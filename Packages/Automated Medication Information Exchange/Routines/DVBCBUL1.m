DVBCBUL1 ;ALB/GTS-557/THM-SEND EXAM ADD MESSAGE ; 2/7/91  6:56 AM
 ;;2.7;AMIE;**42**;Apr 10, 1995
 K ^TMP("DVBC","BUL1",$J),^TMP("DVBC","CMNT",$J) S DIC="^TMP(""DVBC"",""CMNT"",$J,99,",DWPK=1 W @IOF,!!,"Comments:",!! D EN^DIWE
 K DWPK I $O(^TMP("DVBC","CMNT",$J,99,0))]"" S ^TMP("DVBC","BUL1",$J,98,0)=" ",^TMP("DVBC","BUL1",$J,97,0)="==========================<  Additional comments  >=========================="
 F I=0:0 S I=$O(^TMP("DVBC","CMNT",$J,99,I)) Q:I=""  S ^TMP("DVBC","BUL1",$J,(I+99),0)=^TMP("DVBC","CMNT",$J,99,I,0)
 K ^TMP("DVBC","CMNT",$J) S $P(DOTS,".",45)="."
 ;
GO S L=1,^TMP("DVBC","BUL1",$J,L,0)="The following veteran had one or more 2507 exams added:",L=L+1
 S ^TMP("DVBC","BUL1",$J,L,0)="   ",L=L+1
 S ^TMP("DVBC","BUL1",$J,L,0)="   Name: "_PNAM_"   SSN: "_"XXXXX"_$E(SSN,6,9)_"   "_"C-Number: "_CNUM,L=L+1
 S ^TMP("DVBC","BUL1",$J,L,0)=" "
 S Y=$P(^DVB(396.3,REQDA,0),U,2) X ^DD("DD") S ^TMP("DVBC","BUL1",$J,L,0)="     Request date: "_Y,L=L+1
 S ^TMP("DVBC","BUL1",$J,L,0)="  ",L=L+1
 S ^TMP("DVBC","BUL1",$J,L,0)="Note:  Scheduling for this request must now be recompleted.",L=L+1,^TMP("DVBC","BUL1",$J,L,0)="       A new request copy will be printed tomorrow morning.",L=L+1
 S ^TMP("DVBC","BUL1",$J,L,0)=" ",L=L+1
 ;
SEND S $P(^DVB(396.3,REQDA,0),U,6)="" ;reset date sched completed
 S MG=$O(^XMB(3.8,"B","DVBA C EXAM ADDED",0)) I MG="" W !!,*7,"Bulletin not sent.",!,"DVBA C EXAM ADDED mail group not found.",!! H 3 Q
 F JI=0:0 S JI=$O(^XMB(3.8,MG,1,"B",JI)) Q:JI=""  S XMY(JI)=""
 S XMY(DUZ)="",XMSUB="Addition of 2507 Exams",XMTEXT="^TMP(""DVBC"",""BUL1"",$J,",XMDUZ=DUZ
 I '$D(^VA(200,DUZ,.15)) S XMY(XMDUZ)="" G XMD
 I $D(^VA(200,DUZ,.15))&($P(^VA(200,DUZ,.15),"^",1)="") S XMY(XMDUZ)="" G XMD
 I $D(^VA(200,DUZ,.15)) S XMY($P(^VA(200,DUZ,.15),"^",1))=""
XMD D ^XMD K ^TMP("DVBC","BUL1",$J),XMDUZ,DOTS,L,JI,JY,XMY,XMSUB,XMTEXT
 Q
