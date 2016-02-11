IBDEI379 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,53753,1,4,0)
 ;;=4^N17.0
 ;;^UTILITY(U,$J,358.3,53753,2)
 ;;=^5015598
 ;;^UTILITY(U,$J,358.3,53754,0)
 ;;=N18.9^^253^2721^2
 ;;^UTILITY(U,$J,358.3,53754,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53754,1,3,0)
 ;;=3^Chronic kidney disease, unspecified
 ;;^UTILITY(U,$J,358.3,53754,1,4,0)
 ;;=4^N18.9
 ;;^UTILITY(U,$J,358.3,53754,2)
 ;;=^332812
 ;;^UTILITY(U,$J,358.3,53755,0)
 ;;=N19.^^253^2721^4
 ;;^UTILITY(U,$J,358.3,53755,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53755,1,3,0)
 ;;=3^Kidney failure,Unspec
 ;;^UTILITY(U,$J,358.3,53755,1,4,0)
 ;;=4^N19.
 ;;^UTILITY(U,$J,358.3,53755,2)
 ;;=^5015607
 ;;^UTILITY(U,$J,358.3,53756,0)
 ;;=Z94.0^^253^2721^5
 ;;^UTILITY(U,$J,358.3,53756,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53756,1,3,0)
 ;;=3^Kidney transplant status
 ;;^UTILITY(U,$J,358.3,53756,1,4,0)
 ;;=4^Z94.0
 ;;^UTILITY(U,$J,358.3,53756,2)
 ;;=^5063654
 ;;^UTILITY(U,$J,358.3,53757,0)
 ;;=Q61.2^^253^2721^8
 ;;^UTILITY(U,$J,358.3,53757,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53757,1,3,0)
 ;;=3^Polycystic kidney, adult type
 ;;^UTILITY(U,$J,358.3,53757,1,4,0)
 ;;=4^Q61.2
 ;;^UTILITY(U,$J,358.3,53757,2)
 ;;=^5018796
 ;;^UTILITY(U,$J,358.3,53758,0)
 ;;=Q61.3^^253^2721^10
 ;;^UTILITY(U,$J,358.3,53758,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53758,1,3,0)
 ;;=3^Polycystic kidney, unspecified
 ;;^UTILITY(U,$J,358.3,53758,1,4,0)
 ;;=4^Q61.3
 ;;^UTILITY(U,$J,358.3,53758,2)
 ;;=^5018797
 ;;^UTILITY(U,$J,358.3,53759,0)
 ;;=Q61.19^^253^2721^9
 ;;^UTILITY(U,$J,358.3,53759,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53759,1,3,0)
 ;;=3^Polycystic kidney, infantile type, other
 ;;^UTILITY(U,$J,358.3,53759,1,4,0)
 ;;=4^Q61.19
 ;;^UTILITY(U,$J,358.3,53759,2)
 ;;=^5018795
 ;;^UTILITY(U,$J,358.3,53760,0)
 ;;=C64.1^^253^2721^7
 ;;^UTILITY(U,$J,358.3,53760,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53760,1,3,0)
 ;;=3^Malignant neoplasm of right kidney, except renal pelvis
 ;;^UTILITY(U,$J,358.3,53760,1,4,0)
 ;;=4^C64.1
 ;;^UTILITY(U,$J,358.3,53760,2)
 ;;=^5001248
 ;;^UTILITY(U,$J,358.3,53761,0)
 ;;=C64.2^^253^2721^6
 ;;^UTILITY(U,$J,358.3,53761,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53761,1,3,0)
 ;;=3^Malignant neoplasm of left kidney, except renal pelvis
 ;;^UTILITY(U,$J,358.3,53761,1,4,0)
 ;;=4^C64.2
 ;;^UTILITY(U,$J,358.3,53761,2)
 ;;=^5001249
 ;;^UTILITY(U,$J,358.3,53762,0)
 ;;=N18.6^^253^2721^3
 ;;^UTILITY(U,$J,358.3,53762,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53762,1,3,0)
 ;;=3^ESRD
 ;;^UTILITY(U,$J,358.3,53762,1,4,0)
 ;;=4^N18.6
 ;;^UTILITY(U,$J,358.3,53762,2)
 ;;=^303986
 ;;^UTILITY(U,$J,358.3,53763,0)
 ;;=B17.11^^253^2722^2
 ;;^UTILITY(U,$J,358.3,53763,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53763,1,3,0)
 ;;=3^Acute hepatitis C with hepatic coma
 ;;^UTILITY(U,$J,358.3,53763,1,4,0)
 ;;=4^B17.11
 ;;^UTILITY(U,$J,358.3,53763,2)
 ;;=^331777
 ;;^UTILITY(U,$J,358.3,53764,0)
 ;;=B18.2^^253^2722^9
 ;;^UTILITY(U,$J,358.3,53764,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53764,1,3,0)
 ;;=3^Chronic viral hepatitis C
 ;;^UTILITY(U,$J,358.3,53764,1,4,0)
 ;;=4^B18.2
 ;;^UTILITY(U,$J,358.3,53764,2)
 ;;=^5000548
 ;;^UTILITY(U,$J,358.3,53765,0)
 ;;=B17.10^^253^2722^3
 ;;^UTILITY(U,$J,358.3,53765,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53765,1,3,0)
 ;;=3^Acute hepatitis C without hepatic coma
 ;;^UTILITY(U,$J,358.3,53765,1,4,0)
 ;;=4^B17.10
 ;;^UTILITY(U,$J,358.3,53765,2)
 ;;=^5000542
 ;;^UTILITY(U,$J,358.3,53766,0)
 ;;=B19.20^^253^2722^23
 ;;^UTILITY(U,$J,358.3,53766,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53766,1,3,0)
 ;;=3^Viral hepatitis C without hepatic coma,Unspec
