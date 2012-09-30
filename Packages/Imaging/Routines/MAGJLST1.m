MAGJLST1 ;WIRMFO/JHC - VistARad RPC calls ; 30 Dec 2011  1:36 PM
 ;;3.0;IMAGING;**16,22,18,65,76,101,90,120**;Mar 19, 2002;Build 27;May 23, 2012
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
 ;
 ; Subroutines for fetching Patient Exam Info
 ;     PTLIST -- list subset of all exams for a patient
 ;        RPC Call: MAGJ PTRADEXAMS
 ;   PTLSTALL -- list ALL exams for a patient
 ;        RPC Call: MAGJ PT ALL EXAMS
 ;    FACLIST -- get Treating Facility List for a patient
 ;        RPC Call: MAGJ GET TREATING LIST
 ; 
 Q
ERR N ERR S ERR=$$EC^%ZOSV S ^TMP($J,"RET",0)="0^4~"_ERR
 S MAGGRY=$NA(^TMP($J,"RET"))
 D @^%ZOSF("ERRTN")
 Q:$Q 1  Q
 ;
PTLSTALL(MAGGRY,DATA) ; List ALL exams for a patient
 ; MAGGRY - indirect reference to return array of exams for a patient
 ; DATA -- DFN ^ BEGDT ^ ONESHOT
 ;   --> see PTLIST comments
 ;  RPC is MAGJ PT ALL EXAMS
 N PARAM
 S PARAM=$P(DATA,U)_"^^^"_$P(DATA,U,2,3)
 D PTLIST(.MAGGRY,PARAM)
 Q
 ;
