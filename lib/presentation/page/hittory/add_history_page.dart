import 'package:d_input/d_input.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../config/app_color.dart';
import '../../../config/app_format.dart';

class AddHistoryPage extends StatelessWidget {
  const AddHistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controllerName = TextEditingController();
    final controllerPrice = TextEditingController();
    return Scaffold(
      appBar: DView.appBarLeft('Tambah Baru'),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Tanggal',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Row(
            children: [
              Text('2022-01-01'),
              DView.spaceWidth(),
              ElevatedButton.icon(
                onPressed: () {},
                icon: Icon(Icons.event),
                label: Text('pilih'),
              ),
            ],
          ),
          DView.spaceHeight(),
          const Text(
            'Tipe',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          DView.spaceHeight(4),
          DropdownButtonFormField(
            value: 'Pemasukan',
            items: ['Pemasukan', 'Pengeluaran'].map((e) {
              return DropdownMenuItem(
                value: e,
                child: Text(e),
              );
            }).toList(),
            onChanged: (value) {},
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              isDense: true,
            ),
          ),
          DView.spaceHeight(),
          DInput(
            controller: controllerName,
            hint: 'Jualan',
            title: 'Sumber/Objek Pengeluaran',
          ),
          DView.spaceHeight(),
          DInput(
            controller: controllerPrice,
            hint: '30000',
            title: 'Harga',
            inputType: TextInputType.number,
          ),
          DView.spaceHeight(),
          ElevatedButton(
              onPressed: () {}, child: const Text('Tambah ke Items')),
          DView.spaceHeight(),
          Center(
            child: Container(
              height: 5,
              width: 80,
              decoration: BoxDecoration(
                color: AppColor.bg,
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
          DView.spaceHeight(),
          const Text(
            'Items',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          DView.spaceHeight(8),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey),
            ),
            child: Wrap(
              children: [
                Chip(
                  label: Text('Sumber'),
                  deleteIcon: Icon(Icons.clear),
                  onDeleted: () {},
                ),
              ],
            ),
          ),
          DView.spaceHeight(),
          Row(
            children: [
              const Text(
                'Total: ',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              DView.spaceWidth(8),
              Text(
                AppFormat.currency('300000'),
                style: Theme.of(context).textTheme.headline5!.copyWith(
                    fontWeight: FontWeight.bold, color: AppColor.primary),
              ),
            ],
          ),
          DView.spaceHeight(30),
          Material(
            color: AppColor.primary,
            borderRadius: BorderRadius.circular(8),
            child: InkWell(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Center(
                  child: Text(
                    'Submit',
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
