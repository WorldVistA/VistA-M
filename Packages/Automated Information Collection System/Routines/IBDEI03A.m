IBDEI03A ; ; 09-FEB-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,3949,1,3,0)
 ;;=3^Abdominal Pain,RLQ
 ;;^UTILITY(U,$J,358.3,3949,1,4,0)
 ;;=4^R10.31
 ;;^UTILITY(U,$J,358.3,3949,2)
 ;;=^5019211
 ;;^UTILITY(U,$J,358.3,3950,0)
 ;;=R10.32^^19^181^2
 ;;^UTILITY(U,$J,358.3,3950,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3950,1,3,0)
 ;;=3^Abdominal Pain,LLQ
 ;;^UTILITY(U,$J,358.3,3950,1,4,0)
 ;;=4^R10.32
 ;;^UTILITY(U,$J,358.3,3950,2)
 ;;=^5019212
 ;;^UTILITY(U,$J,358.3,3951,0)
 ;;=R10.33^^19^181^8
 ;;^UTILITY(U,$J,358.3,3951,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3951,1,3,0)
 ;;=3^Periumbilical Pain
 ;;^UTILITY(U,$J,358.3,3951,1,4,0)
 ;;=4^R10.33
 ;;^UTILITY(U,$J,358.3,3951,2)
 ;;=^5019213
 ;;^UTILITY(U,$J,358.3,3952,0)
 ;;=R10.13^^19^181^7
 ;;^UTILITY(U,$J,358.3,3952,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3952,1,3,0)
 ;;=3^Epigastric Pain
 ;;^UTILITY(U,$J,358.3,3952,1,4,0)
 ;;=4^R10.13
 ;;^UTILITY(U,$J,358.3,3952,2)
 ;;=^5019208
 ;;^UTILITY(U,$J,358.3,3953,0)
 ;;=R10.84^^19^181^1
 ;;^UTILITY(U,$J,358.3,3953,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3953,1,3,0)
 ;;=3^Abdominal Pain,Generalized
 ;;^UTILITY(U,$J,358.3,3953,1,4,0)
 ;;=4^R10.84
 ;;^UTILITY(U,$J,358.3,3953,2)
 ;;=^5019229
 ;;^UTILITY(U,$J,358.3,3954,0)
 ;;=Z48.01^^19^182^4
 ;;^UTILITY(U,$J,358.3,3954,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3954,1,3,0)
 ;;=3^Wound Dressing Change/Removal
 ;;^UTILITY(U,$J,358.3,3954,1,4,0)
 ;;=4^Z48.01
 ;;^UTILITY(U,$J,358.3,3954,2)
 ;;=^5063034
 ;;^UTILITY(U,$J,358.3,3955,0)
 ;;=Z48.02^^19^182^3
 ;;^UTILITY(U,$J,358.3,3955,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3955,1,3,0)
 ;;=3^Suture Removal
 ;;^UTILITY(U,$J,358.3,3955,1,4,0)
 ;;=4^Z48.02
 ;;^UTILITY(U,$J,358.3,3955,2)
 ;;=^5063035
 ;;^UTILITY(U,$J,358.3,3956,0)
 ;;=Z48.812^^19^182^1
 ;;^UTILITY(U,$J,358.3,3956,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3956,1,3,0)
 ;;=3^Circulatory System Surgery Aftercare
 ;;^UTILITY(U,$J,358.3,3956,1,4,0)
 ;;=4^Z48.812
 ;;^UTILITY(U,$J,358.3,3956,2)
 ;;=^5063049
 ;;^UTILITY(U,$J,358.3,3957,0)
 ;;=Z09.^^19^182^2
 ;;^UTILITY(U,$J,358.3,3957,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3957,1,3,0)
 ;;=3^F/U Exam  After Treatment for Condition Oth Than Malig Neop
 ;;^UTILITY(U,$J,358.3,3957,1,4,0)
 ;;=4^Z09.
 ;;^UTILITY(U,$J,358.3,3957,2)
 ;;=^5062668
 ;;^UTILITY(U,$J,358.3,3958,0)
 ;;=I25.10^^19^183^2
 ;;^UTILITY(U,$J,358.3,3958,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3958,1,3,0)
 ;;=3^Athscl Hrt Disease,Native Coronary Artery w/o Ang Pctrs
 ;;^UTILITY(U,$J,358.3,3958,1,4,0)
 ;;=4^I25.10
 ;;^UTILITY(U,$J,358.3,3958,2)
 ;;=^5007107
 ;;^UTILITY(U,$J,358.3,3959,0)
 ;;=I25.110^^19^183^3
 ;;^UTILITY(U,$J,358.3,3959,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3959,1,3,0)
 ;;=3^Athscl Hrt Disease,Native Coronary Artery w/ Unstable Ang Pctrs
 ;;^UTILITY(U,$J,358.3,3959,1,4,0)
 ;;=4^I25.110
 ;;^UTILITY(U,$J,358.3,3959,2)
 ;;=^5007108
 ;;^UTILITY(U,$J,358.3,3960,0)
 ;;=I25.111^^19^183^4
 ;;^UTILITY(U,$J,358.3,3960,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3960,1,3,0)
 ;;=3^Athscl Hrt Disease,Native Coronary Artery w/ Ang Pctrs w/ Spasm
 ;;^UTILITY(U,$J,358.3,3960,1,4,0)
 ;;=4^I25.111
 ;;^UTILITY(U,$J,358.3,3960,2)
 ;;=^5007109
 ;;^UTILITY(U,$J,358.3,3961,0)
 ;;=I25.118^^19^183^5
 ;;^UTILITY(U,$J,358.3,3961,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3961,1,3,0)
 ;;=3^Athscl Hrt Disease,Native Coronary Artery w/ Oth Ang Pctrs
 ;;^UTILITY(U,$J,358.3,3961,1,4,0)
 ;;=4^I25.118
 ;;^UTILITY(U,$J,358.3,3961,2)
 ;;=^5007110
 ;;^UTILITY(U,$J,358.3,3962,0)
 ;;=I25.119^^19^183^6
 ;;^UTILITY(U,$J,358.3,3962,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3962,1,3,0)
 ;;=3^Athscl Hrt Disease,Native Coronary Artery w/ Unspec Ang Pctrs
 ;;^UTILITY(U,$J,358.3,3962,1,4,0)
 ;;=4^I25.119
 ;;^UTILITY(U,$J,358.3,3962,2)
 ;;=^5007111
 ;;^UTILITY(U,$J,358.3,3963,0)
 ;;=I50.9^^19^183^12
 ;;^UTILITY(U,$J,358.3,3963,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3963,1,3,0)
 ;;=3^Heart Failure,Compensated/Uncompensated
 ;;^UTILITY(U,$J,358.3,3963,1,4,0)
 ;;=4^I50.9
 ;;^UTILITY(U,$J,358.3,3963,2)
 ;;=^5007251
 ;;^UTILITY(U,$J,358.3,3964,0)
 ;;=I65.21^^19^183^16
 ;;^UTILITY(U,$J,358.3,3964,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3964,1,3,0)
 ;;=3^Occlusion & Stenosis,Right Carotid Artery
 ;;^UTILITY(U,$J,358.3,3964,1,4,0)
 ;;=4^I65.21
 ;;^UTILITY(U,$J,358.3,3964,2)
 ;;=^5007360
 ;;^UTILITY(U,$J,358.3,3965,0)
 ;;=I65.22^^19^183^14
 ;;^UTILITY(U,$J,358.3,3965,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3965,1,3,0)
 ;;=3^Occlusion & Stenosis,Left Carotid Artery
 ;;^UTILITY(U,$J,358.3,3965,1,4,0)
 ;;=4^I65.22
 ;;^UTILITY(U,$J,358.3,3965,2)
 ;;=^5007361
 ;;^UTILITY(U,$J,358.3,3966,0)
 ;;=I65.23^^19^183^13
 ;;^UTILITY(U,$J,358.3,3966,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3966,1,3,0)
 ;;=3^Occlusion & Stenosis,Bilateral Carotid Arteries
 ;;^UTILITY(U,$J,358.3,3966,1,4,0)
 ;;=4^I65.23
 ;;^UTILITY(U,$J,358.3,3966,2)
 ;;=^5007362
 ;;^UTILITY(U,$J,358.3,3967,0)
 ;;=I65.8^^19^183^15
 ;;^UTILITY(U,$J,358.3,3967,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3967,1,3,0)
 ;;=3^Occlusion & Stenosis,Precerebral Arteries
 ;;^UTILITY(U,$J,358.3,3967,1,4,0)
 ;;=4^I65.8
 ;;^UTILITY(U,$J,358.3,3967,2)
 ;;=^5007364
 ;;^UTILITY(U,$J,358.3,3968,0)
 ;;=I70.211^^19^183^9
 ;;^UTILITY(U,$J,358.3,3968,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3968,1,3,0)
 ;;=3^Athscl Native Arteries,Right Leg w/ Intrmt Claud
 ;;^UTILITY(U,$J,358.3,3968,1,4,0)
 ;;=4^I70.211
 ;;^UTILITY(U,$J,358.3,3968,2)
 ;;=^5007578
 ;;^UTILITY(U,$J,358.3,3969,0)
 ;;=I70.212^^19^183^8
 ;;^UTILITY(U,$J,358.3,3969,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3969,1,3,0)
 ;;=3^Athscl Native Arteries,Left Leg w/ Intrmt Claud
 ;;^UTILITY(U,$J,358.3,3969,1,4,0)
 ;;=4^I70.212
 ;;^UTILITY(U,$J,358.3,3969,2)
 ;;=^5007579
 ;;^UTILITY(U,$J,358.3,3970,0)
 ;;=I70.213^^19^183^7
 ;;^UTILITY(U,$J,358.3,3970,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3970,1,3,0)
 ;;=3^Athscl Native Arteries,Bilat Legs w/ Intrmt Claud
 ;;^UTILITY(U,$J,358.3,3970,1,4,0)
 ;;=4^I70.213
 ;;^UTILITY(U,$J,358.3,3970,2)
 ;;=^5007580
 ;;^UTILITY(U,$J,358.3,3971,0)
 ;;=I71.2^^19^183^21
 ;;^UTILITY(U,$J,358.3,3971,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3971,1,3,0)
 ;;=3^Thoracic Aortic Aneurysm w/o Rupture
 ;;^UTILITY(U,$J,358.3,3971,1,4,0)
 ;;=4^I71.2
 ;;^UTILITY(U,$J,358.3,3971,2)
 ;;=^5007787
 ;;^UTILITY(U,$J,358.3,3972,0)
 ;;=I71.4^^19^183^1
 ;;^UTILITY(U,$J,358.3,3972,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3972,1,3,0)
 ;;=3^Abdominal Aortic Aneurysm w/o Rupture
 ;;^UTILITY(U,$J,358.3,3972,1,4,0)
 ;;=4^I71.4
 ;;^UTILITY(U,$J,358.3,3972,2)
 ;;=^5007789
 ;;^UTILITY(U,$J,358.3,3973,0)
 ;;=I73.9^^19^183^19
 ;;^UTILITY(U,$J,358.3,3973,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3973,1,3,0)
 ;;=3^Peripheral Vascular Disease,Unspec
 ;;^UTILITY(U,$J,358.3,3973,1,4,0)
 ;;=4^I73.9
 ;;^UTILITY(U,$J,358.3,3973,2)
 ;;=^184182
 ;;^UTILITY(U,$J,358.3,3974,0)
 ;;=I74.2^^19^183^11
 ;;^UTILITY(U,$J,358.3,3974,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3974,1,3,0)
 ;;=3^Embolism & Thrombosis Upper Extrem Arteries
 ;;^UTILITY(U,$J,358.3,3974,1,4,0)
 ;;=4^I74.2
 ;;^UTILITY(U,$J,358.3,3974,2)
 ;;=^5007801
 ;;^UTILITY(U,$J,358.3,3975,0)
 ;;=I74.3^^19^183^10
 ;;^UTILITY(U,$J,358.3,3975,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3975,1,3,0)
 ;;=3^Embolism & Thrombosis Lower Extrem Arteries
 ;;^UTILITY(U,$J,358.3,3975,1,4,0)
 ;;=4^I74.3
 ;;^UTILITY(U,$J,358.3,3975,2)
 ;;=^5007802
 ;;^UTILITY(U,$J,358.3,3976,0)
 ;;=M79.604^^19^183^18
 ;;^UTILITY(U,$J,358.3,3976,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3976,1,3,0)
 ;;=3^Pain,Right Leg
 ;;^UTILITY(U,$J,358.3,3976,1,4,0)
 ;;=4^M79.604
 ;;^UTILITY(U,$J,358.3,3976,2)
 ;;=^5013328
 ;;^UTILITY(U,$J,358.3,3977,0)
 ;;=M79.605^^19^183^17
 ;;^UTILITY(U,$J,358.3,3977,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3977,1,3,0)
 ;;=3^Pain,Left Leg
 ;;^UTILITY(U,$J,358.3,3977,1,4,0)
 ;;=4^M79.605
 ;;^UTILITY(U,$J,358.3,3977,2)
 ;;=^5013329
 ;;^UTILITY(U,$J,358.3,3978,0)
 ;;=Z13.6^^19^183^20
 ;;^UTILITY(U,$J,358.3,3978,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3978,1,3,0)
 ;;=3^Screening for Cardiovascular Disorders
 ;;^UTILITY(U,$J,358.3,3978,1,4,0)
 ;;=4^Z13.6
 ;;^UTILITY(U,$J,358.3,3978,2)
 ;;=^5062707
 ;;^UTILITY(U,$J,358.3,3979,0)
 ;;=C77.0^^19^184^1
 ;;^UTILITY(U,$J,358.3,3979,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3979,1,3,0)
 ;;=3^Met Malig Neop Lymph Nodes of Head,Face,Neck
 ;;^UTILITY(U,$J,358.3,3979,1,4,0)
 ;;=4^C77.0
 ;;^UTILITY(U,$J,358.3,3979,2)
 ;;=^5001329
 ;;^UTILITY(U,$J,358.3,3980,0)
 ;;=C77.1^^19^184^12
 ;;^UTILITY(U,$J,358.3,3980,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3980,1,3,0)
 ;;=3^Met Malig Neop of Intrathoracic Lymph Nodes
 ;;^UTILITY(U,$J,358.3,3980,1,4,0)
 ;;=4^C77.1
 ;;^UTILITY(U,$J,358.3,3980,2)
 ;;=^267315
 ;;^UTILITY(U,$J,358.3,3981,0)
 ;;=C77.2^^19^184^10
 ;;^UTILITY(U,$J,358.3,3981,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3981,1,3,0)
 ;;=3^Met Malig Neop of Intra-Abdominal Lymph Nodes
 ;;^UTILITY(U,$J,358.3,3981,1,4,0)
 ;;=4^C77.2
 ;;^UTILITY(U,$J,358.3,3981,2)
 ;;=^267316
 ;;^UTILITY(U,$J,358.3,3982,0)
 ;;=C77.3^^19^184^2
 ;;^UTILITY(U,$J,358.3,3982,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3982,1,3,0)
 ;;=3^Met Malig Neop of Axilla & Upper Limb Lymph Nodes
 ;;^UTILITY(U,$J,358.3,3982,1,4,0)
 ;;=4^C77.3
 ;;^UTILITY(U,$J,358.3,3982,2)
 ;;=^5001330
 ;;^UTILITY(U,$J,358.3,3983,0)
 ;;=C77.4^^19^184^9
 ;;^UTILITY(U,$J,358.3,3983,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3983,1,3,0)
 ;;=3^Met Malig Neop of Inguinal & Lower Limb Lymph Nodes
 ;;^UTILITY(U,$J,358.3,3983,1,4,0)
 ;;=4^C77.4
 ;;^UTILITY(U,$J,358.3,3983,2)
 ;;=^5001331
 ;;^UTILITY(U,$J,358.3,3984,0)
 ;;=C77.5^^19^184^11
 ;;^UTILITY(U,$J,358.3,3984,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3984,1,3,0)
 ;;=3^Met Malig Neop of Intrapelvic Lymph Nodes
 ;;^UTILITY(U,$J,358.3,3984,1,4,0)
 ;;=4^C77.5
