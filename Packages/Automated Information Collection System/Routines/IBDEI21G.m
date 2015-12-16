IBDEI21G ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,35618,1,4,0)
 ;;=4^C90.31
 ;;^UTILITY(U,$J,358.3,35618,2)
 ;;=^5001760
 ;;^UTILITY(U,$J,358.3,35619,0)
 ;;=C88.8^^189^2057^33
 ;;^UTILITY(U,$J,358.3,35619,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35619,1,3,0)
 ;;=3^Malignant immunoproliferative diseases NEC
 ;;^UTILITY(U,$J,358.3,35619,1,4,0)
 ;;=4^C88.8
 ;;^UTILITY(U,$J,358.3,35619,2)
 ;;=^5001750
 ;;^UTILITY(U,$J,358.3,35620,0)
 ;;=C90.22^^189^2057^24
 ;;^UTILITY(U,$J,358.3,35620,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35620,1,3,0)
 ;;=3^Extramedullary plasmacytoma in relapse
 ;;^UTILITY(U,$J,358.3,35620,1,4,0)
 ;;=4^C90.22
 ;;^UTILITY(U,$J,358.3,35620,2)
 ;;=^5001758
 ;;^UTILITY(U,$J,358.3,35621,0)
 ;;=C90.32^^189^2057^49
 ;;^UTILITY(U,$J,358.3,35621,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35621,1,3,0)
 ;;=3^Solitary plasmacytoma in relapse
 ;;^UTILITY(U,$J,358.3,35621,1,4,0)
 ;;=4^C90.32
 ;;^UTILITY(U,$J,358.3,35621,2)
 ;;=^5001761
 ;;^UTILITY(U,$J,358.3,35622,0)
 ;;=C91.01^^189^2057^2
 ;;^UTILITY(U,$J,358.3,35622,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35622,1,3,0)
 ;;=3^Acute lymphoblastic leukemia, in remission
 ;;^UTILITY(U,$J,358.3,35622,1,4,0)
 ;;=4^C91.01
 ;;^UTILITY(U,$J,358.3,35622,2)
 ;;=^5001763
 ;;^UTILITY(U,$J,358.3,35623,0)
 ;;=C91.02^^189^2057^1
 ;;^UTILITY(U,$J,358.3,35623,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35623,1,3,0)
 ;;=3^Acute lymphoblastic leukemia, in relapse
 ;;^UTILITY(U,$J,358.3,35623,1,4,0)
 ;;=4^C91.02
 ;;^UTILITY(U,$J,358.3,35623,2)
 ;;=^5001764
 ;;^UTILITY(U,$J,358.3,35624,0)
 ;;=C91.11^^189^2057^16
 ;;^UTILITY(U,$J,358.3,35624,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35624,1,3,0)
 ;;=3^Chronic lymphocytic leukemia of B-cell type in remission
 ;;^UTILITY(U,$J,358.3,35624,1,4,0)
 ;;=4^C91.11
 ;;^UTILITY(U,$J,358.3,35624,2)
 ;;=^5001766
 ;;^UTILITY(U,$J,358.3,35625,0)
 ;;=C91.12^^189^2057^17
 ;;^UTILITY(U,$J,358.3,35625,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35625,1,3,0)
 ;;=3^Chronic lymphocytic leukemia of B-cell type in relapse
 ;;^UTILITY(U,$J,358.3,35625,1,4,0)
 ;;=4^C91.12
 ;;^UTILITY(U,$J,358.3,35625,2)
 ;;=^5001767
 ;;^UTILITY(U,$J,358.3,35626,0)
 ;;=C91.Z1^^189^2057^32
 ;;^UTILITY(U,$J,358.3,35626,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35626,1,3,0)
 ;;=3^Lymphoid leukemia, in remission NEC
 ;;^UTILITY(U,$J,358.3,35626,1,4,0)
 ;;=4^C91.Z1
 ;;^UTILITY(U,$J,358.3,35626,2)
 ;;=^5001787
 ;;^UTILITY(U,$J,358.3,35627,0)
 ;;=C91.Z2^^189^2057^31
 ;;^UTILITY(U,$J,358.3,35627,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35627,1,3,0)
 ;;=3^Lymphoid leukemia, in relapse NEC
 ;;^UTILITY(U,$J,358.3,35627,1,4,0)
 ;;=4^C91.Z2
 ;;^UTILITY(U,$J,358.3,35627,2)
 ;;=^5001788
 ;;^UTILITY(U,$J,358.3,35628,0)
 ;;=C92.01^^189^2057^6
 ;;^UTILITY(U,$J,358.3,35628,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35628,1,3,0)
 ;;=3^Acute myeloblastic leukemia, in remission
 ;;^UTILITY(U,$J,358.3,35628,1,4,0)
 ;;=4^C92.01
 ;;^UTILITY(U,$J,358.3,35628,2)
 ;;=^5001790
 ;;^UTILITY(U,$J,358.3,35629,0)
 ;;=C92.41^^189^2057^10
 ;;^UTILITY(U,$J,358.3,35629,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35629,1,3,0)
 ;;=3^Acute promyelocytic leukemia, in remission
 ;;^UTILITY(U,$J,358.3,35629,1,4,0)
 ;;=4^C92.41
 ;;^UTILITY(U,$J,358.3,35629,2)
 ;;=^5001802
 ;;^UTILITY(U,$J,358.3,35630,0)
 ;;=C92.51^^189^2057^8
 ;;^UTILITY(U,$J,358.3,35630,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35630,1,3,0)
 ;;=3^Acute myelomonocytic leukemia, in remission
 ;;^UTILITY(U,$J,358.3,35630,1,4,0)
 ;;=4^C92.51
 ;;^UTILITY(U,$J,358.3,35630,2)
 ;;=^5001805
 ;;^UTILITY(U,$J,358.3,35631,0)
 ;;=C92.02^^189^2057^5
