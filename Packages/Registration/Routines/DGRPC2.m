DGRPC2 ;ALB/MRL/SCK/PJR/BAJ/LBD - CHECK CONSISTENCY OF PATIENT DATA (CONT) ; 10/14/10 9:56am
 ;;5.3;Registration;**45,69,108,121,205,218,342,387,470,467,489,505,507,528,451,564,570,657,688,780,797**;Aug 13, 1993;Build 24
 ;
43 ;off
44 ;off
45 ;off
46 ;off
47 ;off
 S DGLST=$S(DGCHK[",47,":47,DGCHK[",46,":46,DGCHK[",45,":45,DGCHK[",44,":44,1:DGLST)
 D NEXT G @DGLST
48 I DGVT S DGD=DGP(.362) I DGCHK[(",48,"),($P(DGD,"^",17)="Y"),($P(DGD,"^",6)="") S X=48 D COMB
 D NEXT G @DGLST
49 ;
50 ; insurance checks
 I DGCHK[",49,"!(DGCHK[",50,") D  S DGLST=$S(DGCHK["50":50,1:49)
 . N COV,INS,X
 . S X=0,COV=$S($P(DGP(.31),"^",11)="Y":1,1:0)
 . S INS=$$INSUR^IBBAPI(DFN,DT,"R")
 . I COV,'INS S X=49 ; yes, but none
 . I 'COV,INS S X=50 ; not yes, but some
 . I DGCHK[(","_X_",") D COMB
 D NEXT G @DGLST
51 D NEXT G @DGLST ; 51 disabled
 S X=$S($D(^DIC(21,+$P(DGP(.32),"^",3),0)):$P(^(0),"^",3),1:"")
 I X="Z"&($P(DGP(.32),"^",5)'=7)&($P(DGP(.32),"^",10)'=7)&($P(DGP(.32),"^",15)'=7)!($P(DGP(.32),"^",5)=7&(X'="Z")) S X=51 D COMB
 ;
52 I $P(DGP(.31),"^",11)']"" S X=52 D COMB ;automatically on
 D NEXT G @DGLST
53 I $P(DGP(.311),"^",15)']"" S X=53 D COMB ;automatically on
 D NEXT G @DGLST
54 ;
55 ;BELOW IS USED BY BOTH 54 & 55
 N DGMT
 S DGLST=$S(DGCHK["55":55,1:54)
 I $G(^DPT(DFN,.35)),(^(.35)<+($E(DT,1,3)_"0000")) D NEXT G @DGLST ; patient died before current year
 N DGE S DGE=+$O(^DIC(8.1,"B","SERVICE CONNECTED 50% to 100%",0))
 I $P($G(^DPT(DFN,.3)),U,2)'<50!($P($G(^DIC(8,+$G(^DPT(DFN,.36)),0)),U,9)=DGE) D NEXT G @DGLST ;50-100% SC
 S DGPTYP=$G(^DG(391,+DGP("TYPE"),"S")),DGISYR=$E(DT,1,3)-1_"0000" I '$P(DGPTYP,"^",8)&('$P(DGPTYP,"^",9)) K DGPTYP,DGISYR D NEXT G @DGLST ; screens 8 and 9 off
 ; If current/not outdated means test exits, pass to income retrieval
 ; Patch 780
 S DGMT=$$LST^DGMTU(DFN)
 I DGMT,$$OLD^DGMTU4($P(DGMT,U,2)) S DGMT=""
 D ALL^DGMTU21(DFN,"VSD",$S(DGMT:$P(DGMT,U,2),1:DT),"IP",$S(DGMT:DGMT,1:""))
 I '$P(DGPTYP,"^",8)!(DGCHK'["54") G JUST55 ; screen 8 off OR JUST 55 IN CHK
 S DGFL=0 I $D(DGREL("S")),($$SSN^DGMTU1(+DGREL("S"))']"") S DGFL=1
 I 'DGFL F I=0:0 S I=$O(DGREL("D",I)) Q:'I  I $$SSN^DGMTU1(+DGREL("D",I))']"" S DGFL=1 Q
 I DGFL S X=54 D COMB
JUST55 I DGCHK'["55" D NEXT G @DGLST
 S DGLST=55
 I '$P(DGPTYP,"^",9) D NEXT G @DGLST ; screen 9 off
 D TOT^DGRP9(.DGINC) S DGFL=0
 F DGD="V","S","D" I $D(DGTOT(DGD)) F I=8:1:17 I $P(DGTOT(DGD),"^",I)]"" S DGFL=1 Q
 I 'DGFL N DGAPD,DG55 D  I 'DGAPD&('DG55)  S X=55 D COMB
 . S DGAPD=+$$LST^DGMTU(DFN),DGAPD=+$P($G(^DGMT(408.31,+DGAPD,0)),U,11)
 . S DG55=$$CHECK55(DFN) ; **507, Additional Income Checks
 D NEXT G @DGLST
56 I DGVT S DGD=DGP(.3) I DGCHK[(",56,"),($P(DGD,"^",11)="Y"),($P(DGP(.362),"^",20)="") S X=56 D COMB
 D NEXT G END^DGRPC3:$S('+DGLST:1,+DGLST=99:1,1:0) G @DGLST
57 I $P(DGP(.38),U,1) D
 .N X1,X2
 .S X1=$P(DGP(.38),U,2)
 .S X=$P($G(^DG(43,1,0)),U,46) S X2=$S(X:X,1:365) D C^%DTC
 .I X<DT S X=57 D COMB
 D NEXT G @DGLST
58 ;58 - EC Claim - No Gulf/Som Svc
 ;off
 ;DG*5.3*688 changed the wording of Environmental Contaminants
 ;so if this cc is ever activated the text in ^DGIN(38.6,58 
 ;needs to be changed to Southwest Asia Conditions.
 D NEXT G @DGLST
59 ;59 - incomplete Catastrophic Disability info
 I $$HASCAT^DGENCDA(DFN) D
 .I '$P(DGP(.39),"^",2) S X=59 D COMB
 D NEXT G @DGLST
60 ;60 - Location of agent orange exposure unanswered
 I DGVT,$P(DGP(.321),"^",2)="Y",$P(DGP(.321),"^",13)="" S X=60 D COMB
 D NEXT G @DGLST
61 ;61 - Incomplete Phone Number
 ; DG*5.3*657 BAJ Phone number check modified
 ; Home phone check is disabled
 ; Work phone is required only if pt is employed
 N EMPST
 S EMPST=","_$P($G(^DPT(DFN,.311)),U,15)_","
 I ",1,2,4,"[EMPST,($P(DGP(.13),"^",2)="") S X=61 D COMB
 D NEXT G @DGLST
62 ;62 - Missing Emergency Contact Name
 I $P(DGP(.33),"^")="" S X=62 D COMB
 D NEXT G @DGLST
63 ;Confidential Address check
 N STR63,J,DGI,DGERR
 S DGERR=0
 I $P(DGP(.141),U,9)="Y",$P($$CAACT^DGRPCADD(DFN),U) D
 . ; country is either NULL or non-numeric
 . I '$P(DGP(.141),U,16) S DGERR=1 Q
 . ; country is not in Country file
 . I '$D(^HL(779.004,$P(DGP(.141),"^",16))) S DGERR=1 Q
 . S STR63="1,4,5,6" I $$FORIEN^DGADDUTL($P(DGP(.141),"^",16)) S STR63="1,4"
 . F J=1:1:$L(STR63,",") S DGI=$P(STR63,",",J) Q:DGERR  I $P(DGP(.141),U,DGI)="" S DGERR=1
 I DGERR S X=63 D COMB
 D NEXT G @DGLST
64 ;64 - Place of Birth City/State Missing ;**505
 I $P(DGP(0),"^",11)=""!($P(DGP(0),"^",12)="") S X=64 D COMB
 D NEXT G @DGLST
65 ;65 - Mother's Maiden Name Missing ;**505
 I $P(DGP(.24),"^",3)="" S X=65 D COMB
 D NEXT G @DGLST
66 ;66 - Pseudo SSN in use ;**505
 ; DG*5.3*657 BAJ 11/20/2005 Removed from CC.  Pseudo notice appears in Patient List
 ;I $P(DGP(0),"^",9)["P" S X=66 D COMB
 ; off
 D NEXT G @DGLST
67 ;67 - Serv Sep Date [Last] missing or imprecise, patch 528
 N DGG
 S DGG=$$CVELIG^DGCV(DFN)
 I $G(DGG)["A"!($G(DGG)["F") S X=67 D COMB
 D NEXT G @DGLST
68 ;used for 68-71, for Combat Vet, DG*5.3*528
69 ;
70 ;
71 ;
 ;68 - Combat To Date missing or imprecise, patch 528
 ;69 - Yugoslavia To Date missing or imprecise, patch 528
 ;70 - Somalia To Date missing or imprecise, patch 528
 ;71 - Persian Gulf To Date missing or imprecise, patch 528
 N DGG
 S DGG=$$CVELIG^DGCV(DFN)
 I DGG["B"!(DGG["G") S X=68 D COMB
 I DGG["C"!(DGG["H") S X=69 D COMB
 I DGG["D"!(DGG["I") S X=70 D COMB
 I DGG["E"!(DGG["J") S X=71 D COMB
 S DGLST=71
 D NEXT G @DGLST
72 ;; MSE - Required Fields
 S:'$G(MSECHK) MSECHK=$$MSCK^DGMSCK I MSERR S X=72 D COMB
 D NEXT G @DGLST
73 ;; An MSE FROM date precedes an MSE TO date
 S:'$G(MSECHK) MSECHK=$$MSCK^DGMSCK I MSDATERR D NEXT G @DGLST
 N I1
 ;Use MSE data in DGPMSE array, if it exists (DG*5.3*797)
 I $D(DGPMSE) D  D NEXT G @DGLST
 .N OUT S I1=0 F  S I1=$O(DGPMSE(I1)) Q:'I1!($G(OUT))  D
 ..I $P(DGPMSE(I1),U,7) Q  ;Don't check MSE verified by HEC
 ..I '$$B4^DGRPDT($P(DGPMSE(I1),U),$P(DGPMSE(I1),U,2),1) S X=73 D COMB S (MSERR,MSDATERR,OUT)=1 Q
 ;Otherwise, use MSE data in DGP(.32)
 F I1=6,11,16 I '$$B4^DGRPDT($P(DGP(.32),"^",I1),$P(DGP(.32),"^",I1+1),1) S X=73 D COMB S (MSERR,MSDATERR)=1 Q
 D NEXT G @DGLST
74 ;; Conflict Date Missing or Incomplete
 S:'$G(CONCHK) CONCHK=$$CNCK^DGMSCK I CONERR S X=74 D COMB
 D NEXT G @DGLST
75 ;; Conflict TO date precedes FROM date
76 ;; Conflict Date out of range for conflict
 S:'$G(CONCHK) CONCHK=$$CNCK^DGMSCK
 S LOC="",(I5,I6)=0 F I1=1:1 S LOC=$O(CONSPEC(LOC)) Q:LOC=""  I CONARR(LOC)=1 D
 .N FROMDAT,FROMPC,TODAT,TOPC,NODE,DATA
 .S DATA=CONSPEC(LOC)
 .S NODE=$P(DATA,",",1),FROMPC=$P(DATA,",",3),TOPC=$P(DATA,",",4)
 .S FROMDAT=$P(DGP(NODE),"^",FROMPC),TODAT=$P(DGP(NODE),"^",TOPC)
 .I '$$B4^DGRPDT(FROMDAT,TODAT,1) S X=75 D COMB:'I5&(DGCHK[(",75,")) S CONARR(LOC)=2,I5=1 Q
 .I DGCHK'[(",76,") Q
 .S:'$G(RANSET) RANSET=$$RANGE^DGMSCK
 .I '$$RWITHIN^DGRPDT($P(RANGE(LOC),"^",1),$P(RANGE(LOC),"^",2),FROMDAT,TODAT) S X=76 D COMB:'I6 S CONARR(LOC)=2,I6=1
 .Q
 S DGLST=76 D NEXT G @DGLST
77 ;; Date out of range for POW Location
 ;; Check turned off by EVC project (DG*5.3*688)
 D NEXT G @DGLST
78 ;; Date out of range for Combat Location
 S:'$G(RANSET) RANSET=$$RANGE^DGMSCK
 ;; Don't check if Combat Data Incomplete or if Combat TO precedes FROM
 I ((","_DGER_",")[(",39,"))!((","_DGER_",")[(",40,")) D NEXT G @DGLST
 I $P(DGP(.52),"^",11)'="Y" D NEXT G @DGLST ;; Don't check if no COMBAT
 S LOC=$$COMPOW^DGRPMS($P(DGP(.52),"^",12)) I LOC="" D NEXT G @DGLST
 I '$$RWITHIN^DGRPDT($P(RANGE(LOC),"^",1),$P(RANGE(LOC),"^",2),$P(DGP(.52),"^",13),$P(DGP(.52),"^",14)) S X=78 D COMB
 D NEXT G @DGLST
COMB S DGCT=DGCT+1,DGER=DGER_X_",",DGLST=X Q
 ;
NEXT S I=$F(DGCHK,(","_+DGLST_",")),DGLST=+$E(DGCHK,I,999) I +DGLST,+DGLST<79 Q
 S:'DGLST DGLST="END^DGRPC3" I +DGLST S DGLST=DGLST_"^DGRPC3"
 Q
FIND F I=DGLST:1:99 I DGCHK[(","_I_",") Q
 I DGNCK,(I>17),(I<36) S DGLST=36 G FIND
 I I,I<99 S DGLST=I G @(DGLST_$S(DGLST>78:"^DGRPC3",DGLST>42:"",DGLST>17:"^DGRPC1",1:"^DGRPC"))
 G END^DGRPC3
 ;
CHECK55(DFN) ;Business rules for additional 55-INCOME DATA MISSING checks
 ;  Modeled from DGMTR checks.
 ;  Input  DFN - IEN from PATIENT File #2
 ;
 ;  Output 1 - If Income check passes additional business rules
 ;         0 - If Income check fails additional business rules
 ;
 N VAMB,VASV,VA,VADMVT,VAEL,VAINDT,DGRTN,DGMED,DG,DG1,DGWARD,DGSRVC
 ;
 S DGRTN=0
 D MB^VADPT I +VAMB(7) S DGRTN=1 G Q55  ; Check if receiving VA Disability
 D SVC^VADPT I +VASV(4) S DGRTN=1 G Q55  ; check if POW status indicated
 I +VASV(9),(+VASV(9,1)=3) S DGRTN=1 G Q55  ; Check if Purple Heart Status is Confirmed
 D GETS^DIQ(2,DFN_",",".381:.383","I","DGMED")
 I $G(DGMED(2,DFN_",",.381,"I")) S DGRTN=1 G Q55  ; Check if eligible for Medicaid
 D ADM^VADPT2 ; Check for current admission to DOM ward 
 I +$G(VADMVT) D  G:DGRTN Q55
 . Q:'$$GET1^DIQ(43,1,16,"I")  ; Has Dom wards?
 . S DGWARD=$$GET1^DIQ(405,VADMVT,.06,"I") ; Get ward location
 . S DGSRVC=$$GET1^DIQ(42,DGWARD,.03,"I") ; Get ward service
 . S:DGSRVC="D" DGRTN=1 ; If ward service is 'D', then return 1
 ;
 ; Additional checks for 0% SC
 D ELIG^VADPT
 I +VAEL(3),'$P(VAEL(3),U,2) D  ; Check if service connected with % of zero
 . I +VAMB(4) S DGRTN=1 Q  ; Check if receiving a VA pension
 . S DG=0 ; Check for secondary eligibilities
 . F  S DG=$O(VAEL(1,DG)) Q:'DG  D  Q:DGRTN
 . . F DG1=2,4,15,16,17,18 I DG=DG1 S DGRTN=1 Q
 ; DG*5.3*657 BAJ
 ; Additional business rules
 ; Do NOT file inconsistency for the following:
 ; 1. Service Connected = YES, Eligibility Code is "SC LESS THAN 50%", SC % is 10-49, A&A = "YES"
 ; 2. Service Connected = YES, Eligibility Code is "SC LESS THAN 50%", SC % is 10-49, VA Pension = "YES"
 ; 3. Patient Type is "NSC Veteran" and A&A = "YES"
 ; 4. Patient Type is "NSC Veteran" and VA Pension = "YES"
 ; Arrays elements used:
 ; .. VAEL(3) $P 1 = SERVICE CONNECTED? $P 2 = SC %
 ; .. VAEL(6) $P 2 = PATIENT TYPE, "B" INDEX VALUE
 ; .. VAMB(1) $P 1 = RECEIVING A&A
 ; .. VAMB(4) $P 1 = RECEIVING VA PENSION
 I $P(VAEL(1),"^",2)="SC LESS THAN 50%",+VAEL(3) S PCNT=$P(VAEL(3),"^",2) I PCNT'<10,PCNT'>50 S DGRTN=$S(+VAMB(1):1,VAMB(4):1,1:DGRTN)
 I $P($G(VAEL(6)),"^",2)="NSC VETERAN" S DGRTN=$S(+VAMB(1):1,VAMB(4):1,1:DGRTN)
 ;
Q55 D KVAR^VADPT
 Q $G(DGRTN)
