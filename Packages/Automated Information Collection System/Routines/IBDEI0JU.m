IBDEI0JU ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8943,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8943,1,3,0)
 ;;=3^Diabetes due to underlying condition w diabetic nephropathy
 ;;^UTILITY(U,$J,358.3,8943,1,4,0)
 ;;=4^E08.21
 ;;^UTILITY(U,$J,358.3,8943,2)
 ;;=^5002507
 ;;^UTILITY(U,$J,358.3,8944,0)
 ;;=E09.21^^55^555^34
 ;;^UTILITY(U,$J,358.3,8944,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8944,1,3,0)
 ;;=3^Drug/chem diabetes w diabetic nephropathy
 ;;^UTILITY(U,$J,358.3,8944,1,4,0)
 ;;=4^E09.21
 ;;^UTILITY(U,$J,358.3,8944,2)
 ;;=^5002549
 ;;^UTILITY(U,$J,358.3,8945,0)
 ;;=E08.311^^55^555^7
 ;;^UTILITY(U,$J,358.3,8945,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8945,1,3,0)
 ;;=3^Diabetes due to underlying condition w unsp diabetic rtnop w macular edema
 ;;^UTILITY(U,$J,358.3,8945,1,4,0)
 ;;=4^E08.311
 ;;^UTILITY(U,$J,358.3,8945,2)
 ;;=^5002510
 ;;^UTILITY(U,$J,358.3,8946,0)
 ;;=E08.319^^55^555^8
 ;;^UTILITY(U,$J,358.3,8946,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8946,1,3,0)
 ;;=3^Diabetes due to underlying condition w unsp diab rtnop w/o macular edema
 ;;^UTILITY(U,$J,358.3,8946,1,4,0)
 ;;=4^E08.319
 ;;^UTILITY(U,$J,358.3,8946,2)
 ;;=^5002511
 ;;^UTILITY(U,$J,358.3,8947,0)
 ;;=E08.36^^55^555^9
 ;;^UTILITY(U,$J,358.3,8947,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8947,1,3,0)
 ;;=3^Diabetes due to underlying condition w diabetic cataract
 ;;^UTILITY(U,$J,358.3,8947,1,4,0)
 ;;=4^E08.36
 ;;^UTILITY(U,$J,358.3,8947,2)
 ;;=^5002520
 ;;^UTILITY(U,$J,358.3,8948,0)
 ;;=E08.39^^55^555^10
 ;;^UTILITY(U,$J,358.3,8948,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8948,1,3,0)
 ;;=3^Diabetes due to underlying condition w oth diabetic opth comp
 ;;^UTILITY(U,$J,358.3,8948,1,4,0)
 ;;=4^E08.39
 ;;^UTILITY(U,$J,358.3,8948,2)
 ;;=^5002521
 ;;^UTILITY(U,$J,358.3,8949,0)
 ;;=E09.311^^55^555^56
 ;;^UTILITY(U,$J,358.3,8949,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8949,1,3,0)
 ;;=3^Drug/chem diabetes w unsp diabetic rtnop w macular edema
 ;;^UTILITY(U,$J,358.3,8949,1,4,0)
 ;;=4^E09.311
 ;;^UTILITY(U,$J,358.3,8949,2)
 ;;=^5002552
 ;;^UTILITY(U,$J,358.3,8950,0)
 ;;=E09.319^^55^555^57
 ;;^UTILITY(U,$J,358.3,8950,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8950,1,3,0)
 ;;=3^Drug/chem diabetes w unsp diabetic rtnop w/o macular edema
 ;;^UTILITY(U,$J,358.3,8950,1,4,0)
 ;;=4^E09.319
 ;;^UTILITY(U,$J,358.3,8950,2)
 ;;=^5002553
 ;;^UTILITY(U,$J,358.3,8951,0)
 ;;=E09.36^^55^555^32
 ;;^UTILITY(U,$J,358.3,8951,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8951,1,3,0)
 ;;=3^Drug/chem diabetes w diabetic cataract
 ;;^UTILITY(U,$J,358.3,8951,1,4,0)
 ;;=4^E09.36
 ;;^UTILITY(U,$J,358.3,8951,2)
 ;;=^5002562
 ;;^UTILITY(U,$J,358.3,8952,0)
 ;;=E09.39^^55^555^51
 ;;^UTILITY(U,$J,358.3,8952,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8952,1,3,0)
 ;;=3^Drug/chem diabetes w oth diabetic ophthalmic complication
 ;;^UTILITY(U,$J,358.3,8952,1,4,0)
 ;;=4^E09.39
 ;;^UTILITY(U,$J,358.3,8952,2)
 ;;=^5002563
 ;;^UTILITY(U,$J,358.3,8953,0)
 ;;=E08.40^^55^555^11
 ;;^UTILITY(U,$J,358.3,8953,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8953,1,3,0)
 ;;=3^Diabetes due to underlying condition w diabetic neurop, unsp
 ;;^UTILITY(U,$J,358.3,8953,1,4,0)
 ;;=4^E08.40
 ;;^UTILITY(U,$J,358.3,8953,2)
 ;;=^5002522
 ;;^UTILITY(U,$J,358.3,8954,0)
 ;;=E08.41^^55^555^12
 ;;^UTILITY(U,$J,358.3,8954,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8954,1,3,0)
 ;;=3^Diabetes due to underlying condition w diabetic mononeuropathy
 ;;^UTILITY(U,$J,358.3,8954,1,4,0)
 ;;=4^E08.41
 ;;^UTILITY(U,$J,358.3,8954,2)
 ;;=^5002523
 ;;^UTILITY(U,$J,358.3,8955,0)
 ;;=E08.42^^55^555^13
 ;;^UTILITY(U,$J,358.3,8955,1,0)
 ;;=^358.31IA^4^2
