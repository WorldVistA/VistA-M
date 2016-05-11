IBDEI1FS ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,24407,1,4,0)
 ;;=4^F18.229
 ;;^UTILITY(U,$J,358.3,24407,2)
 ;;=^5003396
 ;;^UTILITY(U,$J,358.3,24408,0)
 ;;=F18.929^^90^1071^19
 ;;^UTILITY(U,$J,358.3,24408,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24408,1,3,0)
 ;;=3^Inhalant Intoxication w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,24408,1,4,0)
 ;;=4^F18.929
 ;;^UTILITY(U,$J,358.3,24408,2)
 ;;=^5003408
 ;;^UTILITY(U,$J,358.3,24409,0)
 ;;=F18.180^^90^1071^1
 ;;^UTILITY(U,$J,358.3,24409,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24409,1,3,0)
 ;;=3^Inhalant Induced Anxiety Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,24409,1,4,0)
 ;;=4^F18.180
 ;;^UTILITY(U,$J,358.3,24409,2)
 ;;=^5003389
 ;;^UTILITY(U,$J,358.3,24410,0)
 ;;=F18.280^^90^1071^2
 ;;^UTILITY(U,$J,358.3,24410,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24410,1,3,0)
 ;;=3^Inhalant Induced Anxiety Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,24410,1,4,0)
 ;;=4^F18.280
 ;;^UTILITY(U,$J,358.3,24410,2)
 ;;=^5003402
 ;;^UTILITY(U,$J,358.3,24411,0)
 ;;=F18.980^^90^1071^3
 ;;^UTILITY(U,$J,358.3,24411,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24411,1,3,0)
 ;;=3^Inhalant Induced Anxiety Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,24411,1,4,0)
 ;;=4^F18.980
 ;;^UTILITY(U,$J,358.3,24411,2)
 ;;=^5003414
 ;;^UTILITY(U,$J,358.3,24412,0)
 ;;=F18.94^^90^1071^4
 ;;^UTILITY(U,$J,358.3,24412,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24412,1,3,0)
 ;;=3^Inhalant Induced Depressive Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,24412,1,4,0)
 ;;=4^F18.94
 ;;^UTILITY(U,$J,358.3,24412,2)
 ;;=^5003409
 ;;^UTILITY(U,$J,358.3,24413,0)
 ;;=F18.17^^90^1071^5
 ;;^UTILITY(U,$J,358.3,24413,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24413,1,3,0)
 ;;=3^Inhalant Induced Major Neurocog Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,24413,1,4,0)
 ;;=4^F18.17
 ;;^UTILITY(U,$J,358.3,24413,2)
 ;;=^5003388
 ;;^UTILITY(U,$J,358.3,24414,0)
 ;;=F18.27^^90^1071^6
 ;;^UTILITY(U,$J,358.3,24414,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24414,1,3,0)
 ;;=3^Inhalant Induced Major Neurocog Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,24414,1,4,0)
 ;;=4^F18.27
 ;;^UTILITY(U,$J,358.3,24414,2)
 ;;=^5003401
 ;;^UTILITY(U,$J,358.3,24415,0)
 ;;=F18.97^^90^1071^7
 ;;^UTILITY(U,$J,358.3,24415,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24415,1,3,0)
 ;;=3^Inhalant Induced Major Neurocog Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,24415,1,4,0)
 ;;=4^F18.97
 ;;^UTILITY(U,$J,358.3,24415,2)
 ;;=^5003413
 ;;^UTILITY(U,$J,358.3,24416,0)
 ;;=F18.188^^90^1071^8
 ;;^UTILITY(U,$J,358.3,24416,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24416,1,3,0)
 ;;=3^Inhalant Induced Mild Neurocog Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,24416,1,4,0)
 ;;=4^F18.188
 ;;^UTILITY(U,$J,358.3,24416,2)
 ;;=^5003390
 ;;^UTILITY(U,$J,358.3,24417,0)
 ;;=F18.288^^90^1071^9
 ;;^UTILITY(U,$J,358.3,24417,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24417,1,3,0)
 ;;=3^Inhalant Induced Mild Neurocog Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,24417,1,4,0)
 ;;=4^F18.288
 ;;^UTILITY(U,$J,358.3,24417,2)
 ;;=^5003403
 ;;^UTILITY(U,$J,358.3,24418,0)
 ;;=F18.988^^90^1071^10
 ;;^UTILITY(U,$J,358.3,24418,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24418,1,3,0)
 ;;=3^Inhalant Induced Mild Neurocog Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,24418,1,4,0)
 ;;=4^F18.988
 ;;^UTILITY(U,$J,358.3,24418,2)
 ;;=^5003415
 ;;^UTILITY(U,$J,358.3,24419,0)
 ;;=F18.159^^90^1071^11
 ;;^UTILITY(U,$J,358.3,24419,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24419,1,3,0)
 ;;=3^Inhalant Induced Psychotic Disorder w/ Mild Use Disorder
