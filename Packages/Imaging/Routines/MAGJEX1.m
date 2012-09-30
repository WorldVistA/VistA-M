MAGJEX1 ;WIRMFO/JHC - VistARad RPC calls ; 9 Sep 2011  4:05 PM
 ;;3.0;IMAGING;**16,22,18,65,101,115,104,120**;Mar 19, 2002;Build 27;May 23, 2012
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
 ;
ERR N ERR S ERR=$$EC^%ZOSV S @MAGGRY@(0)="0^4~"_ERR
 D @^%ZOSF("ERRTN")
 Q:$Q 1  Q
 ;
 ;***** Open an exam.
 ; RPC: MAGJ RADCASEIMAGES
 ;
OPENCASE(MAGGRY,DATA) ;
 ; MAGGRY holds $NA reference to ^TMP for rpc return
 ;   all ref's to MAGGRY use subscript indirection
 ; input in DATA:
 ; OPEN_FLAG ^ RADFN^RADTI^RACNI^RARPT ^ PSINDGET ^ <unused> ^ USETGA
 ; OPEN_FLAG = 0: Open, view only
 ;     1: Open, lock the case for status update
 ;     2: Open, Reserve for Interpretation
 ;     VIX: Fetching metadata only; Jukebox retrieval occurs (P115 & earlier)
 ;     VIX-Metadata: Fetching metadata only; no JB Retrieval (P104,ff)
 ;     VIX-Open: Fetching metadata with JB Retrieval (P104,ff)
 ; RADFN^RADTI^RACNI^RARPT = Exam ID string, specifies case of interest
 ; PSINDGET= Presentation State indicators of interest to client
 ;     K/I/U for Key Image/ Interpretation/ User PS types
 ; USETGA   = 1: Open TGA (downsampled) file; 0: Open BIG file
 ; 
 ; Details of Reply message are below tag OPENCASZ
 ; 
 N $ETRAP,$ESTACK S $ETRAP="D ERR^MAGJEX1"
 N RARPT,RADFN,RADTI,RACNI,RADIV
 N DAYCASE,CURCASE,REPLY,CT,MAGS,STARTNOD,LOCKED,DATAOUT,RADATA,RIST,MDL
 N IMAG,MAGXX,MAGFILE,MAGFILE1,MAGFILE2,MAGFILE3,MAGLST,MAGOBJT,MODALITY
 N MAGSTRT,MAGEND,CURPATHS
 N MIXEDUP,VIEWOK,USETGA,USELORES,IMGST,REMOTE,DIQUIET
 N LOGDATA,MODIF,EXCAT,RADATA2,PSIND,RACPT,RASTCAT,RASTORD,ACQSITE,ALTPATH,PROCDT
 N YNMAMMO,YNREVANN,PSINDGET,JBDISABLE,STANUM
 S DIQUIET=1 D DT^DICRW
 S (CT,MIXEDUP)=0,MODALITY="",DATAOUT="",DAYCASE="",MAGLST="MAGJOPENCASE",(ACQSITE,ALTPATH,PROCDT,STANUM)=""
 S VIEWOK=1
 K MAGGRY S MAGGRY=$NA(^TMP($J,MAGLST)),STARTNOD=0 K @MAGGRY  ; assign MAGGRY value
 S CURCASE=$P(DATA,U),RARPT=+$P(DATA,U,5),PSINDGET=+$P(DATA,U,6)
 S PSIND="" I PSINDGET]"" F I="K","I","U" I $F(PSINDGET,I) S PSIND(I)=""
 S USETGA=+$P(DATA,U,8)
 S RADFN=$P(DATA,U,2),RADTI=$P(DATA,U,3),RACNI=$P(DATA,U,4)
 I RADFN,RADTI,RACNI D GETEXAM2^MAGJUTL1(RADFN,RADTI,RACNI,"",.X)
 I 'X S REPLY="4~Request Contains Invalid Case Pointer ("_RADFN_U_RADTI_U_RACNI_U_RARPT_")." G OPENCASZ
 S RADATA=$G(^TMP($J,"MAGRAEX",1,1)),RADATA2=$G(^(2))
 K ^TMP($J,"MAGRAEX")
 S RADIV=$P(RADATA2,U,5),MODIF=$P(RADATA2,U,8),RASTCAT=$P(RADATA2,U,11),RASTORD=$P(RADATA,U,15)
 S RARPT=+$P(RADATA,U,10),DAYCASE=$P(RADATA,U,12),RACPT=$P(RADATA,U,17)
 I 'RARPT!'$D(^RARPT(RARPT,2005)) S REPLY="4~This exam has no report entry for associating images; no images can be accessed." G OPENCASZ
 D CKINTEG^MAGJRPT(.X,RADFN,RADTI,RACNI,RARPT,RADATA)
 I X]"" S MIXEDUP=1,MIXEDUP("REPLY")=X ; DB corruption
 S REPLY="4~Attempting to open/display case #"_DAYCASE
 S JBDISABLE=0
 I CURCASE="VIX-Metadata" S JBDISABLE=1 ; metadata only, do not trigger JB fetches
 ;
 ; Note in several reply messages below the use of "2~"
 ;   This value triggers specific behaviors in vrad client and VIX
 ;     -- client displays an Information message box
 ;     -- VIX 'tags' the exam to refresh the file list metadata from the source
 ;         on any subsequent access for this exam
 ;    These respective behaviours are mutually appropriate for both parts of 
 ;    the system for all the messages involved; avoid using "2~" unless the
 ;    same functionality applies for any given new functionality
 ;
 S IMGST=$$JBFETCH^MAGJUTL2(RARPT,.MAGS,USETGA,JBDISABLE)  ; open only if NOT on JB
 I +IMGST D  G OPENCASZ  ; some images are on JB
 . I $D(MAGS("OFFLN")) N T,TT S T="",TT="" D
 . . F  S T=$O(MAGS("OFFLN",T)) Q:T=""  S TT=TT_$S(TT="":"",1:", ")_T
 . . S REPLY="2~Case #"_DAYCASE_"--Images for this exam are stored OFF-LINE.  To view these images, contact your Imaging Coordinator, and request mounting of the following platters: "_TT
 . E  I JBDISABLE S REPLY="2~Case #"_DAYCASE_"--"_+IMGST_" Images are on Jukebox."
 . E  S REPLY="2~Case #"_DAYCASE_"--"_+IMGST_" Images have been requested from Jukebox; try again later."
 I '$P(IMGST,U,2) S REPLY="2~No Images exist for Case #"_DAYCASE_"." G OPENCASZ
 S USELORES=+$P(IMGST,U,3)_U_$P(IMGST,U,2)
 S MAGSTRT=1,MAGEND=MAGS D IMGLOOP^MAGJEX1B
 ;
 I ACQSITE="" S ACQSITE=RADIV
 ; 
 ; Conditionally support revising an unlocked exam's annotations as a function
 ;   of exam status and credentials of (current & original) interpreter (P101).
 S YNREVANN=$$ZRUREVAN^MAGJUTL4(RADFN,RADTI,RACNI)
 ; 
 ; Return flag to allow display of disclaimer text if ExamType="Mammogram".
 ;   Note the VRad client may override based on image metadata (P101).
 S YNMAMMO=$$ZRUMAMMO^MAGJUTL4(RACPT)
 ; 
 ; 
 S REPLY="0~Images for Case #"_DAYCASE
 ;
