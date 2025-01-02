import 'package:flutter/material.dart';

class TourListWidget extends StatefulWidget {
  const TourListWidget({Key? key}) : super(key: key);

  @override
  _TourListWidgetState createState() => _TourListWidgetState();
}

class _TourListWidgetState extends State<TourListWidget> {
  final List<Map<String, dynamic>> _tours = [
    {
      'name': 'Салют тур новичок',
      'city': 'Москва',
      'rating': 4.5,
      'time': 2.1,
    },
    {
      'name': 'Лионидыч',
      'city': 'Иваново',
      'rating': 4.0,
      'time': 1.2,
    },
    {
      'name': 'Лучший тур Суздаля',
      'city': 'Суздаль',
      'rating': 5.0,
      'time': 0.49,
    },
    {
      'name': 'Тур по Золотому кольцу',
      'city': 'Владимир',
      'rating': 4.8,
      'time': 6.0,
    },
    {
      'name': 'Поездка на Байкал',
      'city': 'Иркутск',
      'rating': 4.9,
      'time': 5.4,
    },
    {
      'name': 'Тур в Санкт-Петербург',
      'city': 'Санкт-Петербург',
      'rating': 4.7,
      'time': 4.0,
    },
     {
      'name': 'Тур абоба',
      'city': 'Сочи',
      'rating': 4.3,
      'time': 0.33,
    },
        {
      'name': 'На любителя',
      'city': 'Краснодар',
      'rating': 3,
      'time': 4.3,
    },
        {
      'name': 'Гурман',
      'city': 'Нижний',
      'rating': 2.5,
      'time': 6.4,
    },
  ];

  List<Map<String, dynamic>> _filteredTours = [];
  double? _selectedRating;
  String? _selectedTime;

  @override
  void initState() {
    super.initState();
    _filteredTours = List.from(_tours);
  }

  void _showFilterMenu() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child:0.0),
                      child: DropdownButtonFormField<double>(
                        value: _selectedRating,
                        decoration: const InputDecoration(
                          labelText: 'Рейтинг',
                          border: InputBorder.none,
                        ),
                        items: const [
                          DropdownMenuItem(value: null, child: Text('Любой')),
                          DropdownMenuItem(value: 3.0, child: Text('3.0 и выше')),
                          DropdownMenuItem(value: 4.0, child: Text('4.0 и выше')),
                          DropdownMenuItem(value: 4.5, child: Text('4.5 и выше')),
                          DropdownMenuItem(value: 5.0, child: Text('5.0')),
                        ],
                        onChanged: (value) {
                          setState(() {
                            _selectedRating = value;
                          });
                        },
                      ),
                    ),
                  ),
                   const SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.10.0),
                        child: DropdownButtonFormField<String>(
                          value: _selectedTime,
                          decoration: const InputDecoration(
                            labelText: 'Время',
                            border: InputBorder.none,
                          ),
                          items: const [
                            DropdownMenuItem(value: null, child: Text('Любой')),
                             DropdownMenuItem(value: 'до 1 часа', child: Text('До 1 часа')),
                             DropdownMenuItem(value: 'до 2 часов', child: Text('До 2 часов')),
                             DropdownMenuItem(value: '3 часа и больше', child: Text('3 часа и больше')),
                          ],
                          onChanged: (value) {
                            setState(() {
                              _selectedTime = value;
                            });
                          },
                        ),
                      ),
                    ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      _applyFilters();
                    },
                    child: const Text('Применить'),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

 void _applyFilters() {
    setState(() {
      _filteredTours = _tours.where((tour) {
        bool ratingFilter = true;
        bool timeFilter = true;
        if (_selectedRating != null) {
          ratingFilter = (tour['rating'] as num).toDouble() >= _selectedRating!;
        }
         if (_selectedTime != null) {
          if (_selectedTime == 'до 1 часа') {
             timeFilter = (tour['time'] as num).toDouble() <= 1;
          } else if (_selectedTime == 'до 2 часов') {
             timeFilter = (tour['time'] as num).toDouble() <= 2;
          } else if (_selectedTime == '3 часа и больше') {
            timeFilter = (tour['time'] as num).toDouble() >= 3;
          }
        }
         return ratingFilter && timeFilter;
      }).toList();
    });
  }


  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _filteredTours.length,
      itemBuilder: (context, index) {
        final tour = _filteredTours[index];
        return Card(
          elevation: 3,
          margin: const EdgeInsets.all(10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                SizedBox(
                  width: 80,
                  height: 80,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.asset(
                      'assets/placeholder.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        tour['name'],
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 5),
                       Text(
                          '${tour['city']} - ${tour['time'] is double ? '${tour['time']} час(а)' : tour['time']}'),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          const Icon(Icons.star,
                              color: Colors.amber, size: 18),
                          const SizedBox(width: 2),
                          Text('${tour['rating']}'),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
