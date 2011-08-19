LRSPRPT ;AVAMC/REG/WTY/KLL - CY/EM/SP PATIENT RPT ;08/22/01
 ;;5.2;LAB SERVICE;**1,72,248,259,317**;Sep 27, 1994
 ;
 W !!?20,LRO(68)," FINAL PATIENT REPORTS"
 K LRSAV,LRAP,LRS(99)
 D EN2^LRUA
 G END^LRSPRPT1:LRAPX=2,SGL:LRAPX=3,CH:LRAPX=4
GETP ;
 D EN1^LRUPS Q:LRAN=-1
 G:$D(^LRO(69.2,LRAA,2,LRAN,0)) GETP
 L +^LRO(69.2,LRAA,2):5  I '$T D  G GETP
 .S MSG(1)="The final reports queue is in use by another person.  "
 .S MSG(1,"F")="!!"
 .S MSG(2)="You will need to add this accession to the queue later."
 .D EN^DDIOL(.MSG) K MSG
 S ^LRO(69.2,LRAA,2,LRAN,0)=LRDFN_"^"_LRI
 S X=^LRO(69.2,LRAA,2,0),^(0)=$P(X,"^",1,2)_"^"_LRAN_"^"_($P(X,"^",4)+1)
 L -^LRO(69.2,LRAA,2)
 G GETP
CH ;
 S LRAPX(1)=2 D EN^LRSPRPT2 Q:%<1
 W !!,"Save final report list for reprinting "
 S %=2 D YN^LRU S:%=1 LRSAV=1
 ;Variable LR("DVD") is used to divide reports displayed in the browser
 K LR("DVD")
 S $P(LR("DVD"),"|",IOM)=""
DEV ;from LRAPMOD
 W !
 S %ZIS="Q" D ^%ZIS
 I POP W ! D END Q
 I $D(IO("Q")) D  Q
 .S ZTDESC="ANAT PATH FINAL REPORT"
 .S ZTSAVE("LR*")="",ZTRTN="QUE^LRSPRPT"
 .D ^%ZTLOAD W:$D(ZTSK) !,"Request Queued, #",ZTSK W !
 .K ZTSK,IO("Q") D HOME^%ZIS
QUE ;
 U IO
 N LRFFF
 ;LRSF515=1 means that this is generating an SF515
 S:'$D(LRSF515) LRSF515=0
 S:'$D(LRFOC) LRFOC=0
 S:'$D(LRQUIT) LRQUIT=0
 S LRFFF=1  ;Flag used to determine whether to perform final form feed
 I LRFOC S LRFFF=0  ;If final office copy, don't perform final form feed
 S LR(.21)=+$G(^LRO(69.2,LRAA,.2)),LR("DIWF")="W"
 S LRA=$S($D(^LRO(69.2,LRAA,0)):$P(^(0),U,9),1:1) S:LRA="" LRA=1
 D L^LRU,S^LRU,L1^LRU,SET^LRUA
PSGL ;Single Report
 I $D(LRAP) D  G LST
 .S LRDFN=$P(LRAP,"^"),LRI=$P(LRAP,"^",2)
 .I +$G(LRPTR) D  Q
 ..D MAIN^LRAPTIUP(LRPTR,0)
 ..S LRFFF=0 ;Don't do final form feed.  It's done by LRAPTIUP.
 ..I LRQUIT S LR("Q")=1 Q
 ..K LRAP S LR("F")=1
 ..I 'LR("Q"),$D(LR("F")),IOST?1"C".E D CONT
 ..Q:LR("Q")
 ..I 'LRFOC S LR("Q")=1 Q
 ..D FOC
 ..I LRQUIT S LR("Q")=1 Q
 ..I 'LR("Q"),$D(LR("F")),IOST?1"C".E D CONT
 .W:IOST?1"C-".E @IOF
 .D EN
 .K LRAP
 .I 'LR("Q"),$D(LR("F")),IOST?1"C".E D CONT
 .Q:LR("Q")
 .I 'LRFOC S LR("Q")=1 Q
 .W !
 .W:IOST?1"P-".E @IOF
 .D FOC
 .I LRQUIT S LR("Q")=1 Q
 .I 'LR("Q"),$D(LR("F")),IOST?1"C".E D CONT
