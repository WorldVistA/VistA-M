IBDEI02Q ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,515,1,3,0)
 ;;=3^Dietary Counseling & Surveillance
 ;;^UTILITY(U,$J,358.3,515,1,4,0)
 ;;=4^Z71.3
 ;;^UTILITY(U,$J,358.3,515,2)
 ;;=^5063245
 ;;^UTILITY(U,$J,358.3,516,0)
 ;;=E10.9^^6^69^35
 ;;^UTILITY(U,$J,358.3,516,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,516,1,3,0)
 ;;=3^Diabetes Type 1 w/o Complications
 ;;^UTILITY(U,$J,358.3,516,1,4,0)
 ;;=4^E10.9
 ;;^UTILITY(U,$J,358.3,516,2)
 ;;=^5002626
 ;;^UTILITY(U,$J,358.3,517,0)
 ;;=E10.65^^6^69^20
 ;;^UTILITY(U,$J,358.3,517,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,517,1,3,0)
 ;;=3^Diabetes Type 1 w/ Hyperglycemia
 ;;^UTILITY(U,$J,358.3,517,1,4,0)
 ;;=4^E10.65
 ;;^UTILITY(U,$J,358.3,517,2)
 ;;=^5002623
 ;;^UTILITY(U,$J,358.3,518,0)
 ;;=E10.21^^6^69^10
 ;;^UTILITY(U,$J,358.3,518,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,518,1,3,0)
 ;;=3^Diabetes Type 1 w/ Diabetic Nephropathy
 ;;^UTILITY(U,$J,358.3,518,1,4,0)
 ;;=4^E10.21
 ;;^UTILITY(U,$J,358.3,518,2)
 ;;=^5002589
 ;;^UTILITY(U,$J,358.3,519,0)
 ;;=E10.22^^6^69^6
 ;;^UTILITY(U,$J,358.3,519,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,519,1,3,0)
 ;;=3^Diabetes Type 1 w/ Diabetic Chr Kidney Disease
 ;;^UTILITY(U,$J,358.3,519,1,4,0)
 ;;=4^E10.22
 ;;^UTILITY(U,$J,358.3,519,2)
 ;;=^5002590
 ;;^UTILITY(U,$J,358.3,520,0)
 ;;=E10.29^^6^69^8
 ;;^UTILITY(U,$J,358.3,520,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,520,1,3,0)
 ;;=3^Diabetes Type 1 w/ Diabetic Kidney Complication
 ;;^UTILITY(U,$J,358.3,520,1,4,0)
 ;;=4^E10.29
 ;;^UTILITY(U,$J,358.3,520,2)
 ;;=^5002591
 ;;^UTILITY(U,$J,358.3,521,0)
 ;;=E10.311^^6^69^17
 ;;^UTILITY(U,$J,358.3,521,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,521,1,3,0)
 ;;=3^Diabetes Type 1 w/ Diabetic Retinopathy w/ Macular Edema
 ;;^UTILITY(U,$J,358.3,521,1,4,0)
 ;;=4^E10.311
 ;;^UTILITY(U,$J,358.3,521,2)
 ;;=^5002592
 ;;^UTILITY(U,$J,358.3,522,0)
 ;;=E10.319^^6^69^18
 ;;^UTILITY(U,$J,358.3,522,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,522,1,3,0)
 ;;=3^Diabetes Type 1 w/ Diabetic Retinopathy w/o Macular Edema
 ;;^UTILITY(U,$J,358.3,522,1,4,0)
 ;;=4^E10.319
 ;;^UTILITY(U,$J,358.3,522,2)
 ;;=^5002593
 ;;^UTILITY(U,$J,358.3,523,0)
 ;;=E10.321^^6^69^21
 ;;^UTILITY(U,$J,358.3,523,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,523,1,3,0)
 ;;=3^Diabetes Type 1 w/ Mild Nonprlf Diabetic Rtnop w/ Macular Edema
 ;;^UTILITY(U,$J,358.3,523,1,4,0)
 ;;=4^E10.321
 ;;^UTILITY(U,$J,358.3,523,2)
 ;;=^5002594
 ;;^UTILITY(U,$J,358.3,524,0)
 ;;=E10.329^^6^69^22
 ;;^UTILITY(U,$J,358.3,524,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,524,1,3,0)
 ;;=3^Diabetes Type 1 w/ Mild Nonprlf Diabetic Rtnop w/o Macular Edema
 ;;^UTILITY(U,$J,358.3,524,1,4,0)
 ;;=4^E10.329
 ;;^UTILITY(U,$J,358.3,524,2)
 ;;=^5002595
 ;;^UTILITY(U,$J,358.3,525,0)
 ;;=E10.331^^6^69^23
 ;;^UTILITY(U,$J,358.3,525,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,525,1,3,0)
 ;;=3^Diabetes Type 1 w/ Moderate Nonprlf Diabetic Rtnop w/ Macular Edema
 ;;^UTILITY(U,$J,358.3,525,1,4,0)
 ;;=4^E10.331
 ;;^UTILITY(U,$J,358.3,525,2)
 ;;=^5002596
 ;;^UTILITY(U,$J,358.3,526,0)
 ;;=E10.339^^6^69^24
 ;;^UTILITY(U,$J,358.3,526,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,526,1,3,0)
 ;;=3^Diabetes Type 1 w/ Moderate Nonprlf Diabetic Rtnop w/o Macular Edema
 ;;^UTILITY(U,$J,358.3,526,1,4,0)
 ;;=4^E10.339
 ;;^UTILITY(U,$J,358.3,526,2)
 ;;=^5002597
 ;;^UTILITY(U,$J,358.3,527,0)
 ;;=E10.341^^6^69^30
 ;;^UTILITY(U,$J,358.3,527,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,527,1,3,0)
 ;;=3^Diabetes Type 1 w/ Severe Nonprlf Diabetic Rtnop w/ Macular Edema
 ;;^UTILITY(U,$J,358.3,527,1,4,0)
 ;;=4^E10.341
 ;;^UTILITY(U,$J,358.3,527,2)
 ;;=^5002598
