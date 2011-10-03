GMRAPAT ;HIRMFO/WAA-Select a patient for ART System ;10/8/96  15:19
 ;;4.0;Adverse Reaction Tracking;**5**;Mar 29, 1996
PAT ;Select a patient from the patient file
 ;    Return list:
 ;           DFN = If DFN is null patient DFN from the patient file
 ;
 S GMRAOUT=0
 W ! S DIC="^DPT(",DIC(0)="AEQM" D ^DIC
 I +Y'>0 S GMRAOUT=1 Q
 S DFN=+Y,GMRADOD=$P($G(^DPT(DFN,.35)),U)
 ;check if patient is deceased
 I GMRADOD]"" D
 .W !!?5,$C(7),"NOTE: This patient is deceased (",$$FMTE^XLFDT(GMRADOD),").",!!
 .D HANGT^GMRAPEH0
 .Q
 K GMRADOD
 Q
REACT(DFN) ;Select a patient reaction
 ;
 Q:'$D(DFN)
 N GMRAL
 S GMRAOUT=0,GMRAL=""
 D LIST(DFN,.GMRAL)
 I GMRAL D EN1^GMRADSP0(.GMRAL) Q:GMRAOUT
 E  W !?10,"This patient has no allergy/adverse reaction data."
 Q
LIST(DFN,GMRA) ;Get all the reaction for a patient
 N GMRAPA
 S (GMRAPA,GMRA)=0
 F  S GMRAPA=$O(^GMR(120.8,"B",DFN,GMRAPA)) Q:GMRAPA<1  D
 .Q:$G(^GMR(120.8,GMRAPA,0))=""
 .Q:+$G(^GMR(120.8,GMRAPA,"ER"))
 .D PASS^GMRADPT(GMRAPA,.GMRA)
 .I 'GMRA S GMRA=1
 .Q
 Q
