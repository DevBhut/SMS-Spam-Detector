// import 'dart:convert';

import 'package:http/http.dart' as http;

class CallApi{
  //final String url = "http://127.0.0.1:33";
  getData(apiUrlEndpoint) async {
    // var fullUrl = '$url/' + apiUrlEndpoint;
    return await http.get(
      Uri.parse(apiUrlEndpoint),
      // body: JsonEncoder(data),
      headers: _setHeaders(),
    );
  }
  _setHeaders()=>{
    'Content-type':'application/json',
    'Accept':'application/json',
  };
}

// in main code, do var response = await CallApi().postData(data, 'apiUrlEndpoint')