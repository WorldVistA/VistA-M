MAGJEX1A ;WIRMFO/JHC - VistARad RPCs, exam locking ; 9 Sep 2011  4:05 PM
 ;;3.0;IMAGING;**18,65,101,120**;Mar 19, 2002;Build 27;May 23, 2012
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
 ; Entry Points:
 ;   CASLOCK--RPC: Lock mgt
 ;   LOCKACT--Subrtn
 ;   LOCKOUT--Subrtn
 ;
ERR N ERR S ERR=$$EC^%ZOSV S @MAGGRY@(0)="0^4~"_ERR
 D @^%ZOSF("ERRTN")
 Q:$Q 1  Q
 ;
CASLOCK(MAGGRY,DATA) ; RPC Call: MAGJ RADCASELOCKS
 ; MAGGRY holds $NA reference to ^TMP for rpc reply; all ref's to MAGGRY use ss indirection
 ; input in DATA: OPEN_FLAG^RADFN^RADTI^RACNI^RARPT
 ; OPEN_FLAG = 3: Reserve-to-Lock; 4: Lock-to-Reserve; 5: Lock/Take
 ; RADFN^, etc--exam id
 ;
 N $ETRAP,$ESTACK S $ETRAP="D ERR^MAGJEX1A"
 N RARPT,RADFN,RADTI,RACNI,DIQUIET,CURCASE,REPLY,CT,DATAOUT,MAGLST,XX
 N DAYCASE,LOCKED,RACN,RADTE,MAGS,LOGDATA,RESULT,MYLOCK,GOTLOCK,LONGACN
 S DIQUIET=1 D DT^DICRW
 S CT=0,DATAOUT=0,DAYCASE="",MAGLST="MAGJCASELOCK"
 K MAGGRY S MAGGRY=$NA(^TMP($J,MAGLST)) K @MAGGRY  ; assign MAGGRY
 S CURCASE=+$P(DATA,U)
 S RADFN=$P(DATA,U,2),RADTI=$P(DATA,U,3),RACNI=$P(DATA,U,4),RARPT=+$P(DATA,U,5)
 I "^3^4^5^"[(U_CURCASE_U)
 E  S REPLY="4~Invalid Caselock request ("_DATA_")." G CASLOCKZ
 I RADFN,RADTI,RACNI,RARPT
 E  S REPLY="4~Caselock Request contains invalid Case Pointer ("_DATA_")." G CASLOCKZ
 S XX=$G(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0))
 S RACN=$P(XX,U),LONGACN=$P(XX,U,31)
 S RADTE=9999999.9999-RADTI
 S DAYCASE=$E(RADTE,4,7)_$E(RADTE,2,3)_"-"_RACN
 I LONGACN]"" S DAYCASE=LONGACN
 S X=$P(XX,U,3)
 I '$D(^RA(72,"AVC","E",X)) D  G CASLOCKZ
 . N STS S STS=X
 . D LOCKACT(RARPT,DAYCASE,100,.RESULT) ; between reserve and now, exam may have been Taken & Updated
 . I +RESULT(1)!+RESULT(2) D LOCKACT(RARPT,DAYCASE,101,.RESULT) ; so, cancel any lock/reserve
 . S REPLY="5~For Case #"_DAYCASE_", current Status is "_$P(^RA(72,STS,0),U)_"; Reserve/Lock change NOT allowed."
 D LOCKACT(RARPT,DAYCASE,CURCASE,.RESULT,.REPLY)
 S GOTLOCK=+RESULT
 D LOCKACT(RARPT,DAYCASE,100,.MYLOCK)
 I GOTLOCK&+MYLOCK(1)&(CURCASE=3!(CURCASE=5)) D  ; update Image access log if got the lock
 . S LOGDATA=$P(MYLOCK(2),"|",2)  ; was saved when the Reserve occurred
 . I CURCASE=5 S $P(LOGDATA,U,4)=+MAGJOB("REMOTE") ; update "remote" indicator if was TAKEN
 . D LOG^MAGJUTL3("VR-VW",LOGDATA,$$PSETLST^MAGJEX1(RADFN,RADTI,RACNI))
 . S $P(^XTMP("MAGJ","LOCK",RARPT,1,DAYCASE),"|",2)=LOGDATA  ; save for Interp event
 S DATAOUT=$S(+MYLOCK(1):1,+MYLOCK(2):2,1:0)
 ;
CASLOCKZ ;
 S @MAGGRY@(0)=CT_U_REPLY_"|"_RADFN_U_RADTI_U_RACNI_U_RARPT_"||"_DATAOUT
 Q
 ;
PNAM(X) ; return pt name for input DFN
 I X S X=$G(^DPT(+X,0)) I X]"" S X=$P(X,U)
 E  S X="UNKNOWN"
 Q X
 ;
