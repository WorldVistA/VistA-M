LRCAPPH2 ;DALISC/FHS - CREATE OR MODIFY LAB LOCATIONS
 ;;5.2;LAB SERVICE;**138**;Sep 27, 1994
EN ;
 S LRPKG=$O(^DIC(9.4,"B","LR",0))
 I 'LRPKG S LRPKG=$O(^DIC(9.4,"B","LAB SERVICE",0))
 I 'LRPKG W !!,$$CJ^XLFSTR("Not able to find 'LAB SERVICE' in your Package (#9.4) file.",80),!,$$CJ^XLFSTR("Contact your IRM Service !!",80),!!,$C(7) H 5 G END
 W !!,$$CJ^XLFSTR("List of already defined Laboratory OOS Locations",80),!
 S (CNT,I)=0 F  S I=$O(^SC(I)) Q:I<1  I $P(^(I,0),U)["LAB DIV " S X=^(0) D
 . S CNT=CNT+1 W !,$P(X,U),?32,$P($G(^DIC(4,+$P(X,U,4),99)),U),?40,$P($G(^DIC(40.7,+$P(X,U,7),0)),U,2)
 W ! I 'CNT D  G END
 . W !,$$CJ^XLFSTR("NONE ARE CURRENTLY DEFINED",80)
 . W !,$$CJ^XLFSTR("INSTALL PATCH LR*5.2*138",80),!
 K DIR S DIR("A")="Would you like a detail display ?",DIR("B")="No",DIR(0)="YAO" D ^DIR
 K DIR W !!
 G END:$G(DTOUT)!($G(DIRUT))!($G(DUOUT))
 I Y=1 D DETAIL G EN
DIV ;
 W !,$$CJ^XLFSTR(" You may define a new Laboratory OOS Location ",80),!
 K DIR,DIC S DIR(0)="PO^4:AQEZNM",DIR("A")="Enter New Division "
 S DIR("S")="I $G(^(99))" D ^DIR
 G END:$G(DTOUT)!($G(DIRUT))!($G(DUOUT))
 G END:Y<1 S LRDIVN=+Y,LRDIV=$P($G(^DIC(4,+Y,99)),U)
SCODE ;
 K DIR S DIR(0)="PO^40.7:AQEZNM",DIR("A")="Select Clinic Stop Code "
 S DIR("S")=$$EXEMPT^SCDXUAPI D ^DIR
 G END:$G(DTOUT)!($G(DIRUT))!($G(DUOUT))
 G END:Y<1  S LRSCODE=$P(Y(0),U,2),LRSCODEN=+Y
DIS ;
 S LRNAME="LAB DIV "_LRDIV_" OOS ID "_LRSCODE,LRNAME=$E(LRNAME,1,30)
 W !,$$CJ^XLFSTR("ONCE DEFINED - IT CAN NOT BE DELETED",80),!
 K DIR S DIR("A")=" ["_LRNAME_"]  Is this the correct new name ? "
 S DIR("B")="No",DIR(0)="YAO" D ^DIR
CHK ;
 K DIR W !!
 G END:$G(DTOUT)!($G(DIRUT))!($G(DUOUT))
 G DIV:'Y
 I $D(^SC("B",LRNAME)) D  G EN
 . W @IOF,!?20,LRNAME,!?5," This location is already defined ",!,$C(7)
 . D END0
 W @IOF D LOAD,END0 G DIV
LOADB S LRNAME=$E(LRNAME,1,30) Q:$D(^SC("B",LRNAME))
LOAD ;
 S X="SCDXUAPI" X ^%ZOSF("TEST") I '$T W !!,$$CJ^XLFSTR("Load SD*5.3*63 Patch",80),!! Q
 S LROK=$$LOC^SCDXUAPI(LRNAME,LRDIVN,LRSCODE,LRPKG,,)
 I $G(LRDBUG) W !,"LROK = ",LROK
 I LROK<1 W !!?5,$P(LROK,U,2),!,"LOCATION NOT CREATED",!,$C(7) Q
 D SHOW
 W !!,$$CJ^XLFSTR("LAB Location Added",80),!!
 Q:$G(LRDBUG)  K DIC,DIE,DA,DIR
 Q
SHOW K DA,DIC,DIE S DA=LROK,DIC="^SC(",DR="0:999999" W !! D EN^DIQ Q
END ;
 Q:$G(LRDBUG)
END0 K DA,DIC,DIR,DR,LRDIV,LRDIVN,LRNAME,LRSCODE,LRSCODEN,SCERR,S
 K LRAA,LRLOC
 Q
DETAIL K DIR D 44
 G:$G(DTOUT)!($G(DIRUT))!($G(DUOUT)) DEND
 I Y>0 S LROK=+Y D SHOW G DETAIL
DEND K DA,DIC,DIR,LROK Q
ACC ;
 K DIR S DIR(0)="PO^68:AQEZNM",DIR("A")="Select Accession Area "
 D ^DIR
 G END:$G(DTOUT)!($G(DIRUT))!($G(DUOUT))!(Y<1)
 S LRAA=Y
 S LROK=$G(^LRO(68,+LRAA,.8)) I LROK D
 . K DIR W @IOF,!,$$CJ^XLFSTR("Current Laboratory OOS Location",80),!
 . W $$CJ^XLFSTR("For [ "_$P(Y,U,2)_" ] Accession Area ",80)
 . D SHOW
 K DIR,LROK S:'$G(^LRO(68,+LRAA,.8)) DIR("B")=$P(^SC(+$G(^LAB(69.9,1,.8)),0),U) S DIR("A")="Select OOS Location for ["_$P(LRAA,U,2)_"] Acc Area " D 44
 I Y=-1 W !?10,"NO SELECTION MADE ",!! G ACC
 G END:$G(DTOUT)!($G(DIRUT))!($G(DUOUT))!(Y<1)
 S LRLOC=+Y
 K DIE,DA S DIE="^LRO(68,",DA=+LRAA,DR=".8////"_LRLOC D ^DIE
 W !?10,"DONE",! G ACC
 Q
44 ;
 K DIC S DIR(0)="PO^44:AQEZNM" S:'$D(DIR("A")) DIR("A")="Select Laboratory OOS Location " S DIR("S")="I $P(^(0),U)[""LAB DIV """
 D ^DIR
 Q
