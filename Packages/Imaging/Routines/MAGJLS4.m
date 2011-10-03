MAGJLS4 ;WIRMFO/JHC VistARad RPCs--History List ; 29 Jul 2003  10:00 AM
 ;;3.0;IMAGING;**18,76,101**;Nov 06, 2009;Build 50
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; | Use of unreleased versions of this software requires the user |
 ;; | to execute a written test agreement with the VistA Imaging    |
 ;; | Development Office of the Department of Veterans Affairs,     |
 ;; | telephone (301) 734-0100.                                     |
 ;; |                                                               |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a medical device.  As such, it may not be changed in any way. |
 ;; | Modifications to this software may result in an adulterated   |
 ;; | medical device under 21CFR820, the use of which is considered |
 ;; | to be a violation of US Federal Statutes.                     |
 ;; +---------------------------------------------------------------+
 ;;
 Q
ERR N ERR S ERR=$$EC^%ZOSV S ^TMP($J,"RET",0)="0^4~"_ERR
 S MAGGRY=$NA(^TMP($J,"RET"))
 D @^%ZOSF("ERRTN")
 Q:$Q 1  Q
 ;
 ; Subroutines for Vistarad History List functions
 ; Entry Points:
 ;   HIST -- All History List rpcs go here
 ;
HIST(MAGGRY,PARAMS,DATA) ; History List RPC: MAGJ HISTORYLIST
 ; PARAMS--TXID ^ TXDUZ ^ TXDIV
 ; TXID: Required; designates action to take; see below
 ; TXDUZ: Optional; if supplied, get data for another user (Read Only)
 ; TXDIV: Optional; if supplied, get data for another division (Read Only)
 ;   Note: for now, TXDIV is forced to the Logon Division
 ; DATA--(optional) array of input data; depends on TXID; see subroutines by TXID
 ;
 N $ETRAP,$ESTACK S $ETRAP="D ERR^MAGJLS4"
 N TXID,TXDUZ,TXDIV,UPDATEOK,DIQUIET,REPLY
 K ^TMP($J,"RET")
 S TXID=+PARAMS,TXDUZ=+$P(PARAMS,U,2),TXDIV=+$P(PARAMS,U,3)
 I 'TXDUZ S TXDUZ=DUZ
 S UPDATEOK=TXDUZ=DUZ
 S TXDIV=DUZ(2) ; Force to Logon Division for now
 S REPLY="0^1~Performing History List operation."
 I 'TXID!'("1,2,3"[TXID) S REPLY="0^4~Invalid History List operation requested." G HISTZ
 I '$D(DATA)&(TXID=1!TXID=3) S REPLY="0^4~No data supplied for History List update/delete." G HISTZ
 I 'UPDATEOK&("1,3"[TXID) S REPLY="0^4~The current History List may not be updated by the current user." G HISTZ
 S DIQUIET=1 D DT^DICRW
 I TXID=1 D HISTADD(.DATA,TXDUZ,TXDIV) G HISTZ
 I TXID=2 D HISTUPD(TXDUZ,TXDIV) D HISTGET(TXDUZ,TXDIV) G HISTZ
 I TXID=3 D HISTDEL(.DATA,TXDUZ,TXDIV) G HISTZ
 ; I TXID=4 D HISTUPD(TXDUZ,TXDIV) G HISTZ ; for now, do this function with txid 2
HISTZ ;
 I 'REPLY S MAGGRY=$NA(^TMP($J,"RET")),@MAGGRY@(0)=REPLY
 E  ; maggry otherwise has been set by called subroutine
 Q
 ;
HISTADD(DATA,TXDUZ,TXDIV) ; add records
 N IDATA,ILOOP,CT,NOGO,EXID,HISDAT,HISTIEN,MAGRACNT,TS
 S IDATA="",CT=0,NOGO=0
 F ILOOP=0:1 S IDATA=$O(DATA(IDATA)) Q:IDATA=""  D
 . S EXID=$P(DATA(IDATA),"|"),HISDAT=$P(DATA(IDATA),"|",2)
 . F I=1:1:4 I '+$P(EXID,U,I) S NOGO=1 Q
 . I NOGO Q
 . L +^XTMP("MAGJ2","HISTORY",TXDUZ,TXDIV):2
 . E  Q
 . S X=$G(^XTMP("MAGJ2","HISTORY",TXDUZ,TXDIV,0)),HISTIEN=+$P(X,U)+1,$P(^(0),U)=HISTIEN
 . L -^XTMP("MAGJ2","HISTORY",TXDUZ,TXDIV)
 . S ^XTMP("MAGJ2","HISTORY",TXDUZ,TXDIV,0,"ADD",HISTIEN)="|"_EXID_"|"_HISTIEN_U_HISDAT_"|"
 . S CT=CT+1
 I 'CT S REPLY="0^3~"_$S(ILOOP:"Unable to add records",1:"No records to add")_" to History List." Q
 S MAGRACNT=0 D ACTIVE^MAGJLS2(.MAGGRY,9996)
 S X=@MAGGRY@(0),X=+X_U_"1~"_$$HISTTL(TXDUZ,TXDIV),@MAGGRY@(0)=X
 S TS="" F I=2,0 S TS=TS_$S(TS="":"",1:U)_$$HTFM^XLFDT($H+I,0)
 S ^XTMP("MAGJ2",0)=TS_U_"VistaRad List Compile"
 S REPLY=1
 Q
 ;
HISTTL(TXDUZ,TXDIV) ;  Build list title string
 N LSTTL
 S LSTTL="HISTORY LIST for "_$$USERINF^MAGJUTL3(TXDUZ,.01)_" at "_"Station #"_$$STATN^MAGJEX1(TXDIV)
 S LSTTL=LSTTL_"|"_TXDUZ ; provide report's DUZ to client
 Q LSTTL
 ;
HISTGET(TXDUZ,TXDIV) ; Get full History List for input user for division txdiv
 N MAGLST,LSTTL,LSTID,MAGLST
 S TXDUZ=$G(TXDUZ,DUZ)
 S TXDIV=$G(TXDIV,DUZ(2))
 D PARAMS^MAGJLS2B(9996)
 I 'LSTID S REPLY="0^4~Problem with History List Compile." Q
 S LSTTL=$$HISTTL(TXDUZ,DUZ(2))
 S X=$O(^XTMP("MAGJ2","HISTORY",TXDUZ,TXDIV,0))
 I 'X S REPLY="0^1~No exams found for: "_LSTTL Q
 S MAGLST=$NA(^XTMP("MAGJ2","HISTORY",TXDUZ,TXDIV))
 D LSTOUT^MAGJLS2B(.MAGGRY,LSTID,MAGLST)
 S REPLY=1
 Q
 ;
HISTDEL(DATA,TXDUZ,TXDIV) ; delete records
 N IDATA,CT,HISTIEN,ALLDONE,LAST
 S IDATA="",CT=0,ALLDONE=0
 L +^XTMP("MAGJ2","HISTORY",TXDUZ,TXDIV):2
 E  S REPLY="0^2~Unable to access HISTORY File for deleting records; try again later." Q
 S MAGGRY=$NA(^TMP($J,"RET"))
 F  S IDATA=$O(DATA(IDATA)) Q:IDATA=""!ALLDONE  D
 . S HISTIEN=$P(DATA(IDATA),U)
 . I HISTIEN,$D(^XTMP("MAGJ2","HISTORY",TXDUZ,TXDIV,HISTIEN)) K ^(HISTIEN) S CT=CT+1,@MAGGRY@(CT)=HISTIEN Q
 . E  I HISTIEN="ALL" S HISTIEN=0 D  S ALLDONE=1
 . . F  S HISTIEN=$O(^XTMP("MAGJ2","HISTORY",TXDUZ,TXDIV,HISTIEN)) Q:'HISTIEN  K ^(HISTIEN) S CT=CT+1,@MAGGRY@(CT)=HISTIEN
 I '$D(^XTMP("MAGJ2","HISTORY",TXDUZ,TXDIV,0,"ADD")) S X=$O(^XTMP("MAGJ2","HISTORY",TXDUZ,TXDIV,""),-1),^(0)=X_U_X
 L -^XTMP("MAGJ2","HISTORY",TXDUZ,TXDIV)
 I 'CT S REPLY="0^3~No HISTORY List records found to delete."
 E  S REPLY=CT_"^1~"_CT_" HISTORY List records deleted."
 S @MAGGRY@(0)=REPLY
 S REPLY=1
 Q
 ;
HISTUPD(TXDUZ,TXDIV) ; Update selected fields in History List
 N LSTTL,CT,NOHIT,RAST,STATUS,REMOTE,RIST1,RIST2,RIST,RISTISME
 N EXID,HISTIEN,RARPT,RADFN,RADTI,RACNI,XX1,XX2,T,X,DELETED,HDATE
 S CT=0,NOHIT=0
 S TXDUZ=$G(TXDUZ,DUZ)
 S TXDIV=$G(TXDIV,DUZ(2))
 S LSTTL=$$HISTTL(TXDUZ,DUZ(2))
 S X=$O(^XTMP("MAGJ2","HISTORY",TXDUZ,TXDIV,0))
 I 'X S REPLY="0^1~No exams found for: "_LSTTL Q
 L +^XTMP("MAGJ2","HISTORY",TXDUZ,TXDIV):2
 E  S REPLY="0^2~Unable to access HISTORY File for updating records; try again later." Q
 S HISTIEN=0
 F  S HISTIEN=$O(^XTMP("MAGJ2","HISTORY",TXDUZ,TXDIV,HISTIEN)) Q:'HISTIEN  S XX1=$G(^(HISTIEN,1)),XX2=$G(^(2)) D
 . S EXID=$P(XX2,"|",2),RARPT=+$P(EXID,U,4),RADFN=+$P(EXID,U),RADTI=+$P(EXID,U,2),RACNI=+$P(EXID,U,3)
 . ; <*> Below is for phase 1 Alpha, til have final user setting for this <*> to be removed
 . ; Age limit parameter to be passed in with txid 2 rpc call; setting is on client <*>
 . S HDATE=$P(XX2,U,13) D  Q:DELETED
 . . S DELETED=0,HDATE=$P(HDATE,"@")
 . . S X=HDATE,%DT="" D ^%DT K %DT
 . . I $$FMTH^XLFDT(Y,1)<($H-3) K ^XTMP("MAGJ2","HISTORY",TXDUZ,TXDIV,HISTIEN) S DELETED=1 Q
 . ; <*> End of temp change
 . I RARPT,RADFN,RADTI,RACNI
 . E  S NOHIT=NOHIT+1 Q
 . D IMGINFO^MAGJUTL2(RARPT,.X) S REMOTE=$P(X,U,4)
 . S X=$G(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0))
 . I X="" Q  ; rad exam deleted
 . S RAST=$P(X,U,3),RIST1=$P(X,U,12),RIST2=$P(X,U,15)
 . S STATUS=$S(RAST:$P(^RA(72,RAST,0),U),1:"")
 . S (RIST,RISTISME)=""
 . I RIST1!RIST2 S X=$$RIST^MAGJUTL1(RIST1,RIST2),RIST=$P(X,U),RISTISME=$P(X,U,2)
 . S RISTISME=$$RISTISME^MAGJLS2B(RISTISME)
 . S $P(XX1,U,16)=RAST,$P(XX1,U,8)=STATUS,$P(XX1,U,12)=REMOTE
 . S T=$P(XX2,"|"),$P(T,U,3)=RIST,$P(T,U,7)=RISTISME,$P(XX2,"|")=T
 . S ^XTMP("MAGJ2","HISTORY",TXDUZ,TXDIV,HISTIEN,1)=XX1,^(2)=XX2
 . S CT=CT+1
 S X=$O(^XTMP("MAGJ2","HISTORY",TXDUZ,TXDIV,""),-1),^(0)=X_U_X ; <*> for phase 1 alpha only?
 L -^XTMP("MAGJ2","HISTORY",TXDUZ,TXDIV)
 S REPLY="0^1~HISTORY File records updated." Q
 Q
 ;
END Q  ; 
