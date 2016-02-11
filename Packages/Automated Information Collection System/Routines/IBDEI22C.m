IBDEI22C ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,34596,1,4,0)
 ;;=4^G00.9
 ;;^UTILITY(U,$J,358.3,34596,2)
 ;;=^5003724
 ;;^UTILITY(U,$J,358.3,34597,0)
 ;;=A87.9^^160^1761^71
 ;;^UTILITY(U,$J,358.3,34597,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34597,1,3,0)
 ;;=3^Viral meningitis, unspecified
 ;;^UTILITY(U,$J,358.3,34597,1,4,0)
 ;;=4^A87.9
 ;;^UTILITY(U,$J,358.3,34597,2)
 ;;=^5000435
 ;;^UTILITY(U,$J,358.3,34598,0)
 ;;=G96.0^^160^1761^7
 ;;^UTILITY(U,$J,358.3,34598,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34598,1,3,0)
 ;;=3^Cerebrospinal fluid leak
 ;;^UTILITY(U,$J,358.3,34598,1,4,0)
 ;;=4^G96.0
 ;;^UTILITY(U,$J,358.3,34598,2)
 ;;=^5004195
 ;;^UTILITY(U,$J,358.3,34599,0)
 ;;=G20.^^160^1761^34
 ;;^UTILITY(U,$J,358.3,34599,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34599,1,3,0)
 ;;=3^Parkinson's disease
 ;;^UTILITY(U,$J,358.3,34599,1,4,0)
 ;;=4^G20.
 ;;^UTILITY(U,$J,358.3,34599,2)
 ;;=^5003770
 ;;^UTILITY(U,$J,358.3,34600,0)
 ;;=I62.00^^160^1761^26
 ;;^UTILITY(U,$J,358.3,34600,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34600,1,3,0)
 ;;=3^Nontraumatic subdural hemorrhage, unspecified
 ;;^UTILITY(U,$J,358.3,34600,1,4,0)
 ;;=4^I62.00
 ;;^UTILITY(U,$J,358.3,34600,2)
 ;;=^5007289
 ;;^UTILITY(U,$J,358.3,34601,0)
 ;;=I60.9^^160^1761^25
 ;;^UTILITY(U,$J,358.3,34601,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34601,1,3,0)
 ;;=3^Nontraumatic subarachnoid hemorrhage, unspecified
 ;;^UTILITY(U,$J,358.3,34601,1,4,0)
 ;;=4^I60.9
 ;;^UTILITY(U,$J,358.3,34601,2)
 ;;=^5007279
 ;;^UTILITY(U,$J,358.3,34602,0)
 ;;=G45.9^^160^1761^37
 ;;^UTILITY(U,$J,358.3,34602,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34602,1,3,0)
 ;;=3^Transient cerebral ischemic attack, unspecified
 ;;^UTILITY(U,$J,358.3,34602,1,4,0)
 ;;=4^G45.9
 ;;^UTILITY(U,$J,358.3,34602,2)
 ;;=^5003959
 ;;^UTILITY(U,$J,358.3,34603,0)
 ;;=G50.0^^160^1761^68
 ;;^UTILITY(U,$J,358.3,34603,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34603,1,3,0)
 ;;=3^Trigeminal neuralgia
 ;;^UTILITY(U,$J,358.3,34603,1,4,0)
 ;;=4^G50.0
 ;;^UTILITY(U,$J,358.3,34603,2)
 ;;=^121978
 ;;^UTILITY(U,$J,358.3,34604,0)
 ;;=G45.0^^160^1761^70
 ;;^UTILITY(U,$J,358.3,34604,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34604,1,3,0)
 ;;=3^Vertebro-basilar artery syndrome
 ;;^UTILITY(U,$J,358.3,34604,1,4,0)
 ;;=4^G45.0
 ;;^UTILITY(U,$J,358.3,34604,2)
 ;;=^5003955
 ;;^UTILITY(U,$J,358.3,34605,0)
 ;;=G91.9^^160^1761^13
 ;;^UTILITY(U,$J,358.3,34605,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34605,1,3,0)
 ;;=3^Hydrocephalus, unspecified
 ;;^UTILITY(U,$J,358.3,34605,1,4,0)
 ;;=4^G91.9
 ;;^UTILITY(U,$J,358.3,34605,2)
 ;;=^5004178
 ;;^UTILITY(U,$J,358.3,34606,0)
 ;;=G93.6^^160^1761^6
 ;;^UTILITY(U,$J,358.3,34606,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34606,1,3,0)
 ;;=3^Cerebral edema
 ;;^UTILITY(U,$J,358.3,34606,1,4,0)
 ;;=4^G93.6
 ;;^UTILITY(U,$J,358.3,34606,2)
 ;;=^5004183
 ;;^UTILITY(U,$J,358.3,34607,0)
 ;;=I97.810^^160^1761^17
 ;;^UTILITY(U,$J,358.3,34607,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34607,1,3,0)
 ;;=3^Intraoperative cerebvasc infarction during cardiac surgery
 ;;^UTILITY(U,$J,358.3,34607,1,4,0)
 ;;=4^I97.810
 ;;^UTILITY(U,$J,358.3,34607,2)
 ;;=^5008107
 ;;^UTILITY(U,$J,358.3,34608,0)
 ;;=I97.811^^160^1761^16
 ;;^UTILITY(U,$J,358.3,34608,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34608,1,3,0)
 ;;=3^Intraoperative cerebrovascular infarction during oth surgery
 ;;^UTILITY(U,$J,358.3,34608,1,4,0)
 ;;=4^I97.811
 ;;^UTILITY(U,$J,358.3,34608,2)
 ;;=^5008108
 ;;^UTILITY(U,$J,358.3,34609,0)
 ;;=I97.820^^160^1761^36
 ;;^UTILITY(U,$J,358.3,34609,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34609,1,3,0)
 ;;=3^Postprocedural cerebvasc infarction during cardiac surgery
