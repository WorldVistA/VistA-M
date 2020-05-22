IBDEI0F5 ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,6519,1,4,0)
 ;;=4^I71.1
 ;;^UTILITY(U,$J,358.3,6519,2)
 ;;=^5007786
 ;;^UTILITY(U,$J,358.3,6520,0)
 ;;=I71.2^^53^417^100
 ;;^UTILITY(U,$J,358.3,6520,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6520,1,3,0)
 ;;=3^Thoracic Aortic Aneurysm w/o Rupture
 ;;^UTILITY(U,$J,358.3,6520,1,4,0)
 ;;=4^I71.2
 ;;^UTILITY(U,$J,358.3,6520,2)
 ;;=^5007787
 ;;^UTILITY(U,$J,358.3,6521,0)
 ;;=I71.3^^53^417^1
 ;;^UTILITY(U,$J,358.3,6521,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6521,1,3,0)
 ;;=3^Abdominal Aortic Aneurysm w/ Rupture
 ;;^UTILITY(U,$J,358.3,6521,1,4,0)
 ;;=4^I71.3
 ;;^UTILITY(U,$J,358.3,6521,2)
 ;;=^5007788
 ;;^UTILITY(U,$J,358.3,6522,0)
 ;;=I71.4^^53^417^2
 ;;^UTILITY(U,$J,358.3,6522,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6522,1,3,0)
 ;;=3^Abdominal Aortic Aneurysm w/o Rupture
 ;;^UTILITY(U,$J,358.3,6522,1,4,0)
 ;;=4^I71.4
 ;;^UTILITY(U,$J,358.3,6522,2)
 ;;=^5007789
 ;;^UTILITY(U,$J,358.3,6523,0)
 ;;=I71.8^^53^417^11
 ;;^UTILITY(U,$J,358.3,6523,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6523,1,3,0)
 ;;=3^Aortic Aneurysm of Unspec Site w/ Rupture
 ;;^UTILITY(U,$J,358.3,6523,1,4,0)
 ;;=4^I71.8
 ;;^UTILITY(U,$J,358.3,6523,2)
 ;;=^9279
 ;;^UTILITY(U,$J,358.3,6524,0)
 ;;=I71.5^^53^417^101
 ;;^UTILITY(U,$J,358.3,6524,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6524,1,3,0)
 ;;=3^Thoracoabdominal Aortic Aneurysm w/ Rupture
 ;;^UTILITY(U,$J,358.3,6524,1,4,0)
 ;;=4^I71.5
 ;;^UTILITY(U,$J,358.3,6524,2)
 ;;=^5007790
 ;;^UTILITY(U,$J,358.3,6525,0)
 ;;=I71.6^^53^417^102
 ;;^UTILITY(U,$J,358.3,6525,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6525,1,3,0)
 ;;=3^Thoracoabdominal Aortic Aneurysm w/o Rupture
 ;;^UTILITY(U,$J,358.3,6525,1,4,0)
 ;;=4^I71.6
 ;;^UTILITY(U,$J,358.3,6525,2)
 ;;=^5007791
 ;;^UTILITY(U,$J,358.3,6526,0)
 ;;=I72.1^^53^417^9
 ;;^UTILITY(U,$J,358.3,6526,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6526,1,3,0)
 ;;=3^Aneurysm of Upper Extremity Artery
 ;;^UTILITY(U,$J,358.3,6526,1,4,0)
 ;;=4^I72.1
 ;;^UTILITY(U,$J,358.3,6526,2)
 ;;=^269771
 ;;^UTILITY(U,$J,358.3,6527,0)
 ;;=I72.2^^53^417^8
 ;;^UTILITY(U,$J,358.3,6527,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6527,1,3,0)
 ;;=3^Aneurysm of Renal Artery
 ;;^UTILITY(U,$J,358.3,6527,1,4,0)
 ;;=4^I72.2
 ;;^UTILITY(U,$J,358.3,6527,2)
 ;;=^269773
 ;;^UTILITY(U,$J,358.3,6528,0)
 ;;=I72.3^^53^417^5
 ;;^UTILITY(U,$J,358.3,6528,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6528,1,3,0)
 ;;=3^Aneurysm of Iliac Artery
 ;;^UTILITY(U,$J,358.3,6528,1,4,0)
 ;;=4^I72.3
 ;;^UTILITY(U,$J,358.3,6528,2)
 ;;=^269775
 ;;^UTILITY(U,$J,358.3,6529,0)
 ;;=I72.4^^53^417^6
 ;;^UTILITY(U,$J,358.3,6529,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6529,1,3,0)
 ;;=3^Aneurysm of Lower Extremity Artery
 ;;^UTILITY(U,$J,358.3,6529,1,4,0)
 ;;=4^I72.4
 ;;^UTILITY(U,$J,358.3,6529,2)
 ;;=^269777
 ;;^UTILITY(U,$J,358.3,6530,0)
 ;;=I72.0^^53^417^4
 ;;^UTILITY(U,$J,358.3,6530,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6530,1,3,0)
 ;;=3^Aneurysm of Carotid Artery
 ;;^UTILITY(U,$J,358.3,6530,1,4,0)
 ;;=4^I72.0
 ;;^UTILITY(U,$J,358.3,6530,2)
 ;;=^5007793
 ;;^UTILITY(U,$J,358.3,6531,0)
 ;;=I72.8^^53^417^3
 ;;^UTILITY(U,$J,358.3,6531,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6531,1,3,0)
 ;;=3^Aneurysm of Arteries NEC
 ;;^UTILITY(U,$J,358.3,6531,1,4,0)
 ;;=4^I72.8
 ;;^UTILITY(U,$J,358.3,6531,2)
 ;;=^5007794
 ;;^UTILITY(U,$J,358.3,6532,0)
 ;;=I73.00^^53^417^94
