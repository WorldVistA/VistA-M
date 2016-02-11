IBDEI1JG ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,25720,0)
 ;;=75791^^125^1260^6^^^^1
 ;;^UTILITY(U,$J,358.3,25720,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25720,1,2,0)
 ;;=2^Angiography,Arteriovenous Shunt
 ;;^UTILITY(U,$J,358.3,25720,1,4,0)
 ;;=4^75791
 ;;^UTILITY(U,$J,358.3,25721,0)
 ;;=75962^^125^1260^18^^^^1
 ;;^UTILITY(U,$J,358.3,25721,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25721,1,2,0)
 ;;=2^Angioplasty,Translum Ball Peripheral Artery
 ;;^UTILITY(U,$J,358.3,25721,1,4,0)
 ;;=4^75962
 ;;^UTILITY(U,$J,358.3,25722,0)
 ;;=75964^^125^1260^19^^^^1
 ;;^UTILITY(U,$J,358.3,25722,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25722,1,2,0)
 ;;=2^Angioplasty,Translum Ball,Ea Addl Artery
 ;;^UTILITY(U,$J,358.3,25722,1,4,0)
 ;;=4^75964
 ;;^UTILITY(U,$J,358.3,25723,0)
 ;;=76000^^125^1260^21^^^^1
 ;;^UTILITY(U,$J,358.3,25723,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25723,1,2,0)
 ;;=2^Cardiac Fluoro<1 hr
 ;;^UTILITY(U,$J,358.3,25723,1,4,0)
 ;;=4^76000
 ;;^UTILITY(U,$J,358.3,25724,0)
 ;;=76506^^125^1260^22^^^^1
 ;;^UTILITY(U,$J,358.3,25724,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25724,1,2,0)
 ;;=2^Echoencephalography,Real Time w/ Image
 ;;^UTILITY(U,$J,358.3,25724,1,4,0)
 ;;=4^76506
 ;;^UTILITY(U,$J,358.3,25725,0)
 ;;=37200^^125^1260^61^^^^1
 ;;^UTILITY(U,$J,358.3,25725,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25725,1,2,0)
 ;;=2^Transcatheter Biopsy
 ;;^UTILITY(U,$J,358.3,25725,1,4,0)
 ;;=4^37200
 ;;^UTILITY(U,$J,358.3,25726,0)
 ;;=37236^^125^1260^59^^^^1
 ;;^UTILITY(U,$J,358.3,25726,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25726,1,2,0)
 ;;=2^Transcath Plcmt Stent,Open/Perc,Init Art
 ;;^UTILITY(U,$J,358.3,25726,1,4,0)
 ;;=4^37236
 ;;^UTILITY(U,$J,358.3,25727,0)
 ;;=37237^^125^1260^57^^^^1
 ;;^UTILITY(U,$J,358.3,25727,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25727,1,2,0)
 ;;=2^Transcath Plcmt Stent,Open/Perc,Ea Addl Art
 ;;^UTILITY(U,$J,358.3,25727,1,4,0)
 ;;=4^37237
 ;;^UTILITY(U,$J,358.3,25728,0)
 ;;=37238^^125^1260^60^^^^1
 ;;^UTILITY(U,$J,358.3,25728,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25728,1,2,0)
 ;;=2^Transcath Plcmt Stent,Open/Perc,Init Vein
 ;;^UTILITY(U,$J,358.3,25728,1,4,0)
 ;;=4^37238
 ;;^UTILITY(U,$J,358.3,25729,0)
 ;;=37239^^125^1260^58^^^^1
 ;;^UTILITY(U,$J,358.3,25729,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25729,1,2,0)
 ;;=2^Transcath Plcmt Stent,Open/Perc,Ea Addl Vein
 ;;^UTILITY(U,$J,358.3,25729,1,4,0)
 ;;=4^37239
 ;;^UTILITY(U,$J,358.3,25730,0)
 ;;=37241^^125^1260^66^^^^1
 ;;^UTILITY(U,$J,358.3,25730,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25730,1,2,0)
 ;;=2^Vasc Emb,Venous,Other Than Hemorrhage
 ;;^UTILITY(U,$J,358.3,25730,1,4,0)
 ;;=4^37241
 ;;^UTILITY(U,$J,358.3,25731,0)
 ;;=37242^^125^1260^65^^^^1
 ;;^UTILITY(U,$J,358.3,25731,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25731,1,2,0)
 ;;=2^Vasc Emb,Arterial,Other Than Hemorrhage
 ;;^UTILITY(U,$J,358.3,25731,1,4,0)
 ;;=4^37242
 ;;^UTILITY(U,$J,358.3,25732,0)
 ;;=37243^^125^1260^63^^^^1
 ;;^UTILITY(U,$J,358.3,25732,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25732,1,2,0)
 ;;=2^Vasc Emb for Tumors,Organ Ischemia,Infarct
 ;;^UTILITY(U,$J,358.3,25732,1,4,0)
 ;;=4^37243
 ;;^UTILITY(U,$J,358.3,25733,0)
 ;;=37244^^125^1260^64^^^^1
 ;;^UTILITY(U,$J,358.3,25733,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25733,1,2,0)
 ;;=2^Vasc Emb,Art or Ven Hemor/Lymph Extrav
 ;;^UTILITY(U,$J,358.3,25733,1,4,0)
 ;;=4^37244
 ;;^UTILITY(U,$J,358.3,25734,0)
 ;;=75970^^125^1260^62^^^^1
 ;;^UTILITY(U,$J,358.3,25734,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25734,1,2,0)
 ;;=2^Transcatheter Biopsy,Radiological S&I
 ;;^UTILITY(U,$J,358.3,25734,1,4,0)
 ;;=4^75970
