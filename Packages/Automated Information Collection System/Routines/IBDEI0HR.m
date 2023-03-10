IBDEI0HR ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,7998,1,3,0)
 ;;=3^Pressure Ulcer of Buttock,Stage 3
 ;;^UTILITY(U,$J,358.3,7998,1,4,0)
 ;;=4^L89.303
 ;;^UTILITY(U,$J,358.3,7998,2)
 ;;=^5009392
 ;;^UTILITY(U,$J,358.3,7999,0)
 ;;=L89.304^^39^391^280
 ;;^UTILITY(U,$J,358.3,7999,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7999,1,3,0)
 ;;=3^Pressure Ulcer of Buttock,Stage 4
 ;;^UTILITY(U,$J,358.3,7999,1,4,0)
 ;;=4^L89.304
 ;;^UTILITY(U,$J,358.3,7999,2)
 ;;=^5009393
 ;;^UTILITY(U,$J,358.3,8000,0)
 ;;=L89.309^^39^391^281
 ;;^UTILITY(U,$J,358.3,8000,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8000,1,3,0)
 ;;=3^Pressure Ulcer of Buttock,Stage Unspec
 ;;^UTILITY(U,$J,358.3,8000,1,4,0)
 ;;=4^L89.309
 ;;^UTILITY(U,$J,358.3,8000,2)
 ;;=^5133672
 ;;^UTILITY(U,$J,358.3,8001,0)
 ;;=L89.90^^39^391^287
 ;;^UTILITY(U,$J,358.3,8001,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8001,1,3,0)
 ;;=3^Pressure Ulcer of Unspec Site,Unspec Stage
 ;;^UTILITY(U,$J,358.3,8001,1,4,0)
 ;;=4^L89.90
 ;;^UTILITY(U,$J,358.3,8001,2)
 ;;=^5133666
 ;;^UTILITY(U,$J,358.3,8002,0)
 ;;=L89.91^^39^391^283
 ;;^UTILITY(U,$J,358.3,8002,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8002,1,3,0)
 ;;=3^Pressure Ulcer of Unspec Site,Stage 1
 ;;^UTILITY(U,$J,358.3,8002,1,4,0)
 ;;=4^L89.91
 ;;^UTILITY(U,$J,358.3,8002,2)
 ;;=^5133664
 ;;^UTILITY(U,$J,358.3,8003,0)
 ;;=L89.92^^39^391^284
 ;;^UTILITY(U,$J,358.3,8003,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8003,1,3,0)
 ;;=3^Pressure Ulcer of Unspec Site,Stage 2
 ;;^UTILITY(U,$J,358.3,8003,1,4,0)
 ;;=4^L89.92
 ;;^UTILITY(U,$J,358.3,8003,2)
 ;;=^5133667
 ;;^UTILITY(U,$J,358.3,8004,0)
 ;;=L89.93^^39^391^285
 ;;^UTILITY(U,$J,358.3,8004,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8004,1,3,0)
 ;;=3^Pressure Ulcer of Unspec Site,Stage 3
 ;;^UTILITY(U,$J,358.3,8004,1,4,0)
 ;;=4^L89.93
 ;;^UTILITY(U,$J,358.3,8004,2)
 ;;=^5133668
 ;;^UTILITY(U,$J,358.3,8005,0)
 ;;=L89.94^^39^391^286
 ;;^UTILITY(U,$J,358.3,8005,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8005,1,3,0)
 ;;=3^Pressure Ulcer of Unspec Site,Stage 4
 ;;^UTILITY(U,$J,358.3,8005,1,4,0)
 ;;=4^L89.94
 ;;^UTILITY(U,$J,358.3,8005,2)
 ;;=^5133669
 ;;^UTILITY(U,$J,358.3,8006,0)
 ;;=L89.95^^39^391^288
 ;;^UTILITY(U,$J,358.3,8006,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8006,1,3,0)
 ;;=3^Pressure Ulcer of Unspec Site,Unstageable
 ;;^UTILITY(U,$J,358.3,8006,1,4,0)
 ;;=4^L89.95
 ;;^UTILITY(U,$J,358.3,8006,2)
 ;;=^5133660
 ;;^UTILITY(U,$J,358.3,8007,0)
 ;;=L92.0^^39^391^159
 ;;^UTILITY(U,$J,358.3,8007,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8007,1,3,0)
 ;;=3^Granuloma Annulare
 ;;^UTILITY(U,$J,358.3,8007,1,4,0)
 ;;=4^L92.0
 ;;^UTILITY(U,$J,358.3,8007,2)
 ;;=^184052
 ;;^UTILITY(U,$J,358.3,8008,0)
 ;;=L95.1^^39^391^146
 ;;^UTILITY(U,$J,358.3,8008,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8008,1,3,0)
 ;;=3^Erythema Elevatum Diutinum
 ;;^UTILITY(U,$J,358.3,8008,1,4,0)
 ;;=4^L95.1
 ;;^UTILITY(U,$J,358.3,8008,2)
 ;;=^5009477
 ;;^UTILITY(U,$J,358.3,8009,0)
 ;;=L97.111^^39^391^262
 ;;^UTILITY(U,$J,358.3,8009,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8009,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer of Right Thigh w/ Breakdown of Skin
 ;;^UTILITY(U,$J,358.3,8009,1,4,0)
 ;;=4^L97.111
 ;;^UTILITY(U,$J,358.3,8009,2)
 ;;=^5009485
 ;;^UTILITY(U,$J,358.3,8010,0)
 ;;=L97.112^^39^391^263
 ;;^UTILITY(U,$J,358.3,8010,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8010,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer of Right Thigh w/ Fat Layer Exposed
