RMPR5NU ;HIN/RVD-PROS INVENTORY SITE PARAMETERS UTILITY ;2/11/98
 ;;3.0;PROSTHETICS;**33,38,52,61,132**;Feb 09, 1996;Build 13
 ;
 ;DBIA #10090 - file #4.
 ; ODJ - patch 52 - 10/17/00 - if a 661.3 record is corrupted with a null
 ;                             HCPC code then put message in report and
 ;                             prevent routine from crashing.
 ;                             (see nois NYH-0900-12030)
 ;
 ; RVD - patch #61 - used new files for inventory balance task job.
 ;
ADD ;add/edit inventory SITE PARAMETER
 S DIC("A")="Select Prosthetics Site Name : "
 S DIR("A")="Would you like to ACTIVATE this Item (Y/N) ",DIC=669.9,DIR(0)="Y"
 S DIC(0)="AEMQ" D ^DIC G:Y'>0 EXIT G:$D(DTOUT) EXIT S DA=+Y
 ;
 ;I $P(^RMPR(661,RMDA,1),U,9)'=1 W !!,$C(7),"*** Item is inactive ***" D ^DIR S:Y=1 $P(^RMPR(661,RMDA,1),U,9)=1 G:Y=0 ADD
 S DIE=DIC,DR="35" D ^DIE
 G ADD
 ;
