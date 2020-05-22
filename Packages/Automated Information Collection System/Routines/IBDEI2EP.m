IBDEI2EP ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,38404,1,4,0)
 ;;=4^F03.90
 ;;^UTILITY(U,$J,358.3,38404,2)
 ;;=^5003050
 ;;^UTILITY(U,$J,358.3,38405,0)
 ;;=G35.^^149^1950^9
 ;;^UTILITY(U,$J,358.3,38405,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38405,1,3,0)
 ;;=3^Multiple sclerosis
 ;;^UTILITY(U,$J,358.3,38405,1,4,0)
 ;;=4^G35.
 ;;^UTILITY(U,$J,358.3,38405,2)
 ;;=^79761
 ;;^UTILITY(U,$J,358.3,38406,0)
 ;;=H81.13^^149^1950^4
 ;;^UTILITY(U,$J,358.3,38406,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38406,1,3,0)
 ;;=3^Benign paroxysmal vertigo, bilateral
 ;;^UTILITY(U,$J,358.3,38406,1,4,0)
 ;;=4^H81.13
 ;;^UTILITY(U,$J,358.3,38406,2)
 ;;=^5006867
 ;;^UTILITY(U,$J,358.3,38407,0)
 ;;=H81.11^^149^1950^6
 ;;^UTILITY(U,$J,358.3,38407,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38407,1,3,0)
 ;;=3^Benign paroxysmal vertigo, right ear
 ;;^UTILITY(U,$J,358.3,38407,1,4,0)
 ;;=4^H81.11
 ;;^UTILITY(U,$J,358.3,38407,2)
 ;;=^5006865
 ;;^UTILITY(U,$J,358.3,38408,0)
 ;;=H81.12^^149^1950^5
 ;;^UTILITY(U,$J,358.3,38408,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38408,1,3,0)
 ;;=3^Benign paroxysmal vertigo, left ear
 ;;^UTILITY(U,$J,358.3,38408,1,4,0)
 ;;=4^H81.12
 ;;^UTILITY(U,$J,358.3,38408,2)
 ;;=^5006866
 ;;^UTILITY(U,$J,358.3,38409,0)
 ;;=G30.0^^149^1950^1
 ;;^UTILITY(U,$J,358.3,38409,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38409,1,3,0)
 ;;=3^Alzheimer's disease w/ early onset
 ;;^UTILITY(U,$J,358.3,38409,1,4,0)
 ;;=4^G30.0
 ;;^UTILITY(U,$J,358.3,38409,2)
 ;;=^5003805
 ;;^UTILITY(U,$J,358.3,38410,0)
 ;;=G30.1^^149^1950^2
 ;;^UTILITY(U,$J,358.3,38410,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38410,1,3,0)
 ;;=3^Alzheimer's disease w/ late onset
 ;;^UTILITY(U,$J,358.3,38410,1,4,0)
 ;;=4^G30.1
 ;;^UTILITY(U,$J,358.3,38410,2)
 ;;=^5003806
 ;;^UTILITY(U,$J,358.3,38411,0)
 ;;=M79.10^^149^1950^10
 ;;^UTILITY(U,$J,358.3,38411,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38411,1,3,0)
 ;;=3^Myalgia,Unspec Site
 ;;^UTILITY(U,$J,358.3,38411,1,4,0)
 ;;=4^M79.10
 ;;^UTILITY(U,$J,358.3,38411,2)
 ;;=^5157394
 ;;^UTILITY(U,$J,358.3,38412,0)
 ;;=G43.B0^^149^1951^4
 ;;^UTILITY(U,$J,358.3,38412,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38412,1,3,0)
 ;;=3^Ophthalmoplegic migraine, not intractable
 ;;^UTILITY(U,$J,358.3,38412,1,4,0)
 ;;=4^G43.B0
 ;;^UTILITY(U,$J,358.3,38412,2)
 ;;=^5003914
 ;;^UTILITY(U,$J,358.3,38413,0)
 ;;=R51.^^149^1951^1
 ;;^UTILITY(U,$J,358.3,38413,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38413,1,3,0)
 ;;=3^Headache
 ;;^UTILITY(U,$J,358.3,38413,1,4,0)
 ;;=4^R51.
 ;;^UTILITY(U,$J,358.3,38413,2)
 ;;=^5019513
 ;;^UTILITY(U,$J,358.3,38414,0)
 ;;=G43.909^^149^1951^3
 ;;^UTILITY(U,$J,358.3,38414,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38414,1,3,0)
 ;;=3^Migraine, unsp, not intractable, without status migrainosus
 ;;^UTILITY(U,$J,358.3,38414,1,4,0)
 ;;=4^G43.909
 ;;^UTILITY(U,$J,358.3,38414,2)
 ;;=^5003909
 ;;^UTILITY(U,$J,358.3,38415,0)
 ;;=G43.919^^149^1951^2
 ;;^UTILITY(U,$J,358.3,38415,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38415,1,3,0)
 ;;=3^Migraine, unsp, intractable, without status migrainosus
 ;;^UTILITY(U,$J,358.3,38415,1,4,0)
 ;;=4^G43.919
 ;;^UTILITY(U,$J,358.3,38415,2)
 ;;=^5003911
 ;;^UTILITY(U,$J,358.3,38416,0)
 ;;=G44.209^^149^1951^5
 ;;^UTILITY(U,$J,358.3,38416,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38416,1,3,0)
 ;;=3^Tension-type headache, unspecified, not intractable
 ;;^UTILITY(U,$J,358.3,38416,1,4,0)
 ;;=4^G44.209
