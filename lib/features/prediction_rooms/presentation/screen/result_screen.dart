import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({required this.roomId, super.key});

  final int roomId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('결과 확인')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
        children: const [
          Card(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '오늘의 꼴찌는 Alex님입니다.',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '총 편차 8점으로 가장 멀리 빗나갔어요.',
                    style: TextStyle(color: AppColors.secondaryText),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          _DeviationRow(name: 'Minwoo', prediction: '2 : 0', deviation: 1),
          _DeviationRow(name: 'Jamie', prediction: '1 : 1', deviation: 1),
          _DeviationRow(
            name: 'Alex',
            prediction: '0 : 2',
            deviation: 5,
            isLoser: true,
          ),
        ],
      ),
    );
  }
}

class _DeviationRow extends StatelessWidget {
  const _DeviationRow({
    required this.name,
    required this.prediction,
    required this.deviation,
    this.isLoser = false,
  });

  final String name;
  final String prediction;
  final int deviation;
  final bool isLoser;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(name),
      subtitle: Text('예측 $prediction'),
      trailing: Text(
        '편차 $deviation',
        style: TextStyle(
          color: isLoser ? AppColors.warning : AppColors.secondaryText,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}
