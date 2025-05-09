import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messenger/features/contacts/domain/usecases/add_contacts_usecase.dart';
import 'package:messenger/features/contacts/domain/usecases/fetch_contacts_usecase.dart';
import 'package:messenger/features/contacts/presentation/bloc/contacts_event.dart';
import 'package:messenger/features/contacts/presentation/bloc/contacts_state.dart';

class ContactsBloc extends Bloc<ContactsEvent, ContactsState> {
  final FetchContactsUsecase fetchContactsUsecase;
  final AddContactUseCase addContactUseCase;

  ContactsBloc(
      {required this.fetchContactsUsecase, required this.addContactUseCase})
      : super(ContactsInitial()) {
    on<FetchContacts>(_onFetchContacts);
    on<AddContact>(_onAddContact);
  }

  Future<void> _onFetchContacts(
      FetchContacts event, Emitter<ContactsState> emit) async {
    emit(ContactsLoading());
    try {
      final contacts = await fetchContactsUsecase();
      emit(ContactsLoaded(contacts));
    } catch (error) {
      emit(ContactsError('Failed to fetch contacts'));
    }
  }

  Future<void> _onAddContact(
      AddContact event, Emitter<ContactsState> emit) async {
    emit(ContactsLoading());
    try {
      // Use the correct use case for adding a contact
      await addContactUseCase(email: event.email);

      emit(ContactAdded());
      add(FetchContacts());
    } catch (error) {
      emit(ContactsError('Failed to add contact'));
    }
  }
}
