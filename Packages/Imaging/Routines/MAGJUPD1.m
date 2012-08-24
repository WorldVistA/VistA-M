MAGJUPD1 ;WOIFO/JHC - VistARad Update Exam Status ; 9 Sep 2011  4:05 PM
 ;;3.0;IMAGING;**16,22,18,76,101,120**;Mar 19, 2002;Build 27;May 23, 2012
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
 ; Subroutines for RPC's to update Exam Status to "Interpreted", and
 ;   for "Closing" a case that is open on the DX Workstation
 ;
ERR N ERR S ERR=$$EC^%ZOSV S @MAGGRY@(0)="0^Server Program Error: "_ERR
 D @^%ZOSF("ERRTN")
 Q:$Q 1  Q
 ;
STATUS(MAGGRY,PARAMS,DATA) ; rpc: MAGJ RADSTATUSUPDATE
 ; Update Exam Status to "Interpreted" and/or Close the exam
 ; Only updates the Status if the current value is "Examined"
 ; This routine defines variables needed for calling the Radiology
 ; package routine UP1^RAUTL1, for filing Status updates
 ;
 ; PARAMS = UPDFLAG ^ RADFN ^ RADTI ^ RACNI ^ RARPT ^ UPDPSKEY
 ;   UPDFLAG = 1/0 -- 1 to perform update; else no update made
 ;   RARPT = ptr to Rad Exam Report file
 ;   RADFN,RADTI,RACNI = pointers to Rad Patient File for the exam
 ;   UPDPSKEY = 1/0 -- 1 to update Presentation State &/or Key Image data
 ;                   = 2 -- update PS data with NO lock in place--Resident workflow, or Sec Key Override
 ;   DATA = optional array containing prezentation state data; see SAVKPS^MAGJUPD2 for description
 ;   MAGGRY = return results in @MAGGRY
 ;
 N $ETRAP,$ESTACK S $ETRAP="D ERR^MAGJUPD1"
 N RARPT,RADFN,RADTI,RACNI,RAEXT,RACNE,RADTE,RAINT,RAMDV,DIQUIET
 N RAONLINE,ZTQUEUED,RAOR,RASN,RASTI,RAPRTSET,LOGDATA,RSL,TIMESTMP
 N UPDPSKEY,MAGRET,MAGLST,REPLY,UPDFLAG,RADATA,RIST,MAGPSET,RACNILST,ACNLST
 N PSETLST
 S MAGLST="MAGJUPDATE"
 K MAGGRY S MAGGRY=$NA(^TMP($J,MAGLST)) K @MAGGRY  ; assign MAGGRY value
 S DIQUIET=1 D DT^DICRW
 S TIMESTMP=$$NOW^XLFDT()
 S UPDFLAG=$P(PARAMS,U),RADFN=$P(PARAMS,U,2),RADTI=$P(PARAMS,U,3),RACNI=$P(PARAMS,U,4),RARPT=$P(PARAMS,U,5),UPDPSKEY=+$P(PARAMS,U,6)
 S REPLY="0^4~Closing case with"_$S(UPDFLAG:"",1:" NO")_" Status Update"
 S RAPRTSET=0
 I RADFN,RADTI,RACNI
 E  S REPLY="0^4~Request Contains Invalid Case Pointer ("_RARPT_")" G STATUSZ
 D GETEXAM2^MAGJUTL1(RADFN,RADTI,RACNI,0,.MAGRET)
 I 'MAGRET S REPLY="0^4~Current Case Not Accessible for Updating" G STATUSZ
 ; 1  RADFN   RADTI    RACNI   RANME   RASSN    <--Contents of RADATA,
 ; 6  RADATE  RADTE    RACN    RAPRC   RARPT         from GETEXAM
 ;11  RAST    DAYCASE  RAELOC  RASTP   RASTORD
 ;16  RADTPRT
 S RADATA=$G(^TMP($J,"MAGRAEX",1,1))
 S RAEXT=$P(RADATA,U,12),RACNE=$P(RAEXT,"-",2),RADTE=$P(RADATA,U,7)
 S RAINT=RADTI_"-"_RACNI
 I UPDPSKEY=2 D  G STATUSZ ; P101 update annotations only, if authorized (Resident workflow, or Sec Key Override)
 . I +MAGJOB("USER",1),'UPDFLAG,($D(DATA)>9) S REPLY="0^1~Case #"_RAEXT_" Closed; No Status Update; annotation updates performed."
 . E  S UPDPSKEY=0,REPLY="0^4~Invalid request to update annotations for Case #"_RAEXT_"."
 D CLOSE(.RSL,RADFN_U_RADTI_U_RACNI_U_U_1,.LOGDATA) ; unlock the case
 ; proceed only if case was locked by this user
 ;   if it was not Locked, then do NOT update PS, Key Images
 I 'RSL S REPLY=RSL,UPDPSKEY=0 G STATUSZ
 I 'UPDFLAG S REPLY="0^1~Case #"_RAEXT_" Closed; No Status Update performed" G STATUSZ
 S RIST=$P(RSL,U,2) ; CLOSE reports back the type of radiologist
 ; now we know this user had locked the case, & wants to do Status update
 D EN2^RAUTL20(.MAGPSET)  ; get info re rad PrintSet
 ; Note--above call also sets variable RAPRTSET
 ;
 ; IF exam is not "Examined", and not "Cancelled" and past "Waiting"
 ;    then assume it has already been updated via another pathway,
 ;    either as printset member (via code below--see PRTSET note...),
 ;    or from a voice-dictation or terminal session by the radiologist
 ;    For these cases, no warning msg is sent
 ; Else, update not allowed, so give warning msg
 ; Note that when the Exam was OPENed, it must have had status "Examined"
 I '$D(^RA(72,"AVC","E",$P(RADATA,U,11))) D  G STATUSX:(+$P(REPLY,U,2)=1),STATUSZ  ; Current Status MUST be "Examined" Category
 . I $P(RADATA,U,15)>2 D  ; assume update has otherwise been done, eg voice dictation or manual entry in Vista
 . . S RACNILST=RACNI,RASTI=$P(RADATA,U,11) ; need for code at tag statusx
 . . I RAPRTSET S REPLY="0^1~Printset Exams with Case #"_RAEXT_" have been updated"
 . . E  S REPLY="0^1~No Update done for Case #"_RAEXT_"--current status is "_$P(RADATA,U,14)
 . E  S REPLY="0^3~No Update Allowed for Case #"_RAEXT_"--current status is "_$P(RADATA,U,14)
 ;
 ; now ready to update exam status
 S RAMDV=$P(^RADPT(RADFN,"DT",RADTI,0),U,3)
 S RAMDV=$TR(^RA(79,RAMDV,.1),"YyNn","1100")
 ;
 ; Update interpreting radiologist field in Rad file
 I RIST D  I RACNILST="" G STATUSZ
 . N SAVRACNI,RTN S RACNILST=""
 . ; PRTSET note: if exam is part of Rad Print-Set, then update all exams of printset
 . I RAPRTSET D
 . . S ACNLST="",SAVRACNI=RACNI,X=0
 . . F I=0:1 S X=$O(MAGPSET(X)) Q:'X  S RACNILST=RACNILST_$S(I:U,1:"")_X S:RACNE'=+MAGPSET(X) ACNLST=ACNLST_", "_"-"_+MAGPSET(X)
 . E  S RACNILST=RACNI
 . F I=1:1:$L(RACNILST,U) S RACNI=$P(RACNILST,U,I) I RACNI D  I RACNILST="" Q
 . . S DA(2)=RADFN,DA(1)=RADTI,DA=RACNI
 . . D STUFPHY^RARIC1(DUZ,RIST,.RTN)
 . . I 'RTN S REPLY="0^4~Unable to update Interpreting Radiologist: "_RTN_"." S RACNILST=""
 . I RAPRTSET S RACNI=SAVRACNI
 S RAONLINE=1,ZTQUEUED=1 D UP1^RAUTL1   ; Suppress msgs, do Status update
 ;<*> K RAONLINE,ZTQUEUED D UP1^RAUTL1 ; <*> Testing Only: ENABLE msgs
 I RAOR<0 S REPLY="0^3~Exam Status for Case #"_RAEXT_" CANNOT be updated; current status remains: "_$S($G(RASN)]"":RASN,1:"Unknown")
 I  G STATUSZ
 ;
 S REPLY="0^1~For Case #"_$S($G(ACNLST)]"":"s ",1:"")_RAEXT_$S(RAPRTSET:ACNLST,1:"")_", Exam Status updated to "_RASN
 ;
