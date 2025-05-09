
import 'package:messenger/features/contacts/data/datasources/contacts_remote_data_source.dart';
import 'package:messenger/features/contacts/domain/entities/contact_entity.dart';
import 'package:messenger/features/contacts/domain/repositories/contacts_repository.dart';

class ContactsRepositoryImpl implements ContactsRepository {
  final ContactsRemoteDataSource remoteDataSource;


  ContactsRepositoryImpl({required this.remoteDataSource});

  @override
  Future<void> addContact({required String email}) async {
   await remoteDataSource.addContact(email: email);
  }

  @override
  Future<List<ContactEntity>> fetchContacts() async {
    return await remoteDataSource.fetchContacts();
  }
}
