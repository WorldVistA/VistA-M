EDP2PRE ;SLC/BWF - Post-init for facility install ;6/5/13 2:25pm
 ;;2.0;EMERGENCY DEPARTMENT;**6**;Feb 24, 2012;Build 200
 ;
 D CLEAR,DEL
 Q
 ;
CLEAR ;
 N I
 ; delete components
 S I=0 F  S I=$O(^EDPB(232.72,I)) Q:'I  D
 .S FDA(232.72,I_",",.01)="@" D FILE^DIE(,"FDA")
 ; delete sections
 S I=0 F  S I=$O(^EDPB(232.71,I)) Q:'I  D
 .S FDA(232.71,I_",",.01)="@" D FILE^DIE(,"FDA")
 ; delete worksheets
 S I=0 F  S I=$O(^EDPB(232.6,I)) Q:'I  D
 .S FDA(232.6,I_",",.01)="@" D FILE^DIE(,"FDA")
 ; delete widgets
 S I=0 F  S I=$O(^EDPB(232.73,I)) Q:'I  D
 .S FDA(232.73,I_",",.01)="@" D FILE^DIE(,"FDA")
 Q
DEL ;
 ; delete data dictionary for file 232.6
 N ERR
 D DELIXN^DDMOD(232.72,"C","K","","")
 Q
