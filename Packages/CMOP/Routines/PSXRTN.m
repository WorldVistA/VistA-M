PSXRTN ;BIR/WPB,PWC-Queue for the Background Filer at Host Facilities ;MAR 1,2002@16:11:17
 ;;2.0;CMOP;**32,44**;11 Apr 97
QUE W !!
 I $D(^PSX(554,"AB")) S DIR(0)="Y",DIR("A",1)="This job is already scheduled.",DIR("A")="Do you want to unschedule this job",DIR("B")="NO" D ^DIR K DIR G:Y<1!($D(DIRUT)) EXIT G:Y=1 STOPJOB^PSXBKD Q
 S %DT="AEXR",%DT("A")="Enter starting date/time:  ",%DT("B")="NOW" D ^%DT K %DT G:Y<0!($D(DTOUT)) EXIT S PSXDATE=Y K Y,X
 S ZTDTH=PSXDATE,ZTDESC="CMOP Background Filer CMOP Master Database file",ZTIO="",ZTRTN="DATA^PSXRTN1",ZTSAVE("DUZ")="" D ^%ZTLOAD
 I $G(ZTSK)>0 W !,"Job Started.",! D
 .K DD,DO
 .S:'$D(^PSX(554,1,1,0)) ^PSX(554,1,1,0)="^554.01SA^^"
 .S DA(1)=1,X=1,DIC(0)="Z",DIC="^PSX(554,"_DA(1)_",1,",DIC("DR")="1////"_PSXDATE_";2////"_ZTSK_";3////S;4////"_DUZ D FILE^DICN K DIC,DIC(0),DIC("DR"),X
 S ZTREQ="@"
 Q
NEXT S FREQ="900S",ZTSK=PSXZTSK,ZTRTN="DATA^PSXRTN1",ZTIO="",ZTDESC="CMOP Automated Release Data Processor",ZTDTH=FREQ D REQ^%ZTLOAD
 ;D ISQED^%ZTLOAD S:$G(ZTSK(0))=0!($G(ZTSK(0))=1) NXTM=$$HTFM^XLFDT($G(ZTSK("D")))
 D NOW^%DTC
 S RE=$O(^PSX(554,"AB","")) S:$G(RE)>0 $P(^PSX(554,1,1,RE,0),"^",9)=%
 K ZTDESC,ZTRTN,ZTSK,ZTIO,ZTDTH,FREQ,ZTSAVE("DUZ"),ZTREQ,PSXZTSK,RE,%
EXIT K AF,BB,CC,CNT,COMDT,DIE,DIC,DR,DA,DRUG,EMPID,FILL,I,NPTR,NREC,PSXFM,PSXNDC,PSXTS,QRYID,QTY,REASON,RECDT,REL,RXN,RXSTAT,SNODE,SS,STAT,REL1,DUPFLG,CANFLG,CDT1,RX1,SP,SP2,SP3,XX1,XX2
 K TNODE,UU,VV,X,XPTR,XREC,XX,XXX,Y,DEL,IEN50,N,NK,NNREC,PSXDATE,COST,STDATE,TIME,XDA,QRYN,ACKTM,ACKT,%,TDT,CANFLG,STOP,LST,LSTQRY,CANF,IDDRG,COST,IEN50,DIROUT,DIR,DIRUT,DTOUT,DUOUT,CDT,LCNT,NXTM
 Q
