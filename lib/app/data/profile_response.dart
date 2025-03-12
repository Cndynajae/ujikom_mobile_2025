class ProfileResponse {
  int? id;
  String? name;
  String? nrp;
  String? email;
  dynamic emailVerifiedAt; // Ubah ke dynamic
  int? isActive;
  dynamic departementId; // Ubah ke dynamic
  dynamic jabatanId; // Ubah ke dynamic
  dynamic bagianId; // Ubah ke dynamic
  dynamic avatar; // Ubah ke dynamic
  String? createdAt;
  String? updatedAt;

  ProfileResponse({
    this.id,
    this.name,
    this.nrp,
    this.email,
    this.emailVerifiedAt,
    this.isActive,
    this.departementId,
    this.jabatanId,
    this.bagianId,
    this.avatar,
    this.createdAt,
    this.updatedAt,
  });

  factory ProfileResponse.fromJson(Map<String, dynamic> json) {
    return ProfileResponse(
      id: json['id'],
      name: json['name'],
      nrp: json['nrp'],
      email: json['email'],
      emailVerifiedAt: json['email_verified_at'],
      isActive: json['is_active'],
      departementId: json['departement_id'],
      jabatanId: json['jabatan_id'],
      bagianId: json['bagian_id'],
      avatar: json['avatar'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'nrp': nrp,
      'email': email,
      'email_verified_at': emailVerifiedAt,
      'is_active': isActive,
      'departement_id': departementId,
      'jabatan_id': jabatanId,
      'bagian_id': bagianId,
      'avatar': avatar,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
