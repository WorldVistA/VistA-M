DVBCREQP ;ALB/GTS-557/THM-PRINT NEW REQUESTS ; 6/27/91  9:36 AM
 ;;2.7;AMIE;;Apr 10, 1995
 S DVBAMAN="" G EN
 ;
CK1 F JI=BDTRQ-.1:0 S JI=$O(^DVB(396.3,XD,JI)) Q:JI=""  F DA(1)=0:0 S DA(1)=$O(^DVB(396.3,XD,JI,DA(1))) Q:DA(1)=""  S DVBXD=$S($D(^DVB(396.3,DA(1),1)):$P(^(1),U,4),1:"") I DVBXD=XDIV S FIND=1
 Q
 ;
PRINT K OUT S STAT=$P(^DVB(396.3,DA(1),0),U,18) ;I STAT["X" S OUT=1 Q
 S DVBCDIV=$S($D(^DVB(396.3,DA(1),1)):$P(^(1),U,4),1:"") Q:DVBCDIV'=XDIV  S DA=DA(1) D VARS^DVBCUTIL,^DVBCREQ1 S:CNUM="" CNUM=99999999 S:SSN="" SSN=999999999 S:PNAM="" PNAM="Missing vet name"
 S DA=DA(1),DIE="^DVB(396.3,",DR="17////P" I STAT="N"!(STAT="NT") D ^DIE
SET S DA=DA(1),DR="4///NOW",(DIC,DIE)="^DVB(396.3,"
 I $P(^DVB(396.3,DA,0),U,5)="" D ^DIE
 I '$D(ONE) S ^TMP($J,DVBCTYPE,PNAM,SSN,CNUM)="" ;for last sheet
 S (PNAM,SSN,CNUM,ADR1,ADR2,ADR3,CITY,STATE,ZIP,HOMPHON,BUSPHON,OTHDIS)="",PRINT=1
 Q
 ;
EN K PRINT S Y=DT X ^DD("DD") S DVBCDT(0)=Y D HOME^%ZIS S FF=IOF W @FF,"Manual New C&P Request Printing",!!!
 ;
ASK K ONE W !,"Do you want just one request" S %=2 D YN^DICN G:$D(DTOUT) EXIT I $D(%Y),%Y["?" W !,"Enter Y for only one Vet or N for all Vets.",! G ASK
 G:%Y=U EXIT I %=1 G ONEREQ
 W ! D DIV I $D(OUT) K OUT G EXIT
 W ! S %DT(0)=-DT,%DT="AET",%DT("A")="Enter BEGINNING date of request: " D ^%DT G:Y<0 EXIT S BDTRQ=Y,%DT="AET",%DT("A")="     and ENDING date of request: " D ^%DT G:Y<0 EN S EDTRQ=Y+.2359
 I EDTRQ<BDTRQ W !!,*7,"Ending date is earlier than starting date!",!! H 2 G EN
 ;
DEVICE K %DT W !! S %ZIS="AEQ",%ZIS("A")="Output device: " D ^%ZIS K %ZIS G:POP EXIT
 I $D(IO("Q")) S ZTRTN=$S($D(ONE):"PRINT^DVBCREQP",1:"GO^DVBCREQP"),ZTIO=ION,ZTDESC="New C&P request printing" F I="ONE","BDTRQ*","EDTRQ*","DA*","Y","XDIV","DIVNM","DVBCDT(0)","DVBCMAN" S ZTSAVE(I)=""
 I $D(IO("Q")) D ^%ZTLOAD G:'$D(ZTSK) EXIT W !!,"Request queued",!! G EXIT
 I $D(ONE) U IO D PRINT K DA G EXIT
 ;
GO D STM^DVBCUTL4
 U IO S X="New C&P Requests -- "_DIVNM
 W:(IOST?1"C-".E) @IOF
 W !!!!!!!!!!!!!!! F I=1:1:10 W ?5,X,!!
 K ^TMP($J),X S DVBCTYPE="NEW"
 F JI=BDTRQ_".0001":0 S JI=$O(^DVB(396.3,"C",JI)) Q:JI=""!(JI>EDTRQ)  F DA(1)=0:0 S DA(1)=$O(^DVB(396.3,"C",JI,DA(1))) Q:DA(1)=""  K OUT D PRINT
 K OUT I '$D(PRINT) W @IOF,!!!,"There were no new 2507 requests for " S Y=BDTRQ X ^DD("DD") W Y," to " S Y=$E(EDTRQ,1,7) X ^DD("DD") W Y,!,"for division ",DIVNM,!!
MODS K FIND S XD="AC" D CK1 I '$D(FIND) G ADDS
 K PRINT,FIND S X="C&P Request Modifications -- "_DIVNM W @IOF,!!!!!!!!!!!!!!! F I=1:1:10 W ?5,X,!!
 K X S DVBCTYPE="MODIFIED"
 F JI=BDTRQ_".0001":0 S JI=$O(^DVB(396.3,"AC",JI)) Q:JI=""!(JI>EDTRQ)  F DA(1)=0:0 S DA(1)=$O(^DVB(396.3,"AC",JI,DA(1))) Q:DA(1)=""  K OUT D PRINT
 I '$D(PRINT) W @IOF,!!!,"No modified requests to report.",!!
 ;
ADDS K FIND S XD="AD" D CK1 I '$D(FIND) G RECAP
 K PRINT,FIND S X="C&P Exams Added -- "_DIVNM W @IOF,!!!!!!!!!!!!!!! F I=1:1:10 W ?5,X,!!
 K X S DVBCTYPE="ADDITIONAL"
 F JI=BDTRQ_".0001":0 S JI=$O(^DVB(396.3,"AD",JI)) Q:JI=""!(JI>EDTRQ)  F DA(1)=0:0 S DA(1)=$O(^DVB(396.3,"AD",JI,DA(1))) Q:DA(1)=""  K OUT D PRINT
 I '$D(PRINT) W @IOF,!!!,"No added exams to report.",!!
RECAP D ^DVBCREQ3 ;recap sheet
 ;
EXIT S XRTN=$T(+0)
 D SPM^DVBCUTL4
 I $D(DVBCMAN)&($D(ZTQUEUED)) D KILL^%ZTLOAD
 K DVBCMAN,DIVNM,XDIV,DVBXD G KILL^DVBCUTIL
 ;
 ;
ONEREQ W !! S DIC="^DVB(396.3,",DIC(0)="AEQM",DIC("W")="W !?10,""Date of request: "" S:$D(Y) OLDY=Y S Y=$P(^(0),U,2) X ^DD(""DD"") W Y S:$D(OLDY) Y=OLDY",DIC("A")="Enter VETERAN NAME: " D ^DIC G:X=""!(X=U) EXIT
 S JI=$P(Y,U,2),DA(1)=+Y D DIV I $D(OUT) G EXIT
 S ONE=1 G DEVICE
 ;
TASK D ^DVBCREQ2 Q
 ;
DIV W !! K OUT S DIC("A")="Enter MED CENTER DIVISION: ",DIC(0)="AEQM",DIC="^DG(40.8," D ^DIC I X=""!(X=U) S OUT=1 Q
 I +Y<0 W *7,"  ???" G DIV
 S XDIV=+Y,DIVNM=$S($D(^DG(40.8,XDIV,0)):$P(^(0),U,1),1:"Unknown Division") Q
