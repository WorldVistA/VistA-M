IBDEI1VS ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,31503,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31503,1,3,0)
 ;;=3^Alcohol Withdrawal Delirium w/ Perceptual Disturbances
 ;;^UTILITY(U,$J,358.3,31503,1,4,0)
 ;;=4^F10.232
 ;;^UTILITY(U,$J,358.3,31503,2)
 ;;=^5003088
 ;;^UTILITY(U,$J,358.3,31504,0)
 ;;=F10.231^^138^1428^3
 ;;^UTILITY(U,$J,358.3,31504,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31504,1,3,0)
 ;;=3^Alcohol Withdrawal Delirium w/o Perceptual Disturbances
 ;;^UTILITY(U,$J,358.3,31504,1,4,0)
 ;;=4^F10.231
 ;;^UTILITY(U,$J,358.3,31504,2)
 ;;=^5003087
 ;;^UTILITY(U,$J,358.3,31505,0)
 ;;=F10.121^^138^1428^6
 ;;^UTILITY(U,$J,358.3,31505,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31505,1,3,0)
 ;;=3^Mild Alcohol Use Disorder w/ Intoxication Delirium
 ;;^UTILITY(U,$J,358.3,31505,1,4,0)
 ;;=4^F10.121
 ;;^UTILITY(U,$J,358.3,31505,2)
 ;;=^5003070
 ;;^UTILITY(U,$J,358.3,31506,0)
 ;;=F10.221^^138^1428^7
 ;;^UTILITY(U,$J,358.3,31506,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31506,1,3,0)
 ;;=3^Moderate/Severe Alcohol Use Disorder w/ Intoxication Delirium
 ;;^UTILITY(U,$J,358.3,31506,1,4,0)
 ;;=4^F10.221
 ;;^UTILITY(U,$J,358.3,31506,2)
 ;;=^5003084
 ;;^UTILITY(U,$J,358.3,31507,0)
 ;;=F10.921^^138^1428^1
 ;;^UTILITY(U,$J,358.3,31507,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31507,1,3,0)
 ;;=3^Alcohol Intoxication Delirium w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,31507,1,4,0)
 ;;=4^F10.921
 ;;^UTILITY(U,$J,358.3,31507,2)
 ;;=^5003102
 ;;^UTILITY(U,$J,358.3,31508,0)
 ;;=F05.^^138^1428^4
 ;;^UTILITY(U,$J,358.3,31508,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31508,1,3,0)
 ;;=3^Delirium d/t Another Medical Condition
 ;;^UTILITY(U,$J,358.3,31508,1,4,0)
 ;;=4^F05.
 ;;^UTILITY(U,$J,358.3,31508,2)
 ;;=^5003052
 ;;^UTILITY(U,$J,358.3,31509,0)
 ;;=F05.^^138^1428^5
 ;;^UTILITY(U,$J,358.3,31509,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31509,1,3,0)
 ;;=3^Delirium d/t Multiple Etiologies
 ;;^UTILITY(U,$J,358.3,31509,1,4,0)
 ;;=4^F05.
 ;;^UTILITY(U,$J,358.3,31509,2)
 ;;=^5003052
 ;;^UTILITY(U,$J,358.3,31510,0)
 ;;=A81.00^^138^1429^9
 ;;^UTILITY(U,$J,358.3,31510,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31510,1,3,0)
 ;;=3^Creutzfeldt-Jakob Disease,Unspec
 ;;^UTILITY(U,$J,358.3,31510,1,4,0)
 ;;=4^A81.00
 ;;^UTILITY(U,$J,358.3,31510,2)
 ;;=^5000409
 ;;^UTILITY(U,$J,358.3,31511,0)
 ;;=A81.01^^138^1429^38
 ;;^UTILITY(U,$J,358.3,31511,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31511,1,3,0)
 ;;=3^Variant Creutzfeldt-Jakob Disease
 ;;^UTILITY(U,$J,358.3,31511,1,4,0)
 ;;=4^A81.01
 ;;^UTILITY(U,$J,358.3,31511,2)
 ;;=^336701
 ;;^UTILITY(U,$J,358.3,31512,0)
 ;;=A81.09^^138^1429^8
 ;;^UTILITY(U,$J,358.3,31512,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31512,1,3,0)
 ;;=3^Creutzfeldt-Jakob Disease,Other
 ;;^UTILITY(U,$J,358.3,31512,1,4,0)
 ;;=4^A81.09
 ;;^UTILITY(U,$J,358.3,31512,2)
 ;;=^5000410
 ;;^UTILITY(U,$J,358.3,31513,0)
 ;;=A81.2^^138^1429^33
 ;;^UTILITY(U,$J,358.3,31513,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31513,1,3,0)
 ;;=3^Progressive Multifocal Leukoencephalopathy
 ;;^UTILITY(U,$J,358.3,31513,1,4,0)
 ;;=4^A81.2
 ;;^UTILITY(U,$J,358.3,31513,2)
 ;;=^5000411
 ;;^UTILITY(U,$J,358.3,31514,0)
 ;;=F01.50^^138^1429^31
 ;;^UTILITY(U,$J,358.3,31514,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31514,1,3,0)
 ;;=3^Probable Major Vascular Neurocognitive Disorder w/o Behavioral Disturbance
 ;;^UTILITY(U,$J,358.3,31514,1,4,0)
 ;;=4^F01.50
 ;;^UTILITY(U,$J,358.3,31514,2)
 ;;=^5003046
 ;;^UTILITY(U,$J,358.3,31515,0)
 ;;=F01.51^^138^1429^32
 ;;^UTILITY(U,$J,358.3,31515,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31515,1,3,0)
 ;;=3^Probable Major Vascular Neurocognitive Disorder w/ Behavioral Disturbance
