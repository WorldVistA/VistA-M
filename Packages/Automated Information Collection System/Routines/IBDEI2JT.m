IBDEI2JT ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,42740,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42740,1,3,0)
 ;;=3^Acute osteomyelitis, lft ankl & ft, oth
 ;;^UTILITY(U,$J,358.3,42740,1,4,0)
 ;;=4^M86.172
 ;;^UTILITY(U,$J,358.3,42740,2)
 ;;=^5014531
 ;;^UTILITY(U,$J,358.3,42741,0)
 ;;=M86.271^^192^2144^31
 ;;^UTILITY(U,$J,358.3,42741,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42741,1,3,0)
 ;;=3^Subacute osteomyelitis, rt ankl & ft
 ;;^UTILITY(U,$J,358.3,42741,1,4,0)
 ;;=4^M86.271
 ;;^UTILITY(U,$J,358.3,42741,2)
 ;;=^5014554
 ;;^UTILITY(U,$J,358.3,42742,0)
 ;;=M86.571^^192^2144^6
 ;;^UTILITY(U,$J,358.3,42742,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42742,1,3,0)
 ;;=3^Chronic hematogenous osteomyel, rt ankl & ft, oth
 ;;^UTILITY(U,$J,358.3,42742,1,4,0)
 ;;=4^M86.571
 ;;^UTILITY(U,$J,358.3,42742,2)
 ;;=^5014626
 ;;^UTILITY(U,$J,358.3,42743,0)
 ;;=M86.572^^192^2144^5
 ;;^UTILITY(U,$J,358.3,42743,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42743,1,3,0)
 ;;=3^Chronic hematogenous osteomyel, lft ankl & ft, oth
 ;;^UTILITY(U,$J,358.3,42743,1,4,0)
 ;;=4^M86.572
 ;;^UTILITY(U,$J,358.3,42743,2)
 ;;=^5014627
 ;;^UTILITY(U,$J,358.3,42744,0)
 ;;=M86.671^^192^2144^10
 ;;^UTILITY(U,$J,358.3,42744,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42744,1,3,0)
 ;;=3^Chronic osteomyelitis, rt ankl & ft, oth
 ;;^UTILITY(U,$J,358.3,42744,1,4,0)
 ;;=4^M86.671
 ;;^UTILITY(U,$J,358.3,42744,2)
 ;;=^5014641
 ;;^UTILITY(U,$J,358.3,42745,0)
 ;;=M86.672^^192^2144^9
 ;;^UTILITY(U,$J,358.3,42745,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42745,1,3,0)
 ;;=3^Chronic osteomyelitis, lft ankl & ft, oth
 ;;^UTILITY(U,$J,358.3,42745,1,4,0)
 ;;=4^M86.672
 ;;^UTILITY(U,$J,358.3,42745,2)
 ;;=^5014642
 ;;^UTILITY(U,$J,358.3,42746,0)
 ;;=M86.8X7^^192^2144^21
 ;;^UTILITY(U,$J,358.3,42746,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42746,1,3,0)
 ;;=3^Osteomyelitis, ankl & ft, oth
 ;;^UTILITY(U,$J,358.3,42746,1,4,0)
 ;;=4^M86.8X7
 ;;^UTILITY(U,$J,358.3,42746,2)
 ;;=^5014653
 ;;^UTILITY(U,$J,358.3,42747,0)
 ;;=M86.371^^192^2144^8
 ;;^UTILITY(U,$J,358.3,42747,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42747,1,3,0)
 ;;=3^Chronic multifoc osteomyel, rt ankl & ft
 ;;^UTILITY(U,$J,358.3,42747,1,4,0)
 ;;=4^M86.371
 ;;^UTILITY(U,$J,358.3,42747,2)
 ;;=^5014578
 ;;^UTILITY(U,$J,358.3,42748,0)
 ;;=M86.372^^192^2144^7
 ;;^UTILITY(U,$J,358.3,42748,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42748,1,3,0)
 ;;=3^Chronic multifoc osteomyel, lft ankl & ft
 ;;^UTILITY(U,$J,358.3,42748,1,4,0)
 ;;=4^M86.372
 ;;^UTILITY(U,$J,358.3,42748,2)
 ;;=^5014579
 ;;^UTILITY(U,$J,358.3,42749,0)
 ;;=M92.71^^192^2144^11
 ;;^UTILITY(U,$J,358.3,42749,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42749,1,3,0)
 ;;=3^Juvenile osteochondrosis of metatarsus, rt ft
 ;;^UTILITY(U,$J,358.3,42749,1,4,0)
 ;;=4^M92.71
 ;;^UTILITY(U,$J,358.3,42749,2)
 ;;=^5015239
 ;;^UTILITY(U,$J,358.3,42750,0)
 ;;=M92.72^^192^2144^12
 ;;^UTILITY(U,$J,358.3,42750,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42750,1,3,0)
 ;;=3^Juvenile osteochondrosis of metatarsus, lft ft
 ;;^UTILITY(U,$J,358.3,42750,1,4,0)
 ;;=4^M92.72
 ;;^UTILITY(U,$J,358.3,42750,2)
 ;;=^5015240
 ;;^UTILITY(U,$J,358.3,42751,0)
 ;;=M92.62^^192^2144^13
 ;;^UTILITY(U,$J,358.3,42751,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42751,1,3,0)
 ;;=3^Juvenile osteochondrosis of tarsus, lft ankl
 ;;^UTILITY(U,$J,358.3,42751,1,4,0)
 ;;=4^M92.62
 ;;^UTILITY(U,$J,358.3,42751,2)
 ;;=^5015237
 ;;^UTILITY(U,$J,358.3,42752,0)
 ;;=M92.61^^192^2144^14
 ;;^UTILITY(U,$J,358.3,42752,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42752,1,3,0)
 ;;=3^Juvenile osteochondrosis of tarsus, rt ankle
