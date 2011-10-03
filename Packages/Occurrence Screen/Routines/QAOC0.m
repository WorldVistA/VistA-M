QAOC0 ;HISC/DAD-OCCURRENCE SCREEN AUTO ENROLLMENT ;10/19/92  14:29
 ;;3.0;Occurrence Screen;;09/14/1993
 ;AUTO ENROLL UTILITIES
 ;
TXSP(CARETYPE,TXSP) ; Is TXSP of type CARETYPE ?
 ; Returns: -1 = No,  >0 = Yes
 ; TXSP     = A facility treating specialty file (#45.7) IEN
 ; CARETYPE = $S(A:Acute, S:Special, I:Intermediate, N:NHCU, P:Psych)
 N Y S Y=1
 I (TXSP'>0)!(CARETYPE="") S Y=-1 Q Y
 I $D(^DIC(45.7,TXSP,0))["0" S Y=-1 Q Y
 S TXSP=$O(^QA(741.9,"B",TXSP,0)) I TXSP'>0 S Y=-1 Q Y
 S CARETYPE(0)=$P($G(^QA(741.9,TXSP,0)),"^",2)
 I CARETYPE(0)="" S Y=-1 Q Y
 S:CARETYPE'[CARETYPE(0) Y=-1
 Q Y
 ;
SCHED(DFN,DATE) ; Is DATE a scheduled admission for DFN ?
 ; Returns: 1 = Yes,  0 = No
 ; DFN  = Patient file (#2) IEN
 ; DATE = A date in internal FM form
 N S0,SCHED,X S SCHED=0,DATE=DATE\1
 F S0=0:0 S S0=$O(^DGS(41.1,"B",DFN,S0)) Q:S0'>0  S X=$G(^DGS(41.1,S0,0)) I $P(X,"^",2)\1=DATE,+$P(X,"^",13)=0 S SCHED=1 Q
 Q:SCHED SCHED
 F S0=DATE-.0000001:0 S S0=$O(^DPT(DFN,"S",S0)) Q:$S(S0'>0:1,S0>(DATE+.24):1,S0\1'?7N:1,1:0)  S X=$G(^DPT(DFN,"S",S0,0)) I "I"[$P(X,"^",2),$P(X,"^",7)=3,$O(^QA(740,1,"OS1","B",+$P(X,"^"),0)) S SCHED=1 Q
 Q SCHED
 ;
INACTIVE(SCRN) ; Is SCRN national, local, or inactive ?
 ; Returns: $S(N:National, L:Local, 1:Inactive)
 ; SCRN = Screen file (#741.1) IEN
 S SCRN=$O(^QA(741.1,"B",SCRN,0))
 Q $P($G(^QA(741.1,+SCRN,0)),"^",4)
 ;
VADPT(DFN,IEN405) ; For DFN get movement number IEN405 data
 ; DFN    = Patient file (#2) IEN
 ; IEN405 = Patient movement file (#405) IEN
 D KVAR^VADPT S VAIP("E")=IEN405 D IN5^VADPT
 Q
