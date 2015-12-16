IBDEI02S ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,756,1,4,0)
 ;;=4^L56.0
 ;;^UTILITY(U,$J,358.3,756,2)
 ;;=^5009214
 ;;^UTILITY(U,$J,358.3,757,0)
 ;;=L56.1^^3^32^32
 ;;^UTILITY(U,$J,358.3,757,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,757,1,3,0)
 ;;=3^Drug photoallergic response
 ;;^UTILITY(U,$J,358.3,757,1,4,0)
 ;;=4^L56.1
 ;;^UTILITY(U,$J,358.3,757,2)
 ;;=^5009215
 ;;^UTILITY(U,$J,358.3,758,0)
 ;;=L56.2^^3^32^120
 ;;^UTILITY(U,$J,358.3,758,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,758,1,3,0)
 ;;=3^Photocontact dermatitis [berloque dermatitis]
 ;;^UTILITY(U,$J,358.3,758,1,4,0)
 ;;=4^L56.2
 ;;^UTILITY(U,$J,358.3,758,2)
 ;;=^5009216
 ;;^UTILITY(U,$J,358.3,759,0)
 ;;=L25.9^^3^32^28
 ;;^UTILITY(U,$J,358.3,759,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,759,1,3,0)
 ;;=3^Contact Dermatitis,Unspec Cause
 ;;^UTILITY(U,$J,358.3,759,1,4,0)
 ;;=4^L25.9
 ;;^UTILITY(U,$J,358.3,759,2)
 ;;=^5133647
 ;;^UTILITY(U,$J,358.3,760,0)
 ;;=L27.0^^3^32^45
 ;;^UTILITY(U,$J,358.3,760,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,760,1,3,0)
 ;;=3^Gen skin eruption d/t drugs/meds taken internally
 ;;^UTILITY(U,$J,358.3,760,1,4,0)
 ;;=4^L27.0
 ;;^UTILITY(U,$J,358.3,760,2)
 ;;=^5009144
 ;;^UTILITY(U,$J,358.3,761,0)
 ;;=L27.1^^3^32^53
 ;;^UTILITY(U,$J,358.3,761,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,761,1,3,0)
 ;;=3^Loc skin eruption d/t drugs/meds taken internally
 ;;^UTILITY(U,$J,358.3,761,1,4,0)
 ;;=4^L27.1
 ;;^UTILITY(U,$J,358.3,761,2)
 ;;=^5009145
 ;;^UTILITY(U,$J,358.3,762,0)
 ;;=L71.8^^3^32^136
 ;;^UTILITY(U,$J,358.3,762,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,762,1,3,0)
 ;;=3^Rosacea NEC
 ;;^UTILITY(U,$J,358.3,762,1,4,0)
 ;;=4^L71.8
 ;;^UTILITY(U,$J,358.3,762,2)
 ;;=^5009275
 ;;^UTILITY(U,$J,358.3,763,0)
 ;;=L71.0^^3^32^119
 ;;^UTILITY(U,$J,358.3,763,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,763,1,3,0)
 ;;=3^Perioral dermatitis
 ;;^UTILITY(U,$J,358.3,763,1,4,0)
 ;;=4^L71.0
 ;;^UTILITY(U,$J,358.3,763,2)
 ;;=^5009274
 ;;^UTILITY(U,$J,358.3,764,0)
 ;;=L71.1^^3^32^135
 ;;^UTILITY(U,$J,358.3,764,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,764,1,3,0)
 ;;=3^Rhinophyma
 ;;^UTILITY(U,$J,358.3,764,1,4,0)
 ;;=4^L71.1
 ;;^UTILITY(U,$J,358.3,764,2)
 ;;=^106083
 ;;^UTILITY(U,$J,358.3,765,0)
 ;;=L30.4^^3^32^36
 ;;^UTILITY(U,$J,358.3,765,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,765,1,3,0)
 ;;=3^Erythema intertrigo
 ;;^UTILITY(U,$J,358.3,765,1,4,0)
 ;;=4^L30.4
 ;;^UTILITY(U,$J,358.3,765,2)
 ;;=^5009157
 ;;^UTILITY(U,$J,358.3,766,0)
 ;;=L26.^^3^32^39
 ;;^UTILITY(U,$J,358.3,766,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,766,1,3,0)
 ;;=3^Exfoliative dermatitis
 ;;^UTILITY(U,$J,358.3,766,1,4,0)
 ;;=4^L26.
 ;;^UTILITY(U,$J,358.3,766,2)
 ;;=^263886
 ;;^UTILITY(U,$J,358.3,767,0)
 ;;=L53.8^^3^32^37
 ;;^UTILITY(U,$J,358.3,767,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,767,1,3,0)
 ;;=3^Erythematous Conditions NEC
 ;;^UTILITY(U,$J,358.3,767,1,4,0)
 ;;=4^L53.8
 ;;^UTILITY(U,$J,358.3,767,2)
 ;;=^88044
 ;;^UTILITY(U,$J,358.3,768,0)
 ;;=L92.0^^3^32^47
 ;;^UTILITY(U,$J,358.3,768,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,768,1,3,0)
 ;;=3^Granuloma annulare
 ;;^UTILITY(U,$J,358.3,768,1,4,0)
 ;;=4^L92.0
 ;;^UTILITY(U,$J,358.3,768,2)
 ;;=^184052
 ;;^UTILITY(U,$J,358.3,769,0)
 ;;=L95.1^^3^32^35
 ;;^UTILITY(U,$J,358.3,769,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,769,1,3,0)
 ;;=3^Erythema elevatum diutinum
 ;;^UTILITY(U,$J,358.3,769,1,4,0)
 ;;=4^L95.1
 ;;^UTILITY(U,$J,358.3,769,2)
 ;;=^5009477
 ;;^UTILITY(U,$J,358.3,770,0)
 ;;=L98.2^^3^32^40
 ;;^UTILITY(U,$J,358.3,770,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,770,1,3,0)
 ;;=3^Febrile neutrophilic dermatosis [Sweet]
