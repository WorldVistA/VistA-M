IBDEI0F0 ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,6460,1,4,0)
 ;;=4^I65.1
 ;;^UTILITY(U,$J,358.3,6460,2)
 ;;=^269747
 ;;^UTILITY(U,$J,358.3,6461,0)
 ;;=I63.22^^53^417^60
 ;;^UTILITY(U,$J,358.3,6461,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6461,1,3,0)
 ;;=3^Cerebral Infarction d/t Unspec Occl/Stenosis of Basilar Arteries
 ;;^UTILITY(U,$J,358.3,6461,1,4,0)
 ;;=4^I63.22
 ;;^UTILITY(U,$J,358.3,6461,2)
 ;;=^5007315
 ;;^UTILITY(U,$J,358.3,6462,0)
 ;;=I65.21^^53^417^91
 ;;^UTILITY(U,$J,358.3,6462,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6462,1,3,0)
 ;;=3^Occlusion/Stenosis of Right Carotid Artery
 ;;^UTILITY(U,$J,358.3,6462,1,4,0)
 ;;=4^I65.21
 ;;^UTILITY(U,$J,358.3,6462,2)
 ;;=^5007360
 ;;^UTILITY(U,$J,358.3,6463,0)
 ;;=I65.22^^53^417^88
 ;;^UTILITY(U,$J,358.3,6463,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6463,1,3,0)
 ;;=3^Occlusion/Stenosis of Left Carotid Artery
 ;;^UTILITY(U,$J,358.3,6463,1,4,0)
 ;;=4^I65.22
 ;;^UTILITY(U,$J,358.3,6463,2)
 ;;=^5007361
 ;;^UTILITY(U,$J,358.3,6464,0)
 ;;=I65.23^^53^417^86
 ;;^UTILITY(U,$J,358.3,6464,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6464,1,3,0)
 ;;=3^Occlusion/Stenosis of Bilateral Carotid Arteries
 ;;^UTILITY(U,$J,358.3,6464,1,4,0)
 ;;=4^I65.23
 ;;^UTILITY(U,$J,358.3,6464,2)
 ;;=^5007362
 ;;^UTILITY(U,$J,358.3,6465,0)
 ;;=I63.031^^53^417^59
 ;;^UTILITY(U,$J,358.3,6465,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6465,1,3,0)
 ;;=3^Cerebral Infarction d/t Thrombosis of Right Carotid Artery
 ;;^UTILITY(U,$J,358.3,6465,1,4,0)
 ;;=4^I63.031
 ;;^UTILITY(U,$J,358.3,6465,2)
 ;;=^5007299
 ;;^UTILITY(U,$J,358.3,6466,0)
 ;;=I65.01^^53^417^92
 ;;^UTILITY(U,$J,358.3,6466,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6466,1,3,0)
 ;;=3^Occlusion/Stenosis of Right Vertebral Artery
 ;;^UTILITY(U,$J,358.3,6466,1,4,0)
 ;;=4^I65.01
 ;;^UTILITY(U,$J,358.3,6466,2)
 ;;=^5007356
 ;;^UTILITY(U,$J,358.3,6467,0)
 ;;=I65.02^^53^417^89
 ;;^UTILITY(U,$J,358.3,6467,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6467,1,3,0)
 ;;=3^Occlusion/Stenosis of Left Vertebral Artery
 ;;^UTILITY(U,$J,358.3,6467,1,4,0)
 ;;=4^I65.02
 ;;^UTILITY(U,$J,358.3,6467,2)
 ;;=^5007357
 ;;^UTILITY(U,$J,358.3,6468,0)
 ;;=I65.03^^53^417^87
 ;;^UTILITY(U,$J,358.3,6468,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6468,1,3,0)
 ;;=3^Occlusion/Stenosis of Bilateral Vertebral Arteries
 ;;^UTILITY(U,$J,358.3,6468,1,4,0)
 ;;=4^I65.03
 ;;^UTILITY(U,$J,358.3,6468,2)
 ;;=^5007358
 ;;^UTILITY(U,$J,358.3,6469,0)
 ;;=I65.8^^53^417^90
 ;;^UTILITY(U,$J,358.3,6469,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6469,1,3,0)
 ;;=3^Occlusion/Stenosis of Precerebral Arteries NEC
 ;;^UTILITY(U,$J,358.3,6469,1,4,0)
 ;;=4^I65.8
 ;;^UTILITY(U,$J,358.3,6469,2)
 ;;=^5007364
 ;;^UTILITY(U,$J,358.3,6470,0)
 ;;=I63.032^^53^417^58
 ;;^UTILITY(U,$J,358.3,6470,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6470,1,3,0)
 ;;=3^Cerebral Infarction d/t Thrombosis of Left Carotid Artery
 ;;^UTILITY(U,$J,358.3,6470,1,4,0)
 ;;=4^I63.032
 ;;^UTILITY(U,$J,358.3,6470,2)
 ;;=^5007300
 ;;^UTILITY(U,$J,358.3,6471,0)
 ;;=I63.131^^53^417^56
 ;;^UTILITY(U,$J,358.3,6471,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6471,1,3,0)
 ;;=3^Cerebral Infarction d/t Embolism of Right Carotid Artery
 ;;^UTILITY(U,$J,358.3,6471,1,4,0)
 ;;=4^I63.131
 ;;^UTILITY(U,$J,358.3,6471,2)
 ;;=^5007308
 ;;^UTILITY(U,$J,358.3,6472,0)
 ;;=I63.132^^53^417^55
 ;;^UTILITY(U,$J,358.3,6472,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6472,1,3,0)
 ;;=3^Cerebral Infarction d/t Embolism of Left Carotid Artery
