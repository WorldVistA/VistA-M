IBJDE1 ;ALB/RB - DM DATA EXTRACTION (MENU OPTIONS/TRANSMIT E-MAIL) ;15-APR-99
 ;;2.0;INTEGRATED BILLING;**100,118,123,159,254,244**;21-MAR-94
 ;
VPE ; - View/print entries in IB DM EXTRACT DATA file (#351.71).
 I '$O(^IBE(351.71,0)) W !!,"There are no entries available.",*7 G ENQ
 ;
 S DIC="^IBE(351.71,",DIC(0)="AEMQZ",DIC("A")="Enter MONTH/YEAR: "
 D ^DIC K DIC G:Y'>0 ENQ S IB0=+Y,IBS=$P(Y(0),U,2),IBDT=Y(0,0)
 ;
 S DIC="^IBE(351.71,",BY=.01,(FR,TO)=IB0,DHD="W ?0 D VPH^IBJDE1"
 S FLDS="[IBJD DM V/P EXTRACTS]",L=0 D EN1^DIP W ! G VPE
 ;
VPH ; - Heading for View/Print option.
 W "DIAGNOSTIC MEASURES SUMMARY EXTRACTIONS-",IBDT
 W " (Status: ",$S(IBS=3:"COMPLETED",IBS=2:"STARTED",1:"ON STANDBY"),")"
 W !!,"Summary Line Item",?58,"Total",! F X=1:1:80 W "-"
 Q
 ;
DER ; - Disable/enable report(s) or extraction process.
 W ! S DIR(0)="Y",DIR("B")="NO"
 I $D(^IBE(351.7,"DISABLE")) D
 .S DIR("A",1)="The DM extract background job has been disabled."
 .S DIR("A")=" Do you want to re-enable it"
 E  S DIR("A")="Do you want to disable the DM extract background job"
 D ^DIR K DIR G:Y["^" ENQ I 'Y G DE1
 I $D(^IBE(351.7,"DISABLE")) K ^("DISABLE")
 E  S ^IBE(351.7,"DISABLE")=""
 W " ...Done",*7
 ;
DE1 ; - List disabled reports, if any.
 I $D(^IBE(351.7,"DISABLE")) G ENQ ; DM extract background job disabled.
 ;
 I $D(^IBE(351.7,"AC",1)) D
 .W !!,"These DM reports have been disabled:",!! S X=0
 .F  S X=$O(^IBE(351.7,"AC",1,X)) Q:'X  W ?3,$P($G(^IBE(351.7,X,0)),U),!
 E  W !!,"There are no disabled DM reports.",!
 ;
DE2 S DIR(0)="PO^351.7:AEMQZ",DIR("A")="Enter REPORT NAME"
 S DIR("?")="^D DEH^IBJDE1" D ^DIR K DIR I Y'>0 G ENQ
 S IB0=+Y,IBFL=$P(Y(0),U,2) W !!,Y(0,0),!
 ;
 S DIR("A")="Do you want to "_$S(IBFL:"re-en",1:"dis")_"able this report"
 S DIR(0)="Y",DIR("B")="NO" D ^DIR K DIR I Y["^"!('Y) W ! G DE2
 S DIE="^IBE(351.7,",DR=".02///"_$S('IBFL&(Y):1,1:"@"),DA=IB0
 D ^DIE K DA,DIE,DR W " ...Done",*7 G DE1
 ;
DEH ; - Help message for disable/enable option.
 W !,"Enter the name of the report you want disabled or re-enabled."
 W !,"If the report you enter is disabled, the monthly DM extraction"
 W !,"process will not collect summary data from the report until you"
 W !,"re-enable it again."
 Q
 ;
RTN ; - Help message for the field ROUTINE (entry point for the reprot)
 W !?9,"Enter the entry point for this report. You may enter  a  program"
 W !?9,"name (^ROUTINE), or a specific label of a  program (TAG^ROUTINE)"
 W !?9,"or you may also leave it blank.",!
 W !?9,"Obs: If this field is left blank, it means that the code respon-"
 W !?9,"     sible for extracting the data will be  invoked  by  another"
 W !?9,"     report.",!
 Q
 ;
MAN1 ; - Manually start DM extraction process.
 I $D(^IBE(351.7,"DISABLE")) D  G ENQ
 .W !!,"The DM extract process has been disabled.",!,*7
 S (IBX,X)=0
 F  S X=$O(^IBE(351.71,X)) Q:'X  I $P(^(X,0),U,2)'=3 S IBX=IBX+1
 I 'IBX W !,"All DM extracts on file have been transmitted.",!,*7 G ENQ
 ;
M1A S DIC="^IBE(351.71,",DIC(0)="AEMQZ",DIC("A")="Enter DM extract date: "
 S DIC("S")="I $P(^(0),U,2)'=3" W ! D ^DIC K DIC I Y'>0 G ENQ
 S IBDT=+Y,IBN=Y(0),IBDT1=$$M1^IBJDE(IBDT,3),IBST=$P(IBN,U,2)
 S DIR("A")="Do you want to start the DM extract process for "_IBDT1
 S DIR(0)="Y",DIR("B")="NO" D ^DIR K DIR I 'Y G ENQ
 I IBST=2 D  G:'Y ENQ
 .S DIR(0)="Y",DIR("B")="NO",IBS=$$M1^IBJDE($P(IBN,U,3),3)
 .S DIR("A",1)="The extract process for "_IBDT1_" began on "_IBS_"."
 .S DIR("A")="Do you want to restart it" W ! D ^DIR K DIR
 ;
 D BJ^IBJDE ; Start DM extraction background job.
 S IBS=$$M1^IBJDE($P($G(^IBE(351.71,IBDT,0)),U,3),3)
 W !!,"Extract process started on ",IBS,".",*7 S IBX=IBX-1
 I IBX D  G:Y M1A
 .S DIR("A")="Do you want to start the process for another date"
 .S DIR(0)="Y",DIR("B")="NO" D ^DIR K DIR
 ;
 G ENQ
 ;
MAN2 ; - Manually transmit DM extract file.
 I $D(^IBE(351.7,"DISABLE")) D  G ENQ
 .W !!,"The DM extract process has been disabled.",!,*7
 S (IBX,X)=0
 F  S X=$O(^IBE(351.71,X)) Q:'X  I $P(^(X,0),U,2)=3 S IBX=IBX+1
 I 'IBX D  G ENQ
 .W !,"All DM extracts on file have NOT been completed.",!,*7
 ;
M2A S DIC="^IBE(351.71,",DIC(0)="AEMQZ",DIC("A")="Enter DM extract date: "
 S DIC("S")="I $P(^(0),U,2)=3" W ! D ^DIC K DIC I Y'>0 G ENQ
 S IBDT=+Y,IBN=Y(0),DIR(0)="Y",DIR("B")="NO"
 S DIR("A")="Are you sure you want to transmit for "_$$M1^IBJDE(IBDT,3)
 D ^DIR K DIR I 'Y G M2A
M2B S $P(^IBE(351.71,IBDT,0),U,5)="" D XM(IBDT)
 I $G(XMZ) W " Done."
 E  D  G:Y M2B
 .S DIR(0)="Y",DIR("B")="NO"
 .S DIR("A")="The DM extract message failed to transmit...try again"
 .W !,*7 D ^DIR K DIR
 ;
 I IBX D  G:Y M2A
 .S DIR("A")="Do you want to start the process for another date"
 .S DIR(0)="Y",DIR("B")="NO" D ^DIR K DIR I Y S IBX=IBX-1
 ;
 G ENQ
 ;
MSG ; - DM extract reports message (shown when DM Menu is called up).
 S IBDT=$$M1^IBJDE(DT,1),IBDT1=$$M1^IBJDE(IBDT,3)
 I '$D(^IBE(351.71,IBDT,0)) G ENQ ; No extract data for this month yet.
 ;
 W @IOF S IBN=$G(^IBE(351.71,IBDT,0)),IBST=$P(IBN,U,2) I 'IBST G ENQ
 I IBST=1 D  G MSQ
 .W !,"The DM extract process for ",IBDT1," was initiated on "
 .W $$M1^IBJDE($P(IBN,U,3),3),!,"but it hasn't run yet.",!
 ;
 I IBST=3 D  G ENQ
 .W !,"The DM report data for ",IBDT1," has been successfully"
 .W !,"extracted on ",$$M1^IBJDE($P(IBN,U,4),3),". This data has been"
 .W !,"sent to the Central Collections mail group in FORUM.",*7
 ;
 S DIC="^IBE(351.71,",BY="[IBJD DM REPT SORT]",FR=IBDT_",1",TO=IBDT_",2"
 S DIOEND="I $Y'<(IOSL-14) R X:DTIME",(IOP,L)=0
 S DHD="W ?0 D MSH^IBJDE1",FLDS="[IBJD DM REPT PRINT]" D EN1^DIP
 ;
MSQ W !,"If you want, you can restart the DM extract process"
 W !,"by using the ""Manually Start DM Extraction"" option in"
 W !,"the Diagnostic Measures Extract Menu."
 G ENQ
 ;
MSH ; - DM extract reports message header.
 W !,"Data for the following DM reports have not been extracted"
 W !," for ",IBDT1,":",!!,*7
 Q
 ;
CHK ; - Check file #351.71 for completed and/or transmitted DM extracts
 ;   (shown when DM Extract Menu is called up).
 W @IOF,!,"Checking for completed and/or transmitted DM extracts"
 K IBX,IBX1 S (IBX,IBX1,IB0)=0
 S DT=$$DT^XLFDT
 F  S IB0=$O(^IBE(351.71,IB0)) Q:'IB0  S IBN=$G(^(IB0,0)) D
 .; - Do not process for invalid (day not equal 00 or future) dates
 .;   and remove data.
 .I (+$E(IB0,6,7)>0)!(IB0>DT) D  Q
 ..W !,"** Invalid date entry found.  Entry ("_IB0_") deleted.**",!
 ..S DIK="^IBE(351.71,",DA=IB0
 ..D ^DIK
 .; - Check for missing zero node.
 .I IBN="" W !,"Zero node data missing for "_IB0_" entry.  Data corruption possible.",! Q
 .; - Check for past months missing from file, if any.
 .I $O(^IBE(351.71,IB0)) D
 ..S IB1=$P(^IBE(351.71,0),U,4),IB2=IB0+$S($E(IB0,4,5)=12:8900,1:100)
 ..I $D(^IBE(351.71,"B",IB2,IB2))!(IB2>DT) Q
 ..S DIC="^IBE(351.71,",DIC(0)="L",DIC("DR")=".02///1",(DINUM,X)=IB2
 ..K DD,DO D FILE^DICN S $P(^IBE(351.71,0),U,4)=IB1+1 K DIC,DINUM,DD,DO
 .;
 .I $P(IBN,U,2)'=3 S IBX(IB0)="" S:'IBX IBX=1 Q
 .E  I '$P(IBN,U,5) S IBX1(IB0)="" S:'IBX1 IBX1=1 Q
 .W "."
 ;
 I 'IBX,'IBX1 W "Done" G ENQ
 I IBX D
 .W !!,"DM data has NOT been fully extracted for these months:",!,*7
 .S IB0=0 F  S IB0=$O(IBX(IB0)) Q:'IB0  W "  ",$$M1^IBJDE(IB0,3)
 .W !,"If you want, you can start the DM extract process for these"
 .W !,"months by using the ""Manually Start DM Extraction"" option."
 ;
 I IBX1 D
 .W !!,"DM data has NOT been transmitted for these months:",!,*7
 .S IB0=0 F  S IB0=$O(IBX1(IB0)) Q:'IB0  W "  ",$$M1^IBJDE(IB0,3)
 .W !,"If you want, you can transmit the DM extract data for these"
 .W !,"months by using the ""Manually Transmit DM Extract"" option."
 ;
 G ENQ
 ;
XM(IBDT) ; - Create/transmit DM extract file message.
 ;
 N DA,DIE,DR,IB0,IB1,IBC,IBDT1,IBMG,IBSTE,X,XMDUZ,XMSUB,XMTEXT
 ;
 K ^TMP("DME",$J) S IBSTE=$$SITE^VASITE,X=$E(DT,4,7)_(1700+$E(DT,1,3))
 S ^TMP("DME",$J,1)="HDR^"_$P(IBSTE,U,3)_U_$P(IBSTE,U,2)_U_X
 S IBC=1,IB0=0
 F  S IB0=$O(^IBE(351.71,IBDT,1,IB0)) Q:'IB0  D
 .Q:IB0=37  ; No unbilled report needed
 .S X=$S(IB0=8:$$M2^IBJDE(IBDT,5,3,1),1:$$M1^IBJDE(IBDT,2))
 .S IBC=IBC+1,^TMP("DME",$J,IBC)="DAT~"_IB0_"~"_$P(X,U)_"~"_$P(X,U,2)
 .S IB1=0 F  S IB1=$O(^IBE(351.71,IBDT,1,IB0,1,IB1)) Q:'IB1  D
 ..S X=$P($G(^IBE(351.71,IBDT,1,IB0,1,IB1,0)),U,2)
 ..S ^TMP("DME",$J,IBC)=^TMP("DME",$J,IBC)_U_X
 ;
 S ^TMP("DME",$J,IBC+1)="END^"_$P(IBSTE,U,3),IBDT1=$$M1^IBJDE(IBDT,3)
 S XMSUB="DIAG. MEASURES EXTRACT FILE-"_IBDT1_" ("_$P(IBSTE,U,2)_")"
 ;
 S IBMG=$P($G(^IBE(350.9,1,4)),U,5) I IBMG="" G ENQ:'$G(IBX),ENQ1
 ;
 S XMDUZ="INTEGRATED BILLING PACKAGE"
 S XMTEXT="^TMP(""DME"",$J,",XMY(IBMG)=""
 D SEND
 I $G(XMZ) S DIE="^IBE(351.71,",DA=IBDT,DR=".05///1;.06///"_XMZ D ^DIE
 ;
 I $G(IBX) G ENQ1 ; Return to DME manual transmit option.
 ;
ENQ K IB2,IBDT2,IBD1,IBD2,IBDT,IBFL,IBFR,IBN,IBS,IBST,IBST1,IBX,IBX1,BY,DHD
 K DIC,DIOEND,FLDS,FR,IOP,L,TO,X,XMZ,Y,%
ENQ1 K IB0,IB1,IBC,IBDT1,IBMG,IBSTE,XMSUB,XMTEXT,XMY,^TMP("DME",$J)
 Q
 ;
SEND ; Calls ^XMD to send the mail message with the data extracted
 ; Obs: By NEWing DUZ, ^XMD will assume DUZ=.5 (Sender=POSTMASTER)
 ;
 N DUZ D ^XMD
 Q
