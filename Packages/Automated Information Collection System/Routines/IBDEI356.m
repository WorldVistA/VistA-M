IBDEI356 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,52742,1,4,0)
 ;;=4^G43.901
 ;;^UTILITY(U,$J,358.3,52742,2)
 ;;=^5003908
 ;;^UTILITY(U,$J,358.3,52743,0)
 ;;=G43.911^^240^2641^15
 ;;^UTILITY(U,$J,358.3,52743,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52743,1,3,0)
 ;;=3^Migraine, unsp, intractable, with status migrainosus
 ;;^UTILITY(U,$J,358.3,52743,1,4,0)
 ;;=4^G43.911
 ;;^UTILITY(U,$J,358.3,52743,2)
 ;;=^5003910
 ;;^UTILITY(U,$J,358.3,52744,0)
 ;;=G44.201^^240^2641^28
 ;;^UTILITY(U,$J,358.3,52744,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52744,1,3,0)
 ;;=3^Tension-type headache, unspecified, intractable
 ;;^UTILITY(U,$J,358.3,52744,1,4,0)
 ;;=4^G44.201
 ;;^UTILITY(U,$J,358.3,52744,2)
 ;;=^5003935
 ;;^UTILITY(U,$J,358.3,52745,0)
 ;;=G44.211^^240^2641^9
 ;;^UTILITY(U,$J,358.3,52745,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52745,1,3,0)
 ;;=3^Episodic tension-type headache, intractable
 ;;^UTILITY(U,$J,358.3,52745,1,4,0)
 ;;=4^G44.211
 ;;^UTILITY(U,$J,358.3,52745,2)
 ;;=^5003937
 ;;^UTILITY(U,$J,358.3,52746,0)
 ;;=G44.219^^240^2641^10
 ;;^UTILITY(U,$J,358.3,52746,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52746,1,3,0)
 ;;=3^Episodic tension-type headache, not intractable
 ;;^UTILITY(U,$J,358.3,52746,1,4,0)
 ;;=4^G44.219
 ;;^UTILITY(U,$J,358.3,52746,2)
 ;;=^5003938
 ;;^UTILITY(U,$J,358.3,52747,0)
 ;;=G44.229^^240^2641^5
 ;;^UTILITY(U,$J,358.3,52747,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52747,1,3,0)
 ;;=3^Chronic tension-type headache, not intractable
 ;;^UTILITY(U,$J,358.3,52747,1,4,0)
 ;;=4^G44.229
 ;;^UTILITY(U,$J,358.3,52747,2)
 ;;=^5003940
 ;;^UTILITY(U,$J,358.3,52748,0)
 ;;=G44.301^^240^2641^22
 ;;^UTILITY(U,$J,358.3,52748,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52748,1,3,0)
 ;;=3^Post-traumatic headache, unspecified, intractable
 ;;^UTILITY(U,$J,358.3,52748,1,4,0)
 ;;=4^G44.301
 ;;^UTILITY(U,$J,358.3,52748,2)
 ;;=^5003941
 ;;^UTILITY(U,$J,358.3,52749,0)
 ;;=G44.309^^240^2641^23
 ;;^UTILITY(U,$J,358.3,52749,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52749,1,3,0)
 ;;=3^Post-traumatic headache, unspecified, not intractable
 ;;^UTILITY(U,$J,358.3,52749,1,4,0)
 ;;=4^G44.309
 ;;^UTILITY(U,$J,358.3,52749,2)
 ;;=^5003942
 ;;^UTILITY(U,$J,358.3,52750,0)
 ;;=G44.311^^240^2641^1
 ;;^UTILITY(U,$J,358.3,52750,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52750,1,3,0)
 ;;=3^Acute post-traumatic headache, intractable
 ;;^UTILITY(U,$J,358.3,52750,1,4,0)
 ;;=4^G44.311
 ;;^UTILITY(U,$J,358.3,52750,2)
 ;;=^5003943
 ;;^UTILITY(U,$J,358.3,52751,0)
 ;;=G44.319^^240^2641^2
 ;;^UTILITY(U,$J,358.3,52751,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52751,1,3,0)
 ;;=3^Acute post-traumatic headache, not intractable
 ;;^UTILITY(U,$J,358.3,52751,1,4,0)
 ;;=4^G44.319
 ;;^UTILITY(U,$J,358.3,52751,2)
 ;;=^5003944
 ;;^UTILITY(U,$J,358.3,52752,0)
 ;;=G44.329^^240^2641^4
 ;;^UTILITY(U,$J,358.3,52752,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52752,1,3,0)
 ;;=3^Chronic post-traumatic headache, not intractable
 ;;^UTILITY(U,$J,358.3,52752,1,4,0)
 ;;=4^G44.329
 ;;^UTILITY(U,$J,358.3,52752,2)
 ;;=^5003946
 ;;^UTILITY(U,$J,358.3,52753,0)
 ;;=G44.321^^240^2641^3
 ;;^UTILITY(U,$J,358.3,52753,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52753,1,3,0)
 ;;=3^Chronic post-traumatic headache, intractable
 ;;^UTILITY(U,$J,358.3,52753,1,4,0)
 ;;=4^G44.321
 ;;^UTILITY(U,$J,358.3,52753,2)
 ;;=^5003945
 ;;^UTILITY(U,$J,358.3,52754,0)
 ;;=G44.40^^240^2641^7
 ;;^UTILITY(U,$J,358.3,52754,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52754,1,3,0)
 ;;=3^Drug-induced headache, NEC, not intractable
 ;;^UTILITY(U,$J,358.3,52754,1,4,0)
 ;;=4^G44.40
