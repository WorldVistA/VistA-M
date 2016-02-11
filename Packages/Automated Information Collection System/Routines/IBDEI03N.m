IBDEI03N ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,995,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,995,1,3,0)
 ;;=3^Malig Neop Left Female Breast,Unspec Site
 ;;^UTILITY(U,$J,358.3,995,1,4,0)
 ;;=4^C50.912
 ;;^UTILITY(U,$J,358.3,995,2)
 ;;=^5001196
 ;;^UTILITY(U,$J,358.3,996,0)
 ;;=C50.911^^12^122^12
 ;;^UTILITY(U,$J,358.3,996,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,996,1,3,0)
 ;;=3^Malig Neop Right Female Breast,Unspec Site
 ;;^UTILITY(U,$J,358.3,996,1,4,0)
 ;;=4^C50.911
 ;;^UTILITY(U,$J,358.3,996,2)
 ;;=^5001195
 ;;^UTILITY(U,$J,358.3,997,0)
 ;;=C61.^^12^122^10
 ;;^UTILITY(U,$J,358.3,997,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,997,1,3,0)
 ;;=3^Malig Neop Prostate
 ;;^UTILITY(U,$J,358.3,997,1,4,0)
 ;;=4^C61.
 ;;^UTILITY(U,$J,358.3,997,2)
 ;;=^267239
 ;;^UTILITY(U,$J,358.3,998,0)
 ;;=C67.9^^12^122^3
 ;;^UTILITY(U,$J,358.3,998,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,998,1,3,0)
 ;;=3^Malig Neop Bladder,Unspec
 ;;^UTILITY(U,$J,358.3,998,1,4,0)
 ;;=4^C67.9
 ;;^UTILITY(U,$J,358.3,998,2)
 ;;=^5001263
 ;;^UTILITY(U,$J,358.3,999,0)
 ;;=C64.2^^12^122^9
 ;;^UTILITY(U,$J,358.3,999,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,999,1,3,0)
 ;;=3^Malig Neop Left Kidney,Except Renal Pelvis
 ;;^UTILITY(U,$J,358.3,999,1,4,0)
 ;;=4^C64.2
 ;;^UTILITY(U,$J,358.3,999,2)
 ;;=^5001249
 ;;^UTILITY(U,$J,358.3,1000,0)
 ;;=C64.1^^12^122^13
 ;;^UTILITY(U,$J,358.3,1000,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1000,1,3,0)
 ;;=3^Malig Neop Right Kidney,Except Renal Pelvis
 ;;^UTILITY(U,$J,358.3,1000,1,4,0)
 ;;=4^C64.1
 ;;^UTILITY(U,$J,358.3,1000,2)
 ;;=^5001248
 ;;^UTILITY(U,$J,358.3,1001,0)
 ;;=C79.51^^12^122^16
 ;;^UTILITY(U,$J,358.3,1001,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1001,1,3,0)
 ;;=3^Secondary Malig Neop Bone
 ;;^UTILITY(U,$J,358.3,1001,1,4,0)
 ;;=4^C79.51
 ;;^UTILITY(U,$J,358.3,1001,2)
 ;;=^5001350
 ;;^UTILITY(U,$J,358.3,1002,0)
 ;;=C79.52^^12^122^17
 ;;^UTILITY(U,$J,358.3,1002,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1002,1,3,0)
 ;;=3^Secondary Malig Neop Bone Marrow
 ;;^UTILITY(U,$J,358.3,1002,1,4,0)
 ;;=4^C79.52
 ;;^UTILITY(U,$J,358.3,1002,2)
 ;;=^5001351
 ;;^UTILITY(U,$J,358.3,1003,0)
 ;;=Z12.9^^12^122^15
 ;;^UTILITY(U,$J,358.3,1003,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1003,1,3,0)
 ;;=3^Screening Malig Neop Site Unspec
 ;;^UTILITY(U,$J,358.3,1003,1,4,0)
 ;;=4^Z12.9
 ;;^UTILITY(U,$J,358.3,1003,2)
 ;;=^5062698
 ;;^UTILITY(U,$J,358.3,1004,0)
 ;;=D17.9^^12^122^2
 ;;^UTILITY(U,$J,358.3,1004,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1004,1,3,0)
 ;;=3^Benign Neop Lipomatous,Unspec
 ;;^UTILITY(U,$J,358.3,1004,1,4,0)
 ;;=4^D17.9
 ;;^UTILITY(U,$J,358.3,1004,2)
 ;;=^5002020
 ;;^UTILITY(U,$J,358.3,1005,0)
 ;;=E11.9^^12^123^15
 ;;^UTILITY(U,$J,358.3,1005,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1005,1,3,0)
 ;;=3^Diabetes Type 2 w/o Complications
 ;;^UTILITY(U,$J,358.3,1005,1,4,0)
 ;;=4^E11.9
 ;;^UTILITY(U,$J,358.3,1005,2)
 ;;=^5002666
 ;;^UTILITY(U,$J,358.3,1006,0)
 ;;=E10.9^^12^123^12
 ;;^UTILITY(U,$J,358.3,1006,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1006,1,3,0)
 ;;=3^Diabetes Type 1 w/o Complications
 ;;^UTILITY(U,$J,358.3,1006,1,4,0)
 ;;=4^E10.9
 ;;^UTILITY(U,$J,358.3,1006,2)
 ;;=^5002626
 ;;^UTILITY(U,$J,358.3,1007,0)
 ;;=E11.65^^12^123^14
 ;;^UTILITY(U,$J,358.3,1007,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1007,1,3,0)
 ;;=3^Diabetes Type 2 w/ Hyperglycemia
 ;;^UTILITY(U,$J,358.3,1007,1,4,0)
 ;;=4^E11.65
 ;;^UTILITY(U,$J,358.3,1007,2)
 ;;=^5002663
 ;;^UTILITY(U,$J,358.3,1008,0)
 ;;=E10.65^^12^123^11
 ;;^UTILITY(U,$J,358.3,1008,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1008,1,3,0)
 ;;=3^Diabetes Type 1 w/ Hyperglycemia
