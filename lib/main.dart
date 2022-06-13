import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'dart:io';
import 'dart:async';

void main() {
  return runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.blueGrey,
        appBar: AppBar(
          title: Text('Socket.io'),
          backgroundColor: Colors.red,
        ),
        body: const SocketIOTest(),
      ),
    ),
  );
}

class SocketIOTest extends StatefulWidget {
  const SocketIOTest({Key? key}) : super(key: key);

  @override
  State<SocketIOTest> createState() => _SocketIOTestState();
}

class _SocketIOTestState extends State<SocketIOTest> {
  late Socket socket;

  void checkSocket() async {
    try {
      socket = io(
          'http://wayfinder-asyncapi.playground-wayfinder-36.serverless.sandbox.verses.build/',
          // 'http://echo.socket.io/',
          OptionBuilder()
              .setTransports(['websocket']) // for Flutter or Dart VM
              .enableAutoConnect()
              .build());
      socket.onConnect((_) => onConnect(_));
      socket.onConnectError((_) => onConnectError(_));
      socket.onError((_) => onError(_));
      socket.on('event', (_) => onEvent(_));
    } catch (err) {
      print("ERR: $err");
    }
  }

  void onEvent(var _) {
    print('onEvent: $_');
  }

  void onConnect(var _) {
    print('onConnect: $_');
    socket.emit('event', {
      "id": "82235bac-2b81-4e70-90b5-2bd1f04b5c7b",
      "source": "/test/1129",
      "specversion": "1.0",
      "type": "wayfinder.auth.login",
      "channel": "dom.nri.us.la.activities",
      "hsml": {
        "@swid": "WMSAuthenticationActivitySwid",
        "@type": "hsml:activity",
        "name": "WorkAssignmentActivity",
        "resolved_by": {
          "@swid": "WarehouseDomainSwid",
          "@type": "hsml:domain",
          "name": "WarehouseDomain",
          "state": {"FacilityName": "LA"}
        },
        "resolved_using": {
          "@swid": "DeviceCredentialSwid",
          "@type": "hsml:credential",
          "name": "Device Credential",
          "state": {
            "type": "DeviceProperties",
            "IPAddress": "192.168.1.1",
            "MACAddress": "00:00:5e:00:53:af"
          }
        },
        "performed_by": {
          "@swid": "EmployeeNumberSwid",
          "@type": "hsml:domain",
          "name": "EmployeeNumber",
          "state": {"EmployeeNumber": "1"}
        },
        "performed_on": {
          "@swid": "PerfomedOnCredentialSwid",
          "@type": "hsml:credential",
          "name": "AuthToken",
          "state": {"type": "Bearer", "token": "TOKEN"}
        }
      },
      "published": "2016-07-16T19:20:30+01:00"
    });
  }

  void onConnectError(var _) {
    print('onConnectError: $_');
  }

  void onError(var _) {
    print('onError: $_');
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        children: <Widget>[
          Expanded(
            child: FlatButton(
              child: Text("Socket Connect"),
              onPressed: () {
                checkSocket();
              },
            ),
          ),
        ],
      ),
    );
  }
}
