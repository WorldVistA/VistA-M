DENTCRD ;ISC2/WCD,SAW-PROCESS DENTAL SERVICE CARD ;8/15/96  15:39
 ;;1.2;DENTAL;**16,19,21**;JAN 26, 1989
 S (DENTVAL,DENTERR,DENTNCR,Z1)=0,U="^" G:'$D(^DENT(225,0)) W F Z3=0:1:2 S Z1=$O(^(Z1)) Q:Z1'>0  S Z2=Z1
 G:Z3=0 W I Z3>1 S DIC="^DENT(225,",DIC(0)="AEMNQZ" D ^DIC G EXIT:Y<0
 S Z=$S(Z3=1:Z2,1:+Y) G W:'$D(^DENT(225,Z,0))
 S IOP=$P(^(0),"^",2),DENTSTA=$P(^(0),"^",1) G W:IOP=""
 S DENTY=0 I $E(DT,4,5)'="01" G NXT
 I $E(DT,6,7)<16 W ! K DIR S DIR(0)="YAO",DIR("A")="Enter Cards From Last December? ",DIR("B")="YES" D ^DIR G:$D(DIROUT)!($D(DIRUT)) EXIT K DIR,DIROUT,DIRUT S DENTY=Y
NXT D ^%ZIS I POP W !,"The card reader port is in use.  Try again later" S IOP=$I D ^%ZIS G EXIT
 K IOP,DA U IO X ^%ZOSF("TYPE-AHEAD") U IO(0) W !,?15,"READ DENTAL CARDS FROM MARK SENSE CARD READER",!!,"You may begin inserting cards"
READCRD ;
 W:DENTNCR !,"Finished Processing Card Number: ",$J(DENTNCR,4)
 U IO R D:30 I '$T!($E(D,2,5)=9999) X ^%ZIS("C") U IO(0) W !,"Time Expired/End of Session" G SUM
 U IO(0) S DENTNCR=DENTNCR+1 G:D="" W1 S D=$E(D,2,75) F I=1:1:74 I "0123456789 "'[$E(D,I) G W1
 I +$E(D,5,13)=2 S DENT=1,E=0 D NCT^DENTCRD2 K D,DENT,E G READCRD
 D EN^DENTCRD1 I '$D(D2) S DENTERR=DENTERR+1 K D G READCRD
 I '$D(^DENT(221,0)) W !!,"YOUR DENTAL TREATMENT FILE IS NOT SET UP PROPERLY",!,"CONTACT YOUR SITE MANAGER",*7 U IO X ^%ZIS("C") G EXIT
 S N1=$P(^DENT(221,0),"^",4),N1=N1+1,N=$P(D2,"^")
 D SAVE(221,D2,.N) ;file record and return IEN
 S ^DENT(221,0)=$P(^DENT(221,0),"^",1,2)_"^"_N_"^"_N1,DENTVAL=DENTVAL+1
 S X=$P(D2,"^",39) G:X=""!(X="GROUP")!('$D(D39)) Q I '$D(^DENT(220,0)) S ^DENT(220,0)="DENTAL PATIENT^220P^^"
 I '$D(^DENT(220,D39,0)) S ^DENT(220,D39,0)=D39,^DENT(220,"B",D39,D39)="",^DENT(220,0)=$P(^DENT(220,0),"^",1,2)_"^"_D39_"^"_($P(^DENT(220,0),"^",4)+1)
Q K D,D2,X,D39 G READCRD
W W !!,"A card reader device has not been entered for your station in the Dental Site",!,"Parameter file.  One must be entered before you can run this option",*7 G EXIT
W1 W !,"This card is unreadable -- Remove and correct card.  Check for extraneous marks",*7 K D S DENTERR=DENTERR+1 G READCRD
SUM W !!,?5,"----- SESSION COMPLETE -----",!,?5,"Total Cards Read: ",DENTNCR
 W !,?5,"Total Errors: ",DENTERR,!,?5,"Total Valid: ",DENTVAL
 W:DENTERR !,"**NOTE** Cards that had errors must be corrected and reread thru the card reader"
EXIT K D,D2,DENT,DENTERR,DENTNCR,DENTSTA,DENTVAL,DENTXX1,DENTY,DIC,DIR,E,I,IOP,N,N1,X,XX1,Y,Z,Z1,Z2,Z3,ZZ Q
SAVE(FILE,VAR,REC) ; Stuff and index the dental record, return IEN 
 N DIC,DIE,X,DA
 S X=$P(VAR,U,1)
 ;execute input transform which converts the date to a unique
 ;inverse date/time & returns DINUM
 X $P(^DD(FILE,.01,0),U,5,99)
 S DIC="^DENT("_FILE_",",DIC(0)="EZ",DIC("DR")="" D FILE^DICN S REC=+Y
 S ^DENT(FILE,REC,0)=VAR S DA=REC,DIK="^DENT("_FILE_"," D IX^DIK
 Q
