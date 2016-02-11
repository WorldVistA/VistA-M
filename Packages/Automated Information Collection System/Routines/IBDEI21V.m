IBDEI21V ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,34367,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34367,1,3,0)
 ;;=3^Alcohol Dependence w/ Alcohol-Induced Persisting Dementia
 ;;^UTILITY(U,$J,358.3,34367,1,4,0)
 ;;=4^F10.27
 ;;^UTILITY(U,$J,358.3,34367,2)
 ;;=^5003095
 ;;^UTILITY(U,$J,358.3,34368,0)
 ;;=F02.81^^157^1746^14
 ;;^UTILITY(U,$J,358.3,34368,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34368,1,3,0)
 ;;=3^Dementia in Oth Diseases Classd Elswhr w/ Behavioral Disturb
 ;;^UTILITY(U,$J,358.3,34368,1,4,0)
 ;;=4^F02.81
 ;;^UTILITY(U,$J,358.3,34368,2)
 ;;=^5003049
 ;;^UTILITY(U,$J,358.3,34369,0)
 ;;=F02.80^^157^1746^15
 ;;^UTILITY(U,$J,358.3,34369,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34369,1,3,0)
 ;;=3^Dementia in Oth Diseases Classd Elswhr w/o Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,34369,1,4,0)
 ;;=4^F02.80
 ;;^UTILITY(U,$J,358.3,34369,2)
 ;;=^5003048
 ;;^UTILITY(U,$J,358.3,34370,0)
 ;;=F19.97^^157^1746^35
 ;;^UTILITY(U,$J,358.3,34370,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34370,1,3,0)
 ;;=3^Psychoactive Substance Use w/ Persisting Dementia NEC
 ;;^UTILITY(U,$J,358.3,34370,1,4,0)
 ;;=4^F19.97
 ;;^UTILITY(U,$J,358.3,34370,2)
 ;;=^5003465
 ;;^UTILITY(U,$J,358.3,34371,0)
 ;;=F01.51^^157^1746^37
 ;;^UTILITY(U,$J,358.3,34371,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34371,1,3,0)
 ;;=3^Vascular Dementia w/ Behavioral Disturbance
 ;;^UTILITY(U,$J,358.3,34371,1,4,0)
 ;;=4^F01.51
 ;;^UTILITY(U,$J,358.3,34371,2)
 ;;=^5003047
 ;;^UTILITY(U,$J,358.3,34372,0)
 ;;=G10.^^157^1746^24
 ;;^UTILITY(U,$J,358.3,34372,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34372,1,3,0)
 ;;=3^Huntington's Disease w/ Dementia w/ Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,34372,1,4,0)
 ;;=4^G10.
 ;;^UTILITY(U,$J,358.3,34372,2)
 ;;=^5003751^F02.81
 ;;^UTILITY(U,$J,358.3,34373,0)
 ;;=G10.^^157^1746^25
 ;;^UTILITY(U,$J,358.3,34373,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34373,1,3,0)
 ;;=3^Huntington's Disease w/ Dementia w/o Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,34373,1,4,0)
 ;;=4^G10.
 ;;^UTILITY(U,$J,358.3,34373,2)
 ;;=^5003751^F02.80
 ;;^UTILITY(U,$J,358.3,34374,0)
 ;;=G90.3^^157^1746^27
 ;;^UTILITY(U,$J,358.3,34374,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34374,1,3,0)
 ;;=3^Multi-System Degeneration of the Autonomic Nervous System
 ;;^UTILITY(U,$J,358.3,34374,1,4,0)
 ;;=4^G90.3
 ;;^UTILITY(U,$J,358.3,34374,2)
 ;;=^5004162
 ;;^UTILITY(U,$J,358.3,34375,0)
 ;;=G91.2^^157^1746^28
 ;;^UTILITY(U,$J,358.3,34375,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34375,1,3,0)
 ;;=3^NPH w/ Dementia w/ Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,34375,1,4,0)
 ;;=4^G91.2
 ;;^UTILITY(U,$J,358.3,34375,2)
 ;;=^5004174^F02.81
 ;;^UTILITY(U,$J,358.3,34376,0)
 ;;=G91.2^^157^1746^29
 ;;^UTILITY(U,$J,358.3,34376,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34376,1,3,0)
 ;;=3^NPH w/ Dementia w/o Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,34376,1,4,0)
 ;;=4^G91.2
 ;;^UTILITY(U,$J,358.3,34376,2)
 ;;=^5004174^F02.80
 ;;^UTILITY(U,$J,358.3,34377,0)
 ;;=G30.8^^157^1746^2
 ;;^UTILITY(U,$J,358.3,34377,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34377,1,3,0)
 ;;=3^Alzheimer's Disease NEC
 ;;^UTILITY(U,$J,358.3,34377,1,4,0)
 ;;=4^G30.8
 ;;^UTILITY(U,$J,358.3,34377,2)
 ;;=^5003807
 ;;^UTILITY(U,$J,358.3,34378,0)
 ;;=G31.09^^157^1746^19
 ;;^UTILITY(U,$J,358.3,34378,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34378,1,3,0)
 ;;=3^Frontotemporal Dementia NEC
 ;;^UTILITY(U,$J,358.3,34378,1,4,0)
 ;;=4^G31.09
 ;;^UTILITY(U,$J,358.3,34378,2)
 ;;=^329916
 ;;^UTILITY(U,$J,358.3,34379,0)
 ;;=G20.^^157^1746^30
 ;;^UTILITY(U,$J,358.3,34379,1,0)
 ;;=^358.31IA^4^2
