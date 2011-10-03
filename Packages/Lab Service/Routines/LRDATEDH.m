LRDATEDH ;DALISC/DRH - DATE RANGE FOR LRRS 1-14-94
 ;;5.2;LAB SERVICE;;Sep 27, 1994
 ;;V1
CONTROL ;
 D LRSD
 I 'OK S LREND=1 QUIT
 D LRED
 I 'OK S LREND=1 QUIT
 Q
LRSD ;
 N X1,X2,X
 S OK=1
 K DIR
 S DIR(0)="D"
 S DIR("A")="Please enter the BEGINNING DATE here"
 S DIR("?",1)="     Date:"
 S DIR("?",2)="      Date can be T for Today"
 S DIR("?",3)="             T+1 for Tommorrow"
 S DIR("?",4)="             T-1 for Yesterday"
 S DIR("?",5)="          OR the date 10-12-93"
 S DIR("?")="  "
 S DIR("B")="T-30"
 D ^DIR
 I $D(DTOUT)!($D(DUOUT)) S OK=0 QUIT
 I $L(X)=2 D HLPDT Q:'OK  G CONTROL QUIT
 I $E(Y,1,1)'=2 D HLPDT Q:'OK  G CONTROL QUIT
 I $L(Y)'<7 D
 . W "  ",$$FMTE^XLFDT(Y,"4D")
 . S X1=Y,X2=-1
 . D C^%DTC
 . S LRSDT=X
 Q
HLPDT ;
 W !,"Insufficient data entered."
 W !,"TYPE ? FOR HELP ",$C(7)
 Q
LRED ;
 S OK=1
 K DIR
 S DIR(0)="D"
 S DIR("A")="Please enter the LAST DATE here"
 S DIR("?",1)="     Date:"
 S DIR("?",2)="      Date can be T for Today"
 S DIR("?",3)="             T+1 for Tommorrow"
 S DIR("?",4)="             T-1 for Yesterday"
 S DIR("?",5)="          OR the date 10-12-93"
 S DIR("?")="  "
 S DIR("B")="TODAY"
 D ^DIR
 I $D(DTOUT)!($D(DUOUT)) S OK=0 QUIT
 I $L(X)=2 D HLPDT Q:'OK  G LRED Q
 I $E(Y,1,1)'=2 D HLPDT Q:'OK  G LRED QUIT
 I $L(Y)'<7 S LREDT=Y
 W "  ",$$FMTE^XLFDT(Y,"4D")
 I LRSDT>LREDT D NONO G CONTROL Q
 Q
NONO W !!,"THE LAST DATE MUST BE AFTER THE BEGINNING DATE!",$C(7),$C(7)
 Q
