SROASWP0 ;B'HAM ISC/MAM - DELETE NO ASSESSMENTS ; 22 APR 1992  12:00 pm
 ;;3.0; Surgery ;;24 Jun 93
 I '$O(^SRA(0)) D DESTROY Q
 W !!,"Risk Assessment Pre-Conversion: "
 W !!,"Deleting all entries from the SURGERY RISK ASSESSMENT file (139) which do not",!,"contain assessment information or have an operation date prior to the ",!,"selected start date."
 K ^TMP("CONVERT") S ^TMP("CONVERT","NO ASSESS",1)="Entries in the SURGERY RISK ASSESSMENT file (139) which were deleted"
 S ^TMP("CONVERT","NO ASSESS",2)="because they contained no assessment information, or had an operation date",^TMP("CONVERT","NO ASSESS",3)="prior to the selected start date."
 S ^TMP("CONVERT","NO ASSESS",4)=" "
 S SRCNT=4,SRAN=0 F  S SRAN=$O(^SRA(SRAN)) Q:'SRAN  S SRA("S")=$G(^SRA(SRAN,"S")),SRTYPE=$P(SRA("S"),"^",2),STATUS=$P(SRA("S"),"^",6) I STATUS'="Y",SRTYPE="N" W "." D MSGLINE,DELETE
 S SRCNT=4,SRAN=0 F  S SRAN=$O(^SRA(SRAN)) Q:'SRAN  D CHECK I SRADEL W "." D MSGLINE,DELETE
 I $D(^TMP("CONVERT","NO ASSESS",5)) D SENDMSG
 K ^TMP("CONVERT") D ^SROASWP1
 Q
CHECK ; determine if assessment should be deleted
 S SRADEL=0 I $P(^SRA(SRAN,0),"^",5)<SRDATE S SRADEL=1 Q
 S SRA("S")=$G(^SRA(SRAN,"S")),SRTYPE=$P(SRA("S"),"^",2),STATUS=$P(SRA("S"),"^",6) I STATUS'="Y",SRTYPE="N" S SRADEL=1
 Q
DELETE ; delete assessment from 139
 S DA=SRAN,DIK="^SRA(" D ^DIK Q
 Q
MSGLINE ; store info for mail message
 S SRA(0)=^SRA(SRAN,0),DFN=$P(SRA(0),"^") D DEM^VADPT S SRANAME=VADM(1)_" ("_VA("PID")_")",DATE=$P(SRA(0),"^",5),DATE=$E(DATE,4,5)_"/"_$E(DATE,6,7)_"/"_$E(DATE,2,3)
 S SRCNT=SRCNT+1,^TMP("CONVERT","NO ASSESS",SRCNT)=SRANAME_"    DATE OF OPERATION: "_DATE
 Q
SENDMSG ; send mail message
 S XMY("G.RISK ASSESSMENT@"_^XMB("NETNAME"))=""
 S XMSUB="RISK ASSESSMENT ENTRIES NOT CONVERTED, NO ASSESSMENT INFORMATION",XMDUZ="RISK ASSESSMENT CONVERSION",XMTEXT="^TMP(""CONVERT"",""NO ASSESS"","
 N I D ^XMD K XMSUB,XMDUZ,XMTEXT,XMY
 Q
DESTROY ; destroy SROA CONVERT option
 S SRCONV=$O(^DIC(19,"B","SROA CONVERT",0)) I 'SRCONV Q
 K DA,DIK S DA=SRCONV,DIK="^DIC(19," D ^DIK
 Q
