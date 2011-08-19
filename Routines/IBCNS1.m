IBCNS1 ;ALB/AAS - INSURANCE MANAGEMENT SUPPORTED FUNCTIONS ;22-JULY-91
 ;;2.0;INTEGRATED BILLING;**28,60,52,85,107,51,137,240,371**;21-MAR-94;Build 57
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
INSURED(DFN,IBINDT) ; -- Is patient insured
 ; --Input  DFN     = patient
 ;          IBINDT  = (optional) date insured (default = today)
 ; -- Output        = 0 - not insured
 ;                  = 1 - insured
 ;
 N J,X,IBINS S IBINS=0,J=0
 I '$G(DFN) G INSQ
 I '$G(IBINDT) S IBINDT=DT
 F  S J=$O(^DPT(DFN,.312,J)) Q:'J  S X=$G(^(J,0)) S IBINS=$$CHK(X,IBINDT) Q:IBINS
INSQ Q IBINS
 ;
PRE(DFN,IBINDT) ; -- is pre-certification required for patient
 N X,Y,J,IBPRE
 S IBPRE=0,J=0
 S:'$G(IBINDT) IBINDT=DT
 F  S J=$O(^DPT(DFN,.312,J)) Q:'J  S X=$G(^(J,0)) I $$CHK(X,IBINDT),$P($G(^IBA(355.3,+$P(X,"^",18),0)),"^",6) S IBPRE=1 Q
PREQ Q IBPRE
 ;
UR(DFN,IBINDT) ; -- is ur required for patient
 N X,Y,J,IBPRE
 S IBUR=0,J=0
 S:'$G(IBINDT) IBINDT=DT
 F  S J=$O(^DPT(DFN,.312,J)) Q:'J  S X=$G(^(J,0)) I $$CHK(X,IBINDT),$P($G(^IBA(355.3,+$P(X,"^",18),0)),"^",5) S IBUR=1 Q
URQ Q IBUR
 ;
CHK(X,Z,Y) ; -- check one entry for active
 ; --  Input   X    = Zeroth node of entry in insurance multiple (2.312)
 ;             Z    = date to check
 ;             Y    = 2 if want will not reimburse
 ;                  = 3 if want will not reimburse AND indemnity plans
 ;                  = 4 if want will not reimburse, but only if it's
 ;                       MEDICARE
 ; --  Output  1    = Insurance Active
 ;             0    = Inactive
 ;
 N Z1,X1
 S Z1=0,Y=$G(Y)
 I Y'=3,$$INDEM(X) G CHKQ ; is an indemnity policy or company
 S X1=$G(^DIC(36,+X,0)) G:X1="" CHKQ ;insurance company entry doesn't exist
 I $P(X,"^",8) G:Z<$P(X,"^",8) CHKQ ;effective date later than care
 I $P(X,"^",4) G:Z>$P(X,"^",4) CHKQ ;care after expiration date
 I $P($G(^IBA(355.3,+$P(X,"^",18),0)),"^",11) G CHKQ ;plan is inactive
 G:$P(X1,"^",5) CHKQ ;insurance company inactive
 I Y<2 G:$P(X1,"^",2)="N" CHKQ ;insurance company will not reimburse
 I Y=4,$P(X1,"^",2)="N",'$$MCRWNR^IBEFUNC(+X) G CHKQ ;only MEDICARE WNR
 S Z1=1
CHKQ Q Z1
 ;
ACTIVE(IBCIFN) ; -- is this company active for this patient for this date
 ; -- called from input transform and x-refs for fields 101,102,103
 ; -- input
 N ACTIVE,DFN,IBINDT
 S DFN=$P(^DGCR(399,DA,0),"^",2),IBINDT=$S(+$G(^DGCR(399,DA,"U")):+$G(^("U")),1:DT)
 ;
ACTIVEQ Q ACTIVE
 ;
DD ;  - called from input transform and x-refs for field 101,102,103
 ;  - input requires da=internal entry number in 399
 ;  - outputs IBdd(ins co.) array
 N DFN S DFN=$P(^DGCR(399,DA,0),"^",2),IBINDT=$S(+$G(^DGCR(399,DA,"U")):+$G(^("U")),1:DT)
 D ALLACT
DDQ K IBINDT Q
 ;
 ;
