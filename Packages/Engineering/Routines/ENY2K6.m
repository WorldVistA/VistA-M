ENY2K6 ;(WASH ISC)/DH-Print Y2K Worklist Header ;8.24.98
 ;;7.0;ENGINEERING;**51,55**;Aug 17, 1993
HDR80 ;  10 pitch worklist
 I $G(ENPG(0))>0,ENPG(0)=ENPG,ENY'>7 W !!,"There are no incomplete Y2K work orders to print.",!
 S X="" I $E(IOST,1,2)="C-" D  Q:X="^"
 . I 'ENPG W @IOF Q
 . D HOLD
 S ($X,$Y)=0 W:ENPG @IOF S ENPG=ENPG+1
 W "Y2K Worklist for "_$E(ENSHOP,1,18)_" Shop thru "_ENY2DT("E")_"  Printed: "_ENDATE_"  Page "_ENPG
 S X(1)="Order: "_ENSRT("A") I "LP"'[ENSRT D
 . I ENSRT="E" S X(1)=X(1)_$S(ENSRT("ALL"):" (All)",1:" (Range)") Q
 . I ENSRT="I" S X(1)=X(1)_$S(ENSRT("ALL"):" (All)",1:" (Range)") Q
 . I ENSRT="C" S X(1)=X(1)_$S(ENSRT("ALL"):" (All)",1:" ("_$E($P($G(^ENG(6911,ENSRT("FR"),0)),U),1,15)_")") Q
 . I ENSRT="S" D
 .. I ENSRT("ALL") S X(1)=X(1)_" (All)" Q
 .. S X(2)=$P($G(^DIC(49,ENSRT("FR"),0)),U,1,2),X(1)=X(1)_" ("_$S($P(X(2),U,2)]"":$P(X(2),U,2),1:$E($P(X(2),U),1,15))_")"
 I ENSRT="L" S X(1)=X(1)_"  " D
 . F I=1:1:$L(ENSRT("BY")) S K=$E(ENSRT("BY"),I) D  S:I'=$L(ENSRT("BY")) X(1)=X(1)_" "
 .. S K=$S(K="D":"DIV",K="B":"BLDG",K="W":"WING",K="R":"ROOM",1:"") Q:K=""
 .. S X(1)=X(1)_K_$S($D(ENSRT(K,"ALL")):"(All)",1:"(Range)")
 W !,X(1)
 W !,$S(ENSRT("OOS"):"Includes ",1:"Does not include ")_"OUT OF SERVICE Equip." I ENTECH'=0 W "  Responsible Tech: "_$S($G(ENEMP)?1A.ANP:$E(ENEMP,1,16),1:"STAFF") W:$G(VACANT) " (VACNT)"
 W !,"Entry #    Equipment Category             Model            Serial Number"
 W !," [ROOM-BLDG-DIV (Wing)]   Manufacturer Equipment Name            Local ID"
 W !," Status   PM #       Manufacturer                   Service"
 W !,"Work Order Number"
 K K S $P(K,"-",79)="-"
 W !,K,!
 S ENY=9
 Q
 ;
HDR96 ; 12 or 16 pitch worklist
 N X,I,K
 I $G(ENPG(0))>0,ENPG(0)=ENPG,ENY'>7 W !!,"There are no incomplete Y2K work orders to print.",!
 S X="" I $E(IOST,1,2)="C-" D  Q:X="^"
 . I 'ENPG W @IOF Q
 . D HOLD
 S ($X,$Y)=0 W:ENPG @IOF S ENPG=ENPG+1
 W "Y2K Worklist for "_ENSHOP_" Shop thru "_ENY2DT("E")_"    Printed: "_TIME_"   Page "_ENPG
 S X(1)="Sort Order: "_ENSRT("A") I "LP"'[ENSRT D
 . I ENSRT="E" S X(1)=X(1)_$S(ENSRT("ALL"):" (All)",1:" (Range)") Q
 . I ENSRT="I" S X(1)=X(1)_$S(ENSRT("ALL"):" (All)",1:" (Range)") Q
 . I ENSRT="C" S X(1)=X(1)_$S(ENSRT("ALL"):" (All)",1:" ("_$E($P($G(^ENG(6911,ENSRT("FR"),0)),U),1,25)_")") Q
 . I ENSRT="S" D
 .. I ENSRT("ALL") S X(1)=X(1)_" (All)" Q
 .. S X(2)=$P($G(^DIC(49,ENSRT("FR"),0)),U,1,2),X(1)=" ("_$S($P(X(2),U,2)]"":$P(X(2),U,2),1:$E($P(X(2),U),1,25))_")"
 I ENSRT="L" S X(1)=X(1)_"  " D
 . F I=1:1:$L(ENSRT("BY")) S K=$E(ENSRT("BY"),I) D  S:I'=$L(ENSRT("BY")) X(1)=X(1)_" "
 .. S K=$S(K="D":"DIV",K="B":"BLDG",K="W":"WING",K="R":"ROOM",1:"") Q:K=""
 .. S X(1)=X(1)_K_$S($D(ENSRT(K,"ALL")):" (All)",1:" (Range)")
 W !,X(1)
 W !,$S(ENSRT("OOS"):"Includes ",1:"Does not include ")_"OUT OF SERVICE Equip." I ENTECH'=0 W "  Responsible Tech: "_$S($G(ENEMP)?1A.ANP:ENEMP,1:"STAFF") W:$G(VACANT) " (VACATED)"
 W !,"Entry #     Equipment Category              Model                Serial Number"
 W !," [ROOM-BLDG-DIV (Wing)]   Manufacturer Equipment Name",?80,"Local ID"
 W !," Status",?18,"PM #       Manufacturer",?60,"Service"
 W !,"Work Order Number"
 K K S $P(K,"-",(IOM-1))="-"
 W !,K,!
 S ENY=9
 Q
 ;
HOLD R !,"Press <RETURN> to continue, '^' to escape...",X:DTIME S:'$T X=U
 Q
 ;
 ;ENY2K6