PQUE ;Report from queue
 S LRAN=0
 F  S LRAN=$O(^LRO(69.2,LRAA,2,LRAN)) Q:'LRAN!(LR("Q"))  D
 .S LRQUIT=0
 .I 'LRFOC S LRFFF=1
 .K LR("F")
 .S X=^LRO(69.2,LRAA,2,LRAN,0),LRDFN=+X,LRI=$P(X,"^",2)
 .D TIUCHK^LRAPUTL(.LRPTR,LRDFN,LRSS,LRI)
 .I +$G(LRPTR) D  Q
 ..D MAIN^LRAPTIUP(LRPTR,0)
 ..S LRFFF=0
 ..W:IOST["BROWSER"&('LRFOC) !!,LR("DVD")
 ..K LRPTR
 ..I LRQUIT S LR("Q")=1 Q
 ..S LR("F")=1
 ..I 'LR("Q"),$D(LR("F")),IOST?1"C-".E D CONT
 ..Q:LR("Q")!('LRFOC)
 ..D FOC
 ..W:IOST["BROWSER" !!,LR("DVD")
 ..I LRQUIT S LR("Q")=1 Q
 ..I 'LR("Q"),$D(LR("F")),IOST?1"C".E D CONT
 .W:IOST?1"C-".E @IOF
 .D EN
 .W:IOST?1"P-".E @IOF
 .W:IOST["BROWSER"&('LRFOC) !!,LR("DVD")
 .I 'LR("Q"),$D(LR("F")),IOST?1"C-".E D CONT
 .Q:LR("Q")
 .Q:'LRFOC
 .W !
 .D FOC
 .W:IOST["BROWSER" !!,LR("DVD")
 .I LRQUIT S LR("Q")=1 Q
 .I 'LR("Q"),$D(LR("F")),IOST?1"C".E D CONT
 S LRFFF=0
LST ;
 K LRRMD,LRPMD,LRAP
 K:'$D(LRSAV) ^LRO(69.2,LRAA,2)
 S ^LRO(69.2,LRAA,2,0)="^69.23A^^0"
 K LRSAV,LRV,LRW,LRZ
 I IOST?1"P-".E W:LRFFF @IOF
 D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@"
 K %,DIR,DTOUT,DUOUT,DIRUT,X,Y
 D END
 Q
W ;
 W !,LR("%")
 Q
F ;        
 D E
 S A=0 F LRZ=0:1 S A=$O(^LR(LRDFN,LRSS,LRI,LRV,A)) Q:'A!(LR("Q"))  D
 .D:$Y>(IOSL-13) F^LRAPF,^LRAPF Q:LR("Q")
 .S X=^LR(LRDFN,LRSS,LRI,LRV,A,0) D:X["|TOP|" TOP D ^DIWP
 Q:LR("Q")  D:LRZ ^DIWW
 Q
E ;
 K ^UTILITY($J)
 S DIWR=IOM-5,DIWL=5,DIWF=LR("DIWF")
 Q
 ;
EN ;from LRSPT
 ;KLL-Suppress printing of SNOMED codes, except on Preliminary prints
 S LR("SPSM")=$S($G(LRPRE):0,1:1)
 S LR(.21)=+$G(^LRO(69.2,+$G(LRAA),.2))
 K LRO Q:'$D(^LR(LRDFN,LRSS,LRI,0))
 S LRQ=0
 D ^LRUA
 D INP^VADPT S LRPRAC=+VAIN(2)
 S:'LRPRAC LRPRAC(1)=""
 I LRPRAC S X=LRPRAC D D^LRUA S LRPRAC(1)=X
 D ^LRAPF Q:LR("Q")
 S LR("F")=1 W !,"Submitted by: ",LRW(5),?44,"Date obtained: ",LRTK
 D:LRA W
 W !,"Specimen (Received ",LRTK(1),"):" S LRV=.1 D A Q:LR("Q")
 I $P($G(^LR(LRDFN,LRSS,LRI,1.2,0)),"^",4) D
 .W !?14,"*+* SUPPLEMENTARY REPORT HAS BEEN ADDED *+*"
 .W !?19,"*+* REFER TO BOTTOM OF REPORT *+*",!
 D:LRA W W !,"Brief Clinical History:" S LRV=.2 D F Q:LR("Q")
 D:LRA W W !,"Preoperative Diagnosis:" S LRV=.3 D F Q:LR("Q")
 D:LRA W W !,"Operative Findings:" S LRV=.4 D F Q:LR("Q")
 D:LRA W W !,"Postoperative Diagnosis:" S LRV=.5 D F Q:LR("Q")
 W !?27,"Surgeon/physician: ",LRMD W:LRA !,LR("%1")
 D:$Y>(IOSL-13) F^LRAPF,^LRAPF Q:LR("Q")
 D P^LRAPF
 D:$Y>(IOSL-13) F^LRAPF,^LRAPF Q:LR("Q")
 D:LRA W
 W:LRRC="" !?20,"+*+* REPORT INCOMPLETE *+*+",!
 D:$Y>(IOSL-13) F^LRAPF,^LRAPF Q:LR("Q")
 W ! W:LRRMD]"" ?31,$S(LRSS="SP":"Pathology Resident: ",LRSS="CY":"Screened by: ",LRSS="EM":"Prepared by: ",1:" "),LRRMD
 I $O(^LR(LRDFN,LRSS,LRI,1.3,0)) D  Q:LR("Q")
 .D:$Y>(IOSL-13) F^LRAPF,^LRAPF Q:LR("Q")
 .W !,LR(69.2,.13)
 .I $P($G(^LR(LRDFN,LRSS,LRI,6,0)),U,4) S LR(0)=6 D ^LRSPRPTM
 S LRV=1.3 D F Q:LR("Q")
 I $O(^LR(LRDFN,LRSS,LRI,1,0)) D  Q:LR("Q")
 .D:$Y>(IOSL-13) F^LRAPF,^LRAPF Q:LR("Q")
 .W !,LR(69.2,.03)
 .I $P($G(^LR(LRDFN,LRSS,LRI,7,0)),U,4) S LR(0)=7 D ^LRSPRPTM
 S LRV=1 D F Q:LR("Q")
 I $O(^LR(LRDFN,LRSS,LRI,1.1,0)) D  Q:LR("Q")
 .D:$Y>(IOSL-13) F^LRAPF,^LRAPF Q:LR("Q")
 .W !,LR(69.2,.04)
 .I $P($G(^LR(LRDFN,LRSS,LRI,4,0)),"^",4) S LR(0)=4 D ^LRSPRPTM
 S LRV=1.1 D F Q:LR("Q")
 I $O(^LR(LRDFN,LRSS,LRI,1.4,0)) D  Q:LR("Q")
 .D:$Y>(IOSL-13) F^LRAPF,^LRAPF Q:LR("Q")
 .W !,LR(69.2,.14)
 .I $P($G(^LR(LRDFN,LRSS,LRI,5,0)),U,4) S LR(0)=5 D ^LRSPRPTM
 S LRV=1.4 D F Q:LR("Q")
 ;Supplementary Report
 I $O(^LR(LRDFN,LRSS,LRI,1.2,0)) D:LR(.21) F^LRAPF,^LRAPF Q:LR("Q")  D
 .D:$Y>(IOSL-13) F^LRAPF,^LRAPF Q:LR("Q")
 .W !,"Supplementary Report:"
 .S LRV=0 F  S LRV=$O(^LR(LRDFN,LRSS,LRI,1.2,LRV)) Q:'LRV!(LR("Q"))  D
 ..S X=^LR(LRDFN,LRSS,LRI,1.2,LRV,0) D S
 D ^LRSPRPT1 Q:LR("Q")
 Q:+$G(LRPRE)  ;Don't set the final flag and print the footer if prelim
 S LRO=1 D F^LRAPF
 Q
S ;
 S Y=+X,X=$P(X,U,2) D D^LRU
 W !?3,"Date: ",Y
 I $D(LR("R")),'X W " not verified" Q
 D:$Y>(IOSL-13) F^LRAPF,^LRAPF Q:LR("Q") 
 D:$P($G(^LR(LRDFN,LRSS,LRI,1.2,LRV,2,0)),U,4) SUPA
 D E S B=0
 F LRZ=0:1 S B=$O(^LR(LRDFN,LRSS,LRI,1.2,LRV,1,B)) Q:'B!(LR("Q"))  D
 .D:$Y>(IOSL-14) F^LRAPF,^LRAPF Q:LR("Q")
 .S DIWF="W"
 .S X=^LR(LRDFN,LRSS,LRI,1.2,LRV,1,B,0) D ^DIWP Q:LR("Q")
 Q:LR("Q")
 D:LRZ ^DIWW
 Q
SGL ;Print Single Report
 N LRPTR
 S LRAPX(1)=""
 D EN1^LRUPS Q:LRAN=-1
 I '$P(^LR(LRDFN,LRSS,LRI,0),"^",11) D  G SGL
 .W $C(7)," Sorry, report not verified.",!
 D TIUCHK^LRAPUTL(.LRPTR,LRDFN,LRSS,LRI)
 S LRAP=LRDFN_"^"_LRI,LRSAV=1
 D EN2^LRUA
 G DEV
A ;
 S A=0 F  S A=$O(^LR(LRDFN,LRSS,LRI,LRV,A)) Q:'A!(LR("Q"))  D
 .D:$Y>(IOSL-13) F^LRAPF,^LRAPF Q:LR("Q")
 .W !,$P(^LR(LRDFN,LRSS,LRI,LRV,A,0),"^")
 Q
TOP ;
 S Z=$P(X,"|TOP|",1)_$P(X,"|TOP|",2) D F^LRAPF,^LRAPF S X=Z
 Q
SUPA ;Print supplementary report audit information
 W !?14,"*+* SUPPLEMENTARY REPORT HAS BEEN ADDED/MODIFIED *+*"
 W !,"(Added/Last modified: "
 S (A,B)=0 F  S A=$O(^LR(LRDFN,LRSS,LRI,1.2,LRV,2,A)) Q:'A!(LR("Q"))  D
 .S B=A
 Q:LR("Q")
 Q:'$D(^LR(LRDFN,LRSS,LRI,1.2,LRV,2,B,0))
 S A=^(0),Y=+A,LRSGN=" typed by ",A=$P(A,"^",2)
 I $P(^LR(LRDFN,LRSS,LRI,1.2,LRV,2,B,0),"^",3) D
 .S A=^(0),LRSGN=" signed by ",A2=$P(A,"^",3),Y=$P(A,"^",4)
 .S A=A2
 S A=$S($D(^VA(200,A,0)):$P(^(0),"^"),1:A)
 ;If supp rpt is released, display 'signed by' instead of 'typed by'
 D D^LRU W Y,LRSGN,A,")"
 ;If RELEASE SUPP REPORT MODIFIED set to 1, display "NOT VERIFIED"
 I $P(^LR(LRDFN,LRSS,LRI,1.2,LRV,0),"^",3) W !,?25,"**-* NOT VERIFIED *-**"
 D:$D(LRQ(9)) SUPM
 Q
SUPM ;Print previous versions of supplementary reports
 ;This is used by menu option 'Print path modifications [LRAPMOD]'
 ;
 S A=0 F  S A=$O(^LR(LRDFN,LRSS,LRI,1.2,LRV,2,A)) Q:'A!(LR("Q"))  D
 .S LRT=^LR(LRDFN,LRSS,LRI,1.2,LRV,2,A,0)
 .D:$Y>(IOSL-13) F^LRAPF,^LRAPF Q:LR("Q")
 .S Y=+LRT,Y2=" modified: ",X=$P(LRT,"^",2),LRSGN="  typed by "
 .;If supp rpt is released, display 'signed by' instead of 'typed by' 
 .I $P(LRT,"^",3) S LRSGN=" signed by ",X=$P(LRT,"^",3),Y=$P(LRT,"^",4),Y2=" released: "
 .S X=$S($D(^VA(200,X,0)):$P(^(0),"^"),1:X)
 .D D^LRU W !,"Date ",Y2,Y,LRSGN,X
 .K ^UTILITY($J)
 .S DIWR=IOM-5,DIWL=5,DIWF="W"
 .S B=0
 .F LRZ=0:1 S B=$O(^LR(LRDFN,LRSS,LRI,1.2,LRV,2,A,1,B)) Q:'B!(LR("Q"))  D
 ..S LRT=^LR(LRDFN,LRSS,LRI,1.2,LRV,2,A,1,B,0)
 ..D:$Y>(IOSL-13) F^LRAPF,^LRAPF Q:LR("Q")
 ..S X=LRT D ^DIWP
 .Q:LR("Q")  D:LRZ ^DIWW
 Q:LR("Q")
 W !?13,"==========Text below appears on final report=========="
 Q
CONT ;
 K DIR S DIR(0)="E"
 D ^DIR W !
 S:$D(DTOUT)!(X[U) LR("Q")=1
 Q
FOC ;Print final office copy page (SNOMEDS)
 N LRADC,LRCTR
 I '$D(LRAP) D
 .D:LRSS'="AU" ^LRUA
 .I LRSS="AU" S X=^LR(LRDFN,0) D ^LRUP
 I LRSS="AU" D
 .S LRADC=$E($P(^LR(LRDFN,LRSS),"^"),1,3)_"0000"
 .S:+$G(LRDPF)=2 LRDEM("DTH")=$P(VADM(6),"^",2)
 .;Get DATE DIED from Referral File for Referral Patients
 .S:+$G(LRDPF)'=2 LRDEM("DTH")=$$GET1^DIQ(67,DFN_",",.351)
 .S LRDEM("AUDT")=$$GET1^DIQ(63,LRDFN_",",11)
 .S LRDEM("AUTYP")=$$GET1^DIQ(63,LRDFN_",",13.7)
 .S LRDEM("PRO")=$$GET1^DIQ(63,LRDFN_",",13.5)
 I LRSS'="AU" D
 .S LRADC=$E($P(^LR(LRDFN,LRSS,LRI,0),"^"),1,3)_"0000"
 .S LRDEM("PRO")=LRMD
 S LRDEM("PNM")=LRP,LRDEM("SSN")=SSN
 S LRDEM("SEX")=SEX,LRDEM("AGE")=AGE,LRDEM("DOB")=DOB
 D INIT^LRAPSNMD(LRDFN,LRSS,$G(LRI),LRSF,LRAA,LRAN,LRADC,.LRDEM,0)
 Q
END ;
 D V^LRU
 K LRSF515
 Q
