IBDEI0WT ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,15396,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15396,1,3,0)
 ;;=3^Mental Disorder d/t Another Medical Condition NEC
 ;;^UTILITY(U,$J,358.3,15396,1,4,0)
 ;;=4^F06.8
 ;;^UTILITY(U,$J,358.3,15396,2)
 ;;=^5003062
 ;;^UTILITY(U,$J,358.3,15397,0)
 ;;=G30.9^^58^662^5
 ;;^UTILITY(U,$J,358.3,15397,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15397,1,3,0)
 ;;=3^Alzheimer's Disease,Unspec
 ;;^UTILITY(U,$J,358.3,15397,1,4,0)
 ;;=4^G30.9
 ;;^UTILITY(U,$J,358.3,15397,2)
 ;;=^5003808
 ;;^UTILITY(U,$J,358.3,15398,0)
 ;;=G31.9^^58^662^23
 ;;^UTILITY(U,$J,358.3,15398,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15398,1,3,0)
 ;;=3^Major Neurocognitive Disorder d/t Alzheimer's Disease,Possible
 ;;^UTILITY(U,$J,358.3,15398,1,4,0)
 ;;=4^G31.9
 ;;^UTILITY(U,$J,358.3,15398,2)
 ;;=^5003815
 ;;^UTILITY(U,$J,358.3,15399,0)
 ;;=G31.01^^58^662^30
 ;;^UTILITY(U,$J,358.3,15399,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15399,1,3,0)
 ;;=3^Pick's Disease
 ;;^UTILITY(U,$J,358.3,15399,1,4,0)
 ;;=4^G31.01
 ;;^UTILITY(U,$J,358.3,15399,2)
 ;;=^329915
 ;;^UTILITY(U,$J,358.3,15400,0)
 ;;=G31.1^^58^662^36
 ;;^UTILITY(U,$J,358.3,15400,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15400,1,3,0)
 ;;=3^Senile Degeneration of the Brain NOS
 ;;^UTILITY(U,$J,358.3,15400,1,4,0)
 ;;=4^G31.1
 ;;^UTILITY(U,$J,358.3,15400,2)
 ;;=^5003809
 ;;^UTILITY(U,$J,358.3,15401,0)
 ;;=G94.^^58^662^7
 ;;^UTILITY(U,$J,358.3,15401,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15401,1,3,0)
 ;;=3^Brain Disorders in Diseases Classified Elsewhere NEC
 ;;^UTILITY(U,$J,358.3,15401,1,4,0)
 ;;=4^G94.
 ;;^UTILITY(U,$J,358.3,15401,2)
 ;;=^5004187
 ;;^UTILITY(U,$J,358.3,15402,0)
 ;;=G31.83^^58^662^16
 ;;^UTILITY(U,$J,358.3,15402,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15402,1,3,0)
 ;;=3^Dementia w/ Lewy Bodies
 ;;^UTILITY(U,$J,358.3,15402,1,4,0)
 ;;=4^G31.83
 ;;^UTILITY(U,$J,358.3,15402,2)
 ;;=^329888
 ;;^UTILITY(U,$J,358.3,15403,0)
 ;;=G31.89^^58^662^11
 ;;^UTILITY(U,$J,358.3,15403,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15403,1,3,0)
 ;;=3^Degenerative Diseases of Nervous System NEC
 ;;^UTILITY(U,$J,358.3,15403,1,4,0)
 ;;=4^G31.89
 ;;^UTILITY(U,$J,358.3,15403,2)
 ;;=^5003814
 ;;^UTILITY(U,$J,358.3,15404,0)
 ;;=G31.9^^58^662^12
 ;;^UTILITY(U,$J,358.3,15404,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15404,1,3,0)
 ;;=3^Degenerative Diseases of Nervous System,Unspec
 ;;^UTILITY(U,$J,358.3,15404,1,4,0)
 ;;=4^G31.9
 ;;^UTILITY(U,$J,358.3,15404,2)
 ;;=^5003815
 ;;^UTILITY(U,$J,358.3,15405,0)
 ;;=G23.8^^58^662^10
 ;;^UTILITY(U,$J,358.3,15405,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15405,1,3,0)
 ;;=3^Degenerative Diseases of Basal Ganglia NEC
 ;;^UTILITY(U,$J,358.3,15405,1,4,0)
 ;;=4^G23.8
 ;;^UTILITY(U,$J,358.3,15405,2)
 ;;=^5003782
 ;;^UTILITY(U,$J,358.3,15406,0)
 ;;=G31.09^^58^662^22
 ;;^UTILITY(U,$J,358.3,15406,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15406,1,3,0)
 ;;=3^Major Frontotemporal Neurocognitive Disorder w/ Behavioral Disturbance
 ;;^UTILITY(U,$J,358.3,15406,1,4,0)
 ;;=4^G31.09
 ;;^UTILITY(U,$J,358.3,15406,2)
 ;;=^329916^F02.81
 ;;^UTILITY(U,$J,358.3,15407,0)
 ;;=G30.0^^58^662^3
 ;;^UTILITY(U,$J,358.3,15407,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15407,1,3,0)
 ;;=3^Alzheimer's Disease w/ Early Onset
 ;;^UTILITY(U,$J,358.3,15407,1,4,0)
 ;;=4^G30.0
 ;;^UTILITY(U,$J,358.3,15407,2)
 ;;=^5003805
 ;;^UTILITY(U,$J,358.3,15408,0)
 ;;=G30.1^^58^662^4
 ;;^UTILITY(U,$J,358.3,15408,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15408,1,3,0)
 ;;=3^Alzheimer's Disease with Late Onset
 ;;^UTILITY(U,$J,358.3,15408,1,4,0)
 ;;=4^G30.1
