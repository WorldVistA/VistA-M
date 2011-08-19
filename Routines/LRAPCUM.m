LRAPCUM ;AVAMC/REG/KLL - AP PATIENT CUM ;9/25/00
 ;;5.2;LAB SERVICE;**34,72,173,248,259**;Sep 27, 1994
 ;
 ;Reference to ^%ZIS supported by IA #10086
 ;Reference to ^DIWP supported by IA #10011
 ;Reference to ^DIWW supported by IA #10029
 ;
 S IOP="HOME" D ^%ZIS,L^LRU
 W !!?15,LRAA(1)," PATIENT REPORT(S) DISPLAY"
P W ! S LR("Q")=0 K DIC D ^LRDPA Q:LRDFN=-1  D R G P
 ;
R W !!,"Is this the patient " S %=1 D YN^LRU Q:%'=1
 I '$D(^LR(LRDFN,LRSS)) W $C(7),!!,"No ",LRAA(1)," reports on file",! Q
 D S F LRI=0:0 W @IOF S LRA(1)=21,LRI=$O(^LR(LRDFN,LRSS,LRI)) Q:'LRI  S B=$G(^(LRI,0)) I B D W Q:LRA(2)?1P
 Q
C S C=0 F LRZ=0:1 S C=$O(^LR(LRDFN,LRSS,LRI,LRV,C)) Q:'C  D:$Y>LRA(1)!'$Y MORE Q:LRA(2)?1P  W !?2,$P(^LR(LRDFN,LRSS,LRI,LRV,C,0),U)
 Q
F D E
 K ^UTILITY($J,"W")
 S C=0 F LRZ=0:1 S C=$O(^LR(LRDFN,LRSS,LRI,LRV,C)) Q:'C!(LRA(2)?1P)  D
 .D:$Y>LRA(1)!'$Y MORE Q:LRA(2)?1P
 .S X=^LR(LRDFN,LRSS,LRI,LRV,C,0),X=$P(X,U)
 .D ^DIWP
 Q:LRA(2)?1P  D:LRZ ^DIWW
 Q
E K ^TMP($J) S DIWL=3,DIWR=IOM-3,DIWF="W" Q
W S Y=+B D D^LRU S LRW(1)=Y,Y=$P(B,"^",10) D D^LRU S LRW(10)=Y,Y=$P(B,"^",3) D D^LRU S LRW(3)=Y,X=$P(B,"^",2) D:X D^LRUA S LRW(2)=X,LRW(11)=$P(B,"^",11)
 S X=$P(B,"^",4) D:X D^LRUA S LRW(4)=X,X=$P(B,"^",7) D:X D^LRUA S LRW(7)=X
 W !,"Date Spec taken: ",LRW(1),?38,"Pathologist:",LRW(2),!,"Date Spec rec'd: ",LRW(10),?38,$S(LRSS="SP":"Resident: ",1:"Tech: "),LRW(4)
 W !,$S($L(LRW(3)):"Date  completed: ",1:"REPORT INCOMPLETE"),LRW(3),?38,"Accession #: ",$P(B,"^",6),!,"Submitted by: ",$P(B,"^",5),?38,"Practitioner:",LRW(7),!,LR("%")
 I LRW(11)="" D A W !,$C(7),"Report not verified",! G MORE
 I $D(^LR(LRDFN,LRSS,LRI,.1)) W !,"Specimen: " S LRV=.1 D C Q:LRA(2)?1P
 I $D(^LR(LRDFN,LRSS,LRI,.2)) W !,"Brief Clinical History:" S LRV=.2 D F Q:LRA(2)?1P
 I $D(^LR(LRDFN,LRSS,LRI,.3)) W !,"Preoperative Diagnosis:" S LRV=.3 D F Q:LRA(2)?1P
 I $D(^LR(LRDFN,LRSS,LRI,.4)) W !,"Operative Findings:" S LRV=.4 D F Q:LRA(2)?1P
 I $D(^LR(LRDFN,LRSS,LRI,.5)) W !,"Postoperative Diagnosis:" S LRV=.5 D F Q:LRA(2)?1P
 D SET^LRUA
 I $O(^LR(LRDFN,LRSS,LRI,1.3,0)) D:$Y>LRA(1)!'$Y MORE Q:LRA(2)?1P  W !,LR(69.2,.13) I $P($G(^LR(LRDFN,LRSS,LRI,6,0)),U,4) S LR(0)=6 D ^LRSPRPTM
 S LRV=1.3 D F Q:LRA(2)?1P
 I $O(^LR(LRDFN,LRSS,LRI,1,0)) D:$Y>LRA(1)!'$Y MORE Q:LRA(2)?1P  W !,LR(69.2,.03) I $P($G(^LR(LRDFN,LRSS,LRI,7,0)),U,4) S LR(0)=7 D ^LRSPRPTM
 S LRV=1 D F Q:LRA(2)?1P
 I $O(^LR(LRDFN,LRSS,LRI,1.1,0)) D:$Y>LRA(1)!'$Y MORE Q:LRA(2)?1P  W !,LR(69.2,.04)," (Date Spec taken: ",LRW(1),")" I $P($G(^LR(LRDFN,LRSS,LRI,4,0)),U,4) S LR(0)=4 D ^LRSPRPTM
 S LRV=1.1 D F Q:LRA(2)?1P  I $O(^LR(LRDFN,LRSS,LRI,1.4,0)) D:$Y>LRA(1)!'$Y MORE Q:LRA(2)?1P  W !,LR(69.2,.14) I $P($G(^LR(LRDFN,LRSS,LRI,5,0)),U,4) S LR(0)=5 D ^LRSPRPTM
 S LRV=1.4 D F Q:LRA(2)?1P
 I $O(^LR(LRDFN,LRSS,LRI,1.2,0)) D
 .W !,"Supplementary Report:"
 .F C=0:0 S C=$O(^LR(LRDFN,LRSS,LRI,1.2,C)) Q:'C!(LRA(2)?1P)  D
 ..S X=^(C,0),Y=+X,X=$P(X,U,2) D D^LRU
 ..W !?3,"Date: ",Y W:'X " not verified"
 ..D:$Y>LRA(1)!'$Y MORE Q:LRA(2)?1P
 ..I X,$P($G(^LR(LRDFN,LRSS,LRI,1.2,C,2,0)),U,4) D
 ...S LRV=C,LR("Q")=LRA(2)
 ...D SUPA^LRSPRPT
 ...S LRA(2)=LR("Q")
 ..D:X U Q:LRA(2)?1P
 Q:LRA(2)?1P
 ;USER MUST POSSESS THE LRLAB KEY TO VIEW SNOMED CODES
 I $D(^LR(LRDFN,LRSS,LRI,2)) D
 .D B
 .I $D(^XUSEC("LRLAB",DUZ)) D ^LRAPCUM1
 Q:LRA(2)?1P  D MORE Q
