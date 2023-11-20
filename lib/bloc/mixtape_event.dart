part of 'mixtape_bloc.dart';

class MixtapeEvent extends Equatable {
  const MixtapeEvent();

  @override
  List<Object> get props => [];
}

//Authentication
class AuthLogout extends MixtapeEvent{}
class AuthLogin extends MixtapeEvent{}

//Friendship
class FriendReqAccept extends MixtapeEvent{}
class FriendReqDeny extends MixtapeEvent{}
class FriendSendReq extends MixtapeEvent{}
class FriendDelete extends MixtapeEvent{}
class FriendGetMany extends MixtapeEvent{}

//Mixtape
class MixtapeGetMany extends MixtapeEvent{}
class MixtapeGetByTitle extends MixtapeEvent{}
class MixtapeGetByTape extends MixtapeEvent{}
class MixtapeGetByArtist extends MixtapeEvent{}
class MixtapeGetBySong extends MixtapeEvent{}
class MixtapeGet extends MixtapeEvent{}
class MixtapeReact extends MixtapeEvent{}
class MixtapeCreate extends MixtapeEvent{}
class MixtapeDelete extends MixtapeEvent{}

//Notification
class NotifGetMany extends MixtapeEvent{}

//Playlist
class PlaylistGetMany extends MixtapeEvent{}
class PlaylistGet extends MixtapeEvent{}
class PlaylistDTOInvite extends MixtapeEvent{}
class PlaylistCreate extends MixtapeEvent{}
class PlaylistSetPic extends MixtapeEvent{}
class PlaylistDelete extends MixtapeEvent{}
class PlaylistReqAccept extends MixtapeEvent{}
class PlaylistReqDeny extends MixtapeEvent{}

//Profile
class ProfileGetMe extends MixtapeEvent{}
class ProfileSearch extends MixtapeEvent{}









