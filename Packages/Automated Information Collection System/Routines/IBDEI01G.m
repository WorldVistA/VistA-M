IBDEI01G ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,178,1,4,0)
 ;;=4^F10.232
 ;;^UTILITY(U,$J,358.3,178,2)
 ;;=^5003088
 ;;^UTILITY(U,$J,358.3,179,0)
 ;;=F10.231^^3^26^3
 ;;^UTILITY(U,$J,358.3,179,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,179,1,3,0)
 ;;=3^Alcohol Withdrawal Delirium w/o Perceptual Disturbances
 ;;^UTILITY(U,$J,358.3,179,1,4,0)
 ;;=4^F10.231
 ;;^UTILITY(U,$J,358.3,179,2)
 ;;=^5003087
 ;;^UTILITY(U,$J,358.3,180,0)
 ;;=F10.121^^3^26^6
 ;;^UTILITY(U,$J,358.3,180,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,180,1,3,0)
 ;;=3^Mild Alcohol Use Disorder w/ Intoxication Delirium
 ;;^UTILITY(U,$J,358.3,180,1,4,0)
 ;;=4^F10.121
 ;;^UTILITY(U,$J,358.3,180,2)
 ;;=^5003070
 ;;^UTILITY(U,$J,358.3,181,0)
 ;;=F10.221^^3^26^7
 ;;^UTILITY(U,$J,358.3,181,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,181,1,3,0)
 ;;=3^Moderate/Severe Alcohol Use Disorder w/ Intoxication Delirium
 ;;^UTILITY(U,$J,358.3,181,1,4,0)
 ;;=4^F10.221
 ;;^UTILITY(U,$J,358.3,181,2)
 ;;=^5003084
 ;;^UTILITY(U,$J,358.3,182,0)
 ;;=F10.921^^3^26^1
 ;;^UTILITY(U,$J,358.3,182,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,182,1,3,0)
 ;;=3^Alcohol Intoxication Delirium w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,182,1,4,0)
 ;;=4^F10.921
 ;;^UTILITY(U,$J,358.3,182,2)
 ;;=^5003102
 ;;^UTILITY(U,$J,358.3,183,0)
 ;;=F05.^^3^26^4
 ;;^UTILITY(U,$J,358.3,183,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,183,1,3,0)
 ;;=3^Delirium d/t Another Medical Condition
 ;;^UTILITY(U,$J,358.3,183,1,4,0)
 ;;=4^F05.
 ;;^UTILITY(U,$J,358.3,183,2)
 ;;=^5003052
 ;;^UTILITY(U,$J,358.3,184,0)
 ;;=F05.^^3^26^5
 ;;^UTILITY(U,$J,358.3,184,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,184,1,3,0)
 ;;=3^Delirium d/t Multiple Etiologies
 ;;^UTILITY(U,$J,358.3,184,1,4,0)
 ;;=4^F05.
 ;;^UTILITY(U,$J,358.3,184,2)
 ;;=^5003052
 ;;^UTILITY(U,$J,358.3,185,0)
 ;;=A81.00^^3^27^9
 ;;^UTILITY(U,$J,358.3,185,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,185,1,3,0)
 ;;=3^Creutzfeldt-Jakob Disease,Unspec
 ;;^UTILITY(U,$J,358.3,185,1,4,0)
 ;;=4^A81.00
 ;;^UTILITY(U,$J,358.3,185,2)
 ;;=^5000409
 ;;^UTILITY(U,$J,358.3,186,0)
 ;;=A81.01^^3^27^38
 ;;^UTILITY(U,$J,358.3,186,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,186,1,3,0)
 ;;=3^Variant Creutzfeldt-Jakob Disease
 ;;^UTILITY(U,$J,358.3,186,1,4,0)
 ;;=4^A81.01
 ;;^UTILITY(U,$J,358.3,186,2)
 ;;=^336701
 ;;^UTILITY(U,$J,358.3,187,0)
 ;;=A81.09^^3^27^8
 ;;^UTILITY(U,$J,358.3,187,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,187,1,3,0)
 ;;=3^Creutzfeldt-Jakob Disease,Other
 ;;^UTILITY(U,$J,358.3,187,1,4,0)
 ;;=4^A81.09
 ;;^UTILITY(U,$J,358.3,187,2)
 ;;=^5000410
 ;;^UTILITY(U,$J,358.3,188,0)
 ;;=A81.2^^3^27^33
 ;;^UTILITY(U,$J,358.3,188,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,188,1,3,0)
 ;;=3^Progressive Multifocal Leukoencephalopathy
 ;;^UTILITY(U,$J,358.3,188,1,4,0)
 ;;=4^A81.2
 ;;^UTILITY(U,$J,358.3,188,2)
 ;;=^5000411
 ;;^UTILITY(U,$J,358.3,189,0)
 ;;=F01.50^^3^27^31
 ;;^UTILITY(U,$J,358.3,189,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,189,1,3,0)
 ;;=3^Probable Major Vascular Neurocognitive Disorder w/o Behavioral Disturbance
 ;;^UTILITY(U,$J,358.3,189,1,4,0)
 ;;=4^F01.50
 ;;^UTILITY(U,$J,358.3,189,2)
 ;;=^5003046
 ;;^UTILITY(U,$J,358.3,190,0)
 ;;=F01.51^^3^27^32
 ;;^UTILITY(U,$J,358.3,190,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,190,1,3,0)
 ;;=3^Probable Major Vascular Neurocognitive Disorder w/ Behavioral Disturbance
 ;;^UTILITY(U,$J,358.3,190,1,4,0)
 ;;=4^F01.51
 ;;^UTILITY(U,$J,358.3,190,2)
 ;;=^5003047
 ;;^UTILITY(U,$J,358.3,191,0)
 ;;=F10.27^^3^27^1
 ;;^UTILITY(U,$J,358.3,191,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,191,1,3,0)
 ;;=3^Alcohol-Induced Major Neurocognitive Disorder,Nonamnestic Confabulatory Type
