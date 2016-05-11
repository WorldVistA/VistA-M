IBDEI0AS ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,4829,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4829,1,3,0)
 ;;=3^Diabetes Type 1 w/ Mod Nonprlf Diab Retinopathy w/ Macular Edema
 ;;^UTILITY(U,$J,358.3,4829,1,4,0)
 ;;=4^E10.331
 ;;^UTILITY(U,$J,358.3,4829,2)
 ;;=^5002596
 ;;^UTILITY(U,$J,358.3,4830,0)
 ;;=E10.339^^24^305^41
 ;;^UTILITY(U,$J,358.3,4830,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4830,1,3,0)
 ;;=3^Diabetes Type 1 w/ Mod Nonprlf Diab Retinopathy w/o Macular Edema
 ;;^UTILITY(U,$J,358.3,4830,1,4,0)
 ;;=4^E10.339
 ;;^UTILITY(U,$J,358.3,4830,2)
 ;;=^5002597
 ;;^UTILITY(U,$J,358.3,4831,0)
 ;;=E11.319^^24^305^60
 ;;^UTILITY(U,$J,358.3,4831,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4831,1,3,0)
 ;;=3^Diabetes Type 2 w/ Diab Retinopathy w/o Macular Edema
 ;;^UTILITY(U,$J,358.3,4831,1,4,0)
 ;;=4^E11.319
 ;;^UTILITY(U,$J,358.3,4831,2)
 ;;=^5002633
 ;;^UTILITY(U,$J,358.3,4832,0)
 ;;=E11.311^^24^305^59
 ;;^UTILITY(U,$J,358.3,4832,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4832,1,3,0)
 ;;=3^Diabetes Type 2 w/ Diab Retinopathy w/ Macular Edema
 ;;^UTILITY(U,$J,358.3,4832,1,4,0)
 ;;=4^E11.311
 ;;^UTILITY(U,$J,358.3,4832,2)
 ;;=^5002632
 ;;^UTILITY(U,$J,358.3,4833,0)
 ;;=E10.311^^24^305^13
 ;;^UTILITY(U,$J,358.3,4833,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4833,1,3,0)
 ;;=3^Diabetes Type 1 w/ Diab Retinopathy w/ Macular Edema
 ;;^UTILITY(U,$J,358.3,4833,1,4,0)
 ;;=4^E10.311
 ;;^UTILITY(U,$J,358.3,4833,2)
 ;;=^5002592
 ;;^UTILITY(U,$J,358.3,4834,0)
 ;;=E10.319^^24^305^14
 ;;^UTILITY(U,$J,358.3,4834,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4834,1,3,0)
 ;;=3^Diabetes Type 1 w/ Diab Retinopathy w/o Macular Edema
 ;;^UTILITY(U,$J,358.3,4834,1,4,0)
 ;;=4^E10.319
 ;;^UTILITY(U,$J,358.3,4834,2)
 ;;=^5002593
 ;;^UTILITY(U,$J,358.3,4835,0)
 ;;=E10.351^^24^305^44
 ;;^UTILITY(U,$J,358.3,4835,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4835,1,3,0)
 ;;=3^Diabetes Type 1 w/ Prolif Diab Retinopathy w/ Macular Edema
 ;;^UTILITY(U,$J,358.3,4835,1,4,0)
 ;;=4^E10.351
 ;;^UTILITY(U,$J,358.3,4835,2)
 ;;=^5002600
 ;;^UTILITY(U,$J,358.3,4836,0)
 ;;=E10.359^^24^305^45
 ;;^UTILITY(U,$J,358.3,4836,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4836,1,3,0)
 ;;=3^Diabetes Type 1 w/ Prolif Diab Retinopathy w/o Macular Edema
 ;;^UTILITY(U,$J,358.3,4836,1,4,0)
 ;;=4^E10.359
 ;;^UTILITY(U,$J,358.3,4836,2)
 ;;=^5002601
 ;;^UTILITY(U,$J,358.3,4837,0)
 ;;=E10.40^^24^305^25
 ;;^UTILITY(U,$J,358.3,4837,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4837,1,3,0)
 ;;=3^Diabetes Type 1 w/ Diabetic Neuropathy,Unspec
 ;;^UTILITY(U,$J,358.3,4837,1,4,0)
 ;;=4^E10.40
 ;;^UTILITY(U,$J,358.3,4837,2)
 ;;=^5002604
 ;;^UTILITY(U,$J,358.3,4838,0)
 ;;=E10.41^^24^305^21
 ;;^UTILITY(U,$J,358.3,4838,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4838,1,3,0)
 ;;=3^Diabetes Type 1 w/ Diabetic Mononeuropathy
 ;;^UTILITY(U,$J,358.3,4838,1,4,0)
 ;;=4^E10.41
 ;;^UTILITY(U,$J,358.3,4838,2)
 ;;=^5002605
 ;;^UTILITY(U,$J,358.3,4839,0)
 ;;=E10.42^^24^305^29
 ;;^UTILITY(U,$J,358.3,4839,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4839,1,3,0)
 ;;=3^Diabetes Type 1 w/ Diabetic Polyneuropathy
 ;;^UTILITY(U,$J,358.3,4839,1,4,0)
 ;;=4^E10.42
 ;;^UTILITY(U,$J,358.3,4839,2)
 ;;=^5002606
 ;;^UTILITY(U,$J,358.3,4840,0)
 ;;=E10.43^^24^305^17
 ;;^UTILITY(U,$J,358.3,4840,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4840,1,3,0)
 ;;=3^Diabetes Type 1 w/ Diabetic Autonomic Polyneuropathy
 ;;^UTILITY(U,$J,358.3,4840,1,4,0)
 ;;=4^E10.43
 ;;^UTILITY(U,$J,358.3,4840,2)
 ;;=^5002607
 ;;^UTILITY(U,$J,358.3,4841,0)
 ;;=E10.44^^24^305^15
 ;;^UTILITY(U,$J,358.3,4841,1,0)
 ;;=^358.31IA^4^2
