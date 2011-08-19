LRAPT3 ;AVAMC/REG/WTY - AUTOPSY RPT PRINT COND(1)'T ;10/18/01
 ;;5.2;LAB SERVICE;**1,259,315**;Sep 27, 1994;Build 25
 S:'$D(LRSF515) LRSF515=0
 S A=0 F  S A=$O(^LR(LRDFN,"AY",A)) Q:'A!(LR("Q"))  D
 .S C=0 F F=0:1 S C=$O(^LR(LRDFN,"AY",A,5,C)) Q:'C!(LR("Q"))  D
 ..S X=^LR(LRDFN,"AY",A,5,C,0)
 ..S T=+^LR(LRDFN,"AY",A,0)
 ..S T(1)=$S($D(^LAB(61,T,0)):$P(^(0),"^"),1:"")
 ..D SP
 Q:LR("Q")
 W !
 Q:LRSF515  ;Don't print diagnosis codes on the SF515
 N LRX
 S A=0 F  S A=$O(^LR(LRDFN,80,A)) Q:'A!(LR("Q"))  D
 .D:$Y>(IOSL-6) FF Q:LR("Q")
 .Q:LR("Q")
 .S LRX=+^LR(LRDFN,80,A,0),LRX=$$ICDDX^ICDCODE(LRX,,,1)
 .W !,"ICD code: ",$P(LRX,"^",2),?20
 .S X=$P(LRX,"^",4) D:LRS(5) C^LRUA W X
 Q
SP S Y=$P(X,"^",2),E=$P(X,"^",3),X=$P(X,"^")_":"
 S A1=$P($P(LRAU("S"),X,2),";",1) D D^LRU S T(2)=Y
 I 'LRSF515 D:$Y>(IOSL-6) FF Q:LR("Q")
 I LRSF515 D:$Y>(IOSL-12) FT^LRAURPT,H^LRAURPT Q:LR("Q")
 Q:LR("Q")
 W:'F !!,T(1)
 W !,A1," ",E," Date: ",T(2)
 D E
 S B=0 F LRZ=0:1 S B=$O(^LR(LRDFN,"AY",A,5,C,1,B)) Q:'B!(LR("Q"))  D
 .I 'LRSF515 D:$Y>(IOSL-6) FF Q:LR("Q")
 .I LRSF515 D:$Y>(IOSL-12) FT^LRAURPT,H^LRAURPT Q:LR("Q")
 .Q:LR("Q")
 .S X=^LR(LRDFN,"AY",A,5,C,1,B,0) D ^DIWP
 Q:LR("Q")  D:LRZ ^DIWW Q
E K ^UTILITY($J) S DIWR=IOM-10,DIWL=10,DIWF="W" Q
 ;
FF D H^LRAPT
 Q
