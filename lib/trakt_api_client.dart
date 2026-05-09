/// A comprehensive, type-safe, and highly optimized Dart/Flutter client for the Trakt.tv API.
///
/// This library provides access to all documented Trakt.tv API endpoints,
/// including Movies, Shows, Seasons, Episodes, Users, Sync, Search, and more.
/// It features automatic OAuth2 token management, advanced filtering, and
/// a robust data model architecture.
library;

export 'src/api/authentication_api.dart';
export 'src/api/calendars_api.dart';
export 'src/api/certifications_api.dart';
export 'src/api/checkin_api.dart';
export 'src/api/comments_api.dart';
export 'src/api/countries_api.dart';
export 'src/api/episodes_api.dart';
export 'src/api/genres_api.dart';
export 'src/api/languages_api.dart';
export 'src/api/lists_api.dart';
export 'src/api/movies_api.dart';
export 'src/api/networks_api.dart';
export 'src/api/notes_api.dart';
export 'src/api/people_api.dart';
export 'src/api/recommendations_api.dart';
export 'src/api/scrobble_api.dart';
export 'src/api/search_api.dart';
export 'src/api/seasons_api.dart';
export 'src/api/shows_api.dart';
export 'src/api/sync_api.dart';
export 'src/api/users_api.dart';
export 'src/core/trakt_api_client.dart';
export 'src/core/trakt_api_config.dart';
export 'src/core/trakt_api_exception.dart';
export 'src/core/trakt_comment_types.dart';
export 'src/core/trakt_date_utils.dart';
export 'src/core/trakt_extended_info.dart';
export 'src/core/trakt_filters.dart';
export 'src/core/trakt_id_type.dart';
export 'src/core/trakt_image_utils.dart';
export 'src/core/trakt_last_activity.dart';
export 'src/core/trakt_list_response.dart';
export 'src/core/trakt_media_class.dart';
export 'src/core/trakt_media_type.dart';
export 'src/core/trakt_period.dart';
export 'src/core/trakt_privacy.dart';
export 'src/core/trakt_rate_limit.dart';
export 'src/core/trakt_report_reason.dart';
export 'src/core/trakt_search_fields.dart';
export 'src/core/trakt_search_utils.dart';
export 'src/core/trakt_sort_types.dart' hide TraktCommentSort;
export 'src/core/trakt_pagination_params.dart';
export 'src/models/trakt_airs.dart';
export 'src/models/trakt_auth_models.dart';
export 'src/models/trakt_checkin_models.dart';
export 'src/models/trakt_comment.dart';
export 'src/models/trakt_episode.dart';
export 'src/models/trakt_generic_models.dart';
export 'src/models/trakt_ids.dart';
export 'src/models/trakt_list.dart';
export 'src/models/trakt_media_entity.dart';
export 'src/models/trakt_media_models.dart';
export 'src/models/trakt_media_state.dart';
export 'src/models/trakt_movie.dart';
export 'src/models/trakt_note.dart';
export 'src/models/trakt_person.dart';
export 'src/models/trakt_person_models.dart';
export 'src/models/trakt_scrobble_models.dart';
export 'src/models/trakt_search_result.dart';
export 'src/models/trakt_season.dart';
export 'src/models/trakt_sharing.dart';
export 'src/models/trakt_show.dart';
export 'src/models/trakt_show_progress.dart';
export 'src/models/trakt_stats.dart';
export 'src/models/trakt_sync_models.dart';
export 'src/models/trakt_user.dart';
export 'src/models/trakt_user_models.dart';
export 'src/models/trakt_video.dart';
