IBDEI0DK ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,6226,1,4,0)
 ;;=4^H01.005
 ;;^UTILITY(U,$J,358.3,6226,2)
 ;;=^5133380
 ;;^UTILITY(U,$J,358.3,6227,0)
 ;;=H01.001^^30^389^4
 ;;^UTILITY(U,$J,358.3,6227,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6227,1,3,0)
 ;;=3^Blepharitis Unspec,Right Upper Eyelid
 ;;^UTILITY(U,$J,358.3,6227,1,4,0)
 ;;=4^H01.001
 ;;^UTILITY(U,$J,358.3,6227,2)
 ;;=^5004238
 ;;^UTILITY(U,$J,358.3,6228,0)
 ;;=H57.13^^30^389^10
 ;;^UTILITY(U,$J,358.3,6228,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6228,1,3,0)
 ;;=3^Ocular Pain,Bilateral
 ;;^UTILITY(U,$J,358.3,6228,1,4,0)
 ;;=4^H57.13
 ;;^UTILITY(U,$J,358.3,6228,2)
 ;;=^5006384
 ;;^UTILITY(U,$J,358.3,6229,0)
 ;;=H57.12^^30^389^11
 ;;^UTILITY(U,$J,358.3,6229,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6229,1,3,0)
 ;;=3^Ocular Pain,Left Eye
 ;;^UTILITY(U,$J,358.3,6229,1,4,0)
 ;;=4^H57.12
 ;;^UTILITY(U,$J,358.3,6229,2)
 ;;=^5006383
 ;;^UTILITY(U,$J,358.3,6230,0)
 ;;=H57.11^^30^389^12
 ;;^UTILITY(U,$J,358.3,6230,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6230,1,3,0)
 ;;=3^Ocular Pain,Right Eye
 ;;^UTILITY(U,$J,358.3,6230,1,4,0)
 ;;=4^H57.11
 ;;^UTILITY(U,$J,358.3,6230,2)
 ;;=^5006382
 ;;^UTILITY(U,$J,358.3,6231,0)
 ;;=S05.02XA^^30^390^3
 ;;^UTILITY(U,$J,358.3,6231,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6231,1,3,0)
 ;;=3^Inj Conjunctiva/Corneal Abrasion w/o FB,Left Eye,Init
 ;;^UTILITY(U,$J,358.3,6231,1,4,0)
 ;;=4^S05.02XA
 ;;^UTILITY(U,$J,358.3,6231,2)
 ;;=^5020582
 ;;^UTILITY(U,$J,358.3,6232,0)
 ;;=S05.01XA^^30^390^4
 ;;^UTILITY(U,$J,358.3,6232,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6232,1,3,0)
 ;;=3^Inj Conjunctiva/Corneal Abrasion w/o FB,Right Eye,Init
 ;;^UTILITY(U,$J,358.3,6232,1,4,0)
 ;;=4^S05.01XA
 ;;^UTILITY(U,$J,358.3,6232,2)
 ;;=^5020579
 ;;^UTILITY(U,$J,358.3,6233,0)
 ;;=T15.02XA^^30^390^1
 ;;^UTILITY(U,$J,358.3,6233,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6233,1,3,0)
 ;;=3^Foreign Body in Cornea,Left Eye,Init Encntr
 ;;^UTILITY(U,$J,358.3,6233,1,4,0)
 ;;=4^T15.02XA
 ;;^UTILITY(U,$J,358.3,6233,2)
 ;;=^5046387
 ;;^UTILITY(U,$J,358.3,6234,0)
 ;;=T15.01XA^^30^390^2
 ;;^UTILITY(U,$J,358.3,6234,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6234,1,3,0)
 ;;=3^Foreign Body in Cornea,Right Eye,Init Encntr
 ;;^UTILITY(U,$J,358.3,6234,1,4,0)
 ;;=4^T15.01XA
 ;;^UTILITY(U,$J,358.3,6234,2)
 ;;=^5046384
 ;;^UTILITY(U,$J,358.3,6235,0)
 ;;=S00.252A^^30^390^5
 ;;^UTILITY(U,$J,358.3,6235,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6235,1,3,0)
 ;;=3^Superficial FB of Left Eyelid/Periocular Area,Init Encntr
 ;;^UTILITY(U,$J,358.3,6235,1,4,0)
 ;;=4^S00.252A
 ;;^UTILITY(U,$J,358.3,6235,2)
 ;;=^5019820
 ;;^UTILITY(U,$J,358.3,6236,0)
 ;;=S00.251A^^30^390^6
 ;;^UTILITY(U,$J,358.3,6236,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6236,1,3,0)
 ;;=3^Superficial FB of Right Eyelid/Periocular Area,Init Encntr
 ;;^UTILITY(U,$J,358.3,6236,1,4,0)
 ;;=4^S00.251A
 ;;^UTILITY(U,$J,358.3,6236,2)
 ;;=^5019817
 ;;^UTILITY(U,$J,358.3,6237,0)
 ;;=B96.81^^30^391^57
 ;;^UTILITY(U,$J,358.3,6237,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6237,1,3,0)
 ;;=3^H. Pylori as the Cause of Diseases Classified Elsewhere
 ;;^UTILITY(U,$J,358.3,6237,1,4,0)
 ;;=4^B96.81
 ;;^UTILITY(U,$J,358.3,6237,2)
 ;;=^5000857
 ;;^UTILITY(U,$J,358.3,6238,0)
 ;;=B15.9^^30^391^59
 ;;^UTILITY(U,$J,358.3,6238,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6238,1,3,0)
 ;;=3^Hepatitis A,Acute w/o Hepatic Coma
 ;;^UTILITY(U,$J,358.3,6238,1,4,0)
 ;;=4^B15.9
 ;;^UTILITY(U,$J,358.3,6238,2)
 ;;=^5000536
 ;;^UTILITY(U,$J,358.3,6239,0)
 ;;=B16.9^^30^391^60
 ;;^UTILITY(U,$J,358.3,6239,1,0)
 ;;=^358.31IA^4^2
