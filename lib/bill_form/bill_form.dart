import 'package:discoveringbloc/bill_form/bill.dart';
import 'package:discoveringbloc/bill_form/bill_cubit.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BillForm extends StatelessWidget {
  const BillForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<BillCubit, Bill>(
        builder: (context, bill) => ListView(
          children: [
            bill.snapshot == null
                ? Container()
                : Image.memory(
                    bill.snapshot!,
                    height: MediaQuery.of(context).size.height * 0.5,
                  ),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Bill',
                hintText: 'Enter the bill amount',
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                if (value.isNotEmpty) {
                  context.read<BillCubit>().setAmount(double.parse(value));
                }
              },
              textInputAction: TextInputAction.next,
            ),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Label',
                hintText: 'Enter the bill label',
              ),
              onChanged: (value) {
                context.read<BillCubit>().setLabel(value);
              },
              textInputAction: TextInputAction.done,
              onSubmitted: (value) => _confirm(context),
            ),
            // confirm button
            Builder(builder: (context) {
              return ElevatedButton(
                child: const Text('Send to boss'),
                onPressed: () => _confirm(context),
              );
            }),
          ],
        ),
      ),
    );
  }

  void _confirm(BuildContext context) {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      context: context,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.3,
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'Are you sure?',
              style: Theme.of(context).textTheme.headline5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  child: const Text('No'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                ElevatedButton(
                  child: const Text('Yes'),
                  onPressed: () {
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
