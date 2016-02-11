IBDEI081 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,3198,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3198,1,3,0)
 ;;=3^Aneurysm,Aortic w/o Rupture,Unspec Site
 ;;^UTILITY(U,$J,358.3,3198,1,4,0)
 ;;=4^I71.9
 ;;^UTILITY(U,$J,358.3,3198,2)
 ;;=^5007792
 ;;^UTILITY(U,$J,358.3,3199,0)
 ;;=I71.2^^28^249^4
 ;;^UTILITY(U,$J,358.3,3199,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3199,1,3,0)
 ;;=3^Aneurysm,Thoracic Aortic w/o Rupture
 ;;^UTILITY(U,$J,358.3,3199,1,4,0)
 ;;=4^I71.2
 ;;^UTILITY(U,$J,358.3,3199,2)
 ;;=^5007787
 ;;^UTILITY(U,$J,358.3,3200,0)
 ;;=I71.6^^28^249^5
 ;;^UTILITY(U,$J,358.3,3200,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3200,1,3,0)
 ;;=3^Aneurysm,Thoracoabdominal Aortic w/o Rupture
 ;;^UTILITY(U,$J,358.3,3200,1,4,0)
 ;;=4^I71.6
 ;;^UTILITY(U,$J,358.3,3200,2)
 ;;=^5007791
 ;;^UTILITY(U,$J,358.3,3201,0)
 ;;=I20.1^^28^249^7
 ;;^UTILITY(U,$J,358.3,3201,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3201,1,3,0)
 ;;=3^Angina Pectoris w/ Spasm
 ;;^UTILITY(U,$J,358.3,3201,1,4,0)
 ;;=4^I20.1
 ;;^UTILITY(U,$J,358.3,3201,2)
 ;;=^5007077
 ;;^UTILITY(U,$J,358.3,3202,0)
 ;;=I20.9^^28^249^8
 ;;^UTILITY(U,$J,358.3,3202,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3202,1,3,0)
 ;;=3^Angina Pectoris,Unspec
 ;;^UTILITY(U,$J,358.3,3202,1,4,0)
 ;;=4^I20.9
 ;;^UTILITY(U,$J,358.3,3202,2)
 ;;=^5007079
 ;;^UTILITY(U,$J,358.3,3203,0)
 ;;=I35.1^^28^249^11
 ;;^UTILITY(U,$J,358.3,3203,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3203,1,3,0)
 ;;=3^Aortic Valve Insufficiency,Nonrheumatic
 ;;^UTILITY(U,$J,358.3,3203,1,4,0)
 ;;=4^I35.1
 ;;^UTILITY(U,$J,358.3,3203,2)
 ;;=^5007175
 ;;^UTILITY(U,$J,358.3,3204,0)
 ;;=I35.2^^28^249^12
 ;;^UTILITY(U,$J,358.3,3204,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3204,1,3,0)
 ;;=3^Aortic Valve Stenosis w/ Insufficiency,Nonrheumatic
 ;;^UTILITY(U,$J,358.3,3204,1,4,0)
 ;;=4^I35.2
 ;;^UTILITY(U,$J,358.3,3204,2)
 ;;=^5007176
 ;;^UTILITY(U,$J,358.3,3205,0)
 ;;=I35.0^^28^249^13
 ;;^UTILITY(U,$J,358.3,3205,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3205,1,3,0)
 ;;=3^Aortic Valve Stenosis,Nonrheumatic
 ;;^UTILITY(U,$J,358.3,3205,1,4,0)
 ;;=4^I35.0
 ;;^UTILITY(U,$J,358.3,3205,2)
 ;;=^5007174
 ;;^UTILITY(U,$J,358.3,3206,0)
 ;;=I35.9^^28^249^10
 ;;^UTILITY(U,$J,358.3,3206,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3206,1,3,0)
 ;;=3^Aortic Valve Disorder,Nonrheumatic,Unspec
 ;;^UTILITY(U,$J,358.3,3206,1,4,0)
 ;;=4^I35.9
 ;;^UTILITY(U,$J,358.3,3206,2)
 ;;=^5007178
 ;;^UTILITY(U,$J,358.3,3207,0)
 ;;=I35.8^^28^249^9
 ;;^UTILITY(U,$J,358.3,3207,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3207,1,3,0)
 ;;=3^Aortic Valve Disorder,Nonrheumatic,Other
 ;;^UTILITY(U,$J,358.3,3207,1,4,0)
 ;;=4^I35.8
 ;;^UTILITY(U,$J,358.3,3207,2)
 ;;=^5007177
 ;;^UTILITY(U,$J,358.3,3208,0)
 ;;=I77.6^^28^249^14
 ;;^UTILITY(U,$J,358.3,3208,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3208,1,3,0)
 ;;=3^Arteritis,Unspec
 ;;^UTILITY(U,$J,358.3,3208,1,4,0)
 ;;=4^I77.6
 ;;^UTILITY(U,$J,358.3,3208,2)
 ;;=^5007813
 ;;^UTILITY(U,$J,358.3,3209,0)
 ;;=I25.810^^28^249^15
 ;;^UTILITY(U,$J,358.3,3209,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3209,1,3,0)
 ;;=3^Atherosclerosis of CABG w/o Angina Pectoris
 ;;^UTILITY(U,$J,358.3,3209,1,4,0)
 ;;=4^I25.810
 ;;^UTILITY(U,$J,358.3,3209,2)
 ;;=^5007141
 ;;^UTILITY(U,$J,358.3,3210,0)
 ;;=I70.91^^28^249^16
 ;;^UTILITY(U,$J,358.3,3210,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3210,1,3,0)
 ;;=3^Atherosclerosis,Generalized
 ;;^UTILITY(U,$J,358.3,3210,1,4,0)
 ;;=4^I70.91
 ;;^UTILITY(U,$J,358.3,3210,2)
 ;;=^5007785
 ;;^UTILITY(U,$J,358.3,3211,0)
 ;;=I70.90^^28^249^17
 ;;^UTILITY(U,$J,358.3,3211,1,0)
 ;;=^358.31IA^4^2