PTLIST(MAGGRY,DATA) ; get list of exams for a patient
 ; 
 ; MAGGRY - indirect reference to return array of exams for a patient
 ; DATA -- DFN ^ unused ^ unused ^ BEGDT ^ ONESHOT
 ;   DFN--Required; Patient's DFN
 ;   BEGDT--Optional; Begin date for exam fetch (see below)
 ;   ONESHOT--Optional; Number days back to search, return all records in one fell swoop
 ; Returns data in ^TMP($J,"MAGRAEX",0:n)
 ; RPC Call: MAGJ PTRADEXAMS
 ;
 ; Client retrieves ALL exams using multiple RPC calls to
 ; incrementally build the list; this is to provide all the data, but without
 ; incurring any long pauses to provide the info to the user.
 ; The algorithm fetches RAD data in one-year chunks, and repeats
 ; until over 20 exams have been processed, at which point the RPC reply
 ; is posted, along with the last date processed; this value is then used for
 ; a subsequent RPC call (BEGDT) to get the next chunk of the record; etc. till all done.
 ;  * ONESHOT overrides the incremental algorithm, returning all desired data in a single call.
 ;   
 N CNT,DFN,ISS,PATNAME,DIQUIET,MAGRACNT,MAGRET,REPLY,REMOTE
 N DAYCASE,DIV,EXCAT,MAGDT,XX,XX2,WHOLOCK,MODALITY,MYLOCK,PLACE,ENDLOOP
 N LIMEXAMS,BEGDT,SAVBEGDT,ENDDT,MORE,RDRIST,PSSN,CPT
 N CURPRIO,STATUS,RARPT,KEY,X2,REMOTE2,ONESHOT,LIMDAYS
 N IMGCNT,LRFLAG,MSG,ONL,PROCMOD,RASTCAT,RASTORD,STATPRIORITY,SNDREMOT
 N $ETRAP,$ESTACK S $ETRAP="D ERR^MAGJLST1"
 S DIQUIET=1 D DT^DICRW
 S BEGDT=$P(DATA,U,4),ONESHOT=$P(DATA,U,5)
 K MAGGRY S DFN=+DATA
 S SNDREMOT=+$P($G(^MAG(2006.69,1,0)),U,11)
 S MAGRACNT=1,CNT=0 K ^TMP($J,"MAGRAEX"),^("MAGRAEX2")
 S REPLY="0^4~Compiling list of Radiology Exams."
 I DFN,$D(^DPT(DFN,0)) S PATNAME=$P(^(0),U) D
 . D PID^VADPT6 S PSSN=$S(VAERR:"Unknown",1:VA("PID"))
 . K VA("PID"),VA("BID"),VAERR
 . S ENDLOOP=0,BEGDT=$S(+BEGDT:BEGDT,1:"")
 . F  D  Q:'MORE  Q:ENDLOOP  S BEGDT=MORE+1
 . . I 'BEGDT S BEGDT=DT,X2=0
 . . E  S X2=-1
 . . S LIMDAYS=365,MORE=1
 . . I ONESHOT,(ONESHOT>0) S LIMDAYS=+ONESHOT
 . . S ENDDT=$$FMADD^XLFDT(BEGDT,X2)
 . . S BEGDT=$$FMADD^XLFDT(ENDDT,-LIMDAYS)
 . . D GETEXAM3^MAGJUTL1(DFN,BEGDT,ENDDT,.MAGRACNT,.MAGRET,.MORE)
 . . S ENDLOOP=(MAGRACNT>20)!+ONESHOT ; For testing only, use >8
 . I 'MORE S SAVBEGDT=0
 . E  S SAVBEGDT=MORE+1 ; adding 1 correctly inits value for subseqent call
 . I MAGRACNT>1 D PTLOOP
 E  S REPLY="0^4~Invalid Radiology Patient"
 I MAGRACNT<2 S:(REPLY["Compiling") REPLY="0^2~Radiology Exams for: "_PATNAME
 I CNT!(REPLY["2~Radiology Exams") D
 . I 'MORE S MSG=""
 . E  S MORE=$$FMTE^XLFDT(MORE) S MSG="Patient has more exams on file."
 . ; show SSN only if the user is a radiologist
 . S X=+MAGJOB("USER",1)
 . I '(X=12!(X=15)),(PSSN?3N1"-"2N1"-"4N) S PSSN=$E(PATNAME)_$P(PSSN,"-",3)
 . S PSSN=" ("_PSSN_")"
 . I CNT S REPLY=CNT_"^1~Radiology Exams for: "_PATNAME_PSSN_$S(MSG="":"",1:" -- "_MSG)
 . E  S REPLY=REPLY_$S(MSG="":"",1:" -- "_MSG)
 . S ^TMP($J,"MAGRAEX2",1)="^Day/Case~S3~1^Lock~~2^Procedure~~6^Modifier~~25^Image Date/Time~S1~7^Status~~8^# Img~S2~9^Onl~~10^"_$S(SNDREMOT:"RC~~12^",1:"")_"Site~~23^Mod~~15^Interp By~~20^Imaging Loc~~11^CPT~~27"
 S $P(REPLY,"|",2)=SAVBEGDT
 S ^TMP($J,"MAGRAEX2",0)=REPLY
 S MAGGRY=$NA(^TMP($J,"MAGRAEX2"))
 K ^TMP($J,"RAE1"),^("MAGRAEX")
 Q
 ;
PTLOOP ; loop through exam data & package it for VRAD use
 S ISS=0
 F  S ISS=$O(^TMP($J,"MAGRAEX",ISS)) Q:'ISS  S XX=^(ISS,1),XX2=^(2) D
 . S CNT=CNT+1,RARPT=$P(XX,U,10)
 . D IMGINFO^MAGJUTL2(RARPT,.Y)
 . S IMGCNT=$P(Y,U),ONL=$P(Y,U,2),MAGDT=$P(Y,U,3),REMOTE=$P(Y,U,4),MODALITY=$P(Y,U,5),PLACE=$P(Y,U,6),KEY=$P(Y,U,7)
 . S REMOTE2=REMOTE
 . S:PLACE PLACE=$P($G(^MAG(2006.1,PLACE,0)),U,9)
 . I REMOTE D
 . . S T="" F I=1:1:$L(REMOTE,",") S T=T_$S(T="":"",1:",")_$P($G(^MAG(2005.2,$P(REMOTE,",",I),3)),U,5)
 . . S REMOTE=T
 . S DIV="",X=$P(XX2,U,5) I X'=DUZ(2) S DIV=$$STATN(X)
 . I MAGDT="" S MAGDT=$P(XX,U,7)
 . S MAGDT=$$FMTE^XLFDT(MAGDT,"5Z")
 . S WHOLOCK=RARPT,MYLOCK="",DAYCASE=$P(XX,U,12)
 . I WHOLOCK]"" S T=$$CHKLOCK^MAGJLS2B(WHOLOCK,DAYCASE),WHOLOCK=$P(T,U),MYLOCK=$P(T,U,2)
 . S RDRIST=$P(XX2,U,3),PROCMOD=$P(XX2,U,8),CPT=$P(XX,U,17),RASTORD=$P(XX,U,15)
 . S Y=U_DAYCASE_U_WHOLOCK_U_$E($P(XX,U,9),1,26)_U_PROCMOD_U_MAGDT_U_$E($P(XX,U,14),1,16)_U_IMGCNT_U_ONL
 . I SNDREMOT S Y=Y_U_REMOTE
 . S Y=Y_U_PLACE_U_MODALITY_U_RDRIST_U_$E($P(XX,U,13),1,11)_U_CPT
 . S STATUS=$P(XX,U,11),EXCAT="",CURPRIO=0,RASTCAT=$P(XX2,U,11),LRFLAG=$P(XX2,U,12)
 . I STATUS]"" D
 . . S EXCAT=RASTCAT
 . . I RASTORD<2!(EXCAT="W")!('IMGCNT) S CURPRIO=0 ; Cancelled/Waiting/No images: Ignore exam
 . . E  I EXCAT="E" S CURPRIO=1  ; Examined="Current" exam
 . . E  S CURPRIO=2  ; must be a "prior" exam
 . . I CURPRIO,'(ONL="Y") S CURPRIO=3 ; images on jukebox
 . . I RASTORD=9 S EXCAT="C" ; Complete
 . . E  I EXCAT="D"!(EXCAT="T") S EXCAT="I" ; just display one value meaning Interpreted
 . S STATPRIORITY=0 ; in the Pt list, this is only a placeholder in next line, to sync with svmag2a, etc.
 . S ^TMP($J,"MAGRAEX2",ISS)=Y_"^|"_$P(XX,U,1,3)_U_RARPT_"||"_EXCAT_U_WHOLOCK_U_MYLOCK_U_MODALITY_U_CPT_U_CURPRIO_U_RARPT_U_KEY_U_REMOTE2_U_LRFLAG_U_STATPRIORITY
 . ; * Note: Keep Pipe-pieces in sync with svmag2a^magjls3 & lstout^magjls2b *
 Q
 ;
STATN(X) ; get station #, else return input value
 N T
 I X]"" D GETS^DIQ(4,X,99,"E","T") S T=$G(T(4,X_",",99,"E")) I T]"" S X=T
 Q X
 ;
