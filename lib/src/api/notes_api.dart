import '../core/trakt_api_client.dart';
import '../core/trakt_extended_info.dart';
import '../core/trakt_privacy.dart';
import '../models/trakt_note.dart';
import '../models/trakt_movie.dart';
import '../models/trakt_show.dart';
import '../models/trakt_season.dart';
import '../models/trakt_episode.dart';
import '../models/trakt_person.dart';

class NotesApi {
  final TraktApiClient _client;

  NotesApi(this._client);

  /// Create a new note attached to a media item.
  Future<TraktNote> create({
    required String note,
    TraktPrivacy privacy = TraktPrivacy.private,
    TraktMovie? movie,
    TraktShow? show,
    TraktSeason? season,
    TraktEpisode? episode,
    TraktPerson? person,
    int? historyId,
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
        'history_id': historyId,
      }..removeWhere((key, value) => value == null),
      mapper: (body, headers) =>
          TraktNote.fromJson(body as Map<String, dynamic>),
    );
  }

  /// Get a single note by its ID.
  Future<TraktNote> get(int id) async {
    return _client.get(
      '/notes/$id',
      mapper: (body, headers) =>
          TraktNote.fromJson(body as Map<String, dynamic>),
    );
  }

  /// Update an existing note.
  Future<TraktNote> update(int id, {required String note, TraktPrivacy privacy = TraktPrivacy.private}) async {
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

  /// Get the object the note is attached to.
  ///
  /// Returns a dynamic object which can be [TraktMovie], [TraktShow],
  /// [TraktSeason], [TraktEpisode], or [TraktPerson].
  Future<dynamic> getItem(int id, {String extended = TraktExtendedInfo.metadata}) async {
    return _client.get(
      '/notes/$id/item',
      queryParams: {'extended': extended},
      mapper: (body, headers) {
        final Map<String, dynamic> json = body as Map<String, dynamic>;
        final String type = json['type'] as String;
        final data = json[type] as Map<String, dynamic>;

        switch (type) {
          case 'movie':
            return TraktMovie.fromJson(data);
          case 'show':
            return TraktShow.fromJson(data);
          case 'season':
            return TraktSeason.fromJson(data);
          case 'episode':
            return TraktEpisode.fromJson(data);
          case 'person':
            return TraktPerson.fromJson(data);
          default:
            return data;
        }
      },
    );
  }
}
