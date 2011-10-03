SPNADF5 ;SAN DIEGO/WDE/ AD HOC REPORTS: OUTCOMES  FILE (#154.1) ;08/23/96  15:23
 ;;2.0;Spinal Cord Dysfunction;**14,15,19,20**;01/02/1997
 ;;2.0;QM Integration Module;;Apr 06, 1994
 ; *** Set up required and optional variables and call Ad Hoc Rpt Gen
 S SPNMRTN="MENU^SPNADF5",SPNORTN="OTHER^SPNADF",SPNDIC=154.1
 S SPNMHDR="ASIA"
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
 ;;1^Score Type^~.021;"Score Type"^PAO^154.3:AEMNQZ^D POINTER^SPNAHOC2
 ;;1^Division^~.023;"Division"^FAO^1:5
 ;;1^Disposition^~.024;"Disposition"^PAO^154.12:AEMNQZ^D POINTER^SPNAHOC2
 ;;1^Respondent Type^~.03;"Respondent Type"^SAOM^1:PATIENT;2:CLINICIAN;3:PROXY;^D SET^SPNAHOC2
 ;;1^Date Recorded^~.04;"Date Recorded"^DAO^::AETS^D DATE^SPNAHOC2
 ;;1^Motor Score^~7.02;"Total Motor Score"^NAO^-999999999:999999999:^
 ;;1^Pin Prick Score^~7.03;"Total Pin Prick Score"^NAO^-999999999:999999999:9^
 ;;1^Light Touch Score^~7.04;"Total Light Touch Score"^NAO^-99999999:999999999:9^
 ;;1^Neurolevel-Sensory R^~7.05;"Neurolevel-Sensory Right"^PAO^154.01:AEMNQZ^D POINTER^SPNAHOC2|I "^C01^S05^UNK^"'[(U_$P(^(0),U)_U)
 ;;1^Neurolevel-Sensory L^~7.06;"Neurolevel-Sensory Left"^PAO^154.01:AEMNQZ^D POINTER^SPNAHOC2|I "^C01^S05^UNK^"'[(U_$P(^(0),U)_U)
 ;;1^Neurolevel-Motor R^~7.07;"Neurolevel-Motor Right"^PAO^154.01:AEMNQZ^D POINTER^SPNAHOC2|N SPNL S SPNL=$TR($P(^(0),U),"CTLS","1234") I ((SPNL'<105)&(SPNL'>108))!(SPNL=201)!(SPNL'<302)&(SPNL'>305))!(SPNL=401)
 ;;1^Neurolevel-Motor L^~7.08;"Neurolevel-Motor Left"^PAO^154.01:AEMNQZ^D POINTER^SPNAHOC2|N SPNL S SPNL=$TR($P(^(0),U),"CTLS","1234") I ((SPNL'<105)&(SPNL'>108))!(SPNL=201)!(SPNL'<302)&(SPNL'>305))!(SPNL=401)
 ;;1^Complete/Incomplete^~7.09;"ASIA Complete/Incomplete"^SAOM^C:COMPLETE;I:INCOMPLETE;^D SET^SPNAHOC2
 ;;1^Partial Pres-Sensory R^~7.1;"Partial Preservation-Sensory R"^PAO^154.01:AEMNQZ^D POINTER^SPNAHOC2|I "^C01^S05^UNK^"'[(U_$P(^(0),U)_U)
 ;;1^Partial Pres-Sensory L^~7.11;"Partial Preservation-Sensory L"^PAO^154.01:AEMNQZ^D POINTER^SPNAHOC2|I "^C01^S05^UNK^"'[(U_$P(^(0),U)_U)
 ;;1^Partial Pres-Motor R^~7.12;"Partial Preservation-Motor R"^PAO^154.01:AEMNQZ^D POINTER^SPNAHOC2|N SPNL S SPNL=$TR($P(^(0),U),"CTLS","1234") I ((SPNL'<105)&(SPNL'>108))!(SPNL=201)!(SPNL'<302)&(SPNL'>305))!(SPNL=401)
 ;;1^Partial Pres-Motor L^~7.13;"Partial Preservation-Motor L"^PAO^154.01:AEMNQZ^D POINTER^SPNAHOC2|N SPNL S SPNL=$TR($P(^(0),U),"CTLS","1234") I ((SPNL'<105)&(SPNL'>108))!(SPNL=201)!(SPNL'<302)&(SPNL'>305))!(SPNL=401)
 ;;1^Highest Neuro Level^~7.14;"ASIA Highest Neuro Level"^PAO^154.01:AEMNQZ^D POINTER^SPNAHOC2
 ;;1^Impairment Scale^~7.01;"ASIA Impairment Scale"^SAOM^A:A;B:B;C:C;D:D;E:E;^D SET^SPNAHOC2
