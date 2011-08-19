LROC ;DALOI/CJS - ORDER LIST CLEAN-UP ; 20 Apr 2005
 ;;5.2;LAB SERVICE;**121,295,329**;Sep 27, 1994;Build 2
 ; Modified slc/jer to include set/kill for "D" cross-reference
 ;
 N DA,DIR,DIROUT,DTOUT,DUOUT,LRAA,LRSAVE,LRX,MSG,X,Y
 D ^LROCM
 ;
 S DIR(0)="Y"
 S DIR("A")="Do you wish to Purge old Orders and Accessions",DIR("B")="NO"
 D ^DIR
 I Y'=1 Q
 ;
 S LRX=+$P($G(^LAB(69.9,1,0)),U,9) S:'LRX LRX=7
 S LRSAVE=$$FMADD^XLFDT(DT,"-"_LRX)
 ;
L1 ; Purge the daily accession areas that meet cutoff
 S LRAA=0
 F  S LRAA=$O(^LRO(68,LRAA)) Q:LRAA<1  D
 . I $P(^LRO(68,LRAA,0),U,3)'="D" W !,"Use File Manager to clear ",$P(^(0),U)
 ;
 N ZTSK,ZTRTN,ZTDESC,ZTIO,ZTSAVE
 S ZTRTN="DQ^LROC",ZTDESC="Purge old orders and accessions"
 S ZTIO="",ZTSAVE("LR*")=""
 D ^%ZTLOAD
 S MSG=$S($G(ZTSK):"Task #"_ZTSK_" tasked to run",1:"Tasking failed")
 D EN^DDIOL(MSG,"","!?2")
 Q
 ;
 ;
