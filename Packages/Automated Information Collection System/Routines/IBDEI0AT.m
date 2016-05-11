IBDEI0AT ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,4841,1,3,0)
 ;;=3^Diabetes Type 1 w/ Diabetic Amyotrophy
 ;;^UTILITY(U,$J,358.3,4841,1,4,0)
 ;;=4^E10.44
 ;;^UTILITY(U,$J,358.3,4841,2)
 ;;=^5002608
 ;;^UTILITY(U,$J,358.3,4842,0)
 ;;=E10.49^^24^305^23
 ;;^UTILITY(U,$J,358.3,4842,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4842,1,3,0)
 ;;=3^Diabetes Type 1 w/ Diabetic Neurological Complications NEC
 ;;^UTILITY(U,$J,358.3,4842,1,4,0)
 ;;=4^E10.49
 ;;^UTILITY(U,$J,358.3,4842,2)
 ;;=^5002609
 ;;^UTILITY(U,$J,358.3,4843,0)
 ;;=E10.59^^24^305^11
 ;;^UTILITY(U,$J,358.3,4843,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4843,1,3,0)
 ;;=3^Diabetes Type 1 w/ Circulatory Complications NEC
 ;;^UTILITY(U,$J,358.3,4843,1,4,0)
 ;;=4^E10.59
 ;;^UTILITY(U,$J,358.3,4843,2)
 ;;=^5002612
 ;;^UTILITY(U,$J,358.3,4844,0)
 ;;=E10.610^^24^305^24
 ;;^UTILITY(U,$J,358.3,4844,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4844,1,3,0)
 ;;=3^Diabetes Type 1 w/ Diabetic Neuropathic Arthropathy
 ;;^UTILITY(U,$J,358.3,4844,1,4,0)
 ;;=4^E10.610
 ;;^UTILITY(U,$J,358.3,4844,2)
 ;;=^5002613
 ;;^UTILITY(U,$J,358.3,4845,0)
 ;;=E10.618^^24^305^16
 ;;^UTILITY(U,$J,358.3,4845,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4845,1,3,0)
 ;;=3^Diabetes Type 1 w/ Diabetic Arthropathy NEC
 ;;^UTILITY(U,$J,358.3,4845,1,4,0)
 ;;=4^E10.618
 ;;^UTILITY(U,$J,358.3,4845,2)
 ;;=^5002614
 ;;^UTILITY(U,$J,358.3,4846,0)
 ;;=E10.620^^24^305^19
 ;;^UTILITY(U,$J,358.3,4846,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4846,1,3,0)
 ;;=3^Diabetes Type 1 w/ Diabetic Dermatitis
 ;;^UTILITY(U,$J,358.3,4846,1,4,0)
 ;;=4^E10.620
 ;;^UTILITY(U,$J,358.3,4846,2)
 ;;=^5002615
 ;;^UTILITY(U,$J,358.3,4847,0)
 ;;=E10.621^^24^305^32
 ;;^UTILITY(U,$J,358.3,4847,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4847,1,3,0)
 ;;=3^Diabetes Type 1 w/ Foot Ulcer
 ;;^UTILITY(U,$J,358.3,4847,1,4,0)
 ;;=4^E10.621
 ;;^UTILITY(U,$J,358.3,4847,2)
 ;;=^5002616
 ;;^UTILITY(U,$J,358.3,4848,0)
 ;;=E10.641^^24^305^34
 ;;^UTILITY(U,$J,358.3,4848,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4848,1,3,0)
 ;;=3^Diabetes Type 1 w/ Hypoglycemia w/ Coma
 ;;^UTILITY(U,$J,358.3,4848,1,4,0)
 ;;=4^E10.641
 ;;^UTILITY(U,$J,358.3,4848,2)
 ;;=^5002621
 ;;^UTILITY(U,$J,358.3,4849,0)
 ;;=E10.69^^24^305^50
 ;;^UTILITY(U,$J,358.3,4849,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4849,1,3,0)
 ;;=3^Diabetes Type 1 w/ Specified Complications NEC
 ;;^UTILITY(U,$J,358.3,4849,1,4,0)
 ;;=4^E10.69
 ;;^UTILITY(U,$J,358.3,4849,2)
 ;;=^5002624
 ;;^UTILITY(U,$J,358.3,4850,0)
 ;;=E10.8^^24^305^12
 ;;^UTILITY(U,$J,358.3,4850,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4850,1,3,0)
 ;;=3^Diabetes Type 1 w/ Complications,Unspec
 ;;^UTILITY(U,$J,358.3,4850,1,4,0)
 ;;=4^E10.8
 ;;^UTILITY(U,$J,358.3,4850,2)
 ;;=^5002625
 ;;^UTILITY(U,$J,358.3,4851,0)
 ;;=E11.00^^24^305^70
 ;;^UTILITY(U,$J,358.3,4851,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4851,1,3,0)
 ;;=3^Diabetes Type 2 w/ Hyperosmolarity w/o NKHHC
 ;;^UTILITY(U,$J,358.3,4851,1,4,0)
 ;;=4^E11.00
 ;;^UTILITY(U,$J,358.3,4851,2)
 ;;=^5002627
 ;;^UTILITY(U,$J,358.3,4852,0)
 ;;=E11.01^^24^305^69
 ;;^UTILITY(U,$J,358.3,4852,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4852,1,3,0)
 ;;=3^Diabetes Type 2 w/ Hyperosmolarity w/ Coma
 ;;^UTILITY(U,$J,358.3,4852,1,4,0)
 ;;=4^E11.01
 ;;^UTILITY(U,$J,358.3,4852,2)
 ;;=^5002628
 ;;^UTILITY(U,$J,358.3,4853,0)
 ;;=E11.36^^24^305^53
 ;;^UTILITY(U,$J,358.3,4853,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4853,1,3,0)
 ;;=3^Diabetes Type 2 w/  Diabetic Cataract
 ;;^UTILITY(U,$J,358.3,4853,1,4,0)
 ;;=4^E11.36
 ;;^UTILITY(U,$J,358.3,4853,2)
 ;;=^5002642
 ;;^UTILITY(U,$J,358.3,4854,0)
 ;;=E11.39^^24^305^65
