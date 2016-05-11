IBDEI1GY ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,24945,2)
 ;;=^5003134
 ;;^UTILITY(U,$J,358.3,24946,0)
 ;;=F11.29^^93^1120^2
 ;;^UTILITY(U,$J,358.3,24946,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24946,1,3,0)
 ;;=3^Opioid Dependence w/ Unspec Opioid-Induced Disorder
 ;;^UTILITY(U,$J,358.3,24946,1,4,0)
 ;;=4^F11.29
 ;;^UTILITY(U,$J,358.3,24946,2)
 ;;=^5003141
 ;;^UTILITY(U,$J,358.3,24947,0)
 ;;=F11.220^^93^1120^1
 ;;^UTILITY(U,$J,358.3,24947,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24947,1,3,0)
 ;;=3^Opioid Dependence w/ Intoxication,Uncomplicated
 ;;^UTILITY(U,$J,358.3,24947,1,4,0)
 ;;=4^F11.220
 ;;^UTILITY(U,$J,358.3,24947,2)
 ;;=^5003129
 ;;^UTILITY(U,$J,358.3,24948,0)
 ;;=F11.188^^93^1120^3
 ;;^UTILITY(U,$J,358.3,24948,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24948,1,3,0)
 ;;=3^Opioid Induced Anxiety Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,24948,1,4,0)
 ;;=4^F11.188
 ;;^UTILITY(U,$J,358.3,24948,2)
 ;;=^5003125
 ;;^UTILITY(U,$J,358.3,24949,0)
 ;;=F11.288^^93^1120^4
 ;;^UTILITY(U,$J,358.3,24949,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24949,1,3,0)
 ;;=3^Opioid Induced Anxiety Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,24949,1,4,0)
 ;;=4^F11.288
 ;;^UTILITY(U,$J,358.3,24949,2)
 ;;=^5003140
 ;;^UTILITY(U,$J,358.3,24950,0)
 ;;=F11.988^^93^1120^5
 ;;^UTILITY(U,$J,358.3,24950,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24950,1,3,0)
 ;;=3^Opioid Induced Anxiety Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,24950,1,4,0)
 ;;=4^F11.988
 ;;^UTILITY(U,$J,358.3,24950,2)
 ;;=^5003154
 ;;^UTILITY(U,$J,358.3,24951,0)
 ;;=F11.921^^93^1120^6
 ;;^UTILITY(U,$J,358.3,24951,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24951,1,3,0)
 ;;=3^Opioid Induced Delirium
 ;;^UTILITY(U,$J,358.3,24951,1,4,0)
 ;;=4^F11.921
 ;;^UTILITY(U,$J,358.3,24951,2)
 ;;=^5003144
 ;;^UTILITY(U,$J,358.3,24952,0)
 ;;=F11.94^^93^1120^7
 ;;^UTILITY(U,$J,358.3,24952,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24952,1,3,0)
 ;;=3^Opioid Induced Depressive Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,24952,1,4,0)
 ;;=4^F11.94
 ;;^UTILITY(U,$J,358.3,24952,2)
 ;;=^5003148
 ;;^UTILITY(U,$J,358.3,24953,0)
 ;;=F11.181^^93^1120^8
 ;;^UTILITY(U,$J,358.3,24953,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24953,1,3,0)
 ;;=3^Opioid Induced Sexual Dysfunction w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,24953,1,4,0)
 ;;=4^F11.181
 ;;^UTILITY(U,$J,358.3,24953,2)
 ;;=^5003123
 ;;^UTILITY(U,$J,358.3,24954,0)
 ;;=F11.281^^93^1120^9
 ;;^UTILITY(U,$J,358.3,24954,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24954,1,3,0)
 ;;=3^Opioid Induced Sexual Dysfunction w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,24954,1,4,0)
 ;;=4^F11.281
 ;;^UTILITY(U,$J,358.3,24954,2)
 ;;=^5003138
 ;;^UTILITY(U,$J,358.3,24955,0)
 ;;=F11.981^^93^1120^10
 ;;^UTILITY(U,$J,358.3,24955,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24955,1,3,0)
 ;;=3^Opioid Induced Sexual Dysfunction w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,24955,1,4,0)
 ;;=4^F11.981
 ;;^UTILITY(U,$J,358.3,24955,2)
 ;;=^5003152
 ;;^UTILITY(U,$J,358.3,24956,0)
 ;;=F11.282^^93^1120^11
 ;;^UTILITY(U,$J,358.3,24956,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24956,1,3,0)
 ;;=3^Opioid Induced Sleep Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,24956,1,4,0)
 ;;=4^F11.282
 ;;^UTILITY(U,$J,358.3,24956,2)
 ;;=^5003139
 ;;^UTILITY(U,$J,358.3,24957,0)
 ;;=F11.982^^93^1120^12
 ;;^UTILITY(U,$J,358.3,24957,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24957,1,3,0)
 ;;=3^Opioid Induced Sleep Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,24957,1,4,0)
 ;;=4^F11.982
 ;;^UTILITY(U,$J,358.3,24957,2)
 ;;=^5003153
