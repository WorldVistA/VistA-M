MAGGTUP ;WOIFO/GEK/SG/NST - Imaging System User preferences ; 12 Apr 2010 9:20 AM
 ;;3.0;IMAGING;**7,8,48,45,59,93,94**;Mar 19, 2002;Build 1744;May 26, 2010
 ;; Per VHA Directive 2004-038, this routine should not be modified.
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; | Use of unreleased versions of this software requires the user |
 ;; | to execute a written test agreement with the VistA Imaging    |
 ;; | Development Office of the Department of Veterans Affairs,     |
 ;; | telephone (301) 734-0100.                                     |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a medical device.  As such, it may not be changed in any way. |
 ;; | Modifications to this software may result in an adulterated   |
 ;; | medical device under 21CFR820, the use of which is considered |
 ;; | to be a violation of US Federal Statutes.                     |
 ;; +---------------------------------------------------------------+
 ;;
 Q
GET(MAGRY,CODE) ;RPC [MAGGUPREFGET] Call to Get user preferences.
 ;
 N Y,PRFIEN,J,X,Z,NODE,MAGPREF
 N $ETRAP,$ESTACK S $ETRAP="D ERRA^MAGGTERR"
 K MAGRY
 S MAGRY(0)="0^Error: Attempting to access user preference"
 S PRFIEN=$O(^MAG(2006.18,"AC",DUZ,""))
 ;    if first time user
 I 'PRFIEN S PRFIEN=$$NEWUSER(DUZ) Q:PRFIEN=-1
 ;    merge default settings into User's Preferences
 D MERGE(PRFIEN)
 ;    This returns the users default Filter, and creates filters if needed.
 S $P(^MAG(2006.18,PRFIEN,"LISTWIN1"),"^",3)=$$DFTFLT^MAGGSFLT(DUZ)
 S MAGRY(0)="1^User Preferences returned."
 ; 
 ; At This point.  Then entry in 2006.18 for User DUZ in complete
 ;   it has been merged with defaults, and has a valid Default Filter.
 ;   
 ;  if caller only wants one node, get it then quit.
 I $L($G(CODE))  S MAGRY($O(MAGRY(""),-1)+1)=CODE_"^"_$G(^MAG(2006.18,PRFIEN,CODE)) Q
 ;
 ;  loop through User Pref file, returning all nodes.
 ; Next line was Un-Commented out. BUT Clients before Patch 8 need it.
 S MAGRY($O(MAGRY(""),-1)+1)="SYS^"_^MAG(2006.18,PRFIEN,0)
 S NODE=""
 F  S NODE=$O(^MAG(2006.18,PRFIEN,NODE)) Q:(NODE="")  D
 . S MAGRY($O(MAGRY(""),-1)+1)=NODE_"^"_^MAG(2006.18,PRFIEN,NODE)
 Q
