import 'package:nostrp2p/controller/profile_provider/profile_provider.dart';
import 'package:nostr/nostr.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../http_client_factory.dart'
    if (dart.library.js_interop) '../http_client_factory_web.dart';

class Np2pAPI {
  static postEvent(String url, String content) async {
    var params = {
      "id": "",
      "pubkey": "",
      "created_at": 0,
      "kind": 1,
      "tags": [],
      "content": content,
      "sig": ""
    };
    //var resp = await Np2pAPI._request('http://' + Np2pAPI.serverAddr +  '/sendEvent', params);
    var resp = await Np2pAPI._request(url + '/publish', params);
    print(resp);
  }

  static updateProfile(String url, String pubhex, String name, String about, String picture) async {
    var params = {
      "id": "",
      "pubkey": "",
      "created_at": 0,
      "kind": 0,
      "tags": [["name", name], ["about", about], ["picture", picture]],
      "content": "",
      "sig": ""
    };

    var resp = await Np2pAPI._request(url + '/publish', params);
    print(resp);
  }

  static Future<ProfileData> getProfile(String pubHex) async {
    //BigInt shortPkey
    // TODO: need to implement Np2pAPI::getProfile
    return ProfileData(name: 'name', picture: 'picture', about: 'about', pubHex: 'pubHex');
  }

  // TEMPORAL API
  static gatherData() async {
    // TODO: need to implement Np2pAPI::gatherData
  }

  static Future<List<Event>> getEvents(String url, int since, int until) async {
    var filter = Filter(kinds: [40000], since: since, until: until);
    var resp = await Np2pAPI._request(url + '/req', filter.toJson());
    return (resp["Events"] as List).map((e) => Np2pAPI.jsonToEvent(e)).toList();
  }

  static Future<Map<String, dynamic>> _request(String destUrl, Object params) async {
    Uri url = Uri.parse(destUrl);
    Map<String, String> headers = {
      'content-type': 'application/json',
      "accept": "application/json",
      "Access-Control-Request-Method": "POST",
      "Access-Control-Request-Private-Network": "true",
    };
    String body = json.encode(params);
    print(body);
    var client = httpClient();
    //http.Response resp = await http.post(url, headers: headers, body: body);
    http.Response resp = await client.post(url, headers: headers, body: body);
    print(resp);
    if (resp.statusCode == 200) {
      return json.decode(resp.body);
    } else {
      return new Future(() => {});
    }
  }

  static Event jsonToEvent(Map<String, dynamic> json) {
    var tags = (json['tags'] as List<dynamic>)
        .map((e) => (e as List<dynamic>).map((e) => e as String).toList())
        .toList();
    return Event(
      json['id'],
      json['pubkey'],
      json['created_at'],
      json['kind'],
      tags,
      json['content'],
      json['sig'],
      verify: false,
    );
  }
}