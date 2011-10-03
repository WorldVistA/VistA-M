LRUCN ;AVAMC/REG/CYM - LAB CONSULTS ;2/18/98  12:34 ;
 ;;5.2;LAB SERVICE;**203,247**;Sep 27, 1994
 ;Per VHA Directive 97-033 this routine should not be modified.  Medical Device # BK970021
 D END W !!?20,"CONSULTATION REPORT"
 S DIC=65.9,DIC(0)="AEQMZ",DIC("A")="Select CONSULTATION: ",DIC("S")="I $P(^(0),U,2)=2" D ^DIC K DIC G:Y<1 END S LRL(1)=$P(Y,U,2),LRL=+Y,LRAA=$P(Y(0),U,9) I 'LRAA W $C(7),!,"Must have an accession area for ",LRL(1) G END
 S LRSS=$P(^LRO(68,LRAA,0),U,2),LRDPAF=1
PT D ^LRDPA G:LRDFN<1 END
 I LRL(1)="DIRECT COOMBS TEST REPORT" D ASK G:LRI<1 END
 S ZTRTN="QUE^LRUCN" D BEG^LRUTL G:POP!($D(ZTSK)) END
QUE U IO S %DT="",X="T" D ^%DT,D^LRU S LRD=Y D L^LRU,S^LRU,H I '$D(^LAB(65.9,LRL,0)) W !,LRL(1)," entry in LAB LETTER file (#65.9) was deleted." G OUT
 D SET D:LRSS="BB" ^LRUCNBB
OUT D END^LRUTL,END Q
H S LRQ=LRQ+1 W @IOF,!!!!,LR("%"),!?5,"CLINICAL RECORD ",LRL(1),?51,"|" W:LRQ>1 ?(IOM-8),"Pg:",LRQ W !?5,LRQ(1),?51,"|" W:$D(LRI) "Specimen:",LRI(1) W !,LR("%") Q
W W !,LR("%") Q
F F X=0:0 Q:$Y>(IOSL-12)  W !
 D W W !?60,"(",$S($D(LRE):"End of report",1:"See next page"),")",!,LRS,!,LRS(1),?60,LRD
 D W W !,LRP,?40,"LOC: ",LRLLOC,!,"SSN:",SSN,?16,"SEX:",SEX," DOB: ",DOB W:$D(AGE) " AGE:",AGE W !
 W:$L(LRADM) "ADM:",$E(LRADM,1,12) W:$D(LRADX) ?17,"DX:",$E(LRADX,1,28) W:$L(LRMD) ?46,LRMD Q
SET S X=^LAB(65.9,LRL,0),DIWL=$S($P(X,U,5):$P(X,U,5),1:5),DIWR=IOM-$P(X,U,6),DIWF=$S($P(X,U,7):"D",1:""),DIWF=DIWF_$S($P(X,U,8):"R",1:"")
 S X=$S($D(^LAB(65.9,LRL,3)):^(3),1:""),LRS=$P(X,"^"),LRS(1)=$P(X,"^",2) Q
ASK I '$O(^LR(LRDFN,LRSS,0)) S LRI=-1 W $C(7),!!,"There are no specimen dates for ",LRP," ",SSN Q
 K DIC S DIC="^LR(LRDFN,LRSS,",DIC(0)="AEQM" D ^DIC K DIC S LRI=+Y,Y=$P(Y,U,2),LRI(1)=$$FMTE^XLFDT(Y,"M") Q
END D V^LRU Q
