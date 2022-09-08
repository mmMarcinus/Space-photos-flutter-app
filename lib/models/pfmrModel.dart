class PFMR {
  List<dynamic> photos;
  // int sol;
  // String camera;
  // int page;

  PFMR(this.photos); //, this.sol, this.camera, this.page);

  factory PFMR.fromJson(dynamic json) {
    return PFMR(json['photos'] as List<dynamic>);
  }
}
