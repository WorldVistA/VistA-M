MAGJEX2 ;;WIRMFO/JHC Rad. Workstation RPC calls;[ 02/25/2000  4:40 PM ] ; 09 Jun 2003  2:58 PM
 ;;3.0;IMAGING;**51,18,76**;Jun 22, 2007;Build 19
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
 ; Subroutines for pre-fetch/ auto-display prior exams' images
 ; Entry Points:
 ;   PRIOR1  -- Pre-Fetch/Auto-Display images for other related cases;
 ;    RPC Call: MAGJ PRIOREXAMS
 ;   PREFETCH -- Pre-Fetch initiated from 
 ;
 Q
ERR N ERR S ERR=$$EC^%ZOSV S MAGGRY(0)="0^Server Program Error: "_ERR
 D @^%ZOSF("ERRTN")
 Q:$Q 1  Q
PREFETCH ; Entry point from HL7 processing, to initiate prefetch at
 ; time of radiology "Register Patient for Exam" function
 ; Do not process if the exam is being Canceled (RACANC true)
 ;
 N RET S RET=""
 I '$P($G(^MAG(2006.69,1,0)),U,5) G PREFQ          ; Prefetch disabled
 I '($G(RADFN)&$G(RADTI)&$G(RACNI)&'$G(RACANC)) G PREFQ ; Required vars
 D PRIOR1(.RET,"P"_U_RADFN_U_RADTI_U_RACNI)
PREFQ ; W !,"End PRE-FETCH RET=" N JHC R JHC ZW RET
 Q
 ;
PRIOR1(MAGGRY,DATA) ; review all exams for a patient to find "related" exams
 ; This ep also called as subroutine from routing software (P51)
 ; MAGGRY - return array of exams to PreFetch, or Auto-send to RAD W/S
 ; DATA:  - input params for the Current Exam
 ;   1) ACTION = P -- Pre-fetch Exams (from Jukebox to Magnetic Disk)
 ;             = A -- Auto-route priors
 ;   2) RADFN  = Case pointers to Rad/Nuc Med Patient file 
 ;   3) RADTI  =  ""        ""         ""          ""
 ;   4) RACNI  =  ""        ""         ""          ""
 ;   5) RARPT  - Case pointer to ^RARPT global
 ;
 N $ETRAP,$ESTACK S $ETRAP="D ERR^MAGJEX2"
 K MAGGRY
 N RADFN,RADTI,RACNI,RARPT,RADATA
 N DAYCASE,DIQUIET,ACTION,CPT,HDR,MAGDFN,MAGDTI,MAGCNI,MAGRET,MAGRACNT
 S ACTION=$P(DATA,U)
 I ACTION="P"!(ACTION="A")
 E  S MAGGRY(0)="0^Invalid Request (Action code="_ACTION_")" G PRIOR1Z
 S MAGDFN=$P(DATA,U,2),MAGDTI=$P(DATA,U,3),MAGCNI=$P(DATA,U,4)
 I MAGDFN,MAGDTI,MAGCNI
 E  S MAGGRY(0)="0^Request Contains Invalid Case Pointer ("_DATA_")" G PRIOR1Z
 S DIQUIET=1 D DT^DICRW
 N MAGJOB D MAGJOBNC^MAGJUTL3
 S HDR=$S(ACTION="P":"Pre-fetch",ACTION="A":"Auto-Display",1:"???")_" Prior Exams for CASE: "
 I '$D(^DPT(MAGDFN,0)) S MAGGRY(0)="0^Request Contains Invalid Patient Pointer ("_MAGDFN_")" G PRIOR1Z
 I $D(^RADPT(MAGDFN,"DT",MAGDTI,"P",MAGCNI))
 E  S MAGGRY(0)="0^Request Contains Invalid Case Pointer ("_MAGCNI_")" G PRIOR1Z
 S MAGRACNT=0
 S MAGGRY(0)="0^Compiling Prior Radiology Exams"
 D GETEXAM2^MAGJUTL1(MAGDFN,MAGDTI,MAGCNI,"",.MAGRET) ; Current Exam only
 S RADFN=MAGDFN,RADTI=MAGDTI,RACNI=MAGCNI
 I 'MAGRET S MAGGRY(0)="0^Current Case is Not Accessible" G PRIOR1Z
 S RADATA=$G(^TMP($J,"MAGRAEX",1,1)) S DAYCASE=$P(RADATA,U,12) D SVMAG2A
 I 'MAGGRY(0) S MAGGRY(0)="0^Current Case either has no CPT code, or has no rules defined for its CPT code." G PRIOR1Z
 S HDR=HDR_DAYCASE
 D SRCH(MAGDFN)  ;  Search prior exams for this patient
