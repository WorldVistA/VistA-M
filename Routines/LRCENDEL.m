LRCENDEL ;SLC/CJS/DALOI/FHS-ORDER CANCELING NO TEST DELETE ;8/11/97
 ;;5.2;LAB SERVICE;**100,121,202,221,263**;Sep 27, 1994
 W @IOF N LRCANK,LRTN
FIND S LREND=0 D ^LRPARAM I $G(LREND) G END
 K LRDFN,LRONE,LRNATURE
 I '$D(LRLABKY) W !?3,"If lab has received the sample (i.e. the test has an accession),",!,"you can't change this order.  If so, call the lab to change the test."
 D
 . N DIR
 . S DIR("A")="ENTER ORDER NUMBER: "
 . S DIR(0)="LO^1:9999999999"
 . S DIR("?")="Enter the number associated with the order. "
 . S DIR("??")="^D ^LROS"
 . S DIR("S")="I $O(^LRO(69,""C"",X,0))"
 . D ^DIR
 G END:$D(DTOUT)!($D(DUOUT))!($D(DIRUT))!($D(DIROUT))
 S LRORD=X
 W @IOF D LOOK G FIND
 Q
LOOK ;
 S LRCNT=0,LRODT=$O(^LRO(69,"C",LRORD,0)) I LRODT<1 W !,"Not found." Q
 S (LRCANK,LROV,LRSN,LRCOL)=0
 F  S LRSN=$O(^LRO(69,"C",+LRORD,LRODT,LRSN)) Q:LRSN<1!($G(LREND))  D:'$G(LREND) SHOW^LROS S LRCNT=1 S:$S($D(^LRO(69,LRODT,1,LRSN,3)):$P(^(3),U,2),1:0) LROV=1 D
 . I $L($P($G(^LRO(69,LRODT,1,LRSN,1)),U,4)),'$D(LRLABKY) S LRCOL=1
 . L +^LRO(69,"C",+LRORD):1 I '$T W !?5,"Someone Else is Editing this order, try later",! S LREND=1 Q
 . S LRTN=0 F  S LRTN=$O(^LRO(69,LRODT,1,LRSN,2,LRTN)) Q:LRTN<1  S X=^(LRTN,0) I '$P(X,"^",11) S LRCANK=1 Q
 I $G(LREND) D UNL69,END Q
 I LRCNT<1 W !,"No order found with that number." D UNL69,END Q
 I 'LRCANK W !!,"[ * All tests on this order # have already been dispositoned. * ]" D NAME Q
 I $G(LRCOL) D  D UNL69,END Q
 . W !!?5," You CAN NOT change the status of test(s) on this order."
 . W !,"Test sample(s) have already been received into the laboratory."
 . W !,"You must CONTACT the Laboratory to have test(s) status changed.",$C(7)
 D NAME
 S LRNOP=0 I 'LROV F I=0:0 W !,"Change entire order" S %=2 D YN^DICN Q:%  W "Answer 'Y'es or 'N'o."
 I 'LROV G END:%=-1,OUT:%=1
 S LRT=0,J=0 F  S J=$O(LRT(J)) Q:J<1  S LRT=J
 I LRT<1 W !,$$CJ^XLFSTR(" Can't change status of test(s) on this order.",IOM),! D UNL69 Q
MORE W !,?8,"entry",?15,"test",?40,"sample"
 S LRT=0,J=0 F  S J=$O(LRT(J)) Q:J<1  S LRT=J W !,?10,J,?15,$P(^LAB(60,$P(LRT(J),U,3),0),U),?40,$P(LRT(J),U,4)
 I LRT=0 W !,"All have been dispositioned from that order." Q
