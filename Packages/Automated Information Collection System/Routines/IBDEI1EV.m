IBDEI1EV ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,23991,1,4,0)
 ;;=4^A81.09
 ;;^UTILITY(U,$J,358.3,23991,2)
 ;;=^5000410
 ;;^UTILITY(U,$J,358.3,23992,0)
 ;;=A81.2^^90^1039^33
 ;;^UTILITY(U,$J,358.3,23992,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23992,1,3,0)
 ;;=3^Progressive Multifocal Leukoencephalopathy
 ;;^UTILITY(U,$J,358.3,23992,1,4,0)
 ;;=4^A81.2
 ;;^UTILITY(U,$J,358.3,23992,2)
 ;;=^5000411
 ;;^UTILITY(U,$J,358.3,23993,0)
 ;;=F01.50^^90^1039^31
 ;;^UTILITY(U,$J,358.3,23993,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23993,1,3,0)
 ;;=3^Probable Major Vascular Neurocognitive Disorder w/o Behavioral Disturbance
 ;;^UTILITY(U,$J,358.3,23993,1,4,0)
 ;;=4^F01.50
 ;;^UTILITY(U,$J,358.3,23993,2)
 ;;=^5003046
 ;;^UTILITY(U,$J,358.3,23994,0)
 ;;=F01.51^^90^1039^32
 ;;^UTILITY(U,$J,358.3,23994,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23994,1,3,0)
 ;;=3^Probable Major Vascular Neurocognitive Disorder w/ Behavioral Disturbance
 ;;^UTILITY(U,$J,358.3,23994,1,4,0)
 ;;=4^F01.51
 ;;^UTILITY(U,$J,358.3,23994,2)
 ;;=^5003047
 ;;^UTILITY(U,$J,358.3,23995,0)
 ;;=F10.27^^90^1039^1
 ;;^UTILITY(U,$J,358.3,23995,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23995,1,3,0)
 ;;=3^Alcohol-Induced Major Neurocognitive Disorder,Nonamnestic Confabulatory Type
 ;;^UTILITY(U,$J,358.3,23995,1,4,0)
 ;;=4^F10.27
 ;;^UTILITY(U,$J,358.3,23995,2)
 ;;=^5003095
 ;;^UTILITY(U,$J,358.3,23996,0)
 ;;=F19.97^^90^1039^37
 ;;^UTILITY(U,$J,358.3,23996,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23996,1,3,0)
 ;;=3^Substance-Induced Major Neurocognitive Disorder NEC
 ;;^UTILITY(U,$J,358.3,23996,1,4,0)
 ;;=4^F19.97
 ;;^UTILITY(U,$J,358.3,23996,2)
 ;;=^5003465
 ;;^UTILITY(U,$J,358.3,23997,0)
 ;;=F02.80^^90^1039^13
 ;;^UTILITY(U,$J,358.3,23997,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23997,1,3,0)
 ;;=3^Dementia in Oth Diseases Classified Elsewhere w/o Behavorial Disturbance
 ;;^UTILITY(U,$J,358.3,23997,1,4,0)
 ;;=4^F02.80
 ;;^UTILITY(U,$J,358.3,23997,2)
 ;;=^5003048
 ;;^UTILITY(U,$J,358.3,23998,0)
 ;;=F02.81^^90^1039^14
 ;;^UTILITY(U,$J,358.3,23998,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23998,1,3,0)
 ;;=3^Dementia in Oth Diseases Classified Elsewhere w/ Behavioral Disturbance
 ;;^UTILITY(U,$J,358.3,23998,1,4,0)
 ;;=4^F02.81
 ;;^UTILITY(U,$J,358.3,23998,2)
 ;;=^5003049
 ;;^UTILITY(U,$J,358.3,23999,0)
 ;;=F06.8^^90^1039^24
 ;;^UTILITY(U,$J,358.3,23999,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23999,1,3,0)
 ;;=3^Mental Disorder d/t Another Medical Condition NEC
 ;;^UTILITY(U,$J,358.3,23999,1,4,0)
 ;;=4^F06.8
 ;;^UTILITY(U,$J,358.3,23999,2)
 ;;=^5003062
 ;;^UTILITY(U,$J,358.3,24000,0)
 ;;=G30.9^^90^1039^5
 ;;^UTILITY(U,$J,358.3,24000,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24000,1,3,0)
 ;;=3^Alzheimer's Disease,Unspec
 ;;^UTILITY(U,$J,358.3,24000,1,4,0)
 ;;=4^G30.9
 ;;^UTILITY(U,$J,358.3,24000,2)
 ;;=^5003808
 ;;^UTILITY(U,$J,358.3,24001,0)
 ;;=G31.9^^90^1039^23
 ;;^UTILITY(U,$J,358.3,24001,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24001,1,3,0)
 ;;=3^Major Neurocognitive Disorder d/t Alzheimer's Disease,Possible
 ;;^UTILITY(U,$J,358.3,24001,1,4,0)
 ;;=4^G31.9
 ;;^UTILITY(U,$J,358.3,24001,2)
 ;;=^5003815
 ;;^UTILITY(U,$J,358.3,24002,0)
 ;;=G31.01^^90^1039^30
 ;;^UTILITY(U,$J,358.3,24002,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24002,1,3,0)
 ;;=3^Pick's Disease
 ;;^UTILITY(U,$J,358.3,24002,1,4,0)
 ;;=4^G31.01
 ;;^UTILITY(U,$J,358.3,24002,2)
 ;;=^329915
 ;;^UTILITY(U,$J,358.3,24003,0)
 ;;=G31.1^^90^1039^36
 ;;^UTILITY(U,$J,358.3,24003,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24003,1,3,0)
 ;;=3^Senile Degeneration of the Brain NOS
