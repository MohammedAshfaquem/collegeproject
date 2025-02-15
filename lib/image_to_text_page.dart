// import 'dart:convert';
// import 'dart:io';
// import 'package:http/http.dart' as http;

// class ClaudeService {
//   final String _baseurl = "https://api.anthropic.com/v1/messages";
//   final String _apikey = "YOUR-API_KEY";

//   Future<String> analyzeimage(File image) async {
//     final bytes = await image.readAsBytes();
//     final base64Image = base64Encode(bytes);
//     final response = await http.post(
//       Uri.parse(_baseurl),
//       headers: {
//         'Content-Type': 'application/json',
//         'x-api-key': _apikey,
//         'anthropic-version': "2023-06-01",
//       },
//       body: jsonEncode(
//         {
//           'model': 'claude-3-opus-20240229',
//           'max_tokens': 50,
//           'messages': [
//             {
//               'role': 'user',
//               'content': [
//                 {
//                   'type': 'image',
//                   'source': {
//                     'type': 'base64',
//                     'media_type': 'image/jpeg',
//                     'data': base64Image,
//                   },
//                 },
//                 {
//                   'type': 'text',
//                   'text': 'Please describe what you see in ths image'
//                 }
//               ],
//             },
//           ],
//         },
//       ),
//     );
//     //successfull response from claude
//     if(response.statusCode == 200){
//       final data = jsonDecode(response.body);

//       return data['content'][0]['text'];
//     }
//     throw Exception("Failed to analyze images:${response.statusCode}");
//   }
// }
