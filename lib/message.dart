import 'dart:convert';

import 'package:http/http.dart' as http;


void sendSMS() async {
  // Replace these values with your Twilio credentials and phone numbers
  String accountSid = 'ACa74da352b84ce9448ad20e11a17099a5';
  String authToken = 'fcadd0b32cd932c2f868cca5424c8b2b';
  String from = '+12513095344';
  String to = '+918138888678';
  String body = 'New Emergency !';

  // Twilio API endpoint for sending SMS
  String url = 'https://api.twilio.com/2010-04-01/Accounts/$accountSid/Messages';

  // Encode Twilio credentials
  String basicAuth = 'Basic ' + base64Encode(utf8.encode('$accountSid:$authToken'));

  // Send SMS request
  try {
    final response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Authorization': basicAuth,
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: <String, String>{
        'From': from,
        'To': to,
        'Body': body,
      },
    );

    if (response.statusCode == 201) {
      print('Message sent successfully!');
    } else {
      print('Failed to send message. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
  } catch (e) {
    print('Error sending message: $e');
  }
}