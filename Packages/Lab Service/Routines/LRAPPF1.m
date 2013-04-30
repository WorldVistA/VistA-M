LRAPPF1 ;DALOI/STAFF - ANAT PATH FILE PRINT BY PT ;11/17/11  10:59
 ;;5.2;LAB SERVICE;**72,173,201,259,362,392,350**;Sep 27, 1994;Build 230
 ;
 ;Reference to ^DIC supported by IA #916
 ;
 I $G(LRSF515)="" N LRSF515 S LRSF515=0
 ;
 S F=0
 F  S F=$O(^TMP($J,F)) Q:'F!(LR("Q"))  D
 . S F(1)=$P(^DIC(F,0),"^"),F(2)=^DIC(F,0,"GL")
 . K LR("F") D H S LR("F")=1 D W
 Q:LR("Q")
 D ^LRAPPF2
 Q
 ;
 ;
W ;
 S W=0
 F LRB=0:0 S W=$O(^TMP($J,F,W)) Q:W=""!(LR("Q"))  D LR
 Q
 ;
 ;
LR ;
 S LRDFN=0
 F  S LRDFN=$O(^TMP($J,F,W,LRDFN)) Q:'LRDFN!(LR("Q"))  D NM
 Q
 ;
 ;
NM ;
 S X=^LR(LRDFN,0),LRDPF=$P(X,U,2),N=$P(X,"^",3),N=@(F(2)_N_",0)")
 S LRP=$P(N,"^"),SSN=$P(N,"^",9),Y=$P(N,"^",3)
 D D^LRU,SSN^LRU S DOB=$S(Y'[1700:Y,1:"")
 ;
 I $Y>(IOSL-4) D H Q:LR("Q")
 ;
 W !!,LRP,?31,SSN W:DOB'="" ?51,"BORN: ",DOB
 S LRI=0
 F  S LRI=$O(^TMP($J,F,W,LRDFN,LRI)) Q:'LRI!(LR("Q"))  D
 . D @($S("CYEMSP"[LRSS:"EN",1:"AUT"))
 Q
 ;
 ;
AUT S LRSF515=+$G(LRSF515)
 D:$Y>(IOSL-12) H1 Q:LR("Q")
 S X=^LR(LRDFN,"AU"),N=$P(X,"^",6),Y=+X D D^LRU S LRH(3)=Y,DA=LRDFN
 D D^LRAUAW S Y=LR(63,12) D D^LRU S E=Y,H(2)=$E(H(1),1,3)
 W !,"AUTOPSY #: ",N," AUTOPSY DATE: ",LRH(3),?51,"DIED: ",E
 D EN^LRAPT2
 S X=0 F  S X=$O(^LR(LRDFN,"AY",X)) Q:'X!(LR("Q"))  D
 . S Y=+^LR(LRDFN,"AY",X,0),Y=$S($D(^LAB(61,Y,0)):$P(^(0),"^"),1:Y)
 . W !,Y D AM
 Q
 ;
 ;
AM S M=0 F  S M=$O(^LR(LRDFN,"AY",X,2,M)) Q:'M!(LR("Q"))  D
 . S Y=+^LR(LRDFN,"AY",X,2,M,0)
 . S Y=$S($D(^LAB(61.1,Y,0)):$P(^(0),"^"),1:Y)
 . W !?5,Y
 Q
 ;
 ;
EN ; from LRAPT1,LRAPQACN
 S LRSF515=+$G(LRSF515)  ;Indicates that this is generating an SF515
 S X=$G(^LR(LRDFN,S,LRI,0)) Q:X=""  S LR("PATH")=$P(X,U,2),N=$P(X,U,6)
 S N(11)=$P(X,U,11),X=$P(X,U,10),X=$P(X,"."),LRH(3)=$$Y2K^LRX(X)
 S H(2)=$E(X,1,3)
 I LR("PATH")]"" S LR("PATH")=$$EXTERNAL^DILFD(LRSF,.02,"",LR("PATH"),LR("PATH"))
 S:N="" N="?" S:'H(2) H(2)="?"
 I LRSF515,($Y>(IOSL-11)) D H1 Q:LR("Q")
 I 'LRSF515,($Y>(IOSL-4)) D H1 Q:LR("Q")
 ;
 W !?2,"Organ/tissue:",?17,"Date rec'd: ",LRH(3),?43,"Acc #:",N
 W ?64,$E(LR("PATH"),1,12)
 I 'N(11) W !?5,"Report not verified." Q
 ; SNOMED codes
 I '+$G(LR("SPSM")) D  Q:LR("Q")
 . S O=0
 . F  S O=$O(^LR(LRDFN,S,LRI,2,O)) Q:'O!(LR("Q"))  D
 . . I LRSF515,($Y>(IOSL-11)) D H2 Q:LR("Q")
 . . I 'LRSF515,($Y>(IOSL-4)) D H2 Q:LR("Q")
 . . S X=^LR(LRDFN,S,LRI,2,O,0),W(3)=$P(X,"^",3)
 . . S O(6)=$P(^LAB(61,+X,0),"^")
 . . W !?5,O(6) W:W(3) " ",W(3)," gm"
 . . D L
 ; Comments
 I $D(LRQ(3)) D
 . S B=0 F  S B=$O(^LR(LRDFN,S,LRI,99,B)) Q:'B!(LR("Q"))  D
 . . W !?5,$E(^LR(LRDFN,S,LRI,99,B,0),1,74)
 . . I LRSF515,($Y>(IOSL-11)) D H2 Q:LR("Q")
 . . I 'LRSF515,($Y>(IOSL-4)) D H2 Q:LR("Q")
 Q
 ;
 ;
DES ; Print Microscopic Description
 Q:$G(LR("Q"))
 ; If printing SF515 then only print main entry (LRAP="LRDFN^LRIDT") or entry on print queue
 I $G(LRSF515),LRAPX=3,$G(LRAP),(LRSS'=S!(LRI'=$P(LRAP,"^",2))) Q
 I $G(LRSF515),LRAPX=4,$G(LRPRE),(LRSS'=S!(LRI'=$P(^LRO(69.2,LRAA,1,LRAN,0),"^",2))) Q
 Q:'$O(^LR(LRDFN,S,LRI,1.1,0))
 W !!,"Microscopic Description/Diagnosis:"
 N X,LRL,LRVAL
 S LRL=0
 F  S LRL=$O(^LR(LRDFN,S,LRI,1.1,LRL)) Q:LRL<1!$G(LR("Q"))  I ($D(^(LRL,0))#2) S LRVAL=$G(^(0)) D
 . I $Y>(IOSL-13) D H2 Q:$G(LR("Q"))  W !!,"Microscopic Description/Diagnosis:"
 . W !?5,LRVAL
 W !
 Q
 ;
 ;
L ;
 S B=0
 F  S B=$O(^LR(LRDFN,S,LRI,2,O,3,B)) Q:'B!(LR("Q"))  D
 . S B(1)=+^LR(LRDFN,S,LRI,2,O,3,B,0)
 . I LRSF515,($Y>(IOSL-11)) D H3 Q:LR("Q")
 . I 'LRSF515,($Y>(IOSL-4)) D H3 Q:LR("Q")
 . W !?10,$P(^LAB(61.3,B(1),0),"^")
 S B=0
 F  S B=$O(^LR(LRDFN,S,LRI,2,O,4,B)) Q:'B!(LR("Q"))  D
 . S X=^LR(LRDFN,S,LRI,2,O,4,B,0),B(1)=+X,B(2)=$P(X,"^",2)
 . I LRSF515,($Y>(IOSL-11)) D H3 Q:LR("Q")
 . I 'LRSF515,($Y>(IOSL-4)) D H3 Q:LR("Q")
 . W !?10,$P(^LAB(61.5,B(1),0),"^")
 . W:B(2)]"" " (",$S(B(2)=0:"Negative",B(2)=1:"Positive",1:"?"),")"
 S B=0
 F  S B=$O(^LR(LRDFN,S,LRI,2,O,1,B)) Q:'B!(LR("Q"))  D
 . S B(1)=+^LR(LRDFN,S,LRI,2,O,1,B,0)
 . I LRSF515,($Y>(IOSL-11)) D H3 Q:LR("Q")
 . I 'LRSF515,($Y>(IOSL-4)) D H3 Q:LR("Q")
 . W !?10,$P(^LAB(61.4,B(1),0),"^")
 S M=0
 F  S M=$O(^LR(LRDFN,S,LRI,2,O,2,M)) Q:'M!(LR("Q"))  D
 . S M(1)=+^LR(LRDFN,S,LRI,2,O,2,M,0)
 . I LRSF515,($Y>(IOSL-11)) D H3 Q:LR("Q")
 . I 'LRSF515,($Y>(IOSL-4)) D H3 Q:LR("Q")
 . W !?10,$P(^LAB(61.1,M(1),0),"^") D E
 S E=0
 F  S E=$O(^LR(LRDFN,S,LRI,2,O,5,E)) Q:'E!(LR("Q"))  D
 . S E(1)=^LR(LRDFN,S,LRI,2,O,5,E,0) D A
 Q
 ;
 ;
