IBDEI1I2 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,25454,1,3,0)
 ;;=3^Alcohol Induced Anxiety Disorder w/ Moderate/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,25454,1,4,0)
 ;;=4^F10.280
 ;;^UTILITY(U,$J,358.3,25454,2)
 ;;=^5003096
 ;;^UTILITY(U,$J,358.3,25455,0)
 ;;=F10.980^^95^1165^3
 ;;^UTILITY(U,$J,358.3,25455,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25455,1,3,0)
 ;;=3^Alcohol Induced Anxiety Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,25455,1,4,0)
 ;;=4^F10.980
 ;;^UTILITY(U,$J,358.3,25455,2)
 ;;=^5003110
 ;;^UTILITY(U,$J,358.3,25456,0)
 ;;=F10.94^^95^1165^4
 ;;^UTILITY(U,$J,358.3,25456,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25456,1,3,0)
 ;;=3^Alcohol Induced Depressive Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,25456,1,4,0)
 ;;=4^F10.94
 ;;^UTILITY(U,$J,358.3,25456,2)
 ;;=^5003104
 ;;^UTILITY(U,$J,358.3,25457,0)
 ;;=F10.26^^95^1165^7
 ;;^UTILITY(U,$J,358.3,25457,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25457,1,3,0)
 ;;=3^Alcohol Induced Neurocog Disorder,Amnestic Cofabul Type w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,25457,1,4,0)
 ;;=4^F10.26
 ;;^UTILITY(U,$J,358.3,25457,2)
 ;;=^5003094
 ;;^UTILITY(U,$J,358.3,25458,0)
 ;;=F10.96^^95^1165^8
 ;;^UTILITY(U,$J,358.3,25458,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25458,1,3,0)
 ;;=3^Alcohol Induced Neurocog Disorder,Amnestic Cofabul Type w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,25458,1,4,0)
 ;;=4^F10.96
 ;;^UTILITY(U,$J,358.3,25458,2)
 ;;=^5003108
 ;;^UTILITY(U,$J,358.3,25459,0)
 ;;=F10.27^^95^1165^9
 ;;^UTILITY(U,$J,358.3,25459,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25459,1,3,0)
 ;;=3^Alcohol Induced Neurocog Disorder,Nonamnestic Confabul Type,w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,25459,1,4,0)
 ;;=4^F10.27
 ;;^UTILITY(U,$J,358.3,25459,2)
 ;;=^5003095
 ;;^UTILITY(U,$J,358.3,25460,0)
 ;;=F10.97^^95^1165^10
 ;;^UTILITY(U,$J,358.3,25460,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25460,1,3,0)
 ;;=3^Alcohol Induced Neurocog Disorder,Nonamnestic Confabul Type w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,25460,1,4,0)
 ;;=4^F10.97
 ;;^UTILITY(U,$J,358.3,25460,2)
 ;;=^5003109
 ;;^UTILITY(U,$J,358.3,25461,0)
 ;;=F10.288^^95^1165^5
 ;;^UTILITY(U,$J,358.3,25461,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25461,1,3,0)
 ;;=3^Alcohol Induced Mild Neurocog Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,25461,1,4,0)
 ;;=4^F10.288
 ;;^UTILITY(U,$J,358.3,25461,2)
 ;;=^5003099
 ;;^UTILITY(U,$J,358.3,25462,0)
 ;;=F10.988^^95^1165^6
 ;;^UTILITY(U,$J,358.3,25462,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25462,1,3,0)
 ;;=3^Alcohol Induced Mild Neurocog Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,25462,1,4,0)
 ;;=4^F10.988
 ;;^UTILITY(U,$J,358.3,25462,2)
 ;;=^5003113
 ;;^UTILITY(U,$J,358.3,25463,0)
 ;;=F10.159^^95^1165^11
 ;;^UTILITY(U,$J,358.3,25463,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25463,1,3,0)
 ;;=3^Alcohol Induced Psychotic Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,25463,1,4,0)
 ;;=4^F10.159
 ;;^UTILITY(U,$J,358.3,25463,2)
 ;;=^5003075
 ;;^UTILITY(U,$J,358.3,25464,0)
 ;;=F10.259^^95^1165^12
 ;;^UTILITY(U,$J,358.3,25464,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25464,1,3,0)
 ;;=3^Alcohol Induced Psychotic Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,25464,1,4,0)
 ;;=4^F10.259
 ;;^UTILITY(U,$J,358.3,25464,2)
 ;;=^5003093
 ;;^UTILITY(U,$J,358.3,25465,0)
 ;;=F10.959^^95^1165^13
 ;;^UTILITY(U,$J,358.3,25465,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25465,1,3,0)
 ;;=3^Alcohol Induced Psychotic Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,25465,1,4,0)
 ;;=4^F10.959
 ;;^UTILITY(U,$J,358.3,25465,2)
 ;;=^5003107
