PSUOPAM ;BIR/DAM - PSU PBM Outpatient AMIS Pharmacy Data Collection; March 2004 ; 1/11/08 11:46am
 ;;4.0;PHARMACY BENEFITS MANAGEMENT;**13**;MARCH, 2005;Build 3
 ;
 ;DBIA's
 ;Reference to File (#52)     supported by DBIA 1878
 ;
EN ;entry point to gather additional AMIS data.  Called from PSUOP2
 ;
 K PSUAM      ;Array to hold single dose Medication Instructions
 K PSUAMMD    ;Array to hold multidose medication instructions
 K PSUMDFLG   ;Multidose flag
 S (PSUPI,PSUCO,PSUEXP,PSUAM,PSUDSG,PSUDIPU,PSUNITS,PSUNOUN)=""
 S (PSUDUR,PSUCONJ,PSUROUT,PSUSCHED,PSUVERB)=""
 D CO
 D EXP
 D DOSG
 Q
 ;
 ;
CO ;Copay status: found in file (#52), field (#105)
 ;
 ;PSU*4*13 Corrected to show the COPAY.
 S PSUCO=$P($G(^TMP("PSOR",$J,PSURXIEN,"IB")),U,1)
 I $G(PSUCO) S PSUCOPAY="Y"
 I '$G(PSUCO) S PSUCOPAY="N"
 Q
 ;
EXP ;Expanded instructions: found in file (#52), multiple (#113),
 ;sub-field (#.01)
 ;
 S PSUD1=0
 F  S PSUD1=$O(^TMP("PSOR",$J,PSURXIEN,"PI",PSUD1)) Q:PSUD1=""  D
 .I PSUD1=1 S PSUEXP=$E(^TMP("PSOR",$J,PSURXIEN,"PI",PSUD1,0),1,80) D
 ..S PSUPI=$G(PSUEXP)
 .I (PSUD1'=1),($L(PSUEXP)<80) D
 ..S PSUEXP=$E(PSUEXP_" "_^TMP("PSOR",$J,PSURXIEN,"PI",PSUD1,0),1,80)
 ..S PSUPI=$G(PSUEXP)
 ;
 Q
 ;
DOSG ;Dosage data: found in file (#52), multiple (#113).  There are 
 ;nine sub-fields to be pulled: #.01 through #8
 ;
 S PSUD1=0
 F  S PSUD1=$O(^TMP("PSOR",$J,PSURXIEN,"MI",PSUD1)) Q:PSUD1=""  D
 .I PSUD1'=1 S PSUMDFLG="M"       ;Multidose flag
 .I PSUD1=1 D                     ;Single dose/first Multidose data
 ..S PSUAM=^TMP("PSOR",$J,PSURXIEN,"MI",PSUD1,0)
 ..S PSUDSG=$P(PSUAM,U,1)             ;Dosage Ordered
 ..S PSUDISPU=$P(PSUAM,U,2)           ;Dispense Units per Dose
 ..S PSUNITS=$P($P(PSUAM,U,3),";",2)  ;Units
 ..S PSUNOUN=$P(PSUAM,U,4)            ;Noun
 ..S PSUDUR=$P(PSUAM,U,5)             ;Duration
 ..S PSUCONJ=$P(PSUAM,U,6)            ;Conjunction
 ..S PSUROUT=$P($P(PSUAM,U,7),";",2)  ;Route
 ..S PSUSCHED=$P(PSUAM,U,8)           ;Schedule
 ..S PSUVERB=$P(PSUAM,U,9)            ;Verb
 ;
 Q
 ;
MULTI ;Set variables for Multidose Medication Instructions
 ;Called from PSUOP3
 ;
 S (PSUDSGMD,PSUDSPMD,PSUNITMD,PSUNMD)=""
 S (PSURTMD,PSUSCHMD,PSUVRBMD)=""
 ;
 S PSUDSGMD=$P(PSUAMMD,U,1)            ;Dosage Ordered
 S PSUDSPMD=$P(PSUAMMD,U,2)            ;Dispense Units per Dose
 S PSUNITMD=$P($P(PSUAMMD,U,3),";",2)  ;Units
 S PSUNMD=$P(PSUAMMD,U,4)              ;Noun
 S PSUDURMD=$P(PSUAMMD,U,5)            ;Duration
 S PSUCONMD=$P(PSUAMMD,U,6)            ;Conjunction
 S PSURTMD=$P($P(PSUAMMD,U,7),";",2)   ;Route
 S PSUSCHMD=$P(PSUAMMD,U,8)            ;Schedule
 S PSUVRBMD=$P(PSUAMMD,U,9)            ;Verb
 ;
 Q