PRIOR1Z ;
 I 'MAGGRY(0) S:(MAGGRY(0)["Compiling") MAGGRY(0)="0^No Exams Found"
 E  I +MAGGRY(0)=1 S MAGGRY(0)="0^No Prior Exams Found" K MAGGRY(1)
 E  D SVMAG2B
 K ^TMP($J,"MAGRAEX"),^("RAE1")
 Q
 ;
SRCH(RADFN) ; Traverse all exams for a patient, up to limits of age & total
 ; numbers of exams to consider
 N BEGDT,LIMYRS,LIMEXAMS,X
 S X=$G(^MAG(2006.69,1,0))
 S LIMYRS=+$P(X,U,14),LIMEXAMS=+$P(X,U,15)
 S:'LIMYRS LIMYRS=7 S:'LIMEXAMS LIMEXAMS=50 ; default limit # Exams
 S BEGDT=($E(DT,1,3)-LIMYRS)_$E(DT,4,7)
 I BEGDT<2950101 S BEGDT=2950101 ; 2 yrs prior to earliest VistaPACS
 S MAGRACNT=1 D GETEXAM3^MAGJUTL1(RADFN,BEGDT,"",.MAGRACNT,.MAGRET,"",LIMEXAMS)
 I MAGRET N IDAT S IDAT=1 D
 . F  S IDAT=$O(^TMP($J,"MAGRAEX",IDAT)) Q:'IDAT  S RADATA=^(IDAT,1) D
 .. S RADTI=$P(RADATA,U,2),RACNI=$P(RADATA,U,3)
 .. I RADTI=MAGDTI&(RACNI=MAGCNI) Q  ; skip current case
 .. D SVMAG2A
 Q
 ;
