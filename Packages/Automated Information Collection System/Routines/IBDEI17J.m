IBDEI17J ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,19611,0)
 ;;=J44.9^^67^878^17
 ;;^UTILITY(U,$J,358.3,19611,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19611,1,3,0)
 ;;=3^Chronic obstructive pulmonary disease, unspecified
 ;;^UTILITY(U,$J,358.3,19611,1,4,0)
 ;;=4^J44.9
 ;;^UTILITY(U,$J,358.3,19611,2)
 ;;=^5008241
 ;;^UTILITY(U,$J,358.3,19612,0)
 ;;=I50.22^^67^878^18
 ;;^UTILITY(U,$J,358.3,19612,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19612,1,3,0)
 ;;=3^Chronic systolic (congestive) heart failure
 ;;^UTILITY(U,$J,358.3,19612,1,4,0)
 ;;=4^I50.22
 ;;^UTILITY(U,$J,358.3,19612,2)
 ;;=^5007241
 ;;^UTILITY(U,$J,358.3,19613,0)
 ;;=Z98.61^^67^878^20
 ;;^UTILITY(U,$J,358.3,19613,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19613,1,3,0)
 ;;=3^Coronary angioplasty status
 ;;^UTILITY(U,$J,358.3,19613,1,4,0)
 ;;=4^Z98.61
 ;;^UTILITY(U,$J,358.3,19613,2)
 ;;=^5063742
 ;;^UTILITY(U,$J,358.3,19614,0)
 ;;=I42.0^^67^878^22
 ;;^UTILITY(U,$J,358.3,19614,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19614,1,3,0)
 ;;=3^Dilated cardiomyopathy
 ;;^UTILITY(U,$J,358.3,19614,1,4,0)
 ;;=4^I42.0
 ;;^UTILITY(U,$J,358.3,19614,2)
 ;;=^5007194
 ;;^UTILITY(U,$J,358.3,19615,0)
 ;;=J43.9^^67^878^23
 ;;^UTILITY(U,$J,358.3,19615,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19615,1,3,0)
 ;;=3^Emphysema, unspecified
 ;;^UTILITY(U,$J,358.3,19615,1,4,0)
 ;;=4^J43.9
 ;;^UTILITY(U,$J,358.3,19615,2)
 ;;=^5008238
 ;;^UTILITY(U,$J,358.3,19616,0)
 ;;=Z82.49^^67^878^24
 ;;^UTILITY(U,$J,358.3,19616,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19616,1,3,0)
 ;;=3^Family hx of ischem heart dis and oth dis of the circ sys
 ;;^UTILITY(U,$J,358.3,19616,1,4,0)
 ;;=4^Z82.49
 ;;^UTILITY(U,$J,358.3,19616,2)
 ;;=^5063369
 ;;^UTILITY(U,$J,358.3,19617,0)
 ;;=I50.9^^67^878^25
 ;;^UTILITY(U,$J,358.3,19617,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19617,1,3,0)
 ;;=3^Heart failure, unspecified
 ;;^UTILITY(U,$J,358.3,19617,1,4,0)
 ;;=4^I50.9
 ;;^UTILITY(U,$J,358.3,19617,2)
 ;;=^5007251
 ;;^UTILITY(U,$J,358.3,19618,0)
 ;;=I25.2^^67^878^27
 ;;^UTILITY(U,$J,358.3,19618,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19618,1,3,0)
 ;;=3^Old myocardial infarction
 ;;^UTILITY(U,$J,358.3,19618,1,4,0)
 ;;=4^I25.2
 ;;^UTILITY(U,$J,358.3,19618,2)
 ;;=^259884
 ;;^UTILITY(U,$J,358.3,19619,0)
 ;;=I42.8^^67^878^12
 ;;^UTILITY(U,$J,358.3,19619,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19619,1,3,0)
 ;;=3^Cardiomyopathies NEC
 ;;^UTILITY(U,$J,358.3,19619,1,4,0)
 ;;=4^I42.8
 ;;^UTILITY(U,$J,358.3,19619,2)
 ;;=^5007199
 ;;^UTILITY(U,$J,358.3,19620,0)
 ;;=I42.2^^67^878^26
 ;;^UTILITY(U,$J,358.3,19620,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19620,1,3,0)
 ;;=3^Hypertrophic cardiomyopathy NEC
 ;;^UTILITY(U,$J,358.3,19620,1,4,0)
 ;;=4^I42.2
 ;;^UTILITY(U,$J,358.3,19620,2)
 ;;=^340521
 ;;^UTILITY(U,$J,358.3,19621,0)
 ;;=I42.5^^67^878^32
 ;;^UTILITY(U,$J,358.3,19621,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19621,1,3,0)
 ;;=3^Restrictive cardiomyopathy NEC
 ;;^UTILITY(U,$J,358.3,19621,1,4,0)
 ;;=4^I42.5
 ;;^UTILITY(U,$J,358.3,19621,2)
 ;;=^5007196
 ;;^UTILITY(U,$J,358.3,19622,0)
 ;;=Z95.1^^67^878^29
 ;;^UTILITY(U,$J,358.3,19622,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19622,1,3,0)
 ;;=3^Presence of aortocoronary bypass graft
 ;;^UTILITY(U,$J,358.3,19622,1,4,0)
 ;;=4^Z95.1
 ;;^UTILITY(U,$J,358.3,19622,2)
 ;;=^5063669
 ;;^UTILITY(U,$J,358.3,19623,0)
 ;;=Z95.0^^67^878^30
 ;;^UTILITY(U,$J,358.3,19623,1,0)
 ;;=^358.31IA^4^2
