PRCFSI1 ;WISC/CLH-SITE PARAMETERS CON'T ;8-31-90/09:55
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
AFU K PRC("L") S PRC("L")=0 I $O(^PRC(411,"AE",1,0)) S PRC("L")="",N=0 F ZI=1:1 S N=$O(^PRC(411,N)) Q:'N  I $P(^PRC(411,N,0),"^",22)=1,$D(^PRC(411,N,6,"B",DUZ)) S PRC("L")=PRC("L")+1,PRC("L",N)=""
 K ZI,PRC("FU") I PRC("L")="" S X="YOU ARE NOT AN AUTHORIZED FISCAL USER.  CONTACT SITE MANAGER.*" D MSG^PRCFQ S PRC("FU")=1 Q
 I PRC("L")=1 S PRC("I")=$O(PRC("L",0)) K:PRC("I")="" PRC("I") I $D(PRC("I")) S PRC("SITE")=+^PRC(411,+PRC("I"),0)
 I '$D(PRC("I")) S PRC("I")=$S($D(^PRC(411,"AC",1))&($O(^(1,0))):$P(^PRC(411,$O(^(0)),0),"^"),1:$P(^PRC(411,$O(^PRC(411,0)),0),U,1))
 Q
AFU1 K PRC("FU") I $O(^PRC(411,"AE",1,0)),'$D(PRC("SP")),$P(^PRC(411,PRC("SITE"),0),U,22)=1,'$D(^PRC(411,PRC("SITE"),6,"B",DUZ)) D A1
 Q
A1 S X="You are not an AUTHORIZED USER FISCAL user for Station "_PRC("SITE")_".  No further actions taken.*" D MSG^PRCFQ S PRC("FU")=1
 Q
