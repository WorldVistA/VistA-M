DVBCIUT1 ;ALB/GTS-AMIE INSUFFICIENT UTILITY RTN 1 ; 11/14/94  3:00 PM
 ;;2.7;AMIE;**13**;Apr 10, 1995
 ;
 ;** Version Changes
 ;   2.7 - New routine (Enhc 15)
 ;
INREAS ;** Select Insufficient Reasons
 N YSAVE
 S YSAVE=Y
 I YSAVE=-1 DO
 .S DIR(0)="YA"
 .S DIR("?",1)=" "
 .S DIR("?",2)="  Enter 'No' to print only those reasons previously"
 .S DIR("?",3)="   selected, 'Yes' to select all reasons existing"
 .S DIR("?")="   on currently entered exams."
 .S DIR("A",1)=" "
 .S DIR("A",2)=" You have selected to report all insufficient reasons."
 .S DIR("A")=" Is this correct? "
 .D ^DIR
 .I Y'=0,('$D(DUOUT)&('$D(DTOUT))) DO
 ..N DVBAXIFN
 ..F DVBAXIFN=0:0 S DVBAXIFN=$O(^DVB(396.94,DVBAXIFN)) Q:+DVBAXIFN=0  DO
 ...S DVBAARY("REASON",DVBAXIFN)=""
 .S Y=-1
 I +YSAVE>0 S DVBAARY("REASON",+YSAVE)=""
 S Y=YSAVE
 K DTOUT,DUOUT,DIR
 Q
 ;
EXMTPE ;** Select the exams to Report
 N YSAVE
 S YSAVE=Y
 I YSAVE=-1 DO
 .S DIR(0)="YA"
 .S DIR("?",1)=" "
 .S DIR("?",2)="  Enter 'No' to print only those exams previously"
 .S DIR("?")="   selected, 'Yes' to select all exams"
 .S DIR("A",1)=" "
 .S DIR("A",2)=" You have selected to report all AMIE exams."
 .S DIR("A")=" Is this correct? "
 .D ^DIR
 .I Y'=0,('$D(DUOUT)&('$D(DTOUT))) DO
 ..N DVBAXIFN
 ..F DVBAXIFN=0:0 S DVBAXIFN=$O(^DVB(396.6,DVBAXIFN)) Q:+DVBAXIFN=0  DO
 ...S ^TMP($J,"XMTYPE",DVBAXIFN)=""
 ...;removed inactive screen
 .S Y=-1
 I +YSAVE>0 S ^TMP($J,"XMTYPE",+YSAVE)=""
 S Y=YSAVE
 K DTOUT,DUOUT,DIR
 Q
