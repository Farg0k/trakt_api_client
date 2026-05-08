import '../core/trakt_api_client.dart';
import '../core/trakt_extended_info.dart';
import '../core/trakt_privacy.dart';
import '../models/trakt_episode.dart';
import '../models/trakt_movie.dart';
import '../models/trakt_note.dart';
import '../models/trakt_note_item.dart';
import '../models/trakt_person.dart';
import '../models/trakt_season.dart';
import '../models/trakt_show.dart';

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

  /// Create a new note.
  ///
  /// You can attach the note to a [movie], [show], [season], [episode], or [person].
  Future<TraktNote> create({
    required String note,
    TraktPrivacy privacy = TraktPrivacy.private,
    TraktMovie? movie,
    TraktShow? show,
    TraktSeason? season,
    TraktEpisode? episode,
    TraktPerson? person,
  }) async {
    return _client.post(
      '/notes',
      body: {
        'note': note,
        'privacy': privacy.name,
        if (movie != null) 'movie': {'ids': movie.ids?.toJson()},
        if (show != null) 'show': {'ids': show.ids?.toJson()},
        if (season != null) 'season': {'ids': season.ids?.toJson()},
        if (episode != null) 'episode': {'ids': episode.ids?.toJson()},
        if (person != null) 'person': {'ids': person.ids?.toJson()},
      },
      mapper: (body, headers) =>
          TraktNote.fromJson(body as Map<String, dynamic>),
    );
  }

  /// Update an existing note.
  Future<TraktNote> update(
    int id, {
    required String note,
    TraktPrivacy privacy = TraktPrivacy.private,
  }) async {
    return _client.put(
      '/notes/$id',
      body: {
        'note': note,
        'privacy': privacy.name,
      },
      mapper: (body, headers) =>
          TraktNote.fromJson(body as Map<String, dynamic>),
    );
  }

  /// Delete a note.
  Future<void> delete(int id) async {
    await _client.delete(
      '/notes/$id',
      mapper: (body, headers) => null,
    );
  }

  /// Get all items attached to a note.
  Future<List<TraktNoteItem>> getItems(int id) async {
    return _client.get(
      '/notes/$id/items',
      mapper: (body, headers) => (body as List)
          .map((item) => TraktNoteItem.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
}
