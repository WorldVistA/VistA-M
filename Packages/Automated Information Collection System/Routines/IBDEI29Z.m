IBDEI29Z ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,38597,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38597,1,3,0)
 ;;=3^Dizziness and giddiness
 ;;^UTILITY(U,$J,358.3,38597,1,4,0)
 ;;=4^R42.
 ;;^UTILITY(U,$J,358.3,38597,2)
 ;;=^5019450
 ;;^UTILITY(U,$J,358.3,38598,0)
 ;;=G43.C0^^148^1888^21
 ;;^UTILITY(U,$J,358.3,38598,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38598,1,3,0)
 ;;=3^Periodic headache syndromes in chld/adlt, not intractable
 ;;^UTILITY(U,$J,358.3,38598,1,4,0)
 ;;=4^G43.C0
 ;;^UTILITY(U,$J,358.3,38598,2)
 ;;=^5003916
 ;;^UTILITY(U,$J,358.3,38599,0)
 ;;=G43.C1^^148^1888^20
 ;;^UTILITY(U,$J,358.3,38599,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38599,1,3,0)
 ;;=3^Periodic headache syndromes in child or adult, intractable
 ;;^UTILITY(U,$J,358.3,38599,1,4,0)
 ;;=4^G43.C1
 ;;^UTILITY(U,$J,358.3,38599,2)
 ;;=^5003917
 ;;^UTILITY(U,$J,358.3,38600,0)
 ;;=R51.^^148^1888^11
 ;;^UTILITY(U,$J,358.3,38600,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38600,1,3,0)
 ;;=3^Headache
 ;;^UTILITY(U,$J,358.3,38600,1,4,0)
 ;;=4^R51.
 ;;^UTILITY(U,$J,358.3,38600,2)
 ;;=^5019513
 ;;^UTILITY(U,$J,358.3,38601,0)
 ;;=G43.909^^148^1888^18
 ;;^UTILITY(U,$J,358.3,38601,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38601,1,3,0)
 ;;=3^Migraine, unsp, not intractable, without status migrainosus
 ;;^UTILITY(U,$J,358.3,38601,1,4,0)
 ;;=4^G43.909
 ;;^UTILITY(U,$J,358.3,38601,2)
 ;;=^5003909
 ;;^UTILITY(U,$J,358.3,38602,0)
 ;;=G43.919^^148^1888^16
 ;;^UTILITY(U,$J,358.3,38602,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38602,1,3,0)
 ;;=3^Migraine, unsp, intractable, without status migrainosus
 ;;^UTILITY(U,$J,358.3,38602,1,4,0)
 ;;=4^G43.919
 ;;^UTILITY(U,$J,358.3,38602,2)
 ;;=^5003911
 ;;^UTILITY(U,$J,358.3,38603,0)
 ;;=G44.209^^148^1888^29
 ;;^UTILITY(U,$J,358.3,38603,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38603,1,3,0)
 ;;=3^Tension-type headache, unspecified, not intractable
 ;;^UTILITY(U,$J,358.3,38603,1,4,0)
 ;;=4^G44.209
 ;;^UTILITY(U,$J,358.3,38603,2)
 ;;=^5003936
 ;;^UTILITY(U,$J,358.3,38604,0)
 ;;=G43.901^^148^1888^17
 ;;^UTILITY(U,$J,358.3,38604,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38604,1,3,0)
 ;;=3^Migraine, unsp, not intractable, with status migrainosus
 ;;^UTILITY(U,$J,358.3,38604,1,4,0)
 ;;=4^G43.901
 ;;^UTILITY(U,$J,358.3,38604,2)
 ;;=^5003908
 ;;^UTILITY(U,$J,358.3,38605,0)
 ;;=G43.911^^148^1888^15
 ;;^UTILITY(U,$J,358.3,38605,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38605,1,3,0)
 ;;=3^Migraine, unsp, intractable, with status migrainosus
 ;;^UTILITY(U,$J,358.3,38605,1,4,0)
 ;;=4^G43.911
 ;;^UTILITY(U,$J,358.3,38605,2)
 ;;=^5003910
 ;;^UTILITY(U,$J,358.3,38606,0)
 ;;=G44.201^^148^1888^28
 ;;^UTILITY(U,$J,358.3,38606,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38606,1,3,0)
 ;;=3^Tension-type headache, unspecified, intractable
 ;;^UTILITY(U,$J,358.3,38606,1,4,0)
 ;;=4^G44.201
 ;;^UTILITY(U,$J,358.3,38606,2)
 ;;=^5003935
 ;;^UTILITY(U,$J,358.3,38607,0)
 ;;=G44.211^^148^1888^9
 ;;^UTILITY(U,$J,358.3,38607,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38607,1,3,0)
 ;;=3^Episodic tension-type headache, intractable
 ;;^UTILITY(U,$J,358.3,38607,1,4,0)
 ;;=4^G44.211
 ;;^UTILITY(U,$J,358.3,38607,2)
 ;;=^5003937
 ;;^UTILITY(U,$J,358.3,38608,0)
 ;;=G44.219^^148^1888^10
 ;;^UTILITY(U,$J,358.3,38608,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38608,1,3,0)
 ;;=3^Episodic tension-type headache, not intractable
 ;;^UTILITY(U,$J,358.3,38608,1,4,0)
 ;;=4^G44.219
 ;;^UTILITY(U,$J,358.3,38608,2)
 ;;=^5003938
 ;;^UTILITY(U,$J,358.3,38609,0)
 ;;=G44.229^^148^1888^5
 ;;^UTILITY(U,$J,358.3,38609,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38609,1,3,0)
 ;;=3^Chronic tension-type headache, not intractable
