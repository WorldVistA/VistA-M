IBCEFG4 ;ALB/TMP - OUTPUT FORMATTER MAINTENANCE - FORM ACTION PROCESSING ;22-JAN-96
 ;;2.0;INTEGRATED BILLING;**52,51,320**;21-MAR-94
 ;
ADDL ; Add a new local form
 N IBCT,IBDA,IBNAME,IBTYPE,IBBASE,IBNEW6,IBNEW7,IBOLD,IBOLD6,IBOLD7,LAST6,LAST7,DIR,X,Y,DD,DO,DIE,DR,DA,Z,Z0,Z1
 D FULL^VALM1
 S DIR("A")="Enter a new LOCAL FORM NAME: ",DIR(0)="FA^1:30^D @(""DUPNM""_$C(94)_""IBCEFG4"")",DIR("?")="Enter the name that you want your new local form to be referenced by" D ^DIR K DIR
 G:$D(DIRUT) ADDLQ
 S IBNAME=Y
ADDL1 S DIR("A")="Enter form number (must be > 9999): ",DIR(0)="NA^9999:999999999^D @(""DUPNUM""_$C(94)_""IBCEFG4"")"
 S DIR("?")="Enter the internal entry number that will be assigned to this form",DIR("B")=$O(^IBE(353,"A"),-1)+1 S:DIR("B")<10000 DIR("B")=10000 D ^DIR K DIR
 G:$D(DIRUT) ADDLQ
 S IBDA=+Y L +^IBE(353,IBDA):5 I '$T W !,*7,"Another user has taken this number ... please select a new one." G ADDL1
 K DD,DO
 S DIC="^IBE(353,",DIC(0)="L",DLAYGO=353,DIC("DR")="2.04////0;@10;2.01;I X="""" W !,*7,""MUST HAVE A BASE FILE!!"" S Y=""@10"";@20;2.02;I X="""" W !,*7,""MUST HAVE A FORMAT TYPE!!"" S Y=""@20""",DINUM=IBDA,X=IBNAME D FILE^DICN K DO,DD,DLAYGO
 S $P(^IBE(353,0),U,3)=$O(^IBE(353,9999),-1) L -^IBE(353,IBDA)
 G:Y<0 ADDLQ
 W !!,"WANT TO ASSOCIATE THIS FORM WITH A NATIONAL FORM" S %=2 D YN^DICN G:'(%+1#3) ADDL2
 K % W !
 S DIE="^IBE(353,",DR="2.05",DA=IBDA D ^DIE W !
 I '$P($G(^IBE(353,IBDA,2)),U,5) W !,*7,"FORM NOT ASSOCIATED WITH ANY NATIONAL FORM"
 G ADDLQ
