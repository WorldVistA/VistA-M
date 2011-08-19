ENY2REP6 ;(WIRMFO)/DH-Print Y2K Cumulative ;8.20.98
 ;;7.0;ENGINEERING;**51,55**;August 17,1993
PRT ;  physical printing
 U IO
 N PAGE,DATE,PRCNT,MONTH,ESCAPE,UL
 D NOW^%DTC S Y=% X ^DD("DD") S DATE("PRNT")=$P(Y,":",1,2),PAGE=0
 S MONTH="Jan^Feb^Mar^Apr^May^Jun^Jul^Aug^Sep^Oct^Nov^Dec"
 S $P(UL,"-",79)="-"
 I '$G(ENCLASS) D  Q
 . S CLASS="CON",STATION="" F  S STATION=$O(COUNT(STATION)) Q:STATION=""  D HDR,PRT1 D HOLD Q:$G(ESCAPE)
 ;
 S STATION="" F  S STATION=$O(COUNT(STATION)) Q:STATION=""!($G(ESCAPE))  S CLASS="" F  S CLASS=$O(COUNT(STATION,CLASS)) Q:CLASS=""!($G(ESCAPE))  I CLASS'="CON" D HDR D PRT1,HOLD Q:$G(ESCAPE)
 Q
 ;
PRT1 ;  print by functional classification
 W !,"Active Equipment Records: "_COUNT(STATION,CLASS,"ACT"),?40,"Potential Y2K Candidates: "_COUNT(STATION,CLASS,"Y2K")
 W !,"  TURN-IN's with Y2K CATEGORY of 'NC' are counted as active records."
 W !,"  Potential Y2K Candidate => Active record with a MANUFACTURER and a MODEL."
 Q:'COUNT(STATION,CLASS,"Y2K")  ; nothing to print
 W !!,"Counts by Y2K Category:"
 W !,?8,"FC",?23,"NC",?37,"CC",?51,"NA",?64,"Null"
 F J=0,"FC","NC","NA","CC" S PRCNT(J)=$P((COUNT(STATION,CLASS,J)/COUNT(STATION,CLASS,"Y2K")*100)+.5,".") S:PRCNT(J)="" PRCNT(J)=0
 W !,?2,$J(COUNT(STATION,CLASS,"FC"),5)_" ("_PRCNT("FC")_"%)",?17,$J(COUNT(STATION,CLASS,"NC"),5)_" ("_PRCNT("NC")_"%)"
 W ?31,$J(COUNT(STATION,CLASS,"CC"),5)_" ("_PRCNT("CC")_"%)",?45,$J(COUNT(STATION,CLASS,"NA"),5)_" ("_PRCNT("NA")_"%)"
 W ?59,$J(COUNT(STATION,CLASS,0),5)_" ("_PRCNT(0)_"%)"
FC D:COUNT(STATION,CLASS,"FC")
 . W !!,"For FULLY COMPLIANT  ("_COUNT(STATION,CLASS,"FC")_" equipment records):"
 . S PRCNT("UPG")=$P((COUNT(STATION,CLASS,"FC","UPG")/COUNT(STATION,CLASS,"FC")*100)+.5,".")
 . S X(0)=COUNT(STATION,CLASS,"FC")-COUNT(STATION,CLASS,"FC","UPG")
 . W !,?2,X(0)_" records were entered as FULLY COMPLIANT, "_COUNT(STATION,CLASS,"FC","UPG")_" were entered as CONDITIONALLY"
 . W !,"  COMPLIANT and then updated." I COUNT(STATION,CLASS,"FC","UPG")>0 D
 .. W " The total cost of "_$S(COUNT(STATION,CLASS,"FC","UPG")=1:"this update",1:"these updates")_" was $"_$P(^TMP($J,STATION,CLASS,"FC","ACST")+.5,".")_"."
 .. W !,"  The estimated total cost was $"_$P(^TMP($J,STATION,CLASS,"FC","ECST")+.5,".")_"."
