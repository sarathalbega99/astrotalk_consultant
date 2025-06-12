// class PayoutsModel {
//   List<Null>? payouts;
//   Pagination? pagination;

//   PayoutsModel({this.payouts, this.pagination});

//   PayoutsModel.fromJson(Map<String, dynamic> json) {
//     if (json['payouts'] != null) {
//       payouts = <Null>[];
//       json['payouts'].forEach((v) {
//         payouts!.add(Null.fromJson(v));
//       });
//     }
//     pagination = json['pagination'] != null
//         ? Pagination.fromJson(json['pagination'])
//         : null;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     if (payouts != null) {
//       data['payouts'] = payouts!.map((v) => v.toJson()).toList();
//     }
//     if (pagination != null) {
//       data['pagination'] = pagination!.toJson();
//     }
//     return data;
//   }
// }

// class Pagination {
//   int? total;
//   int? perPage;
//   int? currentPage;
//   int? lastPage;

//   Pagination({this.total, this.perPage, this.currentPage, this.lastPage});

//   Pagination.fromJson(Map<String, dynamic> json) {
//     total = json['total'];
//     perPage = json['per_page'];
//     currentPage = json['current_page'];
//     lastPage = json['last_page'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['total'] = total;
//     data['per_page'] = perPage;
//     data['current_page'] = currentPage;
//     data['last_page'] = lastPage;
//     return data;
//   }
// }
