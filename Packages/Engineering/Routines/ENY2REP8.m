ENY2REP8 ;;(WIRMFO)/DH-Print Y2K Summary Reports ;9.30.98
 ;;7.0;ENGINEERING;**51,55**;August 17, 1993
 ;
 ;  extension of ^ENY2REP1
 ;
DEQUE ;  print a summary report
 K ^TMP($J)
 N CAT,MFG,CSN,DA,COUNT,Y2K,PAGE,LINE,DATE,ESCAPE,TOTAL,STATION
 S PAGE=0 D NOW^%DTC S Y=% X ^DD("DD") S DATE("PRNT")=$P(Y,":",1,2)
 S STATION("PARNT")=$P(^DIC(6910,1,0),U,2)
 ;  general initialization
 S TOTAL(STATION("PARNT"))=0 F J=0,"FC","NC","CC","NA" S TOTAL(STATION("PARNT"),J)=0
 ;  end general initialization
CSN I ENTYPE="CSN" D CSN^ENY2REP7 K ENTYPE,ENSUP,ENSORT,ENSTN G EXIT
 ;
CAT I ENTYPE="CAT" D  K ENTYPE,ENSUP,ENSORT,ENSTN G EXIT
 . ;  cat initialization
 . S CAT(0)=0 F  S CAT(0)=$O(^ENG(6914,"G",CAT(0))) Q:'CAT(0)  S ^TMP($J,STATION("PARNT"),"COUNT",CAT(0))=0 F J=0,"NA","FC","NC","CC" S ^TMP($J,STATION("PARNT"),CAT(0),J)=0
 . ;  end cat initialization
 . ;  begin data gather
 . S CAT(0)=0,STATION=STATION("PARNT") F  S CAT(0)=$O(^ENG(6914,"G",CAT(0))) Q:'CAT(0)  K:'$D(^ENG(6911,CAT(0),0)) ^ENG(6914,"G",CAT(0)) I $D(^ENG(6911,CAT(0),0)) S (DA,COUNT)=0 F  S DA=$O(^ENG(6914,"G",CAT(0),DA)) Q:'DA  D
 .. Q:'$D(^ENG(6914,DA,0))
 .. I "^4^5^"[(U_$P($G(^ENG(6914,DA,3)),U)_U) Q
 .. I '$D(ZTQUEUED),'(DA#100) W "." ; activity indicator
 .. S Y2K=$P($G(^ENG(6914,DA,11)),U) S:Y2K="" Y2K=0
 .. I ENSUP,"^NA^FC^"[(U_Y2K_U) Q
 .. ;  initialize station if need be
 .. I ENSTN S STATION=$S($P($G(^ENG(6914,DA,9)),U,5)]"":$P(^(9),U,5),1:STATION("PARNT")) D:'$D(^TMP($J,STATION))
 ... S TOTAL(STATION)=0 F J=0,"FC","NC","CC","NA" S TOTAL(STATION,J)=0
 ... S CAT(1)=0 F  S CAT(1)=$O(^ENG(6914,"G",CAT(1))) Q:'CAT(1)  S ^TMP($J,STATION,"COUNT",CAT(1))=0 F J=0,"FC","NC","CC","NA" S ^TMP($J,STATION,CAT(1),J)=0
 ... ;  end initialize
 .. S ^TMP($J,STATION,"COUNT",CAT(0))=^TMP($J,STATION,"COUNT",CAT(0))+1,^TMP($J,STATION,CAT(0),Y2K)=^TMP($J,STATION,CAT(0),Y2K)+1
 .. S TOTAL(STATION,Y2K)=TOTAL(STATION,Y2K)+1,TOTAL(STATION)=TOTAL(STATION)+1
 .. ;  end data gather
 . ;  begin sort
 . S STATION=0 F  S STATION=$O(^TMP($J,STATION)) Q:STATION=""  S CAT(0)=0 F  S CAT(0)=$O(^TMP($J,STATION,"COUNT",CAT(0))) Q:'CAT(0)  S COUNT=^TMP($J,STATION,"COUNT",CAT(0)) I COUNT D
 .. I $E(ENSORT)="C" D  Q
 ... I $G(ENSORT("MIN"))>COUNT Q
 ... S ^TMP($J,STATION,"SORT",COUNT,CAT(0))=""
 .. S CAT=$P($G(^ENG(6911,CAT(0),0)),U) S:CAT="" CAT=0 S ^TMP($J,STATION,"SORT",CAT,CAT(0))=""
 .. ;  end sort
 . ; print the list
 . U IO
 . I '$D(^TMP($J)) D HEADR W !!,?15,"<Nothing to print>" D HOLD Q
 . S STATION=0 F  S STATION=$O(^TMP($J,STATION)) Q:STATION=""!($G(ESCAPE))  D  Q:$G(ESCAPE)  D HOLD Q:$G(ESCAPE)
 .. D HEADR
 .. I '$D(^TMP($J,STATION,"SORT")) W !!,"** No records to print **" Q
 .. I $E(ENSORT)="C" S J=99999 F  S J=$O(^TMP($J,STATION,"SORT",J),-1) Q:'J!($G(ESCAPE))  S CAT(0)=0 F  S CAT(0)=$O(^TMP($J,STATION,"SORT",J,CAT(0))) Q:'CAT(0)  D PRTCAT Q:$G(ESCAPE)  ; J => count
 .. I $E(ENSORT)="A" S J="" F  S J=$O(^TMP($J,STATION,"SORT",J)) Q:J=""!($G(ESCAPE))  S CAT(0)=0 F  S CAT(0)=$O(^TMP($J,STATION,"SORT",J,CAT(0))) Q:'CAT(0)  D PRTCAT Q:$G(ESCAPE)  ; J => category
 .. D TOTALS
 ;
MFG ; must be by manufacturer
 ;  mfg initialization
 S MFG(0)=0 F  S MFG(0)=$O(^ENG(6914,"K",MFG(0))) Q:'MFG(0)  S ^TMP($J,STATION("PARNT"),"COUNT",MFG(0))=0 F J=0,"NA","FC","NC","CC" S ^TMP($J,STATION("PARNT"),MFG(0),J)=0
 ;  end mfg initialization
 ;  begin data gather
 S MFG(0)=0,STATION=STATION("PARNT") F  S MFG(0)=$O(^ENG(6914,"K",MFG(0))) Q:'MFG(0)  K:'$D(^ENG("MFG",MFG(0),0)) ^ENG(6914,"K",MFG(0)) I $D(^ENG("MFG",MFG(0),0)) S (DA,COUNT)=0 F  S DA=$O(^ENG(6914,"K",MFG(0),DA)) Q:'DA  D
 . Q:'$D(^ENG(6914,DA,0))
 . I "^4^5^"[(U_$P($G(^ENG(6914,DA,3)),U)_U) Q
 . I '$D(ZTQUEUED),'(DA#100) W "." ; activity indicator
 . S Y2K=$P($G(^ENG(6914,DA,11)),U) S:Y2K="" Y2K=0
 . I ENSUP,"^NA^FC^"[(U_Y2K_U) Q
 . ;  initialize station if need be
 . I ENSTN S STATION=$S($P($G(^ENG(6914,DA,9)),U,5)]"":$P(^(9),U,5),1:STATION("PARNT")) D:'$D(^TMP($J,STATION))
 .. S TOTAL(STATION)=0 F J=0,"FC","NC","CC","NA" S TOTAL(STATION,J)=0
 .. S MFG(1)=0 F  S MFG(1)=$O(^ENG(6914,"K",MFG(1))) Q:'MFG(1)  S ^TMP($J,STATION,"COUNT",MFG(1))=0 F J=0,"FC","NC","CC","NA" S ^TMP($J,STATION,MFG(1),J)=0
 .. ;  end initialization
 . S ^TMP($J,STATION,"COUNT",MFG(0))=^TMP($J,STATION,"COUNT",MFG(0))+1,^TMP($J,STATION,MFG(0),Y2K)=^TMP($J,STATION,MFG(0),Y2K)+1
 . S TOTAL(STATION,Y2K)=TOTAL(STATION,Y2K)+1,TOTAL(STATION)=TOTAL(STATION)+1
 . ;  end data gather
 ;  begin sort
 S STATION=0 F  S STATION=$O(^TMP($J,STATION)) Q:STATION=""  S MFG(0)=0 F  S MFG(0)=$O(^TMP($J,STATION,"COUNT",MFG(0))) Q:'MFG(0)  S COUNT=^TMP($J,STATION,"COUNT",MFG(0)) I COUNT D
 . I $E(ENSORT)="C" D  Q
 .. I $G(ENSORT("MIN"))>COUNT Q
 .. S ^TMP($J,STATION,"SORT",COUNT,MFG(0))=""
 . S MFG=$P($G(^ENG("MFG",MFG(0),0)),U) S:MFG="" MFG=0 S ^TMP($J,STATION,"SORT",MFG,MFG(0))=""
 . ;  end sort
 ; print the list
 U IO
 S STATION=0 F  S STATION=$O(^TMP($J,STATION)) Q:STATION=""!($G(ESCAPE))  D  Q:$G(ESCAPE)  D HOLD Q:$G(ESCAPE)
 . D HEADR
 . I '$D(^TMP($J,STATION,"SORT")) W !!,"** No records to print **" Q
 . I $E(ENSORT)="C" S J=99999 F  S J=$O(^TMP($J,STATION,"SORT",J),-1) Q:'J!($G(ESCAPE))  S MFG(0)=0 F  S MFG(0)=$O(^TMP($J,STATION,"SORT",J,MFG(0))) Q:'MFG(0)  D PRTMFG Q:$G(ESCAPE)  ; J => count
 . I $E(ENSORT)="A" S J="" F  S J=$O(^TMP($J,STATION,"SORT",J)) Q:J=""!($G(ESCAPE))  S MFG(0)=0 F  S MFG(0)=$O(^TMP($J,STATION,"SORT",J,MFG(0))) Q:'MFG(0)  D PRTMFG Q:$G(ESCAPE)  ; J => manufacturer
 . D TOTALS
 K ENTYPE,ENSUP,ENSORT,ENSTN
 G EXIT
 ;
PRTCAT I ENSUP W !,$E($P(^ENG(6911,CAT(0),0),U),1,30),?42,$J(^TMP($J,STATION,CAT(0),"NC"),5),?49,$J(^("CC"),5),?63,$J(^(0),5),?71,$J(^TMP($J,STATION,"COUNT",CAT(0)),5)
 I 'ENSUP W !,$E($P(^ENG(6911,CAT(0),0),U),1,30),?35,$J(^TMP($J,STATION,CAT(0),"FC"),5),?42,$J(^("NC"),5),?49,$J(^("CC"),5),?56,$J(^("NA"),5),?63,$J(^(0),5),?71,$J(^TMP($J,STATION,"COUNT",CAT(0)),5)
 S LINE=LINE+1 I (IOSL-LINE)'>4 D HOLD Q:$G(ESCAPE)  I $O(^TMP($J,STATION,"SORT",J,CAT(0)))!($O(^TMP($J,STATION,"SORT",J))]"")!($O(^TMP($J,STATION))]"") D HEADR
 Q
 ;
PRTMFG I ENSUP W !,$E($P(^ENG("MFG",MFG(0),0),U),1,30),?42,$J(^TMP($J,STATION,MFG(0),"NC"),5),?49,$J(^("CC"),5),?63,$J(^(0),5),?71,$J(^TMP($J,STATION,"COUNT",MFG(0)),5)
 I 'ENSUP W !,$E($P(^ENG("MFG",MFG(0),0),U),1,30),?35,$J(^TMP($J,STATION,MFG(0),"FC"),5),?42,$J(^("NC"),5),?49,$J(^("CC"),5),?56,$J(^("NA"),5),?63,$J(^(0),5),?71,$J(^TMP($J,STATION,"COUNT",MFG(0)),5)
 S LINE=LINE+1 I (IOSL-LINE)'>4 D HOLD Q:$G(ESCAPE)  I $O(^TMP($J,STATION,"SORT",J,MFG(0)))!($O(^TMP($J,STATION,"SORT",J))]"")!($O(^TMP($J,STATION))]"") D HEADR
 Q
 ;
TOTALS ;  skip totals if printing high counts only
 Q:$G(ESCAPE)!($G(ENSORT("MIN"))>1)
 K X S $P(X,"-",79)="-" W !,X
 I ENSUP W !,"TOTALS",?42,$J(TOTAL(STATION,"NC"),5),?49,$J(TOTAL(STATION,"CC"),5),?63,$J(TOTAL(STATION,0),5),?71,$J(TOTAL(STATION),5)
 I 'ENSUP W !,"TOTALS",?35,$J(TOTAL(STATION,"FC"),5),?42,$J(TOTAL(STATION,"NC"),5),?49,$J(TOTAL(STATION,"CC"),5),?56,$J(TOTAL(STATION,"NA"),5),?63,$J(TOTAL(STATION,0),5),?71,$J(TOTAL(STATION),5)
 Q
 ;
HEADR ; header for summary listing
 W:PAGE>0!($E(IOST,1,2)="C-") @IOF S PAGE=PAGE+1,LINE=4
 W "Y2K Data by "_$S(ENTYPE="CAT":"EQUIPMENT CATEGORY",1:"MANUFACTURER "),?45,DATE("PRNT"),?70,"Page: "_PAGE
 W !,$S('ENSTN:"Consolidated ("_STATION("PARNT")_")  ",1:"Station: "_STATION_"  ")
 I ENSUP W "(Y2K CATEGORIES 'FC' and 'NA' are being ignored.)"
 W !,$S(ENTYPE="CAT":"EQUIPMENT CATEGORY NAME",1:"MANUFACTURER NAME"),?38,"FC",?45,"NC",?52,"CC",?59,"NA",?64,"NULL",?71,"TOTAL"
 K X S $P(X,"-",79)="-" W !,X
 Q
 ;
HOLD Q:$E(IOST,1,2)'="C-"!($G(ESCAPE))
 W !!,"Press <RETURN> to continue, '^' to escape..." R X:DTIME
 I '$T!($E(X)="^") S ESCAPE=1
 Q
EXIT ;
 K ^TMP($J)
 D ^%ZISC,HOME^%ZIS
 I $D(ZTQUEUED) S ZTREQN="@"
 K J,K,X
 Q
 ;ENY2REP8
