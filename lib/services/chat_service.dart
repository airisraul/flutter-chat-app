import 'package:chatapp/global/environment.dart';
import 'package:chatapp/models/mensajes_response.dart';
import 'package:chatapp/models/usuario.dart';
import 'package:chatapp/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class ChatService with ChangeNotifier {

  Usuario usuarioPara;
  

  Future<List<Mensaje>> getChat( String usuarioID ) async{

    final resp = await http.get('${ Environment.apiUrl }/mensajes/$usuarioID',
      headers: {
        'Content-Type': 'application/json',
        'x-token': await AuthService.getToken()
      }
    );

    final mensajesResp = mensajesResponseFromJson(resp.body);

    return mensajesResp.mensajes;

  }


}