STATUSX ; Newly Interpreted exam:
 ; Log the Interpreted event; Printset logging includes all printset members
 S PSETLST=""
 I RAPRTSET S X="" D
 . F I=0:1 S X=$O(MAGPSET(X)) Q:'X  S PSETLST=PSETLST_$S(I:U,1:"")_+MAGPSET(X)
 D LOG^MAGJUTL3("VR-INT",LOGDATA,PSETLST)
 ; Update Recent Exams List
 G STATUSZ:'$P(^MAG(2006.69,1,0),U,8)  ; no bkgnd compile enabled
 L +^XTMP("MAGJ2","RECENT"):5
 E  G STATUSZ
 N INDX F I=1:1:$L(RACNILST,U) S RACNI=$P(RACNILST,U,I) I RACNI D
 . S INDX=+$G(^XTMP("MAGJ2","RECENT",0))+1,$P(^(0),U)=INDX,^(INDX)=RADFN_U_RADTI_U_RACNI_U_RASTI
 L -^XTMP("MAGJ2","RECENT")
STATUSZ ;
 ; store PS, Key Image data
 I UPDPSKEY,($D(DATA)>9) D
 . D SAVKPS^MAGJUPD2(RARPT,UPDPSKEY,.DATA,.X)
 . S REPLY=REPLY_$P(X,"~",2,99)
 S @MAGGRY@(0)=REPLY
 K ^TMP($J,"MAGRAEX"),^("RAE1")
 Q
 ;
