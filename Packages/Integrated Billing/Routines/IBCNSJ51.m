IBCNSJ51 ;ALB/TMP - INSURANCE PLAN MAINTENANCE ACTION PROCESSING  (continued); 15-AUG-95
 ;;Version 2.0 ; INTEGRATED BILLING ;**43**; 21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
EDCOV ; Add/edit limitations of coverage for a plan in IBCPOL
 N IBTYP,IBEDT,IBCNT,IB1,IBOK,IBQUIT,IBOUT,IBCOV,Z,DONE,DONE1
 G:'$G(IBCPOL) EDCOVEX
 D FULL^VALM1
 ;
 ;
 S DONE=0
 F  D  Q:DONE  ; Effective date selection
 .K DIR
 .W !
 .S DIR(0)="DO",DIR("A")="Select EFFECTIVE DATE",DIR("?")="^D COVDTH^IBCNSJ51" S:$D(IBEDT) DIR("B")=$$DAT1^IBOUTL(IBEDT)
 .D ^DIR W:$D(Y(0)) "  ",Y(0) K DIR
 .I $D(DIRUT) S DONE=1 Q
 .S IBEDT=Y\1,IBCNT=0
 .K IBTYP
 .;
 .S DONE1=0
 .F  D  Q:DONE1  ; Coverage category type selection
 ..K DIR
 ..S DIR(0)="F"_$S(IBCNT:"O",1:"")_"^1:30",DIR("A")="Select "_$S(IBCNT:"another ",1:"")_"coverage category -OR- "_$S(IBCNT:"Press ENTER if selection is complete",1:"'ALL' to select all coverage categories")
 ..S DIR("?")="^D COVTYPH^IBCNSJ51"
 ..D ^DIR K DIR
 ..I $D(DUOUT)!$D(DTOUT) S DONE1=1 Q
 ..;
 ..I Y'="" D  Q:$TR(IBCNT,"al","AL")'="ALL"
 ...I 'IBCNT,Y="ALL" S IBCNT="ALL",IBTYP=0 D  Q
 ....F  S IBTYP=$O(^IBE(355.31,IBTYP)) Q:'IBTYP  I $$WARN1(IBTYP) S IBTYP(IBTYP)=""
 ...S DIC="^IBE(355.31,",DIC(0)="EMQ",X=Y D ^DIC
 ...I Y<0 Q:'$$QUIT()  S (DONE,DONE1)=1,IBCNT="" K IBTYP Q
 ...I $D(IBTYP(+Y)) W !,"This category already selected." Q
 ...S IBTYP=+Y I $$WARN1(IBTYP) S IBTYP(IBTYP)="",IBCNT=IBCNT+1
 ..;
 ..I $O(IBTYP(""))="" S (DONE,DONE1)=1 Q
 ..;
 ..S IBTYP=""
 ..F  S IBTYP=$O(IBTYP(IBTYP)) Q:IBTYP=""  D  Q:DONE1
 ...K ^TMP($J,"IBCAT")
 ...W !!,"Effective Date: ",$$DAT1^IBOUTL(IBEDT),"   Coverage Category: ",$P($G(^IBE(355.31,+IBTYP,0)),U)
 ...S DA=$O(^IBA(355.32,"APCD",+IBCPOL,IBTYP,-IBEDT,""))
 ...I DA'="" D SAVE^IBCNSJ52(DA) W !,"Editing existing record.",!
 ...I DA="" D  Q:'DA  ;Add a new record
 ....S DIR(0)="Y",DIR("A",1)="A new record will be added for this EFFECTIVE DATE/coverage category.",DIR("A")="Is this OK",DIR("B")="YES" D ^DIR K DIR
 ....I Y'=1 S:$$QUIT() (DONE,DONE1)=1 Q
 ....K DO,DD
 ....S DIC="^IBA(355.32,",DIC(0)="L",X=IBCPOL,DIC("DR")=".02////"_IBTYP_";.03////"_IBEDT_";.04////1" D FILE^DICN
 ....S DA=$S(Y>0:+Y,1:0)
 ....W:DA !,"New record added.",!
 ...;
 ...S IBCOV=DA
 ...;
 ...L +^IBA(355.32,IBCOV):5 I '$T D LOCKED^IBTRCD1 Q
 ...S DIE="^IBA(355.32,",DR=".04;S Y=$S(X'>1:"""",1:2);2"
 ...D ^DIE S IBOUT=$D(Y)
 ...I $P($G(^IBA(355.32,IBCOV,0)),U,4)'>1,$O(^(2,0)) S Z=0 F  S Z=$O(^IBA(355.32,IBCOV,2,Z)) Q:'Z  S DIK="^IBA(355.32,"_IBCOV_",2,",DA(1)=IBCOV,DA=Z D ^DIK ;Delete comments
 ...I $$DIFFLIM^IBCNSJ52(IBCOV) S DIE="^IBA(355.32,",DA=IBCOV,DR="1.03///NOW;1.04////^S X=DUZ" D ^DIE ;Update user who edited entry
 ...L -^IBA(355.32,IBCOV)
 ...;
 ...I IBOUT,$$QUIT() S (DONE,DONE1)=1
 ..K IBTYP S IBCNT=0
 ;
EDCOVEX S VALMBCK="R"
 K ^TMP($J,"IBCOV")
 Q
 ;
QUIT() ; Quit coverage limitation loop
 N DIR,Y
 S DIR(0)="Y",DIR("A")="Do you want to exit this function now",DIR("B")="YES" D ^DIR
 Q Y
 ;
COVDTH ; Help text for selecting effective date on coverage add/edit
 N Z,Z0,ZX,CT
 D HELP^%DTC
 I $O(^IBA(355.32,"APCD",IBCPOL,""))="" W !!,"No current dates on file for this plan." Q
 W !!,"Current dates on file for this plan:"
 S Z="" F  S Z=$O(^IBA(355.32,"APCD",IBCPOL,Z)) Q:'Z  S Z0="" F  S Z0=$O(^IBA(355.32,"APCD",IBCPOL,Z,Z0)) Q:'Z0  S ZX(Z0,Z)=""
 S Z="" F  S Z=$O(ZX(Z)) Q:'Z  W !,?3,$$DAT1^IBOUTL(-Z)," -"  S Z0="",CT=0 F  S Z0=$O(ZX(Z,Z0)) Q:'Z0!(CT>3)  S CT=CT+1 W "  ",$P($G(^IBE(355.31,Z0,0)),U) W:CT=4&($O(ZX(Z,Z0))'="") " (and more)"
 Q
 ;
COVTYPH ; Help text for selecting coverage category on coverage add/edit
 W !!,"Enter a coverage category to add/edit coverage limitations for.",!
 S DIC="^IBE(355.31,",DIC(0)="M",X="?" D ^DIC
 I '$G(IBCNT) W !,"Enter ALL to select all coverage categories."
 W !,"You may enter multiple coverage categories by entering them one at a time.",!,"After you have selected all needed categories, press ENTER at this prompt to",!,"continue."
 Q
 ;
WARN1(IBTYP) ; Warning if adding/editing an earlier effective date than latest one on file
 N IB1,Y
 S IB1=$O(^IBA(355.32,"APCD",+IBCPOL,IBTYP,-9999999)),Y=1
 I IB1'="",IB1<-IBEDT D
 .W !
 .S DIR(0)="Y",DIR("A",1)="An effective date later than the one you selected",DIR("A",2)="already exists for "_$P($G(^IBE(355.31,IBTYP,0)),U)_"."
 .S DIR("A")=" Are you sure you want to "_$S($D(^IBA(355.32,"APCD",+IBCPOL,IBTYP,-IBEDT)):"edit",1:"add")_" this earlier date for the category",DIR("B")="NO"
 .D ^DIR K DIR
 .W !
 Q (Y=1)
 ;
