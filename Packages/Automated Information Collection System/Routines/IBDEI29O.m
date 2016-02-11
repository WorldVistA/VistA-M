IBDEI29O ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,38070,1,4,0)
 ;;=4^F34.0
 ;;^UTILITY(U,$J,358.3,38070,2)
 ;;=^5003538
 ;;^UTILITY(U,$J,358.3,38071,0)
 ;;=F10.232^^177^1917^2
 ;;^UTILITY(U,$J,358.3,38071,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38071,1,3,0)
 ;;=3^Alcohol Withdrawal Delirium w/ Perceptual Disturbances
 ;;^UTILITY(U,$J,358.3,38071,1,4,0)
 ;;=4^F10.232
 ;;^UTILITY(U,$J,358.3,38071,2)
 ;;=^5003088
 ;;^UTILITY(U,$J,358.3,38072,0)
 ;;=F10.231^^177^1917^3
 ;;^UTILITY(U,$J,358.3,38072,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38072,1,3,0)
 ;;=3^Alcohol Withdrawal Delirium w/o Perceptual Disturbances
 ;;^UTILITY(U,$J,358.3,38072,1,4,0)
 ;;=4^F10.231
 ;;^UTILITY(U,$J,358.3,38072,2)
 ;;=^5003087
 ;;^UTILITY(U,$J,358.3,38073,0)
 ;;=F10.121^^177^1917^6
 ;;^UTILITY(U,$J,358.3,38073,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38073,1,3,0)
 ;;=3^Mild Alcohol Use Disorder w/ Intoxication Delirium
 ;;^UTILITY(U,$J,358.3,38073,1,4,0)
 ;;=4^F10.121
 ;;^UTILITY(U,$J,358.3,38073,2)
 ;;=^5003070
 ;;^UTILITY(U,$J,358.3,38074,0)
 ;;=F10.221^^177^1917^7
 ;;^UTILITY(U,$J,358.3,38074,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38074,1,3,0)
 ;;=3^Moderate/Severe Alcohol Use Disorder w/ Intoxication Delirium
 ;;^UTILITY(U,$J,358.3,38074,1,4,0)
 ;;=4^F10.221
 ;;^UTILITY(U,$J,358.3,38074,2)
 ;;=^5003084
 ;;^UTILITY(U,$J,358.3,38075,0)
 ;;=F10.921^^177^1917^1
 ;;^UTILITY(U,$J,358.3,38075,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38075,1,3,0)
 ;;=3^Alcohol Intoxication Delirium w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,38075,1,4,0)
 ;;=4^F10.921
 ;;^UTILITY(U,$J,358.3,38075,2)
 ;;=^5003102
 ;;^UTILITY(U,$J,358.3,38076,0)
 ;;=F05.^^177^1917^4
 ;;^UTILITY(U,$J,358.3,38076,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38076,1,3,0)
 ;;=3^Delirium d/t Another Medical Condition
 ;;^UTILITY(U,$J,358.3,38076,1,4,0)
 ;;=4^F05.
 ;;^UTILITY(U,$J,358.3,38076,2)
 ;;=^5003052
 ;;^UTILITY(U,$J,358.3,38077,0)
 ;;=F05.^^177^1917^5
 ;;^UTILITY(U,$J,358.3,38077,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38077,1,3,0)
 ;;=3^Delirium d/t Multiple Etiologies
 ;;^UTILITY(U,$J,358.3,38077,1,4,0)
 ;;=4^F05.
 ;;^UTILITY(U,$J,358.3,38077,2)
 ;;=^5003052
 ;;^UTILITY(U,$J,358.3,38078,0)
 ;;=A81.00^^177^1918^9
 ;;^UTILITY(U,$J,358.3,38078,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38078,1,3,0)
 ;;=3^Creutzfeldt-Jakob Disease,Unspec
 ;;^UTILITY(U,$J,358.3,38078,1,4,0)
 ;;=4^A81.00
 ;;^UTILITY(U,$J,358.3,38078,2)
 ;;=^5000409
 ;;^UTILITY(U,$J,358.3,38079,0)
 ;;=A81.01^^177^1918^38
 ;;^UTILITY(U,$J,358.3,38079,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38079,1,3,0)
 ;;=3^Variant Creutzfeldt-Jakob Disease
 ;;^UTILITY(U,$J,358.3,38079,1,4,0)
 ;;=4^A81.01
 ;;^UTILITY(U,$J,358.3,38079,2)
 ;;=^336701
 ;;^UTILITY(U,$J,358.3,38080,0)
 ;;=A81.09^^177^1918^8
 ;;^UTILITY(U,$J,358.3,38080,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38080,1,3,0)
 ;;=3^Creutzfeldt-Jakob Disease,Other
 ;;^UTILITY(U,$J,358.3,38080,1,4,0)
 ;;=4^A81.09
 ;;^UTILITY(U,$J,358.3,38080,2)
 ;;=^5000410
 ;;^UTILITY(U,$J,358.3,38081,0)
 ;;=A81.2^^177^1918^33
 ;;^UTILITY(U,$J,358.3,38081,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38081,1,3,0)
 ;;=3^Progressive Multifocal Leukoencephalopathy
 ;;^UTILITY(U,$J,358.3,38081,1,4,0)
 ;;=4^A81.2
 ;;^UTILITY(U,$J,358.3,38081,2)
 ;;=^5000411
 ;;^UTILITY(U,$J,358.3,38082,0)
 ;;=F01.50^^177^1918^31
 ;;^UTILITY(U,$J,358.3,38082,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38082,1,3,0)
 ;;=3^Probable Major Vascular Neurocognitive Disorder w/o Behavioral Disturbance
 ;;^UTILITY(U,$J,358.3,38082,1,4,0)
 ;;=4^F01.50
 ;;^UTILITY(U,$J,358.3,38082,2)
 ;;=^5003046