OPENCASZ I 'CT,(REPLY["Attempting") S REPLY="4~Unable to retrieve images for Case #"_DAYCASE_"."
 ;
 ; Contents of successful reply = 4 pipe-delimited ("|") pieces:
 ;  1: # Image nodes ^ Reply Msg Type ~ Reply Msg display text
 ;  2: RADFN^RADTI^RACNI^RARPT  -->  Exam ID String
 ;  3: Pt Name ^ CASE # ^ Proc. Name ^ Exam Date ^ Time ^ Modality ^
 ;      SSN ^ <unused> ^ LOCKED Status ^ Modifier ^ Exam Status Category
 ;  4: Is Radiologist? ^ Alt_Path Flag ^ Acquisition Site ^ Procedure Date ^
 ;      Revise Annotations? ^ Mammography? ^ Station Number
 ;
 S REMOTE=+MAGJOB("REMOTE")
 S LOCKED=0
 I MIXEDUP D
 . N IMIX,XDFN,XPTS S VIEWOK=$S($D(MAGJOB("KEYS","MAGJ SEE BAD IMAGES")):1,1:0)
 . I MIXEDUP>1 D
 . . S XPTS="",XDFN=0 F IMIX=0:1 S XDFN=$O(MIXEDUP(XDFN)) Q:'XDFN  S XPTS=XPTS_$S(IMIX:" and ",1:" ")_$$PNAM(XDFN)
 . . S XPTS=$S(IMIX=1:" ",1:"s ")_XPTS
 . . S REPLY=(7-VIEWOK)_"~This exam is registered for "_$$PNAM(RADFN)_"; however, it is linked to images for patient"_XPTS_".  This is a serious problem--immediately report it to Radiology management and Imaging support staff!"
 . E  S REPLY=(7-VIEWOK)_"~"_MIXEDUP("REPLY")
 . I CURCASE S REPLY=REPLY_"  The exam is NOT Locked." S CURCASE=0
 I CT D
 . S RIST=$S(+MAGJOB("USER",1):1,1:0),EXCAT=""
 . S LOGDATA=RADFN_U_+$P(MAGS(1),U,4)_U_+MAGS_U_REMOTE ; for Img Access log
 . I CURCASE D
 . . I $G(MAGJOB("CONSOLIDATED")),'$D(MAGJOB("DIVSCRN",RADIV)) D  S CURCASE=0  Q
 . . . S REPLY="5~Exam is for Station #"_$$STATN(RADIV)_"; you are logged on to #"_$$STATN(DUZ(2))_".  Exam is NOT Locked."
 . . S XX=$P(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0),U,3)
 . . I '$D(^RA(72,"AVC","E",XX)) D  S CURCASE=0  Q
 . . . D LOCKACT^MAGJEX1A(RARPT,DAYCASE,100,.RESULT) ; between reserve and now, exam may have been Taken & Updated
 . . . I +RESULT(1)!+RESULT(2) D LOCKACT^MAGJEX1A(RARPT,DAYCASE,101,.RESULT) ; so, cancel any lock/reserve
 . . . S REPLY="5~For Case #"_DAYCASE_", current Status is "_$P(^RA(72,XX,0),U)_"; Lock or Reserve NOT allowed."
 . . E  S EXCAT="E"
 . . I RIST,'USELORES D  ; lock only for Current Case, Radiologist, & Full Res images
 . . . ;  save data needed to later log Interpreted event
 . . . D LOCKACT^MAGJEX1A(RARPT,DAYCASE,CURCASE,.RESULT,.REPLY,LOGDATA)
 . . . S LOCKED=$S(+RESULT:1,+$P(RESULT,U,2):2,1:0)
 . I EXCAT="" D
 . . I RASTORD=9 S EXCAT="C" Q  ; Complete
 . . E  S EXCAT=RASTCAT
 . . I EXCAT="D"!(EXCAT="T") S EXCAT="I" ; just display one value meaning Interpreted
 . S DATAOUT=$P(RADATA,U,4)_U_DAYCASE_U_$P(RADATA,U,9)
 . S X=$P(RADATA,U,6),T=$L(X,"  "),X=$P(X,"  ",1,T-1)_U_$P(X,"  ",T)
 . S DATAOUT=DATAOUT_U_X
 . S DATAOUT=DATAOUT_U_MODALITY_U_$P(RADATA,U,5)_U_U_LOCKED
 . S DATAOUT=DATAOUT_U_MODIF_U_EXCAT_U_"|"_RIST_U_ALTPATH_U_ACQSITE_U_PROCDT_U_YNREVANN_U_YNMAMMO_U_STANUM
 . I USELORES D
 . . I +USELORES=+$P(USELORES,U,2) S X="All"
 . . E  S X=+USELORES_" of "_+$P(USELORES,U,2)
 . . I $E(REPLY,1,8)="0~Images" S REPLY="3~"
 . . E  S REPLY=REPLY_"  --  "
 . . S REPLY=REPLY_"Note: "_X_" images for Case #"_DAYCASE_" are REDUCED RESOLUTION images, using parameters set by your site Imaging Manager; to view full-resolution images, disable the Reduced Resolution option setting. Exam NOT Locked."
 S @MAGGRY@(STARTNOD)=CT_U_REPLY_"|"_RADFN_U_RADTI_U_RACNI_U_RARPT_"|"_DATAOUT
 ; if mixedup & not have keys to see images, delete image refs
 ;   & send only reply msg
 I MIXEDUP,('VIEWOK) S CT=0 K @MAGGRY S @MAGGRY@(0)=CT_U_REPLY
 E  S $P(@MAGGRY@(0),U)=CT+STARTNOD
 I CT,(LOCKED'=2),(CURCASE'["VIX") D LOG^MAGJUTL3("VR-VW",LOGDATA,$$PSETLST(RADFN,RADTI,RACNI)) ; Image access log
 Q
 ;
PSETLST(RADFN,RADTI,RACNI) ; Return list of Printset Case #'s for exam
 N I,MAGPSET,PSETLST,RAPRTSET,X
 S PSETLST=""  ; initialize return value
 I +$G(RADFN),+$G(RADTI),+$G(RACNI) D
 . D EN2^RAUTL20(.MAGPSET)
 . Q:'RAPRTSET  ; variable set by above call; stop if not a printset
 . S X=""
 . F I=0:1 S X=$O(MAGPSET(X)) Q:'X  S PSETLST=PSETLST_$S(I:U,1:"")_+MAGPSET(X)
 Q:$Q PSETLST Q
 ;
PNAM(X) ; return pt name for input DFN
 I X S X=$G(^DPT(+X,0)) I X]"" S X=$P(X,U)
 E  S X="UNKNOWN"
 Q X
 ;
STATN(X) ; get station #, else return input value
 N T
 I X]"" D GETS^DIQ(4,X,99,"","T") S T=$G(T(4,X_",",99,"E")) I T]"" S X=T
 Q X
 ;
END Q  ;
 ;
