RTSM7 ;PKE/ISC-ALBANY ;revoke user borrowing priv on termination
 ;;v 2.0;Record Tracking;;10/22/91 
 Q
XU Q:'$D(XUDA)  S RTDUZ=XUDA D REVOK,KIL Q
 ;
EN ; per application, revoke borrowing priv , cancel pending requests
 I '$D(RTLN) S RTLN=0
 S (L0,L)=RTLN+1
 S (LO,L)=L0+1 D NOW^%DTC S Y=$E(%,1,12) D D^DIQ K X S X(RTLN+1)="    Terminated User/Borrower Report     START DATE/TIME: "_Y
 S (L0,L)=L0+5
 D UTL,TERM
PRIV ;revoked bor
 S L0=L0+1,X(L0)=" "
 F RTDUZ=0:0 S RTDUZ=$O(^TMP($J,RTDUZ)) Q:'RTDUZ  S RTDUZ0=^(RTDUZ) F RTA=0:0 S RTA=$O(^TMP($J,RTDUZ,RTA)) Q:'RTA  S RTAPL=^(RTA) D YYY
 ;
CAN ;req canc
 F RTDUZ=0:0 S RTDUZ=$O(^TMP($J,RTDUZ)) Q:'RTDUZ  S RTDUZ0=^(RTDUZ) D XXX
 D NOW^%DTC S Y=$E(%,1,12) D D^DIQ K X S X(RTLN+2)="                                         STOP DATE/TIME: "_Y S X(RTLN+3)=" ",X(RTLN+4)=" "
 D UTL Q
YYY S L0=L0+1,L=L+1,X(L0)=" `"_$E(RTDUZ0_"'          ",1,20)_" borrowing priviliges are revoked for '"_RTAPL_"'"
 D UTL Q
TERM ;
 S X1=DT,X2=-3 D C^%DTC S RTDTW=X
 F RTDUZ=0:0 S RTDUZ=$O(^VA(200,RTDUZ)) Q:'RTDUZ  I $D(^(RTDUZ,0)) S RTERM=$P(^(0),"^",11) I RTERM,+RTERM'>DT,RTERM'<RTDTW S RTDUZ0=$P(^(0),"^") D REVOK
 Q
KIL K SAVDUZ,RTDUZ,POINT,BPOINT,RTBOR,Z,DIC,DA,DR Q
 ;
 ;add on to regular bulletin (the whole application)
 ;print cancel request on home location printer /or mailgroup
 Q
REVOK ;entry with duz to revoke borrowering priv
 S BORROW=RTDUZ_";VA(200," D BOR
 Q
BOR ;find borrower to revoke for all applications
 ;check application parameter to revoke/ornot, cancel/ornot
 F RTB=0:0 S RTB=$O(^RTV(195.9,"B",BORROW,RTB)) Q:'RTB  I $D(^RTV(195.9,RTB,0)) S RTA=$P(^(0),"^",3) D NOTE I $D(^DIC(195.1,RTA,2)),$P(^(2),"^",3)="y" S DA=RTB,DIE="^RTV(195.9,",DR="10///REVOKE" D ^DIE K DE,DQ D CANCEL
 Q
NOTE S L0=L0+1,L=L+1
 S X(L0)=" `"_$E(RTDUZ0_"'                ",1,20)_" has been terminated and is a `"_$S(RTA=1:"MAS",RTA=2:"RAD",1:$P(^DIC(195.1,RTA,0),"^"))_"' Borrower"
 D UTL
 S:'$D(^TMP($J,RTDUZ)) ^(RTDUZ)=RTDUZ0
 Q
CANCEL ; cancel rtq
 S:'$D(^TMP($J,RTDUZ,RTA)) ^(RTA)=$S(RTA=1:"MAS",RTA=2:"RAD",1:$S($D(^DIC(195.1,RTA,0)):$P(^(0),"^"),1:""))
 Q:'$D(^DIC(195.1,RTA,2))  I $P(^(2),"^",4)'="y" Q
 F RTQ=0:0 S RTQ=$O(^RTV(190.1,"ABOR",RTB,RTQ)) Q:'RTQ  D CHK
 Q
CHK ;rtapl
 Q:'$D(^RTV(190.1,RTQ,0))  S RTQ0=^(0)
 ;
 I $P(RTQ0,"^",5)'=RTB Q
 ;
 I $P(RTQ0,"^",6)'="r" Q
 ;
 I $P(RTQ0,"^",10),$P(^RTV(194.2,+$P(RTQ0,"^",10),0),"^",10)=1 Q
 ;associated requestor
 I $P(RTQ0,"^",14) Q
 ;date/time requested  (only pending)
 S RDT=$P(RTQ0,"^",4) Q:'RDT
 ;
 Q:'$D(^RT(+RTQ0,0))  S RT0=^(0)
 S RTTY=$P(RT0,"^",3),RTH=+$P(RT0,"^",6),RTAPL=$P(RT0,"^",4)
 I '$D(RTWND(+RTTY)) D PND^RTRPT
 I $P(RDT,".")<RTWND(+RTTY) Q
 S RTE=$P(RT0,"^"),RTV=$P(RT0,"^",5),RT=+RTQ0
 ;need to show what requests were canceled
 S ^TMP($J,RTDUZ,RTAPL,RTQ)=RTE_"^"_RTTY_"^"_RTV_"^"_RT_"^"_RTQ_"^"_RTH_"^"_RDT
 ;
ZZZ S RTSTAT="x" S SAVDUZ=RTDUZ,DA=RTQ,DIE="^RTV(190.1,",DR="[RT CHANGE REQUEST STATUS]" D ^DIE K DE,DQ,RTSTAT S RTDUZ=SAVDUZ Q
 Q
XXX F B=0:0 S B=$O(^TMP($J,RTDUZ,B)) Q:'B  D B
 Q
B I '$O(^TMP($J,RTDUZ,B,0)) Q
 S (L,L0)=L0+1+L,X(L0)=" "
 S L0=L0+1,X(L0)=" "
 S L=L+1,X(L)="  "
 S L=L+1,X(L)=" `"_$E(RTDUZ0_"'          ",1,20)_" had requests for these Records which are CANCELLED" S L=L+1,X(L)="",$P(X(L),"-",78)=""
 S L=L+1,X(L)="    Record            Type   Vol      Rec #       Req #      Request date/time"
 ;
 F C=0:0 S C=$O(^TMP($J,RTDUZ,B,C)) Q:'C  S U0=^(C) D C
 D UTL Q
C S L=L+1,Y=$P(U0,"^") D NAME^RTB S RTTY=$P(U0,"^",2),RTTY=$P(^DIC(195.2,RTTY,0),"^",2),RTV=$P(U0,"^",3),RT=$P(U0,"^",4),RTQ=C
 S BL="",$P(BL," ",20)="",X(L)=" "_$E(Y_BL,1,20)_"  "_$E(RTTY_BL,1,5)_" "_$S($L(RTV):"V",1:" ")_$E(RTV_BL,1,6)_" "_$E(RT_BL,1,12)_"  "_$E(RTQ_BL,1,10)
 S D=$E($P(U0,"^",7)_"00000",1,12)
 S D=$E(D,4,5)_"-"_$E(D,6,7)_" @ "_$E(D,9,10)_":"_$E(D,11,12),X(L)=X(L)_" "_D
 I L#10=0 D UTL
 Q
UTL F Z=0:0 S Z=$O(X(Z)) Q:'Z  S ^TMP($J,"TX",Z,0)=X(Z)
 K X Q
