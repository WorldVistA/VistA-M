IBDEI1G8 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,24615,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24615,1,3,0)
 ;;=3^Dementia in Oth Diseases Classified Elsewhere w/ Behavioral Disturbance
 ;;^UTILITY(U,$J,358.3,24615,1,4,0)
 ;;=4^F02.81
 ;;^UTILITY(U,$J,358.3,24615,2)
 ;;=^5003049
 ;;^UTILITY(U,$J,358.3,24616,0)
 ;;=F06.8^^93^1094^24
 ;;^UTILITY(U,$J,358.3,24616,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24616,1,3,0)
 ;;=3^Mental Disorder d/t Another Medical Condition NEC
 ;;^UTILITY(U,$J,358.3,24616,1,4,0)
 ;;=4^F06.8
 ;;^UTILITY(U,$J,358.3,24616,2)
 ;;=^5003062
 ;;^UTILITY(U,$J,358.3,24617,0)
 ;;=G30.9^^93^1094^5
 ;;^UTILITY(U,$J,358.3,24617,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24617,1,3,0)
 ;;=3^Alzheimer's Disease,Unspec
 ;;^UTILITY(U,$J,358.3,24617,1,4,0)
 ;;=4^G30.9
 ;;^UTILITY(U,$J,358.3,24617,2)
 ;;=^5003808
 ;;^UTILITY(U,$J,358.3,24618,0)
 ;;=G31.9^^93^1094^23
 ;;^UTILITY(U,$J,358.3,24618,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24618,1,3,0)
 ;;=3^Major Neurocognitive Disorder d/t Alzheimer's Disease,Possible
 ;;^UTILITY(U,$J,358.3,24618,1,4,0)
 ;;=4^G31.9
 ;;^UTILITY(U,$J,358.3,24618,2)
 ;;=^5003815
 ;;^UTILITY(U,$J,358.3,24619,0)
 ;;=G31.01^^93^1094^30
 ;;^UTILITY(U,$J,358.3,24619,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24619,1,3,0)
 ;;=3^Pick's Disease
 ;;^UTILITY(U,$J,358.3,24619,1,4,0)
 ;;=4^G31.01
 ;;^UTILITY(U,$J,358.3,24619,2)
 ;;=^329915
 ;;^UTILITY(U,$J,358.3,24620,0)
 ;;=G31.1^^93^1094^36
 ;;^UTILITY(U,$J,358.3,24620,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24620,1,3,0)
 ;;=3^Senile Degeneration of the Brain NOS
 ;;^UTILITY(U,$J,358.3,24620,1,4,0)
 ;;=4^G31.1
 ;;^UTILITY(U,$J,358.3,24620,2)
 ;;=^5003809
 ;;^UTILITY(U,$J,358.3,24621,0)
 ;;=G94.^^93^1094^7
 ;;^UTILITY(U,$J,358.3,24621,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24621,1,3,0)
 ;;=3^Brain Disorders in Diseases Classified Elsewhere NEC
 ;;^UTILITY(U,$J,358.3,24621,1,4,0)
 ;;=4^G94.
 ;;^UTILITY(U,$J,358.3,24621,2)
 ;;=^5004187
 ;;^UTILITY(U,$J,358.3,24622,0)
 ;;=G31.83^^93^1094^16
 ;;^UTILITY(U,$J,358.3,24622,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24622,1,3,0)
 ;;=3^Dementia w/ Lewy Bodies
 ;;^UTILITY(U,$J,358.3,24622,1,4,0)
 ;;=4^G31.83
 ;;^UTILITY(U,$J,358.3,24622,2)
 ;;=^329888
 ;;^UTILITY(U,$J,358.3,24623,0)
 ;;=G31.89^^93^1094^11
 ;;^UTILITY(U,$J,358.3,24623,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24623,1,3,0)
 ;;=3^Degenerative Diseases of Nervous System NEC
 ;;^UTILITY(U,$J,358.3,24623,1,4,0)
 ;;=4^G31.89
 ;;^UTILITY(U,$J,358.3,24623,2)
 ;;=^5003814
 ;;^UTILITY(U,$J,358.3,24624,0)
 ;;=G31.9^^93^1094^12
 ;;^UTILITY(U,$J,358.3,24624,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24624,1,3,0)
 ;;=3^Degenerative Diseases of Nervous System,Unspec
 ;;^UTILITY(U,$J,358.3,24624,1,4,0)
 ;;=4^G31.9
 ;;^UTILITY(U,$J,358.3,24624,2)
 ;;=^5003815
 ;;^UTILITY(U,$J,358.3,24625,0)
 ;;=G23.8^^93^1094^10
 ;;^UTILITY(U,$J,358.3,24625,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24625,1,3,0)
 ;;=3^Degenerative Diseases of Basal Ganglia NEC
 ;;^UTILITY(U,$J,358.3,24625,1,4,0)
 ;;=4^G23.8
 ;;^UTILITY(U,$J,358.3,24625,2)
 ;;=^5003782
 ;;^UTILITY(U,$J,358.3,24626,0)
 ;;=G31.09^^93^1094^22
 ;;^UTILITY(U,$J,358.3,24626,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24626,1,3,0)
 ;;=3^Major Frontotemporal Neurocognitive Disorder w/ Behavioral Disturbance
 ;;^UTILITY(U,$J,358.3,24626,1,4,0)
 ;;=4^G31.09
 ;;^UTILITY(U,$J,358.3,24626,2)
 ;;=^329916^F02.81
 ;;^UTILITY(U,$J,358.3,24627,0)
 ;;=G30.0^^93^1094^3
 ;;^UTILITY(U,$J,358.3,24627,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24627,1,3,0)
 ;;=3^Alzheimer's Disease w/ Early Onset
