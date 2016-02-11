IBDEI06I ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,2444,1,3,0)
 ;;=3^Abdominal Aortic Aneurysm w/ Rupture
 ;;^UTILITY(U,$J,358.3,2444,1,4,0)
 ;;=4^I71.3
 ;;^UTILITY(U,$J,358.3,2444,2)
 ;;=^5007788
 ;;^UTILITY(U,$J,358.3,2445,0)
 ;;=I71.4^^19^203^2
 ;;^UTILITY(U,$J,358.3,2445,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2445,1,3,0)
 ;;=3^Abdominal Aortic Aneurysm w/o Rupture
 ;;^UTILITY(U,$J,358.3,2445,1,4,0)
 ;;=4^I71.4
 ;;^UTILITY(U,$J,358.3,2445,2)
 ;;=^5007789
 ;;^UTILITY(U,$J,358.3,2446,0)
 ;;=I71.8^^19^203^9
 ;;^UTILITY(U,$J,358.3,2446,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2446,1,3,0)
 ;;=3^Aortic Aneurysm of Unspec Site w/ Rupture
 ;;^UTILITY(U,$J,358.3,2446,1,4,0)
 ;;=4^I71.8
 ;;^UTILITY(U,$J,358.3,2446,2)
 ;;=^9279
 ;;^UTILITY(U,$J,358.3,2447,0)
 ;;=I71.5^^19^203^89
 ;;^UTILITY(U,$J,358.3,2447,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2447,1,3,0)
 ;;=3^Thoracoabdominal Aortic Aneurysm w/ Rupture
 ;;^UTILITY(U,$J,358.3,2447,1,4,0)
 ;;=4^I71.5
 ;;^UTILITY(U,$J,358.3,2447,2)
 ;;=^5007790
 ;;^UTILITY(U,$J,358.3,2448,0)
 ;;=I71.6^^19^203^90
 ;;^UTILITY(U,$J,358.3,2448,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2448,1,3,0)
 ;;=3^Thoracoabdominal Aortic Aneurysm w/o Rupture
 ;;^UTILITY(U,$J,358.3,2448,1,4,0)
 ;;=4^I71.6
 ;;^UTILITY(U,$J,358.3,2448,2)
 ;;=^5007791
 ;;^UTILITY(U,$J,358.3,2449,0)
 ;;=I72.1^^19^203^8
 ;;^UTILITY(U,$J,358.3,2449,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2449,1,3,0)
 ;;=3^Aneurysm of Upper Extremity Artery
 ;;^UTILITY(U,$J,358.3,2449,1,4,0)
 ;;=4^I72.1
 ;;^UTILITY(U,$J,358.3,2449,2)
 ;;=^269771
 ;;^UTILITY(U,$J,358.3,2450,0)
 ;;=I72.2^^19^203^7
 ;;^UTILITY(U,$J,358.3,2450,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2450,1,3,0)
 ;;=3^Aneurysm of Renal Artery
 ;;^UTILITY(U,$J,358.3,2450,1,4,0)
 ;;=4^I72.2
 ;;^UTILITY(U,$J,358.3,2450,2)
 ;;=^269773
 ;;^UTILITY(U,$J,358.3,2451,0)
 ;;=I72.3^^19^203^5
 ;;^UTILITY(U,$J,358.3,2451,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2451,1,3,0)
 ;;=3^Aneurysm of Iliac Artery
 ;;^UTILITY(U,$J,358.3,2451,1,4,0)
 ;;=4^I72.3
 ;;^UTILITY(U,$J,358.3,2451,2)
 ;;=^269775
 ;;^UTILITY(U,$J,358.3,2452,0)
 ;;=I72.4^^19^203^6
 ;;^UTILITY(U,$J,358.3,2452,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2452,1,3,0)
 ;;=3^Aneurysm of Lower Extremity Artery
 ;;^UTILITY(U,$J,358.3,2452,1,4,0)
 ;;=4^I72.4
 ;;^UTILITY(U,$J,358.3,2452,2)
 ;;=^269777
 ;;^UTILITY(U,$J,358.3,2453,0)
 ;;=I72.0^^19^203^4
 ;;^UTILITY(U,$J,358.3,2453,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2453,1,3,0)
 ;;=3^Aneurysm of Carotid Artery
 ;;^UTILITY(U,$J,358.3,2453,1,4,0)
 ;;=4^I72.0
 ;;^UTILITY(U,$J,358.3,2453,2)
 ;;=^5007793
 ;;^UTILITY(U,$J,358.3,2454,0)
 ;;=I72.8^^19^203^3
 ;;^UTILITY(U,$J,358.3,2454,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2454,1,3,0)
 ;;=3^Aneurysm of Arteries NEC
 ;;^UTILITY(U,$J,358.3,2454,1,4,0)
 ;;=4^I72.8
 ;;^UTILITY(U,$J,358.3,2454,2)
 ;;=^5007794
 ;;^UTILITY(U,$J,358.3,2455,0)
 ;;=I73.00^^19^203^84
 ;;^UTILITY(U,$J,358.3,2455,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2455,1,3,0)
 ;;=3^Raynaud's Syndrome w/o Gangrene
 ;;^UTILITY(U,$J,358.3,2455,1,4,0)
 ;;=4^I73.00
 ;;^UTILITY(U,$J,358.3,2455,2)
 ;;=^5007796
 ;;^UTILITY(U,$J,358.3,2456,0)
 ;;=I73.1^^19^203^91
 ;;^UTILITY(U,$J,358.3,2456,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2456,1,3,0)
 ;;=3^Thromboangiitis Obliterans
 ;;^UTILITY(U,$J,358.3,2456,1,4,0)
 ;;=4^I73.1
 ;;^UTILITY(U,$J,358.3,2456,2)
 ;;=^5007798
 ;;^UTILITY(U,$J,358.3,2457,0)
 ;;=I73.9^^19^203^83
 ;;^UTILITY(U,$J,358.3,2457,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2457,1,3,0)
 ;;=3^Peripheral Vascular Disease,Unspec
 ;;^UTILITY(U,$J,358.3,2457,1,4,0)
 ;;=4^I73.9
