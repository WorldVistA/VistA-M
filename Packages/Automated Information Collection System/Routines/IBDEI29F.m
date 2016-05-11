IBDEI29F ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,38329,1,4,0)
 ;;=4^F16.959
 ;;^UTILITY(U,$J,358.3,38329,2)
 ;;=^5003356
 ;;^UTILITY(U,$J,358.3,38330,0)
 ;;=F16.99^^145^1857^20
 ;;^UTILITY(U,$J,358.3,38330,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38330,1,3,0)
 ;;=3^Phencyclidine Use Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,38330,1,4,0)
 ;;=4^F16.99
 ;;^UTILITY(U,$J,358.3,38330,2)
 ;;=^5133359
 ;;^UTILITY(U,$J,358.3,38331,0)
 ;;=F11.10^^145^1858^23
 ;;^UTILITY(U,$J,358.3,38331,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38331,1,3,0)
 ;;=3^Opioid Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,38331,1,4,0)
 ;;=4^F11.10
 ;;^UTILITY(U,$J,358.3,38331,2)
 ;;=^5003114
 ;;^UTILITY(U,$J,358.3,38332,0)
 ;;=F11.129^^145^1858^19
 ;;^UTILITY(U,$J,358.3,38332,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38332,1,3,0)
 ;;=3^Opioid Intoxication w/o Perceptual Disturbances;Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,38332,1,4,0)
 ;;=4^F11.129
 ;;^UTILITY(U,$J,358.3,38332,2)
 ;;=^5003118
 ;;^UTILITY(U,$J,358.3,38333,0)
 ;;=F11.14^^145^1858^27
 ;;^UTILITY(U,$J,358.3,38333,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38333,1,3,0)
 ;;=3^Opioid-Induced Depressive Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,38333,1,4,0)
 ;;=4^F11.14
 ;;^UTILITY(U,$J,358.3,38333,2)
 ;;=^5003119
 ;;^UTILITY(U,$J,358.3,38334,0)
 ;;=F11.182^^145^1858^29
 ;;^UTILITY(U,$J,358.3,38334,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38334,1,3,0)
 ;;=3^Opioid-Induced Sleep Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,38334,1,4,0)
 ;;=4^F11.182
 ;;^UTILITY(U,$J,358.3,38334,2)
 ;;=^5003124
 ;;^UTILITY(U,$J,358.3,38335,0)
 ;;=F11.20^^145^1858^24
 ;;^UTILITY(U,$J,358.3,38335,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38335,1,3,0)
 ;;=3^Opioid Use Disorder,Moderate-Severe
 ;;^UTILITY(U,$J,358.3,38335,1,4,0)
 ;;=4^F11.20
 ;;^UTILITY(U,$J,358.3,38335,2)
 ;;=^5003127
 ;;^UTILITY(U,$J,358.3,38336,0)
 ;;=F11.21^^145^1858^25
 ;;^UTILITY(U,$J,358.3,38336,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38336,1,3,0)
 ;;=3^Opioid Use Disorder,Moderate-Severe,In Remission
 ;;^UTILITY(U,$J,358.3,38336,1,4,0)
 ;;=4^F11.21
 ;;^UTILITY(U,$J,358.3,38336,2)
 ;;=^5003128
 ;;^UTILITY(U,$J,358.3,38337,0)
 ;;=F11.23^^145^1858^26
 ;;^UTILITY(U,$J,358.3,38337,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38337,1,3,0)
 ;;=3^Opioid Withdrawal
 ;;^UTILITY(U,$J,358.3,38337,1,4,0)
 ;;=4^F11.23
 ;;^UTILITY(U,$J,358.3,38337,2)
 ;;=^5003133
 ;;^UTILITY(U,$J,358.3,38338,0)
 ;;=F11.24^^145^1858^28
 ;;^UTILITY(U,$J,358.3,38338,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38338,1,3,0)
 ;;=3^Opioid-Induced Depressive Disorder w/ Moderate-Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,38338,1,4,0)
 ;;=4^F11.24
 ;;^UTILITY(U,$J,358.3,38338,2)
 ;;=^5003134
 ;;^UTILITY(U,$J,358.3,38339,0)
 ;;=F11.29^^145^1858^2
 ;;^UTILITY(U,$J,358.3,38339,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38339,1,3,0)
 ;;=3^Opioid Dependence w/ Unspec Opioid-Induced Disorder
 ;;^UTILITY(U,$J,358.3,38339,1,4,0)
 ;;=4^F11.29
 ;;^UTILITY(U,$J,358.3,38339,2)
 ;;=^5003141
 ;;^UTILITY(U,$J,358.3,38340,0)
 ;;=F11.220^^145^1858^1
 ;;^UTILITY(U,$J,358.3,38340,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38340,1,3,0)
 ;;=3^Opioid Dependence w/ Intoxication,Uncomplicated
 ;;^UTILITY(U,$J,358.3,38340,1,4,0)
 ;;=4^F11.220
 ;;^UTILITY(U,$J,358.3,38340,2)
 ;;=^5003129
 ;;^UTILITY(U,$J,358.3,38341,0)
 ;;=F11.188^^145^1858^3
 ;;^UTILITY(U,$J,358.3,38341,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38341,1,3,0)
 ;;=3^Opioid Induced Anxiety Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,38341,1,4,0)
 ;;=4^F11.188
 ;;^UTILITY(U,$J,358.3,38341,2)
 ;;=^5003125
