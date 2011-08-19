LRBLJUT ;AVAMC/REG - BB INVENTORY FINAL DISPOSITION ;3/9/94  14:02 ;
 ;;5.2;LAB SERVICE;**247**;Sep 27, 1994
 ;Per VHA Directive 97-033 this routine should not be modified.  Medical Device # BK970021
 D END S X="BLOOD BANK" D ^LRUTL G:Y=-1 END
 W !!,"Units of RED BLOOD CELLS transfused for a treating specialty"
 S DIC=45.7,DIC(0)="AEQM" D ^DIC G:Y<1 END S LRT=$P(Y,U,2) D ^DIC K DIC S:Y>0 LRT=LRT_", "_$P(Y,U,2)
 D B^LRU G:Y<0 END S LRLDT=LRLDT+.99,LRSDT=LRSDT-.0001
 S ZTRTN="QUE^LRBLJUT" D BEG^LRUTL G:POP!($D(ZTSK)) END
QUE U IO D L^LRU,S^LRU K ^TMP($J) S (LRY,LRP)=0 D H
 F B=0:0 S LRSDT=$O(^LRD(65,"A",LRSDT)) Q:'LRSDT!(LRSDT>LRLDT)  F LRI=0:0 S LRI=$O(^LRD(65,"A",LRSDT,LRI)) Q:'LRI  I $D(^LRD(65,LRI,6)),$P(^(6),"^",3)]"",LRT[$P(^(6),"^",3),$D(^(0)) S X=$P(^(0),"^",4) D:$P(^LAB(66,X,0),"^",19) SET
 S Z=0 F LRC=0:1 S Z=$O(^TMP($J,Z)) Q:'Z  S X=^LR(Z,0),Y=$P(X,"^",3),X=^DIC($P(X,"^",2),0,"GL"),X=@(X_Y_",0)"),^TMP($J,"B",$P(X,"^"),Z)=$P(X,"^",9)
 F LRA=0:0 S LRP=$O(^TMP($J,"B",LRP)) Q:LRP=""  F LRDFN=0:0 S LRDFN=$O(^TMP($J,"B",LRP,LRDFN)) Q:'LRDFN  S SSN=^(LRDFN),LRDPF=$P(^LR(LRDFN,0),U,2) D SSN^LRU D A
 W !!,"TOTAL PATIENTS: ",LRC,?31,"TOTAL UNITS: ",LRY,!,"AVERAGE UNITS/PATIENT: ",$S(LRC:$J(LRY/LRC,5,2),1:"") D END^LRUTL,END Q
A S LRX=^TMP($J,LRDFN),LRY=LRY+LRX D:$Y>(IOSL-6) H W !,LRP,?31,SSN,?50,$J(LRX,4) Q
SET S X=+^LRD(65,LRI,6) I X S:'$D(^TMP($J,X)) ^(X)=0 S ^(X)=^(X)+1
 Q
H S LRQ=LRQ+1,X="N",%DT="T" D ^%DT,D^LRU W @IOF,!,Y,?23,"BLOOD BANK ",LRQ(1),?(IOM-10),"Pg:",LRQ
 W !,"Treating ",$S(LRT[",":"Specialties",1:"Specialty"),": ",LRT,!,"Units RBC transfused from ",LRSTR," to ",LRLST,!,"Patient",?31,"SSN",?50,"# Units",!,LR("%") Q
END D V^LRU Q
