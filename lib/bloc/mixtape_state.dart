part of 'mixtape_bloc.dart';

enum PageStatus { add_songs, friends, home, login, notif, playlist_creation, playlist, profile, search, tape, tape_creation }

class MixtapeState extends Equatable {
  const MixtapeState({
    this.page = PageStatus.login,
    this.playlists = const <Playlist>[],
    this.friends = const <Friend>[],
    this.notifications = const <Notif>[],
    this.tapes = const <Mixtape>[],
    this.id = "",
    this.id2 = "",
    this.text = "",
  });

  
  final PageStatus page;
  final List<Playlist> playlists;
  final List<Friend> friends;
  final List<Notif> notifications;
  final List<Mixtape> tapes;
  final String id;
  final String id2;
  final String text;


  //Used to change a sinular aspect of the Bloc State
  MixtapeState copyWith({
    PageStatus? page,
    List<Playlist>? playlists,
    Profile? currentProfile,
    List<Friend>? friends,
    List<Notif>? notifications,
    List<Mixtape>? tapes,
    String? id,
    String? id2,
    String? text,
  }) {
    return MixtapeState(
      page: page ?? this.page,
      playlists: playlists ?? this.playlists,
      friends: friends ?? this.friends,
      notifications: notifications ?? this.notifications,
      tapes: tapes ?? this.tapes,
      id: id ?? this.id,
      id2: id2 ?? this.id2,
      text: text ?? this.text,
    );
  }
  
  @override
  List<Object> get props => [];
}

class MixtapeInitial extends MixtapeState {
}
