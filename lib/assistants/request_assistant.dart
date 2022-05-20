import 'dart:convert';

import 'package:http/http.dart' as http;

class RequestAssistant
{
  static Future<dynamic> receivedRequest(String url) async
  {
    http.Response httpResponse = await http.get(Uri.parse(url));

    try
    {
      if(httpResponse.statusCode == 200) //successful response
        {
        String responseData = httpResponse.body; //json data

        var decodeResponseData = json.decode(responseData);

        return decodeResponseData;
      }
      else
      {
        return "Error Occured. Failed, no response";
      }
    }catch(exp)
    {
      return "Error Occured. Failed, no response.";
    }


  }
}