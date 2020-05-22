IBDEI0OF ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,10888,0)
 ;;=76514^^76^710^9^^^^1
 ;;^UTILITY(U,$J,358.3,10888,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10888,1,2,0)
 ;;=2^Pachymetry (corneal thickness)
 ;;^UTILITY(U,$J,358.3,10888,1,3,0)
 ;;=3^76514
 ;;^UTILITY(U,$J,358.3,10889,0)
 ;;=92025^^76^710^10^^^^1
 ;;^UTILITY(U,$J,358.3,10889,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10889,1,2,0)
 ;;=2^Topography (cornea),Unilat or Bilat
 ;;^UTILITY(U,$J,358.3,10889,1,3,0)
 ;;=3^92025
 ;;^UTILITY(U,$J,358.3,10890,0)
 ;;=92242^^76^710^8^^^^1
 ;;^UTILITY(U,$J,358.3,10890,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10890,1,2,0)
 ;;=2^Fluorescein & ICG Angiography,Unilat or Bilat
 ;;^UTILITY(U,$J,358.3,10890,1,3,0)
 ;;=3^92242
 ;;^UTILITY(U,$J,358.3,10891,0)
 ;;=92286^^76^710^11^^^^1
 ;;^UTILITY(U,$J,358.3,10891,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10891,1,2,0)
 ;;=2^Specular Microscopy
 ;;^UTILITY(U,$J,358.3,10891,1,3,0)
 ;;=3^92286
 ;;^UTILITY(U,$J,358.3,10892,0)
 ;;=92311^^76^711^11^^^^1
 ;;^UTILITY(U,$J,358.3,10892,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10892,1,2,0)
 ;;=2^Contact Lens-Aphakia OD/OS
 ;;^UTILITY(U,$J,358.3,10892,1,3,0)
 ;;=3^92311
 ;;^UTILITY(U,$J,358.3,10893,0)
 ;;=92312^^76^711^12^^^^1
 ;;^UTILITY(U,$J,358.3,10893,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10893,1,2,0)
 ;;=2^Contact Lens-Aphakia OU
 ;;^UTILITY(U,$J,358.3,10893,1,3,0)
 ;;=3^92312
 ;;^UTILITY(U,$J,358.3,10894,0)
 ;;=92340^^76^711^5^^^^1
 ;;^UTILITY(U,$J,358.3,10894,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10894,1,2,0)
 ;;=2^Glasses Fitting, Monofocal
 ;;^UTILITY(U,$J,358.3,10894,1,3,0)
 ;;=3^92340
 ;;^UTILITY(U,$J,358.3,10895,0)
 ;;=92341^^76^711^4^^^^1
 ;;^UTILITY(U,$J,358.3,10895,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10895,1,2,0)
 ;;=2^Glasses Fitting, Bifocal
 ;;^UTILITY(U,$J,358.3,10895,1,3,0)
 ;;=3^92341
 ;;^UTILITY(U,$J,358.3,10896,0)
 ;;=92342^^76^711^7^^^^1
 ;;^UTILITY(U,$J,358.3,10896,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10896,1,2,0)
 ;;=2^Glasses Fitting, Multifocal
 ;;^UTILITY(U,$J,358.3,10896,1,3,0)
 ;;=3^92342
 ;;^UTILITY(U,$J,358.3,10897,0)
 ;;=92352^^76^711^6^^^^1
 ;;^UTILITY(U,$J,358.3,10897,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10897,1,2,0)
 ;;=2^Glasses Fitting, Monofocal for Aphakia
 ;;^UTILITY(U,$J,358.3,10897,1,3,0)
 ;;=3^92352
 ;;^UTILITY(U,$J,358.3,10898,0)
 ;;=92353^^76^711^8^^^^1
 ;;^UTILITY(U,$J,358.3,10898,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10898,1,2,0)
 ;;=2^Glasses Fitting, Multifocal, for Aphakia
 ;;^UTILITY(U,$J,358.3,10898,1,3,0)
 ;;=3^92353
 ;;^UTILITY(U,$J,358.3,10899,0)
 ;;=92354^^76^711^13^^^^1
 ;;^UTILITY(U,$J,358.3,10899,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10899,1,2,0)
 ;;=2^Low Vision Aid Fitting, Single Element
 ;;^UTILITY(U,$J,358.3,10899,1,3,0)
 ;;=3^92354
 ;;^UTILITY(U,$J,358.3,10900,0)
 ;;=92355^^76^711^14^^^^1
 ;;^UTILITY(U,$J,358.3,10900,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10900,1,2,0)
 ;;=2^Low Vision Aid Fitting, Telescopic/Compound Lens
 ;;^UTILITY(U,$J,358.3,10900,1,3,0)
 ;;=3^92355
 ;;^UTILITY(U,$J,358.3,10901,0)
 ;;=92370^^76^711^3^^^^1
 ;;^UTILITY(U,$J,358.3,10901,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10901,1,2,0)
 ;;=2^Repair/Refit Glasses
 ;;^UTILITY(U,$J,358.3,10901,1,3,0)
 ;;=3^92370
 ;;^UTILITY(U,$J,358.3,10902,0)
 ;;=92371^^76^711^9^^^^1
 ;;^UTILITY(U,$J,358.3,10902,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10902,1,2,0)
 ;;=2^Repair/Refit Glasses for Aphakia
