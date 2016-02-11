IBDEI0JL ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8824,2)
 ;;=^5008473
 ;;^UTILITY(U,$J,358.3,8825,0)
 ;;=K12.2^^55^547^1
 ;;^UTILITY(U,$J,358.3,8825,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8825,1,3,0)
 ;;=3^Cellulitis and abscess of mouth
 ;;^UTILITY(U,$J,358.3,8825,1,4,0)
 ;;=4^K12.2
 ;;^UTILITY(U,$J,358.3,8825,2)
 ;;=^5008485
 ;;^UTILITY(U,$J,358.3,8826,0)
 ;;=K12.30^^55^547^4
 ;;^UTILITY(U,$J,358.3,8826,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8826,1,3,0)
 ;;=3^Oral mucositis (ulcerative), unspecified
 ;;^UTILITY(U,$J,358.3,8826,1,4,0)
 ;;=4^K12.30
 ;;^UTILITY(U,$J,358.3,8826,2)
 ;;=^5008486
 ;;^UTILITY(U,$J,358.3,8827,0)
 ;;=K12.0^^55^547^5
 ;;^UTILITY(U,$J,358.3,8827,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8827,1,3,0)
 ;;=3^Recurrent oral aphthae
 ;;^UTILITY(U,$J,358.3,8827,1,4,0)
 ;;=4^K12.0
 ;;^UTILITY(U,$J,358.3,8827,2)
 ;;=^5008483
 ;;^UTILITY(U,$J,358.3,8828,0)
 ;;=K13.70^^55^547^3
 ;;^UTILITY(U,$J,358.3,8828,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8828,1,3,0)
 ;;=3^Oral Mucosa Lesions,Unspec
 ;;^UTILITY(U,$J,358.3,8828,1,4,0)
 ;;=4^K13.70
 ;;^UTILITY(U,$J,358.3,8828,2)
 ;;=^5008496
 ;;^UTILITY(U,$J,358.3,8829,0)
 ;;=R04.2^^55^547^2
 ;;^UTILITY(U,$J,358.3,8829,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8829,1,3,0)
 ;;=3^Hemoptysis
 ;;^UTILITY(U,$J,358.3,8829,1,4,0)
 ;;=4^R04.2
 ;;^UTILITY(U,$J,358.3,8829,2)
 ;;=^5019175
 ;;^UTILITY(U,$J,358.3,8830,0)
 ;;=R94.5^^55^548^1
 ;;^UTILITY(U,$J,358.3,8830,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8830,1,3,0)
 ;;=3^Abnormal results of liver function studies
 ;;^UTILITY(U,$J,358.3,8830,1,4,0)
 ;;=4^R94.5
 ;;^UTILITY(U,$J,358.3,8830,2)
 ;;=^5019742
 ;;^UTILITY(U,$J,358.3,8831,0)
 ;;=T78.40XA^^55^548^2
 ;;^UTILITY(U,$J,358.3,8831,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8831,1,3,0)
 ;;=3^Allergy, unspecified, initial encounter
 ;;^UTILITY(U,$J,358.3,8831,1,4,0)
 ;;=4^T78.40XA
 ;;^UTILITY(U,$J,358.3,8831,2)
 ;;=^5054284
 ;;^UTILITY(U,$J,358.3,8832,0)
 ;;=Z51.81^^55^548^6
 ;;^UTILITY(U,$J,358.3,8832,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8832,1,3,0)
 ;;=3^Therapeutic drug level monitoring
 ;;^UTILITY(U,$J,358.3,8832,1,4,0)
 ;;=4^Z51.81
 ;;^UTILITY(U,$J,358.3,8832,2)
 ;;=^5063064
 ;;^UTILITY(U,$J,358.3,8833,0)
 ;;=Z02.79^^55^548^4
 ;;^UTILITY(U,$J,358.3,8833,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8833,1,3,0)
 ;;=3^Issue of other medical certificate
 ;;^UTILITY(U,$J,358.3,8833,1,4,0)
 ;;=4^Z02.79
 ;;^UTILITY(U,$J,358.3,8833,2)
 ;;=^5062641
 ;;^UTILITY(U,$J,358.3,8834,0)
 ;;=Z76.0^^55^548^5
 ;;^UTILITY(U,$J,358.3,8834,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8834,1,3,0)
 ;;=3^Issue of repeat prescription
 ;;^UTILITY(U,$J,358.3,8834,1,4,0)
 ;;=4^Z76.0
 ;;^UTILITY(U,$J,358.3,8834,2)
 ;;=^5063297
 ;;^UTILITY(U,$J,358.3,8835,0)
 ;;=Z04.9^^55^548^3
 ;;^UTILITY(U,$J,358.3,8835,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8835,1,3,0)
 ;;=3^Examination and observation for unsp reason
 ;;^UTILITY(U,$J,358.3,8835,1,4,0)
 ;;=4^Z04.9
 ;;^UTILITY(U,$J,358.3,8835,2)
 ;;=^5062666
 ;;^UTILITY(U,$J,358.3,8836,0)
 ;;=G89.0^^55^549^4
 ;;^UTILITY(U,$J,358.3,8836,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8836,1,3,0)
 ;;=3^Central pain syndrome
 ;;^UTILITY(U,$J,358.3,8836,1,4,0)
 ;;=4^G89.0
 ;;^UTILITY(U,$J,358.3,8836,2)
 ;;=^334189
 ;;^UTILITY(U,$J,358.3,8837,0)
 ;;=G89.11^^55^549^1
 ;;^UTILITY(U,$J,358.3,8837,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8837,1,3,0)
 ;;=3^Acute pain due to trauma
 ;;^UTILITY(U,$J,358.3,8837,1,4,0)
 ;;=4^G89.11
 ;;^UTILITY(U,$J,358.3,8837,2)
 ;;=^5004152
 ;;^UTILITY(U,$J,358.3,8838,0)
 ;;=G89.12^^55^549^2
 ;;^UTILITY(U,$J,358.3,8838,1,0)
 ;;=^358.31IA^4^2
