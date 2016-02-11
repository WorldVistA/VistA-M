IBDEI2CR ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,39505,1,4,0)
 ;;=4^S02.19XS
 ;;^UTILITY(U,$J,358.3,39505,2)
 ;;=^5020305
 ;;^UTILITY(U,$J,358.3,39506,0)
 ;;=S02.10XS^^183^2024^5
 ;;^UTILITY(U,$J,358.3,39506,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39506,1,3,0)
 ;;=3^Fracture of base of skull unspec, sequela
 ;;^UTILITY(U,$J,358.3,39506,1,4,0)
 ;;=4^S02.10XS
 ;;^UTILITY(U,$J,358.3,39506,2)
 ;;=^5020263
 ;;^UTILITY(U,$J,358.3,39507,0)
 ;;=S02.61XS^^183^2024^7
 ;;^UTILITY(U,$J,358.3,39507,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39507,1,3,0)
 ;;=3^Fracture of condylar process of mandible, sequela
 ;;^UTILITY(U,$J,358.3,39507,1,4,0)
 ;;=4^S02.61XS
 ;;^UTILITY(U,$J,358.3,39507,2)
 ;;=^5020383
 ;;^UTILITY(U,$J,358.3,39508,0)
 ;;=S02.63XS^^183^2024^8
 ;;^UTILITY(U,$J,358.3,39508,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39508,1,3,0)
 ;;=3^Fracture of coronoid process of mandible, sequela
 ;;^UTILITY(U,$J,358.3,39508,1,4,0)
 ;;=4^S02.63XS
 ;;^UTILITY(U,$J,358.3,39508,2)
 ;;=^5020395
 ;;^UTILITY(U,$J,358.3,39509,0)
 ;;=S02.92XS^^183^2024^9
 ;;^UTILITY(U,$J,358.3,39509,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39509,1,3,0)
 ;;=3^Fracture of facial bones unspec, sequela
 ;;^UTILITY(U,$J,358.3,39509,1,4,0)
 ;;=4^S02.92XS
 ;;^UTILITY(U,$J,358.3,39509,2)
 ;;=^5020443
 ;;^UTILITY(U,$J,358.3,39510,0)
 ;;=S02.609S^^183^2024^19
 ;;^UTILITY(U,$J,358.3,39510,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39510,1,3,0)
 ;;=3^Fracture of mandible, unspecified, sequela
 ;;^UTILITY(U,$J,358.3,39510,1,4,0)
 ;;=4^S02.609S
 ;;^UTILITY(U,$J,358.3,39510,2)
 ;;=^5020377
 ;;^UTILITY(U,$J,358.3,39511,0)
 ;;=S02.2XXS^^183^2024^20
 ;;^UTILITY(U,$J,358.3,39511,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39511,1,3,0)
 ;;=3^Fracture of nasal bones, sequela
 ;;^UTILITY(U,$J,358.3,39511,1,4,0)
 ;;=4^S02.2XXS
 ;;^UTILITY(U,$J,358.3,39511,2)
 ;;=^5020311
 ;;^UTILITY(U,$J,358.3,39512,0)
 ;;=S02.118S^^183^2024^23
 ;;^UTILITY(U,$J,358.3,39512,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39512,1,3,0)
 ;;=3^Fracture of occiput NEC, sequela
 ;;^UTILITY(U,$J,358.3,39512,1,4,0)
 ;;=4^S02.118S
 ;;^UTILITY(U,$J,358.3,39512,2)
 ;;=^5020293
 ;;^UTILITY(U,$J,358.3,39513,0)
 ;;=S02.119S^^183^2024^24
 ;;^UTILITY(U,$J,358.3,39513,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39513,1,3,0)
 ;;=3^Fracture of occiput unspec, sequela
 ;;^UTILITY(U,$J,358.3,39513,1,4,0)
 ;;=4^S02.119S
 ;;^UTILITY(U,$J,358.3,39513,2)
 ;;=^5020299
 ;;^UTILITY(U,$J,358.3,39514,0)
 ;;=S02.3XXS^^183^2024^25
 ;;^UTILITY(U,$J,358.3,39514,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39514,1,3,0)
 ;;=3^Fracture of orbital floor, sequela
 ;;^UTILITY(U,$J,358.3,39514,1,4,0)
 ;;=4^S02.3XXS
 ;;^UTILITY(U,$J,358.3,39514,2)
 ;;=^5020317
 ;;^UTILITY(U,$J,358.3,39515,0)
 ;;=S02.64XS^^183^2024^26
 ;;^UTILITY(U,$J,358.3,39515,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39515,1,3,0)
 ;;=3^Fracture of ramus of mandible, sequela
 ;;^UTILITY(U,$J,358.3,39515,1,4,0)
 ;;=4^S02.64XS
 ;;^UTILITY(U,$J,358.3,39515,2)
 ;;=^5020401
 ;;^UTILITY(U,$J,358.3,39516,0)
 ;;=S02.91XS^^183^2024^36
 ;;^UTILITY(U,$J,358.3,39516,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39516,1,3,0)
 ;;=3^Fracture of skull unspec, sequela
 ;;^UTILITY(U,$J,358.3,39516,1,4,0)
 ;;=4^S02.91XS
 ;;^UTILITY(U,$J,358.3,39516,2)
 ;;=^5020437
 ;;^UTILITY(U,$J,358.3,39517,0)
 ;;=S02.62XS^^183^2024^37
 ;;^UTILITY(U,$J,358.3,39517,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39517,1,3,0)
 ;;=3^Fracture of subcondylar process of mandible, sequela
 ;;^UTILITY(U,$J,358.3,39517,1,4,0)
 ;;=4^S02.62XS
 ;;^UTILITY(U,$J,358.3,39517,2)
 ;;=^5020389
 ;;^UTILITY(U,$J,358.3,39518,0)
 ;;=S02.66XS^^183^2024^38
