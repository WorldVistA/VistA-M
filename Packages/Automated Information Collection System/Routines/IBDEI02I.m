IBDEI02I ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,622,1,4,0)
 ;;=4^D49.3
 ;;^UTILITY(U,$J,358.3,622,2)
 ;;=^5002273
 ;;^UTILITY(U,$J,358.3,623,0)
 ;;=D49.4^^2^26^4
 ;;^UTILITY(U,$J,358.3,623,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,623,1,3,0)
 ;;=3^Neoplasm of unspecified behavior of bladder
 ;;^UTILITY(U,$J,358.3,623,1,4,0)
 ;;=4^D49.4
 ;;^UTILITY(U,$J,358.3,623,2)
 ;;=^5002274
 ;;^UTILITY(U,$J,358.3,624,0)
 ;;=D49.5^^2^26^10
 ;;^UTILITY(U,$J,358.3,624,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,624,1,3,0)
 ;;=3^Neoplasm of unspecified behavior of other genitourinary organs
 ;;^UTILITY(U,$J,358.3,624,1,4,0)
 ;;=4^D49.5
 ;;^UTILITY(U,$J,358.3,624,2)
 ;;=^5002275
 ;;^UTILITY(U,$J,358.3,625,0)
 ;;=D49.6^^2^26^6
 ;;^UTILITY(U,$J,358.3,625,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,625,1,3,0)
 ;;=3^Neoplasm of unspecified behavior of brain
 ;;^UTILITY(U,$J,358.3,625,1,4,0)
 ;;=4^D49.6
 ;;^UTILITY(U,$J,358.3,625,2)
 ;;=^5002276
 ;;^UTILITY(U,$J,358.3,626,0)
 ;;=D49.7^^2^26^9
 ;;^UTILITY(U,$J,358.3,626,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,626,1,3,0)
 ;;=3^Neoplasm of unspecified behavior of endo glands
 ;;^UTILITY(U,$J,358.3,626,1,4,0)
 ;;=4^D49.7
 ;;^UTILITY(U,$J,358.3,626,2)
 ;;=^5002277
 ;;^UTILITY(U,$J,358.3,627,0)
 ;;=D49.81^^2^26^13
 ;;^UTILITY(U,$J,358.3,627,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,627,1,3,0)
 ;;=3^Neoplasm of unspecified behavior of retina and choroid
 ;;^UTILITY(U,$J,358.3,627,1,4,0)
 ;;=4^D49.81
 ;;^UTILITY(U,$J,358.3,627,2)
 ;;=^5002278
 ;;^UTILITY(U,$J,358.3,628,0)
 ;;=D49.89^^2^26^11
 ;;^UTILITY(U,$J,358.3,628,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,628,1,3,0)
 ;;=3^Neoplasm of unspecified behavior of other specified sites
 ;;^UTILITY(U,$J,358.3,628,1,4,0)
 ;;=4^D49.89
 ;;^UTILITY(U,$J,358.3,628,2)
 ;;=^5002279
 ;;^UTILITY(U,$J,358.3,629,0)
 ;;=D49.9^^2^26^14
 ;;^UTILITY(U,$J,358.3,629,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,629,1,3,0)
 ;;=3^Neoplasm of unspecified behavior of unspecified site
 ;;^UTILITY(U,$J,358.3,629,1,4,0)
 ;;=4^D49.9
 ;;^UTILITY(U,$J,358.3,629,2)
 ;;=^5002280
 ;;^UTILITY(U,$J,358.3,630,0)
 ;;=D68.51^^2^26^1
 ;;^UTILITY(U,$J,358.3,630,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,630,1,3,0)
 ;;=3^Activated protein C resistance
 ;;^UTILITY(U,$J,358.3,630,1,4,0)
 ;;=4^D68.51
 ;;^UTILITY(U,$J,358.3,630,2)
 ;;=^5002358
 ;;^UTILITY(U,$J,358.3,631,0)
 ;;=D68.52^^2^26^16
 ;;^UTILITY(U,$J,358.3,631,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,631,1,3,0)
 ;;=3^Prothrombin gene mutation
 ;;^UTILITY(U,$J,358.3,631,1,4,0)
 ;;=4^D68.52
 ;;^UTILITY(U,$J,358.3,631,2)
 ;;=^5002359
 ;;^UTILITY(U,$J,358.3,632,0)
 ;;=D68.59^^2^26^15
 ;;^UTILITY(U,$J,358.3,632,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,632,1,3,0)
 ;;=3^Primary Thrombophilia NEC
 ;;^UTILITY(U,$J,358.3,632,1,4,0)
 ;;=4^D68.59
 ;;^UTILITY(U,$J,358.3,632,2)
 ;;=^5002360
 ;;^UTILITY(U,$J,358.3,633,0)
 ;;=D68.61^^2^26^2
 ;;^UTILITY(U,$J,358.3,633,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,633,1,3,0)
 ;;=3^Antiphospholipid syndrome
 ;;^UTILITY(U,$J,358.3,633,1,4,0)
 ;;=4^D68.61
 ;;^UTILITY(U,$J,358.3,633,2)
 ;;=^185421
 ;;^UTILITY(U,$J,358.3,634,0)
 ;;=D68.62^^2^26^3
 ;;^UTILITY(U,$J,358.3,634,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,634,1,3,0)
 ;;=3^Lupus anticoagulant syndrome
 ;;^UTILITY(U,$J,358.3,634,1,4,0)
 ;;=4^D68.62
 ;;^UTILITY(U,$J,358.3,634,2)
 ;;=^5002361
 ;;^UTILITY(U,$J,358.3,635,0)
 ;;=Z85.810^^2^27^3
 ;;^UTILITY(U,$J,358.3,635,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,635,1,3,0)
 ;;=3^Personal history of malignant neoplasm of tongue
 ;;^UTILITY(U,$J,358.3,635,1,4,0)
 ;;=4^Z85.810