NDRGMSG Q:'$D(^TMP($J,"PSXNDG"))
 I $$GET1^DIQ(554,1,8)="NO" Q
 S XMSUB="CMOP DRUG Cost Missing",XMDUZ=.5,XMDUN="CMOP Manager"
 D XMZ^XMA2 G:XMZ'>0 NDRGMSG
 S XX2="********************"
 S LCNT=1,^XMB(3.9,XMZ,2,LCNT,0)="DRUG/Items listed below are missing cost data or are not marked for CMOP.",LCNT=LCNT+1
 S ^XMB(3.9,XMZ,2,LCNT,0)="",LCNT=LCNT+1,XX1="                  "
 S ^XMB(3.9,XMZ,2,LCNT,0)="DRUG ID  COMPLETED DATE    RX NUMBER         TRANSMISSION",LCNT=LCNT+1
 S ^XMB(3.9,XMZ,2,LCNT,0)="-------------------------------------------------------------------------------",LCNT=LCNT+1
 S IDRG="" F  S IDRG=$O(^TMP($J,"PSXNDG",IDRG)) Q:IDRG=""  S CDT="" F  S CDT=$O(^TMP($J,"PSXNDG",IDRG,CDT)) Q:CDT=""  D
 .S CDT1=$$FMTE^XLFDT(CDT,"2D"),RX1=$P(^TMP($J,"PSXNDG",IDRG,CDT),"^",1),SP="    ",SP2=$E(XX1,1,18-$L(CDT1)),SP3=$E(XX1,1,18-$L(RX1))
 .S ^XMB(3.9,XMZ,2,LCNT,0)=IDRG_SP_CDT1_SP2_RX1_SP3_$P(^TMP($J,"PSXNDG",IDRG,CDT),"^",2),LCNT=LCNT+1
 S ^XMB(3.9,XMZ,2,LCNT,0)="",LCNT=LCNT+1
 S ^XMB(3.9,XMZ,2,LCNT,0)=XX2_XX2_XX2_$E(XX2,1,$L(XX2)-1),LCNT=LCNT+1
 S ^XMB(3.9,XMZ,2,LCNT,0)="There is NO ENTRY in DRUG file #50 marked for CMOP Dispense with this ID number",LCNT=LCNT+1
 S ^XMB(3.9,XMZ,2,LCNT,0)="and/or there is no COST information available.",LCNT=LCNT+1
 S ^XMB(3.9,XMZ,2,LCNT,0)=XX2_XX2_XX2_$E(XX2,1,$L(XX2)-1),LCNT=LCNT+1
 S ^XMB(3.9,XMZ,2,LCNT,0)="",LCNT=LCNT+1
 S ^XMB(3.9,XMZ,2,LCNT,0)="Corrective Action:  ",LCNT=LCNT+1
 S ^XMB(3.9,XMZ,2,LCNT,0)="    Step 1:  Locate the correct entry in DRUG file #50, or create the new entry",LCNT=LCNT+1
 S ^XMB(3.9,XMZ,2,LCNT,0)="             if necessary.  Since the drug/item was filled by the automated",LCNT=LCNT+1
 S ^XMB(3.9,XMZ,2,LCNT,0)="             system, you can look up the VA Print Name on that system, not",LCNT=LCNT+1
 S ^XMB(3.9,XMZ,2,LCNT,0)="             DHCP, to determine what the DRUG file #50 entry should be.  The",LCNT=LCNT+1
 S ^XMB(3.9,XMZ,2,LCNT,0)="             remainder of the steps should be done on DHCP.",LCNT=LCNT+1
 S ^XMB(3.9,XMZ,2,LCNT,0)="    Step 2:  Be sure the entry is marked for Outpatient use.",LCNT=LCNT+1
 S ^XMB(3.9,XMZ,2,LCNT,0)="    Step 3:  Match to the correct NATIONAL DRUG file entry.",LCNT=LCNT+1
 S ^XMB(3.9,XMZ,2,LCNT,0)="    Step 4:  Verify the match.",LCNT=LCNT+1
 S ^XMB(3.9,XMZ,2,LCNT,0)="    Step 5:  Merge the NDF data into DRUG file #50.",LCNT=LCNT+1
 S ^XMB(3.9,XMZ,2,LCNT,0)="    Step 6:  Enter the correct cost information in DRUG file #50.",LCNT=LCNT+1
 S ^XMB(3.9,XMZ,2,LCNT,0)="    Step 7:  Run the Cost Update option for the completed date listed to",LCNT=LCNT+1
 S ^XMB(3.9,XMZ,2,LCNT,0)="             update the CMOP MASTER DATABASE file.",LCNT=LCNT+1
 S ^XMB(3.9,XMZ,2,LCNT,0)="    Step 8:  Review prescriptions listed above using the Rx Inquiry option",LCNT=LCNT+1
 S ^XMB(3.9,XMZ,2,LCNT,0)="             to validate that the cost entry is complete.",LCNT=LCNT+1
 S ^XMB(3.9,XMZ,2,LCNT,0)="    Step 9:  Recompile the cost data for the date(s) listed to pick up the new",LCNT=LCNT+1
 S ^XMB(3.9,XMZ,2,LCNT,0)="             cost data.",LCNT=LCNT+1
 S ^XMB(3.9,XMZ,2,LCNT,0)="",LCNT=LCNT+1
 S ^XMB(3.9,XMZ,2,LCNT,0)=XX2_XX2_XX2_$E(XX2,1,$L(XX2)-1),LCNT=LCNT+1
 S ^XMB(3.9,XMZ,2,LCNT,0)="** Failure to complete these changes will result in inaccurate cost reports. **",LCNT=LCNT+1
 S ^XMB(3.9,XMZ,2,LCNT,0)=XX2_XX2_XX2_$E(XX2,1,$L(XX2)-1),LCNT=LCNT+1
 S ^XMB(3.9,XMZ,2,0)="^3.92A^"_LCNT_"^"_LCNT_"^"_DT
 K XMY D GRP^PSXNOTE D ENT1^XMD
 G EXIT
