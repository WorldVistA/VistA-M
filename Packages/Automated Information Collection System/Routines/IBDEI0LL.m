IBDEI0LL ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,10070,1,4,0)
 ;;=4^E11.319
 ;;^UTILITY(U,$J,358.3,10070,2)
 ;;=^5002633
 ;;^UTILITY(U,$J,358.3,10071,0)
 ;;=E11.311^^44^500^25
 ;;^UTILITY(U,$J,358.3,10071,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10071,1,3,0)
 ;;=3^DM Type 2 w/ Unspec Diab Retinopathy w/ Macular Edema
 ;;^UTILITY(U,$J,358.3,10071,1,4,0)
 ;;=4^E11.311
 ;;^UTILITY(U,$J,358.3,10071,2)
 ;;=^5002632
 ;;^UTILITY(U,$J,358.3,10072,0)
 ;;=E10.9^^44^500^13
 ;;^UTILITY(U,$J,358.3,10072,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10072,1,3,0)
 ;;=3^DM Type 1 w/o Complications
 ;;^UTILITY(U,$J,358.3,10072,1,4,0)
 ;;=4^E10.9
 ;;^UTILITY(U,$J,358.3,10072,2)
 ;;=^5002626
 ;;^UTILITY(U,$J,358.3,10073,0)
 ;;=E10.311^^44^500^11
 ;;^UTILITY(U,$J,358.3,10073,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10073,1,3,0)
 ;;=3^DM Type 1 w/ Unspec Diab Retinopathy w/ Macular Edema
 ;;^UTILITY(U,$J,358.3,10073,1,4,0)
 ;;=4^E10.311
 ;;^UTILITY(U,$J,358.3,10073,2)
 ;;=^5002592
 ;;^UTILITY(U,$J,358.3,10074,0)
 ;;=E10.319^^44^500^12
 ;;^UTILITY(U,$J,358.3,10074,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10074,1,3,0)
 ;;=3^DM Type 1 w/ Unspec Diab Retinopathy w/o Macular Edema
 ;;^UTILITY(U,$J,358.3,10074,1,4,0)
 ;;=4^E10.319
 ;;^UTILITY(U,$J,358.3,10074,2)
 ;;=^5002593
 ;;^UTILITY(U,$J,358.3,10075,0)
 ;;=E10.36^^44^500^1
 ;;^UTILITY(U,$J,358.3,10075,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10075,1,3,0)
 ;;=3^DM Type 1 w/ Diabetic Cataract
 ;;^UTILITY(U,$J,358.3,10075,1,4,0)
 ;;=4^E10.36
 ;;^UTILITY(U,$J,358.3,10075,2)
 ;;=^5002602
 ;;^UTILITY(U,$J,358.3,10076,0)
 ;;=E10.39^^44^500^2
 ;;^UTILITY(U,$J,358.3,10076,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10076,1,3,0)
 ;;=3^DM Type 1 w/ Diabetic Ophthalmic Complication
 ;;^UTILITY(U,$J,358.3,10076,1,4,0)
 ;;=4^E10.39
 ;;^UTILITY(U,$J,358.3,10076,2)
 ;;=^5002603
 ;;^UTILITY(U,$J,358.3,10077,0)
 ;;=E10.321^^44^500^3
 ;;^UTILITY(U,$J,358.3,10077,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10077,1,3,0)
 ;;=3^DM Type 1 w/ Mild Nonprolif Diab Retinopathy w/ Macular Edema
 ;;^UTILITY(U,$J,358.3,10077,1,4,0)
 ;;=4^E10.321
 ;;^UTILITY(U,$J,358.3,10077,2)
 ;;=^5002594
 ;;^UTILITY(U,$J,358.3,10078,0)
 ;;=E10.329^^44^500^4
 ;;^UTILITY(U,$J,358.3,10078,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10078,1,3,0)
 ;;=3^DM Type 1 w/ Mild Nonprolif Diab Retinopathy w/o Macular Edema
 ;;^UTILITY(U,$J,358.3,10078,1,4,0)
 ;;=4^E10.329
 ;;^UTILITY(U,$J,358.3,10078,2)
 ;;=^5002595
 ;;^UTILITY(U,$J,358.3,10079,0)
 ;;=E10.331^^44^500^5
 ;;^UTILITY(U,$J,358.3,10079,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10079,1,3,0)
 ;;=3^DM Type 1 w/ Moderate Nonprolif Diab Retinopathy w/ Macular Edema
 ;;^UTILITY(U,$J,358.3,10079,1,4,0)
 ;;=4^E10.331
 ;;^UTILITY(U,$J,358.3,10079,2)
 ;;=^5002596
 ;;^UTILITY(U,$J,358.3,10080,0)
 ;;=E10.339^^44^500^6
 ;;^UTILITY(U,$J,358.3,10080,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10080,1,3,0)
 ;;=3^DM Type 1 w/ Moderate Nonprolif Diab Retinopathy w/o Macular Edema
 ;;^UTILITY(U,$J,358.3,10080,1,4,0)
 ;;=4^E10.339
 ;;^UTILITY(U,$J,358.3,10080,2)
 ;;=^5002597
 ;;^UTILITY(U,$J,358.3,10081,0)
 ;;=E10.341^^44^500^9
 ;;^UTILITY(U,$J,358.3,10081,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10081,1,3,0)
 ;;=3^DM Type 1 w/ Severe Nonprolif Diab Retinopathy w/ Macular Edema
 ;;^UTILITY(U,$J,358.3,10081,1,4,0)
 ;;=4^E10.341
 ;;^UTILITY(U,$J,358.3,10081,2)
 ;;=^5002598
 ;;^UTILITY(U,$J,358.3,10082,0)
 ;;=E10.349^^44^500^10
 ;;^UTILITY(U,$J,358.3,10082,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10082,1,3,0)
 ;;=3^DM Type 1 w/ Severe Nonprolif Diab Retinopathy w/o Macular Edema
