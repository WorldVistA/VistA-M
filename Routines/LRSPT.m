LRSPT ;AVAMC/REG/WTY - AP PRELIMINARY REPORTS ;10/16/01
 ;;5.2;LAB SERVICE;**1,72,248,259,373**;Sep 27, 1994;Build 1
 ;
 ;Reference to ^%DT supported by IA #10003
 ;Reference to ^DPT supported by IA #918
 ;Reference to ^DIWP suppported by IA #10011
 ;Reference to ^DIWW suppported by IA #10029
 ;Reference to EN^DDIOL supported by IA #10142
 ;
 S X="T",%DT="" D ^%DT,D^LRU S LRTOD=Y D EN2^LRUA
 W !!,"Preliminary reports for ",LRO(68)
 G END:LRAPX=2,SGL:LRAPX=3,CH:LRAPX=4
GETP D EN1^LRUPS Q:LRAN=-1
 G:$D(^LRO(69.2,LRAA,1,LRAN,0)) GETP
 L +^LRO(69.2,LRAA,1):5  I '$T D  G GETP
 .S MSG(1)="The preliminary reports queue is in use by another person.  "
 .S MSG(1,"F")="!!"
 .S MSG(2)="You will need to add this accession to the queue later."
 .D EN^DDIOL(.MSG) K MSG
 S ^LRO(69.2,LRAA,1,LRAN,0)=LRDFN_"^"_LRI
 S X=^LRO(69.2,LRAA,1,0),^(0)=$P(X,"^",1,2)_"^"_LRAN_"^"_($P(X,"^",4)+1)
 L -^LRO(69.2,LRAA,1)
 G GETP
CH S LRAPX(1)=1 D EN^LRSPRPT2 Q:%<1
 W !!,"Save preliminary reports for reprinting "
 S %=2 D YN^LRU S:%=1 LRSAV=1
 ;Variable LR("DVD") is used to divide reports displayed in the browser
 K LR("DVD")
 S $P(LR("DVD"),"|",IOM)=""
DEV ;
 W !
 S %ZIS="Q" D ^%ZIS
 I POP W ! Q
 I $D(IO("Q")) D  Q
 .S ZTDESC="ANAT PATH PRELIM REPORT"
 .S ZTSAVE("LR*")="",ZTRTN="QUE^LRSPT"
 .D ^%ZTLOAD W:$D(ZTSK) !,"Request Queued, #",ZTSK W !
 .K ZTSK,IO("Q") D HOME^%ZIS
QUE ;
 U IO
 ;LRSF515=1 means this is generating and SF515.
 S:'$D(LRSF515) LRSF515=0
 D L^LRU,L1^LRU,S^LRU,SET^LRUA
 S LR("SPSM")=1  ;Set flag to suppress printing of SNOMED codes
 S LRS(5)=1,LRQ(2)=1,LRA=$S($D(^LRO(69.2,LRAA,0)):$P(^(0),U,9),1:1)
 S:LRA="" LRA=1
 S LR("DIWF")=$S($P(^LRO(69.2,LRAA,0),"^",6)="D":"D",1:"")_"W"
 I $D(LRAP) S LRDFN=$P(LRAP,"^"),LRI=$P(LRAP,"^",2) D D G K
 S LRAN=0 F  S LRAN=$O(^LRO(69.2,LRAA,1,LRAN)) Q:'LRAN!(LR("Q"))  D
 .S X=^LRO(69.2,LRAA,1,LRAN,0),LRDFN=+X,LRI=$P(X,"^",2) D D
 .W:IOST["BROWSER" !!,LR("DVD")
K K:'$D(LRSAV) ^LRO(69.2,LRAA,1) K P,S,LRAN
 S ^LRO(69.2,LRAA,1,0)="^69.21A^^"
 I 'LR("Q"),$D(LR("F")),IOST?1"C".E D CONT
 K LRSAV
 W:IOST?1"P-".E @IOF D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@"
 K %,DIR,DTOUT,DUOUT,DIRUT,X,Y
 Q
D K ^UTILITY($J) I '$D(^LR(LRDFN,0)) K ^LRO(69.2,LRAA,1,LRAN) Q
 N LRPRE S LRPRE=1 ;Notifies EN^LRSPRPT that this is a prelim report
 D EN^LRSPRPT Q:LR("Q")
 I $P($G(^LR(LRDFN,0)),"^",2)=2 D  Q:LR("Q")
 .D ^LRAPPOW
 G:'$D(^LR(LRDFN,"SP",0))&('$D(^LR(LRDFN,"CY",0)))&('$D(^LR(LRDFN,"EM",0))) AU
 D ^LRAPT1 Q:LR("Q")
AU I $D(^LR(LRDFN,"AU")),$L($P(^LR(LRDFN,"AU"),"^")) D ^LRAPT2 Q:LR("Q")
 K ^UTILITY($J) S DIWR=IOM-5,DIWF="W",LR("A")=0
 W ! F LRZ=0:1 S LR("A")=$O(^LRO(69.2,LRAA,10,LR("A"))) Q:'LR("A")  D
 .D:$Y>(IOSL-13) F^LRAPF,H S X=^LRO(69.2,LRAA,10,LR("A"),0) D ^DIWP
 D:LRZ ^DIWW
 S LRO=1 D F^LRAPF
 Q
H ;from LRAPPF1
 D F^LRU W !,"ANATOMIC PATHOLOGY",!,LR("%") Q
END W $C(7),!!,"OK TO DELETE THE ",LRO(68)," PRELIMINARY REPORT LIST" S %=2 D YN^LRU I %=1 K ^LRO(69.2,LRAA,1) S ^LRO(69.2,LRAA,1,0)="^69.21A^0^0" W $C(7),!,"LIST DELETED !" Q
 W !!,"FINE, LET'S FORGET IT",! Q
 ;
SGL D EN1^LRUPS Q:LRAN=-1  S LRAP=LRDFN_"^"_LRI,LRSAV=1 D EN2^LRUA G DEV
CONT ;
 K DIR S DIR(0)="E"
 D ^DIR W !
 S:$D(DTOUT)!(X[U) LR("Q")=1
 Q
