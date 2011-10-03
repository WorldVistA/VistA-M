PSSDIN ;BIR/WRT-API for National Formulary Indicator ;03/13/00
 ;;1.0;PHARMACY DATA MANAGEMENT;**38**;9/30/97
 ;
 ; Input: PSSOI=Orderable Item (optional), PSSDD=Dispense Drug(optional)
 ; Output: ^TMP("PSSDIN",$J,"OI",PSSOI,dtien,index)=text
 ; Output: ^TMP("PSSDIN",$J,"DD",PSSDD,dtien,index)=text
 ;
EN(PSSOI,PSSDD) ;entry point returns nfi text
 K ^TMP("PSSDIN",$J) N IDX,IEN,WP,TY,TD
 I $D(PSSOI),$G(PSSOI) D OITM
 I $D(PSSDD),$G(PSSDD) D DPDRG
 Q
OITM ;returns nfi text for a single orderable item
 Q:'$O(^PS(50.7,PSSOI,1,0))
 S TY="OI",TD=PSSOI F IDX=0:0 S IDX=$O(^PS(50.7,TD,1,IDX)) Q:'IDX  S IEN=$P($G(^PS(50.7,PSSOI,1,IDX,0)),"^") D FTX
 Q
FTX I $G(IEN),$D(^PS(51.7,IEN)) D:$P($G(^PS(51.7,IEN,0)),"^",2)=""!($P($G(^PS(51.7,IEN,0)),"^",2)>(DT-1))
 .F WP=0:0 S WP=$O(^PS(51.7,IEN,2,WP)) Q:'WP  S:$D(^PS(51.7,IEN,2,WP,0)) ^TMP("PSSDIN",$J,TY,TD,IEN,WP)=^PS(51.7,IEN,2,WP,0)
 Q
DPDRG ;returns nfi text for a single dispense drug
 Q:'$O(^PSDRUG(PSSDD,9,0))
 S TY="DD",TD=PSSDD F IDX=0:0 S IDX=$O(^PSDRUG(TD,9,IDX)) Q:'IDX  S IEN=$P($G(^PSDRUG(PSSDD,9,IDX,0)),"^") D FTX
 Q
PROMPT() ;conditional read
 Q:'$O(^TMP("PSSDIN",$J,"OI",0))&('$O(^TMP("PSSDIN",$J,"DD",0))) ""
 S PSSOI=$O(^TMP("PSSDIN",$J,"OI",0)),PSSDD=$O(^TMP("PSSDIN",$J,"DD",0))
READ1 K DIR S DIR(0)="SB^N:NO"_$S($G(PSSDD):";D:DISPENSE DRUG",1:"")_$S($G(PSSOI):";O:ORDERABLE ITEM",1:"")_$S($G(PSSDD)&($G(PSSOI)):";B:ORDERABLE ITEM AND DISPENSE DRUG",1:"")
 S DIR("A")="  Restriction/Guideline(s) exist.  Display? ",DIR("B")="No" D ^DIR K DIR,PSSOI,PSSDD
 Q $S(Y="B":"Y",1:Y)
