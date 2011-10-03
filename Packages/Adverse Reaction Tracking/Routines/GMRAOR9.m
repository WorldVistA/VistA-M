GMRAOR9 ;HIRMFO/RM,WAA,FPT-Stuff Drug Ingredients/Classes ; 1/9/08 5:18am
 ;;4.0;Adverse Reaction Tracking;**4,13,41**;Mar 29, 1996;Build 8
 ; <Copied from GMRAPES1>
EN1 ; Auto stuff Ingredients and VA Drug Classes
 ; GMRAING() will have all the ingredients for the reaction
 ; GMRADRCL() will have all the drug classes for the reaction.
 ;
 K GMRADRCL,GMRAING
 ; If the Reactant is a Drug Ingredient
 I GMRAAR[50.416 S GMRAING(+GMRAAR)="" G STING
 ;If the Reactant is a Drug Class
 I GMRAAR[50.605 S GMRADRCL(+GMRAAR)=""
 ;If the Reactant is an entry in the GMR ALLERGY file
 I GMRAAR[120.82 D
 .S Y=0 F  S Y=$O(^GMRD(120.82,+GMRAAR,"ING",Y)) Q:Y'>0  I $D(^GMRD(120.82,+GMRAAR,"ING",Y,0)),+^(0)>0 S GMRAING(+^(0))=""
 .S Y=0 F  S Y=$O(^GMRD(120.82,+GMRAAR,"CLASS",Y)) Q:Y'>0  I $D(^GMRD(120.82,+GMRAAR,"CLASS",Y,0)),+^(0)>0 S GMRADRCL(+^(0))=""
 .Q
 ;I GMRAAR["PSDRUG" D
 ;.N PSODA
 ;.S PSODA=+GMRAAR K ^TMP("PSO",$J) D ^PSONGR F Y=0:0 S Y=$O(^TMP("PSO",$J,Y)) Q:Y'>0  S GMRAING(Y)=""
 ;.N GMRAX,GMRAY
 ;.;S GMRAX=$P($G(^PSDRUG(+GMRAAR,"ND")),U,6) S:GMRAX>0 GMRADRCL(GMRAX)="" Q
 ;.S GMRAX=$$DRP2CLP^GMRAPENC(GMRAAR) S:GMRAX>0 GMRADRCL(GMRAX)="" Q
 ;.;S GMRAX=$P($G(^PSDRUG(+GMRAAR,0)),U,2) Q:GMRAX=""
 ;.S GMRAX=$$DRP2CODE^GMRAPENC(GMRAAR) Q:GMRAX=""
 ;.;S GMRAY=$O(^PS(50.605,"B",GMRAX,"")) S:GMRAY>0 GMRADRCL(GMRAY)=""
 ;.S GMRAY=$$CODE2CLP^GMRAPENC(GMRAX) S:GMRAY>0 GMRADRCL(GMRAY)=""
 ;.Q
 I GMRAAR["PSNDF" D
 .N PSNDA
 .S PSNDA=+GMRAAR K ^TMP("PSN",$J) D ^PSNNGR F Y=0:0 S Y=$O(^TMP("PSN",$J,Y)) Q:Y'>0  S GMRAING(Y)=""
 .; all classes for NDF entry returned in GMRADRCL
 .N CLASS
 .S CLASS=$$CLIST^PSNAPIS(+GMRAAR,.GMRADRCL)
 K ^TMP("PSO",$J),^TMP("PSN",$J),PSODA,PSNID
STING ;Stuffing Drug Ing & VA Drug Classes into file 120.8
 I $D(GMRAING) D
 .S DA(1)=+GMRAPA,DIC="^GMR(120.8,"_+GMRAPA_",2,",DLAYGO=120.8,DIC(0)="L",DIC("P")="120.802PA"
 .F X=0:0 S X=$O(GMRAING(X)) Q:X'>0  I '$D(^GMR(120.8,GMRAPA,2,"B",X)) K DD,DO,DINUM D FILE^DICN
 .K DIC,DLAYGO
 .Q
 I $D(GMRADRCL) D
 .S DA(1)=+GMRAPA,DIC="^GMR(120.8,"_+GMRAPA_",3,",DIC(0)="L",DIC("P")="120.803PA"
 .F X=0:0 S X=$O(GMRADRCL(X)) Q:X'>0  I '$D(^GMR(120.8,GMRAPA,3,"B",X)) K DD,DO,DINUM D FILE^DICN
 .K DIC
 .Q
 K GMRADRCL,GMRAING
 Q
