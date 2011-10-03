LRARCHIV ;SLC/RWF/DAL/HOAK FIRST ROUTINE FOR PATIENT ARCHIVE ; 12/12/96  10:16 ;
 ;;5.2;LAB SERVICE;**59,111**;Sep 27, 1994
 ;
 ;  Taken from--> SET UP O("S") VARIABLES FOR ARCHIVE. ;2/5/91  12:30 ;
INIT ;
 ;
 ;
 ;
 K ^TMP("LRBAD"),^TMP("LRUNV"),^TMP("LRNOD")
 ;
SEARCH ;
 S OK=1
 ;          Rewrite of basic archive SEARCH function for ^LR data
 ;
 ;--> Following the F1 variable tells you where you are
 ;
 ;^LAB(69.9,1,6,1,0) = ARCH-1^VAMC^2970318.0941^1^2970318
 ;
 ;--> F1=1 or 2 or 3 or 4or 5 depending what step has been done
 ;                                              
 ;DATA TYPE:       Set of Codes                 |
 ;                 1:Searching------------------|               
 ;                 2:Search done----------------|
 ;                 3:Clear----------------------|
 ;                 4:Purging--------------------|
 ;                 5:Purge done-----------------|
 ;SERCHING:
 ;  Looks through the entire LR global by patient (LRDFN) for all
 ;  eligible entries by date.
 ;  New functionality also make certain all associated eligiable data is
 ;  forced to a perminant cume page.
 ;
 I '$G(F1) G MEET QUIT
 S OK=1 D RESTART^LRAR06:$G(F1)=1
 I 'OK D END QUIT
 ;
 I $G(F1)>1 W !,"Please finish the Clear and Purge steps first." D QUIT Q
 ;
 I $G(F1)=0 S:'$D(^LAB(69.9,1,6,0)) ^LAB(69.9,1,6,0)="^69.9003A^^" D TAPE^LRAR06
 ;
 I $G(DA)<1!($G(P1)<1) D QUIT Q
PAT ;
 ;    Entry for testing--------------------->
STEPOUT ;
MEET ;
 W @IOF,!!,"Welcome to The Search Option for the New Archive Modual",!
 ;
 I '$G(P1) S OK=1 D TAPE^LRAR06 I 'OK D END QUIT
 ;E  W !,"A file entry IS NOT present"
 ;
 ;            Make a list of data or not
 ;
 ;
 W !,"Shall I prepare a list of patients that will have data archived"
 S %=2 D YN^DICN
 ;
QUES I %=0 W !,"Answering YES to this question will produce" D  G PAT
 .  W "a list of patients that will have data archived."
 ;
 S LRPAT=0 S:%=1 LRPAT=1
T ;
 I '$G(P1) W !,"Tape name not defined. Please start again."
 I  QUIT
 ;
 S ^LAB(69.9,1,"TAPE")=P1
 S $P(^LAB(69.9,1,6,P1,0),U,4)=1 ;---SEARCH IS IN PROGRESS
 S X=1
 S LRP1=P1
 D LRSUB1 D DEVICE
 QUIT
END ;
 D QUIT
 Q
 ;
DEVICE ;
 S %ZIS="Q"
QUE ;
 S ZTSAVE("LR*")="",ZTRTN="LR^LRAR04",ZTDESC="Archive search option."
 S ZTSAVE("LR*")=""
 S ZTSAVE("^TMP(""LR9""")=""
 D IO^LRWU
 QUIT
DQ1 ;
 ;
 K OK,LRI
 U IO
 S LRC1=1,LRC2=0,LRC3=0,Y=LR(1)
 D DD^LRX
 W @IOF,!,"LAB DATA ARCHIVE for data before ",Y
 W ". on " D STAMP^LRX S X=1 X ^%ZOSF("PRIORITY")
 I '$G(LREDT3) D TIME^LRAR06
 S X2=LREDT3,X1=LR(1) D ^%DTC
 W !!,"Number of Days To be searched: ",X
 QUIT
 ;
 ;      Get test data names from 63.04
 ;
