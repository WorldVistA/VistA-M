IBDEI28Q ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,38013,0)
 ;;=G31.1^^145^1832^36
 ;;^UTILITY(U,$J,358.3,38013,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38013,1,3,0)
 ;;=3^Senile Degeneration of the Brain NOS
 ;;^UTILITY(U,$J,358.3,38013,1,4,0)
 ;;=4^G31.1
 ;;^UTILITY(U,$J,358.3,38013,2)
 ;;=^5003809
 ;;^UTILITY(U,$J,358.3,38014,0)
 ;;=G94.^^145^1832^7
 ;;^UTILITY(U,$J,358.3,38014,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38014,1,3,0)
 ;;=3^Brain Disorders in Diseases Classified Elsewhere NEC
 ;;^UTILITY(U,$J,358.3,38014,1,4,0)
 ;;=4^G94.
 ;;^UTILITY(U,$J,358.3,38014,2)
 ;;=^5004187
 ;;^UTILITY(U,$J,358.3,38015,0)
 ;;=G31.83^^145^1832^16
 ;;^UTILITY(U,$J,358.3,38015,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38015,1,3,0)
 ;;=3^Dementia w/ Lewy Bodies
 ;;^UTILITY(U,$J,358.3,38015,1,4,0)
 ;;=4^G31.83
 ;;^UTILITY(U,$J,358.3,38015,2)
 ;;=^329888
 ;;^UTILITY(U,$J,358.3,38016,0)
 ;;=G31.89^^145^1832^11
 ;;^UTILITY(U,$J,358.3,38016,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38016,1,3,0)
 ;;=3^Degenerative Diseases of Nervous System NEC
 ;;^UTILITY(U,$J,358.3,38016,1,4,0)
 ;;=4^G31.89
 ;;^UTILITY(U,$J,358.3,38016,2)
 ;;=^5003814
 ;;^UTILITY(U,$J,358.3,38017,0)
 ;;=G31.9^^145^1832^12
 ;;^UTILITY(U,$J,358.3,38017,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38017,1,3,0)
 ;;=3^Degenerative Diseases of Nervous System,Unspec
 ;;^UTILITY(U,$J,358.3,38017,1,4,0)
 ;;=4^G31.9
 ;;^UTILITY(U,$J,358.3,38017,2)
 ;;=^5003815
 ;;^UTILITY(U,$J,358.3,38018,0)
 ;;=G23.8^^145^1832^10
 ;;^UTILITY(U,$J,358.3,38018,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38018,1,3,0)
 ;;=3^Degenerative Diseases of Basal Ganglia NEC
 ;;^UTILITY(U,$J,358.3,38018,1,4,0)
 ;;=4^G23.8
 ;;^UTILITY(U,$J,358.3,38018,2)
 ;;=^5003782
 ;;^UTILITY(U,$J,358.3,38019,0)
 ;;=G31.09^^145^1832^22
 ;;^UTILITY(U,$J,358.3,38019,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38019,1,3,0)
 ;;=3^Major Frontotemporal Neurocognitive Disorder w/ Behavioral Disturbance
 ;;^UTILITY(U,$J,358.3,38019,1,4,0)
 ;;=4^G31.09
 ;;^UTILITY(U,$J,358.3,38019,2)
 ;;=^329916^F02.81
 ;;^UTILITY(U,$J,358.3,38020,0)
 ;;=G30.0^^145^1832^3
 ;;^UTILITY(U,$J,358.3,38020,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38020,1,3,0)
 ;;=3^Alzheimer's Disease w/ Early Onset
 ;;^UTILITY(U,$J,358.3,38020,1,4,0)
 ;;=4^G30.0
 ;;^UTILITY(U,$J,358.3,38020,2)
 ;;=^5003805
 ;;^UTILITY(U,$J,358.3,38021,0)
 ;;=G30.1^^145^1832^4
 ;;^UTILITY(U,$J,358.3,38021,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38021,1,3,0)
 ;;=3^Alzheimer's Disease with Late Onset
 ;;^UTILITY(U,$J,358.3,38021,1,4,0)
 ;;=4^G30.1
 ;;^UTILITY(U,$J,358.3,38021,2)
 ;;=^5003806
 ;;^UTILITY(U,$J,358.3,38022,0)
 ;;=B20.^^145^1832^18
 ;;^UTILITY(U,$J,358.3,38022,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38022,1,3,0)
 ;;=3^HIV Disease w/ Dementia w/ Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,38022,1,4,0)
 ;;=4^B20.
 ;;^UTILITY(U,$J,358.3,38022,2)
 ;;=^5000555^F02.81
 ;;^UTILITY(U,$J,358.3,38023,0)
 ;;=B20.^^145^1832^19
 ;;^UTILITY(U,$J,358.3,38023,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38023,1,3,0)
 ;;=3^HIV Disease w/ Dementia w/o Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,38023,1,4,0)
 ;;=4^B20.
 ;;^UTILITY(U,$J,358.3,38023,2)
 ;;=^5000555^F02.80
 ;;^UTILITY(U,$J,358.3,38024,0)
 ;;=G10.^^145^1832^20
 ;;^UTILITY(U,$J,358.3,38024,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38024,1,3,0)
 ;;=3^Huntington's Disease w/ Dementia w/ Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,38024,1,4,0)
 ;;=4^G10.
 ;;^UTILITY(U,$J,358.3,38024,2)
 ;;=^5003751^F02.81
 ;;^UTILITY(U,$J,358.3,38025,0)
 ;;=G10.^^145^1832^21
 ;;^UTILITY(U,$J,358.3,38025,1,0)
 ;;=^358.31IA^4^2
