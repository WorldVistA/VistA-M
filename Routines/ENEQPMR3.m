ENEQPMR3 ;(WCIOFO)/DH-Rapid Close Out ;11/9/1998
 ;;7.0;ENGINEERING;**15,35,43,47,59**;Aug 17, 1993
 ;
RCO6 I $D(^ENG("TMP",ENPMWO("P"))) G RCO61
 W !!,"You have not identified any PM work orders as exceptions to Rapid Close Out.",!,"At this point, the entire PM worklist will be closed out"
 W:ENDEL="Y" ", and the work orders",!,"deleted." W:ENDEL'="Y" "." G RCO7
RCO61 W @IOF,"The following work orders will be unaffected by Rapid Close Out:" S ENY=2,I=0 F K=0:0 S I=$O(^ENG("TMP",ENPMWO("P"),I)) Q:I=""  D WRIT
 W !,"All other work orders on the ",$S(ENPM="M":"MONTHLY",ENPM["W":"WEEKLY",1:"")," PM list for the ",ENSHOP,!,"Shop for ",$P("JANUARY^FEBRUARY^MARCH^APRIL^MAY^JUNE^JULY^AUGUST^SEPTEMBER^OCTOBER^NOVEMBER^DECEMBER","^",ENPMMN)
 W ", "_ENPMYR_$E(ENPMDT,1,2)_$S(ENPM["W":" Week("_ENPMWK_")",1:"")_" are subject to Rapid Close Out."
 ;
RCO7 S ENFR="",ENTO="ZZ",ENTO("L")=20
 W !!,"Would you like to specify starting and stopping points for",!,"Rapid Close Out" S %=2 D YN^DICN G:%<0 ABORT G:%=2 RCO71 I %=0 D RCO7H G RCO7
 S J=$O(^ENG(6920,"B",ENPMWO("P"))) G:J'[ENPMWO("P") OUT
RCO701 W !!,"Please enter the starting work order (or the sequential portion thereof)",!,"(ex: '"_J_"' or just '"_+$P(J,"-",3)_"'): "
 R X:DTIME G:'$T!($E(X)="^")!(X="") RCO7
 S:X?1.2N X=$S(X?1N:"00"_X,1:"0"_X) I X?.N S X=ENPMWO("P")_X
 I '$D(^ENG(6920,"B",X)) W !,?5,X_" is not an existing work order. Please try again." G RCO701
 S DIC="^ENG(6920,",DIC("S")="I $P(^(0),U,1)[ENPMWO(""P"")",DIC(0)="X" D ^DIC K DIC("S") G:Y'>0 RCO7 S ENFR=$P(Y,U,2) W "   ("_ENFR_")"
 S ENFR(0)=$O(^ENG(6920,"B",ENFR),-1) S ENFR=$S(ENFR(0)[ENPMWO("P"):ENFR(0),1:ENPMWO("P")_"000")
RCO702 W !!,"Now enter the last work order to be closed (or sequential portion thereof)"
 S J=$O(^ENG(6920,"B",ENPMWO("P")_9999),-1)
 W !,"(ex: '"_J_"' or just '"_+$P(J,"-",3)_"'): "
 R X:DTIME G:'$T!(X="")!($E(X)="^") RCO7
 S:X?1.2N X=$S(X?1N:"00"_X,1:"0"_X) I X?.N S X=ENPMWO("P")_X
 S X1=$O(^ENG(6920,"B",X,0)) I X1'>0 W !,?5,X_" is not an existing work order. Please try again." G RCO702
 I $P($P($G(^ENG(6920,X1,0)),U),"-",3)<$P(ENFR,"-",3) W !,?5,X_" does not follow "_ENFR_"." G RCO702
 S DIC("S")="I $P(^(0),U)[ENPMWO(""P""),(+$P($P(^(0),U),""-"",3)>+$P(ENFR,""-"",3))"
 D ^DIC K DIC("S") G:Y'>0 RCO7 S ENTO=$P(Y,U,2),ENTO("L")=$L(ENTO) W "   ("_ENTO_")"
 ;
RCO71 K DIC("S"),DIC("A") S DIE="^ENG(6920,",DR="35.2///P;36///^S X=ENCDATE;32///^S X=""COMPLETED"""
 W !,"Would you like to free up this terminal" S %=1 D YN^DICN G:%=1 RCO8 I %'=2 G OUT
 W !!,"Rapid close out now in progress "
 S ENPMWO=$S(ENFR]"":ENFR,1:ENPMWO("P")_"-000")
 F ENK=0:0 S ENPMWO=$O(^ENG(6920,"B",ENPMWO)) Q:ENPMWO'[ENPMWO("P")!(ENPMWO]ENTO)  I '$D(^ENG("TMP",ENPMWO("P"),ENPMWO)),($L(ENPMWO)'>ENTO("L")) D
 . W "." S DA=$O(^ENG(6920,"B",ENPMWO,0)) D POST
 . I ENDEL="Y" D DEL
 K ^ENG("TMP",ENPMWO("P"))
 G OUT
 ;
RCO8 S ZTDTH=$H,ZTRTN="RCO9^ENEQPMR3",ZTSAVE("EN*")="",ZTSAVE("PMTECH(")="",ZTSAVE("DIE")="",ZTSAVE("DR")="",ZTIO="",ZTDESC="Rapid Close Out (PMI)" D ^%ZTLOAD K ZTSK D ^%ZISC,HOME^%ZIS G OUT
 ;
RCO9 S ENPMWO=$S(ENFR]"":ENFR,1:ENPMWO("P")_"-000")
 F ENK=0:0 S ENPMWO=$O(^ENG(6920,"B",ENPMWO)) Q:ENPMWO'[ENPMWO("P")!(ENPMWO]ENTO)  I '$D(^ENG("TMP",ENPMWO("P"),ENPMWO)),($L(ENPMWO)'>ENTO("L")) D
 . S DA=$O(^ENG(6920,"B",ENPMWO,0)) D POST
 . I ENDEL="Y" D DEL
 K ^ENG("TMP",ENPMWO("P"))
 ;
OUT L -^ENG("PMLIST",ENPMWO("P"))
 K EN,ENPMWO,ENK,ENDATE,ENDEL,ENPM,ENPMYR,ENPMMN,ENPMWK,ENSHABR
 K ENSHOP,ENY,DA,DR,DIE,DIC,DIK,EN1
 K ENFR,ENTO S:$D(ZTQUEUED) ZTREQ="@"
 I $D(PMTOT) D COUNT^ENBCPM8
 K ENPMDT,ENSHKEY
 K:$D(ZTQUEUED) PMTECH
 Q
 ;
WRIT D:ENY>(IOSL-2) HLD W !,?10,I S ENY=ENY+1
 Q
 ;
HLD I $E(IOST,1,2)="C-" R !,"Press <RETURN> to continue...",X:DTIME
 S ENY=1 W @IOF
 Q
 ;
POST I $D(^ENG(6920,DA,5)),$P(^(5),U,2)]"" Q
 ;
 ; if tech substitution list exists
 I $O(PMTECH(0)) D
 . N I,CTECH,STECH
 . ; loop thru assigned tech multiple of work order (DA)
 . S I=0 F  S I=$O(^ENG(6920,DA,7,I)) Q:'I  D
 . . S CTECH=$P($G(^ENG(6920,DA,7,I,0)),U) ; current tech
 . . S STECH=$$SUBTEC(CTECH) ; determine substitute (if any)
 . . I STECH D CHGTEC(DA,I,STECH) ; make change 
 ;
 D ^DIE,PMINV^ENEQPMR4
 I $D(DA),$D(^ENG(6920,DA,2)),$P(^(2),U,2)]"" D PMHRS^ENEQPMR4
 Q
 ;
DEL I $E(^ENG(6920,DA,0),1,3)="PM-" S DIK="^ENG(6920," D ^DIK K DIK
 Q
 ;
RCO7H W !!,"If you want to close out only a portion of a PM worklist, you may specify the",!,"first and last work orders that you want Rapid Close Out to operate on."
 W !,"NOTE: Rapid Close Out will close the first and the last and everything",!,"      in between."
 Q
ABORT ;Forget it
 K ^ENG("TMP",ENPMWO("P"))
 G OUT
 ;
SUBTEC(TEC) ; return substitute tech
 ; input
 ;   TEC     = input tech (internal value)
 ;   PMTECH( = substitution list array
 ; returns ien of tech to be substituted for the input tech or 0 if none
 N I,RET
 ; loop thru PMTECH( array
 S RET=0 ; assume no substitute
 I TEC S I=0 F  S I=$O(PMTECH(I)) Q:I'>0  D  Q:RET
 . I PMTECH(I,0)=TEC S RET=PMTECH(I,1) ; substitute found
 Q RET
 ;
CHGTEC(WOIEN,ATIEN,TEC) ; change tech in assigned tech multiple
 ; input
 ;   WOIEN - work order ien
 ;   ATIEN - assigned tech multiple ien
 ;   TEC   - new tech (internal value)
 N DA,DIE,DR
 S DA=ATIEN
 S DA(1)=WOIEN
 S DIE="^ENG(6920,"_DA(1)_",7,"
 S DR=".01////^S X="_TEC
 D ^DIE
 Q
 ;ENEQPMR3
