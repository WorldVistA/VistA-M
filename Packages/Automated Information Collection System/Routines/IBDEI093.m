IBDEI093 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,3708,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3708,1,3,0)
 ;;=3^Gout,Chr Secondary w/o Tophus,Unspec Site
 ;;^UTILITY(U,$J,358.3,3708,1,4,0)
 ;;=4^M1A.40X0
 ;;^UTILITY(U,$J,358.3,3708,2)
 ;;=^5010993
 ;;^UTILITY(U,$J,358.3,3709,0)
 ;;=M1A.9XX1^^28^258^65
 ;;^UTILITY(U,$J,358.3,3709,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3709,1,3,0)
 ;;=3^Gout,Chr w/ Tophus,Unspec
 ;;^UTILITY(U,$J,358.3,3709,1,4,0)
 ;;=4^M1A.9XX1
 ;;^UTILITY(U,$J,358.3,3709,2)
 ;;=^5133773
 ;;^UTILITY(U,$J,358.3,3710,0)
 ;;=M1A.9XX0^^28^258^66
 ;;^UTILITY(U,$J,358.3,3710,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3710,1,3,0)
 ;;=3^Gout,Chr w/o Tophus,Unspec
 ;;^UTILITY(U,$J,358.3,3710,1,4,0)
 ;;=4^M1A.9XX0
 ;;^UTILITY(U,$J,358.3,3710,2)
 ;;=^5011027
 ;;^UTILITY(U,$J,358.3,3711,0)
 ;;=M15.1^^28^258^69
 ;;^UTILITY(U,$J,358.3,3711,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3711,1,3,0)
 ;;=3^Heberden's Nodes w/ Arthropathy
 ;;^UTILITY(U,$J,358.3,3711,1,4,0)
 ;;=4^M15.1
 ;;^UTILITY(U,$J,358.3,3711,2)
 ;;=^5010763
 ;;^UTILITY(U,$J,358.3,3712,0)
 ;;=R29.4^^28^258^70
 ;;^UTILITY(U,$J,358.3,3712,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3712,1,3,0)
 ;;=3^Hip,Clicking
 ;;^UTILITY(U,$J,358.3,3712,1,4,0)
 ;;=4^R29.4
 ;;^UTILITY(U,$J,358.3,3712,2)
 ;;=^5019315
 ;;^UTILITY(U,$J,358.3,3713,0)
 ;;=M79.4^^28^258^72
 ;;^UTILITY(U,$J,358.3,3713,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3713,1,3,0)
 ;;=3^Hypertrophy of Infrapatellar Fat Pad
 ;;^UTILITY(U,$J,358.3,3713,1,4,0)
 ;;=4^M79.4
 ;;^UTILITY(U,$J,358.3,3713,2)
 ;;=^5013324
 ;;^UTILITY(U,$J,358.3,3714,0)
 ;;=M96.89^^28^258^73
 ;;^UTILITY(U,$J,358.3,3714,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3714,1,3,0)
 ;;=3^Intraoperative/Postproc Compl/Disorder of Musculoskel System
 ;;^UTILITY(U,$J,358.3,3714,1,4,0)
 ;;=4^M96.89
 ;;^UTILITY(U,$J,358.3,3714,2)
 ;;=^5015399
 ;;^UTILITY(U,$J,358.3,3715,0)
 ;;=M25.9^^28^258^74
 ;;^UTILITY(U,$J,358.3,3715,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3715,1,3,0)
 ;;=3^Joint Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,3715,1,4,0)
 ;;=4^M25.9
 ;;^UTILITY(U,$J,358.3,3715,2)
 ;;=^5011693
 ;;^UTILITY(U,$J,358.3,3716,0)
 ;;=M25.40^^28^258^75
 ;;^UTILITY(U,$J,358.3,3716,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3716,1,3,0)
 ;;=3^Joint Effusion,Unspec Joint
 ;;^UTILITY(U,$J,358.3,3716,1,4,0)
 ;;=4^M25.40
 ;;^UTILITY(U,$J,358.3,3716,2)
 ;;=^5011575
 ;;^UTILITY(U,$J,358.3,3717,0)
 ;;=M25.70^^28^258^76
 ;;^UTILITY(U,$J,358.3,3717,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3717,1,3,0)
 ;;=3^Joint Osteophyte,Unspec Joint
 ;;^UTILITY(U,$J,358.3,3717,1,4,0)
 ;;=4^M25.70
 ;;^UTILITY(U,$J,358.3,3717,2)
 ;;=^5011645
 ;;^UTILITY(U,$J,358.3,3718,0)
 ;;=M76.9^^28^258^77
 ;;^UTILITY(U,$J,358.3,3718,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3718,1,3,0)
 ;;=3^Joint Tendinitis,Lower Limb,Excluding Foot
 ;;^UTILITY(U,$J,358.3,3718,1,4,0)
 ;;=4^M76.9
 ;;^UTILITY(U,$J,358.3,3718,2)
 ;;=^5013299
 ;;^UTILITY(U,$J,358.3,3719,0)
 ;;=M14.60^^28^258^78
 ;;^UTILITY(U,$J,358.3,3719,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3719,1,3,0)
 ;;=3^Joint,Charcot's,Unspec Site
 ;;^UTILITY(U,$J,358.3,3719,1,4,0)
 ;;=4^M14.60
 ;;^UTILITY(U,$J,358.3,3719,2)
 ;;=^5010714
 ;;^UTILITY(U,$J,358.3,3720,0)
 ;;=M25.00^^28^258^71
 ;;^UTILITY(U,$J,358.3,3720,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3720,1,3,0)
 ;;=3^Hoint,Hemarthrosis,Unspec Joint
 ;;^UTILITY(U,$J,358.3,3720,1,4,0)
 ;;=4^M25.00
 ;;^UTILITY(U,$J,358.3,3720,2)
 ;;=^5011475
 ;;^UTILITY(U,$J,358.3,3721,0)
 ;;=Z96.652^^28^258^80
 ;;^UTILITY(U,$J,358.3,3721,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3721,1,3,0)
 ;;=3^Knee Joint,Artificial,Left
