//class SettingInformation {
//  AppInfo  appInfo;
//
//  SettingInformation({this.appInfo});
//
//  SettingInformation.fromJson(Map<String, dynamic> json) {
//    appInfo = json['data'] != null ? AppInfo.fromJson(json['data']) : null;
//  }
//
//}

class SettingInformation {
  String  email;
  String  mobile;
  String  websiteName;
  String  facebookLink;
  String  instgramLink;
  String  twitterLink;
  String  address;
  List<Areas>  areas=[];

  SettingInformation(
      {this.email,
        this.mobile,
        this.websiteName,
        this.facebookLink,
        this.instgramLink,
        this.twitterLink,
        this.address,
        this.areas});

  SettingInformation.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    mobile = json['mobile'];
    websiteName = json['website_name'];
    facebookLink = json['facebook_link'];
    instgramLink = json['instgram_link'];
    twitterLink = json['twitter_link'];
    address = json['address'];
    if (json['areas'] != null) {
      areas = <Areas>[];
      json['areas'].forEach((v) {
        areas.add( Areas.fromJson(v));
      });
    }
  }


}

class Areas {
  int  id;
  String  name;

  Areas({this.id, this.name});

  Areas.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }
  
}
