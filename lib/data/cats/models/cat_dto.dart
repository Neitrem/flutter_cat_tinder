class CatDTO {  
  final String id;
  final String url;
  final int width;
  final int height;
  final List<dynamic> breeds;
  //final List<dynamic> favourite;

  CatDTO({
    required this.id, 
    required this.url,
    required this.width,
    required this.height,
    required this.breeds,
    //required this.favourite
  });

  factory CatDTO.fromJson(Map<String, dynamic> json) => CatDTO(
    id: json['id'],
    url: json['url'],
    width: json['width'],
    height: json['height'],
    breeds: json['breeds'],
    //favourite: json['favoutite']
  );
}