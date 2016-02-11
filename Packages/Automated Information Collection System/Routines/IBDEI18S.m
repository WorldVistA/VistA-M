IBDEI18S ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,20771,1,4,0)
 ;;=4^A81.09
 ;;^UTILITY(U,$J,358.3,20771,2)
 ;;=^5000410
 ;;^UTILITY(U,$J,358.3,20772,0)
 ;;=A81.2^^99^985^33
 ;;^UTILITY(U,$J,358.3,20772,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20772,1,3,0)
 ;;=3^Progressive Multifocal Leukoencephalopathy
 ;;^UTILITY(U,$J,358.3,20772,1,4,0)
 ;;=4^A81.2
 ;;^UTILITY(U,$J,358.3,20772,2)
 ;;=^5000411
 ;;^UTILITY(U,$J,358.3,20773,0)
 ;;=F01.50^^99^985^31
 ;;^UTILITY(U,$J,358.3,20773,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20773,1,3,0)
 ;;=3^Probable Major Vascular Neurocognitive Disorder w/o Behavioral Disturbance
 ;;^UTILITY(U,$J,358.3,20773,1,4,0)
 ;;=4^F01.50
 ;;^UTILITY(U,$J,358.3,20773,2)
 ;;=^5003046
 ;;^UTILITY(U,$J,358.3,20774,0)
 ;;=F01.51^^99^985^32
 ;;^UTILITY(U,$J,358.3,20774,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20774,1,3,0)
 ;;=3^Probable Major Vascular Neurocognitive Disorder w/ Behavioral Disturbance
 ;;^UTILITY(U,$J,358.3,20774,1,4,0)
 ;;=4^F01.51
 ;;^UTILITY(U,$J,358.3,20774,2)
 ;;=^5003047
 ;;^UTILITY(U,$J,358.3,20775,0)
 ;;=F10.27^^99^985^1
 ;;^UTILITY(U,$J,358.3,20775,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20775,1,3,0)
 ;;=3^Alcohol-Induced Major Neurocognitive Disorder,Nonamnestic Confabulatory Type
 ;;^UTILITY(U,$J,358.3,20775,1,4,0)
 ;;=4^F10.27
 ;;^UTILITY(U,$J,358.3,20775,2)
 ;;=^5003095
 ;;^UTILITY(U,$J,358.3,20776,0)
 ;;=F19.97^^99^985^37
 ;;^UTILITY(U,$J,358.3,20776,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20776,1,3,0)
 ;;=3^Substance-Induced Major Neurocognitive Disorder NEC
 ;;^UTILITY(U,$J,358.3,20776,1,4,0)
 ;;=4^F19.97
 ;;^UTILITY(U,$J,358.3,20776,2)
 ;;=^5003465
 ;;^UTILITY(U,$J,358.3,20777,0)
 ;;=F02.80^^99^985^13
 ;;^UTILITY(U,$J,358.3,20777,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20777,1,3,0)
 ;;=3^Dementia in Oth Diseases Classified Elsewhere w/o Behavorial Disturbance
 ;;^UTILITY(U,$J,358.3,20777,1,4,0)
 ;;=4^F02.80
 ;;^UTILITY(U,$J,358.3,20777,2)
 ;;=^5003048
 ;;^UTILITY(U,$J,358.3,20778,0)
 ;;=F02.81^^99^985^14
 ;;^UTILITY(U,$J,358.3,20778,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20778,1,3,0)
 ;;=3^Dementia in Oth Diseases Classified Elsewhere w/ Behavioral Disturbance
 ;;^UTILITY(U,$J,358.3,20778,1,4,0)
 ;;=4^F02.81
 ;;^UTILITY(U,$J,358.3,20778,2)
 ;;=^5003049
 ;;^UTILITY(U,$J,358.3,20779,0)
 ;;=F06.8^^99^985^24
 ;;^UTILITY(U,$J,358.3,20779,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20779,1,3,0)
 ;;=3^Mental Disorder d/t Another Medical Condition NEC
 ;;^UTILITY(U,$J,358.3,20779,1,4,0)
 ;;=4^F06.8
 ;;^UTILITY(U,$J,358.3,20779,2)
 ;;=^5003062
 ;;^UTILITY(U,$J,358.3,20780,0)
 ;;=G30.9^^99^985^5
 ;;^UTILITY(U,$J,358.3,20780,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20780,1,3,0)
 ;;=3^Alzheimer's Disease,Unspec
 ;;^UTILITY(U,$J,358.3,20780,1,4,0)
 ;;=4^G30.9
 ;;^UTILITY(U,$J,358.3,20780,2)
 ;;=^5003808
 ;;^UTILITY(U,$J,358.3,20781,0)
 ;;=G31.9^^99^985^23
 ;;^UTILITY(U,$J,358.3,20781,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20781,1,3,0)
 ;;=3^Major Neurocognitive Disorder d/t Alzheimer's Disease,Possible
 ;;^UTILITY(U,$J,358.3,20781,1,4,0)
 ;;=4^G31.9
 ;;^UTILITY(U,$J,358.3,20781,2)
 ;;=^5003815
 ;;^UTILITY(U,$J,358.3,20782,0)
 ;;=G31.01^^99^985^30
 ;;^UTILITY(U,$J,358.3,20782,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20782,1,3,0)
 ;;=3^Pick's Disease
 ;;^UTILITY(U,$J,358.3,20782,1,4,0)
 ;;=4^G31.01
 ;;^UTILITY(U,$J,358.3,20782,2)
 ;;=^329915
 ;;^UTILITY(U,$J,358.3,20783,0)
 ;;=G31.1^^99^985^36
 ;;^UTILITY(U,$J,358.3,20783,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20783,1,3,0)
 ;;=3^Senile Degeneration of the Brain NOS
 ;;^UTILITY(U,$J,358.3,20783,1,4,0)
 ;;=4^G31.1
