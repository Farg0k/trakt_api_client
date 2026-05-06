import '../core/trakt_api_client.dart';
import '../core/trakt_extended_info.dart';
import '../models/trakt_note.dart';

class NotesApi {
  final TraktApiClient _client;

  NotesApi(this._client);

  /// Get a single note by its ID.
  Future<TraktNote> get(int id,
      {TraktExtendedInfo extended = TraktExtendedInfo.metadata}) async {
    return _client.get(
      '/notes/$id',
      queryParams: {'extended': extended.value},
      mapper: (body, headers) =>
          TraktNote.fromJson(body as Map<String, dynamic>),
    );
  }
}
