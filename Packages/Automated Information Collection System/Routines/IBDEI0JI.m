IBDEI0JI ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,9064,1,3,0)
 ;;=3^Diab d/t Drug/Chem w/ Unspec Diab Retinopathy w/ Macular Edema
 ;;^UTILITY(U,$J,358.3,9064,1,4,0)
 ;;=4^E09.311
 ;;^UTILITY(U,$J,358.3,9064,2)
 ;;=^5002552
 ;;^UTILITY(U,$J,358.3,9065,0)
 ;;=E09.319^^41^473^38
 ;;^UTILITY(U,$J,358.3,9065,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9065,1,3,0)
 ;;=3^Diab d/t Drug/Chem w/ Unspec Diab Retinopathy w/o Macular Edema
 ;;^UTILITY(U,$J,358.3,9065,1,4,0)
 ;;=4^E09.319
 ;;^UTILITY(U,$J,358.3,9065,2)
 ;;=^5002553
 ;;^UTILITY(U,$J,358.3,9066,0)
 ;;=E09.321^^41^473^29
 ;;^UTILITY(U,$J,358.3,9066,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9066,1,3,0)
 ;;=3^Diab d/t Drug/Chem w/ Mild Nonprolif Diab Retinopathy w/ Macular Edema
 ;;^UTILITY(U,$J,358.3,9066,1,4,0)
 ;;=4^E09.321
 ;;^UTILITY(U,$J,358.3,9066,2)
 ;;=^5002554
 ;;^UTILITY(U,$J,358.3,9067,0)
 ;;=E09.329^^41^473^30
 ;;^UTILITY(U,$J,358.3,9067,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9067,1,3,0)
 ;;=3^Diab d/t Drug/Chem w/ Mild Nonprolif Diab Retinopathy w/o Macular Edema
 ;;^UTILITY(U,$J,358.3,9067,1,4,0)
 ;;=4^E09.329
 ;;^UTILITY(U,$J,358.3,9067,2)
 ;;=^5002555
 ;;^UTILITY(U,$J,358.3,9068,0)
 ;;=E09.351^^41^473^33
 ;;^UTILITY(U,$J,358.3,9068,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9068,1,3,0)
 ;;=3^Diab d/t Drug/Chem w/ Prolif Diab Retinopathy w/ Macular Edema
 ;;^UTILITY(U,$J,358.3,9068,1,4,0)
 ;;=4^E09.351
 ;;^UTILITY(U,$J,358.3,9068,2)
 ;;=^5002560
 ;;^UTILITY(U,$J,358.3,9069,0)
 ;;=E09.359^^41^473^34
 ;;^UTILITY(U,$J,358.3,9069,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9069,1,3,0)
 ;;=3^Diab d/t Drug/Chem w/ Prolif Diab Retinopathy w/o Macular Edema
 ;;^UTILITY(U,$J,358.3,9069,1,4,0)
 ;;=4^E09.359
 ;;^UTILITY(U,$J,358.3,9069,2)
 ;;=^5002561
 ;;^UTILITY(U,$J,358.3,9070,0)
 ;;=E08.351^^41^473^45
 ;;^UTILITY(U,$J,358.3,9070,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9070,1,3,0)
 ;;=3^Diab d/t Undrl Cond w/ Prolif Diab Rtnop w/ Macular Edema
 ;;^UTILITY(U,$J,358.3,9070,1,4,0)
 ;;=4^E08.351
 ;;^UTILITY(U,$J,358.3,9070,2)
 ;;=^5002518
 ;;^UTILITY(U,$J,358.3,9071,0)
 ;;=E08.359^^41^473^46
 ;;^UTILITY(U,$J,358.3,9071,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9071,1,3,0)
 ;;=3^Diab d/t Undrl Cond w/ Prolif Diab Rtnop w/o Macular Edema
 ;;^UTILITY(U,$J,358.3,9071,1,4,0)
 ;;=4^E08.359
 ;;^UTILITY(U,$J,358.3,9071,2)
 ;;=^5002519
 ;;^UTILITY(U,$J,358.3,9072,0)
 ;;=E13.351^^41^473^27
 ;;^UTILITY(U,$J,358.3,9072,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9072,1,3,0)
 ;;=3^DM w/ Prolif Diab Retinopathy w/ Macular Edema
 ;;^UTILITY(U,$J,358.3,9072,1,4,0)
 ;;=4^E13.351
 ;;^UTILITY(U,$J,358.3,9072,2)
 ;;=^5002680
 ;;^UTILITY(U,$J,358.3,9073,0)
 ;;=E13.359^^41^473^28
 ;;^UTILITY(U,$J,358.3,9073,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9073,1,3,0)
 ;;=3^DM w/ Prolif Diab Retinopathy w/o Macular Edema
 ;;^UTILITY(U,$J,358.3,9073,1,4,0)
 ;;=4^E13.359
 ;;^UTILITY(U,$J,358.3,9073,2)
 ;;=^5002681
 ;;^UTILITY(U,$J,358.3,9074,0)
 ;;=E09.331^^41^473^31
 ;;^UTILITY(U,$J,358.3,9074,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9074,1,3,0)
 ;;=3^Diab d/t Drug/Chem w/ Moderate Nonprolif Diab Retinopathy w/ Macular Edema
 ;;^UTILITY(U,$J,358.3,9074,1,4,0)
 ;;=4^E09.331
 ;;^UTILITY(U,$J,358.3,9074,2)
 ;;=^5002556
 ;;^UTILITY(U,$J,358.3,9075,0)
 ;;=E09.341^^41^473^35
 ;;^UTILITY(U,$J,358.3,9075,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9075,1,3,0)
 ;;=3^Diab d/t Drug/Chem w/ Severe Nonprolif Diab Retinopathy w/ Macula Edema
 ;;^UTILITY(U,$J,358.3,9075,1,4,0)
 ;;=4^E09.341
 ;;^UTILITY(U,$J,358.3,9075,2)
 ;;=^5002558
 ;;^UTILITY(U,$J,358.3,9076,0)
 ;;=E13.311^^41^473^49
