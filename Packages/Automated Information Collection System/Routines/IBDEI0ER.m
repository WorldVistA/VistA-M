IBDEI0ER ; ; 12-AUG-2014
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,7123,1,4,0)
 ;;=4^185.
 ;;^UTILITY(U,$J,358.3,7123,1,5,0)
 ;;=5^Ca Prostate
 ;;^UTILITY(U,$J,358.3,7123,2)
 ;;=Prostate CA^99481
 ;;^UTILITY(U,$J,358.3,7124,0)
 ;;=189.0^^55^577^48
 ;;^UTILITY(U,$J,358.3,7124,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7124,1,4,0)
 ;;=4^189.0
 ;;^UTILITY(U,$J,358.3,7124,1,5,0)
 ;;=5^Ca Renal
 ;;^UTILITY(U,$J,358.3,7124,2)
 ;;=Renal Cancer^73523
 ;;^UTILITY(U,$J,358.3,7125,0)
 ;;=189.1^^55^577^49
 ;;^UTILITY(U,$J,358.3,7125,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7125,1,4,0)
 ;;=4^189.1
 ;;^UTILITY(U,$J,358.3,7125,1,5,0)
 ;;=5^Ca Renal Pelvis
 ;;^UTILITY(U,$J,358.3,7125,2)
 ;;=   ^267264
 ;;^UTILITY(U,$J,358.3,7126,0)
 ;;=171.9^^55^577^113
 ;;^UTILITY(U,$J,358.3,7126,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7126,1,4,0)
 ;;=4^171.9
 ;;^UTILITY(U,$J,358.3,7126,1,5,0)
 ;;=5^Soft Tissue Sarcoma
 ;;^UTILITY(U,$J,358.3,7126,2)
 ;;=^267165
 ;;^UTILITY(U,$J,358.3,7127,0)
 ;;=186.9^^55^577^52
 ;;^UTILITY(U,$J,358.3,7127,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7127,1,4,0)
 ;;=4^186.9
 ;;^UTILITY(U,$J,358.3,7127,1,5,0)
 ;;=5^Ca Testicular
 ;;^UTILITY(U,$J,358.3,7127,2)
 ;;=^267242
 ;;^UTILITY(U,$J,358.3,7128,0)
 ;;=198.7^^55^577^7
 ;;^UTILITY(U,$J,358.3,7128,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7128,1,4,0)
 ;;=4^198.7
 ;;^UTILITY(U,$J,358.3,7128,1,5,0)
 ;;=5^Adrenal Metastasis
 ;;^UTILITY(U,$J,358.3,7128,2)
 ;;=^267337
 ;;^UTILITY(U,$J,358.3,7129,0)
 ;;=198.5^^55^577^95
 ;;^UTILITY(U,$J,358.3,7129,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7129,1,4,0)
 ;;=4^198.5
 ;;^UTILITY(U,$J,358.3,7129,1,5,0)
 ;;=5^Mets to Bone or Bone Marrow
 ;;^UTILITY(U,$J,358.3,7129,2)
 ;;=^267336
 ;;^UTILITY(U,$J,358.3,7130,0)
 ;;=198.3^^55^577^96
 ;;^UTILITY(U,$J,358.3,7130,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7130,1,4,0)
 ;;=4^198.3
 ;;^UTILITY(U,$J,358.3,7130,1,5,0)
 ;;=5^Mets to Brain
 ;;^UTILITY(U,$J,358.3,7130,2)
 ;;=Brain Metatastasis^267334
 ;;^UTILITY(U,$J,358.3,7131,0)
 ;;=197.7^^55^577^39
 ;;^UTILITY(U,$J,358.3,7131,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7131,1,4,0)
 ;;=4^197.7
 ;;^UTILITY(U,$J,358.3,7131,1,5,0)
 ;;=5^Ca Liver, Secondary
 ;;^UTILITY(U,$J,358.3,7131,2)
 ;;=CA Liver, Secondary^267328
 ;;^UTILITY(U,$J,358.3,7132,0)
 ;;=197.0^^55^577^97
 ;;^UTILITY(U,$J,358.3,7132,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7132,1,4,0)
 ;;=4^197.0
 ;;^UTILITY(U,$J,358.3,7132,1,5,0)
 ;;=5^Mets to Lung
 ;;^UTILITY(U,$J,358.3,7132,2)
 ;;=Mets to Lung^267322
 ;;^UTILITY(U,$J,358.3,7133,0)
 ;;=196.2^^55^577^98
 ;;^UTILITY(U,$J,358.3,7133,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7133,1,4,0)
 ;;=4^196.2
 ;;^UTILITY(U,$J,358.3,7133,1,5,0)
 ;;=5^Mets to Lymph Nodes,Abdominal
 ;;^UTILITY(U,$J,358.3,7133,2)
 ;;=^267316
 ;;^UTILITY(U,$J,358.3,7134,0)
 ;;=196.3^^55^577^99
 ;;^UTILITY(U,$J,358.3,7134,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7134,1,4,0)
 ;;=4^196.3
 ;;^UTILITY(U,$J,358.3,7134,1,5,0)
 ;;=5^Mets to Lymph Nodes,Axillary Or Brachial
 ;;^UTILITY(U,$J,358.3,7134,2)
 ;;=^267317
 ;;^UTILITY(U,$J,358.3,7135,0)
 ;;=196.0^^55^577^100
 ;;^UTILITY(U,$J,358.3,7135,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7135,1,4,0)
 ;;=4^196.0
 ;;^UTILITY(U,$J,358.3,7135,1,5,0)
 ;;=5^Mets to Lymph Nodes,Cervical
 ;;^UTILITY(U,$J,358.3,7135,2)
 ;;=Lymph Nodes^267314
 ;;^UTILITY(U,$J,358.3,7136,0)
 ;;=196.1^^55^577^101
 ;;^UTILITY(U,$J,358.3,7136,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7136,1,4,0)
 ;;=4^196.1
 ;;^UTILITY(U,$J,358.3,7136,1,5,0)
 ;;=5^Mets to Lymph Nodes,Mediastinal 
 ;;^UTILITY(U,$J,358.3,7136,2)
 ;;=Lymph Nodes^267315
 ;;^UTILITY(U,$J,358.3,7137,0)
 ;;=196.8^^55^577^102