IBDEI1TZ ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,31094,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31094,1,3,0)
 ;;=3^Opioid-Induced Sleep Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,31094,1,4,0)
 ;;=4^F11.182
 ;;^UTILITY(U,$J,358.3,31094,2)
 ;;=^5003124
 ;;^UTILITY(U,$J,358.3,31095,0)
 ;;=F11.20^^123^1559^24
 ;;^UTILITY(U,$J,358.3,31095,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31095,1,3,0)
 ;;=3^Opioid Use Disorder,Moderate-Severe
 ;;^UTILITY(U,$J,358.3,31095,1,4,0)
 ;;=4^F11.20
 ;;^UTILITY(U,$J,358.3,31095,2)
 ;;=^5003127
 ;;^UTILITY(U,$J,358.3,31096,0)
 ;;=F11.21^^123^1559^25
 ;;^UTILITY(U,$J,358.3,31096,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31096,1,3,0)
 ;;=3^Opioid Use Disorder,Moderate-Severe,In Remission
 ;;^UTILITY(U,$J,358.3,31096,1,4,0)
 ;;=4^F11.21
 ;;^UTILITY(U,$J,358.3,31096,2)
 ;;=^5003128
 ;;^UTILITY(U,$J,358.3,31097,0)
 ;;=F11.23^^123^1559^26
 ;;^UTILITY(U,$J,358.3,31097,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31097,1,3,0)
 ;;=3^Opioid Withdrawal
 ;;^UTILITY(U,$J,358.3,31097,1,4,0)
 ;;=4^F11.23
 ;;^UTILITY(U,$J,358.3,31097,2)
 ;;=^5003133
 ;;^UTILITY(U,$J,358.3,31098,0)
 ;;=F11.24^^123^1559^28
 ;;^UTILITY(U,$J,358.3,31098,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31098,1,3,0)
 ;;=3^Opioid-Induced Depressive Disorder w/ Moderate-Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,31098,1,4,0)
 ;;=4^F11.24
 ;;^UTILITY(U,$J,358.3,31098,2)
 ;;=^5003134
 ;;^UTILITY(U,$J,358.3,31099,0)
 ;;=F11.29^^123^1559^2
 ;;^UTILITY(U,$J,358.3,31099,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31099,1,3,0)
 ;;=3^Opioid Dependence w/ Unspec Opioid-Induced Disorder
 ;;^UTILITY(U,$J,358.3,31099,1,4,0)
 ;;=4^F11.29
 ;;^UTILITY(U,$J,358.3,31099,2)
 ;;=^5003141
 ;;^UTILITY(U,$J,358.3,31100,0)
 ;;=F11.220^^123^1559^1
 ;;^UTILITY(U,$J,358.3,31100,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31100,1,3,0)
 ;;=3^Opioid Dependence w/ Intoxication,Uncomplicated
 ;;^UTILITY(U,$J,358.3,31100,1,4,0)
 ;;=4^F11.220
 ;;^UTILITY(U,$J,358.3,31100,2)
 ;;=^5003129
 ;;^UTILITY(U,$J,358.3,31101,0)
 ;;=F11.188^^123^1559^3
 ;;^UTILITY(U,$J,358.3,31101,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31101,1,3,0)
 ;;=3^Opioid Induced Anxiety Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,31101,1,4,0)
 ;;=4^F11.188
 ;;^UTILITY(U,$J,358.3,31101,2)
 ;;=^5003125
 ;;^UTILITY(U,$J,358.3,31102,0)
 ;;=F11.288^^123^1559^4
 ;;^UTILITY(U,$J,358.3,31102,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31102,1,3,0)
 ;;=3^Opioid Induced Anxiety Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,31102,1,4,0)
 ;;=4^F11.288
 ;;^UTILITY(U,$J,358.3,31102,2)
 ;;=^5003140
 ;;^UTILITY(U,$J,358.3,31103,0)
 ;;=F11.988^^123^1559^5
 ;;^UTILITY(U,$J,358.3,31103,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31103,1,3,0)
 ;;=3^Opioid Induced Anxiety Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,31103,1,4,0)
 ;;=4^F11.988
 ;;^UTILITY(U,$J,358.3,31103,2)
 ;;=^5003154
 ;;^UTILITY(U,$J,358.3,31104,0)
 ;;=F11.921^^123^1559^6
 ;;^UTILITY(U,$J,358.3,31104,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31104,1,3,0)
 ;;=3^Opioid Induced Delirium
 ;;^UTILITY(U,$J,358.3,31104,1,4,0)
 ;;=4^F11.921
 ;;^UTILITY(U,$J,358.3,31104,2)
 ;;=^5003144
 ;;^UTILITY(U,$J,358.3,31105,0)
 ;;=F11.94^^123^1559^7
 ;;^UTILITY(U,$J,358.3,31105,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31105,1,3,0)
 ;;=3^Opioid Induced Depressive Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,31105,1,4,0)
 ;;=4^F11.94
 ;;^UTILITY(U,$J,358.3,31105,2)
 ;;=^5003148
 ;;^UTILITY(U,$J,358.3,31106,0)
 ;;=F11.181^^123^1559^8
 ;;^UTILITY(U,$J,358.3,31106,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31106,1,3,0)
 ;;=3^Opioid Induced Sexual Dysfunction w/ Mild Use Disorder
