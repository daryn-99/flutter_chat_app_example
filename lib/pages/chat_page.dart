import 'dart:io';

import 'package:chat/models/usuario.dart';
import 'package:chat/services/auth_services.dart';
import 'package:chat/services/chat_service.dart';
import 'package:chat/services/sockets_service.dart';
import 'package:chat/services/usuarios_service.dart';
import 'package:chat/widgets/chat_message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chat/models/mensajes_response.dart';
import 'package:image_picker/image_picker.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
  final usuarioService = new UsuariosService();
  final _textController = new TextEditingController();
  final _focusNode = new FocusNode();

  PickedFile _imageFile;
  final ImagePicker _picker = ImagePicker();

  ChatService chatService;
  SocketService socketService;
  AuthService authService;
  List<Usuario> usuario;

  List<ChatMessage> _messages = [];

  bool _estaEscribiendo = false;

  @override
  void initState() {
    super.initState();

    this.chatService = Provider.of<ChatService>(context, listen: false);
    this.socketService = Provider.of<SocketService>(context, listen: false);
    this.authService = Provider.of<AuthService>(context, listen: false);

    this.socketService.socket.on('mensaje-personal', _escucharMensaje);

    _cargarHistorial(this.chatService.usuarioPara.uid);
    _cargarUsuarios();
  }

  void _cargarHistorial(String usuarioID) async {
    List<Mensaje> chat = await this.chatService.getChat(usuarioID);

    final history = chat.map((m) => new ChatMessage(
          texto: m.mensaje,
          uid: m.de,
          animationController: new AnimationController(
              vsync: this, duration: Duration(milliseconds: 0))
            ..forward(),
        ));

    setState(() {
      _messages.insertAll(0, history);
    });
  }

  void _escucharMensaje(dynamic payload) {
    ChatMessage message = new ChatMessage(
      texto: payload['mensaje'],
      uid: payload['de'],
      animationController: AnimationController(
          vsync: this, duration: Duration(milliseconds: 300)),
    );

    setState(() {
      _messages.insert(0, message);
    });

    message.animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    Usuario usuario;
    final usuarioPara = chatService.usuarioPara;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 70.0,
        title: Column(
          children: <Widget>[
            CircleAvatar(
              backgroundImage: AuthService().getImage(usuarioPara.imgUrl),
              // child: Text(usuarioPara.nombre.substring(0, 2),
              //     style: TextStyle(fontSize: 12)),
              // backgroundColor: Colors.blue[100],
              maxRadius: 22,
            ),
            SizedBox(
              height: 3,
            ),
            Text(usuarioPara.nombre,
                style: TextStyle(color: Colors.black87, fontSize: 12))
          ],
        ),
        leading: IconButton(
            onPressed: () => {
                  Navigator.popAndPushNamed(context, 'usuarios'),
                },
            icon: Icon(Icons.chevron_left_sharp, color: Colors.black),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
        centerTitle: true,
        elevation: 1,
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Flexible(
                child: ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: _messages.length,
              itemBuilder: (_, i) => _messages[i],
              reverse: true,
            )),
            Divider(height: 1),
            Container(
              color: Colors.white,
              child: _inputChat(),
            )
          ],
        ),
      ),
    );
  }

  Widget _inputChat() {
    return SafeArea(
        child: Container(
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: <Widget>[
          Flexible(
              child: TextField(
            controller: _textController,
            onSubmitted: _handleSubmit,
            onChanged: (texto) {
              setState(() {
                if (texto.trim().length > 0) {
                  _estaEscribiendo = true;
                } else {
                  _estaEscribiendo = false;
                }
              });
            },
            decoration: InputDecoration.collapsed(hintText: 'Enviar Mensaje'),
            focusNode: _focusNode,
          )),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 4.0),
            child: Platform.isIOS
                ? CupertinoButton(
                    child: Text('Enviar'),
                    onPressed: _estaEscribiendo
                        ? () => _handleSubmit(_textController.text.trim())
                        : null,
                  )
                : Container(
                    margin: EdgeInsets.symmetric(horizontal: 4.0),
                    child: IconTheme(
                      data: IconThemeData(color: Colors.blue[400]),
                      child: Row(
                        children: [
                          // IconButton(
                          //   onPressed: () {
                          //     showModalBottomSheet(
                          //       context: context,
                          //       builder: ((builder) => bottomSheet()),
                          //     );
                          //   },
                          //   highlightColor: Colors.transparent,
                          //   splashColor: Colors.transparent,
                          //   icon: Icon(Icons.attach_file_rounded),
                          // ),
                          // IconButton(
                          //   onPressed: () {
                          //     takePhoto(ImageSource.camera);
                          //   },
                          //   highlightColor: Colors.transparent,
                          //   splashColor: Colors.transparent,
                          //   icon: Icon(Icons.photo_camera_rounded),
                          // ),
                          IconButton(
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            icon: Icon(Icons.send),
                            onPressed: _estaEscribiendo
                                ? () =>
                                    _handleSubmit(_textController.text.trim())
                                : null,
                          ),
                        ],
                      ),
                    ),
                  ),
          )
        ],
      ),
    ));
  }

  void takePhoto(ImageSource source) async {
    final pickedFile = await _picker.getImage(
      source: ImageSource.camera,
    );
    setState(() {
      _imageFile = pickedFile;
    });
  }

  void importimg(ImageSource source) async {
    final pickedFile = await _picker.getImage(
      source: ImageSource.gallery,
    );
    setState(() {
      _imageFile = pickedFile;
    });
  }

  Widget bottomSheet() {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: <Widget>[
          Text(
            "Elige una archivo",
            style: TextStyle(fontSize: 20.0),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: <Widget>[
              TextButton.icon(
                icon: Icon(Icons.attach_file_rounded),
                onPressed: () {},
                label: Text("Adjuntar"),
              ),
              TextButton.icon(
                icon: Icon(Icons.add_photo_alternate_outlined),
                onPressed: () {
                  importimg(ImageSource.gallery);
                },
                label: Text("Galería"),
              )
            ],
          )
        ],
      ),
    );
  }

