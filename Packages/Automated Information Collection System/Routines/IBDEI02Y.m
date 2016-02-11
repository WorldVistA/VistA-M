IBDEI02Y ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,620,2)
 ;;=^329888
 ;;^UTILITY(U,$J,358.3,621,0)
 ;;=F03.90^^6^76^15
 ;;^UTILITY(U,$J,358.3,621,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,621,1,3,0)
 ;;=3^Dementia w/o Behavioral Disturbances,Unspec
 ;;^UTILITY(U,$J,358.3,621,1,4,0)
 ;;=4^F03.90
 ;;^UTILITY(U,$J,358.3,621,2)
 ;;=^5003050
 ;;^UTILITY(U,$J,358.3,622,0)
 ;;=F01.51^^6^76^30
 ;;^UTILITY(U,$J,358.3,622,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,622,1,3,0)
 ;;=3^Vascular Dementia w/ Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,622,1,4,0)
 ;;=4^F01.51
 ;;^UTILITY(U,$J,358.3,622,2)
 ;;=^5003047
 ;;^UTILITY(U,$J,358.3,623,0)
 ;;=F01.50^^6^76^31
 ;;^UTILITY(U,$J,358.3,623,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,623,1,3,0)
 ;;=3^Vascular Dementia w/o Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,623,1,4,0)
 ;;=4^F01.50
 ;;^UTILITY(U,$J,358.3,623,2)
 ;;=^5003046
 ;;^UTILITY(U,$J,358.3,624,0)
 ;;=A81.9^^6^76^6
 ;;^UTILITY(U,$J,358.3,624,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,624,1,3,0)
 ;;=3^Atypical Virus Infection of CNS,Unspec
 ;;^UTILITY(U,$J,358.3,624,1,4,0)
 ;;=4^A81.9
 ;;^UTILITY(U,$J,358.3,624,2)
 ;;=^5000414
 ;;^UTILITY(U,$J,358.3,625,0)
 ;;=A81.09^^6^76^8
 ;;^UTILITY(U,$J,358.3,625,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,625,1,3,0)
 ;;=3^Creutzfeldt-Jakob Disease NEC
 ;;^UTILITY(U,$J,358.3,625,1,4,0)
 ;;=4^A81.09
 ;;^UTILITY(U,$J,358.3,625,2)
 ;;=^5000410
 ;;^UTILITY(U,$J,358.3,626,0)
 ;;=A81.00^^6^76^9
 ;;^UTILITY(U,$J,358.3,626,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,626,1,3,0)
 ;;=3^Creutzfeldt-Jakob Disease,Unspec
 ;;^UTILITY(U,$J,358.3,626,1,4,0)
 ;;=4^A81.00
 ;;^UTILITY(U,$J,358.3,626,2)
 ;;=^5000409
 ;;^UTILITY(U,$J,358.3,627,0)
 ;;=A81.01^^6^76^10
 ;;^UTILITY(U,$J,358.3,627,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,627,1,3,0)
 ;;=3^Creutzfeldt-Jakob Disease,Variant
 ;;^UTILITY(U,$J,358.3,627,1,4,0)
 ;;=4^A81.01
 ;;^UTILITY(U,$J,358.3,627,2)
 ;;=^336701
 ;;^UTILITY(U,$J,358.3,628,0)
 ;;=A81.89^^6^76^7
 ;;^UTILITY(U,$J,358.3,628,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,628,1,3,0)
 ;;=3^Atypical Virus Infections of CNS NEC
 ;;^UTILITY(U,$J,358.3,628,1,4,0)
 ;;=4^A81.89
 ;;^UTILITY(U,$J,358.3,628,2)
 ;;=^5000413
 ;;^UTILITY(U,$J,358.3,629,0)
 ;;=A81.2^^6^76^27
 ;;^UTILITY(U,$J,358.3,629,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,629,1,3,0)
 ;;=3^Progressive Multifocal Leukoencephalopathy
 ;;^UTILITY(U,$J,358.3,629,1,4,0)
 ;;=4^A81.2
 ;;^UTILITY(U,$J,358.3,629,2)
 ;;=^5000411
 ;;^UTILITY(U,$J,358.3,630,0)
 ;;=B20.^^6^76^17
 ;;^UTILITY(U,$J,358.3,630,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,630,1,3,0)
 ;;=3^HIV Disease w/ Dementia w/ Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,630,1,4,0)
 ;;=4^B20.
 ;;^UTILITY(U,$J,358.3,630,2)
 ;;=^5000555^F02.81
 ;;^UTILITY(U,$J,358.3,631,0)
 ;;=B20.^^6^76^18
 ;;^UTILITY(U,$J,358.3,631,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,631,1,3,0)
 ;;=3^HIV Disease w/ Dementia w/o Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,631,1,4,0)
 ;;=4^B20.
 ;;^UTILITY(U,$J,358.3,631,2)
 ;;=^5000555^F02.80
 ;;^UTILITY(U,$J,358.3,632,0)
 ;;=F10.27^^6^76^1
 ;;^UTILITY(U,$J,358.3,632,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,632,1,3,0)
 ;;=3^Alcohol Dependence w/ Alcohol-Induced Persisting Dementia
 ;;^UTILITY(U,$J,358.3,632,1,4,0)
 ;;=4^F10.27
 ;;^UTILITY(U,$J,358.3,632,2)
 ;;=^5003095
 ;;^UTILITY(U,$J,358.3,633,0)
 ;;=F19.97^^6^76^29
 ;;^UTILITY(U,$J,358.3,633,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,633,1,3,0)
 ;;=3^Psychoactive Substance Use w/ Persisting Dementia NEC
 ;;^UTILITY(U,$J,358.3,633,1,4,0)
 ;;=4^F19.97
 ;;^UTILITY(U,$J,358.3,633,2)
 ;;=^5003465
