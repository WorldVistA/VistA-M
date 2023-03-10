IBDEI13X ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,17964,1,4,0)
 ;;=4^X50.3XXA
 ;;^UTILITY(U,$J,358.3,17964,2)
 ;;=^5140387
 ;;^UTILITY(U,$J,358.3,17965,0)
 ;;=X50.9XXA^^61^794^104
 ;;^UTILITY(U,$J,358.3,17965,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17965,1,3,0)
 ;;=3^Overexertion/Sten Mvmnts/Postures,Oth/Unspec,Init Encntr
 ;;^UTILITY(U,$J,358.3,17965,1,4,0)
 ;;=4^X50.9XXA
 ;;^UTILITY(U,$J,358.3,17965,2)
 ;;=^5140390
 ;;^UTILITY(U,$J,358.3,17966,0)
 ;;=F02.81^^61^795^11
 ;;^UTILITY(U,$J,358.3,17966,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17966,1,3,0)
 ;;=3^Dementia in Oth Diseases Classd Elswhr w/ Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,17966,1,4,0)
 ;;=4^F02.81
 ;;^UTILITY(U,$J,358.3,17966,2)
 ;;=^5003049
 ;;^UTILITY(U,$J,358.3,17967,0)
 ;;=F02.80^^61^795^12
 ;;^UTILITY(U,$J,358.3,17967,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17967,1,3,0)
 ;;=3^Dementia in Oth Diseases Classd Elswhr w/o Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,17967,1,4,0)
 ;;=4^F02.80
 ;;^UTILITY(U,$J,358.3,17967,2)
 ;;=^5003048
 ;;^UTILITY(U,$J,358.3,17968,0)
 ;;=F03.91^^61^795^13
 ;;^UTILITY(U,$J,358.3,17968,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17968,1,3,0)
 ;;=3^Dementia w/ Behavioral Disturbances,Unspec
 ;;^UTILITY(U,$J,358.3,17968,1,4,0)
 ;;=4^F03.91
 ;;^UTILITY(U,$J,358.3,17968,2)
 ;;=^5133350
 ;;^UTILITY(U,$J,358.3,17969,0)
 ;;=G31.83^^61^795^14
 ;;^UTILITY(U,$J,358.3,17969,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17969,1,3,0)
 ;;=3^Dementia w/ Lewy Bodies
 ;;^UTILITY(U,$J,358.3,17969,1,4,0)
 ;;=4^G31.83
 ;;^UTILITY(U,$J,358.3,17969,2)
 ;;=^329888
 ;;^UTILITY(U,$J,358.3,17970,0)
 ;;=F01.51^^61^795^30
 ;;^UTILITY(U,$J,358.3,17970,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17970,1,3,0)
 ;;=3^Vascular Dementia w/ Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,17970,1,4,0)
 ;;=4^F01.51
 ;;^UTILITY(U,$J,358.3,17970,2)
 ;;=^5003047
 ;;^UTILITY(U,$J,358.3,17971,0)
 ;;=F01.50^^61^795^31
 ;;^UTILITY(U,$J,358.3,17971,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17971,1,3,0)
 ;;=3^Vascular Dementia w/o Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,17971,1,4,0)
 ;;=4^F01.50
 ;;^UTILITY(U,$J,358.3,17971,2)
 ;;=^5003046
 ;;^UTILITY(U,$J,358.3,17972,0)
 ;;=A81.9^^61^795^6
 ;;^UTILITY(U,$J,358.3,17972,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17972,1,3,0)
 ;;=3^Atypical Virus Infection of CNS,Unspec
 ;;^UTILITY(U,$J,358.3,17972,1,4,0)
 ;;=4^A81.9
 ;;^UTILITY(U,$J,358.3,17972,2)
 ;;=^5000414
 ;;^UTILITY(U,$J,358.3,17973,0)
 ;;=A81.09^^61^795^8
 ;;^UTILITY(U,$J,358.3,17973,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17973,1,3,0)
 ;;=3^Creutzfeldt-Jakob Disease NEC
 ;;^UTILITY(U,$J,358.3,17973,1,4,0)
 ;;=4^A81.09
 ;;^UTILITY(U,$J,358.3,17973,2)
 ;;=^5000410
 ;;^UTILITY(U,$J,358.3,17974,0)
 ;;=A81.00^^61^795^9
 ;;^UTILITY(U,$J,358.3,17974,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17974,1,3,0)
 ;;=3^Creutzfeldt-Jakob Disease,Unspec
 ;;^UTILITY(U,$J,358.3,17974,1,4,0)
 ;;=4^A81.00
 ;;^UTILITY(U,$J,358.3,17974,2)
 ;;=^5000409
 ;;^UTILITY(U,$J,358.3,17975,0)
 ;;=A81.01^^61^795^10
 ;;^UTILITY(U,$J,358.3,17975,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17975,1,3,0)
 ;;=3^Creutzfeldt-Jakob Disease,Variant
 ;;^UTILITY(U,$J,358.3,17975,1,4,0)
 ;;=4^A81.01
 ;;^UTILITY(U,$J,358.3,17975,2)
 ;;=^336701
 ;;^UTILITY(U,$J,358.3,17976,0)
 ;;=A81.89^^61^795^7
 ;;^UTILITY(U,$J,358.3,17976,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17976,1,3,0)
 ;;=3^Atypical Virus Infections of CNS NEC
