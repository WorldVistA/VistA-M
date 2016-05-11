IBDEI1KG ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,26569,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26569,1,3,0)
 ;;=3^Creutzfeldt-Jakob Disease,Unspec
 ;;^UTILITY(U,$J,358.3,26569,1,4,0)
 ;;=4^A81.00
 ;;^UTILITY(U,$J,358.3,26569,2)
 ;;=^5000409
 ;;^UTILITY(U,$J,358.3,26570,0)
 ;;=A81.01^^100^1269^38
 ;;^UTILITY(U,$J,358.3,26570,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26570,1,3,0)
 ;;=3^Variant Creutzfeldt-Jakob Disease
 ;;^UTILITY(U,$J,358.3,26570,1,4,0)
 ;;=4^A81.01
 ;;^UTILITY(U,$J,358.3,26570,2)
 ;;=^336701
 ;;^UTILITY(U,$J,358.3,26571,0)
 ;;=A81.09^^100^1269^8
 ;;^UTILITY(U,$J,358.3,26571,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26571,1,3,0)
 ;;=3^Creutzfeldt-Jakob Disease,Other
 ;;^UTILITY(U,$J,358.3,26571,1,4,0)
 ;;=4^A81.09
 ;;^UTILITY(U,$J,358.3,26571,2)
 ;;=^5000410
 ;;^UTILITY(U,$J,358.3,26572,0)
 ;;=A81.2^^100^1269^33
 ;;^UTILITY(U,$J,358.3,26572,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26572,1,3,0)
 ;;=3^Progressive Multifocal Leukoencephalopathy
 ;;^UTILITY(U,$J,358.3,26572,1,4,0)
 ;;=4^A81.2
 ;;^UTILITY(U,$J,358.3,26572,2)
 ;;=^5000411
 ;;^UTILITY(U,$J,358.3,26573,0)
 ;;=F01.50^^100^1269^31
 ;;^UTILITY(U,$J,358.3,26573,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26573,1,3,0)
 ;;=3^Probable Major Vascular Neurocognitive Disorder w/o Behavioral Disturbance
 ;;^UTILITY(U,$J,358.3,26573,1,4,0)
 ;;=4^F01.50
 ;;^UTILITY(U,$J,358.3,26573,2)
 ;;=^5003046
 ;;^UTILITY(U,$J,358.3,26574,0)
 ;;=F01.51^^100^1269^32
 ;;^UTILITY(U,$J,358.3,26574,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26574,1,3,0)
 ;;=3^Probable Major Vascular Neurocognitive Disorder w/ Behavioral Disturbance
 ;;^UTILITY(U,$J,358.3,26574,1,4,0)
 ;;=4^F01.51
 ;;^UTILITY(U,$J,358.3,26574,2)
 ;;=^5003047
 ;;^UTILITY(U,$J,358.3,26575,0)
 ;;=F10.27^^100^1269^1
 ;;^UTILITY(U,$J,358.3,26575,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26575,1,3,0)
 ;;=3^Alcohol-Induced Major Neurocognitive Disorder,Nonamnestic Confabulatory Type
 ;;^UTILITY(U,$J,358.3,26575,1,4,0)
 ;;=4^F10.27
 ;;^UTILITY(U,$J,358.3,26575,2)
 ;;=^5003095
 ;;^UTILITY(U,$J,358.3,26576,0)
 ;;=F19.97^^100^1269^37
 ;;^UTILITY(U,$J,358.3,26576,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26576,1,3,0)
 ;;=3^Substance-Induced Major Neurocognitive Disorder NEC
 ;;^UTILITY(U,$J,358.3,26576,1,4,0)
 ;;=4^F19.97
 ;;^UTILITY(U,$J,358.3,26576,2)
 ;;=^5003465
 ;;^UTILITY(U,$J,358.3,26577,0)
 ;;=F02.80^^100^1269^13
 ;;^UTILITY(U,$J,358.3,26577,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26577,1,3,0)
 ;;=3^Dementia in Oth Diseases Classified Elsewhere w/o Behavorial Disturbance
 ;;^UTILITY(U,$J,358.3,26577,1,4,0)
 ;;=4^F02.80
 ;;^UTILITY(U,$J,358.3,26577,2)
 ;;=^5003048
 ;;^UTILITY(U,$J,358.3,26578,0)
 ;;=F02.81^^100^1269^14
 ;;^UTILITY(U,$J,358.3,26578,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26578,1,3,0)
 ;;=3^Dementia in Oth Diseases Classified Elsewhere w/ Behavioral Disturbance
 ;;^UTILITY(U,$J,358.3,26578,1,4,0)
 ;;=4^F02.81
 ;;^UTILITY(U,$J,358.3,26578,2)
 ;;=^5003049
 ;;^UTILITY(U,$J,358.3,26579,0)
 ;;=F06.8^^100^1269^24
 ;;^UTILITY(U,$J,358.3,26579,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26579,1,3,0)
 ;;=3^Mental Disorder d/t Another Medical Condition NEC
 ;;^UTILITY(U,$J,358.3,26579,1,4,0)
 ;;=4^F06.8
 ;;^UTILITY(U,$J,358.3,26579,2)
 ;;=^5003062
 ;;^UTILITY(U,$J,358.3,26580,0)
 ;;=G30.9^^100^1269^5
 ;;^UTILITY(U,$J,358.3,26580,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26580,1,3,0)
 ;;=3^Alzheimer's Disease,Unspec
 ;;^UTILITY(U,$J,358.3,26580,1,4,0)
 ;;=4^G30.9
 ;;^UTILITY(U,$J,358.3,26580,2)
 ;;=^5003808
 ;;^UTILITY(U,$J,358.3,26581,0)
 ;;=G31.9^^100^1269^23
