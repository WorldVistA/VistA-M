DVBCBULL ;ALB/GTS-557/THM-SEND CANCELLATION BULLETIN ; 6/25/91  11:01 AM
 ;;2.7;AMIE;**42**;Apr 10, 1995
 ;
 K ^TMP("DVBC","BULL",$J),^TMP("DVBC","CMNT",$J) S DIC="^TMP(""DVBC"",""CMNT"",$J,99,",DWPK=1 W @IOF,!!,"Cancellation comments:",!! D EN^DIWE
 K DWPK I $O(^TMP("DVBC","CMNT",$J,99,0))]"" S ^TMP("DVBC","BULL",$J,98,0)=" ",^TMP("DVBC","BULL",$J,97,0)="==========================<  Additional comments  >=========================="
 F I=0:0 S I=$O(^TMP("DVBC","CMNT",$J,99,I)) Q:I=""  S ^TMP("DVBC","BULL",$J,(I+99),0)=^TMP("DVBC","CMNT",$J,99,I,0)
 K ^TMP("DVBC","CMNT",$J) S $P(DOTS,".",45)="." W !!,"A bulletin will now be sent to the 2507 Cancellation mail group.",!
 ;
GO S L=1,^TMP("DVBC","BULL",$J,L,0)="The following veteran had one or more 2507 exams cancelled:",L=L+1
 S ^TMP("DVBC","BULL",$J,L,0)="   ",L=L+1
 S ^TMP("DVBC","BULL",$J,L,0)="   Name: "_PNAM_"   SSN: "_"XXXXX"_$E(SSN,6,9)_"   "_"C-Number: "_CNUM,L=L+1
 S ^TMP("DVBC","BULL",$J,L,0)="  ",L=L+1
 S ^TMP("DVBC","BULL",$J,L,0)="Exams cancelled                               Reason",L=L+1
 S ^TMP("DVBC","BULL",$J,L,0)="  ",L=L+1
 S EXAM="",RSTAT=$P(^DVB(396.3,REQDA,0),U,18)
 F JI=0:0 S EXAM=$O(CANC(EXAM)) Q:EXAM=""  I $P(CANC(EXAM),U,1)="X"!($P(CANC(EXAM),U,1)="RX") S REAS=+$P(CANC(EXAM),U,2) D EXAMS
 S ^TMP("DVBC","BULL",$J,L,0)=" ",L=L+1,COMP=1,CMPC=0
 S ^TMP("DVBC","BULL",$J,L,0)=" ",L=L+1 K ^TMP("DVBC","CMNT",$J)
 I RSTAT["X" S ^TMP("DVBC","BULL",$J,L,0)=" *** All exams on this request are now CANCELLED. ***",L=L+1,^TMP("DVBC","BULL",$J,L,0)=" ",L=L+1 G SEND
 S ECNT=0
 F JZ=0:0 S JZ=$O(^DVB(396.4,"C",REQDA,JZ)) Q:JZ=""  S STAT=$P(^DVB(396.4,JZ,0),U,4) S:STAT="C" CMPC=1 I STAT'="C"&(STAT'["X") S COMP=0,ECNT=ECNT+1
 ;CMPC=completed exam COMP=open exam
 ;both are toggled, depending on exam status.  Both must be 1 to put release banner on message
 I RSTAT'["X",COMP=0 S ^TMP("DVBC","BULL",$J,L,0)=" *** There "_$S(ECNT=1:"is",1:"are")_" still "_ECNT_" exam"_$S(ECNT=1:"",1:"s")_" open on this request. ***",L=L+1,^TMP("DVBC","BULL",$J,L,0)=" ",L=L+1 G SEND
 I COMP=1&(CMPC=1),RSTAT'["X" S ^TMP("DVBC","BULL",$J,L,0)=" *** This request is now COMPLETE and should be released by MAS ***",L=L+1
 I COMP=1&(CMPC=1),RSTAT'["X" S ^TMP("DVBC","BULL",$J,L,0)=" ",L=L+1 ;spacer
 ;
SEND ;remote sites get bulletins only on total cancellations
 S DIC="^XMB(3.8,",DIC(0)="QM",X="DVBA C 2507 CANCELLATION" D ^DIC S MG=+Y I +Y<0 W !!,*7,"2507 mail group NOT found!  Bulletin not sent.",!! H 3 Q
 F JI=0:0 S JI=$O(^XMB(3.8,MG,1,"B",JI)) Q:JI=""  S XMY(JI)=""
 F JI=0:0 S JI=$O(XMY(JI)) Q:JI=""!(+JI=0)  I '$D(^VA(200,JI,2,+REQRO))&'$D(^VA(200,JI,2,+REQRO))&('$D(^XUSEC("DVBA C SUPERVISOR",JI))) K XMY(JI)
 S:REQSTR="" REQSTR=.5 S XMY(REQSTR)="",XMY(DUZ)="",XMSUB="Cancellation of 2507 Exams",XMTEXT="^TMP(""DVBC"",""BULL"",$J,",XMDUZ=DUZ
 I '$D(^VA(200,DUZ,.15)) S XMY(XMDUZ)="" G XMD
 I $D(^VA(200,DUZ,.15))&($P(^VA(200,DUZ,.15),"^",1)="") S XMY(XMDUZ)="" G XMD
 I $D(^VA(200,DUZ,.15)) S XMY($P(^VA(200,DUZ,.15),"^",1))=""
XMD D ^XMD
 K ^TMP("DVBC","BULL",$J),XMDUZ,DOTS,COMP,CMPC,XEXAM,REASON,L,JI,JY,XMY,XMSUB,XMTEXT,XMDUZ,ECNT
 Q
 ;
EXAMS S REASON=$S($D(^DVB(396.5,+REAS,0)):$P(^(0),U,1),1:"Undetermined")
 S XEXAM=$E(EXAM,1,25),^TMP("DVBC","BULL",$J,L,0)="     "_XEXAM_" "_$E(DOTS,1,35-$L(XEXAM))_" "_REASON S L=L+1
 Q
