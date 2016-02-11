IBDEI03K ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,953,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,953,1,3,0)
 ;;=3^Asthma Uncomplicated,Unspec
 ;;^UTILITY(U,$J,358.3,953,1,4,0)
 ;;=4^J45.909
 ;;^UTILITY(U,$J,358.3,953,2)
 ;;=^5008256
 ;;^UTILITY(U,$J,358.3,954,0)
 ;;=M12.9^^12^119^17
 ;;^UTILITY(U,$J,358.3,954,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,954,1,3,0)
 ;;=3^Arthropathy,Unspec
 ;;^UTILITY(U,$J,358.3,954,1,4,0)
 ;;=4^M12.9
 ;;^UTILITY(U,$J,358.3,954,2)
 ;;=^5010666
 ;;^UTILITY(U,$J,358.3,955,0)
 ;;=T78.40XA^^12^119^11
 ;;^UTILITY(U,$J,358.3,955,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,955,1,3,0)
 ;;=3^Allergy,Unspec Initial Encounter
 ;;^UTILITY(U,$J,358.3,955,1,4,0)
 ;;=4^T78.40XA
 ;;^UTILITY(U,$J,358.3,955,2)
 ;;=^5054284
 ;;^UTILITY(U,$J,358.3,956,0)
 ;;=L40.2^^12^119^6
 ;;^UTILITY(U,$J,358.3,956,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,956,1,3,0)
 ;;=3^Acrodermatitis Continua
 ;;^UTILITY(U,$J,358.3,956,1,4,0)
 ;;=4^L40.2
 ;;^UTILITY(U,$J,358.3,956,2)
 ;;=^5009162
 ;;^UTILITY(U,$J,358.3,957,0)
 ;;=R10.9^^12^119^3
 ;;^UTILITY(U,$J,358.3,957,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,957,1,3,0)
 ;;=3^Abdominal Pain,Unspec
 ;;^UTILITY(U,$J,358.3,957,1,4,0)
 ;;=4^R10.9
 ;;^UTILITY(U,$J,358.3,957,2)
 ;;=^5019230
 ;;^UTILITY(U,$J,358.3,958,0)
 ;;=F10.10^^12^119^8
 ;;^UTILITY(U,$J,358.3,958,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,958,1,3,0)
 ;;=3^Alcohol Abuse Uncomplicated
 ;;^UTILITY(U,$J,358.3,958,1,4,0)
 ;;=4^F10.10
 ;;^UTILITY(U,$J,358.3,958,2)
 ;;=^5003068
 ;;^UTILITY(U,$J,358.3,959,0)
 ;;=F43.0^^12^119^7
 ;;^UTILITY(U,$J,358.3,959,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,959,1,3,0)
 ;;=3^Acute Stress Reaction
 ;;^UTILITY(U,$J,358.3,959,1,4,0)
 ;;=4^F43.0
 ;;^UTILITY(U,$J,358.3,959,2)
 ;;=^5003569
 ;;^UTILITY(U,$J,358.3,960,0)
 ;;=Z89.511^^12^119^5
 ;;^UTILITY(U,$J,358.3,960,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,960,1,3,0)
 ;;=3^Acquired Absence Right Leg Below Knee
 ;;^UTILITY(U,$J,358.3,960,1,4,0)
 ;;=4^Z89.511
 ;;^UTILITY(U,$J,358.3,960,2)
 ;;=^5063566
 ;;^UTILITY(U,$J,358.3,961,0)
 ;;=Z89.512^^12^119^4
 ;;^UTILITY(U,$J,358.3,961,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,961,1,3,0)
 ;;=3^Acquired Absence Left Leg Below Knee
 ;;^UTILITY(U,$J,358.3,961,1,4,0)
 ;;=4^Z89.512
 ;;^UTILITY(U,$J,358.3,961,2)
 ;;=^5063567
 ;;^UTILITY(U,$J,358.3,962,0)
 ;;=E53.8^^12^120^1
 ;;^UTILITY(U,$J,358.3,962,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,962,1,3,0)
 ;;=3^B Vitamin Group Deficiency
 ;;^UTILITY(U,$J,358.3,962,1,4,0)
 ;;=4^E53.8
 ;;^UTILITY(U,$J,358.3,962,2)
 ;;=^5002797
 ;;^UTILITY(U,$J,358.3,963,0)
 ;;=F31.9^^12^120^2
 ;;^UTILITY(U,$J,358.3,963,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,963,1,3,0)
 ;;=3^Bipolar Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,963,1,4,0)
 ;;=4^F31.9
 ;;^UTILITY(U,$J,358.3,963,2)
 ;;=^331892
 ;;^UTILITY(U,$J,358.3,964,0)
 ;;=R00.1^^12^120^5
 ;;^UTILITY(U,$J,358.3,964,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,964,1,3,0)
 ;;=3^Bradycardia,Unspec
 ;;^UTILITY(U,$J,358.3,964,1,4,0)
 ;;=4^R00.1
 ;;^UTILITY(U,$J,358.3,964,2)
 ;;=^5019164
 ;;^UTILITY(U,$J,358.3,965,0)
 ;;=J20.9^^12^120^6
 ;;^UTILITY(U,$J,358.3,965,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,965,1,3,0)
 ;;=3^Bronchitis,Acute,Unspec
 ;;^UTILITY(U,$J,358.3,965,1,4,0)
 ;;=4^J20.9
 ;;^UTILITY(U,$J,358.3,965,2)
 ;;=^5008195
 ;;^UTILITY(U,$J,358.3,966,0)
 ;;=N32.0^^12^120^3
 ;;^UTILITY(U,$J,358.3,966,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,966,1,3,0)
 ;;=3^Bladder-Neck Obstruction
 ;;^UTILITY(U,$J,358.3,966,1,4,0)
 ;;=4^N32.0
 ;;^UTILITY(U,$J,358.3,966,2)
 ;;=^5015649
 ;;^UTILITY(U,$J,358.3,967,0)
 ;;=M71.50^^12^120^7
