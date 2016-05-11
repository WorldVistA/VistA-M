IBDEI026 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,524,1,4,0)
 ;;=4^F11.24
 ;;^UTILITY(U,$J,358.3,524,2)
 ;;=^5003134
 ;;^UTILITY(U,$J,358.3,525,0)
 ;;=F11.29^^3^53^2
 ;;^UTILITY(U,$J,358.3,525,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,525,1,3,0)
 ;;=3^Opioid Dependence w/ Unspec Opioid-Induced Disorder
 ;;^UTILITY(U,$J,358.3,525,1,4,0)
 ;;=4^F11.29
 ;;^UTILITY(U,$J,358.3,525,2)
 ;;=^5003141
 ;;^UTILITY(U,$J,358.3,526,0)
 ;;=F11.220^^3^53^1
 ;;^UTILITY(U,$J,358.3,526,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,526,1,3,0)
 ;;=3^Opioid Dependence w/ Intoxication,Uncomplicated
 ;;^UTILITY(U,$J,358.3,526,1,4,0)
 ;;=4^F11.220
 ;;^UTILITY(U,$J,358.3,526,2)
 ;;=^5003129
 ;;^UTILITY(U,$J,358.3,527,0)
 ;;=F11.188^^3^53^3
 ;;^UTILITY(U,$J,358.3,527,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,527,1,3,0)
 ;;=3^Opioid Induced Anxiety Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,527,1,4,0)
 ;;=4^F11.188
 ;;^UTILITY(U,$J,358.3,527,2)
 ;;=^5003125
 ;;^UTILITY(U,$J,358.3,528,0)
 ;;=F11.288^^3^53^4
 ;;^UTILITY(U,$J,358.3,528,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,528,1,3,0)
 ;;=3^Opioid Induced Anxiety Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,528,1,4,0)
 ;;=4^F11.288
 ;;^UTILITY(U,$J,358.3,528,2)
 ;;=^5003140
 ;;^UTILITY(U,$J,358.3,529,0)
 ;;=F11.988^^3^53^5
 ;;^UTILITY(U,$J,358.3,529,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,529,1,3,0)
 ;;=3^Opioid Induced Anxiety Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,529,1,4,0)
 ;;=4^F11.988
 ;;^UTILITY(U,$J,358.3,529,2)
 ;;=^5003154
 ;;^UTILITY(U,$J,358.3,530,0)
 ;;=F11.921^^3^53^6
 ;;^UTILITY(U,$J,358.3,530,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,530,1,3,0)
 ;;=3^Opioid Induced Delirium
 ;;^UTILITY(U,$J,358.3,530,1,4,0)
 ;;=4^F11.921
 ;;^UTILITY(U,$J,358.3,530,2)
 ;;=^5003144
 ;;^UTILITY(U,$J,358.3,531,0)
 ;;=F11.94^^3^53^7
 ;;^UTILITY(U,$J,358.3,531,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,531,1,3,0)
 ;;=3^Opioid Induced Depressive Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,531,1,4,0)
 ;;=4^F11.94
 ;;^UTILITY(U,$J,358.3,531,2)
 ;;=^5003148
 ;;^UTILITY(U,$J,358.3,532,0)
 ;;=F11.181^^3^53^8
 ;;^UTILITY(U,$J,358.3,532,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,532,1,3,0)
 ;;=3^Opioid Induced Sexual Dysfunction w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,532,1,4,0)
 ;;=4^F11.181
 ;;^UTILITY(U,$J,358.3,532,2)
 ;;=^5003123
 ;;^UTILITY(U,$J,358.3,533,0)
 ;;=F11.281^^3^53^9
 ;;^UTILITY(U,$J,358.3,533,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,533,1,3,0)
 ;;=3^Opioid Induced Sexual Dysfunction w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,533,1,4,0)
 ;;=4^F11.281
 ;;^UTILITY(U,$J,358.3,533,2)
 ;;=^5003138
 ;;^UTILITY(U,$J,358.3,534,0)
 ;;=F11.981^^3^53^10
 ;;^UTILITY(U,$J,358.3,534,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,534,1,3,0)
 ;;=3^Opioid Induced Sexual Dysfunction w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,534,1,4,0)
 ;;=4^F11.981
 ;;^UTILITY(U,$J,358.3,534,2)
 ;;=^5003152
 ;;^UTILITY(U,$J,358.3,535,0)
 ;;=F11.282^^3^53^11
 ;;^UTILITY(U,$J,358.3,535,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,535,1,3,0)
 ;;=3^Opioid Induced Sleep Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,535,1,4,0)
 ;;=4^F11.282
 ;;^UTILITY(U,$J,358.3,535,2)
 ;;=^5003139
 ;;^UTILITY(U,$J,358.3,536,0)
 ;;=F11.982^^3^53^12
 ;;^UTILITY(U,$J,358.3,536,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,536,1,3,0)
 ;;=3^Opioid Induced Sleep Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,536,1,4,0)
 ;;=4^F11.982
 ;;^UTILITY(U,$J,358.3,536,2)
 ;;=^5003153
 ;;^UTILITY(U,$J,358.3,537,0)
 ;;=F11.121^^3^53^13
 ;;^UTILITY(U,$J,358.3,537,1,0)
 ;;=^358.31IA^4^2
