IBDEI28P ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,38001,0)
 ;;=A81.09^^145^1832^8
 ;;^UTILITY(U,$J,358.3,38001,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38001,1,3,0)
 ;;=3^Creutzfeldt-Jakob Disease,Other
 ;;^UTILITY(U,$J,358.3,38001,1,4,0)
 ;;=4^A81.09
 ;;^UTILITY(U,$J,358.3,38001,2)
 ;;=^5000410
 ;;^UTILITY(U,$J,358.3,38002,0)
 ;;=A81.2^^145^1832^33
 ;;^UTILITY(U,$J,358.3,38002,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38002,1,3,0)
 ;;=3^Progressive Multifocal Leukoencephalopathy
 ;;^UTILITY(U,$J,358.3,38002,1,4,0)
 ;;=4^A81.2
 ;;^UTILITY(U,$J,358.3,38002,2)
 ;;=^5000411
 ;;^UTILITY(U,$J,358.3,38003,0)
 ;;=F01.50^^145^1832^31
 ;;^UTILITY(U,$J,358.3,38003,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38003,1,3,0)
 ;;=3^Probable Major Vascular Neurocognitive Disorder w/o Behavioral Disturbance
 ;;^UTILITY(U,$J,358.3,38003,1,4,0)
 ;;=4^F01.50
 ;;^UTILITY(U,$J,358.3,38003,2)
 ;;=^5003046
 ;;^UTILITY(U,$J,358.3,38004,0)
 ;;=F01.51^^145^1832^32
 ;;^UTILITY(U,$J,358.3,38004,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38004,1,3,0)
 ;;=3^Probable Major Vascular Neurocognitive Disorder w/ Behavioral Disturbance
 ;;^UTILITY(U,$J,358.3,38004,1,4,0)
 ;;=4^F01.51
 ;;^UTILITY(U,$J,358.3,38004,2)
 ;;=^5003047
 ;;^UTILITY(U,$J,358.3,38005,0)
 ;;=F10.27^^145^1832^1
 ;;^UTILITY(U,$J,358.3,38005,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38005,1,3,0)
 ;;=3^Alcohol-Induced Major Neurocognitive Disorder,Nonamnestic Confabulatory Type
 ;;^UTILITY(U,$J,358.3,38005,1,4,0)
 ;;=4^F10.27
 ;;^UTILITY(U,$J,358.3,38005,2)
 ;;=^5003095
 ;;^UTILITY(U,$J,358.3,38006,0)
 ;;=F19.97^^145^1832^37
 ;;^UTILITY(U,$J,358.3,38006,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38006,1,3,0)
 ;;=3^Substance-Induced Major Neurocognitive Disorder NEC
 ;;^UTILITY(U,$J,358.3,38006,1,4,0)
 ;;=4^F19.97
 ;;^UTILITY(U,$J,358.3,38006,2)
 ;;=^5003465
 ;;^UTILITY(U,$J,358.3,38007,0)
 ;;=F02.80^^145^1832^13
 ;;^UTILITY(U,$J,358.3,38007,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38007,1,3,0)
 ;;=3^Dementia in Oth Diseases Classified Elsewhere w/o Behavorial Disturbance
 ;;^UTILITY(U,$J,358.3,38007,1,4,0)
 ;;=4^F02.80
 ;;^UTILITY(U,$J,358.3,38007,2)
 ;;=^5003048
 ;;^UTILITY(U,$J,358.3,38008,0)
 ;;=F02.81^^145^1832^14
 ;;^UTILITY(U,$J,358.3,38008,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38008,1,3,0)
 ;;=3^Dementia in Oth Diseases Classified Elsewhere w/ Behavioral Disturbance
 ;;^UTILITY(U,$J,358.3,38008,1,4,0)
 ;;=4^F02.81
 ;;^UTILITY(U,$J,358.3,38008,2)
 ;;=^5003049
 ;;^UTILITY(U,$J,358.3,38009,0)
 ;;=F06.8^^145^1832^24
 ;;^UTILITY(U,$J,358.3,38009,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38009,1,3,0)
 ;;=3^Mental Disorder d/t Another Medical Condition NEC
 ;;^UTILITY(U,$J,358.3,38009,1,4,0)
 ;;=4^F06.8
 ;;^UTILITY(U,$J,358.3,38009,2)
 ;;=^5003062
 ;;^UTILITY(U,$J,358.3,38010,0)
 ;;=G30.9^^145^1832^5
 ;;^UTILITY(U,$J,358.3,38010,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38010,1,3,0)
 ;;=3^Alzheimer's Disease,Unspec
 ;;^UTILITY(U,$J,358.3,38010,1,4,0)
 ;;=4^G30.9
 ;;^UTILITY(U,$J,358.3,38010,2)
 ;;=^5003808
 ;;^UTILITY(U,$J,358.3,38011,0)
 ;;=G31.9^^145^1832^23
 ;;^UTILITY(U,$J,358.3,38011,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38011,1,3,0)
 ;;=3^Major Neurocognitive Disorder d/t Alzheimer's Disease,Possible
 ;;^UTILITY(U,$J,358.3,38011,1,4,0)
 ;;=4^G31.9
 ;;^UTILITY(U,$J,358.3,38011,2)
 ;;=^5003815
 ;;^UTILITY(U,$J,358.3,38012,0)
 ;;=G31.01^^145^1832^30
 ;;^UTILITY(U,$J,358.3,38012,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38012,1,3,0)
 ;;=3^Pick's Disease
 ;;^UTILITY(U,$J,358.3,38012,1,4,0)
 ;;=4^G31.01
 ;;^UTILITY(U,$J,358.3,38012,2)
 ;;=^329915
