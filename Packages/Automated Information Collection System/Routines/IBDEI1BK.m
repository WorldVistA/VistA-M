IBDEI1BK ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,21087,1,3,0)
 ;;=3^Hallucinogen Abuse,In Remission
 ;;^UTILITY(U,$J,358.3,21087,1,4,0)
 ;;=4^F16.11
 ;;^UTILITY(U,$J,358.3,21087,2)
 ;;=^268239
 ;;^UTILITY(U,$J,358.3,21088,0)
 ;;=F11.10^^95^1046^25
 ;;^UTILITY(U,$J,358.3,21088,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21088,1,3,0)
 ;;=3^Opioid Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,21088,1,4,0)
 ;;=4^F11.10
 ;;^UTILITY(U,$J,358.3,21088,2)
 ;;=^5003114
 ;;^UTILITY(U,$J,358.3,21089,0)
 ;;=F11.129^^95^1046^21
 ;;^UTILITY(U,$J,358.3,21089,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21089,1,3,0)
 ;;=3^Opioid Intoxication w/o Perceptual Disturbances w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,21089,1,4,0)
 ;;=4^F11.129
 ;;^UTILITY(U,$J,358.3,21089,2)
 ;;=^5003118
 ;;^UTILITY(U,$J,358.3,21090,0)
 ;;=F11.14^^95^1046^7
 ;;^UTILITY(U,$J,358.3,21090,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21090,1,3,0)
 ;;=3^Opioid Induced Depressive Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,21090,1,4,0)
 ;;=4^F11.14
 ;;^UTILITY(U,$J,358.3,21090,2)
 ;;=^5003119
 ;;^UTILITY(U,$J,358.3,21091,0)
 ;;=F11.182^^95^1046^13
 ;;^UTILITY(U,$J,358.3,21091,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21091,1,3,0)
 ;;=3^Opioid Induced Sleep Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,21091,1,4,0)
 ;;=4^F11.182
 ;;^UTILITY(U,$J,358.3,21091,2)
 ;;=^5003124
 ;;^UTILITY(U,$J,358.3,21092,0)
 ;;=F11.20^^95^1046^2
 ;;^UTILITY(U,$J,358.3,21092,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21092,1,3,0)
 ;;=3^Opioid Dependence
 ;;^UTILITY(U,$J,358.3,21092,1,4,0)
 ;;=4^F11.20
 ;;^UTILITY(U,$J,358.3,21092,2)
 ;;=^5003127
 ;;^UTILITY(U,$J,358.3,21093,0)
 ;;=F11.23^^95^1046^3
 ;;^UTILITY(U,$J,358.3,21093,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21093,1,3,0)
 ;;=3^Opioid Dependence w/ Withdrawal
 ;;^UTILITY(U,$J,358.3,21093,1,4,0)
 ;;=4^F11.23
 ;;^UTILITY(U,$J,358.3,21093,2)
 ;;=^5003133
 ;;^UTILITY(U,$J,358.3,21094,0)
 ;;=F11.24^^95^1046^8
 ;;^UTILITY(U,$J,358.3,21094,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21094,1,3,0)
 ;;=3^Opioid Induced Depressive Disorder w/ Moderate-Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,21094,1,4,0)
 ;;=4^F11.24
 ;;^UTILITY(U,$J,358.3,21094,2)
 ;;=^5003134
 ;;^UTILITY(U,$J,358.3,21095,0)
 ;;=F11.188^^95^1046^4
 ;;^UTILITY(U,$J,358.3,21095,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21095,1,3,0)
 ;;=3^Opioid Induced Anxiety Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,21095,1,4,0)
 ;;=4^F11.188
 ;;^UTILITY(U,$J,358.3,21095,2)
 ;;=^5003125
 ;;^UTILITY(U,$J,358.3,21096,0)
 ;;=F11.288^^95^1046^5
 ;;^UTILITY(U,$J,358.3,21096,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21096,1,3,0)
 ;;=3^Opioid Induced Anxiety Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,21096,1,4,0)
 ;;=4^F11.288
 ;;^UTILITY(U,$J,358.3,21096,2)
 ;;=^5003140
 ;;^UTILITY(U,$J,358.3,21097,0)
 ;;=F11.988^^95^1046^6
 ;;^UTILITY(U,$J,358.3,21097,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21097,1,3,0)
 ;;=3^Opioid Induced Anxiety Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,21097,1,4,0)
 ;;=4^F11.988
 ;;^UTILITY(U,$J,358.3,21097,2)
 ;;=^5003154
 ;;^UTILITY(U,$J,358.3,21098,0)
 ;;=F11.921^^95^1046^26
 ;;^UTILITY(U,$J,358.3,21098,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21098,1,3,0)
 ;;=3^Opioid Use w/ Intoxication Delirium
 ;;^UTILITY(U,$J,358.3,21098,1,4,0)
 ;;=4^F11.921
 ;;^UTILITY(U,$J,358.3,21098,2)
 ;;=^5003144
 ;;^UTILITY(U,$J,358.3,21099,0)
 ;;=F11.94^^95^1046^9
