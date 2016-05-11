IBDEI1G7 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,24602,2)
 ;;=^5003084
 ;;^UTILITY(U,$J,358.3,24603,0)
 ;;=F10.921^^93^1093^1
 ;;^UTILITY(U,$J,358.3,24603,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24603,1,3,0)
 ;;=3^Alcohol Intoxication Delirium w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,24603,1,4,0)
 ;;=4^F10.921
 ;;^UTILITY(U,$J,358.3,24603,2)
 ;;=^5003102
 ;;^UTILITY(U,$J,358.3,24604,0)
 ;;=F05.^^93^1093^4
 ;;^UTILITY(U,$J,358.3,24604,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24604,1,3,0)
 ;;=3^Delirium d/t Another Medical Condition
 ;;^UTILITY(U,$J,358.3,24604,1,4,0)
 ;;=4^F05.
 ;;^UTILITY(U,$J,358.3,24604,2)
 ;;=^5003052
 ;;^UTILITY(U,$J,358.3,24605,0)
 ;;=F05.^^93^1093^5
 ;;^UTILITY(U,$J,358.3,24605,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24605,1,3,0)
 ;;=3^Delirium d/t Multiple Etiologies
 ;;^UTILITY(U,$J,358.3,24605,1,4,0)
 ;;=4^F05.
 ;;^UTILITY(U,$J,358.3,24605,2)
 ;;=^5003052
 ;;^UTILITY(U,$J,358.3,24606,0)
 ;;=A81.00^^93^1094^9
 ;;^UTILITY(U,$J,358.3,24606,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24606,1,3,0)
 ;;=3^Creutzfeldt-Jakob Disease,Unspec
 ;;^UTILITY(U,$J,358.3,24606,1,4,0)
 ;;=4^A81.00
 ;;^UTILITY(U,$J,358.3,24606,2)
 ;;=^5000409
 ;;^UTILITY(U,$J,358.3,24607,0)
 ;;=A81.01^^93^1094^38
 ;;^UTILITY(U,$J,358.3,24607,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24607,1,3,0)
 ;;=3^Variant Creutzfeldt-Jakob Disease
 ;;^UTILITY(U,$J,358.3,24607,1,4,0)
 ;;=4^A81.01
 ;;^UTILITY(U,$J,358.3,24607,2)
 ;;=^336701
 ;;^UTILITY(U,$J,358.3,24608,0)
 ;;=A81.09^^93^1094^8
 ;;^UTILITY(U,$J,358.3,24608,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24608,1,3,0)
 ;;=3^Creutzfeldt-Jakob Disease,Other
 ;;^UTILITY(U,$J,358.3,24608,1,4,0)
 ;;=4^A81.09
 ;;^UTILITY(U,$J,358.3,24608,2)
 ;;=^5000410
 ;;^UTILITY(U,$J,358.3,24609,0)
 ;;=A81.2^^93^1094^33
 ;;^UTILITY(U,$J,358.3,24609,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24609,1,3,0)
 ;;=3^Progressive Multifocal Leukoencephalopathy
 ;;^UTILITY(U,$J,358.3,24609,1,4,0)
 ;;=4^A81.2
 ;;^UTILITY(U,$J,358.3,24609,2)
 ;;=^5000411
 ;;^UTILITY(U,$J,358.3,24610,0)
 ;;=F01.50^^93^1094^31
 ;;^UTILITY(U,$J,358.3,24610,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24610,1,3,0)
 ;;=3^Probable Major Vascular Neurocognitive Disorder w/o Behavioral Disturbance
 ;;^UTILITY(U,$J,358.3,24610,1,4,0)
 ;;=4^F01.50
 ;;^UTILITY(U,$J,358.3,24610,2)
 ;;=^5003046
 ;;^UTILITY(U,$J,358.3,24611,0)
 ;;=F01.51^^93^1094^32
 ;;^UTILITY(U,$J,358.3,24611,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24611,1,3,0)
 ;;=3^Probable Major Vascular Neurocognitive Disorder w/ Behavioral Disturbance
 ;;^UTILITY(U,$J,358.3,24611,1,4,0)
 ;;=4^F01.51
 ;;^UTILITY(U,$J,358.3,24611,2)
 ;;=^5003047
 ;;^UTILITY(U,$J,358.3,24612,0)
 ;;=F10.27^^93^1094^1
 ;;^UTILITY(U,$J,358.3,24612,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24612,1,3,0)
 ;;=3^Alcohol-Induced Major Neurocognitive Disorder,Nonamnestic Confabulatory Type
 ;;^UTILITY(U,$J,358.3,24612,1,4,0)
 ;;=4^F10.27
 ;;^UTILITY(U,$J,358.3,24612,2)
 ;;=^5003095
 ;;^UTILITY(U,$J,358.3,24613,0)
 ;;=F19.97^^93^1094^37
 ;;^UTILITY(U,$J,358.3,24613,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24613,1,3,0)
 ;;=3^Substance-Induced Major Neurocognitive Disorder NEC
 ;;^UTILITY(U,$J,358.3,24613,1,4,0)
 ;;=4^F19.97
 ;;^UTILITY(U,$J,358.3,24613,2)
 ;;=^5003465
 ;;^UTILITY(U,$J,358.3,24614,0)
 ;;=F02.80^^93^1094^13
 ;;^UTILITY(U,$J,358.3,24614,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24614,1,3,0)
 ;;=3^Dementia in Oth Diseases Classified Elsewhere w/o Behavorial Disturbance
 ;;^UTILITY(U,$J,358.3,24614,1,4,0)
 ;;=4^F02.80
 ;;^UTILITY(U,$J,358.3,24614,2)
 ;;=^5003048
 ;;^UTILITY(U,$J,358.3,24615,0)
 ;;=F02.81^^93^1094^14
