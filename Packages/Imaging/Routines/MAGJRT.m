MAGJRT ;WIRMFO/JHC VistaRad RPC calls for Demand Routing ; 13 Jan 2004  11:00 AM
 ;;3.0;IMAGING;**9,22,11,18**;Mar 07, 2006
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
 ; Entry Points:
 ;   RTENA -- Determine whether user has Security Key required to use Demand Routing
 ;   RTREQ -- Build message to create Demand Routing Request form on the W/S
 ;  RTEXAM -- Queue images to route according to input requests
 ;
ERR N ERR S ERR=$$EC^%ZOSV S @MAGGRY@(0)="0^4~"_ERR
 D @^%ZOSF("ERRTN")
 Q:$Q 1  Q
 ;
RTENA(MAGGRY,DATA) ; RPC: MAGJ ROUTE ENABLE
 ; Enable if: 1) User has applicable security key and, 2) Routing Loc'n has usable entries
 N $ETRAP,$ESTACK S $ETRAP="D ERR^MAGJRT"
 S MAGGRY="FALSE"
 I '$D(MAGJOB("KEYS")) D USERKEYS^MAGJUTL3
 F X="MAGJ DEMAND ROUTE","MAGJ DEMAND ROUTE DICOM" I $D(MAGJOB("KEYS",X)) D  Q
 . N OK,DUM
 . S OK=0 D RTLOCS1(.DUM,.OK) I +OK!+$P(OK,U,2) S MAGGRY="TRUE"
 Q
 ;
RTREQ(MAGGRY,DATA) ; RPC: MAGJ ROUTE REQUEST
 ; request to route exams;  info returned in MAGGRY
 ; input in DATA(1:n): RADFN ^ RADTI ^ RACNI ^ RARPT
 ;  - RADFN^RADTI^RACNI input to specify case of interest
 ; Returns: Exam Info for routable exams in ^TMP($J,"MAGJROUTE",1:N)
 ;          Followed by Prompts for Routing Locations & Priority
 ;          Then error messages, if any
 ;          
 ; MAGGRY holds $NA reference to ^TMP where Broker return message is assembled;
 ;   all references to MAGGRY use subscript indirection
 ;
 N $ETRAP,$ESTACK S $ETRAP="D ERR^MAGJRT"
 N RARPT,RADFN,RADTI,RACNI
 N DAYCASE,REPLY,CT,MAGS,STARTNOD,DATAOUT,RADATA,MAGSTRT,MAGEND,NEXAM,DIQUIET
 N IDATA,NOGO
 S DIQUIET=1 D DT^DICRW
 S CT=0,NEXAM=0,DATAOUT="",DAYCASE=""
 S NOGO(0)=0  ; array for reply for exams unable to process
 S MAGLST="MAGJROUTE",STARTNOD=1
 K MAGGRY S MAGGRY=$NA(^TMP($J,MAGLST)) K @MAGGRY ; assign MAGGRY value
 S IDATA=""
 F  S IDATA=$O(DATA(IDATA)) Q:IDATA=""  S DATA=DATA(IDATA) D EXDAT("RTGET")
 I NEXAM D  ; have some exams eligible to be routed
 . S @MAGGRY@(STARTNOD)="^Case #^Patient^Procedure^Image Date/Time^Status^Modality"
 . S CT=CT+1,@MAGGRY@(CT+STARTNOD)="*END"
 . S REPLY="1~Route Exams to Selected Locations"
 . D RTLOCS(.CT) D RTPRIOR(.CT)
 E  D
 . S REPLY="0~Unable to Route any Exams"
RTREQZ I NOGO(0) D NOGO("Routed",.CT)
 S @MAGGRY@(0)=NEXAM_U_REPLY
 Q
 ;
 ;
EXDAT(GET) ; Put routable exam info in output file, non-routable in NOGO(n)
 S NOGO=0,RARPT=+$P(DATA,U,4)
 S RADFN=$P(DATA,U),RADTI=$P(DATA,U,2),RACNI=$P(DATA,U,3),X=0
 I RADFN,RADTI,RACNI D GETEXAM2^MAGJUTL1(RADFN,RADTI,RACNI,"",.X)
 I 'X S NOGO="1~Request has Invalid Case Pointer ("_RADFN_U_RADTI_U_RACNI_U_RARPT_")." G EXDATZ
 S RADATA=$G(^TMP($J,"MAGRAEX",1,1)) K ^TMP($J,"MAGRAEX")
 S RARPT=$P(RADATA,U,10),DAYCASE=$P(RADATA,U,12)
 S DATAOUT="" D @GET
