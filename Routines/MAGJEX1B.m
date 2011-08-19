MAGJEX1B ;WIRMFO/JHC Rad. Workstation RPC calls ; 29 Jul 2003  9:58 AM
 ;;3.0;IMAGING;**16,22,18,65,76**;Jun 22, 2007;Build 19
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
 ; Subroutines for fetch exam images, exam lock/reserve, remove dangling locks
 ;
IMGLOOP ; get data for all the images
 ; This subroutine is called from MAGJEX1
 ;       MAGGRY holds $NA reference to ^TMP where Broker return message is assembled;
 ;   all references to MAGGRY use subscript indirection  
 N DFN,IMGREC,P18ALTP
 I '$D(MAGJOB("ALTPATH")) S MAGJOB("ALTPATH")=0 ; facilitates testing
 F IMAG=MAGSTRT:1:MAGEND S MAGIEN=$P(MAGS(IMAG),U,4) D
 . S DFN=$P(MAGS(IMAG),U,8)
 . I DFN=RADFN S MIXEDUP(RADFN)=""  ;ok
 . E  S:'DFN DFN=0 S MIXEDUP=MIXEDUP+2,MIXEDUP(DFN)="" ; database corruption
 . S MDL=$P(MAGS(IMAG),U,3)
 . I MDL="DR" S MDL="CR"  ; for now, hard code cx of non-standard code
 . I $G(SERBRK),(SERLBL]"") D    ; mark Begin of series
 . . S CT=CT+1,@MAGGRY@(CT+STARTNOD)=SERLBL,SERLBL=""
 . S MAGXX=MAGIEN D
 . . I 'USETGA,($P(MAGS(IMAG),U,2)["BIG") D BIG^MAGFILEB Q
 . . E  D VST^MAGFILEB
 . I MAGJOB("ALTPATH") S X=$P(MAGS(IMAG),U,6),P18ALTP="" I X]"" D
 . . F I=1:1:$L(X,",") S T=$P(X,",",I) I T S CURPATHS(T)="" I 'MAGJOB("P32"),$D(MAGJOB("LOC",T)) S P18ALTP=P18ALTP_$S(P18ALTP="":"",1:",")_T
 . S IMGREC="B2^"_MAGIEN_U_MAGFILE2
 . I 'MAGJOB("P32") D
 . . S T="",X=$P(MAGS(IMAG),U,11) I X]"" F I="K","I","U" I X[I,$D(PSIND(I)) S T=T_$S(T="":"",1:",")_I ; PS_Indicators
 . . S IMGREC=IMGREC_U_T_U_$S(MAGJOB("ALTPATH"):P18ALTP,1:"") ; AltPaths for this img
 . . I '(PROCDT]"") D  ; Img Process Date
 . . . S X=$P(MAGS(IMAG),U,12) I X]"" S T=$S($E(X)=3:20,$E(X)=2:19,1:"") I T S PROCDT=T_$E(X,2,7)
 . . I '(ACQSITE]"") D  ; Acq Site
 . . . S X=$P(MAGS(IMAG),U,13) I X]"" S ACQSITE=X
 . S CT=CT+1,@MAGGRY@(CT+STARTNOD)=IMGREC
 . I MODALITY="" D
 . . I 'MAGJOB("P32") S MODALITY=MDL Q
 . . N T S T=$P("1dummy1^CT^CR^MR^US^AS^CD^CS^DG^EC^FA^LP^MA^PT^ST^XA^NM^OT^BI^CP^DD^DM^ES^FS^LS^MS^RG^TG^RF^RTIMAGE^RTSTRUCT^HC^RTDOSE^RTPLAN^RTRECORD^DX^MG^IO^PX",U_MDL_U,1)
 . . S MODALITY=$L(T,U)
 . . I MODALITY>38 S MODALITY=9999  ; 38=TOTAL # modalities defined; else 9999
 . . I STKLAY S OPENCNT=0 ; no limit on WS for # of exams open in StackVwr
 ;
 I 'MAGJOB("ALTPATH") S ALTPATH=-1
 E  D
 . S T=0 F  S T=$O(CURPATHS(T)) Q:'T  I $D(MAGJOB("LOC",T)) Q
 . S ALTPATH=$S('T:0,1:1)
 . I ALTPATH=$P(MAGJOB("ALTPATH"),U,2) S ALTPATH=-1
 . E  S $P(MAGJOB("ALTPATH"),U,2)=ALTPATH
IMGLOOPZ Q
 ;
 ;
LOCKIN(RARPT,LOCKLEV,MYLOCK,LOCKCHK) ; init lock-related info B4 do any lock actions
 ; called from UTL3 & EX1A
 ; if LOCKCHK="STATUS", only return current status
 ; Input RARPT (required) and LOCKCHK (opt)
 ; Output: LOCKLEV & MYLOCK array; successful LOCKS left intact, unless LOCKCHK="STATUS"
 ; M LOCKS det. what Actions are possible by calling program modules
 ; MYLOCK(1/2)= Lock_is_Mine ^ DUZ ^ $J ^ User Name ^ User Init ^ Case #
 ; LOCKLEV=0:3--is/not 1-Lockable/2-Reservable/3-Both to user
 ; MYLOCK=0:3--is/not already 1-Locked/2-Reserved/3-Both by user
 ;
 N CKMINE,CASENO,XX,XY,ILOCK
 S LOCKCHK=$G(LOCKCHK)="STATUS"
 S LOCKLEV=0 K MYLOCK S MYLOCK=0
 L +^XTMP("MAGJ","LOCK",RARPT):0
 I  S LOCKLEV=3
 L +^XTMP("MAGJ","LOCK",RARPT,1):0 ; "1" for Exam "LOCK"
 I  S:'LOCKLEV LOCKLEV=1
 L +^XTMP("MAGJ","LOCK",RARPT,2):0 ; "2" for Exam "RESERVE"
 I  S LOCKLEV=$S('LOCKLEV:2,1:3)
 L -^XTMP("MAGJ","LOCK",RARPT)
 S CKMINE=DUZ_U_$J
 F ILOCK=1,2 D
 . S XX="",XY="",CASENO=$G(^XTMP("MAGJ","LOCK",RARPT,ILOCK))
 . I CASENO]"" S XX=$G(^XTMP("MAGJ","LOCK",RARPT,ILOCK,CASENO)),XY=$P(XX,"|",2),XX=$P(XX,"|")
 . S X=$P(XX,U,1,2),MYLOCK(ILOCK)=(X=CKMINE)
 . S X=$P(XX,U)_U_$P(XX,U,2)_U_$P(XX,U,4)_U_$P(XX,U,5)_U_CASENO_U_"|"_XY
 . S MYLOCK(ILOCK)=MYLOCK(ILOCK)_U_X
 . I MYLOCK(ILOCK) S MYLOCK=MYLOCK+ILOCK
 I LOCKCHK,LOCKLEV D  ; reset locks for Lock check
 . I LOCKLEV=1!(LOCKLEV=3) L -^XTMP("MAGJ","LOCK",RARPT,1)
 . I LOCKLEV=2!(LOCKLEV=3) L -^XTMP("MAGJ","LOCK",RARPT,2)
 Q
 ;
REMLOCK ;  Remove dangling exam locks; this is run only at Logon
 ; If a recorded lock is found that a new job (logon) can M-Lock
 ; then that is a dangling lock that must be removed
 N RARPT,TS,LOCKLEV,MYLOCK,ACTION,DAYCASE,ILOCK,RESULT
 S RARPT=""
 F  S RARPT=$O(^XTMP("MAGJ","LOCK",RARPT)) Q:'RARPT  D  ; loop thru recorded locks
 . D LOCKIN(RARPT,.LOCKLEV,.MYLOCK)
 . I 'LOCKLEV Q  ;unable to lock--is ok
 . S ACTION="",DAYCASE=""
 . F ILOCK=1,2 I $D(^XTMP("MAGJ","LOCK",RARPT,ILOCK)) S XX=^(ILOCK) D
 . . I DAYCASE="" S DAYCASE=$P(XX,U)
 . . I ILOCK=1,(LOCKLEV=1!(LOCKLEV=3)) S $P(ACTION,U,1)=1
 . . I ILOCK=2,(LOCKLEV=2!(LOCKLEV=3)) S $P(ACTION,U,2)=1
 . I 'ACTION,'+$P(ACTION,U,2),(DAYCASE="") D  Q  ; should never occur, but 
 . . I LOCKLEV=1!(LOCKLEV=3) L -^XTMP("MAGJ","LOCK",RARPT,1)
 . . I LOCKLEV=2!(LOCKLEV=3) L -^XTMP("MAGJ","LOCK",RARPT,2)
 . D LOCKOUT^MAGJEX1A(RARPT,DAYCASE,.LOCKLEV,.MYLOCK,ACTION,.RESULT) ; 1st, lock to me
 . K LOCKLEV,MYLOCK D LOCKACT^MAGJEX1A(RARPT,DAYCASE,101,.RESULT) ;    then, clear the lock
 S TS="" F I=2,0 S TS=TS_$S(TS="":"",1:U)_$$HTFM^XLFDT($H+I,0)
 S ^XTMP("MAGJ",0)=TS_U_"VistaRad Locks"
 Q
 ;
 ;
END ;
