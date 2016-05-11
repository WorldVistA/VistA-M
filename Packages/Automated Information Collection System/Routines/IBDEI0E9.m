IBDEI0E9 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,6557,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6557,1,3,0)
 ;;=3^Lobular Carcinoma in Situ,Right Breast
 ;;^UTILITY(U,$J,358.3,6557,1,4,0)
 ;;=4^D05.01
 ;;^UTILITY(U,$J,358.3,6557,2)
 ;;=^5001927
 ;;^UTILITY(U,$J,358.3,6558,0)
 ;;=D05.00^^30^396^98
 ;;^UTILITY(U,$J,358.3,6558,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6558,1,3,0)
 ;;=3^Lobular Carcinoma in Situ,Unspec Breast
 ;;^UTILITY(U,$J,358.3,6558,1,4,0)
 ;;=4^D05.00
 ;;^UTILITY(U,$J,358.3,6558,2)
 ;;=^5001926
 ;;^UTILITY(U,$J,358.3,6559,0)
 ;;=R59.0^^30^396^59
 ;;^UTILITY(U,$J,358.3,6559,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6559,1,3,0)
 ;;=3^Enlarged Lymph Nodes,Localized
 ;;^UTILITY(U,$J,358.3,6559,1,4,0)
 ;;=4^R59.0
 ;;^UTILITY(U,$J,358.3,6559,2)
 ;;=^5019529
 ;;^UTILITY(U,$J,358.3,6560,0)
 ;;=C83.59^^30^396^99
 ;;^UTILITY(U,$J,358.3,6560,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6560,1,3,0)
 ;;=3^Lymphoblastic Lymphoma,Extranodal/Solid Organ Sites
 ;;^UTILITY(U,$J,358.3,6560,1,4,0)
 ;;=4^C83.59
 ;;^UTILITY(U,$J,358.3,6560,2)
 ;;=^5001590
 ;;^UTILITY(U,$J,358.3,6561,0)
 ;;=C83.50^^30^396^100
 ;;^UTILITY(U,$J,358.3,6561,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6561,1,3,0)
 ;;=3^Lymphoblastic Lymphoma,Unspec Site
 ;;^UTILITY(U,$J,358.3,6561,1,4,0)
 ;;=4^C83.50
 ;;^UTILITY(U,$J,358.3,6561,2)
 ;;=^5001581
 ;;^UTILITY(U,$J,358.3,6562,0)
 ;;=C43.9^^30^396^102
 ;;^UTILITY(U,$J,358.3,6562,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6562,1,3,0)
 ;;=3^Malig Melanoma of Skin,Unspec Site
 ;;^UTILITY(U,$J,358.3,6562,1,4,0)
 ;;=4^C43.9
 ;;^UTILITY(U,$J,358.3,6562,2)
 ;;=^5001015
 ;;^UTILITY(U,$J,358.3,6563,0)
 ;;=C31.9^^30^396^103
 ;;^UTILITY(U,$J,358.3,6563,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6563,1,3,0)
 ;;=3^Malig Neop Accessory Sinus,Unspec
 ;;^UTILITY(U,$J,358.3,6563,1,4,0)
 ;;=4^C31.9
 ;;^UTILITY(U,$J,358.3,6563,2)
 ;;=^5000953
 ;;^UTILITY(U,$J,358.3,6564,0)
 ;;=C24.1^^30^396^105
 ;;^UTILITY(U,$J,358.3,6564,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6564,1,3,0)
 ;;=3^Malig Neop Ampulla of Vater
 ;;^UTILITY(U,$J,358.3,6564,1,4,0)
 ;;=4^C24.1
 ;;^UTILITY(U,$J,358.3,6564,2)
 ;;=^267100
 ;;^UTILITY(U,$J,358.3,6565,0)
 ;;=C21.0^^30^396^106
 ;;^UTILITY(U,$J,358.3,6565,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6565,1,3,0)
 ;;=3^Malig Neop Anus,Unspec
 ;;^UTILITY(U,$J,358.3,6565,1,4,0)
 ;;=4^C21.0
 ;;^UTILITY(U,$J,358.3,6565,2)
 ;;=^5000930
 ;;^UTILITY(U,$J,358.3,6566,0)
 ;;=C67.9^^30^396^109
 ;;^UTILITY(U,$J,358.3,6566,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6566,1,3,0)
 ;;=3^Malig Neop Bladder,Unspec
 ;;^UTILITY(U,$J,358.3,6566,1,4,0)
 ;;=4^C67.9
 ;;^UTILITY(U,$J,358.3,6566,2)
 ;;=^5001263
 ;;^UTILITY(U,$J,358.3,6567,0)
 ;;=C71.9^^30^396^113
 ;;^UTILITY(U,$J,358.3,6567,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6567,1,3,0)
 ;;=3^Malig Neop Brain,Unspec
 ;;^UTILITY(U,$J,358.3,6567,1,4,0)
 ;;=4^C71.9
 ;;^UTILITY(U,$J,358.3,6567,2)
 ;;=^5001297
 ;;^UTILITY(U,$J,358.3,6568,0)
 ;;=C18.9^^30^396^115
 ;;^UTILITY(U,$J,358.3,6568,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6568,1,3,0)
 ;;=3^Malig Neop Colon,Unspec
 ;;^UTILITY(U,$J,358.3,6568,1,4,0)
 ;;=4^C18.9
 ;;^UTILITY(U,$J,358.3,6568,2)
 ;;=^5000929
 ;;^UTILITY(U,$J,358.3,6569,0)
 ;;=C49.9^^30^396^116
 ;;^UTILITY(U,$J,358.3,6569,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6569,1,3,0)
 ;;=3^Malig Neop Connective/Soft Tissue,Unspec
 ;;^UTILITY(U,$J,358.3,6569,1,4,0)
 ;;=4^C49.9
 ;;^UTILITY(U,$J,358.3,6569,2)
 ;;=^5001136
 ;;^UTILITY(U,$J,358.3,6570,0)
 ;;=C62.12^^30^396^117
 ;;^UTILITY(U,$J,358.3,6570,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6570,1,3,0)
 ;;=3^Malig Neop Descended Left Testis
