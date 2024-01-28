import 'package:scrum_handler/model/team_member.dart';
import 'package:flutter/material.dart';

class TeamProvider extends ChangeNotifier {
  final List<TeamMember> _myTeam = [];
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  List<TeamMember> get myTeam => _myTeam;

  TeamProvider() {
    loadCompleteTeam();
  }

  void loadCompleteTeam() async {
    _isLoading = true;
    _myTeam.add(TeamMember(name: 'Alejo Cumpa'));
    _myTeam.add(TeamMember(name: 'Alejo Cumpa2'));
    _myTeam.add(TeamMember(name: 'Alejo Cumpa3'));
    _myTeam.add(TeamMember(name: 'Alejo Cumpa4'));
    _myTeam.add(TeamMember(name: 'Alejo Cumpa5'));
    _myTeam.add(TeamMember(name: 'Alejo Cumpa6'));
    _myTeam.add(TeamMember(name: 'Alejo Cumpa7'));
    _myTeam.add(TeamMember(name: 'Alejo Cumpa8'));
    _myTeam.add(TeamMember(name: 'Alejo Cumpa9'));
    _myTeam.add(TeamMember(name: 'Alejo Cumpa10'));
    _myTeam.add(TeamMember(name: 'Alejo Cumpa11'));
    _myTeam.add(TeamMember(name: 'Alejo Cumpa12'));
    _myTeam.add(TeamMember(name: 'Alejo Cumpa13'));
    _isLoading = false;
  }
}
