IBDEI1FL ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,24321,1,3,0)
 ;;=3^Opioid Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,24321,1,4,0)
 ;;=4^F11.10
 ;;^UTILITY(U,$J,358.3,24321,2)
 ;;=^5003114
 ;;^UTILITY(U,$J,358.3,24322,0)
 ;;=F11.129^^90^1065^19
 ;;^UTILITY(U,$J,358.3,24322,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24322,1,3,0)
 ;;=3^Opioid Intoxication w/o Perceptual Disturbances;Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,24322,1,4,0)
 ;;=4^F11.129
 ;;^UTILITY(U,$J,358.3,24322,2)
 ;;=^5003118
 ;;^UTILITY(U,$J,358.3,24323,0)
 ;;=F11.14^^90^1065^27
 ;;^UTILITY(U,$J,358.3,24323,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24323,1,3,0)
 ;;=3^Opioid-Induced Depressive Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,24323,1,4,0)
 ;;=4^F11.14
 ;;^UTILITY(U,$J,358.3,24323,2)
 ;;=^5003119
 ;;^UTILITY(U,$J,358.3,24324,0)
 ;;=F11.182^^90^1065^29
 ;;^UTILITY(U,$J,358.3,24324,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24324,1,3,0)
 ;;=3^Opioid-Induced Sleep Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,24324,1,4,0)
 ;;=4^F11.182
 ;;^UTILITY(U,$J,358.3,24324,2)
 ;;=^5003124
 ;;^UTILITY(U,$J,358.3,24325,0)
 ;;=F11.20^^90^1065^24
 ;;^UTILITY(U,$J,358.3,24325,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24325,1,3,0)
 ;;=3^Opioid Use Disorder,Moderate-Severe
 ;;^UTILITY(U,$J,358.3,24325,1,4,0)
 ;;=4^F11.20
 ;;^UTILITY(U,$J,358.3,24325,2)
 ;;=^5003127
 ;;^UTILITY(U,$J,358.3,24326,0)
 ;;=F11.21^^90^1065^25
 ;;^UTILITY(U,$J,358.3,24326,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24326,1,3,0)
 ;;=3^Opioid Use Disorder,Moderate-Severe,In Remission
 ;;^UTILITY(U,$J,358.3,24326,1,4,0)
 ;;=4^F11.21
 ;;^UTILITY(U,$J,358.3,24326,2)
 ;;=^5003128
 ;;^UTILITY(U,$J,358.3,24327,0)
 ;;=F11.23^^90^1065^26
 ;;^UTILITY(U,$J,358.3,24327,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24327,1,3,0)
 ;;=3^Opioid Withdrawal
 ;;^UTILITY(U,$J,358.3,24327,1,4,0)
 ;;=4^F11.23
 ;;^UTILITY(U,$J,358.3,24327,2)
 ;;=^5003133
 ;;^UTILITY(U,$J,358.3,24328,0)
 ;;=F11.24^^90^1065^28
 ;;^UTILITY(U,$J,358.3,24328,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24328,1,3,0)
 ;;=3^Opioid-Induced Depressive Disorder w/ Moderate-Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,24328,1,4,0)
 ;;=4^F11.24
 ;;^UTILITY(U,$J,358.3,24328,2)
 ;;=^5003134
 ;;^UTILITY(U,$J,358.3,24329,0)
 ;;=F11.29^^90^1065^2
 ;;^UTILITY(U,$J,358.3,24329,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24329,1,3,0)
 ;;=3^Opioid Dependence w/ Unspec Opioid-Induced Disorder
 ;;^UTILITY(U,$J,358.3,24329,1,4,0)
 ;;=4^F11.29
 ;;^UTILITY(U,$J,358.3,24329,2)
 ;;=^5003141
 ;;^UTILITY(U,$J,358.3,24330,0)
 ;;=F11.220^^90^1065^1
 ;;^UTILITY(U,$J,358.3,24330,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24330,1,3,0)
 ;;=3^Opioid Dependence w/ Intoxication,Uncomplicated
 ;;^UTILITY(U,$J,358.3,24330,1,4,0)
 ;;=4^F11.220
 ;;^UTILITY(U,$J,358.3,24330,2)
 ;;=^5003129
 ;;^UTILITY(U,$J,358.3,24331,0)
 ;;=F11.188^^90^1065^3
 ;;^UTILITY(U,$J,358.3,24331,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24331,1,3,0)
 ;;=3^Opioid Induced Anxiety Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,24331,1,4,0)
 ;;=4^F11.188
 ;;^UTILITY(U,$J,358.3,24331,2)
 ;;=^5003125
 ;;^UTILITY(U,$J,358.3,24332,0)
 ;;=F11.288^^90^1065^4
 ;;^UTILITY(U,$J,358.3,24332,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24332,1,3,0)
 ;;=3^Opioid Induced Anxiety Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,24332,1,4,0)
 ;;=4^F11.288
 ;;^UTILITY(U,$J,358.3,24332,2)
 ;;=^5003140
 ;;^UTILITY(U,$J,358.3,24333,0)
 ;;=F11.988^^90^1065^5
 ;;^UTILITY(U,$J,358.3,24333,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24333,1,3,0)
 ;;=3^Opioid Induced Anxiety Disorder w/o Use Disorder
