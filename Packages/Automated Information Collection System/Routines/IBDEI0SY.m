IBDEI0SY ; ; 20-MAY-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,14276,0)
 ;;=37239^^86^880^54^^^^1
 ;;^UTILITY(U,$J,358.3,14276,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14276,1,2,0)
 ;;=2^Transcath Plcmt Stent,Open/Perc,Ea Addl Vein
 ;;^UTILITY(U,$J,358.3,14276,1,4,0)
 ;;=4^37239
 ;;^UTILITY(U,$J,358.3,14277,0)
 ;;=37241^^86^880^65^^^^1
 ;;^UTILITY(U,$J,358.3,14277,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14277,1,2,0)
 ;;=2^Vasc Emb,Venous,Other Than Hemorrhage
 ;;^UTILITY(U,$J,358.3,14277,1,4,0)
 ;;=4^37241
 ;;^UTILITY(U,$J,358.3,14278,0)
 ;;=37242^^86^880^64^^^^1
 ;;^UTILITY(U,$J,358.3,14278,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14278,1,2,0)
 ;;=2^Vasc Emb,Arterial,Other Than Hemorrhage
 ;;^UTILITY(U,$J,358.3,14278,1,4,0)
 ;;=4^37242
 ;;^UTILITY(U,$J,358.3,14279,0)
 ;;=37243^^86^880^62^^^^1
 ;;^UTILITY(U,$J,358.3,14279,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14279,1,2,0)
 ;;=2^Vasc Emb for Tumors,Organ Ischemia,Infarct
 ;;^UTILITY(U,$J,358.3,14279,1,4,0)
 ;;=4^37243
 ;;^UTILITY(U,$J,358.3,14280,0)
 ;;=37244^^86^880^63^^^^1
 ;;^UTILITY(U,$J,358.3,14280,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14280,1,2,0)
 ;;=2^Vasc Emb,Art or Ven Hemor/Lymph Extrav
 ;;^UTILITY(U,$J,358.3,14280,1,4,0)
 ;;=4^37244
 ;;^UTILITY(U,$J,358.3,14281,0)
 ;;=75970^^86^880^58^^^^1
 ;;^UTILITY(U,$J,358.3,14281,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14281,1,2,0)
 ;;=2^Transcatheter Biopsy,Radiological S&I
 ;;^UTILITY(U,$J,358.3,14281,1,4,0)
 ;;=4^75970
 ;;^UTILITY(U,$J,358.3,14282,0)
 ;;=36222^^86^880^38^^^^1
 ;;^UTILITY(U,$J,358.3,14282,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14282,1,2,0)
 ;;=2^Select Cath w/ Cervicocerebral Arch Angio
 ;;^UTILITY(U,$J,358.3,14282,1,4,0)
 ;;=4^36222
 ;;^UTILITY(U,$J,358.3,14283,0)
 ;;=36223^^86^880^39^^^^1
 ;;^UTILITY(U,$J,358.3,14283,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14283,1,2,0)
 ;;=2^Select Cath w/ Extracranial Carotid Angio
 ;;^UTILITY(U,$J,358.3,14283,1,4,0)
 ;;=4^36223
 ;;^UTILITY(U,$J,358.3,14284,0)
 ;;=36224^^86^880^40^^^^1
 ;;^UTILITY(U,$J,358.3,14284,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14284,1,2,0)
 ;;=2^Select Cath w/ Ipsilateral Intracranial Angio
 ;;^UTILITY(U,$J,358.3,14284,1,4,0)
 ;;=4^36224
 ;;^UTILITY(U,$J,358.3,14285,0)
 ;;=36253^^86^880^43^^^^1
 ;;^UTILITY(U,$J,358.3,14285,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14285,1,2,0)
 ;;=2^Superselect Cath Ren Art&Access Art
 ;;^UTILITY(U,$J,358.3,14285,1,4,0)
 ;;=4^36253
 ;;^UTILITY(U,$J,358.3,14286,0)
 ;;=37251^^86^880^23^^^^1
 ;;^UTILITY(U,$J,358.3,14286,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14286,1,2,0)
 ;;=2^Intravas US,Non/Cor,Diag/Ther Interv,Ea Addl
 ;;^UTILITY(U,$J,358.3,14286,1,4,0)
 ;;=4^37251
 ;;^UTILITY(U,$J,358.3,14287,0)
 ;;=34800^^86^881^4^^^^1
 ;;^UTILITY(U,$J,358.3,14287,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14287,1,2,0)
 ;;=2^Endovasc Abdo Repair w/ Tube
 ;;^UTILITY(U,$J,358.3,14287,1,4,0)
 ;;=4^34800
 ;;^UTILITY(U,$J,358.3,14288,0)
 ;;=34802^^86^881^3^^^^1
 ;;^UTILITY(U,$J,358.3,14288,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14288,1,2,0)
 ;;=2^Endovasc Abdo Repair w/ Bifurc
 ;;^UTILITY(U,$J,358.3,14288,1,4,0)
 ;;=4^34802
 ;;^UTILITY(U,$J,358.3,14289,0)
 ;;=34803^^86^881^2^^^^1
 ;;^UTILITY(U,$J,358.3,14289,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14289,1,2,0)
 ;;=2^Endovas AAA Repair w/ 3-P Part
 ;;^UTILITY(U,$J,358.3,14289,1,4,0)
 ;;=4^34803
 ;;^UTILITY(U,$J,358.3,14290,0)
 ;;=36005^^86^882^1^^^^1
 ;;^UTILITY(U,$J,358.3,14290,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14290,1,2,0)
 ;;=2^Contrast Venography
 ;;^UTILITY(U,$J,358.3,14290,1,4,0)
 ;;=4^36005
