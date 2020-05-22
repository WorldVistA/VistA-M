IBDEI0DY ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,5946,1,3,0)
 ;;=3^Intravas US,Non/Cor Vsl,Diag/Thera Interv,1st Vsl
 ;;^UTILITY(U,$J,358.3,5947,0)
 ;;=37253^^52^386^25^^^^1
 ;;^UTILITY(U,$J,358.3,5947,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5947,1,2,0)
 ;;=2^37253
 ;;^UTILITY(U,$J,358.3,5947,1,3,0)
 ;;=3^Intravas US,Non/Cor Vsl,Dx/Ther Interv,Ea Addl Vsl
 ;;^UTILITY(U,$J,358.3,5948,0)
 ;;=36901^^52^386^8^^^^1
 ;;^UTILITY(U,$J,358.3,5948,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5948,1,2,0)
 ;;=2^36901
 ;;^UTILITY(U,$J,358.3,5948,1,3,0)
 ;;=3^Arteriovenous Shunt,Incl Rad S&I
 ;;^UTILITY(U,$J,358.3,5949,0)
 ;;=36222^^52^386^11^^^^1
 ;;^UTILITY(U,$J,358.3,5949,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5949,1,2,0)
 ;;=2^36222
 ;;^UTILITY(U,$J,358.3,5949,1,3,0)
 ;;=3^Cath Plcmnt Carotid,Extracranial,Unilat,Rad S&L
 ;;^UTILITY(U,$J,358.3,5950,0)
 ;;=36223^^52^386^12^^^^1
 ;;^UTILITY(U,$J,358.3,5950,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5950,1,2,0)
 ;;=2^36223
 ;;^UTILITY(U,$J,358.3,5950,1,3,0)
 ;;=3^Cath Plcmnt Carotid,Intracranial,Unilat,Rad S&L
 ;;^UTILITY(U,$J,358.3,5951,0)
 ;;=37246^^52^386^28^^^^1
 ;;^UTILITY(U,$J,358.3,5951,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5951,1,2,0)
 ;;=2^37246
 ;;^UTILITY(U,$J,358.3,5951,1,3,0)
 ;;=3^Perc Angioplasty,Intracran,Cor,Pulm,1st Artery
 ;;^UTILITY(U,$J,358.3,5952,0)
 ;;=37247^^52^386^29^^^^1
 ;;^UTILITY(U,$J,358.3,5952,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5952,1,2,0)
 ;;=2^37247
 ;;^UTILITY(U,$J,358.3,5952,1,3,0)
 ;;=3^Perc Angioplasty,Intracran,Cor,Pulm,Ea Addl Artery
 ;;^UTILITY(U,$J,358.3,5953,0)
 ;;=37248^^52^386^30^^^^1
 ;;^UTILITY(U,$J,358.3,5953,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5953,1,2,0)
 ;;=2^37248
 ;;^UTILITY(U,$J,358.3,5953,1,3,0)
 ;;=3^Perc Angioplasty,Venous,1st Vein
 ;;^UTILITY(U,$J,358.3,5954,0)
 ;;=37249^^52^386^31^^^^1
 ;;^UTILITY(U,$J,358.3,5954,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5954,1,2,0)
 ;;=2^37249
 ;;^UTILITY(U,$J,358.3,5954,1,3,0)
 ;;=3^Perc Angioplasty,Venous,Ea Addl Vein
 ;;^UTILITY(U,$J,358.3,5955,0)
 ;;=0236T^^52^386^56^^^^1
 ;;^UTILITY(U,$J,358.3,5955,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5955,1,2,0)
 ;;=2^0236T
 ;;^UTILITY(U,$J,358.3,5955,1,3,0)
 ;;=3^Trluml Perip Athrc Abd Aorta
 ;;^UTILITY(U,$J,358.3,5956,0)
 ;;=75825^^52^386^62^^^^1
 ;;^UTILITY(U,$J,358.3,5956,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5956,1,2,0)
 ;;=2^75825
 ;;^UTILITY(U,$J,358.3,5956,1,3,0)
 ;;=3^Vein X-Ray,Chest Inferior
 ;;^UTILITY(U,$J,358.3,5957,0)
 ;;=36005^^52^387^1^^^^1
 ;;^UTILITY(U,$J,358.3,5957,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5957,1,2,0)
 ;;=2^36005
 ;;^UTILITY(U,$J,358.3,5957,1,3,0)
 ;;=3^Contrast Venography
 ;;^UTILITY(U,$J,358.3,5958,0)
 ;;=92950^^52^388^1^^^^1
 ;;^UTILITY(U,$J,358.3,5958,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5958,1,2,0)
 ;;=2^92950
 ;;^UTILITY(U,$J,358.3,5958,1,3,0)
 ;;=3^CPR
 ;;^UTILITY(U,$J,358.3,5959,0)
 ;;=92970^^52^388^2^^^^1
 ;;^UTILITY(U,$J,358.3,5959,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5959,1,2,0)
 ;;=2^92970
 ;;^UTILITY(U,$J,358.3,5959,1,3,0)
 ;;=3^Cardio Assist Dev Insert
 ;;^UTILITY(U,$J,358.3,5960,0)
 ;;=94760^^52^388^3^^^^1
 ;;^UTILITY(U,$J,358.3,5960,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5960,1,2,0)
 ;;=2^94760
 ;;^UTILITY(U,$J,358.3,5960,1,3,0)
 ;;=3^Measure Blood Oxygen Level,1 Time
 ;;^UTILITY(U,$J,358.3,5961,0)
 ;;=94761^^52^388^4^^^^1
