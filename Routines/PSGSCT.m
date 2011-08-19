PSGSCT ;BIR/CML3-SERVICE COST TOTALS ; 22 Jun 98 / 1:50 PM
 ;;5.0; INPATIENT MEDICATIONS ;**3,12**;16 DEC 97
 ;
 D ENCV^PSGSETU I '$D(XQUIT) S HLP="SERVICE" D ENDTS^PSGAMS I SD,FD S ZTDESC="COST PER SERVICE REPORT",RTN="SCT" D EN3^PSGTI I 'POP,'$D(IO("Q")) D ENQ D:IO'=IO(0)!($E(IOST)'="C") ^%ZISC
 ;
DONE ;
 D ENKV^PSGSETU K COST,DRG,FD,HLP,RTN,ND,NU,P,PR,SD,ST,STOP,STRT,W,WN,WD Q
 ;
ENQ ;
 K ^UTILITY("PSG",$J) F ST=SD:0 S ST=$O(^PS(57.6,ST)) Q:'ST!(ST>FD)  S W=0 F  S W=$O(^PS(57.6,ST,1,W)) Q:'W  S (CNT,COST)=0,(SN,WD)="" D ADD
 D ^PSGSCT0 K ^UTILITY("PSG",$J) Q
 ;
ADD ; find service, if possible, or ward name
 S SN=$P($G(^DIC(42,W,0)),"^",3) I SN]"",$$VFIELD^DILFD(42,.03) S SN=$$EXTERNAL^DILFD(42,.03,"",SN) G:SN]"" DRG
 S WD=$S('$D(^DIC(42,W,0)):W,$P(^(0),"^")]"":$P(^(0),"^"),1:W)
DRG ;
 S PR=0 F  S PR=$O(^PS(57.6,ST,1,W,1,PR)) Q:'PR  S DRG=0 F  S DRG=$O(^PS(57.6,ST,1,W,1,PR,1,DRG)) Q:'DRG  I $D(^(DRG,0)) S ND=^(0),CNT=CNT+$P(ND,"^",2)-$P(ND,"^",4),COST=COST+$P(ND,"^",3)-$P(ND,"^",5)
 Q:'CNT&'COST
 ;
TOT ; set global of service, if service found, or ward if service not found
 I SN]"" S ND=$G(^UTILITY("PSG",$J,"S",SN)),^(SN)=+ND+CNT_"^"_($P(ND,"^",2)+COST) Q
 S ND=$G(^UTILITY("PSG",$J,"W",WD)),^(WD)=+ND+CNT_"^"_($P(ND,"^",2)+COST) Q