/*
  bottonAttach() {
    return Container(
      height: 268,
      width: MediaQuery.of(context).size.width,
      child: Card(
        margin: EdgeInsets.all(18),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  iconCreation(
                      Icons.insert_drive_file, Colors.amber, "Documento"),
                  SizedBox(width: 40),
                  iconCreation(Icons.camera_alt, Colors.purple, "Cámara"),
                  SizedBox(width: 40),
                  iconCreation(Icons.photo_rounded, Colors.teal, "Galería"),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  iconCreation(Icons.audiotrack_outlined, Colors.pink, "Audio"),
                  SizedBox(width: 40),
                  iconCreation(Icons.location_on, Colors.green, "Ubicación"),
                  SizedBox(width: 40),
                  iconCreation(Icons.person, Colors.blue, "Contacto"),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
*/
  Widget iconCreation(IconData icon, Color color, String text) {
    return InkWell(
      onTap: () {},
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: color,
            child: Icon(
              icon,
              size: 25,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 5),
          Text(text,
              style: TextStyle(
                fontSize: 12,
              ))
        ],
      ),
    );
  }

  _handleSubmit(String texto) {
    if (texto.length == 0) return;

    _textController.clear();
    _focusNode.requestFocus();

    final newMessage = new ChatMessage(
      uid: authService.usuario.uid,
      texto: texto,
      animationController: AnimationController(
          vsync: this, duration: Duration(milliseconds: 400)),
    );
    _messages.insert(0, newMessage);
    newMessage.animationController.forward();

    setState(() {
      _estaEscribiendo = false;
    });

    this.socketService.emit('mensaje-personal', {
      'de': this.authService.usuario.uid,
      'para': this.chatService.usuarioPara.uid,
      'mensaje': texto,
    });
  }

  @override
  void dispose() {
    // off del socket

    for (ChatMessage messagge in _messages) {
      messagge.animationController.dispose();
    }

    this.socketService.socket.off('mensaje-personal');
    super.dispose();
  }

  _cargarUsuarios() async {
    this.usuario = await usuarioService.getUsuarios();

    setState(() {});
    await Future.delayed(Duration(milliseconds: 1000));
  }
}
