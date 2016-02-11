IBDEI2CS ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,39518,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39518,1,3,0)
 ;;=3^Fracture of symphysis of mandible, sequela
 ;;^UTILITY(U,$J,358.3,39518,1,4,0)
 ;;=4^S02.66XS
 ;;^UTILITY(U,$J,358.3,39518,2)
 ;;=^5020413
 ;;^UTILITY(U,$J,358.3,39519,0)
 ;;=S02.600S^^183^2024^39
 ;;^UTILITY(U,$J,358.3,39519,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39519,1,3,0)
 ;;=3^Fracture of unspecified part of body of mandible, sequela
 ;;^UTILITY(U,$J,358.3,39519,1,4,0)
 ;;=4^S02.600S
 ;;^UTILITY(U,$J,358.3,39519,2)
 ;;=^5020371
 ;;^UTILITY(U,$J,358.3,39520,0)
 ;;=S02.0XXS^^183^2024^44
 ;;^UTILITY(U,$J,358.3,39520,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39520,1,3,0)
 ;;=3^Fracture of vault of skull, sequela
 ;;^UTILITY(U,$J,358.3,39520,1,4,0)
 ;;=4^S02.0XXS
 ;;^UTILITY(U,$J,358.3,39520,2)
 ;;=^5020257
 ;;^UTILITY(U,$J,358.3,39521,0)
 ;;=S02.411S^^183^2024^45
 ;;^UTILITY(U,$J,358.3,39521,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39521,1,3,0)
 ;;=3^LeFort I fracture, sequela
 ;;^UTILITY(U,$J,358.3,39521,1,4,0)
 ;;=4^S02.411S
 ;;^UTILITY(U,$J,358.3,39521,2)
 ;;=^5020341
 ;;^UTILITY(U,$J,358.3,39522,0)
 ;;=S02.412S^^183^2024^46
 ;;^UTILITY(U,$J,358.3,39522,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39522,1,3,0)
 ;;=3^LeFort II fracture, sequela
 ;;^UTILITY(U,$J,358.3,39522,1,4,0)
 ;;=4^S02.412S
 ;;^UTILITY(U,$J,358.3,39522,2)
 ;;=^5020347
 ;;^UTILITY(U,$J,358.3,39523,0)
 ;;=S02.413S^^183^2024^47
 ;;^UTILITY(U,$J,358.3,39523,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39523,1,3,0)
 ;;=3^LeFort III fracture, sequela
 ;;^UTILITY(U,$J,358.3,39523,1,4,0)
 ;;=4^S02.413S
 ;;^UTILITY(U,$J,358.3,39523,2)
 ;;=^5020353
 ;;^UTILITY(U,$J,358.3,39524,0)
 ;;=S02.400S^^183^2024^48
 ;;^UTILITY(U,$J,358.3,39524,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39524,1,3,0)
 ;;=3^Malar fracture unspecified, sequela
 ;;^UTILITY(U,$J,358.3,39524,1,4,0)
 ;;=4^S02.400S
 ;;^UTILITY(U,$J,358.3,39524,2)
 ;;=^5020323
 ;;^UTILITY(U,$J,358.3,39525,0)
 ;;=S02.401S^^183^2024^49
 ;;^UTILITY(U,$J,358.3,39525,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39525,1,3,0)
 ;;=3^Maxillary fracture, unspecified, sequela
 ;;^UTILITY(U,$J,358.3,39525,1,4,0)
 ;;=4^S02.401S
 ;;^UTILITY(U,$J,358.3,39525,2)
 ;;=^5020329
 ;;^UTILITY(U,$J,358.3,39526,0)
 ;;=S02.113S^^183^2024^22
 ;;^UTILITY(U,$J,358.3,39526,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39526,1,3,0)
 ;;=3^Fracture of occipital condyle unspec, sequela
 ;;^UTILITY(U,$J,358.3,39526,1,4,0)
 ;;=4^S02.113S
 ;;^UTILITY(U,$J,358.3,39526,2)
 ;;=^5020287
 ;;^UTILITY(U,$J,358.3,39527,0)
 ;;=S02.110S^^183^2024^53
 ;;^UTILITY(U,$J,358.3,39527,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39527,1,3,0)
 ;;=3^Type I occipital condyle fracture, sequela
 ;;^UTILITY(U,$J,358.3,39527,1,4,0)
 ;;=4^S02.110S
 ;;^UTILITY(U,$J,358.3,39527,2)
 ;;=^5020269
 ;;^UTILITY(U,$J,358.3,39528,0)
 ;;=S02.111S^^183^2024^54
 ;;^UTILITY(U,$J,358.3,39528,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39528,1,3,0)
 ;;=3^Type II occipital condyle fracture, sequela
 ;;^UTILITY(U,$J,358.3,39528,1,4,0)
 ;;=4^S02.111S
 ;;^UTILITY(U,$J,358.3,39528,2)
 ;;=^5020275
 ;;^UTILITY(U,$J,358.3,39529,0)
 ;;=S02.112S^^183^2024^55
 ;;^UTILITY(U,$J,358.3,39529,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39529,1,3,0)
 ;;=3^Type III occipital condyle fracture, sequela
 ;;^UTILITY(U,$J,358.3,39529,1,4,0)
 ;;=4^S02.112S
 ;;^UTILITY(U,$J,358.3,39529,2)
 ;;=^5020281
 ;;^UTILITY(U,$J,358.3,39530,0)
 ;;=S02.402S^^183^2024^56
 ;;^UTILITY(U,$J,358.3,39530,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39530,1,3,0)
 ;;=3^Zygomatic fracture, unspecified, sequela
