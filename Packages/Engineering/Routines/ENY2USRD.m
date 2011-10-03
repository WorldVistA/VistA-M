ENY2USRD ;(WASH CIOFO)/DH-Y2K Utility System Reports ;8.27.98
 ;;7.0;ENGINEERING;**55**;August 17,1993
EN W @IOF,!,?20,"UTILITY EQUIPMENT DETAILED REPORT"
 I $P($G(^DIC(6910,1,0)),U,2)']"" W !!,"There is no STATION NUMBER in your Engineering Init Paramaters file.",!,"Can't proceed.",*7 Q
 S DIR(0)="SM^CAT:Equipment Category;MFGR:Manufacturer Equipment Name",DIR("A")="Select an IDENTIFIER",DIR("B")="CAT"
 S DIR("?",1)="The first 15 characters of whichever field you select as your IDENTIFIER"
 S DIR("?",2)="will be printed with system components in order to help you know what you're"
 S DIR("?")="looking at. Please choose whichever field is likely to be most helpful."
 D ^DIR K DIR I $D(DIRUT) G EXIT
 S ENIDENT=Y
 S ENSTN=0
 I $P(^DIC(6910,1,0),U,10)!($D(^DIC(6910,1,3))) D  I ENSTN="^" K ENIDENT Q
 . W !! S DIR(0)="Y",DIR("A")="Do you want a breakout by station",DIR("B")="NO"
 . S DIR("?",1)="If you say 'NO' you will obtain a single report for all your equipment,"
 . S DIR("?")="regardless of which station it belongs to."
 . D ^DIR K DIR I $D(DIRUT) S ENSTN="^" Q
 . S ENSTN=Y
 W !! K IO("Q") S %ZIS="QM" D ^%ZIS G:POP EXIT
 I $D(IO("Q")) S ZTRTN="DET^ENY2USRD" D  G EXIT
 . S ZTDESC="Detailed Util Systems Report",ZTIO=ION
 . S ZTSAVE("ENIDENT")="",ZTSAVE("ENSTN")=""
 . D ^%ZTLOAD,HOME^%ZIS K ZTSK
 ;
