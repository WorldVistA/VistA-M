ENY2K2 ;(WASH ISC)/DH-Generate Y2K Worklists ;5.4.98
 ;;7.0;ENGINEERING;**51**;Aug 17, 1993
 ;
Y2L ;  produce  Y2K worklist
 W @IOF,?32,"GENERATE Y2K WORK LIST",!,?31,"VERSION ",^ENG("VERSION"),!!
 W !!,"Print Y2K Work Orders for Equipment Records whose ESTIMATED Y2K COMPLIANCE"
 S Y=$E(DT,1,5)_"00",%DT="AEF",%DT("A")="DATE is on or before what date: " D ^%DT G:Y'>0 OUT S ENY2DT=Y S ENPMYR=1700+$E(Y,1,3) X ^DD("DD") S ENY2DT("E")=Y
 W !!,"NOTE: Equipment that is CONDITIONALLY COMPLIANT for Y2K and has no ESTIMATED",!,"      Y2K COMPLIANCE DATE will always appear on Y2K worklists."
 ;
LSTSRT K ENSRT
 W !!,"Y2K work lists are collections of Y2K work orders for equipment whose Y2K",!,"CATEGORY is CONDITIONALLY COMPLIANT. They are always sorted by ASSIGNED SHOP"
 W !,"with page breaks between each shop. If you request it, they will be sorted",!,"by ASSIGNED TECH (with page breaks) within each shop."
 W !!,"Beyond that, how would you like your worklist to be sorted?"
 S X="" R !!,"     (E,P,I,L,C,S or ? for Help) L// ",X:DTIME Q:$E(X)="^"  S:X="" X="L" I $L(X)>1!("EPILCS"'[X) D LSTH1^ENEQPMS4 G LSTSRT
 S ENSRT=X,ENSRT("ALL")=1 S:X="L" ENSRT("LOC")=1
 ;
LSTSRT1 S ENSRT("A")=$S(ENSRT="E":"ENTRY NUMBER",ENSRT="P":"PM NUMBER",ENSRT="I":"LOCAL ID",ENSRT="L":"LOCATION",ENSRT="C":"CATEGORY",ENSRT="S":"SERVICE",1:"")
 G:ENSRT("A")="" OUT
 I ENSRT'="P" S ENSRT("ALL")=0 D SPL0^ENEQPMS3 G:X=U OUT
 I "EP"[ENSRT S ENSRT("LOC")=0
 I "EPL"'[ENSRT D  G:$D(DIRUT) OUT
 . W !!,"Within "_ENSRT("A")_", shall worklist be sorted by LOCATION?"
 . S DIR(0)="Y",DIR("B")="YES"
 . S DIR("?",1)="If you want this list to be ordered by LOCATION within "_ENSRT("A")_","
 . S DIR("?",2)="please enter 'YES', otherwise enter 'NO' and items will be ordered by"
 . S DIR("?")="EQUIPMENT ENTRY NUMBER."
 . D ^DIR K DIR Q:$D(DIRUT)
 . S ENSRT("LOC")=$S(Y:1,1:0)
 . I ENSRT("LOC") D
 .. S DIR(0)="Y",DIR("A")="Shall all LOCATIONS be included",DIR("B")="YES"
 .. S DIR("?",1)="Enter 'NO' if you want to screen your worklist by DIVISION, BUILDING, WING,"
 .. S DIR("?",2)="and/or ROOM. If you enter 'YES' then all LOCATIONS will be included. The"
 .. S DIR("?")="sort order will be DIVISION, BUILDING, WING, and finally ROOM."
 .. D ^DIR K DIR Q:$D(DIRUT)
 .. S ENSRT("LOC","ALL")=$S(Y:1,1:0) S:Y ENSRT("BY")="DBWR"
 .. D:'ENSRT("LOC","ALL") GEN^ENSPSRT
 ;
LSTTEK S DIR(0)="Y",DIR("A")="Shall worklist be sorted by Y2K TECHNICIAN",DIR("B")="YES"
 S DIR("?",1)="Enter 'YES' if you want your worklist sorted by Y2K TECHNICIAN, with page"
 S DIR("?",2)="breaks between each TECH. If you enter 'NO' then equipment items will be"
 S DIR("?")="selected without regard to RESPONSIBLE TECH."
 D ^DIR K DIR G:$D(DIRUT) OUT
 I 'Y S ENTECH=0,ENTECH("ALL")=1 G LSTOOS
 ;
LSTTEK1 W !,"For all TECH's: " S %=1 D YN^DICN G:%<0 OUT I %<1 W !,"You may select all TECH's or one specific TECH. Enter 'Y'es for a worklist",!,"which includes all equipment, regardless of Y2K TECHNICIAN." G LSTTEK1
 I %=1 S ENTECH="ALL",ENTECH("ALL")=1 G LSTOOS
 S DIC="^ENG(""EMP"",",DIC(0)="AEMQ" D ^DIC G:Y<0 OUT S ENTECH=+Y,ENTECH("ALL")=0
 ;
LSTOOS S DIR("A")="Shall 'OUT OF SERVICE' equipment be included in worklist"
 S DIR(0)="Y",DIR("B")="YES"
 S DIR("?",1)="Enter 'YES' if you want equipment entries with a USE STATUS of 'OUT OF"
 S DIR("?")="SERVICE' to appear on this PM worklist. Otherwise enter 'NO'."
 D ^DIR K DIR G:$D(DIRUT) OUT
 S ENSRT("OOS")=Y
 ;
LST01 W !,"For all shops"
 S ENSHKEY="ALL"
 S DIR(0)="Y",DIR("B")="YES",DIR("?")="You may generate worklists for all shops or for one particular shop."
 D ^DIR K DIR G:$D(DIRUT) OUT
 I 'Y S ENSHKEY="" D SSHOP^ENWO G:ENSHKEY=-1 OUT
 D DEV^ENLIB G:POP OUT I $D(IO("Q")) D  G OUT
 . K IO("Q")
 . S ZTIO=ION,ZTRTN="ENTRY^ENY2K3",ZTSAVE("EN*")="",ZTDESC="Generate Y2K Worklist" D ^%ZTLOAD K ZTSK D HOME^%ZIS
 D ENTRY^ENY2K3
 ;
OUT K K,ENY2DT,ENA,ENHZS,ENSHOP,ENSHKEY,ENEQDT,ENDA,ENSRT,ENTECH,ENMNTH,%DT,DIC,DNX,ENERR
 Q
 ;
MSG R !,"Press <RETURN> to continue...",X:DTIME
 Q
 ;ENY2K2
