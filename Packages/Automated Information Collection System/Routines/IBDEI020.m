IBDEI020 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,164,1,3,0)
 ;;=3^Alcohol Withdrawal Delirium w/o Perceptual Disturbances
 ;;^UTILITY(U,$J,358.3,164,1,4,0)
 ;;=4^F10.231
 ;;^UTILITY(U,$J,358.3,164,2)
 ;;=^5003087
 ;;^UTILITY(U,$J,358.3,165,0)
 ;;=F10.121^^3^26^6
 ;;^UTILITY(U,$J,358.3,165,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,165,1,3,0)
 ;;=3^Mild Alcohol Use Disorder w/ Intoxication Delirium
 ;;^UTILITY(U,$J,358.3,165,1,4,0)
 ;;=4^F10.121
 ;;^UTILITY(U,$J,358.3,165,2)
 ;;=^5003070
 ;;^UTILITY(U,$J,358.3,166,0)
 ;;=F10.221^^3^26^7
 ;;^UTILITY(U,$J,358.3,166,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,166,1,3,0)
 ;;=3^Moderate/Severe Alcohol Use Disorder w/ Intoxication Delirium
 ;;^UTILITY(U,$J,358.3,166,1,4,0)
 ;;=4^F10.221
 ;;^UTILITY(U,$J,358.3,166,2)
 ;;=^5003084
 ;;^UTILITY(U,$J,358.3,167,0)
 ;;=F10.921^^3^26^1
 ;;^UTILITY(U,$J,358.3,167,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,167,1,3,0)
 ;;=3^Alcohol Intoxication Delirium w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,167,1,4,0)
 ;;=4^F10.921
 ;;^UTILITY(U,$J,358.3,167,2)
 ;;=^5003102
 ;;^UTILITY(U,$J,358.3,168,0)
 ;;=F05.^^3^26^4
 ;;^UTILITY(U,$J,358.3,168,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,168,1,3,0)
 ;;=3^Delirium d/t Another Medical Condition
 ;;^UTILITY(U,$J,358.3,168,1,4,0)
 ;;=4^F05.
 ;;^UTILITY(U,$J,358.3,168,2)
 ;;=^5003052
 ;;^UTILITY(U,$J,358.3,169,0)
 ;;=F05.^^3^26^5
 ;;^UTILITY(U,$J,358.3,169,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,169,1,3,0)
 ;;=3^Delirium d/t Multiple Etiologies
 ;;^UTILITY(U,$J,358.3,169,1,4,0)
 ;;=4^F05.
 ;;^UTILITY(U,$J,358.3,169,2)
 ;;=^5003052
 ;;^UTILITY(U,$J,358.3,170,0)
 ;;=A81.00^^3^27^9
 ;;^UTILITY(U,$J,358.3,170,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,170,1,3,0)
 ;;=3^Creutzfeldt-Jakob Disease,Unspec
 ;;^UTILITY(U,$J,358.3,170,1,4,0)
 ;;=4^A81.00
 ;;^UTILITY(U,$J,358.3,170,2)
 ;;=^5000409
 ;;^UTILITY(U,$J,358.3,171,0)
 ;;=A81.01^^3^27^38
 ;;^UTILITY(U,$J,358.3,171,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,171,1,3,0)
 ;;=3^Variant Creutzfeldt-Jakob Disease
 ;;^UTILITY(U,$J,358.3,171,1,4,0)
 ;;=4^A81.01
 ;;^UTILITY(U,$J,358.3,171,2)
 ;;=^336701
 ;;^UTILITY(U,$J,358.3,172,0)
 ;;=A81.09^^3^27^8
 ;;^UTILITY(U,$J,358.3,172,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,172,1,3,0)
 ;;=3^Creutzfeldt-Jakob Disease,Other
 ;;^UTILITY(U,$J,358.3,172,1,4,0)
 ;;=4^A81.09
 ;;^UTILITY(U,$J,358.3,172,2)
 ;;=^5000410
 ;;^UTILITY(U,$J,358.3,173,0)
 ;;=A81.2^^3^27^33
 ;;^UTILITY(U,$J,358.3,173,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,173,1,3,0)
 ;;=3^Progressive Multifocal Leukoencephalopathy
 ;;^UTILITY(U,$J,358.3,173,1,4,0)
 ;;=4^A81.2
 ;;^UTILITY(U,$J,358.3,173,2)
 ;;=^5000411
 ;;^UTILITY(U,$J,358.3,174,0)
 ;;=F01.50^^3^27^31
 ;;^UTILITY(U,$J,358.3,174,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,174,1,3,0)
 ;;=3^Probable Major Vascular Neurocognitive Disorder w/o Behavioral Disturbance
 ;;^UTILITY(U,$J,358.3,174,1,4,0)
 ;;=4^F01.50
 ;;^UTILITY(U,$J,358.3,174,2)
 ;;=^5003046
 ;;^UTILITY(U,$J,358.3,175,0)
 ;;=F01.51^^3^27^32
 ;;^UTILITY(U,$J,358.3,175,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,175,1,3,0)
 ;;=3^Probable Major Vascular Neurocognitive Disorder w/ Behavioral Disturbance
 ;;^UTILITY(U,$J,358.3,175,1,4,0)
 ;;=4^F01.51
 ;;^UTILITY(U,$J,358.3,175,2)
 ;;=^5003047
 ;;^UTILITY(U,$J,358.3,176,0)
 ;;=F10.27^^3^27^1
 ;;^UTILITY(U,$J,358.3,176,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,176,1,3,0)
 ;;=3^Alcohol-Induced Major Neurocognitive Disorder,Nonamnestic Confabulatory Type
 ;;^UTILITY(U,$J,358.3,176,1,4,0)
 ;;=4^F10.27
 ;;^UTILITY(U,$J,358.3,176,2)
 ;;=^5003095
 ;;^UTILITY(U,$J,358.3,177,0)
 ;;=F19.97^^3^27^37
