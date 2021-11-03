class ModelDrop1 {
  String val;
  String text;

  ModelDrop1({ this.text,this.val});

  ModelDrop1.fromJson(Map<String, dynamic> json) {
    text = json['text'];
     val = json['val'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['text'] = this.text;
     data['val'] = this.val;
    return data;
  }
}