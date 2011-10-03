ENY2REP7 ;;(WIRMFO)/DH-Print Y2K Sum by CSN ;8.7.98
 ;;7.0;ENGINEERING;**51,55**;August 17, 1993
 ;
 ;  extension of ^ENY2REP1
 ;
CSN ;  summary by category stock number
 ;  csn initialization
 S CSN(0)=0 F  S CSN(0)=$O(^ENG(6914,"J",CSN(0))) Q:'CSN(0)  S ^TMP($J,STATION("PARNT"),"COUNT",CSN(0))=0 F J=0,"NA","FC","NC","CC" S ^TMP($J,STATION("PARNT"),CSN(0),J)=0
 ;  end csn initialization
 ;  begin data gather
 S CSN(0)=0,STATION=STATION("PARNT") F  S CSN(0)=$O(^ENG(6914,"J",CSN(0))) Q:'CSN(0)  K:'$D(^ENCSN(6917,CSN(0),0)) ^ENG(6914,"J",CSN(0)) I $D(^ENCSN(6917,CSN(0),0)) S (DA,COUNT)=0 F  S DA=$O(^ENG(6914,"J",CSN(0),DA)) Q:'DA  D
 . Q:'$D(^ENG(6914,DA,0))
 . I "^4^5^"[(U_$P($G(^ENG(6914,DA,3)),U)_U) Q
 . I '$D(ZTQUEUED),'(DA#100) W "." ; activity indicator
 . S Y2K=$P($G(^ENG(6914,DA,11)),U) S:Y2K="" Y2K=0
 . I ENSUP,"^NA^FC^"[(U_Y2K_U) Q
 . ;  initialize station if need be
 . I ENSTN S STATION=$S($P($G(^ENG(6914,DA,9)),U,5)]"":$P(^(9),U,5),1:STATION("PARNT")) D:'$D(^TMP($J,STATION))
 .. S TOTAL(STATION)=0 F J=0,"FC","NC","CC","NA" S TOTAL(STATION,J)=0
 .. S CSN(1)=0 F  S CSN(1)=$O(^ENG(6914,"J",CSN(1))) Q:'CSN(1)  S ^TMP($J,STATION,"COUNT",CSN(1))=0 F J=0,"FC","NC","CC","NA" S ^TMP($J,STATION,CSN(1),J)=0
 .. ;  end initialization
 . S ^TMP($J,STATION,"COUNT",CSN(0))=^TMP($J,STATION,"COUNT",CSN(0))+1,^TMP($J,STATION,CSN(0),Y2K)=^TMP($J,STATION,CSN(0),Y2K)+1
 . S TOTAL(STATION,Y2K)=TOTAL(STATION,Y2K)+1,TOTAL(STATION)=TOTAL(STATION)+1
 . ;  end data gather
 ;  begin sort
 S STATION=0 F  S STATION=$O(^TMP($J,STATION)) Q:STATION=""  S CSN(0)=0 F  S CSN(0)=$O(^TMP($J,STATION,"COUNT",CSN(0))) Q:'CSN(0)  S COUNT=^TMP($J,STATION,"COUNT",CSN(0)) I COUNT D
 . I $E(ENSORT)="C" D  Q
 .. I $G(ENSORT("MIN"))>COUNT Q
 .. S ^TMP($J,STATION,"SORT",COUNT,CSN(0))=""
 . S CSN=$P($G(^ENCSN(6917,CSN(0),0)),U) S:CSN="" CSN=0 S ^TMP($J,STATION,"SORT",CSN,CSN(0))=""
 . ;  end sort
 ; print the list
 U IO
 S STATION=0 F  S STATION=$O(^TMP($J,STATION)) Q:STATION=""!($G(ESCAPE))  D  Q:$G(ESCAPE)  D HOLD Q:$G(ESCAPE)
 . D HEADR
 . I '$D(^TMP($J,STATION,"SORT")) W !!,"** No records to print **" Q
 . I $E(ENSORT)="C" S J=99999 F  S J=$O(^TMP($J,STATION,"SORT",J),-1) Q:'J!($G(ESCAPE))  S CSN(0)=0 F  S CSN(0)=$O(^TMP($J,STATION,"SORT",J,CSN(0))) Q:'CSN(0)  D PRTCSN Q:$G(ESCAPE)  ; J => count
 . I $E(ENSORT)="A" S J="" F  S J=$O(^TMP($J,STATION,"SORT",J)) Q:J=""!($G(ESCAPE))  S CSN(0)=0 F  S CSN(0)=$O(^TMP($J,STATION,"SORT",J,CSN(0))) Q:'CSN(0)  D PRTCSN Q:$G(ESCAPE)  ; J => category stock number
 . D TOTALS
 K ENTYPE,ENSUP,ENSORT,ENSTN
 G EXIT
 ;
PRTCSN I ENSUP W !,$P(^ENCSN(6917,CSN(0),0),U)_" "_$E($P(^(0),U,3),1,30),?42,$J(^TMP($J,STATION,CSN(0),"NC"),5),?49,$J(^("CC"),5),?63,$J(^(0),5),?71,$J(^TMP($J,STATION,"COUNT",CSN(0)),5)
 I 'ENSUP W !,$P(^ENCSN(6917,CSN(0),0),U)_" "_$E($P(^(0),U,3),1,25),?35,$J(^TMP($J,STATION,CSN(0),"FC"),5),?42,$J(^("NC"),5),?49,$J(^("CC"),5),?56,$J(^("NA"),5),?63,$J(^(0),5),?71,$J(^TMP($J,STATION,"COUNT",CSN(0)),5)
 S LINE=LINE+1 I (IOSL-LINE)'>4 D HOLD Q:$G(ESCAPE)  I $O(^TMP($J,STATION,"SORT",J,CSN(0)))!($O(^TMP($J,STATION,"SORT",J))]"")!($O(^TMP($J,STATION))]"") D HEADR
 Q
 ;
TOTALS ;
 Q:$G(ESCAPE)!($G(ENSORT("MIN"))>1)  ; skip totals if printing high counts only
 K X S $P(X,"-",79)="-" W !,X
 I ENSUP W !,"TOTALS",?42,$J(TOTAL(STATION,"NC"),5),?49,$J(TOTAL(STATION,"CC"),5),?63,$J(TOTAL(STATION,0),5),?71,$J(TOTAL(STATION),5)
 I 'ENSUP W !,"TOTALS",?35,$J(TOTAL(STATION,"FC"),5),?42,$J(TOTAL(STATION,"NC"),5),?49,$J(TOTAL(STATION,"CC"),5),?56,$J(TOTAL(STATION,"NA"),5),?63,$J(TOTAL(STATION,0),5),?71,$J(TOTAL(STATION),5)
 Q
 ;
HEADR ; header for summary listing
 W:PAGE>0!($E(IOST,1,2)="C-") @IOF S PAGE=PAGE+1,LINE=4
 W "Y2K Data by CATEGORY STOCK NUMBER",?45,DATE("PRNT"),?70,"Page: "_PAGE
 W !,$S('ENSTN:"Consolidated ("_STATION("PARNT")_")  ",1:"Station: "_STATION_"  ")
 I ENSUP W "(Y2K CATEGORIES 'FC' and 'NA' are being ignored.)"
 W !,"CATEGORY STOCK NUMBER",?38,"FC",?45,"NC",?52,"CC",?59,"NA",?64,"NULL",?71,"TOTAL"
 K X S $P(X,"-",79)="-" W !,X
 Q
 ;
HOLD Q:$E(IOST,1,2)'="C-"
 W !!,"Press <RETURN> to continue, '^' to escape..." R X:DTIME
 I '$T!($E(X)="^") S ESCAPE=1
 Q
EXIT ;
 Q
 ;ENY2REP7
