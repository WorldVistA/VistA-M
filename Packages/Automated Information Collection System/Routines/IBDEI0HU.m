IBDEI0HU ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,7992,1,4,0)
 ;;=4^E11.349
 ;;^UTILITY(U,$J,358.3,7992,2)
 ;;=^5002639
 ;;^UTILITY(U,$J,358.3,7993,0)
 ;;=E10.321^^55^532^5
 ;;^UTILITY(U,$J,358.3,7993,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7993,1,3,0)
 ;;=3^Type 1 diab w mild nonprlf diabetic rtnop w macular edema
 ;;^UTILITY(U,$J,358.3,7993,1,4,0)
 ;;=4^E10.321
 ;;^UTILITY(U,$J,358.3,7993,2)
 ;;=^5002594
 ;;^UTILITY(U,$J,358.3,7994,0)
 ;;=E10.329^^55^532^6
 ;;^UTILITY(U,$J,358.3,7994,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7994,1,3,0)
 ;;=3^Type 1 diab w mild nonprlf diabetic rtnop w/o macular edema
 ;;^UTILITY(U,$J,358.3,7994,1,4,0)
 ;;=4^E10.329
 ;;^UTILITY(U,$J,358.3,7994,2)
 ;;=^5002595
 ;;^UTILITY(U,$J,358.3,7995,0)
 ;;=E10.331^^55^532^7
 ;;^UTILITY(U,$J,358.3,7995,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7995,1,3,0)
 ;;=3^Type 1 diab w moderate nonprlf diab rtnop w macular edema
 ;;^UTILITY(U,$J,358.3,7995,1,4,0)
 ;;=4^E10.331
 ;;^UTILITY(U,$J,358.3,7995,2)
 ;;=^5002596
 ;;^UTILITY(U,$J,358.3,7996,0)
 ;;=E10.339^^55^532^8
 ;;^UTILITY(U,$J,358.3,7996,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7996,1,3,0)
 ;;=3^Type 1 diab w moderate nonprlf diab rtnop w/o macular edema
 ;;^UTILITY(U,$J,358.3,7996,1,4,0)
 ;;=4^E10.339
 ;;^UTILITY(U,$J,358.3,7996,2)
 ;;=^5002597
 ;;^UTILITY(U,$J,358.3,7997,0)
 ;;=E10.311^^55^532^11
 ;;^UTILITY(U,$J,358.3,7997,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7997,1,3,0)
 ;;=3^Type 1 diab w unsp diabetic retinopathy w macular edema
 ;;^UTILITY(U,$J,358.3,7997,1,4,0)
 ;;=4^E10.311
 ;;^UTILITY(U,$J,358.3,7997,2)
 ;;=^5002592
 ;;^UTILITY(U,$J,358.3,7998,0)
 ;;=E10.319^^55^532^12
 ;;^UTILITY(U,$J,358.3,7998,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7998,1,3,0)
 ;;=3^Type 1 diab w unsp diabetic rtnop w/o macular edema
 ;;^UTILITY(U,$J,358.3,7998,1,4,0)
 ;;=4^E10.319
 ;;^UTILITY(U,$J,358.3,7998,2)
 ;;=^5002593
 ;;^UTILITY(U,$J,358.3,7999,0)
 ;;=E10.341^^55^532^10
 ;;^UTILITY(U,$J,358.3,7999,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7999,1,3,0)
 ;;=3^Type 1 diab w severe nonprlf diabetic rtnop w macular edema
 ;;^UTILITY(U,$J,358.3,7999,1,4,0)
 ;;=4^E10.341
 ;;^UTILITY(U,$J,358.3,7999,2)
 ;;=^5002598
 ;;^UTILITY(U,$J,358.3,8000,0)
 ;;=E10.349^^55^532^9
 ;;^UTILITY(U,$J,358.3,8000,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8000,1,3,0)
 ;;=3^Type 1 diab w severe nonprlf diab rtnop w/o macular edema
 ;;^UTILITY(U,$J,358.3,8000,1,4,0)
 ;;=4^E10.349
 ;;^UTILITY(U,$J,358.3,8000,2)
 ;;=^5002599
 ;;^UTILITY(U,$J,358.3,8001,0)
 ;;=E11.40^^55^532^14
 ;;^UTILITY(U,$J,358.3,8001,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8001,1,3,0)
 ;;=3^Type 2 diab w diabetic neuropathy, unsp
 ;;^UTILITY(U,$J,358.3,8001,1,4,0)
 ;;=4^E11.40
 ;;^UTILITY(U,$J,358.3,8001,2)
 ;;=^5002644
 ;;^UTILITY(U,$J,358.3,8002,0)
 ;;=E10.40^^55^532^2
 ;;^UTILITY(U,$J,358.3,8002,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8002,1,3,0)
 ;;=3^Type 1 diab w diabetic neuropathy, unsp
 ;;^UTILITY(U,$J,358.3,8002,1,4,0)
 ;;=4^E10.40
 ;;^UTILITY(U,$J,358.3,8002,2)
 ;;=^5002604
 ;;^UTILITY(U,$J,358.3,8003,0)
 ;;=E11.51^^55^532^15
 ;;^UTILITY(U,$J,358.3,8003,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8003,1,3,0)
 ;;=3^Type 2 diab w diabetic peripheral angiopath w/o gangrene
 ;;^UTILITY(U,$J,358.3,8003,1,4,0)
 ;;=4^E11.51
 ;;^UTILITY(U,$J,358.3,8003,2)
 ;;=^5002650
 ;;^UTILITY(U,$J,358.3,8004,0)
 ;;=E11.52^^55^532^16
 ;;^UTILITY(U,$J,358.3,8004,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8004,1,3,0)
 ;;=3^Type 2 diab w diabetic peripheral angiopathy w gangrene
 ;;^UTILITY(U,$J,358.3,8004,1,4,0)
 ;;=4^E11.52
 ;;^UTILITY(U,$J,358.3,8004,2)
 ;;=^5002651
