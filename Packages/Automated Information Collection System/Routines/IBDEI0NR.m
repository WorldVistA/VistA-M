IBDEI0NR ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,11091,1,4,0)
 ;;=4^E11.44
 ;;^UTILITY(U,$J,358.3,11091,2)
 ;;=^5002648
 ;;^UTILITY(U,$J,358.3,11092,0)
 ;;=E11.59^^47^527^7
 ;;^UTILITY(U,$J,358.3,11092,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11092,1,3,0)
 ;;=3^Diabetes Type 2 w/ Circulatory Complications
 ;;^UTILITY(U,$J,358.3,11092,1,4,0)
 ;;=4^E11.59
 ;;^UTILITY(U,$J,358.3,11092,2)
 ;;=^5002652
 ;;^UTILITY(U,$J,358.3,11093,0)
 ;;=E11.638^^47^527^25
 ;;^UTILITY(U,$J,358.3,11093,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11093,1,3,0)
 ;;=3^Diabetes Type 2 w/ Oral Complications
 ;;^UTILITY(U,$J,358.3,11093,1,4,0)
 ;;=4^E11.638
 ;;^UTILITY(U,$J,358.3,11093,2)
 ;;=^5002660
 ;;^UTILITY(U,$J,358.3,11094,0)
 ;;=E11.628^^47^527^27
 ;;^UTILITY(U,$J,358.3,11094,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11094,1,3,0)
 ;;=3^Diabetes Type 2 w/ Skin Complications
 ;;^UTILITY(U,$J,358.3,11094,1,4,0)
 ;;=4^E11.628
 ;;^UTILITY(U,$J,358.3,11094,2)
 ;;=^5002658
 ;;^UTILITY(U,$J,358.3,11095,0)
 ;;=E11.630^^47^527^26
 ;;^UTILITY(U,$J,358.3,11095,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11095,1,3,0)
 ;;=3^Diabetes Type 2 w/ Periodontal Disease
 ;;^UTILITY(U,$J,358.3,11095,1,4,0)
 ;;=4^E11.630
 ;;^UTILITY(U,$J,358.3,11095,2)
 ;;=^5002659
 ;;^UTILITY(U,$J,358.3,11096,0)
 ;;=E11.8^^47^527^28
 ;;^UTILITY(U,$J,358.3,11096,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11096,1,3,0)
 ;;=3^Diabetes Type 2 w/ Unspec Complications
 ;;^UTILITY(U,$J,358.3,11096,1,4,0)
 ;;=4^E11.8
 ;;^UTILITY(U,$J,358.3,11096,2)
 ;;=^5002665
 ;;^UTILITY(U,$J,358.3,11097,0)
 ;;=E11.9^^47^527^29
 ;;^UTILITY(U,$J,358.3,11097,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11097,1,3,0)
 ;;=3^Diabetes Type 2 w/o Complications
 ;;^UTILITY(U,$J,358.3,11097,1,4,0)
 ;;=4^E11.9
 ;;^UTILITY(U,$J,358.3,11097,2)
 ;;=^5002666
 ;;^UTILITY(U,$J,358.3,11098,0)
 ;;=E11.36^^47^527^9
 ;;^UTILITY(U,$J,358.3,11098,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11098,1,3,0)
 ;;=3^Diabetes Type 2 w/ Diabetic Cataract
 ;;^UTILITY(U,$J,358.3,11098,1,4,0)
 ;;=4^E11.36
 ;;^UTILITY(U,$J,358.3,11098,2)
 ;;=^5002642
 ;;^UTILITY(U,$J,358.3,11099,0)
 ;;=E11.22^^47^527^10
 ;;^UTILITY(U,$J,358.3,11099,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11099,1,3,0)
 ;;=3^Diabetes Type 2 w/ Diabetic Chronic Kidney Disease
 ;;^UTILITY(U,$J,358.3,11099,1,4,0)
 ;;=4^E11.22
 ;;^UTILITY(U,$J,358.3,11099,2)
 ;;=^5002630
 ;;^UTILITY(U,$J,358.3,11100,0)
 ;;=E11.29^^47^527^12
 ;;^UTILITY(U,$J,358.3,11100,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11100,1,3,0)
 ;;=3^Diabetes Type 2 w/ Diabetic Kidney Complication
 ;;^UTILITY(U,$J,358.3,11100,1,4,0)
 ;;=4^E11.29
 ;;^UTILITY(U,$J,358.3,11100,2)
 ;;=^5002631
 ;;^UTILITY(U,$J,358.3,11101,0)
 ;;=E11.21^^47^527^13
 ;;^UTILITY(U,$J,358.3,11101,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11101,1,3,0)
 ;;=3^Diabetes Type 2 w/ Diabetic Nephropathy
 ;;^UTILITY(U,$J,358.3,11101,1,4,0)
 ;;=4^E11.21
 ;;^UTILITY(U,$J,358.3,11101,2)
 ;;=^5002629
 ;;^UTILITY(U,$J,358.3,11102,0)
 ;;=E11.39^^47^527^16
 ;;^UTILITY(U,$J,358.3,11102,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11102,1,3,0)
 ;;=3^Diabetes Type 2 w/ Diabetic Ophthalmic Complication
 ;;^UTILITY(U,$J,358.3,11102,1,4,0)
 ;;=4^E11.39
 ;;^UTILITY(U,$J,358.3,11102,2)
 ;;=^5002643
 ;;^UTILITY(U,$J,358.3,11103,0)
 ;;=E11.311^^47^527^20
 ;;^UTILITY(U,$J,358.3,11103,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11103,1,3,0)
 ;;=3^Diabetes Type 2 w/ Diabetic Retinopathy w/ Macular Edema
 ;;^UTILITY(U,$J,358.3,11103,1,4,0)
 ;;=4^E11.311
 ;;^UTILITY(U,$J,358.3,11103,2)
 ;;=^5002632
 ;;^UTILITY(U,$J,358.3,11104,0)
 ;;=E11.319^^47^527^19
