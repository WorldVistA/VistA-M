IBDEI1N4 ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,26196,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26196,1,3,0)
 ;;=3^Overexertion from Strenuous Movement/Load,Init Encntr
 ;;^UTILITY(U,$J,358.3,26196,1,4,0)
 ;;=4^X50.0XXA
 ;;^UTILITY(U,$J,358.3,26196,2)
 ;;=^5140381
 ;;^UTILITY(U,$J,358.3,26197,0)
 ;;=X50.1XXA^^107^1230^105
 ;;^UTILITY(U,$J,358.3,26197,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26197,1,3,0)
 ;;=3^Overextertion from Prlgd/Akwrd Postures,Init Encntr
 ;;^UTILITY(U,$J,358.3,26197,1,4,0)
 ;;=4^X50.1XXA
 ;;^UTILITY(U,$J,358.3,26197,2)
 ;;=^5140384
 ;;^UTILITY(U,$J,358.3,26198,0)
 ;;=X50.3XXA^^107^1230^102
 ;;^UTILITY(U,$J,358.3,26198,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26198,1,3,0)
 ;;=3^Overexertion from Repetitive Movements,Init Encntr
 ;;^UTILITY(U,$J,358.3,26198,1,4,0)
 ;;=4^X50.3XXA
 ;;^UTILITY(U,$J,358.3,26198,2)
 ;;=^5140387
 ;;^UTILITY(U,$J,358.3,26199,0)
 ;;=X50.9XXA^^107^1230^104
 ;;^UTILITY(U,$J,358.3,26199,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26199,1,3,0)
 ;;=3^Overexertion/Sten Mvmnts/Postures,Oth/Unspec,Init Encntr
 ;;^UTILITY(U,$J,358.3,26199,1,4,0)
 ;;=4^X50.9XXA
 ;;^UTILITY(U,$J,358.3,26199,2)
 ;;=^5140390
 ;;^UTILITY(U,$J,358.3,26200,0)
 ;;=F02.81^^107^1231^11
 ;;^UTILITY(U,$J,358.3,26200,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26200,1,3,0)
 ;;=3^Dementia in Oth Diseases Classd Elswhr w/ Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,26200,1,4,0)
 ;;=4^F02.81
 ;;^UTILITY(U,$J,358.3,26200,2)
 ;;=^5003049
 ;;^UTILITY(U,$J,358.3,26201,0)
 ;;=F02.80^^107^1231^12
 ;;^UTILITY(U,$J,358.3,26201,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26201,1,3,0)
 ;;=3^Dementia in Oth Diseases Classd Elswhr w/o Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,26201,1,4,0)
 ;;=4^F02.80
 ;;^UTILITY(U,$J,358.3,26201,2)
 ;;=^5003048
 ;;^UTILITY(U,$J,358.3,26202,0)
 ;;=F03.91^^107^1231^13
 ;;^UTILITY(U,$J,358.3,26202,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26202,1,3,0)
 ;;=3^Dementia w/ Behavioral Disturbances,Unspec
 ;;^UTILITY(U,$J,358.3,26202,1,4,0)
 ;;=4^F03.91
 ;;^UTILITY(U,$J,358.3,26202,2)
 ;;=^5133350
 ;;^UTILITY(U,$J,358.3,26203,0)
 ;;=G31.83^^107^1231^14
 ;;^UTILITY(U,$J,358.3,26203,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26203,1,3,0)
 ;;=3^Dementia w/ Lewy Bodies
 ;;^UTILITY(U,$J,358.3,26203,1,4,0)
 ;;=4^G31.83
 ;;^UTILITY(U,$J,358.3,26203,2)
 ;;=^329888
 ;;^UTILITY(U,$J,358.3,26204,0)
 ;;=F01.51^^107^1231^30
 ;;^UTILITY(U,$J,358.3,26204,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26204,1,3,0)
 ;;=3^Vascular Dementia w/ Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,26204,1,4,0)
 ;;=4^F01.51
 ;;^UTILITY(U,$J,358.3,26204,2)
 ;;=^5003047
 ;;^UTILITY(U,$J,358.3,26205,0)
 ;;=F01.50^^107^1231^31
 ;;^UTILITY(U,$J,358.3,26205,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26205,1,3,0)
 ;;=3^Vascular Dementia w/o Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,26205,1,4,0)
 ;;=4^F01.50
 ;;^UTILITY(U,$J,358.3,26205,2)
 ;;=^5003046
 ;;^UTILITY(U,$J,358.3,26206,0)
 ;;=A81.9^^107^1231^6
 ;;^UTILITY(U,$J,358.3,26206,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26206,1,3,0)
 ;;=3^Atypical Virus Infection of CNS,Unspec
 ;;^UTILITY(U,$J,358.3,26206,1,4,0)
 ;;=4^A81.9
 ;;^UTILITY(U,$J,358.3,26206,2)
 ;;=^5000414
 ;;^UTILITY(U,$J,358.3,26207,0)
 ;;=A81.09^^107^1231^8
 ;;^UTILITY(U,$J,358.3,26207,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26207,1,3,0)
 ;;=3^Creutzfeldt-Jakob Disease NEC
 ;;^UTILITY(U,$J,358.3,26207,1,4,0)
 ;;=4^A81.09
