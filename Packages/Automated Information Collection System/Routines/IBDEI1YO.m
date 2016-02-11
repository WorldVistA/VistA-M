IBDEI1YO ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,32843,0)
 ;;=F02.81^^146^1585^14
 ;;^UTILITY(U,$J,358.3,32843,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32843,1,3,0)
 ;;=3^Dementia in Oth Diseases Classified Elsewhere w/ Behavioral Disturbance
 ;;^UTILITY(U,$J,358.3,32843,1,4,0)
 ;;=4^F02.81
 ;;^UTILITY(U,$J,358.3,32843,2)
 ;;=^5003049
 ;;^UTILITY(U,$J,358.3,32844,0)
 ;;=F06.8^^146^1585^24
 ;;^UTILITY(U,$J,358.3,32844,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32844,1,3,0)
 ;;=3^Mental Disorder d/t Another Medical Condition NEC
 ;;^UTILITY(U,$J,358.3,32844,1,4,0)
 ;;=4^F06.8
 ;;^UTILITY(U,$J,358.3,32844,2)
 ;;=^5003062
 ;;^UTILITY(U,$J,358.3,32845,0)
 ;;=G30.9^^146^1585^5
 ;;^UTILITY(U,$J,358.3,32845,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32845,1,3,0)
 ;;=3^Alzheimer's Disease,Unspec
 ;;^UTILITY(U,$J,358.3,32845,1,4,0)
 ;;=4^G30.9
 ;;^UTILITY(U,$J,358.3,32845,2)
 ;;=^5003808
 ;;^UTILITY(U,$J,358.3,32846,0)
 ;;=G31.9^^146^1585^23
 ;;^UTILITY(U,$J,358.3,32846,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32846,1,3,0)
 ;;=3^Major Neurocognitive Disorder d/t Alzheimer's Disease,Possible
 ;;^UTILITY(U,$J,358.3,32846,1,4,0)
 ;;=4^G31.9
 ;;^UTILITY(U,$J,358.3,32846,2)
 ;;=^5003815
 ;;^UTILITY(U,$J,358.3,32847,0)
 ;;=G31.01^^146^1585^30
 ;;^UTILITY(U,$J,358.3,32847,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32847,1,3,0)
 ;;=3^Pick's Disease
 ;;^UTILITY(U,$J,358.3,32847,1,4,0)
 ;;=4^G31.01
 ;;^UTILITY(U,$J,358.3,32847,2)
 ;;=^329915
 ;;^UTILITY(U,$J,358.3,32848,0)
 ;;=G31.1^^146^1585^36
 ;;^UTILITY(U,$J,358.3,32848,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32848,1,3,0)
 ;;=3^Senile Degeneration of the Brain NOS
 ;;^UTILITY(U,$J,358.3,32848,1,4,0)
 ;;=4^G31.1
 ;;^UTILITY(U,$J,358.3,32848,2)
 ;;=^5003809
 ;;^UTILITY(U,$J,358.3,32849,0)
 ;;=G94.^^146^1585^7
 ;;^UTILITY(U,$J,358.3,32849,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32849,1,3,0)
 ;;=3^Brain Disorders in Diseases Classified Elsewhere NEC
 ;;^UTILITY(U,$J,358.3,32849,1,4,0)
 ;;=4^G94.
 ;;^UTILITY(U,$J,358.3,32849,2)
 ;;=^5004187
 ;;^UTILITY(U,$J,358.3,32850,0)
 ;;=G31.83^^146^1585^16
 ;;^UTILITY(U,$J,358.3,32850,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32850,1,3,0)
 ;;=3^Dementia w/ Lewy Bodies
 ;;^UTILITY(U,$J,358.3,32850,1,4,0)
 ;;=4^G31.83
 ;;^UTILITY(U,$J,358.3,32850,2)
 ;;=^329888
 ;;^UTILITY(U,$J,358.3,32851,0)
 ;;=G31.89^^146^1585^11
 ;;^UTILITY(U,$J,358.3,32851,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32851,1,3,0)
 ;;=3^Degenerative Diseases of Nervous System NEC
 ;;^UTILITY(U,$J,358.3,32851,1,4,0)
 ;;=4^G31.89
 ;;^UTILITY(U,$J,358.3,32851,2)
 ;;=^5003814
 ;;^UTILITY(U,$J,358.3,32852,0)
 ;;=G31.9^^146^1585^12
 ;;^UTILITY(U,$J,358.3,32852,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32852,1,3,0)
 ;;=3^Degenerative Diseases of Nervous System,Unspec
 ;;^UTILITY(U,$J,358.3,32852,1,4,0)
 ;;=4^G31.9
 ;;^UTILITY(U,$J,358.3,32852,2)
 ;;=^5003815
 ;;^UTILITY(U,$J,358.3,32853,0)
 ;;=G23.8^^146^1585^10
 ;;^UTILITY(U,$J,358.3,32853,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32853,1,3,0)
 ;;=3^Degenerative Diseases of Basal Ganglia NEC
 ;;^UTILITY(U,$J,358.3,32853,1,4,0)
 ;;=4^G23.8
 ;;^UTILITY(U,$J,358.3,32853,2)
 ;;=^5003782
 ;;^UTILITY(U,$J,358.3,32854,0)
 ;;=G31.09^^146^1585^22
 ;;^UTILITY(U,$J,358.3,32854,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32854,1,3,0)
 ;;=3^Major Frontotemporal Neurocognitive Disorder w/ Behavioral Disturbance
 ;;^UTILITY(U,$J,358.3,32854,1,4,0)
 ;;=4^G31.09
 ;;^UTILITY(U,$J,358.3,32854,2)
 ;;=^329916^F02.81
 ;;^UTILITY(U,$J,358.3,32855,0)
 ;;=G30.0^^146^1585^3
 ;;^UTILITY(U,$J,358.3,32855,1,0)
 ;;=^358.31IA^4^2
