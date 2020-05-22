IBDEI2LO ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,41528,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41528,1,2,0)
 ;;=2^Asp/Inj Small Jt w/o US
 ;;^UTILITY(U,$J,358.3,41528,1,3,0)
 ;;=3^20600
 ;;^UTILITY(U,$J,358.3,41529,0)
 ;;=20550^^154^2056^9^^^^1
 ;;^UTILITY(U,$J,358.3,41529,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41529,1,2,0)
 ;;=2^Inject Tendon/Ligament/Cyst
 ;;^UTILITY(U,$J,358.3,41529,1,3,0)
 ;;=3^20550
 ;;^UTILITY(U,$J,358.3,41530,0)
 ;;=64490^^154^2056^7^^^^1
 ;;^UTILITY(U,$J,358.3,41530,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41530,1,2,0)
 ;;=2^Cervical/Thoracic Inj,1st Level
 ;;^UTILITY(U,$J,358.3,41530,1,3,0)
 ;;=3^64490
 ;;^UTILITY(U,$J,358.3,41531,0)
 ;;=64480^^154^2056^8^^^^1
 ;;^UTILITY(U,$J,358.3,41531,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41531,1,2,0)
 ;;=2^Cervical/Thoracic Inj,Ea Addl Level
 ;;^UTILITY(U,$J,358.3,41531,1,3,0)
 ;;=3^64480
 ;;^UTILITY(U,$J,358.3,41532,0)
 ;;=64483^^154^2056^16^^^^1
 ;;^UTILITY(U,$J,358.3,41532,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41532,1,2,0)
 ;;=2^Lumbar/Sacral Inj,1st Level
 ;;^UTILITY(U,$J,358.3,41532,1,3,0)
 ;;=3^64483
 ;;^UTILITY(U,$J,358.3,41533,0)
 ;;=64484^^154^2056^17^^^^1
 ;;^UTILITY(U,$J,358.3,41533,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41533,1,2,0)
 ;;=2^Lumbar/Sacral Inj,Ea Addl Level
 ;;^UTILITY(U,$J,358.3,41533,1,3,0)
 ;;=3^64484
 ;;^UTILITY(U,$J,358.3,41534,0)
 ;;=64490^^154^2056^10^^^^1
 ;;^UTILITY(U,$J,358.3,41534,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41534,1,2,0)
 ;;=2^Intraarticular Jt or MBB Cervical/Thoracic,1st Level
 ;;^UTILITY(U,$J,358.3,41534,1,3,0)
 ;;=3^64490
 ;;^UTILITY(U,$J,358.3,41535,0)
 ;;=64491^^154^2056^11^^^^1
 ;;^UTILITY(U,$J,358.3,41535,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41535,1,2,0)
 ;;=2^Intraarticular Jt or MBB Cervical/Thoracic,2nd Level
 ;;^UTILITY(U,$J,358.3,41535,1,3,0)
 ;;=3^64491
 ;;^UTILITY(U,$J,358.3,41536,0)
 ;;=64492^^154^2056^12^^^^1
 ;;^UTILITY(U,$J,358.3,41536,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41536,1,2,0)
 ;;=2^Intraarticular Jt or MBB Cervical/Thoracic,3rd Level
 ;;^UTILITY(U,$J,358.3,41536,1,3,0)
 ;;=3^64492
 ;;^UTILITY(U,$J,358.3,41537,0)
 ;;=64493^^154^2056^13^^^^1
 ;;^UTILITY(U,$J,358.3,41537,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41537,1,2,0)
 ;;=2^Intraarticular Jt or MBB Lumbar/Sacral,1st Level
 ;;^UTILITY(U,$J,358.3,41537,1,3,0)
 ;;=3^64493
 ;;^UTILITY(U,$J,358.3,41538,0)
 ;;=64494^^154^2056^14^^^^1
 ;;^UTILITY(U,$J,358.3,41538,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41538,1,2,0)
 ;;=2^Intraarticular Jt or MBB Lumbar/Sacral,2nd Level
 ;;^UTILITY(U,$J,358.3,41538,1,3,0)
 ;;=3^64494
 ;;^UTILITY(U,$J,358.3,41539,0)
 ;;=64495^^154^2056^15^^^^1
 ;;^UTILITY(U,$J,358.3,41539,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41539,1,2,0)
 ;;=2^Intraarticular Jt or MBB Lumbar/Sacral,3rd Level
 ;;^UTILITY(U,$J,358.3,41539,1,3,0)
 ;;=3^64495
 ;;^UTILITY(U,$J,358.3,41540,0)
 ;;=20552^^154^2056^19^^^^1
 ;;^UTILITY(U,$J,358.3,41540,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41540,1,2,0)
 ;;=2^Trigger Point Inj,1-2 Muscles
 ;;^UTILITY(U,$J,358.3,41540,1,3,0)
 ;;=3^20552
 ;;^UTILITY(U,$J,358.3,41541,0)
 ;;=27096^^154^2056^18^^^^1
 ;;^UTILITY(U,$J,358.3,41541,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41541,1,2,0)
 ;;=2^Sacroiliac Jt Inj w/ Fluoroscopy
 ;;^UTILITY(U,$J,358.3,41541,1,3,0)
 ;;=3^27096
 ;;^UTILITY(U,$J,358.3,41542,0)
 ;;=20553^^154^2056^20^^^^1
 ;;^UTILITY(U,$J,358.3,41542,1,0)
 ;;=^358.31IA^3^2
