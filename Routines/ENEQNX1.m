ENEQNX1 ;(WASH ISC)/DH-Process Uploaded Equipment Inventory ;1/9/2001
 ;;7.0;ENGINEERING;**10,21,45,68**;Aug 17, 1993
RES ;Restart an aborted process
 S X="",ENY=0 W !!,"Enter PROCESS ID: " R X:DTIME G:X="^"!(X="") EXIT^ENEQNX2 S ENCTID=$O(^PRCT(446.4,"C",X,"")) I ENCTID="" W !!,*7,"Wrong application. Aborting..." D HOLD G EXIT^ENEQNX2
 S X="" W !!,"Enter TIME STAMP of process to be restarted: " R X:DTIME G:X="^"!(X="") EXIT^ENEQNX2 S ENCTTI=$O(^PRCT(446.4,ENCTID,2,"B",X,"")) I ENCTTI="" W !!,"NO DATA. Aborting..." D HOLD G EXIT^ENEQNX2
EN ;Main entry point. Expects ENCTID and ENCTTI.
 G:'$D(ENCTID) ERR^ENEQNX3
 S ENSTA=$P($G(^DIC(6910,1,0)),U,2),ENSTAL=$L(ENSTA)
 I ENSTA="" W !!,"Can't seem to find your STATION NUMBER. Please check File 6910.",!,"Your IRM staff may need to assist you.",*7 G ERR^ENEQNX3
 F I=1,2,3,4,5,6,7,8 S ENSTA(I)="",ENSTAL(I)=0
 I $G(^DIC(6910,1,3,0))]"" D
 . S (I,ENX)=0 F  S ENX=$O(^DIC(6910,1,3,ENX)) Q:'ENX!(I>8)  D
 .. S I=I+1,ENSTA(I)=$P(^DIC(6910,1,3,ENX,0),U)
 .. S ENSTAL(I)=$L(ENSTA(I))
 S X="T",U="^",%DT="" D ^%DT S DT=+Y X ^DD("DD") S ENDATE=Y I '$D(DTIME) S DTIME=600
 D MSG^ENEQNX3
 S %ZIS="Q",%ZIS("A")="Select Device for Exception Messages: " D ^%ZIS K %ZIS G:POP ERR^ENEQNX3
 G:$D(IO("Q")) ZTSK
CONT ;Physical processing of uploaded data
 U IO S (ENY,ENPG)=0,ENX=$O(^PRCT(446.4,ENCTID,2,ENCTTI,1,0)) I ENX'>0 D HDR W *7,!!,"No data to process." D HOLD G EXIT^ENEQNX2
 S ENX=$O(^PRCT(446.4,ENCTID,2,ENCTTI,1,ENX)) ;ignore file ID
NEWLOC ;Beginning of a specific location
 S ENLBL=^PRCT(446.4,ENCTID,2,ENCTTI,1,ENX,0),ENLOC=$E(ENLBL,3,50) I $E(ENLBL,1,2)'="SP" S ENMSG="LOCATION EXPECTED." D XCPTN S ENX=$O(^PRCT(446.4,ENCTID,2,ENCTTI,1,ENX)) G:ENX'>0 EXIT^ENEQNX2 G NEWLOC
 I ENLOC["  " S ENLOC=$P(ENLOC,"  ")
 S X=$L(ENLOC) I $E(ENLOC,X)=" " S ENLOC=$E(ENLOC,1,(X-1))
NEWNX ;Process a piece of equipment
 S ENX=$O(^PRCT(446.4,ENCTID,2,ENCTTI,1,ENX)) G:ENX'>0 DONE S (ENEQ,ENLBL)=^(ENX,0) G:$E(ENLBL)="*" NEWNX
 I $E(ENEQ,1,2)="SP" K ENEQ G NEWLOC
 S ^PRCT(446.4,ENCTID,2,ENCTTI,1,ENX,0)="*"_ENEQ
 I $E(ENEQ,1,4)="MOD:" D NOLBL^ENEQNX3 G NEWNX
 I $E(ENEQ,1,4)="PM#:" D PMN^ENEQNX3 G NEWNX
 I ENEQ[" EE",$P(ENEQ," ")'=ENSTA D  I $D(ENMSG) D XCPTN G NEWNX
 . K ENMSG S ENMSG="FOREIGN EQUIPMENT."
 . F I=1:1:8 I ENSTAL(I),ENSTA(I)=$E(ENEQ,1,ENSTAL(I)) K ENMSG Q
 . I $D(ENMSG) S ENMSG(0,1)="Cannot process a bar code label from another VAMC."
 S ENEQ=$S($D(^ENG(6914,"OEE",ENLBL)):$O(^(ENLBL,0)),1:+$P(ENLBL,"EE",2))
 I ENEQ>0 D UPDATE^ENEQNX2
 G NEWNX
 ;
XCPTN ;Print Exception Messages
 D:ENY=0!(ENY>(IOSL-5)) HDR W !!,ENMSG,! W:$D(ENLBL) "   Label scanned as: ",ENLBL W:$D(ENLOC) "   Location: ",ENLOC S ENY=ENY+3
 I $D(ENMSG(0)) F I=0:0 S I=$O(ENMSG(0,I)) Q:I'=+I  W !,ENMSG(0,I) S ENY=ENY+1
 K ENMSG
 Q
 ;
HDR ;New page for exception printing
 I $E(IOST,1,2)="C-",ENY>0 D HOLD
 I ENPG!($E(IOST,1,2)="C-") W @IOF
 S ENPG=ENPG+1
 W "NON-EXPENDABLE INVENTORY EXCEPTION MESSAGES",?(IOM-15),ENDATE
 W !,"   Global Reference: ^PRCT(446.4,"_ENCTID_",2,"_ENCTTI_",1,",?(IOM-15),"Page ",ENPG
 K % S $P(%,"-",(IOM-1))="-" W !,%
 S ENY=4
 Q
ZTSK ;Queue processing for later time
 K IO("Q") S ZTIO=ION,ZTRTN="CONT^ENEQNX1",ZTDESC="NX Inventory (Bar Code)"
 F I="ENSTA","ENSTA(","ENSTAL","ENSTAL(","ENCTTI","ENCTID","DT","ENDATE" S ZTSAVE(I)=""
 D ^%ZTLOAD K ZTSK D HOME^%ZIS
 G EXIT^ENEQNX2
HOLD I $E(IOST,1,2)="C-" W !,"Press <RETURN> to continue..." R X:DTIME
 Q
DONE ;Delete DATE/TIME OF DATA UPLOAD
 K DA,DIK S DIK="^PRCT(446.4,"_ENCTID_",2,",DA(1)=ENCTID,DA=ENCTTI
 D ^DIK
 K DIK
 G EXIT^ENEQNX2
 ;ENEQNX1
