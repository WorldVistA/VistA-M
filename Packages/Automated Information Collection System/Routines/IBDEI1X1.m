IBDEI1X1 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,32501,1,3,0)
 ;;=3^Chronic multifoc osteomyel, rt ankl & ft
 ;;^UTILITY(U,$J,358.3,32501,1,4,0)
 ;;=4^M86.371
 ;;^UTILITY(U,$J,358.3,32501,2)
 ;;=^5014578
 ;;^UTILITY(U,$J,358.3,32502,0)
 ;;=M86.372^^126^1616^7
 ;;^UTILITY(U,$J,358.3,32502,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32502,1,3,0)
 ;;=3^Chronic multifoc osteomyel, lft ankl & ft
 ;;^UTILITY(U,$J,358.3,32502,1,4,0)
 ;;=4^M86.372
 ;;^UTILITY(U,$J,358.3,32502,2)
 ;;=^5014579
 ;;^UTILITY(U,$J,358.3,32503,0)
 ;;=M92.71^^126^1616^11
 ;;^UTILITY(U,$J,358.3,32503,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32503,1,3,0)
 ;;=3^Juvenile osteochondrosis of metatarsus, rt ft
 ;;^UTILITY(U,$J,358.3,32503,1,4,0)
 ;;=4^M92.71
 ;;^UTILITY(U,$J,358.3,32503,2)
 ;;=^5015239
 ;;^UTILITY(U,$J,358.3,32504,0)
 ;;=M92.72^^126^1616^12
 ;;^UTILITY(U,$J,358.3,32504,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32504,1,3,0)
 ;;=3^Juvenile osteochondrosis of metatarsus, lft ft
 ;;^UTILITY(U,$J,358.3,32504,1,4,0)
 ;;=4^M92.72
 ;;^UTILITY(U,$J,358.3,32504,2)
 ;;=^5015240
 ;;^UTILITY(U,$J,358.3,32505,0)
 ;;=M92.62^^126^1616^13
 ;;^UTILITY(U,$J,358.3,32505,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32505,1,3,0)
 ;;=3^Juvenile osteochondrosis of tarsus, lft ankl
 ;;^UTILITY(U,$J,358.3,32505,1,4,0)
 ;;=4^M92.62
 ;;^UTILITY(U,$J,358.3,32505,2)
 ;;=^5015237
 ;;^UTILITY(U,$J,358.3,32506,0)
 ;;=M92.61^^126^1616^14
 ;;^UTILITY(U,$J,358.3,32506,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32506,1,3,0)
 ;;=3^Juvenile osteochondrosis of tarsus, rt ankle
 ;;^UTILITY(U,$J,358.3,32506,1,4,0)
 ;;=4^M92.61
 ;;^UTILITY(U,$J,358.3,32506,2)
 ;;=^5015236
 ;;^UTILITY(U,$J,358.3,32507,0)
 ;;=Z47.89^^126^1616^16
 ;;^UTILITY(U,$J,358.3,32507,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32507,1,3,0)
 ;;=3^Orthopedic aftercare, oth
 ;;^UTILITY(U,$J,358.3,32507,1,4,0)
 ;;=4^Z47.89
 ;;^UTILITY(U,$J,358.3,32507,2)
 ;;=^5063032
 ;;^UTILITY(U,$J,358.3,32508,0)
 ;;=M19.072^^126^1616^18
 ;;^UTILITY(U,$J,358.3,32508,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32508,1,3,0)
 ;;=3^Osteoarthritis,Left Ankle/Foot,Primary
 ;;^UTILITY(U,$J,358.3,32508,1,4,0)
 ;;=4^M19.072
 ;;^UTILITY(U,$J,358.3,32508,2)
 ;;=^5010821
 ;;^UTILITY(U,$J,358.3,32509,0)
 ;;=M19.071^^126^1616^19
 ;;^UTILITY(U,$J,358.3,32509,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32509,1,3,0)
 ;;=3^Osteoarthritis,Right Ankle/Foot,Primary
 ;;^UTILITY(U,$J,358.3,32509,1,4,0)
 ;;=4^M19.071
 ;;^UTILITY(U,$J,358.3,32509,2)
 ;;=^5010820
 ;;^UTILITY(U,$J,358.3,32510,0)
 ;;=M19.90^^126^1616^20
 ;;^UTILITY(U,$J,358.3,32510,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32510,1,3,0)
 ;;=3^Osteoarthritis,Unspec Site
 ;;^UTILITY(U,$J,358.3,32510,1,4,0)
 ;;=4^M19.90
 ;;^UTILITY(U,$J,358.3,32510,2)
 ;;=^5010853
 ;;^UTILITY(U,$J,358.3,32511,0)
 ;;=M96.0^^126^1617^14
 ;;^UTILITY(U,$J,358.3,32511,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32511,1,3,0)
 ;;=3^Pseudarthrosis after fusion or arthrodesis
 ;;^UTILITY(U,$J,358.3,32511,1,4,0)
 ;;=4^M96.0
 ;;^UTILITY(U,$J,358.3,32511,2)
 ;;=^5015373
 ;;^UTILITY(U,$J,358.3,32512,0)
 ;;=R20.2^^126^1617^1
 ;;^UTILITY(U,$J,358.3,32512,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32512,1,3,0)
 ;;=3^Paresthesia of skin
 ;;^UTILITY(U,$J,358.3,32512,1,4,0)
 ;;=4^R20.2
 ;;^UTILITY(U,$J,358.3,32512,2)
 ;;=^5019280
 ;;^UTILITY(U,$J,358.3,32513,0)
 ;;=I87.003^^126^1617^12
 ;;^UTILITY(U,$J,358.3,32513,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32513,1,3,0)
 ;;=3^Postthrom syndr w/o compl of bilat lwr extrem
 ;;^UTILITY(U,$J,358.3,32513,1,4,0)
 ;;=4^I87.003
 ;;^UTILITY(U,$J,358.3,32513,2)
 ;;=^5008029
