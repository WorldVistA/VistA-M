IBDEI080 ; ; 01-AUG-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;AUG 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,19502,1,3,0)
 ;;=3^Spondyls w/ Radiculopathy,Lumbar Region
 ;;^UTILITY(U,$J,358.3,19502,1,4,0)
 ;;=4^M47.26
 ;;^UTILITY(U,$J,358.3,19502,2)
 ;;=^5012065
 ;;^UTILITY(U,$J,358.3,19503,0)
 ;;=M47.27^^65^795^65
 ;;^UTILITY(U,$J,358.3,19503,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19503,1,3,0)
 ;;=3^Spondyls w/ Radiculopathy,Lumbosacral Region
 ;;^UTILITY(U,$J,358.3,19503,1,4,0)
 ;;=4^M47.27
 ;;^UTILITY(U,$J,358.3,19503,2)
 ;;=^5012066
 ;;^UTILITY(U,$J,358.3,19504,0)
 ;;=M47.28^^65^795^66
 ;;^UTILITY(U,$J,358.3,19504,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19504,1,3,0)
 ;;=3^Spondyls w/ Radiculopathy,Sacral/Sacroccygeal Region
 ;;^UTILITY(U,$J,358.3,19504,1,4,0)
 ;;=4^M47.28
 ;;^UTILITY(U,$J,358.3,19504,2)
 ;;=^5012067
 ;;^UTILITY(U,$J,358.3,19505,0)
 ;;=M48.02^^65^795^48
 ;;^UTILITY(U,$J,358.3,19505,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19505,1,3,0)
 ;;=3^Spinal Stenosis,Cervical Region
 ;;^UTILITY(U,$J,358.3,19505,1,4,0)
 ;;=4^M48.02
 ;;^UTILITY(U,$J,358.3,19505,2)
 ;;=^5012089
 ;;^UTILITY(U,$J,358.3,19506,0)
 ;;=M48.03^^65^795^49
 ;;^UTILITY(U,$J,358.3,19506,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19506,1,3,0)
 ;;=3^Spinal Stenosis,Cervicothoracic Region
 ;;^UTILITY(U,$J,358.3,19506,1,4,0)
 ;;=4^M48.03
 ;;^UTILITY(U,$J,358.3,19506,2)
 ;;=^5012090
 ;;^UTILITY(U,$J,358.3,19507,0)
 ;;=M48.04^^65^795^54
 ;;^UTILITY(U,$J,358.3,19507,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19507,1,3,0)
 ;;=3^Spinal Stenosis,Thoracic Region
 ;;^UTILITY(U,$J,358.3,19507,1,4,0)
 ;;=4^M48.04
 ;;^UTILITY(U,$J,358.3,19507,2)
 ;;=^5012091
 ;;^UTILITY(U,$J,358.3,19508,0)
 ;;=M48.05^^65^795^55
 ;;^UTILITY(U,$J,358.3,19508,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19508,1,3,0)
 ;;=3^Spinal Stenosis,Thoracolumbar Region
 ;;^UTILITY(U,$J,358.3,19508,1,4,0)
 ;;=4^M48.05
 ;;^UTILITY(U,$J,358.3,19508,2)
 ;;=^5012092
 ;;^UTILITY(U,$J,358.3,19509,0)
 ;;=M48.07^^65^795^52
 ;;^UTILITY(U,$J,358.3,19509,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19509,1,3,0)
 ;;=3^Spinal Stenosis,Lumbosacral Region
 ;;^UTILITY(U,$J,358.3,19509,1,4,0)
 ;;=4^M48.07
 ;;^UTILITY(U,$J,358.3,19509,2)
 ;;=^5012094
 ;;^UTILITY(U,$J,358.3,19510,0)
 ;;=M48.08^^65^795^53
 ;;^UTILITY(U,$J,358.3,19510,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19510,1,3,0)
 ;;=3^Spinal Stenosis,Sacrococcygeal Region
 ;;^UTILITY(U,$J,358.3,19510,1,4,0)
 ;;=4^M48.08
 ;;^UTILITY(U,$J,358.3,19510,2)
 ;;=^5012095
 ;;^UTILITY(U,$J,358.3,19511,0)
 ;;=R47.01^^65^796^1
 ;;^UTILITY(U,$J,358.3,19511,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19511,1,3,0)
 ;;=3^Aphasia NEC
 ;;^UTILITY(U,$J,358.3,19511,1,4,0)
 ;;=4^R47.01
 ;;^UTILITY(U,$J,358.3,19511,2)
 ;;=^5019488
 ;;^UTILITY(U,$J,358.3,19512,0)
 ;;=I69.920^^65^796^5
 ;;^UTILITY(U,$J,358.3,19512,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19512,1,3,0)
 ;;=3^Aphasia after unspec cerebrovascular disease
 ;;^UTILITY(U,$J,358.3,19512,1,4,0)
 ;;=4^I69.920
 ;;^UTILITY(U,$J,358.3,19512,2)
 ;;=^5007553
 ;;^UTILITY(U,$J,358.3,19513,0)
 ;;=I69.991^^65^796^10
 ;;^UTILITY(U,$J,358.3,19513,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19513,1,3,0)
 ;;=3^Dysphagia after unspec cerebrovascular disease
 ;;^UTILITY(U,$J,358.3,19513,1,4,0)
 ;;=4^I69.991
 ;;^UTILITY(U,$J,358.3,19513,2)
 ;;=^5007569
 ;;^UTILITY(U,$J,358.3,19514,0)
 ;;=I69.952^^65^796^18
 ;;^UTILITY(U,$J,358.3,19514,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19514,1,3,0)
 ;;=3^Hemiplegia after Unsp Crbvasc Dis,Left Dominant Side
 ;;^UTILITY(U,$J,358.3,19514,1,4,0)
 ;;=4^I69.952
 ;;^UTILITY(U,$J,358.3,19514,2)
 ;;=^5133586
 ;;^UTILITY(U,$J,358.3,19515,0)
 ;;=I69.954^^65^796^19
 ;;^UTILITY(U,$J,358.3,19515,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19515,1,3,0)
 ;;=3^Hemiplegia after Unsp Crbvasc Dis,Left Nondominant Side
 ;;^UTILITY(U,$J,358.3,19515,1,4,0)
 ;;=4^I69.954
 ;;^UTILITY(U,$J,358.3,19515,2)
 ;;=^5133587
 ;;^UTILITY(U,$J,358.3,19516,0)
 ;;=I69.951^^65^796^20
 ;;^UTILITY(U,$J,358.3,19516,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19516,1,3,0)
 ;;=3^Hemiplegia after Unsp Crbvasc Dis,Right Dominant Side
 ;;^UTILITY(U,$J,358.3,19516,1,4,0)
 ;;=4^I69.951
 ;;^UTILITY(U,$J,358.3,19516,2)
 ;;=^5007561
 ;;^UTILITY(U,$J,358.3,19517,0)
 ;;=I69.953^^65^796^21
 ;;^UTILITY(U,$J,358.3,19517,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19517,1,3,0)
 ;;=3^Hemiplegia after Unsp Crbvasc Dis,Right Nondominant Side
 ;;^UTILITY(U,$J,358.3,19517,1,4,0)
 ;;=4^I69.953
 ;;^UTILITY(U,$J,358.3,19517,2)
 ;;=^5007562
 ;;^UTILITY(U,$J,358.3,19518,0)
 ;;=G81.92^^65^796^22
 ;;^UTILITY(U,$J,358.3,19518,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19518,1,3,0)
 ;;=3^Hemiplegia,Unspec Affecting Left Dominant Side
 ;;^UTILITY(U,$J,358.3,19518,1,4,0)
 ;;=4^G81.92
 ;;^UTILITY(U,$J,358.3,19518,2)
 ;;=^5004122
 ;;^UTILITY(U,$J,358.3,19519,0)
 ;;=G81.94^^65^796^23
 ;;^UTILITY(U,$J,358.3,19519,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19519,1,3,0)
 ;;=3^Hemiplegia,Unspec Affecting Left Nondominant Side
 ;;^UTILITY(U,$J,358.3,19519,1,4,0)
 ;;=4^G81.94
 ;;^UTILITY(U,$J,358.3,19519,2)
 ;;=^5004124
 ;;^UTILITY(U,$J,358.3,19520,0)
 ;;=G81.91^^65^796^24
 ;;^UTILITY(U,$J,358.3,19520,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19520,1,3,0)
 ;;=3^Hemiplegia,Unspec Affecting Right Dominant Side
 ;;^UTILITY(U,$J,358.3,19520,1,4,0)
 ;;=4^G81.91
 ;;^UTILITY(U,$J,358.3,19520,2)
 ;;=^5004121
 ;;^UTILITY(U,$J,358.3,19521,0)
 ;;=G81.93^^65^796^25
 ;;^UTILITY(U,$J,358.3,19521,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19521,1,3,0)
 ;;=3^Hemiplegia,Unspec Affecting Right Nondominant Side
 ;;^UTILITY(U,$J,358.3,19521,1,4,0)
 ;;=4^G81.93
 ;;^UTILITY(U,$J,358.3,19521,2)
 ;;=^5004123
 ;;^UTILITY(U,$J,358.3,19522,0)
 ;;=I69.942^^65^796^42
 ;;^UTILITY(U,$J,358.3,19522,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19522,1,3,0)
 ;;=3^Monoplg LL after Unsp Crbvasc Dis,Left Dominant Side
 ;;^UTILITY(U,$J,358.3,19522,1,4,0)
 ;;=4^I69.942
 ;;^UTILITY(U,$J,358.3,19522,2)
 ;;=^5133582
 ;;^UTILITY(U,$J,358.3,19523,0)
 ;;=I69.944^^65^796^43
 ;;^UTILITY(U,$J,358.3,19523,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19523,1,3,0)
 ;;=3^Monoplg LL after Unsp Crbvasc Dis,Left Nondominant Side
 ;;^UTILITY(U,$J,358.3,19523,1,4,0)
 ;;=4^I69.944
 ;;^UTILITY(U,$J,358.3,19523,2)
 ;;=^5133585
 ;;^UTILITY(U,$J,358.3,19524,0)
 ;;=I69.941^^65^796^44
 ;;^UTILITY(U,$J,358.3,19524,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19524,1,3,0)
 ;;=3^Monoplg LL after Unsp Crbvasc Dis,Right Dominant Side
 ;;^UTILITY(U,$J,358.3,19524,1,4,0)
 ;;=4^I69.941
 ;;^UTILITY(U,$J,358.3,19524,2)
 ;;=^5133581
 ;;^UTILITY(U,$J,358.3,19525,0)
 ;;=I69.943^^65^796^45
 ;;^UTILITY(U,$J,358.3,19525,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19525,1,3,0)
 ;;=3^Monoplg LL after Unsp Crbvasc Dis,Right Nondominant Side
 ;;^UTILITY(U,$J,358.3,19525,1,4,0)
 ;;=4^I69.943
 ;;^UTILITY(U,$J,358.3,19525,2)
 ;;=^5133584
 ;;^UTILITY(U,$J,358.3,19526,0)
 ;;=G35.^^65^796^46
 ;;^UTILITY(U,$J,358.3,19526,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19526,1,3,0)
 ;;=3^Multiple sclerosis
 ;;^UTILITY(U,$J,358.3,19526,1,4,0)
 ;;=4^G35.
 ;;^UTILITY(U,$J,358.3,19526,2)
 ;;=^79761
 ;;^UTILITY(U,$J,358.3,19527,0)
 ;;=G20.^^65^796^47
 ;;^UTILITY(U,$J,358.3,19527,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19527,1,3,0)
 ;;=3^Parkinson's disease
 ;;^UTILITY(U,$J,358.3,19527,1,4,0)
 ;;=4^G20.
 ;;^UTILITY(U,$J,358.3,19527,2)
 ;;=^5003770
 ;;^UTILITY(U,$J,358.3,19528,0)
 ;;=R56.9^^65^796^6
 ;;^UTILITY(U,$J,358.3,19528,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19528,1,3,0)
 ;;=3^Convulsions,Unspec
 ;;^UTILITY(U,$J,358.3,19528,1,4,0)
 ;;=4^R56.9
 ;;^UTILITY(U,$J,358.3,19528,2)
 ;;=^5019524
 ;;^UTILITY(U,$J,358.3,19529,0)
 ;;=S06.9X5S^^65^796^26
 ;;^UTILITY(U,$J,358.3,19529,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19529,1,3,0)
 ;;=3^Intcrn injury w LOC >24 hr w ret consc lev, sequela
 ;;^UTILITY(U,$J,358.3,19529,1,4,0)
 ;;=4^S06.9X5S
 ;;^UTILITY(U,$J,358.3,19529,2)
 ;;=^5021223
 ;;^UTILITY(U,$J,358.3,19530,0)
 ;;=S06.9X6S^^65^796^27
 ;;^UTILITY(U,$J,358.3,19530,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19530,1,3,0)
 ;;=3^Intcrn injury w LOC >24 hr w/o ret consc w surv, sqla
 ;;^UTILITY(U,$J,358.3,19530,1,4,0)
 ;;=4^S06.9X6S
 ;;^UTILITY(U,$J,358.3,19530,2)
 ;;=^5021226
 ;;^UTILITY(U,$J,358.3,19531,0)
 ;;=S06.9X3S^^65^796^28
 ;;^UTILITY(U,$J,358.3,19531,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19531,1,3,0)
 ;;=3^Intcrn injury w LOC of 1-5 hrs 59 min, sequela
 ;;^UTILITY(U,$J,358.3,19531,1,4,0)
 ;;=4^S06.9X3S
 ;;^UTILITY(U,$J,358.3,19531,2)
 ;;=^5021217
 ;;^UTILITY(U,$J,358.3,19532,0)
 ;;=S06.9X1S^^65^796^29
 ;;^UTILITY(U,$J,358.3,19532,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19532,1,3,0)
 ;;=3^Intcrn injury w LOC of 30 minutes or less, sequela
 ;;^UTILITY(U,$J,358.3,19532,1,4,0)
 ;;=4^S06.9X1S
 ;;^UTILITY(U,$J,358.3,19532,2)
 ;;=^5021211
 ;;^UTILITY(U,$J,358.3,19533,0)
 ;;=S06.9X2S^^65^796^30
 ;;^UTILITY(U,$J,358.3,19533,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19533,1,3,0)
 ;;=3^Intcrn injury w LOC of 31-59 min, sequela
 ;;^UTILITY(U,$J,358.3,19533,1,4,0)
 ;;=4^S06.9X2S
 ;;^UTILITY(U,$J,358.3,19533,2)
 ;;=^5021214
 ;;^UTILITY(U,$J,358.3,19534,0)
 ;;=S06.9X4S^^65^796^31
 ;;^UTILITY(U,$J,358.3,19534,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19534,1,3,0)
 ;;=3^Intcrn injury w LOC of 6-24 hrs, sequela
 ;;^UTILITY(U,$J,358.3,19534,1,4,0)
 ;;=4^S06.9X4S
 ;;^UTILITY(U,$J,358.3,19534,2)
 ;;=^5021220
 ;;^UTILITY(U,$J,358.3,19535,0)
 ;;=S06.9X9S^^65^796^32
 ;;^UTILITY(U,$J,358.3,19535,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19535,1,3,0)
 ;;=3^Intcrn injury w LOC of unsp duration, sequela
 ;;^UTILITY(U,$J,358.3,19535,1,4,0)
 ;;=4^S06.9X9S
 ;;^UTILITY(U,$J,358.3,19535,2)
 ;;=^5021235
 ;;^UTILITY(U,$J,358.3,19536,0)
 ;;=S06.9X0S^^65^796^33
 ;;^UTILITY(U,$J,358.3,19536,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19536,1,3,0)
 ;;=3^Intcrn injury w/o LOC, sequela
 ;;^UTILITY(U,$J,358.3,19536,1,4,0)
 ;;=4^S06.9X0S
 ;;^UTILITY(U,$J,358.3,19536,2)
 ;;=^5021208
 ;;^UTILITY(U,$J,358.3,19537,0)
 ;;=G11.10^^65^796^12
 ;;^UTILITY(U,$J,358.3,19537,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19537,1,3,0)
 ;;=3^Early-Onset Cerebellar Ataxia,Unspec
 ;;^UTILITY(U,$J,358.3,19537,1,4,0)
 ;;=4^G11.10
 ;;^UTILITY(U,$J,358.3,19537,2)
 ;;=^5159151
 ;;^UTILITY(U,$J,358.3,19538,0)
 ;;=G11.11^^65^796^13
 ;;^UTILITY(U,$J,358.3,19538,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19538,1,3,0)
 ;;=3^Friedreich Ataxia
 ;;^UTILITY(U,$J,358.3,19538,1,4,0)
 ;;=4^G11.11
 ;;^UTILITY(U,$J,358.3,19538,2)
 ;;=^5159152
 ;;^UTILITY(U,$J,358.3,19539,0)
 ;;=G11.19^^65^796^11
 ;;^UTILITY(U,$J,358.3,19539,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19539,1,3,0)
 ;;=3^Early-Onset Cerebellar Ataxia,Oth
 ;;^UTILITY(U,$J,358.3,19539,1,4,0)
 ;;=4^G11.19
 ;;^UTILITY(U,$J,358.3,19539,2)
 ;;=^5159153
 ;;^UTILITY(U,$J,358.3,19540,0)
 ;;=I69.020^^65^796^4
 ;;^UTILITY(U,$J,358.3,19540,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19540,1,3,0)
 ;;=3^Aphasia after non-traumatic SAH
 ;;^UTILITY(U,$J,358.3,19540,1,4,0)
 ;;=4^I69.020
 ;;^UTILITY(U,$J,358.3,19540,2)
 ;;=^5007395
 ;;^UTILITY(U,$J,358.3,19541,0)
 ;;=I69.120^^65^796^3
 ;;^UTILITY(U,$J,358.3,19541,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19541,1,3,0)
 ;;=3^Aphasia after non-traumatic ICH
 ;;^UTILITY(U,$J,358.3,19541,1,4,0)
 ;;=4^I69.120
 ;;^UTILITY(U,$J,358.3,19541,2)
 ;;=^5007427
 ;;^UTILITY(U,$J,358.3,19542,0)
 ;;=I69.320^^65^796^2
 ;;^UTILITY(U,$J,358.3,19542,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19542,1,3,0)
 ;;=3^Aphasia after cerebral infarction
 ;;^UTILITY(U,$J,358.3,19542,1,4,0)
 ;;=4^I69.320
 ;;^UTILITY(U,$J,358.3,19542,2)
 ;;=^5007491
 ;;^UTILITY(U,$J,358.3,19543,0)
 ;;=I69.091^^65^796^9
 ;;^UTILITY(U,$J,358.3,19543,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19543,1,3,0)
 ;;=3^Dysphagia after non-traumatic SAH
 ;;^UTILITY(U,$J,358.3,19543,1,4,0)
 ;;=4^I69.091
 ;;^UTILITY(U,$J,358.3,19543,2)
 ;;=^5007421
 ;;^UTILITY(U,$J,358.3,19544,0)
 ;;=I69.191^^65^796^8
 ;;^UTILITY(U,$J,358.3,19544,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19544,1,3,0)
 ;;=3^Dysphagia after non-traumatic ICH
 ;;^UTILITY(U,$J,358.3,19544,1,4,0)
 ;;=4^I69.191
 ;;^UTILITY(U,$J,358.3,19544,2)
 ;;=^5007453
 ;;^UTILITY(U,$J,358.3,19545,0)
 ;;=I69.391^^65^796^7
 ;;^UTILITY(U,$J,358.3,19545,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19545,1,3,0)
 ;;=3^Dysphagia after cerebral infaction
 ;;^UTILITY(U,$J,358.3,19545,1,4,0)
 ;;=4^I69.391
 ;;^UTILITY(U,$J,358.3,19545,2)
 ;;=^5007516
 ;;^UTILITY(U,$J,358.3,19546,0)
 ;;=I69.351^^65^796^16
 ;;^UTILITY(U,$J,358.3,19546,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19546,1,3,0)
 ;;=3^Hemiplegia after CVA-Rt dominant side
 ;;^UTILITY(U,$J,358.3,19546,1,4,0)
 ;;=4^I69.351
 ;;^UTILITY(U,$J,358.3,19546,2)
 ;;=^5007504
 ;;^UTILITY(U,$J,358.3,19547,0)
 ;;=I69.352^^65^796^14
 ;;^UTILITY(U,$J,358.3,19547,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19547,1,3,0)
 ;;=3^Hemiplegia after CVA-Lt dominant side
 ;;^UTILITY(U,$J,358.3,19547,1,4,0)
 ;;=4^I69.352
 ;;^UTILITY(U,$J,358.3,19547,2)
 ;;=^5007505
 ;;^UTILITY(U,$J,358.3,19548,0)
 ;;=I69.353^^65^796^17
 ;;^UTILITY(U,$J,358.3,19548,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19548,1,3,0)
 ;;=3^Hemiplegia after CVA-Rt non-dominant side
 ;;^UTILITY(U,$J,358.3,19548,1,4,0)
 ;;=4^I69.353
 ;;^UTILITY(U,$J,358.3,19548,2)
 ;;=^5007506
 ;;^UTILITY(U,$J,358.3,19549,0)
 ;;=I69.354^^65^796^15
 ;;^UTILITY(U,$J,358.3,19549,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19549,1,3,0)
 ;;=3^Hemiplegia after CVA-Lt non-dominant side
 ;;^UTILITY(U,$J,358.3,19549,1,4,0)
 ;;=4^I69.354
 ;;^UTILITY(U,$J,358.3,19549,2)
 ;;=^5007507
 ;;^UTILITY(U,$J,358.3,19550,0)
 ;;=I69.331^^65^796^40
 ;;^UTILITY(U,$J,358.3,19550,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19550,1,3,0)
 ;;=3^Monoplegia Upper Limb after CVA-Rt Dominant Side
 ;;^UTILITY(U,$J,358.3,19550,1,4,0)
 ;;=4^I69.331
 ;;^UTILITY(U,$J,358.3,19550,2)
 ;;=^5007496
 ;;^UTILITY(U,$J,358.3,19551,0)
 ;;=I69.332^^65^796^38
 ;;^UTILITY(U,$J,358.3,19551,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19551,1,3,0)
 ;;=3^Monoplegia Upper Limb after CVA-Lt Dominant Side
 ;;^UTILITY(U,$J,358.3,19551,1,4,0)
 ;;=4^I69.332
 ;;^UTILITY(U,$J,358.3,19551,2)
 ;;=^5007497
 ;;^UTILITY(U,$J,358.3,19552,0)
 ;;=I69.333^^65^796^41
 ;;^UTILITY(U,$J,358.3,19552,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19552,1,3,0)
 ;;=3^Monoplegia Upper Limb after CVA-Rt Non-Dominant Side
 ;;^UTILITY(U,$J,358.3,19552,1,4,0)
 ;;=4^I69.333
 ;;^UTILITY(U,$J,358.3,19552,2)
 ;;=^5007498
 ;;^UTILITY(U,$J,358.3,19553,0)
 ;;=I69.334^^65^796^39
 ;;^UTILITY(U,$J,358.3,19553,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19553,1,3,0)
 ;;=3^Monoplegia Upper Limb after CVA-Lt Non-Dominant Side
 ;;^UTILITY(U,$J,358.3,19553,1,4,0)
 ;;=4^I69.334
 ;;^UTILITY(U,$J,358.3,19553,2)
 ;;=^5007499
 ;;^UTILITY(U,$J,358.3,19554,0)
 ;;=I69.341^^65^796^36
 ;;^UTILITY(U,$J,358.3,19554,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19554,1,3,0)
 ;;=3^Monoplegia Lower Limb after CVA-Rt Dominant Side
 ;;^UTILITY(U,$J,358.3,19554,1,4,0)
 ;;=4^I69.341
 ;;^UTILITY(U,$J,358.3,19554,2)
 ;;=^5007501
 ;;^UTILITY(U,$J,358.3,19555,0)
 ;;=I69.342^^65^796^34
 ;;^UTILITY(U,$J,358.3,19555,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19555,1,3,0)
 ;;=3^Monoplegia Lower Limb after CVA-Lt Dominant Side
 ;;^UTILITY(U,$J,358.3,19555,1,4,0)
 ;;=4^I69.342
 ;;^UTILITY(U,$J,358.3,19555,2)
 ;;=^5133575
 ;;^UTILITY(U,$J,358.3,19556,0)
 ;;=I69.343^^65^796^37
 ;;^UTILITY(U,$J,358.3,19556,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19556,1,3,0)
 ;;=3^Monoplegia Lower Limb after CVA-Rt Non-Dominant Side
 ;;^UTILITY(U,$J,358.3,19556,1,4,0)
 ;;=4^I69.343
 ;;^UTILITY(U,$J,358.3,19556,2)
 ;;=^5007502
 ;;^UTILITY(U,$J,358.3,19557,0)
 ;;=I69.344^^65^796^35
 ;;^UTILITY(U,$J,358.3,19557,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19557,1,3,0)
 ;;=3^Monoplegia Lower Limb after CVA-Lt Non-Dominant Side
 ;;^UTILITY(U,$J,358.3,19557,1,4,0)
 ;;=4^I69.344
 ;;^UTILITY(U,$J,358.3,19557,2)
 ;;=^5133576
 ;;^UTILITY(U,$J,358.3,19558,0)
 ;;=I25.10^^65^797^7
 ;;^UTILITY(U,$J,358.3,19558,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19558,1,3,0)
 ;;=3^Athscl Hrt Dis of Nat Cor Artery w/o Ang Pctrs
 ;;^UTILITY(U,$J,358.3,19558,1,4,0)
 ;;=4^I25.10
 ;;^UTILITY(U,$J,358.3,19558,2)
 ;;=^5007107
 ;;^UTILITY(U,$J,358.3,19559,0)
 ;;=J44.1^^65^797^19
 ;;^UTILITY(U,$J,358.3,19559,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19559,1,3,0)
 ;;=3^COPD w/ Acute Exacerbation
 ;;^UTILITY(U,$J,358.3,19559,1,4,0)
 ;;=4^J44.1
 ;;^UTILITY(U,$J,358.3,19559,2)
 ;;=^5008240
 ;;^UTILITY(U,$J,358.3,19560,0)
 ;;=J44.9^^65^797^21
 ;;^UTILITY(U,$J,358.3,19560,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19560,1,3,0)
 ;;=3^COPD,Unspec
 ;;^UTILITY(U,$J,358.3,19560,1,4,0)
 ;;=4^J44.9
 ;;^UTILITY(U,$J,358.3,19560,2)
 ;;=^5008241
 ;;^UTILITY(U,$J,358.3,19561,0)
 ;;=Z98.61^^65^797^23
 ;;^UTILITY(U,$J,358.3,19561,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19561,1,3,0)
 ;;=3^Coronary angioplasty status
 ;;^UTILITY(U,$J,358.3,19561,1,4,0)
 ;;=4^Z98.61
 ;;^UTILITY(U,$J,358.3,19561,2)
 ;;=^5063742
 ;;^UTILITY(U,$J,358.3,19562,0)
 ;;=J43.9^^65^797^24
 ;;^UTILITY(U,$J,358.3,19562,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19562,1,3,0)
 ;;=3^Emphysema, unspecified
 ;;^UTILITY(U,$J,358.3,19562,1,4,0)
 ;;=4^J43.9
 ;;^UTILITY(U,$J,358.3,19562,2)
 ;;=^5008238
 ;;^UTILITY(U,$J,358.3,19563,0)
 ;;=Z82.49^^65^797^26
 ;;^UTILITY(U,$J,358.3,19563,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19563,1,3,0)
 ;;=3^Family Hx of Ischemic Hrt Dis/Oth Circ System Dis
 ;;^UTILITY(U,$J,358.3,19563,1,4,0)
 ;;=4^Z82.49
 ;;^UTILITY(U,$J,358.3,19563,2)
 ;;=^5063369
 ;;^UTILITY(U,$J,358.3,19564,0)
 ;;=I50.9^^65^797^27
 ;;^UTILITY(U,$J,358.3,19564,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19564,1,3,0)
 ;;=3^Heart failure, unspecified
 ;;^UTILITY(U,$J,358.3,19564,1,4,0)
 ;;=4^I50.9
 ;;^UTILITY(U,$J,358.3,19564,2)
 ;;=^5007251
 ;;^UTILITY(U,$J,358.3,19565,0)
 ;;=I25.2^^65^797^28
 ;;^UTILITY(U,$J,358.3,19565,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19565,1,3,0)
 ;;=3^Old myocardial infarction
 ;;^UTILITY(U,$J,358.3,19565,1,4,0)
 ;;=4^I25.2
 ;;^UTILITY(U,$J,358.3,19565,2)
 ;;=^259884
 ;;^UTILITY(U,$J,358.3,19566,0)
 ;;=I42.8^^65^797^22
 ;;^UTILITY(U,$J,358.3,19566,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19566,1,3,0)
 ;;=3^Cardiomyopathies NEC
 ;;^UTILITY(U,$J,358.3,19566,1,4,0)
 ;;=4^I42.8
 ;;^UTILITY(U,$J,358.3,19566,2)
 ;;=^5007199
 ;;^UTILITY(U,$J,358.3,19567,0)
 ;;=I42.5^^65^797^32
 ;;^UTILITY(U,$J,358.3,19567,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19567,1,3,0)
 ;;=3^Restrictive Cardiomyopathy NEC
 ;;^UTILITY(U,$J,358.3,19567,1,4,0)
 ;;=4^I42.5
 ;;^UTILITY(U,$J,358.3,19567,2)
 ;;=^5007196
 ;;^UTILITY(U,$J,358.3,19568,0)
 ;;=Z95.1^^65^797^29
 ;;^UTILITY(U,$J,358.3,19568,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19568,1,3,0)
 ;;=3^Presence of aortocoronary bypass graft
 ;;^UTILITY(U,$J,358.3,19568,1,4,0)
 ;;=4^Z95.1
 ;;^UTILITY(U,$J,358.3,19568,2)
 ;;=^5063669
