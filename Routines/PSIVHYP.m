PSIVHYP ;BIR/RGY-CALCULATE AND PRINT HYPER ORDERS ;16 DEC 97 / 1:39 PM 
 ;;5.0; INPATIENT MEDICATIONS ;**58,96**;16 DEC 97
 ;
 ; Reference to ^PS(55 is supported by DBIA 2191
 ; Reference to ^PS(52.6 is supported by DBIA# 1231
 ; Reference to ^PS(52.7 is supported by DBIA# 2173
 ; Reference to ^PS(50.4 is supported by DBIA 2175
 ;
 K HYPL,HYPA,PSIVPRT S TVOL=0 F Z=52.6,52.7 F DRG=0:0 S DRG=$O(^PS(55,DFN,"IV",+ON,$S(Z=52.6:"AD",1:"SOL"),DRG)) Q:'DRG  S DRG=DRG_"^"_^(DRG,0) S:$P(DRG,"^",4)="" $P(DRG,"^",4)="ALL" D DRG
 S TVOL=TVOL+.5\1 K EL,DRG,NAD,Z Q
DRG ;
 I Z=52.7 S TVOL=TVOL+$P(DRG,"^",3)
 NEW ZZ S ZZ=$S(Z=52.6:"AD",1:"SOL")
 S NAD=$S('$P(DRG,"^",2):"*",$D(^PS(Z,$P(DRG,"^",2),0)):^(0),1:"*")
 I NAD="*" S HYPL(+Z,"*","ALL")=".0001 ***"
 I Z=52.6,$S('$D(^PS(52.6,$P(DRG,"^",2),2,0)):1,$P(^(0),"^",4)<1:1,1:0) D ADD Q
 F EL=0:0 S EL=$O(^PS(Z,$P(DRG,"^",2),2,EL)) Q:'EL  S EL=EL_"^"_^(EL,0) D EL
 Q
EL ;
 I $S($P(EL,"^",2)="":1,'$D(^PS(50.4,$P(EL,"^",2),0)):1,1:0) S HYPL(Z,"*","ALL")=".0001 ***"_U_$P(EL,U,2) Q
 I $P($P($P(EL,"^",3),"/")," ",2)="" S HYPL(50.4,$P(EL,"^",2),"ALL")=".0001 ***"_U_$P(EL,U,2) Q
 S ELT=$S($P(NAD,"^",10)!(Z=52.7):$P(DRG,"^",3)/$S(Z=52.7:1,1:$P(NAD,"^",10))*$P(EL,"^",3),1:0)
 S HYPL(50.4,$P(EL,"^",2),$P(DRG,"^",4))=$S($D(HYPL(50.4,$P(EL,"^",2),$P(DRG,"^",4))):HYPL(50.4,$P(EL,"^",2),$P(DRG,"^",4)),1:0)+ELT_" "_$P($P($P(EL,"^",3),"/")," ",2)_U_$P(EL,U,2)
 ;S HYPA(50.4,$P(EL,"^",2),$P(DRG,"^",4))=Z_"^"_+DRG_ZZ
 S HYPLRPT($P(EL,U,2),ZZ,+DRG)=""
 K ELT Q
ADD S:'$D(HYPL(+Z,+DRG,$P(DRG,"^",4))) HYPL(+Z,+DRG,$P(DRG,"^",4))=0 S HYPL(+Z,+DRG,$P(DRG,"^",4))=HYPL(+Z,+DRG,$P(DRG,"^",4))+$P(DRG,"^",3)_" "_$P($P(DRG,"^",3)," ",2)_U_+DRG_ZZ Q
