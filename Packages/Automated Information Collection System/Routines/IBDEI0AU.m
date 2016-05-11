IBDEI0AU ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,4854,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4854,1,3,0)
 ;;=3^Diabetes Type 2 w/ Diabetic Ophthalmic Complication NEC
 ;;^UTILITY(U,$J,358.3,4854,1,4,0)
 ;;=4^E11.39
 ;;^UTILITY(U,$J,358.3,4854,2)
 ;;=^5002643
 ;;^UTILITY(U,$J,358.3,4855,0)
 ;;=E11.41^^24^305^63
 ;;^UTILITY(U,$J,358.3,4855,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4855,1,3,0)
 ;;=3^Diabetes Type 2 w/ Diabetic Mononueuropathy
 ;;^UTILITY(U,$J,358.3,4855,1,4,0)
 ;;=4^E11.41
 ;;^UTILITY(U,$J,358.3,4855,2)
 ;;=^5002645
 ;;^UTILITY(U,$J,358.3,4856,0)
 ;;=E11.42^^24^305^66
 ;;^UTILITY(U,$J,358.3,4856,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4856,1,3,0)
 ;;=3^Diabetes Type 2 w/ Diabetic Polyneuropathy
 ;;^UTILITY(U,$J,358.3,4856,1,4,0)
 ;;=4^E11.42
 ;;^UTILITY(U,$J,358.3,4856,2)
 ;;=^5002646
 ;;^UTILITY(U,$J,358.3,4857,0)
 ;;=E11.43^^24^305^62
 ;;^UTILITY(U,$J,358.3,4857,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4857,1,3,0)
 ;;=3^Diabetes Type 2 w/ Diabetic Autonomic Polyneuropathy
 ;;^UTILITY(U,$J,358.3,4857,1,4,0)
 ;;=4^E11.43
 ;;^UTILITY(U,$J,358.3,4857,2)
 ;;=^5002647
 ;;^UTILITY(U,$J,358.3,4858,0)
 ;;=E11.44^^24^305^61
 ;;^UTILITY(U,$J,358.3,4858,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4858,1,3,0)
 ;;=3^Diabetes Type 2 w/ Diabetic Amyotrophy
 ;;^UTILITY(U,$J,358.3,4858,1,4,0)
 ;;=4^E11.44
 ;;^UTILITY(U,$J,358.3,4858,2)
 ;;=^5002648
 ;;^UTILITY(U,$J,358.3,4859,0)
 ;;=E11.49^^24^305^64
 ;;^UTILITY(U,$J,358.3,4859,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4859,1,3,0)
 ;;=3^Diabetes Type 2 w/ Diabetic Neurological Complication NEC
 ;;^UTILITY(U,$J,358.3,4859,1,4,0)
 ;;=4^E11.49
 ;;^UTILITY(U,$J,358.3,4859,2)
 ;;=^5002649
 ;;^UTILITY(U,$J,358.3,4860,0)
 ;;=E10.39^^24^305^26
 ;;^UTILITY(U,$J,358.3,4860,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4860,1,3,0)
 ;;=3^Diabetes Type 1 w/ Diabetic Ophthalmic Complication NEC
 ;;^UTILITY(U,$J,358.3,4860,1,4,0)
 ;;=4^E10.39
 ;;^UTILITY(U,$J,358.3,4860,2)
 ;;=^5002603
 ;;^UTILITY(U,$J,358.3,4861,0)
 ;;=E10.10^^24^305^37
 ;;^UTILITY(U,$J,358.3,4861,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4861,1,3,0)
 ;;=3^Diabetes Type 1 w/ Ketoacidosis w/o Coma
 ;;^UTILITY(U,$J,358.3,4861,1,4,0)
 ;;=4^E10.10
 ;;^UTILITY(U,$J,358.3,4861,2)
 ;;=^5002587
 ;;^UTILITY(U,$J,358.3,4862,0)
 ;;=E10.21^^24^305^22
 ;;^UTILITY(U,$J,358.3,4862,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4862,1,3,0)
 ;;=3^Diabetes Type 1 w/ Diabetic Nephropathy
 ;;^UTILITY(U,$J,358.3,4862,1,4,0)
 ;;=4^E10.21
 ;;^UTILITY(U,$J,358.3,4862,2)
 ;;=^5002589
 ;;^UTILITY(U,$J,358.3,4863,0)
 ;;=E10.311^^24^305^30
 ;;^UTILITY(U,$J,358.3,4863,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4863,1,3,0)
 ;;=3^Diabetes Type 1 w/ Diabetic Retinopathy w/ Macular Edema
 ;;^UTILITY(U,$J,358.3,4863,1,4,0)
 ;;=4^E10.311
 ;;^UTILITY(U,$J,358.3,4863,2)
 ;;=^5002592
 ;;^UTILITY(U,$J,358.3,4864,0)
 ;;=E10.319^^24^305^31
 ;;^UTILITY(U,$J,358.3,4864,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4864,1,3,0)
 ;;=3^Diabetes Type 1 w/ Diabetic Retinopathy w/o Macular Edema
 ;;^UTILITY(U,$J,358.3,4864,1,4,0)
 ;;=4^E10.319
 ;;^UTILITY(U,$J,358.3,4864,2)
 ;;=^5002593
 ;;^UTILITY(U,$J,358.3,4865,0)
 ;;=E10.321^^24^305^38
 ;;^UTILITY(U,$J,358.3,4865,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4865,1,3,0)
 ;;=3^Diabetes Type 1 w/ Mild Nonprlf Diabetic Retinopathy w/ Macular Edema
 ;;^UTILITY(U,$J,358.3,4865,1,4,0)
 ;;=4^E10.321
 ;;^UTILITY(U,$J,358.3,4865,2)
 ;;=^5002594
 ;;^UTILITY(U,$J,358.3,4866,0)
 ;;=E10.329^^24^305^39
 ;;^UTILITY(U,$J,358.3,4866,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4866,1,3,0)
 ;;=3^Diabetes Type 1 w/ Mild Nonprlf Diabetic Retinopathy w/o Macular Edema
