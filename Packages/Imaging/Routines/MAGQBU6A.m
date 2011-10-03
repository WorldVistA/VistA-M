MAGQBU6A ;WIOFO/RMP Utility to find possible incorrect Image issues with the Import Queue File. ; 14 Oct 2010 10:12 AM
 ;;3.0;IMAGING;**39**;Mar 19, 2002;Build 2010;Mar 08, 2011
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
GETRL(LIST) ;  Get Redundant List (of shares)
 N HASH,IEN,NODE,NODE2,NODE3,PATH,PLACE,TYPE
 ; Must have same:  PHYSICAL REFERENCE,STORAGE TYPE,HASH DIRECTORY,PLACE
 ; Return array:(UNC path, 1 or 0 for hash directory,division)=list of iens that match the UNC path
 ; ARRAY(\\UNC_HASH_DIVISION)=1ST IEN FOUND_IEN_IEN,etc.
 K LIST
 S U="^"
 S IEN=0 F  S IEN=$O(^MAG(2005.2,IEN)) Q:'IEN  D
 . S NODE=$G(^MAG(2005.2,IEN,0)),NODE3=$G(^MAG(2005.2,IEN,3)),NODE2=$G(^MAG(2005,IEN,3))
 . S PATH=$P(NODE,U,2),PLACE=$P(NODE,U,10),TYPE=$P(NODE,U,7),HASH=$P(NODE,U,8)
 . Q:((TYPE'["WORM")&(TYPE'["MAG"))  ; Only RAID and Jukebox NAMES
 . I +$D(LIST(PATH_U_HASH_U_PLACE)) D  Q
 . . S $P(LIST(PATH_U_HASH_U_PLACE),U,1,99)=$P(LIST(PATH_U_HASH_U_PLACE),U,1,99)_U_IEN
 . . Q
 . E  S LIST(PATH_U_HASH_U_PLACE)=IEN
 . Q
 S PATH="" F  S PATH=$O(LIST(PATH)) Q:PATH=""  D
 . I $G(LIST(PATH))'["^" K LIST(PATH) ;Only entry with more than one IEN defined.
 . Q
 ;Now start applying rule: 
 ;Use the IEN in the duplicates that is ONLINE-- as the primary.
 N NEW,OLD,ON,PC,PRIME
 S EN="" F  S EN=$O(LIST(EN)) Q:EN=""  D
 . S ON=0 F PC=1:1:$L(LIST(EN),"^") S IEN=$P(LIST(EN),U,PC) D  Q:ON
 . . I PC=1,+$P(^MAG(2005.2,IEN,0),U,6) S ON=1 Q    ;above rule
 . . I +$P(^MAG(2005.2,IEN,0),U,6) S ON=1 S NEW(EN)=IEN_"^"_PC
 . . Q
 . Q
 ;resort the array to place the new prime in right order
 S EN="" F  S EN=$O(NEW(EN)) Q:EN=""  D
 . ;get the original prime (OLD)and the new piece value for it.
 . S PRIME=$G(NEW(EN)),OLD=+LIST(EN)_U_$P(PRIME,U,2)
 . S NEW(EN)=$G(LIST(EN))   ;get the original prime and dup values 
 . S $P(NEW(EN),U)=+PRIME   ;set the new prime
 . S $P(NEW(EN),U,$P(OLD,U,2))=+OLD  ;Reposition the old prime value
 . Q
 S EN="" F  S EN=$O(LIST(EN)) Q:EN=""  D
 . I $D(NEW(EN)) M LIST(EN)=NEW(EN)
 . Q
 ;Now save in a temp file in case errors occur during repointing of dangling pointers in the IMAGE files.
 N ENTRY,ILIST,X,X2
 S X=$$NOW^XLFDT,X2=$$FMADD^XLFDT(X,30,"","","")
 S ^XTMP("MAGP39","DUPSHARE",0)=X_"^"_X2_"^"_"Patch 39 Consolidating Network Locations"
 S PATH="" F  S PATH=$O(LIST(PATH)) Q:PATH=""  D 
 . S ILIST=$G(LIST(PATH)) I ILIST S ENTRY=$P(ILIST,"^") I ENTRY D
 . S ^XTMP("MAGP39","DUPSHARE","ENTRIES",ENTRY,PATH)=ILIST
 . Q
 Q 
 ;
DSPNL ; Display the original Network Location file
 N EN,DATA,ONLINE,ROUTER
 S EN=0
 D PMSG^MAGQBUT6("")
 D PMSG^MAGQBUT6("======================================================================")
 D PMSG^MAGQBUT6("Display the original Network Location file")
 F  S EN=$O(^MAG(2005.2,EN)) Q:'EN  D
 . D PMSG^MAGQBUT6("Entry:"_EN_" "_$G(^MAG(2005.2,EN,0)))
 . Q
 D PMSG^MAGQBUT6("======================================================================")
 Q
REPNAM ;Report residual duplicate names
 N ARRAY,DSITE,EN,EN1,PSITE,TMP
 S (TMP,ARRAY)=""
 F  S TMP=$O(^MAG(2005.2,"B",TMP)) Q:TMP=""  D
 . S (EN,EN1)="",EN=$O(^MAG(2005.2,"B",TMP,"")) S PSITE=$P($G(^MAG(2005.2,EN,0)),U,10)
 . S EN1=EN F  S EN1=$O(^MAG(2005.2,"B",TMP,EN1)) Q:EN1=""  D
 . . S DSITE=$P($G(^MAG(2005.2,EN1,0)),U,10)  I PSITE'=DSITE Q  ;Not the same site.
 . . S ARRAY(TMP,EN1)="",ARRAY(TMP,EN)="" Q
 . Q
 Q:$O(ARRAY(""))=""
 S TMP=""
 D PMSG^MAGQBUT6("The following is a list of residual duplicate names in the Network Location file")
 F  S TMP=$O(ARRAY(TMP)) Q:TMP=""  D
 . S EN="" F  S EN=$O(ARRAY(TMP,EN)) Q:EN=""  D
 . . S SITE=$P($G(^MAG(2005.2,EN,0)),U,10),SITE=$P($G(^MAG(2006.1,SITE,0)),U)
 . . D PMSG^MAGQBUT6("NAME: "_TMP_" "_" IEN: "_EN_" for Imaging division "_SITE)
 . . Q
 . Q
 K ARRAY
 Q
RLOC(LIST,RESULT) ; Delete Network Location file entry
 N DA,DIK,EN,PC,PLACE,APP
 S X="ERR^MAGQBU6A",@^%ZOSF("TRAP")
 S RESULT="1"
 S EN=""  F  S EN=$O(LIST(EN)) Q:EN=""  D
 . F PC=2:1:$L(LIST(EN),U) D
 . . S DA=$P(LIST(EN),U,PC) Q:'DA
 . . S PLACE=$P($G(^MAG(2005.2,DA,0)),U,10)
 . . I '$D(^MAG(2005.2,DA,0)) S RESULT="-1^This is an invalid entry." Q
 . . I $P($G(^MAG(2005.2,DA,0)),U,7)["GRP" Q:'$$GRP(DA,PLACE,.RESULT)
 . . E   I DA=$$CWL^MAGBAPI(PLACE) D  ; Attempt to reset the Current Write location wo an able share within the current group
 . . . N MIN,SPACE,SIZE,IEN,TSPACE,TSIZE,GRP
 . . . S (TSIZE,TSPACE,SPACE,SIZE,IEN,CNT)=0
 . . . S MIN=$$SPARM^MAGQBUT
 . . . S GRP=$$GRP^MAGQBUT(PLACE)
 . . . D FSP^MAGQBUT(MIN,.SPACE,.SIZE,.IEN,.TSPACE,.TSIZE,PLACE,.GRP,DA)
 . . . I IEN>0 D  Q
 . . . . I $$VALRD^MAGQBUT(IEN,PLACE,GRP) D
 . . . . . S APP="Network Location Delete: RAID"
 . . . . . D SCWL^MAGQBUT(IEN,PLACE,GRP,APP,DUZ)
 . . . . . S RESULT="1^The Current Write Location has been reset to: "_IEN
 . . . . . Q
 . . . . E  S RESULT="0^This is invalid share: "_IEN Q
 . . . S RESULT="0^This is the current Write Location and there are no other able members in the current group."
 . . . Q
 . . Q:$P(RESULT,U,1)<1
 . . D GRPEN(DA)
 . . S DIK="^MAG(2005.2,"
 . . D ^DIK
 . . K DIK,DA
 . . Q
 . Q
 Q
 ;
GRP(GRPIEN,PLACE,RESULT) ;
 N GROUP,CWL,APP,RES
 S RES=1
 I GRPIEN=$$GRP^MAGQBUT(PLACE) D  ;Advance RAID Group and reset the Current Write Location
 . S GROUP=$$NXTGP^MAGQBUT(PLACE,GRPIEN)
 . I GROUP=GRPIEN S RESULT="-1^This Network Location is the Current Write Group.",RES=0 Q 
 . S CWL=$O(^MAG(2005.2,GROUP,7,"B",""))
 . I CWL<1 S RESULT="-1^The Current Write Group has no member shares.",RES=0 Q
 . S APP="GRP^MAGQBU6A: Group Delete"
 . D SCWL^MAGQBUT(CWL,PLACE,GROUP,APP,DUZ)
 . Q
 D:RES
 . N INDX
 . S INDX="" F  S INDX=$O(^MAG(2005.2,GRPIEN,7,"B",INDX)) Q:'INDX  D
 . . S $P(^MAG(2005.2,INDX,1),U,8)=""
 . . Q
 . Q
 Q RES
GRPEN(DUPIEN) ;
 ;DUPIEN is the duplicate entry in file 2005.2 being deleted.
 ;This module checks if the duplicate entry is part of a RAID group and
 ;deletes the entry to prevent hanging pointers.
 N DA,DIK,MAGIEN,SITE
 Q:'+$G(DUPIEN)
 S SITE=0 F  S SITE=$O(^MAG(2005.2,"F",SITE)) Q:'SITE  D
 . Q:'$D(^MAG(2005.2,"F",SITE,"GRP"))
 . S MAGIEN=0 F  S MAGIEN=$O(^MAG(2005.2,"F",SITE,"GRP",MAGIEN)) Q:'MAGIEN  D
 . . I $D(^MAG(2005.2,MAGIEN,7,"B",DUPIEN)) D
 . . . N DA,DIK
 . . . S DA=$O(^MAG(2005.2,MAGIEN,7,"B",DUPIEN,0)) Q:'DA
 . . . S DA(1)=MAGIEN,DIK="^MAG(2005.2,"_DA(1)_",7," D ^DIK K DA,DIK
 . . . Q
 . . Q 
 . Q
 Q
RLOCA(RESULT,RLOC) ; Delete Network Location file entry
 ; [RPC:MAGQ DEL NLOC ]
 Q:'$D(^XUSEC("MAG SYSTEM",DUZ))  ; Requires the "MAG SYS" security key
 N LST,RES
 S LST(1)=$P(RLOC,U,2)_U_$P(RLOC,U,2),RES="1"
 D RLOC(.LST,.RES)
 S RESULT=RES
 K LST
 Q 
REQDUP ; Are there duplicate .01 entries? If so rename by adding A,B, etc. 
 N ARRAY,CHAR,CNT,IEN,NAME,NME,NODE,NNAME,MSG,ROUTE,SITE,TYPE
 S NAME="" F  S NAME=$O(^MAG(2005.2,"B",NAME)) Q:NAME=""  D
 . S IEN="",CNT=0 F  S IEN=$O(^MAG(2005.2,"B",NAME,IEN)) Q:'IEN  D
 . . ;GET TYPE ON MAG TYPE WILL BE DUPLICATED.
 . . S NODE=$G(^MAG(2005.2,IEN,0)),TYPE=$P(NODE,"^",7),SITE=$P(NODE,"^",10)
 . . S ROUTE=$P(NODE,"^",9)
 . . ;QUIT IF ROUTER, NOT MAG OR WORM TYPE
 . . Q:ROUTE
 . . Q:NAME["MUSE"
 . . I TYPE["MAG"!(TYPE["WORM") D
 . . . S NME(NAME,SITE)=$G(NME(NAME,SITE))+1
 . . . S ARRAY(NAME,SITE,IEN)=CNT,CNT=CNT+1
 . . . Q
 . . Q
 . Q
 S NAME="" F  S NAME=$O(ARRAY(NAME)) Q:NAME=""  S SITE=0 F  S SITE=$O(ARRAY(NAME,SITE)) Q:'SITE  D
 . Q:+$G(NME(NAME,SITE))'>1
 . S IEN=0 F  S IEN=$O(ARRAY(NAME,SITE,IEN)) Q:'IEN  D
 . . S CHAR=$G(ARRAY(NAME,SITE,IEN)) Q:'CHAR  S CHAR=(63+CHAR)
 . . S NNAME=NAME_$C(CHAR)
 . . Q:'$D(^MAG(2005.2,IEN,0))
 . . N FDA S FDA(2005.2,IEN_",",.01)=NNAME D UPDATE^DIE("U","FDA")
 . . S ^XTMP("MAGP39","^MAG(2005.2,"_IEN_",0)",1)=NNAME_U_NAME
 . . S MSG="Duplicate named Network Location entry, "_NAME_" was renamed to "_NNAME
 . . D PMSG^MAGQBUT6(MSG)
 . . S (CHAR,NNAME)=""
 . . Q
 . Q
 Q
RESTART ;
 ;Controls the purging of this global at the sites.
 ;^XTMP("MAGP39","DUPSHARE",0)=X_"^"_X2_"^"_"Patch 39 Consolidating Network Locations"
 ;contains the list of duplicate shares to be used to remove dangling network entries.
 ;^XTMP("MAGP39","DUPSHARE","ENTRIES",ENTRY,PATH)= Original ien^nn^nn (nn^nn are the duplicate entries).
 ;set in MAGQBUT6 while processing the entries in file 2005 and 2005.1
 ;^XTMP("MAGP39","DUPSHARE","LAST")=Last ien processed in either 2005 or 2005.1
 ;
 N ARRAY,ENTRY,SHAREDIR
 I '$D(^XMTP("MAGP39","DUPSHARE")) W !,"Nothing to process, global does not exist." H 2 Q
 ;rebuild the list
 I '$D(^XMTP("MAGP39","DUPSHARE","ENTRIES")) D  Q
 . W !,"No duplicate shares information available." H 2
 . Q
 S ENTRY=0 F  S ENTRY=$O(^XMTP("MAGP39","DUPSHARE","ENTRIES",ENTRY)) Q:'ENTRY  D
 . S SHAREDIR="" S SHAREDIR=$O(^XMTP("MAGP39","DUPSHARE","ENTRIES",ENTRY,SHAREDIR)) D:SHAREDIR'=""
 . . S ARRAY(SHAREDIR)=$G(^XMTP("MAGP39","DUPSHARE","ENTRIES",ENTRY,SHAREDIR))
 . . Q
 . Q
 S ENTRY=$G(^XTMP("MAGP39","DUPSHARE","LAST")) Q:'ENTRY
 D RSREF^MAGQBUT6(ARRAY,ENTRY)
 Q
PRINT ;Print out the entries in files 2005 and 2005.1 whose fields were modified by the redundant share job
 ;
 I '$D(^XTMP("MAGP39","IMAGEFILE")) W !,"Sorry, the XTMP global has been cleared, nothing to display. Quitting" H 2 Q
 W !,"Image files 2005, 2005.1 & 2006.035 whose network location was reset as a result of redundant network location entries."
 N POP,ZTDESC,ZTRTN,ZTSK
 S %ZIS="QMP" D ^%ZIS K %ZIS I POP Q
 I '$D(IO("Q")) U IO D STARTPRT Q
 ; task job
 S ZTRTN="STARTPRT^MAGQBU6A",ZTDESC="Patch 39 changes to Image files."
 D ^%ZTLOAD
 W !!,$S(+$D(ZTSK):">>> Job has been queued. The task number is "_ZTSK_".",1:">>> Unable to queue this job.") K IO("Q")
 Q
STARTPRT ;
 N ANS,FILE,FIELD,IEN,HEADING,PAGE,STOP,TEXT,ZTREQ
 S ZTREQ="@"  ;TaskMan utilities to delete the task.
 S:'$G(DTIME) DTIME=600
 S PAGE=0,HEADING="Patch 39 changes to Image files 2005,2005.1 and 2006.035"
 D HDR
 S (STOP,FILE)=0
 F  S FILE=$O(^XTMP("MAGP39","IMAGEFILE",FILE)) Q:'FILE!STOP  D 
 . S IEN=0 F  S IEN=$O(^XTMP("MAGP39","IMAGEFILE",FILE,IEN)) Q:'IEN!STOP  D
 . . S FIELD=0 F  S FIELD=$O(^XTMP("MAGP39","IMAGEFILE",FILE,IEN,FIELD)) Q:'FIELD!STOP  D
 . . . S TEXT=$G(^XTMP("MAGP39","IMAGEFILE",FILE,IEN,FIELD)) D LINE
 . . . Q
 . . Q
 . Q
 D ^%ZISC
 Q
HDR ;
 W @IOF S PAGE=PAGE+1
 W !?2,HEADING,"  Page: ",PAGE
 W !,?10,"___________________________________",!
 Q
LINE ;Display output
 D HDR:$Y+4>IOSL
 W !,"File: "_FILE_" entry: "_IEN_" was modified by changing "_TEXT
 I $E(IOST,1,2)["C-",$Y+4>IOSL D
 . W !,"Press RETURN to continue or '^' to exit: "
 . R ANS:DTIME S STOP=$S(ANS="^":1,1:0)
 . Q
 Q
ERR ;
 N ERRXX
 S ERRXX=$$EC^%ZOSV
 D ^%ZTER
 D ^XUSCLEAN
 Q
 ;
