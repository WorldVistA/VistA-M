IBDEI34A ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,52320,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52320,1,3,0)
 ;;=3^Variant Creutzfeldt-Jakob Disease
 ;;^UTILITY(U,$J,358.3,52320,1,4,0)
 ;;=4^A81.01
 ;;^UTILITY(U,$J,358.3,52320,2)
 ;;=^336701
 ;;^UTILITY(U,$J,358.3,52321,0)
 ;;=A81.09^^237^2592^8
 ;;^UTILITY(U,$J,358.3,52321,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52321,1,3,0)
 ;;=3^Creutzfeldt-Jakob Disease,Other
 ;;^UTILITY(U,$J,358.3,52321,1,4,0)
 ;;=4^A81.09
 ;;^UTILITY(U,$J,358.3,52321,2)
 ;;=^5000410
 ;;^UTILITY(U,$J,358.3,52322,0)
 ;;=A81.2^^237^2592^33
 ;;^UTILITY(U,$J,358.3,52322,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52322,1,3,0)
 ;;=3^Progressive Multifocal Leukoencephalopathy
 ;;^UTILITY(U,$J,358.3,52322,1,4,0)
 ;;=4^A81.2
 ;;^UTILITY(U,$J,358.3,52322,2)
 ;;=^5000411
 ;;^UTILITY(U,$J,358.3,52323,0)
 ;;=F01.50^^237^2592^31
 ;;^UTILITY(U,$J,358.3,52323,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52323,1,3,0)
 ;;=3^Probable Major Vascular Neurocognitive Disorder w/o Behavioral Disturbance
 ;;^UTILITY(U,$J,358.3,52323,1,4,0)
 ;;=4^F01.50
 ;;^UTILITY(U,$J,358.3,52323,2)
 ;;=^5003046
 ;;^UTILITY(U,$J,358.3,52324,0)
 ;;=F01.51^^237^2592^32
 ;;^UTILITY(U,$J,358.3,52324,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52324,1,3,0)
 ;;=3^Probable Major Vascular Neurocognitive Disorder w/ Behavioral Disturbance
 ;;^UTILITY(U,$J,358.3,52324,1,4,0)
 ;;=4^F01.51
 ;;^UTILITY(U,$J,358.3,52324,2)
 ;;=^5003047
 ;;^UTILITY(U,$J,358.3,52325,0)
 ;;=F10.27^^237^2592^1
 ;;^UTILITY(U,$J,358.3,52325,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52325,1,3,0)
 ;;=3^Alcohol-Induced Major Neurocognitive Disorder,Nonamnestic Confabulatory Type
 ;;^UTILITY(U,$J,358.3,52325,1,4,0)
 ;;=4^F10.27
 ;;^UTILITY(U,$J,358.3,52325,2)
 ;;=^5003095
 ;;^UTILITY(U,$J,358.3,52326,0)
 ;;=F19.97^^237^2592^37
 ;;^UTILITY(U,$J,358.3,52326,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52326,1,3,0)
 ;;=3^Substance-Induced Major Neurocognitive Disorder NEC
 ;;^UTILITY(U,$J,358.3,52326,1,4,0)
 ;;=4^F19.97
 ;;^UTILITY(U,$J,358.3,52326,2)
 ;;=^5003465
 ;;^UTILITY(U,$J,358.3,52327,0)
 ;;=F02.80^^237^2592^13
 ;;^UTILITY(U,$J,358.3,52327,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52327,1,3,0)
 ;;=3^Dementia in Oth Diseases Classified Elsewhere w/o Behavorial Disturbance
 ;;^UTILITY(U,$J,358.3,52327,1,4,0)
 ;;=4^F02.80
 ;;^UTILITY(U,$J,358.3,52327,2)
 ;;=^5003048
 ;;^UTILITY(U,$J,358.3,52328,0)
 ;;=F02.81^^237^2592^14
 ;;^UTILITY(U,$J,358.3,52328,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52328,1,3,0)
 ;;=3^Dementia in Oth Diseases Classified Elsewhere w/ Behavioral Disturbance
 ;;^UTILITY(U,$J,358.3,52328,1,4,0)
 ;;=4^F02.81
 ;;^UTILITY(U,$J,358.3,52328,2)
 ;;=^5003049
 ;;^UTILITY(U,$J,358.3,52329,0)
 ;;=F06.8^^237^2592^24
 ;;^UTILITY(U,$J,358.3,52329,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52329,1,3,0)
 ;;=3^Mental Disorder d/t Another Medical Condition NEC
 ;;^UTILITY(U,$J,358.3,52329,1,4,0)
 ;;=4^F06.8
 ;;^UTILITY(U,$J,358.3,52329,2)
 ;;=^5003062
 ;;^UTILITY(U,$J,358.3,52330,0)
 ;;=G30.9^^237^2592^5
 ;;^UTILITY(U,$J,358.3,52330,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52330,1,3,0)
 ;;=3^Alzheimer's Disease,Unspec
 ;;^UTILITY(U,$J,358.3,52330,1,4,0)
 ;;=4^G30.9
 ;;^UTILITY(U,$J,358.3,52330,2)
 ;;=^5003808
 ;;^UTILITY(U,$J,358.3,52331,0)
 ;;=G31.9^^237^2592^23
 ;;^UTILITY(U,$J,358.3,52331,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52331,1,3,0)
 ;;=3^Major Neurocognitive Disorder d/t Alzheimer's Disease,Possible
 ;;^UTILITY(U,$J,358.3,52331,1,4,0)
 ;;=4^G31.9
 ;;^UTILITY(U,$J,358.3,52331,2)
 ;;=^5003815
 ;;^UTILITY(U,$J,358.3,52332,0)
 ;;=G31.01^^237^2592^30