DQ ; Tasked entry point to clean up file #69
 N DA,I,J,K,LRDA
 ;
 ; Purge the daily accession areas that meet cutoff
 S LRAA=0
 F  S LRAA=$O(^LRO(68,LRAA)) Q:LRAA<1  D  Q:$G(ZTSTOP)
 . I $P(^LRO(68,LRAA,0),U,3)'="D" Q
 . I $$S^%ZTLOAD("Processing accession area: "_LRAA) S ZTSTOP=1 Q
 . S DA=0
 . F  S DA=$O(^LRO(68,LRAA,1,DA)) Q:DA<1!(LRSAVE<DA)  K ^LRO(68,LRAA,1,DA)
 ;
 I $G(ZTSTOP) Q
 ;
 S I=0
 F  S I=$O(^LRO(69,"C",I)) Q:I<1  D  Q:$G(ZTSTOP)
 . I $$S^%ZTLOAD("Processing 'C' X-REF in file #69") S ZTSTOP=1 Q
 . S J=0
 . F  S J=$O(^LRO(69,"C",I,J)) Q:J>LRSAVE!(J<1)  K ^(J)
 I $G(ZTSTOP) Q
 ;
 S I=0
 F  S I=$O(^LRO(69,"D",I)) Q:I<1  D  Q:$G(ZTSTOP)
 . I $$S^%ZTLOAD("Processing 'D' X-REF in file #69") S ZTSTOP=1 Q
 . S J=0
 . F  S J=$O(^LRO(69,"D",I,J)) Q:J>LRSAVE!(J<1)  K ^(J)
 I $G(ZTSTOP) Q
 ;
 S LRDA=1
 F  S LRDA=$O(^LRO(69,LRDA)) D  Q:(LRSAVE<LRDA)!(LRDA<1)  Q:$G(ZTSTOP)
 . I LRDA["0000" Q
 . I $$S^%ZTLOAD("Processing orders in file #69 for "_$$FMTE^XLFDT(LRDA)) S ZTSTOP=1 Q
 . S ^LRO(69,0)=$P(^LRO(69,0),U,1,2)_U_LRDA_U_($P(^(0),U,4)-1)
 . N LRSN
 . S LRSN=0
 . F  S LRSN=$O(^LRO(69,LRDA,1,LRSN)) Q:LRSN<1  D NEW^LR7OB1(LRDA,LRSN,"Z@") ; Call OE/RR
 . K ^LRO(69,LRDA),^LRO(69,"B",LRDA,LRDA)
 ;
 I LRDA<1 S ^LRO(69,0)=$P(^(0),U,1,2)
 I $G(ZTSTOP) Q
 ;
 D CHKUID
 I $G(ZTSTOP) Q
 D ^LROC1
 K LRSAVE
 ;
 Q
 ;
 ;
CENDEL ;
 W !,"STARTING CENTRAL ENTRY #: " R LRSTA:DTIME S LRSTA=LRSTA-1
 S U="^" W !,"ENDING CENTRAL ENTRY #: " R LRFIN:DTIME
 W !,"ARE YOU SURE? N//" D % Q:%'["Y"
 S ZTRTN="REENTRY^LROC",ZTIO="",ZTSAVE("L*")=""
 D ^%ZTLOAD
 K IO("Q"),ZTSK,ZTRTN,ZTIO,ZTSAVE
 K %H,%ZA,%ZB,%ZC,DA,I,J,LRAA,LRAN,LRDFN,LRDTM,LRDTN,LRFIN,LRIDT,LRIOZERO,LRLOST,LROCN,LROID,LRORD,LROSN,LRSAVE,LRSN,LRSS,LRSTA,POP,Z
 Q
 ;
 ;
REENTRY ;
 S LRORD=LRSTA
 F  S LRORD=$O(^LRO(69,"C",LRORD)) Q:LRORD<1!(LRORD>LRFIN)  D FDAT
 Q
 ;
 ;
FDAT ;
 S LRDTN=0
 F  S LRDTN=$O(^LRO(69,"C",LRORD,LRDTN)) Q:LRDTN<1  D ZAP
 Q
 ;
 ;
ZAP ;
 S LRSN=0
 F  S LRSN=$O(^LRO(69,"C",+LRORD,LRDTN,LRSN)) Q:LRSN<1  D
 . D NEW^LR7OB1(LRDTN,LRSN,"Z@") ;Call OE/RR
 . K ^LRO(69,"C",+LRORD,LRDTN,LRSN) Q:'$D(^LRO(69,LRDTN,1,LRSN,0))  S LRDFN=+^(0)
 . K ^LRO(69,LRDTN,1,LRSN),^LRO(69,LRDTN,1,"AA",LRDFN,LRSN),^LRO(69,"D",LRDFN,LRDTN,LRSN)
 S LRAA=0
 F  S LRAA=$O(^LRO(68,LRAA)) Q:LRAA<1  D:$P(^(LRAA,0),U,10)="Y" LRORD
 Q
 ;
 ;
LRORD ;
 S LRAN=$O(^LRO(68,LRAA,1,LRDTN,1,"D",LRORD,0)) Q:LRAN<1
 Q:'$D(^LRO(68,LRAA,1,LRDTN,1,LRAN,0))
 S LRSS=$P(^LRO(68,LRAA,0),"^",2)
 S LRDFN=+^LRO(68,LRAA,1,LRDTN,1,LRAN,0) G:'$D(^(3)) SKPLR S LRDTM=+^LRO(68,LRAA,1,LRDTN,1,LRAN,3) G:'LRDTM SKPLR S LRIDT=9999999-LRDTM
 I $D(^LR(LRDFN,LRSS,LRIDT,0)),$P(^(0),U,3) Q
 K ^LR(LRDFN,LRSS,LRIDT)
 I LRSS="CH" D CHKILL^LRPX(LRDFN,LRIDT)
 ;
SKPLR S X=^LRO(68,LRAA,1,LRDTN,1,LRAN,0),LROSN=$P(X,U,5),LROID=$P(X,U,6),LROCN=$S($D(^(.1)):$P(^(.1),U),1:"")
 K:$L(LROID) ^LRO(68,LRAA,1,LRDTN,1,"C",LROID,LRAN)
 K:$L(LROCN) ^LRO(68,LRAA,1,LRDTN,1,"D",LROCN,LRAN)
 K ^LRO(68,LRAA,1,LRDTN,1,LRAN)
 W "."
 Q
 ;
 ;
% R %:DTIME Q:%=""!(%["N")!(%["Y")  W !,"Answer 'Y' or 'N': " G %
 Q
 ;
 ;
CHKUID ; Check UID's for purged accessions
 ;
 N LRAA,LRAD,LRAN,LRCNT,LRROOT
 ;
 ; Check "C" cross-reference
 S LRROOT="^LRO(68,""C"")",(LRAA,LRAD,LRAN,LRCNT)=0
 F  S LRROOT=$Q(@LRROOT) Q:LRROOT=""  Q:$QS(LRROOT,2)'="C"  D CHKACN Q:$G(ZTSTOP)
 ;
 ; Check "D" cross-reference
 S LRROOT="^LRO(68,""D"")",(LRAA,LRAD,LRAN,LRCNT)=0
 F  S LRROOT=$Q(@LRROOT) Q:LRROOT=""  Q:$QS(LRROOT,2)'="D"  D CHKACN Q:$G(ZTSTOP)
 Q
 ;
CHKACN ; Check for deleted corresponding accession.
 S LRAA=$QS(LRROOT,4),LRAD=$QS(LRROOT,5),LRAN=$QS(LRROOT,6)
 S LRCNT=LRCNT+1
 ; take a "rest" - allow OS to swap out process
 ; Check if task has been requested to stop
 I '(LRCNT#10000) D  Q:$G(ZTSTOP)
 . I $$S^%ZTLOAD("Processing UID: "_$QS(LRROOT,3)) S ZTSTOP=1 Q
 . H 2
 I $D(^LRO(68,LRAA,1,LRAD,1,LRAN,0)) Q
 K @LRROOT
 Q
