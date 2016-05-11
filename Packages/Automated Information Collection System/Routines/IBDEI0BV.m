IBDEI0BV ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,5369,1,4,0)
 ;;=4^E85.4
 ;;^UTILITY(U,$J,358.3,5369,2)
 ;;=^5003017
 ;;^UTILITY(U,$J,358.3,5370,0)
 ;;=M32.14^^27^345^2
 ;;^UTILITY(U,$J,358.3,5370,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5370,1,3,0)
 ;;=3^Glomerular disease in systemic lupus erythematosus
 ;;^UTILITY(U,$J,358.3,5370,1,4,0)
 ;;=4^M32.14
 ;;^UTILITY(U,$J,358.3,5370,2)
 ;;=^5011757
 ;;^UTILITY(U,$J,358.3,5371,0)
 ;;=M32.15^^27^345^14
 ;;^UTILITY(U,$J,358.3,5371,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5371,1,3,0)
 ;;=3^Tubulo-interstitial neuropathy in SLE
 ;;^UTILITY(U,$J,358.3,5371,1,4,0)
 ;;=4^M32.15
 ;;^UTILITY(U,$J,358.3,5371,2)
 ;;=^5011758
 ;;^UTILITY(U,$J,358.3,5372,0)
 ;;=M34.0^^27^345^12
 ;;^UTILITY(U,$J,358.3,5372,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5372,1,3,0)
 ;;=3^Progressive systemic sclerosis
 ;;^UTILITY(U,$J,358.3,5372,1,4,0)
 ;;=4^M34.0
 ;;^UTILITY(U,$J,358.3,5372,2)
 ;;=^5011778
 ;;^UTILITY(U,$J,358.3,5373,0)
 ;;=M31.1^^27^345^13
 ;;^UTILITY(U,$J,358.3,5373,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5373,1,3,0)
 ;;=3^Thrombotic Microangiopathy
 ;;^UTILITY(U,$J,358.3,5373,1,4,0)
 ;;=4^M31.1
 ;;^UTILITY(U,$J,358.3,5373,2)
 ;;=^119061
 ;;^UTILITY(U,$J,358.3,5374,0)
 ;;=Z87.442^^27^346^1
 ;;^UTILITY(U,$J,358.3,5374,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5374,1,3,0)
 ;;=3^Personal Hx of Urinary Calculi
 ;;^UTILITY(U,$J,358.3,5374,1,4,0)
 ;;=4^Z87.442
 ;;^UTILITY(U,$J,358.3,5374,2)
 ;;=^5063497
 ;;^UTILITY(U,$J,358.3,5375,0)
 ;;=N20.0^^27^346^2
 ;;^UTILITY(U,$J,358.3,5375,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5375,1,3,0)
 ;;=3^Calculus of Kidney
 ;;^UTILITY(U,$J,358.3,5375,1,4,0)
 ;;=4^N20.0
 ;;^UTILITY(U,$J,358.3,5375,2)
 ;;=^67056
 ;;^UTILITY(U,$J,358.3,5376,0)
 ;;=N20.1^^27^346^3
 ;;^UTILITY(U,$J,358.3,5376,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5376,1,3,0)
 ;;=3^Calculus of Ureter
 ;;^UTILITY(U,$J,358.3,5376,1,4,0)
 ;;=4^N20.1
 ;;^UTILITY(U,$J,358.3,5376,2)
 ;;=^5015608
 ;;^UTILITY(U,$J,358.3,5377,0)
 ;;=N20.2^^27^346^4
 ;;^UTILITY(U,$J,358.3,5377,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5377,1,3,0)
 ;;=3^Calculus of Kidney w/ Calculus of Ureter
 ;;^UTILITY(U,$J,358.3,5377,1,4,0)
 ;;=4^N20.2
 ;;^UTILITY(U,$J,358.3,5377,2)
 ;;=^5015609
 ;;^UTILITY(U,$J,358.3,5378,0)
 ;;=N20.9^^27^346^5
 ;;^UTILITY(U,$J,358.3,5378,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5378,1,3,0)
 ;;=3^Urinary Calculus,Unspec
 ;;^UTILITY(U,$J,358.3,5378,1,4,0)
 ;;=4^N20.9
 ;;^UTILITY(U,$J,358.3,5378,2)
 ;;=^5015610
 ;;^UTILITY(U,$J,358.3,5379,0)
 ;;=E72.53^^27^346^6
 ;;^UTILITY(U,$J,358.3,5379,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5379,1,3,0)
 ;;=3^Hyperoxaluria
 ;;^UTILITY(U,$J,358.3,5379,1,4,0)
 ;;=4^E72.53
 ;;^UTILITY(U,$J,358.3,5379,2)
 ;;=^60210
 ;;^UTILITY(U,$J,358.3,5380,0)
 ;;=R78.89^^27^347^1
 ;;^UTILITY(U,$J,358.3,5380,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5380,1,3,0)
 ;;=3^Lithium Toxicity
 ;;^UTILITY(U,$J,358.3,5380,1,4,0)
 ;;=4^R78.89
 ;;^UTILITY(U,$J,358.3,5380,2)
 ;;=^5019588
 ;;^UTILITY(U,$J,358.3,5381,0)
 ;;=Z99.2^^27^348^3
 ;;^UTILITY(U,$J,358.3,5381,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5381,1,3,0)
 ;;=3^Dependence on Renal Dialysis
 ;;^UTILITY(U,$J,358.3,5381,1,4,0)
 ;;=4^Z99.2
 ;;^UTILITY(U,$J,358.3,5381,2)
 ;;=^5063758
 ;;^UTILITY(U,$J,358.3,5382,0)
 ;;=Z91.15^^27^348^6
 ;;^UTILITY(U,$J,358.3,5382,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5382,1,3,0)
 ;;=3^Noncompliance w/ Renal Dialysis
 ;;^UTILITY(U,$J,358.3,5382,1,4,0)
 ;;=4^Z91.15
 ;;^UTILITY(U,$J,358.3,5382,2)
 ;;=^5063617
 ;;^UTILITY(U,$J,358.3,5383,0)
 ;;=Z49.31^^27^348^1
 ;;^UTILITY(U,$J,358.3,5383,1,0)
 ;;=^358.31IA^4^2