TASK ;entry point for task job to check balances.
 K ^TMP($J)
 S IO=0
 S Y=DT D DD^%DT S RMRDAT=Y
 S RMERR=$$MES^RMPRPIUD("")
 ;a TMP($J global created for mail message.
 Q:$G(RMERR)
 D PROC S RMSUBI=5
 I $D(^TMP($J,"RMX")) D BUILD
MAIL D:$D(^XMB(3.8,"B","RMPR INVENTORY")) MES1,MES2
 ;set Notification Date in file #669.9
 S RS=0
 F  S RS=$O(^RMPR(669.9,RS)) Q:RS'>0  S $P(^RMPR(669.9,RS,"INV"),U,3)=DT
 ;D WRI ;for printing to a designated inventory printer.
 G EXIT
 ;
PROC ;process
 F I=0:0 S I=$O(^TMP($J,"RMPRPIUD",I)) Q:I'>0  S J="" F  S J=$O(^TMP($J,"RMPRPIUD",I,J)) Q:J=""  F K=0:0 S K=$O(^TMP($J,"RMPRPIUD",I,J,K)) Q:K'>0  D
 .F L=0:0 S L=$O(^TMP($J,"RMPRPIUD",I,J,K,"L",L)) Q:L'>0  D
 ..S RMDATA=$G(^TMP($J,"RMPRPIUD",I,J,K,"L",L))
 ..S RMREOR=$P(RMDATA,U,1)
 ..S RMQUAN=$P(RMDATA,U,2) I RMQUAN="" S RMQUAN=0
 ..I RMREOR>RMQUAN D
 ...S RM11=$O(^RMPR(661.11,"ASHI",I,J,K,0))
 ...S RMITEM="xxxx"
 ...I RM11,$D(^RMPR(661.11,RM11,0)) Q:$P(^RMPR(661.11,RM11,0),U,9)  S RMITEM=$P(^RMPR(661.11,RM11,0),U,3)
 ...S RML="****"
 ...I L,$D(^RMPR(661.5,L,0)) S RML=$P(^RMPR(661.5,L,0),U,1)
 ...S ^TMP($J,"RMX",I,RML,RMITEM)=RMITEM_"^"_RMREOR_"^"_RMQUAN_"^"_J_"-"_K
 ...I $D(^TMP($J,"RMPRPIUD",I,J,K,"M")) D
 ....F RMI=0:0 S RMI=$O(^TMP($J,"RMPRPIUD",I,J,K,"M",RMI)) Q:RMI'>0  D
 .....S RMLEFT=0
 .....F RMJ=0:0 S RMJ=$O(^TMP($J,"RMPRPIUD",I,J,K,"M",RMI,RMJ)) Q:RMJ'>0  S RM41=^TMP($J,"RMPRPIUD",I,J,K,"M",RMI,RMJ) D
 ......S RMORD=$P(RM41,U,1)
 ......S RMDATO=$P(RM41,U,2),RMRECV=$P(RM41,U,3),RMWDS=""
 ......S:RMRECV RMWDS="  ...received to-date: "_RMRECV
 ......;S RMLEF=RMORD-RMREC
 ......;I $G(RMLEF) S RMLEFT=RMLEFT+RMLEF
 ......I $G(RMORD) S ^TMP($J,"RMX",I,RML,RMITEM,"M",RMJ)="   **** Quantity = "_RMORD_" has been ordered for item..."_RMITEM_" on "_RMDATO_RMWDS
 ;
 Q
MES1 ;
 S XMY("G.RMPR INVENTORY")="",XMDUZ=.5,XMTEXT="RMX("
 S XMSUB="PROSTHETICS INVENTORY MESSAGE"
 S RMX(1)="Run Date: "_RMRDAT
 S RMX(2)="This is a notification from the Prosthetics Department........"
 S RMX(3)=""
 S RMX(4)="The current balance for the following item(s) is/are below the reorder level:"
 S RMX(5)="[Site] [Location]       [Item]                      [HCPCS] [Reorder Lvl] [Bal] "
 Q
MES2 ;
 S RMX(RMSUBI+2)=""
 S RMX(RMSUBI+3)=""
 S RMX(RMSUBI+4)="Thank You!!!"
 S RMX(RMSUBI+5)=""
 S RMX(RMSUBI+6)="PROSTHETICS DEPARTMENT"
 D ^XMD
 Q
 ;
BUILD S I=""
 F  S I=$O(^TMP($J,"RMX",I)) Q:I=""  S J="" F  S J=$O(^TMP($J,"RMX",I,J)) Q:J=""  S K="" F  S K=$O(^TMP($J,"RMX",I,J,K)) Q:K=""  S RM0=^TMP($J,"RMX",I,J,K) D
 .S RML=$P(RM0,U,2),RMB=$P(RM0,U,3),RMSTA=I,RMLO=J,RMITEM=K,RMHCPC=$P(RM0,U,4)_"  "
 .S RMITEM=RMITEM_"                             "
 .S RMSUBI=RMSUBI+1,RMLO=RMLO_"                    "
 .S RMX(RMSUBI)=$E($P(^DIC(4,RMSTA,0),U,1),1,6)_" "_$E(RMLO,1,16)_" "_$E(RMITEM,1,28)_" "_$E(RMHCPC,1,9)_" "_$J(RML,5)_"      "_$J(RMB,5)
 .;S RMXI(RMSUBI)=RMX(RMSUBI)_"^"_I_"^"_J_"^"_K
 .I $D(^TMP($J,"RMX",I,J,K,"M")) D
 ..S RMJ=0
 ..F  S RMJ=$O(^TMP($J,"RMX",I,J,K,"M",RMJ)) Q:RMJ=""  D
 ...S RMSUBI=RMSUBI+1,RMX(RMSUBI)=^TMP($J,"RMX",I,J,K,"M",RMJ)
 Q
 ;
WRI ;PRINT NOTIFICATION LETTER IN SUPPLY PRINTER. This functionality is not included with this released.
 ;S RMDEV=$P(^RMPR(669.9,RS,"INV"),U,1)
 ;S RMIOS=IO,IO=$P(^%ZIS(1,RMDEV,0),U,2)
 ;D NOW^%DTC
 ;O IO U IO W !,"Run Date: ",RMRDAT,!!,"This is a notification from the Prosthetics Department..."
 ;W !!,"The current balance for the following item(s) is/are below the reorder level:"
 ;W !,"[Location]        [Item]              [HCPCS] [Reorder Level] [Current Balance]"
 ;F I=0:0 S I=$O(RMXI(I)) Q:I'>0  D
 ;.S RMLO=$P(RMXI(I),U,2),RMI=$P(RMXI(I),U,3)
 ;.W !,$P(RMXI(I),U,1)
 ;.S $P(^RMPR(661.3,RMLO,1,RMI,0),U,7)=%
 ;W !!!,"Thank You!!!!!"
 ;W !!,"PROSTHETICS DEPARTMENT"
 ;S $P(^RMPR(669.9,RS,"INV"),U,3)=DT
 ;D ^%ZISC S IO=RMIOS O IO U IO
 ;K RMB,RMD,RMI,RML,RMDO,RMDATI,RMLOCI,RMXI,I,J,XMTEXT,RMGROUP,RMHCPC
 ;Q
 ;
EXIT ;MAIN EXIT POINT
 N RMPRSITE,RMPR D KILL^XUSCLEAN
 K ^TMP($J)
 Q
