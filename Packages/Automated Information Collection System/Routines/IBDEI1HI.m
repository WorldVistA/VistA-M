IBDEI1HI ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,25197,0)
 ;;=A81.09^^95^1143^8
 ;;^UTILITY(U,$J,358.3,25197,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25197,1,3,0)
 ;;=3^Creutzfeldt-Jakob Disease,Other
 ;;^UTILITY(U,$J,358.3,25197,1,4,0)
 ;;=4^A81.09
 ;;^UTILITY(U,$J,358.3,25197,2)
 ;;=^5000410
 ;;^UTILITY(U,$J,358.3,25198,0)
 ;;=A81.2^^95^1143^33
 ;;^UTILITY(U,$J,358.3,25198,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25198,1,3,0)
 ;;=3^Progressive Multifocal Leukoencephalopathy
 ;;^UTILITY(U,$J,358.3,25198,1,4,0)
 ;;=4^A81.2
 ;;^UTILITY(U,$J,358.3,25198,2)
 ;;=^5000411
 ;;^UTILITY(U,$J,358.3,25199,0)
 ;;=F01.50^^95^1143^31
 ;;^UTILITY(U,$J,358.3,25199,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25199,1,3,0)
 ;;=3^Probable Major Vascular Neurocognitive Disorder w/o Behavioral Disturbance
 ;;^UTILITY(U,$J,358.3,25199,1,4,0)
 ;;=4^F01.50
 ;;^UTILITY(U,$J,358.3,25199,2)
 ;;=^5003046
 ;;^UTILITY(U,$J,358.3,25200,0)
 ;;=F01.51^^95^1143^32
 ;;^UTILITY(U,$J,358.3,25200,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25200,1,3,0)
 ;;=3^Probable Major Vascular Neurocognitive Disorder w/ Behavioral Disturbance
 ;;^UTILITY(U,$J,358.3,25200,1,4,0)
 ;;=4^F01.51
 ;;^UTILITY(U,$J,358.3,25200,2)
 ;;=^5003047
 ;;^UTILITY(U,$J,358.3,25201,0)
 ;;=F10.27^^95^1143^1
 ;;^UTILITY(U,$J,358.3,25201,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25201,1,3,0)
 ;;=3^Alcohol-Induced Major Neurocognitive Disorder,Nonamnestic Confabulatory Type
 ;;^UTILITY(U,$J,358.3,25201,1,4,0)
 ;;=4^F10.27
 ;;^UTILITY(U,$J,358.3,25201,2)
 ;;=^5003095
 ;;^UTILITY(U,$J,358.3,25202,0)
 ;;=F19.97^^95^1143^37
 ;;^UTILITY(U,$J,358.3,25202,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25202,1,3,0)
 ;;=3^Substance-Induced Major Neurocognitive Disorder NEC
 ;;^UTILITY(U,$J,358.3,25202,1,4,0)
 ;;=4^F19.97
 ;;^UTILITY(U,$J,358.3,25202,2)
 ;;=^5003465
 ;;^UTILITY(U,$J,358.3,25203,0)
 ;;=F02.80^^95^1143^13
 ;;^UTILITY(U,$J,358.3,25203,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25203,1,3,0)
 ;;=3^Dementia in Oth Diseases Classified Elsewhere w/o Behavorial Disturbance
 ;;^UTILITY(U,$J,358.3,25203,1,4,0)
 ;;=4^F02.80
 ;;^UTILITY(U,$J,358.3,25203,2)
 ;;=^5003048
 ;;^UTILITY(U,$J,358.3,25204,0)
 ;;=F02.81^^95^1143^14
 ;;^UTILITY(U,$J,358.3,25204,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25204,1,3,0)
 ;;=3^Dementia in Oth Diseases Classified Elsewhere w/ Behavioral Disturbance
 ;;^UTILITY(U,$J,358.3,25204,1,4,0)
 ;;=4^F02.81
 ;;^UTILITY(U,$J,358.3,25204,2)
 ;;=^5003049
 ;;^UTILITY(U,$J,358.3,25205,0)
 ;;=F06.8^^95^1143^24
 ;;^UTILITY(U,$J,358.3,25205,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25205,1,3,0)
 ;;=3^Mental Disorder d/t Another Medical Condition NEC
 ;;^UTILITY(U,$J,358.3,25205,1,4,0)
 ;;=4^F06.8
 ;;^UTILITY(U,$J,358.3,25205,2)
 ;;=^5003062
 ;;^UTILITY(U,$J,358.3,25206,0)
 ;;=G30.9^^95^1143^5
 ;;^UTILITY(U,$J,358.3,25206,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25206,1,3,0)
 ;;=3^Alzheimer's Disease,Unspec
 ;;^UTILITY(U,$J,358.3,25206,1,4,0)
 ;;=4^G30.9
 ;;^UTILITY(U,$J,358.3,25206,2)
 ;;=^5003808
 ;;^UTILITY(U,$J,358.3,25207,0)
 ;;=G31.9^^95^1143^23
 ;;^UTILITY(U,$J,358.3,25207,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25207,1,3,0)
 ;;=3^Major Neurocognitive Disorder d/t Alzheimer's Disease,Possible
 ;;^UTILITY(U,$J,358.3,25207,1,4,0)
 ;;=4^G31.9
 ;;^UTILITY(U,$J,358.3,25207,2)
 ;;=^5003815
 ;;^UTILITY(U,$J,358.3,25208,0)
 ;;=G31.01^^95^1143^30
 ;;^UTILITY(U,$J,358.3,25208,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25208,1,3,0)
 ;;=3^Pick's Disease
 ;;^UTILITY(U,$J,358.3,25208,1,4,0)
 ;;=4^G31.01
 ;;^UTILITY(U,$J,358.3,25208,2)
 ;;=^329915
