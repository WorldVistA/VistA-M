IBDEI1AT ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,22078,1,4,0)
 ;;=4^H57.12
 ;;^UTILITY(U,$J,358.3,22078,2)
 ;;=^5006383
 ;;^UTILITY(U,$J,358.3,22079,0)
 ;;=H57.11^^87^974^12
 ;;^UTILITY(U,$J,358.3,22079,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22079,1,3,0)
 ;;=3^Ocular Pain,Right Eye
 ;;^UTILITY(U,$J,358.3,22079,1,4,0)
 ;;=4^H57.11
 ;;^UTILITY(U,$J,358.3,22079,2)
 ;;=^5006382
 ;;^UTILITY(U,$J,358.3,22080,0)
 ;;=S05.02XA^^87^975^3
 ;;^UTILITY(U,$J,358.3,22080,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22080,1,3,0)
 ;;=3^Inj Conjunctiva/Corneal Abrasion w/o FB,Left Eye,Init
 ;;^UTILITY(U,$J,358.3,22080,1,4,0)
 ;;=4^S05.02XA
 ;;^UTILITY(U,$J,358.3,22080,2)
 ;;=^5020582
 ;;^UTILITY(U,$J,358.3,22081,0)
 ;;=S05.01XA^^87^975^4
 ;;^UTILITY(U,$J,358.3,22081,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22081,1,3,0)
 ;;=3^Inj Conjunctiva/Corneal Abrasion w/o FB,Right Eye,Init
 ;;^UTILITY(U,$J,358.3,22081,1,4,0)
 ;;=4^S05.01XA
 ;;^UTILITY(U,$J,358.3,22081,2)
 ;;=^5020579
 ;;^UTILITY(U,$J,358.3,22082,0)
 ;;=T15.02XA^^87^975^1
 ;;^UTILITY(U,$J,358.3,22082,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22082,1,3,0)
 ;;=3^Foreign Body in Cornea,Left Eye,Init Encntr
 ;;^UTILITY(U,$J,358.3,22082,1,4,0)
 ;;=4^T15.02XA
 ;;^UTILITY(U,$J,358.3,22082,2)
 ;;=^5046387
 ;;^UTILITY(U,$J,358.3,22083,0)
 ;;=T15.01XA^^87^975^2
 ;;^UTILITY(U,$J,358.3,22083,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22083,1,3,0)
 ;;=3^Foreign Body in Cornea,Right Eye,Init Encntr
 ;;^UTILITY(U,$J,358.3,22083,1,4,0)
 ;;=4^T15.01XA
 ;;^UTILITY(U,$J,358.3,22083,2)
 ;;=^5046384
 ;;^UTILITY(U,$J,358.3,22084,0)
 ;;=S00.252A^^87^975^5
 ;;^UTILITY(U,$J,358.3,22084,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22084,1,3,0)
 ;;=3^Superficial FB of Left Eyelid/Periocular Area,Init Encntr
 ;;^UTILITY(U,$J,358.3,22084,1,4,0)
 ;;=4^S00.252A
 ;;^UTILITY(U,$J,358.3,22084,2)
 ;;=^5019820
 ;;^UTILITY(U,$J,358.3,22085,0)
 ;;=S00.251A^^87^975^6
 ;;^UTILITY(U,$J,358.3,22085,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22085,1,3,0)
 ;;=3^Superficial FB of Right Eyelid/Periocular Area,Init Encntr
 ;;^UTILITY(U,$J,358.3,22085,1,4,0)
 ;;=4^S00.251A
 ;;^UTILITY(U,$J,358.3,22085,2)
 ;;=^5019817
 ;;^UTILITY(U,$J,358.3,22086,0)
 ;;=B96.81^^87^976^56
 ;;^UTILITY(U,$J,358.3,22086,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22086,1,3,0)
 ;;=3^H. Pylori as the Cause of Diseases Classified Elsewhere
 ;;^UTILITY(U,$J,358.3,22086,1,4,0)
 ;;=4^B96.81
 ;;^UTILITY(U,$J,358.3,22086,2)
 ;;=^5000857
 ;;^UTILITY(U,$J,358.3,22087,0)
 ;;=B15.9^^87^976^58
 ;;^UTILITY(U,$J,358.3,22087,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22087,1,3,0)
 ;;=3^Hepatitis A,Acute w/o Hepatic Coma
 ;;^UTILITY(U,$J,358.3,22087,1,4,0)
 ;;=4^B15.9
 ;;^UTILITY(U,$J,358.3,22087,2)
 ;;=^5000536
 ;;^UTILITY(U,$J,358.3,22088,0)
 ;;=B16.9^^87^976^59
 ;;^UTILITY(U,$J,358.3,22088,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22088,1,3,0)
 ;;=3^Hepatitis B,Acute w/o Delta-Agent & w/o Hepatic Coma
 ;;^UTILITY(U,$J,358.3,22088,1,4,0)
 ;;=4^B16.9
 ;;^UTILITY(U,$J,358.3,22088,2)
 ;;=^5000540
 ;;^UTILITY(U,$J,358.3,22089,0)
 ;;=B19.10^^87^976^61
 ;;^UTILITY(U,$J,358.3,22089,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22089,1,3,0)
 ;;=3^Hepatitis B,Viral w/o Hepatic Coma,Unspec
 ;;^UTILITY(U,$J,358.3,22089,1,4,0)
 ;;=4^B19.10
 ;;^UTILITY(U,$J,358.3,22089,2)
 ;;=^5000552
 ;;^UTILITY(U,$J,358.3,22090,0)
 ;;=B18.1^^87^976^60
 ;;^UTILITY(U,$J,358.3,22090,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22090,1,3,0)
 ;;=3^Hepatitis B,Chronic Viral w/o Delta-Agent
 ;;^UTILITY(U,$J,358.3,22090,1,4,0)
 ;;=4^B18.1
 ;;^UTILITY(U,$J,358.3,22090,2)
 ;;=^5000547
