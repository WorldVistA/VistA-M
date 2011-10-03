ENEQPMS1 ;(WASH ISC)/DH-Generate PMI Worklists ;1/24/2001
 ;;7.0;ENGINEERING;**35,42,68**;Aug 17, 1993
WK ;Produce weekly PM worklist
 W @IOF,?25,"GENERATE WEEKLY PM LIST(S)",!,?31,"VERSION ",^ENG("VERSION"),!!
 S ENDATE=$E(DT,4,5)_"/"_$E(DT,6,7)_"/"_$E(DT,2,3),Y=$E(DT,1,5)_"00" X ^DD("DD")
 S %DT("A")="Select Month: ",%DT("B")=Y,%DT="AEFMX" D ^%DT G:Y'>0 OUT S ENPMDT=$E(Y,2,5),ENPMMN=$E(Y,4,5) S:$E(ENPMMN)=0 ENPMMN=$E(ENPMMN,2,2)
WK1 R !,"Week number (enter an integer from 1 to 5, or '^' to escape): ",X:DTIME G:X="^" OUT I X?1N,X>0,X<6 S ENPMWK=X,ENPM="W"_X G LSTSRT
 W "??",*7 G WK1
 ;
MNTH ;Produce monthly PM worklist
 S ENPM="M" W @IOF,?25,"GENERATE MONTHLY PM LIST(S)",!,?31,"VERSION ",^ENG("VERSION"),!!
 S ENDATE=$E(DT,4,5)_"/"_$E(DT,6,7)_"/"_$E(DT,2,3),Y=$E(DT,1,5)_"00" X ^DD("DD")
 S %DT("A")="Select Month: ",%DT("B")=Y,%DT="AEFMX" D ^%DT G:Y'>0 OUT S ENPMDT=$E(Y,2,5),ENPMMN=$E(Y,4,5) S:$E(ENPMMN)="0" ENPMMN=$E(ENPMMN,2,2) S ENPMYR=1700+$E(Y,1,3)
 ;
LSTSRT K ENSRT S I=$O(^ENG(6910.2,"B","PM SORT",0)) I I>0,$D(^ENG(6910.2,I,0)) S ENSRT=$P(^(0),U,2) I ENSRT?1U,"EPILCS"[ENSRT S ENSRT("ALL")=1 S:ENSRT="L" ENSRT("LOC")=1 G LSTSRT1
 S X="" R !,"Sort by: (E,P,I,L,C,S or ? for Help) L// ",X:DTIME Q:$E(X)="^"  S:X="" X="L" I $L(X)>1!("EPILCS"'[X) D LSTH1^ENEQPMS4 G LSTSRT
 S ENSRT=X,ENSRT("ALL")=1 S:X="L" ENSRT("LOC")=1
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
LSTTEK S DIR(0)="Y",DIR("A")="Shall worklist be sorted by RESPONSIBLE TECHNICIAN",DIR("B")="YES"
 S DIR("?",1)="Enter 'YES' if you want your worklist sorted by RESPONSIBLE TECHNICIAN, with"
 S DIR("?",2)="page breaks between each TECH. If you enter 'NO' then equipment items will"
 S DIR("?")="be selected without regard to RESPONSIBLE TECH."
 D ^DIR K DIR G:$D(DIRUT) OUT
 I 'Y S ENTECH=0,ENTECH("ALL")=1 G LSTOOS
LSTTEK1 W !,"For all TECH's: " S %=1 D YN^DICN G:%<0 OUT I %<1 W !,"You may select all TECH's or one specific TECH. Enter 'Y'es for a worklist",!,"which includes all equipment, regardless of RESPONSIBLE TECHNICIAN." G LSTTEK1
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
LST0 Q:'$D(ENPM)  K ENCRIT R !,"For what levels of CRITICALITY: ALL// ",X:DTIME G:X="^" OUT I X=""!(X="ALL") S ENCRIT("ALL")="" G LST01
 I $E(X)="?" D LSTH0 G LST0
 I X'?1.2N1P.N!(X'["-") W "??",*7 D LSTH0 G LST0
 S ENCRIT("FR")=$P(X,"-",1),ENCRIT("TO")=$P(X,"-",2) I ENCRIT("FR")>ENCRIT("TO") W "??",*7 D LSTH0 G LST0
 S DIR("A",1)="Should equipment for which no CRITICALITY has been recorded be included on"
 S DIR("A")="this worklist",DIR("B")="YES",DIR(0)="Y"
 S DIR("?")="If we don't know the CRITICALITY do you want to see the equipment?"
 D ^DIR K DIR G:$D(DIRUT) OUT
 S ENCRIT("NULL")=Y
 ;
LST01 W !,"For all shops" S %=1 D YN^DICN Q:%<0  G:%=1 LST1 I %=0 W !,"You may generate worklists for ALL shops or for ONE PARTICULAR shop." G LST01
 D SSHOP^ENWO G:ENSHKEY=-1 OUT D DEV^ENLIB G:POP OUT I $D(IO("Q")) K IO("Q") S ZTIO=ION,ZTRTN="NTRY^ENEQPMS2",ZTSAVE("EN*")="",ZTDESC="Generate Engineering PMI List" D ^%ZTLOAD K ZTSK D HOME^%ZIS G OUT
 D NTRY^ENEQPMS2 ;One shop
 G OUT
 ;
LST1 D DEV^ENLIB G:POP OUT I $D(IO("Q")) K IO("Q") S ZTIO=ION,ZTRTN="MNTRY^ENEQPMS2",ZTSAVE("EN*")="",ZTDESC="Generate Engineering PMI List" D ^%ZTLOAD K ZTSK D HOME^%ZIS G OUT
 D MNTRY^ENEQPMS2 ;All shops
 ;
OUT K K,S,%OPT,%O,ENDATE,ENPM,ENPMDT,ENA,ENHZS,ENPMWK,ENSHOP,ENSHKEY,ENPMMN,ENSTMN,ENSTYR,ENCRIT,ENDA,ENSRT,ENTECH,ENMNTH,%DT,DIC,DNX,ENERR,ENMN
 Q
 ;
MSG R !,"Press <RETURN> to continue...",X:DTIME Q
 ;
LSTH0 W !,"This feature enables you to print a 'partial' PMI list, containing only those",!,"devices whose 'CRITICALITY' falls within a certain range."
 W !!,"For example, if your site ranks devices from 1 to 10 (10 being most critical)",!,"and circumstances are such that you only have resources for a limited number"
 W !,"of PMI's in a given month, you may wish to enter something like '6-10'. This",!,"will mean that PMI's which would normally be scheduled for devices in the"
 W !,"criticality range 1-5 will be suppressed, as will entries with 'CRITICALITY'",!,"greater than 10, but since your site only uses 1 thru 10 there shouldn't be",!,"any."
 W !!,"The system will not attempt to re-schedule these PMI's for the next month,"
 W !,"because that would tend to defeat any efforts to balance the PM work load."
 W !!,"In short, this feature is not intended for routine use but rather as a sys-",!,"tematic approach to dealing with an exceptional situation."
 W !!,"Entries must be in the form 'M-N' where M and N are integers in the range of",!,"1 to 99 and M is less than or equal to N."
 Q
 ;ENEQPMS1
