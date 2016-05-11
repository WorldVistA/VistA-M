IBDEI1GR ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,24861,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24861,1,3,0)
 ;;=3^Alcohol Withdrawal w/o Perceptual Disturbances
 ;;^UTILITY(U,$J,358.3,24861,1,4,0)
 ;;=4^F10.239
 ;;^UTILITY(U,$J,358.3,24861,2)
 ;;=^5003089
 ;;^UTILITY(U,$J,358.3,24862,0)
 ;;=F10.24^^93^1116^35
 ;;^UTILITY(U,$J,358.3,24862,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24862,1,3,0)
 ;;=3^Alcohol-Induced Depressive & Related Disorder w/ Moderate-Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,24862,1,4,0)
 ;;=4^F10.24
 ;;^UTILITY(U,$J,358.3,24862,2)
 ;;=^5003090
 ;;^UTILITY(U,$J,358.3,24863,0)
 ;;=F10.29^^93^1116^37
 ;;^UTILITY(U,$J,358.3,24863,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24863,1,3,0)
 ;;=3^Alcohol-Related Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,24863,1,4,0)
 ;;=4^F10.29
 ;;^UTILITY(U,$J,358.3,24863,2)
 ;;=^5003100
 ;;^UTILITY(U,$J,358.3,24864,0)
 ;;=F10.180^^93^1116^1
 ;;^UTILITY(U,$J,358.3,24864,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24864,1,3,0)
 ;;=3^Alcohol Induced Anxiety Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,24864,1,4,0)
 ;;=4^F10.180
 ;;^UTILITY(U,$J,358.3,24864,2)
 ;;=^5003076
 ;;^UTILITY(U,$J,358.3,24865,0)
 ;;=F10.280^^93^1116^2
 ;;^UTILITY(U,$J,358.3,24865,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24865,1,3,0)
 ;;=3^Alcohol Induced Anxiety Disorder w/ Moderate/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,24865,1,4,0)
 ;;=4^F10.280
 ;;^UTILITY(U,$J,358.3,24865,2)
 ;;=^5003096
 ;;^UTILITY(U,$J,358.3,24866,0)
 ;;=F10.980^^93^1116^3
 ;;^UTILITY(U,$J,358.3,24866,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24866,1,3,0)
 ;;=3^Alcohol Induced Anxiety Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,24866,1,4,0)
 ;;=4^F10.980
 ;;^UTILITY(U,$J,358.3,24866,2)
 ;;=^5003110
 ;;^UTILITY(U,$J,358.3,24867,0)
 ;;=F10.94^^93^1116^4
 ;;^UTILITY(U,$J,358.3,24867,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24867,1,3,0)
 ;;=3^Alcohol Induced Depressive Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,24867,1,4,0)
 ;;=4^F10.94
 ;;^UTILITY(U,$J,358.3,24867,2)
 ;;=^5003104
 ;;^UTILITY(U,$J,358.3,24868,0)
 ;;=F10.26^^93^1116^7
 ;;^UTILITY(U,$J,358.3,24868,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24868,1,3,0)
 ;;=3^Alcohol Induced Neurocog Disorder,Amnestic Cofabul Type w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,24868,1,4,0)
 ;;=4^F10.26
 ;;^UTILITY(U,$J,358.3,24868,2)
 ;;=^5003094
 ;;^UTILITY(U,$J,358.3,24869,0)
 ;;=F10.96^^93^1116^8
 ;;^UTILITY(U,$J,358.3,24869,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24869,1,3,0)
 ;;=3^Alcohol Induced Neurocog Disorder,Amnestic Cofabul Type w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,24869,1,4,0)
 ;;=4^F10.96
 ;;^UTILITY(U,$J,358.3,24869,2)
 ;;=^5003108
 ;;^UTILITY(U,$J,358.3,24870,0)
 ;;=F10.27^^93^1116^9
 ;;^UTILITY(U,$J,358.3,24870,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24870,1,3,0)
 ;;=3^Alcohol Induced Neurocog Disorder,Nonamnestic Confabul Type,w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,24870,1,4,0)
 ;;=4^F10.27
 ;;^UTILITY(U,$J,358.3,24870,2)
 ;;=^5003095
 ;;^UTILITY(U,$J,358.3,24871,0)
 ;;=F10.97^^93^1116^10
 ;;^UTILITY(U,$J,358.3,24871,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24871,1,3,0)
 ;;=3^Alcohol Induced Neurocog Disorder,Nonamnestic Confabul Type w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,24871,1,4,0)
 ;;=4^F10.97
 ;;^UTILITY(U,$J,358.3,24871,2)
 ;;=^5003109
 ;;^UTILITY(U,$J,358.3,24872,0)
 ;;=F10.288^^93^1116^5
 ;;^UTILITY(U,$J,358.3,24872,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24872,1,3,0)
 ;;=3^Alcohol Induced Mild Neurocog Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,24872,1,4,0)
 ;;=4^F10.288
