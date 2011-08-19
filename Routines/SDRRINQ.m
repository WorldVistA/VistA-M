SDRRINQ  ;10N20/MAH;-Recall Reminder PATIENT INQUIRY ;01/28/2008  11:32
 ;;5.3;Scheduling;**536**;Aug 13, 1993;Build 53
 ; Option: SDRR PATIENT INQUIRY
EN ;Looping through both active recalls and archive entries
 N DFN
 K ^TMP("SDRRINQ",$J)
 S (SHOW,SHOW1)=1
 D ^DPTLK Q:Y<0  S DFN=+Y K Y
 I '$D(^SD(403.5,"B",DFN)) W !!,"**No Active Clinic Recall on file",! S SHOW=0
 I '$D(^SD(403.56,"B",DFN)) W !,"**No Archive Clinic Recalls on file",! S SHOW1=0
 G:(SHOW<1)&(SHOW1<1) QUIT
 D DATE
 I $D(ERR) K ERR Q
SELDT I RANGE=1 S %DT="AEX",%DT("A")="Beginning Date: " D ^%DT Q:Y<0  S SDT=Y,%DT("A")="Ending DATE: " D ^%DT I Y<SDT W $C(7),"  ??" G SELDT
 S EDT=Y
 I RANGE=0 S (SDT,EDT)=0
 I RANGE=0 D PRT
 I $D(ERROR)  K ERROR Q
 I Y=1 G QUE^SDRRINQ1
 I RANGE=0 D ACT,ARC,REPORT,REPORT1 G QUIT
 I RANGE=1 D SEL,SEL1,REPORT,REPORT1 G QUIT
 Q
