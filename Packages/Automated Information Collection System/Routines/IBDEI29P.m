IBDEI29P ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,38083,0)
 ;;=F01.51^^177^1918^32
 ;;^UTILITY(U,$J,358.3,38083,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38083,1,3,0)
 ;;=3^Probable Major Vascular Neurocognitive Disorder w/ Behavioral Disturbance
 ;;^UTILITY(U,$J,358.3,38083,1,4,0)
 ;;=4^F01.51
 ;;^UTILITY(U,$J,358.3,38083,2)
 ;;=^5003047
 ;;^UTILITY(U,$J,358.3,38084,0)
 ;;=F10.27^^177^1918^1
 ;;^UTILITY(U,$J,358.3,38084,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38084,1,3,0)
 ;;=3^Alcohol-Induced Major Neurocognitive Disorder,Nonamnestic Confabulatory Type
 ;;^UTILITY(U,$J,358.3,38084,1,4,0)
 ;;=4^F10.27
 ;;^UTILITY(U,$J,358.3,38084,2)
 ;;=^5003095
 ;;^UTILITY(U,$J,358.3,38085,0)
 ;;=F19.97^^177^1918^37
 ;;^UTILITY(U,$J,358.3,38085,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38085,1,3,0)
 ;;=3^Substance-Induced Major Neurocognitive Disorder NEC
 ;;^UTILITY(U,$J,358.3,38085,1,4,0)
 ;;=4^F19.97
 ;;^UTILITY(U,$J,358.3,38085,2)
 ;;=^5003465
 ;;^UTILITY(U,$J,358.3,38086,0)
 ;;=F02.80^^177^1918^13
 ;;^UTILITY(U,$J,358.3,38086,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38086,1,3,0)
 ;;=3^Dementia in Oth Diseases Classified Elsewhere w/o Behavorial Disturbance
 ;;^UTILITY(U,$J,358.3,38086,1,4,0)
 ;;=4^F02.80
 ;;^UTILITY(U,$J,358.3,38086,2)
 ;;=^5003048
 ;;^UTILITY(U,$J,358.3,38087,0)
 ;;=F02.81^^177^1918^14
 ;;^UTILITY(U,$J,358.3,38087,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38087,1,3,0)
 ;;=3^Dementia in Oth Diseases Classified Elsewhere w/ Behavioral Disturbance
 ;;^UTILITY(U,$J,358.3,38087,1,4,0)
 ;;=4^F02.81
 ;;^UTILITY(U,$J,358.3,38087,2)
 ;;=^5003049
 ;;^UTILITY(U,$J,358.3,38088,0)
 ;;=F06.8^^177^1918^24
 ;;^UTILITY(U,$J,358.3,38088,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38088,1,3,0)
 ;;=3^Mental Disorder d/t Another Medical Condition NEC
 ;;^UTILITY(U,$J,358.3,38088,1,4,0)
 ;;=4^F06.8
 ;;^UTILITY(U,$J,358.3,38088,2)
 ;;=^5003062
 ;;^UTILITY(U,$J,358.3,38089,0)
 ;;=G30.9^^177^1918^5
 ;;^UTILITY(U,$J,358.3,38089,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38089,1,3,0)
 ;;=3^Alzheimer's Disease,Unspec
 ;;^UTILITY(U,$J,358.3,38089,1,4,0)
 ;;=4^G30.9
 ;;^UTILITY(U,$J,358.3,38089,2)
 ;;=^5003808
 ;;^UTILITY(U,$J,358.3,38090,0)
 ;;=G31.9^^177^1918^23
 ;;^UTILITY(U,$J,358.3,38090,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38090,1,3,0)
 ;;=3^Major Neurocognitive Disorder d/t Alzheimer's Disease,Possible
 ;;^UTILITY(U,$J,358.3,38090,1,4,0)
 ;;=4^G31.9
 ;;^UTILITY(U,$J,358.3,38090,2)
 ;;=^5003815
 ;;^UTILITY(U,$J,358.3,38091,0)
 ;;=G31.01^^177^1918^30
 ;;^UTILITY(U,$J,358.3,38091,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38091,1,3,0)
 ;;=3^Pick's Disease
 ;;^UTILITY(U,$J,358.3,38091,1,4,0)
 ;;=4^G31.01
 ;;^UTILITY(U,$J,358.3,38091,2)
 ;;=^329915
 ;;^UTILITY(U,$J,358.3,38092,0)
 ;;=G31.1^^177^1918^36
 ;;^UTILITY(U,$J,358.3,38092,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38092,1,3,0)
 ;;=3^Senile Degeneration of the Brain NOS
 ;;^UTILITY(U,$J,358.3,38092,1,4,0)
 ;;=4^G31.1
 ;;^UTILITY(U,$J,358.3,38092,2)
 ;;=^5003809
 ;;^UTILITY(U,$J,358.3,38093,0)
 ;;=G94.^^177^1918^7
 ;;^UTILITY(U,$J,358.3,38093,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38093,1,3,0)
 ;;=3^Brain Disorders in Diseases Classified Elsewhere NEC
 ;;^UTILITY(U,$J,358.3,38093,1,4,0)
 ;;=4^G94.
 ;;^UTILITY(U,$J,358.3,38093,2)
 ;;=^5004187
 ;;^UTILITY(U,$J,358.3,38094,0)
 ;;=G31.83^^177^1918^16
 ;;^UTILITY(U,$J,358.3,38094,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38094,1,3,0)
 ;;=3^Dementia w/ Lewy Bodies
 ;;^UTILITY(U,$J,358.3,38094,1,4,0)
 ;;=4^G31.83
 ;;^UTILITY(U,$J,358.3,38094,2)
 ;;=^329888
 ;;^UTILITY(U,$J,358.3,38095,0)
 ;;=G31.89^^177^1918^11
