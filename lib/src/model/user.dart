class MyUser {
  String? uid;
  String? email;
  String? name;
  String? address;
  String? city;
  String? postcode;
  String? state;
  String? contactNo;


  MyUser({this.uid, this.email, this.name, this.address, this.city, this.contactNo, this.postcode, this.state});

  // receiving data from server
  factory MyUser.fromMap(map) {
    return MyUser(
      uid: map['uid'],
      email: map['email'],
      name: map['name'],
      address: map['address'],
      city: map['city'],
      postcode: map['postcode'],
      state: map['state'],
      contactNo: map['contactNo'],
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
    };
  }
}