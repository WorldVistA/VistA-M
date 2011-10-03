ENY2KR1 ;(WASH ISC)/DH-Rapid Y2K Close Out ;6.16.98
 ;;7.0;ENGINEERING;**51**;Aug 17, 1993
CAT ;  rapid closeout by equipment category
 N CAT,DIC,DIE,DA,DR,COUNT,ENY2K,ESCAPE,DATE,COST,Y2DA,SORT,WO,CRITER
 S CRITER="SKIP"
 D CAT1^ENY2K ; get a range of work orders (by equipment id)
 Q:'$G(ENY2K("CONT"))!('$D(^TMP($J)))
 S SORT=$E(CAT,1,20)
 D Y2KWO,PROCS
 G EXIT
 ;
CSN ;  rapid closeout by category stock number
 N CSN,DIC,DIE,DA,DR,COUNT,ENY2K,ESCAPE,DATE,COST,Y2DA,SORT,WO,CRITER
 S CRITER="SKIP"
 D CSN1^ENY2K ; get a range of work orders (by equipment id)
 Q:'$G(ENY2K("CONT"))!('$D(^TMP($J)))
 S SORT=$E(CSN,1,20)
 D Y2KWO,PROCS
 G EXIT
 ;
MEN ;  rapid closeout by manufacturer equipment name (trade name)
 ;  menu option disabled at request of TAG
 N MEN,DIC,DIE,DA,DR,COUNT,ENY2K,ESCAPE,DATE,COST,Y2DA,SORT,WO,CRITER
 S CRITER="SKIP"
 D MEN1^ENY2KA ; get a range of work orders (by equipment id)
 Q:'$G(ENY2K("CONT"))!('$D(^TMP($J)))
 S SORT=$E(MEN,1,20)
 D Y2KWO,PROCS
 G EXIT
 ;
MFG ;  rapid closeout by manufacturer
 N MFG,DIC,DIE,DA,DR,COUNT,ENY2K,ESCAPE,DATE,COST,Y2DA,SORT,WO,CRITER
 S CRITER="SKIP"
 D MFG1^ENY2K ; get a range of work orders (by equipment id)
 Q:'$G(ENY2K("CONT"))!('$D(^TMP($J)))
 S SORT=$E(MFG,1,20)
 D Y2KWO,PROCS
 G EXIT
 ;
LOC ;  rapid closeout by range of local identifiers
 N LOC,DIC,DIE,DA,DR,COUNT,ENY2K,ESCAPE,DATE,COST,Y2DA,SORT,END,WO,CRITER
 S CRITER="SKIP"
 D LOC1^ENY2K9 ; get a range of work orders (by equipment id)
 Q:'$G(ENY2K("CONT"))!('$D(^TMP($J)))
 S SORT=$E(LOC,1,10)_"-"_$E(END,1,10)
 D Y2KWO,PROCS
 G EXIT
 ;
MOD ;  rapid closeout by manufacturer and model
 N MFG,MOD,DIC,DIE,DA,DR,COUNT,ENY2K,ESCAPE,DATE,COST,Y2DA,SORT,WO,CRITER
 S CRITER="SKIP"
 D MOD1^ENY2K ; get a range of work orders (by equipment id)
 Q:'$G(ENY2K("CONT"))!('$D(^TMP($J)))
 S SORT=$E(MFG,1,12)_"/"_$E(MOD,1,12)
 D Y2KWO,PROCS
 G EXIT
 ;
Y2KWO ;  check for open Y2K work orders
 S DA=0,COUNT("Y2KWO")=0 F  S DA=$O(^TMP($J,DA)) Q:'DA  D
 . S WO=$P($G(^ENG(6914,DA,11)),U,8) Q:WO'>0
 . I $D(^ENG(6920,WO,0)),$P($G(^(5)),U,2)="" S ^TMP($J,"Y2KWO",DA)="",^TMP($J,"Y2KWO_LIST",$P(^ENG(6920,WO,0),U),DA)="",COUNT("Y2KWO")=COUNT("Y2KWO")+1
 Q
 ;
