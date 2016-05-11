IBDEI1I8 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,25526,2)
 ;;=^5133359
 ;;^UTILITY(U,$J,358.3,25527,0)
 ;;=F11.10^^95^1169^23
 ;;^UTILITY(U,$J,358.3,25527,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25527,1,3,0)
 ;;=3^Opioid Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,25527,1,4,0)
 ;;=4^F11.10
 ;;^UTILITY(U,$J,358.3,25527,2)
 ;;=^5003114
 ;;^UTILITY(U,$J,358.3,25528,0)
 ;;=F11.129^^95^1169^19
 ;;^UTILITY(U,$J,358.3,25528,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25528,1,3,0)
 ;;=3^Opioid Intoxication w/o Perceptual Disturbances;Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,25528,1,4,0)
 ;;=4^F11.129
 ;;^UTILITY(U,$J,358.3,25528,2)
 ;;=^5003118
 ;;^UTILITY(U,$J,358.3,25529,0)
 ;;=F11.14^^95^1169^27
 ;;^UTILITY(U,$J,358.3,25529,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25529,1,3,0)
 ;;=3^Opioid-Induced Depressive Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,25529,1,4,0)
 ;;=4^F11.14
 ;;^UTILITY(U,$J,358.3,25529,2)
 ;;=^5003119
 ;;^UTILITY(U,$J,358.3,25530,0)
 ;;=F11.182^^95^1169^29
 ;;^UTILITY(U,$J,358.3,25530,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25530,1,3,0)
 ;;=3^Opioid-Induced Sleep Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,25530,1,4,0)
 ;;=4^F11.182
 ;;^UTILITY(U,$J,358.3,25530,2)
 ;;=^5003124
 ;;^UTILITY(U,$J,358.3,25531,0)
 ;;=F11.20^^95^1169^24
 ;;^UTILITY(U,$J,358.3,25531,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25531,1,3,0)
 ;;=3^Opioid Use Disorder,Moderate-Severe
 ;;^UTILITY(U,$J,358.3,25531,1,4,0)
 ;;=4^F11.20
 ;;^UTILITY(U,$J,358.3,25531,2)
 ;;=^5003127
 ;;^UTILITY(U,$J,358.3,25532,0)
 ;;=F11.21^^95^1169^25
 ;;^UTILITY(U,$J,358.3,25532,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25532,1,3,0)
 ;;=3^Opioid Use Disorder,Moderate-Severe,In Remission
 ;;^UTILITY(U,$J,358.3,25532,1,4,0)
 ;;=4^F11.21
 ;;^UTILITY(U,$J,358.3,25532,2)
 ;;=^5003128
 ;;^UTILITY(U,$J,358.3,25533,0)
 ;;=F11.23^^95^1169^26
 ;;^UTILITY(U,$J,358.3,25533,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25533,1,3,0)
 ;;=3^Opioid Withdrawal
 ;;^UTILITY(U,$J,358.3,25533,1,4,0)
 ;;=4^F11.23
 ;;^UTILITY(U,$J,358.3,25533,2)
 ;;=^5003133
 ;;^UTILITY(U,$J,358.3,25534,0)
 ;;=F11.24^^95^1169^28
 ;;^UTILITY(U,$J,358.3,25534,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25534,1,3,0)
 ;;=3^Opioid-Induced Depressive Disorder w/ Moderate-Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,25534,1,4,0)
 ;;=4^F11.24
 ;;^UTILITY(U,$J,358.3,25534,2)
 ;;=^5003134
 ;;^UTILITY(U,$J,358.3,25535,0)
 ;;=F11.29^^95^1169^2
 ;;^UTILITY(U,$J,358.3,25535,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25535,1,3,0)
 ;;=3^Opioid Dependence w/ Unspec Opioid-Induced Disorder
 ;;^UTILITY(U,$J,358.3,25535,1,4,0)
 ;;=4^F11.29
 ;;^UTILITY(U,$J,358.3,25535,2)
 ;;=^5003141
 ;;^UTILITY(U,$J,358.3,25536,0)
 ;;=F11.220^^95^1169^1
 ;;^UTILITY(U,$J,358.3,25536,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25536,1,3,0)
 ;;=3^Opioid Dependence w/ Intoxication,Uncomplicated
 ;;^UTILITY(U,$J,358.3,25536,1,4,0)
 ;;=4^F11.220
 ;;^UTILITY(U,$J,358.3,25536,2)
 ;;=^5003129
 ;;^UTILITY(U,$J,358.3,25537,0)
 ;;=F11.188^^95^1169^3
 ;;^UTILITY(U,$J,358.3,25537,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25537,1,3,0)
 ;;=3^Opioid Induced Anxiety Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,25537,1,4,0)
 ;;=4^F11.188
 ;;^UTILITY(U,$J,358.3,25537,2)
 ;;=^5003125
 ;;^UTILITY(U,$J,358.3,25538,0)
 ;;=F11.288^^95^1169^4
 ;;^UTILITY(U,$J,358.3,25538,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25538,1,3,0)
 ;;=3^Opioid Induced Anxiety Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,25538,1,4,0)
 ;;=4^F11.288
 ;;^UTILITY(U,$J,358.3,25538,2)
 ;;=^5003140
 ;;^UTILITY(U,$J,358.3,25539,0)
 ;;=F11.988^^95^1169^5
