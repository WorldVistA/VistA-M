IBDEI2CN ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,39455,1,4,0)
 ;;=4^M12.541
 ;;^UTILITY(U,$J,358.3,39455,2)
 ;;=^5010628
 ;;^UTILITY(U,$J,358.3,39456,0)
 ;;=M12.551^^183^2023^54
 ;;^UTILITY(U,$J,358.3,39456,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39456,1,3,0)
 ;;=3^Traumatic arthropathy, right hip
 ;;^UTILITY(U,$J,358.3,39456,1,4,0)
 ;;=4^M12.551
 ;;^UTILITY(U,$J,358.3,39456,2)
 ;;=^5010631
 ;;^UTILITY(U,$J,358.3,39457,0)
 ;;=M12.561^^183^2023^55
 ;;^UTILITY(U,$J,358.3,39457,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39457,1,3,0)
 ;;=3^Traumatic arthropathy, right knee
 ;;^UTILITY(U,$J,358.3,39457,1,4,0)
 ;;=4^M12.561
 ;;^UTILITY(U,$J,358.3,39457,2)
 ;;=^5010634
 ;;^UTILITY(U,$J,358.3,39458,0)
 ;;=M12.511^^183^2023^56
 ;;^UTILITY(U,$J,358.3,39458,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39458,1,3,0)
 ;;=3^Traumatic arthropathy, right shoulder
 ;;^UTILITY(U,$J,358.3,39458,1,4,0)
 ;;=4^M12.511
 ;;^UTILITY(U,$J,358.3,39458,2)
 ;;=^5010619
 ;;^UTILITY(U,$J,358.3,39459,0)
 ;;=M12.531^^183^2023^57
 ;;^UTILITY(U,$J,358.3,39459,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39459,1,3,0)
 ;;=3^Traumatic arthropathy, right wrist
 ;;^UTILITY(U,$J,358.3,39459,1,4,0)
 ;;=4^M12.531
 ;;^UTILITY(U,$J,358.3,39459,2)
 ;;=^5010625
 ;;^UTILITY(U,$J,358.3,39460,0)
 ;;=M12.9^^183^2023^1
 ;;^UTILITY(U,$J,358.3,39460,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39460,1,3,0)
 ;;=3^Arthropathy, unspecified
 ;;^UTILITY(U,$J,358.3,39460,1,4,0)
 ;;=4^M12.9
 ;;^UTILITY(U,$J,358.3,39460,2)
 ;;=^5010666
 ;;^UTILITY(U,$J,358.3,39461,0)
 ;;=M18.9^^183^2023^16
 ;;^UTILITY(U,$J,358.3,39461,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39461,1,3,0)
 ;;=3^Osteoarthritis of first carpometacarpal joint, unspecified
 ;;^UTILITY(U,$J,358.3,39461,1,4,0)
 ;;=4^M18.9
 ;;^UTILITY(U,$J,358.3,39461,2)
 ;;=^5010807
 ;;^UTILITY(U,$J,358.3,39462,0)
 ;;=M16.9^^183^2023^17
 ;;^UTILITY(U,$J,358.3,39462,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39462,1,3,0)
 ;;=3^Osteoarthritis of hip, unspecified
 ;;^UTILITY(U,$J,358.3,39462,1,4,0)
 ;;=4^M16.9
 ;;^UTILITY(U,$J,358.3,39462,2)
 ;;=^5010783
 ;;^UTILITY(U,$J,358.3,39463,0)
 ;;=M17.9^^183^2023^18
 ;;^UTILITY(U,$J,358.3,39463,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39463,1,3,0)
 ;;=3^Osteoarthritis of knee, unspecified
 ;;^UTILITY(U,$J,358.3,39463,1,4,0)
 ;;=4^M17.9
 ;;^UTILITY(U,$J,358.3,39463,2)
 ;;=^5010794
 ;;^UTILITY(U,$J,358.3,39464,0)
 ;;=M15.0^^183^2023^19
 ;;^UTILITY(U,$J,358.3,39464,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39464,1,3,0)
 ;;=3^Primary generalized (osteo)arthritis
 ;;^UTILITY(U,$J,358.3,39464,1,4,0)
 ;;=4^M15.0
 ;;^UTILITY(U,$J,358.3,39464,2)
 ;;=^5010762
 ;;^UTILITY(U,$J,358.3,39465,0)
 ;;=M19.072^^183^2023^20
 ;;^UTILITY(U,$J,358.3,39465,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39465,1,3,0)
 ;;=3^Primary osteoarthritis, left ankle and foot
 ;;^UTILITY(U,$J,358.3,39465,1,4,0)
 ;;=4^M19.072
 ;;^UTILITY(U,$J,358.3,39465,2)
 ;;=^5010821
 ;;^UTILITY(U,$J,358.3,39466,0)
 ;;=M19.042^^183^2023^21
 ;;^UTILITY(U,$J,358.3,39466,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39466,1,3,0)
 ;;=3^Primary osteoarthritis, left hand
 ;;^UTILITY(U,$J,358.3,39466,1,4,0)
 ;;=4^M19.042
 ;;^UTILITY(U,$J,358.3,39466,2)
 ;;=^5010818
 ;;^UTILITY(U,$J,358.3,39467,0)
 ;;=M19.012^^183^2023^22
 ;;^UTILITY(U,$J,358.3,39467,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39467,1,3,0)
 ;;=3^Primary osteoarthritis, left shoulder
 ;;^UTILITY(U,$J,358.3,39467,1,4,0)
 ;;=4^M19.012
 ;;^UTILITY(U,$J,358.3,39467,2)
 ;;=^5010809
 ;;^UTILITY(U,$J,358.3,39468,0)
 ;;=M19.071^^183^2023^23
 ;;^UTILITY(U,$J,358.3,39468,1,0)
 ;;=^358.31IA^4^2
