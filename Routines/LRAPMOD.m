LRAPMOD ;AVAMC/REG/WTY/KLL - PRINT PATH MICRO MODIFICATIONS ;9/22/00
 ;;5.2;LAB SERVICE;**72,248,259**;Sep 27, 1994
 ;
 ;Reference to ^%DT supported by IA #10003
 ;
 ;If ESIG Switch turned ON, print from TIU if found,
 ;  otherwise print from LR.
 N LRESSW
 D GETDATA^LRAPESON(.LRESSW)
 I +$G(LRESSW) D TIUPRT,END Q
 ;Print from LR
 S LRDICS="AUSPCYEM" D ^LRAP G:'$D(Y) END
 W !!?15,LRO(68),!!?15,"Print pathology report modifications",!!
GETP D EN2^LRUA,EN1^LRUPS
 G:LRAN["?" GETP
 I LRAN=-1 D END Q
 S FLGMOD=1
LRPRT I LRSS'="AU" D
 .S:($D(^LR(LRDFN,LRSS,LRI,4))!($D(^(5)))!($D(^(6)))!($D(^(7)))) FLGMOD=0
 I FLGMOD D  K LRFILE
 .S LRFILE=$S(LRSS="AU":"^LR(LRDFN,84",1:"^LR(LRDFN,LRSS,LRI,1.2")
 .I $D(@(LRFILE_")")) D
 ..F A=0:0 S A=$O(@(LRFILE_",A)")) Q:'A!('FLGMOD)  D
 ...S:$D(@(LRFILE_",A,2)")) FLGMOD=0
 I FLGMOD W $C(7),!!?5,"No modifications to print." G END
 K FLGMOD
 S (LRQ(9),LRSAV)=1,LRAP=LRDFN
 I LRSS'="AU" D  G DEV^LRSPRPT
 .S LRAP=LRAP_"^"_LRI,LRS(99)=1
 S X="T",%DT="" D ^%DT,D^LRU S LRH(3)=Y,LRFLG=1
 G DEV^LRAPAUSR
TIUPRT ;Print from TIU 
 N LRPTR,LREL,LRDATA
 S (LRQUIT,LRCONT,LRPTR2)=0
 S LRDICS="AUSPCYEM" D ^LRAP G:'$D(Y) END
 W !!?15,LRO(68),!!?5,"Print All AP Reports for an Accession from TIU",!!
 D ACCYR^LRAPMRL
 I LRQUIT D END Q
 S LRAU=0
 I LRSS="AU" S LRAU=1
 D LOOKUP^LRAPUTL(.LRDATA,LRH(0),LRO(68),LRSS,LRAD,LRAA)
 Q:'LRDATA!(LRDATA=-1)
 S FLGMOD=1
 S LRDFN=LRDATA,LRI=LRDATA(1)
 S LRIENS=LRI_","_LRDFN_","
 ;Check for release date
 I LRSS'="AU" S LREL=$$GET1^DIQ(LRSF,LRIENS,.11,"I")
 I LRSS="AU" S LREL=$$GET1^DIQ(63,LRDFN_",",14.7,"I")
 I 'LREL D
 .S DIR(0)="Y",DIR("B")="YES",DIR("A")="CONTINUE?"
 .S DIR("A",1)="Report not verified. Check for and print"
 .S DIR("A",2)="   previous versions?"
 .D ^DIR
 .I Y=0 S LRQUIT=1
 I LRQUIT D END Q
 I 'LREL D
 .D GETPREV
 .;No previous versions found, retrieve from LR?
 .I '+$G(LRPTR) D
 ..S DIR(0)="Y",DIR("B")="YES",DIR("A")="CONTINUE?"
 ..S DIR("A",1)="No previous versions found in TIU."
 ..S DIR("A",2)="   Print from LR?"
 ..D ^DIR
 ..I Y=0 S LRQUIT=1
 ..I Y=1 S LRCONT=1
 G:LRCONT GETP
 I LRQUIT D END Q
 ;Release date found, check TIU
 I LREL D
 .D TIUCHK^LRAPUTL(.LRPTR,LRDFN,LRSS,LRI)
 .I '+$G(LRPTR) D
 ..S DIR(0)="Y",DIR("B")="YES",DIR("A")="CONTINUE?"
 ..S DIR("A",1)="Report not found in TIU."
 ..S DIR("A",2)="   Print from LR?"
 ..D ^DIR
 ..I Y=0 S LRQUIT=1
 ..I Y=1 S LRCONT=1
 I LRQUIT D END Q
 G:LRCONT GETP
 ;Found in TIU, print from TIU
 I +$G(LRPTR) D
 .S LRPTR2=1
 .W !
 .S %ZIS="Q" D ^%ZIS
 .I POP W ! D END Q
 .I $D(IO("Q")) D  Q
 ..S ZTDESC="Print Anat Path Reports"
 ..S ZTSAVE("LR*")="",ZTRTN="PRTRPT^LRAPMOD"
 ..D ^%ZTLOAD W:$D(ZTSK) !,"Request Queued, #",ZTSK W !
 ..K ZTSK,IO("Q") D HOME^%ZIS
 .D PRTRPT
 D ^%ZISC
 ;Allow print of LR even if stored in TIU
 I LRPTR2=1 D
 .S DIR(0)="Y",DIR("B")="YES",DIR("A")="CONTINUE?"
 .S DIR("A",1)="Print a copy from LR in addition to TIU print?"
 .D ^DIR
 .I Y=0 S LRQUIT=1
 .I Y=1 S LRCONT=1,LRPTR=0
 Q:LRQUIT
 G:LRCONT GETP
 Q
PRTRPT ;Print from TIU
 U IO
 F  D  Q:'LRPTR!(LRQUIT)
 .D MAIN^LRAPTIUP(LRPTR,0)
 .S LRPTR=$$GET1^DIQ(8925,LRPTR,1406,"I")
 Q
GETPREV ;
 I LRSS="AU" D
 .S LRROOT="^LR(LRDFN,101,""A"")",LRIENS=LRDFN_","
 .S LRFILE=63.101
 I LRSS'="AU" D
 .S LRROOT="^LR(LRDFN,LRSS,LRI,.05,""A"")"
 .S LRIENS=LRI_","_LRDFN_","
 .S LRFILE=$S(LRSS="SP":63.19,LRSS="CY":63.47,LRSS="EM":63.49,1:"")
 S LRTREC=$O(@(LRROOT),-1)
 I LRFILE=""!(LRTREC="") S LRPTR=0 Q
 S LRIENS=LRTREC_","_LRIENS
 S LRPTR=+$$GET1^DIQ(LRFILE,LRIENS,1,"I")
 I '+$G(LRPTR) D
 .W $C(7),"Report not found in TIU",!
 .S LRQUIT=1
 Q
END ;
 D V^LRU
 Q
