IBDEI07L ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,3051,1,3,0)
 ;;=3^Delirium d/t Another Medical Condition
 ;;^UTILITY(U,$J,358.3,3051,1,4,0)
 ;;=4^F05.
 ;;^UTILITY(U,$J,358.3,3051,2)
 ;;=^5003052
 ;;^UTILITY(U,$J,358.3,3052,0)
 ;;=F05.^^8^88^5
 ;;^UTILITY(U,$J,358.3,3052,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3052,1,3,0)
 ;;=3^Delirium d/t Multiple Etiologies
 ;;^UTILITY(U,$J,358.3,3052,1,4,0)
 ;;=4^F05.
 ;;^UTILITY(U,$J,358.3,3052,2)
 ;;=^5003052
 ;;^UTILITY(U,$J,358.3,3053,0)
 ;;=A81.00^^8^89^5
 ;;^UTILITY(U,$J,358.3,3053,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3053,1,3,0)
 ;;=3^Creutzfeldt-Jakob Disease,Unspec
 ;;^UTILITY(U,$J,358.3,3053,1,4,0)
 ;;=4^A81.00
 ;;^UTILITY(U,$J,358.3,3053,2)
 ;;=^5000409
 ;;^UTILITY(U,$J,358.3,3054,0)
 ;;=A81.01^^8^89^23
 ;;^UTILITY(U,$J,358.3,3054,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3054,1,3,0)
 ;;=3^Variant Creutzfeldt-Jakob Disease
 ;;^UTILITY(U,$J,358.3,3054,1,4,0)
 ;;=4^A81.01
 ;;^UTILITY(U,$J,358.3,3054,2)
 ;;=^336701
 ;;^UTILITY(U,$J,358.3,3055,0)
 ;;=A81.09^^8^89^4
 ;;^UTILITY(U,$J,358.3,3055,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3055,1,3,0)
 ;;=3^Creutzfeldt-Jakob Disease,Other
 ;;^UTILITY(U,$J,358.3,3055,1,4,0)
 ;;=4^A81.09
 ;;^UTILITY(U,$J,358.3,3055,2)
 ;;=^5000410
 ;;^UTILITY(U,$J,358.3,3056,0)
 ;;=A81.2^^8^89^20
 ;;^UTILITY(U,$J,358.3,3056,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3056,1,3,0)
 ;;=3^Progressive Multifocal Leukoencephalopathy
 ;;^UTILITY(U,$J,358.3,3056,1,4,0)
 ;;=4^A81.2
 ;;^UTILITY(U,$J,358.3,3056,2)
 ;;=^5000411
 ;;^UTILITY(U,$J,358.3,3057,0)
 ;;=F03.90^^8^89^12
 ;;^UTILITY(U,$J,358.3,3057,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3057,1,3,0)
 ;;=3^Dementia w/o Behavioral Disturbance,Unspec
 ;;^UTILITY(U,$J,358.3,3057,1,4,0)
 ;;=4^F03.90
 ;;^UTILITY(U,$J,358.3,3057,2)
 ;;=^5003050
 ;;^UTILITY(U,$J,358.3,3058,0)
 ;;=F01.50^^8^89^18
 ;;^UTILITY(U,$J,358.3,3058,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3058,1,3,0)
 ;;=3^Probable Major Vascular Neurocognitive Disorder w/o Behavioral Disturbance
 ;;^UTILITY(U,$J,358.3,3058,1,4,0)
 ;;=4^F01.50
 ;;^UTILITY(U,$J,358.3,3058,2)
 ;;=^5003046
 ;;^UTILITY(U,$J,358.3,3059,0)
 ;;=F01.51^^8^89^19
 ;;^UTILITY(U,$J,358.3,3059,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3059,1,3,0)
 ;;=3^Probable Major Vascular Neurocognitive Disorder w/ Behavioral Disturbance
 ;;^UTILITY(U,$J,358.3,3059,1,4,0)
 ;;=4^F01.51
 ;;^UTILITY(U,$J,358.3,3059,2)
 ;;=^5003047
 ;;^UTILITY(U,$J,358.3,3060,0)
 ;;=F10.27^^8^89^1
 ;;^UTILITY(U,$J,358.3,3060,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3060,1,3,0)
 ;;=3^Alcohol-Induced Major Neurocognitive Disorder,Nonamnestic Confabulatory Type
 ;;^UTILITY(U,$J,358.3,3060,1,4,0)
 ;;=4^F10.27
 ;;^UTILITY(U,$J,358.3,3060,2)
 ;;=^5003095
 ;;^UTILITY(U,$J,358.3,3061,0)
 ;;=F19.97^^8^89^22
 ;;^UTILITY(U,$J,358.3,3061,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3061,1,3,0)
 ;;=3^Substance-Induced Major Neurocognitive Disorder NEC
 ;;^UTILITY(U,$J,358.3,3061,1,4,0)
 ;;=4^F19.97
 ;;^UTILITY(U,$J,358.3,3061,2)
 ;;=^5003465
 ;;^UTILITY(U,$J,358.3,3062,0)
 ;;=F02.80^^8^89^9
 ;;^UTILITY(U,$J,358.3,3062,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3062,1,3,0)
 ;;=3^Dementia in Other Diseases Classified Elsewhere w/o Behavorial Disturbance
 ;;^UTILITY(U,$J,358.3,3062,1,4,0)
 ;;=4^F02.80
 ;;^UTILITY(U,$J,358.3,3062,2)
 ;;=^5003048
 ;;^UTILITY(U,$J,358.3,3063,0)
 ;;=F02.81^^8^89^10
 ;;^UTILITY(U,$J,358.3,3063,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3063,1,3,0)
 ;;=3^Dementia in Other Diseases Classified Elsewhere w/ Behavioral Disturbance
 ;;^UTILITY(U,$J,358.3,3063,1,4,0)
 ;;=4^F02.81
