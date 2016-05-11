IBDEI0LN ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,10094,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10094,1,3,0)
 ;;=3^Diab d/t Drug/Chem w/ Unspec Diab Retinopathy w/o Macular Edema
 ;;^UTILITY(U,$J,358.3,10094,1,4,0)
 ;;=4^E09.319
 ;;^UTILITY(U,$J,358.3,10094,2)
 ;;=^5002553
 ;;^UTILITY(U,$J,358.3,10095,0)
 ;;=E09.321^^44^500^29
 ;;^UTILITY(U,$J,358.3,10095,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10095,1,3,0)
 ;;=3^Diab d/t Drug/Chem w/ Mild Nonprolif Diab Retinopathy w/ Macular Edema
 ;;^UTILITY(U,$J,358.3,10095,1,4,0)
 ;;=4^E09.321
 ;;^UTILITY(U,$J,358.3,10095,2)
 ;;=^5002554
 ;;^UTILITY(U,$J,358.3,10096,0)
 ;;=E09.329^^44^500^30
 ;;^UTILITY(U,$J,358.3,10096,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10096,1,3,0)
 ;;=3^Diab d/t Drug/Chem w/ Mild Nonprolif Diab Retinopathy w/o Macular Edema
 ;;^UTILITY(U,$J,358.3,10096,1,4,0)
 ;;=4^E09.329
 ;;^UTILITY(U,$J,358.3,10096,2)
 ;;=^5002555
 ;;^UTILITY(U,$J,358.3,10097,0)
 ;;=E09.351^^44^500^33
 ;;^UTILITY(U,$J,358.3,10097,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10097,1,3,0)
 ;;=3^Diab d/t Drug/Chem w/ Prolif Diab Retinopathy w/ Macular Edema
 ;;^UTILITY(U,$J,358.3,10097,1,4,0)
 ;;=4^E09.351
 ;;^UTILITY(U,$J,358.3,10097,2)
 ;;=^5002560
 ;;^UTILITY(U,$J,358.3,10098,0)
 ;;=E09.359^^44^500^34
 ;;^UTILITY(U,$J,358.3,10098,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10098,1,3,0)
 ;;=3^Diab d/t Drug/Chem w/ Prolif Diab Retinopathy w/o Macular Edema
 ;;^UTILITY(U,$J,358.3,10098,1,4,0)
 ;;=4^E09.359
 ;;^UTILITY(U,$J,358.3,10098,2)
 ;;=^5002561
 ;;^UTILITY(U,$J,358.3,10099,0)
 ;;=E08.351^^44^500^45
 ;;^UTILITY(U,$J,358.3,10099,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10099,1,3,0)
 ;;=3^Diab d/t Undrl Cond w/ Prolif Diab Rtnop w/ Macular Edema
 ;;^UTILITY(U,$J,358.3,10099,1,4,0)
 ;;=4^E08.351
 ;;^UTILITY(U,$J,358.3,10099,2)
 ;;=^5002518
 ;;^UTILITY(U,$J,358.3,10100,0)
 ;;=E08.359^^44^500^46
 ;;^UTILITY(U,$J,358.3,10100,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10100,1,3,0)
 ;;=3^Diab d/t Undrl Cond w/ Prolif Diab Rtnop w/o Macular Edema
 ;;^UTILITY(U,$J,358.3,10100,1,4,0)
 ;;=4^E08.359
 ;;^UTILITY(U,$J,358.3,10100,2)
 ;;=^5002519
 ;;^UTILITY(U,$J,358.3,10101,0)
 ;;=E13.351^^44^500^27
 ;;^UTILITY(U,$J,358.3,10101,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10101,1,3,0)
 ;;=3^DM w/ Prolif Diab Retinopathy w/ Macular Edema
 ;;^UTILITY(U,$J,358.3,10101,1,4,0)
 ;;=4^E13.351
 ;;^UTILITY(U,$J,358.3,10101,2)
 ;;=^5002680
 ;;^UTILITY(U,$J,358.3,10102,0)
 ;;=E13.359^^44^500^28
 ;;^UTILITY(U,$J,358.3,10102,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10102,1,3,0)
 ;;=3^DM w/ Prolif Diab Retinopathy w/o Macular Edema
 ;;^UTILITY(U,$J,358.3,10102,1,4,0)
 ;;=4^E13.359
 ;;^UTILITY(U,$J,358.3,10102,2)
 ;;=^5002681
 ;;^UTILITY(U,$J,358.3,10103,0)
 ;;=E09.331^^44^500^31
 ;;^UTILITY(U,$J,358.3,10103,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10103,1,3,0)
 ;;=3^Diab d/t Drug/Chem w/ Moderate Nonprolif Diab Retinopathy w/ Macular Edema
 ;;^UTILITY(U,$J,358.3,10103,1,4,0)
 ;;=4^E09.331
 ;;^UTILITY(U,$J,358.3,10103,2)
 ;;=^5002556
 ;;^UTILITY(U,$J,358.3,10104,0)
 ;;=E09.341^^44^500^35
 ;;^UTILITY(U,$J,358.3,10104,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10104,1,3,0)
 ;;=3^Diab d/t Drug/Chem w/ Severe Nonprolif Diab Retinopathy w/ Macula Edema
 ;;^UTILITY(U,$J,358.3,10104,1,4,0)
 ;;=4^E09.341
 ;;^UTILITY(U,$J,358.3,10104,2)
 ;;=^5002558
 ;;^UTILITY(U,$J,358.3,10105,0)
 ;;=E13.311^^44^500^49
 ;;^UTILITY(U,$J,358.3,10105,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10105,1,3,0)
 ;;=3^Diab w/ Unspec Diabetic Retinopathy w/ Macular Edema
 ;;^UTILITY(U,$J,358.3,10105,1,4,0)
 ;;=4^E13.311
