SROASWP2 ;B'HAM ISC/MAM - MOVE RISK TO FILE 130 ; 13 APR 1992  3:35 pm
 ;;3.0; Surgery ;;24 Jun 93
 S Y=SRDATE D D^DIQ S SRDT=Y
 W !!,"Automatically matching Risk Assessment entries with Surgery Cases"
 K ^TMP("CONVERT") S ^TMP("CONVERT","MATCH",1)="The following assessments were matched with entries in the SURGERY file (130)",^TMP("CONVERT","MATCH",2)="based on the patient identifier and date of operation."
 S ^TMP("CONVERT","MATCH",3)="   ",SRCNT=3
 S SRAN=0 F  S SRAN=$O(^SRA(SRAN)) Q:'SRAN  S SRA(0)=^SRA(SRAN,0),DFN=$P(SRA(0),"^"),SRSDATE=$E($P(SRA(0),"^",5),1,7) D CHECK I OK D CONVERT,DELETE
 I $D(^TMP("CONVERT","MATCH",4)) D SENDMSG
 I '$O(^SRA(0)) Q
 S (CNT,X)=0 F  S X=$O(^SRA(X)) Q:'X  S CNT=CNT+1
MANUAL W !!,"There "_$S(CNT=1:"is ",1:"are ")_CNT_" assessment"_$S(CNT=1:"",1:"s")_" remaining."
 W !!,"Do you want to continue with the manual matching process now ? YES//  " R SRYN:DTIME I '$T!(SRYN["^") S SRSOUT=1 Q
 S SRYN=$E(SRYN) I "YyNn"'[SRYN D HELP Q:SRSOUT  G MANUAL
 I "Yy"'[SRYN S SRSOUT=1 Q
 S SRAN=0 F  S SRAN=$O(^SRA(SRAN)) Q:'SRAN!(SRSOUT)  S OK=0 D ^SROASWP3 I OK D CONVERT,DELETE
 Q
CONVERT S SRDD=8 F  S SRDD=$O(^DD(139,SRDD)) Q:'SRDD  D MOVE
 S SRCD=$P(^SRA(SRAN,0),"^",9)
 S A=^SRA(SRAN,"S"),SRSTATUS=$P(A,"^"),SRTYPE=$P(A,"^",2) K A S DR="284////"_SRTYPE_";Q;235////"_SRSTATUS_";272////"_SRCD_";323////Y",DA=SRTN,DIE=130 D ^DIE
 D ^SROCCAT
 K SRDD,X,Y,Z
 D MSGLINE
 Q
MOVE ; move data from file 139 to file 130
 I SRDD=11!(SRDD=12)!(SRDD=17)!(SRDD=23)!(SRDD=24)!(SRDD=44)!(SRDD=78)!(SRDD=136) Q
 I SRDD=95!(SRDD=153)!(SRDD=185)!(SRDD=182)!(SRDD=192)!(SRDD=219)!(SRDD=216) Q
 I SRDD=289!(SRDD=290)!(SRDD=291)!(SRDD=292)!(SRDD=293)!(SRDD=294) Q
 I SRDD=295!(SRDD=75)!(SRDD=125)!(SRDD=99)!(SRDD=80)!(SRDD=74)!(SRDD=149) Q
 S GLOBAL=$P(^DD(139,SRDD,0),"^",4),P1=$P(GLOBAL,";"),P2=$P(GLOBAL,";",2),DATA=$P($G(^SRA(SRAN,P1)),"^",P2)
 S ^TMP("CONVERT",SRAN,SRTN)="MATCHED"
 I SRDD=216 S SRFIELD=$P($G(^SRA(SRAN,2)),"^",22) I SRFIELD'="" S DA=SRTN,DIE=130,DR=".25////"_SRFIELD D ^DIE K DA,DR,DIE Q
 S X=$P(^DD(139,SRDD,0),"^"),SRFIELD=$O(^DD(130,"B",X,0)) ; I SRFIELD W !!,SRDD_"  ",X,?45,SRFIELD,?50,DATA
 S GLOBAL=$P(^DD(130,SRFIELD,0),"^",4),P1=$P(GLOBAL,";"),P2=$P(GLOBAL,";",2),$P(^SRF(SRTN,P1),"^",P2)=DATA
 Q
CHECK ; check for match
 K CASE S (OK,SRTN,CNT)=0 F  S SRTN=$O(^SRF("B",DFN,SRTN)) Q:'SRTN  S DATE=$E($P(^SRF(SRTN,0),"^",9),1,7) I DATE=SRSDATE S CNT=CNT+1,CASE(CNT)=SRTN
 K SRTN I '$D(CASE(1)) Q
 I $D(CASE(2)) Q
 S OK=1,SRTN=CASE(1) W "."
 Q
DELETE ; delete assessment from 139
 S DA=SRAN,DIK="^SRA(" D ^DIK Q
 Q
MSGLINE ; store info for mail message
 S SRA(0)=^SRA(SRAN,0),DFN=$P(SRA(0),"^") D DEM^VADPT S SRANAME=VADM(1)_" ("_VA("PID")_")",DATE=$P(SRA(0),"^",5),DATE=$E(DATE,4,5)_"/"_$E(DATE,6,7)_"/"_$E(DATE,2,3)
 S SRCNT=SRCNT+1,^TMP("CONVERT","MATCH",SRCNT)=SRANAME_"    DATE OF OPERATION: "_DATE,SRCNT=SRCNT+1,^TMP("CONVERT","MATCH",SRCNT)="SURGERY CASE NUMBER: "_SRTN,SRCNT=SRCNT+1,^TMP("CONVERT","MATCH",SRCNT)="  "
 Q
SENDMSG ; send mail message
 S XMY("G.RISK ASSESSMENT@"_^XMB("NETNAME"))=""
 S XMSUB="SURGERY RISK ASSESSMENT ENTRIES AUTOMATICALLY CONVERTED",XMDUZ="RISK ASSESSMENT CONVERSION",XMTEXT="^TMP(""CONVERT"",""MATCH"","
 N I D ^XMD K XMSUB,XMDUZ,XMTEXT,XMY
 Q
HELP W !!,"Enter 'YES' if you want to continue converting assessments manually, or 'NO'",!,"to quit this option.",!
 K DIR S DIR(0)="E" D ^DIR I 'Y S SRSOUT=1
 Q