SVMAG2A ; 2A and 2B used by subroutine at tag PRIOR1
 ; Find all the patient's exams whose CPT codes are related to the
 ; Current exam's CPT code, according to dictionary 2006.65
 N RAIMGTYP
 N CPT,CPT3,CPT4,CPT5,CURCPTX,CURCPTS,HIT,MAGMATCH,MAGDTH
 S RARPT=+$P(RADATA,U,10)
 I MAGGRY(0) Q:'$P(MAGGRY(1),U)           ;  Cur Case CPT not in map file
 I  Q:(ACTION="P")&'$D(^RARPT(RARPT,2005))  ; nothing to pre-fetch
 I  Q:$P(RADATA,U,15)<2          ; Cancel or Waiting
 ;   Note: if no images, may still want to do Auto-Disp to get Report;
 ;      also, Current Case should still proceed
 S CPT=$P(RADATA,U,17)
 Q:'CPT  ;  algorithm REQUIRES CPT codes be used
 S CPT5=CPT,CPT4=$E(CPT,1,4),CPT3=$E(CPT,1,3)
 S MAGMATCH="^^"
 I 'MAGGRY(0) D  Q:'MAGMATCH  ; No rules defined for Cur. Case's CPT
 . S Y=""
 .  ;  Order of CPT5/4/3 is important for the algorithm, which
 .  ;  uses the 1st rule found at the LOWEST level of detail defined
 . F X=CPT5,CPT4,CPT3 I $D(^MAG(2006.65,"B",X)) S Y=Y_$S(Y:",",1:"")_X S $P(MAGMATCH,U)=Y
 I CPT,MAGGRY(0) D
 .  ; curcpts has the cpt5/4/3 list generated above for Cur. Case CPT's
 . S HIT=0,CURCPTS=$P(MAGGRY(1),U)
 . F  Q:CURCPTS=""  S CURCPTX=$O(^MAG(2006.65,"B",$P(CURCPTS,","),"")) S CURCPTS=$P(CURCPTS,",",2,9) I CURCPTX]"" D  Q:HIT  ; 1st hit only
 .. ;  This algorithm checks from lowest detail to most general, and acts
 .. ;  on the information found at the FIRST Hit only
 .. F CPT="CPT5","CPT4","CPT3" S CPT=@CPT I CPT]"",$D(^MAG(2006.65,CURCPTX,1,"B",CPT)) S X=$O(^(CPT,"")) D  S HIT=1 Q  ;1st hit only
 ... S X=^MAG(2006.65,CURCPTX,1,X,0) S Y=$S(ACTION="A":2,1:5),X=$P(X,U,Y,Y+2)
 ... I +X S MAGMATCH=CPT F I=2,3 S $P(MAGMATCH,U,I)=$P(X,U,I)
 ;         sample of logic file:
 ; ^MAG(2006.65,1,0) = 730
 ; ^MAG(2006.65,1,1,0) = ^12000011.01^2^2
 ; ^MAG(2006.65,1,1,1,0) = 730^1^40^6^1^120^10
 ; ^MAG(2006.65,1,1,2,0) = 732^1^40^2^1^120^4
 ; ^MAG(2006.65,1,1,"B",730,1) =
 ; ^MAG(2006.65,1,1,"B",732,2) =
 ; ^MAG(2006.65,"B",730,1) =
 ;
 Q:'MAGMATCH
 ; 1  RADFN   RADTI    RACNI   RANME   RASSN    <-- from GETEXAM
 ; 6  RADATE  RADTE    RACN    RAPRC   RARPT
 ; 11 RAST    DAYCASE  RAELOC  RASTP   RASTORD
 ; 16 RADTPRT RACPT    RAIMGTYP
 S MAGDTH=$$FMTH^XLFDT($P(RADATA,U,7),1)
 S X=$P(RADATA,U,18)
 S RAIMGTYP=$S(X]"":$O(^RA(79.2,"C",X,"")),1:X)
 S Y=MAGGRY(0)+1,$P(MAGGRY(0),U)=Y,MAGGRY(Y)=MAGMATCH_U_MAGDTH_U_U_$P(RADATA,U,9)_U_RAIMGTYP_U_RADFN_U_RADTI_U_RACNI_U_RARPT_U_$P(RADATA,U,12)_U_$P(RADATA,U,11)
 Q
 ;
SVMAG2B ; For exams whose CPTs match, select a subset that are within defined
 ; limits with respect to time interval & maximum # exams to retrieve
 ; Return MAGGRY(0) =  count ^ message
 ;        MAGGRY(1:N) = "M08" | RADFN ^ RADTI ^ RACNI ^ RARPT
 N CPT,CT,CURDAT,ICPT,IREC,GO
 S CURDAT=$P(MAGGRY(1),U,4)
 F IREC=2:1:MAGGRY(0) S X=MAGGRY(IREC),CPT=+X D  K MAGGRY(IREC)
 . I $P(X,U,2) S Y=CURDAT-$P(X,U,4) S:Y<0 Y=-Y I Y>$P(X,U,2) Q  ;too old
 . S Y=$G(GO(CPT))+1 I CPT,(Y>$P(X,U,3)) Q  ; already have enough cases
 . S GO(CPT)=Y,GO(CPT,Y)=X
 K MAGGRY
 I $D(GO) S CT=0,CPT="" D
 . F  S CPT=$O(GO(CPT)) Q:CPT=""  F ICPT=1:1:GO(CPT) D
 .. S CT=CT+1,X=GO(CPT,ICPT),RARPT=$P(X,U,11)
 .. S MAGGRY(CT)="M08^"_CPT_"|"_$P(X,U,8,11)
 .. I ACTION="P"!(ACTION="A") S Y=$$JBFETCH^MAGJUTL2(RARPT)  ; fetch from jukebox
 . S MAGGRY(0)=CT_"^"_HDR
 E  S MAGGRY(0)="0^No Exams Found for "_HDR
 Q
 ;
END ;