LOCKACT(RARPT,DAYCASE,REQUEST,RESULT,ACTREPLY,LOGDATA) ; determine if desired lock action is feasible
 ; Input: RARPT, DAYCASE, REQUEST, LOGDATA
 ;   REQUESTed Action:
 ;     1-Lock; 2-Reserve; 3-ResToLock; 4-LockToRes; 5-TakeLock; 100-Status; 101-UNLOCK
 ;     Note: 100 & 101 are special for internal use only
 ;   LOGDATA--pass through for Image Access Log
 ; Output: RESULT, ACTREPLY
 ;  RESULT: ACTION "allowed" = LOCK^RESERVE^ResToInt^IntToRes^Take^_"|"_ImgLst
 ;    these are truth values; Imglst true =~ return Image File list to client
 ;  RESULT is ultimately used at tag LOCKOUT
 ;  ACTREPLY --reply message for client logic/display
 ;
 N ACTION,LOCKLEV,MYLOCK
 K RESULT S ACTION="",ACTREPLY="",RESULT="" S LOGDATA=$G(LOGDATA,"")
 I '$P($G(^MAG(2006.69,1,0)),U,4) Q  ;  Status Updates not enabled
 I REQUEST=100 D LOCKIN^MAGJEX1B(RARPT,.LOCKLEV,.RESULT,"STATUS") G LOCKACTZ ; Lock Status check only
 S ACTION="0^0^0^0^0|0"
 D LOCKIN^MAGJEX1B(RARPT,.LOCKLEV,.MYLOCK)
 I REQUEST=101 D  G LOCKACT1 ; Unlock exam
 . M ACTREPLY=MYLOCK ; internal use by MAGJUPD1
 I 'LOCKLEV D  G LOCKACT1
 . I REQUEST=1!(REQUEST=2) S $P(ACTION,"|",2)=1,ACTREPLY="5~Exam #"_DAYCASE_" is Locked by "_$P(MYLOCK(1),U,4)_"."  ; View/Cancel
 . E  S ACTREPLY="3~Invalid exam lock request ("_REQUEST_")--#0"
 I LOCKLEV=3 D  ; Is or Can be Reserved or Interp by me
 . I MYLOCK(1) D  Q  ; Already Locked/TAKEN by me
 . . I REQUEST=1 D  Q
 . . . I MAGJOB("P32") S $P(ACTION,U)=1,$P(ACTION,U,2)=1,$P(ACTION,"|",2)=1,ACTREPLY="1~#"_DAYCASE_" ("_$$PNAM(RADFN)_") locked for update by "_$P(MAGJOB("USER",1),U,3)
 . . . E  S $P(ACTION,U,1)=1,$P(ACTION,U,2)=+MYLOCK(2),ACTREPLY="1~Exam #"_$P(MYLOCK(1),U,6)_" already open/locked--no action taken"
 . . I REQUEST=4 D  Q  ;  Remove Lock, keep Reserve
 . . . S $P(ACTION,U,2)=1,$P(ACTION,U,4)=1,ACTREPLY="1~Exam unlocked, reserved"
 . . E  S $P(ACTION,U,1)=1,$P(ACTION,U,2)=+MYLOCK(2),ACTREPLY="3~Invalid exam lock request ("_REQUEST_")--#1"
 . E  I MYLOCK(2) D  Q  ; Already Reserved by me
 . . I REQUEST=3 S $P(ACTION,U)=1,$P(ACTION,U,2)=1,$P(ACTION,U,3)=1,ACTREPLY="1~#"_DAYCASE_" ("_$$PNAM(RADFN)_") locked for update (from reserve) by "_$P(MAGJOB("USER",1),U,3)
 . . E  I REQUEST=2 S $P(ACTION,U,2)=1,ACTREPLY="1~Exam #"_$P(MYLOCK(2),U,6)_" already reserved--no action taken."
 . . E  S $P(ACTION,U,2)=1,ACTREPLY="3~Invalid exam lock request ("_REQUEST_")--#2"
 . E  D  ; Available
 . . I REQUEST=1 S $P(ACTION,U)=1,$P(ACTION,U,2)=1,$P(ACTION,"|",2)=1,ACTREPLY="1~#"_DAYCASE_" ("_$$PNAM(RADFN)_") locked for update by "_$P(MAGJOB("USER",1),U,3)
 . . E  I REQUEST=2 S $P(ACTION,U,2)=1,$P(ACTION,"|",2)=1,ACTREPLY="1~Exam #"_DAYCASE_" reserved."
 . . E  S ACTREPLY="3~Invalid exam lock request ("_REQUEST_")--#3"
 E  I LOCKLEV=1 D  ; Reserved by other (I can Take, Except View/Take/Cancel)
 . I MYLOCK(1) D  Q
 . . I REQUEST=1 D  Q
 . . . I MAGJOB("P32") S $P(ACTION,U)=1,$P(ACTION,"|",2)=1,ACTREPLY="1~#"_DAYCASE_" ("_$$PNAM(RADFN)_") locked for update by "_$P(MAGJOB("USER",1),U,3) ; should be impossible
 . . . E  S $P(ACTION,U)=1,ACTREPLY="1~Exam #"_$P(MYLOCK(1),U,6)_" already locked; no action taken."
 . . E  I REQUEST=2 S $P(ACTION,U,1)=1,ACTREPLY="1~Exam #"_$P(MYLOCK(1),U,6)_" already locked; no action taken."
 . . ; <*> next line Unlocks ME, and preserves Other User's Reserve
 . . E  I REQUEST=4 S $P(ACTION,U,4)=1,ACTREPLY="1~Exam unlocked; reserved by "_$P(MYLOCK(2),U,4)_"."
 . . E  S $P(ACTION,U)=1,ACTREPLY="3~Invalid exam lock request ("_REQUEST_")--#5; Lock retained." ; preserve lock
 . I 'MYLOCK D  Q
 . . I REQUEST=1 D  Q
 . . . I MAGJOB("P32") S $P(ACTION,"|",2)=1,ACTREPLY="5~Case #"_DAYCASE_" is Reserved by "_$P(MYLOCK(2),U,4)_"."
 . . . E  S $P(ACTION,"|",2)=1,ACTREPLY="8~Case #"_DAYCASE_" is Reserved by "_$P(MYLOCK(2),U,4)_"."    ; #8=View/Take/Cancel"
 . . E  I REQUEST=2 S $P(ACTION,"|",2)=1,ACTREPLY="5~Case #"_DAYCASE_" is Reserved by "_$P(MYLOCK(2),U,4)_"."
 . . E  I REQUEST=5  S $P(ACTION,U)=1,$P(ACTION,U,5)=1,ACTREPLY="1~#"_DAYCASE_" ("_$$PNAM(RADFN)_") taken/locked for update by "_$P(MAGJOB("USER",1),U,3)
 . . E  S ACTREPLY="3~Invalid exam lock request ("_REQUEST_")--#6"
 E  I LOCKLEV=2 D  ; Locked by another
 . I MYLOCK(2) D  Q
 . . S $P(ACTION,U,3)=1,ACTREPLY="5~Case #"_DAYCASE_" is Locked (taken) by "_$P(MYLOCK(1),U,4)_"; reserve cancelled." ; View/Cancel"
 . I 'MYLOCK D  Q
 . . I REQUEST=1!(REQUEST=2) S $P(ACTION,"|",2)=1,ACTREPLY="5~Case #"_DAYCASE_" is Locked by "_$P(MYLOCK(1),U,4)_"."  ; View/Cancel"
 . . E  S ACTREPLY="3~Invalid exam lock request ("_REQUEST_")--#8"
 ;
