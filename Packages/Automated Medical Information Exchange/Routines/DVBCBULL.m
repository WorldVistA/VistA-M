DVBCBULL ;ALB/GTS - 557/THM-SEND CANCELLATION BULLETIN ; 6/25/91  11:01 AM
 ;;2.7;AMIE;**42,184,189**;Apr 10, 1995;Build 22
 ;
 N MSG1,MERR1,CNT1,MSG2,MERR2,CNT2,RIEN
 K ^TMP("DVBC","BULL",$J),^TMP("DVBC","CMNT",$J) S DIC="^TMP(""DVBC"",""CMNT"",$J,99,",DWPK=1 W @IOF,!!,"Cancellation comments:",!! D EN^DIWE
 K DWPK I $O(^TMP("DVBC","CMNT",$J,99,0))]"" S ^TMP("DVBC","BULL",$J,98,0)=" ",^TMP("DVBC","BULL",$J,97,0)="==========================<  Additional comments  >=========================="
 F I=0:0 S I=$O(^TMP("DVBC","CMNT",$J,99,I)) Q:I=""  S ^TMP("DVBC","BULL",$J,(I+99),0)=^TMP("DVBC","CMNT",$J,99,I,0)
 K ^TMP("DVBC","CMNT",$J) S $P(DOTS,".",45)="." W !!,"A bulletin will now be sent to the 2507 Cancellation mail group.",!
 ;
 ;Build Claim Type Info
 S RIEN=DA
 K ^TMP($J,"DVBCBULL","CT")
 N MSG1,MERR1,CTR1
 S (MSG1,MERR1)="",CTR1=1
 D GETS^DIQ(396.3,RIEN_",","9.1*","E","MSG1","MERR1")
 I $G(MERR1)'="" S ^TMP($J,"DVBCBULL","CT",CTR1)="ERROR GETTING CLAIM TYPE CODES"
 S J=""
 F  S J=$O(MSG1(396.32,J)) Q:J=""  D
 . S CTR1=CTR1+1
 . S ^TMP($J,"DVBCBULL","CT",CTR1)=$G(MSG1(396.32,J,.01,"E"))
 ;
 ;Build Special Considerations Info
 K ^TMP($J,"DVBCBULL","SC")
 N MSG2,MERR2,CTR2
 S (MSG2,MERR2)="",CTR2=1
 D GETS^DIQ(396.3,RIEN,"50*","IE","MSG2","MERR2")
 I $G(MERR2)'="" S ^TMP($J,"DVBCBULL","SC",CTR2)="ERROR GETTING SPECIAL CONSIDERATION CODES"
 S J=""
 F  S J=$O(MSG2(396.31,J)) Q:J=""  D
 . S CTR2=CTR2+1
 . S ^TMP($J,"DVBCBULL","SC",CTR2)=$G(MSG2(396.31,J,.01,"E"))
 ;
GO S L=1,^TMP("DVBC","BULL",$J,L,0)="The following veteran had one or more 2507 exams cancelled:",L=L+1
 S ^TMP("DVBC","BULL",$J,L,0)="   ",L=L+1
 S ^TMP("DVBC","BULL",$J,L,0)="  DFN: `"_DFN_$E("                    ",1,20-$L(DFN))_"SITE: "_DVBCSITE,L=L+1
 S ^TMP("DVBC","BULL",$J,L,0)="  REQUEST DATE: "_DVBCRDAT,L=L+1
 S ^TMP("DVBC","BULL",$J,L,0)="  ",L=L+1
 S ^TMP("DVBC","BULL",$J,L,0)="  Claim Type:",L=L+1
 F  S J=$O(^TMP($J,"DVBCBULL","CT",J)) Q:J=""  D
 . S ^TMP("DVBC","BULL",$J,L,0)="    "_^TMP($J,"DVBCBULL","CT",J),L=L+1
 S ^TMP("DVBC","BULL",$J,L,0)=" ",L=L+1
 S ^TMP("DVBC","BULL",$J,L,0)="  Special Consideration(s):",L=L+1
 S J=""
 F  S J=$O(^TMP($J,"DVBCBULL","SC",J)) Q:J=""  D
 . S ^TMP("DVBC","BULL",$J,L,0)="    "_^TMP($J,"DVBCBULL","SC",J),L=L+1
 S ^TMP("DVBC","BULL",$J,L,0)=" ",L=L+1
 S ^TMP("DVBC","BULL",$J,L,0)="Exams cancelled                               Reason",L=L+1
 S ^TMP("DVBC","BULL",$J,L,0)="  ",L=L+1
 S EXAM="",RSTAT=$P(^DVB(396.3,REQDA,0),U,18)
 F JI=0:0 S EXAM=$O(CANC(EXAM)) Q:EXAM=""  I $P(CANC(EXAM),U,1)="X"!($P(CANC(EXAM),U,1)="RX") S REAS=+$P(CANC(EXAM),U,2) D EXAMS
 S ^TMP("DVBC","BULL",$J,L,0)=" ",L=L+1,COMP=1,CMPC=0
 ;
 S ^TMP("DVBC","BULL",$J,L,0)="  ",L=L+1
 S ^TMP("DVBC","BULL",$J,L,0)="** NOTE: To view the patient using the DFN, paste the DFN number into the    **",L=L+1
 S ^TMP("DVBC","BULL",$J,L,0)="** CAPRI Patient Selector 'Patient ID' field to find the patient. Be sure to **",L=L+1
 S ^TMP("DVBC","BULL",$J,L,0)="** include the ' (backward-apostrophe) character.                            **",L=L+1
 S ^TMP("DVBC","BULL",$J,L,0)="  ",L=L+1
 ;
 K ^TMP("DVBC","CMNT",$J)
 I RSTAT["X" S ^TMP("DVBC","BULL",$J,L,0)=" *** All exams on this request are now CANCELLED. ***",L=L+1,^TMP("DVBC","BULL",$J,L,0)=" ",L=L+1
 S ^TMP("DVBC","BULL",$J,L,0)="** This is an auto-generated email.  Do not respond to this email address.   **",L=L+1
 G SEND
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
 K ^TMP($J,"DVBCBULL","CT"),^TMP($J,"DVBCBULL","SC")
 Q
 ;
EXAMS S REASON=$S($D(^DVB(396.5,+REAS,0)):$P(^(0),U,1),1:"Undetermined")
 S XEXAM=$E(EXAM,1,25),^TMP("DVBC","BULL",$J,L,0)="     "_XEXAM_" "_$E(DOTS,1,35-$L(XEXAM))_" "_REASON S L=L+1
 Q
