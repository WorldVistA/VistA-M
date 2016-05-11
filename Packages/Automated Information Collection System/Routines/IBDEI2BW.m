IBDEI2BW ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,39488,2)
 ;;=^5002600
 ;;^UTILITY(U,$J,358.3,39489,0)
 ;;=E10.359^^153^1925^8
 ;;^UTILITY(U,$J,358.3,39489,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39489,1,3,0)
 ;;=3^DM Type 1 w/ Prolif Diab Retinopathy w/o Macular Edema
 ;;^UTILITY(U,$J,358.3,39489,1,4,0)
 ;;=4^E10.359
 ;;^UTILITY(U,$J,358.3,39489,2)
 ;;=^5002601
 ;;^UTILITY(U,$J,358.3,39490,0)
 ;;=E08.311^^153^1925^39
 ;;^UTILITY(U,$J,358.3,39490,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39490,1,3,0)
 ;;=3^Diab d/t Undrl Cond w/ Diab Retinopathy w/ Macular Edema
 ;;^UTILITY(U,$J,358.3,39490,1,4,0)
 ;;=4^E08.311
 ;;^UTILITY(U,$J,358.3,39490,2)
 ;;=^5002510
 ;;^UTILITY(U,$J,358.3,39491,0)
 ;;=E08.319^^153^1925^40
 ;;^UTILITY(U,$J,358.3,39491,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39491,1,3,0)
 ;;=3^Diab d/t Undrl Cond w/ Diab Retinopathy w/o Macular Edema
 ;;^UTILITY(U,$J,358.3,39491,1,4,0)
 ;;=4^E08.319
 ;;^UTILITY(U,$J,358.3,39491,2)
 ;;=^5002511
 ;;^UTILITY(U,$J,358.3,39492,0)
 ;;=E08.321^^153^1925^41
 ;;^UTILITY(U,$J,358.3,39492,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39492,1,3,0)
 ;;=3^Diab d/t Undrl Cond w/ Mild Nonprolif Diab Retinopathy w/ Macular Edema
 ;;^UTILITY(U,$J,358.3,39492,1,4,0)
 ;;=4^E08.321
 ;;^UTILITY(U,$J,358.3,39492,2)
 ;;=^5002512
 ;;^UTILITY(U,$J,358.3,39493,0)
 ;;=E08.329^^153^1925^42
 ;;^UTILITY(U,$J,358.3,39493,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39493,1,3,0)
 ;;=3^Diab d/t Undrl Cond w/ Mild Nonprolif Diab Retinopathy w/o Macular Edema
 ;;^UTILITY(U,$J,358.3,39493,1,4,0)
 ;;=4^E08.329
 ;;^UTILITY(U,$J,358.3,39493,2)
 ;;=^5002513
 ;;^UTILITY(U,$J,358.3,39494,0)
 ;;=E08.331^^153^1925^43
 ;;^UTILITY(U,$J,358.3,39494,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39494,1,3,0)
 ;;=3^Diab d/t Undrl Cond w/ Moderate Nonprolif Diab Retinopathy w/ Macular Edema
 ;;^UTILITY(U,$J,358.3,39494,1,4,0)
 ;;=4^E08.331
 ;;^UTILITY(U,$J,358.3,39494,2)
 ;;=^5002514
 ;;^UTILITY(U,$J,358.3,39495,0)
 ;;=E08.339^^153^1925^44
 ;;^UTILITY(U,$J,358.3,39495,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39495,1,3,0)
 ;;=3^Diab d/t Undrl Cond w/ Moderate Nonprolif Diab Retinopathy w/o Macular Edema
 ;;^UTILITY(U,$J,358.3,39495,1,4,0)
 ;;=4^E08.339
 ;;^UTILITY(U,$J,358.3,39495,2)
 ;;=^5002515
 ;;^UTILITY(U,$J,358.3,39496,0)
 ;;=E08.341^^153^1925^47
 ;;^UTILITY(U,$J,358.3,39496,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39496,1,3,0)
 ;;=3^Diab d/t Undrl Cond w/ Severe Nonprolif Diab Retinopathy w/ Macular Edema
 ;;^UTILITY(U,$J,358.3,39496,1,4,0)
 ;;=4^E08.341
 ;;^UTILITY(U,$J,358.3,39496,2)
 ;;=^5002516
 ;;^UTILITY(U,$J,358.3,39497,0)
 ;;=E08.349^^153^1925^48
 ;;^UTILITY(U,$J,358.3,39497,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39497,1,3,0)
 ;;=3^Diab d/t Undrl Cond w/ Severe Nonprolif Diab Retinopathy w/o Macular Edema
 ;;^UTILITY(U,$J,358.3,39497,1,4,0)
 ;;=4^E08.349
 ;;^UTILITY(U,$J,358.3,39497,2)
 ;;=^5002517
 ;;^UTILITY(U,$J,358.3,39498,0)
 ;;=E09.311^^153^1925^37
 ;;^UTILITY(U,$J,358.3,39498,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39498,1,3,0)
 ;;=3^Diab d/t Drug/Chem w/ Unspec Diab Retinopathy w/ Macular Edema
 ;;^UTILITY(U,$J,358.3,39498,1,4,0)
 ;;=4^E09.311
 ;;^UTILITY(U,$J,358.3,39498,2)
 ;;=^5002552
 ;;^UTILITY(U,$J,358.3,39499,0)
 ;;=E09.319^^153^1925^38
 ;;^UTILITY(U,$J,358.3,39499,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39499,1,3,0)
 ;;=3^Diab d/t Drug/Chem w/ Unspec Diab Retinopathy w/o Macular Edema
 ;;^UTILITY(U,$J,358.3,39499,1,4,0)
 ;;=4^E09.319
 ;;^UTILITY(U,$J,358.3,39499,2)
 ;;=^5002553
 ;;^UTILITY(U,$J,358.3,39500,0)
 ;;=E09.321^^153^1925^29
