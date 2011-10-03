GMRAOR2 ;HIRMFO/RM-OERR UTILITIES ; 11/29/07 12:17pm
 ;;4.0;Adverse Reaction Tracking;**21,41**;Mar 29, 1996;Build 8
EN1(IEN,ARRAY) ; This entry point returns detailed information about a
 ; particular patient allergy/adverse reaction.
 ; Input Variables
 ;       IEN = The internal entry number of the reaction in file 120.8
 ;     ARRAY = The array that the reaction data is to be passed back in.
 ;             (Note: The return array cannot be the GMRAL array.)
 Q:$G(IEN)=""
 S ARRAY=$S($G(ARRAY)'="":ARRAY,1:"GMRACT") Q:ARRAY="GMRAL"
 N GMRAPA,GMRAOTH,GMRAL,GMRAI
 S GMRAPA=IEN,GMRAPA(0)=$G(^GMR(120.8,GMRAPA,0)) Q:GMRAPA(0)=""
 ; Set up GMRAL variable
 S GMRAL=$P(GMRAPA(0),U,2)_U
 S GMRAL=GMRAL_$S($P(GMRAPA(0),U,5)'="":$$GET1^DIQ(200,$P(GMRAPA(0),U,5)_",",".01"),1:"<None>")_U ;21
 S %=$S($P(GMRAPA(0),U,5)'="":$$GET1^DIQ(200,$P(GMRAPA(0),U,5)_",","8","I"),1:"") ;21
 S GMRAL=GMRAL_$S(%>1:$P($G(^DIC(3.1,%,0)),U),1:"")_U
 S GMRAL=GMRAL_$S($P(GMRAPA(0),U,16)=1:"",1:"NOT ")_"VERIFIED"_U
 S GMRAL=GMRAL_$S($P(GMRAPA(0),U,6)="o":"OBSERVED",$P(GMRAPA(0),U,6)="h":"HISTORICAL",1:"")_U
 S GMRAL=GMRAL_$S($P(GMRAPA(0),U,14)="A":"ALLERGY",$P(GMRAPA(0),U,14)="P":"PHARMACOLOGIC",$P(GMRAPA(0),U,14)="U":"UNKNOWN",1:"")_U
 S GMRAL=GMRAL_$$OUTTYPE^GMRAUTL($P(GMRAPA(0),U,20))_U_$S($P(GMRAPA(0),U,16)&('$P(GMRAPA(0),U,18)):"<auto-verified>",1:$$GET1^DIQ(200,$P(GMRAPA(0),U,18)_",",.01))_U_$P(GMRAPA(0),U,17) ;21
 S GMRAL=GMRAL_U_$$FMTE^XLFDT($P(GMRAPA(0),U,4)) ;21 add orig date/time
 ;Set up Comments in to GMRAL("C",
 S GMRAI=0 F %=1:1 S GMRAI=$O(^GMR(120.8,GMRAPA,26,GMRAI)) Q:GMRAI<1  D
 .N GMRACOM
 .S GMRACOM=$G(^GMR(120.8,GMRAPA,26,GMRAI,0)) Q:GMRACOM=""
 .S GMRAL("C",%)=$P(GMRACOM,U)_U_$S($P(GMRACOM,U,3)="V":"VERIFIER",$P(GMRACOM,U,3)="O":"ORIGINATOR",1:"")_U_$$GET1^DIQ(200,$P(GMRACOM,U,2)_",",.01) ;21
 .M GMRAL("C",%)=^GMR(120.8,GMRAPA,26,GMRAI,2)
 .Q
 ;Observer information from file 120.85
 S GMRAI=0 F %=1:1 S GMRAI=$O(^GMR(120.85,"C",GMRAPA,GMRAI)) Q:GMRAI<1  D
 .N GMRACOM
 .S GMRACOM=$G(^GMR(120.85,GMRAI,0)) Q:GMRACOM=""
 .S GMRAL("O",%)=$P(GMRACOM,U)_U_$S($P(GMRACOM,U,14)=1:"MILD",$P(GMRACOM,U,14)=2:"MODERATE",$P(GMRACOM,U,14)=3:"SEVERE",1:"")
 .Q
 ;Signs/Symptoms
 S GMRAOTH=$O(^GMRD(120.83,"B","OTHER REACTION",0))
 S GMRAI=0 F %=1:1 S GMRAI=$O(^GMR(120.8,GMRAPA,10,GMRAI)) Q:GMRAI<1  D
 .N GMRAZ
 .S GMRAZ=$G(^GMR(120.8,GMRAPA,10,GMRAI,0)) Q:GMRAZ=""
 .S GMRAL("S",%)=$S(+GMRAZ'=GMRAOTH:$P($G(^GMRD(120.83,+GMRAZ,0)),U),1:$P(GMRAZ,U,2))_$S($P(GMRAZ,U,4)'="":" ("_$$FMTE^XLFDT($P(GMRAZ,U,4),2)_")",1:"") ;21
 .Q
 ;VA Drug Class
 S GMRAI=0 F %=1:1 S GMRAI=$O(^GMR(120.8,GMRAPA,3,GMRAI)) Q:GMRAI<1  D
 .N GMRACOM
 .S GMRACOM=$G(^GMR(120.8,GMRAPA,3,GMRAI,0)) Q:GMRACOM=""
 .;S GMRAL("V",%)=$P($G(^PS(50.605,GMRACOM,0)),U,1,2)
 .S GMRAL("V",%)=$$CLP2CLDA^GMRAPENC(GMRACOM)
 .Q
 ;Drug Ingredients
 S GMRAI=0 F %=1:1 S GMRAI=$O(^GMR(120.8,GMRAPA,2,GMRAI)) Q:GMRAI<1  D
 .N GMRACOM
 .S GMRACOM=$G(^GMR(120.8,GMRAPA,2,GMRAI,0)) Q:GMRACOM=""
 .;S GMRAL("I",%)=$P($G(^PS(50.416,GMRACOM,0)),U)
 .S GMRAL("I",%)=$$INP2INNA^GMRAPENC(GMRACOM)
 .Q
 M @ARRAY=GMRAL
 Q
