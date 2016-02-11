IBDEI1JX ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,25937,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25937,1,3,0)
 ;;=3^Occlusion/Stenosis of Left Carotid Artery
 ;;^UTILITY(U,$J,358.3,25937,1,4,0)
 ;;=4^I65.22
 ;;^UTILITY(U,$J,358.3,25937,2)
 ;;=^5007361
 ;;^UTILITY(U,$J,358.3,25938,0)
 ;;=I65.23^^127^1269^13
 ;;^UTILITY(U,$J,358.3,25938,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25938,1,3,0)
 ;;=3^Occlusion/Stenosis of Bilateral Carotid Arteries
 ;;^UTILITY(U,$J,358.3,25938,1,4,0)
 ;;=4^I65.23
 ;;^UTILITY(U,$J,358.3,25938,2)
 ;;=^5007362
 ;;^UTILITY(U,$J,358.3,25939,0)
 ;;=I65.8^^127^1269^15
 ;;^UTILITY(U,$J,358.3,25939,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25939,1,3,0)
 ;;=3^Occlusion/Stenosis of Precerebral Arteries NEC
 ;;^UTILITY(U,$J,358.3,25939,1,4,0)
 ;;=4^I65.8
 ;;^UTILITY(U,$J,358.3,25939,2)
 ;;=^5007364
 ;;^UTILITY(U,$J,358.3,25940,0)
 ;;=I70.211^^127^1269^8
 ;;^UTILITY(U,$J,358.3,25940,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25940,1,3,0)
 ;;=3^Athscl Native Arteries of Right Leg w/ Intrmt Claud
 ;;^UTILITY(U,$J,358.3,25940,1,4,0)
 ;;=4^I70.211
 ;;^UTILITY(U,$J,358.3,25940,2)
 ;;=^5007578
 ;;^UTILITY(U,$J,358.3,25941,0)
 ;;=I70.212^^127^1269^7
 ;;^UTILITY(U,$J,358.3,25941,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25941,1,3,0)
 ;;=3^Athscl Native Arteries of Left Leg w/ Intrmt Claud
 ;;^UTILITY(U,$J,358.3,25941,1,4,0)
 ;;=4^I70.212
 ;;^UTILITY(U,$J,358.3,25941,2)
 ;;=^5007579
 ;;^UTILITY(U,$J,358.3,25942,0)
 ;;=I70.213^^127^1269^6
 ;;^UTILITY(U,$J,358.3,25942,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25942,1,3,0)
 ;;=3^Athscl Native Arteries of Bilateral Legs w/ Intrmt Claud
 ;;^UTILITY(U,$J,358.3,25942,1,4,0)
 ;;=4^I70.213
 ;;^UTILITY(U,$J,358.3,25942,2)
 ;;=^5007580
 ;;^UTILITY(U,$J,358.3,25943,0)
 ;;=I71.2^^127^1269^20
 ;;^UTILITY(U,$J,358.3,25943,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25943,1,3,0)
 ;;=3^Thoracic Aortic Aneurysm w/o Rupture
 ;;^UTILITY(U,$J,358.3,25943,1,4,0)
 ;;=4^I71.2
 ;;^UTILITY(U,$J,358.3,25943,2)
 ;;=^5007787
 ;;^UTILITY(U,$J,358.3,25944,0)
 ;;=I71.4^^127^1269^1
 ;;^UTILITY(U,$J,358.3,25944,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25944,1,3,0)
 ;;=3^AAA w/o Rupture
 ;;^UTILITY(U,$J,358.3,25944,1,4,0)
 ;;=4^I71.4
 ;;^UTILITY(U,$J,358.3,25944,2)
 ;;=^5007789
 ;;^UTILITY(U,$J,358.3,25945,0)
 ;;=I73.9^^127^1269^17
 ;;^UTILITY(U,$J,358.3,25945,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25945,1,3,0)
 ;;=3^Peripheral Vascular Disease,Unspec
 ;;^UTILITY(U,$J,358.3,25945,1,4,0)
 ;;=4^I73.9
 ;;^UTILITY(U,$J,358.3,25945,2)
 ;;=^184182
 ;;^UTILITY(U,$J,358.3,25946,0)
 ;;=I74.2^^127^1269^11
 ;;^UTILITY(U,$J,358.3,25946,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25946,1,3,0)
 ;;=3^Embolism/Thrombosis of Upper Extremity Arteries
 ;;^UTILITY(U,$J,358.3,25946,1,4,0)
 ;;=4^I74.2
 ;;^UTILITY(U,$J,358.3,25946,2)
 ;;=^5007801
 ;;^UTILITY(U,$J,358.3,25947,0)
 ;;=I74.3^^127^1269^10
 ;;^UTILITY(U,$J,358.3,25947,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25947,1,3,0)
 ;;=3^Embolism/Thrombosis of Lower Extremity Arteries
 ;;^UTILITY(U,$J,358.3,25947,1,4,0)
 ;;=4^I74.3
 ;;^UTILITY(U,$J,358.3,25947,2)
 ;;=^5007802
 ;;^UTILITY(U,$J,358.3,25948,0)
 ;;=I83.019^^127^1269^22
 ;;^UTILITY(U,$J,358.3,25948,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25948,1,3,0)
 ;;=3^Varicose Veins Right Lower Extrem w/ Ulcer
 ;;^UTILITY(U,$J,358.3,25948,1,4,0)
 ;;=4^I83.019
 ;;^UTILITY(U,$J,358.3,25948,2)
 ;;=^5007979
 ;;^UTILITY(U,$J,358.3,25949,0)
 ;;=I83.029^^127^1269^21
 ;;^UTILITY(U,$J,358.3,25949,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25949,1,3,0)
 ;;=3^Varicose Veins Left Lower Extrem w/ Ulcer
