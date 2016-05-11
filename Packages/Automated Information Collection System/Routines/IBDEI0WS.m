IBDEI0WS ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,15384,0)
 ;;=F05.^^58^661^4
 ;;^UTILITY(U,$J,358.3,15384,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15384,1,3,0)
 ;;=3^Delirium d/t Another Medical Condition
 ;;^UTILITY(U,$J,358.3,15384,1,4,0)
 ;;=4^F05.
 ;;^UTILITY(U,$J,358.3,15384,2)
 ;;=^5003052
 ;;^UTILITY(U,$J,358.3,15385,0)
 ;;=F05.^^58^661^5
 ;;^UTILITY(U,$J,358.3,15385,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15385,1,3,0)
 ;;=3^Delirium d/t Multiple Etiologies
 ;;^UTILITY(U,$J,358.3,15385,1,4,0)
 ;;=4^F05.
 ;;^UTILITY(U,$J,358.3,15385,2)
 ;;=^5003052
 ;;^UTILITY(U,$J,358.3,15386,0)
 ;;=A81.00^^58^662^9
 ;;^UTILITY(U,$J,358.3,15386,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15386,1,3,0)
 ;;=3^Creutzfeldt-Jakob Disease,Unspec
 ;;^UTILITY(U,$J,358.3,15386,1,4,0)
 ;;=4^A81.00
 ;;^UTILITY(U,$J,358.3,15386,2)
 ;;=^5000409
 ;;^UTILITY(U,$J,358.3,15387,0)
 ;;=A81.01^^58^662^38
 ;;^UTILITY(U,$J,358.3,15387,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15387,1,3,0)
 ;;=3^Variant Creutzfeldt-Jakob Disease
 ;;^UTILITY(U,$J,358.3,15387,1,4,0)
 ;;=4^A81.01
 ;;^UTILITY(U,$J,358.3,15387,2)
 ;;=^336701
 ;;^UTILITY(U,$J,358.3,15388,0)
 ;;=A81.09^^58^662^8
 ;;^UTILITY(U,$J,358.3,15388,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15388,1,3,0)
 ;;=3^Creutzfeldt-Jakob Disease,Other
 ;;^UTILITY(U,$J,358.3,15388,1,4,0)
 ;;=4^A81.09
 ;;^UTILITY(U,$J,358.3,15388,2)
 ;;=^5000410
 ;;^UTILITY(U,$J,358.3,15389,0)
 ;;=A81.2^^58^662^33
 ;;^UTILITY(U,$J,358.3,15389,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15389,1,3,0)
 ;;=3^Progressive Multifocal Leukoencephalopathy
 ;;^UTILITY(U,$J,358.3,15389,1,4,0)
 ;;=4^A81.2
 ;;^UTILITY(U,$J,358.3,15389,2)
 ;;=^5000411
 ;;^UTILITY(U,$J,358.3,15390,0)
 ;;=F01.50^^58^662^31
 ;;^UTILITY(U,$J,358.3,15390,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15390,1,3,0)
 ;;=3^Probable Major Vascular Neurocognitive Disorder w/o Behavioral Disturbance
 ;;^UTILITY(U,$J,358.3,15390,1,4,0)
 ;;=4^F01.50
 ;;^UTILITY(U,$J,358.3,15390,2)
 ;;=^5003046
 ;;^UTILITY(U,$J,358.3,15391,0)
 ;;=F01.51^^58^662^32
 ;;^UTILITY(U,$J,358.3,15391,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15391,1,3,0)
 ;;=3^Probable Major Vascular Neurocognitive Disorder w/ Behavioral Disturbance
 ;;^UTILITY(U,$J,358.3,15391,1,4,0)
 ;;=4^F01.51
 ;;^UTILITY(U,$J,358.3,15391,2)
 ;;=^5003047
 ;;^UTILITY(U,$J,358.3,15392,0)
 ;;=F10.27^^58^662^1
 ;;^UTILITY(U,$J,358.3,15392,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15392,1,3,0)
 ;;=3^Alcohol-Induced Major Neurocognitive Disorder,Nonamnestic Confabulatory Type
 ;;^UTILITY(U,$J,358.3,15392,1,4,0)
 ;;=4^F10.27
 ;;^UTILITY(U,$J,358.3,15392,2)
 ;;=^5003095
 ;;^UTILITY(U,$J,358.3,15393,0)
 ;;=F19.97^^58^662^37
 ;;^UTILITY(U,$J,358.3,15393,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15393,1,3,0)
 ;;=3^Substance-Induced Major Neurocognitive Disorder NEC
 ;;^UTILITY(U,$J,358.3,15393,1,4,0)
 ;;=4^F19.97
 ;;^UTILITY(U,$J,358.3,15393,2)
 ;;=^5003465
 ;;^UTILITY(U,$J,358.3,15394,0)
 ;;=F02.80^^58^662^13
 ;;^UTILITY(U,$J,358.3,15394,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15394,1,3,0)
 ;;=3^Dementia in Oth Diseases Classified Elsewhere w/o Behavorial Disturbance
 ;;^UTILITY(U,$J,358.3,15394,1,4,0)
 ;;=4^F02.80
 ;;^UTILITY(U,$J,358.3,15394,2)
 ;;=^5003048
 ;;^UTILITY(U,$J,358.3,15395,0)
 ;;=F02.81^^58^662^14
 ;;^UTILITY(U,$J,358.3,15395,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15395,1,3,0)
 ;;=3^Dementia in Oth Diseases Classified Elsewhere w/ Behavioral Disturbance
 ;;^UTILITY(U,$J,358.3,15395,1,4,0)
 ;;=4^F02.81
 ;;^UTILITY(U,$J,358.3,15395,2)
 ;;=^5003049
 ;;^UTILITY(U,$J,358.3,15396,0)
 ;;=F06.8^^58^662^24
