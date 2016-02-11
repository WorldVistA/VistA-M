IBDEI021 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,177,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,177,1,3,0)
 ;;=3^Substance-Induced Major Neurocognitive Disorder NEC
 ;;^UTILITY(U,$J,358.3,177,1,4,0)
 ;;=4^F19.97
 ;;^UTILITY(U,$J,358.3,177,2)
 ;;=^5003465
 ;;^UTILITY(U,$J,358.3,178,0)
 ;;=F02.80^^3^27^13
 ;;^UTILITY(U,$J,358.3,178,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,178,1,3,0)
 ;;=3^Dementia in Oth Diseases Classified Elsewhere w/o Behavorial Disturbance
 ;;^UTILITY(U,$J,358.3,178,1,4,0)
 ;;=4^F02.80
 ;;^UTILITY(U,$J,358.3,178,2)
 ;;=^5003048
 ;;^UTILITY(U,$J,358.3,179,0)
 ;;=F02.81^^3^27^14
 ;;^UTILITY(U,$J,358.3,179,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,179,1,3,0)
 ;;=3^Dementia in Oth Diseases Classified Elsewhere w/ Behavioral Disturbance
 ;;^UTILITY(U,$J,358.3,179,1,4,0)
 ;;=4^F02.81
 ;;^UTILITY(U,$J,358.3,179,2)
 ;;=^5003049
 ;;^UTILITY(U,$J,358.3,180,0)
 ;;=F06.8^^3^27^24
 ;;^UTILITY(U,$J,358.3,180,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,180,1,3,0)
 ;;=3^Mental Disorder d/t Another Medical Condition NEC
 ;;^UTILITY(U,$J,358.3,180,1,4,0)
 ;;=4^F06.8
 ;;^UTILITY(U,$J,358.3,180,2)
 ;;=^5003062
 ;;^UTILITY(U,$J,358.3,181,0)
 ;;=G30.9^^3^27^5
 ;;^UTILITY(U,$J,358.3,181,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,181,1,3,0)
 ;;=3^Alzheimer's Disease,Unspec
 ;;^UTILITY(U,$J,358.3,181,1,4,0)
 ;;=4^G30.9
 ;;^UTILITY(U,$J,358.3,181,2)
 ;;=^5003808
 ;;^UTILITY(U,$J,358.3,182,0)
 ;;=G31.9^^3^27^23
 ;;^UTILITY(U,$J,358.3,182,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,182,1,3,0)
 ;;=3^Major Neurocognitive Disorder d/t Alzheimer's Disease,Possible
 ;;^UTILITY(U,$J,358.3,182,1,4,0)
 ;;=4^G31.9
 ;;^UTILITY(U,$J,358.3,182,2)
 ;;=^5003815
 ;;^UTILITY(U,$J,358.3,183,0)
 ;;=G31.01^^3^27^30
 ;;^UTILITY(U,$J,358.3,183,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,183,1,3,0)
 ;;=3^Pick's Disease
 ;;^UTILITY(U,$J,358.3,183,1,4,0)
 ;;=4^G31.01
 ;;^UTILITY(U,$J,358.3,183,2)
 ;;=^329915
 ;;^UTILITY(U,$J,358.3,184,0)
 ;;=G31.1^^3^27^36
 ;;^UTILITY(U,$J,358.3,184,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,184,1,3,0)
 ;;=3^Senile Degeneration of the Brain NOS
 ;;^UTILITY(U,$J,358.3,184,1,4,0)
 ;;=4^G31.1
 ;;^UTILITY(U,$J,358.3,184,2)
 ;;=^5003809
 ;;^UTILITY(U,$J,358.3,185,0)
 ;;=G94.^^3^27^7
 ;;^UTILITY(U,$J,358.3,185,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,185,1,3,0)
 ;;=3^Brain Disorders in Diseases Classified Elsewhere NEC
 ;;^UTILITY(U,$J,358.3,185,1,4,0)
 ;;=4^G94.
 ;;^UTILITY(U,$J,358.3,185,2)
 ;;=^5004187
 ;;^UTILITY(U,$J,358.3,186,0)
 ;;=G31.83^^3^27^16
 ;;^UTILITY(U,$J,358.3,186,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,186,1,3,0)
 ;;=3^Dementia w/ Lewy Bodies
 ;;^UTILITY(U,$J,358.3,186,1,4,0)
 ;;=4^G31.83
 ;;^UTILITY(U,$J,358.3,186,2)
 ;;=^329888
 ;;^UTILITY(U,$J,358.3,187,0)
 ;;=G31.89^^3^27^11
 ;;^UTILITY(U,$J,358.3,187,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,187,1,3,0)
 ;;=3^Degenerative Diseases of Nervous System NEC
 ;;^UTILITY(U,$J,358.3,187,1,4,0)
 ;;=4^G31.89
 ;;^UTILITY(U,$J,358.3,187,2)
 ;;=^5003814
 ;;^UTILITY(U,$J,358.3,188,0)
 ;;=G31.9^^3^27^12
 ;;^UTILITY(U,$J,358.3,188,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,188,1,3,0)
 ;;=3^Degenerative Diseases of Nervous System,Unspec
 ;;^UTILITY(U,$J,358.3,188,1,4,0)
 ;;=4^G31.9
 ;;^UTILITY(U,$J,358.3,188,2)
 ;;=^5003815
 ;;^UTILITY(U,$J,358.3,189,0)
 ;;=G23.8^^3^27^10
 ;;^UTILITY(U,$J,358.3,189,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,189,1,3,0)
 ;;=3^Degenerative Diseases of Basal Ganglia NEC
 ;;^UTILITY(U,$J,358.3,189,1,4,0)
 ;;=4^G23.8
 ;;^UTILITY(U,$J,358.3,189,2)
 ;;=^5003782
 ;;^UTILITY(U,$J,358.3,190,0)
 ;;=G31.09^^3^27^22
