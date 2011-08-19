SOWKBCD ;BHAM ISC/DLR-DELETE INCOMPLETE CASE OPENING INFO ; 21 Mar 94 / 12:36 PM
 ;;3.0; Social Work ;**21**;27 Apr 93
 ;
BEG W @IOF
 W !,"This routine will delete any incomplete or incorrect case data in the Social",!,"Work files (650)(655)(655.2). After correcting the data, file (650)",!,"will be reindexed.",!!
 S DIR(0)="Y",DIR("B")="NO",DIR("A")="Do you wish to continue",DIR("?")="Enter ""YES"" to delete the data, associated with incomplete cases, from the Case (650), RCH (655), and ASSESSMENT (655.2) files." D ^DIR K DIR,X Q:Y'>0
DEV K %ZIS,IOP,ZTSK S SOWKION=ION,%ZIS="QM",%ZIS("B")="" D ^%ZIS K %ZIS I POP S IOP=SOWKION D ^%ZIS K IOP,SOWKION G END
 I $E(IOST)["C" W *7,!,"PRINTOUT MUST BE SENT TO PRINTER !!",! G DEV
 K SOWKION I $D(IO("Q")) S ZTDESC="SOCIAL WORK CASE CORRECTION",ZTRTN="ENQ^SOWKBCD"
 I  K IO("Q") D ^%ZTLOAD W:$D(ZTSK) !!,"Task Queued to Print",! K ZTSK,G G END
ENQ S REC=0 F CS=0:0 S CS=$O(^SOWK(650,CS)) Q:CS'>0  D
 .S SWPT=$P(^SOWK(650,CS,0),"^",8) I '$P(^SOWK(650,CS,0),"^")!('$D(SWPT)) S REC=REC+1 D:REC=1 REC1 D CK K ^SOWK(650,CS) Q
 .I $P(^SOWK(650,CS,0),"^",13)=74 D RCH
 F X="AC","ACD","AD","AE","B","BS5","CP","O","P","W" K ^SOWK(650,X)
 S DIK="^SOWK(650," D IXALL^DIK
 D:REC=0 REC0
END ;kills all the variables
 W:$E(IOST)'["C" @IOF D ^%ZISC K X,X2,SWPT,REC,SOWKFLAG,DFN Q
RCH ;check RCH file (655) for entries with CS as the case #
 S SOWKFLAG=0
 I '$O(^SOWK(655,SWPT,4,0)) S REC=REC+1 D:REC=1 REC1 S DA=SWPT,DIK="^SOWK(655," D ^DIK
 I $O(^SOWK(655,SWPT,4,0)) F X2=0:0 S X2=$O(^SOWK(655,SWPT,4,X2)) Q:X2'>0  D
 .I $D(^SOWK(655,SWPT,4,X2,0)),$P($G(^SOWK(655,SWPT,4,X2,0)),"^",5)="" D DEL
 .I $P($G(^SOWK(655,SWPT,4,X2,0)),"^",5)=CS S SOWKFLAG=1
 I 'SOWKFLAG D CK S REC=REC+1 D:REC=1 REC1 S DA=CS,DIK="^SOWK(650," D ^DIK D DIS
 Q
DEL ;deletes home entries without the pointers back to the case file (650)
 S REC=REC+1 D:REC=1 REC1 S DA=X2,DA(1)=SWPT,DIK="^SOWK(655,"_DA(1)_",4," D ^DIK W !,*7,"<RECORD DELETED>" K DIK
 I '$O(^SOWK(655,SWPT,4,0)) S REC=REC+1 D:REC=1 REC1 S DA=SWPT,DIK="^SOWK(655," D ^DIK
 Q
REC1 ;
 U IO W !!!,"These patients were associated with incomplete case openings.",!,"The incomplete records were probably a direct result of exiting, ""^"",",!,"out of the Open Case option at the RCH prompts.",!! Q
REC0 ;
 U IO W !,"There were no incomplete cases located within your case file (650).",!! Q
DIS ;displays the Case # and the patients name being deleted from the file
  U IO S DFN=SWPT D DEM^VADPT W !,*7,"Case #"_$G(CS)_" "_$G(VADM(1))_" was deleted." K DIK,DA D KVA^VADPT K X2 Q
CK ;checks to see if there is an Assessment Associated with this case
 I $P($G(^SOWK(655.2,SWPT,0)),"^",12)=CS S DA=SWPT,DIK="^SOWK(655.2," D ^DIK K DIK Q
 Q
