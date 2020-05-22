IBDEI0UA ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,13486,1,3,0)
 ;;=3^Angina Pectoris,Unspec
 ;;^UTILITY(U,$J,358.3,13486,1,4,0)
 ;;=4^I20.9
 ;;^UTILITY(U,$J,358.3,13486,2)
 ;;=^5007079
 ;;^UTILITY(U,$J,358.3,13487,0)
 ;;=I35.1^^83^812^11
 ;;^UTILITY(U,$J,358.3,13487,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13487,1,3,0)
 ;;=3^Aortic Valve Insufficiency,Nonrheumatic
 ;;^UTILITY(U,$J,358.3,13487,1,4,0)
 ;;=4^I35.1
 ;;^UTILITY(U,$J,358.3,13487,2)
 ;;=^5007175
 ;;^UTILITY(U,$J,358.3,13488,0)
 ;;=I35.2^^83^812^12
 ;;^UTILITY(U,$J,358.3,13488,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13488,1,3,0)
 ;;=3^Aortic Valve Stenosis w/ Insufficiency,Nonrheumatic
 ;;^UTILITY(U,$J,358.3,13488,1,4,0)
 ;;=4^I35.2
 ;;^UTILITY(U,$J,358.3,13488,2)
 ;;=^5007176
 ;;^UTILITY(U,$J,358.3,13489,0)
 ;;=I35.0^^83^812^13
 ;;^UTILITY(U,$J,358.3,13489,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13489,1,3,0)
 ;;=3^Aortic Valve Stenosis,Nonrheumatic
 ;;^UTILITY(U,$J,358.3,13489,1,4,0)
 ;;=4^I35.0
 ;;^UTILITY(U,$J,358.3,13489,2)
 ;;=^5007174
 ;;^UTILITY(U,$J,358.3,13490,0)
 ;;=I35.9^^83^812^10
 ;;^UTILITY(U,$J,358.3,13490,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13490,1,3,0)
 ;;=3^Aortic Valve Disorder,Nonrheumatic,Unspec
 ;;^UTILITY(U,$J,358.3,13490,1,4,0)
 ;;=4^I35.9
 ;;^UTILITY(U,$J,358.3,13490,2)
 ;;=^5007178
 ;;^UTILITY(U,$J,358.3,13491,0)
 ;;=I35.8^^83^812^9
 ;;^UTILITY(U,$J,358.3,13491,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13491,1,3,0)
 ;;=3^Aortic Valve Disorder,Nonrheumatic,Other
 ;;^UTILITY(U,$J,358.3,13491,1,4,0)
 ;;=4^I35.8
 ;;^UTILITY(U,$J,358.3,13491,2)
 ;;=^5007177
 ;;^UTILITY(U,$J,358.3,13492,0)
 ;;=I77.6^^83^812^14
 ;;^UTILITY(U,$J,358.3,13492,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13492,1,3,0)
 ;;=3^Arteritis,Unspec
 ;;^UTILITY(U,$J,358.3,13492,1,4,0)
 ;;=4^I77.6
 ;;^UTILITY(U,$J,358.3,13492,2)
 ;;=^5007813
 ;;^UTILITY(U,$J,358.3,13493,0)
 ;;=I25.810^^83^812^15
 ;;^UTILITY(U,$J,358.3,13493,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13493,1,3,0)
 ;;=3^Atherosclerosis of CABG w/o Angina Pectoris
 ;;^UTILITY(U,$J,358.3,13493,1,4,0)
 ;;=4^I25.810
 ;;^UTILITY(U,$J,358.3,13493,2)
 ;;=^5007141
 ;;^UTILITY(U,$J,358.3,13494,0)
 ;;=I70.91^^83^812^16
 ;;^UTILITY(U,$J,358.3,13494,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13494,1,3,0)
 ;;=3^Atherosclerosis,Generalized
 ;;^UTILITY(U,$J,358.3,13494,1,4,0)
 ;;=4^I70.91
 ;;^UTILITY(U,$J,358.3,13494,2)
 ;;=^5007785
 ;;^UTILITY(U,$J,358.3,13495,0)
 ;;=I70.90^^83^812^17
 ;;^UTILITY(U,$J,358.3,13495,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13495,1,3,0)
 ;;=3^Atherosclerosis,Unspec
 ;;^UTILITY(U,$J,358.3,13495,1,4,0)
 ;;=4^I70.90
 ;;^UTILITY(U,$J,358.3,13495,2)
 ;;=^5007784
 ;;^UTILITY(U,$J,358.3,13496,0)
 ;;=I25.10^^83^812^18
 ;;^UTILITY(U,$J,358.3,13496,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13496,1,3,0)
 ;;=3^Athscl Hrt Disease Native Coronary Artery w/o Angina Pectoris
 ;;^UTILITY(U,$J,358.3,13496,1,4,0)
 ;;=4^I25.10
 ;;^UTILITY(U,$J,358.3,13496,2)
 ;;=^5007107
 ;;^UTILITY(U,$J,358.3,13497,0)
 ;;=I48.91^^83^812^19
 ;;^UTILITY(U,$J,358.3,13497,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13497,1,3,0)
 ;;=3^Atrial Fibrillation,Unspec
 ;;^UTILITY(U,$J,358.3,13497,1,4,0)
 ;;=4^I48.91
 ;;^UTILITY(U,$J,358.3,13497,2)
 ;;=^5007229
 ;;^UTILITY(U,$J,358.3,13498,0)
 ;;=Z95.1^^83^812^21
 ;;^UTILITY(U,$J,358.3,13498,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13498,1,3,0)
 ;;=3^Bypass Graft,Aortocoronary
