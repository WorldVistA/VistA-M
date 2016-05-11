IBDEI0A1 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,4455,0)
 ;;=L20.81^^21^278^7
 ;;^UTILITY(U,$J,358.3,4455,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4455,1,3,0)
 ;;=3^Neurodermatitis,Atopic
 ;;^UTILITY(U,$J,358.3,4455,1,4,0)
 ;;=4^L20.81
 ;;^UTILITY(U,$J,358.3,4455,2)
 ;;=^5009108
 ;;^UTILITY(U,$J,358.3,4456,0)
 ;;=D48.5^^21^278^6
 ;;^UTILITY(U,$J,358.3,4456,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4456,1,3,0)
 ;;=3^Neoplasm,Skin,Uncertain Behavior
 ;;^UTILITY(U,$J,358.3,4456,1,4,0)
 ;;=4^D48.5
 ;;^UTILITY(U,$J,358.3,4456,2)
 ;;=^267777
 ;;^UTILITY(U,$J,358.3,4457,0)
 ;;=D49.2^^21^278^5
 ;;^UTILITY(U,$J,358.3,4457,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4457,1,3,0)
 ;;=3^Neoplasm,Bone/Soft Tissue/Skin,Unspec Behavior
 ;;^UTILITY(U,$J,358.3,4457,1,4,0)
 ;;=4^D49.2
 ;;^UTILITY(U,$J,358.3,4457,2)
 ;;=^5002272
 ;;^UTILITY(U,$J,358.3,4458,0)
 ;;=L60.0^^21^278^3
 ;;^UTILITY(U,$J,358.3,4458,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4458,1,3,0)
 ;;=3^Nail,Ingrowing
 ;;^UTILITY(U,$J,358.3,4458,1,4,0)
 ;;=4^L60.0
 ;;^UTILITY(U,$J,358.3,4458,2)
 ;;=^5009234
 ;;^UTILITY(U,$J,358.3,4459,0)
 ;;=L60.9^^21^278^1
 ;;^UTILITY(U,$J,358.3,4459,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4459,1,3,0)
 ;;=3^Nail Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,4459,1,4,0)
 ;;=4^L60.9
 ;;^UTILITY(U,$J,358.3,4459,2)
 ;;=^5009240
 ;;^UTILITY(U,$J,358.3,4460,0)
 ;;=Z91.19^^21^278^9
 ;;^UTILITY(U,$J,358.3,4460,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4460,1,3,0)
 ;;=3^Noncompliance w/ Medical Treatment/Regimen
 ;;^UTILITY(U,$J,358.3,4460,1,4,0)
 ;;=4^Z91.19
 ;;^UTILITY(U,$J,358.3,4460,2)
 ;;=^5063618
 ;;^UTILITY(U,$J,358.3,4461,0)
 ;;=E80.1^^21^279^20
 ;;^UTILITY(U,$J,358.3,4461,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4461,1,3,0)
 ;;=3^Porphyria Cutanea Tarda
 ;;^UTILITY(U,$J,358.3,4461,1,4,0)
 ;;=4^E80.1
 ;;^UTILITY(U,$J,358.3,4461,2)
 ;;=^5002982
 ;;^UTILITY(U,$J,358.3,4462,0)
 ;;=L56.4^^21^279^19
 ;;^UTILITY(U,$J,358.3,4462,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4462,1,3,0)
 ;;=3^Polymorphous Light Eruption
 ;;^UTILITY(U,$J,358.3,4462,1,4,0)
 ;;=4^L56.4
 ;;^UTILITY(U,$J,358.3,4462,2)
 ;;=^5009218
 ;;^UTILITY(U,$J,358.3,4463,0)
 ;;=L10.0^^21^279^4
 ;;^UTILITY(U,$J,358.3,4463,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4463,1,3,0)
 ;;=3^Pemphigus Vulgaris
 ;;^UTILITY(U,$J,358.3,4463,1,4,0)
 ;;=4^L10.0
 ;;^UTILITY(U,$J,358.3,4463,2)
 ;;=^91129
 ;;^UTILITY(U,$J,358.3,4464,0)
 ;;=L41.3^^21^279^2
 ;;^UTILITY(U,$J,358.3,4464,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4464,1,3,0)
 ;;=3^Parapsoriasis,Small Plague
 ;;^UTILITY(U,$J,358.3,4464,1,4,0)
 ;;=4^L41.3
 ;;^UTILITY(U,$J,358.3,4464,2)
 ;;=^5009173
 ;;^UTILITY(U,$J,358.3,4465,0)
 ;;=L41.4^^21^279^1
 ;;^UTILITY(U,$J,358.3,4465,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4465,1,3,0)
 ;;=3^Parapsoriasis,Large Plague
 ;;^UTILITY(U,$J,358.3,4465,1,4,0)
 ;;=4^L41.4
 ;;^UTILITY(U,$J,358.3,4465,2)
 ;;=^5009174
 ;;^UTILITY(U,$J,358.3,4466,0)
 ;;=L28.1^^21^279^30
 ;;^UTILITY(U,$J,358.3,4466,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4466,1,3,0)
 ;;=3^Prurigo Nodularis
 ;;^UTILITY(U,$J,358.3,4466,1,4,0)
 ;;=4^L28.1
 ;;^UTILITY(U,$J,358.3,4466,2)
 ;;=^5009148
 ;;^UTILITY(U,$J,358.3,4467,0)
 ;;=H61.001^^21^279^6
 ;;^UTILITY(U,$J,358.3,4467,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4467,1,3,0)
 ;;=3^Perichondritis Right External Ear,Unspec
 ;;^UTILITY(U,$J,358.3,4467,1,4,0)
 ;;=4^H61.001
 ;;^UTILITY(U,$J,358.3,4467,2)
 ;;=^5006499
 ;;^UTILITY(U,$J,358.3,4468,0)
 ;;=H61.002^^21^279^5
 ;;^UTILITY(U,$J,358.3,4468,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4468,1,3,0)
 ;;=3^Perichondritis Left External Ear,Unspec