EXDATZ I NOGO D
 . S NOGO(0)=NOGO(0)+1,NOGO(NOGO(0))=$P(NOGO,"~",2,99)
 E  D
 . S DATAOUT=U_DATAOUT_"|"_RADFN_U_RADTI_U_RACNI_U_RARPT_"||"
 . S NEXAM=NEXAM+1,CT=CT+1,@MAGGRY@(CT+STARTNOD)=DATAOUT
 Q
 ;
RTGET ;GET code for Demand Routing function
 ; get data for exams (DATAOUT), or reason for error (NOGO)
 N IMAG,MAGIEN,MDL,MAGS
 S X=$$JBFETCH^MAGJUTL2(RARPT,.MAGS)  ; ? route only if NOT on Jukebox
 I +X S NOGO="2~Case #"_DAYCASE_"--Images have been requested from Jukebox; try again later." Q
 I '$P(X,U,2) S NOGO="3~Case #"_DAYCASE_"--No Images exist for exam." Q
 F IMAG=1:1 S MAGIEN=$P($G(MAGS(IMAG)),U,4) Q:MAGIEN=""  D  Q:MDL]""
 . S MDL=$P(MAGS(IMAG),U,3)
 . I MDL="DR" S MDL="CR"  ; for now, hard code cx of non-standard code
 ; Contents of DATAOUT=
 ;  DAYCASE ^ Pt Name ^ Proc. Name ^ Exam Date/Time ^ Status ^ MDL
 S DATAOUT=DAYCASE_U_$P(RADATA,U,4)_U_$P(RADATA,U,9)
 S DATAOUT=DATAOUT_U_$$DTTIM($P(RADATA,U,6))_U_$P(RADATA,U,14)_U_MDL
 Q
 ;
DTTIM(X) ; Format Image Date/Time
 N T S T=$L(X,"  "),X=$P(X,"  ",1,T-1)_"@"_$P(X,"  ",T)
 Q X
 ;
RTLOCS(CT) ; define prompts for Routing Locations
 ;DROP-Down List, Default=[Do Not Route], Enable Auto-fill (if>1 exam)
 N AUTOFILL,T,X,OK,TMP
 S AUTOFILL=$S($G(NEXAM)>1:"AUTOFILL",1:"")
 S CT=CT+1,@MAGGRY@(CT+STARTNOD)="*PROMPT"
 S CT=CT+1,@MAGGRY@(CT+STARTNOD)="DROP^Route To^"_AUTOFILL_"^[Do Not Route]"
 S T=0
 S CT=CT+1,@MAGGRY@(CT+STARTNOD)="0^[Do Not Route]"
 K TMP S TMP=0 D RTLOCS1(.TMP,.OK)
 F I=1:1:TMP S CT=CT+1,@MAGGRY@(CT+STARTNOD)=TMP(I)
 S CT=CT+1,@MAGGRY@(CT+STARTNOD)="*END"
 Q
 ;
RTLOCS1(RET,OK) ; return:
 ;  RET = array of loc'ns screened by sec key
 ;  OK  = Non-dcm ^ dcm   Truth value for user may route respective routing types
 S RET=0,OK=""
 I $D(MAGJOB("KEYS","MAGJ DEMAND ROUTE")) D
 . N T S T=0
 . F  S T=$O(^MAG(2005.2,T)) Q:'T  S X=$G(^(T,0)) I X]"" D
 .. Q:'$P(X,U,9)  ; Not a routable location
 .. Q:'$P(X,U,6)  ; OPERATIONAL STATUS not On-Line
 .. Q:'($P(X,U,7)="MAG")  ; Storage Type not Magnetic
 .. S X=$P(X,U),OK=OK+1
 .. S RET=RET+1,RET(RET)=T_U_X
 ; dicom destinations: assume that all are "active"
 I $D(MAGJOB("KEYS","MAGJ DEMAND ROUTE DICOM")) D
 . N DCM
 . D DCMLIST^MAGBRTUT(.DCM,DUZ(2))
 . I +$G(DCM(1)) S $P(OK,U,2)=+$G(DCM(1))
 . I  F I=2:1:DCM(1)+1 S X=DCM(I),RET=RET+1,RET(RET)=$P(X,U,2)_"DCM"_U_"dcm "_$P(X,U)
 Q
 ;
