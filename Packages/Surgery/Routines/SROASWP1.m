SROASWP1 ;B'HAM ISC/MAM - MOVE RISK TO FILE 130 ; 13 APR 1992  3:35 pm
 ;;3.0; Surgery ;;24 Jun 93
 S ^TMP("CONVERT","NO MATCH",1)="The following entries in the SURGERY RISK ASSESSMENT file (139) cannot be",^TMP("CONVERT","NO MATCH",2)="converted because the patient has no surgical cases entered in the SURGERY"
 S ^TMP("CONVERT","NO MATCH",3)="file (130).",^TMP("CONVERT","NO MATCH",4)="  ",SRCNT=4
 W !!,"Deleting all Assessments in which the patient entered has no Surgery cases",!,"on file" S SRAN=0 F  S SRAN=$O(^SRA(SRAN)) Q:'SRAN  S DFN=$P(^SRA(SRAN,0),"^") I '$O(^SRF("B",DFN,0)) W "." D MSGLINE,DELETE
 I $D(^TMP("CONVERT","NO MATCH",5)) D SENDMSG
 I '$O(^SRA(0)) Q
 Q
DELETE ; delete assessment from 139
 S DA=SRAN,DIK="^SRA(" D ^DIK Q
 Q
MSGLINE ; store info for mail message
 S SRA(0)=^SRA(SRAN,0),DFN=$P(SRA(0),"^") D DEM^VADPT S SRANAME=VADM(1)_" ("_VA("PID")_")",DATE=$P(SRA(0),"^",5),DATE=$E(DATE,4,5)_"/"_$E(DATE,6,7)_"/"_$E(DATE,2,3)
 S SRCNT=SRCNT+1,^TMP("CONVERT","NO MATCH",SRCNT)=SRANAME_"    DATE OF OPERATION: "_DATE
 Q
SENDMSG ; send mail message
 S XMY("G.RISK ASSESSMENT@"_^XMB("NETNAME"))=""
 S XMSUB="RISK ASSESSMENT ENTRIES NOT CONVERTED, NO MATCHES",XMDUZ="RISK ASSESSMENT CONVERSION",XMTEXT="^TMP(""CONVERT"",""NO MATCH"","
 N I D ^XMD K XMSUB,XMDUZ,XMTEXT,XMY
 Q
