IBDEI1FD ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,23050,0)
 ;;=F32.9^^78^997^12
 ;;^UTILITY(U,$J,358.3,23050,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23050,1,3,0)
 ;;=3^Major depressive disorder, single episode, unspecified
 ;;^UTILITY(U,$J,358.3,23050,1,4,0)
 ;;=4^F32.9
 ;;^UTILITY(U,$J,358.3,23050,2)
 ;;=^5003528
 ;;^UTILITY(U,$J,358.3,23051,0)
 ;;=F33.9^^78^997^11
 ;;^UTILITY(U,$J,358.3,23051,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23051,1,3,0)
 ;;=3^Major depressive disorder, recurrent, unspecified
 ;;^UTILITY(U,$J,358.3,23051,1,4,0)
 ;;=4^F33.9
 ;;^UTILITY(U,$J,358.3,23051,2)
 ;;=^5003537
 ;;^UTILITY(U,$J,358.3,23052,0)
 ;;=F41.9^^78^997^5
 ;;^UTILITY(U,$J,358.3,23052,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23052,1,3,0)
 ;;=3^Anxiety disorder, unspecified
 ;;^UTILITY(U,$J,358.3,23052,1,4,0)
 ;;=4^F41.9
 ;;^UTILITY(U,$J,358.3,23052,2)
 ;;=^5003567
 ;;^UTILITY(U,$J,358.3,23053,0)
 ;;=F43.0^^78^997^1
 ;;^UTILITY(U,$J,358.3,23053,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23053,1,3,0)
 ;;=3^Acute stress reaction
 ;;^UTILITY(U,$J,358.3,23053,1,4,0)
 ;;=4^F43.0
 ;;^UTILITY(U,$J,358.3,23053,2)
 ;;=^5003569
 ;;^UTILITY(U,$J,358.3,23054,0)
 ;;=F43.10^^78^997^15
 ;;^UTILITY(U,$J,358.3,23054,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23054,1,3,0)
 ;;=3^PTSD, unspec
 ;;^UTILITY(U,$J,358.3,23054,1,4,0)
 ;;=4^F43.10
 ;;^UTILITY(U,$J,358.3,23054,2)
 ;;=^5003570
 ;;^UTILITY(U,$J,358.3,23055,0)
 ;;=F43.12^^78^997^14
 ;;^UTILITY(U,$J,358.3,23055,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23055,1,3,0)
 ;;=3^PTSD, chronic
 ;;^UTILITY(U,$J,358.3,23055,1,4,0)
 ;;=4^F43.12
 ;;^UTILITY(U,$J,358.3,23055,2)
 ;;=^5003572
 ;;^UTILITY(U,$J,358.3,23056,0)
 ;;=F10.11^^78^997^2
 ;;^UTILITY(U,$J,358.3,23056,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23056,1,3,0)
 ;;=3^Alcohol Abuse,In Remission
 ;;^UTILITY(U,$J,358.3,23056,1,4,0)
 ;;=4^F10.11
 ;;^UTILITY(U,$J,358.3,23056,2)
 ;;=^268230
 ;;^UTILITY(U,$J,358.3,23057,0)
 ;;=F32.A^^78^997^10
 ;;^UTILITY(U,$J,358.3,23057,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23057,1,3,0)
 ;;=3^Depression,Unspec
 ;;^UTILITY(U,$J,358.3,23057,1,4,0)
 ;;=4^F32.A
 ;;^UTILITY(U,$J,358.3,23057,2)
 ;;=^5161153
 ;;^UTILITY(U,$J,358.3,23058,0)
 ;;=G20.^^78^998^12
 ;;^UTILITY(U,$J,358.3,23058,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23058,1,3,0)
 ;;=3^Parkinson's disease
 ;;^UTILITY(U,$J,358.3,23058,1,4,0)
 ;;=4^G20.
 ;;^UTILITY(U,$J,358.3,23058,2)
 ;;=^5003770
 ;;^UTILITY(U,$J,358.3,23059,0)
 ;;=G30.9^^78^998^1
 ;;^UTILITY(U,$J,358.3,23059,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23059,1,3,0)
 ;;=3^Alzheimer's disease, unspecified
 ;;^UTILITY(U,$J,358.3,23059,1,4,0)
 ;;=4^G30.9
 ;;^UTILITY(U,$J,358.3,23059,2)
 ;;=^5003808
 ;;^UTILITY(U,$J,358.3,23060,0)
 ;;=G35.^^78^998^11
 ;;^UTILITY(U,$J,358.3,23060,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23060,1,3,0)
 ;;=3^Multiple sclerosis
 ;;^UTILITY(U,$J,358.3,23060,1,4,0)
 ;;=4^G35.
 ;;^UTILITY(U,$J,358.3,23060,2)
 ;;=^79761
 ;;^UTILITY(U,$J,358.3,23061,0)
 ;;=G40.909^^78^998^4
 ;;^UTILITY(U,$J,358.3,23061,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23061,1,3,0)
 ;;=3^Epilepsy, not intractable w/o status epilepticus
 ;;^UTILITY(U,$J,358.3,23061,1,4,0)
 ;;=4^G40.909
 ;;^UTILITY(U,$J,358.3,23061,2)
 ;;=^5003865
 ;;^UTILITY(U,$J,358.3,23062,0)
 ;;=G43.909^^78^998^10
 ;;^UTILITY(U,$J,358.3,23062,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23062,1,3,0)
 ;;=3^Migraine, not intractable w/o status migrainosus
