IBDEI02R ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,528,0)
 ;;=E10.349^^6^69^31
 ;;^UTILITY(U,$J,358.3,528,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,528,1,3,0)
 ;;=3^Diabetes Type 1 w/ Severe Nonprlf Diabetic Rtnop w/o mMacular Edema
 ;;^UTILITY(U,$J,358.3,528,1,4,0)
 ;;=4^E10.349
 ;;^UTILITY(U,$J,358.3,528,2)
 ;;=^5002599
 ;;^UTILITY(U,$J,358.3,529,0)
 ;;=E10.351^^6^69^28
 ;;^UTILITY(U,$J,358.3,529,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,529,1,3,0)
 ;;=3^Diabetes Type 1 w/ Prolif Diabetic Rtnop w/ Macular Edema
 ;;^UTILITY(U,$J,358.3,529,1,4,0)
 ;;=4^E10.351
 ;;^UTILITY(U,$J,358.3,529,2)
 ;;=^5002600
 ;;^UTILITY(U,$J,358.3,530,0)
 ;;=E10.359^^6^69^29
 ;;^UTILITY(U,$J,358.3,530,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,530,1,3,0)
 ;;=3^Diabetes Type 1 w/ Prolif Diabetic Rtnop w/o Macular Edema
 ;;^UTILITY(U,$J,358.3,530,1,4,0)
 ;;=4^E10.359
 ;;^UTILITY(U,$J,358.3,530,2)
 ;;=^5002601
 ;;^UTILITY(U,$J,358.3,531,0)
 ;;=E10.36^^6^69^5
 ;;^UTILITY(U,$J,358.3,531,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,531,1,3,0)
 ;;=3^Diabetes Type 1 w/ Diabetic Cataract
 ;;^UTILITY(U,$J,358.3,531,1,4,0)
 ;;=4^E10.36
 ;;^UTILITY(U,$J,358.3,531,2)
 ;;=^5002602
 ;;^UTILITY(U,$J,358.3,532,0)
 ;;=E10.39^^6^69^14
 ;;^UTILITY(U,$J,358.3,532,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,532,1,3,0)
 ;;=3^Diabetes Type 1 w/ Diabetic Ophthalmic Complications
 ;;^UTILITY(U,$J,358.3,532,1,4,0)
 ;;=4^E10.39
 ;;^UTILITY(U,$J,358.3,532,2)
 ;;=^5002603
 ;;^UTILITY(U,$J,358.3,533,0)
 ;;=E10.40^^6^69^13
 ;;^UTILITY(U,$J,358.3,533,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,533,1,3,0)
 ;;=3^Diabetes Type 1 w/ Diabetic Neuropathy
 ;;^UTILITY(U,$J,358.3,533,1,4,0)
 ;;=4^E10.40
 ;;^UTILITY(U,$J,358.3,533,2)
 ;;=^5002604
 ;;^UTILITY(U,$J,358.3,534,0)
 ;;=E10.41^^6^69^9
 ;;^UTILITY(U,$J,358.3,534,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,534,1,3,0)
 ;;=3^Diabetes Type 1 w/ Diabetic Mononeuropathy
 ;;^UTILITY(U,$J,358.3,534,1,4,0)
 ;;=4^E10.41
 ;;^UTILITY(U,$J,358.3,534,2)
 ;;=^5002605
 ;;^UTILITY(U,$J,358.3,535,0)
 ;;=E10.42^^6^69^16
 ;;^UTILITY(U,$J,358.3,535,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,535,1,3,0)
 ;;=3^Diabetes Type 1 w/ Diabetic Polyneuropathy
 ;;^UTILITY(U,$J,358.3,535,1,4,0)
 ;;=4^E10.42
 ;;^UTILITY(U,$J,358.3,535,2)
 ;;=^5002606
 ;;^UTILITY(U,$J,358.3,536,0)
 ;;=E10.43^^6^69^4
 ;;^UTILITY(U,$J,358.3,536,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,536,1,3,0)
 ;;=3^Diabetes Type 1 w/ Diabetic Autonomic Polyneuropathy
 ;;^UTILITY(U,$J,358.3,536,1,4,0)
 ;;=4^E10.43
 ;;^UTILITY(U,$J,358.3,536,2)
 ;;=^5002607
 ;;^UTILITY(U,$J,358.3,537,0)
 ;;=E10.44^^6^69^2
 ;;^UTILITY(U,$J,358.3,537,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,537,1,3,0)
 ;;=3^Diabetes Type 1 w/ Diabetic Amyotrophy
 ;;^UTILITY(U,$J,358.3,537,1,4,0)
 ;;=4^E10.44
 ;;^UTILITY(U,$J,358.3,537,2)
 ;;=^5002608
 ;;^UTILITY(U,$J,358.3,538,0)
 ;;=E10.49^^6^69^11
 ;;^UTILITY(U,$J,358.3,538,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,538,1,3,0)
 ;;=3^Diabetes Type 1 w/ Diabetic Neurological Complication
 ;;^UTILITY(U,$J,358.3,538,1,4,0)
 ;;=4^E10.49
 ;;^UTILITY(U,$J,358.3,538,2)
 ;;=^5002609
 ;;^UTILITY(U,$J,358.3,539,0)
 ;;=E10.51^^6^69^15
 ;;^UTILITY(U,$J,358.3,539,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,539,1,3,0)
 ;;=3^Diabetes Type 1 w/ Diabetic Peripheral Angiopathy w/o Gangrene
 ;;^UTILITY(U,$J,358.3,539,1,4,0)
 ;;=4^E10.51
 ;;^UTILITY(U,$J,358.3,539,2)
 ;;=^5002610
 ;;^UTILITY(U,$J,358.3,540,0)
 ;;=E10.59^^6^69^1
 ;;^UTILITY(U,$J,358.3,540,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,540,1,3,0)
 ;;=3^Diabetes Type 1 w/ Circulatory Complications
 ;;^UTILITY(U,$J,358.3,540,1,4,0)
 ;;=4^E10.59
