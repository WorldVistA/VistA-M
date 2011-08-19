LRAPAUSR ;AVAMC/REG/WTY - AUTOPSY SUPPLEMENTARY REPORT;9/14/01
 ;;5.2;LAB SERVICE;**1,173,248,259,317**;Sep 27, 1994
 ;
 ;Reference to ^DD(63 supported by IA #10155
 ;
 S X="T",%DT="" D ^%DT,D^LRU S LRH(3)=Y,LRFLG=1
 W !!,LRO(68)," Autopsy Supplementary Reports" D XR^LRU
 S LRS(1)=$P(^LRO(69.2,LRAA,0),U,3),LRS(2)=$P(^(0),U,4)
 D EN2^LRUA
 G END:LRAPX=2,SGL:LRAPX=3,CH:LRAPX=4
 S XTMP="Someone else is building a print queue for this Accession Area"
 L +^LRO(69.2,LRAA,3):5 I '$T D EN^DDIOL(XTMP,"","$C(7),!!") K XTMP Q
GETP ;Add a patient to the report queue
 W ! S X="" D ^LRUPS G GETP:LRAN["?" I LRAN=-1 L -^LRO(69.2,LRAA,3) Q
 S FDAIEN(2)=LRAN
 S FDA(1,69.29,"+2,"_+LRAA_",",.01)=LRDFN
 D UPDATE^DIE("","FDA(1)","FDAIEN") K FDAIEN G GETP
CH I '$O(^LRO(69.2,LRAA,3,0)) D  Q
 .W $C(7),!!,"No AUTOPSY SUPPLEMENTARY REPORTS currently on the "
 .W "print queue.",!!
SPC R !,"(D)ouble or (S)ingle spacing of report(s): ",X:DTIME
 Q:X=""!(X[U)
 I $E(X)'="D"&($E(X)'="S") D  G SPC
 .W $C(7),!,"Enter 'S' for single or 'D' for double spacing of reports"
 S LRS=$S(X="D":"D",1:"")_"W" Q:LRAPX=3
 W !!,"Save supplementary report list for reprinting "
 S %=2 D YN^LRU S:%=1 LRSAV=1
DEV ;
 W !
 S %ZIS="Q" D ^%ZIS
 I POP W ! Q
 I $D(IO("Q")) D  Q
 .S ZTDESC="ANAT PATH FINAL REPORT"
 .S ZTSAVE("LR*")="",ZTRTN="QUE^LRAPAUSR"
 .D ^%ZTLOAD W:$D(ZTSK) !,"Request Queued, #",ZTSK W !
 .K ZTSK,IO("Q") D HOME^%ZIS
QUE U IO D L^LRU,S^LRU,EN^LRUA
 ;LRSF515=1 indicates that an SF515 is being generated.
 S:'$D(LRSF515) LRSF515=0
 S (LRS(5),LRAURPT)=1
 I $D(LRAP) S LRDFN=LRAP D EN Q:LR("Q")  K LRAP G LST
 F LRAN=0:0 S LRAN=$O(^LRO(69.2,LRAA,3,LRAN)) Q:'LRAN!(LR("Q"))  D
 .S LRDFN=+^(LRAN,0) D EN
LST K:'$D(LRSAV) ^LRO(69.2,LRAA,3) K LRAURPT
 S:'$D(^LRO(69.2,LRAA,3,0)) ^(0)="^69.29A^0^0"
 I 'LR("Q"),$D(LR("F")),IOST?1"C".E D CONT
 K LRSAV D K^LRU
 W:IOST?1"P-".E @IOF D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@"
 K %,DIR,DTOUT,DUOUT,DIRUT,X,Y
 Q
W W !,LR("%") Q
E K ^UTILITY($J) S DIWR=IOM-5,DIWL=5,DIWF=LRS Q
 ;
EN S LRQ=0,X=^LR(LRDFN,0) Q:'$O(^LR(LRDFN,84,0))  D ^LRUP
 I '$D(^LR(LRDFN,"AU")) L +^LRO(69.2,LRAA,3,LRAN):5 Q:'$T  D  Q
 .S DIK="^LRO(69.2,LRAA,3,",DA=LRAN,DA(1)=0
 .D ^DIK K KA,DIK
 .L -^LRO(69.2,LRAA,3,LRAN)
 S X=^LR(LRDFN,"AU"),LRAC=$P(X,"^",6),LRM(2)=$P(X,"^",7)
 S LRM(1)=$P(X,"^",12),LRW(9)=$P(X,"^",13),LRM(3)=$P(X,"^",10)
 S Y=$P(X,"^"),LRH(2)=$E(Y,2,3) D D^LRU S LRH(1)=Y
 S LRLLOC=$P(X,"^",5),AGE=$P(X,"^",9)
 ;Define the service
 S Y=$P(X,"^",8),C=$P(^DD(63,14.5,0),U,3)
 D Y^DIQ S LRSVC=Y
 ;Define autopsy type
 S Y=$P(X,"^",11),C=$P(^DD(63,13.7,0),U,3)
 D Y^DIQ S LRS(3)=Y
 S DA=LRDFN D D^LRAUAW S Y=LR(63,12) D D^LRU S LRH=Y,X=LRM(1)
 D:X D^LRUA S LRM(1)=X,X=LRM(2) D:X D^LRUA S LRM(2)=X,X=LRM(3)
 D:X D^LRUA S LRM(3)=X
 D H Q:LR("Q")  S LR("F")=1
 W:LRH(1)="" !?20,"+*+* REPORT INCOMPLETE *+*+"
 S LRA=0 F  S LRA=$O(^LR(LRDFN,84,LRA)) Q:'LRA!(LR("Q"))  D
 .S LRB=^LR(LRDFN,84,LRA,0)
 .D:$Y>(IOSL-13) FT,H Q:LR("Q")
 .W !!,"SUPPLEMENTARY REPORT DATE: "
 .S Y=LRB D D^LRU W Y
 .D:$Y>(IOSL-13) FT,H Q:LR("Q")
 .D:$P($G(^LR(LRDFN,84,LRA,2,0)),U,4) SUPA
 .D WRT
 Q:LR("Q")  D FT Q
WRT D E S LRC=0
 F LRZ=0:1 S LRC=$O(^LR(LRDFN,84,LRA,1,LRC)) Q:'LRC!(LR("Q"))  D
 .D:$Y>(IOSL-13) FT,H S LR("F")=1 Q:LR("Q")
 .S X=^LR(LRDFN,84,LRA,1,LRC,0) D:X["|TOP|" TOP D ^DIWP
 Q:LR("Q")  D:LRZ ^DIWW
 Q
SUPA ;Print supplementary report audit information
 W !?14,"*+* SUPPLEMENTARY REPORT HAS BEEN ADDED/MODIFIED*+*"
 W !,"(Added/Last modified: "
 S (A,B)=0 F  S A=$O(^LR(LRDFN,84,LRA,2,A)) Q:'A!(LR("Q"))  D
 .S B=A
 Q:LR("Q")
 Q:'$D(^LR(LRDFN,84,LRA,2,B,0))
 S A=^(0),Y=+A,LRSGN=" typed by ",A2=$P(A,"^",2)
 I $P(A,"^",3) D
 .S LRSGN=" signed by ",A2=$P(A,"^",3),Y=$P(A,"^",4)
 S A2=$S($D(^VA(200,A2,0)):$P(^(0),"^"),1:A2)
 ;If supp rpt is released, display 'signed by' instead of 'typed by'
 D D^LRU W Y,LRSGN,A2,")"
 ;If RELEASE SUPP REPORT MODIFIED set to 1, display "NOT VERIFIED"
 I $P(^LR(LRDFN,84,LRA,0),"^",3) W !,?25,"**-* NOT VERIFIED *-**"
 D:$D(LRQ(9)) SUPM
 Q
SUPM ;Print previous versions of supplementary reports
 ;This is used by menu option 'Print path modifications [LRAPMOD]'
 ;
 S A=0 F  S A=$O(^LR(LRDFN,84,LRA,2,A)) Q:'A!(LR("Q"))  D
 .S LRT=^LR(LRDFN,84,LRA,2,A,0)
 .D:$Y>(IOSL-13) FT,H Q:LR("Q")
 .S Y=+LRT,Y2="modified: ",X=$P(LRT,"^",2),LRSGN="  typed by "
 .;If supp rpt is released, display 'signed by' instead of 'typed by'
 .I $P(LRT,"^",3) S LRSGN=" signed by",X=$P(LRT,"^",3),Y=$P(LRT,"^",4),Y2="released: "
 .S X=$S($D(^VA(200,X,0)):$P(^(0),"^"),1:X)
 .D D^LRU W !,"Date ",Y2,Y,LRSGN,X
 .K ^UTILITY($J) S DIWR=IOM-5,DIWL=5,DIWF="W"
 .S B=0
 .F LRZ=0:1 S B=$O(^LR(LRDFN,84,LRA,2,A,1,B)) Q:'B!(LR("Q"))  D
 ..S LRT=^LR(LRDFN,84,LRA,2,A,1,B,0)
 ..D:$Y>(IOSL-13) FT,H Q:LR("Q")
 ..S X=LRT D ^DIWP
 .Q:LR("Q")  D:LRZ ^DIWW
 Q:LR("Q")
 W !?13,"==========Text below appears on final report=========="
 Q
H ;Header
 I $D(LR("F")),IOST?1"C".E D CONT  Q:LR("Q")
 W:($D(LR("F"))) @IOF
 S LRQ=LRQ+1
 ;W:IOST?1"C".E!(IOST'?1"C".E&('$D(LRFLG))) @IOF,!
 ;K LRFLG
 W ! D W
 W !?5,"CLINICAL RECORD |",?40,"AUTOPSY SUPPLEMENTARY REPORT"
 W ?73,"Pg ",LRQ,!,LR("%")
 W !,"Date died: ",LRH,?40,"| Autopsy date: ",LRH(1)
 W !,"Resident: ",LRM(2),?40,"| ",LRS(3)
 W ?56,"Autopsy No. ",$S(LRQ(8)]"":LRQ(8)_LRH(2)_" "_LRAC,1:LRAC)
 W !,LR("%")
 Q
FT ;Footer
 Q:LR("Q")
 I IOSL'>66 F  Q:$Y>(IOSL-13)  W !
 D W W !!,"Pathologist: ",LRM(3),?52,LRW(9),?55,"| Date ",$E(LRH(3),1,12)
 D W W !,LRQ(1),?(IOM-30),"AUTOPSY SUPPLEMENTARY REPORT"
 W !,$E(LRP,1,30),?31,SSN,?49,"SEX:",SEX,?55,"DOB:",DOB,!,LRLLOC
 W ?31,LRM(1),?55,"AGE AT DEATH: ",AGE
 Q
SGL ;Entry point for printing single report
 S X="" D ^LRUPS G:LRAN="?" SGL Q:LRAN=-1
 I $D(LR("AU1")),'$P(^LR(LRDFN,"AU"),U,15) D  Q
 .W $C(7),!!,"Report not verified."
 D SPC Q:X=""!(X[U)
 S LRAP=LRDFN,LRSAV=1
 D EN2^LRUA
 G DEV
CONT ;
 K DIR S DIR(0)="E"
 D ^DIR W !
 S:$D(DTOUT)!(X[U) LR("Q")=1
 Q
END ;
 W $C(7),!!,"OK to delete the AUTOPSY SUPPLEMENTARY REPORT list "
 S %=2 D YN^LRU
 I %=1 K ^LRO(69.2,LRAA,3) S ^LRO(69.2,LRAA,3,0)="^69.29A^0^0" D  Q
 .W $C(7),!,"LIST DELETED !",!
 W !!,"OK, LET'S FORGET IT.",!
 Q
TOP S Z=$P(X,"|TOP|",1)_$P(X,"|TOP|",2)
 D FT,H S X=Z,LR("F")=1
 Q
