IBDEI0YD ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,16138,1,3,0)
 ;;=3^Myeloid Leukemia,BCR/ABL-Positive,Chr,In Remission
 ;;^UTILITY(U,$J,358.3,16138,1,4,0)
 ;;=4^C92.11
 ;;^UTILITY(U,$J,358.3,16138,2)
 ;;=^5001793
 ;;^UTILITY(U,$J,358.3,16139,0)
 ;;=C92.10^^61^724^34
 ;;^UTILITY(U,$J,358.3,16139,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16139,1,3,0)
 ;;=3^Myeloid Leukemia,BCR/ABL-Positive,Chr,Not in Remission
 ;;^UTILITY(U,$J,358.3,16139,1,4,0)
 ;;=4^C92.10
 ;;^UTILITY(U,$J,358.3,16139,2)
 ;;=^5001792
 ;;^UTILITY(U,$J,358.3,16140,0)
 ;;=C91.40^^61^724^7
 ;;^UTILITY(U,$J,358.3,16140,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16140,1,3,0)
 ;;=3^Hairy Cell Leukemia,Not in Remission
 ;;^UTILITY(U,$J,358.3,16140,1,4,0)
 ;;=4^C91.40
 ;;^UTILITY(U,$J,358.3,16140,2)
 ;;=^5001771
 ;;^UTILITY(U,$J,358.3,16141,0)
 ;;=C81.90^^61^724^19
 ;;^UTILITY(U,$J,358.3,16141,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16141,1,3,0)
 ;;=3^Hodgkin Lymphoma,Unspec Site
 ;;^UTILITY(U,$J,358.3,16141,1,4,0)
 ;;=4^C81.90
 ;;^UTILITY(U,$J,358.3,16141,2)
 ;;=^5001451
 ;;^UTILITY(U,$J,358.3,16142,0)
 ;;=C81.99^^61^724^26
 ;;^UTILITY(U,$J,358.3,16142,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16142,1,3,0)
 ;;=3^Lymphoma,Extrnod & Solid Org Sites,Unspec
 ;;^UTILITY(U,$J,358.3,16142,1,4,0)
 ;;=4^C81.99
 ;;^UTILITY(U,$J,358.3,16142,2)
 ;;=^5001460
 ;;^UTILITY(U,$J,358.3,16143,0)
 ;;=C81.00^^61^724^16
 ;;^UTILITY(U,$J,358.3,16143,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16143,1,3,0)
 ;;=3^Hodgkin Lymphoma,Nodular Lymphocyte,Unspec Site
 ;;^UTILITY(U,$J,358.3,16143,1,4,0)
 ;;=4^C81.00
 ;;^UTILITY(U,$J,358.3,16143,2)
 ;;=^5001391
 ;;^UTILITY(U,$J,358.3,16144,0)
 ;;=C81.09^^61^724^15
 ;;^UTILITY(U,$J,358.3,16144,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16144,1,3,0)
 ;;=3^Hodgkin Lymphoma,Nodular Lymphocyte,Extrnod & Solid Org Site
 ;;^UTILITY(U,$J,358.3,16144,1,4,0)
 ;;=4^C81.09
 ;;^UTILITY(U,$J,358.3,16144,2)
 ;;=^5001400
 ;;^UTILITY(U,$J,358.3,16145,0)
 ;;=C81.40^^61^724^12
 ;;^UTILITY(U,$J,358.3,16145,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16145,1,3,0)
 ;;=3^Hodgkin Lymphoma,Lymphocyte-Rich,Unspec Site
 ;;^UTILITY(U,$J,358.3,16145,1,4,0)
 ;;=4^C81.40
 ;;^UTILITY(U,$J,358.3,16145,2)
 ;;=^5001431
 ;;^UTILITY(U,$J,358.3,16146,0)
 ;;=C81.49^^61^724^11
 ;;^UTILITY(U,$J,358.3,16146,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16146,1,3,0)
 ;;=3^Hodgkin Lymphoma,Lymphocyte-Rich,Extrnod & Solid Org Sites
 ;;^UTILITY(U,$J,358.3,16146,1,4,0)
 ;;=4^C81.49
 ;;^UTILITY(U,$J,358.3,16146,2)
 ;;=^5001440
 ;;^UTILITY(U,$J,358.3,16147,0)
 ;;=C81.30^^61^724^10
 ;;^UTILITY(U,$J,358.3,16147,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16147,1,3,0)
 ;;=3^Hodgkin Lymphoma,Lymphocyte Depleted,Unspec Site
 ;;^UTILITY(U,$J,358.3,16147,1,4,0)
 ;;=4^C81.30
 ;;^UTILITY(U,$J,358.3,16147,2)
 ;;=^5001421
 ;;^UTILITY(U,$J,358.3,16148,0)
 ;;=C81.39^^61^724^9
 ;;^UTILITY(U,$J,358.3,16148,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16148,1,3,0)
 ;;=3^Hodgkin Lymphoma,Lymphocyte Depleted,Extrnod & Solid Org Site
 ;;^UTILITY(U,$J,358.3,16148,1,4,0)
 ;;=4^C81.39
 ;;^UTILITY(U,$J,358.3,16148,2)
 ;;=^5001430
 ;;^UTILITY(U,$J,358.3,16149,0)
 ;;=C81.20^^61^724^14
 ;;^UTILITY(U,$J,358.3,16149,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16149,1,3,0)
 ;;=3^Hodgkin Lymphoma,Mixed Cellularity,Unspec Site
 ;;^UTILITY(U,$J,358.3,16149,1,4,0)
 ;;=4^C81.20
 ;;^UTILITY(U,$J,358.3,16149,2)
 ;;=^5001411
 ;;^UTILITY(U,$J,358.3,16150,0)
 ;;=C81.29^^61^724^13
 ;;^UTILITY(U,$J,358.3,16150,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16150,1,3,0)
 ;;=3^Hodgkin Lymphoma,Mixed Cellularity,Extrnod & Solid Org Sites
