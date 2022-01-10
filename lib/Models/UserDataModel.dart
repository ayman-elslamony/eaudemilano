class UserData {
  int  id;
  String  name;
  String  email;
  String  status;
  String  mobile;
  String  deviceToken;
  String  apiToken;

  UserData(
      {this.id,
        this.name,
        this.email,
        this.status,
        this.mobile,
        this.deviceToken,
        this.apiToken});

  UserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    status = json['status'];
    mobile = json['mobile'];
    deviceToken = json['device_token'];
    apiToken = json['api_token'];
  }


}