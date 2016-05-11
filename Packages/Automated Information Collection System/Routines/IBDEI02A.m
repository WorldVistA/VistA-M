IBDEI02A ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,574,2)
 ;;=^5003250
 ;;^UTILITY(U,$J,358.3,575,0)
 ;;=F14.20^^3^57^3
 ;;^UTILITY(U,$J,358.3,575,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,575,1,3,0)
 ;;=3^Cocaine Use Disorder,Moderate-Severe
 ;;^UTILITY(U,$J,358.3,575,1,4,0)
 ;;=4^F14.20
 ;;^UTILITY(U,$J,358.3,575,2)
 ;;=^5003253
 ;;^UTILITY(U,$J,358.3,576,0)
 ;;=F14.21^^3^57^2
 ;;^UTILITY(U,$J,358.3,576,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,576,1,3,0)
 ;;=3^Cocaine Use Disorder,Mod-Severe,In Remission
 ;;^UTILITY(U,$J,358.3,576,1,4,0)
 ;;=4^F14.21
 ;;^UTILITY(U,$J,358.3,576,2)
 ;;=^5003254
 ;;^UTILITY(U,$J,358.3,577,0)
 ;;=F14.23^^3^57^4
 ;;^UTILITY(U,$J,358.3,577,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,577,1,3,0)
 ;;=3^Cocaine Withdrawal
 ;;^UTILITY(U,$J,358.3,577,1,4,0)
 ;;=4^F14.23
 ;;^UTILITY(U,$J,358.3,577,2)
 ;;=^5003259
 ;;^UTILITY(U,$J,358.3,578,0)
 ;;=F43.0^^3^58^1
 ;;^UTILITY(U,$J,358.3,578,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,578,1,3,0)
 ;;=3^Acute Stress Disorder
 ;;^UTILITY(U,$J,358.3,578,1,4,0)
 ;;=4^F43.0
 ;;^UTILITY(U,$J,358.3,578,2)
 ;;=^5003569
 ;;^UTILITY(U,$J,358.3,579,0)
 ;;=F43.21^^3^58^3
 ;;^UTILITY(U,$J,358.3,579,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,579,1,3,0)
 ;;=3^Adjustment Disorder w/ Depressed Mood
 ;;^UTILITY(U,$J,358.3,579,1,4,0)
 ;;=4^F43.21
 ;;^UTILITY(U,$J,358.3,579,2)
 ;;=^331948
 ;;^UTILITY(U,$J,358.3,580,0)
 ;;=F43.22^^3^58^2
 ;;^UTILITY(U,$J,358.3,580,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,580,1,3,0)
 ;;=3^Adjustment Disorder w/ Anxiety
 ;;^UTILITY(U,$J,358.3,580,1,4,0)
 ;;=4^F43.22
 ;;^UTILITY(U,$J,358.3,580,2)
 ;;=^331949
 ;;^UTILITY(U,$J,358.3,581,0)
 ;;=F43.23^^3^58^5
 ;;^UTILITY(U,$J,358.3,581,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,581,1,3,0)
 ;;=3^Adjustment Disorder w/ Mixed Anxiety & Depressed Mood
 ;;^UTILITY(U,$J,358.3,581,1,4,0)
 ;;=4^F43.23
 ;;^UTILITY(U,$J,358.3,581,2)
 ;;=^331950
 ;;^UTILITY(U,$J,358.3,582,0)
 ;;=F43.24^^3^58^4
 ;;^UTILITY(U,$J,358.3,582,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,582,1,3,0)
 ;;=3^Adjustment Disorder w/ Disturbance of Conduct
 ;;^UTILITY(U,$J,358.3,582,1,4,0)
 ;;=4^F43.24
 ;;^UTILITY(U,$J,358.3,582,2)
 ;;=^331951
 ;;^UTILITY(U,$J,358.3,583,0)
 ;;=F43.25^^3^58^6
 ;;^UTILITY(U,$J,358.3,583,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,583,1,3,0)
 ;;=3^Adjustment Disorder w/ Mixed Disturbance Emotions & Conduct
 ;;^UTILITY(U,$J,358.3,583,1,4,0)
 ;;=4^F43.25
 ;;^UTILITY(U,$J,358.3,583,2)
 ;;=^331952
 ;;^UTILITY(U,$J,358.3,584,0)
 ;;=F43.8^^3^58^15
 ;;^UTILITY(U,$J,358.3,584,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,584,1,3,0)
 ;;=3^Trauma/Stressor-Related Disorder NEC
 ;;^UTILITY(U,$J,358.3,584,1,4,0)
 ;;=4^F43.8
 ;;^UTILITY(U,$J,358.3,584,2)
 ;;=^5003575
 ;;^UTILITY(U,$J,358.3,585,0)
 ;;=F43.20^^3^58^7
 ;;^UTILITY(U,$J,358.3,585,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,585,1,3,0)
 ;;=3^Adjustment Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,585,1,4,0)
 ;;=4^F43.20
 ;;^UTILITY(U,$J,358.3,585,2)
 ;;=^5003573
 ;;^UTILITY(U,$J,358.3,586,0)
 ;;=F43.9^^3^58^16
 ;;^UTILITY(U,$J,358.3,586,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,586,1,3,0)
 ;;=3^Trauma/Stressor-Related Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,586,1,4,0)
 ;;=4^F43.9
 ;;^UTILITY(U,$J,358.3,586,2)
 ;;=^5003576
 ;;^UTILITY(U,$J,358.3,587,0)
 ;;=F43.11^^3^58^9
 ;;^UTILITY(U,$J,358.3,587,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,587,1,3,0)
 ;;=3^PTSD,Acute
 ;;^UTILITY(U,$J,358.3,587,1,4,0)
 ;;=4^F43.11
 ;;^UTILITY(U,$J,358.3,587,2)
 ;;=^5003571
 ;;^UTILITY(U,$J,358.3,588,0)
 ;;=F43.12^^3^58^10
 ;;^UTILITY(U,$J,358.3,588,1,0)
 ;;=^358.31IA^4^2
