MAGJUTL4 ;WIRMFO/JHC VistARad subroutines for RPC calls ; 5-Mar-2010 4:18 PM
 ;;3.0;IMAGING;**18,76,101,90**;Mar 19, 2002;Build 1764;Jun 09, 2010
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
 ;***** Return matching CPT's based on grouping criteria.
 ; RPC: MAGJ CPTMATCH
 ;
CPTGRP(MAGGRY,DATA) ;
 ; FOR INPUT cpt code, return matching cpt's based on grouping criteria:
 ; INPUT in DATA: CPT Code ^ Criteria
 ; Criteria:
 ;   1=Matching cpt
 ;   2=Body Part
 ;   3=Body Part & Modality
 ;  10=Same CPT (used to return short description only)
 ; Return: List of CPTs with Short Name:  CPT ^ Short Name
 ; MAGGRY holds $NA reference to ^TMP for rpc return
 ;   all ref's to MAGGRY use subscript indirection
 ;
 N $ETRAP,$ESTACK S $ETRAP="G ERR1^MAGJUTL4"
 N REPLY,DIQUIET,CPT,CRIT,CT,MAGLST,NOD,NODLST
 N MATCHGRP,INDXLST,AND,RET,CPTGLB,CPTIN,CPTIEN,TCPT,CPTFILIEN,CPTFILDAT,IEN
 ;
 ; <*> Issue: Unable get specific body part for some non-specific CPTs (e.g., 75774-ANGIO SELECT EA ADD VESSEL-S)
 ;         --> For these, could just return matching CPTs (or equivalent CPT?)
 ;
 ; Produce List of cptiens for each INDX of interest
 ; AND with next list of cptiens; repeat until no more INDXs
 ; build output list of CPT codes (w/ short names [optional])
 ; 
 S DIQUIET=1 D DT^DICRW
 S CT=0,MAGLST="MAGJCPT"
 K MAGGRY S MAGGRY=$NA(^TMP($J,MAGLST)) K @MAGGRY  ; assign MAGGRY value
 S CPTIN=$P(DATA,U),CRIT=$P(DATA,U,2),CPTIEN=""
 S REPLY="0^Getting matching CPT info."
 S:'CRIT CRIT=1 ; default equivalent
 I '(CRIT=1!(CRIT=2)!(CRIT=3)!(CRIT=10)) S REPLY="0^Invalid cpt lookup criteria ("_DATA_")." G CPTGRPZ
 I CPTIN="" S REPLY="0^Invalid CPT code ("_DATA_")." G CPTGRPZ
 S CPTFILDAT=$$CPT^ICPTCOD(CPTIN)
 I +CPTFILDAT=-1 S CPTFILDAT=""
 S CPTFILIEN=$P(CPTFILDAT,U)
 S CPTGLB=$NA(^MAG(2006.67))
 I CPTFILIEN S CPTIEN=$O(@CPTGLB@("B",CPTFILIEN,""))
 I 'CPTIEN D  G CPTGRPZ
 . ; if no entry in CPTGLB, return same CPT
 . S CT=CT+1,@MAGGRY@(CT)=CPTIN_U_$P(CPTFILDAT,U,3)
 . I CPTFILIEN S REPLY=CT_U_"1~ "_CT_" CPT name returned for "_CPTIN
 . E  S REPLY=CT_U_"1~ "_CT_" record returned--no value found for "_CPTIN
 S X=@CPTGLB@(CPTIEN,0),MATCHGRP=+$P(X,U,4)
 ;CPTMATCH^BODYPART^MDL
 I CRIT=2!(CRIT=3) D
 . S X=0 F  S X=$O(@CPTGLB@(CPTIEN,1,"B",X)) Q:'X  D GETCPTS("BODYPART",X,"",.RET)
 . I CRIT=3 D
 . . M AND=RET K RET S X=0
 . . F  S X=$O(@CPTGLB@(CPTIEN,2,"B",X)) Q:'X  D GETCPTS("MDL",X,.AND,.RET)
 I CRIT=1 D
 . I MATCHGRP,(MATCHGRP'=CPTIEN) S RET(MATCHGRP)="" D GETCPTS("CPTMATCH",MATCHGRP,"",.RET)
 . D GETCPTS("CPTMATCH",CPTIEN,"",.RET)
 I CRIT=10 ; fall through answers this!
 I '$D(RET(CPTIEN)) S RET(CPTIEN)="" ; always report back input cpt
 S IEN=0 F  S IEN=$O(RET(IEN)) Q:'IEN  D
 . N LIN S X=$G(@CPTGLB@(IEN,0))
 . Q:'(X]"")  S TCPT=$P(X,U),LIN=$P($$CPT^ICPTCOD(TCPT),U,2,3)
 . S CT=CT+1,@MAGGRY@(CT)=LIN
 S REPLY=CT_U_"1~ "_CT_" CPT Matches returned for "_CPTIN
CPTGRPZ ;
 S @MAGGRY@(0)=REPLY
 Q
 ;
GETCPTS(INDEX,VALUE,AND,OUT) ; return a list of CPTIENS in OUT
 ; if array AND is defined, reply only values contained in AND &  the index
 N X,GLBREF,CPTIEN
 S GLBREF=$NA(@CPTGLB@(INDEX,VALUE))
 S CPTIEN=0
 I $D(AND)>9 D
 . F  S CPTIEN=$O(AND(CPTIEN)) Q:CPTIEN=""  I $D(@GLBREF@(CPTIEN)) S OUT(CPTIEN)=""
 E  F  S CPTIEN=$O(@GLBREF@(CPTIEN)) Q:'CPTIEN  D
 . S OUT(CPTIEN)=""
 Q
 ;
BODPART(CPTIEN,DLM) ; return DLM-delimited list of body part values for this CPT
 I +$G(CPTIEN)
 E  Q ""
 N LIST,CPTGLB S LIST=""
 S DLM=$E($G(DLM))
 I DLM="" S DLM="^"
 S CPTGLB=$NA(^MAG(2006.67))
 S NOD=0
 F  S NOD=$O(@CPTGLB@(CPTIEN,1,NOD)) Q:'NOD  S X=$P(^(NOD,0),U) I X]"" S LIST=LIST_DLM_X
 Q:$Q $E(LIST,2,999)  Q
 ;
MDLLST(CPTIEN,DLM) ; return DLM-delimited list of modality values for this CPT
 I +$G(CPTIEN)
 E  Q ""
 N LIST,CPTGLB S LIST=""
 S DLM=$E($G(DLM))
 I DLM="" S DLM="^"
 S CPTGLB=$NA(^MAG(2006.67))
 S NOD=0
 F  S NOD=$O(@CPTGLB@(CPTIEN,2,NOD)) Q:'NOD  S X=$P(^(NOD,0),U) I X]"" S LIST=LIST_DLM_X
 Q:$Q $E(LIST,2,999)  Q
 ;
 ;***** Returns server data to display in new "Image Display" window (P101.31).
 ; RPC: MAGJ MAGDATADUMP
 ;
 ;  DATA         REQUEST ^ PARAM1 | PARAM2
 ;
 ;  ..... REQUEST determines format:
 ;
 ;  ^01:  REQUEST           Literal string: [ CPT, FLDS, GLB ]
 ;
 ;  ^02:  if REQUEST="CPT":
 ;
 ;        |01:  PARAM1      CPT Code
 ;        |02:  [PARAM2]    ""
 ;
 ;  ^02:  if REQUEST="FLDS" or "GLB":
 ;
 ;        |01:  [PARAM1]    FileMan GETS^DIQ Flags (only if REQUEST="FLDS") *OR*
 ;        |02:  PARAM2      ImageIEN or Case_ID_String
 ;
 ;  Return Values:
 ;        0:N lines to display (Internal Imaging or CPT Match data).
 ;
DATADUMP(MAGGRY,DATA) ;
 ;
 ; Initialize. <*> Do NOT change name of EP.
 N $ETRAP,$ESTACK S $ETRAP="G ERR1^MAGJUTL4"
 N CT,DIQUIET,IMGIEN,INVALID,PARAM1,PARAM2,REQUEST
 S DIQUIET=1 D DT^DICRW
 K MAGGRY S MAGGRY=$NA(^TMP($J,"MAGJDATA")) K @MAGGRY
 ;
 ; Validate input.
 S INVALID=$$DDMPVLD8()
 ;
 ; Process then Exit, REPLYing with data or error code.
 I 'INVALID D
 . D DDMPROCS S REPLY=CT_U_"1~ "_CT_" lines of text returned for "_DATA
 . M @MAGGRY=XMM K XMM
 E  S REPLY="0^Invalid image data request: "_""""_DATA_""""_" (ck"_INVALID_")."
 S @MAGGRY@(0)=REPLY
 Q
 ;
 ;+++++ Process according to REQUEST. Called by DATADUMP.
 ; 
 ; Calls: GETS^MAGGTSYS, MAG^MAGGTSY1.
 ;
 ; Local array MM structures multiple calls' output for centralized processing.
 ; The array is re-subscripted by converting "," to "." allowing a single MERGE
 ; to the broker output global.
 ;   
 ;   MM(.1:.99) ... Header information.
 ;   MM(1) ........ CPT (similar) match(es).
 ;   MM(2) ........ CPT (BodyPart and Modality) match(es).
 ;   MM(3) ........ FLDS output data.
 ;   MM(4) ........ GLB output data.
 ;
DDMPROCS ;
 ;
 ; Initialize.
 S REPLY="0^Retrieving imaging internal data ..."
 ;
 ; Process. CPT request via MAG RAD CPT MATCHING File (#2006.67).
 I REQUEST="CPT" D DDMPRCPT(PARAM1)
 I REQUEST="FLDS" D GETS^MAGGTSYS(.M,IMGIEN,PARAM1) M MM(3)=@M K M
 I REQUEST="GLB" D MAG^MAGGTSY2(.M,IMGIEN) M MM(4)=@M K M
 ;
 ; Re-subscript array MM to simplify MERGE to broker output global.
 S CT=0,MMX=$NA(MM(.999)) F  S MMX=$Q(@MMX) Q:MMX=""  D  S CT=CT+1
 . S MXX="XMM("_$QS(MMX,1)_"."_(1000+$QS(MMX,2))_")" S @MXX=@MMX
 K MM,MMX,MXX
 Q
 ;
 ;+++++ Process a CPT request. Called by DDMPROCS.
 ;
 ; Calls CPT^ICPTCOD for CPT Description.
 ;
DDMPRCPT(CPT) ;
 ;
 ; Initialize.
 N FN,FN1,NDX,NOD,SS
 ;
 ; Set section headers.
 S MM(.1)="Input CPT Code ........... "_CPT_"  ("_$P($$CPT^ICPTCOD(CPT),U,3)_")."
 S MM(.2)="          Body Part(s) ... "
 S MM(.3)="          Modality(s) .... "
 ;
 ; Set primary CPT bodyPart & modality.
 S FN=2006.67,FN1=2006.671,NDX=$O(^MAG(FN,"B",CPT,""))
 S NOD=$NA(^MAG(FN,NDX,0)) F  S NOD=$Q(@NOD) Q:$QS(NOD,2)>NDX  I $QS(NOD,4)="B" D
 . I $QS(NOD,3)=1 S MM(.2)=MM(.2)_$G(^MAG(FN1,$QS(NOD,5),0))_"; "
 . I $QS(NOD,3)=2 S MM(.3)=MM(.3)_$P($G(^RAMIS(73.1,$QS(NOD,5),0)),U)_"; "
 . Q
 ;
 ; Strip dangling concatenators.
 F SS=.2,.3 S MM(SS)=$$ZRUPUNCT(MM(SS),"; ",".")
 ;
 ; Fetch CPTs matching on CPT.
 D CPTGRP(.M,CPT_"^1") M MM(1)=@M K M
 S MM(1,0)=$P(MM(1,0),"~ ",2)
 S MM(1,0)=$J(+$P(MM(1,0)," "),3)_" matching CPT(s) via similar CPT:"
 ;
 ; Fetch CPTs matching on BodyPart & Modality.
 D CPTGRP(.M,CPT_"^3") M MM(2)=@M K M
 S MM(2,0)=$P(MM(2,0),"~ ",2)
 S MM(2,0)=$J(+$P(MM(2,0)," "),3)_" matching CPT(s) via BODY PART and MODALITY:"
 ;
 ; Re-format. [Not modular -- should provide for leaving as-is.]
 S MMX=$NA(MM(.99)) F  S MMX=$Q(@MMX) Q:MMX=""  I @MMX["^" S @MMX="     "_$TR(@MMX,"^"," ")
 Q
 ;
 ;+++++ Validate. Called by DATADUMP.
 ;
DDMPVLD8() ;
 ;
 ; ... DATA string format or exit invalid (code 1).
 Q:'$D(DATA) 1
 Q:DATA="" 1
 Q:DATA'["^"!(DATA'["|") 1
 ;
 ; Initialize.
 N RACNI,RADFN,RADTI,RARPT S REPLY="0^Validating input parameters ..."
 S REQUEST=$P(DATA,U),PARAM1=$P($P(DATA,U,2),"|"),PARAM2=$P(DATA,"|",2)
 ;
 ; ... DATA string's REQUEST piece or exit (invalid: code 2).
 Q:"^CPT^FLDS^GLB^"'[(U_REQUEST_U) 2
 ;
 ; ... PARAM1 if REQUEST="CPT" or exit (invalid: code 3).
 I REQUEST="CPT" Q:'$D(^MAG(2006.67,"B",PARAM1)) 3
 ;
 ; ... PARAM1 if REQUEST="FLDS" or re-set to null. External call will set defaults.
 ; .......... only validate format of FileMan flags.
 I REQUEST="FLDS"&(PARAM1'?1U.U) S PARAM1=""
 ; 
 ; ... PARAM2 if REQUEST=("FLDS" or "GLB") or exit (invalid: code 4).
 I REQUEST="FLDS"!(REQUEST="GLB") S IMGIEN="" D  Q:IMGIEN="" 4
 . ;
 . ; Case 1: PARAM2 holds IMGIEN.
 . I PARAM2?1N.N,$D(^MAG(2005,PARAM2)) S IMGIEN=PARAM2 Q
 . ;
 . ; Case 2: PARAM2 holds RARPT in piece 4, set IMGIEN via back-pointer in File #74.
 . I $L(PARAM2,U)=4 S RARPT=$P(PARAM2,U,4),IMGIEN=$O(^RARPT(RARPT,2005,"B",""))
 . I IMGIEN'="",$D(^MAG(2005,IMGIEN)) Q
 . ;
 . ; Case 3: PARAM2 holds RADFN^RADTI^RACNI in pieces 1:3.
 . S RADFN=+PARAM2,RADTI=$P(PARAM2,U,2),RACNI=$P(PARAM2,U,3)
 . I RADFN,RADTI,RACNI D
 . . S RARPT=$P(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0),U,17)
 . . I RARPT'="",$D(^RARPT(RARPT,2005,"B"))>1 S IMGIEN=$O(^RARPT(RARPT,2005,"B",""))
 Q 0
 ;
 ;***** Check Exam Status.
 ; RPC: MAGJ RADSTATUSCHECK
 ;
STATCHK(MAGGRY,DATA) ;
 ; This may also be accessed by subroutine call. <*> do not change name of EP
 ; Exam Status check RPC and subroutine: determine if the exam has been Tech-Verified (at least).
 ; Images are assumed to be verified if Exam Status is Examined, or higher status.
 ;       ; Input in DATA: RADFN^RADTI^RACNI^RARPT
 ;   Input is either RADFN, RADTI, and RACNI; or, RARPT only may be input in piece 4
 ;   Return: Code^Text
 ;    0 = Problem, or exam was cancelled
 ;    1 = Not yet verified
 ;    2 = Tech Verified
 ;    3 = Radiologist Verified
 ;    4 = User is a Radiology professional--always allow access
 ;
 N $ETRAP,$ESTACK S $ETRAP="G ERR3^MAGJUTL4"
 N REPLY,STATUS,ORDER,VCAT,STOUT
 N DIQUIET,RARPT,RADFN,RADTI,RACNI
 S DIQUIET=1 D DT^DICRW
 S RADFN=$P(DATA,U),RADTI=$P(DATA,U,2),RACNI=$P(DATA,U,3),RARPT=$P(DATA,U,4)
 S STOUT="",REPLY="0^Getting image verification status."
 I RADFN,RADTI,RACNI
 E  I RARPT D RPT2DPT(RARPT,.X) I X S RADFN=+X,RADTI=$P(X,U,2),RACNI=$P(X,U,3) I RADFN,RADTI,RACNI
 E  S REPLY="0^Image Verification Status request contains invalid case pointer ("_DATA_")" G STATCHKZ
 S STATUS=$P($G(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0)),U,3)
 I STATUS="" S REPLY="0^Image Verification Status request error--no Exam Status is defined for ("_DATA_")" G STATCHKZ
 S VCAT=$P(^RA(72,STATUS,0),U,9),ORDER=$P(^(0),U,3)
 I VCAT]"" D  G STATCHK2:STOUT
 . I "EDT"[VCAT S STOUT=$S(VCAT="E":2,1:3) ; Examined or Interpreted
 . E  I VCAT="W" S STOUT=1 ; Not yet Verified
 I ORDER=9 S STOUT=3  ; Completed exam
 E  I ORDER=0 S REPLY="0^Exam Cancelled"
 E  I ORDER=1 S STOUT=1  ; Waiting for exam
STATCHK2 ;
 I STOUT<2 D
 . F X="S","R","T" I $D(^VA(200,"ARC",X,DUZ)) S STOUT=4 Q  ; Radiologist or Tech -- OK to access
STATCHKZ ;
 I STOUT S REPLY=STOUT_U_$S(STOUT=1:"Images not yet verified",STOUT=2:"Images verified by Technologist",STOUT=3:"Images interpreted by Radiologist",STOUT=4:"Radiology professional--OK to view images.",1:"")
 S MAGGRY=REPLY
 Q
 ;
 ;***** User set/clear flag to show/not show remote exams only.
 ; RPC: MAGJ REMOTESCREEN
 ;
REMSCRN(MAGGRY,DATA) ;
 ; Input in DATA: 1/0 1=show remote only; 0=show all exams
 ; Return: Reply^Code~msg
 ;    Reply -- 0=Problem; 1=Success
 ;    Code -- 4=Error; 1=ok
 ;    msg -- display text if error
 ;
 N $ETRAP,$ESTACK S $ETRAP="G ERR3^MAGJUTL4"
 N REPLY
 N DIQUIET S DIQUIET=1 D DT^DICRW
 I $D(DATA),(DATA=0!(DATA=1))
 E  S REPLY="0^4~REMOTESCREEN request has invalid parameter ("_$G(DATA)_")" G REMSCRNZ
 S MAGJOB("REMOTESCREEN")=DATA,REPLY="1^1~"_DATA
REMSCRNZ ;
 S MAGGRY=REPLY
 Q
 ;
RPT2DPT(RARPT,RET) ; Input RARPT. Return RET containing exam ss values for ^RADPT
 ;
 N DFN,DTI,CNI S (DFN,DTI,CNI)=""
 I RARPT?1N.N,$D(^RARPT(RARPT)) S X=$G(^(RARPT,0)) I X]"" D
 . S X=$P(X,U)
 . S X=$O(^RADPT("ADC",X,0)) I X S DFN=X,DTI=$O(^(X,0)),CNI=$O(^(DTI,0))
 . S RET=DFN_U_DTI_U_CNI
 E  S RET=""
 Q
 ;
ERR1 N ERR S ERR=$$EC^%ZOSV S @MAGGRY@(0)="0^4~"_ERR G ERR
ERR3 N ERR S ERR=$$EC^%ZOSV S MAGGRY="0^4~"_ERR
ERR D @^%ZOSF("ERRTN")
 Q:$Q 1  Q
 ;
END Q  ;
 ;
 ;***** Identify if mammogram via CPT Code. Called by OPENCASE^MAGJEX1.
 ;
 ; Calls ZRUMDLST, $$CPT^ICPTCOD (which may return "-1^NO SUCH ENTRY").
 ;
 ; CPT     CPT Code
 ;
 ; Return Value:
 ;      0  NOT a mammogram.
 ;      1  IS  a mammogram.
 ;
ZRUMAMMO(CPT) ;
 N CPTCATIEN,YN S YN=0
 S CPTCATIEN=$P($$CPT^ICPTCOD(CPT),U,4) Q:CPTCATIEN="" YN Q:+CPTCATIEN<0 YN
 ;
 ; Criterion (1A): CPT Category (cf., ^DIC(81.1,240,0)=BREAST MAMMOGRAPHY^s^4^77051^77059^C).
 I $P(^DIC(81.1,CPTCATIEN,0),U)="BREAST MAMMOGRAPHY" S YN=1 D
 . ;
 . ; Criterion (1B): CPT "Modality" (using MAGS array's modalities via ZRUMDLST).
 . N MODALITY
 . D ZRUMDLST(.MAGS) I '$D(MAGMDLST) S YN=1 Q
 . F MODALITY="MR","OCT","US" S:$D(MAGMDLST(MODALITY)) YN=0
 ;
 ; Criterion (2) -- Deprecated mammography CPTs.
 E  D
 . N CPTMAM F CPTMAM=76082,76083,76085:1:76092 I CPT=CPTMAM S YN=1 Q
 Q YN
 ;
 ;+++++ Array any unique MAGS' piece 3 modalities. Called by ZRUMAMMO.
 ;
 ; .MAGS      Array of individual image data (cf. JBFETCH^MAGJUTL2).
 ; 
 ; Sets array MAGMDLST(modality).
 ; 
ZRUMDLST(MAGS) ;
 K MAGMDLST
 I $D(MAGS),MAGS N MD0,X F X=1:1:MAGS D
 . S MD0=$P(MAGS(X),U,3) I MD0'="",'$D(MAGMDLST(MD0)) S MAGMDLST(MD0)=""
 Q
 ;
 ;+++++ Strip IN's trailing elements & append REPL.
 ;
 ; IN       String to operate on.
 ; REPL     String to place at right end.
 ; STRIP    String to remove from right end.
 ;
 ; Returns:
 ;      IN_REPL
 ;
ZRUPUNCT(IN,STRIP,REPL) ;
 Q:'$D(IN)!('$D(STRIP))!('$D(REPL))  F  Q:STRIP'[$E(IN,$L(IN))  S IN=$E(IN,1,$L(IN)-1)
 Q IN_REPL
 ;
 ; ***** Query to modify existing annotations. Called by OPENCASE^MAGJEX1
 ; 
 ; DUZ      Kernel internal user identifier.
 ; RACNI    RAD/NUC Med Patient File (#70) Case Number Index
 ; RADFN    "                              Patient DFN
 ; RADTI    "                              Study Internal Date
 ; 
 ; Return Value:
 ;      0   NOT authorized to annotate.
 ;      1   AUTHORIZED     "".
 ; 
ZRUREVAN(RADFN,RADTI,RACNI) ;
 ;
 ; Initialize. Exit if RAxxx pointers fail.
 N EXAMSTAT,EXMSTSPT,RADNOD,RIST1,RIST2,YN
 S YN=0,RADNOD=$G(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0))
 Q:RADNOD="" YN
 ;
 ; Collect data about ...
 S RIST1=$P(RADNOD,U,12) ; .. PRIMARY INTERPRETING RESIDENT [12P:200]
 S RIST2=$P(RADNOD,U,15) ; .. PRIMARY INTERPRETING STAFF [15P:200]
 S EXMSTSPT=$P(RADNOD,U,3) ;. EXAM STATUS [3P:72]
 S EXAMSTAT=$P($G(^RA(72,EXMSTSPT,0)),U,9) ; VISTARAD CATEGORY (#9)
 ;
 I EXAMSTAT="D"!(EXAMSTAT="T") D
 . ;
 . ; 'Yes' if CurrentUser=Primary Interpreting Radiologist.
 . I DUZ=RIST1!(DUZ=RIST2) S YN=1
 . E  I RIST1'="",$D(^VA(200,"ARC","S",+DUZ)) S YN=1 ; 'Yes' if (Primary Interpreting Radiologist is Resident) & (CurrentUser is Staff)
 . Q
 Q YN
