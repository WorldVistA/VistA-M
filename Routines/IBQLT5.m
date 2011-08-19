IBQLT5 ;LEB/MRY - TRANSMIT PREVIOUS ROLLUPS;; Oct 5, 1995
 ;;1.0;UTILIZATION MGMT ROLLUP LOCAL;**2,3**;Oct 01, 1995
 ;
 Q
ASK ;
 S IBQUIT=0
 S DIR(0)="Y",DIR("A")="Do you wish to submit a previous rollup from the one above",DIR("B")="No"
 W ! D ^DIR G:$D(DUOUT)!($D(DTOUT)) END Q:Y<1
 K DIR
 ;
 S DIR(0)="S^1:4/1/94 to 9/30/94;2:10/1/94 to 3/31/95",DIR("A")="Select number"
 D ^DIR G:$D(DUOUT)!($D(DTOUT)) END
 ;
 I Y=1 S IBBDT=2940401,IBEDT=2940930
 I Y=2 S IBBDT=2941001,IBEDT=2950331
 Q
END ; -- Quit, if this request is aborted.
 S IBQUIT=1 Q
 ;
 ;
 ;
 ;
 ;
RANGE ; Ask user to select a rollup date range.
 S IBQUIT=0 K IBY
 D BLD I IBQUIT G QUIT
 S DIR("A")="Select a roll-up period (by number)",DIR("?")="^D HELP^IBQLT5"
 D ^DIR K DIR
 I '$D(IBY(+Y)) S IBQUIT=1 G QUIT
 ;
 S IBBDT=$P(IBY(+Y),"^",2),IBEDT=$P(IBY(+Y),"^",3)
 ;
QUIT K IBY,Y
 Q
 ;
HELP ; Help text for the rollup period prompt.
 W !!,"You must transmit your data to the national database for a specific"
 W !,"rollup period.  Please select a roll-up period by number, or type '^'"
 W !,"to quit this option."
 Q
 ;
 ;
BLD ; Build IBY array and DIR(0).
 N I,X,X1,X2
 S X=DT F I=1:1:2 D BLD1(X) Q:X2<2940401  S IBY(I)=$$DAT(X1)_" to "_$$DAT(X2)_"^"_X1_"^"_X2,X=X1
 I '$O(IBY(0)) W !!,"There are no Rollup Periods that can be selected for transmission!" S IBQUIT=1 G BLDQ
 ;
 S DIR(0)="S^" S I=0 F  S I=$O(IBY(I)) Q:'I  S DIR(0)=DIR(0)_I_":"_$P(IBY(I),"^")_";"
 S DIR(0)=$E(DIR(0),1,$L(DIR(0))-1)
BLDQ Q
 ;
 ;
BLD1(X) ; Create Rollup Begin and End Dates.
 I +$E(X,4,7)'<930 S X2=$E(X,1,3)_"0930",X1=$E(X,1,3)_"0401" Q
 I +$E(X,4,7)'<331 S X2=$E(X,1,3)_"0331",X1=$E(X,1,3)-1_"1001" Q
 S X2=$E(X,1,3)-1_"0930",X1=$E(X,1,3)-1_"0401"
 Q
 ;
DAT(X) ; Format FileMan dates.
 Q $S(X:+$E(X,4,5)_"/"_+$E(X,6,7)_"/"_$E(X,2,3),1:"")
