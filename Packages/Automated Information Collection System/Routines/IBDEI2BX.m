IBDEI2BX ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,39500,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39500,1,3,0)
 ;;=3^Diab d/t Drug/Chem w/ Mild Nonprolif Diab Retinopathy w/ Macular Edema
 ;;^UTILITY(U,$J,358.3,39500,1,4,0)
 ;;=4^E09.321
 ;;^UTILITY(U,$J,358.3,39500,2)
 ;;=^5002554
 ;;^UTILITY(U,$J,358.3,39501,0)
 ;;=E09.329^^153^1925^30
 ;;^UTILITY(U,$J,358.3,39501,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39501,1,3,0)
 ;;=3^Diab d/t Drug/Chem w/ Mild Nonprolif Diab Retinopathy w/o Macular Edema
 ;;^UTILITY(U,$J,358.3,39501,1,4,0)
 ;;=4^E09.329
 ;;^UTILITY(U,$J,358.3,39501,2)
 ;;=^5002555
 ;;^UTILITY(U,$J,358.3,39502,0)
 ;;=E09.351^^153^1925^33
 ;;^UTILITY(U,$J,358.3,39502,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39502,1,3,0)
 ;;=3^Diab d/t Drug/Chem w/ Prolif Diab Retinopathy w/ Macular Edema
 ;;^UTILITY(U,$J,358.3,39502,1,4,0)
 ;;=4^E09.351
 ;;^UTILITY(U,$J,358.3,39502,2)
 ;;=^5002560
 ;;^UTILITY(U,$J,358.3,39503,0)
 ;;=E09.359^^153^1925^34
 ;;^UTILITY(U,$J,358.3,39503,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39503,1,3,0)
 ;;=3^Diab d/t Drug/Chem w/ Prolif Diab Retinopathy w/o Macular Edema
 ;;^UTILITY(U,$J,358.3,39503,1,4,0)
 ;;=4^E09.359
 ;;^UTILITY(U,$J,358.3,39503,2)
 ;;=^5002561
 ;;^UTILITY(U,$J,358.3,39504,0)
 ;;=E08.351^^153^1925^45
 ;;^UTILITY(U,$J,358.3,39504,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39504,1,3,0)
 ;;=3^Diab d/t Undrl Cond w/ Prolif Diab Rtnop w/ Macular Edema
 ;;^UTILITY(U,$J,358.3,39504,1,4,0)
 ;;=4^E08.351
 ;;^UTILITY(U,$J,358.3,39504,2)
 ;;=^5002518
 ;;^UTILITY(U,$J,358.3,39505,0)
 ;;=E08.359^^153^1925^46
 ;;^UTILITY(U,$J,358.3,39505,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39505,1,3,0)
 ;;=3^Diab d/t Undrl Cond w/ Prolif Diab Rtnop w/o Macular Edema
 ;;^UTILITY(U,$J,358.3,39505,1,4,0)
 ;;=4^E08.359
 ;;^UTILITY(U,$J,358.3,39505,2)
 ;;=^5002519
 ;;^UTILITY(U,$J,358.3,39506,0)
 ;;=E13.351^^153^1925^27
 ;;^UTILITY(U,$J,358.3,39506,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39506,1,3,0)
 ;;=3^DM w/ Prolif Diab Retinopathy w/ Macular Edema
 ;;^UTILITY(U,$J,358.3,39506,1,4,0)
 ;;=4^E13.351
 ;;^UTILITY(U,$J,358.3,39506,2)
 ;;=^5002680
 ;;^UTILITY(U,$J,358.3,39507,0)
 ;;=E13.359^^153^1925^28
 ;;^UTILITY(U,$J,358.3,39507,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39507,1,3,0)
 ;;=3^DM w/ Prolif Diab Retinopathy w/o Macular Edema
 ;;^UTILITY(U,$J,358.3,39507,1,4,0)
 ;;=4^E13.359
 ;;^UTILITY(U,$J,358.3,39507,2)
 ;;=^5002681
 ;;^UTILITY(U,$J,358.3,39508,0)
 ;;=E09.331^^153^1925^31
 ;;^UTILITY(U,$J,358.3,39508,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39508,1,3,0)
 ;;=3^Diab d/t Drug/Chem w/ Moderate Nonprolif Diab Retinopathy w/ Macular Edema
 ;;^UTILITY(U,$J,358.3,39508,1,4,0)
 ;;=4^E09.331
 ;;^UTILITY(U,$J,358.3,39508,2)
 ;;=^5002556
 ;;^UTILITY(U,$J,358.3,39509,0)
 ;;=E09.341^^153^1925^35
 ;;^UTILITY(U,$J,358.3,39509,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39509,1,3,0)
 ;;=3^Diab d/t Drug/Chem w/ Severe Nonprolif Diab Retinopathy w/ Macula Edema
 ;;^UTILITY(U,$J,358.3,39509,1,4,0)
 ;;=4^E09.341
 ;;^UTILITY(U,$J,358.3,39509,2)
 ;;=^5002558
 ;;^UTILITY(U,$J,358.3,39510,0)
 ;;=E13.311^^153^1925^49
 ;;^UTILITY(U,$J,358.3,39510,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39510,1,3,0)
 ;;=3^Diab w/ Unspec Diabetic Retinopathy w/ Macular Edema
 ;;^UTILITY(U,$J,358.3,39510,1,4,0)
 ;;=4^E13.311
 ;;^UTILITY(U,$J,358.3,39510,2)
 ;;=^5002673
 ;;^UTILITY(U,$J,358.3,39511,0)
 ;;=E09.339^^153^1925^32
 ;;^UTILITY(U,$J,358.3,39511,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39511,1,3,0)
 ;;=3^Diab d/t Drug/Chem w/ Moderate Nonprolif Diab Retinopathy w/o Macular Edema