RTPRIOR(CT) ; define prompts for Routing Priorities
 ;DROP-Down List, Default=Medium, Enable Auto-fill (if>1 exam)
 N AUTOFILL
 S AUTOFILL=$S($G(NEXAM)>1:"AUTOFILL",1:"")
 S CT=CT+1,@MAGGRY@(CT+STARTNOD)="*PROMPT"
 S CT=CT+1,@MAGGRY@(CT+STARTNOD)="DROP^Priority^"_AUTOFILL_"^Medium"
 S CT=CT+1,@MAGGRY@(CT+STARTNOD)="900^STAT"
 S CT=CT+1,@MAGGRY@(CT+STARTNOD)="750^High"
 S CT=CT+1,@MAGGRY@(CT+STARTNOD)="500^Medium"
 S CT=CT+1,@MAGGRY@(CT+STARTNOD)="250^Low"
 S CT=CT+1,@MAGGRY@(CT+STARTNOD)="*END"
 Q
 ;
NOGO(HDR,CT) ; output error msgs for exams
 Q:'NOGO(0)
 S CT=CT+1,@MAGGRY@(CT+STARTNOD)="*ERROR"
 S CT=CT+1,@MAGGRY@(CT+STARTNOD)=NOGO(0)_" Exams Not Able to be "_HDR
 F I=1:1:NOGO(0) S CT=CT+1,@MAGGRY@(CT+STARTNOD)=NOGO(I)
 S CT=CT+1,@MAGGRY@(CT+STARTNOD)="*END"
 Q
 ;
 ; 1  RADFN   RADTI    RACNI   RANME   RASSN    <-- from GETEXAM
 ; 6  RADATE  RADTE    RACN    RAPRC   RARPT            (=RADATA)
 ; 11 RAST    DAYCASE  RAELOC  RASTP   RASTORD
 ; 16 RADTPRT RACPT
 ;
RTEXAM(MAGGRY,DATA) ; RPC: MAGJ ROUTE EXAMS
 ; queue images to route according to input requests
 ; input in DATA(1:n), list of exams to route: 
 ;    Destination Network Loc'n ^ Priority | RADFN ^ RADTI ^ RACNI ^ RARPT
 ; Returns: Reply status in ^TMP($J,"MAGJROUTE",1:N)
 ;          Then error messages for each exam if applicable
 ;          
 ; MAGGRY holds $NA reference to ^TMP where Broker return message is assembled;
 ;   all references to MAGGRY use subscript indirection
 ;
 ;        MAGS = # Images stored for the case
 ;  MAGS(1:n) = 1/0 ^ FULL/BIG ^ Mod ^ ien ^ Series ^ Routed-to Locations
 ;              (1=Image is on Magnetic Disk)
 ;
 N $ETRAP,$ESTACK S $ETRAP="D ERR^MAGJRT"
 N IEXAM,RTLOC,RTPRI,RARPT,IDATA,REPLY,CT,MAGS,STARTNOD,NEXAM,NOGO
 N IMAG,MAGLST,MAGIEN,RTTYP,DIQUIET
 S DIQUIET=1 D DT^DICRW
 K NOGO S NOGO(0)=0  ; array for reply for exams unable to process
 S MAGLST="MAGJROUTE",CT=0,STARTNOD=0,NEXAM=0
 K MAGGRY S MAGGRY=$NA(^TMP($J,MAGLST)) K @MAGGRY ; assign MAGGRY value
 S IDATA=""
 F  S IDATA=$O(DATA(IDATA)) Q:IDATA=""  D
 . S X=DATA(IDATA),DATA=$P(X,"|",2),X=$P(X,"|"),RTLOC=$P(X,U),RTPRI=$P(X,U,2)
 . S RTTYP=$S(RTLOC=+RTLOC:1,1:2),RTLOC=+RTLOC ; 1=DOS; 2=Dicom
 . I 'RTLOC Q  ; routing cancelled for this exam
 . S RARPT=$P(DATA,U,4)  I 'RARPT D  Q
 . . S NOGO(0)=NOGO(0)+1,NOGO(NOGO(0))="Exam not queued: Missing exam pointer information for exam ("_DATA(IDATA)_")"
 . S X=$$JBFETCH^MAGJUTL2(RARPT,.MAGS)
 . F IMAG=1:1 S MAGIEN=$P($G(MAGS(IMAG)),U,4) Q:MAGIEN=""  D
 . . D SEND^MAGBRTUT(MAGIEN,RTLOC,RTPRI,RTTYP)
 . I IMAG>1 S NEXAM=NEXAM+1
 . E  S NOGO(0)=NOGO(0)+1,NOGO(NOGO(0))="Exam not queued: No images found ("_DATA(IDATA)_")"
 I NEXAM S REPLY=1_"~"_NEXAM_" Exam"_$S(NEXAM-1:"s",1:"")_" were queued to be routed."
 E  S REPLY="0~Unable to queue any exams for routing."
RTEXAMZ I NOGO(0) D NOGO("Queued",.CT)
 S @MAGGRY@(0)=$S(NOGO(0):CT,1:0)_U_REPLY
 Q
 ;
END Q
 ;