PROCS ;  close the Y2K work orders
 I '$D(^TMP($J,"Y2KWO")) W !!,"None of the selected equipment entries have open Y2K work orders.",!,"Data base unchanged." G EXIT
 W !!,COUNT("Y2KWO")_" of the selected equipment records have open Y2K work orders which",!,"may now be closed."
 W !!,"First we'll print a list of the open Y2K work orders."
 N PAGE
 D NOW^%DTC S Y=% X ^DD("DD") S DATE("PRNT")=$P(Y,":",1,2)
 W ! S %ZIS="" D ^%ZIS G:POP EXIT S PAGE=0
 U IO
 D HDR S (WO,DA)="" F  S WO=$O(^TMP($J,"Y2KWO_LIST",WO)) Q:WO=""  S DA=$O(^(WO,0)) D:DA>0  Q:$G(ESCAPE)
 . I (IOSL-$Y)'>2 D HOLD,HDR
 . W !,WO,?34,$J(DA,10)
 I IO=IO(0) D HOLD G:$G(ESCAPE) EXIT
 I IO'=IO(0) D ^%ZISC G:$G(ESCAPE) EXIT
 W @IOF,!,"Rapid Close Out of Y2K work orders will automatically place the affected",!,"equipment in a Y2K CATEGORY of 'FULLY COMPLIANT'."
 W !!,"It is assumed that you have reviewed the list of open Y2K work orders just",!,"printed. You will have an opportunity to remove individual work orders from"
 W !,"this closeout list by specifying their equipment entry numbers."
 W !!,"If any of these equipment entries have been erroneously classified as",!,"'CONDITIONALLY COMPLIANT', then you should remove them from the closeout list."
 W !!,"You should then use the 'Delete Y2K Work Orders' option [ENY2K_DEL] to delete",!,"the work orders instead of closing them. Finally, you should use the 'Manual"
 W !,"Equipment Selection for Y2K' option [ENY2KIND], which is under 'Y2K Data Entry'",!,"[ENY2K_ENTRY], to enter correct Y2K information for the subject equipment."
 W !!,"Please enter any equipment entry numbers that should be removed from the",!,"closeout list:"
 W ! S COUNT("Y2KWO","REMOVE")=0 F  D GETEQ^ENUTL Q:Y'>0  D
 . I $D(^TMP($J,"Y2KWO",+Y)) K ^(+Y) S COUNT("Y2KWO","REMOVE")=COUNT("Y2KWO","REMOVE")+1
 I COUNT("Y2KWO","REMOVE")=COUNT("Y2KWO") W !!,"There's nothing left to close out. Data base unchanged." G EXIT
 W !!,COUNT("Y2KWO")-COUNT("Y2KWO","REMOVE")_" Y2K work orders are about to be closed out. Are you sure that",!,"you want to proceed?"
 S DIR(0)="Y",DIR("B")="YES"
 D ^DIR K DIR I $D(DIRUT)!('Y) G EXIT
 ;
PROCD D FIRST Q:$G(ESCAPE)  ; EQDA now set to first ^TMP($J,"Y2KWO" node
 S COUNT=1,COUNT("LOCK")=0 F  S EQDA=$O(^TMP($J,"Y2KWO",EQDA)) Q:'EQDA  D SUBSQNT
 W !,COUNT_" Y2K work orders were closed."
 I COUNT("LOCK") D
 . W !,"Work orders for the following "_COUNT("LOCK")_" equipment records could not be",!,"locked and were, therefore, not processed:"
 . S EQDA=0 F  S EQDA=$O(^TMP($J,"LOCK",EQDA)) Q:'EQDA  D  Q:$G(ESCAPE)
 .. I (IOSL-$Y)'>2 D HOLD Q:$G(ESCAPE)  W @IOF
 .. W !,?10,EQDA
 Q
 ;
FIRST ;  close out first Y2K work order
 S EQDA=$O(^TMP($J,"Y2KWO",0)),DA=$P(^ENG(6914,EQDA,11),U,8) I DA>0,'$D(^ENG(6920,DA,0)) S DA=""
 I DA'>0 F  S EQDA=$O(^TMP($J,"Y2KWO",EQDA)) Q:'EQDA  S DA=$P(^ENG(6914,EQDA,11),U,8) I DA>0,$D(^ENG(6920,DA,0)) D  Q:DA>0
 . I $P($G(^ENG(6920,DA,5)),U,2)]"" S DA="" Q  ; completed work order
 . L +^ENG(6920,DA):1 I '$T S ^TMP($J,"LOCK",EQDA)="",COUNT("LOCK")=COUNT("LOCK")+1 S DA=""
 I DA'>0 W !!,"There are no open Y2K work orders that can be closed. Data base unchanged." S ESCAPE=1 Q  ;nothing to do
 W !!,"You will be prompted to close the first Y2K work order manually, after which",!,"the system will take care of the others automatically."
 W !!,"EQUIPMENT ID#: "_EQDA_"    "_SORT_"   "_$E($$GET1^DIQ(6914,EQDA,1),1,20)_"   "_$E($$GET1^DIQ(6914,EQDA,4),1,20)
 S Y2DA=DA
 S DIE="^ENG(6920,",DR=$S($D(^DIE("B","ENZY2CLOSE")):"[ENZY2CLOSE]",1:"[ENY2CLOSE]")
 D ^DIE I $P($G(^ENG(6920,DA,5)),U,2)="" W !,"The work order was not closed out. Terminating the option." D HOLD L -^ENG(6920,DA) S ESCAPE=1 Q
 S X=$G(^ENG(6920,DA,5)),ENY2K("WORK")=$P(X,U,7),ENY2K("HOURS")=$P(X,U,3)
 S ENY2K("PRIM")=$P($G(^ENG(6920,DA,2)),U,2)
 S DATE=$P(^ENG(6920,DA,5),U,2),COST("L")=$P(^(5),U,6),COST("M")=$P(^(5),U,4),COST("V")=$P($G(^(4)),U,4)
 S Y=DATE D DD^%DT S DATE("E")=Y
 S COST=COST("L")+COST("M")+COST("V")
 S DA=EQDA,DIE="^ENG(6914,",DR="71///^S X=""FC"";72.1///^S X=DATE;74///^S X=COST" D ^DIE
 Q
 ;
SUBSQNT ;  finish the list
 S DA=$P(^ENG(6914,EQDA,11),U,8) Q:DA'>0  Q:'$D(^ENG(6920,DA,0))
 Q:$P($G(^ENG(6920,DA,5)),U,2)]""  ; completed work order
 L +^ENG(6920,DA):1 I '$T S ^TMP($J,"LOCK",EQDA)="" Q
 S ENY2WO=$P(^ENG(6920,DA,0),U),COUNT=COUNT+1
 S DIE="^ENG(6920,",%X="^ENG(6920,"_Y2DA_",7,",%Y="^ENG(6920,"_DA_",7," D %XY^%RCR  ;assigned techs
 S %X="^ENG(6920,"_Y2DA_",8,",%Y="^ENG(6920,"_DA_",8," D %XY^%RCR  ;work actions
 S DR="39///^S X=ENY2K(""WORK"");16///^S X=ENY2K(""PRIM"");37.5///^S X=COST(""L"");38///^S X=COST(""M"");47///^S X=COST(""V"");37///^S X=ENY2K(""HOURS"");36///^S X=DATE(""E"");32///^S X=""COMPLETED"""
 D ^DIE
 S DIE="^ENG(6914,",DA=EQDA,DR="71///^S X=""FC"";72.1///^S X=DATE(""E"");74///^S X=COST"
 D ^DIE
 Q
 ;
HDR ;  header for Y2K work order list
 W:PAGE>0!($E(IOST,1,2)="C-") @IOF S PAGE=PAGE+1
 W "Y2K Work Orders Now Subject to Rapid Closeout  "_DATE("PRNT")_"  Page: "_PAGE
 W !,"Work Order Number",?25,"Equipment Entry Number"
 K X S $P(X,"-",79)="-" W !,X
 Q
 ;
HOLD I $E(IOST,1,2)="C-" R !,"<cr> to continue, '^' to quit...",X:DTIME S:X="^" ESCAPE=1
 Q
 ;
EXIT K ^TMP($J)
 K ENY2WO,EQDA
 Q
 ;ENY2KR1
