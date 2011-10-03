IBCNSBL ;ALB/AAS - NEW INSURANCE POLICY BULLETIN ;29-AUG-93
 ;;2.0;INTEGRATED BILLING;**6,28,103,249**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
% N IBP,START,END,X,Y,I,J,VAIN,VAINDT,VA,DA,DR,DIE,DIC,INPT,OPT,DGPM,IBINS,IBX,IBTADD
 ;
 Q:'$D(IBEVTA0)!('$D(IBEVTA1))!('$D(IBEVTA2))!('$D(IBCDFN))!('$D(IBEVTACT))
 D:IBEVTACT="ADD" BLTN
 D:$P($G(IBEVTA1),"^",9)=3 IVM
 D VNC
 Q
 ;
BLTN ; -- generate bulletin if new policy
 ;
 K ^TMP($J,"SDAMA201","GETAPPT")
 S IBP=$$PT^IBEFUNC(DFN),(OPT,INPT)=0
 ;
 ; -- set starting date = latest of 2 years ago, or effective date
 S START=DT-20000
 I $P(IBEVTA0,"^",8),$P(IBEVTA0,"^",8)>START S START=$P(IBEVTA0,"^",8)
 ;
 S END=DT+.9
 ;
 D GETAPPT^SDAMA201(DFN,"1;2","R",START,END,.OPT,"O")
 S X=$O(^DGPM("APTT1",DFN,START)) I X,(X'>(END+.24)) S INPT=1
 I $G(^DPT(DFN,.1))'="" D  S INPT=1
 .;
 .;see if current admission is in claims tracking
 .S VAINDT=DT+.24 D INP^VADPT
 .N IBMVAD,IBTRKR,IBRANDOM,DGPMA
 .S IBMVAD=+VAIN(1),DGPMA=$G(^DGPM(+IBMVAD,0))
 .I DFN=$P($G(^IBT(356,+$O(^IBT(356,"AD",+IBMVAD,0)),0)),"^",2) Q  ; quit if already in claims tracking
 .S IBTRKR=$G(^IBE(350.9,1,6))
 .I $P(IBTRKR,"^",2)=2 D ADM^IBTUTL(IBMVAD,$E(+DGPMA,1,12),0,$P(DGPMA,"^",27)) S IBTADD=1
 .I $P(IBTRKR,"^",2)=1,$$INSURED^IBCNS1(DFN,+DGPMA) D ADM^IBTUTL(IBMVAD,$E(+DGPMA,1,12),0,$P(DGPMA,"^",27)) S IBTADD=1
 .Q
 ;
 S VAINDT=START+.24 D INP^VADPT I $G(VAIN(1)) S INPT=1
 I 'OPT,'INPT G BQ
 ;
 D BULL^IBCNSBL1
BQ K ^TMP($J,"SDAMA201","GETAPPT")
 Q
 ;
IVM ; -- announce patients who have ivm-identified insurance.  input = dfn
 I $G(^IBA(354,DFN,"IVM")) G IVMQ
 I '$D(^IBA(354,DFN)) D ADDP^IBAUTL6 K IBWHER,IBEXERR,IBADD
 S DIE="^IBA(354,",DR="50////1",DA=DFN D ^DIE K DIE,DR,DA,DIC
IVMQ Q
 ;
VNC ;  -- remove verification of no coverage
 N DA,DIC,DIE,DR,X,Y
 I '$G(^IBA(354,DFN,60)) G VNCQ
 ;
 ; - delete verification date if the patient has effective policies
 I $$EPOL^IBCNSM2(DFN) S DA=DFN,DIE="^IBA(354,",DR="60///@" D ^DIE
VNCQ Q
