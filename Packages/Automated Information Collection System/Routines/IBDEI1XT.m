IBDEI1XT ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,30941,1,3,0)
 ;;=3^Hereditary nephropathy, NEC w/ dense deposit disease
 ;;^UTILITY(U,$J,358.3,30941,1,4,0)
 ;;=4^N07.6
 ;;^UTILITY(U,$J,358.3,30941,2)
 ;;=^5015565
 ;;^UTILITY(U,$J,358.3,30942,0)
 ;;=N07.7^^123^1597^27
 ;;^UTILITY(U,$J,358.3,30942,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30942,1,3,0)
 ;;=3^Hereditary nephropathy, NEC w/ diffuse crescentic glomrlneph
 ;;^UTILITY(U,$J,358.3,30942,1,4,0)
 ;;=4^N07.7
 ;;^UTILITY(U,$J,358.3,30942,2)
 ;;=^5015566
 ;;^UTILITY(U,$J,358.3,30943,0)
 ;;=N07.8^^123^1597^30
 ;;^UTILITY(U,$J,358.3,30943,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30943,1,3,0)
 ;;=3^Hereditary nephropathy, NEC w/ oth morphologic lesions
 ;;^UTILITY(U,$J,358.3,30943,1,4,0)
 ;;=4^N07.8
 ;;^UTILITY(U,$J,358.3,30943,2)
 ;;=^5015567
 ;;^UTILITY(U,$J,358.3,30944,0)
 ;;=N07.9^^123^1597^31
 ;;^UTILITY(U,$J,358.3,30944,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30944,1,3,0)
 ;;=3^Hereditary nephropathy, NEC w/ unsp morphologic lesions
 ;;^UTILITY(U,$J,358.3,30944,1,4,0)
 ;;=4^N07.9
 ;;^UTILITY(U,$J,358.3,30944,2)
 ;;=^5015568
 ;;^UTILITY(U,$J,358.3,30945,0)
 ;;=N08.^^123^1597^21
 ;;^UTILITY(U,$J,358.3,30945,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30945,1,3,0)
 ;;=3^Glomerular disorders in diseases classified elsewhere
 ;;^UTILITY(U,$J,358.3,30945,1,4,0)
 ;;=4^N08.
 ;;^UTILITY(U,$J,358.3,30945,2)
 ;;=^5015569
 ;;^UTILITY(U,$J,358.3,30946,0)
 ;;=C90.00^^123^1598^10
 ;;^UTILITY(U,$J,358.3,30946,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30946,1,3,0)
 ;;=3^Multiple myeloma not having achieved remission
 ;;^UTILITY(U,$J,358.3,30946,1,4,0)
 ;;=4^C90.00
 ;;^UTILITY(U,$J,358.3,30946,2)
 ;;=^5001752
 ;;^UTILITY(U,$J,358.3,30947,0)
 ;;=C90.01^^123^1598^9
 ;;^UTILITY(U,$J,358.3,30947,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30947,1,3,0)
 ;;=3^Multiple myeloma in remission
 ;;^UTILITY(U,$J,358.3,30947,1,4,0)
 ;;=4^C90.01
 ;;^UTILITY(U,$J,358.3,30947,2)
 ;;=^267515
 ;;^UTILITY(U,$J,358.3,30948,0)
 ;;=C90.02^^123^1598^8
 ;;^UTILITY(U,$J,358.3,30948,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30948,1,3,0)
 ;;=3^Multiple myeloma in relapse
 ;;^UTILITY(U,$J,358.3,30948,1,4,0)
 ;;=4^C90.02
 ;;^UTILITY(U,$J,358.3,30948,2)
 ;;=^5001753
 ;;^UTILITY(U,$J,358.3,30949,0)
 ;;=E11.29^^123^1598^21
 ;;^UTILITY(U,$J,358.3,30949,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30949,1,3,0)
 ;;=3^Type 2 DM w/ Oth Diabetic Kidney Complications
 ;;^UTILITY(U,$J,358.3,30949,1,4,0)
 ;;=4^E11.29
 ;;^UTILITY(U,$J,358.3,30949,2)
 ;;=^5002631
 ;;^UTILITY(U,$J,358.3,30950,0)
 ;;=E11.21^^123^1598^20
 ;;^UTILITY(U,$J,358.3,30950,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30950,1,3,0)
 ;;=3^Type 2 DM w/ Diabetic nephropathy
 ;;^UTILITY(U,$J,358.3,30950,1,4,0)
 ;;=4^E11.21
 ;;^UTILITY(U,$J,358.3,30950,2)
 ;;=^5002629
 ;;^UTILITY(U,$J,358.3,30951,0)
 ;;=E11.22^^123^1598^19
 ;;^UTILITY(U,$J,358.3,30951,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30951,1,3,0)
 ;;=3^Type 2 DM w/ Diabetic CKD
 ;;^UTILITY(U,$J,358.3,30951,1,4,0)
 ;;=4^E11.22
 ;;^UTILITY(U,$J,358.3,30951,2)
 ;;=^5002630
 ;;^UTILITY(U,$J,358.3,30952,0)
 ;;=E10.29^^123^1598^18
 ;;^UTILITY(U,$J,358.3,30952,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30952,1,3,0)
 ;;=3^Type 1 DM w/ Oth Diabetic Kidney Complications
 ;;^UTILITY(U,$J,358.3,30952,1,4,0)
 ;;=4^E10.29
 ;;^UTILITY(U,$J,358.3,30952,2)
 ;;=^5002591
 ;;^UTILITY(U,$J,358.3,30953,0)
 ;;=E10.21^^123^1598^17
