IBDEI1SF ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,30369,1,3,0)
 ;;=3^Neoplasm of unspecified behavior of digestive system
 ;;^UTILITY(U,$J,358.3,30369,1,4,0)
 ;;=4^D49.0
 ;;^UTILITY(U,$J,358.3,30369,2)
 ;;=^5002270
 ;;^UTILITY(U,$J,358.3,30370,0)
 ;;=D49.1^^118^1507^12
 ;;^UTILITY(U,$J,358.3,30370,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30370,1,3,0)
 ;;=3^Neoplasm of unspecified behavior of respiratory system
 ;;^UTILITY(U,$J,358.3,30370,1,4,0)
 ;;=4^D49.1
 ;;^UTILITY(U,$J,358.3,30370,2)
 ;;=^5002271
 ;;^UTILITY(U,$J,358.3,30371,0)
 ;;=D49.2^^118^1507^5
 ;;^UTILITY(U,$J,358.3,30371,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30371,1,3,0)
 ;;=3^Neoplasm of unspecified behavior of bone, soft tissue, and skin
 ;;^UTILITY(U,$J,358.3,30371,1,4,0)
 ;;=4^D49.2
 ;;^UTILITY(U,$J,358.3,30371,2)
 ;;=^5002272
 ;;^UTILITY(U,$J,358.3,30372,0)
 ;;=D49.3^^118^1507^7
 ;;^UTILITY(U,$J,358.3,30372,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30372,1,3,0)
 ;;=3^Neoplasm of unspecified behavior of breast
 ;;^UTILITY(U,$J,358.3,30372,1,4,0)
 ;;=4^D49.3
 ;;^UTILITY(U,$J,358.3,30372,2)
 ;;=^5002273
 ;;^UTILITY(U,$J,358.3,30373,0)
 ;;=D49.4^^118^1507^4
 ;;^UTILITY(U,$J,358.3,30373,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30373,1,3,0)
 ;;=3^Neoplasm of unspecified behavior of bladder
 ;;^UTILITY(U,$J,358.3,30373,1,4,0)
 ;;=4^D49.4
 ;;^UTILITY(U,$J,358.3,30373,2)
 ;;=^5002274
 ;;^UTILITY(U,$J,358.3,30374,0)
 ;;=D49.5^^118^1507^10
 ;;^UTILITY(U,$J,358.3,30374,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30374,1,3,0)
 ;;=3^Neoplasm of unspecified behavior of other genitourinary organs
 ;;^UTILITY(U,$J,358.3,30374,1,4,0)
 ;;=4^D49.5
 ;;^UTILITY(U,$J,358.3,30374,2)
 ;;=^5002275
 ;;^UTILITY(U,$J,358.3,30375,0)
 ;;=D49.6^^118^1507^6
 ;;^UTILITY(U,$J,358.3,30375,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30375,1,3,0)
 ;;=3^Neoplasm of unspecified behavior of brain
 ;;^UTILITY(U,$J,358.3,30375,1,4,0)
 ;;=4^D49.6
 ;;^UTILITY(U,$J,358.3,30375,2)
 ;;=^5002276
 ;;^UTILITY(U,$J,358.3,30376,0)
 ;;=D49.7^^118^1507^9
 ;;^UTILITY(U,$J,358.3,30376,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30376,1,3,0)
 ;;=3^Neoplasm of unspecified behavior of endo glands
 ;;^UTILITY(U,$J,358.3,30376,1,4,0)
 ;;=4^D49.7
 ;;^UTILITY(U,$J,358.3,30376,2)
 ;;=^5002277
 ;;^UTILITY(U,$J,358.3,30377,0)
 ;;=D49.81^^118^1507^13
 ;;^UTILITY(U,$J,358.3,30377,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30377,1,3,0)
 ;;=3^Neoplasm of unspecified behavior of retina and choroid
 ;;^UTILITY(U,$J,358.3,30377,1,4,0)
 ;;=4^D49.81
 ;;^UTILITY(U,$J,358.3,30377,2)
 ;;=^5002278
 ;;^UTILITY(U,$J,358.3,30378,0)
 ;;=D49.89^^118^1507^11
 ;;^UTILITY(U,$J,358.3,30378,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30378,1,3,0)
 ;;=3^Neoplasm of unspecified behavior of other specified sites
 ;;^UTILITY(U,$J,358.3,30378,1,4,0)
 ;;=4^D49.89
 ;;^UTILITY(U,$J,358.3,30378,2)
 ;;=^5002279
 ;;^UTILITY(U,$J,358.3,30379,0)
 ;;=D49.9^^118^1507^14
 ;;^UTILITY(U,$J,358.3,30379,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30379,1,3,0)
 ;;=3^Neoplasm of unspecified behavior of unspecified site
 ;;^UTILITY(U,$J,358.3,30379,1,4,0)
 ;;=4^D49.9
 ;;^UTILITY(U,$J,358.3,30379,2)
 ;;=^5002280
 ;;^UTILITY(U,$J,358.3,30380,0)
 ;;=D68.51^^118^1507^1
 ;;^UTILITY(U,$J,358.3,30380,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30380,1,3,0)
 ;;=3^Activated protein C resistance
 ;;^UTILITY(U,$J,358.3,30380,1,4,0)
 ;;=4^D68.51
 ;;^UTILITY(U,$J,358.3,30380,2)
 ;;=^5002358
 ;;^UTILITY(U,$J,358.3,30381,0)
 ;;=D68.52^^118^1507^16
 ;;^UTILITY(U,$J,358.3,30381,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30381,1,3,0)
 ;;=3^Prothrombin gene mutation
