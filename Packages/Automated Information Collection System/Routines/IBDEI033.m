IBDEI033 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,994,0)
 ;;=H60.313^^6^108^22
 ;;^UTILITY(U,$J,358.3,994,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,994,1,3,0)
 ;;=3^Otitis Externa Diffused,Bilateral
 ;;^UTILITY(U,$J,358.3,994,1,4,0)
 ;;=4^H60.313
 ;;^UTILITY(U,$J,358.3,994,2)
 ;;=^5006449
 ;;^UTILITY(U,$J,358.3,995,0)
 ;;=H60.321^^6^108^27
 ;;^UTILITY(U,$J,358.3,995,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,995,1,3,0)
 ;;=3^Otitis Externa Hemorrhagic,Right Ear
 ;;^UTILITY(U,$J,358.3,995,1,4,0)
 ;;=4^H60.321
 ;;^UTILITY(U,$J,358.3,995,2)
 ;;=^5006451
 ;;^UTILITY(U,$J,358.3,996,0)
 ;;=H60.322^^6^108^26
 ;;^UTILITY(U,$J,358.3,996,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,996,1,3,0)
 ;;=3^Otitis Externa Hemorrhagic,Left Ear
 ;;^UTILITY(U,$J,358.3,996,1,4,0)
 ;;=4^H60.322
 ;;^UTILITY(U,$J,358.3,996,2)
 ;;=^5006452
 ;;^UTILITY(U,$J,358.3,997,0)
 ;;=H60.323^^6^108^25
 ;;^UTILITY(U,$J,358.3,997,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,997,1,3,0)
 ;;=3^Otitis Externa Hemorrhagic,Bilateral
 ;;^UTILITY(U,$J,358.3,997,1,4,0)
 ;;=4^H60.323
 ;;^UTILITY(U,$J,358.3,997,2)
 ;;=^5006453
 ;;^UTILITY(U,$J,358.3,998,0)
 ;;=H60.391^^6^108^30
 ;;^UTILITY(U,$J,358.3,998,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,998,1,3,0)
 ;;=3^Otitis Externa Infective,Right Ear
 ;;^UTILITY(U,$J,358.3,998,1,4,0)
 ;;=4^H60.391
 ;;^UTILITY(U,$J,358.3,998,2)
 ;;=^5006459
 ;;^UTILITY(U,$J,358.3,999,0)
 ;;=H60.392^^6^108^29
 ;;^UTILITY(U,$J,358.3,999,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,999,1,3,0)
 ;;=3^Otitis Externa Infective,Left Ear
 ;;^UTILITY(U,$J,358.3,999,1,4,0)
 ;;=4^H60.392
 ;;^UTILITY(U,$J,358.3,999,2)
 ;;=^5006460
 ;;^UTILITY(U,$J,358.3,1000,0)
 ;;=H60.323^^6^108^28
 ;;^UTILITY(U,$J,358.3,1000,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1000,1,3,0)
 ;;=3^Otitis Externa Infective,Bilateral
 ;;^UTILITY(U,$J,358.3,1000,1,4,0)
 ;;=4^H60.323
 ;;^UTILITY(U,$J,358.3,1000,2)
 ;;=^5006453
 ;;^UTILITY(U,$J,358.3,1001,0)
 ;;=H66.91^^6^108^33
 ;;^UTILITY(U,$J,358.3,1001,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1001,1,3,0)
 ;;=3^Otitis Media,Unspec,Right Ear
 ;;^UTILITY(U,$J,358.3,1001,1,4,0)
 ;;=4^H66.91
 ;;^UTILITY(U,$J,358.3,1001,2)
 ;;=^5006640
 ;;^UTILITY(U,$J,358.3,1002,0)
 ;;=H66.92^^6^108^32
 ;;^UTILITY(U,$J,358.3,1002,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1002,1,3,0)
 ;;=3^Otitis Media,Unspec,Left Ear
 ;;^UTILITY(U,$J,358.3,1002,1,4,0)
 ;;=4^H66.92
 ;;^UTILITY(U,$J,358.3,1002,2)
 ;;=^5006641
 ;;^UTILITY(U,$J,358.3,1003,0)
 ;;=H66.93^^6^108^31
 ;;^UTILITY(U,$J,358.3,1003,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1003,1,3,0)
 ;;=3^Otitis Media,Unspec,Bilateral
 ;;^UTILITY(U,$J,358.3,1003,1,4,0)
 ;;=4^H66.93
 ;;^UTILITY(U,$J,358.3,1003,2)
 ;;=^5006642
 ;;^UTILITY(U,$J,358.3,1004,0)
 ;;=M19.90^^6^108^16
 ;;^UTILITY(U,$J,358.3,1004,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1004,1,3,0)
 ;;=3^Osteoarthritis,Unspec Site
 ;;^UTILITY(U,$J,358.3,1004,1,4,0)
 ;;=4^M19.90
 ;;^UTILITY(U,$J,358.3,1004,2)
 ;;=^5010853
 ;;^UTILITY(U,$J,358.3,1005,0)
 ;;=M81.0^^6^108^18
 ;;^UTILITY(U,$J,358.3,1005,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1005,1,3,0)
 ;;=3^Osteoporosis,Age-Related,w/o Current Path Fracture
 ;;^UTILITY(U,$J,358.3,1005,1,4,0)
 ;;=4^M81.0
 ;;^UTILITY(U,$J,358.3,1005,2)
 ;;=^5013555
 ;;^UTILITY(U,$J,358.3,1006,0)
 ;;=R11.2^^6^108^2
 ;;^UTILITY(U,$J,358.3,1006,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1006,1,3,0)
 ;;=3^Nausea w/ Vomiting
 ;;^UTILITY(U,$J,358.3,1006,1,4,0)
 ;;=4^R11.2
 ;;^UTILITY(U,$J,358.3,1006,2)
 ;;=^5019237
 ;;^UTILITY(U,$J,358.3,1007,0)
 ;;=H57.13^^6^108^13
 ;;^UTILITY(U,$J,358.3,1007,1,0)
 ;;=^358.31IA^4^2
