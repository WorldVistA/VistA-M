IBDEI1FC ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,23037,1,4,0)
 ;;=4^E87.6
 ;;^UTILITY(U,$J,358.3,23037,2)
 ;;=^60610
 ;;^UTILITY(U,$J,358.3,23038,0)
 ;;=E87.70^^78^996^14
 ;;^UTILITY(U,$J,358.3,23038,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23038,1,3,0)
 ;;=3^Fluid overload, unspecified
 ;;^UTILITY(U,$J,358.3,23038,1,4,0)
 ;;=4^E87.70
 ;;^UTILITY(U,$J,358.3,23038,2)
 ;;=^5003023
 ;;^UTILITY(U,$J,358.3,23039,0)
 ;;=E78.00^^78^996^15
 ;;^UTILITY(U,$J,358.3,23039,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23039,1,3,0)
 ;;=3^Hypercholesterolemia,Pure
 ;;^UTILITY(U,$J,358.3,23039,1,4,0)
 ;;=4^E78.00
 ;;^UTILITY(U,$J,358.3,23039,2)
 ;;=^5138435
 ;;^UTILITY(U,$J,358.3,23040,0)
 ;;=E78.49^^78^996^19
 ;;^UTILITY(U,$J,358.3,23040,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23040,1,3,0)
 ;;=3^Hyperlipidemia,Other
 ;;^UTILITY(U,$J,358.3,23040,1,4,0)
 ;;=4^E78.49
 ;;^UTILITY(U,$J,358.3,23040,2)
 ;;=^5157299
 ;;^UTILITY(U,$J,358.3,23041,0)
 ;;=F02.80^^78^997^8
 ;;^UTILITY(U,$J,358.3,23041,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23041,1,3,0)
 ;;=3^Dementia in oth diseases w/o behavrl disturb
 ;;^UTILITY(U,$J,358.3,23041,1,4,0)
 ;;=4^F02.80
 ;;^UTILITY(U,$J,358.3,23041,2)
 ;;=^5003048
 ;;^UTILITY(U,$J,358.3,23042,0)
 ;;=F02.81^^78^997^7
 ;;^UTILITY(U,$J,358.3,23042,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23042,1,3,0)
 ;;=3^Dementia in oth diseases w/ behavioral disturb
 ;;^UTILITY(U,$J,358.3,23042,1,4,0)
 ;;=4^F02.81
 ;;^UTILITY(U,$J,358.3,23042,2)
 ;;=^5003049
 ;;^UTILITY(U,$J,358.3,23043,0)
 ;;=F03.90^^78^997^9
 ;;^UTILITY(U,$J,358.3,23043,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23043,1,3,0)
 ;;=3^Dementia w/o behavioral disturbance
 ;;^UTILITY(U,$J,358.3,23043,1,4,0)
 ;;=4^F03.90
 ;;^UTILITY(U,$J,358.3,23043,2)
 ;;=^5003050
 ;;^UTILITY(U,$J,358.3,23044,0)
 ;;=F07.0^^78^997^16
 ;;^UTILITY(U,$J,358.3,23044,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23044,1,3,0)
 ;;=3^Personality change d/t physiological condition
 ;;^UTILITY(U,$J,358.3,23044,1,4,0)
 ;;=4^F07.0
 ;;^UTILITY(U,$J,358.3,23044,2)
 ;;=^5003063
 ;;^UTILITY(U,$J,358.3,23045,0)
 ;;=F10.10^^78^997^3
 ;;^UTILITY(U,$J,358.3,23045,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23045,1,3,0)
 ;;=3^Alcohol abuse, uncomplicated
 ;;^UTILITY(U,$J,358.3,23045,1,4,0)
 ;;=4^F10.10
 ;;^UTILITY(U,$J,358.3,23045,2)
 ;;=^5003068
 ;;^UTILITY(U,$J,358.3,23046,0)
 ;;=F10.20^^78^997^4
 ;;^UTILITY(U,$J,358.3,23046,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23046,1,3,0)
 ;;=3^Alcohol dependence, uncomplicated
 ;;^UTILITY(U,$J,358.3,23046,1,4,0)
 ;;=4^F10.20
 ;;^UTILITY(U,$J,358.3,23046,2)
 ;;=^5003081
 ;;^UTILITY(U,$J,358.3,23047,0)
 ;;=F17.200^^78^997^13
 ;;^UTILITY(U,$J,358.3,23047,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23047,1,3,0)
 ;;=3^Nicotine dependence, unspecified, uncomplicated
 ;;^UTILITY(U,$J,358.3,23047,1,4,0)
 ;;=4^F17.200
 ;;^UTILITY(U,$J,358.3,23047,2)
 ;;=^5003360
 ;;^UTILITY(U,$J,358.3,23048,0)
 ;;=F20.5^^78^997^17
 ;;^UTILITY(U,$J,358.3,23048,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23048,1,3,0)
 ;;=3^Residual schizophrenia
 ;;^UTILITY(U,$J,358.3,23048,1,4,0)
 ;;=4^F20.5
 ;;^UTILITY(U,$J,358.3,23048,2)
 ;;=^5003473
 ;;^UTILITY(U,$J,358.3,23049,0)
 ;;=F31.9^^78^997^6
 ;;^UTILITY(U,$J,358.3,23049,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23049,1,3,0)
 ;;=3^Bipolar disorder, unspecified
 ;;^UTILITY(U,$J,358.3,23049,1,4,0)
 ;;=4^F31.9
 ;;^UTILITY(U,$J,358.3,23049,2)
 ;;=^331892
