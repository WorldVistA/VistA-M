IBDEI0HL ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,7657,1,3,0)
 ;;=3^Morbid Obesity w/ Alveolar Hypoventilation
 ;;^UTILITY(U,$J,358.3,7657,1,4,0)
 ;;=4^E66.2
 ;;^UTILITY(U,$J,358.3,7657,2)
 ;;=^5002829
 ;;^UTILITY(U,$J,358.3,7658,0)
 ;;=K85.90^^63^497^20
 ;;^UTILITY(U,$J,358.3,7658,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7658,1,3,0)
 ;;=3^Pancreatitis,Acute w/o Necrosis/Infection,Unspec
 ;;^UTILITY(U,$J,358.3,7658,1,4,0)
 ;;=4^K85.90
 ;;^UTILITY(U,$J,358.3,7658,2)
 ;;=^5138761
 ;;^UTILITY(U,$J,358.3,7659,0)
 ;;=K85.91^^63^497^19
 ;;^UTILITY(U,$J,358.3,7659,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7659,1,3,0)
 ;;=3^Pancreatitis,Acute w/ Uninfected Necrosis,Unspec
 ;;^UTILITY(U,$J,358.3,7659,1,4,0)
 ;;=4^K85.91
 ;;^UTILITY(U,$J,358.3,7659,2)
 ;;=^5138762
 ;;^UTILITY(U,$J,358.3,7660,0)
 ;;=K85.92^^63^497^18
 ;;^UTILITY(U,$J,358.3,7660,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7660,1,3,0)
 ;;=3^Pancreatitis,Acute w/ Infected Necrosis,Unspec
 ;;^UTILITY(U,$J,358.3,7660,1,4,0)
 ;;=4^K85.92
 ;;^UTILITY(U,$J,358.3,7660,2)
 ;;=^5138763
 ;;^UTILITY(U,$J,358.3,7661,0)
 ;;=I21.4^^63^498^57
 ;;^UTILITY(U,$J,358.3,7661,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7661,1,3,0)
 ;;=3^NSTEMI Myocardial Infarction
 ;;^UTILITY(U,$J,358.3,7661,1,4,0)
 ;;=4^I21.4
 ;;^UTILITY(U,$J,358.3,7661,2)
 ;;=^5007088
 ;;^UTILITY(U,$J,358.3,7662,0)
 ;;=I50.9^^63^498^41
 ;;^UTILITY(U,$J,358.3,7662,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7662,1,3,0)
 ;;=3^Heart Failure,Unspec
 ;;^UTILITY(U,$J,358.3,7662,1,4,0)
 ;;=4^I50.9
 ;;^UTILITY(U,$J,358.3,7662,2)
 ;;=^5007251
 ;;^UTILITY(U,$J,358.3,7663,0)
 ;;=I50.23^^63^498^75
 ;;^UTILITY(U,$J,358.3,7663,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7663,1,3,0)
 ;;=3^Systolic Congestive Heart Failure,Acute on Chronic
 ;;^UTILITY(U,$J,358.3,7663,1,4,0)
 ;;=4^I50.23
 ;;^UTILITY(U,$J,358.3,7663,2)
 ;;=^5007242
 ;;^UTILITY(U,$J,358.3,7664,0)
 ;;=I25.10^^63^498^6
 ;;^UTILITY(U,$J,358.3,7664,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7664,1,3,0)
 ;;=3^Athscl Hrt Disease Native Coronary Artery w/o Ang Pctrs
 ;;^UTILITY(U,$J,358.3,7664,1,4,0)
 ;;=4^I25.10
 ;;^UTILITY(U,$J,358.3,7664,2)
 ;;=^5007107
 ;;^UTILITY(U,$J,358.3,7665,0)
 ;;=I10.^^63^498^43
 ;;^UTILITY(U,$J,358.3,7665,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7665,1,3,0)
 ;;=3^Hypertension
 ;;^UTILITY(U,$J,358.3,7665,1,4,0)
 ;;=4^I10.
 ;;^UTILITY(U,$J,358.3,7665,2)
 ;;=^5007062
 ;;^UTILITY(U,$J,358.3,7666,0)
 ;;=I49.8^^63^498^29
 ;;^UTILITY(U,$J,358.3,7666,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7666,1,3,0)
 ;;=3^Cardiac Arrhythmias,Oth Spec
 ;;^UTILITY(U,$J,358.3,7666,1,4,0)
 ;;=4^I49.8
 ;;^UTILITY(U,$J,358.3,7666,2)
 ;;=^5007236
 ;;^UTILITY(U,$J,358.3,7667,0)
 ;;=R00.1^^63^498^27
 ;;^UTILITY(U,$J,358.3,7667,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7667,1,3,0)
 ;;=3^Bradycardia,Unspec
 ;;^UTILITY(U,$J,358.3,7667,1,4,0)
 ;;=4^R00.1
 ;;^UTILITY(U,$J,358.3,7667,2)
 ;;=^5019164
 ;;^UTILITY(U,$J,358.3,7668,0)
 ;;=I47.2^^63^498^79
 ;;^UTILITY(U,$J,358.3,7668,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7668,1,3,0)
 ;;=3^Ventricular Tachycardia
 ;;^UTILITY(U,$J,358.3,7668,1,4,0)
 ;;=4^I47.2
 ;;^UTILITY(U,$J,358.3,7668,2)
 ;;=^125976
 ;;^UTILITY(U,$J,358.3,7669,0)
 ;;=I25.810^^63^498^5
 ;;^UTILITY(U,$J,358.3,7669,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7669,1,3,0)
 ;;=3^Atherosclerosis of CABG w/o Angina Pectoris
 ;;^UTILITY(U,$J,358.3,7669,1,4,0)
 ;;=4^I25.810
