IBDEI0GB ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,7239,1,4,0)
 ;;=4^E10.44
 ;;^UTILITY(U,$J,358.3,7239,2)
 ;;=^5002608
 ;;^UTILITY(U,$J,358.3,7240,0)
 ;;=E10.49^^49^479^23
 ;;^UTILITY(U,$J,358.3,7240,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7240,1,3,0)
 ;;=3^Diabetes Type 1 w/ Diabetic Neurological Complications NEC
 ;;^UTILITY(U,$J,358.3,7240,1,4,0)
 ;;=4^E10.49
 ;;^UTILITY(U,$J,358.3,7240,2)
 ;;=^5002609
 ;;^UTILITY(U,$J,358.3,7241,0)
 ;;=E10.59^^49^479^11
 ;;^UTILITY(U,$J,358.3,7241,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7241,1,3,0)
 ;;=3^Diabetes Type 1 w/ Circulatory Complications NEC
 ;;^UTILITY(U,$J,358.3,7241,1,4,0)
 ;;=4^E10.59
 ;;^UTILITY(U,$J,358.3,7241,2)
 ;;=^5002612
 ;;^UTILITY(U,$J,358.3,7242,0)
 ;;=E10.610^^49^479^24
 ;;^UTILITY(U,$J,358.3,7242,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7242,1,3,0)
 ;;=3^Diabetes Type 1 w/ Diabetic Neuropathic Arthropathy
 ;;^UTILITY(U,$J,358.3,7242,1,4,0)
 ;;=4^E10.610
 ;;^UTILITY(U,$J,358.3,7242,2)
 ;;=^5002613
 ;;^UTILITY(U,$J,358.3,7243,0)
 ;;=E10.618^^49^479^16
 ;;^UTILITY(U,$J,358.3,7243,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7243,1,3,0)
 ;;=3^Diabetes Type 1 w/ Diabetic Arthropathy NEC
 ;;^UTILITY(U,$J,358.3,7243,1,4,0)
 ;;=4^E10.618
 ;;^UTILITY(U,$J,358.3,7243,2)
 ;;=^5002614
 ;;^UTILITY(U,$J,358.3,7244,0)
 ;;=E10.620^^49^479^19
 ;;^UTILITY(U,$J,358.3,7244,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7244,1,3,0)
 ;;=3^Diabetes Type 1 w/ Diabetic Dermatitis
 ;;^UTILITY(U,$J,358.3,7244,1,4,0)
 ;;=4^E10.620
 ;;^UTILITY(U,$J,358.3,7244,2)
 ;;=^5002615
 ;;^UTILITY(U,$J,358.3,7245,0)
 ;;=E10.621^^49^479^32
 ;;^UTILITY(U,$J,358.3,7245,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7245,1,3,0)
 ;;=3^Diabetes Type 1 w/ Foot Ulcer
 ;;^UTILITY(U,$J,358.3,7245,1,4,0)
 ;;=4^E10.621
 ;;^UTILITY(U,$J,358.3,7245,2)
 ;;=^5002616
 ;;^UTILITY(U,$J,358.3,7246,0)
 ;;=E10.641^^49^479^34
 ;;^UTILITY(U,$J,358.3,7246,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7246,1,3,0)
 ;;=3^Diabetes Type 1 w/ Hypoglycemia w/ Coma
 ;;^UTILITY(U,$J,358.3,7246,1,4,0)
 ;;=4^E10.641
 ;;^UTILITY(U,$J,358.3,7246,2)
 ;;=^5002621
 ;;^UTILITY(U,$J,358.3,7247,0)
 ;;=E10.69^^49^479^50
 ;;^UTILITY(U,$J,358.3,7247,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7247,1,3,0)
 ;;=3^Diabetes Type 1 w/ Specified Complications NEC
 ;;^UTILITY(U,$J,358.3,7247,1,4,0)
 ;;=4^E10.69
 ;;^UTILITY(U,$J,358.3,7247,2)
 ;;=^5002624
 ;;^UTILITY(U,$J,358.3,7248,0)
 ;;=E10.8^^49^479^12
 ;;^UTILITY(U,$J,358.3,7248,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7248,1,3,0)
 ;;=3^Diabetes Type 1 w/ Complications,Unspec
 ;;^UTILITY(U,$J,358.3,7248,1,4,0)
 ;;=4^E10.8
 ;;^UTILITY(U,$J,358.3,7248,2)
 ;;=^5002625
 ;;^UTILITY(U,$J,358.3,7249,0)
 ;;=E11.00^^49^479^70
 ;;^UTILITY(U,$J,358.3,7249,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7249,1,3,0)
 ;;=3^Diabetes Type 2 w/ Hyperosmolarity w/o NKHHC
 ;;^UTILITY(U,$J,358.3,7249,1,4,0)
 ;;=4^E11.00
 ;;^UTILITY(U,$J,358.3,7249,2)
 ;;=^5002627
 ;;^UTILITY(U,$J,358.3,7250,0)
 ;;=E11.01^^49^479^69
 ;;^UTILITY(U,$J,358.3,7250,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7250,1,3,0)
 ;;=3^Diabetes Type 2 w/ Hyperosmolarity w/ Coma
 ;;^UTILITY(U,$J,358.3,7250,1,4,0)
 ;;=4^E11.01
 ;;^UTILITY(U,$J,358.3,7250,2)
 ;;=^5002628
 ;;^UTILITY(U,$J,358.3,7251,0)
 ;;=E11.36^^49^479^53
 ;;^UTILITY(U,$J,358.3,7251,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7251,1,3,0)
 ;;=3^Diabetes Type 2 w/  Diabetic Cataract
 ;;^UTILITY(U,$J,358.3,7251,1,4,0)
 ;;=4^E11.36
 ;;^UTILITY(U,$J,358.3,7251,2)
 ;;=^5002642
 ;;^UTILITY(U,$J,358.3,7252,0)
 ;;=E11.39^^49^479^65
 ;;^UTILITY(U,$J,358.3,7252,1,0)
 ;;=^358.31IA^4^2
