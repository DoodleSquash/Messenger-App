import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messenger/features/contacts/presentation/bloc/contacts_bloc.dart';
import 'package:messenger/features/contacts/presentation/bloc/contacts_event.dart';
import 'package:messenger/features/contacts/presentation/bloc/contacts_state.dart';

class ContactsPage extends StatelessWidget {
  const ContactsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contacts'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: BlocBuilder<ContactsBloc, ContactsState>(
        builder: (context, state) {
          if (state is ContactsLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is ContactsLoaded) {
            return ListView.builder(
              itemCount: state.contacts.length,
              itemBuilder: (context, index) {
                final contact = state.contacts[index];
                return ListTile(
                  title: Text(contact.username),
                  subtitle: Text(contact.email),
                  onTap: () {
                    Navigator.pop(context, contact );
                  },
                );
              },
            );
          } else if (state is ContactsError) {
            return Center(child: Text(state.message));
          } else {
            return Center(child: Text('No contacts found'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddContactDialog(context),
        child: Icon(Icons.add),
      ),
    );
  }


  void _showAddContactDialog(BuildContext context) {
    final TextEditingController emailController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.red,
          title: Text('Add Contact',
              style: Theme.of(context).textTheme.bodyMedium),
          content: TextField(
            controller: emailController,
            decoration: InputDecoration(hintText: 'Enter contact email'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                final email = emailController.text.trim();
                if (email.isNotEmpty) {
                  BlocProvider.of<ContactsBloc>(context)
                      .add(AddContact( email));
                }
                Navigator.pop(context);
              },
              child: Text('Add',
              style: Theme.of(context).textTheme.bodyMedium
              ),

            ),
          ],
        );
      },
    );
  }
}