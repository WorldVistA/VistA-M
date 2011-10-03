RTSM61 ;PKE/ISC-ALBANY more clinic requests sh. admis. ;9/1/90
 ;;v 2.0;Record Tracking;;10/22/91 
EN F A=0:0 S A=$O(^RTV(195.9,"AD","y",A)) Q:'A  I $D(^RTV(195.9,A,"ADM")),$D(^(0)) S RTSA(A)=$P(^(0),"^",1,3)_"^"_$P(^("ADM"),"^",2)
 ;
 I $D(^DIC(195.1,+^DIC(195.4,1,"MAS"),4)) S RTSA("MAS")=$P(^(4),"^",2)_"^^"_+^DIC(195.4,1,"MAS")
 I $D(^DIC(195.1,+^DIC(195.4,1,"RAD"),4)) S RTSA("RAD")=$P(^(4),"^",2)_"^^"_+^DIC(195.4,1,"RAD")
 K A,B
ST S X="T",%DT="" D ^%DT S RTBEG=Y S X="T+"_(0+$S($D(^DIC(195.4,1,0)):$S($P(^(0),"^",6):$P(^(0),"^",6),1:7),1:7)) D ^%DT S RTEND=Y_".2359" K %DT
 ;S RTBEG=2880101
 ;
START F RTTM=(RTBEG-.0001):0 S RTTM=$O(^DGS(41.1,"C",RTTM)) Q:'RTTM!(RTEND<RTTM)  F RTSAA=0:0 S RTSAA=$O(^DGS(41.1,"C",RTTM,RTSAA)) Q:'RTSAA  I $D(^DGS(41.1,RTSAA,0)) S A0=^(0) D APL
 K R,RTTM,RTSA,RTSAA,Q0,RTBOR,RTAA,RTBKGRD Q
APL ;A T/W,Ward,Treatsp get RTBOR pointer to Borrower
 I $P(A0,"^",13) Q  ;canceled
 K RTBOR
 S A=$P(A0,"^",10),W=$P(A0,"^",8),T=$P(A0,"^",9),DFN=+A0
 ;see if any sa borrowers have treat spec.
 I A="T" F Z=0:0 S Z=$O(RTSA(Z)) Q:'Z  I $P(RTSA(Z),"^",4)=T S RTBOR($P(RTSA(Z),"^",3))=Z
 ;see if any sa borrowers are ward locations
 I A="W" F Z=0:0 S Z=$O(RTSA(Z)) Q:'Z  I (+$P(RTSA(Z),"^",1)=W) S RTBOR($P(RTSA(Z),"^",3))=Z
 ;RTBOR(1),RTBOR(2) not defined, default, set default
 ;do directly from global
 F Z="MAS","RAD" I $D(RTSA(Z)) S A=$P(RTSA(Z),"^",3) I '$D(RTBOR(A)) S RTBOR(A)=RTSA(Z)
 K A,W,T,Z
 I '$D(RTBOR) Q
 ;Now loop borrower and create request, pull list.
 F RTAA=0:0 S RTAA=$O(RTBOR(RTAA)) Q:'RTAA  D CREATE
 Q
CREATE ;Have RTB,DFN,RTTM
 ;exclude inpatients
 I $D(^DPT(DFN,.1)),$D(^DIC(195.1,RTAA,4)),$P(^(4),"^") Q
 I $D(^DIC(195.1,RTAA,4)),$P(^(4),"^",3)="n",'$D(^RT("AA",RTAA,DFN_";DPT(")) Q
 S (Y,RTB)=+RTBOR(RTAA) I 'Y Q
 S Y=$P(^RTV(195.9,Y,0),"^",12) I 'Y S Y=RTB ;associated borrower
 S Y=$P(^RTV(195.9,Y,0),"^") D NAME^RTB S Y="SA "_Y
 ;
 S RTE=DFN_";DPT(",RTPLTY=1,(RTQDT,X)=RTTM,RTPN=$P(Y,"^")_" ["_$E(X,4,5)_"/"_$E(X,6,7)_"/"_$E(X,2,3)_"]"
PUL ;entry with RTB,RTA,Y
 S X=RTB,A=+RTAA K RTA,RTSD,RTDIV D INST1^RTUTL G Q:'$D(RTINST) S RTDIV=RTINST
 D BLD^RTQ2
 ;
 I '$D(RTSD),RTAA=1 F RTBLD=0:0 S RTBLD=$O(^DIC(195.1,+^DIC(195.4,1,"MAS"),"MAS",RTBLD)) Q:'RTBLD  I $D(^(RTBLD,0)) S X=^(0) D BLD1^RTQ2
 ;
 I '$D(RTSD),RTAA=2 F RTBLD=0:0 S RTBLD=$O(^DIC(195.1,+^DIC(195.4,1,"MAS"),"RAD",RTBLD)) Q:'RTBLD  I $D(^(RTBLD,0)) S X=^(0) D BLD1^RTQ2:'$D(RTTYR(+X))
 D RTSD
Q K RTBLD,RTTYR,RTPAR,RTSD,RT,RTSEL,A,Z,L,L1,I,RTINST,RTDIV,RTPULL,RTPN,RTTY,RTTYP,RTAPL,RTQ,RTY,RTS,RTQDT,RTB,RTPLTY,RTE
 Q
RTSD ;
 K RTPAR F RT=0:0 S RT=$O(RTSD(RT)) Q:'RT  S RTB=$P(^RTV(195.9,RTB,0),"^"),(RTA,RTAPL)=+RTSD(RT) D CHK K RTA,RTQ D PULL^RTQ2,CHK1 K:'$D(RTQ) RTSD(RT) I '$D(RTPAR),$D(RTQ) S RTPAR=RTQ
 Q
CHK S Y=+$O(^RTV(195.9,"ABOR",RTB,RTA,0)) D SET^RTDPA3:'Y S RTB=Y Q
 ;
CHK1 F R=0:0 S R=$O(^RTV(190.1,"C",RTTM,R)) Q:'R  I $D(^RTV(190.1,"ABOR",RTB,R)),$D(^RTV(190.1,R,0)) S Q0=^(0) I $P(Q0,"^")=RT,$P(Q0,"^",4)=RTTM,$P(Q0,"^",5)=RTB,$P(Q0,"^",10)=RTPULL Q
 I 'R D SET^RTQ
 Q