ALLACT ; -- return active insurance zeroth nodes in ibdd(ins co,entry in mult)
 N X,X1
 S (X1,IBDD)=0
 F  S X1=$O(^DPT(DFN,.312,X1)) Q:'X1  S X=$G(^(X,0)) I $$CHK(X,IBINDT) S IBDD(+X,X1)=X
 ;
ALLACTQ Q
 ;
HDR W !?4,"Insurance Co.",?22,"Policy #",?40,"Group",?52,"Holder",?60,"Effective",?70,"Expires" S X="",$P(X,"=",IOM-4)="" W !?4,X
 Q
 ;
 ;
D1 N X Q:'$D(IBINS)
 W !?4,$S($D(^DIC(36,+IBINS,0)):$E($P(^(0),"^",1),1,16),1:"UNKNOWN")
 W ?22,$E($P(IBINS,"^",2),1,16)
 W ?40,$E($$GRP^IBCNS($P(IBINS,"^",18)),1,10)
 S X=$P(IBINS,"^",6) W ?52,$S(X="v":"SELF",X="s":"SPOUSE",1:"OTHER")
 W ?60,$$DAT1^IBOUTL($P(IBINS,"^",8)),?70,$$DAT1^IBOUTL($P(IBINS,"^",4))
 Q
 ;
ALL(DFN,VAR,ACT,ADT,SOP) ; -- find all insurance data on a patient
 ;
 ; -- input DFN  = patient
 ;          VAR  = variable to output in format of abc
 ;                 or abc(dfn)
 ;                 or ^tmp($j,"Insurance")
 ;          ACT  = 1 if only active ins. desired
 ;               = 2 if active and will not reimburse desired
 ;               = 3 if active, will not reimburse, and indemnity are
 ;                 all desired (for the $$INSTYP function below)
 ;               = 4 if only active and MEDICARE WNR only desired
 ;          ADT  = if ACT=1 or 4, then ADT is the internal date to check
 ;                 active for, default = dt
 ;          SOP  = if SOP=1, then sort policies in COB order
 ;
 ; -- output var(0)   =: number of entries insurance multiple
 ;           var(x,0) =: ^dpt(dfn,.312,x,0)
 ;           var(x,1) =: ^dpt(dfn,.312,x,1)
 ;           var(x,2) =: ^dpt(dfn,.312,x,2)
 ;           var(x,3) =: ^dpt(dfn,.312,x,3)
 ;           var(x,4) =: ^dpt(dfn,.312,x,4)
 ;           var(x,5) =: ^dpt(dfn,.312,x,5)
 ;       var(x,355.3) =: ^iba(355.3,$p(var(x,0),"^",18),0)
 ;       var("S",COB sequence,x) =: (null) as an xref for COB
 ;
 N X,IBMRA,IBSP
 S X=0 I $G(ACT),$E($G(ADT),1,7)'?7N S ADT=DT
 S (IBMRA,IBSP)=0 ;Flag to say if pt has medicare wnr, spouse has policy
 F  S X=$O(^DPT(DFN,.312,X)) Q:'X  I $D(^(X,0)) D
 .I $G(ACT),'$$CHK(^DPT(DFN,.312,X,0),ADT,$G(ACT)) Q
 .S @VAR@(0)=$G(@VAR@(0))+1
 .S @VAR@(X,0)=$$ZND(DFN,X)
 .S @VAR@(X,1)=$G(^DPT(DFN,.312,X,1))
 .S @VAR@(X,2)=$G(^DPT(DFN,.312,X,2))
 .S @VAR@(X,3)=$G(^DPT(DFN,.312,X,3))
 .S @VAR@(X,4)=$G(^DPT(DFN,.312,X,4))
 .S @VAR@(X,5)=$G(^DPT(DFN,.312,X,5))
 .S @VAR@(X,355.3)=$G(^IBA(355.3,+$P($G(^DPT(DFN,.312,X,0)),"^",18),0))
 .I $G(SOP) D
 ..N COB,WHO
 ..S COB=$P(@VAR@(X,0),U,20)
 ..S WHO=$P(@VAR@(X,0),U,6) S:WHO="s" IBSP=1
 ..I $$MCRWNR^IBEFUNC(+@VAR@(X,0)) D
 ... S COB=.5,IBMRA=1
 ... 
 ..S COB=$S(COB'="":COB,WHO="v":1,WHO="s":$S(IBMRA:1,1:2),1:3)
 ..S @VAR@("S",COB,X)=""
 ..Q
 ; Ck for spouse's insurance, move it before any MEDICARE WNR if sorting
 I $G(SOP),IBMRA,IBSP D
 . ; Shuffle Medicare WNR, if necessary
 . S X=0 F  S X=$O(@VAR@("S",.5,X)) Q:'X  S @VAR@("S",2,X)="" K @VAR@("S",.5,X)
 . S X=0 F  S X=$O(@VAR@("S",2,X)) Q:'X  I $P(@VAR@(X,0),U,6)="s",'$P(@VAR@(X,0),U,20) S @VAR@("S",1,X)="" K @VAR@("S",2,X)
ALLQ Q
 ;
ALLWNR(DFN,VAR,ADT) ; Returns 'all active and MEDICARE WNR'
 D ALL(DFN,VAR,4,ADT)
 Q
 ;
ZND(DFN,NODE) ; -- set group number and group name back into zeroth node of ins. type
 N X,Y S (X,Y)=""
 I '$G(DFN)!('$G(NODE)) G ZNDQ
 S X=$G(^DPT(+DFN,.312,+NODE,0))
 S Y=$G(^IBA(355.3,+$P(X,"^",18),0)) I Y="" G ZNDQ
 S $P(X,"^",3)=$P(Y,"^",4) ; move group number
 S $P(X,"^",15)=$P(Y,"^",3) ; move group name
 ;
