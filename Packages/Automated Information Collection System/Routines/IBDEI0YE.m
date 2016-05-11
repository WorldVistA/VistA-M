IBDEI0YE ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,16150,1,4,0)
 ;;=4^C81.29
 ;;^UTILITY(U,$J,358.3,16150,2)
 ;;=^5001420
 ;;^UTILITY(U,$J,358.3,16151,0)
 ;;=C81.10^^61^724^18
 ;;^UTILITY(U,$J,358.3,16151,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16151,1,3,0)
 ;;=3^Hodgkin Lymphoma,Nodular Sclerosis,Unspec Site
 ;;^UTILITY(U,$J,358.3,16151,1,4,0)
 ;;=4^C81.10
 ;;^UTILITY(U,$J,358.3,16151,2)
 ;;=^5001401
 ;;^UTILITY(U,$J,358.3,16152,0)
 ;;=C81.19^^61^724^17
 ;;^UTILITY(U,$J,358.3,16152,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16152,1,3,0)
 ;;=3^Hodgkin Lymphoma,Nodular Sclerosis,Extrnod & Solid Org Sites
 ;;^UTILITY(U,$J,358.3,16152,1,4,0)
 ;;=4^C81.19
 ;;^UTILITY(U,$J,358.3,16152,2)
 ;;=^5001410
 ;;^UTILITY(U,$J,358.3,16153,0)
 ;;=C81.99^^61^724^8
 ;;^UTILITY(U,$J,358.3,16153,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16153,1,3,0)
 ;;=3^Hodgkin Lymphoma,Extrnod & Solid Org Sites,Unspec
 ;;^UTILITY(U,$J,358.3,16153,1,4,0)
 ;;=4^C81.99
 ;;^UTILITY(U,$J,358.3,16153,2)
 ;;=^5001460
 ;;^UTILITY(U,$J,358.3,16154,0)
 ;;=C82.90^^61^724^6
 ;;^UTILITY(U,$J,358.3,16154,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16154,1,3,0)
 ;;=3^Follicular Lymphoma,Unspec Site
 ;;^UTILITY(U,$J,358.3,16154,1,4,0)
 ;;=4^C82.90
 ;;^UTILITY(U,$J,358.3,16154,2)
 ;;=^5001541
 ;;^UTILITY(U,$J,358.3,16155,0)
 ;;=C82.99^^61^724^5
 ;;^UTILITY(U,$J,358.3,16155,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16155,1,3,0)
 ;;=3^Follicular Lymphoma,Extrnod & Solid Org Sites
 ;;^UTILITY(U,$J,358.3,16155,1,4,0)
 ;;=4^C82.99
 ;;^UTILITY(U,$J,358.3,16155,2)
 ;;=^5001550
 ;;^UTILITY(U,$J,358.3,16156,0)
 ;;=C83.70^^61^724^2
 ;;^UTILITY(U,$J,358.3,16156,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16156,1,3,0)
 ;;=3^Burkitt Lymphoma,Unspec Site
 ;;^UTILITY(U,$J,358.3,16156,1,4,0)
 ;;=4^C83.70
 ;;^UTILITY(U,$J,358.3,16156,2)
 ;;=^5001591
 ;;^UTILITY(U,$J,358.3,16157,0)
 ;;=C83.79^^61^724^1
 ;;^UTILITY(U,$J,358.3,16157,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16157,1,3,0)
 ;;=3^Burkitt Lymphoma,Extrnod & Solid Org Sites
 ;;^UTILITY(U,$J,358.3,16157,1,4,0)
 ;;=4^C83.79
 ;;^UTILITY(U,$J,358.3,16157,2)
 ;;=^5001600
 ;;^UTILITY(U,$J,358.3,16158,0)
 ;;=C96.9^^61^724^27
 ;;^UTILITY(U,$J,358.3,16158,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16158,1,3,0)
 ;;=3^Malig Neop Lymphoid/Hematopoietic/Related Tissue,Unspec
 ;;^UTILITY(U,$J,358.3,16158,1,4,0)
 ;;=4^C96.9
 ;;^UTILITY(U,$J,358.3,16158,2)
 ;;=^5001864
 ;;^UTILITY(U,$J,358.3,16159,0)
 ;;=C96.4^^61^724^3
 ;;^UTILITY(U,$J,358.3,16159,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16159,1,3,0)
 ;;=3^Dendritic Cells Sarcoma
 ;;^UTILITY(U,$J,358.3,16159,1,4,0)
 ;;=4^C96.4
 ;;^UTILITY(U,$J,358.3,16159,2)
 ;;=^5001861
 ;;^UTILITY(U,$J,358.3,16160,0)
 ;;=C83.50^^61^724^23
 ;;^UTILITY(U,$J,358.3,16160,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16160,1,3,0)
 ;;=3^Lymphoblastic Lymphoma,Unspec Site
 ;;^UTILITY(U,$J,358.3,16160,1,4,0)
 ;;=4^C83.50
 ;;^UTILITY(U,$J,358.3,16160,2)
 ;;=^5001581
 ;;^UTILITY(U,$J,358.3,16161,0)
 ;;=C83.59^^61^724^22
 ;;^UTILITY(U,$J,358.3,16161,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16161,1,3,0)
 ;;=3^Lymphoblastic Lymphoma,Extrnod & Solid Org Sites
 ;;^UTILITY(U,$J,358.3,16161,1,4,0)
 ;;=4^C83.59
 ;;^UTILITY(U,$J,358.3,16161,2)
 ;;=^5001590
 ;;^UTILITY(U,$J,358.3,16162,0)
 ;;=C94.40^^61^724^40
 ;;^UTILITY(U,$J,358.3,16162,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16162,1,3,0)
 ;;=3^Panmyelosis w/ Myelofibrosis,Acute,Not in Remission
 ;;^UTILITY(U,$J,358.3,16162,1,4,0)
 ;;=4^C94.40
 ;;^UTILITY(U,$J,358.3,16162,2)
 ;;=^5001843
 ;;^UTILITY(U,$J,358.3,16163,0)
 ;;=C94.41^^61^724^38