MORE R !,"'^' TO STOP: ",LRA(2):DTIME I LRA(2)["?" W $C(7) G MORE
 I LRA(2)?1P S A=0 Q
 S LRA(1)=LRA(1)+21
 W $C(13),$J("",15),$C(13)
 Q
S S (A,LRA(2))=0 Q
U D E
 K ^UTILITY($J,"W")
 S E=0
 F LRZ=0:1 S E=$O(^LR(LRDFN,LRSS,LRI,1.2,C,1,E)) Q:'E!(LRA(2)?1P)  D
 .D:$Y>LRA(1)!'$Y MORE Q:LRA(2)?1P
 .S X=^LR(LRDFN,LRSS,LRI,1.2,C,1,E,0)
 .D ^DIWP
 Q:LRA(2)?1P  D:LRZ ^DIWW
 Q
B F C=0:0 S C=$O(^LR(LRDFN,LRSS,LRI,2,C)) Q:'C!(LRA(2)?1P)  D SP
 Q
SP F G=0:0 S G=$O(^LR(LRDFN,LRSS,LRI,2,C,5,G)) Q:'G  S X=^(G,0),Y=$P(X,"^",2),E=$P(X,"^",3),E(1)=$P(X,"^")_":",E(1)=$P($P(LR(LRSS),E(1),2),";") D D^LRU S T(2)=Y D:$Y>LRA(1)!'$Y MORE Q:LRA(2)?1P  D WP
 Q
WP W !,E(1)," ",E," Date: ",T(2)," ",!
 D E
 K ^UTILITY($J,"W")
 S F=0
 F LRZ=0:1 S F=$O(^LR(LRDFN,LRSS,LRI,2,C,5,G,1,F)) Q:'F!(LRA(2)?1P)  D
 .D:$Y>LRA(1)!'$Y MORE Q:LRA(2)?1P
 .S X=^LR(LRDFN,LRSS,LRI,2,C,5,G,1,F,0) D ^DIWP
 Q:LRA(2)?1P  D:LRZ ^DIWW
 Q
A S A=0 F  S A=$O(^LR(LRDFN,LRSS,LRI,97,A)) Q:'A  W !,^(A,0)
 Q