ZNDQ Q X
 ;
INDEM(X) ; -- is this an indemnity plan
 ; -- input zeroth node if insurance type field
 N IBINDEM,IBCTP
 S IBINDEM=1
 I $P($G(^DIC(36,+X,0)),"^",13)=15 G INDEMQ ; company is indemnity co.
 S IBCTP=$P($G(^IBA(355.3,+$P(X,"^",18),0)),"^",9)
 I IBCTP,$P($G(^IBE(355.1,+IBCTP,0)),"^",3)=9 G INDEMQ ; plan is an indemnity plan
 S IBINDEM=0
INDEMQ Q IBINDEM
 ;
 ;
INSTYP(DFN,DATE) ; -- return type of insurance policy for patient
 ;
 ; -- input    dfn := pointer to patient file (required)
 ;            date := date of insurance (optional, default = today)
 ;
 ; -- output   Major Category of type of Plan (file 355.1, field .03)
 ;             for policy which would be billed first (cob)
 ;               null     no insurance found
 ;               1        MAJOR MEDICAL (default)
 ;               2        DENTAL
 ;               3        HMO
 ;               4        PPO
 ;               5        MEDICARE
 ;               6        MEDICAID
 ;               7        TRICARE
 ;               8        WORKMANS COMP
 ;               9        INDEMNITY
 ;              10        PRESCRIPTION
 ;              11        MEDICARE SUPPLEMENTAL
 ;              12        ALL OTHER
 ;
 N TYPE,POL,IBCPOL
 S TYPE=""
 I '$G(DFN) G INSTYPQ
 I '$G(DATE) S DATE=DT
 D ALL(DFN,"POL",3,DATE)
 I $G(POL(0))<1 G INSTYPQ
 I $G(POL(0))=1 S IBCPOL=+$O(POL(0))
 I $G(POL(0))>1 S IBCPOL=$$COB(.POL)
 ;
 I IBCPOL S TYPE=$P($G(^IBE(355.1,+$P($G(POL(IBCPOL,355.3)),"^",9),0)),"^",3)
 I TYPE="" S TYPE=1 ;default is major medical
 ;
INSTYPQ Q TYPE
 ;
COB(POL) ; -- find policy with high coordination of benefits
 N I,X,IBC,COB,WHO,IBCOB
 ;
 S IBC=""
 S I=0 F  S I=$O(POL(I)) Q:'I  D
 .S WHO=$P($G(POL(I,0)),"^",6),COB=$P($G(POL(I,0)),"^",20)
 .S X=$S(COB'="":COB,WHO="v":1,WHO="s":2,1:3)
 .I 'IBC S IBC=I,IBCOB=X Q
 .I X<IBCOB S IBC=I,IBCOB=X
 Q IBC
