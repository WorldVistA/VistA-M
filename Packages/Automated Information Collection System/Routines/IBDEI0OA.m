IBDEI0OA ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,10920,1,4,0)
 ;;=4^F16.11
 ;;^UTILITY(U,$J,358.3,10920,2)
 ;;=^268239
 ;;^UTILITY(U,$J,358.3,10921,0)
 ;;=F11.10^^42^494^25
 ;;^UTILITY(U,$J,358.3,10921,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10921,1,3,0)
 ;;=3^Opioid Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,10921,1,4,0)
 ;;=4^F11.10
 ;;^UTILITY(U,$J,358.3,10921,2)
 ;;=^5003114
 ;;^UTILITY(U,$J,358.3,10922,0)
 ;;=F11.129^^42^494^21
 ;;^UTILITY(U,$J,358.3,10922,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10922,1,3,0)
 ;;=3^Opioid Intoxication w/o Perceptual Disturbances w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,10922,1,4,0)
 ;;=4^F11.129
 ;;^UTILITY(U,$J,358.3,10922,2)
 ;;=^5003118
 ;;^UTILITY(U,$J,358.3,10923,0)
 ;;=F11.14^^42^494^7
 ;;^UTILITY(U,$J,358.3,10923,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10923,1,3,0)
 ;;=3^Opioid Induced Depressive Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,10923,1,4,0)
 ;;=4^F11.14
 ;;^UTILITY(U,$J,358.3,10923,2)
 ;;=^5003119
 ;;^UTILITY(U,$J,358.3,10924,0)
 ;;=F11.182^^42^494^13
 ;;^UTILITY(U,$J,358.3,10924,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10924,1,3,0)
 ;;=3^Opioid Induced Sleep Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,10924,1,4,0)
 ;;=4^F11.182
 ;;^UTILITY(U,$J,358.3,10924,2)
 ;;=^5003124
 ;;^UTILITY(U,$J,358.3,10925,0)
 ;;=F11.20^^42^494^2
 ;;^UTILITY(U,$J,358.3,10925,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10925,1,3,0)
 ;;=3^Opioid Dependence
 ;;^UTILITY(U,$J,358.3,10925,1,4,0)
 ;;=4^F11.20
 ;;^UTILITY(U,$J,358.3,10925,2)
 ;;=^5003127
 ;;^UTILITY(U,$J,358.3,10926,0)
 ;;=F11.23^^42^494^3
 ;;^UTILITY(U,$J,358.3,10926,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10926,1,3,0)
 ;;=3^Opioid Dependence w/ Withdrawal
 ;;^UTILITY(U,$J,358.3,10926,1,4,0)
 ;;=4^F11.23
 ;;^UTILITY(U,$J,358.3,10926,2)
 ;;=^5003133
 ;;^UTILITY(U,$J,358.3,10927,0)
 ;;=F11.24^^42^494^8
 ;;^UTILITY(U,$J,358.3,10927,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10927,1,3,0)
 ;;=3^Opioid Induced Depressive Disorder w/ Moderate-Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,10927,1,4,0)
 ;;=4^F11.24
 ;;^UTILITY(U,$J,358.3,10927,2)
 ;;=^5003134
 ;;^UTILITY(U,$J,358.3,10928,0)
 ;;=F11.188^^42^494^4
 ;;^UTILITY(U,$J,358.3,10928,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10928,1,3,0)
 ;;=3^Opioid Induced Anxiety Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,10928,1,4,0)
 ;;=4^F11.188
 ;;^UTILITY(U,$J,358.3,10928,2)
 ;;=^5003125
 ;;^UTILITY(U,$J,358.3,10929,0)
 ;;=F11.288^^42^494^5
 ;;^UTILITY(U,$J,358.3,10929,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10929,1,3,0)
 ;;=3^Opioid Induced Anxiety Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,10929,1,4,0)
 ;;=4^F11.288
 ;;^UTILITY(U,$J,358.3,10929,2)
 ;;=^5003140
 ;;^UTILITY(U,$J,358.3,10930,0)
 ;;=F11.988^^42^494^6
 ;;^UTILITY(U,$J,358.3,10930,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10930,1,3,0)
 ;;=3^Opioid Induced Anxiety Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,10930,1,4,0)
 ;;=4^F11.988
 ;;^UTILITY(U,$J,358.3,10930,2)
 ;;=^5003154
 ;;^UTILITY(U,$J,358.3,10931,0)
 ;;=F11.921^^42^494^26
 ;;^UTILITY(U,$J,358.3,10931,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10931,1,3,0)
 ;;=3^Opioid Use w/ Intoxication Delirium
 ;;^UTILITY(U,$J,358.3,10931,1,4,0)
 ;;=4^F11.921
 ;;^UTILITY(U,$J,358.3,10931,2)
 ;;=^5003144
 ;;^UTILITY(U,$J,358.3,10932,0)
 ;;=F11.94^^42^494^9
 ;;^UTILITY(U,$J,358.3,10932,1,0)
 ;;=^358.31IA^4^2
