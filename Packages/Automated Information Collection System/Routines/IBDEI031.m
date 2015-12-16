IBDEI031 ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,875,0)
 ;;=E11.311^^3^33^25
 ;;^UTILITY(U,$J,358.3,875,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,875,1,3,0)
 ;;=3^Type 2 diab w unsp diabetic retinopathy w macular edema
 ;;^UTILITY(U,$J,358.3,875,1,4,0)
 ;;=4^E11.311
 ;;^UTILITY(U,$J,358.3,875,2)
 ;;=^5002632
 ;;^UTILITY(U,$J,358.3,876,0)
 ;;=E11.319^^3^33^26
 ;;^UTILITY(U,$J,358.3,876,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,876,1,3,0)
 ;;=3^Type 2 diab w unsp diabetic rtnop w/o macular edema
 ;;^UTILITY(U,$J,358.3,876,1,4,0)
 ;;=4^E11.319
 ;;^UTILITY(U,$J,358.3,876,2)
 ;;=^5002633
 ;;^UTILITY(U,$J,358.3,877,0)
 ;;=E11.341^^3^33^24
 ;;^UTILITY(U,$J,358.3,877,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,877,1,3,0)
 ;;=3^Type 2 diab w severe nonprlf diabetic rtnop w macular edema
 ;;^UTILITY(U,$J,358.3,877,1,4,0)
 ;;=4^E11.341
 ;;^UTILITY(U,$J,358.3,877,2)
 ;;=^5002638
 ;;^UTILITY(U,$J,358.3,878,0)
 ;;=E11.349^^3^33^23
 ;;^UTILITY(U,$J,358.3,878,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,878,1,3,0)
 ;;=3^Type 2 diab w severe nonprlf diab rtnop w/o macular edema
 ;;^UTILITY(U,$J,358.3,878,1,4,0)
 ;;=4^E11.349
 ;;^UTILITY(U,$J,358.3,878,2)
 ;;=^5002639
 ;;^UTILITY(U,$J,358.3,879,0)
 ;;=E10.321^^3^33^5
 ;;^UTILITY(U,$J,358.3,879,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,879,1,3,0)
 ;;=3^Type 1 diab w mild nonprlf diabetic rtnop w macular edema
 ;;^UTILITY(U,$J,358.3,879,1,4,0)
 ;;=4^E10.321
 ;;^UTILITY(U,$J,358.3,879,2)
 ;;=^5002594
 ;;^UTILITY(U,$J,358.3,880,0)
 ;;=E10.329^^3^33^6
 ;;^UTILITY(U,$J,358.3,880,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,880,1,3,0)
 ;;=3^Type 1 diab w mild nonprlf diabetic rtnop w/o macular edema
 ;;^UTILITY(U,$J,358.3,880,1,4,0)
 ;;=4^E10.329
 ;;^UTILITY(U,$J,358.3,880,2)
 ;;=^5002595
 ;;^UTILITY(U,$J,358.3,881,0)
 ;;=E10.331^^3^33^7
 ;;^UTILITY(U,$J,358.3,881,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,881,1,3,0)
 ;;=3^Type 1 diab w moderate nonprlf diab rtnop w macular edema
 ;;^UTILITY(U,$J,358.3,881,1,4,0)
 ;;=4^E10.331
 ;;^UTILITY(U,$J,358.3,881,2)
 ;;=^5002596
 ;;^UTILITY(U,$J,358.3,882,0)
 ;;=E10.339^^3^33^8
 ;;^UTILITY(U,$J,358.3,882,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,882,1,3,0)
 ;;=3^Type 1 diab w moderate nonprlf diab rtnop w/o macular edema
 ;;^UTILITY(U,$J,358.3,882,1,4,0)
 ;;=4^E10.339
 ;;^UTILITY(U,$J,358.3,882,2)
 ;;=^5002597
 ;;^UTILITY(U,$J,358.3,883,0)
 ;;=E10.311^^3^33^11
 ;;^UTILITY(U,$J,358.3,883,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,883,1,3,0)
 ;;=3^Type 1 diab w unsp diabetic retinopathy w macular edema
 ;;^UTILITY(U,$J,358.3,883,1,4,0)
 ;;=4^E10.311
 ;;^UTILITY(U,$J,358.3,883,2)
 ;;=^5002592
 ;;^UTILITY(U,$J,358.3,884,0)
 ;;=E10.319^^3^33^12
 ;;^UTILITY(U,$J,358.3,884,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,884,1,3,0)
 ;;=3^Type 1 diab w unsp diabetic rtnop w/o macular edema
 ;;^UTILITY(U,$J,358.3,884,1,4,0)
 ;;=4^E10.319
 ;;^UTILITY(U,$J,358.3,884,2)
 ;;=^5002593
 ;;^UTILITY(U,$J,358.3,885,0)
 ;;=E10.341^^3^33^10
 ;;^UTILITY(U,$J,358.3,885,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,885,1,3,0)
 ;;=3^Type 1 diab w severe nonprlf diabetic rtnop w macular edema
 ;;^UTILITY(U,$J,358.3,885,1,4,0)
 ;;=4^E10.341
 ;;^UTILITY(U,$J,358.3,885,2)
 ;;=^5002598
 ;;^UTILITY(U,$J,358.3,886,0)
 ;;=E10.349^^3^33^9
 ;;^UTILITY(U,$J,358.3,886,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,886,1,3,0)
 ;;=3^Type 1 diab w severe nonprlf diab rtnop w/o macular edema
 ;;^UTILITY(U,$J,358.3,886,1,4,0)
 ;;=4^E10.349
 ;;^UTILITY(U,$J,358.3,886,2)
 ;;=^5002599
 ;;^UTILITY(U,$J,358.3,887,0)
 ;;=E11.40^^3^33^14
 ;;^UTILITY(U,$J,358.3,887,1,0)
 ;;=^358.31IA^4^2
