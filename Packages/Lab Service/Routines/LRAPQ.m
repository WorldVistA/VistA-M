LRAPQ ;AVAMC/REG/CYM - ANAT PATH QUEUE LIST ;2/12/98  10:35 ;
 ;;5.2;LAB SERVICE;**72,201**;Sep 27, 1994
 D ^LRAP G:'$D(Y) END
 W !!,LRO(68)," (",LRABV,")",!!?20,"List of pathology reports in print queue",!!?16,"1. ",$S(LRSS'="AU":"Preliminary",1:"Supplementary")," reports",!?16,"2. ",$S(LRSS'="AU":"Final",1:"Protocols"),?31,$S(LRSS'="AU":"reports",1:"")
ASK W !,"Select 1 or 2 : " R X:DTIME Q:X=""!(X[U)  I X<1!(X>2) W $C(7),!!,"Enter '1' for preliminary reports '2' for final reports" G ASK
 S LRS=X I LRSS="AU",X=1 S LRS=3
 S ZTRTN="QUE^LRAPQ" D BEG^LRUTL G:POP!($D(ZTSK)) END
QUE U IO D L^LRU,S^LRU,H S LR("F")=1,LRC=0
 F LRAN=0:0 S LRAN=$O(^LRO(69.2,LRAA,LRS,LRAN)) Q:'LRAN!(LR("Q"))  S LR=^(LRAN,0),LRDFN=+LR,LRI=$P(LR,U,2) D:$Y>(IOSL-5) H Q:LR("Q")  D L
 I 'LRC W !!,"There are no reports in the print queue."
 D END^LRUTL,END Q
L I LRSS'="AU" Q:$P($P($G(^LR(LRDFN,LRSS,LRI,0)),U,6)," ")'=LRABV  S X=+^(0) G W
 E  Q:$P($P($G(^LR(LRDFN,"AU")),U,6)," ")'=LRABV  S X=+^("AU")
W W !,$J(LRAN,4),?10,$$FMTE^XLFDT(X,"D") S LRC=LRC+1
 S X=^LR(LRDFN,0),Y=$P(X,"^",3),(LRDPF,X)=^DIC($P(X,"^",2),0,"GL"),X=@(X_Y_",0)") S SSN=$P(X,"^",9) D SSN^LRU
 W ?24,$P(X,"^"),?55,SSN Q
H I $D(LR("F")),IOST?1"C".E D M^LRU Q:LR("Q")
 D F^LRU W !,LRO(68)," (",LRABV,") ",$S(LRS=2&(LRSS'="AU"):"FINAL",LRS=1:"PRELIMINARY",LRS=2&(LRSS="AU"):"PROTOCOL(S)",1:"SUPPLEMENTARY"),$S(LRS=2&(LRSS="AU"):"",1:" REPORTS")," IN PRINT QUEUE"
 W !,"Acc #",?12,"Date",?24,"Patient",?55,"SSN",!,LR("%") Q
 ;
END D V^LRU Q
