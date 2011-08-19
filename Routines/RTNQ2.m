RTNQ2 ;MJK/TROY ISC;Record Inquiry Routine ; 5/4/87  9:57 AM ;
 ;;2.0;Record Tracking;**32,36**;10/22/91 
 I '$D(RTAPL) D APL2^RTPSET D NEXT:$D(RTAPL) K RTAPL,RTSYS Q
NEXT S RTA=+RTAPL D ASK^RTB K RTA G Q:$D(RTESC),RTNQ2:Y<0 S RTE=X
 S RTRD(1)="All^display all volumes for all record types",RTRD(2)="Type^display all volumes for a specific record type",RTRD(3)="Volume^display specific volumes",RTRD("B")=1,RTRD(0)="S"
 S RTRD("A")="Indicate what information to display: " D SET^RTRD K RTRD G Q:$E(X)="^" S RTINFO=$E(X)
 I RTINFO="T" S DIC(0)="IAEMQ",DIC="^DIC(195.2,",DIC("S")="I $P(^(0),U,3)=+RTAPL,$D(^RT(""AT"",Y,RTE))",DIC("A")="Select Record Type: " D ^DIC K DIC G Q:Y<0 S RTINFO="T^"_+Y
 I RTINFO="V" D VOL G Q:'$D(RTINFO)
 S RTPGM="START^RTNQ2",RTVAR="RTE^RTINFO^RTAPL" D ZIS^RTUTL G Q:POP D START G NEXT
 ;
START U IO S RTPAGE=0,RTFL="RECS",RTUTL=0 K RT,^TMP($J,"RTNQ") I '$D(IOSL)!('$D(IOF)) S IOP="" D ^%ZIS K IOP
 D TYPE,HD I RTINFO["V" S X=$P(RTINFO,"^",2,99) F I=1:1 Q:'$P(X,"^",I)  S RT(+$P(X,"^",I))=""
 I RTINFO["T" S T=+$P(RTINFO,"^",2) F RT=0:0 S RT=$O(^RT("AT",T,RTE,RT)) Q:'RT  S RT(RT)=""
 I RTINFO["A" S A=+RTAPL F RT=0:0 S RT=$O(^RT("AA",A,RTE,RT)) Q:'RT  S RT(RT)=""
 G Q:$D(RT)<10 K RTL F RT=0:0 S RT=$O(RT(RT)) Q:'RT  K RT(RT) I $D(^RT(RT,0)) S RT0=^(0) I $D(RTO(+$P(RT0,"^",3))) S RT(RT)=RT0 D REC
 S C=0,RTESC="" K R F O=0:0 S O=$O(RTL(O)) Q:'O  F V=0:0 S V=$O(RTL(O,V)) Q:'V  S C=C+1,R(C)=^TMP($J,"RTNQ",RTL(O,V),1) D WRITE:C=3 G Q:RTESC="^"
 D WRITE:C,^RTNQ21:RTESC'["^"
Q K C,S,RTVAR,RTPGM,RTQ,RTWND,RTDT,R,RT,RT0,RTA,RTE,RTESC,RTFL,RTINFO,RTL,RTO,RTPAGE,RTUTL,^TMP($J,"RTNQ") D CLOSE^RTUTL
 K I,Y,DUOUT,DIC,DIY,N,A,F,O,X1,%I,%H,POP,X Q
VOL K RTY S RTDC("S")="I $P(^(0),U,4)="_+RTAPL,RTSEL="S",Y=RTE D NAME^RTB S RTSEL("A")="Select "_Y_"'s Record" D ^RTUTL2 K RTSEL I $D(RTY) F I=1:1 Q:'$D(RTY(I))  S $P(RTINFO,"^",I+1)=RTY(I)
 K:'$D(RTY) RTINFO K RT1,RTC,RTY,RTDC,RTSEL Q
 ;
HD S RTESC="" I RTPAGE,IOST["C-" R !!,"Press RETURN to continue or '^' to stop: ",RTESC:DTIME S:'$T RTESC="^" Q:RTESC["^"
 S RTPAGE=RTPAGE+1,X1=$S($D(^DIC(195.1,+RTAPL,"HD")):^("HD"),1:"Record")_" Inquiry" D PTHD^RTUTL2,EQUALS^RTUTL3
 Q
 ;
REC S Y=RT0 Q:'$D(^RT(RT,"CL"))  S RTCL=^("CL"),R("BC")=$S($P(RTCL,"^",15)="y":"Barcode",1:"Non-barcode"),T=+$P(Y,"^",3),V=+$P(Y,"^",7),R("DES")=$P(Y,"^",12),Y=$P(Y,"^",11),C=$P(^DD(190,11,0),"^",2) D Y^DIQ S R("R")=Y
 S (H,H("P"))="" I $D(^RTV(195.9,+$P(RT0,"^",6),0)) S Y=^(0),H("P")=$P(Y,"^",7),Y=$P(Y,"^") D NAME^RTB S H=Y
 S Y=RTCL,D=$P(Y,"^",6)_".00000",D=$TR($$FMTE^XLFDT($E(D,1,12),"5F")," /","0-")
 S U1=$S($D(^VA(200,+$P(Y,"^",7),0)):$P(^(0),"^"),1:"UNKNOWN")
 S Y=+$P(Y,"^",8),C=$P(^DD(190,108,0),"^",2) D Y^DIQ S M=Y
 S R("I")="" I $D(^RT(RT,"I")),^("I"),DT>^("I") S R("I")=$S(M["TRANSFER TO":"** Transferred **",1:"*** Inactive ***")
 S (B,B("P"))="" I $D(^RTV(195.9,+$P(RTCL,"^",5),0)) S Y=^(0),B("P")=$P(Y,"^",7),Y=$P(Y,"^") D NAME^RTB S B=Y
 S Y=$P(RTCL,"^",14) D BOR^RTB:Y S R("PROV")=Y
 S RTUTL=RTUTL+1,RTL(+RTO(T),999-V)=RTUTL,^TMP($J,"RTNQ",RTUTL,1)=$P(RTO(T),"^",2)_"^"_V_"^"_RT_"^"_R("DES")_"^"_B_"^"_B("P")_"^"_R("PROV")_"^"_D_"^"_M_"^"_U1_"^"_H_"^"_H("P")_"^"_R("I")_"^"_R("R")_"^"_R("BC")
RECQ K V,B,RTCL,D,H,R,M,U1,C,Y Q
 ;
WRITE S RTN=15 D HD:($Y+RTN+3)>IOSL G WRITEQ:RTESC="^" F F=1:1:RTN W !,$P($T(LABELS+F),";;",2) F I=1:1 Q:'$D(R(I))  W ?(20+(20*(I-1))),$E($P(R(I),"^",F),1,19)
WRITEQ K R,RTN S C=0 Q
 ;
TYPE F T=0:0 S T=$O(^DIC(195.2,"C",+RTAPL,T)) Q:'T  I $D(^DIC(195.2,T,0)) S O=$S($P(^(0),"^",4)]"":+$P(^(0),"^",4),1:0),RTO(T)=$S(O:O,1:0)_"^"_$P(^(0),"^",1,2)
 Q
 ;
LABELS ;;
 ;;Type of Record  :
 ;;Volume No.      :
 ;;Record No.      :
 ;;Descriptor      :
 ;;Current Location:
 ;;Current Phone   :
 ;;Associated Borr.:
 ;;Since...        :
 ;;Movement        :
 ;;Responsible User:
 ;;Home Location   :
 ;;Home Phone      :
 ;;Inactive Flag   :
 ;;Retirement Flag :
 ;;Last Access Meth:
