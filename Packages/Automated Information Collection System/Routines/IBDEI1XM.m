IBDEI1XM ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,32343,2)
 ;;=^5003062
 ;;^UTILITY(U,$J,358.3,32344,0)
 ;;=G30.9^^143^1521^5
 ;;^UTILITY(U,$J,358.3,32344,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32344,1,3,0)
 ;;=3^Alzheimer's Disease,Unspec
 ;;^UTILITY(U,$J,358.3,32344,1,4,0)
 ;;=4^G30.9
 ;;^UTILITY(U,$J,358.3,32344,2)
 ;;=^5003808
 ;;^UTILITY(U,$J,358.3,32345,0)
 ;;=G31.9^^143^1521^23
 ;;^UTILITY(U,$J,358.3,32345,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32345,1,3,0)
 ;;=3^Major Neurocognitive Disorder d/t Alzheimer's Disease,Possible
 ;;^UTILITY(U,$J,358.3,32345,1,4,0)
 ;;=4^G31.9
 ;;^UTILITY(U,$J,358.3,32345,2)
 ;;=^5003815
 ;;^UTILITY(U,$J,358.3,32346,0)
 ;;=G31.01^^143^1521^30
 ;;^UTILITY(U,$J,358.3,32346,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32346,1,3,0)
 ;;=3^Pick's Disease
 ;;^UTILITY(U,$J,358.3,32346,1,4,0)
 ;;=4^G31.01
 ;;^UTILITY(U,$J,358.3,32346,2)
 ;;=^329915
 ;;^UTILITY(U,$J,358.3,32347,0)
 ;;=G31.1^^143^1521^36
 ;;^UTILITY(U,$J,358.3,32347,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32347,1,3,0)
 ;;=3^Senile Degeneration of the Brain NOS
 ;;^UTILITY(U,$J,358.3,32347,1,4,0)
 ;;=4^G31.1
 ;;^UTILITY(U,$J,358.3,32347,2)
 ;;=^5003809
 ;;^UTILITY(U,$J,358.3,32348,0)
 ;;=G94.^^143^1521^7
 ;;^UTILITY(U,$J,358.3,32348,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32348,1,3,0)
 ;;=3^Brain Disorders in Diseases Classified Elsewhere NEC
 ;;^UTILITY(U,$J,358.3,32348,1,4,0)
 ;;=4^G94.
 ;;^UTILITY(U,$J,358.3,32348,2)
 ;;=^5004187
 ;;^UTILITY(U,$J,358.3,32349,0)
 ;;=G31.83^^143^1521^16
 ;;^UTILITY(U,$J,358.3,32349,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32349,1,3,0)
 ;;=3^Dementia w/ Lewy Bodies
 ;;^UTILITY(U,$J,358.3,32349,1,4,0)
 ;;=4^G31.83
 ;;^UTILITY(U,$J,358.3,32349,2)
 ;;=^329888
 ;;^UTILITY(U,$J,358.3,32350,0)
 ;;=G31.89^^143^1521^11
 ;;^UTILITY(U,$J,358.3,32350,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32350,1,3,0)
 ;;=3^Degenerative Diseases of Nervous System NEC
 ;;^UTILITY(U,$J,358.3,32350,1,4,0)
 ;;=4^G31.89
 ;;^UTILITY(U,$J,358.3,32350,2)
 ;;=^5003814
 ;;^UTILITY(U,$J,358.3,32351,0)
 ;;=G31.9^^143^1521^12
 ;;^UTILITY(U,$J,358.3,32351,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32351,1,3,0)
 ;;=3^Degenerative Diseases of Nervous System,Unspec
 ;;^UTILITY(U,$J,358.3,32351,1,4,0)
 ;;=4^G31.9
 ;;^UTILITY(U,$J,358.3,32351,2)
 ;;=^5003815
 ;;^UTILITY(U,$J,358.3,32352,0)
 ;;=G23.8^^143^1521^10
 ;;^UTILITY(U,$J,358.3,32352,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32352,1,3,0)
 ;;=3^Degenerative Diseases of Basal Ganglia NEC
 ;;^UTILITY(U,$J,358.3,32352,1,4,0)
 ;;=4^G23.8
 ;;^UTILITY(U,$J,358.3,32352,2)
 ;;=^5003782
 ;;^UTILITY(U,$J,358.3,32353,0)
 ;;=G31.09^^143^1521^22
 ;;^UTILITY(U,$J,358.3,32353,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32353,1,3,0)
 ;;=3^Major Frontotemporal Neurocognitive Disorder w/ Behavioral Disturbance
 ;;^UTILITY(U,$J,358.3,32353,1,4,0)
 ;;=4^G31.09
 ;;^UTILITY(U,$J,358.3,32353,2)
 ;;=^329916^F02.81
 ;;^UTILITY(U,$J,358.3,32354,0)
 ;;=G30.0^^143^1521^3
 ;;^UTILITY(U,$J,358.3,32354,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32354,1,3,0)
 ;;=3^Alzheimer's Disease w/ Early Onset
 ;;^UTILITY(U,$J,358.3,32354,1,4,0)
 ;;=4^G30.0
 ;;^UTILITY(U,$J,358.3,32354,2)
 ;;=^5003805
 ;;^UTILITY(U,$J,358.3,32355,0)
 ;;=G30.1^^143^1521^4
 ;;^UTILITY(U,$J,358.3,32355,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32355,1,3,0)
 ;;=3^Alzheimer's Disease with Late Onset
 ;;^UTILITY(U,$J,358.3,32355,1,4,0)
 ;;=4^G30.1
 ;;^UTILITY(U,$J,358.3,32355,2)
 ;;=^5003806
 ;;^UTILITY(U,$J,358.3,32356,0)
 ;;=B20.^^143^1521^18
 ;;^UTILITY(U,$J,358.3,32356,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32356,1,3,0)
 ;;=3^HIV Disease w/ Dementia w/ Behavioral Disturbances
