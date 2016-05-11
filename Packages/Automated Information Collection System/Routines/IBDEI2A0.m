IBDEI2A0 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,38609,1,4,0)
 ;;=4^G44.229
 ;;^UTILITY(U,$J,358.3,38609,2)
 ;;=^5003940
 ;;^UTILITY(U,$J,358.3,38610,0)
 ;;=G44.301^^148^1888^22
 ;;^UTILITY(U,$J,358.3,38610,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38610,1,3,0)
 ;;=3^Post-traumatic headache, unspecified, intractable
 ;;^UTILITY(U,$J,358.3,38610,1,4,0)
 ;;=4^G44.301
 ;;^UTILITY(U,$J,358.3,38610,2)
 ;;=^5003941
 ;;^UTILITY(U,$J,358.3,38611,0)
 ;;=G44.309^^148^1888^23
 ;;^UTILITY(U,$J,358.3,38611,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38611,1,3,0)
 ;;=3^Post-traumatic headache, unspecified, not intractable
 ;;^UTILITY(U,$J,358.3,38611,1,4,0)
 ;;=4^G44.309
 ;;^UTILITY(U,$J,358.3,38611,2)
 ;;=^5003942
 ;;^UTILITY(U,$J,358.3,38612,0)
 ;;=G44.311^^148^1888^1
 ;;^UTILITY(U,$J,358.3,38612,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38612,1,3,0)
 ;;=3^Acute post-traumatic headache, intractable
 ;;^UTILITY(U,$J,358.3,38612,1,4,0)
 ;;=4^G44.311
 ;;^UTILITY(U,$J,358.3,38612,2)
 ;;=^5003943
 ;;^UTILITY(U,$J,358.3,38613,0)
 ;;=G44.319^^148^1888^2
 ;;^UTILITY(U,$J,358.3,38613,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38613,1,3,0)
 ;;=3^Acute post-traumatic headache, not intractable
 ;;^UTILITY(U,$J,358.3,38613,1,4,0)
 ;;=4^G44.319
 ;;^UTILITY(U,$J,358.3,38613,2)
 ;;=^5003944
 ;;^UTILITY(U,$J,358.3,38614,0)
 ;;=G44.329^^148^1888^4
 ;;^UTILITY(U,$J,358.3,38614,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38614,1,3,0)
 ;;=3^Chronic post-traumatic headache, not intractable
 ;;^UTILITY(U,$J,358.3,38614,1,4,0)
 ;;=4^G44.329
 ;;^UTILITY(U,$J,358.3,38614,2)
 ;;=^5003946
 ;;^UTILITY(U,$J,358.3,38615,0)
 ;;=G44.321^^148^1888^3
 ;;^UTILITY(U,$J,358.3,38615,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38615,1,3,0)
 ;;=3^Chronic post-traumatic headache, intractable
 ;;^UTILITY(U,$J,358.3,38615,1,4,0)
 ;;=4^G44.321
 ;;^UTILITY(U,$J,358.3,38615,2)
 ;;=^5003945
 ;;^UTILITY(U,$J,358.3,38616,0)
 ;;=G44.40^^148^1888^7
 ;;^UTILITY(U,$J,358.3,38616,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38616,1,3,0)
 ;;=3^Drug-induced headache, NEC, not intractable
 ;;^UTILITY(U,$J,358.3,38616,1,4,0)
 ;;=4^G44.40
 ;;^UTILITY(U,$J,358.3,38616,2)
 ;;=^5003947
 ;;^UTILITY(U,$J,358.3,38617,0)
 ;;=G44.41^^148^1888^8
 ;;^UTILITY(U,$J,358.3,38617,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38617,1,3,0)
 ;;=3^Drug-induced headache, not elsewhere classified, intractable
 ;;^UTILITY(U,$J,358.3,38617,1,4,0)
 ;;=4^G44.41
 ;;^UTILITY(U,$J,358.3,38617,2)
 ;;=^5003948
 ;;^UTILITY(U,$J,358.3,38618,0)
 ;;=G44.51^^148^1888^13
 ;;^UTILITY(U,$J,358.3,38618,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38618,1,3,0)
 ;;=3^Hemicrania continua
 ;;^UTILITY(U,$J,358.3,38618,1,4,0)
 ;;=4^G44.51
 ;;^UTILITY(U,$J,358.3,38618,2)
 ;;=^5003949
 ;;^UTILITY(U,$J,358.3,38619,0)
 ;;=G44.52^^148^1888^19
 ;;^UTILITY(U,$J,358.3,38619,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38619,1,3,0)
 ;;=3^New daily persistent headache (NDPH)
 ;;^UTILITY(U,$J,358.3,38619,1,4,0)
 ;;=4^G44.52
 ;;^UTILITY(U,$J,358.3,38619,2)
 ;;=^5003950
 ;;^UTILITY(U,$J,358.3,38620,0)
 ;;=G44.53^^148^1888^27
 ;;^UTILITY(U,$J,358.3,38620,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38620,1,3,0)
 ;;=3^Primary thunderclap headache
 ;;^UTILITY(U,$J,358.3,38620,1,4,0)
 ;;=4^G44.53
 ;;^UTILITY(U,$J,358.3,38620,2)
 ;;=^5003951
 ;;^UTILITY(U,$J,358.3,38621,0)
 ;;=G44.59^^148^1888^6
 ;;^UTILITY(U,$J,358.3,38621,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38621,1,3,0)
 ;;=3^Complicated headache syndrome, other
 ;;^UTILITY(U,$J,358.3,38621,1,4,0)
 ;;=4^G44.59
 ;;^UTILITY(U,$J,358.3,38621,2)
 ;;=^336559
 ;;^UTILITY(U,$J,358.3,38622,0)
 ;;=G44.81^^148^1888^14
