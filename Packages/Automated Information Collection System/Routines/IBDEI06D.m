IBDEI06D ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,2382,1,4,0)
 ;;=4^Z79.01
 ;;^UTILITY(U,$J,358.3,2382,2)
 ;;=^5063330
 ;;^UTILITY(U,$J,358.3,2383,0)
 ;;=I65.1^^19^203^75
 ;;^UTILITY(U,$J,358.3,2383,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2383,1,3,0)
 ;;=3^Occlusion/Stenosis of Basilar Artery
 ;;^UTILITY(U,$J,358.3,2383,1,4,0)
 ;;=4^I65.1
 ;;^UTILITY(U,$J,358.3,2383,2)
 ;;=^269747
 ;;^UTILITY(U,$J,358.3,2384,0)
 ;;=I63.22^^19^203^52
 ;;^UTILITY(U,$J,358.3,2384,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2384,1,3,0)
 ;;=3^Cerebral Inarction d/t Unspec Occlusion/Stenosis of Basilar Arteries
 ;;^UTILITY(U,$J,358.3,2384,1,4,0)
 ;;=4^I63.22
 ;;^UTILITY(U,$J,358.3,2384,2)
 ;;=^5007315
 ;;^UTILITY(U,$J,358.3,2385,0)
 ;;=I65.21^^19^203^81
 ;;^UTILITY(U,$J,358.3,2385,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2385,1,3,0)
 ;;=3^Occlusion/Stenosis of Right Carotid Artery
 ;;^UTILITY(U,$J,358.3,2385,1,4,0)
 ;;=4^I65.21
 ;;^UTILITY(U,$J,358.3,2385,2)
 ;;=^5007360
 ;;^UTILITY(U,$J,358.3,2386,0)
 ;;=I65.22^^19^203^78
 ;;^UTILITY(U,$J,358.3,2386,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2386,1,3,0)
 ;;=3^Occlusion/Stenosis of Left Carotid Artery
 ;;^UTILITY(U,$J,358.3,2386,1,4,0)
 ;;=4^I65.22
 ;;^UTILITY(U,$J,358.3,2386,2)
 ;;=^5007361
 ;;^UTILITY(U,$J,358.3,2387,0)
 ;;=I65.23^^19^203^76
 ;;^UTILITY(U,$J,358.3,2387,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2387,1,3,0)
 ;;=3^Occlusion/Stenosis of Bilateral Carotid Arteries
 ;;^UTILITY(U,$J,358.3,2387,1,4,0)
 ;;=4^I65.23
 ;;^UTILITY(U,$J,358.3,2387,2)
 ;;=^5007362
 ;;^UTILITY(U,$J,358.3,2388,0)
 ;;=I63.031^^19^203^56
 ;;^UTILITY(U,$J,358.3,2388,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2388,1,3,0)
 ;;=3^Cerebral Infarction d/t Thrombosis of Right Carotid Artery
 ;;^UTILITY(U,$J,358.3,2388,1,4,0)
 ;;=4^I63.031
 ;;^UTILITY(U,$J,358.3,2388,2)
 ;;=^5007299
 ;;^UTILITY(U,$J,358.3,2389,0)
 ;;=I65.01^^19^203^82
 ;;^UTILITY(U,$J,358.3,2389,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2389,1,3,0)
 ;;=3^Occlusion/Stenosis of Right Vertebral Artery
 ;;^UTILITY(U,$J,358.3,2389,1,4,0)
 ;;=4^I65.01
 ;;^UTILITY(U,$J,358.3,2389,2)
 ;;=^5007356
 ;;^UTILITY(U,$J,358.3,2390,0)
 ;;=I65.02^^19^203^79
 ;;^UTILITY(U,$J,358.3,2390,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2390,1,3,0)
 ;;=3^Occlusion/Stenosis of Left Vertebral Artery
 ;;^UTILITY(U,$J,358.3,2390,1,4,0)
 ;;=4^I65.02
 ;;^UTILITY(U,$J,358.3,2390,2)
 ;;=^5007357
 ;;^UTILITY(U,$J,358.3,2391,0)
 ;;=I65.03^^19^203^77
 ;;^UTILITY(U,$J,358.3,2391,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2391,1,3,0)
 ;;=3^Occlusion/Stenosis of Bilateral Vertebral Arteries
 ;;^UTILITY(U,$J,358.3,2391,1,4,0)
 ;;=4^I65.03
 ;;^UTILITY(U,$J,358.3,2391,2)
 ;;=^5007358
 ;;^UTILITY(U,$J,358.3,2392,0)
 ;;=I65.8^^19^203^80
 ;;^UTILITY(U,$J,358.3,2392,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2392,1,3,0)
 ;;=3^Occlusion/Stenosis of Precerebral Arteries NEC
 ;;^UTILITY(U,$J,358.3,2392,1,4,0)
 ;;=4^I65.8
 ;;^UTILITY(U,$J,358.3,2392,2)
 ;;=^5007364
 ;;^UTILITY(U,$J,358.3,2393,0)
 ;;=I63.032^^19^203^55
 ;;^UTILITY(U,$J,358.3,2393,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2393,1,3,0)
 ;;=3^Cerebral Infarction d/t Thrombosis of Left Carotid Artery
 ;;^UTILITY(U,$J,358.3,2393,1,4,0)
 ;;=4^I63.032
 ;;^UTILITY(U,$J,358.3,2393,2)
 ;;=^5007300
 ;;^UTILITY(U,$J,358.3,2394,0)
 ;;=I63.131^^19^203^54
 ;;^UTILITY(U,$J,358.3,2394,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2394,1,3,0)
 ;;=3^Cerebral Infarction d/t Embolism of Right Carotid Artery
 ;;^UTILITY(U,$J,358.3,2394,1,4,0)
 ;;=4^I63.131
 ;;^UTILITY(U,$J,358.3,2394,2)
 ;;=^5007308
 ;;^UTILITY(U,$J,358.3,2395,0)
 ;;=I63.132^^19^203^53