FACLIST(MAGGRY,DATA) ; get Treating Facility List for a patient
 ; RPC Call: MAGJ GET TREATING LIST
 ; MAGGRY -- return array--supplied by TFL^VAFCTFU1
 ; Input: DATA -- Patient DFN
 ; Returns:
 ; Array; first entry contains result header with # lines to follow
 ; and reply message description.
 ; Entries 2:N (if any exist) contain data for each Treating facility
 ; up-caret delimited : A ^ B ^ C ^ D ^ E
 ;    A: Institution IEN of the Facility
 ;    B: Institution Name
 ;    C: Current date on record for that institution
 ;    D: ADT/HL7 event reason 
 ;    E: FACILITY TYPE
 ; Note--see TFL^VAFCTFU1 for further details
 ; 
 N $ETRAP,$ESTACK S $ETRAP="D ERR^MAGJLST1"
 S DIQUIET=1 D DT^DICRW
 N DFN
 K MAGGRY S DFN=+$G(DATA)
 S REPLY="0^4~Compiling list of Treating Facilities."
 I DFN
 E  S REPLY="0^4~Invalid Radiology Patient" G FACLISTZ
 D TFL^VAFCTFU1(.MAGGRY,DFN)  ; ICR 2990
 I $D(MAGGRY)<10 S REPLY="0^4~No results available." G FACLISTZ
 E  I +MAGGRY(1)=-1 S REPLY="0^2~"_$P(MAGGRY(1),U,2) K MAGGRY(1) G FACLISTZ
 S REPLY=$O(MAGGRY(""),-1)_U_"1~Treating facilities returned"
FACLISTZ S MAGGRY(0)=REPLY
 Q
 ;
END Q  ;
