import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:toast/toast.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Send mail',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String email;
  sendMail() async {
    String username = 'hancyjerry11@gmail.com';
    String password = 'K@thmandu';

    final smtpServer = gmail(username, password);
    // Use the SmtpServer class to configure an SMTP server:
    // final smtpServer = SmtpServer('smtp.domain.com');
    // See the named arguments of SmtpServer for further configuration
    // options.

    // Create our message.
    final message = Message()
      ..from = Address(username, 'Bipin Bhandari')
      ..recipients.add('nirdoshlamixane001@gmail.com')
      //..ccRecipients.addAll(['destCc1@example.com', 'destCc2@example.com'])
      //..bccRecipients.add(Address('bccAddress@example.com'))
      ..subject = 'Test Dart Mailer library :: 😀 :: ${DateTime.now()}'
      ..text = 'This is the plain text.\nThis is line 2 of the text part.'
      ..html =
          "<h1>Test</h1>\n<p>Hey! Are you fine in this covid 19 period .</p>";

    try {
      final sendReport = await send(message, smtpServer);
      showToast('Message sent check your email',
          gravity: Toast.CENTER, duration: 3);
      print('Message sent: ' + sendReport.toString());
    } on MailerException catch (e) {
      print('Message not sent.');
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    }
    // DONE

    // Let's send another message using a slightly different syntax:
    //
    // Addresses without a name part can be set directly.
    // For instance `..recipients.add('destination@example.com')`
    // If you want to display a name part you have to create an
    // Address object: `new Address('destination@example.com', 'Display name part')`
    // Creating and adding an Address object without a name part
    // `new Address('destination@example.com')` is equivalent to
    // adding the mail address as `String`.
    // final equivalentMessage = Message()
    //   ..from = Address(username, 'Your name')
    //   ..recipients.add(Address('destination@example.com'))
    //   ..ccRecipients
    //       .addAll([Address('destCc1@example.com'), 'destCc2@example.com'])
    //   ..bccRecipients.add('bccAddress@example.com')
    //   ..subject = 'Test Dart Mailer library :: 😀 :: ${DateTime.now()}'
    //   ..text = 'This is the plain text.\nThis is line 2 of the text part.'
    //   ..html = "<h1>Test</h1>\n<p>Hey! Here's some HTML content</p>";

    // final sendReport2 = await send(equivalentMessage, smtpServer);

    // // Sending multiple messages with the same connection
    // //
    // // Create a smtp client that will persist the connection
    // var connection = PersistentConnection(smtpServer);

    // // Send the first message
    // await connection.send(message);

    // // send the equivalent message
    // await connection.send(equivalentMessage);

    // // close the connection
    // await connection.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter send email'),
      ),
      body: Center(
        child: MaterialButton(
            color: Colors.green,
            child: Text('Enter'),
            onPressed: () {
              sendMail();
            }),
      ),
    );
  }

  showToast(String msg, {int duration, int gravity}) {
    Toast.show(msg, context, duration: duration, gravity: gravity);
  }
}
