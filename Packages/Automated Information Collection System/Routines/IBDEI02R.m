IBDEI02R ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,826,1,3,0)
 ;;=3^Acrodermatitis Continua
 ;;^UTILITY(U,$J,358.3,826,1,4,0)
 ;;=4^L40.2
 ;;^UTILITY(U,$J,358.3,826,2)
 ;;=^5009162
 ;;^UTILITY(U,$J,358.3,827,0)
 ;;=R10.9^^6^97^3
 ;;^UTILITY(U,$J,358.3,827,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,827,1,3,0)
 ;;=3^Abdominal Pain,Unspec
 ;;^UTILITY(U,$J,358.3,827,1,4,0)
 ;;=4^R10.9
 ;;^UTILITY(U,$J,358.3,827,2)
 ;;=^5019230
 ;;^UTILITY(U,$J,358.3,828,0)
 ;;=F10.10^^6^97^8
 ;;^UTILITY(U,$J,358.3,828,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,828,1,3,0)
 ;;=3^Alcohol Abuse Uncomplicated
 ;;^UTILITY(U,$J,358.3,828,1,4,0)
 ;;=4^F10.10
 ;;^UTILITY(U,$J,358.3,828,2)
 ;;=^5003068
 ;;^UTILITY(U,$J,358.3,829,0)
 ;;=F43.0^^6^97^7
 ;;^UTILITY(U,$J,358.3,829,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,829,1,3,0)
 ;;=3^Acute Stress Reaction
 ;;^UTILITY(U,$J,358.3,829,1,4,0)
 ;;=4^F43.0
 ;;^UTILITY(U,$J,358.3,829,2)
 ;;=^5003569
 ;;^UTILITY(U,$J,358.3,830,0)
 ;;=Z89.511^^6^97^5
 ;;^UTILITY(U,$J,358.3,830,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,830,1,3,0)
 ;;=3^Acquired Absence Right Leg Below Knee
 ;;^UTILITY(U,$J,358.3,830,1,4,0)
 ;;=4^Z89.511
 ;;^UTILITY(U,$J,358.3,830,2)
 ;;=^5063566
 ;;^UTILITY(U,$J,358.3,831,0)
 ;;=Z89.512^^6^97^4
 ;;^UTILITY(U,$J,358.3,831,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,831,1,3,0)
 ;;=3^Acquired Absence Left Leg Below Knee
 ;;^UTILITY(U,$J,358.3,831,1,4,0)
 ;;=4^Z89.512
 ;;^UTILITY(U,$J,358.3,831,2)
 ;;=^5063567
 ;;^UTILITY(U,$J,358.3,832,0)
 ;;=E53.8^^6^98^1
 ;;^UTILITY(U,$J,358.3,832,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,832,1,3,0)
 ;;=3^B Vitamin Group Deficiency
 ;;^UTILITY(U,$J,358.3,832,1,4,0)
 ;;=4^E53.8
 ;;^UTILITY(U,$J,358.3,832,2)
 ;;=^5002797
 ;;^UTILITY(U,$J,358.3,833,0)
 ;;=F31.9^^6^98^2
 ;;^UTILITY(U,$J,358.3,833,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,833,1,3,0)
 ;;=3^Bipolar Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,833,1,4,0)
 ;;=4^F31.9
 ;;^UTILITY(U,$J,358.3,833,2)
 ;;=^331892
 ;;^UTILITY(U,$J,358.3,834,0)
 ;;=R00.1^^6^98^5
 ;;^UTILITY(U,$J,358.3,834,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,834,1,3,0)
 ;;=3^Bradycardia,Unspec
 ;;^UTILITY(U,$J,358.3,834,1,4,0)
 ;;=4^R00.1
 ;;^UTILITY(U,$J,358.3,834,2)
 ;;=^5019164
 ;;^UTILITY(U,$J,358.3,835,0)
 ;;=J20.9^^6^98^6
 ;;^UTILITY(U,$J,358.3,835,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,835,1,3,0)
 ;;=3^Bronchitis,Acute,Unspec
 ;;^UTILITY(U,$J,358.3,835,1,4,0)
 ;;=4^J20.9
 ;;^UTILITY(U,$J,358.3,835,2)
 ;;=^5008195
 ;;^UTILITY(U,$J,358.3,836,0)
 ;;=N32.0^^6^98^3
 ;;^UTILITY(U,$J,358.3,836,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,836,1,3,0)
 ;;=3^Bladder-Neck Obstruction
 ;;^UTILITY(U,$J,358.3,836,1,4,0)
 ;;=4^N32.0
 ;;^UTILITY(U,$J,358.3,836,2)
 ;;=^5015649
 ;;^UTILITY(U,$J,358.3,837,0)
 ;;=M71.50^^6^98^7
 ;;^UTILITY(U,$J,358.3,837,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,837,1,3,0)
 ;;=3^Bursitis NEC,Unspec Site
 ;;^UTILITY(U,$J,358.3,837,1,4,0)
 ;;=4^M71.50
 ;;^UTILITY(U,$J,358.3,837,2)
 ;;=^5013190
 ;;^UTILITY(U,$J,358.3,838,0)
 ;;=D75.89^^6^98^4
 ;;^UTILITY(U,$J,358.3,838,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,838,1,3,0)
 ;;=3^Blood & Blood-Forming Organ Diseases,Oth Spec
 ;;^UTILITY(U,$J,358.3,838,1,4,0)
 ;;=4^D75.89
 ;;^UTILITY(U,$J,358.3,838,2)
 ;;=^5002392
 ;;^UTILITY(U,$J,358.3,839,0)
 ;;=K63.5^^6^99^16
 ;;^UTILITY(U,$J,358.3,839,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,839,1,3,0)
 ;;=3^Colon Polyp
 ;;^UTILITY(U,$J,358.3,839,1,4,0)
 ;;=4^K63.5
 ;;^UTILITY(U,$J,358.3,839,2)
 ;;=^5008765
 ;;^UTILITY(U,$J,358.3,840,0)
 ;;=G56.01^^6^99^7
 ;;^UTILITY(U,$J,358.3,840,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,840,1,3,0)
 ;;=3^Carpal Tunnel Syndrome,Right Upper Limb
