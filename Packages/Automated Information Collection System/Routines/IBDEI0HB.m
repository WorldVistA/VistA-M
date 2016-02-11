IBDEI0HB ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,7741,2)
 ;;=^5015563
 ;;^UTILITY(U,$J,358.3,7742,0)
 ;;=N07.5^^52^518^27
 ;;^UTILITY(U,$J,358.3,7742,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7742,1,3,0)
 ;;=3^Hereditary nephropathy, NEC w/ diffuse mesangiocap glomrlneph
 ;;^UTILITY(U,$J,358.3,7742,1,4,0)
 ;;=4^N07.5
 ;;^UTILITY(U,$J,358.3,7742,2)
 ;;=^5015564
 ;;^UTILITY(U,$J,358.3,7743,0)
 ;;=N07.6^^52^518^22
 ;;^UTILITY(U,$J,358.3,7743,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7743,1,3,0)
 ;;=3^Hereditary nephropathy, NEC w/ dense deposit disease
 ;;^UTILITY(U,$J,358.3,7743,1,4,0)
 ;;=4^N07.6
 ;;^UTILITY(U,$J,358.3,7743,2)
 ;;=^5015565
 ;;^UTILITY(U,$J,358.3,7744,0)
 ;;=N07.7^^52^518^28
 ;;^UTILITY(U,$J,358.3,7744,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7744,1,3,0)
 ;;=3^Hereditary nephropathy, NEC w/ diffuse crescentic glomrlneph
 ;;^UTILITY(U,$J,358.3,7744,1,4,0)
 ;;=4^N07.7
 ;;^UTILITY(U,$J,358.3,7744,2)
 ;;=^5015566
 ;;^UTILITY(U,$J,358.3,7745,0)
 ;;=N07.8^^52^518^31
 ;;^UTILITY(U,$J,358.3,7745,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7745,1,3,0)
 ;;=3^Hereditary nephropathy, NEC w/ oth morphologic lesions
 ;;^UTILITY(U,$J,358.3,7745,1,4,0)
 ;;=4^N07.8
 ;;^UTILITY(U,$J,358.3,7745,2)
 ;;=^5015567
 ;;^UTILITY(U,$J,358.3,7746,0)
 ;;=N07.9^^52^518^32
 ;;^UTILITY(U,$J,358.3,7746,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7746,1,3,0)
 ;;=3^Hereditary nephropathy, NEC w/ unsp morphologic lesions
 ;;^UTILITY(U,$J,358.3,7746,1,4,0)
 ;;=4^N07.9
 ;;^UTILITY(U,$J,358.3,7746,2)
 ;;=^5015568
 ;;^UTILITY(U,$J,358.3,7747,0)
 ;;=N08.^^52^518^21
 ;;^UTILITY(U,$J,358.3,7747,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7747,1,3,0)
 ;;=3^Glomerular disorders in diseases classified elsewhere
 ;;^UTILITY(U,$J,358.3,7747,1,4,0)
 ;;=4^N08.
 ;;^UTILITY(U,$J,358.3,7747,2)
 ;;=^5015569
 ;;^UTILITY(U,$J,358.3,7748,0)
 ;;=C90.00^^52^519^9
 ;;^UTILITY(U,$J,358.3,7748,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7748,1,3,0)
 ;;=3^Multiple myeloma not having achieved remission
 ;;^UTILITY(U,$J,358.3,7748,1,4,0)
 ;;=4^C90.00
 ;;^UTILITY(U,$J,358.3,7748,2)
 ;;=^5001752
 ;;^UTILITY(U,$J,358.3,7749,0)
 ;;=C90.01^^52^519^8
 ;;^UTILITY(U,$J,358.3,7749,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7749,1,3,0)
 ;;=3^Multiple myeloma in remission
 ;;^UTILITY(U,$J,358.3,7749,1,4,0)
 ;;=4^C90.01
 ;;^UTILITY(U,$J,358.3,7749,2)
 ;;=^267515
 ;;^UTILITY(U,$J,358.3,7750,0)
 ;;=C90.02^^52^519^7
 ;;^UTILITY(U,$J,358.3,7750,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7750,1,3,0)
 ;;=3^Multiple myeloma in relapse
 ;;^UTILITY(U,$J,358.3,7750,1,4,0)
 ;;=4^C90.02
 ;;^UTILITY(U,$J,358.3,7750,2)
 ;;=^5001753
 ;;^UTILITY(U,$J,358.3,7751,0)
 ;;=E11.29^^52^519^19
 ;;^UTILITY(U,$J,358.3,7751,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7751,1,3,0)
 ;;=3^Type 2 DM w/ Oth Diabetic Kidney Complications
 ;;^UTILITY(U,$J,358.3,7751,1,4,0)
 ;;=4^E11.29
 ;;^UTILITY(U,$J,358.3,7751,2)
 ;;=^5002631
 ;;^UTILITY(U,$J,358.3,7752,0)
 ;;=E11.21^^52^519^18
 ;;^UTILITY(U,$J,358.3,7752,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7752,1,3,0)
 ;;=3^Type 2 DM w/ Diabetic nephropathy
 ;;^UTILITY(U,$J,358.3,7752,1,4,0)
 ;;=4^E11.21
 ;;^UTILITY(U,$J,358.3,7752,2)
 ;;=^5002629
 ;;^UTILITY(U,$J,358.3,7753,0)
 ;;=E11.22^^52^519^17
 ;;^UTILITY(U,$J,358.3,7753,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7753,1,3,0)
 ;;=3^Type 2 DM w/ Diabetic CKD
 ;;^UTILITY(U,$J,358.3,7753,1,4,0)
 ;;=4^E11.22
 ;;^UTILITY(U,$J,358.3,7753,2)
 ;;=^5002630
 ;;^UTILITY(U,$J,358.3,7754,0)
 ;;=E10.29^^52^519^16
 ;;^UTILITY(U,$J,358.3,7754,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7754,1,3,0)
 ;;=3^Type 1 DM w/ Oth Diabetic Kidney Complications
