IBDEI1YN ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,32830,2)
 ;;=^5003084
 ;;^UTILITY(U,$J,358.3,32831,0)
 ;;=F10.921^^146^1584^1
 ;;^UTILITY(U,$J,358.3,32831,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32831,1,3,0)
 ;;=3^Alcohol Intoxication Delirium w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,32831,1,4,0)
 ;;=4^F10.921
 ;;^UTILITY(U,$J,358.3,32831,2)
 ;;=^5003102
 ;;^UTILITY(U,$J,358.3,32832,0)
 ;;=F05.^^146^1584^4
 ;;^UTILITY(U,$J,358.3,32832,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32832,1,3,0)
 ;;=3^Delirium d/t Another Medical Condition
 ;;^UTILITY(U,$J,358.3,32832,1,4,0)
 ;;=4^F05.
 ;;^UTILITY(U,$J,358.3,32832,2)
 ;;=^5003052
 ;;^UTILITY(U,$J,358.3,32833,0)
 ;;=F05.^^146^1584^5
 ;;^UTILITY(U,$J,358.3,32833,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32833,1,3,0)
 ;;=3^Delirium d/t Multiple Etiologies
 ;;^UTILITY(U,$J,358.3,32833,1,4,0)
 ;;=4^F05.
 ;;^UTILITY(U,$J,358.3,32833,2)
 ;;=^5003052
 ;;^UTILITY(U,$J,358.3,32834,0)
 ;;=A81.00^^146^1585^9
 ;;^UTILITY(U,$J,358.3,32834,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32834,1,3,0)
 ;;=3^Creutzfeldt-Jakob Disease,Unspec
 ;;^UTILITY(U,$J,358.3,32834,1,4,0)
 ;;=4^A81.00
 ;;^UTILITY(U,$J,358.3,32834,2)
 ;;=^5000409
 ;;^UTILITY(U,$J,358.3,32835,0)
 ;;=A81.01^^146^1585^38
 ;;^UTILITY(U,$J,358.3,32835,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32835,1,3,0)
 ;;=3^Variant Creutzfeldt-Jakob Disease
 ;;^UTILITY(U,$J,358.3,32835,1,4,0)
 ;;=4^A81.01
 ;;^UTILITY(U,$J,358.3,32835,2)
 ;;=^336701
 ;;^UTILITY(U,$J,358.3,32836,0)
 ;;=A81.09^^146^1585^8
 ;;^UTILITY(U,$J,358.3,32836,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32836,1,3,0)
 ;;=3^Creutzfeldt-Jakob Disease,Other
 ;;^UTILITY(U,$J,358.3,32836,1,4,0)
 ;;=4^A81.09
 ;;^UTILITY(U,$J,358.3,32836,2)
 ;;=^5000410
 ;;^UTILITY(U,$J,358.3,32837,0)
 ;;=A81.2^^146^1585^33
 ;;^UTILITY(U,$J,358.3,32837,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32837,1,3,0)
 ;;=3^Progressive Multifocal Leukoencephalopathy
 ;;^UTILITY(U,$J,358.3,32837,1,4,0)
 ;;=4^A81.2
 ;;^UTILITY(U,$J,358.3,32837,2)
 ;;=^5000411
 ;;^UTILITY(U,$J,358.3,32838,0)
 ;;=F01.50^^146^1585^31
 ;;^UTILITY(U,$J,358.3,32838,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32838,1,3,0)
 ;;=3^Probable Major Vascular Neurocognitive Disorder w/o Behavioral Disturbance
 ;;^UTILITY(U,$J,358.3,32838,1,4,0)
 ;;=4^F01.50
 ;;^UTILITY(U,$J,358.3,32838,2)
 ;;=^5003046
 ;;^UTILITY(U,$J,358.3,32839,0)
 ;;=F01.51^^146^1585^32
 ;;^UTILITY(U,$J,358.3,32839,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32839,1,3,0)
 ;;=3^Probable Major Vascular Neurocognitive Disorder w/ Behavioral Disturbance
 ;;^UTILITY(U,$J,358.3,32839,1,4,0)
 ;;=4^F01.51
 ;;^UTILITY(U,$J,358.3,32839,2)
 ;;=^5003047
 ;;^UTILITY(U,$J,358.3,32840,0)
 ;;=F10.27^^146^1585^1
 ;;^UTILITY(U,$J,358.3,32840,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32840,1,3,0)
 ;;=3^Alcohol-Induced Major Neurocognitive Disorder,Nonamnestic Confabulatory Type
 ;;^UTILITY(U,$J,358.3,32840,1,4,0)
 ;;=4^F10.27
 ;;^UTILITY(U,$J,358.3,32840,2)
 ;;=^5003095
 ;;^UTILITY(U,$J,358.3,32841,0)
 ;;=F19.97^^146^1585^37
 ;;^UTILITY(U,$J,358.3,32841,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32841,1,3,0)
 ;;=3^Substance-Induced Major Neurocognitive Disorder NEC
 ;;^UTILITY(U,$J,358.3,32841,1,4,0)
 ;;=4^F19.97
 ;;^UTILITY(U,$J,358.3,32841,2)
 ;;=^5003465
 ;;^UTILITY(U,$J,358.3,32842,0)
 ;;=F02.80^^146^1585^13
 ;;^UTILITY(U,$J,358.3,32842,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32842,1,3,0)
 ;;=3^Dementia in Oth Diseases Classified Elsewhere w/o Behavorial Disturbance
 ;;^UTILITY(U,$J,358.3,32842,1,4,0)
 ;;=4^F02.80
 ;;^UTILITY(U,$J,358.3,32842,2)
 ;;=^5003048
