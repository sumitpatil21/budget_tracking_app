class HomeModal{
  int? id,isincome;
  String? date,category;
  double? amount;

  HomeModal({ required this.id, required this.isincome,required this.date,required this.category,required this.amount});

  factory HomeModal.fromjson(Map m1)
  {
    return HomeModal(id: m1['id'], isincome: m1['isincome'], date: m1['date'], category: m1['category'], amount: m1['amount']);
  }
}