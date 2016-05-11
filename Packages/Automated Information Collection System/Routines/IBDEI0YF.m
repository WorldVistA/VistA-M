IBDEI0YF ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,16163,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16163,1,3,0)
 ;;=3^Panmyelosis w/ Myelofibrosis,Acute,In Remission
 ;;^UTILITY(U,$J,358.3,16163,1,4,0)
 ;;=4^C94.41
 ;;^UTILITY(U,$J,358.3,16163,2)
 ;;=^5001844
 ;;^UTILITY(U,$J,358.3,16164,0)
 ;;=C94.42^^61^724^39
 ;;^UTILITY(U,$J,358.3,16164,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16164,1,3,0)
 ;;=3^Panmyelosis w/ Myelofibrosis,Acute,In Relapse
 ;;^UTILITY(U,$J,358.3,16164,1,4,0)
 ;;=4^C94.42
 ;;^UTILITY(U,$J,358.3,16164,2)
 ;;=^5001845
 ;;^UTILITY(U,$J,358.3,16165,0)
 ;;=D47.1^^61^724^36
 ;;^UTILITY(U,$J,358.3,16165,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16165,1,3,0)
 ;;=3^Myeloproliferative Disease,Chr
 ;;^UTILITY(U,$J,358.3,16165,1,4,0)
 ;;=4^D47.1
 ;;^UTILITY(U,$J,358.3,16165,2)
 ;;=^5002256
 ;;^UTILITY(U,$J,358.3,16166,0)
 ;;=D47.9^^61^724^37
 ;;^UTILITY(U,$J,358.3,16166,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16166,1,3,0)
 ;;=3^Neop Uncrt Behavior Lymphoid/Hematopoietic/Related Tissue,Unspec
 ;;^UTILITY(U,$J,358.3,16166,1,4,0)
 ;;=4^D47.9
 ;;^UTILITY(U,$J,358.3,16166,2)
 ;;=^5002260
 ;;^UTILITY(U,$J,358.3,16167,0)
 ;;=C80.0^^61^724^4
 ;;^UTILITY(U,$J,358.3,16167,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16167,1,3,0)
 ;;=3^Disseminated Malig Neop,Unspec
 ;;^UTILITY(U,$J,358.3,16167,1,4,0)
 ;;=4^C80.0
 ;;^UTILITY(U,$J,358.3,16167,2)
 ;;=^5001388
 ;;^UTILITY(U,$J,358.3,16168,0)
 ;;=D47.2^^61^724^28
 ;;^UTILITY(U,$J,358.3,16168,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16168,1,3,0)
 ;;=3^Monoclonal Gammopathy
 ;;^UTILITY(U,$J,358.3,16168,1,4,0)
 ;;=4^D47.2
 ;;^UTILITY(U,$J,358.3,16168,2)
 ;;=^5002257
 ;;^UTILITY(U,$J,358.3,16169,0)
 ;;=C90.00^^61^724^29
 ;;^UTILITY(U,$J,358.3,16169,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16169,1,3,0)
 ;;=3^Multiple Myeloma,Not in Remission
 ;;^UTILITY(U,$J,358.3,16169,1,4,0)
 ;;=4^C90.00
 ;;^UTILITY(U,$J,358.3,16169,2)
 ;;=^5001752
 ;;^UTILITY(U,$J,358.3,16170,0)
 ;;=C84.00^^61^724^31
 ;;^UTILITY(U,$J,358.3,16170,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16170,1,3,0)
 ;;=3^Mycosis Fungoides,Unspec Site
 ;;^UTILITY(U,$J,358.3,16170,1,4,0)
 ;;=4^C84.00
 ;;^UTILITY(U,$J,358.3,16170,2)
 ;;=^5001621
 ;;^UTILITY(U,$J,358.3,16171,0)
 ;;=C84.09^^61^724^30
 ;;^UTILITY(U,$J,358.3,16171,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16171,1,3,0)
 ;;=3^Mycosis Fungoides,Extrnod & Solid Org Sites
 ;;^UTILITY(U,$J,358.3,16171,1,4,0)
 ;;=4^C84.09
 ;;^UTILITY(U,$J,358.3,16171,2)
 ;;=^5001630
 ;;^UTILITY(U,$J,358.3,16172,0)
 ;;=C79.71^^61^725^2
 ;;^UTILITY(U,$J,358.3,16172,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16172,1,3,0)
 ;;=3^Malig Neop Adrenal Gland,Right,Secondary
 ;;^UTILITY(U,$J,358.3,16172,1,4,0)
 ;;=4^C79.71
 ;;^UTILITY(U,$J,358.3,16172,2)
 ;;=^5001356
 ;;^UTILITY(U,$J,358.3,16173,0)
 ;;=C79.72^^61^725^1
 ;;^UTILITY(U,$J,358.3,16173,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16173,1,3,0)
 ;;=3^Malig Neop Adrenal Gland,Left,Secondary
 ;;^UTILITY(U,$J,358.3,16173,1,4,0)
 ;;=4^C79.72
 ;;^UTILITY(U,$J,358.3,16173,2)
 ;;=^5001357
 ;;^UTILITY(U,$J,358.3,16174,0)
 ;;=C79.51^^61^725^5
 ;;^UTILITY(U,$J,358.3,16174,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16174,1,3,0)
 ;;=3^Malig Neop Bone,Secondary
 ;;^UTILITY(U,$J,358.3,16174,1,4,0)
 ;;=4^C79.51
 ;;^UTILITY(U,$J,358.3,16174,2)
 ;;=^5001350
 ;;^UTILITY(U,$J,358.3,16175,0)
 ;;=C79.52^^61^725^4
 ;;^UTILITY(U,$J,358.3,16175,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16175,1,3,0)
 ;;=3^Malig Neop Bone Marrow,Secondary
 ;;^UTILITY(U,$J,358.3,16175,1,4,0)
 ;;=4^C79.52
 ;;^UTILITY(U,$J,358.3,16175,2)
 ;;=^5001351
