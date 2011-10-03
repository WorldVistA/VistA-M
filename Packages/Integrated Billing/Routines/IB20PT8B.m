IB20PT8B ;ALB/CPM - EXPORT ROUTINE 'DGPMVBUR' ; 24-FEB-94
 ;;Version 2.0 ; INTEGRATED BILLING ;; 21-MAR-94
 ;
DGPMVBUR ;ALB/MIR - UR ADMISSION BULLETIN FOR MCCR ; 13 JUL 91
 ;;5.3;Registration;**26**;Aug 13, 1993
 ;
UR ;UR bulletin
 K DGPMUR
 D INS I '$D(DGPMUR(10)) D URQ Q
 S DGPMX=$O(^XMB(3.8,"B","DGPM UR ADMISSION",0)) I '$O(^XMB(3.8,+DGPMX,1,0)) K DGPMX D URQ Q  ; if no mailgroup members, quit
 S XMSUB="UR ADMISSION BULLETIN",XMTEXT="DGPMUR(",DGPMBLN=0
 F I=0:0 S I=$O(^XMB(3.8,+DGPMX,1,I)) Q:'I  I $D(^(I,0)) S XMY(+^(0))=""
 D PID^VADPT6 S DGPMBL="Admission for  : "_$P(^DPT(DFN,0),"^",1)_"   "_VA("PID") D SETLN
 S Y=+DGPMA X ^DD("DD") S DGPMBL="Date/Time      : "_Y D SETLN
 S DGPMBL="Type of Admit  : "_$S($D(^DG(405.1,+$P(DGPMA,"^",4),0)):$P(^(0),"^",1),1:"") D SETLN
 S DGPMBL=" " D SETLN
 S DGPMBL="Ward Location  : "_$S($D(^DIC(42,+$P(DGPMA,"^",6),0)):$P(^(0),"^",1),1:"UNKNOWN") D SETLN
 S DGPMBL="Room-Bed       : "_$S($D(^DG(405.4,+$P(DGPMA,"^",7),0)):$P(^(0),"^",1),1:"UNKNOWN") D SETLN
 S DGPMBL="Admitting DX   : "_$P(DGPMA,"^",10) D SETLN
 S DGPMBL=" " D SETLN
 S DGPMBLN=DGPMLAST D DIS ;SC disabilities
 D ^XMD
URQ K DGPMBL,DGPMBLN,DGPMLAST,DGPMUR,DGTMP,XMY,XMSUB,XMTEXT
 K %,%Y,DGPMOB,DGPMOW,DGPMX,I,X,X1,X2,Y,DGIBINS
 Q
 ;
INS ;get insurance effective at time of admission, start at DGPMBLN=10
 S DGPMBLN=9
 K DGIBINS
 D ALL^IBCNS1(DFN,"DGIBINS") F I=0:0 S I=$O(DGIBINS(I)) Q:'I  S X=DGIBINS(I,0) D ACT
 I $D(DGPMUR(10)) S DGPMLAST=DGPMBLN
 Q
 ;
ACT ;is insurance active?  If so, set in DGPMBLN array
 I $P(X,"^",4)<+DGPMA,$P(X,"^",4) Q  ;insurance expired before admission
 I $P(X,"^",8)>+DGPMA Q  ;insurance effective after admission
 Q:'$D(^DIC(36,+X,0))  S X1=^(0),X2=$S($D(^(.13)):^(.13),1:"") ;get insurance company information
 I $P(X1,"^",5)!($P(X1,"^",2)="N") Q  ;insurance company is inactive or doesn't reimburse
 S DGPMBL="Insurance Co.  : "_$P(X1,"^",1) D SETLN
 S DGTMP=$S(($P(X,"^",15)]""):$P(X,"^",15),1:$P(X,"^",3))
 I DGTMP]"" S DGPMBL="Group          : "_DGTMP D SETLN
 S DGPMBL="Policy Holder  : "_$P(X,"^",17) D SETLN
 S DGPMBL="Subscriber ID  : "_$P(X,"^",2) D SETLN
 S DGPMBL="Ins. Co Phone# : "_$S($P(X2,"^",2)]"":$P(X2,"^",2),$P(X2,"^",1)]"":$P(X2,"^",1),1:"UNKNOWN") D SETLN
 S DGPMBL=" " D SETLN
 Q
DIS ;rated disabilities
 I $S('$D(^DPT(DFN,.3)):1,$P(^(.3),"^",1)'="Y":1,1:"") Q  ;not service connected...
 I $S('$D(^DPT(DFN,"VET")):1,$P(^("VET"),"^",1)'="Y":1,1:0),$S('$D(^DG(391,+$S($D(^DPT(DFN,"TYPE")):^("TYPE"),1:""),0)):1,$P(^(0),"^",2):0,1:1) Q
 ;X=0 node, X1=already one SC disability?
 S X1=0 F I=0:0 S I=$O(^DPT(DFN,.372,I)) Q:'I  I $D(^(I,0)) S X=^(0) I $P(X,"^",3)&$D(^DIC(31,+X,0)) S DGPMBL=$S('X1:"SC Disabilities: ",1:"                 ")_$P(^(0),"^",1)_" ("_+$P(X,"^",2)_"%)" S X1=1 D SETLN
 Q
SETLN ; -- set line in xmtext array
 S DGPMBLN=DGPMBLN+1
 S DGPMUR(DGPMBLN)=DGPMBL
 Q
