import 'package:chat/config/palette.dart';
import 'package:flutter/material.dart';

class TerminosPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Terminos y condiciones de uso'),
          backgroundColor: Palette.colorBlue,
        ),
        body: SingleChildScrollView(
            child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'Términos y Condiciones de Uso' +
                '\n\n'
                    'INFORMACIÓN RELEVANTE' +
                '\n\n'
                    'Es requisito necesario para el uso de las funcionalidades que se ofrecen en esta aplicación, que lea y este informado de los siguientes Términos y Condiciones que a continuación se redactan. El uso de nuestros servicios que usted ha leído en los Términos y Condiciones de Uso en el presente documento. Todas las restricciones y reglas de comportamiento están sujetas a las políticas de la empresa. Para la creación de un usuario será necesario el registro por parte del administrador (en este caso el gerente de recursos humanos), con ingreso de datos personales fidedignos y definición de una contraseña. ' +
                '\n'
                    'El usuario puede elegir y cambiar la clave para su acceso de administración de la cuenta en cualquier momento, en caso de que se haya registrado.' +
                '\n\n'
                    'LICENCIA' +
                '\n\n'
                    'Roatan Electric Company a través de su aplicación móvil concede una licencia para que los usuarios utilicen las funcionalidades que son expuestas en éste software de acuerdo a los Términos y Condiciones que se describen en este documento.' +
                '\n\n'
                    'USO NO AUTORIZADO' +
                '\n\n'
                    'Usted no puede utilizar la aplicación, ni compartir la información de inicio de sesión con ninguna persona, esta estrictamente prohibida la divulgación de datos personales.' +
                '\n\n'
                    'PROPIEDAD' +
                '\n\n'
                    'Usted no puede declarar propiedad intelectual o exclusiva a ninguno de nuestras publicaciones, modificadas o sin modificar. Todas las publicaciones son propiedad de la empresa.' +
                '\n\n'
                    'PRIVACIDAD' +
                '\n\n'
                    'Este software garantiza que la información personal que usted envía cuenta con la seguridad necesaria. Los datos ingresados por usuario, salvo que deba ser revelada en cumplimiento a una orden judicial o requerimientos legales.' +
                '\n\n'
                    'Roatan Electric Company reserva los derechos de cambiar o de modificar estos términos sin previo aviso.',
            textAlign: TextAlign.justify,
            style: Theme.of(context).textTheme.subtitle1,
          ),
        )));
  }
}
