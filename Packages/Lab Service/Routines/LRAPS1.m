LRAPS1 ;AVAMC/REG/CYM/KLL - ANATOMIC PATH PRINT ;2/9/98  08:04 ;
 ;;5.2;LAB SERVICE;**72,173,201,259**;Sep 27, 1994
 S LRA("A")="Y"
S ;from LRAPS
 F S="SP","CY","EM" D HDR1 Q:LRA("A")]""  F LRI=0:0 S LRI=$O(^LR(LRDFN,S,LRI)) Q:'LRI  D:$Y>(IOSL-3) M Q:LRA("A")]""  D EN
 Q
EN S X=^LR(LRDFN,S,LRI,0),LR("PATH")=$P(X,U,2),N=$P(X,"^",6),N(11)=$P(X,"^",11),X=$P(X,"^",10),X=$P(X,"."),H(2)=$E(X,1,3),LRH(3)=$$Y2K^LRX(X)
 I LR("PATH")]"" S LR("PATH")=$$EXTERNAL^DILFD(63.08,.02,"",LR("PATH"),LR("PATH"))
 S:N="" N="?" S:'H(2) H(2)="?" D:$Y>(IOSL-3) M
 Q:LRA("A")]""  W !?2,"Organ/tissue:",?17,"Date rec'd: ",LRH(3),?43,"Acc #:",N,?64,$E(LR("PATH"),1,12)
 I 'N(11) W !?5,"Report not verified." Q
 ;DON'T DISPLAY SNOMED CODES IF USER DOESN'T HAVE LRLAB KEY
 Q:'$D(^XUSEC("LRLAB",DUZ))
 F O=0:0 S O=$O(^LR(LRDFN,S,LRI,2,O)) Q:'O  D:$Y>(IOSL-3) HDR2 Q:LRA("A")]""  S X=^LR(LRDFN,S,LRI,2,O,0),W(3)=$P(X,"^",3),O(6)=$P(^LAB(61,+X,0),"^") W !?5,O(6) W:W(3) " ",W(3)," gm" D L
 I $D(LRQ(3)) F B=0:0 S B=$O(^LR(LRDFN,S,LRI,99,B)) Q:'B  W !?5,$E(^(B,0),1,74)
 Q
L F B=0:0 S B=$O(^LR(LRDFN,S,LRI,2,O,3,B)) Q:'B  S B(1)=+^(B,0) D:$Y>(IOSL-3) HDR3 Q:LRA("A")]""  W !?10,$P(^LAB(61.3,B(1),0),"^")
 F B=0:0 S B=$O(^LR(LRDFN,S,LRI,2,O,4,B)) Q:'B  S X=^(B,0),B(1)=+X,B(2)=$P(X,"^",2) D:$Y>(IOSL-3) HDR3 Q:LRA("A")]""  W !?10,$P(^LAB(61.5,B(1),0),"^") W:B(2)]"" " (",$S(B(2)=0:"Negative",B(2)=1:"Positive",1:"?"),")"
 F B=0:0 S B=$O(^LR(LRDFN,S,LRI,2,O,1,B)) Q:'B  S B(1)=+^(B,0) D:$Y>(IOSL-3) HDR3 Q:LRA("A")]""  W !?10,$P(^LAB(61.4,B(1),0),"^")
 F M=0:0 S M=$O(^LR(LRDFN,S,LRI,2,O,2,M)) Q:'M  S M(1)=+^(M,0) D:$Y>(IOSL-3) HDR3 Q:LRA("A")]""  W !?10,$P(^LAB(61.1,M(1),0),"^") D E
 F E=0:0 S E=$O(^LR(LRDFN,S,LRI,2,O,5,E)) Q:'E  S E(1)=^(E,0),Y=$P(E(1),"^",2),E(3)=$P(E(1),"^",3),E(4)=$P(E(1),"^")_":",E(4)=$P($P(LR(S),E(4),2),";") D D^LRU S E(2)=Y D:$Y>(IOSL-12) HDR3 W !?5,E(4)," ",E(3)," Date: ",E(2)
 Q
E F E=0:0 S E=$O(^LR(LRDFN,S,LRI,2,O,2,M,1,E)) Q:'E  S E(1)=+^(E,0) D:$Y>(IOSL-3) HDR3 Q:LRA("A")]""  W !?12,$P(^LAB(61.2,E(1),0),"^")
 Q
HDR1 D:$Y>(IOSL-3) M Q:'$O(^LR(LRDFN,S,0))!(LRA("A")]"")  W !,LR("%")
 W !?30,$S(S="SP":"SURGICAL PATHOLOGY",S="CY":"CYTOPATHOLOGY",S="EM":"ELECTRON MICROSCOPY",1:"") Q
HDR2 D M Q:LRA("A")]""
HDR21 W !?3,"Organ/tissue:",?20,"Date rec'd: ",LRH(3),?43,"Acc #:",$J(N,5),?64,$E(LR("PATH"),1,12) Q
HDR3 D M Q:LRA("A")]""  D HDR21 W !?5,O(6) W:W(3) " ",W(3)," gm" Q
 ;
M Q:$D(ORHFS)  ;Don't allow reads if coming from CPRS
 Q:LRA("A")]""  R !,"'^' TO STOP ",LRA("A"):DTIME S:'$T LRA("A")="^" Q:LRA("A")="^"  I LRA("A")]"" W $C(7) G M
 W @IOF,$E(LRP,1,30),?31,SSN,?50,"DOB: ",DOB,?68,"LOC: ",$E(LRLLOC,1,5) D HDR1 Q