LOCKACT1 D LOCKOUT(RARPT,DAYCASE,LOCKLEV,.MYLOCK,ACTION,.RESULT,LOGDATA)
 ;
LOCKACTZ Q
 ;
 ;
LOCKOUT(RARPT,DAYCASE,LOCKLEV,MYLOCK,ACTION,RESULT,LOGDATA) ; Record Locks and Clear Locks, as required
 ; Precursors are logic and data from tags LOCKIN^magjex1b and LOCKACT
 S RESULT="" S LOGDATA=$G(LOGDATA,"")
 Q:'LOCKLEV  ; nothing to do
 N ILOCK
 F ILOCK=1,2 D  ; 1:Lock  2:Reserve
 . I ILOCK=1&(LOCKLEV=1!(LOCKLEV=3))
 . E  I ILOCK=2&(LOCKLEV=2!(LOCKLEV=3))
 . E  Q
 . I MYLOCK(ILOCK) D  ; NEVER change order of the logic below!
 . . I '$P(ACTION,U,ILOCK) D
 . . . K ^XTMP("MAGJ","LOCK",RARPT,ILOCK)
 . . . S $P(RESULT,U,ILOCK)=0
 . . L -^XTMP("MAGJ","LOCK",RARPT,ILOCK) ; reset lock
 . ; index by DayCase manages locks for Printset Exams (>1 DayCase for one RARPT)
 . ; a lock on any printset member exam effectively locks all related exams
 . I +$P(ACTION,U,ILOCK),'MYLOCK(ILOCK) D
 . . S ^XTMP("MAGJ","LOCK",RARPT,ILOCK,DAYCASE)=DUZ_U_$J_U_$H_U_$P(MAGJOB("USER",1),U,2,3)_U_"|"_LOGDATA
 . . S ^XTMP("MAGJ","LOCK",RARPT,ILOCK)=DAYCASE
 . . S $P(RESULT,U,ILOCK)=1
 . I '$P(ACTION,U,ILOCK) L -^XTMP("MAGJ","LOCK",RARPT,ILOCK)  ; reset or clear lock
 Q
 ;
END Q  ;
