IBDEI1D9 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,22777,1,4,0)
 ;;=4^C81.10
 ;;^UTILITY(U,$J,358.3,22777,2)
 ;;=^5001401
 ;;^UTILITY(U,$J,358.3,22778,0)
 ;;=C81.19^^104^1062^17
 ;;^UTILITY(U,$J,358.3,22778,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22778,1,3,0)
 ;;=3^Hodgkin Lymphoma,Nodular Sclerosis,Extrnod & Solid Org Sites
 ;;^UTILITY(U,$J,358.3,22778,1,4,0)
 ;;=4^C81.19
 ;;^UTILITY(U,$J,358.3,22778,2)
 ;;=^5001410
 ;;^UTILITY(U,$J,358.3,22779,0)
 ;;=C81.99^^104^1062^8
 ;;^UTILITY(U,$J,358.3,22779,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22779,1,3,0)
 ;;=3^Hodgkin Lymphoma,Extrnod & Solid Org Sites,Unspec
 ;;^UTILITY(U,$J,358.3,22779,1,4,0)
 ;;=4^C81.99
 ;;^UTILITY(U,$J,358.3,22779,2)
 ;;=^5001460
 ;;^UTILITY(U,$J,358.3,22780,0)
 ;;=C82.90^^104^1062^6
 ;;^UTILITY(U,$J,358.3,22780,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22780,1,3,0)
 ;;=3^Follicular Lymphoma,Unspec Site
 ;;^UTILITY(U,$J,358.3,22780,1,4,0)
 ;;=4^C82.90
 ;;^UTILITY(U,$J,358.3,22780,2)
 ;;=^5001541
 ;;^UTILITY(U,$J,358.3,22781,0)
 ;;=C82.99^^104^1062^5
 ;;^UTILITY(U,$J,358.3,22781,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22781,1,3,0)
 ;;=3^Follicular Lymphoma,Extrnod & Solid Org Sites
 ;;^UTILITY(U,$J,358.3,22781,1,4,0)
 ;;=4^C82.99
 ;;^UTILITY(U,$J,358.3,22781,2)
 ;;=^5001550
 ;;^UTILITY(U,$J,358.3,22782,0)
 ;;=C83.70^^104^1062^2
 ;;^UTILITY(U,$J,358.3,22782,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22782,1,3,0)
 ;;=3^Burkitt Lymphoma,Unspec Site
 ;;^UTILITY(U,$J,358.3,22782,1,4,0)
 ;;=4^C83.70
 ;;^UTILITY(U,$J,358.3,22782,2)
 ;;=^5001591
 ;;^UTILITY(U,$J,358.3,22783,0)
 ;;=C83.79^^104^1062^1
 ;;^UTILITY(U,$J,358.3,22783,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22783,1,3,0)
 ;;=3^Burkitt Lymphoma,Extrnod & Solid Org Sites
 ;;^UTILITY(U,$J,358.3,22783,1,4,0)
 ;;=4^C83.79
 ;;^UTILITY(U,$J,358.3,22783,2)
 ;;=^5001600
 ;;^UTILITY(U,$J,358.3,22784,0)
 ;;=C96.9^^104^1062^27
 ;;^UTILITY(U,$J,358.3,22784,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22784,1,3,0)
 ;;=3^Malig Neop Lymphoid/Hematopoietic/Related Tissue,Unspec
 ;;^UTILITY(U,$J,358.3,22784,1,4,0)
 ;;=4^C96.9
 ;;^UTILITY(U,$J,358.3,22784,2)
 ;;=^5001864
 ;;^UTILITY(U,$J,358.3,22785,0)
 ;;=C96.4^^104^1062^3
 ;;^UTILITY(U,$J,358.3,22785,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22785,1,3,0)
 ;;=3^Dendritic Cells Sarcoma
 ;;^UTILITY(U,$J,358.3,22785,1,4,0)
 ;;=4^C96.4
 ;;^UTILITY(U,$J,358.3,22785,2)
 ;;=^5001861
 ;;^UTILITY(U,$J,358.3,22786,0)
 ;;=C83.50^^104^1062^23
 ;;^UTILITY(U,$J,358.3,22786,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22786,1,3,0)
 ;;=3^Lymphoblastic Lymphoma,Unspec Site
 ;;^UTILITY(U,$J,358.3,22786,1,4,0)
 ;;=4^C83.50
 ;;^UTILITY(U,$J,358.3,22786,2)
 ;;=^5001581
 ;;^UTILITY(U,$J,358.3,22787,0)
 ;;=C83.59^^104^1062^22
 ;;^UTILITY(U,$J,358.3,22787,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22787,1,3,0)
 ;;=3^Lymphoblastic Lymphoma,Extrnod & Solid Org Sites
 ;;^UTILITY(U,$J,358.3,22787,1,4,0)
 ;;=4^C83.59
 ;;^UTILITY(U,$J,358.3,22787,2)
 ;;=^5001590
 ;;^UTILITY(U,$J,358.3,22788,0)
 ;;=C94.40^^104^1062^40
 ;;^UTILITY(U,$J,358.3,22788,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22788,1,3,0)
 ;;=3^Panmyelosis w/ Myelofibrosis,Acute,Not in Remission
 ;;^UTILITY(U,$J,358.3,22788,1,4,0)
 ;;=4^C94.40
 ;;^UTILITY(U,$J,358.3,22788,2)
 ;;=^5001843
 ;;^UTILITY(U,$J,358.3,22789,0)
 ;;=C94.41^^104^1062^38
 ;;^UTILITY(U,$J,358.3,22789,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22789,1,3,0)
 ;;=3^Panmyelosis w/ Myelofibrosis,Acute,In Remission
 ;;^UTILITY(U,$J,358.3,22789,1,4,0)
 ;;=4^C94.41
 ;;^UTILITY(U,$J,358.3,22789,2)
 ;;=^5001844
 ;;^UTILITY(U,$J,358.3,22790,0)
 ;;=C94.42^^104^1062^39
