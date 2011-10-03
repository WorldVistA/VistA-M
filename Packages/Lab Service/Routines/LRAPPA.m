LRAPPA ;AVAMC/REG - CY/EM/SP PATIENT RPT ;8/12/95  08:15 ;
 ;;5.2;LAB SERVICE;**72**;Sep 27, 1994
 S LRDICS="SPCYEM" D ^LRAP G:'$D(Y) END
 S X="T",%DT="" D ^%DT S LR("Y")=$E(Y,1,3)+1700,IOP="HOME" D ^%ZIS
 W !!?20,LRAA(1)," FINAL PATIENT REPORTS DISPLAY" K LRSAV,LRAP,LRS(99) D EN2^LRUA
 S %DT("A")="Enter year: ",%DT("B")=LR("Y"),%DT="AEQ" D ^%DT G:Y<1 END S LR("Y")=$E(Y,1,3)
A1 R !,"Start with accession #: ",X:DTIME G:X=""!(X[U) END I X<1!(X>99999) W $C(7),!,"Enter a number from 1 to 99999" G A1
 S LR("B")=X
A2 R !,"Go to accession #: ",X:DTIME G:X=""!(X[U) END I X<1!(X>99999) W $C(7),!,"Enter a number from 1 to 99999" G A2
 S LR("E")=X I LR("B")>LR("E") S X=LR("B"),LR("B")=LR("E"),LR("E")=X
 S LR("B")=LR("B")-1
 S LRA(2)=0,LRA=1 D L^LRU,S^LRU,SET^LRUA,XR^LRU I IO=IO(0) S DIWL=3,DIWR=IOM-3,DIWF="W"
 F LRAN=LR("B"):0 S LRAN=$O(^LR(LRXREF,LR("Y"),LRABV,LRAN)) Q:'LRAN!(LRAN>LR("E"))!(LRA(2)?1P)  S LRDFN=$O(^(LRAN,0)),LRI=$O(^(LRDFN,0)) D @$S(IO'=IO(0):"EN^LRSPRPT",1:"D") Q:LRA(2)?1P
 W @IOF D END^LRUTL,END Q
 ;
D W @IOF S (A,LRA(2))=0,LRA(1)=$Y+21,B=^LR(LRDFN,LRSS,LRI,0),X=^LR(LRDFN,0),Y=$P(X,"^",3),X=$P(X,"^",2),X=^DIC(X,0,"GL"),X=@(X_Y_",0)") W !,$P(X,"^"),?38,"SSN: ",$P(X,"^",9) D E^LRAPCUM,W^LRAPCUM Q
END D V^LRU Q
