RTNQ4 ;MJK,PKE/TROY ISC;Expanded Record Inquiry Routine ; 5/4/87  9:57 AM ;
 ;;2.0;Record Tracking;**32,36**;10/22/91 
 I '$D(RTAPL) D APL2^RTPSET D NEXT:$D(RTAPL) K RTAPL,RTSYS Q
NEXT S RTA=+RTAPL D ASK^RTB K RTA G Q:$D(RTESC),NEXT:Y<0 S RTE=X
 S RTINFO="A"
 S RTPGM="START^RTNQ4",RTVAR="RTE^RTINFO^RTAPL" D ZIS^RTUTL G Q:POP D START G NEXT
 ;
START U IO S RTPAGE=0,RTFL="RECS",RTUTL=0
 K RT,^TMP($J,"RTNQ"),R2,R3,Z
 I '$D(IOSL)!('$D(IOF)) S IOP="" D ^%ZIS K IOP
 D TYPE,HD
 I RTINFO["A" S A=+RTAPL F RT=0:0 S RT=$O(^RT("AA",A,RTE,RT)) Q:'RT  S RT(RT)=""
 G Q:$D(RT)<10 K RTL F RT=0:0 S RT=$O(RT(RT)) Q:'RT  K RT(RT) I $D(^RT(RT,0)) S RT0=^(0) I $D(RTO(+$P(RT0,"^",3))) S RT(RT)=RT0 D REC
 D ^RTNQ41
 S C=0,RTESC="" K R F O=0:0 S O=$O(RTL(O)) Q:'O  F V=0:0 S V=$O(RTL(O,V)) Q:'V  S C=C+1,R(C)=^TMP($J,"RTNQ",RTL(O,V),1) D WRITE:C=3 G Q:RTESC="^"
 ; c is number of volumes
 D WRITE:C
 Q
Q K C,S,RTVAR,RTPGM,RTQ,RTWND,RTDT,R,RT,RT0,RTA,RTE,RTESC,RTFL,RTINFO,RTL,RTO,RTPAGE,RTUTL,^TMP($J,"RTNQ"),R2,R3,Z D CLOSE^RTUTL
 K DIC,DIY,N,A,F,O,X1,%I,%H,POP,X
 K:'$D(RTY) RTINFO K RT1,RTC,RTY,RTDC,RTSEL
 K M,T,DFN,CT,I,T,V,VADMVT,Y Q
 ;
HD S RTESC="" I RTPAGE,IOST["C-" W !! R !,"Press RETURN to continue or '^' to stop: ",RTESC:DTIME S:'$T RTESC="^" Q:RTESC["^"
 S RTPAGE=RTPAGE+1,X1=$S($D(^DIC(195.1,+RTAPL,"HD")):^("HD"),1:"Record")_" Inquiry" D PTHD^RTUTL2,EQUALS^RTUTL3
 Q
 ;
REC S Y=RT0 Q:'$D(^RT(RT,"CL"))  S RTCL=^("CL"),R("BC")=$S($P(RTCL,"^",15)="y":"Barcode",1:"Non-barcode"),T=+$P(Y,"^",3),V=+$P(Y,"^",7),R("DES")=$P(Y,"^",12),Y=$P(Y,"^",11),C=$P(^DD(190,11,0),"^",2) D Y^DIQ S R("R")=Y
 S (H,H("P"))="" I $D(^RTV(195.9,+$P(RT0,"^",6),0)) S Y=^(0),H("P")=$P(Y,"^",7),Y=$P(Y,"^") D NAME^RTB S H=Y
 ;
 S Y=RTCL,D=$P(Y,"^",6)_".00000",D=$TR($$FMTE^XLFDT($E(D,1,12),"5F")," /","0-")
 S U1=$S($D(^VA(200,+$P(Y,"^",7),0)):$P(^(0),"^"),1:"UNKNOWN")
 S Y=$P(Y,"^",8),C=$P(^DD(190,108,0),"^",2) D Y^DIQ S M=Y
 S R("I")="" I $D(^RT(RT,"I")),^("I"),DT>^("I") S R("I")=$S(M["TRANSFER TO":"** Transferred **",1:"*** Inactive ***")
 ;
 S (B,B("P"))="" I $D(^RTV(195.9,+$P(RTCL,"^",5),0)) S Y=^(0),B("P")=$P(Y,"^",7),Y=$P(Y,"^") D NAME^RTB S B=Y
 S Y=$P(RTCL,"^",14) D BOR^RTB:Y S R("PROV")=Y
 S RTUTL=RTUTL+1,RTL(+RTO(T),999-V)=RTUTL,^TMP($J,"RTNQ",RTUTL,1)=$P(RTO(T),"^",2)_"^"_V_"^"_RT_"^"_R("DES")_"^"_B_"^"_B("P")_"^"_R("PROV")_"^"_D_"^"_M_"^"_U1
RECQ K V,B,RTCL,D,H,R,M,U1,C,Y Q
 ;
WRITE S RTN=10 D HD:($Y+RTN+8)>9999 G WRITEQ:RTESC="^" F F=1:1:RTN W !,$P($T(LABELS+F),";;",2) F I=1:1 Q:'$D(R(I))  W ?(20+(20*(I-1))),$E($P(R(I),"^",F),1,19)
 D DPL^RTNQ41
 I C=3,$O(RTL(O))!($O(RTL(O,V))) D HD
WRITEQ K R,RTN S C=0 Q
 ;
TYPE F T=0:0 S T=$O(^DIC(195.2,"C",+RTAPL,T)) Q:'T  I $D(^DIC(195.2,T,0)) S O=$S($P(^(0),"^",4)]"":+$P(^(0),"^",4),1:0),RTO(T)=$S(O:O,1:0)_"^"_$P(^(0),"^",1,2)
 Q
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
 ;
