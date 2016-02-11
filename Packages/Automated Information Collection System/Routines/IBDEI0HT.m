IBDEI0HT ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,7980,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7980,1,3,0)
 ;;=3^Rash and other nonspecific skin eruption
 ;;^UTILITY(U,$J,358.3,7980,1,4,0)
 ;;=4^R21.
 ;;^UTILITY(U,$J,358.3,7980,2)
 ;;=^5019283
 ;;^UTILITY(U,$J,358.3,7981,0)
 ;;=R23.3^^55^531^141
 ;;^UTILITY(U,$J,358.3,7981,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7981,1,3,0)
 ;;=3^Spontaneous ecchymoses
 ;;^UTILITY(U,$J,358.3,7981,1,4,0)
 ;;=4^R23.3
 ;;^UTILITY(U,$J,358.3,7981,2)
 ;;=^5019295
 ;;^UTILITY(U,$J,358.3,7982,0)
 ;;=I96.^^55^531^44
 ;;^UTILITY(U,$J,358.3,7982,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7982,1,3,0)
 ;;=3^Gangrene, not elsewhere classified
 ;;^UTILITY(U,$J,358.3,7982,1,4,0)
 ;;=4^I96.
 ;;^UTILITY(U,$J,358.3,7982,2)
 ;;=^5008081
 ;;^UTILITY(U,$J,358.3,7983,0)
 ;;=E11.21^^55^532^13
 ;;^UTILITY(U,$J,358.3,7983,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7983,1,3,0)
 ;;=3^Type 2 diab w diabetic nephropathy
 ;;^UTILITY(U,$J,358.3,7983,1,4,0)
 ;;=4^E11.21
 ;;^UTILITY(U,$J,358.3,7983,2)
 ;;=^5002629
 ;;^UTILITY(U,$J,358.3,7984,0)
 ;;=E10.21^^55^532^1
 ;;^UTILITY(U,$J,358.3,7984,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7984,1,3,0)
 ;;=3^Type 1 diab w diabetic nephropathy
 ;;^UTILITY(U,$J,358.3,7984,1,4,0)
 ;;=4^E10.21
 ;;^UTILITY(U,$J,358.3,7984,2)
 ;;=^5002589
 ;;^UTILITY(U,$J,358.3,7985,0)
 ;;=E11.321^^55^532^19
 ;;^UTILITY(U,$J,358.3,7985,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7985,1,3,0)
 ;;=3^Type 2 diab w mild nonprlf diabetic rtnop w macular edema
 ;;^UTILITY(U,$J,358.3,7985,1,4,0)
 ;;=4^E11.321
 ;;^UTILITY(U,$J,358.3,7985,2)
 ;;=^5002634
 ;;^UTILITY(U,$J,358.3,7986,0)
 ;;=E11.329^^55^532^20
 ;;^UTILITY(U,$J,358.3,7986,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7986,1,3,0)
 ;;=3^Type 2 diab w mild nonprlf diabetic rtnop w/o macular edema
 ;;^UTILITY(U,$J,358.3,7986,1,4,0)
 ;;=4^E11.329
 ;;^UTILITY(U,$J,358.3,7986,2)
 ;;=^5002635
 ;;^UTILITY(U,$J,358.3,7987,0)
 ;;=E11.331^^55^532^21
 ;;^UTILITY(U,$J,358.3,7987,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7987,1,3,0)
 ;;=3^Type 2 diab w moderate nonprlf diab rtnop w macular edema
 ;;^UTILITY(U,$J,358.3,7987,1,4,0)
 ;;=4^E11.331
 ;;^UTILITY(U,$J,358.3,7987,2)
 ;;=^5002636
 ;;^UTILITY(U,$J,358.3,7988,0)
 ;;=E11.339^^55^532^22
 ;;^UTILITY(U,$J,358.3,7988,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7988,1,3,0)
 ;;=3^Type 2 diab w moderate nonprlf diab rtnop w/o macular edema
 ;;^UTILITY(U,$J,358.3,7988,1,4,0)
 ;;=4^E11.339
 ;;^UTILITY(U,$J,358.3,7988,2)
 ;;=^5002637
 ;;^UTILITY(U,$J,358.3,7989,0)
 ;;=E11.311^^55^532^25
 ;;^UTILITY(U,$J,358.3,7989,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7989,1,3,0)
 ;;=3^Type 2 diab w unsp diabetic retinopathy w macular edema
 ;;^UTILITY(U,$J,358.3,7989,1,4,0)
 ;;=4^E11.311
 ;;^UTILITY(U,$J,358.3,7989,2)
 ;;=^5002632
 ;;^UTILITY(U,$J,358.3,7990,0)
 ;;=E11.319^^55^532^26
 ;;^UTILITY(U,$J,358.3,7990,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7990,1,3,0)
 ;;=3^Type 2 diab w unsp diabetic rtnop w/o macular edema
 ;;^UTILITY(U,$J,358.3,7990,1,4,0)
 ;;=4^E11.319
 ;;^UTILITY(U,$J,358.3,7990,2)
 ;;=^5002633
 ;;^UTILITY(U,$J,358.3,7991,0)
 ;;=E11.341^^55^532^24
 ;;^UTILITY(U,$J,358.3,7991,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7991,1,3,0)
 ;;=3^Type 2 diab w severe nonprlf diabetic rtnop w macular edema
 ;;^UTILITY(U,$J,358.3,7991,1,4,0)
 ;;=4^E11.341
 ;;^UTILITY(U,$J,358.3,7991,2)
 ;;=^5002638
 ;;^UTILITY(U,$J,358.3,7992,0)
 ;;=E11.349^^55^532^23
 ;;^UTILITY(U,$J,358.3,7992,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7992,1,3,0)
 ;;=3^Type 2 diab w severe nonprlf diab rtnop w/o macular edema