CLOSE(RSL,PARAMS,LOGDATA) ; Close/unlock a case
 ; Input: PARAMS = DFN ^ DTI ^ CNI ^ RPT ^ UPDFLAG
 ;
 ;  DFN,DTI,CNI,RPT = pointers to Rad File for the exam
 ;   UPDFLAG = 1/0 -- 1 indicates CLOSE was called from subroutine
 ;                    STATUS, above (which has already called GETEXAM)
 ;    RSL = return result of the Close
 ; This subroutine may be called directly (to close a case without
 ; doing a status update), or is called from tag STATUS, above, when
 ; also doing a status update
 ;
 N $ETRAP,$ESTACK S $ETRAP="D ERR^MAGJUPD1"
 N RPT,DFN,DTI,CNI,MAGRET,REPLY,RARPT,UPDFLAG,RIST,DAYCASE,NLOCKS,MYLOCK
 S DFN=$P(PARAMS,U),DTI=$P(PARAMS,U,2),CNI=$P(PARAMS,U,3),RPT=$P(PARAMS,U,4),UPDFLAG=$P(PARAMS,U,5)
 S LOGDATA=""
 I $P($G(^MAG(2006.69,1,0)),U,4)
 E  S REPLY=$S(UPDFLAG:"0^3~Updates not allowed at this site--no action taken",1:"") G CLOSEZ   ;   Status Update NOT Enabled
 S RIST=+MAGJOB("USER",1) I RIST
 E  S REPLY=$S(UPDFLAG:"0^3~Update allowed only by a radiologist--no action taken",1:"") G CLOSEZ  ; need only unlock a radiologist
 I DFN,DTI,CNI
 E  S REPLY="0^4~Request Contains Invalid Case Pointer ("_RPT_")--no action taken" G CLOSEZ
 ;
 I 'UPDFLAG N RADATA D  I 'MAGRET G CLOSEZ
 . D GETEXAM2^MAGJUTL1(DFN,DTI,CNI,0,.MAGRET)
 . I 'MAGRET S REPLY="0^4~No Current Case accessible to close--no action taken"
 . E  S RADATA=$G(^TMP($J,"MAGRAEX",1,1))
 S RARPT=$P(RADATA,U,10),DAYCASE=$P(RADATA,U,12)
 I RARPT,DAYCASE
 E  S REPLY="0^4~Current Case not accessible to close--no action taken" G CLOSEZ
 ;
 D LOCKACT^MAGJEX1A(RARPT,DAYCASE,101,,.MYLOCK)
 S LOGDATA=$P(MYLOCK(1),"|",2)
 I 'MYLOCK(1) S X=$P(MYLOCK(1),U,4) D  S LOGDATA="" G CLOSEZ
 . I UPDFLAG S REPLY="0^1~Case #"_DAYCASE_$S(X]"":" locked by "_X,1:" not locked by "_$P(MAGJOB("USER",1),U,2))_"--No Status update performed"
 . E  S REPLY="0^1~ "  ; case wasn't opened by this R'ist; nothing to do
 ;
 I UPDFLAG S REPLY=1_U_RIST
 E  S REPLY="0^1~Case #"_DAYCASE_$S(+MYLOCK(1):" unlocked",+MYLOCK(2):" reserve cancelled",1:" closed")_"--No Status Update performed."
CLOSEZ S RSL=REPLY
 Q
 ;
END Q  ;
