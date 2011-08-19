ENY2USRS ;(WASH CIOFO)/DH-Y2K Utility System Reports ;8.26.98
 ;;7.0;ENGINEERING;**55**;August 17,1993
EN W @IOF,!,?20,"UTILITY EQUIPMENT SUMMARY REPORT"
 I $P($G(^DIC(6910,1,0)),U,2)']"" W !!,"There is no STATION NUMBER in your Engineering Init Paramaters file.",!,"Can't proceed.",*7 Q
 S ENSTN=0
 I $P(^DIC(6910,1,0),U,10)!($D(^DIC(6910,1,3))) D  I ENSTN="^" K ENSTN Q
 . W !! S DIR(0)="Y",DIR("A")="Do you want a breakout by station",DIR("B")="NO"
 . S DIR("?",1)="If you say 'NO' you will obtain a single report for all your equipment,"
 . S DIR("?")="regardless of which station it belongs to."
 . D ^DIR K DIR I $D(DIRUT) S ENSTN="^" Q
 . S ENSTN=Y
 W !! K IO("Q") S %ZIS="QM" D ^%ZIS G:POP EXIT
 I $D(IO("Q")) S ZTRTN="SUM^ENY2USRS" D  G EXIT
 . S ZTDESC="Summary Util Systems Report",ZTIO=ION
 . S ZTSAVE("ENSTN")=""
 . D ^%ZTLOAD,HOME^%ZIS K ZTSK
 ;
SUM ;  summarization of utility equipment status
 N STATION,COUNT,TOTAL,FMLY,COMP,DA,J,K
