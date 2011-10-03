GMRYXENV ;HIRMFO/FT-Environment Check for intake & Output v4.0  ;1/21/97  14:26
 ;;4.0;Intake/Output;;Apr 25, 1997
GMRY ;
 I +$$VERSION^XPDUTL("REGISTRATION")<5.3 D BMES^XPDUTL("PIMS (MAS) V5.3 OR GREATER IS REQUIRED - CANNOT CONTINUE") S XPDABORT=2 Q
 Q:+$$VERSION^XPDUTL("GMRY")'>0  ;quit if virgin install
 ; find how many entries exist in Package File (#9.4)
 K GMRYIEN,GMRYERR
 D FIND^DIC(9.4,"","","X","GMRY","","C","","","GMRYIEN","GMRYERR")
 ; quit if FileMan lookup errors out
 I +$G(GMRYERR("DIERR")) D  S GMRYSTOP=1 D KILL Q
 .K GMRYMSG
 .S GMRYMSG(1)="Error trying to lookup Intake & Output in the PACKAGE (#9.4) file."
 .S GMRYMSG(2)="Halting."
 .D BMES^XPDUTL(.GMRYMSG)
 .Q
 ; delete duplicates
 ; keep GEN. MED. REC. - I/O entry
 S GMRYSEQ=0
 F  S GMRYSEQ=$O(GMRYIEN("DILIST",1,GMRYSEQ)) Q:GMRYSEQ'>0  D
 . S GMRYNAME=$G(GMRYIEN("DILIST",1,GMRYSEQ)) Q:GMRYNAME=""
 . I GMRYNAME="GEN. MED. REC. - I/O" Q
 . S DA=$G(GMRYIEN("DILIST",2,GMRYSEQ))
 . I DA S DIK="^DIC(9.4," D ^DIK
 . Q
KILL ;
 S:$G(GMRYSTOP) XPDABORT=2 ;don't install transport global/leave in ^XTMP
 K DA,DIK,GMRYERR,GMRYIEN,GMRYMSG,GMRYNAME,GMRYSEQ,X,Y
 Q
