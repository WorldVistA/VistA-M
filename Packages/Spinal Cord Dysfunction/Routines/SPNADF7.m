SPNADF7 ;SAN DIEGO/WDE AD HOC REPORTS: INTERFACE FOR THE FUNCTIONAL STATUS FILE (#154.1) ;08/23/96  15:23
 ;;2.0;Spinal Cord Dysfunction;**19,20**;01/02/1997
 ;;2.0;QM Integration Module;;Apr 06, 1994
 ; *** Set up required and optional variables and call Ad Hoc Rpt Gen
 S SPNMRTN="MENU^SPNADF7",SPNORTN="OTHER^SPNADF",SPNDIC=154.1
 S SPNMHDR="FAM"
 D ^SPNAHOC0
 Q
MENU ; *** Build the menu array
 S SPNMENU=1
 F SP=1:1 S X=$P($T(TEXT+SP),";",3,99) Q:X=""  D
 . S SPNMENU(SPNMENU)=X,SPNMENU=SPNMENU+1
 . Q
OTHER ; *** Set up other (optional) EN1^DIP variables
 S DIS(0)="I $$EN2^SPNPRTMT(+$P($G(^SPNL(154.1,D0,0)),U))"
 S DISUPNO=0
 Q
TEXT ;;*** Sort Yes/No ^ Menu Text ^ ~Field # ^ DIR(0)           
 ;;1^Patient^~.01;"Patient"^PAO^2:AEMNQZ^D POINTER^SPNAHOC2
 ;;1^SSN^~999.01^FAO^1:60^
 ;;1^Date of Birth^~999.02;"Date Of Birth"^DAO^::AETS^D DATE^SPNAHOC2
 ;;1^Date of Death^~999.09;"Date Of Death"^DAO^::AETS^D DATE^SPNAHOC2
 ;;1^Age^~999.025;"Age"^FAO^1:60^
 ;;1^Care Type^1003;"Care Type"^SAOM^1:INPATIENT;2:OUTPATIENT;3:ANNUAL EVALUATION;4:CONTINUUM OF CARE;^D SET^SPNAHOC2
 ;;1^Care Start Date^~1001;"Care Start Date"^DAO^::AETS^D DATE^SPNAHOC2
 ;;1^Care End Date^~1002;"Care End Date"^DAO^::AETS^D DATE^SPNAHOC2
 ;;0^Record Type^~.02;"Record Type"^SAOM^1:Self Report of Function;2:FIM;3:ASIA;4:CHART;5:FAM;6:DIENER;7:DUSOI;8:Multiple Sclerosis;^D SET^SPNAHOC2
 ;;1^Score Type^.021;"Score Type"^PAO^154.3:AEMNQZ^D POINTER^SPNAHOC2
 ;;1^Division^~.023;"Division"^FAO^1:5
 ;;1^Disposition^~.024;"Disposition"^PAO^154.12:AEMNQZ^D POINTER^SPNAHOC2
 ;;1^Respondent Type^~.03;"Respondent Type"^SAOM^1:PATIENT;2:CLINICIAN;3:PROXY;^D SET^SPNAHOC2
 ;;1^Date Recorded^~.04;"Date Recorded"^DAO^::AETS^D DATE^SPNAHOC2
 ;;1^FAM Swallowing^~5.01;"Swallowing (FAM)"^PAO^154.11:AEMNQZ^D POINTER^SPNAHOC2|I $P(^(0),U,3)=5
 ;;1^FAM Car Transfers^~5.02;"Car Transfers (FAM)"^PAO^154.11:AEMNQZ^D POINTER^SPNAHOC2|I $P(^(0),U,3)=5
 ;;1^FAM Community Access^~5.03;"Community Access (FAM)"^PAO^154.11:AEMNQZ^D POINTER^SPNAHOC2|I $P(^(0),U,3)=5
 ;;1^FAM Reading^~5.04;"Reading (FAM)"^PAO^154.11:AEMNQZ^D POINTER^SPNAHOC2|I $P(^(0),U,3)=5
 ;;1^FAM Writing^~5.05;"Writing (FAM)"^PAO^154.11:AEMNQZ^D POINTER^SPNAHOC2|I $P(^(0),U,3)=5
 ;;1^FAM Speech Intel^~5.06;"Speech Intelligibility (FAM)"^PAO^154.11:AEMNQZ^D POINTER^SPNAHOC2|I $P(^(0),U,3)=5
 ;;1^FAM Emotional Status^~5.07;"Emotional Status (FAM)"^PAO^154.11:AEMNQZ^D POINTER^SPNAHOC2|I $P(^(0),U,3)=5
 ;;1^FAM Adj to Limitations^~5.08;"Adjustment To Limitations (FAM)"^PAO^154.11:AEMNQZ^D POINTER^SPNAHOC2|I $P(^(0),U,3)=5
 ;;1^FAM Employability^~5.09;"Employability (FAM)"^PAO^154.11:AEMNQZ^D POINTER^SPNAHOC2|I $P(^(0),U,3)=5
 ;;1^FAM Orientation^~5.1;"Orientation (FAM)"^PAO^154.11:AEMNQZ^D POINTER^SPNAHOC2|I $P(^(0),U,3)=5
 ;;1^FAM Attention Span^~5.11;"Attention (FAM)"^PAO^154.11:AEMNQZ^D POINTER^ER^SPNAHOC2|I $P(^(0),U,3)=5
 ;;1^FAM Safety Judgement^~5.12;"Safety Judgement (FAM)"^PAO^154.11:AEMNQZ^D POINTER^SPNAHOC2|I $P(^(0),U,3)=5
