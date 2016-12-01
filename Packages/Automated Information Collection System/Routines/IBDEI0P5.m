IBDEI0P5 ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,31879,1,3,0)
 ;;=3^Traumatic spondylopathy, cervicothoracic region
 ;;^UTILITY(U,$J,358.3,31879,1,4,0)
 ;;=4^M48.33
 ;;^UTILITY(U,$J,358.3,31879,2)
 ;;=^5012117
 ;;^UTILITY(U,$J,358.3,31880,0)
 ;;=M48.34^^94^1404^61
 ;;^UTILITY(U,$J,358.3,31880,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31880,1,3,0)
 ;;=3^Traumatic spondylopathy, thoracic region
 ;;^UTILITY(U,$J,358.3,31880,1,4,0)
 ;;=4^M48.34
 ;;^UTILITY(U,$J,358.3,31880,2)
 ;;=^5012118
 ;;^UTILITY(U,$J,358.3,31881,0)
 ;;=R47.01^^94^1405^1
 ;;^UTILITY(U,$J,358.3,31881,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31881,1,3,0)
 ;;=3^Aphasia
 ;;^UTILITY(U,$J,358.3,31881,1,4,0)
 ;;=4^R47.01
 ;;^UTILITY(U,$J,358.3,31881,2)
 ;;=^5019488
 ;;^UTILITY(U,$J,358.3,31882,0)
 ;;=I69.920^^94^1405^2
 ;;^UTILITY(U,$J,358.3,31882,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31882,1,3,0)
 ;;=3^Aphasia following unspecified cerebrovascular disease
 ;;^UTILITY(U,$J,358.3,31882,1,4,0)
 ;;=4^I69.920
 ;;^UTILITY(U,$J,358.3,31882,2)
 ;;=^5007553
 ;;^UTILITY(U,$J,358.3,31883,0)
 ;;=I69.91^^94^1405^3
 ;;^UTILITY(U,$J,358.3,31883,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31883,1,3,0)
 ;;=3^Cognitive deficits following unsp cerebrovascular disease
 ;;^UTILITY(U,$J,358.3,31883,1,4,0)
 ;;=4^I69.91
 ;;^UTILITY(U,$J,358.3,31883,2)
 ;;=^5007552
 ;;^UTILITY(U,$J,358.3,31884,0)
 ;;=I69.991^^94^1405^5
 ;;^UTILITY(U,$J,358.3,31884,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31884,1,3,0)
 ;;=3^Dysphagia following unspecified cerebrovascular disease
 ;;^UTILITY(U,$J,358.3,31884,1,4,0)
 ;;=4^I69.991
 ;;^UTILITY(U,$J,358.3,31884,2)
 ;;=^5007569
 ;;^UTILITY(U,$J,358.3,31885,0)
 ;;=G11.1^^94^1405^6
 ;;^UTILITY(U,$J,358.3,31885,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31885,1,3,0)
 ;;=3^Early-onset cerebellar ataxia
 ;;^UTILITY(U,$J,358.3,31885,1,4,0)
 ;;=4^G11.1
 ;;^UTILITY(U,$J,358.3,31885,2)
 ;;=^5003753
 ;;^UTILITY(U,$J,358.3,31886,0)
 ;;=I69.952^^94^1405^11
 ;;^UTILITY(U,$J,358.3,31886,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31886,1,3,0)
 ;;=3^Hemiplga fol unsp cerebvasc disease aff left dominant side
 ;;^UTILITY(U,$J,358.3,31886,1,4,0)
 ;;=4^I69.952
 ;;^UTILITY(U,$J,358.3,31886,2)
 ;;=^5133586
 ;;^UTILITY(U,$J,358.3,31887,0)
 ;;=I69.954^^94^1405^12
 ;;^UTILITY(U,$J,358.3,31887,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31887,1,3,0)
 ;;=3^Hemiplga fol unsp cerebvasc disease aff left nondom side
 ;;^UTILITY(U,$J,358.3,31887,1,4,0)
 ;;=4^I69.954
 ;;^UTILITY(U,$J,358.3,31887,2)
 ;;=^5133587
 ;;^UTILITY(U,$J,358.3,31888,0)
 ;;=I69.951^^94^1405^13
 ;;^UTILITY(U,$J,358.3,31888,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31888,1,3,0)
 ;;=3^Hemiplga fol unsp cerebvasc disease aff right dominant side
 ;;^UTILITY(U,$J,358.3,31888,1,4,0)
 ;;=4^I69.951
 ;;^UTILITY(U,$J,358.3,31888,2)
 ;;=^5007561
 ;;^UTILITY(U,$J,358.3,31889,0)
 ;;=I69.953^^94^1405^14
 ;;^UTILITY(U,$J,358.3,31889,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31889,1,3,0)
 ;;=3^Hemiplga fol unsp cerebvasc disease aff right nondom side
 ;;^UTILITY(U,$J,358.3,31889,1,4,0)
 ;;=4^I69.953
 ;;^UTILITY(U,$J,358.3,31889,2)
 ;;=^5007562
 ;;^UTILITY(U,$J,358.3,31890,0)
 ;;=G81.92^^94^1405^7
 ;;^UTILITY(U,$J,358.3,31890,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31890,1,3,0)
 ;;=3^Hemiplegia, unspecified affecting left dominant side
 ;;^UTILITY(U,$J,358.3,31890,1,4,0)
 ;;=4^G81.92
 ;;^UTILITY(U,$J,358.3,31890,2)
 ;;=^5004122
 ;;^UTILITY(U,$J,358.3,31891,0)
 ;;=G81.94^^94^1405^8
 ;;^UTILITY(U,$J,358.3,31891,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31891,1,3,0)
 ;;=3^Hemiplegia, unspecified affecting left nondominant side
 ;;^UTILITY(U,$J,358.3,31891,1,4,0)
 ;;=4^G81.94
 ;;^UTILITY(U,$J,358.3,31891,2)
 ;;=^5004124
 ;;^UTILITY(U,$J,358.3,31892,0)
 ;;=G81.91^^94^1405^9
 ;;^UTILITY(U,$J,358.3,31892,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31892,1,3,0)
 ;;=3^Hemiplegia, unspecified affecting right dominant side
 ;;^UTILITY(U,$J,358.3,31892,1,4,0)
 ;;=4^G81.91
 ;;^UTILITY(U,$J,358.3,31892,2)
 ;;=^5004121
 ;;^UTILITY(U,$J,358.3,31893,0)
 ;;=G81.93^^94^1405^10
 ;;^UTILITY(U,$J,358.3,31893,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31893,1,3,0)
 ;;=3^Hemiplegia, unspecified affecting right nondominant side
 ;;^UTILITY(U,$J,358.3,31893,1,4,0)
 ;;=4^G81.93
 ;;^UTILITY(U,$J,358.3,31893,2)
 ;;=^5004123
 ;;^UTILITY(U,$J,358.3,31894,0)
 ;;=I69.942^^94^1405^23
 ;;^UTILITY(U,$J,358.3,31894,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31894,1,3,0)
 ;;=3^Monoplg low lmb fol unsp cerebvasc dis aff left dom side
 ;;^UTILITY(U,$J,358.3,31894,1,4,0)
 ;;=4^I69.942
 ;;^UTILITY(U,$J,358.3,31894,2)
 ;;=^5133582
 ;;^UTILITY(U,$J,358.3,31895,0)
 ;;=I69.944^^94^1405^24
 ;;^UTILITY(U,$J,358.3,31895,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31895,1,3,0)
 ;;=3^Monoplg low lmb fol unsp cerebvasc dis aff left nondom side
 ;;^UTILITY(U,$J,358.3,31895,1,4,0)
 ;;=4^I69.944
 ;;^UTILITY(U,$J,358.3,31895,2)
 ;;=^5133585
 ;;^UTILITY(U,$J,358.3,31896,0)
 ;;=I69.941^^94^1405^25
 ;;^UTILITY(U,$J,358.3,31896,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31896,1,3,0)
 ;;=3^Monoplg low lmb fol unsp cerebvasc dis aff right dom side
 ;;^UTILITY(U,$J,358.3,31896,1,4,0)
 ;;=4^I69.941
 ;;^UTILITY(U,$J,358.3,31896,2)
 ;;=^5133581
 ;;^UTILITY(U,$J,358.3,31897,0)
 ;;=I69.943^^94^1405^26
 ;;^UTILITY(U,$J,358.3,31897,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31897,1,3,0)
 ;;=3^Monoplg low lmb fol unsp cerebvasc dis aff right nondom side
 ;;^UTILITY(U,$J,358.3,31897,1,4,0)
 ;;=4^I69.943
 ;;^UTILITY(U,$J,358.3,31897,2)
 ;;=^5133584
 ;;^UTILITY(U,$J,358.3,31898,0)
 ;;=G35.^^94^1405^27
 ;;^UTILITY(U,$J,358.3,31898,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31898,1,3,0)
 ;;=3^Multiple sclerosis
 ;;^UTILITY(U,$J,358.3,31898,1,4,0)
 ;;=4^G35.
 ;;^UTILITY(U,$J,358.3,31898,2)
 ;;=^79761
 ;;^UTILITY(U,$J,358.3,31899,0)
 ;;=G20.^^94^1405^28
 ;;^UTILITY(U,$J,358.3,31899,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31899,1,3,0)
 ;;=3^Parkinson's disease
 ;;^UTILITY(U,$J,358.3,31899,1,4,0)
 ;;=4^G20.
 ;;^UTILITY(U,$J,358.3,31899,2)
 ;;=^5003770
 ;;^UTILITY(U,$J,358.3,31900,0)
 ;;=R56.9^^94^1405^4
 ;;^UTILITY(U,$J,358.3,31900,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31900,1,3,0)
 ;;=3^Convulsions,Unspec
 ;;^UTILITY(U,$J,358.3,31900,1,4,0)
 ;;=4^R56.9
 ;;^UTILITY(U,$J,358.3,31900,2)
 ;;=^5019524
 ;;^UTILITY(U,$J,358.3,31901,0)
 ;;=S06.9X5S^^94^1405^15
 ;;^UTILITY(U,$J,358.3,31901,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31901,1,3,0)
 ;;=3^Intcrn injury w LOC >24 hr w ret consc lev, sequela
 ;;^UTILITY(U,$J,358.3,31901,1,4,0)
 ;;=4^S06.9X5S
 ;;^UTILITY(U,$J,358.3,31901,2)
 ;;=^5021223
 ;;^UTILITY(U,$J,358.3,31902,0)
 ;;=S06.9X6S^^94^1405^16
 ;;^UTILITY(U,$J,358.3,31902,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31902,1,3,0)
 ;;=3^Intcrn injury w LOC >24 hr w/o ret consc w surv, sqla
 ;;^UTILITY(U,$J,358.3,31902,1,4,0)
 ;;=4^S06.9X6S
 ;;^UTILITY(U,$J,358.3,31902,2)
 ;;=^5021226
 ;;^UTILITY(U,$J,358.3,31903,0)
 ;;=S06.9X3S^^94^1405^17
 ;;^UTILITY(U,$J,358.3,31903,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31903,1,3,0)
 ;;=3^Intcrn injury w LOC of 1-5 hrs 59 min, sequela
 ;;^UTILITY(U,$J,358.3,31903,1,4,0)
 ;;=4^S06.9X3S
 ;;^UTILITY(U,$J,358.3,31903,2)
 ;;=^5021217
 ;;^UTILITY(U,$J,358.3,31904,0)
 ;;=S06.9X1S^^94^1405^18
 ;;^UTILITY(U,$J,358.3,31904,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31904,1,3,0)
 ;;=3^Intcrn injury w LOC of 30 minutes or less, sequela
 ;;^UTILITY(U,$J,358.3,31904,1,4,0)
 ;;=4^S06.9X1S
 ;;^UTILITY(U,$J,358.3,31904,2)
 ;;=^5021211
 ;;^UTILITY(U,$J,358.3,31905,0)
 ;;=S06.9X2S^^94^1405^19
 ;;^UTILITY(U,$J,358.3,31905,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31905,1,3,0)
 ;;=3^Intcrn injury w LOC of 31-59 min, sequela
 ;;^UTILITY(U,$J,358.3,31905,1,4,0)
 ;;=4^S06.9X2S
 ;;^UTILITY(U,$J,358.3,31905,2)
 ;;=^5021214
 ;;^UTILITY(U,$J,358.3,31906,0)
 ;;=S06.9X4S^^94^1405^20
 ;;^UTILITY(U,$J,358.3,31906,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31906,1,3,0)
 ;;=3^Intcrn injury w LOC of 6-24 hrs, sequela
 ;;^UTILITY(U,$J,358.3,31906,1,4,0)
 ;;=4^S06.9X4S
 ;;^UTILITY(U,$J,358.3,31906,2)
 ;;=^5021220
 ;;^UTILITY(U,$J,358.3,31907,0)
 ;;=S06.9X9S^^94^1405^21
 ;;^UTILITY(U,$J,358.3,31907,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31907,1,3,0)
 ;;=3^Intcrn injury w LOC of unsp duration, sequela
 ;;^UTILITY(U,$J,358.3,31907,1,4,0)
 ;;=4^S06.9X9S
 ;;^UTILITY(U,$J,358.3,31907,2)
 ;;=^5021235
 ;;^UTILITY(U,$J,358.3,31908,0)
 ;;=S06.9X0S^^94^1405^22
 ;;^UTILITY(U,$J,358.3,31908,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31908,1,3,0)
 ;;=3^Intcrn injury w/o LOC, sequela
 ;;^UTILITY(U,$J,358.3,31908,1,4,0)
 ;;=4^S06.9X0S
 ;;^UTILITY(U,$J,358.3,31908,2)
 ;;=^5021208
 ;;^UTILITY(U,$J,358.3,31909,0)
 ;;=I25.10^^94^1406^1
 ;;^UTILITY(U,$J,358.3,31909,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31909,1,3,0)
 ;;=3^Athscl heart disease of native coronary artery w/o ang pctrs
 ;;^UTILITY(U,$J,358.3,31909,1,4,0)
 ;;=4^I25.10
 ;;^UTILITY(U,$J,358.3,31909,2)
 ;;=^5007107
 ;;^UTILITY(U,$J,358.3,31910,0)
 ;;=J44.1^^94^1406^3
 ;;^UTILITY(U,$J,358.3,31910,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31910,1,3,0)
 ;;=3^COPD w acute exacerbation
 ;;^UTILITY(U,$J,358.3,31910,1,4,0)
 ;;=4^J44.1
 ;;^UTILITY(U,$J,358.3,31910,2)
 ;;=^5008240
 ;;^UTILITY(U,$J,358.3,31911,0)
 ;;=J44.9^^94^1406^4
 ;;^UTILITY(U,$J,358.3,31911,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31911,1,3,0)
 ;;=3^COPD, unspecified
 ;;^UTILITY(U,$J,358.3,31911,1,4,0)
 ;;=4^J44.9
 ;;^UTILITY(U,$J,358.3,31911,2)
 ;;=^5008241
 ;;^UTILITY(U,$J,358.3,31912,0)
 ;;=Z98.61^^94^1406^6
 ;;^UTILITY(U,$J,358.3,31912,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31912,1,3,0)
 ;;=3^Coronary angioplasty status
 ;;^UTILITY(U,$J,358.3,31912,1,4,0)
 ;;=4^Z98.61
 ;;^UTILITY(U,$J,358.3,31912,2)
 ;;=^5063742
 ;;^UTILITY(U,$J,358.3,31913,0)
 ;;=J43.9^^94^1406^7
 ;;^UTILITY(U,$J,358.3,31913,1,0)
 ;;=^358.31IA^4^2
