IBDEI146 ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,17890,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17890,1,3,0)
 ;;=3^Car Occpnt,Unspec,Injured in Collsn w/ Fixed Obj/Traffic,Init Encntr
 ;;^UTILITY(U,$J,358.3,17890,1,4,0)
 ;;=4^V47.9XXA
 ;;^UTILITY(U,$J,358.3,17890,2)
 ;;=^5140369
 ;;^UTILITY(U,$J,358.3,17891,0)
 ;;=W26.2XXA^^88^898^15
 ;;^UTILITY(U,$J,358.3,17891,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17891,1,3,0)
 ;;=3^Contact w/ Edge of Stiff Paper,Init Encntr
 ;;^UTILITY(U,$J,358.3,17891,1,4,0)
 ;;=4^W26.2XXA
 ;;^UTILITY(U,$J,358.3,17891,2)
 ;;=^5140372
 ;;^UTILITY(U,$J,358.3,17892,0)
 ;;=W26.8XXA^^88^898^16
 ;;^UTILITY(U,$J,358.3,17892,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17892,1,3,0)
 ;;=3^Contact w/ Other Sharp Object,Init Encntr
 ;;^UTILITY(U,$J,358.3,17892,1,4,0)
 ;;=4^W26.8XXA
 ;;^UTILITY(U,$J,358.3,17892,2)
 ;;=^5140375
 ;;^UTILITY(U,$J,358.3,17893,0)
 ;;=W26.9XXA^^88^898^17
 ;;^UTILITY(U,$J,358.3,17893,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17893,1,3,0)
 ;;=3^Contact w/ Unspec Sharp Object,Init Encntr
 ;;^UTILITY(U,$J,358.3,17893,1,4,0)
 ;;=4^W26.9XXA
 ;;^UTILITY(U,$J,358.3,17893,2)
 ;;=^5140378
 ;;^UTILITY(U,$J,358.3,17894,0)
 ;;=X50.0XXA^^88^898^103
 ;;^UTILITY(U,$J,358.3,17894,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17894,1,3,0)
 ;;=3^Overexertion from Strenuous Movement/Load,Init Encntr
 ;;^UTILITY(U,$J,358.3,17894,1,4,0)
 ;;=4^X50.0XXA
 ;;^UTILITY(U,$J,358.3,17894,2)
 ;;=^5140381
 ;;^UTILITY(U,$J,358.3,17895,0)
 ;;=X50.1XXA^^88^898^105
 ;;^UTILITY(U,$J,358.3,17895,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17895,1,3,0)
 ;;=3^Overextertion from Prlgd/Akwrd Postures,Init Encntr
 ;;^UTILITY(U,$J,358.3,17895,1,4,0)
 ;;=4^X50.1XXA
 ;;^UTILITY(U,$J,358.3,17895,2)
 ;;=^5140384
 ;;^UTILITY(U,$J,358.3,17896,0)
 ;;=X50.3XXA^^88^898^102
 ;;^UTILITY(U,$J,358.3,17896,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17896,1,3,0)
 ;;=3^Overexertion from Repetitive Movements,Init Encntr
 ;;^UTILITY(U,$J,358.3,17896,1,4,0)
 ;;=4^X50.3XXA
 ;;^UTILITY(U,$J,358.3,17896,2)
 ;;=^5140387
 ;;^UTILITY(U,$J,358.3,17897,0)
 ;;=X50.9XXA^^88^898^104
 ;;^UTILITY(U,$J,358.3,17897,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17897,1,3,0)
 ;;=3^Overexertion/Sten Mvmnts/Postures,Oth/Unspec,Init Encntr
 ;;^UTILITY(U,$J,358.3,17897,1,4,0)
 ;;=4^X50.9XXA
 ;;^UTILITY(U,$J,358.3,17897,2)
 ;;=^5140390
 ;;^UTILITY(U,$J,358.3,17898,0)
 ;;=F02.81^^88^899^11
 ;;^UTILITY(U,$J,358.3,17898,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17898,1,3,0)
 ;;=3^Dementia in Oth Diseases Classd Elswhr w/ Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,17898,1,4,0)
 ;;=4^F02.81
 ;;^UTILITY(U,$J,358.3,17898,2)
 ;;=^5003049
 ;;^UTILITY(U,$J,358.3,17899,0)
 ;;=F02.80^^88^899^12
 ;;^UTILITY(U,$J,358.3,17899,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17899,1,3,0)
 ;;=3^Dementia in Oth Diseases Classd Elswhr w/o Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,17899,1,4,0)
 ;;=4^F02.80
 ;;^UTILITY(U,$J,358.3,17899,2)
 ;;=^5003048
 ;;^UTILITY(U,$J,358.3,17900,0)
 ;;=F03.91^^88^899^13
 ;;^UTILITY(U,$J,358.3,17900,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17900,1,3,0)
 ;;=3^Dementia w/ Behavioral Disturbances,Unspec
 ;;^UTILITY(U,$J,358.3,17900,1,4,0)
 ;;=4^F03.91
 ;;^UTILITY(U,$J,358.3,17900,2)
 ;;=^5133350
 ;;^UTILITY(U,$J,358.3,17901,0)
 ;;=G31.83^^88^899^14
 ;;^UTILITY(U,$J,358.3,17901,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17901,1,3,0)
 ;;=3^Dementia w/ Lewy Bodies