MERGE(PRFIEN) ; Merge default settings into User Prefs returned.
 ; This will assure the User Prefs returned have values for New fields.
 ; PRFIEN = IEN in IMAGING USER PREFERENCES File.
 N NODE,DARR,MN,YN
 D DFLTARR(.DARR)
 S NODE="" F  S NODE=$O(DARR($J,NODE)) Q:(NODE="")  D
 . S YN=DARR($J,NODE)
 . S MN=$G(^MAG(2006.18,PRFIEN,NODE))
 . F J=1:1:$L(YN,"^") I ($P(YN,"^",J)'=""),($P(MN,"^",J)="") S $P(MN,"^",J)=$P(YN,"^",J)
 . S ^MAG(2006.18,PRFIEN,NODE)=MN
 ;
 Q
SAVE(MAGRY,DATA) ;RPC [MAGGUPREFSAVE] Call to save User Preferences
 ;
 S MAGRY="0^Error: Saving user preferences."
 N X,Y,NODE,PRFIEN,J
 N $ETRAP,$ESTACK S $ETRAP="D ERR^MAGGTERR"
 S PRFIEN=$O(^MAG(2006.18,"AC",DUZ,"")) I 'PRFIEN S PRFIEN=$$NEWUSER(DUZ) Q:PRFIEN=-1
 S NODE="" F  S NODE=$O(DATA(NODE)) Q:NODE=""  D
 . S X=$G(^MAG(2006.18,PRFIEN,NODE))
 . S Y=DATA(NODE)
 . F J=1:1:$L(Y,"^") I $L($P(Y,"^",J)) S $P(X,"^",J)=$P(Y,"^",J)
 . S ^MAG(2006.18,PRFIEN,NODE)=X
 S MAGRY="1^User Preferences saved."
 Q
NEWUSER(USER) ;Returns IEN of New entry in IMAGING USER PREFERENCES File.
 K DD,DO
 N DIC
 S X=$E($$GET1^DIQ(200,USER_",",.01),1,15)_" (SETTING 1)"
 S DIC="^MAG(2006.18,",DIC(0)="L"
 S DIC("DR")="1////"_USER_";2////12;3////12;" D FILE^DICN
 I Y=-1 Q Y
 D DEFAULT(+Y)
 Q +Y
DEFAULT(NEWPREF) ;Setup a new IMAGING USER PREFERENCES entry, with System defaults.
 ;    NEWPREF = IEN in IMAGING USER PREFERENCES File
 N DFTPREF,N0,DFTSET
 S DFTPREF=+$$GET1^DIQ(2006.1,$$PLACE^MAGBAPI(DUZ(2)),100,"I") ; DBI - SEB 9/20/2002
 I DFTPREF,$D(^MAG(2006.18,DFTPREF)) D DEFUSER(NEWPREF,DFTPREF) Q
 ;    save the User name, Setting Name 
 S N0=$P(^MAG(2006.18,NEWPREF,0),U,1,4)
 D DFLTARR(.DFTSET)
 M ^MAG(2006.18,NEWPREF)=DFTSET($J)
 ;    reset User name, Setting name.
 S $P(^MAG(2006.18,NEWPREF,0),U,1,4)=N0
 Q
DEFUSER(NEWPREF,DFTPREF) ;Merge New User preference with the Default User as defined
 ; in the Imaging Site Parameters file
 ;    NEWPREF  =  new IMAGING USER PREFERENCE (IEN)
 ;    DFLTPREF =  DEFAULT USER PREFERENCE in the IMAGING SITE PARAMETERS File
 ; 
 N X0
 S X0=$P(^MAG(2006.18,NEWPREF,0),"^",1,4)
 M ^MAG(2006.18,NEWPREF)=^MAG(2006.18,DFTPREF)
 S $P(^MAG(2006.18,NEWPREF,0),"^",1,4)=X0
 ;    remove default user's default Filter from new user's preferences.
 S $P(^MAG(2006.18,NEWPREF,"LISTWIN1"),"^",3)=""
 Q
DFLTARR(ARR) ; Return an Array of All Default settings
 K ARR($J)
 S ARR($J,0)="^^^^0^1^1^"
 S ARR($J,"DICOMWIN")="2^320^292^724^487"
 S ARR($J,"IMAGEGRID")="2^487^2^786^426^1^35,73,67,34,110,46,69,96,76,79,25,0,0^1^"
 S ARR($J,"REPORT")="2^2^333^722^437^Courier^^10"
 S ARR($J,"RADLISTWIN")="2^487^10^433^172^0"
 S ARR($J,"MAIN")="2^1^1^487^172^1"
 S ARR($J,"ABS")="2^1^160^486^326^134^113^1^1^3^24^2^1^0"
 S ARR($J,"FULL")="2^310^282^714^487^674^447^^1^1^4^1^0^1"
 S ARR($J,"GROUP")="2^24^231^427^457^110^70^^1^2^24^2^1^0"
 S ARR($J,"DOC")="2^298^24^729^429^0^0^3^1^2^4^2^0"
 S ARR($J,"CAPCONFIG")="1^1^1^0^0^0^0^1^0^1^0^0^1^1^0^0^1^1^1^1^1^1^200^400^300^100^500^0^0^1^0^1"
 ;                    1   2   3   4   5  6  7  8 9 0 1  2   3  456 7 8
 S ARR($J,"CAPTIU")="261^414^455^654^66^67^280^1^1^~^1^100^-12^^^1^1^^"
 S ARR($J,"RIVER")="1^0^0^0^"
 S ARR($J,"APPMSG")="0^0^"
 S ARR($J,"APPPREFS")="1^7^7^10"
 S ARR($J,"LISTWIN1")="0^0^^1^0"
 ;--- MAG*3*93
 S ARR($J,"IEDIT")="2^445^295^710^433"
 S ARR($J,"ISTYLE")="0^0^1^1^1^3^1^1^0^1^1^1^,101,460,288,2,2,288,298,259,160,"
 S ARR($J,"IVERIFY")="2^184^56^1201^871^1^0^1^1^44,139,0,0,0,42,0,0,0,0,0,0,0,0,0,58,0,,"
 ;
 ; MAG*3.0*94
 S ARR($J,"EKG")="2^1^1^600^400^0"
 Q
