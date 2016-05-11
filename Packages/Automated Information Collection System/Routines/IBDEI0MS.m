IBDEI0MS ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,10629,1,4,0)
 ;;=4^A81.01
 ;;^UTILITY(U,$J,358.3,10629,2)
 ;;=^336701
 ;;^UTILITY(U,$J,358.3,10630,0)
 ;;=G31.9^^47^518^28
 ;;^UTILITY(U,$J,358.3,10630,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10630,1,3,0)
 ;;=3^Dementia,Degenerative Disease Nervous System,Unspec
 ;;^UTILITY(U,$J,358.3,10630,1,4,0)
 ;;=4^G31.9
 ;;^UTILITY(U,$J,358.3,10630,2)
 ;;=^5003815
 ;;^UTILITY(U,$J,358.3,10631,0)
 ;;=G10.^^47^518^45
 ;;^UTILITY(U,$J,358.3,10631,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10631,1,3,0)
 ;;=3^Huntington's Disease w/ Dementia w/o Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,10631,1,4,0)
 ;;=4^G10.
 ;;^UTILITY(U,$J,358.3,10631,2)
 ;;=^5003751^F02.80
 ;;^UTILITY(U,$J,358.3,10632,0)
 ;;=G94.^^47^518^24
 ;;^UTILITY(U,$J,358.3,10632,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10632,1,3,0)
 ;;=3^Dementia,Brain Disorder in Diseases Classified Elsewhere
 ;;^UTILITY(U,$J,358.3,10632,1,4,0)
 ;;=4^G94.
 ;;^UTILITY(U,$J,358.3,10632,2)
 ;;=^5004187
 ;;^UTILITY(U,$J,358.3,10633,0)
 ;;=G31.09^^47^518^29
 ;;^UTILITY(U,$J,358.3,10633,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10633,1,3,0)
 ;;=3^Dementia,Frontotemporal,Other
 ;;^UTILITY(U,$J,358.3,10633,1,4,0)
 ;;=4^G31.09
 ;;^UTILITY(U,$J,358.3,10633,2)
 ;;=^329916
 ;;^UTILITY(U,$J,358.3,10634,0)
 ;;=G23.8^^47^518^23
 ;;^UTILITY(U,$J,358.3,10634,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10634,1,3,0)
 ;;=3^Dementia,Basal Ganglia Degenerative Diseases
 ;;^UTILITY(U,$J,358.3,10634,1,4,0)
 ;;=4^G23.8
 ;;^UTILITY(U,$J,358.3,10634,2)
 ;;=^5003782
 ;;^UTILITY(U,$J,358.3,10635,0)
 ;;=G31.89^^47^518^31
 ;;^UTILITY(U,$J,358.3,10635,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10635,1,3,0)
 ;;=3^Dementia,Nervous System Degenerative Diseases
 ;;^UTILITY(U,$J,358.3,10635,1,4,0)
 ;;=4^G31.89
 ;;^UTILITY(U,$J,358.3,10635,2)
 ;;=^5003814
 ;;^UTILITY(U,$J,358.3,10636,0)
 ;;=F06.8^^47^518^30
 ;;^UTILITY(U,$J,358.3,10636,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10636,1,3,0)
 ;;=3^Dementia,Mental Disorders d/t Physiological Condition
 ;;^UTILITY(U,$J,358.3,10636,1,4,0)
 ;;=4^F06.8
 ;;^UTILITY(U,$J,358.3,10636,2)
 ;;=^5003062
 ;;^UTILITY(U,$J,358.3,10637,0)
 ;;=F10.27^^47^518^32
 ;;^UTILITY(U,$J,358.3,10637,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10637,1,3,0)
 ;;=3^Dementia,Persisting,Alcohol-Induced
 ;;^UTILITY(U,$J,358.3,10637,1,4,0)
 ;;=4^F10.27
 ;;^UTILITY(U,$J,358.3,10637,2)
 ;;=^5003095
 ;;^UTILITY(U,$J,358.3,10638,0)
 ;;=F19.97^^47^518^33
 ;;^UTILITY(U,$J,358.3,10638,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10638,1,3,0)
 ;;=3^Dementia,Persisting,Psychoactive Subst Use
 ;;^UTILITY(U,$J,358.3,10638,1,4,0)
 ;;=4^F19.97
 ;;^UTILITY(U,$J,358.3,10638,2)
 ;;=^5003465
 ;;^UTILITY(U,$J,358.3,10639,0)
 ;;=G31.01^^47^518^34
 ;;^UTILITY(U,$J,358.3,10639,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10639,1,3,0)
 ;;=3^Dementia,Pick's Disease
 ;;^UTILITY(U,$J,358.3,10639,1,4,0)
 ;;=4^G31.01
 ;;^UTILITY(U,$J,358.3,10639,2)
 ;;=^329915
 ;;^UTILITY(U,$J,358.3,10640,0)
 ;;=A81.2^^47^518^35
 ;;^UTILITY(U,$J,358.3,10640,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10640,1,3,0)
 ;;=3^Dementia,Progressive Multifocal Leukoencephalopathy
 ;;^UTILITY(U,$J,358.3,10640,1,4,0)
 ;;=4^A81.2
 ;;^UTILITY(U,$J,358.3,10640,2)
 ;;=^5000411
 ;;^UTILITY(U,$J,358.3,10641,0)
 ;;=G31.1^^47^518^36
 ;;^UTILITY(U,$J,358.3,10641,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10641,1,3,0)
 ;;=3^Dementia,Senile Degeneration of Brain NEC
 ;;^UTILITY(U,$J,358.3,10641,1,4,0)
 ;;=4^G31.1
 ;;^UTILITY(U,$J,358.3,10641,2)
 ;;=^5003809
 ;;^UTILITY(U,$J,358.3,10642,0)
 ;;=F03.90^^47^518^21
