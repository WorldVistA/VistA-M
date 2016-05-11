IBDEI0B7 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,5053,2)
 ;;=^5010356
 ;;^UTILITY(U,$J,358.3,5054,0)
 ;;=E66.9^^27^327^33
 ;;^UTILITY(U,$J,358.3,5054,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5054,1,3,0)
 ;;=3^Obesity,Unspec
 ;;^UTILITY(U,$J,358.3,5054,1,4,0)
 ;;=4^E66.9
 ;;^UTILITY(U,$J,358.3,5054,2)
 ;;=^5002832
 ;;^UTILITY(U,$J,358.3,5055,0)
 ;;=E66.01^^27^327^32
 ;;^UTILITY(U,$J,358.3,5055,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5055,1,3,0)
 ;;=3^Obesity,Morbid,d/t Excess Calories
 ;;^UTILITY(U,$J,358.3,5055,1,4,0)
 ;;=4^E66.01
 ;;^UTILITY(U,$J,358.3,5055,2)
 ;;=^5002826
 ;;^UTILITY(U,$J,358.3,5056,0)
 ;;=D50.9^^27^327^2
 ;;^UTILITY(U,$J,358.3,5056,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5056,1,3,0)
 ;;=3^Anemia,Iron Deficiency,Unspec
 ;;^UTILITY(U,$J,358.3,5056,1,4,0)
 ;;=4^D50.9
 ;;^UTILITY(U,$J,358.3,5056,2)
 ;;=^5002283
 ;;^UTILITY(U,$J,358.3,5057,0)
 ;;=D63.1^^27^327^1
 ;;^UTILITY(U,$J,358.3,5057,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5057,1,3,0)
 ;;=3^Anemia in Chronic Kidney Disease
 ;;^UTILITY(U,$J,358.3,5057,1,4,0)
 ;;=4^D63.1
 ;;^UTILITY(U,$J,358.3,5057,2)
 ;;=^332908
 ;;^UTILITY(U,$J,358.3,5058,0)
 ;;=G60.9^^27^327^31
 ;;^UTILITY(U,$J,358.3,5058,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5058,1,3,0)
 ;;=3^Neuropathy,Hereditary/Idiopathic,Unspec
 ;;^UTILITY(U,$J,358.3,5058,1,4,0)
 ;;=4^G60.9
 ;;^UTILITY(U,$J,358.3,5058,2)
 ;;=^5004071
 ;;^UTILITY(U,$J,358.3,5059,0)
 ;;=I73.9^^27^327^34
 ;;^UTILITY(U,$J,358.3,5059,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5059,1,3,0)
 ;;=3^PVD,Unspec
 ;;^UTILITY(U,$J,358.3,5059,1,4,0)
 ;;=4^I73.9
 ;;^UTILITY(U,$J,358.3,5059,2)
 ;;=^184182
 ;;^UTILITY(U,$J,358.3,5060,0)
 ;;=N04.9^^27^327^30
 ;;^UTILITY(U,$J,358.3,5060,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5060,1,3,0)
 ;;=3^Nephrotic Syndrome w/ Unspec Morphologic Changes
 ;;^UTILITY(U,$J,358.3,5060,1,4,0)
 ;;=4^N04.9
 ;;^UTILITY(U,$J,358.3,5060,2)
 ;;=^5015540
 ;;^UTILITY(U,$J,358.3,5061,0)
 ;;=N25.0^^27^327^35
 ;;^UTILITY(U,$J,358.3,5061,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5061,1,3,0)
 ;;=3^Renal Osteodystrophy
 ;;^UTILITY(U,$J,358.3,5061,1,4,0)
 ;;=4^N25.0
 ;;^UTILITY(U,$J,358.3,5061,2)
 ;;=^104747
 ;;^UTILITY(U,$J,358.3,5062,0)
 ;;=T80.211A^^27^327^3
 ;;^UTILITY(U,$J,358.3,5062,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5062,1,3,0)
 ;;=3^Bloodstream Infection d/t Central Venous Catheter,Init Encntr
 ;;^UTILITY(U,$J,358.3,5062,1,4,0)
 ;;=4^T80.211A
 ;;^UTILITY(U,$J,358.3,5062,2)
 ;;=^5054350
 ;;^UTILITY(U,$J,358.3,5063,0)
 ;;=T80.211D^^27^327^4
 ;;^UTILITY(U,$J,358.3,5063,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5063,1,3,0)
 ;;=3^Bloodstream Infection d/t Central Venous Catheter,Subs Encntr
 ;;^UTILITY(U,$J,358.3,5063,1,4,0)
 ;;=4^T80.211D
 ;;^UTILITY(U,$J,358.3,5063,2)
 ;;=^5054351
 ;;^UTILITY(U,$J,358.3,5064,0)
 ;;=E83.59^^27^327^5
 ;;^UTILITY(U,$J,358.3,5064,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5064,1,3,0)
 ;;=3^Calciphylaxis
 ;;^UTILITY(U,$J,358.3,5064,1,4,0)
 ;;=4^E83.59
 ;;^UTILITY(U,$J,358.3,5064,2)
 ;;=^5003006
 ;;^UTILITY(U,$J,358.3,5065,0)
 ;;=T85.621A^^27^327^8
 ;;^UTILITY(U,$J,358.3,5065,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5065,1,3,0)
 ;;=3^Displacement of Intraperitoneal Dialysis Catheter,Init Encntr
 ;;^UTILITY(U,$J,358.3,5065,1,4,0)
 ;;=4^T85.621A
 ;;^UTILITY(U,$J,358.3,5065,2)
 ;;=^5055625
 ;;^UTILITY(U,$J,358.3,5066,0)
 ;;=T85.621D^^27^327^9
 ;;^UTILITY(U,$J,358.3,5066,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5066,1,3,0)
 ;;=3^Displacement of Intraperitoneal Dialysis Catheter,Subs Encntr
 ;;^UTILITY(U,$J,358.3,5066,1,4,0)
 ;;=4^T85.621D
