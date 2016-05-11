IBDEI1L0 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,26825,1,3,0)
 ;;=3^Alcohol-Induced Depressive & Related Disorder w/ Moderate-Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,26825,1,4,0)
 ;;=4^F10.24
 ;;^UTILITY(U,$J,358.3,26825,2)
 ;;=^5003090
 ;;^UTILITY(U,$J,358.3,26826,0)
 ;;=F10.29^^100^1291^37
 ;;^UTILITY(U,$J,358.3,26826,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26826,1,3,0)
 ;;=3^Alcohol-Related Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,26826,1,4,0)
 ;;=4^F10.29
 ;;^UTILITY(U,$J,358.3,26826,2)
 ;;=^5003100
 ;;^UTILITY(U,$J,358.3,26827,0)
 ;;=F10.180^^100^1291^1
 ;;^UTILITY(U,$J,358.3,26827,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26827,1,3,0)
 ;;=3^Alcohol Induced Anxiety Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,26827,1,4,0)
 ;;=4^F10.180
 ;;^UTILITY(U,$J,358.3,26827,2)
 ;;=^5003076
 ;;^UTILITY(U,$J,358.3,26828,0)
 ;;=F10.280^^100^1291^2
 ;;^UTILITY(U,$J,358.3,26828,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26828,1,3,0)
 ;;=3^Alcohol Induced Anxiety Disorder w/ Moderate/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,26828,1,4,0)
 ;;=4^F10.280
 ;;^UTILITY(U,$J,358.3,26828,2)
 ;;=^5003096
 ;;^UTILITY(U,$J,358.3,26829,0)
 ;;=F10.980^^100^1291^3
 ;;^UTILITY(U,$J,358.3,26829,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26829,1,3,0)
 ;;=3^Alcohol Induced Anxiety Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,26829,1,4,0)
 ;;=4^F10.980
 ;;^UTILITY(U,$J,358.3,26829,2)
 ;;=^5003110
 ;;^UTILITY(U,$J,358.3,26830,0)
 ;;=F10.94^^100^1291^4
 ;;^UTILITY(U,$J,358.3,26830,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26830,1,3,0)
 ;;=3^Alcohol Induced Depressive Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,26830,1,4,0)
 ;;=4^F10.94
 ;;^UTILITY(U,$J,358.3,26830,2)
 ;;=^5003104
 ;;^UTILITY(U,$J,358.3,26831,0)
 ;;=F10.26^^100^1291^7
 ;;^UTILITY(U,$J,358.3,26831,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26831,1,3,0)
 ;;=3^Alcohol Induced Neurocog Disorder,Amnestic Cofabul Type w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,26831,1,4,0)
 ;;=4^F10.26
 ;;^UTILITY(U,$J,358.3,26831,2)
 ;;=^5003094
 ;;^UTILITY(U,$J,358.3,26832,0)
 ;;=F10.96^^100^1291^8
 ;;^UTILITY(U,$J,358.3,26832,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26832,1,3,0)
 ;;=3^Alcohol Induced Neurocog Disorder,Amnestic Cofabul Type w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,26832,1,4,0)
 ;;=4^F10.96
 ;;^UTILITY(U,$J,358.3,26832,2)
 ;;=^5003108
 ;;^UTILITY(U,$J,358.3,26833,0)
 ;;=F10.27^^100^1291^9
 ;;^UTILITY(U,$J,358.3,26833,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26833,1,3,0)
 ;;=3^Alcohol Induced Neurocog Disorder,Nonamnestic Confabul Type,w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,26833,1,4,0)
 ;;=4^F10.27
 ;;^UTILITY(U,$J,358.3,26833,2)
 ;;=^5003095
 ;;^UTILITY(U,$J,358.3,26834,0)
 ;;=F10.97^^100^1291^10
 ;;^UTILITY(U,$J,358.3,26834,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26834,1,3,0)
 ;;=3^Alcohol Induced Neurocog Disorder,Nonamnestic Confabul Type w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,26834,1,4,0)
 ;;=4^F10.97
 ;;^UTILITY(U,$J,358.3,26834,2)
 ;;=^5003109
 ;;^UTILITY(U,$J,358.3,26835,0)
 ;;=F10.288^^100^1291^5
 ;;^UTILITY(U,$J,358.3,26835,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26835,1,3,0)
 ;;=3^Alcohol Induced Mild Neurocog Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,26835,1,4,0)
 ;;=4^F10.288
 ;;^UTILITY(U,$J,358.3,26835,2)
 ;;=^5003099
 ;;^UTILITY(U,$J,358.3,26836,0)
 ;;=F10.988^^100^1291^6
 ;;^UTILITY(U,$J,358.3,26836,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26836,1,3,0)
 ;;=3^Alcohol Induced Mild Neurocog Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,26836,1,4,0)
 ;;=4^F10.988
 ;;^UTILITY(U,$J,358.3,26836,2)
 ;;=^5003113
