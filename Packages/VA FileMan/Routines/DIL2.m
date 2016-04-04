DIL2 ;SFISC/GFT,XAK,TKW-PROCESS HDRS AND TRAILERS ;11:39 AM  13 Feb 2003
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**1000**
 ;
 D T:$D(^UTILITY($J,"T")) S:DIPT $P(^DIPT(DIPT,0),U,7)=DT S:$D(DIBT) $P(^DIBT(DIBT,0),U,7)=DT S:$G(DISV) $P(^DIBT(DISV,0),U,7)=DT
 F X=0:0 S X=$O(R(X)) Q:X=""  I X<500,$O(^UTILITY($J,99,X))>499 S DX=X
 S X=$S($D(DNP):"",$D(DIWR):" D ^DIWW",($G(DIAR)=4!($G(DIAR)=6)):" W "".""",1:" D T")_$S(DIWL:" K DIWF",1:"")_$S($D(CP):" D CP",1:"")_$P(" S DJ=DJ+1",U,$D(DIS)>9&(L!($D(DISTEMP))))_$S($D(DHIT):" X DHIT",1:"")
 I X'["D T" S X=X_" S DISTP=DISTP+1 D:'(DISTP#100) CSTP^DIO2"
 S:$D(DISV) X=X_" S ^DIBT("_DISV_",1,D0)="""""
 S:X]"" DX=DX+1,^UTILITY($J,99,DX)=$E(X,2,999)
HEAD K DIOT S DW=2,(DQI,DV)=DHD,M=M(DP(0)) I DV?.P1"[".E1"]" D HT(DV?1"-".E) G 0
 I 'DV G 0:DV?1"W ".E,0:$G(DIFIXPT)=1,0:$G(IOST)?1"C".E S ^UTILITY($J,99,0)="Q" G G
 I $D(DIPZ) S ^UTILITY($J,1)=^UTILITY($J,1)_" X ^UTILITY($J,2) D HEAD"_^DIPT(DIPZ,"ROU")_^("LAST") G 0
 S DHTDXS="",X="",$P(X,"-",$S(IOM<244:IOM,1:244))="-"
 D O S ^UTILITY($J,DV)="W !,"""_X_""",!!",^(1)=^(1)_O
0 S ^UTILITY($J,99,0)="I DC["","""_$S(DIPT=.01:"!($Y>"_(DIOSL-5)_")",1:"")_" X ^UTILITY($J,1)"
G S DX(0)=^UTILITY($J,99,0) K ^UTILITY($J,0),DXIX,DHTDXS
 I $D(DPP(0)) S DJ=DPP(0,"IX"),DPQ=$O(DPP(DPP(0)))]"",DJK=0 G ^DIO
 S DPQ=$P(DPP(1),U,4)["-"!($D(DPP(1,"CM"))&('$D(DPP(1,"PTRIX"))))
 F R=2:1:DPP S:'$D(DPP(R,U)) DPQ=1
 S:$P(DPP(1),U,5)[";L" DPQ=1
 S DJK=1 I DPQ S %=0 F R=1:1:DPP I +$G(DPP(R,"SER"))>% S %=+DPP(R,"SER"),DJK=R
 I $D(DPP(DJK,"IX")) S DJ=DPP(DJK,"IX") G ^DIO
 S DJ=DK_DK_U_1 I $O(DPP(DJK,-1))>0!$P(DPP(DJK),U,2) S DPQ=1
 S:'DPQ DPP(1,"IX")=""
 G ^DIO
 ;
O S O=DHTDXS_" F DE="_DW_":1:"_DHD_" X ^UTILITY($J,DE)" Q
 ;
T ;
 F DG=-1:0 S DG=$O(^UTILITY($J,"T",DG)) Q:DG=""  S Z="""",I=$P(^(DG),U,6,99) I I]"" F W=2:1 Q:$P(I,Z,W,99)=""  S V=$P(I,Z,W) I V]"",$D(DCL(V)) S I=$P(I,Z,1,W-1)_+DCL(V)_$P(I,Z,W+1,99),W=W-1,^(DG)=$P(^(DG),U,1,5)_U_I
 Q
 ;
HT(DILTRAIL) S DLP=DX,DCC=M,DV=DW D
 . N DISMIN D INIT^DIP5
 F %=0:0 S %=$O(^DIPT("B",$P($P(DHD,"[",2),"]",1),%)) G TT:%="" I $D(^DIPT(%,0)),$P(^(0),U,4)=""!($P(^(0),U,4)=DP) S $P(^(0),U,7)=DT Q
 S DHTDXS=$S($D(^("DXS")):" N DXS M DXS=^DIPT("_%_",""DXS"") ",1:"")
 S DHT=$G(^DIPT(%,"ROU")) I DHT[U,$D(^("IOM")),^("IOM")'>IOM S ^UTILITY($J,DV)=DHTDXS_"D "_DHT,DV=DV+1 G EHT
 S DX=-1,DHD="^DIPT("_%_",""F"",DHT)" F DHT=0:0 S DHT=$O(@DHD) Q:DHT'>0  S R=^(DHT) D  D UNSTACK^DIL:DM
 . N DNP D ^DIL
 I $L(Y)>1 D PX^DIL
EHT S DX=DLP,DHD=DV-1,M=M(DP(0)) D O S DW=DV,O=" N X,DIP"_O
 I DILTRAIL S M=M+1,DILIOSL=IOSL-M,^(1)="X DIOT "_^UTILITY($J,1)_" K DIOT(2)",DIOT="I DC?.N,$Y N DA S DA=D0 N D0 S D0=+$G(DIOT(""D0""),DA) X DIOT(1)"_O,DIOT(1)="S DIOT(2)=1 F  W ! Q:$Y>"_DILIOSL_"!($G(DDBRZIS))",M=M+DCC Q
 S M=DCC,^(1)=^UTILITY($J,1)_O
TT S DHD=$P(DQI,"]",2) I DHD]"" D HT(1)
 Q
