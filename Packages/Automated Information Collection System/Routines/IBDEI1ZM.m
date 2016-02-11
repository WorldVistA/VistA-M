IBDEI1ZM ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,33282,0)
 ;;=A81.00^^148^1635^9
 ;;^UTILITY(U,$J,358.3,33282,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33282,1,3,0)
 ;;=3^Creutzfeldt-Jakob Disease,Unspec
 ;;^UTILITY(U,$J,358.3,33282,1,4,0)
 ;;=4^A81.00
 ;;^UTILITY(U,$J,358.3,33282,2)
 ;;=^5000409
 ;;^UTILITY(U,$J,358.3,33283,0)
 ;;=A81.01^^148^1635^38
 ;;^UTILITY(U,$J,358.3,33283,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33283,1,3,0)
 ;;=3^Variant Creutzfeldt-Jakob Disease
 ;;^UTILITY(U,$J,358.3,33283,1,4,0)
 ;;=4^A81.01
 ;;^UTILITY(U,$J,358.3,33283,2)
 ;;=^336701
 ;;^UTILITY(U,$J,358.3,33284,0)
 ;;=A81.09^^148^1635^8
 ;;^UTILITY(U,$J,358.3,33284,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33284,1,3,0)
 ;;=3^Creutzfeldt-Jakob Disease,Other
 ;;^UTILITY(U,$J,358.3,33284,1,4,0)
 ;;=4^A81.09
 ;;^UTILITY(U,$J,358.3,33284,2)
 ;;=^5000410
 ;;^UTILITY(U,$J,358.3,33285,0)
 ;;=A81.2^^148^1635^33
 ;;^UTILITY(U,$J,358.3,33285,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33285,1,3,0)
 ;;=3^Progressive Multifocal Leukoencephalopathy
 ;;^UTILITY(U,$J,358.3,33285,1,4,0)
 ;;=4^A81.2
 ;;^UTILITY(U,$J,358.3,33285,2)
 ;;=^5000411
 ;;^UTILITY(U,$J,358.3,33286,0)
 ;;=F01.50^^148^1635^31
 ;;^UTILITY(U,$J,358.3,33286,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33286,1,3,0)
 ;;=3^Probable Major Vascular Neurocognitive Disorder w/o Behavioral Disturbance
 ;;^UTILITY(U,$J,358.3,33286,1,4,0)
 ;;=4^F01.50
 ;;^UTILITY(U,$J,358.3,33286,2)
 ;;=^5003046
 ;;^UTILITY(U,$J,358.3,33287,0)
 ;;=F01.51^^148^1635^32
 ;;^UTILITY(U,$J,358.3,33287,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33287,1,3,0)
 ;;=3^Probable Major Vascular Neurocognitive Disorder w/ Behavioral Disturbance
 ;;^UTILITY(U,$J,358.3,33287,1,4,0)
 ;;=4^F01.51
 ;;^UTILITY(U,$J,358.3,33287,2)
 ;;=^5003047
 ;;^UTILITY(U,$J,358.3,33288,0)
 ;;=F10.27^^148^1635^1
 ;;^UTILITY(U,$J,358.3,33288,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33288,1,3,0)
 ;;=3^Alcohol-Induced Major Neurocognitive Disorder,Nonamnestic Confabulatory Type
 ;;^UTILITY(U,$J,358.3,33288,1,4,0)
 ;;=4^F10.27
 ;;^UTILITY(U,$J,358.3,33288,2)
 ;;=^5003095
 ;;^UTILITY(U,$J,358.3,33289,0)
 ;;=F19.97^^148^1635^37
 ;;^UTILITY(U,$J,358.3,33289,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33289,1,3,0)
 ;;=3^Substance-Induced Major Neurocognitive Disorder NEC
 ;;^UTILITY(U,$J,358.3,33289,1,4,0)
 ;;=4^F19.97
 ;;^UTILITY(U,$J,358.3,33289,2)
 ;;=^5003465
 ;;^UTILITY(U,$J,358.3,33290,0)
 ;;=F02.80^^148^1635^13
 ;;^UTILITY(U,$J,358.3,33290,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33290,1,3,0)
 ;;=3^Dementia in Oth Diseases Classified Elsewhere w/o Behavorial Disturbance
 ;;^UTILITY(U,$J,358.3,33290,1,4,0)
 ;;=4^F02.80
 ;;^UTILITY(U,$J,358.3,33290,2)
 ;;=^5003048
 ;;^UTILITY(U,$J,358.3,33291,0)
 ;;=F02.81^^148^1635^14
 ;;^UTILITY(U,$J,358.3,33291,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33291,1,3,0)
 ;;=3^Dementia in Oth Diseases Classified Elsewhere w/ Behavioral Disturbance
 ;;^UTILITY(U,$J,358.3,33291,1,4,0)
 ;;=4^F02.81
 ;;^UTILITY(U,$J,358.3,33291,2)
 ;;=^5003049
 ;;^UTILITY(U,$J,358.3,33292,0)
 ;;=F06.8^^148^1635^24
 ;;^UTILITY(U,$J,358.3,33292,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33292,1,3,0)
 ;;=3^Mental Disorder d/t Another Medical Condition NEC
 ;;^UTILITY(U,$J,358.3,33292,1,4,0)
 ;;=4^F06.8
 ;;^UTILITY(U,$J,358.3,33292,2)
 ;;=^5003062
 ;;^UTILITY(U,$J,358.3,33293,0)
 ;;=G30.9^^148^1635^5
 ;;^UTILITY(U,$J,358.3,33293,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33293,1,3,0)
 ;;=3^Alzheimer's Disease,Unspec
 ;;^UTILITY(U,$J,358.3,33293,1,4,0)
 ;;=4^G30.9
 ;;^UTILITY(U,$J,358.3,33293,2)
 ;;=^5003808
