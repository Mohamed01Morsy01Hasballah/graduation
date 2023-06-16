class GetResultToParentModel {
  String? status;
  List<dynamic>? results;

  GetResultToParentModel({this.status, this.results});

  GetResultToParentModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add(new Results.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.results != null) {
      data['results'] = this.results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Results {
  int? id;
  String? name;
  String? email;
  dynamic phone;
  String? photo;
  dynamic address;
  int? rank;
  int? schoolId;
  int? roomId;
  int? parentId;
  String? createdAt;
  String? updatedAt;
  List<Result>? result;

  Results(
      {this.id,
        this.name,
        this.email,
        this.phone,
        this.photo,
        this.address,
        this.rank,
        this.schoolId,
        this.roomId,
        this.parentId,
        this.createdAt,
        this.updatedAt,
        this.result});

  Results.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    photo = json['photo'];
    address = json['address'];
    rank = json['rank'];
    schoolId = json['school_id'];
    roomId = json['room_id'];
    parentId = json['parent_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['result'] != null) {
      result = <Result>[];
      json['result'].forEach((v) {
        result!.add(new Result.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['photo'] = this.photo;
    data['address'] = this.address;
    data['rank'] = this.rank;
    data['school_id'] = this.schoolId;
    data['room_id'] = this.roomId;
    data['parent_id'] = this.parentId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.result != null) {
      data['result'] = this.result!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Result {
  int? id;
  String? name;
  int? schoolId;
  int? roomId;
  String? createdAt;
  String? updatedAt;
  Pivot? pivot;
  Room? room;
  List<ResultsDetailsDegree>? resultsdetails;

  Result(
      {this.id,
        this.name,
        this.schoolId,
        this.roomId,
        this.createdAt,
        this.updatedAt,
        this.pivot,
        this.room,
        this.resultsdetails});

  Result.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    schoolId = json['school_id'];
    roomId = json['room_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    pivot = json['pivot'] != null ? new Pivot.fromJson(json['pivot']) : null;
    room = json['room'] != null ? new Room.fromJson(json['room']) : null;
    if (json['resultsdetails'] != null) {
      resultsdetails = <ResultsDetailsDegree>[];
      json['resultsdetails'].forEach((v) {
        resultsdetails!.add(new ResultsDetailsDegree.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['school_id'] = this.schoolId;
    data['room_id'] = this.roomId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.pivot != null) {
      data['pivot'] = this.pivot!.toJson();
    }
    if (this.room != null) {
      data['room'] = this.room!.toJson();
    }
    if (this.resultsdetails != null) {
      data['resultsdetails'] = this.resultsdetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Pivot {
  int? studentId;
  int? resultId;

  Pivot({this.studentId, this.resultId});

  Pivot.fromJson(Map<String, dynamic> json) {
    studentId = json['student_id'];
    resultId = json['result_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['student_id'] = this.studentId;
    data['result_id'] = this.resultId;
    return data;
  }
}

class Room {
  int? id;
  String? name;
  int? schoolId;
  int? classId;
  String? createdAt;
  String? updatedAt;
  List<Subjects>? subjects;

  Room(
      {this.id,
        this.name,
        this.schoolId,
        this.classId,
        this.createdAt,
        this.updatedAt,
        this.subjects});

  Room.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    schoolId = json['school_id'];
    classId = json['class_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['subjects'] != null) {
      subjects = <Subjects>[];
      json['subjects'].forEach((v) {
        subjects!.add(new Subjects.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['school_id'] = this.schoolId;
    data['class_id'] = this.classId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.subjects != null) {
      data['subjects'] = this.subjects!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Subjects {
  int? id;
  int? schoolId;
  int? subjectId;
  String? createdAt;
  String? updatedAt;
  Pivot? pivot;
  Subject? subject;

  Subjects(
      {this.id,
        this.schoolId,
        this.subjectId,
        this.createdAt,
        this.updatedAt,
        this.pivot,
        this.subject});

  Subjects.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    schoolId = json['school_id'];
    subjectId = json['subject_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    pivot = json['pivot'] != null ? new Pivot.fromJson(json['pivot']) : null;
    subject =
    json['subject'] != null ? new Subject.fromJson(json['subject']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['school_id'] = this.schoolId;
    data['subject_id'] = this.subjectId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.pivot != null) {
      data['pivot'] = this.pivot!.toJson();
    }
    if (this.subject != null) {
      data['subject'] = this.subject!.toJson();
    }
    return data;
  }
}

class PivotDetails {
  int? roomId;
  int? subjectId;

  PivotDetails({this.roomId, this.subjectId});

  PivotDetails.fromJson(Map<String, dynamic> json) {
    roomId = json['room_id'];
    subjectId = json['subject_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['room_id'] = this.roomId;
    data['subject_id'] = this.subjectId;
    return data;
  }
}

class Subject {
  int? id;
  String? name;

  Subject({this.id, this.name});

  Subject.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class ResultsDetailsDegree {
  int? id;
  String? subjectDegree;
  String? studentDegree;
  int? studentId;
  int? resultId;
  int? subjectId;
  String? createdAt;
  String? updatedAt;

  ResultsDetailsDegree(
      {this.id,
        this.subjectDegree,
        this.studentDegree,
        this.studentId,
        this.resultId,
        this.subjectId,
        this.createdAt,
        this.updatedAt});

  ResultsDetailsDegree.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subjectDegree = json['subject_degree'];
    studentDegree = json['student_degree'];
    studentId = json['student_id'];
    resultId = json['result_id'];
    subjectId = json['subject_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['subject_degree'] = this.subjectDegree;
    data['student_degree'] = this.studentDegree;
    data['student_id'] = this.studentId;
    data['result_id'] = this.resultId;
    data['subject_id'] = this.subjectId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}