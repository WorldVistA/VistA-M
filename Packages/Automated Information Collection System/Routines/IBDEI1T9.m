IBDEI1T9 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,30765,2)
 ;;=^5003095
 ;;^UTILITY(U,$J,358.3,30766,0)
 ;;=F19.97^^123^1533^37
 ;;^UTILITY(U,$J,358.3,30766,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30766,1,3,0)
 ;;=3^Substance-Induced Major Neurocognitive Disorder NEC
 ;;^UTILITY(U,$J,358.3,30766,1,4,0)
 ;;=4^F19.97
 ;;^UTILITY(U,$J,358.3,30766,2)
 ;;=^5003465
 ;;^UTILITY(U,$J,358.3,30767,0)
 ;;=F02.80^^123^1533^13
 ;;^UTILITY(U,$J,358.3,30767,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30767,1,3,0)
 ;;=3^Dementia in Oth Diseases Classified Elsewhere w/o Behavorial Disturbance
 ;;^UTILITY(U,$J,358.3,30767,1,4,0)
 ;;=4^F02.80
 ;;^UTILITY(U,$J,358.3,30767,2)
 ;;=^5003048
 ;;^UTILITY(U,$J,358.3,30768,0)
 ;;=F02.81^^123^1533^14
 ;;^UTILITY(U,$J,358.3,30768,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30768,1,3,0)
 ;;=3^Dementia in Oth Diseases Classified Elsewhere w/ Behavioral Disturbance
 ;;^UTILITY(U,$J,358.3,30768,1,4,0)
 ;;=4^F02.81
 ;;^UTILITY(U,$J,358.3,30768,2)
 ;;=^5003049
 ;;^UTILITY(U,$J,358.3,30769,0)
 ;;=F06.8^^123^1533^24
 ;;^UTILITY(U,$J,358.3,30769,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30769,1,3,0)
 ;;=3^Mental Disorder d/t Another Medical Condition NEC
 ;;^UTILITY(U,$J,358.3,30769,1,4,0)
 ;;=4^F06.8
 ;;^UTILITY(U,$J,358.3,30769,2)
 ;;=^5003062
 ;;^UTILITY(U,$J,358.3,30770,0)
 ;;=G30.9^^123^1533^5
 ;;^UTILITY(U,$J,358.3,30770,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30770,1,3,0)
 ;;=3^Alzheimer's Disease,Unspec
 ;;^UTILITY(U,$J,358.3,30770,1,4,0)
 ;;=4^G30.9
 ;;^UTILITY(U,$J,358.3,30770,2)
 ;;=^5003808
 ;;^UTILITY(U,$J,358.3,30771,0)
 ;;=G31.9^^123^1533^23
 ;;^UTILITY(U,$J,358.3,30771,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30771,1,3,0)
 ;;=3^Major Neurocognitive Disorder d/t Alzheimer's Disease,Possible
 ;;^UTILITY(U,$J,358.3,30771,1,4,0)
 ;;=4^G31.9
 ;;^UTILITY(U,$J,358.3,30771,2)
 ;;=^5003815
 ;;^UTILITY(U,$J,358.3,30772,0)
 ;;=G31.01^^123^1533^30
 ;;^UTILITY(U,$J,358.3,30772,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30772,1,3,0)
 ;;=3^Pick's Disease
 ;;^UTILITY(U,$J,358.3,30772,1,4,0)
 ;;=4^G31.01
 ;;^UTILITY(U,$J,358.3,30772,2)
 ;;=^329915
 ;;^UTILITY(U,$J,358.3,30773,0)
 ;;=G31.1^^123^1533^36
 ;;^UTILITY(U,$J,358.3,30773,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30773,1,3,0)
 ;;=3^Senile Degeneration of the Brain NOS
 ;;^UTILITY(U,$J,358.3,30773,1,4,0)
 ;;=4^G31.1
 ;;^UTILITY(U,$J,358.3,30773,2)
 ;;=^5003809
 ;;^UTILITY(U,$J,358.3,30774,0)
 ;;=G94.^^123^1533^7
 ;;^UTILITY(U,$J,358.3,30774,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30774,1,3,0)
 ;;=3^Brain Disorders in Diseases Classified Elsewhere NEC
 ;;^UTILITY(U,$J,358.3,30774,1,4,0)
 ;;=4^G94.
 ;;^UTILITY(U,$J,358.3,30774,2)
 ;;=^5004187
 ;;^UTILITY(U,$J,358.3,30775,0)
 ;;=G31.83^^123^1533^16
 ;;^UTILITY(U,$J,358.3,30775,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30775,1,3,0)
 ;;=3^Dementia w/ Lewy Bodies
 ;;^UTILITY(U,$J,358.3,30775,1,4,0)
 ;;=4^G31.83
 ;;^UTILITY(U,$J,358.3,30775,2)
 ;;=^329888
 ;;^UTILITY(U,$J,358.3,30776,0)
 ;;=G31.89^^123^1533^11
 ;;^UTILITY(U,$J,358.3,30776,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30776,1,3,0)
 ;;=3^Degenerative Diseases of Nervous System NEC
 ;;^UTILITY(U,$J,358.3,30776,1,4,0)
 ;;=4^G31.89
 ;;^UTILITY(U,$J,358.3,30776,2)
 ;;=^5003814
 ;;^UTILITY(U,$J,358.3,30777,0)
 ;;=G31.9^^123^1533^12
 ;;^UTILITY(U,$J,358.3,30777,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30777,1,3,0)
 ;;=3^Degenerative Diseases of Nervous System,Unspec
 ;;^UTILITY(U,$J,358.3,30777,1,4,0)
 ;;=4^G31.9
 ;;^UTILITY(U,$J,358.3,30777,2)
 ;;=^5003815
 ;;^UTILITY(U,$J,358.3,30778,0)
 ;;=G23.8^^123^1533^10
