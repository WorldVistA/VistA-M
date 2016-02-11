IBDEI0JP ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8877,0)
 ;;=Z87.01^^55^550^27
 ;;^UTILITY(U,$J,358.3,8877,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8877,1,3,0)
 ;;=3^Personal history of pneumonia (recurrent)
 ;;^UTILITY(U,$J,358.3,8877,1,4,0)
 ;;=4^Z87.01
 ;;^UTILITY(U,$J,358.3,8877,2)
 ;;=^5063480
 ;;^UTILITY(U,$J,358.3,8878,0)
 ;;=Z86.010^^55^550^3
 ;;^UTILITY(U,$J,358.3,8878,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8878,1,3,0)
 ;;=3^Personal history of colonic polyps
 ;;^UTILITY(U,$J,358.3,8878,1,4,0)
 ;;=4^Z86.010
 ;;^UTILITY(U,$J,358.3,8878,2)
 ;;=^5063456
 ;;^UTILITY(U,$J,358.3,8879,0)
 ;;=Z87.440^^55^550^28
 ;;^UTILITY(U,$J,358.3,8879,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8879,1,3,0)
 ;;=3^Personal history of urinary (tract) infections
 ;;^UTILITY(U,$J,358.3,8879,1,4,0)
 ;;=4^Z87.440
 ;;^UTILITY(U,$J,358.3,8879,2)
 ;;=^5063495
 ;;^UTILITY(U,$J,358.3,8880,0)
 ;;=Z87.441^^55^550^26
 ;;^UTILITY(U,$J,358.3,8880,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8880,1,3,0)
 ;;=3^Personal history of nephrotic syndrome
 ;;^UTILITY(U,$J,358.3,8880,1,4,0)
 ;;=4^Z87.441
 ;;^UTILITY(U,$J,358.3,8880,2)
 ;;=^5063496
 ;;^UTILITY(U,$J,358.3,8881,0)
 ;;=Z91.81^^55^550^1
 ;;^UTILITY(U,$J,358.3,8881,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8881,1,3,0)
 ;;=3^History of falling
 ;;^UTILITY(U,$J,358.3,8881,1,4,0)
 ;;=4^Z91.81
 ;;^UTILITY(U,$J,358.3,8881,2)
 ;;=^5063625
 ;;^UTILITY(U,$J,358.3,8882,0)
 ;;=R09.1^^55^551^6
 ;;^UTILITY(U,$J,358.3,8882,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8882,1,3,0)
 ;;=3^Pleurisy
 ;;^UTILITY(U,$J,358.3,8882,1,4,0)
 ;;=4^R09.1
 ;;^UTILITY(U,$J,358.3,8882,2)
 ;;=^95428
 ;;^UTILITY(U,$J,358.3,8883,0)
 ;;=J91.0^^55^551^3
 ;;^UTILITY(U,$J,358.3,8883,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8883,1,3,0)
 ;;=3^Malignant pleural effusion
 ;;^UTILITY(U,$J,358.3,8883,1,4,0)
 ;;=4^J91.0
 ;;^UTILITY(U,$J,358.3,8883,2)
 ;;=^336603
 ;;^UTILITY(U,$J,358.3,8884,0)
 ;;=J90.^^55^551^5
 ;;^UTILITY(U,$J,358.3,8884,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8884,1,3,0)
 ;;=3^Pleural effusion, not elsewhere classified
 ;;^UTILITY(U,$J,358.3,8884,1,4,0)
 ;;=4^J90.
 ;;^UTILITY(U,$J,358.3,8884,2)
 ;;=^5008310
 ;;^UTILITY(U,$J,358.3,8885,0)
 ;;=J91.8^^55^551^4
 ;;^UTILITY(U,$J,358.3,8885,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8885,1,3,0)
 ;;=3^Pleural effusion in other conditions classified elsewhere
 ;;^UTILITY(U,$J,358.3,8885,1,4,0)
 ;;=4^J91.8
 ;;^UTILITY(U,$J,358.3,8885,2)
 ;;=^5008311
 ;;^UTILITY(U,$J,358.3,8886,0)
 ;;=J93.0^^55^551^10
 ;;^UTILITY(U,$J,358.3,8886,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8886,1,3,0)
 ;;=3^Spontaneous tension pneumothorax
 ;;^UTILITY(U,$J,358.3,8886,1,4,0)
 ;;=4^J93.0
 ;;^UTILITY(U,$J,358.3,8886,2)
 ;;=^269987
 ;;^UTILITY(U,$J,358.3,8887,0)
 ;;=J93.11^^55^551^8
 ;;^UTILITY(U,$J,358.3,8887,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8887,1,3,0)
 ;;=3^Primary spontaneous pneumothorax
 ;;^UTILITY(U,$J,358.3,8887,1,4,0)
 ;;=4^J93.11
 ;;^UTILITY(U,$J,358.3,8887,2)
 ;;=^340529
 ;;^UTILITY(U,$J,358.3,8888,0)
 ;;=J93.12^^55^551^9
 ;;^UTILITY(U,$J,358.3,8888,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8888,1,3,0)
 ;;=3^Secondary spontaneous pneumothorax
 ;;^UTILITY(U,$J,358.3,8888,1,4,0)
 ;;=4^J93.12
 ;;^UTILITY(U,$J,358.3,8888,2)
 ;;=^340530
 ;;^UTILITY(U,$J,358.3,8889,0)
 ;;=J93.81^^55^551^2
 ;;^UTILITY(U,$J,358.3,8889,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8889,1,3,0)
 ;;=3^Chronic pneumothorax
 ;;^UTILITY(U,$J,358.3,8889,1,4,0)
 ;;=4^J93.81
 ;;^UTILITY(U,$J,358.3,8889,2)
 ;;=^340531
 ;;^UTILITY(U,$J,358.3,8890,0)
 ;;=J93.82^^55^551^1
 ;;^UTILITY(U,$J,358.3,8890,1,0)
 ;;=^358.31IA^4^2
