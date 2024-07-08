
// for the apis urls

class MyAppConstants{
  static String ip='http://192.168.100.8:5000';
  static String baseurl="$ip/api";
  //.......................................... merchant...........................
  static String merchantDetails="$baseurl/merchants";
  static String addmerchant="$baseurl/createmerchants";
  static String deletemerhcant="$baseurl/deletemerchants";
  static String updatemerchant="$baseurl/updatemerchants";
  //..........................................Devices.............................
  static String devices="$baseurl/terminal";
  static String adddevice="$baseurl/createterminal";




  static String subgrouplist="$baseurl/subgroup";






// ${StaticData.brandtype}


}






// for the user token

class StaticData{
  static String token='eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjYsImlhdCI6MTcyMDI1OTQyNn0.YVMfhMznDW3iZhrf8CumWM03x2wd0sKAeDwHg7mP97o';
}