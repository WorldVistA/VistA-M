IBDEI0KZ ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,9285,0)
 ;;=10021^^70^631^16^^^^1
 ;;^UTILITY(U,$J,358.3,9285,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9285,1,2,0)
 ;;=2^10021
 ;;^UTILITY(U,$J,358.3,9285,1,3,0)
 ;;=3^FNA w/o Imaging Guidance,1st Lesion
 ;;^UTILITY(U,$J,358.3,9286,0)
 ;;=10004^^70^631^17^^^^1
 ;;^UTILITY(U,$J,358.3,9286,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9286,1,2,0)
 ;;=2^10004
 ;;^UTILITY(U,$J,358.3,9286,1,3,0)
 ;;=3^FNA w/o Imaging Guidance,Ea Addl Lesion
 ;;^UTILITY(U,$J,358.3,9287,0)
 ;;=11765^^70^631^18^^^^1
 ;;^UTILITY(U,$J,358.3,9287,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9287,1,2,0)
 ;;=2^11765
 ;;^UTILITY(U,$J,358.3,9287,1,3,0)
 ;;=3^Wedge Excision of Nail for Ingrown Nail
 ;;^UTILITY(U,$J,358.3,9288,0)
 ;;=90792^^70^632^1^^^^1
 ;;^UTILITY(U,$J,358.3,9288,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9288,1,2,0)
 ;;=2^90792
 ;;^UTILITY(U,$J,358.3,9288,1,3,0)
 ;;=3^Psychiatric Diagnostic Eval w/ Med Eval
 ;;^UTILITY(U,$J,358.3,9289,0)
 ;;=90839^^70^632^2^^^^1
 ;;^UTILITY(U,$J,358.3,9289,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9289,1,2,0)
 ;;=2^90839
 ;;^UTILITY(U,$J,358.3,9289,1,3,0)
 ;;=3^Psychotherapy for Crisis;1st hr
 ;;^UTILITY(U,$J,358.3,9290,0)
 ;;=90840^^70^632^3^^^^1
 ;;^UTILITY(U,$J,358.3,9290,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9290,1,2,0)
 ;;=2^90840
 ;;^UTILITY(U,$J,358.3,9290,1,3,0)
 ;;=3^Psychotherapy for Crisis;Ea Addl 30min
 ;;^UTILITY(U,$J,358.3,9291,0)
 ;;=90885^^70^632^4^^^^1
 ;;^UTILITY(U,$J,358.3,9291,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9291,1,2,0)
 ;;=2^90885
 ;;^UTILITY(U,$J,358.3,9291,1,3,0)
 ;;=3^Psych Eval of Records for Diagnostic Purposes
 ;;^UTILITY(U,$J,358.3,9292,0)
 ;;=36415^^70^633^16^^^^1
 ;;^UTILITY(U,$J,358.3,9292,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9292,1,2,0)
 ;;=2^36415
 ;;^UTILITY(U,$J,358.3,9292,1,3,0)
 ;;=3^Venous Blood Draw
 ;;^UTILITY(U,$J,358.3,9293,0)
 ;;=36000^^70^633^4^^^^1
 ;;^UTILITY(U,$J,358.3,9293,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9293,1,2,0)
 ;;=2^36000
 ;;^UTILITY(U,$J,358.3,9293,1,3,0)
 ;;=3^IV Insertion,Vein
 ;;^UTILITY(U,$J,358.3,9294,0)
 ;;=94760^^70^633^10^^^^1
 ;;^UTILITY(U,$J,358.3,9294,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9294,1,2,0)
 ;;=2^94760
 ;;^UTILITY(U,$J,358.3,9294,1,3,0)
 ;;=3^Pulse Oximetry
 ;;^UTILITY(U,$J,358.3,9295,0)
 ;;=94640^^70^633^7^^^^1
 ;;^UTILITY(U,$J,358.3,9295,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9295,1,2,0)
 ;;=2^94640
 ;;^UTILITY(U,$J,358.3,9295,1,3,0)
 ;;=3^Nebulizer Treatment
 ;;^UTILITY(U,$J,358.3,9296,0)
 ;;=94010^^70^633^9^^^^1
 ;;^UTILITY(U,$J,358.3,9296,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9296,1,2,0)
 ;;=2^94010
 ;;^UTILITY(U,$J,358.3,9296,1,3,0)
 ;;=3^Peak Flow Spirometry
 ;;^UTILITY(U,$J,358.3,9297,0)
 ;;=82948^^70^633^3^^^^1
 ;;^UTILITY(U,$J,358.3,9297,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9297,1,2,0)
 ;;=2^82948
 ;;^UTILITY(U,$J,358.3,9297,1,3,0)
 ;;=3^Glucose Finger Stick
 ;;^UTILITY(U,$J,358.3,9298,0)
 ;;=51798^^70^633^1^^^^1
 ;;^UTILITY(U,$J,358.3,9298,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9298,1,2,0)
 ;;=2^51798
 ;;^UTILITY(U,$J,358.3,9298,1,3,0)
 ;;=3^Bladder Scan PVR
 ;;^UTILITY(U,$J,358.3,9299,0)
 ;;=51702^^70^633^5^^^^1
 ;;^UTILITY(U,$J,358.3,9299,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9299,1,2,0)
 ;;=2^51702
 ;;^UTILITY(U,$J,358.3,9299,1,3,0)
 ;;=3^Insert Foley Catheter
 ;;^UTILITY(U,$J,358.3,9300,0)
 ;;=51701^^70^633^6^^^^1
