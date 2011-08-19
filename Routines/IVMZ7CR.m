IVMZ7CR ;BAJ,ERC - HL7 Z07 CONSISTENCY CHECKER -- REGISTRATION SUBROUTINE ; 12/6/07 8:51am
 ;;2.0;INCOME VERIFICATION MATCH;**105,127,132**;JUL 8,1996;Build 1
 ;
 ; Registration Consistency Checks
 Q       ; Entry point must be specified
EN(DFN,DGP,DGSD) ;Entry point
 ;  input:  DFN - Patient IEN
 ;          DGP - Patient data array
 ;          DGSD - Spouse and Dependent data array
 ; output: ^TMP($J,DFN,RULE) global
 ;          DFN - Patient IEN
 ;          RULE - Consistency rule #
 ;initialize variables
 N RULE,Y,X,FILERR,SPDEP
 S SPDEP=$D(DGSD("DEP"))
 ; we do not count through all numbers to save routine space
 F RULE=4,7,9,11,13,15,16,19,24,29:1:31,34,60,72,74,75,76,78,81,83,85,86 I $D(^DGIN(38.6,RULE)) D
 . I $$ON(RULE) D @RULE
 I $D(FILERR) M ^TMP($J,DFN)=FILERR
 Q
4 ; DOB UNSPECIFIED
 ; Note: RULE #302 in IVMZ7CD is a duplicate of this rule
 N RIEN
 I $P($G(DGP("PAT",0)),U,3)="" S FILERR(RULE)=""
 I 'SPDEP Q
 S RIEN=0 F  S RIEN=$O(DGSD("DEP",RIEN)) Q:RIEN=""  D
 . I $P(DGSD("DEP",RIEN,0),U,3)="" S FILERR(RULE)=""
 Q
7 ; SSN UNSPECIFIED
 ; Note: RULE #305 in IVMZ7CD is a duplicate of this rule
 I $P($G(DGP("PAT",0)),U,9)="" S FILERR(RULE)=""
 Q
9 ; VETERAN STATUS UNSPECIFIED
 I $P($G(DGP("PAT","VET")),U)="" S FILERR(RULE)=""
 Q
11 ; SC PROMPT INCONSISTENT
 N VET,SC,PTYPE
 ; If VET Status is not specified (RULE 9) no need for this test
 Q:$P($G(DGP("PAT","VET")),U)=""
 S VET=$P(DGP("PAT","VET"),U,1)="Y",SC=$P(DGP("PAT",.3),U,1)="Y"
 I 'VET,SC S FILERR(RULE)=""
 Q
13 ; POS UNSPECIFIED
 ; Note: Rule #413 IN IVMZ7CE is a duplicate of this rule
 Q:$P($G(DGP("PAT","VET")),U,1)'="Y"
 ; Make sure that the value in the field is valid -- DGRPC does this as well
 I '$D(^DIC(21,+$P(DGP("PAT",.32),U,3),0)) S FILERR(RULE)=""
 Q
15 ; INEL REASON UNSPECIFIED
 ; Note: Rule #404 IN IVMZ7CE is a duplicate of this rule
 I $P(DGP("PAT",.15),U,2),$P($G(DGP("PAT",.3)),U,7)="" S FILERR(RULE)=""
 Q
16 ; DATE OF DEATH IN FUTURE
 ; Note: Rule #308 IN IVMZ7CD is a duplicate of this rule
 S X=$P($G(DGP("PAT",.35)),U) I X']"" Q
 ; Compare DOD to right now
 I X>$$NOW^XLFDT S FILERR(RULE)=""
 Q
