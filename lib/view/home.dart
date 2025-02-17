import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studenthiive/controller/controller/student_funtions.dart';
import 'package:studenthiive/view/add.dart';
import 'package:studenthiive/view/details.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<studentDb>(listen: false, context).getData();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddDetails()));
        },
        child: Icon(Icons.add),
      ),
      body: Consumer<studentDb>(
        builder: (context, value, child) {
          return ListView.builder(
            itemCount: value.studentList.length,
            itemBuilder: (context, index) {
              final data = value.studentList[index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: FileImage(File(data.image!)),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>StudentsDetails (
                            image: data.image!,
                              name: data.studentName!,
                              age: data.age!,
                              cls: data.studentClass!,
                              address: data.studentAddress!,
                              index: index)));
                },
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.edit),
                    SizedBox(
                      width: 10,
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        Provider.of<studentDb>(context, listen: false)
                            .deleteData(index);
                      },
                    ),
                  ],
                ),
                title: Text(data.studentName!),
              );
            },
          );
        },
      ),
    );
  }
}
