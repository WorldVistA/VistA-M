IBDEI21F ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,35606,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35606,1,3,0)
 ;;=3^Follicular lymphoma, unsp, lymph nodes of multiple sites
 ;;^UTILITY(U,$J,358.3,35606,1,4,0)
 ;;=4^C82.98
 ;;^UTILITY(U,$J,358.3,35606,2)
 ;;=^5001549
 ;;^UTILITY(U,$J,358.3,35607,0)
 ;;=C84.08^^189^2057^42
 ;;^UTILITY(U,$J,358.3,35607,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35607,1,3,0)
 ;;=3^Mycosis fungoides, lymph nodes of multiple sites
 ;;^UTILITY(U,$J,358.3,35607,1,4,0)
 ;;=4^C84.08
 ;;^UTILITY(U,$J,358.3,35607,2)
 ;;=^5001629
 ;;^UTILITY(U,$J,358.3,35608,0)
 ;;=C84.18^^189^2057^48
 ;;^UTILITY(U,$J,358.3,35608,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35608,1,3,0)
 ;;=3^Sezary disease, lymph nodes of multiple sites
 ;;^UTILITY(U,$J,358.3,35608,1,4,0)
 ;;=4^C84.18
 ;;^UTILITY(U,$J,358.3,35608,2)
 ;;=^5001639
 ;;^UTILITY(U,$J,358.3,35609,0)
 ;;=C91.40^^189^2057^27
 ;;^UTILITY(U,$J,358.3,35609,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35609,1,3,0)
 ;;=3^Hairy cell leukemia not having achieved remission
 ;;^UTILITY(U,$J,358.3,35609,1,4,0)
 ;;=4^C91.40
 ;;^UTILITY(U,$J,358.3,35609,2)
 ;;=^5001771
 ;;^UTILITY(U,$J,358.3,35610,0)
 ;;=C96.0^^189^2057^39
 ;;^UTILITY(U,$J,358.3,35610,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35610,1,3,0)
 ;;=3^Multifocal and multisystemic Langerhans-cell histiocytosis
 ;;^UTILITY(U,$J,358.3,35610,1,4,0)
 ;;=4^C96.0
 ;;^UTILITY(U,$J,358.3,35610,2)
 ;;=^5001859
 ;;^UTILITY(U,$J,358.3,35611,0)
 ;;=C96.2^^189^2057^34
 ;;^UTILITY(U,$J,358.3,35611,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35611,1,3,0)
 ;;=3^Malignant mast cell tumor
 ;;^UTILITY(U,$J,358.3,35611,1,4,0)
 ;;=4^C96.2
 ;;^UTILITY(U,$J,358.3,35611,2)
 ;;=^5001860
 ;;^UTILITY(U,$J,358.3,35612,0)
 ;;=C84.48^^189^2057^45
 ;;^UTILITY(U,$J,358.3,35612,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35612,1,3,0)
 ;;=3^Peripheral T-cell lymphoma, not classified, nodes mult site
 ;;^UTILITY(U,$J,358.3,35612,1,4,0)
 ;;=4^C84.48
 ;;^UTILITY(U,$J,358.3,35612,2)
 ;;=^5001649
 ;;^UTILITY(U,$J,358.3,35613,0)
 ;;=C90.01^^189^2057^41
 ;;^UTILITY(U,$J,358.3,35613,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35613,1,3,0)
 ;;=3^Multiple myeloma in remission
 ;;^UTILITY(U,$J,358.3,35613,1,4,0)
 ;;=4^C90.01
 ;;^UTILITY(U,$J,358.3,35613,2)
 ;;=^267515
 ;;^UTILITY(U,$J,358.3,35614,0)
 ;;=C90.02^^189^2057^40
 ;;^UTILITY(U,$J,358.3,35614,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35614,1,3,0)
 ;;=3^Multiple myeloma in relapse
 ;;^UTILITY(U,$J,358.3,35614,1,4,0)
 ;;=4^C90.02
 ;;^UTILITY(U,$J,358.3,35614,2)
 ;;=^5001753
 ;;^UTILITY(U,$J,358.3,35615,0)
 ;;=C90.11^^189^2057^47
 ;;^UTILITY(U,$J,358.3,35615,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35615,1,3,0)
 ;;=3^Plasma cell leukemia in remission
 ;;^UTILITY(U,$J,358.3,35615,1,4,0)
 ;;=4^C90.11
 ;;^UTILITY(U,$J,358.3,35615,2)
 ;;=^267517
 ;;^UTILITY(U,$J,358.3,35616,0)
 ;;=C90.12^^189^2057^46
 ;;^UTILITY(U,$J,358.3,35616,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35616,1,3,0)
 ;;=3^Plasma cell leukemia in relapse
 ;;^UTILITY(U,$J,358.3,35616,1,4,0)
 ;;=4^C90.12
 ;;^UTILITY(U,$J,358.3,35616,2)
 ;;=^5001755
 ;;^UTILITY(U,$J,358.3,35617,0)
 ;;=C90.21^^189^2057^25
 ;;^UTILITY(U,$J,358.3,35617,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35617,1,3,0)
 ;;=3^Extramedullary plasmacytoma in remission
 ;;^UTILITY(U,$J,358.3,35617,1,4,0)
 ;;=4^C90.21
 ;;^UTILITY(U,$J,358.3,35617,2)
 ;;=^5001757
 ;;^UTILITY(U,$J,358.3,35618,0)
 ;;=C90.31^^189^2057^50
 ;;^UTILITY(U,$J,358.3,35618,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35618,1,3,0)
 ;;=3^Solitary plasmacytoma in remission
