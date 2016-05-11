IBDEI1IF ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,25613,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25613,1,3,0)
 ;;=3^Inhalant Intoxication w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,25613,1,4,0)
 ;;=4^F18.229
 ;;^UTILITY(U,$J,358.3,25613,2)
 ;;=^5003396
 ;;^UTILITY(U,$J,358.3,25614,0)
 ;;=F18.929^^95^1175^19
 ;;^UTILITY(U,$J,358.3,25614,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25614,1,3,0)
 ;;=3^Inhalant Intoxication w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,25614,1,4,0)
 ;;=4^F18.929
 ;;^UTILITY(U,$J,358.3,25614,2)
 ;;=^5003408
 ;;^UTILITY(U,$J,358.3,25615,0)
 ;;=F18.180^^95^1175^1
 ;;^UTILITY(U,$J,358.3,25615,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25615,1,3,0)
 ;;=3^Inhalant Induced Anxiety Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,25615,1,4,0)
 ;;=4^F18.180
 ;;^UTILITY(U,$J,358.3,25615,2)
 ;;=^5003389
 ;;^UTILITY(U,$J,358.3,25616,0)
 ;;=F18.280^^95^1175^2
 ;;^UTILITY(U,$J,358.3,25616,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25616,1,3,0)
 ;;=3^Inhalant Induced Anxiety Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,25616,1,4,0)
 ;;=4^F18.280
 ;;^UTILITY(U,$J,358.3,25616,2)
 ;;=^5003402
 ;;^UTILITY(U,$J,358.3,25617,0)
 ;;=F18.980^^95^1175^3
 ;;^UTILITY(U,$J,358.3,25617,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25617,1,3,0)
 ;;=3^Inhalant Induced Anxiety Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,25617,1,4,0)
 ;;=4^F18.980
 ;;^UTILITY(U,$J,358.3,25617,2)
 ;;=^5003414
 ;;^UTILITY(U,$J,358.3,25618,0)
 ;;=F18.94^^95^1175^4
 ;;^UTILITY(U,$J,358.3,25618,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25618,1,3,0)
 ;;=3^Inhalant Induced Depressive Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,25618,1,4,0)
 ;;=4^F18.94
 ;;^UTILITY(U,$J,358.3,25618,2)
 ;;=^5003409
 ;;^UTILITY(U,$J,358.3,25619,0)
 ;;=F18.17^^95^1175^5
 ;;^UTILITY(U,$J,358.3,25619,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25619,1,3,0)
 ;;=3^Inhalant Induced Major Neurocog Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,25619,1,4,0)
 ;;=4^F18.17
 ;;^UTILITY(U,$J,358.3,25619,2)
 ;;=^5003388
 ;;^UTILITY(U,$J,358.3,25620,0)
 ;;=F18.27^^95^1175^6
 ;;^UTILITY(U,$J,358.3,25620,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25620,1,3,0)
 ;;=3^Inhalant Induced Major Neurocog Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,25620,1,4,0)
 ;;=4^F18.27
 ;;^UTILITY(U,$J,358.3,25620,2)
 ;;=^5003401
 ;;^UTILITY(U,$J,358.3,25621,0)
 ;;=F18.97^^95^1175^7
 ;;^UTILITY(U,$J,358.3,25621,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25621,1,3,0)
 ;;=3^Inhalant Induced Major Neurocog Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,25621,1,4,0)
 ;;=4^F18.97
 ;;^UTILITY(U,$J,358.3,25621,2)
 ;;=^5003413
 ;;^UTILITY(U,$J,358.3,25622,0)
 ;;=F18.188^^95^1175^8
 ;;^UTILITY(U,$J,358.3,25622,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25622,1,3,0)
 ;;=3^Inhalant Induced Mild Neurocog Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,25622,1,4,0)
 ;;=4^F18.188
 ;;^UTILITY(U,$J,358.3,25622,2)
 ;;=^5003390
 ;;^UTILITY(U,$J,358.3,25623,0)
 ;;=F18.288^^95^1175^9
 ;;^UTILITY(U,$J,358.3,25623,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25623,1,3,0)
 ;;=3^Inhalant Induced Mild Neurocog Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,25623,1,4,0)
 ;;=4^F18.288
 ;;^UTILITY(U,$J,358.3,25623,2)
 ;;=^5003403
 ;;^UTILITY(U,$J,358.3,25624,0)
 ;;=F18.988^^95^1175^10
 ;;^UTILITY(U,$J,358.3,25624,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25624,1,3,0)
 ;;=3^Inhalant Induced Mild Neurocog Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,25624,1,4,0)
 ;;=4^F18.988
 ;;^UTILITY(U,$J,358.3,25624,2)
 ;;=^5003415
 ;;^UTILITY(U,$J,358.3,25625,0)
 ;;=F18.159^^95^1175^11
