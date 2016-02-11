IBDEI2W5 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,48543,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48543,1,3,0)
 ;;=3^Chronic combined systolic and diastolic hrt fail
 ;;^UTILITY(U,$J,358.3,48543,1,4,0)
 ;;=4^I50.42
 ;;^UTILITY(U,$J,358.3,48543,2)
 ;;=^5007249
 ;;^UTILITY(U,$J,358.3,48544,0)
 ;;=I50.32^^216^2408^15
 ;;^UTILITY(U,$J,358.3,48544,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48544,1,3,0)
 ;;=3^Chronic diastolic (congestive) heart failure
 ;;^UTILITY(U,$J,358.3,48544,1,4,0)
 ;;=4^I50.32
 ;;^UTILITY(U,$J,358.3,48544,2)
 ;;=^5007245
 ;;^UTILITY(U,$J,358.3,48545,0)
 ;;=J44.1^^216^2408^16
 ;;^UTILITY(U,$J,358.3,48545,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48545,1,3,0)
 ;;=3^Chronic obstructive pulmonary disease w (acute) exacerbation
 ;;^UTILITY(U,$J,358.3,48545,1,4,0)
 ;;=4^J44.1
 ;;^UTILITY(U,$J,358.3,48545,2)
 ;;=^5008240
 ;;^UTILITY(U,$J,358.3,48546,0)
 ;;=J44.9^^216^2408^17
 ;;^UTILITY(U,$J,358.3,48546,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48546,1,3,0)
 ;;=3^Chronic obstructive pulmonary disease, unspecified
 ;;^UTILITY(U,$J,358.3,48546,1,4,0)
 ;;=4^J44.9
 ;;^UTILITY(U,$J,358.3,48546,2)
 ;;=^5008241
 ;;^UTILITY(U,$J,358.3,48547,0)
 ;;=I50.22^^216^2408^18
 ;;^UTILITY(U,$J,358.3,48547,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48547,1,3,0)
 ;;=3^Chronic systolic (congestive) heart failure
 ;;^UTILITY(U,$J,358.3,48547,1,4,0)
 ;;=4^I50.22
 ;;^UTILITY(U,$J,358.3,48547,2)
 ;;=^5007241
 ;;^UTILITY(U,$J,358.3,48548,0)
 ;;=Z98.61^^216^2408^20
 ;;^UTILITY(U,$J,358.3,48548,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48548,1,3,0)
 ;;=3^Coronary angioplasty status
 ;;^UTILITY(U,$J,358.3,48548,1,4,0)
 ;;=4^Z98.61
 ;;^UTILITY(U,$J,358.3,48548,2)
 ;;=^5063742
 ;;^UTILITY(U,$J,358.3,48549,0)
 ;;=I42.0^^216^2408^22
 ;;^UTILITY(U,$J,358.3,48549,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48549,1,3,0)
 ;;=3^Dilated cardiomyopathy
 ;;^UTILITY(U,$J,358.3,48549,1,4,0)
 ;;=4^I42.0
 ;;^UTILITY(U,$J,358.3,48549,2)
 ;;=^5007194
 ;;^UTILITY(U,$J,358.3,48550,0)
 ;;=J43.9^^216^2408^23
 ;;^UTILITY(U,$J,358.3,48550,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48550,1,3,0)
 ;;=3^Emphysema, unspecified
 ;;^UTILITY(U,$J,358.3,48550,1,4,0)
 ;;=4^J43.9
 ;;^UTILITY(U,$J,358.3,48550,2)
 ;;=^5008238
 ;;^UTILITY(U,$J,358.3,48551,0)
 ;;=Z82.49^^216^2408^24
 ;;^UTILITY(U,$J,358.3,48551,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48551,1,3,0)
 ;;=3^Family hx of ischem heart dis and oth dis of the circ sys
 ;;^UTILITY(U,$J,358.3,48551,1,4,0)
 ;;=4^Z82.49
 ;;^UTILITY(U,$J,358.3,48551,2)
 ;;=^5063369
 ;;^UTILITY(U,$J,358.3,48552,0)
 ;;=I50.9^^216^2408^25
 ;;^UTILITY(U,$J,358.3,48552,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48552,1,3,0)
 ;;=3^Heart failure, unspecified
 ;;^UTILITY(U,$J,358.3,48552,1,4,0)
 ;;=4^I50.9
 ;;^UTILITY(U,$J,358.3,48552,2)
 ;;=^5007251
 ;;^UTILITY(U,$J,358.3,48553,0)
 ;;=I25.2^^216^2408^27
 ;;^UTILITY(U,$J,358.3,48553,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48553,1,3,0)
 ;;=3^Old myocardial infarction
 ;;^UTILITY(U,$J,358.3,48553,1,4,0)
 ;;=4^I25.2
 ;;^UTILITY(U,$J,358.3,48553,2)
 ;;=^259884
 ;;^UTILITY(U,$J,358.3,48554,0)
 ;;=I42.8^^216^2408^12
 ;;^UTILITY(U,$J,358.3,48554,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48554,1,3,0)
 ;;=3^Cardiomyopathies NEC
 ;;^UTILITY(U,$J,358.3,48554,1,4,0)
 ;;=4^I42.8
 ;;^UTILITY(U,$J,358.3,48554,2)
 ;;=^5007199
 ;;^UTILITY(U,$J,358.3,48555,0)
 ;;=I42.2^^216^2408^26
 ;;^UTILITY(U,$J,358.3,48555,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48555,1,3,0)
 ;;=3^Hypertrophic cardiomyopathy NEC
 ;;^UTILITY(U,$J,358.3,48555,1,4,0)
 ;;=4^I42.2
 ;;^UTILITY(U,$J,358.3,48555,2)
 ;;=^340521