SEL I $D(^SD(403.5,"B",DFN)) S (RSENT,SSENT,PRDT,TYPE)="" S IEN=0 F  S IEN=$O(^SD(403.5,"B",DFN,IEN)) Q:'IEN  S NODE=$G(^SD(403.5,IEN,0)) D
 .S CLINIC=$P($G(NODE),"^",2),CLINIC=$$GET1^DIQ(44,CLINIC_",",.01),ACCINFOR=$P($G(NODE),"^",3)
 .S TYPE=$P($G(NODE),"^",4) I TYPE'="" S TYPE=$P(^SD(403.51,TYPE,0),"^",1)
 .S PROVIDER=$P(NODE,"^",5) I PROVIDER'="" S PROVIDER=$P($G(^SD(403.54,PROVIDER,0)),"^",1) S PROVIDER=$$NAME^XUSER(PROVIDER,"F")
 .I PROVIDER="" S PROVIDER="Unknown"
 .S RDT=""
 .S Y=$P(NODE,"^",6) Q:Y<SDT!(Y>EDT)
 .I Y>SDT,(Y<EDT) D DD^%DT S RDT=Y K Y,X
 .S COMMENT=$P($G(NODE),"^",7)
 .S FAST=$S($P(NODE,"^",8)["n":"NO",$P(NODE,"^",8)["f":"YES",1:"")
 .S LOA=$P(NODE,"^",9)
 .S Y=$P($G(NODE),"^",10) I Y'="" D DD^%DT S RSENT=Y K Y,X
 .I RSENT="" S RSENT="NOTSENT"
 .S USER=$P($G(NODE),"^",11),USER=$$NAME^XUSER(USER,"F")
 .S Y=$P(NODE,"^",12) I Y'="" D DD^%DT S PRDT=Y K Y,X
 .S Y=$P(NODE,"^",13) I Y'="" D DD^%DT S SSENT="*"_Y K Y,X
 .S ^TMP("SDRRINQ",$J,"ACT",IEN)=CLINIC_"^"_ACCINFOR_"^"_TYPE_"^"_PROVIDER_"^"_RDT_"^"_COMMENT_"^"_FAST_"^"_LOA_"^"_RSENT_"^"_USER_"^"_PRDT_"^"_SSENT
 Q
SEL1 I $D(^SD(403.56,"B",DFN))  S (SSENT,RSENT,PRDTA,TYPE)="" S IENA=0 F  S IENA=$O(^SD(403.56,"B",DFN,IENA)) Q:'IENA  S NODEA=$G(^SD(403.56,IENA,0)) D
 .S CLINIC=$P($G(NODEA),"^",2),CLINIC=$$GET1^DIQ(44,CLINIC_",",.01),ACCINFOR=$P($G(NODEA),"^",3)
 .S TYPE=$P($G(NODEA),"^",4) I TYPE'="" S TYPE=$P(^SD(403.51,TYPE,0),"^",1)
 .S PROVIDER=$P(NODEA,"^",5) I PROVIDER'="" S PROVIDER=$P($G(^SD(403.54,PROVIDER,0)),"^",1) S PROVIDER=$$NAME^XUSER(PROVIDER,"F")
 .I PROVIDER="" S PROVIDER="Unknown"
 .S RDT=""
 .S Y=$P(NODEA,"^",6) Q:Y<SDT!(Y>EDT)
 .I Y>SDT&(Y<EDT) D DD^%DT S RDT=Y K Y,X
 .S COMMENT=$P($G(NODEA),"^",7)
 .S FAST=$S($P(NODEA,"^",8)["n":"NO",$P(NODEA,"^",8)["f":"YES",1:"")
 .S LOA=$P(NODEA,"^",9)
 .S Y=$P($G(NODEA),"^",10) I Y'="" D DD^%DT S RSENT=Y K Y,X
 .I RSENT="" S RSENT="NOTSENT"
 .S USER=$P($G(NODEA),"^",11),USER=$$NAME^XUSER(USER,"F")
 .I $D(^SD(403.56,IENA,2)) S NODEA2=$G(^SD(403.56,IENA,2)) D
 ..S Y=$P(NODEA2,"^",1) D DD^%DT S PRDTA=Y K Y,X
 ..S USER2=$P($G(NODEA2),"^",2),USER2=$$NAME^XUSER(USER2,"F")
 ..S SDRREASN=$S($P(NODEA2,"^",3)=1:"FTR",$P(NODEA2,"^",3)=2:"MOVED",$P(NODEA2,"^",3)=3:"DECEASED",$P(NODEA2,"^",3)=4:"DNWC",$P(NODEA2,"^",3)=5:"RCOVA",$P(NODEA2,"^",3)=6:"OTHER",$P(NODEA2,"^",3)=7:"Scheduled",1:"")
 ..S ^TMP("SDRRINQ",$J,"ARC",IENA)=CLINIC_"^"_ACCINFOR_"^"_TYPE_"^"_PROVIDER_"^"_RDT_"^"_COMMENT_"^"_FAST_"^"_LOA_"^"_RSENT_"^"_USER2_"^"_SSENT_"^"_SDRREASN_"^"_PRDTA
 Q
HDR ;Review all Recall Reminder on screen for all
 D DEM^VADPT S NAME=VADM(1),LAST4=VA("BID"),DOB=$P(VADM(3),"^",2) S HDR="Patient Name: "_NAME_"  Date of Birth: "_DOB_" Last4: "_LAST4
 W @IOF,HDR
 Q
ACT I $D(^SD(403.5,"B",DFN)) S (RSENT,SSENT,IEN,PRDT,TYPE)="" F  S IEN=$O(^SD(403.5,"B",DFN,IEN)) Q:'IEN  S NODE=$G(^SD(403.5,IEN,0)) D
 .S CLINIC=$P($G(NODE),"^",2),CLINIC=$$GET1^DIQ(44,CLINIC_",",.01),ACCINFOR=$P($G(NODE),"^",3)
 .S TYPE=$P($G(NODE),"^",4) I TYPE'="" S TYPE=$P(^SD(403.51,TYPE,0),"^",1)
 .S PROVIDER=$P(NODE,"^",5) I PROVIDER'="" S PROVIDER=$P($G(^SD(403.54,PROVIDER,0)),"^",1) S PROVIDER=$$NAME^XUSER(PROVIDER,"F")
 .I PROVIDER="" S PROVIDER="Unknown"
 .S RDT=""
 .S Y=$P(NODE,"^",6) D DD^%DT S RDT=Y K Y,X
 .S COMMENT=$P($G(NODE),"^",7)
 .S FAST=$S($P(NODE,"^",8)["n":"NO",$P(NODE,"^",8)["f":"YES",1:"")
 .S LOA=$P(NODE,"^",9)
 .S Y=$P($G(NODE),"^",10) I Y'="" D DD^%DT S RSENT=Y K Y,X
 .I RSENT="" S RSENT="NOTSENT"
 .S USER=$P($G(NODE),"^",11),USER=$$NAME^XUSER(USER,"F")
 .S Y=$P(NODE,"^",12) I Y'="" D DD^%DT S PRDT=Y K Y,X
 .S Y=$P(NODE,"^",13) I Y'="" D DD^%DT S SSENT="*"_Y K Y,X
 .S ^TMP("SDRRINQ",$J,"ACT",IEN)=CLINIC_"^"_ACCINFOR_"^"_TYPE_"^"_PROVIDER_"^"_RDT_"^"_COMMENT_"^"_FAST_"^"_LOA_"^"_RSENT_"^"_USER_"^"_PRDT_"^"_SSENT
 Q
ARC I $D(^SD(403.56,"B",DFN))  S (SSENT,RSENT,PRDTA,TYPE)="" S IENA=0 F  S IENA=$O(^SD(403.56,"B",DFN,IENA)) Q:'IENA  S NODEA=$G(^SD(403.56,IENA,0)) D
 .S CLINIC=$P($G(NODEA),"^",2),CLINIC=$$GET1^DIQ(44,CLINIC_",",.01),ACCINFOR=$P($G(NODEA),"^",3)
 .S TYPE=$P($G(NODEA),"^",4) I TYPE'="" S TYPE=$P(^SD(403.51,TYPE,0),"^",1)
 .S PROVIDER=$P(NODEA,"^",5) I PROVIDER'="" S PROVIDER=$P($G(^SD(403.54,PROVIDER,0)),"^",1) S PROVIDER=$$NAME^XUSER(PROVIDER,"F")
 .I PROVIDER="" S PROVIDER="Unknown"
 .S RDT=""
 .S Y=$P(NODEA,"^",6) D DD^%DT S RDT=Y K Y,X
 .S COMMENT=$P($G(NODEA),"^",7)
 .S FAST=$S($P(NODEA,"^",8)["n":"NO",$P(NODEA,"^",8)["f":"YES",1:"")
 .S LOA=$P(NODEA,"^",9)
 .S Y=$P($G(NODEA),"^",10) I Y'="" D DD^%DT S RSENT=Y K Y,X
 .I RSENT="" S RSENT="NOTSENT"
 .S USER=$P($G(NODEA),"^",11),USER=$$NAME^XUSER(USER,"F")
 .I $D(^SD(403.56,IENA,2)) S NODEA2=$G(^SD(403.56,IENA,2)) D
 ..S Y=$P(NODEA2,"^",1) D DD^%DT S PRDTA=Y K Y,X
 ..S USER2=$P($G(NODEA2),"^",2),USER2=$$NAME^XUSER(USER2,"F")
 ..S SDRREASN=$S($P(NODEA2,"^",3)=1:"FTR",$P(NODEA2,"^",3)=2:"MOVED",$P(NODEA2,"^",3)=3:"DECEASED",$P(NODEA2,"^",3)=4:"DNWC",$P(NODEA2,"^",3)=5:"RCOVA",$P(NODEA2,"^",3)=6:"OTHER",$P(NODEA2,"^",3)=7:"Scheduled",1:"")
 ..S ^TMP("SDRRINQ",$J,"ARC",IENA)=CLINIC_"^"_ACCINFOR_"^"_TYPE_"^"_PROVIDER_"^"_RDT_"^"_COMMENT_"^"_FAST_"^"_LOA_"^"_RSENT_"^"_USER2_"^"_SSENT_"^"_SDRREASN_"^"_PRDTA
 Q
DATE ; DIR call
 S (YES,RANGE)=0,DIR("B")="All" K SDHDR
 S DIR(0)="S^R:Range;A:All",DIR("A")="Do you want a (R)ange or (A)ll" I $D(DIRUT) S ERR=1 G QUIT
 S DIR("?",1)="",DIR("?",2)="     (A)ll gives the user all dates.",DIR("?")="     (R)ange allows the user to select a range of dates."
 D ^DIR K DIR I $D(DIRUT) S ERR=1 G QUIT
 I "RA"'[Y W !!,"Enter 'R' for a date range or 'A' for all dates." G DATE
 I "R"[Y S RANGE=1
 Q
PRT ;
 S YES=0
 S DIR(0)="Y",DIR("B")="NO",DIR("A")="Do you want to print the profile"
 S DIR("?",1)="     Enter 'YES' to print the profile.",DIR("?")="     If you enter 'NO', it will take you to the Recall Reminder report."
 D ^DIR K DIR I $D(DIRUT) S ERROR=1 G QUIT
 Q
REPORT D HDR
 I '$D(^TMP("SDRRINQ",$J,"ACT")) W !!,?25,"No ACTIVE Recalls Reminders on file" Q
 I $D(^TMP("SDRRINQ",$J,"ACT")) W !!,?25,"ACTIVE RECALL REMINDERS"
 S ITEM=0 F  S ITEM=$O(^TMP("SDRRINQ",$J,"ACT",ITEM)) Q:'ITEM  D
 .S INFOR=$G(^TMP("SDRRINQ",$J,"ACT",ITEM))
 .W !!,?5,"Clinic: "_$P($G(INFOR),"^",1),?45,"Recall Date: "_$P($G(INFOR),"^",5)
 .W !,?5,"Provider: "_$P($G(INFOR),"^",4),?45,"Appt/Type: "_$P($G(INFOR),"^",3)
 .W !,?5,"Fasting/NonFasting: "_$P($G(INFOR),"^",7)
 .W !,?5,"Appt Requested Length: "_$P($G(INFOR),"^",8),?45,"Date Reminder Sent: "_$P($G(INFOR),"^",9)
 .W !,?5,"User who Entered: "_$P($G(INFOR),"^",10),?45,"Patient Requested Dt: "_$P($G(INFOR),"^",11)
 .W !,?5,"Date Second Reminder Sent: "_$P($G(INFOR),"^",12)
 .W !,?5,"Comments: "_$P($G(INFOR),"^",6)
 .I $Y>(IOSL-6) K DIR S DIR(0)="E",DIR("A")="Press Return for more Information.." D ^DIR Q:$D(DUOUT)!($D(DTOUT))  D HDR
 K DIR S DIR(0)="E",DIR("A")="Press Return to continue.." D ^DIR Q:$D(DUOUT)!($D(DTOUT))
 Q
REPORT1 D HDR
 I '$D(^TMP("SDRRINQ",$J,"ARC")) W !!,?25,"No INACTIVE Recalls Reminders on file" Q
 I $D(^TMP("SDRRINQ",$J,"ARC")) W !!,?25,"INACTIVE RECALL REMINDERS"
 S ITEM=0 F  S ITEM=$O(^TMP("SDRRINQ",$J,"ARC",ITEM)) Q:'ITEM  D
 .S INFOR=$G(^TMP("SDRRINQ",$J,"ARC",ITEM))
 .W !!,?5,"Clinic: "_$P($G(INFOR),"^",1),?45,"Recall Date: "_$P($G(INFOR),"^",5)
 .W !,?5,"Provider: "_$P($G(INFOR),"^",4),?45,"Appt/Type: "_$P($G(INFOR),"^",3)
 .W !,?5,"Fasting/NonFasting: "_$P($G(INFOR),"^",7)
 .W !,?5,"Appt Requested Length: "_$P($G(INFOR),"^",8),?45,"Date Reminder Sent: "_$P($G(INFOR),"^",9)
 .W !,?5,"User who Entered: "_$P($G(INFOR),"^",10),?45,"Patient Requested Dt: "_$P($G(INFOR),"^",11)
 .W !,?5,"Date Removed from Active File: "_$P($G(INFOR),"^",13)
 .W !,?5,"Reason for Removal: "_$P($G(INFOR),"^",12)
 .W !,?5,"User who Deleted Entry: "_$P($G(INFOR),"^",10)
 .W !,?5,"Comments: "_$P($G(INFOR),"^",6)
 .I $Y>(IOSL-6) K DIR S DIR(0)="E",DIR("A")="Press Return for more Information.." D ^DIR Q:$D(DUOUT)!($D(DTOUT))  D HDR
 K DIR S DIR(0)="E",DIR("A")="Press Return to continue.." D ^DIR Q:$D(DUOUT)!($D(DTOUT))
 Q
QUIT K DFN,Y,SHOW,SHOW1,ACCINFOR,CLINIC,COMMENT,DOB,DIRUT,DTOUT,DUOUT,EDT,FAST,HDR,IEN,IENA,INFOR,ITEM,LAST4,LOA,NAME
 K NODE,NODEA,PRDT,PRDTA,PROVIDER,RANGE,RDT,RSENT,SDRREASN,SDT,SSENT,TYPE,USER,USER2,NODEA2,DIR,YES
 K ^TMP("SDRRINQ",$J),%DT,VA,VADM,YES
 Q
