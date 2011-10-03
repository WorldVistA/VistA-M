PSGWTR ;BHAM ISC/PTD,CML-Transfer Stock Entries from One AOU to Another ; 08 Dec 93 / 10:02 AM
 ;;2.3; Automatic Replenishment/Ward Stock ;;4 JAN 94
 K LOC("TR") S CT=0,PSGWDUZ=DUZ W !!,"This option will copy the stock entries from one AOU into AOUs",!,"you select.  Inactive or duplicate items will not be transferred."
 W !,"Choosing to copy stock items into multiple AOUs will allow you",!,"to choose up to 10 AOUs at one time."
HOWMANY W !!?5,"Do you wish to copy stock items INTO:",!?5,"(1) ONE Area of Use, or",!?5,"(2) multiple Areas of Use",!!,"Select ""1"" or ""2"": " R CHS:DTIME
 G:'$T!("^"[CHS) END I CHS=1!(CHS=2) G WHAT
 W !!,"Answer ""1"" if transfer to only ONE AOU is desired,",!,"answer ""2"" if the same stock list is to be copied into more than one AOU." G HOWMANY
 ;
WHAT W !!?5,"Do you wish to transfer:",!?5,"(1) Drug (item) name only, or",!?5,"(2) Drug name, stock level, and location, or",!?5,"(3) Drug name, stock level, location, and type.",!!,"Select ""1"", ""2"", or ""3"": " R TR:DTIME
 G:'$T!("^"[TR) END I TR=1!(TR=2)!(TR=3) G DICF
 W !!,"Answer ""1"" if transfer of ONLY drug name is desired,",!,"answer ""2"" if you wish to copy drug name, stock level, and location, or",!,"answer ""3"" if you wish to transfer drug name, stock level, location, and types." G WHAT
 ;
DICF W ! S DIC="^PSI(58.1,",DIC(0)="QEAM",DIC("A")="Select AOU to transfer stock list FROM: " D ^DIC K DIC G:Y<0 END S AOUF=+Y W !
 ;
DICT S DIC="^PSI(58.1,",DIC(0)="QEAM",DIC("A")="Select AOU to transfer stock list INTO: " D ^DIC K DIC G:(Y<0)&(CHS=1) END G:(Y<0)&(CHS=2) SURE S LOC("TR",+Y)="",CT=CT+1 G:CT>9 LIMIT G:CHS=2 DICT
 ;
SURE I $D(LOC("TR",AOUF)) W *7,*7,!!?5,"NOT ALLOWED to transfer out of and into SAME Area of Use!" G END
 G:'$O(LOC("TR",0)) END W !!?5,"I will now COPY the ENTIRE stock list from",!?5,$P(^PSI(58.1,AOUF,0),"^")," into" F J=0:0 S J=$O(LOC("TR",J)) Q:'J  W !?5,$P(^PSI(58.1,J,0),"^")
 W !!?5,"I will transfer ",$S(TR=2:"drug name, stock level, and location.",TR=3:"drug name, stock level, location, and types.",1:"drug name only.")
 R !!,"Are you SURE that is what you want to do?  NO// ",X:DTIME
 G:'$T!("^Nn"[$E(X)) END I "YyNn"'[$E(X) W *7,!!,"Answer ""yes"" if you wish to transfer stock entries.",!,"Answer ""no"" or <return> if you do not.",!! G SURE
 ;
QUE W !!,"This job will automatically be queued to run in the background.",!,"You will be notified by MailMan when the transfer is completed.",!
 S AOUT="" F J=0:0 S J=$O(LOC("TR",J)) Q:'J  S AOUT=AOUT_J_","
 S ZTIO="",ZTDTH=$H,ZTRTN="^PSGWTR1",ZTDESC="Transfer AOU Stock" F G="AOUF","TR","PSGWDUZ","AOUT" S:$D(@G) ZTSAVE(G)=""
 D ^%ZTLOAD,HOME^%ZIS W !,"TRANSFER FILE ENTRIES queued!"
END K AOUF,CHS,J,TR,X,G,ZTIO,AOUT,CT,PSGWDUZ,Y,ZTDESC,ZTDTH,ZTRTN,ZTSAVE,LOC("TR"),ZTSK
 S:$D(ZTQUEUED) ZTREQ="@" Q
 ;
LIMIT W !!,"You may not transfer TO additional AOUs at this time.",!,"Enter the option again to transfer to more AOUs." G SURE
