MAGNPCHE ;WOIFO/NST - Pre-Cach RPC calls; OCT 18, 2018@4:05 PM
 ;;3.0;IMAGING;**221**;Mar 19, 2002;Build 27;May 23, 2012
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
 ;***** PRE-CACHE PATIENT EXAM BY CPT
 ;
 ; RPC: MAGN PRECACHE BY CPT
 ;
 ; .MAGOUT   Reference to a local variable where the results are returned to
 ; IDTYPE    - "DFN" or "ICN"
 ; ID        = Patient DFN or ICN
 ; CPT       - CPT Code to search for prior patient exams
 ;
 ; Return Values
 ; =============   
 ; MAGRY(0) if error 0^error message
 ; MAGRY(1..n) = SITE NUMBER ^ DFN ^ ICN ^ CPRSCONTEXTID 
 ;
PRECACHE(MAGRY,IDTYPE,ID,CPT) ; RPC [MAGN PRECACHE BY CPT]
 N DFN,BEGDT,CHK,CNT,LIMYRS,LIMEXAMS,IDAT,MAGRET,RADATA,RARPT,MAGCPTS,Y
 ;
 N $ETRAP,$ESTACK S $ETRAP="D ERR^MAGGSERR"
 ;
 S MAGRY(0)=1
 ;
 S CNT=0
 I (IDTYPE'="DFN")&(IDTYPE'="ICN") S MAGRY(0)="0^Invalid IDTYPE "_IDTYPE Q
 ;
 S DFN=$G(ID)
 I IDTYPE="ICN" D
 . S DFN=$S($T(GETDFN^MPIF001)'="":$$GETDFN^MPIF001(ID),1:"-1^NO MPI") ; Supported IA (#2701)
 . Q
 I DFN'>0 S MAGRY(0)="0^Error: "_DFN Q
 ;
 S MAGCPTS=$$GETCPTS(CPT)
 I 'MAGCPTS Q  ; No rules defined for CPT
 ;
 S LIMYRS=30    ; default limit
 S LIMEXAMS=100 ; default # Exams
 S BEGDT=($E(DT,1,3)-LIMYRS)_$E(DT,4,7)
 I BEGDT<2950101 S BEGDT=2950101 ; 2 yrs prior to earliest VistaPACS
 D GETEXAM3^MAGJUTL1(DFN,BEGDT,"",0,.MAGRET,"",LIMEXAMS)  ; Get Patient's exams
 S IDAT=""
 F  S IDAT=$O(^TMP($J,"MAGRAEX",IDAT)) Q:'IDAT  D
 . S RADATA=^TMP($J,"MAGRAEX",IDAT,1)
 . S CHK=$$MATCHED(MAGCPTS,RADATA)
 . I CHK D
 . . S RARPT=+$P(RADATA,U,10)
 . . S CNT=CNT+1,MAGRY(CNT)=$$GCPRSID^MAGNUTL2(RARPT)  ; pre-cache exams
 . . Q
 . Q
 ;
 K ^TMP($J,"MAGRAEX"),^TMP($J,"RAE1")
 Q
 ;
GETCPTS(CPT)  ; Get CPT to search for
 ; CPT - CPT to search for
 N CPT3,CPT4,CPT5,MAGMATCH,X,Y
 S MAGMATCH=""
 S CPT5=CPT,CPT4=$E(CPT,1,4),CPT3=$E(CPT,1,3)
 S Y=""
 ;  Order of CPT5/4/3 is important for the algorithm, which
 ;  uses the 1st rule found at the LOWEST level of detail defined
 F X=CPT5,CPT4,CPT3 I $D(^MAG(2006.65,"B",X)) S Y=Y_$S(Y:",",1:"")_X S $P(MAGMATCH,U)=Y
 Q MAGMATCH
 ;
MATCHED(MAGCPTS,RADATA) ;
 ; Compare the patient's exams CPT codes to the
 ; MAGCPTS CPT code, according to dictionary 2006.65
 N RADFN,RARPT,RADTI,RACNI,RAIMGTYP,X,Y
 N CPT,MAGMATCH,MAGDTH
 S RADFN=$P(RADATA,U,1)
 S RARPT=+$P(RADATA,U,10)
 S RADTI=$P(RADATA,U,2)
 S RACNI=$P(RADATA,U,3)
 ;Q:$P(RADATA,U,15)<2 ""          ; Cancel or Waiting
 S CPT=$P(RADATA,U,17)
 Q:'CPT  ;  algorithm REQUIRES CPT codes be used
 ;
 S MAGMATCH=$$CPTMATCH(MAGCPTS,CPT)
 ;
 Q MAGMATCH
 ;
CPTMATCH(MAGCPTS,CPT) ; Find CPT match
 N CPT3,CPT4,CPT5,CURCPTS,CURCPTX,HIT,MAGMATCH,X,Y,I
 ;
 I ('CPT)!('MAGCPTS) Q ""  ; No CPT
 ;
 S CURCPTS=MAGCPTS
 S CPT5=CPT,CPT4=$E(CPT,1,4),CPT3=$E(CPT,1,3)
 S MAGMATCH=""
 S HIT=0
 F  Q:CURCPTS=""  S CURCPTX=$O(^MAG(2006.65,"B",$P(CURCPTS,","),"")),CURCPTS=$P(CURCPTS,",",2,9) I CURCPTX]"" D  Q:HIT  ; 1st hit only
 . ;  This algorithm checks from lowest detail to most general, and acts
 . ;  on the information found at the FIRST Hit only
 . F CPT="CPT5","CPT4","CPT3" Q:HIT  D  ;1st hit only
 . . S CPT=@CPT
 . . I CPT]"",$D(^MAG(2006.65,CURCPTX,1,"B",CPT)) D
 . . . S HIT=1
 . . . S X=$O(^MAG(2006.65,CURCPTX,1,"B",CPT,"")) D
 . . . . S X=^MAG(2006.65,CURCPTX,1,X,0) S Y=5,X=$P(X,U,Y,Y+2)
 . . . . I +X S MAGMATCH=CPT F I=2,3 S $P(MAGMATCH,U,I)=$P(X,U,I)
 . . . . Q
 . . . Q
 . . Q
 . Q
 Q MAGMATCH
