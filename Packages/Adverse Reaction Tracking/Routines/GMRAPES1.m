GMRAPES1 ;HIRMFO/RM,WAA-SELECT PATIENT ALLERGY TO EDIT ;10/1/07  10:42
 ;;4.0;Adverse Reaction Tracking;**13,14,17,41**;Mar 29, 1996;Build 8
ADAR ; ADD A NEW A/AR FOR THIS PATIENT
 S GMRAPA="" F X=0:0 S X=$O(^GMR(120.8,"B",DFN,X)) Q:X'>0  I $S('$D(^GMR(120.8,X,0)):0,$P(^(0),"^",2)=GMRAAR(0):1,1:0),$S('$D(^("ER")):1,1:'+^("ER")) S GMRAPA=X Q
 Q:GMRAPA>0
 I $D(XRTL) D T0^%ZOSV ; START RT
 D NOW^%DTC
 S GMRAAR(1)=+$E(%,1,12),DIC="^GMR(120.8,",DIC(0)="LQ",DLAYGO=120.8
 S DIC("DR")=".02////"_GMRAAR(0)_";1////^S X=GMRAAR;4////"_GMRAAR(1)_";5////"_DUZ_";15///0;17///U;3.1////"_$S($G(GMRAAR("O"))'="":GMRAAR("O"),1:"O"),X=DFN
 K DD,DO D FILE^DICN
 K DIC,DLAYGO S GMRAPA=+Y,GMRANEW=Y>0
 ;S GMRACAUS="RADIOLOGICAL/CONTRAST MEDIA",GMRADRCL=$O(^PS(50.605,"B","DX100",0))_";PS(50.605," ;41 Code not needed
 K GMRAING,GMRADRCL ;41 Removed GMRACAUS and added GMRAING
 I GMRAPA'>0 D  Q  ;Entry is not added
 .   I $D(XRT0) S XRTN=$T(+0) D T1^%ZOSV ; STOP RT IF EXITING HERE
 .   Q
 ;
UPDATE ;Updates entry with drug ingredients and/or drug classes - this API added with patch 17
 ;Start of New code to support Drug Classes
 ;This code section will auto stuff Ings and VA Drug Classes
 ;GMRAING() will have all the Ing for the selected reaction
 ;GMRADRCL() will have all the drug classes for the selected
 ;reaction.
 ;If the Reactant is a Drug Ingrediant
 I GMRAAR[50.416 S GMRAING(+GMRAAR)="" G STING
 ;If the Reacant is a Drug Class
 I GMRAAR[50.605 S GMRADRCL(+GMRAAR)=""
 ;If the Reactant is a entry in the GMR ALLERGY file
 I GMRAAR[120.82 D
 .S Y=0 F  S Y=$O(^GMRD(120.82,+GMRAAR,"ING",Y)) Q:Y'>0  I $D(^GMRD(120.82,+GMRAAR,"ING",Y,0)),+^(0)>0 S GMRAING(+^(0))=""
 .S Y=0 F  S Y=$O(^GMRD(120.82,+GMRAAR,"CLASS",Y)) Q:Y'>0  I $D(^GMRD(120.82,+GMRAAR,"CLASS",Y,0)),+^(0)>0 S GMRADRCL(+^(0))=""
 .Q
 ;41 - Section related to PSDRUG no longer needed
 ;I GMRAAR["PSDRUG" D
 ;.N PSODA
 ;.S PSODA=+GMRAAR K ^TMP("PSO",$J) D ^PSONGR F Y=0:0 S Y=$O(^TMP("PSO",$J,Y)) Q:Y'>0  S GMRAING(Y)=""
 ;.N GMRAX,GMRAY
 ;.S GMRAX=$P($G(^PSDRUG(+GMRAAR,"ND")),U,6) S:GMRAX>0 GMRADRCL(GMRAX)="" Q
 ;.S GMRAX=$P($G(^PSDRUG(+GMRAAR,0)),U,2) Q:GMRAX=""
 ;.S GMRAY=$O(^PS(50.605,"B",GMRAX,"")) S:GMRAY>0 GMRADRCL(GMRAY)=""
 ;.Q
 I GMRAAR["PSNDF" D
 .N PSNDA
 .S PSNDA=+GMRAAR K ^TMP("PSN",$J) D ^PSNNGR F Y=0:0 S Y=$O(^TMP("PSN",$J,Y)) Q:Y'>0  S GMRAING(Y)=""
 .; all classes for NDF entry returned in GMRADRCL
 .N CLASS
 .S CLASS=$$CLIST^PSNAPIS(+GMRAAR,.GMRADRCL)
 .Q
 K ^TMP("PSN",$J),PSOID,PSNID ;41 - Removed K ^TMP("PSO",$J)
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
 I $D(XRT0) S XRTN=$T(+0) D T1^%ZOSV ; STOP RT IF EXITING HERE
 K GMRADRCL,GMRAING
 Q