ADDL2 W !!,"WANT TO COPY ALL FIELDS FROM AN EXISTING FORM" S %=2 D YN^DICN G:'(%+1#3) ADDLQ
 S DIC="^IBE(353,",DIC(0)="AEMQ",DIC("A")="Select FORM TO COPY FROM: ",DIC("S")="I $P($G(^(2)),U,5)="""",$P($G(^IBE(353,"_IBDA_",2)),U,2)=$P($G(^IBE(353,Y,2)),U,2),+$G(^IBE(353,"_IBDA_",2))=+$G(^IBE(353,Y,2)),Y'="_IBDA D ^DIC K DIC
 G:Y<0 ADDL2 S IBOLD=+Y
 W !,"ARE YOU SURE YOU WANT TO MAKE THIS COPY" S %=2 D YN^DICN G:'(%+1#3) ADDLQ
 W !!,"This may take a little while ... please be patient while I build your new form"
 ;
 ; IB*2*320
 ; Make sure files 364.6 and 364.7 are set-up to add new entries in the
 ; local number range (greater than 10000).  We cannot allow these local
 ; entries to get added into the national number range.
 F Z=364.6,364.7 I $P($G(^IBA(Z,0)),U,3)<10000 D
 . N IBLAST S IBLAST=$O(^IBA(Z," "),-1)
 . I IBLAST<10000 S IBLAST=10000
 . S $P(^IBA(Z,0),U,3)=IBLAST
 . Q
 ;
 K ^TMP("IBX",$J)
 S Z=0 F  S Z=$O(^IBA(364.6,"APAR",IBOLD,Z)) Q:'Z  S Z0=0 F  S Z0=$O(^IBA(364.6,"APAR",IBOLD,Z,Z0)) Q:'Z0  S ^TMP("IBX",$J,1,Z0)=Z,^TMP("IBX",$J,2,Z)=Z0 ;Save off overrides
 ;
 S LAST6=+$O(^DD(364.6,"GL",0,""),-1),LAST7=+$O(^DD(364.7,"GL",0,""),-1),IBCT=0
 S IBOLD6=0 F  S IBOLD6=$O(^IBA(364.6,"B",IBOLD,IBOLD6)) Q:'IBOLD6  S IBNEW6=$$NEW(6,IBDA) I IBNEW6 S IBCT=IBCT+1,Z=$G(^IBA(364.6,IBOLD6,0)) D
 .S $P(^IBA(364.6,IBNEW6,0),U,4,LAST6)=$P(Z,U,4,LAST6)
 .;
 .I $D(^TMP("IBX",$J,2,IBOLD6)) S Z0=^(IBOLD6) D  ;parent record
 ..I '$D(^TMP("IBX",$J,1,+Z0,1)) S ^TMP("IBX",$J,2,IBOLD6,1)=IBNEW6 Q
 ..S Z1=^TMP("IBX",$J,1,+Z0,1),$P(^IBA(364.6,Z1,0),U,3)=IBNEW6,DIK="^IBA(364.6,",DA=Z1,DIK(1)=.03 D EN^DIK K DIK
 .I $P(Z,U,3) D  ;child record
 ..I $G(^TMP("IBX",$J,2,$P(Z,U,3),1)) S $P(^IBA(364.6,IBNEW6,0),U,3)=^TMP("IBX",$J,2,$P(Z,U,3),1) Q
 ..S ^TMP("IBX",$J,1,IBOLD6,1)=IBNEW6
 .;
 .S DA=IBNEW6,DIK="^IBA(364.6," D IX1^DIK
 .S IBOLD7=$O(^IBA(364.7,"B",IBOLD6,"")) Q:'IBOLD7
 .S IBNEW7=$$NEW(7,IBNEW6) Q:'IBNEW7
 .S $P(^IBA(364.7,IBNEW7,0),U,3,LAST7)=$P(^IBA(364.7,IBOLD7,0),U,3,LAST7)
 .I $G(^IBA(364.7,IBOLD7,1))'="" S ^IBA(364.7,IBNEW7,1)=^IBA(364.7,IBOLD7,1)
 .S DA=IBNEW7,DIK="^IBA(364.7," D IX1^DIK
 K ^TMP("IBX",$J)
 W !!,"Field copy completed - ",IBCT," fields copied",!!
ADDLQ I $G(IBDA) D EDITL(IBDA),BLD^IBCEFG3
 S VALMBCK="R"
 Q
 ;
NEW(FILE,KEY) ; Add a new local entry to file 364.FILE whose .01 field is KEY
 ; RETURN IEN OF NEW ENTRY OR 0 IF NONE ADDED
 K DO,DD
 S DLAYGO=364_"."_FILE,DIC="^IBA(364."_FILE_",",DIC("DR")=".02////L",X=KEY,DIC(0)="L"
 D FILE^DICN K DIC,DD,DO,DLAYGO
 W "."
 Q $S(Y>0:+Y,1:0)
 ;
EDIT ; Edit a local form
 D FULL^VALM1
 D:$G(IBCEXDA) EDITL(IBCEXDA),BLDX^IBCEFG3
 S VALMBCK=$S($D(^IBE(353,+$G(IBCEXDA))):"R",1:"Q")
 Q
 ;
EDITL(DA) ; Edit a local form whose entry number is DA
 S DIE="^IBE(353,",DR="[IBCE ADD/EDIT LOCAL FORM]" D ^DIE
 Q
 ;
FFLDS ; Edit Local Form Fields
 D FULL^VALM1
 D EN^VALM("IBCE FORM FIELDS LIST")
 S VALMBCK="R"
 Q
 ; 
CHGFORM ; Select a new form without going back a screen
 N DIC,DA
 D FULL^VALM1
 S DIC="^IBE(353,",DIC("S")="I $P($G(^(2)),U,4)=0",DIC(0)="AEMQ" D ^DIC
 I Y>0 S IBCEXDA=+Y D HDRX^IBCEFG3,BLDX^IBCEFG3
 S VALMBCK="R"
 Q
 ;
FASTEXIT ; Sets a flag that system should be exited
 S VALMBCK="Q"
 I $G(VALMEVL) D  ;Ask this for all but the last level
 .D FULL^VALM1
 .K DIR S DIR(0)="Y",DIR("A")="Exit option entirely",DIR("B")="NO" D ^DIR K DIR
 .I $D(DIRUT)!(Y) S IBFASTXT=1
 Q
 ;
DUPNM ;
 I $D(^IBE(353,"B",X)) K X W !,*7,"A form with this name already exists"
 Q
 ;
DUPNUM ;
 I $D(^IBE(353,X)) K X W !,*7,"A form with this number already exists"
 Q
