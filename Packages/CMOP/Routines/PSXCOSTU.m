PSXCOSTU ;BIR/BAB,WPB,HTW-Cost Update ; 26 Apr 2000  10:52 AM
 ;;2.0;CMOP;**18,19,27**;11 Apr 97
 ;Reference to ^PSDRUG( supported by DBIA #2367, #1983
 ;
 ;This routine will update the CMOP Master Database file with cost data from the drug file. Discrepancies will be reported via mail message.
 Q
BLANK S ^XMB(3.9,XMZ,2,MCT,0)="" S MCT=MCT+1
 Q
EN ;
 W !! S DIR(0)="D^::EX",DIR("A")="Enter Begin Date ",DIR("?")="Enter the beginning date for the report" D ^DIR K DIR,DIR("?")
 G:($D(DIRUT))!($D(DIROUT)) EXIT
 S BB=Y,BEG=$$FMADD^XLFDT(BB,-1,0,0,0) K Y
EDT W !! S DIR(0)="DO^::EX",DIR("A")="Enter End Date ",DIR("?")="Enter the ending date for the report" D ^DIR K DIR,DIR("?")
 I $G(Y)']"" W !! G EN
 G:($D(DIRUT))!($D(DIROUT)) EXIT
 I Y<BB W !,"End Date must follow Begin Date!" K Y,DIR G EDT
 S EE=Y,END=$$FMADD^XLFDT(EE,1,0,0,0) K Y,EE
QUE S ZTRTN="GET^PSXCOSTU",ZTIO="",ZTSAVE("BEG")="",ZTSAVE("END")=""
 S ZTDESC="CMOP Cost Update for Master Database",ZTSAVE("DUZ")=""
 D ^%ZTLOAD
 I $D(ZTSK)[0 W !!,"Job Cancelled"
 E  W !!,"Job Queued"
 G EXIT
 ; Called by Taskman to Build Cost Data
GET S (C1,CNT)=1
 F  S BEG=$O(^PSX(552.4,"AD",BEG)) Q:BEG'>0!(BEG=END)  S XX=0 F  S XX=$O(^PSX(552.4,"AD",BEG,XX)) Q:XX'>0  S YY=0 F  S YY=$O(^PSX(552.4,"AD",BEG,XX,YY)) Q:YY'>0  D
 .I $P($G(^PSX(552.4,XX,1,YY,0)),U,2)'=1 Q
 .I $P(^PSX(552.4,XX,1,YY,0),U,11)>0 Q
 .S IDDRG=$P($G(^PSX(552.4,XX,1,YY,0)),U,4) Q:$G(IDDRG)=""
 .S CDT=$P($G(^PSX(552.4,XX,1,YY,0)),U,9) I $G(CDT) S Y=$P(CDT,".") X ^DD("DD") S CDT=Y K Y
 .S IEN50=$O(^PSDRUG("AQ1",IDDRG,""))
 .I $G(IEN50)']"" S ^TMP($J,"PSX",CNT)=IDDRG_"     "_$G(CDT) S CNT=CNT+1 Q
 .S COST=$P($G(^PSDRUG(IEN50,660)),U,6)
 .S Z1=$P($G(^PSDRUG(IEN50,"ND")),U),Z2=$P($G(^("ND")),U,3)
 .I $G(Z1),($G(Z2)) S ZX=$$PROD2^PSNAPIS(Z1,Z2),TRUG=$P($G(ZX),"^")
 .I $G(COST)']"" S ^TMP($J,"PSX1",C1)=IDDRG_"     "_$G(CDT)_"     "_$G(TRUG) S C1=C1+1 Q
 .S DA(1)=XX,DA=YY,DIE="^PSX(552.4,"_XX_",1,",DR="10////"_$G(COST) D ^DIE
 .K DA(1),DA,COST,IDDRG,IEN50,DIE,DR,Z1,Z2
MSG ;
 I '$D(^TMP($J,"PSX")),('$D(^TMP($J,"PSX1"))) G EXIT
 S XMSUB="CMOP COST UPDATE",XMDUZ=.5
XMZ D XMZ^XMA2
 I XMZ'>0 G XMZ
 S MCT=2
 D NOW^%DTC S Y=% X ^DD("DD")
 S ^XMB(3.9,XMZ,2,1,0)="CMOP Master Database Drug Cost Update   "_Y K Y
 F I=1:1:2 D BLANK
 I '$D(^TMP($J,"PSX")) G PSX1
 S ^XMB(3.9,XMZ,2,MCT,0)="The drug ID's listed below are missing a corresponding entry in Drug file 50,  therefore, no cost information can be updated for any prescription written"
 S MCT=MCT+1
 S ^XMB(3.9,XMZ,2,MCT,0)="for this drug.  When the drug file entry is available, the Cost Update option  may be re-run for the dates indicated to enter the costs for these drugs."
 S MCT=MCT+1
 D BLANK
 S ^XMB(3.9,XMZ,2,MCT,0)="DRUG ID   COMPLETED D/T"
 S MCT=MCT+1
 D BLANK
 F I=0:0 S I=$O(^TMP($J,"PSX",I)) Q:'I  D
 .S ^XMB(3.9,XMZ,2,MCT,0)=^TMP($J,"PSX",I) S MCT=MCT+1
 F I=1:1:2 D BLANK
PSX1 I '$D(^TMP($J,"PSX1")) G MSGEND
 S ^XMB(3.9,XMZ,2,MCT,0)="The Drug File entries listed below do not contain cost data so prescriptions   for these drugs have not been updated.  When the cost data is entered,  "
 S MCT=MCT+1
 S ^XMB(3.9,XMZ,2,MCT,0)="the Cost Update option may be re-run to update the prescription entries."
 S MCT=MCT+1
 D BLANK
 S ^XMB(3.9,XMZ,2,MCT,0)="DRUG ID   COMPLETED D/T   DRUG NAME"
 S MCT=MCT+1
 D BLANK
 F I=0:0 S I=$O(^TMP($J,"PSX1",I)) Q:'I  D
 .S ^XMB(3.9,XMZ,2,MCT,0)=^TMP($J,"PSX1",I) S MCT=MCT+1
MSGEND S ^XMB(3.9,XMZ,2,0)="^3.92A^"_MCT_U_MCT_U_DT,XMDUN="CMOP Manager"
 S XMDUZ=.5,XMY(DUZ)=""
 D ENT1^XMD
EXIT K ID,XX,YY,BEG,END,IDDRG,IEN50,CNT,COST,^TMP($J),CDT,BB
 K XMSER,XQMSG,XMZ,XMSUB S ZTREQ="@"
 Q
