IBDEI0GC ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,7252,1,3,0)
 ;;=3^Diabetes Type 2 w/ Diabetic Ophthalmic Complication NEC
 ;;^UTILITY(U,$J,358.3,7252,1,4,0)
 ;;=4^E11.39
 ;;^UTILITY(U,$J,358.3,7252,2)
 ;;=^5002643
 ;;^UTILITY(U,$J,358.3,7253,0)
 ;;=E11.41^^49^479^63
 ;;^UTILITY(U,$J,358.3,7253,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7253,1,3,0)
 ;;=3^Diabetes Type 2 w/ Diabetic Mononueuropathy
 ;;^UTILITY(U,$J,358.3,7253,1,4,0)
 ;;=4^E11.41
 ;;^UTILITY(U,$J,358.3,7253,2)
 ;;=^5002645
 ;;^UTILITY(U,$J,358.3,7254,0)
 ;;=E11.42^^49^479^66
 ;;^UTILITY(U,$J,358.3,7254,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7254,1,3,0)
 ;;=3^Diabetes Type 2 w/ Diabetic Polyneuropathy
 ;;^UTILITY(U,$J,358.3,7254,1,4,0)
 ;;=4^E11.42
 ;;^UTILITY(U,$J,358.3,7254,2)
 ;;=^5002646
 ;;^UTILITY(U,$J,358.3,7255,0)
 ;;=E11.43^^49^479^62
 ;;^UTILITY(U,$J,358.3,7255,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7255,1,3,0)
 ;;=3^Diabetes Type 2 w/ Diabetic Autonomic Polyneuropathy
 ;;^UTILITY(U,$J,358.3,7255,1,4,0)
 ;;=4^E11.43
 ;;^UTILITY(U,$J,358.3,7255,2)
 ;;=^5002647
 ;;^UTILITY(U,$J,358.3,7256,0)
 ;;=E11.44^^49^479^61
 ;;^UTILITY(U,$J,358.3,7256,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7256,1,3,0)
 ;;=3^Diabetes Type 2 w/ Diabetic Amyotrophy
 ;;^UTILITY(U,$J,358.3,7256,1,4,0)
 ;;=4^E11.44
 ;;^UTILITY(U,$J,358.3,7256,2)
 ;;=^5002648
 ;;^UTILITY(U,$J,358.3,7257,0)
 ;;=E11.49^^49^479^64
 ;;^UTILITY(U,$J,358.3,7257,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7257,1,3,0)
 ;;=3^Diabetes Type 2 w/ Diabetic Neurological Complication NEC
 ;;^UTILITY(U,$J,358.3,7257,1,4,0)
 ;;=4^E11.49
 ;;^UTILITY(U,$J,358.3,7257,2)
 ;;=^5002649
 ;;^UTILITY(U,$J,358.3,7258,0)
 ;;=E10.39^^49^479^26
 ;;^UTILITY(U,$J,358.3,7258,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7258,1,3,0)
 ;;=3^Diabetes Type 1 w/ Diabetic Ophthalmic Complication NEC
 ;;^UTILITY(U,$J,358.3,7258,1,4,0)
 ;;=4^E10.39
 ;;^UTILITY(U,$J,358.3,7258,2)
 ;;=^5002603
 ;;^UTILITY(U,$J,358.3,7259,0)
 ;;=E10.10^^49^479^37
 ;;^UTILITY(U,$J,358.3,7259,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7259,1,3,0)
 ;;=3^Diabetes Type 1 w/ Ketoacidosis w/o Coma
 ;;^UTILITY(U,$J,358.3,7259,1,4,0)
 ;;=4^E10.10
 ;;^UTILITY(U,$J,358.3,7259,2)
 ;;=^5002587
 ;;^UTILITY(U,$J,358.3,7260,0)
 ;;=E10.21^^49^479^22
 ;;^UTILITY(U,$J,358.3,7260,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7260,1,3,0)
 ;;=3^Diabetes Type 1 w/ Diabetic Nephropathy
 ;;^UTILITY(U,$J,358.3,7260,1,4,0)
 ;;=4^E10.21
 ;;^UTILITY(U,$J,358.3,7260,2)
 ;;=^5002589
 ;;^UTILITY(U,$J,358.3,7261,0)
 ;;=E10.311^^49^479^30
 ;;^UTILITY(U,$J,358.3,7261,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7261,1,3,0)
 ;;=3^Diabetes Type 1 w/ Diabetic Retinopathy w/ Macular Edema
 ;;^UTILITY(U,$J,358.3,7261,1,4,0)
 ;;=4^E10.311
 ;;^UTILITY(U,$J,358.3,7261,2)
 ;;=^5002592
 ;;^UTILITY(U,$J,358.3,7262,0)
 ;;=E10.319^^49^479^31
 ;;^UTILITY(U,$J,358.3,7262,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7262,1,3,0)
 ;;=3^Diabetes Type 1 w/ Diabetic Retinopathy w/o Macular Edema
 ;;^UTILITY(U,$J,358.3,7262,1,4,0)
 ;;=4^E10.319
 ;;^UTILITY(U,$J,358.3,7262,2)
 ;;=^5002593
 ;;^UTILITY(U,$J,358.3,7263,0)
 ;;=E10.321^^49^479^38
 ;;^UTILITY(U,$J,358.3,7263,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7263,1,3,0)
 ;;=3^Diabetes Type 1 w/ Mild Nonprlf Diabetic Retinopathy w/ Macular Edema
 ;;^UTILITY(U,$J,358.3,7263,1,4,0)
 ;;=4^E10.321
 ;;^UTILITY(U,$J,358.3,7263,2)
 ;;=^5002594
 ;;^UTILITY(U,$J,358.3,7264,0)
 ;;=E10.329^^49^479^39
 ;;^UTILITY(U,$J,358.3,7264,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7264,1,3,0)
 ;;=3^Diabetes Type 1 w/ Mild Nonprlf Diabetic Retinopathy w/o Macular Edema
