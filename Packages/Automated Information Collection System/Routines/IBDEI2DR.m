IBDEI2DR ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,37986,2)
 ;;=^5010821
 ;;^UTILITY(U,$J,358.3,37987,0)
 ;;=M19.071^^146^1924^19
 ;;^UTILITY(U,$J,358.3,37987,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37987,1,3,0)
 ;;=3^Osteoarthritis,Right Ankle/Foot,Primary
 ;;^UTILITY(U,$J,358.3,37987,1,4,0)
 ;;=4^M19.071
 ;;^UTILITY(U,$J,358.3,37987,2)
 ;;=^5010820
 ;;^UTILITY(U,$J,358.3,37988,0)
 ;;=M19.90^^146^1924^20
 ;;^UTILITY(U,$J,358.3,37988,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37988,1,3,0)
 ;;=3^Osteoarthritis,Unspec Site
 ;;^UTILITY(U,$J,358.3,37988,1,4,0)
 ;;=4^M19.90
 ;;^UTILITY(U,$J,358.3,37988,2)
 ;;=^5010853
 ;;^UTILITY(U,$J,358.3,37989,0)
 ;;=M96.0^^146^1925^14
 ;;^UTILITY(U,$J,358.3,37989,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37989,1,3,0)
 ;;=3^Pseudarthrosis after fusion or arthrodesis
 ;;^UTILITY(U,$J,358.3,37989,1,4,0)
 ;;=4^M96.0
 ;;^UTILITY(U,$J,358.3,37989,2)
 ;;=^5015373
 ;;^UTILITY(U,$J,358.3,37990,0)
 ;;=R20.2^^146^1925^1
 ;;^UTILITY(U,$J,358.3,37990,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37990,1,3,0)
 ;;=3^Paresthesia of skin
 ;;^UTILITY(U,$J,358.3,37990,1,4,0)
 ;;=4^R20.2
 ;;^UTILITY(U,$J,358.3,37990,2)
 ;;=^5019280
 ;;^UTILITY(U,$J,358.3,37991,0)
 ;;=I87.003^^146^1925^12
 ;;^UTILITY(U,$J,358.3,37991,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37991,1,3,0)
 ;;=3^Postthrom syndr w/o compl of bilat lwr extrem
 ;;^UTILITY(U,$J,358.3,37991,1,4,0)
 ;;=4^I87.003
 ;;^UTILITY(U,$J,358.3,37991,2)
 ;;=^5008029
 ;;^UTILITY(U,$J,358.3,37992,0)
 ;;=I87.001^^146^1925^11
 ;;^UTILITY(U,$J,358.3,37992,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37992,1,3,0)
 ;;=3^Postrhomb syndr w/o compl of rt lwr extrem
 ;;^UTILITY(U,$J,358.3,37992,1,4,0)
 ;;=4^I87.001
 ;;^UTILITY(U,$J,358.3,37992,2)
 ;;=^5008027
 ;;^UTILITY(U,$J,358.3,37993,0)
 ;;=I80.01^^146^1925^8
 ;;^UTILITY(U,$J,358.3,37993,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37993,1,3,0)
 ;;=3^Phlebitis & Thromboph,Right Lower Sprfcl Vessels
 ;;^UTILITY(U,$J,358.3,37993,1,4,0)
 ;;=4^I80.01
 ;;^UTILITY(U,$J,358.3,37993,2)
 ;;=^5007821
 ;;^UTILITY(U,$J,358.3,37994,0)
 ;;=I80.02^^146^1925^6
 ;;^UTILITY(U,$J,358.3,37994,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37994,1,3,0)
 ;;=3^Phlebitis & Thromboph,Left Lower Sprfcl Vessels
 ;;^UTILITY(U,$J,358.3,37994,1,4,0)
 ;;=4^I80.02
 ;;^UTILITY(U,$J,358.3,37994,2)
 ;;=^5007822
 ;;^UTILITY(U,$J,358.3,37995,0)
 ;;=I80.03^^146^1925^4
 ;;^UTILITY(U,$J,358.3,37995,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37995,1,3,0)
 ;;=3^Phlebitis & Thromboph,Bilateral Lower Sprfcl Vessels
 ;;^UTILITY(U,$J,358.3,37995,1,4,0)
 ;;=4^I80.03
 ;;^UTILITY(U,$J,358.3,37995,2)
 ;;=^5007823
 ;;^UTILITY(U,$J,358.3,37996,0)
 ;;=I80.11^^146^1925^7
 ;;^UTILITY(U,$J,358.3,37996,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37996,1,3,0)
 ;;=3^Phlebitis & Thromboph,Right Femoral Vein
 ;;^UTILITY(U,$J,358.3,37996,1,4,0)
 ;;=4^I80.11
 ;;^UTILITY(U,$J,358.3,37996,2)
 ;;=^5007825
 ;;^UTILITY(U,$J,358.3,37997,0)
 ;;=I80.12^^146^1925^5
 ;;^UTILITY(U,$J,358.3,37997,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37997,1,3,0)
 ;;=3^Phlebitis & Thromboph,Left Femoral Vein
 ;;^UTILITY(U,$J,358.3,37997,1,4,0)
 ;;=4^I80.12
 ;;^UTILITY(U,$J,358.3,37997,2)
 ;;=^5007826
 ;;^UTILITY(U,$J,358.3,37998,0)
 ;;=I80.13^^146^1925^3
 ;;^UTILITY(U,$J,358.3,37998,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37998,1,3,0)
 ;;=3^Phlebitis & Thromboph,Bilateral Femora Vein
 ;;^UTILITY(U,$J,358.3,37998,1,4,0)
 ;;=4^I80.13
