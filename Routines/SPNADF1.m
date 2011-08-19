SPNADF1 ;SAN DIEGO/WDE AD HOC REPORTS: INTERFACE FOR THE FUNCTIONAL STATUS FILE (#154.1) ;08/23/96  15:23
 ;;2.0;Spinal Cord Dysfunction;**12,14,15,19,20**;01/02/1997
 ;;2.0;QM Integration Module;;Apr 06, 1994
MENU ; *** Build the menu array
 F SP=1:1 S X=$P($T(TEXT+SP),";",3,99) Q:X=""  D
 . S SPNMENU(SPNMENU)=X,SPNMENU=SPNMENU+1
 . Q
 Q
TEXT ;;*** Sort Yes/No ^ Menu Text ^ ~Field # ^ DIR(0)
 ;;1^Number of Hrs of Hlp^~2.09;"Number Of Hours Of Help"^NAO^-999999999:999999999:9^
 ;;1^Hrs of Hlp Last 24Hrs^~2.13;"Hours Of Help Within Last Day"^NAO^-99999999:999999999:9^
 ;;0^Sensory Kurtzke^~3.3;"Sensory (Kurtzke)"^PAO^154.2:AEMNQZ^D POINTER^SPNAHOC2|I $P(^(0),U,3)=3
 ;;0^Cerebral Kurtzke^~3.4;"Cerebral (Kurtzke)"^PAO^154.2:AEMNQZ^D POINTER^SPNAHOC2|I $P(^(0),U,3)=4
 ;;0^Cerebellar Kurtzke^~3.5;"Cerebellar (Kurtzke)"^PAO^154.2:AEMNQZ^D POINTER^SPNAHOC2|I $P(^(0),U,3)=5
 ;;0^Bwl Blad Funct Kurtzke^~3.6;"Bowel & Bladder Funct (Kurtzke)"^PAO^154.2:AEMNQZ^D POINTER^SPNAHOC2|I $P(^(0),U,3)=6
 ;;0^Visual Kurtzke^~3.7;"Visual (Kurtzke)"^PAO^154.2:AEMNQZ^D POINTER^SPNAHOC2|I $P(^(0),U,3)=7
 ;;0^Other Kurtzke^~3.8;"Other (Kurtzke)"^PAO^154.2:AEMNQZ^D POINTER^SPNAHOC2|I $P(^(0),U,3)=8
 ;;0^Pyramidal Kurtzke^~3.1;"Pyramidal (Kurtzke)"^PAO^154.2:AEMNQZ^D POINTER^SPNAHOC2|I $P(^(0),U,3)=1
 ;;0^Brainstem Kurtzke^~3.2;"Brainstem (Kurtzke)"^PAO^154.2:AEMNQZ^D POINTER^SPNAHOC2|I $P(^(0),U,3)=2
 ;;0^EDSS^~3.9;"EDSS"^PAO^154.2:AEMNQZ^D POINTER^SPNAHOC2|I $P(^(0),U,3)=9
 ;;1^CHART Physical Indep^~4.1;"Physical Independence (CHART)"^NAO^-999999999:999999999:9^
 ;;1^CHART Mobility^~4.2;"Mobility (CHART)"^NAO^-999999999:999999999:9^
 ;;1^CHART Occupation^~4.3;"Occupation (CHART)"^NAO^-999999999:999999999:9^
 ;;1^CHART Social Interact^~4.4;"Social Interaction (CHART)"^NAO^-999999999:999999999:9^
 ;;1^CHART Econ Self Suff^~4.5;"Economic Self Sufficiency (CHART)"^NAO^-999999999:999999999:9^
 ;;1^CHART Cognitive Indep^~4.6;"Cognitive Indep (CHART)"^NAO^-999999999:999999999:9^
 ;;1^CHART Total Score^~999.06;"CHART Total Score"^FAO^1:60^
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
 ;;1^FAM Attention^~5.11;"Attention (FAM)"^PAO^154.11:AEMNQZ^D POINTER^SPNAHOC2|I $P(^(0),U,3)=5
 ;;1^FAM Safety Judgement^~5.12;"Safety Judgement (FAM)"^PAO^154.11:AEMNQZ^D POINTER^SPNAHOC2|I $P(^(0),U,3)=5
 ;;1^Diener Composite Score^~6.01;"Diener Composite Score"^NAO^-999999999:999999999:9^
 ;;1^DUSOI Composite Score^~6.02;"DUSOI Composite Score"^NAO^-999999999:999999999:9^
 ;;1^FIM Motor Score^~999.03;"Motor Score (FIM)"^FAO^1:60^
 ;;1^FIM Cognitive Score^~999.04;"Cognitive Score (FIM)"^FAO^1:60^
 ;;1^FIM Total Score^~999.05;"Total Score (FIM)"^FAO^1:60^
 ;;1^Length of Rehab in Days^~999.08;"Length of Rehab in Days"^FAO^1:60^
 ;;1^ASIA Impairment Scale^~7.01;"ASIA Impairment Scale"^SAOM^A:A;B:B;C:C;D:D;E:E;^D SET^SPNAHOC2
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
