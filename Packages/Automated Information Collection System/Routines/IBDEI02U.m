IBDEI02U ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,868,2)
 ;;=^5001263
 ;;^UTILITY(U,$J,358.3,869,0)
 ;;=C64.2^^6^100^9
 ;;^UTILITY(U,$J,358.3,869,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,869,1,3,0)
 ;;=3^Malig Neop Left Kidney,Except Renal Pelvis
 ;;^UTILITY(U,$J,358.3,869,1,4,0)
 ;;=4^C64.2
 ;;^UTILITY(U,$J,358.3,869,2)
 ;;=^5001249
 ;;^UTILITY(U,$J,358.3,870,0)
 ;;=C64.1^^6^100^13
 ;;^UTILITY(U,$J,358.3,870,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,870,1,3,0)
 ;;=3^Malig Neop Right Kidney,Except Renal Pelvis
 ;;^UTILITY(U,$J,358.3,870,1,4,0)
 ;;=4^C64.1
 ;;^UTILITY(U,$J,358.3,870,2)
 ;;=^5001248
 ;;^UTILITY(U,$J,358.3,871,0)
 ;;=C79.51^^6^100^16
 ;;^UTILITY(U,$J,358.3,871,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,871,1,3,0)
 ;;=3^Secondary Malig Neop Bone
 ;;^UTILITY(U,$J,358.3,871,1,4,0)
 ;;=4^C79.51
 ;;^UTILITY(U,$J,358.3,871,2)
 ;;=^5001350
 ;;^UTILITY(U,$J,358.3,872,0)
 ;;=C79.52^^6^100^17
 ;;^UTILITY(U,$J,358.3,872,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,872,1,3,0)
 ;;=3^Secondary Malig Neop Bone Marrow
 ;;^UTILITY(U,$J,358.3,872,1,4,0)
 ;;=4^C79.52
 ;;^UTILITY(U,$J,358.3,872,2)
 ;;=^5001351
 ;;^UTILITY(U,$J,358.3,873,0)
 ;;=Z12.9^^6^100^15
 ;;^UTILITY(U,$J,358.3,873,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,873,1,3,0)
 ;;=3^Screening Malig Neop Site Unspec
 ;;^UTILITY(U,$J,358.3,873,1,4,0)
 ;;=4^Z12.9
 ;;^UTILITY(U,$J,358.3,873,2)
 ;;=^5062698
 ;;^UTILITY(U,$J,358.3,874,0)
 ;;=D17.9^^6^100^2
 ;;^UTILITY(U,$J,358.3,874,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,874,1,3,0)
 ;;=3^Benign Neop Lipomatous,Unspec
 ;;^UTILITY(U,$J,358.3,874,1,4,0)
 ;;=4^D17.9
 ;;^UTILITY(U,$J,358.3,874,2)
 ;;=^5002020
 ;;^UTILITY(U,$J,358.3,875,0)
 ;;=E11.9^^6^101^15
 ;;^UTILITY(U,$J,358.3,875,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,875,1,3,0)
 ;;=3^Diabetes Type 2 w/o Complications
 ;;^UTILITY(U,$J,358.3,875,1,4,0)
 ;;=4^E11.9
 ;;^UTILITY(U,$J,358.3,875,2)
 ;;=^5002666
 ;;^UTILITY(U,$J,358.3,876,0)
 ;;=E10.9^^6^101^12
 ;;^UTILITY(U,$J,358.3,876,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,876,1,3,0)
 ;;=3^Diabetes Type 1 w/o Complications
 ;;^UTILITY(U,$J,358.3,876,1,4,0)
 ;;=4^E10.9
 ;;^UTILITY(U,$J,358.3,876,2)
 ;;=^5002626
 ;;^UTILITY(U,$J,358.3,877,0)
 ;;=E11.65^^6^101^14
 ;;^UTILITY(U,$J,358.3,877,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,877,1,3,0)
 ;;=3^Diabetes Type 2 w/ Hyperglycemia
 ;;^UTILITY(U,$J,358.3,877,1,4,0)
 ;;=4^E11.65
 ;;^UTILITY(U,$J,358.3,877,2)
 ;;=^5002663
 ;;^UTILITY(U,$J,358.3,878,0)
 ;;=E10.65^^6^101^11
 ;;^UTILITY(U,$J,358.3,878,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,878,1,3,0)
 ;;=3^Diabetes Type 1 w/ Hyperglycemia
 ;;^UTILITY(U,$J,358.3,878,1,4,0)
 ;;=4^E10.65
 ;;^UTILITY(U,$J,358.3,878,2)
 ;;=^5002623
 ;;^UTILITY(U,$J,358.3,879,0)
 ;;=E86.0^^6^101^1
 ;;^UTILITY(U,$J,358.3,879,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,879,1,3,0)
 ;;=3^Dehydration
 ;;^UTILITY(U,$J,358.3,879,1,4,0)
 ;;=4^E86.0
 ;;^UTILITY(U,$J,358.3,879,2)
 ;;=^332743
 ;;^UTILITY(U,$J,358.3,880,0)
 ;;=F03.90^^6^101^4
 ;;^UTILITY(U,$J,358.3,880,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,880,1,3,0)
 ;;=3^Dementia w/o Behavioral Disturbance
 ;;^UTILITY(U,$J,358.3,880,1,4,0)
 ;;=4^F03.90
 ;;^UTILITY(U,$J,358.3,880,2)
 ;;=^5003050
 ;;^UTILITY(U,$J,358.3,881,0)
 ;;=F02.80^^6^101^3
 ;;^UTILITY(U,$J,358.3,881,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,881,1,3,0)
 ;;=3^Dementia in Oth Diseases w/o Behavioral Disturbance
 ;;^UTILITY(U,$J,358.3,881,1,4,0)
 ;;=4^F02.80
 ;;^UTILITY(U,$J,358.3,881,2)
 ;;=^5003048
 ;;^UTILITY(U,$J,358.3,882,0)
 ;;=F02.81^^6^101^2
 ;;^UTILITY(U,$J,358.3,882,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,882,1,3,0)
 ;;=3^Dementia in Oth Diseases w/ Behavioral Disturbance