DET ;  detailed report of utility system status
 ;  first collect all top level components in ^TMP($J,STATION,IEN)
 ;  then add children IENs as additional subscripts
 K ^TMP($J)
 N STATION,TYPE,DA,UTIL,NDX,FMLY,X,J
 S STATION("PARNT")=$P(^DIC(6910,1,0),U,2),STATION=STATION("PARNT")
 S J=0 F  S J=$O(^ENG(6918.1,J)) Q:'J  S UTIL(J)=$P(^ENG(6918.1,J,0),U)
 S DA=0 F  S DA=$O(^ENG(6914,"AR","BSE",DA)) Q:'DA  I $D(^ENG(6914,DA,0)) D
 . I '$D(ZTQUEUED),'(DA#100) W "." ; activity indicator
 . Q:$P(^ENG(6914,DA,0),U,3)  ; don't count children
 . Q:"^4^5^"[(U_$P($G(^ENG(6914,DA,3)),U)_U)  ; ck for turn-ins
 . I ENSTN S STATION=$S($P($G(^ENG(6914,DA,9)),U,5)]"":$P(^(9),U,5),1:STATION("PARNT"))
 . S FMLY="AAA",X=$P($G(^ENG(6914,DA,9)),U,12) I X,$D(UTIL(X)) S FMLY=UTIL(X)
 . S ^TMP($J,STATION,FMLY,DA)=""
 ; now round up the children
 S STATION="" F  S STATION=$O(^TMP($J,STATION)) Q:STATION=""  S FMLY="" F  S FMLY=$O(^TMP($J,STATION,FMLY)) Q:FMLY=""  S DA=0 F  S DA=$O(^TMP($J,STATION,FMLY,DA)) Q:'DA  D
 . I '$D(^ENG(6914,"AE",DA)) Q  ; simple system
 . D GETCHLD(DA,"") ; complex system
 ;
DETPRNT ; print detailed utility system hierarchy
 U IO
 N PAGE,DATE,ESCAPE,NODE,Y2K,UL,ULD
 D NOW^%DTC S Y=% X ^DD("DD") S DATE("PRNT")=$P(Y,":",1,2),PAGE=0
 S $P(UL,"-",79)="-",$P(ULD,"=",79)="="
 S STATION=""
 F  S STATION=$O(^TMP($J,STATION)) Q:STATION=""  D:PAGE HOLD D HDRDET S FMLY="" F  S FMLY=$O(^TMP($J,STATION,FMLY)) Q:FMLY=""  S DA=0 D
 . F  S DA=$O(^TMP($J,STATION,FMLY,DA)) Q:'DA  Q:$G(ESCAPE)  S Y2K=1 D
 .. I STATION?.N S NODE="^TMP("_$J_","_STATION_","""_FMLY_""","_DA_")"
 .. E  S NODE="^TMP("_$J_","""_STATION_""","""_FMLY_""","_DA_")"
 .. F  D  Q:$QS(NODE,1)'=$J  Q:$QS(NODE,4)'=DA  Q:$G(ESCAPE)
 ... I (IOSL-$Y)'>5 D HOLD Q:$G(ESCAPE)  D HDRDET
 ... N IDENT,SYSTEM,LEVEL,COMP
 ... S IDENT="" I ENIDENT="CAT" S IDENT(0)=$P($G(^ENG(6914,DA,1)),U) I IDENT(0) S IDENT=$E($P($G(^ENG(6911,IDENT(0),0)),U),1,15)
 ... I ENIDENT="MFGR" S IDENT=$E($P(^ENG(6914,DA,0),U,2),1,15)
 ... I $QL(NODE)=4 D  Q  ; top level
 .... W !!!,DA,?12,IDENT
 .... I @NODE W "  ("_@NODE_" comp.)"
 .... S Y2K(DA)=$S($P($G(^ENG(6914,DA,11)),U)]"":$P(^(11),U),1:"Null") W "  Y2K: ",Y2K(DA) I "^FC^NA^"'[(U_Y2K(DA)_U) S Y2K=0
 .... W ?60,$S(FMLY'="AAA":FMLY,1:"NONE")
 .... S NODE=$Q(@NODE) I NODE]"",$QS(NODE,1)=$J,$QL(NODE)=4 W !!,"This Utility Component is " W:'Y2K "NOT " W "Y2K Compliant.",!,UL Q
 .... I NODE]"",$QS(NODE,1)'=$J W !!,"This Utility Component is " W:'Y2K "NOT " W "Y2K compliant.",!,UL Q
 .... I NODE="" W !!,"This Utility Component is " W:'Y2K "NOT " W "Y2K compliant.",!,UL
 ... F  D  S NODE=$Q(@NODE) Q:NODE=""  Q:$QS(NODE,1)'=$J  Q:$QS(NODE,4)'=DA  Q:$G(ESCAPE)
 .... S LEVEL=$QL(NODE),DA(LEVEL)=$QS(NODE,LEVEL)
 .... S IDENT="" I ENIDENT="CAT" S IDENT(0)=$P($G(^ENG(6914,DA(LEVEL),1)),U) I IDENT(0) S IDENT=$E($P($G(^ENG(6911,IDENT(0),0)),U),1,15)
 .... I ENIDENT="MFGR" S IDENT=$E($P(^ENG(6914,DA(LEVEL),0),U,2),1,15)
 .... S Y2K(DA(LEVEL))=$S($P($G(^ENG(6914,DA(LEVEL),11)),U)]"":$P(^(11),U),1:"Null") I "^FC^NA^"'[(U_Y2K(DA(LEVEL))_U) S Y2K=0
 .... W !,?((LEVEL-3)*12),DA(LEVEL),?((LEVEL-2)*12),IDENT
 .... I @NODE>0 W "  ("_@NODE_" comp.)"
 .... W "  Y2K: ",Y2K(DA(LEVEL))
 .... I (IOSL-$Y)'>5 D HOLD Q:$G(ESCAPE)  D HDRDET
 ... Q:$G(ESCAPE)  W !!,"This Utility System is " W:'Y2K "NOT " W "Y2K compliant.",!,UL Q:NODE=""  Q:$QS(NODE,1)'=$J  Q:$QS(NODE,2)'=STATION
 D HOLD G EXIT ; design exit for detailed report
 ;
HDRDET ; header for detailed utility systems report
 Q:$G(ESCAPE)
 W:PAGE>0!($E(IOST,1,2)="C-") @IOF S PAGE=PAGE+1
 W "Detailed Report of Utility Systems as of "_DATE("PRNT"),?70,"Page: "_PAGE
 W !,$S(ENSTN:"Station: "_STATION,1:"Consolidated ("_STATION("PARNT")_")")
 W !,"System Entry Number",?60,"System Family"
 W !,ULD
 Q
 ;
HOLD Q:$E(IOST,1,2)'="C-"!($G(ESCAPE))
 W !!,"Press <RETURN> to continue, '^' to escape..." R X:DTIME
 I '$T!($E(X)="^") S ESCAPE=1
 Q
 ;
GETCHLD(PARNT,PRECRSR)   ; Get All Components Under Parent System PARNT
 ;Input
 ; PARNT - ien of parent system (e.g. 1024)
 ; PRECRSR - ien list of parent system precursors (e.g.: 150,7019)
 ;Output
 ; ^TMP($J,STATION,FMLY,parent ien)=# of components
 ; ^TMP($J,STATION,FMLY,parent ien,component ien,sub-component ien...)=""
 N CHILD,COUNT
 ; init component counter
 S COUNT=0
 ; loop thru components of parent system PARNT
 S CHILD=0 F  S CHILD=$O(^ENG(6914,"AE",PARNT,CHILD)) Q:'CHILD  D
 . ; check for endless loop
 . I ","_PRECRSR_PARNT_","[(","_CHILD_",") D  Q
 . . W !,"ERROR - ENDLESS LOOP DETECTED - SKIPPING ENTRY"
 . . W !,"  Entry #",CHILD," already is a parent in "_PARNT_","
 . Q:"^4^5^"[(U_$P($G(^ENG(6914,CHILD,3)),U)_U)  ; ck for turn-ins
 . ; save component
 . S @("^TMP($J,STATION,FMLY,"_PRECRSR_PARNT_","_CHILD_")")="",COUNT=COUNT+1
 . ; if component has components then get them also
 . I $O(^ENG(6914,"AE",CHILD,0)) D GETCHLD(CHILD,PRECRSR_PARNT_",")
 ; save parent system component count
 S @("^TMP($J,STATION,FMLY,"_PRECRSR_PARNT_")")=COUNT
 Q
 ;
EXIT K ENSTN,ENIDENT
 K ^TMP($J)
 I $D(ZTQUEUED) S ZTREQN="@"
 D ^%ZISC,HOME^%ZIS
 Q
 ;ENY2USRD
