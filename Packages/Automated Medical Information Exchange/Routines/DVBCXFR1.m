DVBCXFR1 ;AJF/ReRoute C&P Request ; 7/18/16  2:14 PM
 ;;2.7;AMIE;**193**;;Build 84
 ;
 ;
 Q
EN(RTN,REQDA,PIEN,SNUM,RDIV,RR,RD) ;Call from CAPRI
 ; RPC: DVBA CAPRI SEND REROUTE
 ;
 ;ReRoute C&P 2507 Request
 ;  RTN = Return value
 ;  REQDA = 2507 Request IEN
 ;  SNUM = CAPRI Reroute IEN
 ;  PIEN = Patient IEN
 ;  RDIV = Division IEN
 ;  RR = Reroute Reason
 ;  RD = Reroute Description
 ;
 I $G(REQDA)="" S RTN="0^Missing request number number" Q
 I $G(SNUM)="" S RTN="0^Missing CAPRI Reroute Site number" Q
 I $G(PIEN)="" S RTN="0^Missing Patient IEN" Q
 I $G(RDIV)="" S RTN="0^Missing Routing Location" Q
 I $G(RR)="" S RTN="0^Missing Reroute Reason" Q
 I '$D(^DVB(396.3,REQDA,0)) S RTN="0^Not a valad request number" Q
 I '$D(^DVB(396.195,SNUM)) S RTN="0^Not a valid CAPRI Reroute Site IEN" Q
 ;
 N R0,DFN,DIEN,DOMNAM,DOMNUM,DOMNUM1,EXAMS,EXMNM,EXR,JJ,PNAM,INAM
 N SSN,XMCNT,XMVAR
 S R0=^DVB(396.3,REQDA,0)
 K DVBAINSF
 I $P(R0,U,18)>2 S RTN="0^This request does not have a NEW or PENDING status and may not be rerouted." Q
 ;I $P(R0,U,18)'=1,($P(R0,U,18)'=2),($P(R0,U,18)'=12) S RTN="0^This request does not have a NEW or PENDING status and may not be rerouted." Q
 ;I $P(R0,U,22)]"" S RTN="0^This request was transferred in and CANNOT be transferred to any other site " Q
 ;
 S DFN=$P(R0,U,1)
 I DFN'=PIEN S RTN="0^Patient IEN passed in does match 2507 Request" Q
 S PNAM=$P(^DPT(DFN,0),U,1),SSN=$P(^(0),U,9)
 S:$P(R0,U,10)="E" DVBAINSF=""
 S DOMNAM=$P(^DVB(396.195,SNUM,0),"^",3)
 S DIEN=$O(^DIC(4.2,"B",DOMNAM,""))
 I DIEN="" S RTN="0^Domain Name not found in Domain File. Please contact IRM for assistance." Q
 S STN=$P(^DIC(4.2,DIEN,0),"^",13)
 I STN="" S RTN="0^Station Number not found in Domain File. Please contact IRM for assistance." Q
 S INUM=$O(^DIC(4,"D",STN,0))
 I INUM'="" S TSITE=$P($G(^DIC(4,INUM,0)),"^",1)
 S:INUM="" INUM=STN
 S DOMNUM=$S($P(^DIC(4.2,DIEN,0),U,3)]"":$P(^(0),U,3),1:DIEN)
 S INAM=$S($D(TSITE):TSITE,1:$P(^DIC(4.2,DIEN,0),U,1))
 S DOMNUM1=DIEN
 ;
 I $L($G(RD))>250 S RD=$E(RD,1,250)
 ;I $D(CORR) G DISPLAY
 ;
 ;EXAMS K XEXAMS W @FF,!,"Exam selection",!!!! S EXAMS="",XMCNT=0
 ;F LPCNT=0:0 S LPCNT=$O(XMVAR(LPCNT)) Q:LPCNT=""  K XMVAR(LPCNT)
 ;W !!,"Do you want to transfer ALL exams" S %=2 D YN^DICN G:%<0 EXIT
 ;I %=2 W !! G PART
 ;I %=0 W !!,"Enter Y if you want to transfer all exams or N if not.",!! D CONTMES^DVBCUTL4 G EXAMS
 ;W !!! 
 K XEXAMS S EXAMS="",XMCNT=0
 F JJ=0:0 S JJ=$O(^DVB(396.4,"C",REQDA,JJ)) Q:JJ=""  D SET
 ;
 D INREAS^DVBCXUTL
MAILMAN D ^DVBCXFR2
 ;
 Q
 ;
SET ;** EXAMS - Xfr all
 S EXMNM=$P(^DVB(396.6,$P(^DVB(396.4,JJ,0),U,3),0),U,1)
 I $P(^DVB(396.4,JJ,0),U,4)["X" S EXR(JJ)=EXMNM_" is CANCELED and cannot be transferred." Q
 I $P(^DVB(396.4,JJ,0),U,4)="C" S EXR(JJ)=EXMNM_" is COMPLETED and cannot be transferred." Q
 I $P(^DVB(396.4,JJ,0),U,4)="T" S EXR(JJ)=EXMNM_" has been TRANSFERRED and cannot be selected." Q
 ;W !,EXMNM," is OK to transfer.",!!
 S EXAMS=EXAMS_$P(^DVB(396.4,JJ,0),U,3)_U,XEXAMS(JJ)="",XMCNT=XMCNT+1
 ;
 ;** Set XMVAR(XMCNT)=$EXAM AMIE EXAM IFN^INSUFF REASON IFN
 S XMVAR(XMCNT)="$EXAM "_$P(^DVB(396.4,JJ,0),U,3)_U_$S(+$P(^DVB(396.4,JJ,0),U,11)>0:$P(^DVB(396.94,$P(^DVB(396.4,JJ,0),U,11),0),U,1),1:"")
 ;EXAMS for MailMan msg, XEXAMS sets exam status
 ;XMVAR() add one exam/line to bulletin - Future
 Q
 ;
 ;
EXIT D CLRVAR^DVBCXUTL,KILLVRS^DVBCXUTL,KILL^DVBCUTIL