A ;
 S Y=$P(E(1),"^",2),E(3)=$P(E(1),"^",3),E(4)=$P(E(1),"^")_":"
 S E(4)=$P($P(LR(S),E(4),2),";") D D^LRU S E(2)=Y D D^LRU
 I LRSF515,($Y>(IOSL-11)) D H3 Q:LR("Q")
 I 'LRSF515,($Y>(IOSL-4)) D H3 Q:LR("Q")
 W !?5,E(4)," ",E(3)," Date: ",E(2)
 Q
 ;
 ;
E ;
 S E=0
 F  S E=$O(^LR(LRDFN,S,LRI,2,O,2,M,1,E)) Q:'E!(LR("Q"))  W !?12,$P(^LAB(61.2,+^LR(LRDFN,S,LRI,2,O,2,M,1,E,0),0),"^")
 Q
 ;
 ;
H ;
 ;
 I LRSF515 D F^LRAPF,^LRAPF Q
 I $D(LR("F")),IOST?1"C".E D M^LRU Q:LR("Q")
 I $D(LRQ(2)) D H^LRSPT Q
 I $D(LRQ(9)) D H^LRAPT1 Q
 D F^LRU W !,LRO(68)," "
 W:F(2)'="^DPT(" !,"Demographic data in ",F(1)," file."
 W !,"Entries listed by PATIENT (From: ",LRSTR," to: ",LRLST,")"
 W !,"Name",?31,"Identifier"
 W !,LR("%")
 Q
 ;
 ;
H1 ;
 D H
 I '$D(LRQ(9)) W !,LRP,?30,SSN,?42,DOB
 Q
 ;
 ;
H2 ;
 D H1
 W !?5,"Organ/tissue:",?25,"Date received: ",LRH(3),?51,"Acc #:",N
 Q
 ;
 ;
H3 ;
 D H2
 W !?5,O(6) W:W(3) " ",W(3)," gm"
 Q
