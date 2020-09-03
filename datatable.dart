import 'package:flutter/material.dart';

class User {
  String firstName;
  String lastName;

  User({this.firstName, this.lastName});

  static List<User> getUsers() {
    return <User>[
      User(firstName: "Aaryan", lastName: "Shah"),
      User(firstName: "Ben", lastName: "John"),
      User(firstName: "Carrie", lastName: "Brown"),
      User(firstName: "Deep", lastName: "Sen"),
      User(firstName: "Emily", lastName: "Jane"),
      User(firstName: "Aaryan", lastName: "Shah"),
      User(firstName: "Ben", lastName: "John"),
      User(firstName: "Carrie", lastName: "Brown"),
      User(firstName: "Deep", lastName: "Sen"),
      User(firstName: "Emily", lastName: "Jane"),
      User(firstName: "Aaryan", lastName: "Shah"),
      User(firstName: "Ben", lastName: "John"),
      User(firstName: "Carrie", lastName: "Brown"),
      User(firstName: "Deep", lastName: "Sen"),
      User(firstName: "Emily", lastName: "Jane"),
      User(firstName: "Aaryan", lastName: "Shah"),
      User(firstName: "Ben", lastName: "John"),
      User(firstName: "Carrie", lastName: "Brown"),
      User(firstName: "Deep", lastName: "Sen"),
      User(firstName: "Emily", lastName: "Jane"),
      User(firstName: "Aaryan", lastName: "Shah"),
      User(firstName: "Ben", lastName: "John"),
      User(firstName: "Carrie", lastName: "Brown"),
      User(firstName: "Deep", lastName: "Sen"),
      User(firstName: "Emily", lastName: "Jane"),
      User(firstName: "Aaryan", lastName: "Shah"),
      User(firstName: "Ben", lastName: "John"),
      User(firstName: "Carrie", lastName: "Brown"),
      User(firstName: "Deep", lastName: "Sen"),
      User(firstName: "Emily", lastName: "Jane"),
      User(firstName: "Aaryan", lastName: "Shah"),
      User(firstName: "Ben", lastName: "John"),
      User(firstName: "Carrie", lastName: "Brown"),
      User(firstName: "Deep", lastName: "Sen"),
      User(firstName: "Emily", lastName: "Jane"),
      User(firstName: "Aaryan", lastName: "Shah"),
      User(firstName: "Ben", lastName: "John"),
      User(firstName: "Carrie", lastName: "Brown"),
      User(firstName: "Deep", lastName: "Sen"),
      User(firstName: "Emily", lastName: "Jane"),
    ];
  }
}

class DataTableDemo extends StatefulWidget {
  DataTableDemo() : super();

  final String title = "Data Table Flutter Demo";

  @override
  DataTableDemoState createState() => DataTableDemoState();
}

class DataTableDemoState extends State<DataTableDemo> {
  List<User> users;
  List<User> selectedUsers;
  List<User> _searchResult = [];
  TextEditingController controller = TextEditingController();

  bool sort;

  @override
  void initState() {
    sort = false;
    selectedUsers = [];
    users = User.getUsers();
    super.initState();
  }

  onSearchTextChanged(String text) async {
    _searchResult.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }
    users.forEach((userDetail) {
      if (userDetail.firstName.toLowerCase().contains(text.toLowerCase()) ||
          userDetail.lastName.toLowerCase().contains(text.toLowerCase()))
        _searchResult.add(userDetail);
    });

    setState(() {});
  }

  onSortColum(int columnIndex, bool ascending) {
    if (columnIndex == 0) {
      if (ascending) {
        users.sort((a, b) => a.firstName.compareTo(b.firstName));
      } else {
        users.sort((a, b) => b.firstName.compareTo(a.firstName));
      }
    }
  }

  onSelectedRow(bool selected, User user) async {
    setState(() {
      if (selected) {
        selectedUsers.add(user);
      } else {
        selectedUsers.remove(user);
      }
    });
  }

  deleteSelected() async {
    setState(() {
      if (selectedUsers.isNotEmpty) {
        List<User> temp = [];
        temp.addAll(selectedUsers);
        for (User user in temp) {
          users.remove(user);
          selectedUsers.remove(user);
        }
      }
    });
  }

  Widget dataBody() {
    return Container(
      margin: EdgeInsets.all(20),
      child: Card(
        child: Column(
          children: [
            ListTile(
              tileColor: Colors.grey,
              title: Text(
                'User Table',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            ExpansionTile(
              title: Text('Filter'),
              children: [
                TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    hintText: 'Search',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(250),
                      borderSide: BorderSide(),
                    ),
                  ),
                  onChanged: onSearchTextChanged,
                ),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      child: DataTable(
                        sortAscending: sort,
                        sortColumnIndex: 0,
                        columns: [
                          DataColumn(
                              label: Text("FIRST NAME"),
                              numeric: false,
                              tooltip: "This is First Name",
                              onSort: (columnIndex, ascending) {
                                setState(() {
                                  sort = !sort;
                                });
                                onSortColum(columnIndex, ascending);
                              }),
                          DataColumn(
                            label: Text("LAST NAME"),
                            numeric: false,
                            tooltip: "This is Last Name",
                          ),
                        ],
                        rows: _searchResult.length != 0 ||
                                controller.text.isNotEmpty
                            ? _searchResult
                                .map(
                                  (user) => DataRow(
                                      selected: selectedUsers.contains(user),
                                      onSelectChanged: (b) {
                                        print("Onselect");
                                        onSelectedRow(b, user);
                                      },
                                      cells: [
                                        DataCell(
                                          Text(user.firstName),
                                          onTap: () {
                                            print('Selected ${user.firstName}');
                                          },
                                        ),
                                        DataCell(
                                          Text(user.lastName),
                                        ),
                                      ]),
                                )
                                .toList()
                            : users
                                .map(
                                  (user) => DataRow(
                                      selected: selectedUsers.contains(user),
                                      onSelectChanged: (b) {
                                        print("Onselect");
                                        onSelectedRow(b, user);
                                      },
                                      cells: [
                                        DataCell(
                                          Text(user.firstName),
                                          onTap: () {
                                            print('Selected ${user.firstName}');
                                          },
                                        ),
                                        DataCell(
                                          Text(user.lastName),
                                        ),
                                      ]),
                                )
                                .toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: dataBody(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(20.0),
                child: OutlineButton(
                  child: Text('SELECTED ${selectedUsers.length}'),
                  onPressed: () {},
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: OutlineButton(
                  child: Text('DELETE SELECTED'),
                  onPressed: selectedUsers.isEmpty
                      ? null
                      : () {
                          deleteSelected();
                        },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
