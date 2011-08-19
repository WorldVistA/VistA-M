SR81UTL ;BIR/ADM-SR*3*81 Retransmissions of FY98 data ; [ 10/06/98  1:04 PM ]
 ;;3.0; Surgery ;**81**;24 Jun 93
 ; SRP(1) - station number
 ; SRP(2) - assessment/case number
 ; SRP(3) - division
 ; SRP(4) - patient ID
 ; SRP(5) - date of operation
 ; SRP(6) - hospital admission date
 ; SRP(7) - hospital discharge date
 ; SRP(8) - admission/transfer to surgical service
 ; SRP(9) - transfer/discharge to non-acute care
 ; SRP(10) - date/time patient left the OR
 ; SRP(11) - anesthesia care start date/time
 ; SRP(12) - PACU discharge date/time
 ; SRP(13) - observation admission date/time
 ; SRP(14) - observation discharge date/time
 ; SRP(15) - observation treating specialty
 ; SRP(16) - concurrent case number
 Q
EN1 K ^TMP("SRA",$J),^TMP("SRAINC",$J) S SITE=+$P($$SITE^SROVAR,"^",3),(SRI,SRAINC)=0,SROPD=2971000
 F  S SROPD=$O(^SRF("AC",SROPD)) Q:'SROPD  S SRTN=0 F  S SRTN=$O(^SRF("AC",SROPD,SRTN)) Q:'SRTN  S SRA=$G(^SRF(SRTN,"RA")),SR235=$P(SRA,"^") I (SR235="T"!(SR235="C")),$P(SRA,"^",6)="Y",$P(SRA,"^",2)="N",$G(^SRF(SRTN,208.1))="" D
 .K SRP F I=1:1:16 S SRP(I)=""
 .S SRA=$G(^SRF(SRTN,0)) Q:SRA=""  S SRP(1)=SITE,SRP(2)=SRTN,DFN=$P(SRA,"^"),SRP(5)=$P(SRA,"^",9) D DEM^VADPT S SRP(4)=VA("PID")
 .I $P($G(^SRF(SRTN,208.1)),"^")="" D OBS D:'SRSOUT NA I SRSOUT D INC Q
 .I SR235="C" Q
 .S SRP(3)=$P($G(^SRF(SRTN,8)),"^") I SRP(3) S SRP(3)=$$GET1^DIQ(4,SRP(3),99)
 .S SRA=$G(^SRF(SRTN,208)) F I=14:1:17 S SRP(I-8)=$E($P(SRA,"^",I),1,12)
 .S SRA=$G(^SRF(SRTN,.2)) S SRP(10)=$P(SRA,"^",12),SRP(11)=$P(SRA,"^")
 .S SRP(12)=$P($G(^SRF(SRTN,1.1)),"^",8),SRA=$G(^SRF(SRTN,208.1)),J=0 F I=13:1:15 S J=J+1,SRP(I)=$P(SRA,"^",J)
 .S SRP(16)=$P($G(^SRF(SRTN,"CON")),"^")
 .S SRTMP=SRP(1) F I=2:1:16 S SRTMP=SRTMP_"^"_SRP(I)
 .S SRI=SRI+1,^TMP("SRA",$J,SRI)=SRTMP
 N SRD S SRD=^XMB("NETNAME") I $E(SRD,1,3)="ISC"!(SRD["ISC-")!(SRD["ISC.")!(SRD["FORUM")!(SRD["TST.")!(SRD["TEST")!(SRD["UTL.")!(SRD["TRN.") G RAMG
 S XMSUB="** SR*3*81 FROM VAMC-"_SITE_" **",XMDUZ=$S($D(DUZ):DUZ,1:.5)
 S XMY("G.SRCOSERV@ISC-CHICAGO.VA.GOV")=""
 S XMTEXT="^TMP(""SRA"",$J," N I D ^XMD
RAMG ; send list of assessments changed to incomplete
 G:SRAINC=0 END K XMTEXT,XMSUB,XMDUZ
 S ^TMP("SRAINC",$J,.1)="The following completed/transmitted non-cardiac assessments have been",^TMP("SRAINC",$J,.2)="updated to incomplete.  Please review patient demographic information and"
 S ^TMP("SRAINC",$J,.3)="complete these assessments again.",^TMP("SRAINC",$J,.4)=""
 S XMSUB="ASSESSMENTS CHANGED TO INCOMPLETE",XMDUZ=$S($D(DUZ):DUZ,1:.5)
 S XMY("G.RISK ASSESSMENT")=""
 S XMTEXT="^TMP(""SRAINC"",$J," N I D ^XMD
END K ^TMP("SRA",$J),^TMP("SRAINC",$J) S ZTREQ="@"
 Q
OBS ; check for admission for observation following surgery
 S SRSOUT=0,(VAIP("D"),SRSDATE)=SRP(5) D IN5^VADPT I VAIP(13) Q
 S X1=$P($G(^SRF(SRTN,.2)),"^",12),X2=1 D C^%DTC S SR24=X,SRDT=$O(^DGPM("APTT1",DFN,SRP(5))) Q:'SRDT!(SRDT>SR24)  S VAIP("D")=SRDT D IN5^VADPT I 'VAIP(13) Q
 S SRX=$P(VAIP(13,6),"^") D SPEC S Y="18,23,24,36,41,65,94" I Y[SRSP S SRSOUT=1
 Q
NA F I=1:1:3 S $P(^SRF(SRTN,208.1),"^",I)="NA"
 Q
SPEC K DA,DIC,DIQ,DR,SRY S DIC=45.7,DR=1,DA=SRX,DIQ="SRY",DIQ(0)="I" D EN^DIQ1 S SRSP=SRY(45.7,SRX,1,"I") I SRSP,$L(SRSP)=1 S SRSP="0"_SRSP
 Q
INC ; make completed/transmitted assessment incomplete
 K DA,DIE,DR S DIE=130,DA=SRTN,DR="235////I;393////"_$S(SR235="T":1,1:"") D ^DIE K DA,DIE,DR
 I SR235="C"&($P(^SRF(SRTN,"RA"),"^",3)'="1") S DIE=130,DA=SRTN,DR="272///@" D ^DIE K DA,DIE,DR
 S X=SRP(5),SRADT=$E(X,4,5)_"/"_$E(X,6,7)_"/"_$E(X,2,3)
 S SRAINC=SRAINC+1,^TMP("SRAINC",$J,SRAINC)="ASSESSMENT: "_SRTN_"   "_$J(VADM(1),20)_"   OPERATION DATE: "_SRADT
 Q
POST ; post-install action for SR*3*81
 ; task retransmission message
 D NOW^%DTC S ZTDTH=$E(%,1,12),ZTRTN="EN1^SR81UTL",ZTDESC="Surgery Risk Assessment Retransmission",ZTIO="" D ^%ZTLOAD
 Q
