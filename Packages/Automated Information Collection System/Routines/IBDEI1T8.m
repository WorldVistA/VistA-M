IBDEI1T8 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,30753,1,4,0)
 ;;=4^F10.231
 ;;^UTILITY(U,$J,358.3,30753,2)
 ;;=^5003087
 ;;^UTILITY(U,$J,358.3,30754,0)
 ;;=F10.121^^123^1532^6
 ;;^UTILITY(U,$J,358.3,30754,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30754,1,3,0)
 ;;=3^Mild Alcohol Use Disorder w/ Intoxication Delirium
 ;;^UTILITY(U,$J,358.3,30754,1,4,0)
 ;;=4^F10.121
 ;;^UTILITY(U,$J,358.3,30754,2)
 ;;=^5003070
 ;;^UTILITY(U,$J,358.3,30755,0)
 ;;=F10.221^^123^1532^7
 ;;^UTILITY(U,$J,358.3,30755,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30755,1,3,0)
 ;;=3^Moderate/Severe Alcohol Use Disorder w/ Intoxication Delirium
 ;;^UTILITY(U,$J,358.3,30755,1,4,0)
 ;;=4^F10.221
 ;;^UTILITY(U,$J,358.3,30755,2)
 ;;=^5003084
 ;;^UTILITY(U,$J,358.3,30756,0)
 ;;=F10.921^^123^1532^1
 ;;^UTILITY(U,$J,358.3,30756,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30756,1,3,0)
 ;;=3^Alcohol Intoxication Delirium w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,30756,1,4,0)
 ;;=4^F10.921
 ;;^UTILITY(U,$J,358.3,30756,2)
 ;;=^5003102
 ;;^UTILITY(U,$J,358.3,30757,0)
 ;;=F05.^^123^1532^4
 ;;^UTILITY(U,$J,358.3,30757,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30757,1,3,0)
 ;;=3^Delirium d/t Another Medical Condition
 ;;^UTILITY(U,$J,358.3,30757,1,4,0)
 ;;=4^F05.
 ;;^UTILITY(U,$J,358.3,30757,2)
 ;;=^5003052
 ;;^UTILITY(U,$J,358.3,30758,0)
 ;;=F05.^^123^1532^5
 ;;^UTILITY(U,$J,358.3,30758,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30758,1,3,0)
 ;;=3^Delirium d/t Multiple Etiologies
 ;;^UTILITY(U,$J,358.3,30758,1,4,0)
 ;;=4^F05.
 ;;^UTILITY(U,$J,358.3,30758,2)
 ;;=^5003052
 ;;^UTILITY(U,$J,358.3,30759,0)
 ;;=A81.00^^123^1533^9
 ;;^UTILITY(U,$J,358.3,30759,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30759,1,3,0)
 ;;=3^Creutzfeldt-Jakob Disease,Unspec
 ;;^UTILITY(U,$J,358.3,30759,1,4,0)
 ;;=4^A81.00
 ;;^UTILITY(U,$J,358.3,30759,2)
 ;;=^5000409
 ;;^UTILITY(U,$J,358.3,30760,0)
 ;;=A81.01^^123^1533^38
 ;;^UTILITY(U,$J,358.3,30760,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30760,1,3,0)
 ;;=3^Variant Creutzfeldt-Jakob Disease
 ;;^UTILITY(U,$J,358.3,30760,1,4,0)
 ;;=4^A81.01
 ;;^UTILITY(U,$J,358.3,30760,2)
 ;;=^336701
 ;;^UTILITY(U,$J,358.3,30761,0)
 ;;=A81.09^^123^1533^8
 ;;^UTILITY(U,$J,358.3,30761,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30761,1,3,0)
 ;;=3^Creutzfeldt-Jakob Disease,Other
 ;;^UTILITY(U,$J,358.3,30761,1,4,0)
 ;;=4^A81.09
 ;;^UTILITY(U,$J,358.3,30761,2)
 ;;=^5000410
 ;;^UTILITY(U,$J,358.3,30762,0)
 ;;=A81.2^^123^1533^33
 ;;^UTILITY(U,$J,358.3,30762,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30762,1,3,0)
 ;;=3^Progressive Multifocal Leukoencephalopathy
 ;;^UTILITY(U,$J,358.3,30762,1,4,0)
 ;;=4^A81.2
 ;;^UTILITY(U,$J,358.3,30762,2)
 ;;=^5000411
 ;;^UTILITY(U,$J,358.3,30763,0)
 ;;=F01.50^^123^1533^31
 ;;^UTILITY(U,$J,358.3,30763,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30763,1,3,0)
 ;;=3^Probable Major Vascular Neurocognitive Disorder w/o Behavioral Disturbance
 ;;^UTILITY(U,$J,358.3,30763,1,4,0)
 ;;=4^F01.50
 ;;^UTILITY(U,$J,358.3,30763,2)
 ;;=^5003046
 ;;^UTILITY(U,$J,358.3,30764,0)
 ;;=F01.51^^123^1533^32
 ;;^UTILITY(U,$J,358.3,30764,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30764,1,3,0)
 ;;=3^Probable Major Vascular Neurocognitive Disorder w/ Behavioral Disturbance
 ;;^UTILITY(U,$J,358.3,30764,1,4,0)
 ;;=4^F01.51
 ;;^UTILITY(U,$J,358.3,30764,2)
 ;;=^5003047
 ;;^UTILITY(U,$J,358.3,30765,0)
 ;;=F10.27^^123^1533^1
 ;;^UTILITY(U,$J,358.3,30765,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30765,1,3,0)
 ;;=3^Alcohol-Induced Major Neurocognitive Disorder,Nonamnestic Confabulatory Type
 ;;^UTILITY(U,$J,358.3,30765,1,4,0)
 ;;=4^F10.27
