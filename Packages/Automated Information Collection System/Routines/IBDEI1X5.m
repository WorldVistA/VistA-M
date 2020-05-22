IBDEI1X5 ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,30649,2)
 ;;=^5002283
 ;;^UTILITY(U,$J,358.3,30650,0)
 ;;=D63.1^^123^1580^1
 ;;^UTILITY(U,$J,358.3,30650,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30650,1,3,0)
 ;;=3^Anemia in Chronic Kidney Disease
 ;;^UTILITY(U,$J,358.3,30650,1,4,0)
 ;;=4^D63.1
 ;;^UTILITY(U,$J,358.3,30650,2)
 ;;=^332908
 ;;^UTILITY(U,$J,358.3,30651,0)
 ;;=G60.9^^123^1580^31
 ;;^UTILITY(U,$J,358.3,30651,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30651,1,3,0)
 ;;=3^Neuropathy,Hereditary/Idiopathic,Unspec
 ;;^UTILITY(U,$J,358.3,30651,1,4,0)
 ;;=4^G60.9
 ;;^UTILITY(U,$J,358.3,30651,2)
 ;;=^5004071
 ;;^UTILITY(U,$J,358.3,30652,0)
 ;;=I73.9^^123^1580^34
 ;;^UTILITY(U,$J,358.3,30652,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30652,1,3,0)
 ;;=3^PVD,Unspec
 ;;^UTILITY(U,$J,358.3,30652,1,4,0)
 ;;=4^I73.9
 ;;^UTILITY(U,$J,358.3,30652,2)
 ;;=^184182
 ;;^UTILITY(U,$J,358.3,30653,0)
 ;;=N04.9^^123^1580^30
 ;;^UTILITY(U,$J,358.3,30653,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30653,1,3,0)
 ;;=3^Nephrotic Syndrome w/ Unspec Morphologic Changes
 ;;^UTILITY(U,$J,358.3,30653,1,4,0)
 ;;=4^N04.9
 ;;^UTILITY(U,$J,358.3,30653,2)
 ;;=^5015540
 ;;^UTILITY(U,$J,358.3,30654,0)
 ;;=N25.0^^123^1580^35
 ;;^UTILITY(U,$J,358.3,30654,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30654,1,3,0)
 ;;=3^Renal Osteodystrophy
 ;;^UTILITY(U,$J,358.3,30654,1,4,0)
 ;;=4^N25.0
 ;;^UTILITY(U,$J,358.3,30654,2)
 ;;=^104747
 ;;^UTILITY(U,$J,358.3,30655,0)
 ;;=T80.211A^^123^1580^3
 ;;^UTILITY(U,$J,358.3,30655,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30655,1,3,0)
 ;;=3^Bloodstream Infection d/t Central Venous Catheter,Init Encntr
 ;;^UTILITY(U,$J,358.3,30655,1,4,0)
 ;;=4^T80.211A
 ;;^UTILITY(U,$J,358.3,30655,2)
 ;;=^5054350
 ;;^UTILITY(U,$J,358.3,30656,0)
 ;;=T80.211D^^123^1580^4
 ;;^UTILITY(U,$J,358.3,30656,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30656,1,3,0)
 ;;=3^Bloodstream Infection d/t Central Venous Catheter,Subs Encntr
 ;;^UTILITY(U,$J,358.3,30656,1,4,0)
 ;;=4^T80.211D
 ;;^UTILITY(U,$J,358.3,30656,2)
 ;;=^5054351
 ;;^UTILITY(U,$J,358.3,30657,0)
 ;;=E83.59^^123^1580^5
 ;;^UTILITY(U,$J,358.3,30657,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30657,1,3,0)
 ;;=3^Calciphylaxis
 ;;^UTILITY(U,$J,358.3,30657,1,4,0)
 ;;=4^E83.59
 ;;^UTILITY(U,$J,358.3,30657,2)
 ;;=^5003006
 ;;^UTILITY(U,$J,358.3,30658,0)
 ;;=T85.621A^^123^1580^8
 ;;^UTILITY(U,$J,358.3,30658,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30658,1,3,0)
 ;;=3^Displacement of Intraperitoneal Dialysis Catheter,Init Encntr
 ;;^UTILITY(U,$J,358.3,30658,1,4,0)
 ;;=4^T85.621A
 ;;^UTILITY(U,$J,358.3,30658,2)
 ;;=^5055625
 ;;^UTILITY(U,$J,358.3,30659,0)
 ;;=T85.621D^^123^1580^9
 ;;^UTILITY(U,$J,358.3,30659,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30659,1,3,0)
 ;;=3^Displacement of Intraperitoneal Dialysis Catheter,Subs Encntr
 ;;^UTILITY(U,$J,358.3,30659,1,4,0)
 ;;=4^T85.621D
 ;;^UTILITY(U,$J,358.3,30659,2)
 ;;=^5055626
 ;;^UTILITY(U,$J,358.3,30660,0)
 ;;=K65.0^^123^1580^10
 ;;^UTILITY(U,$J,358.3,30660,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30660,1,3,0)
 ;;=3^Generalized (acute) Peritonitis
 ;;^UTILITY(U,$J,358.3,30660,1,4,0)
 ;;=4^K65.0
 ;;^UTILITY(U,$J,358.3,30660,2)
 ;;=^332799
 ;;^UTILITY(U,$J,358.3,30661,0)
 ;;=G60.9^^123^1580^14
 ;;^UTILITY(U,$J,358.3,30661,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30661,1,3,0)
 ;;=3^Hereditary & Idiopathic Neuropathy,Unspec
 ;;^UTILITY(U,$J,358.3,30661,1,4,0)
 ;;=4^G60.9
