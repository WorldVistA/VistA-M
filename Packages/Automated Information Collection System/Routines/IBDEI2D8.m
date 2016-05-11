IBDEI2D8 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,40114,1,4,0)
 ;;=4^C84.08
 ;;^UTILITY(U,$J,358.3,40114,2)
 ;;=^5001629
 ;;^UTILITY(U,$J,358.3,40115,0)
 ;;=C84.18^^156^1952^48
 ;;^UTILITY(U,$J,358.3,40115,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40115,1,3,0)
 ;;=3^Sezary disease, lymph nodes of multiple sites
 ;;^UTILITY(U,$J,358.3,40115,1,4,0)
 ;;=4^C84.18
 ;;^UTILITY(U,$J,358.3,40115,2)
 ;;=^5001639
 ;;^UTILITY(U,$J,358.3,40116,0)
 ;;=C91.40^^156^1952^27
 ;;^UTILITY(U,$J,358.3,40116,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40116,1,3,0)
 ;;=3^Hairy cell leukemia not having achieved remission
 ;;^UTILITY(U,$J,358.3,40116,1,4,0)
 ;;=4^C91.40
 ;;^UTILITY(U,$J,358.3,40116,2)
 ;;=^5001771
 ;;^UTILITY(U,$J,358.3,40117,0)
 ;;=C96.0^^156^1952^39
 ;;^UTILITY(U,$J,358.3,40117,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40117,1,3,0)
 ;;=3^Multifocal and multisystemic Langerhans-cell histiocytosis
 ;;^UTILITY(U,$J,358.3,40117,1,4,0)
 ;;=4^C96.0
 ;;^UTILITY(U,$J,358.3,40117,2)
 ;;=^5001859
 ;;^UTILITY(U,$J,358.3,40118,0)
 ;;=C96.2^^156^1952^34
 ;;^UTILITY(U,$J,358.3,40118,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40118,1,3,0)
 ;;=3^Malignant mast cell tumor
 ;;^UTILITY(U,$J,358.3,40118,1,4,0)
 ;;=4^C96.2
 ;;^UTILITY(U,$J,358.3,40118,2)
 ;;=^5001860
 ;;^UTILITY(U,$J,358.3,40119,0)
 ;;=C84.48^^156^1952^45
 ;;^UTILITY(U,$J,358.3,40119,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40119,1,3,0)
 ;;=3^Peripheral T-cell lymphoma, not classified, nodes mult site
 ;;^UTILITY(U,$J,358.3,40119,1,4,0)
 ;;=4^C84.48
 ;;^UTILITY(U,$J,358.3,40119,2)
 ;;=^5001649
 ;;^UTILITY(U,$J,358.3,40120,0)
 ;;=C90.01^^156^1952^41
 ;;^UTILITY(U,$J,358.3,40120,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40120,1,3,0)
 ;;=3^Multiple myeloma in remission
 ;;^UTILITY(U,$J,358.3,40120,1,4,0)
 ;;=4^C90.01
 ;;^UTILITY(U,$J,358.3,40120,2)
 ;;=^267515
 ;;^UTILITY(U,$J,358.3,40121,0)
 ;;=C90.02^^156^1952^40
 ;;^UTILITY(U,$J,358.3,40121,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40121,1,3,0)
 ;;=3^Multiple myeloma in relapse
 ;;^UTILITY(U,$J,358.3,40121,1,4,0)
 ;;=4^C90.02
 ;;^UTILITY(U,$J,358.3,40121,2)
 ;;=^5001753
 ;;^UTILITY(U,$J,358.3,40122,0)
 ;;=C90.11^^156^1952^47
 ;;^UTILITY(U,$J,358.3,40122,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40122,1,3,0)
 ;;=3^Plasma cell leukemia in remission
 ;;^UTILITY(U,$J,358.3,40122,1,4,0)
 ;;=4^C90.11
 ;;^UTILITY(U,$J,358.3,40122,2)
 ;;=^267517
 ;;^UTILITY(U,$J,358.3,40123,0)
 ;;=C90.12^^156^1952^46
 ;;^UTILITY(U,$J,358.3,40123,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40123,1,3,0)
 ;;=3^Plasma cell leukemia in relapse
 ;;^UTILITY(U,$J,358.3,40123,1,4,0)
 ;;=4^C90.12
 ;;^UTILITY(U,$J,358.3,40123,2)
 ;;=^5001755
 ;;^UTILITY(U,$J,358.3,40124,0)
 ;;=C90.21^^156^1952^25
 ;;^UTILITY(U,$J,358.3,40124,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40124,1,3,0)
 ;;=3^Extramedullary plasmacytoma in remission
 ;;^UTILITY(U,$J,358.3,40124,1,4,0)
 ;;=4^C90.21
 ;;^UTILITY(U,$J,358.3,40124,2)
 ;;=^5001757
 ;;^UTILITY(U,$J,358.3,40125,0)
 ;;=C90.31^^156^1952^50
 ;;^UTILITY(U,$J,358.3,40125,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40125,1,3,0)
 ;;=3^Solitary plasmacytoma in remission
 ;;^UTILITY(U,$J,358.3,40125,1,4,0)
 ;;=4^C90.31
 ;;^UTILITY(U,$J,358.3,40125,2)
 ;;=^5001760
 ;;^UTILITY(U,$J,358.3,40126,0)
 ;;=C88.8^^156^1952^33
 ;;^UTILITY(U,$J,358.3,40126,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40126,1,3,0)
 ;;=3^Malignant immunoproliferative diseases NEC
 ;;^UTILITY(U,$J,358.3,40126,1,4,0)
 ;;=4^C88.8
 ;;^UTILITY(U,$J,358.3,40126,2)
 ;;=^5001750
 ;;^UTILITY(U,$J,358.3,40127,0)
 ;;=C90.22^^156^1952^24
 ;;^UTILITY(U,$J,358.3,40127,1,0)
 ;;=^358.31IA^4^2
