IBDEI0VF ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,14725,1,4,0)
 ;;=4^Y36.230S
 ;;^UTILITY(U,$J,358.3,14725,2)
 ;;=^5061627
 ;;^UTILITY(U,$J,358.3,14726,0)
 ;;=Y36.7X0S^^53^612^130
 ;;^UTILITY(U,$J,358.3,14726,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14726,1,3,0)
 ;;=3^War Op w/ Chem Weapons/Unconvtl Warfare,Milt,Sequela
 ;;^UTILITY(U,$J,358.3,14726,1,4,0)
 ;;=4^Y36.7X0S
 ;;^UTILITY(U,$J,358.3,14726,2)
 ;;=^5061783
 ;;^UTILITY(U,$J,358.3,14727,0)
 ;;=F02.81^^53^613^11
 ;;^UTILITY(U,$J,358.3,14727,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14727,1,3,0)
 ;;=3^Dementia in Oth Diseases Classd Elswhr w/ Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,14727,1,4,0)
 ;;=4^F02.81
 ;;^UTILITY(U,$J,358.3,14727,2)
 ;;=^5003049
 ;;^UTILITY(U,$J,358.3,14728,0)
 ;;=F02.80^^53^613^12
 ;;^UTILITY(U,$J,358.3,14728,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14728,1,3,0)
 ;;=3^Dementia in Oth Diseases Classd Elswhr w/o Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,14728,1,4,0)
 ;;=4^F02.80
 ;;^UTILITY(U,$J,358.3,14728,2)
 ;;=^5003048
 ;;^UTILITY(U,$J,358.3,14729,0)
 ;;=F03.91^^53^613^13
 ;;^UTILITY(U,$J,358.3,14729,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14729,1,3,0)
 ;;=3^Dementia w/ Behavioral Disturbances,Unspec
 ;;^UTILITY(U,$J,358.3,14729,1,4,0)
 ;;=4^F03.91
 ;;^UTILITY(U,$J,358.3,14729,2)
 ;;=^5133350
 ;;^UTILITY(U,$J,358.3,14730,0)
 ;;=G31.83^^53^613^14
 ;;^UTILITY(U,$J,358.3,14730,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14730,1,3,0)
 ;;=3^Dementia w/ Lewy Bodies
 ;;^UTILITY(U,$J,358.3,14730,1,4,0)
 ;;=4^G31.83
 ;;^UTILITY(U,$J,358.3,14730,2)
 ;;=^329888
 ;;^UTILITY(U,$J,358.3,14731,0)
 ;;=F01.51^^53^613^30
 ;;^UTILITY(U,$J,358.3,14731,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14731,1,3,0)
 ;;=3^Vascular Dementia w/ Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,14731,1,4,0)
 ;;=4^F01.51
 ;;^UTILITY(U,$J,358.3,14731,2)
 ;;=^5003047
 ;;^UTILITY(U,$J,358.3,14732,0)
 ;;=F01.50^^53^613^31
 ;;^UTILITY(U,$J,358.3,14732,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14732,1,3,0)
 ;;=3^Vascular Dementia w/o Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,14732,1,4,0)
 ;;=4^F01.50
 ;;^UTILITY(U,$J,358.3,14732,2)
 ;;=^5003046
 ;;^UTILITY(U,$J,358.3,14733,0)
 ;;=A81.9^^53^613^6
 ;;^UTILITY(U,$J,358.3,14733,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14733,1,3,0)
 ;;=3^Atypical Virus Infection of CNS,Unspec
 ;;^UTILITY(U,$J,358.3,14733,1,4,0)
 ;;=4^A81.9
 ;;^UTILITY(U,$J,358.3,14733,2)
 ;;=^5000414
 ;;^UTILITY(U,$J,358.3,14734,0)
 ;;=A81.09^^53^613^8
 ;;^UTILITY(U,$J,358.3,14734,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14734,1,3,0)
 ;;=3^Creutzfeldt-Jakob Disease NEC
 ;;^UTILITY(U,$J,358.3,14734,1,4,0)
 ;;=4^A81.09
 ;;^UTILITY(U,$J,358.3,14734,2)
 ;;=^5000410
 ;;^UTILITY(U,$J,358.3,14735,0)
 ;;=A81.00^^53^613^9
 ;;^UTILITY(U,$J,358.3,14735,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14735,1,3,0)
 ;;=3^Creutzfeldt-Jakob Disease,Unspec
 ;;^UTILITY(U,$J,358.3,14735,1,4,0)
 ;;=4^A81.00
 ;;^UTILITY(U,$J,358.3,14735,2)
 ;;=^5000409
 ;;^UTILITY(U,$J,358.3,14736,0)
 ;;=A81.01^^53^613^10
 ;;^UTILITY(U,$J,358.3,14736,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14736,1,3,0)
 ;;=3^Creutzfeldt-Jakob Disease,Variant
 ;;^UTILITY(U,$J,358.3,14736,1,4,0)
 ;;=4^A81.01
 ;;^UTILITY(U,$J,358.3,14736,2)
 ;;=^336701
 ;;^UTILITY(U,$J,358.3,14737,0)
 ;;=A81.89^^53^613^7
 ;;^UTILITY(U,$J,358.3,14737,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14737,1,3,0)
 ;;=3^Atypical Virus Infections of CNS NEC
 ;;^UTILITY(U,$J,358.3,14737,1,4,0)
 ;;=4^A81.89
 ;;^UTILITY(U,$J,358.3,14737,2)
 ;;=^5000413
 ;;^UTILITY(U,$J,358.3,14738,0)
 ;;=A81.2^^53^613^27
