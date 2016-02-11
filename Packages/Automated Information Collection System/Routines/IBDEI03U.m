IBDEI03U ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,1090,0)
 ;;=G47.00^^12^127^13
 ;;^UTILITY(U,$J,358.3,1090,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1090,1,3,0)
 ;;=3^Insomnia,Unspec
 ;;^UTILITY(U,$J,358.3,1090,1,4,0)
 ;;=4^G47.00
 ;;^UTILITY(U,$J,358.3,1090,2)
 ;;=^332924
 ;;^UTILITY(U,$J,358.3,1091,0)
 ;;=T81.4XXA^^12^127^7
 ;;^UTILITY(U,$J,358.3,1091,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1091,1,3,0)
 ;;=3^Infection Following Procedure,Initial Encounter
 ;;^UTILITY(U,$J,358.3,1091,1,4,0)
 ;;=4^T81.4XXA
 ;;^UTILITY(U,$J,358.3,1091,2)
 ;;=^5054479
 ;;^UTILITY(U,$J,358.3,1092,0)
 ;;=K40.90^^12^127^12
 ;;^UTILITY(U,$J,358.3,1092,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1092,1,3,0)
 ;;=3^Inguinal Hernia,Unil w/o Obst/Gangr
 ;;^UTILITY(U,$J,358.3,1092,1,4,0)
 ;;=4^K40.90
 ;;^UTILITY(U,$J,358.3,1092,2)
 ;;=^5008591
 ;;^UTILITY(U,$J,358.3,1093,0)
 ;;=K40.20^^12^127^11
 ;;^UTILITY(U,$J,358.3,1093,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1093,1,3,0)
 ;;=3^Inguinal Hernia,Bilat w/o Obst/Gangr
 ;;^UTILITY(U,$J,358.3,1093,1,4,0)
 ;;=4^K40.20
 ;;^UTILITY(U,$J,358.3,1093,2)
 ;;=^5008585
 ;;^UTILITY(U,$J,358.3,1094,0)
 ;;=K43.2^^12^127^6
 ;;^UTILITY(U,$J,358.3,1094,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1094,1,3,0)
 ;;=3^Incisional Hernia w/o Obst/Gangr
 ;;^UTILITY(U,$J,358.3,1094,1,4,0)
 ;;=4^K43.2
 ;;^UTILITY(U,$J,358.3,1094,2)
 ;;=^5008609
 ;;^UTILITY(U,$J,358.3,1095,0)
 ;;=K75.9^^12^127^8
 ;;^UTILITY(U,$J,358.3,1095,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1095,1,3,0)
 ;;=3^Inflammatory Liver Disease,Unspec
 ;;^UTILITY(U,$J,358.3,1095,1,4,0)
 ;;=4^K75.9
 ;;^UTILITY(U,$J,358.3,1095,2)
 ;;=^5008830
 ;;^UTILITY(U,$J,358.3,1096,0)
 ;;=M51.9^^12^127^14
 ;;^UTILITY(U,$J,358.3,1096,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1096,1,3,0)
 ;;=3^Intervertebral Disc Disorder Thoracic,Thoracolumbar & Lumbar
 ;;^UTILITY(U,$J,358.3,1096,1,4,0)
 ;;=4^M51.9
 ;;^UTILITY(U,$J,358.3,1096,2)
 ;;=^5012263
 ;;^UTILITY(U,$J,358.3,1097,0)
 ;;=I30.0^^12^127^2
 ;;^UTILITY(U,$J,358.3,1097,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1097,1,3,0)
 ;;=3^Idiopathic Pericarditis Acute
 ;;^UTILITY(U,$J,358.3,1097,1,4,0)
 ;;=4^I30.0
 ;;^UTILITY(U,$J,358.3,1097,2)
 ;;=^5007157
 ;;^UTILITY(U,$J,358.3,1098,0)
 ;;=N18.9^^12^128^3
 ;;^UTILITY(U,$J,358.3,1098,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1098,1,3,0)
 ;;=3^Kidney Disease,Chr,Unspec
 ;;^UTILITY(U,$J,358.3,1098,1,4,0)
 ;;=4^N18.9
 ;;^UTILITY(U,$J,358.3,1098,2)
 ;;=^332812
 ;;^UTILITY(U,$J,358.3,1099,0)
 ;;=J04.0^^12^128^6
 ;;^UTILITY(U,$J,358.3,1099,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1099,1,3,0)
 ;;=3^Laryngitis,Acute
 ;;^UTILITY(U,$J,358.3,1099,1,4,0)
 ;;=4^J04.0
 ;;^UTILITY(U,$J,358.3,1099,2)
 ;;=^5008137
 ;;^UTILITY(U,$J,358.3,1100,0)
 ;;=J05.0^^12^128^7
 ;;^UTILITY(U,$J,358.3,1100,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1100,1,3,0)
 ;;=3^Laryngitis,Acute Obstructive (Croup)
 ;;^UTILITY(U,$J,358.3,1100,1,4,0)
 ;;=4^J05.0
 ;;^UTILITY(U,$J,358.3,1100,2)
 ;;=^5008141
 ;;^UTILITY(U,$J,358.3,1101,0)
 ;;=R17.^^12^128^1
 ;;^UTILITY(U,$J,358.3,1101,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1101,1,3,0)
 ;;=3^Jaundice,Unspec
 ;;^UTILITY(U,$J,358.3,1101,1,4,0)
 ;;=4^R17.
 ;;^UTILITY(U,$J,358.3,1101,2)
 ;;=^5019251
 ;;^UTILITY(U,$J,358.3,1102,0)
 ;;=N17.9^^12^128^4
 ;;^UTILITY(U,$J,358.3,1102,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1102,1,3,0)
 ;;=3^Kidney Failure,Acute
 ;;^UTILITY(U,$J,358.3,1102,1,4,0)
 ;;=4^N17.9
 ;;^UTILITY(U,$J,358.3,1102,2)
 ;;=^338532
 ;;^UTILITY(U,$J,358.3,1103,0)
 ;;=N18.9^^12^128^5
 ;;^UTILITY(U,$J,358.3,1103,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1103,1,3,0)
 ;;=3^Kidney Failure,Chronic