ONE R !,"Change status of which entry: ",LRJ:DTIME W:LRJ["?" !,"Pick one of the following entries:" G MORE:LRJ["?" Q:LRJ["^"!(LRJ="")
 I LRJ'=+LRJ!(LRJ<1)!(LRJ>LRT) W !,"Enter a number between 1 and ",LRT,! G ONE
 I '$D(LRT(LRJ)) W !,"You've already dispositioned that one.",! G MORE
 K LRNATURE
 D FX2^LRTSTOUT I $G(LREND) D UNL69,END Q
 K LRTSTI,LRMSTATI D EN1,UNL69 G LOOK
 Q
EN1 S LREND=0,LRSN=+LRT(LRJ),LRTSTI=+$P(LRT(LRJ),U,2),LRTSTS=+$P(LRT(LRJ),U,3)
 I '$D(^LRO(69,LRODT,1,LRSN,2,LRTSTI,0))#2 W !,"Does not exist ",! Q
 S LRX=^LRO(69,LRODT,1,LRSN,2,LRTSTI,0),LRAD=+$P(LRX,U,3),LRAA=+$P(LRX,U,4),LRAN=+$P(LRX,U,5),LRNOP=0,LRONE="",LRACC=0,ORIFN=$P(LRX,U,7)
 S LRSS=$P($G(^LRO(68,LRAA,0)),U,2)
 S LRTNM=$P($G(^LAB(60,LRTSTS,0)),U)
 I '$L($G(LRNATURE)) D DC^LROR6() I $G(LRNATURE)=-1 W !!,$C(7),"NOTHING CHANGED" Q
 S LRIDT=+$P($G(^LRO(68,LRAA,1,LRAD,1,LRAN,3)),U,5)
 I LRIDT L +^LR(LRDFN,LRSS,LRIDT):1 I '$T W !?5,"Someone else is editing this entry",! S LREND=1 Q
 D SET^LRTSTOUT I LRIDT L -^LR(LRDFN,LRSS,LRIDT)
 D UNL69
 Q
 D CEN1^LRCENDE1 K LRONE Q:LRACC&'$D(^XUSEC("LRLAB",DUZ))
 I LRTSTI,'$G(LRNOP) D 
 . N LRI S LRI(LRTSN)=""
 . D NEW^LR7OB1(LRODT,LRSN,$S($G(LRMSTATI)=""!($G(LRMSTATI)=1):"OC",1:"SC"),$G(LRNATURE),.LRI,$G(LRMSTATI))
 . S $P(^LRO(69,LRODT,1,LRSN,2,LRTSTI,0),"^",3,6)="^^^",$P(^(0),"^",9,11)="CA^L^"_DUZ K T(LRJ)
 . S DIE="^LRO(69,LRODT,1,LRSN,2,",DA=LRTSTI,DA(1)=LRODT,DR=99 D ^DIE
 K LRI
 S X=DUZ D DUZ^LRX
 ;I 'LRNOP S DIE="^LRO(69,LRODT,1,",DA=LRSN,DR="16" D ^DIE
 W:'LRNOP !!,"Status changed to Not Performed" G FIND:$O(LRT(0))<1,ONE
OUT Q:$G(LRNOP)  S LRJ=0
 D FX2^LRTSTOUT I $G(LREND) D UNL69,END Q
 S LRCCOMX=LRCCOM
 S LRJ=0 F  S LRJ=$O(LRT(LRJ)) Q:LRJ<1  S LRCCOM=LRCCOMX D EN1
 K LRCCOMX D UNL69
 Q
 S LRSN=0 F  S LRSN=$O(^LRO(69,"C",+LRORD,LRODT,LRSN)) Q:LRSN<1  D
 . S LRX=^LRO(69,LRODT,1,LRSN,2,LRTSTI,0),LRAD=$P(LRX,U,3),LRAA=+$P(LRX,U,4),LRAN=+$P(LRX,U,5),LRNOP=0,LRONE="",LRACC=0,ORIFN=$P(LRX,U,7)
 K LRNATURE G FIND
% R %:DTIME Q:%=""!(%["N")!(%["Y")  W !,"Answer 'Y' or 'N': " G %
 Q
UNL69 ;
 L -^LRO(69,"C",+LRORD)
 Q
NAME S LRDFN=+^LRO(69,LRODT,1,$O(^LRO(69,"C",+LRORD,LRODT,0)),0),LRDPF=$P(^LR(LRDFN,0),U,2),DFN=$P(^(0),U,3) D PT^LRX W !,PNM,?30,SSN
EN ;from LRPHITE3
 K LRT S (J,LRSN,LRNOP)=0 F  S LRSN=$O(^LRO(69,"C",+LRORD,LRODT,LRSN)) Q:LRSN<1!($G(LRNOP))  D TSET
 Q
TSET I $D(^LRO(69,LRODT,1,LRSN,3)),$P(^(3),"^",2) D  Q
 . W !,$$CJ^XLFSTR("Test(s) already verified for this order, cannot change ENTIRE order",IOM)
 . W !,$$CJ^XLFSTR(" You must select individual test using the 'Delete Test from Accession' option.",IOM),!!
 . D UNL69 S LRNOP=1
 S I=0 F  S I=$O(^LRO(69,LRODT,1,LRSN,2,I)) Q:I<1  S X=^(I,0) D
 . Q:$P(X,"^",11)
 . I $P(X,U,3),'$D(LRLABKY) Q
 . S J=J+1,LRSPEC=$S($D(^LRO(69,LRODT,1,LRSN,4,1,0)):+^(0),1:""),LRT(J)=LRSN_U_I_U_+X_U_$S(LRSPEC:$P(^LAB(61,+LRSPEC,0),U),1:"")_U_$P(X,U,2,99)
 Q
END K %,A,AGE,DFN,DIC,DIE,DOB,DQ,DR,DWLW,I,J,K,LRAA,LRACC,LRACN0,LRAD,LRAN,LRCL,LRCNT,LRCOL,LRDOC,LRDPF,LRDTM,LREND,LRIDT
 K LRNOW,LRLL,LRLLOC,LRNOP,LROD0,LROD1,LROD3,LRODT,LROOS,LRORD,LROS,LROSD,LROT,LROV,LRROD
 K LRSCNXB,LRSN,LRSPEC,LRSS,LRTC,LRTP,LRTSTS,LRT,LRTT,LRURG,LRUSI,LRUSNM,LRWRD,PNM,SEX,SSN,T,X,X1,X2,X3,X4,Y,Z,LRNATURE,ORIFN
 K LRCANK,LRTN,LRCCOM,LRCCOM1 D END^LRTSTOUT
 K LRACN,LRJ,LRTSTI
 Q
