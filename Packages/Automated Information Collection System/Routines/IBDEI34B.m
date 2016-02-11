IBDEI34B ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,52332,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52332,1,3,0)
 ;;=3^Pick's Disease
 ;;^UTILITY(U,$J,358.3,52332,1,4,0)
 ;;=4^G31.01
 ;;^UTILITY(U,$J,358.3,52332,2)
 ;;=^329915
 ;;^UTILITY(U,$J,358.3,52333,0)
 ;;=G31.1^^237^2592^36
 ;;^UTILITY(U,$J,358.3,52333,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52333,1,3,0)
 ;;=3^Senile Degeneration of the Brain NOS
 ;;^UTILITY(U,$J,358.3,52333,1,4,0)
 ;;=4^G31.1
 ;;^UTILITY(U,$J,358.3,52333,2)
 ;;=^5003809
 ;;^UTILITY(U,$J,358.3,52334,0)
 ;;=G94.^^237^2592^7
 ;;^UTILITY(U,$J,358.3,52334,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52334,1,3,0)
 ;;=3^Brain Disorders in Diseases Classified Elsewhere NEC
 ;;^UTILITY(U,$J,358.3,52334,1,4,0)
 ;;=4^G94.
 ;;^UTILITY(U,$J,358.3,52334,2)
 ;;=^5004187
 ;;^UTILITY(U,$J,358.3,52335,0)
 ;;=G31.83^^237^2592^16
 ;;^UTILITY(U,$J,358.3,52335,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52335,1,3,0)
 ;;=3^Dementia w/ Lewy Bodies
 ;;^UTILITY(U,$J,358.3,52335,1,4,0)
 ;;=4^G31.83
 ;;^UTILITY(U,$J,358.3,52335,2)
 ;;=^329888
 ;;^UTILITY(U,$J,358.3,52336,0)
 ;;=G31.89^^237^2592^11
 ;;^UTILITY(U,$J,358.3,52336,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52336,1,3,0)
 ;;=3^Degenerative Diseases of Nervous System NEC
 ;;^UTILITY(U,$J,358.3,52336,1,4,0)
 ;;=4^G31.89
 ;;^UTILITY(U,$J,358.3,52336,2)
 ;;=^5003814
 ;;^UTILITY(U,$J,358.3,52337,0)
 ;;=G31.9^^237^2592^12
 ;;^UTILITY(U,$J,358.3,52337,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52337,1,3,0)
 ;;=3^Degenerative Diseases of Nervous System,Unspec
 ;;^UTILITY(U,$J,358.3,52337,1,4,0)
 ;;=4^G31.9
 ;;^UTILITY(U,$J,358.3,52337,2)
 ;;=^5003815
 ;;^UTILITY(U,$J,358.3,52338,0)
 ;;=G23.8^^237^2592^10
 ;;^UTILITY(U,$J,358.3,52338,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52338,1,3,0)
 ;;=3^Degenerative Diseases of Basal Ganglia NEC
 ;;^UTILITY(U,$J,358.3,52338,1,4,0)
 ;;=4^G23.8
 ;;^UTILITY(U,$J,358.3,52338,2)
 ;;=^5003782
 ;;^UTILITY(U,$J,358.3,52339,0)
 ;;=G31.09^^237^2592^22
 ;;^UTILITY(U,$J,358.3,52339,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52339,1,3,0)
 ;;=3^Major Frontotemporal Neurocognitive Disorder w/ Behavioral Disturbance
 ;;^UTILITY(U,$J,358.3,52339,1,4,0)
 ;;=4^G31.09
 ;;^UTILITY(U,$J,358.3,52339,2)
 ;;=^329916^F02.81
 ;;^UTILITY(U,$J,358.3,52340,0)
 ;;=G30.0^^237^2592^3
 ;;^UTILITY(U,$J,358.3,52340,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52340,1,3,0)
 ;;=3^Alzheimer's Disease w/ Early Onset
 ;;^UTILITY(U,$J,358.3,52340,1,4,0)
 ;;=4^G30.0
 ;;^UTILITY(U,$J,358.3,52340,2)
 ;;=^5003805
 ;;^UTILITY(U,$J,358.3,52341,0)
 ;;=G30.1^^237^2592^4
 ;;^UTILITY(U,$J,358.3,52341,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52341,1,3,0)
 ;;=3^Alzheimer's Disease with Late Onset
 ;;^UTILITY(U,$J,358.3,52341,1,4,0)
 ;;=4^G30.1
 ;;^UTILITY(U,$J,358.3,52341,2)
 ;;=^5003806
 ;;^UTILITY(U,$J,358.3,52342,0)
 ;;=B20.^^237^2592^18
 ;;^UTILITY(U,$J,358.3,52342,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52342,1,3,0)
 ;;=3^HIV Disease w/ Dementia w/ Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,52342,1,4,0)
 ;;=4^B20.
 ;;^UTILITY(U,$J,358.3,52342,2)
 ;;=^5000555^F02.81
 ;;^UTILITY(U,$J,358.3,52343,0)
 ;;=B20.^^237^2592^19
 ;;^UTILITY(U,$J,358.3,52343,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52343,1,3,0)
 ;;=3^HIV Disease w/ Dementia w/o Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,52343,1,4,0)
 ;;=4^B20.
 ;;^UTILITY(U,$J,358.3,52343,2)
 ;;=^5000555^F02.80
 ;;^UTILITY(U,$J,358.3,52344,0)
 ;;=G10.^^237^2592^20
 ;;^UTILITY(U,$J,358.3,52344,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52344,1,3,0)
 ;;=3^Huntington's Disease w/ Dementia w/ Behavioral Disturbances
