IBDEI08A ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,3577,1,4,0)
 ;;=4^G81.92
 ;;^UTILITY(U,$J,358.3,3577,2)
 ;;=^5004122
 ;;^UTILITY(U,$J,358.3,3578,0)
 ;;=G81.94^^18^220^68
 ;;^UTILITY(U,$J,358.3,3578,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3578,1,3,0)
 ;;=3^Hemiplegia,Affecting Lt Nondominant Side
 ;;^UTILITY(U,$J,358.3,3578,1,4,0)
 ;;=4^G81.94
 ;;^UTILITY(U,$J,358.3,3578,2)
 ;;=^5004124
 ;;^UTILITY(U,$J,358.3,3579,0)
 ;;=G81.91^^18^220^69
 ;;^UTILITY(U,$J,358.3,3579,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3579,1,3,0)
 ;;=3^Hemiplegia,Affecting Rt Dominant Side,Unspec
 ;;^UTILITY(U,$J,358.3,3579,1,4,0)
 ;;=4^G81.91
 ;;^UTILITY(U,$J,358.3,3579,2)
 ;;=^5004121
 ;;^UTILITY(U,$J,358.3,3580,0)
 ;;=G81.93^^18^220^70
 ;;^UTILITY(U,$J,358.3,3580,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3580,1,3,0)
 ;;=3^Hemiplegia,Affecting Rt Nondominant Side
 ;;^UTILITY(U,$J,358.3,3580,1,4,0)
 ;;=4^G81.93
 ;;^UTILITY(U,$J,358.3,3580,2)
 ;;=^5004123
 ;;^UTILITY(U,$J,358.3,3581,0)
 ;;=G10.^^18^220^71
 ;;^UTILITY(U,$J,358.3,3581,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3581,1,3,0)
 ;;=3^Huntington's Disease
 ;;^UTILITY(U,$J,358.3,3581,1,4,0)
 ;;=4^G10.
 ;;^UTILITY(U,$J,358.3,3581,2)
 ;;=^5003751
 ;;^UTILITY(U,$J,358.3,3582,0)
 ;;=G91.2^^18^220^72
 ;;^UTILITY(U,$J,358.3,3582,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3582,1,3,0)
 ;;=3^Hydrocephalus,Idiopathic,Normal Pressure
 ;;^UTILITY(U,$J,358.3,3582,1,4,0)
 ;;=4^G91.2
 ;;^UTILITY(U,$J,358.3,3582,2)
 ;;=^5004174
 ;;^UTILITY(U,$J,358.3,3583,0)
 ;;=G91.9^^18^220^73
 ;;^UTILITY(U,$J,358.3,3583,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3583,1,3,0)
 ;;=3^Hydrocephalus,Unspec
 ;;^UTILITY(U,$J,358.3,3583,1,4,0)
 ;;=4^G91.9
 ;;^UTILITY(U,$J,358.3,3583,2)
 ;;=^5004178
 ;;^UTILITY(U,$J,358.3,3584,0)
 ;;=R25.9^^18^220^74
 ;;^UTILITY(U,$J,358.3,3584,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3584,1,3,0)
 ;;=3^Involuntary Movements,Abnormal,Unspec
 ;;^UTILITY(U,$J,358.3,3584,1,4,0)
 ;;=4^R25.9
 ;;^UTILITY(U,$J,358.3,3584,2)
 ;;=^5019303
 ;;^UTILITY(U,$J,358.3,3585,0)
 ;;=G43.911^^18^220^75
 ;;^UTILITY(U,$J,358.3,3585,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3585,1,3,0)
 ;;=3^Migraine,Intractable w/ Status Migrainosus,Unspec
 ;;^UTILITY(U,$J,358.3,3585,1,4,0)
 ;;=4^G43.911
 ;;^UTILITY(U,$J,358.3,3585,2)
 ;;=^5003910
 ;;^UTILITY(U,$J,358.3,3586,0)
 ;;=G43.919^^18^220^76
 ;;^UTILITY(U,$J,358.3,3586,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3586,1,3,0)
 ;;=3^Migraine,Intractable w/o Status Migrainosus,Unspec
 ;;^UTILITY(U,$J,358.3,3586,1,4,0)
 ;;=4^G43.919
 ;;^UTILITY(U,$J,358.3,3586,2)
 ;;=^5003911
 ;;^UTILITY(U,$J,358.3,3587,0)
 ;;=G43.901^^18^220^77
 ;;^UTILITY(U,$J,358.3,3587,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3587,1,3,0)
 ;;=3^Migraine,Not Intractable w/ Status Migrainosis,Unspec
 ;;^UTILITY(U,$J,358.3,3587,1,4,0)
 ;;=4^G43.901
 ;;^UTILITY(U,$J,358.3,3587,2)
 ;;=^5003908
 ;;^UTILITY(U,$J,358.3,3588,0)
 ;;=G43.909^^18^220^78
 ;;^UTILITY(U,$J,358.3,3588,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3588,1,3,0)
 ;;=3^Migraine,Not Intractable w/o Status Migrainosis,Unspec
 ;;^UTILITY(U,$J,358.3,3588,1,4,0)
 ;;=4^G43.909
 ;;^UTILITY(U,$J,358.3,3588,2)
 ;;=^5003909
 ;;^UTILITY(U,$J,358.3,3589,0)
 ;;=G12.20^^18^220^79
 ;;^UTILITY(U,$J,358.3,3589,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3589,1,3,0)
 ;;=3^Motor Neuron Disease,Unspec
 ;;^UTILITY(U,$J,358.3,3589,1,4,0)
 ;;=4^G12.20
 ;;^UTILITY(U,$J,358.3,3589,2)
 ;;=^5003761
 ;;^UTILITY(U,$J,358.3,3590,0)
 ;;=G25.70^^18^220^80
 ;;^UTILITY(U,$J,358.3,3590,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3590,1,3,0)
 ;;=3^Movement Disorder,Drug-Induced,Unspec