19 ; ELIG/NONVET STAT INCONSISTENT
 ; Note: Rule #405 in IVMZ7CE is a duplicate of this rule
 N VET,ELIG,FILE8,FILE81,MPTR,MTYPE,PTYPE
 ; Patient's VET status
 S VET=$P($G(DGP("PAT","VET")),U,1) I VET="" S FILERR(RULE)="" Q
 ; do this check for NON-VET status only
 Q:VET="Y"
 ; Check PT type to see if we skip VET checks
 S PTYPE=$P($G(DGP("PAT","TYPE")),U,1)
 I PTYPE]"",$P(^DG(391,PTYPE,0),U,2) Q
 ; Eligibility Code
 S ELIG=$P($G(DGP("PAT",.36)),U,1) I ELIG="" S FILERR(RULE)="" Q
 ;start in File #8
 S FILE8=$G(^DIC(8,ELIG,0)) I FILE8="" S FILERR(RULE)="" Q
 ;using the pointer value in field #8 (node 0; piece 9)
 S MPTR=$P(FILE8,U,9)
 ;find the record in File #8.1
 S FILE81=$G(^DIC(8.1,MPTR,0)) I FILE81="" S FILERR(RULE)="" Q
 ;check the Type field #4 (node 0; piece 5). 
 S MTYPE=$P(FILE81,U,5)
 ; Pt's VET status must match NON-VET Status of Eligibility Code
 I VET'=MTYPE S FILERR(RULE)=""
 Q
24 ; POS/ELIG CODE INCONSISTENT
 ; Note: Rule #412 in IVMZ7CE is a duplicate of this rule
 I '$D(^DIC(21,+$P(DGP("PAT",.32),U,3),"E",+$P(DGP("PAT",.36),U,1))) S FILERR(RULE)=""
 Q
29 ; A&A CLAIMED, NONVET
 I $P(DGP("PAT","VET"),U,1)'="Y",$P($G(^DPT(DFN,.362)),U,12)="Y" S FILERR(RULE)=""
 Q
30 ; HOUSEBOUND CLAIMED, NONVET
 I $P(DGP("PAT","VET"),U,1)'="Y",$P($G(^DPT(DFN,.362)),U,13)="Y" S FILERR(RULE)=""
 Q
31 ; VA PENSION CLAIMED, NONVET
 I $P(DGP("PAT","VET"),U,1)'="Y",$P($G(^DPT(DFN,.362)),U,14)="Y" S FILERR(RULE)=""
 Q
34 ; POW CLAIMED, NONVET
 I $P(DGP("PAT","VET"),U,1)'="Y",$P($G(^DPT(DFN,.52)),U,5)="Y" S FILERR(RULE)=""
 Q
60 ; AGENT ORANGE EXP LOC MISSING
 ; Note: Rule #512 in IVMZ7CS is a duplicate of this rule.
 I $P(DGP("PAT",.321),U,2)="Y",$P(DGP("PAT",.321),U,13)="" S FILERR(RULE)=""
 Q
72 ; MSE DATA MISSING/INCOMPLETE, turned off with DG*5.3*765
 ; Note: Rule #513 in IVMZ7CS is a duplicate of this rule.
 N I,X
 S X=DGP("PAT",.32)
 F I=4,5,8 I $P(X,U,I)'="",'$$YY^IVMZ7CS($P(X,U,6)) S FILERR(RULE)="" Q     ;LAST
 F I=9,10,13 I $P(X,U,I)'="",'$$YY^IVMZ7CS($P(X,U,11)) S FILERR(RULE)="" Q  ;NTL
 F I=14,15,18 I $P(X,U,I)'="",'$$YY^IVMZ7CS($P(X,U,11)) S FILERR(RULE)=""   ;NNTL
 Q
 ;
74 ; CONFLICT DT MISSING/INCOMPLETE, turned off with DG*5.3*765 
 ; Note:#515 IVMZ7CS is a duplicate, turned off with DG*5.3*771
