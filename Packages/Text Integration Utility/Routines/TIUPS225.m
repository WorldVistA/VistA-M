TIUPS225 ; ISL/JER - Post-install for TIU*1*225 ; 06/05/2007
 ;;1.0;TEXT INTEGRATION UTILITIES;**225**;Jun 20, 1997;Build 13
 ;
MAIN ; control subroutine
 D SETID
 D BALOINC
 D SETSEC
 D SETMGS
 Q
SETID ; Create "Write identifier" for file 8925.1
 N TIUID
 D BMES^XPDUTL("SETTING ""WRITE"" IDENTIFIER ON FILE 8925.1")
 S TIUID="S %I=Y,Y=$S('$D(^(15)):"""",$D(^TIU(8926.1,+$P(^(15),U,1),0))#2:$P(^(0),U,1),1:"""") N DIERR S:Y]"""" Y=$$EXTERNAL^DILFD(8926.1,.01,"""",Y,""DIERR"") D:Y]"""" EN^DDIOL(Y,"""",""!?6,""""Std Title: """""") S Y=%I K %I"
 S ^DD(8925.1,0,"ID","W.1501")=TIUID
 Q
BALOINC ; Build "ALOINC" x-ref on file 8925.1
 N DA,DIK,TIUCNT
 D BMES^XPDUTL("BUILDING NEW ""ALOINC"" CROSS-REFERENCE ON FILE 8925.1")
 ; remove "LOINC" cross-reference in preparation for building "ALOINC"
 K ^TIU(8925.1,"LOINC")
 S (DA,TIUCNT)=0,DIK="^TIU(8925.1,",DIK(1)="1501^ALOINC"
 F  S DA=$O(^TIU(8925.1,DA)) Q:+DA'>0  D
 . D EN1^DIK
 . S TIUCNT=TIUCNT+1
 . I '(TIUCNT#10) D UPDATE^XPDID(TIUCNT)
 Q
SETSEC ; set file security on 8926.1
 N TIUSC S TIUSC("RD")=""
 D FILESEC^DDMOD(8926.1,.TIUSC)
 Q
SETMGS ; set mail groups for TIU ENTERPRISE STANDARD TITLES bulletin
 N TIUBIEN,TIUBNM,TIUERRF,TIUFDA,TIUGIEN,TIUGNM,TIULNE
 N TIUMSG,TIUTXT
 K TIUMSG
 D BMES^XPDUTL("Attaching Mail Groups to TIU ENTERPRISE STANDARD TITLES Bulletin")
 S TIUBNM="TIU ENTERPRISE STANDARD TITLES"
 S TIUBIEN=$$FIND1^DIC(3.6,"","X",TIUBNM,"","","")
 ;If Bulletin not found, error
 I TIUBIEN'>0 D  I 1
 . S TIUMSG(1)="**"
 . S TIUMSG(2)="** Bulletin "_TIUBNM_" not found"
 . D MES^XPDUTL(.TIUMSG) K TIUMSG
 . S TIUERRF=1
 ELSE  F TIUGNM="TIU CACS","XUMF SERVER" D  Q:+$G(TIUERRF)
 . S TIUGIEN=$$FIND1^DIC(3.8,"","X",TIUGNM,"","","")
 . ;If Mail Group not found, error
 . I TIUGIEN'>0 D  Q
 . . S TIUMSG(1)="**"
 . . S TIUMSG(2)="** Mail Group "_TIUGNM_" not found"
 . . D MES^XPDUTL(.TIUMSG) K TIUMSG
 . . S TIUERRF=1
 . ;Attach Mail Group to Bulletin
 . N TIUFDA,TIUIEN,TIUMSG
 . S TIUFDA(3.62,"?+2,"_TIUBIEN_",",.01)=TIUGIEN
 . D UPDATE^DIE("","TIUFDA","TIUIEN","TIUMSG")
 . ;Check for error
 . I $D(TIUMSG("DIERR")) D  Q
 . . S TIUMSG(1)="**"
 . . S TIUMSG(2)="** Unable to attach "_TIUGNM_" to "_TIUBNM
 . . D MES^XPDUTL(.TIUMSG) K TIUMSG
 . . S TIUERRF=1
 . S TIUMSG(1)=" "
 . S TIUMSG(2)="... G."_TIUGNM_$S($G(TIUIEN(2,0))="?":" already",1:"")_" attached to "_TIUBNM_" Bulletin"
 . D MES^XPDUTL(.TIUMSG) K TIUMSG
 ;Check for error
 I $G(TIUERRF) D
 . S TIUMSG(1)="** Post-installation interrupted"
 . S TIUMSG(2)="** Please contact Enterprise VistA Support"
 . D MES^XPDUTL(.TIUMSG) K TIUMSG
 Q
