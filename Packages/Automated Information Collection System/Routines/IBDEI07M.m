IBDEI07M ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,3063,2)
 ;;=^5003049
 ;;^UTILITY(U,$J,358.3,3064,0)
 ;;=F06.8^^8^89^16
 ;;^UTILITY(U,$J,358.3,3064,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3064,1,3,0)
 ;;=3^Mental Disorder d/t Another Medical Condition NEC
 ;;^UTILITY(U,$J,358.3,3064,1,4,0)
 ;;=4^F06.8
 ;;^UTILITY(U,$J,358.3,3064,2)
 ;;=^5003062
 ;;^UTILITY(U,$J,358.3,3065,0)
 ;;=G30.9^^8^89^2
 ;;^UTILITY(U,$J,358.3,3065,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3065,1,3,0)
 ;;=3^Alzheimer's Disease,Unspec
 ;;^UTILITY(U,$J,358.3,3065,1,4,0)
 ;;=4^G30.9
 ;;^UTILITY(U,$J,358.3,3065,2)
 ;;=^5003808
 ;;^UTILITY(U,$J,358.3,3066,0)
 ;;=G31.9^^8^89^14
 ;;^UTILITY(U,$J,358.3,3066,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3066,1,3,0)
 ;;=3^Major Neurocognitive Disorder d/t Alzheimer's Disease,Possible
 ;;^UTILITY(U,$J,358.3,3066,1,4,0)
 ;;=4^G31.9
 ;;^UTILITY(U,$J,358.3,3066,2)
 ;;=^5003815
 ;;^UTILITY(U,$J,358.3,3067,0)
 ;;=G31.01^^8^89^17
 ;;^UTILITY(U,$J,358.3,3067,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3067,1,3,0)
 ;;=3^Pick's Disease
 ;;^UTILITY(U,$J,358.3,3067,1,4,0)
 ;;=4^G31.01
 ;;^UTILITY(U,$J,358.3,3067,2)
 ;;=^329915
 ;;^UTILITY(U,$J,358.3,3068,0)
 ;;=G31.1^^8^89^21
 ;;^UTILITY(U,$J,358.3,3068,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3068,1,3,0)
 ;;=3^Senile Degeneration of the Brain NOS
 ;;^UTILITY(U,$J,358.3,3068,1,4,0)
 ;;=4^G31.1
 ;;^UTILITY(U,$J,358.3,3068,2)
 ;;=^5003809
 ;;^UTILITY(U,$J,358.3,3069,0)
 ;;=G94.^^8^89^3
 ;;^UTILITY(U,$J,358.3,3069,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3069,1,3,0)
 ;;=3^Brain Disorders in Diseases Classified Elsewhere NEC
 ;;^UTILITY(U,$J,358.3,3069,1,4,0)
 ;;=4^G94.
 ;;^UTILITY(U,$J,358.3,3069,2)
 ;;=^5004187
 ;;^UTILITY(U,$J,358.3,3070,0)
 ;;=G31.83^^8^89^11
 ;;^UTILITY(U,$J,358.3,3070,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3070,1,3,0)
 ;;=3^Dementia w/ Lewy Bodies
 ;;^UTILITY(U,$J,358.3,3070,1,4,0)
 ;;=4^G31.83
 ;;^UTILITY(U,$J,358.3,3070,2)
 ;;=^329888
 ;;^UTILITY(U,$J,358.3,3071,0)
 ;;=G31.89^^8^89^7
 ;;^UTILITY(U,$J,358.3,3071,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3071,1,3,0)
 ;;=3^Degenerative Diseases of Nervous System NEC
 ;;^UTILITY(U,$J,358.3,3071,1,4,0)
 ;;=4^G31.89
 ;;^UTILITY(U,$J,358.3,3071,2)
 ;;=^5003814
 ;;^UTILITY(U,$J,358.3,3072,0)
 ;;=G31.9^^8^89^8
 ;;^UTILITY(U,$J,358.3,3072,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3072,1,3,0)
 ;;=3^Degenerative Diseases of Nervous System,Unspec
 ;;^UTILITY(U,$J,358.3,3072,1,4,0)
 ;;=4^G31.9
 ;;^UTILITY(U,$J,358.3,3072,2)
 ;;=^5003815
 ;;^UTILITY(U,$J,358.3,3073,0)
 ;;=G23.8^^8^89^6
 ;;^UTILITY(U,$J,358.3,3073,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3073,1,3,0)
 ;;=3^Degenerative Diseases of Basal Ganglia NEC
 ;;^UTILITY(U,$J,358.3,3073,1,4,0)
 ;;=4^G23.8
 ;;^UTILITY(U,$J,358.3,3073,2)
 ;;=^5003782
 ;;^UTILITY(U,$J,358.3,3074,0)
 ;;=G10.^^8^89^15
 ;;^UTILITY(U,$J,358.3,3074,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3074,1,3,0)
 ;;=3^Major Neurocognitive Disorder d/t Huntington's Disease w/ Behavioral Disturbance
 ;;^UTILITY(U,$J,358.3,3074,1,4,0)
 ;;=4^G10.
 ;;^UTILITY(U,$J,358.3,3074,2)
 ;;=^5003751^F02.81
 ;;^UTILITY(U,$J,358.3,3075,0)
 ;;=G31.09^^8^89^13
 ;;^UTILITY(U,$J,358.3,3075,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3075,1,3,0)
 ;;=3^Major Frontotemporal Neurocognitive Disorder w/ Behavioral Disturbance
 ;;^UTILITY(U,$J,358.3,3075,1,4,0)
 ;;=4^G31.09
 ;;^UTILITY(U,$J,358.3,3075,2)
 ;;=^329916^F02.81
 ;;^UTILITY(U,$J,358.3,3076,0)
 ;;=F06.30^^8^90^2
 ;;^UTILITY(U,$J,358.3,3076,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3076,1,3,0)
 ;;=3^Depressive Disorder d/t Another Medical Condition,Unspec
