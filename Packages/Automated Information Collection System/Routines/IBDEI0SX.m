IBDEI0SX ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,13302,2)
 ;;=^5002510
 ;;^UTILITY(U,$J,358.3,13303,0)
 ;;=E08.319^^80^758^34
 ;;^UTILITY(U,$J,358.3,13303,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13303,1,3,0)
 ;;=3^Diab d/t Undrl Cond w/ Diab Retinopathy w/o Macular Edema
 ;;^UTILITY(U,$J,358.3,13303,1,4,0)
 ;;=4^E08.319
 ;;^UTILITY(U,$J,358.3,13303,2)
 ;;=^5002511
 ;;^UTILITY(U,$J,358.3,13304,0)
 ;;=E08.321^^80^758^35
 ;;^UTILITY(U,$J,358.3,13304,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13304,1,3,0)
 ;;=3^Diab d/t Undrl Cond w/ Mild Nonprolif Diab Retinopathy w/ Macular Edema
 ;;^UTILITY(U,$J,358.3,13304,1,4,0)
 ;;=4^E08.321
 ;;^UTILITY(U,$J,358.3,13304,2)
 ;;=^5002512
 ;;^UTILITY(U,$J,358.3,13305,0)
 ;;=E08.329^^80^758^36
 ;;^UTILITY(U,$J,358.3,13305,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13305,1,3,0)
 ;;=3^Diab d/t Undrl Cond w/ Mild Nonprolif Diab Retinopathy w/o Macular Edema
 ;;^UTILITY(U,$J,358.3,13305,1,4,0)
 ;;=4^E08.329
 ;;^UTILITY(U,$J,358.3,13305,2)
 ;;=^5002513
 ;;^UTILITY(U,$J,358.3,13306,0)
 ;;=E08.331^^80^758^37
 ;;^UTILITY(U,$J,358.3,13306,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13306,1,3,0)
 ;;=3^Diab d/t Undrl Cond w/ Moderate Nonprolif Diab Retinopathy w/ Macular Edema
 ;;^UTILITY(U,$J,358.3,13306,1,4,0)
 ;;=4^E08.331
 ;;^UTILITY(U,$J,358.3,13306,2)
 ;;=^5002514
 ;;^UTILITY(U,$J,358.3,13307,0)
 ;;=E08.339^^80^758^38
 ;;^UTILITY(U,$J,358.3,13307,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13307,1,3,0)
 ;;=3^Diab d/t Undrl Cond w/ Moderate Nonprolif Diab Retinopathy w/o Macular Edema
 ;;^UTILITY(U,$J,358.3,13307,1,4,0)
 ;;=4^E08.339
 ;;^UTILITY(U,$J,358.3,13307,2)
 ;;=^5002515
 ;;^UTILITY(U,$J,358.3,13308,0)
 ;;=E08.341^^80^758^39
 ;;^UTILITY(U,$J,358.3,13308,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13308,1,3,0)
 ;;=3^Diab d/t Undrl Cond w/ Severe Nonprolif Diab Retinopathy w/ Macular Edema
 ;;^UTILITY(U,$J,358.3,13308,1,4,0)
 ;;=4^E08.341
 ;;^UTILITY(U,$J,358.3,13308,2)
 ;;=^5002516
 ;;^UTILITY(U,$J,358.3,13309,0)
 ;;=E08.349^^80^758^40
 ;;^UTILITY(U,$J,358.3,13309,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13309,1,3,0)
 ;;=3^Diab d/t Undrl Cond w/ Severe Nonprolif Diab Retinopathy w/o Macular Edema
 ;;^UTILITY(U,$J,358.3,13309,1,4,0)
 ;;=4^E08.349
 ;;^UTILITY(U,$J,358.3,13309,2)
 ;;=^5002517
 ;;^UTILITY(U,$J,358.3,13310,0)
 ;;=E09.311^^80^758^31
 ;;^UTILITY(U,$J,358.3,13310,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13310,1,3,0)
 ;;=3^Diab d/t Drug/Chem w/ Unspec Diab Retinopathy w/ Macular Edema
 ;;^UTILITY(U,$J,358.3,13310,1,4,0)
 ;;=4^E09.311
 ;;^UTILITY(U,$J,358.3,13310,2)
 ;;=^5002552
 ;;^UTILITY(U,$J,358.3,13311,0)
 ;;=E09.319^^80^758^32
 ;;^UTILITY(U,$J,358.3,13311,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13311,1,3,0)
 ;;=3^Diab d/t Drug/Chem w/ Unspec Diab Retinopathy w/o Macular Edema
 ;;^UTILITY(U,$J,358.3,13311,1,4,0)
 ;;=4^E09.319
 ;;^UTILITY(U,$J,358.3,13311,2)
 ;;=^5002553
 ;;^UTILITY(U,$J,358.3,13312,0)
 ;;=E09.321^^80^758^27
 ;;^UTILITY(U,$J,358.3,13312,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13312,1,3,0)
 ;;=3^Diab d/t Drug/Chem w/ Mild Nonprolif Diab Retinopathy w/ Macular Edema
 ;;^UTILITY(U,$J,358.3,13312,1,4,0)
 ;;=4^E09.321
 ;;^UTILITY(U,$J,358.3,13312,2)
 ;;=^5002554
 ;;^UTILITY(U,$J,358.3,13313,0)
 ;;=E09.329^^80^758^28
 ;;^UTILITY(U,$J,358.3,13313,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13313,1,3,0)
 ;;=3^Diab d/t Drug/Chem w/ Mild Nonprolif Diab Retinopathy w/o Macular Edema
 ;;^UTILITY(U,$J,358.3,13313,1,4,0)
 ;;=4^E09.329
 ;;^UTILITY(U,$J,358.3,13313,2)
 ;;=^5002555
 ;;^UTILITY(U,$J,358.3,13314,0)
 ;;=E09.351^^80^758^29
