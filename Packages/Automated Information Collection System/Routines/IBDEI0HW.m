IBDEI0HW ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8279,1,1,0)
 ;;=1^Detailed
 ;;^UTILITY(U,$J,358.3,8279,1,2,0)
 ;;=2^99243
 ;;^UTILITY(U,$J,358.3,8280,0)
 ;;=99244^^34^441^4
 ;;^UTILITY(U,$J,358.3,8280,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,8280,1,1,0)
 ;;=1^Comprehensive, Moderate
 ;;^UTILITY(U,$J,358.3,8280,1,2,0)
 ;;=2^99244
 ;;^UTILITY(U,$J,358.3,8281,0)
 ;;=99245^^34^441^5
 ;;^UTILITY(U,$J,358.3,8281,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,8281,1,1,0)
 ;;=1^Comprehensive, High
 ;;^UTILITY(U,$J,358.3,8281,1,2,0)
 ;;=2^99245
 ;;^UTILITY(U,$J,358.3,8282,0)
 ;;=E11.9^^35^442^30
 ;;^UTILITY(U,$J,358.3,8282,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8282,1,3,0)
 ;;=3^Diabetes Type 2 w/o Complications
 ;;^UTILITY(U,$J,358.3,8282,1,4,0)
 ;;=4^E11.9
 ;;^UTILITY(U,$J,358.3,8282,2)
 ;;=^5002666
 ;;^UTILITY(U,$J,358.3,8283,0)
 ;;=E10.9^^35^442^19
 ;;^UTILITY(U,$J,358.3,8283,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8283,1,3,0)
 ;;=3^Diabetes Type 1 w/o Complications
 ;;^UTILITY(U,$J,358.3,8283,1,4,0)
 ;;=4^E10.9
 ;;^UTILITY(U,$J,358.3,8283,2)
 ;;=^5002626
 ;;^UTILITY(U,$J,358.3,8284,0)
 ;;=E10.69^^35^442^18
 ;;^UTILITY(U,$J,358.3,8284,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8284,1,3,0)
 ;;=3^Diabetes Type 1 w/ Other Spec Complication
 ;;^UTILITY(U,$J,358.3,8284,1,4,0)
 ;;=4^E10.69
 ;;^UTILITY(U,$J,358.3,8284,2)
 ;;=^5002624
 ;;^UTILITY(U,$J,358.3,8285,0)
 ;;=E11.65^^35^442^28
 ;;^UTILITY(U,$J,358.3,8285,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8285,1,3,0)
 ;;=3^Diabetes Type 2 w/ Hyperglycemia
 ;;^UTILITY(U,$J,358.3,8285,1,4,0)
 ;;=4^E11.65
 ;;^UTILITY(U,$J,358.3,8285,2)
 ;;=^5002663
 ;;^UTILITY(U,$J,358.3,8286,0)
 ;;=E11.21^^35^442^21
 ;;^UTILITY(U,$J,358.3,8286,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8286,1,3,0)
 ;;=3^Diabetes Type 2 w/ Diab Nephropathy
 ;;^UTILITY(U,$J,358.3,8286,1,4,0)
 ;;=4^E11.21
 ;;^UTILITY(U,$J,358.3,8286,2)
 ;;=^5002629
 ;;^UTILITY(U,$J,358.3,8287,0)
 ;;=E11.22^^35^442^20
 ;;^UTILITY(U,$J,358.3,8287,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8287,1,3,0)
 ;;=3^Diabetes Type 2 w/ Chronic Kidney Disease
 ;;^UTILITY(U,$J,358.3,8287,1,4,0)
 ;;=4^E11.22
 ;;^UTILITY(U,$J,358.3,8287,2)
 ;;=^5002630
 ;;^UTILITY(U,$J,358.3,8288,0)
 ;;=E11.311^^35^442^22
 ;;^UTILITY(U,$J,358.3,8288,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8288,1,3,0)
 ;;=3^Diabetes Type 2 w/ Diab Retinopathy w/ Macular Edema
 ;;^UTILITY(U,$J,358.3,8288,1,4,0)
 ;;=4^E11.311
 ;;^UTILITY(U,$J,358.3,8288,2)
 ;;=^5002632
 ;;^UTILITY(U,$J,358.3,8289,0)
 ;;=E11.319^^35^442^23
 ;;^UTILITY(U,$J,358.3,8289,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8289,1,3,0)
 ;;=3^Diabetes Type 2 w/ Diab Retinopathy w/o Macular Edema
 ;;^UTILITY(U,$J,358.3,8289,1,4,0)
 ;;=4^E11.319
 ;;^UTILITY(U,$J,358.3,8289,2)
 ;;=^5002633
 ;;^UTILITY(U,$J,358.3,8290,0)
 ;;=E11.621^^35^442^27
 ;;^UTILITY(U,$J,358.3,8290,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8290,1,3,0)
 ;;=3^Diabetes Type 2 w/ Foot Ulcer
 ;;^UTILITY(U,$J,358.3,8290,1,4,0)
 ;;=4^E11.621
 ;;^UTILITY(U,$J,358.3,8290,2)
 ;;=^5002656
 ;;^UTILITY(U,$J,358.3,8291,0)
 ;;=E11.8^^35^442^29
 ;;^UTILITY(U,$J,358.3,8291,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8291,1,3,0)
 ;;=3^Diabetes Type 2 w/ Unspec Complications
 ;;^UTILITY(U,$J,358.3,8291,1,4,0)
 ;;=4^E11.8
 ;;^UTILITY(U,$J,358.3,8291,2)
 ;;=^5002665
 ;;^UTILITY(U,$J,358.3,8292,0)
 ;;=N18.6^^35^442^32
 ;;^UTILITY(U,$J,358.3,8292,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8292,1,3,0)
 ;;=3^ESRD
 ;;^UTILITY(U,$J,358.3,8292,1,4,0)
 ;;=4^N18.6
 ;;^UTILITY(U,$J,358.3,8292,2)
 ;;=^303986
 ;;^UTILITY(U,$J,358.3,8293,0)
 ;;=N18.9^^35^442^15
