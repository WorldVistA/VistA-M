IBDEI2ZS ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,47780,1,3,0)
 ;;=3^Cellulitis,Unspec
 ;;^UTILITY(U,$J,358.3,47780,1,4,0)
 ;;=4^L03.90
 ;;^UTILITY(U,$J,358.3,47780,2)
 ;;=^5009067
 ;;^UTILITY(U,$J,358.3,47781,0)
 ;;=L94.9^^185^2412^19
 ;;^UTILITY(U,$J,358.3,47781,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47781,1,3,0)
 ;;=3^Connective Tissue Disorder,Localized,Unspec
 ;;^UTILITY(U,$J,358.3,47781,1,4,0)
 ;;=4^L94.9
 ;;^UTILITY(U,$J,358.3,47781,2)
 ;;=^5009475
 ;;^UTILITY(U,$J,358.3,47782,0)
 ;;=L84.^^185^2412^20
 ;;^UTILITY(U,$J,358.3,47782,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47782,1,3,0)
 ;;=3^Corns & Callosities
 ;;^UTILITY(U,$J,358.3,47782,1,4,0)
 ;;=4^L84.
 ;;^UTILITY(U,$J,358.3,47782,2)
 ;;=^271920
 ;;^UTILITY(U,$J,358.3,47783,0)
 ;;=L27.0^^185^2412^22
 ;;^UTILITY(U,$J,358.3,47783,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47783,1,3,0)
 ;;=3^Dermatitis d/t Drugs/Meds Taken Internally,General
 ;;^UTILITY(U,$J,358.3,47783,1,4,0)
 ;;=4^L27.0
 ;;^UTILITY(U,$J,358.3,47783,2)
 ;;=^5009144
 ;;^UTILITY(U,$J,358.3,47784,0)
 ;;=L27.1^^185^2412^23
 ;;^UTILITY(U,$J,358.3,47784,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47784,1,3,0)
 ;;=3^Dermatitis d/t Drugs/Meds Taken Internally,Local
 ;;^UTILITY(U,$J,358.3,47784,1,4,0)
 ;;=4^L27.1
 ;;^UTILITY(U,$J,358.3,47784,2)
 ;;=^5009145
 ;;^UTILITY(U,$J,358.3,47785,0)
 ;;=L27.2^^185^2412^24
 ;;^UTILITY(U,$J,358.3,47785,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47785,1,3,0)
 ;;=3^Dermatitis d/t Ingested Food
 ;;^UTILITY(U,$J,358.3,47785,1,4,0)
 ;;=4^L27.2
 ;;^UTILITY(U,$J,358.3,47785,2)
 ;;=^5009146
 ;;^UTILITY(U,$J,358.3,47786,0)
 ;;=L58.0^^185^2412^25
 ;;^UTILITY(U,$J,358.3,47786,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47786,1,3,0)
 ;;=3^Dermatitis d/t Radiation,Acute
 ;;^UTILITY(U,$J,358.3,47786,1,4,0)
 ;;=4^L58.0
 ;;^UTILITY(U,$J,358.3,47786,2)
 ;;=^5009228
 ;;^UTILITY(U,$J,358.3,47787,0)
 ;;=L58.1^^185^2412^26
 ;;^UTILITY(U,$J,358.3,47787,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47787,1,3,0)
 ;;=3^Dermatitis d/t Radiation,Chronic
 ;;^UTILITY(U,$J,358.3,47787,1,4,0)
 ;;=4^L58.1
 ;;^UTILITY(U,$J,358.3,47787,2)
 ;;=^5009229
 ;;^UTILITY(U,$J,358.3,47788,0)
 ;;=L58.9^^185^2412^21
 ;;^UTILITY(U,$J,358.3,47788,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47788,1,3,0)
 ;;=3^Dermatitis d/t  Radiation,Unspec
 ;;^UTILITY(U,$J,358.3,47788,1,4,0)
 ;;=4^L58.9
 ;;^UTILITY(U,$J,358.3,47788,2)
 ;;=^5009230
 ;;^UTILITY(U,$J,358.3,47789,0)
 ;;=L27.9^^185^2412^27
 ;;^UTILITY(U,$J,358.3,47789,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47789,1,3,0)
 ;;=3^Dermatitis d/t Unspec Subs Taken Internally
 ;;^UTILITY(U,$J,358.3,47789,1,4,0)
 ;;=4^L27.9
 ;;^UTILITY(U,$J,358.3,47789,2)
 ;;=^271914
 ;;^UTILITY(U,$J,358.3,47790,0)
 ;;=L20.9^^185^2412^29
 ;;^UTILITY(U,$J,358.3,47790,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47790,1,3,0)
 ;;=3^Dermatitis,Atopic,Unspec
 ;;^UTILITY(U,$J,358.3,47790,1,4,0)
 ;;=4^L20.9
 ;;^UTILITY(U,$J,358.3,47790,2)
 ;;=^5009113
 ;;^UTILITY(U,$J,358.3,47791,0)
 ;;=L23.9^^185^2412^28
 ;;^UTILITY(U,$J,358.3,47791,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47791,1,3,0)
 ;;=3^Dermatitis,Allergic Contact,Unspec Cause
 ;;^UTILITY(U,$J,358.3,47791,1,4,0)
 ;;=4^L23.9
 ;;^UTILITY(U,$J,358.3,47791,2)
 ;;=^5009125
 ;;^UTILITY(U,$J,358.3,47792,0)
 ;;=L24.9^^185^2412^30
 ;;^UTILITY(U,$J,358.3,47792,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47792,1,3,0)
 ;;=3^Dermatitis,Irritant Contact,Unspec Cause