LRSUB1 S LRSUB=1
 F  S LRSUB=$O(^DD(63.04,LRSUB)) Q:LRSUB<1  D
 .  I $D(^DD(63.04,LRSUB,0)),'$D(^DD(63.999904,LRSUB)) D
 ..  S LRX0=^DD(63.04,LRSUB,0) S LRX3=$S($D(^(3)):^(3),1:"")
 ..  S ^DD(63.999904,LRSUB,0)=LRX0 S:LRX3'="" ^(3)=LRX3
 ..  S ^DD(63.999904,"B",$P(LRX0,U),LRSUB)=""
 K X,Y,L1,L2
 ;
 ;D ^AAHAGL
 ;
 ;QUIT  ;****************************************************
 ;
 ;
 ;
PROCESS ;
 ;
 ;
 K ^LAR("DHZ")
 ;
 K ^TMP("LRT2")
 ;
 D SET^LRAR03
 ;
 ;
 ;S $P(^LAB(69.9,1,6,P1,0),U,4)=2 L -^LAR
 QUIT
LST ;
 W @IOF
 S OK=1
 U IO
 S LRPAGE=1
 D HEAD
 I $G(LRPAT) W !! S PNM="" F  S PNM=$O(^LAR("NAME",PNM)) Q:PNM=""  D
 .  S LRDFN=0
 .  F  S LRDFN=$O(^LAR("NAME",PNM,LRDFN)) Q:+LRDFN'>0!('OK)  D
 ..  I $D(^LR(LRDFN,0))#2 N PNM S LRDPF=$P(^LR(LRDFN,0),"^",2) D
 ...  Q:'OK
 ...  S DFN=$P(^LR(LRDFN,0),"^",3)
 ...  D CHKPG Q:'OK  D DEM^LRX W !,PNM,?30,SSN
 ..  I '$D(^LR(LRDFN,0))#2 D
 ...  W !!,PNM," LRDFN # "_LRDFN_" Has Been Deleted from ^LR( ",!,$C(7),"SSN = Unknown",!
 ;
LISTS ;
 ;
 I 'OK S OK=1 G AROUND
 I IOST'["C-" G AROUND
 S OK=1
 I IOST["C-" S DIR(0)="E" D ^DIR
AROUND F LRQ="^TMP(""LRBAD"")","^TMP(""LRUNV"")","^TMP(""LRNOD"")" Q:LRQ=""  D
 .  W @IOF
 .  W !,$$CJ^XLFSTR($S(LRQ["LRBAD":"Entries with bad Data",LRQ["LRUNV":"Entries that were not verified",1:"Entries with no data"),IOM),!!
 .  F  S LRQ=$Q(@LRQ) Q:LRQ'["LR"  D CHKPG Q:'OK  W !,@LRQ
QUIT ;
 D KILL^LRAR01 D KVAR^VADPT K F1,LRC1,LRC2,LRC3 U IO(0)
 ;
 I $G(LRP1) S $P(^LAB(69.9,1,6,LRP1,0),U,4)=2 ;----SEARCH IS DONE
 ;
 K ^TMP("LRBAD"),^TMP("LRUNV"),^TMP("LRNOD")
 QUIT
CHKPG ;
 Q:'OK
 I IOSL-$Y'>3&($E(IOST,1,2)="C-") S DIR(0)="E" D ^DIR K DIR D
 .  W @IOF
 .  I $D(DTOUT)!($D(DUOUT)) S OK=0
 Q:'OK
 I IOSL-$Y'>3&($E(IOST,1,2)="P-") S LRPAGE=LRPAGE+1 D HEAD
 ;
 QUIT
HEAD ;
 W $$RJ^XLFSTR("Page "_LRPAGE,IOM),!
 Q
CLEAN ;
 D CLEAN^LRAR01
 Q
PURGE ;
 D PURGE^LRAR01 
 Q
