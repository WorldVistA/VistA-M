IBDEI0J5 ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8615,1,3,0)
 ;;=3^Malig Neop Kidney,Except Renal Pelvis,Unspec
 ;;^UTILITY(U,$J,358.3,8615,1,4,0)
 ;;=4^C64.9
 ;;^UTILITY(U,$J,358.3,8615,2)
 ;;=^5001250
 ;;^UTILITY(U,$J,358.3,8616,0)
 ;;=C34.92^^39^401^138
 ;;^UTILITY(U,$J,358.3,8616,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8616,1,3,0)
 ;;=3^Malig Neop Left Bronchus/Lung,Unspec Part
 ;;^UTILITY(U,$J,358.3,8616,1,4,0)
 ;;=4^C34.92
 ;;^UTILITY(U,$J,358.3,8616,2)
 ;;=^5000968
 ;;^UTILITY(U,$J,358.3,8617,0)
 ;;=C34.90^^39^401^124
 ;;^UTILITY(U,$J,358.3,8617,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8617,1,3,0)
 ;;=3^Malig Neop Bronchus/Lung,Unspec Part
 ;;^UTILITY(U,$J,358.3,8617,1,4,0)
 ;;=4^C34.90
 ;;^UTILITY(U,$J,358.3,8617,2)
 ;;=^5000966
 ;;^UTILITY(U,$J,358.3,8618,0)
 ;;=C65.9^^39^401^158
 ;;^UTILITY(U,$J,358.3,8618,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8618,1,3,0)
 ;;=3^Malig Neop Renal Pelvis,Unspec
 ;;^UTILITY(U,$J,358.3,8618,1,4,0)
 ;;=4^C65.9
 ;;^UTILITY(U,$J,358.3,8618,2)
 ;;=^5001253
 ;;^UTILITY(U,$J,358.3,8619,0)
 ;;=C50.912^^39^401^139
 ;;^UTILITY(U,$J,358.3,8619,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8619,1,3,0)
 ;;=3^Malig Neop Left Female Breast,Unspec Site
 ;;^UTILITY(U,$J,358.3,8619,1,4,0)
 ;;=4^C50.912
 ;;^UTILITY(U,$J,358.3,8619,2)
 ;;=^5001196
 ;;^UTILITY(U,$J,358.3,8620,0)
 ;;=C50.911^^39^401^161
 ;;^UTILITY(U,$J,358.3,8620,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8620,1,3,0)
 ;;=3^Malig Neop Right Female Breast,Unspec Site
 ;;^UTILITY(U,$J,358.3,8620,1,4,0)
 ;;=4^C50.911
 ;;^UTILITY(U,$J,358.3,8620,2)
 ;;=^5001195
 ;;^UTILITY(U,$J,358.3,8621,0)
 ;;=C50.919^^39^401^131
 ;;^UTILITY(U,$J,358.3,8621,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8621,1,3,0)
 ;;=3^Malig Neop Female Breast,Unspec Site
 ;;^UTILITY(U,$J,358.3,8621,1,4,0)
 ;;=4^C50.919
 ;;^UTILITY(U,$J,358.3,8621,2)
 ;;=^5001197
 ;;^UTILITY(U,$J,358.3,8622,0)
 ;;=C62.90^^39^401^169
 ;;^UTILITY(U,$J,358.3,8622,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8622,1,3,0)
 ;;=3^Malig Neop Testis,Unspec
 ;;^UTILITY(U,$J,358.3,8622,1,4,0)
 ;;=4^C62.90
 ;;^UTILITY(U,$J,358.3,8622,2)
 ;;=^5001236
 ;;^UTILITY(U,$J,358.3,8623,0)
 ;;=D03.9^^39^401^174
 ;;^UTILITY(U,$J,358.3,8623,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8623,1,3,0)
 ;;=3^Melanoma in Situ,Unspec
 ;;^UTILITY(U,$J,358.3,8623,1,4,0)
 ;;=4^D03.9
 ;;^UTILITY(U,$J,358.3,8623,2)
 ;;=^5001908
 ;;^UTILITY(U,$J,358.3,8624,0)
 ;;=C45.0^^39^401^175
 ;;^UTILITY(U,$J,358.3,8624,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8624,1,3,0)
 ;;=3^Mesothelioma of Pleura
 ;;^UTILITY(U,$J,358.3,8624,1,4,0)
 ;;=4^C45.0
 ;;^UTILITY(U,$J,358.3,8624,2)
 ;;=^5001095
 ;;^UTILITY(U,$J,358.3,8625,0)
 ;;=C90.01^^39^401^177
 ;;^UTILITY(U,$J,358.3,8625,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8625,1,3,0)
 ;;=3^Multiple Myeloma,In Remission
 ;;^UTILITY(U,$J,358.3,8625,1,4,0)
 ;;=4^C90.01
 ;;^UTILITY(U,$J,358.3,8625,2)
 ;;=^267515
 ;;^UTILITY(U,$J,358.3,8626,0)
 ;;=C90.00^^39^401^178
 ;;^UTILITY(U,$J,358.3,8626,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8626,1,3,0)
 ;;=3^Multiple Myeloma,Not in Remission
 ;;^UTILITY(U,$J,358.3,8626,1,4,0)
 ;;=4^C90.00
 ;;^UTILITY(U,$J,358.3,8626,2)
 ;;=^5001752
 ;;^UTILITY(U,$J,358.3,8627,0)
 ;;=C94.6^^39^401^179
 ;;^UTILITY(U,$J,358.3,8627,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8627,1,3,0)
 ;;=3^Myelodysplastic Disease NEC
 ;;^UTILITY(U,$J,358.3,8627,1,4,0)
 ;;=4^C94.6