75 ; ALSO # 75 CONFLICT TO DT BEFORE FROM DT
76 ;      # 76 INACCURATE CONFLICT DATE, turned off with DG*5.3*771
 ; 
 N I,T,FROM,TO,NODE,PCE,PCEFR,PCETO,CONFL,RANGE,RFR,RTO,RNGE,ERR,COM,ON74,ON75,ON76
 S ON74=$$ON(74),ON75=$$ON(75),ON76=$$ON(76)
 S I=$$RANGE^DGMSCK()    ; load range table
 F I=1:1 S CONFL=$P($T(CONLIST+I),";;",3) Q:CONFL="QUIT"  D
 . ;we have to have a flag ERR because we don't want multiple
 . ;inconsistencies on a single conflict but we do want to
 . ;flag a single inconsistency on multiple conflicts
 . S ERR=0
 . S NODE=$P(CONFL,U,1),PCE=$P(CONFL,U,2),PCEFR=$P(CONFL,U,3),PCETO=$P(CONFL,U,4)
 . S RNGE=$P(CONFL,U,5)
 . Q:$P(DGP("PAT",NODE),U,PCE)'="Y"
 . S FROM=$P(DGP("PAT",NODE),U,PCEFR),TO=$P(DGP("PAT",NODE),U,PCETO)
 . ; check rule 74 CONFLICT DT MISSING/INCOMPLETE
 . I ON74,(RULE=74) F T=FROM,TO I '$$YM^IVMZ7CS(T) S FILERR(RULE)="",ERR=1
 . Q:ERR
 . ; check rule 75 CONFLICT TO DT BEFORE CONFLICT FROM DT
 . I ON75,(RULE=75),(FROM>TO) S FILERR(RULE)="",ERR=1
 . Q:ERR
 . ; check rule 76 INACCURATE CONFLICT DATE
 . Q:ERR
 . Q:'$D(RANGE(RNGE))  ; can't calculate if range table is missing
 . ; determine whether dates are withing conflict range
 . S RFR=$P(RANGE(RNGE),U,1),RTO=$P(RANGE(RNGE),U,2)
 . I ON76,(RULE=76) D
 . . I '((RFR'>FROM)&((RTO'<TO))) S FILERR(RULE)=""
 Q
78 ; INACCURATE COMBAT DT/LOC, turned off with DG*5.3*771
 N I,T,FROM,TO,RULE,NODE,PCE,PCEFR,PCETO,CONFL,RANGE,RFR,RTO,RNGE,ERR,COM,ON78,LOC
 ; This tag checks COMBAT status and verifies that valid FROM & TO dates are found
 S RULE=78
 I '$$ON(RULE) Q
 S I=$$RANGE^DGMSCK()    ; load range table
 F I=1:1 S CONFL=$P($T(COMLIST+I),";;",3) Q:CONFL="QUIT"  D
 . S NODE=$P(CONFL,U,1),PCE=$P(CONFL,U,2),PCEFR=$P(CONFL,U,3),PCETO=$P(CONFL,U,4)
 . S RNGE=$P(CONFL,U,5)
 . ; if we have COMBAT data, get Service Location info, it comes under a different rule
 . Q:$P(DGP("PAT",NODE),U,PCE)'="Y"
 . S RNGE=$$COMPOW^DGRPMS($P(DGP("PAT",.52),U,12)) I $G(RNGE)="" S FILERR(RULE)="" Q
 . S FROM=$P(DGP("PAT",NODE),U,PCEFR),TO=$P(DGP("PAT",NODE),U,PCETO)
 . ; determine whether Pt dates are within conflict range for specified location
 . S RFR=$P(RANGE(RNGE),U,1),RTO=$P(RANGE(RNGE),U,2)
 . I '(RFR'>FROM&((FROM'>RTO)&((RTO'<TO)&((TO'<RFR))))) S FILERR(RULE)=""
 Q
81 ; COMBAT DT NOT WITHIN MSE, turned off with DG*5.3*765
 ; this code is copied from DGRP3
 ; MSFROMTO^DGMSCK creates a block for a continual MSE
 N MSE,MSECHK,MSESET,ANYMSE,DGP81
 I '$P($G(DGP("PAT",.52)),U,12) Q
 ;
 ; we're calling into DG Legacy code so we have to modify some arrays
 M DGP81=DGP K DGP
 M DGP=DGP81("PAT")
 ; set up the check
 S:'$G(MSECHK) MSECHK=$$MSCK^DGMSCK S:'$G(MSESET) MSESET=$$MSFROMTO^DGMSCK
 ; If COMBAT, but no MSE, then Range is NOT within MSE
 I '$G(ANYMSE) D  Q
 . S FILERR(RULE)=""
 . K DGP M DGP=DGP81
 I '$$RWITHIN^DGRPDT($P(MSESET,U,1),$P(MSESET,U,2),$P($G(DGP81("PAT",.52)),U,13),$P($G(DGP81("PAT",.52)),U,14)) S FILERR(RULE)=""
 K DGP M DGP=DGP81
 Q
 ;
83 ; BOS REQUIRES DATE W/IN WWII
 ; this code is copied from DGRP3
 N BOS,BOSN,MS,MSE,DGP83
 Q:'$D(DGP("PAT",.32))
 ; we're calling into DG Legacy code so we have to modify some arrays
 M DGP83=DGP K DGP
 M DGP=DGP83("PAT")
 F MS=1:1:3 D
 . I MS=2,$P(DGP83("PAT",.32),U,19)'="Y" Q
 . I MS=3,$P(DGP83("PAT",.32),U,20)'="Y" Q
 . S BOS=$P(DGP83("PAT",.32),U,(5*MS)) Q:'BOS  S BOSN=$P($G(^DIC(23,BOS,0)),U)
 . S MSE=$P("MSL^MSNTL^MSNNTL",U,MS)
 . I $$BRANCH^DGRPMS(BOS_U_BOSN),'$$WWII^DGRPMS(DFN,"",MSE) S FILERR(RULE)=""
 ; fix the arrays before we leave
 K DGP M DGP=DGP83
 Q
85 ; FILIPINO VET SHOULD BE VET='Y'
 ; this code is copied from DGRP3
 N MS,BOS,FV,FILV,NOTFV,MSE,RULE2,DGVT,DGP85
 Q:'$D(DGP("PAT",.32))
 ; we're calling into DG Legacy code so we have to modify some arrays
 S DGVT=$P($G(DGP("PAT","VET")),U)="Y"
 M DGP85=DGP K DGP
 M DGP=DGP85("PAT")
 S RULE2=86   ; will also check RULE #86 INEL FIL VET SHOULD BE VET='N'
 F MS=1:1:3 D
 . I MS=2,$P(DGP85("PAT",.32),U,19)'="Y" Q
 . I MS=3,$P(DGP85("PAT",.32),U,20)'="Y" Q
 . S BOS=$P(DGP85("PAT",.32),U,(5*MS)),FV=$$FV^DGRPMS(BOS) I 'FV S NOTFV="" Q
 . S MSE=$P("MSL^MSNTL^MSNNTL",U,MS)
 . I '$$WWII^DGRPMS(DFN,"",MSE) S FILV("I")="" Q
 . I FV=2 S FILV("E")="" Q
 . I $P(DGP85("PAT",.321),U,14)=""!($P(DGP85("PAT",.321),U,14)="NO") S FILV("I")="" Q
 . S FILV("E")=""
 I $D(FILV) D
 . I DGVT'=1,$D(FILV("E")) S FILERR(RULE)=""
 . I DGVT=1,'$D(NOTFV),'$D(FILV("E")),$D(FILV("I")) S FILERR(RULE2)=""
 ; fix the arrays before we leave
 K DGP M DGP=DGP85
 Q
86 ; INEL FIL VET SHOULD BE VET='N'
 ; This rule is satisfied in #85 above
 Q
ON(RULE) ;verify RULE is turned on
 N ON,Y
 S ON=0
 S Y=^DGIN(38.6,RULE,0)
 I $P(Y,U,6) S ON=1
 Q ON
CONLIST ;;CONFLICT;;NODE^PIECE^FROM^TO^RANGE  -- offset list, do not add comments
 ;;VIETNAM;;.321^1^4^5^VIET
 ;;LEBANON;;.322^1^2^3^LEB
 ;;GRENADA;;.322^4^5^6^GREN
 ;;PANAMA;;.322^7^8^9^PAN
 ;;PERSIAN GULF;;.322^10^11^12^GULF
 ;;SOMALIA;;.322^16^17^18^SOM
 ;;YUGOSLAVIA;;.322^19^20^21^YUG
 ;;QUIT;;QUIT
COMLIST ;;COMBAT;;NODE^PIECE^FROM^TO^RANGE  -- offset list, do not add comments
 ;;WWI;;.52^11^13^14^WWI
 ;;WWIIE;;.52^11^13^14^WWIIE
 ;;WWIIP;;.52^11^13^14^WWIIP
 ;;KOREA;;.52^11^13^14^KOR
 ;;OTHER;;.52^11^13^14^OTHER
 ;;VIETNAM;;.52^11^13^14^VIET
 ;;LEBANON;;.52^11^13^14^LEB
 ;;GRENADA;;.52^11^13^14^GREN
 ;;PANAMA;;.52^11^13^14^PAN
 ;;PERSIAN GULF;;.52^11^13^14^GULF
 ;;SOMALIA;;.52^11^13^14^SOM
 ;;YUGOSLAVIA;;.52^11^13^14^YUG
 ;;QUIT;;QUIT
