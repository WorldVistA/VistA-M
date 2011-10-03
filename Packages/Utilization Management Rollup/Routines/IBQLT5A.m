IBQLT5A ;LEB/MRY - TRANSMIT PREVIOUS ROLLUPS;; Oct 5, 1995
 ;;1.0;UTILIZATION MGMT ROLLUP LOCAL;;Oct 01, 1995
 ;
 Q
ASK ;
 S IBQUIT=0
 S DIR(0)="Y",DIR("A")="Do you wish to submit a previous rollup from the one above",DIR("B")="No"
 W ! D ^DIR G:$D(DUOUT)!($D(DTOUT)) END Q:Y<1
 K DIR
 ;
 S DIR(0)="S^1:4/1/94 to 9/30/94;2:10/1/94 to 3/31/95;3:4/1/95 to 9/30/95",DIR("A")="Select number"
 D ^DIR G:$D(DUOUT)!($D(DTOUT)) END
 ;
 I Y=1 S IBBDT=2940401,IBEDT=2940930
 I Y=2 S IBBDT=2941001,IBEDT=2950331
 I Y=3 S IBBDT=2950401,IBEDT=2950930
 Q
END ; -- Quit, if this request is aborted.
 S IBQUIT=1 Q