NC D:COUNT(STATION,CLASS,"NC")
 . W !!,"For NON-COMPLIANT  ("_COUNT(STATION,CLASS,"NC")_" equipment records):"
 . F J=0,"RET","REP","USE" S PRCNT(J)=$P((COUNT(STATION,CLASS,"NC",J)/COUNT(STATION,CLASS,"NC")*100)+.5,".") S:PRCNT(J)="" PRCNT(J)=0
 . W !," Retire:",$J(COUNT(STATION,CLASS,"NC","RET"),5)_"("_PRCNT("RET")_"%)  Replace:",$J(COUNT(STATION,CLASS,"NC","REP"),5)_"("_PRCNT("REP")_"%)  Use as is:"
 . W $J(COUNT(STATION,CLASS,"NC","USE"),5)_"("_PRCNT("USE")_"%)  Unknown:",$J(COUNT(STATION,CLASS,"NC",0),5)_"("_PRCNT(0)_"%)"
 . W !,"  ",COUNT(STATION,CLASS,"NC","ATD")_" item"_$S(COUNT(STATION,CLASS,"NC","ATD")=1:" has",1:"s have")_" been replaced to date"
 . I COUNT(STATION,CLASS,"NC","ATD")'>0 W "."
 . E  D
 .. W " at a cost of $"_$P(^TMP($J,STATION,CLASS,"NC","ATD")+.5,".")_"."
 .. W !,"  The original estimate for replacing "_$S(COUNT(STATION,CLASS,"NC","ATD")=1:"this item",COUNT(STATION,CLASS,"NC","ATD")=2:"both of these items",1:"these "_COUNT(STATION,CLASS,"NC","ATD")_" items")
 .. W " was $"_$P(^TMP($J,STATION,CLASS,"NC","ETD")+.5,".")_"."
 . I COUNT(STATION,CLASS,"NC","REP")>0 D
 .. W !,"  The original estimate for replacing "_$S(COUNT(STATION,CLASS,"NC","REP")=1:"this item",COUNT(STATION,CLASS,"NC","REP")=2:"both of these items",1:"all of these "_COUNT(STATION,CLASS,"NC","REP")_" items")
 .. W " was $"_$P(^TMP($J,STATION,CLASS,"NC","ETOT")+.5,".")_"."
 .. I COUNT(STATION,CLASS,"NC","REP")>COUNT(STATION,CLASS,"NC","ATD") D
 ... W !,"  The current estimate for replacing the remaining "_(COUNT(STATION,CLASS,"NC","REP")-COUNT(STATION,CLASS,"NC","ATD"))_" item(s) is $"_($P(^TMP($J,STATION,CLASS,"NC","ETOT")+.5,".")-$P(^TMP($J,STATION,CLASS,"NC","ETD")+.5,"."))_"."
 .. I IOSL<60 D HOLD,HDR Q:$G(ESCAPE)
 .. I IOSL>59 W !
 .. W !,?15,"REPLACEMENT SCHEDULE ("_COUNT(STATION,CLASS,"NC","SREP")_" equipment records)"
 .. W !,"                Calendar 1998          Calendar 1999          Calendar 2000"
 .. W !,"Month        Count  Est cost($)     Count  Est Cost($)     Count  Est Cost($)"
 .. W !,UL
 .. F J=1:1:12 W !,$P(MONTH,U,J),?13,$J(COUNT(STATION,CLASS,"NC","SCHDT",1998,J),5),?24,$J(^TMP($J,STATION,CLASS,"NC","ECST",1998,J),7,0) D
 ... W ?36,$J(COUNT(STATION,CLASS,"NC","SCHDT",1999,J),5),?47,$J(^TMP($J,STATION,CLASS,"NC","ECST",1999,J),7,0)
 ... W ?59,$J(COUNT(STATION,CLASS,"NC","SCHDT",2000,J),5),?70,$J(^TMP($J,STATION,CLASS,"NC","ECST",2000,J),7,0)
 .. W !,"Unknown",?13,$J(COUNT(STATION,CLASS,"NC","SCHDT",1998,0),5),?24,$J(^TMP($J,STATION,CLASS,"NC","ECST",1998,0),7,0) D
 ... W ?36,$J(COUNT(STATION,CLASS,"NC","SCHDT",1999,0),5),?47,$J(^TMP($J,STATION,CLASS,"NC","ECST",1999,0),7,0)
 ... W ?59,$J(COUNT(STATION,CLASS,"NC","SCHDT",2000,0),5),?70,$J(^TMP($J,STATION,CLASS,"NC","ECST",2000,0),7,0)
CC Q:'COUNT(STATION,CLASS,"CC")
 I IOSL<60 D HOLD,HDR Q:$G(ESCAPE)
 W:IOSL>59 !
 W !,?18,"UPDATE SCHEDULE ("_COUNT(STATION,CLASS,"CC")_" equipment records)"
 W !,"                Calendar 1998          Calendar 1999          Calendar 2000"
 W !,"Month        Count  Est cost($)     Count  Est Cost($)     Count  Est Cost($)"
 W !,UL
 F J=1:1:12 W !,$P(MONTH,U,J),?13,$J(COUNT(STATION,CLASS,"CC","UPG",1998,J),5),?24,$J(^TMP($J,STATION,CLASS,"CC","ECST",1998,J),7,0) D
 . W ?36,$J(COUNT(STATION,CLASS,"CC","UPG",1999,J),5),?47,$J(^TMP($J,STATION,CLASS,"CC","ECST",1999,J),7,0)
 . W ?59,$J(COUNT(STATION,CLASS,"CC","UPG",2000,J),5),?70,$J(^TMP($J,STATION,CLASS,"CC","ECST",2000,J),7,0)
 W !,UL
 W !,"Estimated total cost of updating "_COUNT(STATION,CLASS,"CC")_" item(s) is $"_^TMP($J,STATION,CLASS,"CC","ECST")_"."
 Q
 ;
HDR ;  report header
 Q:$G(ESCAPE)
 W:PAGE>0!($E(IOST,1,2)="C-") @IOF S PAGE=PAGE+1
 W "Cumulative Y2K Report as of "_DATE("PRNT"),?65,"Page: "_PAGE
 W !,$S(ENSTN:"Station: "_STATION,1:"Consolidated ("_STATION("PARNT")_")")
 W ?40,"FUNCTIONAL CLASSIFICATION: "_$S('$G(ENCLASS):"ALL",CLASS=0:"Null",1:CLASS)
 W !,UL
 Q
 ;
HOLD Q:$E(IOST,1,2)'="C-"!($G(ESCAPE))
 W !!,"Press <RETURN> to continue, '^' to escape..." R X:DTIME
 I '$T!($E(X)="^") S ESCAPE=1
 Q
 ;ENY2REP6
