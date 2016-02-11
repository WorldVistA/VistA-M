IBDEI1VT ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,31515,1,4,0)
 ;;=4^F01.51
 ;;^UTILITY(U,$J,358.3,31515,2)
 ;;=^5003047
 ;;^UTILITY(U,$J,358.3,31516,0)
 ;;=F10.27^^138^1429^1
 ;;^UTILITY(U,$J,358.3,31516,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31516,1,3,0)
 ;;=3^Alcohol-Induced Major Neurocognitive Disorder,Nonamnestic Confabulatory Type
 ;;^UTILITY(U,$J,358.3,31516,1,4,0)
 ;;=4^F10.27
 ;;^UTILITY(U,$J,358.3,31516,2)
 ;;=^5003095
 ;;^UTILITY(U,$J,358.3,31517,0)
 ;;=F19.97^^138^1429^37
 ;;^UTILITY(U,$J,358.3,31517,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31517,1,3,0)
 ;;=3^Substance-Induced Major Neurocognitive Disorder NEC
 ;;^UTILITY(U,$J,358.3,31517,1,4,0)
 ;;=4^F19.97
 ;;^UTILITY(U,$J,358.3,31517,2)
 ;;=^5003465
 ;;^UTILITY(U,$J,358.3,31518,0)
 ;;=F02.80^^138^1429^13
 ;;^UTILITY(U,$J,358.3,31518,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31518,1,3,0)
 ;;=3^Dementia in Oth Diseases Classified Elsewhere w/o Behavorial Disturbance
 ;;^UTILITY(U,$J,358.3,31518,1,4,0)
 ;;=4^F02.80
 ;;^UTILITY(U,$J,358.3,31518,2)
 ;;=^5003048
 ;;^UTILITY(U,$J,358.3,31519,0)
 ;;=F02.81^^138^1429^14
 ;;^UTILITY(U,$J,358.3,31519,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31519,1,3,0)
 ;;=3^Dementia in Oth Diseases Classified Elsewhere w/ Behavioral Disturbance
 ;;^UTILITY(U,$J,358.3,31519,1,4,0)
 ;;=4^F02.81
 ;;^UTILITY(U,$J,358.3,31519,2)
 ;;=^5003049
 ;;^UTILITY(U,$J,358.3,31520,0)
 ;;=F06.8^^138^1429^24
 ;;^UTILITY(U,$J,358.3,31520,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31520,1,3,0)
 ;;=3^Mental Disorder d/t Another Medical Condition NEC
 ;;^UTILITY(U,$J,358.3,31520,1,4,0)
 ;;=4^F06.8
 ;;^UTILITY(U,$J,358.3,31520,2)
 ;;=^5003062
 ;;^UTILITY(U,$J,358.3,31521,0)
 ;;=G30.9^^138^1429^5
 ;;^UTILITY(U,$J,358.3,31521,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31521,1,3,0)
 ;;=3^Alzheimer's Disease,Unspec
 ;;^UTILITY(U,$J,358.3,31521,1,4,0)
 ;;=4^G30.9
 ;;^UTILITY(U,$J,358.3,31521,2)
 ;;=^5003808
 ;;^UTILITY(U,$J,358.3,31522,0)
 ;;=G31.9^^138^1429^23
 ;;^UTILITY(U,$J,358.3,31522,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31522,1,3,0)
 ;;=3^Major Neurocognitive Disorder d/t Alzheimer's Disease,Possible
 ;;^UTILITY(U,$J,358.3,31522,1,4,0)
 ;;=4^G31.9
 ;;^UTILITY(U,$J,358.3,31522,2)
 ;;=^5003815
 ;;^UTILITY(U,$J,358.3,31523,0)
 ;;=G31.01^^138^1429^30
 ;;^UTILITY(U,$J,358.3,31523,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31523,1,3,0)
 ;;=3^Pick's Disease
 ;;^UTILITY(U,$J,358.3,31523,1,4,0)
 ;;=4^G31.01
 ;;^UTILITY(U,$J,358.3,31523,2)
 ;;=^329915
 ;;^UTILITY(U,$J,358.3,31524,0)
 ;;=G31.1^^138^1429^36
 ;;^UTILITY(U,$J,358.3,31524,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31524,1,3,0)
 ;;=3^Senile Degeneration of the Brain NOS
 ;;^UTILITY(U,$J,358.3,31524,1,4,0)
 ;;=4^G31.1
 ;;^UTILITY(U,$J,358.3,31524,2)
 ;;=^5003809
 ;;^UTILITY(U,$J,358.3,31525,0)
 ;;=G94.^^138^1429^7
 ;;^UTILITY(U,$J,358.3,31525,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31525,1,3,0)
 ;;=3^Brain Disorders in Diseases Classified Elsewhere NEC
 ;;^UTILITY(U,$J,358.3,31525,1,4,0)
 ;;=4^G94.
 ;;^UTILITY(U,$J,358.3,31525,2)
 ;;=^5004187
 ;;^UTILITY(U,$J,358.3,31526,0)
 ;;=G31.83^^138^1429^16
 ;;^UTILITY(U,$J,358.3,31526,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31526,1,3,0)
 ;;=3^Dementia w/ Lewy Bodies
 ;;^UTILITY(U,$J,358.3,31526,1,4,0)
 ;;=4^G31.83
 ;;^UTILITY(U,$J,358.3,31526,2)
 ;;=^329888
 ;;^UTILITY(U,$J,358.3,31527,0)
 ;;=G31.89^^138^1429^11
 ;;^UTILITY(U,$J,358.3,31527,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31527,1,3,0)
 ;;=3^Degenerative Diseases of Nervous System NEC
 ;;^UTILITY(U,$J,358.3,31527,1,4,0)
 ;;=4^G31.89
 ;;^UTILITY(U,$J,358.3,31527,2)
 ;;=^5003814
