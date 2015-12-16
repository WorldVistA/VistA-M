IBDEI03N ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,1171,1,4,0)
 ;;=4^N31.9
 ;;^UTILITY(U,$J,358.3,1171,2)
 ;;=^5015648
 ;;^UTILITY(U,$J,358.3,1172,0)
 ;;=N31.0^^3^38^63
 ;;^UTILITY(U,$J,358.3,1172,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1172,1,3,0)
 ;;=3^Uninhibited neuropathic bladder, not elsewhere classified
 ;;^UTILITY(U,$J,358.3,1172,1,4,0)
 ;;=4^N31.0
 ;;^UTILITY(U,$J,358.3,1172,2)
 ;;=^5015644
 ;;^UTILITY(U,$J,358.3,1173,0)
 ;;=N31.1^^3^38^57
 ;;^UTILITY(U,$J,358.3,1173,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1173,1,3,0)
 ;;=3^Reflex neuropathic bladder, not elsewhere classified
 ;;^UTILITY(U,$J,358.3,1173,1,4,0)
 ;;=4^N31.1
 ;;^UTILITY(U,$J,358.3,1173,2)
 ;;=^5015645
 ;;^UTILITY(U,$J,358.3,1174,0)
 ;;=N36.44^^3^38^43
 ;;^UTILITY(U,$J,358.3,1174,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1174,1,3,0)
 ;;=3^Muscular disorders of urethra
 ;;^UTILITY(U,$J,358.3,1174,1,4,0)
 ;;=4^N36.44
 ;;^UTILITY(U,$J,358.3,1174,2)
 ;;=^5015676
 ;;^UTILITY(U,$J,358.3,1175,0)
 ;;=N34.1^^3^38^49
 ;;^UTILITY(U,$J,358.3,1175,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1175,1,3,0)
 ;;=3^Nonspecific urethritis
 ;;^UTILITY(U,$J,358.3,1175,1,4,0)
 ;;=4^N34.1
 ;;^UTILITY(U,$J,358.3,1175,2)
 ;;=^5015655
 ;;^UTILITY(U,$J,358.3,1176,0)
 ;;=N39.0^^3^38^69
 ;;^UTILITY(U,$J,358.3,1176,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1176,1,3,0)
 ;;=3^Urinary tract infection, site not specified
 ;;^UTILITY(U,$J,358.3,1176,1,4,0)
 ;;=4^N39.0
 ;;^UTILITY(U,$J,358.3,1176,2)
 ;;=^124436
 ;;^UTILITY(U,$J,358.3,1177,0)
 ;;=R31.9^^3^38^23
 ;;^UTILITY(U,$J,358.3,1177,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1177,1,3,0)
 ;;=3^Hematuria, unspecified
 ;;^UTILITY(U,$J,358.3,1177,1,4,0)
 ;;=4^R31.9
 ;;^UTILITY(U,$J,358.3,1177,2)
 ;;=^5019328
 ;;^UTILITY(U,$J,358.3,1178,0)
 ;;=R31.0^^3^38^22
 ;;^UTILITY(U,$J,358.3,1178,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1178,1,3,0)
 ;;=3^Gross hematuria
 ;;^UTILITY(U,$J,358.3,1178,1,4,0)
 ;;=4^R31.0
 ;;^UTILITY(U,$J,358.3,1178,2)
 ;;=^5019325
 ;;^UTILITY(U,$J,358.3,1179,0)
 ;;=R31.2^^3^38^42
 ;;^UTILITY(U,$J,358.3,1179,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1179,1,3,0)
 ;;=3^Microscopic hematuria NEC
 ;;^UTILITY(U,$J,358.3,1179,1,4,0)
 ;;=4^R31.2
 ;;^UTILITY(U,$J,358.3,1179,2)
 ;;=^5019327
 ;;^UTILITY(U,$J,358.3,1180,0)
 ;;=N40.0^^3^38^17
 ;;^UTILITY(U,$J,358.3,1180,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1180,1,3,0)
 ;;=3^Enlarged prostate without lower urinary tract symptoms
 ;;^UTILITY(U,$J,358.3,1180,1,4,0)
 ;;=4^N40.0
 ;;^UTILITY(U,$J,358.3,1180,2)
 ;;=^5015689
 ;;^UTILITY(U,$J,358.3,1181,0)
 ;;=N40.1^^3^38^16
 ;;^UTILITY(U,$J,358.3,1181,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1181,1,3,0)
 ;;=3^Enlarged prostate with lower urinary tract symptoms
 ;;^UTILITY(U,$J,358.3,1181,1,4,0)
 ;;=4^N40.1
 ;;^UTILITY(U,$J,358.3,1181,2)
 ;;=^5015690
 ;;^UTILITY(U,$J,358.3,1182,0)
 ;;=N40.2^^3^38^47
 ;;^UTILITY(U,$J,358.3,1182,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1182,1,3,0)
 ;;=3^Nodular prostate without lower urinary tract symptoms
 ;;^UTILITY(U,$J,358.3,1182,1,4,0)
 ;;=4^N40.2
 ;;^UTILITY(U,$J,358.3,1182,2)
 ;;=^5015691
 ;;^UTILITY(U,$J,358.3,1183,0)
 ;;=N41.0^^3^38^4
 ;;^UTILITY(U,$J,358.3,1183,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1183,1,3,0)
 ;;=3^Acute prostatitis
 ;;^UTILITY(U,$J,358.3,1183,1,4,0)
 ;;=4^N41.0
 ;;^UTILITY(U,$J,358.3,1183,2)
 ;;=^259106
 ;;^UTILITY(U,$J,358.3,1184,0)
 ;;=N45.2^^3^38^50
 ;;^UTILITY(U,$J,358.3,1184,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1184,1,3,0)
 ;;=3^Orchitis
 ;;^UTILITY(U,$J,358.3,1184,1,4,0)
 ;;=4^N45.2
 ;;^UTILITY(U,$J,358.3,1184,2)
 ;;=^86174
