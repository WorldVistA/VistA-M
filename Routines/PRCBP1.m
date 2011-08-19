PRCBP1 ;WISC/CTB-PRINT OPTIONS FOR RD 2-285 REPORTS ;5/3/93  9:39 AM
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
OUT K %,%X,DP,IOX,IOY,PRCF Q
EN1 ;FIRST QUARTER
 S FLDS="[PRCB 285 1ST QTR]" D ALL,OUT Q
 ;
EN2 ;SECOND QUARTER
 S FLDS="[PRCB 285 2ND QTR]" D ALL,OUT Q
EN3 ;THIRD QUARTER
 S FLDS="[PRCB 285 3RD QTR]" D ALL,OUT Q
EN4 ;FOURTH QUARTER
 S FLDS="[PRCB 285 4TH QTR]" D ALL,OUT Q
EN5 ;OCTOBER - DECEMBER
 S FLDS="[PRCB 285 OCT-MAR]" D ALL,OUT Q
EN6 ;APRIL - SEPTEMBER
 S FLDS="[PRCB 285 APR-SEP]" D ALL,OUT Q
EN7 ;COMPLETE FISCAL YEAR
 S FLDS="[PRCB 285 FISCAL YEAR]" D ALL,OUT Q
ALL S PRCF("X")="ABFS" D ^PRCFSITE Q:'%
 D WAIT S FR=$O(^PRCF(421,"AJ",PRCF("SIFY"),0)) I FR="" W !,"NO TRANSACTIONS IN FY ",PRC("FY") Q
 S BY="[PRCB SORT BY SIFY/TDA]",FR=PRCF("SIFY"),TO=PRCF("SIFY"),DIC="^PRCF(421," D EN1^DIP Q
 Q
WAIT ;
 W !,"..."
 W $P("Whoops^Hmmm^Excuse me^Sorry","^",$R(4)+1),", "
 W $P($T(LIST+$R(6)),";",3)_"..."
LIST ;;This may take a few moments
 ;;Let me put you on 'HOLD' for a second
 ;;Hold on
 ;;Just a moment, please
 ;;I'm working as fast as I can
 ;;Let me think about this for a moment
 ;
