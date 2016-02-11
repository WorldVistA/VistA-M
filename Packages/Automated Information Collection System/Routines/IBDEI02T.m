IBDEI02T ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,554,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,554,1,3,0)
 ;;=3^Diabetes Type 2 w/ Diabetic Chr Kidney Disease
 ;;^UTILITY(U,$J,358.3,554,1,4,0)
 ;;=4^E11.22
 ;;^UTILITY(U,$J,358.3,554,2)
 ;;=^5002630
 ;;^UTILITY(U,$J,358.3,555,0)
 ;;=E11.29^^6^69^43
 ;;^UTILITY(U,$J,358.3,555,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,555,1,3,0)
 ;;=3^Diabetes Type 2 w/ Diabetic Kidney Complication
 ;;^UTILITY(U,$J,358.3,555,1,4,0)
 ;;=4^E11.29
 ;;^UTILITY(U,$J,358.3,555,2)
 ;;=^5002631
 ;;^UTILITY(U,$J,358.3,556,0)
 ;;=E11.311^^6^69^52
 ;;^UTILITY(U,$J,358.3,556,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,556,1,3,0)
 ;;=3^Diabetes Type 2 w/ Diabetic Retinopathy w/ Macular Edema
 ;;^UTILITY(U,$J,358.3,556,1,4,0)
 ;;=4^E11.311
 ;;^UTILITY(U,$J,358.3,556,2)
 ;;=^5002632
 ;;^UTILITY(U,$J,358.3,557,0)
 ;;=E11.319^^6^69^53
 ;;^UTILITY(U,$J,358.3,557,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,557,1,3,0)
 ;;=3^Diabetes Type 2 w/ Diabetic Retinopathy w/o Macular Edema
 ;;^UTILITY(U,$J,358.3,557,1,4,0)
 ;;=4^E11.319
 ;;^UTILITY(U,$J,358.3,557,2)
 ;;=^5002633
 ;;^UTILITY(U,$J,358.3,558,0)
 ;;=E11.321^^6^69^56
 ;;^UTILITY(U,$J,358.3,558,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,558,1,3,0)
 ;;=3^Diabetes Type 2 w/ Mild Nonprlf Diabetic Rtnop w/ Macular Edema
 ;;^UTILITY(U,$J,358.3,558,1,4,0)
 ;;=4^E11.321
 ;;^UTILITY(U,$J,358.3,558,2)
 ;;=^5002634
 ;;^UTILITY(U,$J,358.3,559,0)
 ;;=E11.329^^6^69^57
 ;;^UTILITY(U,$J,358.3,559,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,559,1,3,0)
 ;;=3^Diabetes Type 2 w/ Mild Nonprlf Diabetic Rtnop w/o Macular Edema
 ;;^UTILITY(U,$J,358.3,559,1,4,0)
 ;;=4^E11.329
 ;;^UTILITY(U,$J,358.3,559,2)
 ;;=^5002635
 ;;^UTILITY(U,$J,358.3,560,0)
 ;;=E11.331^^6^69^58
 ;;^UTILITY(U,$J,358.3,560,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,560,1,3,0)
 ;;=3^Diabetes Type 2 w/ Moderate Nonprlf Diabetic Rtnop w/ Macular Edema
 ;;^UTILITY(U,$J,358.3,560,1,4,0)
 ;;=4^E11.331
 ;;^UTILITY(U,$J,358.3,560,2)
 ;;=^5002636
 ;;^UTILITY(U,$J,358.3,561,0)
 ;;=E11.339^^6^69^59
 ;;^UTILITY(U,$J,358.3,561,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,561,1,3,0)
 ;;=3^Diabetes Type 2 w/ Moderate Nonprlf Diabetic Rtnop w/o Macular Edema
 ;;^UTILITY(U,$J,358.3,561,1,4,0)
 ;;=4^E11.339
 ;;^UTILITY(U,$J,358.3,561,2)
 ;;=^5002637
 ;;^UTILITY(U,$J,358.3,562,0)
 ;;=E11.341^^6^69^64
 ;;^UTILITY(U,$J,358.3,562,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,562,1,3,0)
 ;;=3^Diabetes Type 2 w/ Severe Nonprlf Diabetic Rtnop w/ Macular Edema
 ;;^UTILITY(U,$J,358.3,562,1,4,0)
 ;;=4^E11.341
 ;;^UTILITY(U,$J,358.3,562,2)
 ;;=^5002638
 ;;^UTILITY(U,$J,358.3,563,0)
 ;;=E11.349^^6^69^65
 ;;^UTILITY(U,$J,358.3,563,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,563,1,3,0)
 ;;=3^Diabetes Type 2 w/ Severe Nonprlf Diabetic Rtnop w/o Macular Edema
 ;;^UTILITY(U,$J,358.3,563,1,4,0)
 ;;=4^E11.349
 ;;^UTILITY(U,$J,358.3,563,2)
 ;;=^5002639
 ;;^UTILITY(U,$J,358.3,564,0)
 ;;=E11.351^^6^69^62
 ;;^UTILITY(U,$J,358.3,564,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,564,1,3,0)
 ;;=3^Diabetes Type 2 w/ Prolif Diabetic Rtnop w/ Macular Edema
 ;;^UTILITY(U,$J,358.3,564,1,4,0)
 ;;=4^E11.351
 ;;^UTILITY(U,$J,358.3,564,2)
 ;;=^5002640
 ;;^UTILITY(U,$J,358.3,565,0)
 ;;=E11.359^^6^69^63
 ;;^UTILITY(U,$J,358.3,565,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,565,1,3,0)
 ;;=3^Diabetes Type 2 w/ Prolif Diabetic Rtnop w/o Macular Edema
 ;;^UTILITY(U,$J,358.3,565,1,4,0)
 ;;=4^E11.359
 ;;^UTILITY(U,$J,358.3,565,2)
 ;;=^5002641
 ;;^UTILITY(U,$J,358.3,566,0)
 ;;=E11.36^^6^69^40
 ;;^UTILITY(U,$J,358.3,566,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,566,1,3,0)
 ;;=3^Diabetes Type 2 w/ Diabetic Cataract