SUM1 S STATION("PARNT")=$P(^DIC(6910,1,0),U,2),STATION=STATION("PARNT")
 F J=0,"ALARM","COMM","ELECT","ENVRN","FIRE","OTHER","SCRTY","TRANS","WATER" F K="TOT","FC","NC","CC" S COUNT(STATION,"SYS",J,K)=0,COUNT(STATION,"COMP",J,K)=0
 F J=0,"ALARM","COMM","ELECT","ENVRN","FIRE","OTHER","SCRTY","TRANS","WATER" S TOTAL(STATION,"ECST",J)=0
 S DA=0 F  S DA=$O(^ENG(6914,"AR","BSE",DA)) Q:'DA  I $D(^ENG(6914,DA,0)) D
 . I '$D(ZTQUEUED),'(DA#10) W "." ; activity indicator
 . Q:"^4^5^"[(U_$P($G(^ENG(6914,DA,3)),U)_U)  ; turned in
 . I ENSTN S STATION=$S($P($G(^ENG(6914,DA,9)),U,5)]"":$P(^(9),U,5),1:STATION("PARNT")) D:'$D(COUNT(STATION))
 .. F J=0,"ALARM","COMM","ELECT","ENVRN","FIRE","OTHER","SCRTY","TRANS","WATER" F K="TOT","FC","NC","CC" S COUNT(STATION,"SYS",J,K)=0,COUNT(STATION,"COMP",J,K)=0
 .. F J=0,"ALARM","COMM","ELECT","ENVRN","FIRE","OTHER","SCRTY","TRANS","WATER" S TOTAL(STATION,"ECST",J)=0
 . I $P(^ENG(6914,DA,0),U,3)="" D  Q
 .. ;component without a parent (may or may not have children)
 .. S FMLY=$P($G(^ENG(6914,DA,9)),U,12) I FMLY="" S FMLY=0
 .. E  S FMLY=$P($G(^ENG(6918.1,FMLY,0)),U) S:FMLY="" FMLY=0
 .. S COUNT(STATION,"COMP",FMLY,"TOT")=COUNT(STATION,"COMP",FMLY,"TOT")+1,COMP("SYS")="FC" D
 ... I "^FC^NA^"[(U_$P($G(^ENG(6914,DA,11)),U)_U) S COUNT(STATION,"COMP",FMLY,"FC")=COUNT(STATION,"COMP",FMLY,"FC")+1 Q
 ... I $P($G(^ENG(6914,DA,11)),U)="NC" S COUNT(STATION,"COMP",FMLY,"NC")=COUNT(STATION,"COMP",FMLY,"NC")+1,COMP("SYS")="NC",TOTAL(STATION,"ECST",FMLY)=TOTAL(STATION,"ECST",FMLY)+$P($G(^ENG(6914,DA,2)),U,3) Q
 ... I $P($G(^ENG(6914,DA,11)),U)="CC" S COUNT(STATION,"COMP",FMLY,"CC")=COUNT(STATION,"COMP",FMLY,"CC")+1,COMP("SYS")="NC",TOTAL(STATION,"ECST",FMLY)=TOTAL(STATION,"ECST",FMLY)+$P($G(^ENG(6914,DA,11)),U,3)
 .. Q:'$D(^ENG(6914,"AE",DA))  ;no children
 .. D RCRSN(DA,"")
 .. S COUNT(STATION,"SYS",FMLY,"TOT")=COUNT(STATION,"SYS",FMLY,"TOT")+1
 .. I COMP("SYS")]"" S COUNT(STATION,"SYS",FMLY,COMP("SYS"))=COUNT(STATION,"SYS",FMLY,COMP("SYS"))+1
 ;
PRNTSUM ; print the summary report
 Q:$G(ENY2K("VACO"))  ;  invoked by national roll-up
 U IO
 N PAGE,DATE,ESCAPE,UL,ULD
 D NOW^%DTC S Y=% X ^DD("DD") S DATE("PRNT")=$P(Y,":",1,2),PAGE=0
 S $P(UL,"-",79)="-",$P(ULD,"=",79)="="
 S STATION="" F  S STATION=$O(COUNT(STATION)) Q:STATION=""  D HDRSUM D  D HOLD Q:$G(ESCAPE)
 . N PRCNT
 . S COUNT(STATION,"SYS")=0,COUNT(STATION,"SYS","FC")=0,COUNT(STATION,"SYS","NC")=0 F J=0,"ALARM","COMM","ELECT","ENVRN","FIRE","OTHER","SCRTY","TRANS","WATER" D
 .. S COUNT(STATION,"SYS")=COUNT(STATION,"SYS")+COUNT(STATION,"SYS",J,"TOT"),COUNT(STATION,"SYS","FC")=COUNT(STATION,"SYS","FC")+COUNT(STATION,"SYS",J,"FC")
 .. S COUNT(STATION,"SYS","NC")=COUNT(STATION,"SYS","NC")+COUNT(STATION,"SYS",J,"NC")
 . I 'COUNT(STATION,"SYS") W !!,?20,"<There are no Utility Systems on which to report>"
 . E  D
 .. S PRCNT("COMP")=$P(100*(COUNT(STATION,"SYS","FC")/COUNT(STATION,"SYS"))+.5,".") S:PRCNT("COMP")="" PRCNT("COMP")=0
 .. W !!,"There "_$S(COUNT(STATION,"SYS")=1:"is ",1:"are ")_COUNT(STATION,"SYS")_" Utility System"_$S(COUNT(STATION,"SYS")=1:"",1:"s")_" in this data base."
 .. W !,?5,COUNT(STATION,"SYS","FC")_"  ("_$J(PRCNT("COMP"),3)_" %) are Y2K compliant."
 .. W:IOSL>59 !,ULD
 .. W !!,?35,"SYSTEM"
 .. W !,?22,"System",?40,"FC System",?60,"NC/CC System"
 .. W !,"Family",?22,"Count",?42,"Count",?63,"Count"
 .. W !,UL
 .. F J="ALARM","COMM","ELECT","ENVRN","FIRE","OTHER","SCRTY","TRANS","WATER" W !,J,?19,$J(COUNT(STATION,"SYS",J,"TOT"),8),?39,$J(COUNT(STATION,"SYS",J,"FC"),8),?60,$J(COUNT(STATION,"SYS",J,"NC"),8)
 .. W !,"No Family",?19,$J(COUNT(STATION,"SYS",0,"TOT"),8),?39,$J(COUNT(STATION,"SYS",0,"FC"),8),?60,$J(COUNT(STATION,"SYS",0,"NC"),8)
 .. W:IOSL>59 !,UL
 .. W !,"TOTALS",?19,$J(COUNT(STATION,"SYS"),8),?39,$J(COUNT(STATION,"SYS","FC"),8),?60,$J(COUNT(STATION,"SYS","NC"),8)
 . S COUNT(STATION,"COMP")=0,COUNT(STATION,"COMP","FC")=0,COUNT(STATION,"COMP","NC")=0,COUNT(STATION,"COMP","CC")=0,TOTAL(STATION,"ECST")=0
 . F J=0,"ALARM","COMM","ELECT","ENVRN","FIRE","OTHER","SCRTY","TRANS","WATER" D
 .. S COUNT(STATION,"COMP")=COUNT(STATION,"COMP")+COUNT(STATION,"COMP",J,"TOT"),COUNT(STATION,"COMP","FC")=COUNT(STATION,"COMP","FC")+COUNT(STATION,"COMP",J,"FC")
 .. S COUNT(STATION,"COMP","NC")=COUNT(STATION,"COMP","NC")+COUNT(STATION,"COMP",J,"NC"),COUNT(STATION,"COMP","CC")=COUNT(STATION,"COMP","CC")+COUNT(STATION,"COMP",J,"CC"),TOTAL(STATION,"ECST")=TOTAL(STATION,"ECST")+TOTAL(STATION,"ECST",J)
 . I 'COUNT(STATION,"COMP") W !!,?20,"<There is no Utility Equipment on which to report>" Q
 . I COUNT(STATION,"SYS"),IOSL<60 D HOLD Q:$G(ESCAPE)  D HDRSUM
 . I IOSL>59 W !!,ULD
 . W !,?34,"COMPONENTS"
 . W !,?12,"Component",?24,"FC Component",?39,"NC Component",?54,"CC Component",?69,"Est Comp"
 . W !,"Family",?14,"Count",?28,"Count",?43,"Count",?58,"Count",?71,"Cost"
 . W !,UL
 . F J="ALARM","COMM","ELECT","ENVRN","FIRE","OTHER","SCRTY","TRANS","WATER" W !,J,?12,$J(COUNT(STATION,"COMP",J,"TOT"),8),?27,$J(COUNT(STATION,"COMP",J,"FC"),8),?42,$J(COUNT(STATION,"COMP",J,"NC"),8),?57,$J(COUNT(STATION,"COMP",J,"CC"),8) D
 .. W ?67,"$",$J($P(TOTAL(STATION,"ECST",J)+.5,"."),9,0)
 . W !,"No Family",?12,$J(COUNT(STATION,"COMP",0,"TOT"),8),?27,$J(COUNT(STATION,"COMP",0,"FC"),8),?42,$J(COUNT(STATION,"COMP",0,"NC"),8),?57,$J(COUNT(STATION,"COMP",0,"CC"),8),?67,"$",$J($P(TOTAL(STATION,"ECST",0)+.5,"."),9,0)
 . W !,UL
 . W !,"TOTALS",?12,$J(COUNT(STATION,"COMP"),8),?27,$J(COUNT(STATION,"COMP","FC"),8),?42,$J(COUNT(STATION,"COMP","NC"),8),?57,$J(COUNT(STATION,"COMP","CC"),8),?67,"$",$J($P(TOTAL(STATION,"ECST")+.5,"."),9,0)
 . W !,ULD
 G EXIT ; design exit for summary report
 ;
HDRSUM ; header for summary utility systems report
 Q:$G(ESCAPE)
 W:PAGE>0!($E(IOST,1,2)="C-") @IOF S PAGE=PAGE+1
 W "Summary Report on Utility Equipment as of "_DATE("PRNT"),?70,"Page: "_PAGE
 W !,$S(ENSTN:"Station: "_STATION,1:"Consolidated ("_STATION("PARNT")_")")
 W !,ULD
 Q
 ;
RCRSN(PARNT,PRECRSR) ;  build hierarchical system tree
 N CHILD
 S CHILD=0 F  S CHILD=$O(^ENG(6914,"AE",PARNT,CHILD)) Q:'CHILD  D
 . Q:","_PRECRSR_PARNT_","[(","_CHILD_",")  ;  would be an endless loop
 . Q:"^4^5^"[(U_$P($G(^ENG(6914,CHILD,3)),U)_U)  ; ck for turn-ins
 . S COUNT(STATION,"COMP",FMLY,"TOT")=COUNT(STATION,"COMP",FMLY,"TOT")+1 D
 .. I "^FC^NA^"[(U_$P($G(^ENG(6914,DA,11)),U)_U) S COUNT(STATION,"COMP",FMLY,"FC")=COUNT(STATION,"COMP",FMLY,"FC")+1 Q
 .. I $P($G(^ENG(6914,DA,11)),U)="NC" S COUNT(STATION,"COMP",FMLY,"NC")=COUNT(STATION,"COMP",FMLY,"NC")+1,COMP("SYS")="NC",TOTAL(STATION,"ECST",FMLY)=TOTAL(STATION,"ECST",FMLY)+$P($G(^ENG(6914,DA,2)),U,3) Q
 .. I $P($G(^ENG(6914,DA,11)),U)="CC" S COUNT(STATION,"COMP",FMLY,"CC")=COUNT(STATION,"COMP",FMLY,"CC")+1,COMP("SYS")="NC",TOTAL(STATION,"ECST",FMLY)=TOTAL(STATION,"ECST",FMLY)+$P($G(^ENG(6914,DA,11)),U,3) Q
 .. ;this component has Y2K category of null
 .. S:COMP("SYS")'="NC" COMP("SYS")=""
 . I $O(^ENG(6914,"AE",CHILD,0)) D RCRSN(CHILD,PRECRSR_PARNT_",")
 Q
 ;
HOLD Q:$E(IOST,1,2)'="C-"!($G(ESCAPE))
 W !!,"Press <RETURN> to continue, '^' to escape..." R X:DTIME
 I '$T!($E(X)="^") S ESCAPE=1
 Q
 ;
EXIT K ENSTN
 I $D(ZTQUEUED) S ZTREQN="@"
 D ^%ZISC,HOME^%ZIS
 Q
 ;ENY2USRS
