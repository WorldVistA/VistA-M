SPNMISS ;WDE/SAN-DIEGO;CLEANUP REPORT ON MISSING DATA ELEMENTS; 1-18-2005
 ;;2.0;Spinal Cord Dysfunction;**24**;01/02/97
 ;
 ;
EN ;
 W !!,"This report provides a list of patients with missing data in the SCD Registry."
 W !,"Data elements checked are: Registration Status, SCI Network, SSN, Integration"
 W !,"Control Number, Registration Date, and Date of Last Review."
 W !!,"After viewing or printing the report, simply edit the patient records,"
 W !,"inserting information into fields identified as having missing data."
 W !,"Cleaning up such records is important to future development of the Registry.",!!
 K ^TMP($J)
 S SPNLEXIT=""
 S ZTSAVE(DUZ)=""
  D DEVICE^SPNPRTMT("QUED^SPNMISS","SCD Missing Data Report",.ZTSAVE) Q:SPNLEXIT
 Q:POP
 I $G(SPNIO)["Q" Q
QUED ;
 S (SPNCNT)=0
 S DFN=0 F  S DFN=$O(^SPNL(154,DFN)) Q:(DFN=0)!('+DFN)  D
 .S SPNCNT=SPNCNT+1
 .I $E(IOST,1)="C" I SPNCNT#10=0 W "."
 .S PTNAM=$$GET1^DIQ(154,DFN_",",.01)
 .Q:PTNAM=""  ;2-9-05
 .F FIELD=.03,1.1,.02,.05 D TEST
 .F FIELD=991.01,.09 D TTWO  ;check ssn and icn
 .D DUPSSN
 .Q
 D ^SPNMISS2
KILL ;
 K ^TMP($J),DATA,PAGE,STATS,EQ,PTNAM,DFN,SPNCON,SPNDD,SPNSSN,FIELD,SUBCNT,SSN,SPNLEXIT
 K SPNIO,SPNCNT,SS,DUPDFN
 Q
TEST S DATA="",DATA=$$GET1^DIQ(154,DFN_",",FIELD)
 I DATA="" D
 .S SPNDD=$G(^DD(154,FIELD,0)),SPNDD=$P(SPNDD,U,1)
 .I $D(^TMP($J,PTNAM,DFN,0))=0 S ^TMP($J,PTNAM,DFN,0)=""
 .S ^TMP($J,PTNAM,DFN,FIELD)=SPNDD
 Q
TTWO ;test on patient file fields
 S DATA="",DATA=$$GET1^DIQ(2,DFN_",",FIELD)
 I DATA="" D
 .S SPNDD=$G(^DD(2,FIELD,0)),SPNDD=$P(SPNDD,U,1)
 .I $D(^TMP($J,PTNAM,DFN,0))=0 S ^TMP($J,PTNAM,DFN,0)=""
 .S ^TMP($J,PTNAM,DFN,FIELD)=SPNDD
 Q
DUPSSN ;
 S SUBCNT=0 S SSN=$$GET1^DIQ(2,DFN_",",.09)
 S DUPDFN=0 F  S DUPDFN=$O(^DPT("SSN",SSN,DUPDFN)) Q:(DUPDFN=0)!('+DUPDFN)  I DUPDFN'=DFN D
 .S SUBCNT=SUBCNT+1
 .I $D(^TMP($J,PTNAM,DFN,0))=0 S ^TMP($J,PTNAM,DFN,0)=""
 .S ^TMP($J,PTNAM,DFN,"SSN",SUBCNT)=DUPDFN
 .Q
 Q
