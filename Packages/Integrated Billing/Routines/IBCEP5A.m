IBCEP5A ;ALB/TMP - EDI UTILITIES for provider ID ;29-SEP-00
 ;;2.0;INTEGRATED BILLING;**137,232,320,348**;21-MAR-94;Build 5
 ;
NEW(IBPRV,IBINS) ; Add new prov id
 D FULL^VALM1
 N DIC,DIR,X,Y,DA,DO,DD,DLAYGO,IBQ,IBIEN,IBPRV0,DTOUT,DUOUT,IBIF,IBSIC
 S IBQ=0,IBPRV0=$S(IBPRV'["355.93":"",1:$G(^IBA(355.93,+IBPRV,0)))
 ;
 ; Only 5 secondary providers allowed for lab/facilities
 S IBIF=$P(IBPRV0,U,2)
 S IBSIC=$O(^TMP("IBPRV_",$J,"ZIDX",""),-1)
 I IBIF=1,IBSIC>4 D  G NEWQ
 . S DIR(0)="EA",DIR("A",1)="A maximum of 5 secondary IDs are allowed for a lab/facility.",DIR("A")="PRESS ENTER TO CONTINUE " D ^DIR K DIR W !
 ;
 S DIR(0)="PAr^355.97:AEMQ"
 S DIR("A")="Enter Provider ID Qualifier: "
 S DIR("?")="Enter a Qualifier to indentify the type of ID number you are entering."
 ;
 ;S DIR("S")=$S($G(IBINS):"I ""04""[+$P($G(^(0)),U,2)",1:"I +$P($G(^(1)),U,7)&'$G(^(1))&$S($P(IBPRV0,U,2)'=1:1,1:$P(^(0),U,3)'=""SY"")")
 I $G(IBINS) D
 . I $P(IBPRV0,U,2)=1 S DIR("S")="I $$LFINS^IBCEPU(Y)" Q   ; Lab or Facility ID provided by ins
 . S DIR("S")="I $$RAINS^IBCEPU(Y)" Q   ; Non VA Ind provided by ins
 I '$G(IBINS) D
 . I $P(IBPRV0,U,2)=1 D  Q
 .. I IBPRV["VA(200," S DIR("S")="I $$LFINS^IBCEPU(Y)" Q   ; VA facility own IDS
 .. S DIR("S")="I $$NVALFOWN^IBCEPU(Y)" Q   ; Non -VA facility own
 . S DIR("S")="I $$RAOWN^IBCEPU(Y)"   ; FACILITY/GROUP;PROVIDER'S OWN PERSONAL NUMBER
 ;
 D ^DIR K DIR
 I $D(DTOUT)!$D(DUOUT) S IBQ=1 G NEWQ
 I $P($G(^IBE(355.97,+Y,1)),U,3),IBPRV["355.93" D  G NEWQ
 . K DIE,DR
 . S DIE="^IBA(355.93,",DA=+IBPRV
 . S DR="S Y=""@5"";@1;.07;@5;I $P($G(^IBA(355.93,DA,0)),U,7)'="""" S Y=""@2"";W !!,""YOU MUST HAVE A STATE TO USE LICENSE # AS AN ID!!"",! S Y=""@1"";@2;W !!,""LICENSING STATE: "",$P($G(^DIC(5,+$P($G(^IBA(355.93,DA,0)),U,7),0)),U,2);.12"
 . D ^DIE
 . I '$D(Y) D BLD^IBCEP5
 K IB3559(.06)
 S IB3559(.06)=+Y
 ;
 I $G(IBINS)'="NO",'$G(IBINS),'$P($G(^IBE(355.97,IB3559(.06),1)),U,8) D  G:IBQ NEWQ
 . S DIR(0)="PA^DIC(36,:AEMQ",DIR("A")="Select INSURANCE CO: ",DIR("?")="Select the INSURANCE CO that is furnishing you with the provider ID"
 . D ^DIR K DIR
 . I $D(DTOUT)!$D(DUOUT) S IBQ=1 Q
 . S IBINS=$S(Y>0:+Y,1:"")
 S IB3559(.02)=$S($G(IBINS):IBINS,1:"*ALL*")
 ;
 I '$P($G(^IBE(355.97,IB3559(.06),1)),U,8) D  G:'IBIEN NEWQ
 . S DIC(0)="L",DLAYGO=355.9,DIC="^IBA(355.9,",X=IBPRV
 . S:$G(IBINS) DIC("DR")=".02////"_IBINS
 . D FILE^DICN K DIC,DLAYGO,DD,DO
 . I Y'>0!$D(DUOUT)!$D(DTOUT) S IBIEN=0 Q
 . S IBIEN=+Y
 . D NEWID^IBCEP5B(355.9,IB3559(.02),IBPRV,IB3559(.06),IBIEN,1)
 ;
 E  D  ; Provider-specific id stored outside of billing
 . N DIR,X,Y,Z
 . ; State License # is stored in file 200
 . ; DEA# may not be edited in IB
 . S Z=$G(^IBE(355.97,IB3559(.06),1))
 . I +Z D  Q
 .. W ! S DIR(0)="EA",DIR("A",1)="DEA # CANNOT BE EDITED WITHIN THE BILLING SOFTWARE",DIR("A")="PRESS ENTER TO CONTINUE " D ^DIR K DIR W !
 . I $P(Z,U,3) D
 .. D PRVED(+IBPRV)
 D BLD^IBCEP5
NEWQ K VALMBCK
 S VALMBCK="R"
 Q
 ;
DEL1 ; Delete Provider specific ID's
 N IBDA,DA,DIE,DR
 D FULL^VALM1
 D SEL^IBCEP5(.IBDA)
 G:'$O(IBDA(0)) DEL1Q
 S IBDA=+$O(IBDA("")),IBDA=$G(IBDA(IBDA))
 G:'IBDA&($E($P(IBDA,U),1,3)'="LIC") DEL1Q
 I IBDA>0 D DEL^IBCEP5B(355.9,IBDA,""),BLD^IBCEP5
 E  D  ; check for state license
 . Q:$E($P(IBDA,U),1,3)'="LIC"
 . I $P(IBDA,U,2)["IBA(355.93" D
 .. S DA=+$P(IBDA,U,2),DR=".12///@",DIE="^IBA(355.93," D ^DIE
 . E  D
 .. D PRVED(+$P(IBDA,U,2))
 . D BLD^IBCEP5
DEL1Q S VALMBCK="R"
 Q
 ;
CHG1 ; Edit Provider ID's
 N IBDA,DIR,DA,DIE,DR,Z
 D FULL^VALM1
 D SEL^IBCEP5(.IBDA)
 G:'$O(IBDA(0)) CHG1Q
 S IBDA=+$O(IBDA("")),IBDA=$G(IBDA(IBDA))
 I IBDA>0 D
 . D CHG^IBCEP5B(355.9,IBDA),BLD^IBCEP5
 ; check for state license
 E  D
 . Q:$E($P(IBDA,U),1,3)'="LIC"
 . I $P(IBDA,U,2)["IBA(355.93" D
 .. S DA=+$P(IBDA,U,2),DIE="^IBA(355.93,"
 .. S DR="S Y=""@5"";@1;.07;@5;I $P($G(^IBA(355.93,DA,0)),U,7)'="""" S Y=""@2"";W !,""YOU MUST HAVE A STATE TO USE LICENSE # AS AN ID!!"" S Y=""@1"";@2;W !!,""LICENSING STATE: "",$P($G(^DIC(5,+$P($G(^IBA(355.93,DA,0)),U,7),0)),U,2);.12"
 .. D ^DIE
 . E  D
 .. D PRVED(+$P(IBDA,U,2))
 . D BLD^IBCEP5
CHG1Q S VALMBCK="R"
 Q
 ;
PRVED(IBPRV) ; Maintain license #'s for VA provider ien IBPRV
 S IBPRV=IBPRV_";VA(200,"
 D EN^IBCEP5D
 Q
 ;
COPYPROV(IBINS) ; Check if any ID's were edited and this is a parent insurance company
 ; IBINS = IEN into Insurance co file
 ; 
 Q:'$D(^TMP("IB_EDITED_IDS",$J))
 K ^TMP("IB_EDITED_IDS",$J)
 D COPY^IBCEPCID(IBINS)
 Q
 ;
 ; Get the next number so that the edits can be replicated in order for other providers/insurance companies
NEXTONE() ;
 Q $O(^TMP("IB_EDITED_IDS",$J,""),-1)+1
