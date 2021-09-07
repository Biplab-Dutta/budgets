import 'package:budgets/presentation/widgets/transaction_listtile.dart';
import 'package:budgets/presentation/widgets/widget_card.dart';
import 'package:flutter/material.dart';

import '../../../../constants.dart';

class LastRecordsWidget extends StatelessWidget {
  const LastRecordsWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WidgetCard(
      title: 'Last records',
      content: Container(
        height: 200,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TransactionListTile(),
            TransactionListTile(),
            TransactionListTile(),
            Spacer(),
            Text(
              'Show more',
              textAlign: TextAlign.end,
              style: TextStyle(color: kAccentColor),
            )
          ],
        ),
      ),
    );
  }
}