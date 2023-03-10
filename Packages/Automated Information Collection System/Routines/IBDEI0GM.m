IBDEI0GM ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,7457,0)
 ;;=C7A.029^^36^368^31
 ;;^UTILITY(U,$J,358.3,7457,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7457,1,3,0)
 ;;=3^Carcinoid,Malignant,Unspec Colon
 ;;^UTILITY(U,$J,358.3,7457,1,4,0)
 ;;=4^C7A.029
 ;;^UTILITY(U,$J,358.3,7457,2)
 ;;=^5001370
 ;;^UTILITY(U,$J,358.3,7458,0)
 ;;=C7B.02^^36^368^5
 ;;^UTILITY(U,$J,358.3,7458,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7458,1,3,0)
 ;;=3^Carcinoid of Liver
 ;;^UTILITY(U,$J,358.3,7458,1,4,0)
 ;;=4^C7B.02
 ;;^UTILITY(U,$J,358.3,7458,2)
 ;;=^5001383
 ;;^UTILITY(U,$J,358.3,7459,0)
 ;;=E34.0^^36^368^6
 ;;^UTILITY(U,$J,358.3,7459,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7459,1,3,0)
 ;;=3^Carcinoid syndrome
 ;;^UTILITY(U,$J,358.3,7459,1,4,0)
 ;;=4^E34.0
 ;;^UTILITY(U,$J,358.3,7459,2)
 ;;=^19261
 ;;^UTILITY(U,$J,358.3,7460,0)
 ;;=C83.79^^36^368^33
 ;;^UTILITY(U,$J,358.3,7460,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7460,1,3,0)
 ;;=3^Lymphoma,Burkitt,Extranodal
 ;;^UTILITY(U,$J,358.3,7460,1,4,0)
 ;;=4^C83.79
 ;;^UTILITY(U,$J,358.3,7460,2)
 ;;=^5001600
 ;;^UTILITY(U,$J,358.3,7461,0)
 ;;=C83.39^^36^368^34
 ;;^UTILITY(U,$J,358.3,7461,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7461,1,3,0)
 ;;=3^Lymphoma,Diffuse large B-Cell,Extranodal
 ;;^UTILITY(U,$J,358.3,7461,1,4,0)
 ;;=4^C83.39
 ;;^UTILITY(U,$J,358.3,7461,2)
 ;;=^5001580
 ;;^UTILITY(U,$J,358.3,7462,0)
 ;;=C86.2^^36^368^35
 ;;^UTILITY(U,$J,358.3,7462,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7462,1,3,0)
 ;;=3^Lymphoma,Enteropathy T-cell type
 ;;^UTILITY(U,$J,358.3,7462,1,4,0)
 ;;=4^C86.2
 ;;^UTILITY(U,$J,358.3,7462,2)
 ;;=^5001743
 ;;^UTILITY(U,$J,358.3,7463,0)
 ;;=C82.59^^36^368^36
 ;;^UTILITY(U,$J,358.3,7463,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7463,1,3,0)
 ;;=3^Lymphoma,Follicular Diffuse,Extranodal
 ;;^UTILITY(U,$J,358.3,7463,1,4,0)
 ;;=4^C82.59
 ;;^UTILITY(U,$J,358.3,7463,2)
 ;;=^5001520
 ;;^UTILITY(U,$J,358.3,7464,0)
 ;;=C88.4^^36^368^37
 ;;^UTILITY(U,$J,358.3,7464,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7464,1,3,0)
 ;;=3^Lymphoma,MALT Type
 ;;^UTILITY(U,$J,358.3,7464,1,4,0)
 ;;=4^C88.4
 ;;^UTILITY(U,$J,358.3,7464,2)
 ;;=^5001749
 ;;^UTILITY(U,$J,358.3,7465,0)
 ;;=C83.19^^36^368^38
 ;;^UTILITY(U,$J,358.3,7465,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7465,1,3,0)
 ;;=3^Lymphoma,Mantle cell,Extranodal
 ;;^UTILITY(U,$J,358.3,7465,1,4,0)
 ;;=4^C83.19
 ;;^UTILITY(U,$J,358.3,7465,2)
 ;;=^5001570
 ;;^UTILITY(U,$J,358.3,7466,0)
 ;;=C78.6^^36^368^39
 ;;^UTILITY(U,$J,358.3,7466,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7466,1,3,0)
 ;;=3^Peritoneal carinomatosis
 ;;^UTILITY(U,$J,358.3,7466,1,4,0)
 ;;=4^C78.6
 ;;^UTILITY(U,$J,358.3,7466,2)
 ;;=^108899
 ;;^UTILITY(U,$J,358.3,7467,0)
 ;;=E85.89^^36^368^3
 ;;^UTILITY(U,$J,358.3,7467,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7467,1,3,0)
 ;;=3^Amyloidosis,Systemic
 ;;^UTILITY(U,$J,358.3,7467,1,4,0)
 ;;=4^E85.89
 ;;^UTILITY(U,$J,358.3,7467,2)
 ;;=^334034
 ;;^UTILITY(U,$J,358.3,7468,0)
 ;;=E85.81^^36^368^1
 ;;^UTILITY(U,$J,358.3,7468,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7468,1,3,0)
 ;;=3^Amyloidosis,Light Chain (AL)
 ;;^UTILITY(U,$J,358.3,7468,1,4,0)
 ;;=4^E85.81
 ;;^UTILITY(U,$J,358.3,7468,2)
 ;;=^5151302
 ;;^UTILITY(U,$J,358.3,7469,0)
 ;;=E85.82^^36^368^4
 ;;^UTILITY(U,$J,358.3,7469,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7469,1,3,0)
 ;;=3^Amyloidosis,Wild-type Transthyretin-related (ATTR)
