LRSPRPTM ;AVAMC/REG/WTY - MODIFIED PATH REPORT ;9/22/00
 ;;5.2;LAB SERVICE;**1,248**;Sep 27, 1994
 ;
 ;Reference to ^VA(200 supported by IA #10060
 ;Reference to ^DIWP suppported by IA #10011
 ;Reference to ^DIWW suppported by IA #10029
 ;
 W !?28,"*** MODIFIED REPORT ***"
 W !,"(Last modified: "
 S B=0
 F A=0:0 S A=$O(^LR(LRDFN,LRSS,LRI,LR(0),A)) Q:'A!(LR("Q"))  S B=A
 Q:LR("Q")  Q:'$D(^LR(LRDFN,LRSS,LRI,LR(0),B,0))
 S A=^LR(LRDFN,LRSS,LRI,LR(0),B,0),Y=+A,A=$P(A,"^",2)
 S A=$S($D(^VA(200,A,0)):$P(^(0),"^"),1:A)
 D D^LRU W Y," typed by ",A,")"
 D:$D(LRQ(9)) M
 Q
 ;
M F A=0:0 S A=$O(^LR(LRDFN,LRSS,LRI,LR(0),A)) Q:'A!(LR("Q"))  D
 .S LRT=^LR(LRDFN,LRSS,LRI,LR(0),A,0)
 .D:$Y>(IOSL-14) F^LRAPF,^LRAPF Q:LR("Q")
 .S Y=+LRT,X=$P(LRT,"^",2),X=$S($D(^VA(200,X,0)):$P(^(0),"^"),1:X)
 .D D^LRU W !,"Date modified:",Y," typed by ",X D F
 Q:LR("Q")
 W !?13,"==========Text below appears on final report=========="
 Q
E K ^UTILITY($J) S DIWR=IOM-5,DIWL=5,DIWF="W"
 Q
 ;
F D E S B=0
 F LRZ=0:1 S B=$O(^LR(LRDFN,LRSS,LRI,LR(0),A,1,B)) Q:'B!(LR("Q"))  D
 .S LRT=^LR(LRDFN,LRSS,LRI,LR(0),A,1,B,0)
 .D:$Y>(IOSL-14) F^LRAPF,^LRAPF Q:LR("Q")
 .S X=LRT D ^DIWP
 Q:LR("Q")  D:LRZ ^DIWW
 Q
