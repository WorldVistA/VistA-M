IBDEI1XL ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,32331,2)
 ;;=^5003052
 ;;^UTILITY(U,$J,358.3,32332,0)
 ;;=F05.^^143^1520^5
 ;;^UTILITY(U,$J,358.3,32332,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32332,1,3,0)
 ;;=3^Delirium d/t Multiple Etiologies
 ;;^UTILITY(U,$J,358.3,32332,1,4,0)
 ;;=4^F05.
 ;;^UTILITY(U,$J,358.3,32332,2)
 ;;=^5003052
 ;;^UTILITY(U,$J,358.3,32333,0)
 ;;=A81.00^^143^1521^9
 ;;^UTILITY(U,$J,358.3,32333,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32333,1,3,0)
 ;;=3^Creutzfeldt-Jakob Disease,Unspec
 ;;^UTILITY(U,$J,358.3,32333,1,4,0)
 ;;=4^A81.00
 ;;^UTILITY(U,$J,358.3,32333,2)
 ;;=^5000409
 ;;^UTILITY(U,$J,358.3,32334,0)
 ;;=A81.01^^143^1521^38
 ;;^UTILITY(U,$J,358.3,32334,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32334,1,3,0)
 ;;=3^Variant Creutzfeldt-Jakob Disease
 ;;^UTILITY(U,$J,358.3,32334,1,4,0)
 ;;=4^A81.01
 ;;^UTILITY(U,$J,358.3,32334,2)
 ;;=^336701
 ;;^UTILITY(U,$J,358.3,32335,0)
 ;;=A81.09^^143^1521^8
 ;;^UTILITY(U,$J,358.3,32335,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32335,1,3,0)
 ;;=3^Creutzfeldt-Jakob Disease,Other
 ;;^UTILITY(U,$J,358.3,32335,1,4,0)
 ;;=4^A81.09
 ;;^UTILITY(U,$J,358.3,32335,2)
 ;;=^5000410
 ;;^UTILITY(U,$J,358.3,32336,0)
 ;;=A81.2^^143^1521^33
 ;;^UTILITY(U,$J,358.3,32336,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32336,1,3,0)
 ;;=3^Progressive Multifocal Leukoencephalopathy
 ;;^UTILITY(U,$J,358.3,32336,1,4,0)
 ;;=4^A81.2
 ;;^UTILITY(U,$J,358.3,32336,2)
 ;;=^5000411
 ;;^UTILITY(U,$J,358.3,32337,0)
 ;;=F01.50^^143^1521^31
 ;;^UTILITY(U,$J,358.3,32337,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32337,1,3,0)
 ;;=3^Probable Major Vascular Neurocognitive Disorder w/o Behavioral Disturbance
 ;;^UTILITY(U,$J,358.3,32337,1,4,0)
 ;;=4^F01.50
 ;;^UTILITY(U,$J,358.3,32337,2)
 ;;=^5003046
 ;;^UTILITY(U,$J,358.3,32338,0)
 ;;=F01.51^^143^1521^32
 ;;^UTILITY(U,$J,358.3,32338,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32338,1,3,0)
 ;;=3^Probable Major Vascular Neurocognitive Disorder w/ Behavioral Disturbance
 ;;^UTILITY(U,$J,358.3,32338,1,4,0)
 ;;=4^F01.51
 ;;^UTILITY(U,$J,358.3,32338,2)
 ;;=^5003047
 ;;^UTILITY(U,$J,358.3,32339,0)
 ;;=F10.27^^143^1521^1
 ;;^UTILITY(U,$J,358.3,32339,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32339,1,3,0)
 ;;=3^Alcohol-Induced Major Neurocognitive Disorder,Nonamnestic Confabulatory Type
 ;;^UTILITY(U,$J,358.3,32339,1,4,0)
 ;;=4^F10.27
 ;;^UTILITY(U,$J,358.3,32339,2)
 ;;=^5003095
 ;;^UTILITY(U,$J,358.3,32340,0)
 ;;=F19.97^^143^1521^37
 ;;^UTILITY(U,$J,358.3,32340,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32340,1,3,0)
 ;;=3^Substance-Induced Major Neurocognitive Disorder NEC
 ;;^UTILITY(U,$J,358.3,32340,1,4,0)
 ;;=4^F19.97
 ;;^UTILITY(U,$J,358.3,32340,2)
 ;;=^5003465
 ;;^UTILITY(U,$J,358.3,32341,0)
 ;;=F02.80^^143^1521^13
 ;;^UTILITY(U,$J,358.3,32341,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32341,1,3,0)
 ;;=3^Dementia in Oth Diseases Classified Elsewhere w/o Behavorial Disturbance
 ;;^UTILITY(U,$J,358.3,32341,1,4,0)
 ;;=4^F02.80
 ;;^UTILITY(U,$J,358.3,32341,2)
 ;;=^5003048
 ;;^UTILITY(U,$J,358.3,32342,0)
 ;;=F02.81^^143^1521^14
 ;;^UTILITY(U,$J,358.3,32342,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32342,1,3,0)
 ;;=3^Dementia in Oth Diseases Classified Elsewhere w/ Behavioral Disturbance
 ;;^UTILITY(U,$J,358.3,32342,1,4,0)
 ;;=4^F02.81
 ;;^UTILITY(U,$J,358.3,32342,2)
 ;;=^5003049
 ;;^UTILITY(U,$J,358.3,32343,0)
 ;;=F06.8^^143^1521^24
 ;;^UTILITY(U,$J,358.3,32343,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32343,1,3,0)
 ;;=3^Mental Disorder d/t Another Medical Condition NEC
 ;;^UTILITY(U,$J,358.3,32343,1,4,0)
 ;;=4^F06.8
