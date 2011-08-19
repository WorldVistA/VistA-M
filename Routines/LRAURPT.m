LRAURPT ;AVAMC/REG/WTY - AUTOPSY RPT ;9/22/00
 ;;5.2;LAB SERVICE;**1,72,173,248,259**;Sep 27, 1994
 ;
 ;Reference to ^DD(63 supported by IA #10155
 ;WTY;24-AUG-01;Added ICD to the print coding question
 ;
 N LRPTR,LREL
 W !!,LRO(68)," Autopsy Protocols" D XR^LRU,EN2^LRUA S LRD("V")=""
 G END:LRAPX=2,SGL:LRAPX=3,CH:LRAPX=4
 L +^LRO(69.2,LRAA,2):5
 I '$T D EN^DDIOL("Someone else is building a print queue for this Accession Area","","$C(7),!!") Q
GETP ;Add a patient to the report queue
 W ! S X="" D ^LRUPS G GETP:LRAN["?" I LRAN=-1 L -^LRO(69.2,LRAA,2) Q
 G:$D(^LRO(69.2,LRAA,2,LRAN,0)) GETP
 S FDAIEN(2)=LRAN
 S FDA(2,69.23,"+2,"_+LRAA_",",.01)=LRDFN
 D UPDATE^DIE("","FDA(2)","FDAIEN") K FDAIEN G GETP
CH ;Check Queue
 I '$O(^LRO(69.2,LRAA,2,0)) D  Q
 .W $C(7),!!,"No AUTOPSY PROTOCOLS currently on the print queue.",!!
 ;Variable LR("DVD") is used to divide reports displayed in the browser
 K LR("DVD")
 S $P(LR("DVD"),"|",IOM)=""
SPC ;Spacing
 I LRAPX=4 D
 .W !!,"The following two questions apply only to reports not stored in "
 .W "TIU."
 .W !,"If the report is stored in TIU it will be printed in its "
 .W "original format.",!
 R !,"(D)ouble or (S)ingle spacing of report(s): ",X:DTIME
 Q:X=""!(X[U)
 I $E(X)'="D"&($E(X)'="S") D  G SPC
 .W $C(7),!,"Enter 'S' for single or 'D' for double "
 .W "spacing of reports"
 S LRS=$S(X="D":"D",1:"")_"W"
 W !!,"Print special studies, journal references, weights, and "
 W "measures: "
 S %=1 D YN^LRU Q:%<1  S:%=1 LRD=1
 Q:LRAPX=3
 W !!,"Save protocol list for reprinting "
 S %=2 D YN^LRU S:%=1 LRSAV=1
DEV ;Device Handling
 S %ZIS="Q" D ^%ZIS
 I POP W ! S LR("Q")=1 Q
 I $D(IO("Q")) D  Q
 .S ZTDESC="Print AU Anat Path Reports"
 .S ZTSAVE("LR*")="",ZTRTN="QUE^LRAURPT"
 .D ^%ZTLOAD W:$D(ZTSK) !,"Request Queued, #",ZTSK W !
 .K ZTSK,IO("Q") D HOME^%ZIS
 .S LR("Q")=1
QUE ;
 U IO D L^LRU,S^LRU,EN^LRUA
 N LRFFF
 S LRQUIT=0,LR("Q")=+$G(LR("Q"))
 ;LRSF515=1 means an SF515 is being generated.
 S:'$D(LRSF515) LRSF515=0
 S:'$D(LRFOC) LRFOC=0 ;Final office copy
 S LRFFF=1  ;Flag used to determine whether to perform final form feed
 I LRFOC S LRFFF=0  ;If final office copy, don't perform final form feed
 S LR(.21)=+$G(^LRO(69.2,LRAA,.2)),(LRS(5),LRAURPT)=1
PSGL ;Single Report
 I $D(LRAP) D  G LST
 .S LRDFN=LRAP
 .I +$G(LRPTR) D  Q
 ..D:$D(LR("AU1")) EN
 ..Q:LR("Q")
 ..D MAIN^LRAPTIUP(LRPTR,0)
 ..S LRFFF=0 ;Don't do final form feed.  It's done by LRAPTIUP.
 ..I LRQUIT S LR("Q")=1 Q
 ..K LRAP S LR("F")=1
 ..I 'LR("Q"),$D(LR("F")),IOST?1"C-".E D CONT
 ..Q:LR("Q")
 ..I 'LRFOC S LR("Q")=1 Q
 ..S LRI="" D FOC^LRSPRPT
 ..I LRQUIT S LR("Q")=1 Q
 ..I 'LR("Q"),$D(LR("F")),IOST?1"C-".E D CONT
 .D EN
 .K LRAP
 .I 'LR("Q"),$D(LR("F")),IOST?1"C-".E D CONT
 .Q:LR("Q")
 .I 'LRFOC S LR("Q")=1 Q
 .W !
 .W:IOST?1"P-".E @IOF
 .S LRI="" D FOC^LRSPRPT
 .I LRQUIT S LR("Q")=1 Q
 .I 'LR("Q"),$D(LR("F")),IOST?1"C-".E D CONT
PQUE ;Print all on queue
 S LRAN=0
 F  S LRAN=$O(^LRO(69.2,LRAA,2,LRAN)) Q:'LRAN!(LR("Q"))  D
 .S (LRQUIT,LRQ)=0
 .I 'LRFOC S LRFFF=1
 .K LR("F")
 .S LRDFN=+^LRO(69.2,LRAA,2,LRAN,0)
 .D RELEASE^LRAPUTL(.LREL,LRDFN,LRSS)
 .I +$G(LREL(1)) D
 ..D TIUCHK^LRAPUTL(.LRPTR,LRDFN,LRSS)
 .I +$G(LRPTR) D  Q
 ..D MAIN^LRAPTIUP(LRPTR,0)
 ..S LRFFF=0
 ..W:IOST["BROWSER"&('LRFOC) !!,LR("DVD")
 ..K LRPTR
 ..I LRQUIT S LR("Q")=1 Q
 ..S LR("F")=1
 ..I 'LR("Q"),$D(LR("F")),IOST?1"C-".E D CONT
 ..Q:LR("Q")!('LRFOC)
 ..D FOC^LRSPRPT
 ..W:IOST["BROWSER" !!,LR("DVD")
 ..I LRQUIT S LR("Q")=1 Q
 ..I 'LR("Q"),$D(LR("F")),IOST?1"C".E D CONT
 .W:IOST?1"C-".E @IOF
 .D EN
 .W:IOST?1"P-".E @IOF
 .W:IOST["BROWSER"&('LRFOC) !!,LR("DVD")
 .I 'LR("Q"),$D(LR("F")),IOST?1"C-".E D CONT
 .Q:LR("Q")!('LRFOC)
 .W !
 .D FOC^LRSPRPT
 .W:IOST["BROWSER" !!,LR("DVD")
 .I LRQUIT S LR("Q")=1 Q
 .I 'LR("Q"),$D(LR("F")),IOST?1"C".E D CONT
 S LRFFF=0
LST ;
 K:'$D(LRSAV) ^LRO(69.2,LRAA,2) K LRAURPT
 S:'$D(^LRO(69.2,LRAA,2,0)) ^(0)="^69.23A^0^0"
 K LRSAV D K^LRU
 D:'$D(LR("AU1")) DEVEND
 Q
W ;
 W !,LR("%")
 Q
F D E
 S A=0 F LRZ=0:1 S A=$O(^LR(LRDFN,LRV,A)) Q:'A!(LR("Q"))  D
 .D:$Y>(IOSL-12) FT,H Q:LR("Q")
 .S X=^LR(LRDFN,LRV,A,0) D:X["|TOP|" TOP D ^DIWP
 Q:LR("Q")  D:LRZ ^DIWW Q
E K ^UTILITY($J) S DIWR=IOM-5,DIWL=5,DIWF=LRS
 Q
EN ;
 S LR("SPSM")=1 ;Set this flag to suppress SNOMED codes 
 S LRQ=0,X=^LR(LRDFN,0) D ^LRUP
 I '$D(^LR(LRDFN,"AU")) L +^LRO(69.2,LRAA,2,LRAN):5 Q:'$T  D  Q
 .S DIK="^LRO(69.2,LRAA,2,",DA=LRAN,DA(1)=0
 .D ^DIK K DA,DIK
 .L -^LRO(69.2,LRAA,2,LRAN)
 S X=^LR(LRDFN,"AU"),LRAC=$P(X,"^",6),LRM(2)=$P(X,"^",7)
 S LRM(1)=$P(X,"^",12),LRW(9)=$P(X,"^",13),LRM(3)=$P(X,"^",10)
 S Y=$P(X,"^"),LRH(2)=$E(Y,2,3) D D^LRU
 S LRH(1)=Y,Y=$P(X,"^",3) D D^LRU
 S LRH(3)=Y,Y=$P(X,"^",17) D D^LRU S LRH(17)=Y
 S LRLLOC=$P(X,"^",5),AGE=$P(X,"^",9)
 S Y=$P(X,"^",8),C=$P(^DD(63,14.5,0),U,3)
 D Y^DIQ S LRSVC=Y
 S Y=$P(X,"^",11),C=$P(^DD(63,13.7,0),U,3)
 D Y^DIQ S LRS(3)=Y
 S DA=LRDFN D D^LRAUAW S Y=LR(63,12) D D^LRU S LRH=Y,X=LRM(1)
 D:X D^LRUA S LRM(1)=X,X=LRM(2)
 D:X D^LRUA S LRM(2)=X,X=LRM(3)
 D:X D^LRUA S LRM(3)=X
 Q:+$G(LRPTR)
 D H Q:LR("Q")  S LR("F")=1
 W:LRH(1)="" !?20,"**** REPORT INCOMPLETE ****",!
 W !!,LRAU(1),! S LRV=81 D F
 D:$Y>(IOSL-12) FT,H Q:LR("Q")  W !!,LR("%")
 W !,LRAU(2),! S LRV=82 D F
 I $O(^LR(LRDFN,84,0)),LR(.21) D FT,H Q:LR("Q")
 S LRA=0 F  S LRA=$O(^LR(LRDFN,84,LRA)) Q:'LRA!(LR("Q"))  D
 .S LRB=^LR(LRDFN,84,LRA,0) D:$Y>(IOSL-12) FT,H Q:LR("Q")
 .W !!,"SUPPLEMENTARY REPORT DATE: "
 .S Y=LRB D D^LRU W Y
 .D:$P($G(^LR(LRDFN,84,LRA,2,0)),U,4) SUPA^LRAPAUSR
 .D WRT
 Q:LR("Q")
 D:$G(LRD) ^LRAPT2
 Q:LR("Q")
 D FT
 Q
WRT D E S LRC=0
 F LRZ=0:1 S LRC=$O(^LR(LRDFN,84,LRA,1,LRC)) Q:'LRC!(LR("Q"))  D
 .D:$Y>(IOSL-12) FT,H Q:LR("Q")
 .S X=^LR(LRDFN,84,LRA,1,LRC,0) D:X["|TOP|" TOP D ^DIWP
 Q:LR("Q")  D:LRZ ^DIWW Q
H ;
 Q:LR("Q")
 I $D(LR("F")),IOST?1"C".E D CONT  Q:LR("Q")
 S LRQ=LRQ+1
 W:($D(LR("F"))) @IOF
 W !! D W
 W !?5,"CLINICAL RECORD |",?40,"AUTOPSY PROTOCOL",?73,"Pg ",LRQ
 W !,LR("%")
 W !,"Date died: ",LRH,?40,"| Autopsy date: ",LRH(1)
 W !,"Resident: ",LRM(2),?40,"| ",$E(LRS(3),1,13)
 W ?56,"Autopsy No. ",$S(LRQ(8)]"":LRQ(8)_LRH(2)_" "_LRAC,1:LRAC)
 W !,LR("%")
 Q
FT ;Footer
 Q:LR("Q")
 I IOSL'>66 F  Q:$Y>(IOSL-12)  W !
 D W W !
 W:LRH(3)=""&(LRH(17)]"") ?55,"| Provisional Anatomic Dx"
 W !,"Pathologist: ",LRM(3),?52,LRW(9),?55,"| Date "
 W $E($S(LRH(3)]"":LRH(3),1:LRH(17)),1,12)
 D W W !,LRQ(1),?IOM-17,"AUTOPSY PROTOCOL"
 W !,"Patient: ",$E(LRP,1,30),?43,SSN,?56,"SEX:",SEX,?63,"DOB:",DOB
 W !,$E(LRLLOC,1,22),?23,"Physician: ",$E(LRM(1),1,28)
 W ?63,"AGE AT DEATH:",$J(AGE,3)
 Q
SGL ;Print single report entry point
 K LRD("V") S X="" D ^LRUPS G:LRAN="?" SGL Q:LRAN=-1
 D RELEASE^LRAPUTL(.LREL,LRDFN,LRSS)
 I $D(LR("AU1")),'+$G(LREL(1)) D  Q
 .W $C(7),!!,"Report not verified." S LR("AU1")=2
 I +$G(LREL(1)) D
 .D TIUCHK^LRAPUTL(.LRPTR,LRDFN,LRSS)
 I $D(LR("AU1"))!(+$G(LRPTR)) S LRS="W",LRD=1
 E  D SPC Q:X=""!(X[U)
 D EN2^LRUA
 S LRAP=LRDFN,LRSAV=1
 G DEV
DEVEND ;Close device
 I IOST?1"P-".E W:LRFFF @IOF
 D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@"
 Q
CONT ;
 K DIR S DIR(0)="E"
 D ^DIR W !
 S:$D(DTOUT)!(X[U) LR("Q")=1
 Q
END ;
 W $C(7),!!,"OK to delete the AUTOPSY PROTOCOL list "
 S %=2 D YN^LRU
 I %=1 D  Q
 .K ^LRO(69.2,LRAA,2)
 .S ^LRO(69.2,LRAA,2,0)="^69.23A^0^0"
 .W $C(7),!,"LIST DELETED !",!
 W !!,"OK, LET'S FORGET IT.",!
 Q
TOP ;
 S Z=$P(X,"|TOP|",1)_$P(X,"|TOP|",2)
 D FT,H S X=Z
 Q
