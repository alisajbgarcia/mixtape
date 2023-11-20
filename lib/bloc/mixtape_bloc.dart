import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mixtape/models/friendship.dart';
import 'package:mixtape/models/notification.dart';
import 'package:mixtape/models/profile.dart';
import 'package:mixtape/services/authentication_service.dart';
import 'package:mixtape/services/mixtape_service.dart';
import 'package:mixtape/services/notification_service.dart';
import 'package:mixtape/services/playlist_service.dart';
import 'package:mixtape/services/profile_service.dart';
import 'package:mixtape/widgets/playlist_invitation.dart';

import '../models/mixtape.dart';
import '../models/playlist.dart';
import '../services/friendship_service.dart';

part 'mixtape_event.dart';
part 'mixtape_state.dart';

class MixtapeBloc extends Bloc<MixtapeEvent, MixtapeState> {
  MixtapeBloc({
    required Profile currentProfile,
    required ProfileService profileService,
    required AuthenticationService authenticationService,
    required FriendshipService friendshipService,
    required MixtapeService mixtapeService,
    required NotificationService notificationService,
    required PlaylistService playlistService,
  }) : _currentProfile = currentProfile,
  _profileService = profileService,
  _authenticationService = authenticationService,
  _friendshipService = friendshipService,
  _mixtapeService = mixtapeService,
  _notificationService = notificationService,
  _playlistService = playlistService,
  super(const MixtapeState()) {
    on<AuthLogout>(_onAuthLogout);
    on<AuthLogin>(_onAuthLogin);

    on<FriendReqAccept>(_onFriendReqAccept);
    on<FriendReqDeny>(_onFriendReqDeny);
    on<FriendSendReq>(_onFriendSendReq);
    on<FriendDelete>(_onFriendDelete);
    on<FriendGetMany>(_onFriendGetMany);
    
    on<MixtapeGetMany>(_onMixtapeGetMany);
    on<MixtapeGetByTitle>(_onMixtapeGetByTitle);
    on<MixtapeGetByArtist>(_onMixtapeGetByArtist);
    on<MixtapeGetBySong>(_onMixtapeGetBySong);
    on<MixtapeGetByTape>(_onMixtapeGetByTape);
    on<MixtapeGet>(_onMixtapeGet);
    on<MixtapeReact>(_onMixtapeReact);
    //on<MixtapeCreate>(_onMixtapeCreate);
    on<MixtapeDelete>(_onMixtapeDelete);
  }



  final Profile _currentProfile;
  final ProfileService _profileService;
  final AuthenticationService _authenticationService;
  final FriendshipService _friendshipService; 
  final MixtapeService _mixtapeService;
  final NotificationService _notificationService;
  final PlaylistService _playlistService;


  //ALL EVENT HANDLERS
  //Authentication
  Future<bool> _onAuthLogin(AuthLogin event, Emitter<MixtapeState> emit) async {
    return _authenticationService.login();
  }

  Future<void> _onAuthLogout(AuthLogout event, Emitter<MixtapeState> emit) async {
    return _authenticationService.logout();
  }

  
  //Friendship
  Future<List<Friendship>> _onFriendGetMany(FriendGetMany event, Emitter<MixtapeState> emit) async {
    return _friendshipService.getFriendsForCurrentUser();
  }
  Future<void> _onFriendReqAccept(FriendReqAccept event, Emitter<MixtapeState> emit) async {
    return _friendshipService.acceptRequest(state.id);
  }
  Future<void> _onFriendReqDeny(FriendReqDeny event, Emitter<MixtapeState> emit) async {
    return _friendshipService.deleteRequest(state.id);
  }
  Future<void> _onFriendSendReq(FriendSendReq event, Emitter<MixtapeState> emit) async {
    return _friendshipService.createFriendRequest(state.id);
  }
  Future<void> _onFriendDelete(FriendDelete event, Emitter<MixtapeState> emit) async {
    return _friendshipService.deleteFriendship(state.id);
  }


  //Mixtape
  Future<List<Mixtape>> _onMixtapeGetMany(MixtapeGetMany event, Emitter<MixtapeState> emit) async {
    return _mixtapeService.getMixtapesForPlaylistCurrentUser(state.id);
  }
  Future<List<Mixtape>> _onMixtapeGetByTitle(MixtapeGetByTitle event, Emitter<MixtapeState> emit) async {
    return _mixtapeService.getMixtapesbyTapeForPlaylistCurrentUser(state.id, state.text);
  }
  Future<List<Mixtape>> _onMixtapeGetBySong(MixtapeGetBySong event, Emitter<MixtapeState> emit) async {
    return _mixtapeService.getMixtapesbyTapeForPlaylistCurrentUser(state.id, state.text);
  }
  Future<List<Mixtape>> _onMixtapeGetByTape(MixtapeGetByTape event, Emitter<MixtapeState> emit) async {
    return _mixtapeService.getMixtapesbyTapeForPlaylistCurrentUser(state.id, state.text);
  }
  Future<List<Mixtape>> _onMixtapeGetByArtist(MixtapeGetByArtist event, Emitter<MixtapeState> emit) async {
    return _mixtapeService.getMixtapesbyTapeForPlaylistCurrentUser(state.id, state.text);
  }
  Future<Mixtape> _onMixtapeGet(MixtapeGet event, Emitter<MixtapeState> emit) async {
    return _mixtapeService.getMixtapeInPlaylistCurrentUser(state.id, state.id2);
  }
  Future<Mixtape> _onMixtapeReact(MixtapeReact event, Emitter<MixtapeState> emit) async {
    return _mixtapeService.addReactionForCurrentUser(state.id, state.id2, type: state.text);
  }
  /*
  Future<Mixtape> _onMixtapeCreate(MixtapeCreate event, Emitter<MixtapeState> emit) async {
    return _mixtapeService.createMixtapeInPlaylistForCurrentUser(state.id);
  }*/
  Future<void> _onMixtapeDelete(MixtapeDelete event, Emitter<MixtapeState> emit) async {
    return _mixtapeService.deleteMixtapeInPlaylistForCurrentUser(state.id, state.id2);
  }
  

  //Notification
  Future<List<Notif>> _onNotifGetMany(NotifGetMany event, Emitter<MixtapeState> emit) async {
    return _notificationService.getNotifications();
  }


  //Playlist
  /*

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
  */

}
