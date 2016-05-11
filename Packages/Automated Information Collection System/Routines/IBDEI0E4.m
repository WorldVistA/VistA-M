IBDEI0E4 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,6492,0)
 ;;=C94.41^^30^396^16
 ;;^UTILITY(U,$J,358.3,6492,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6492,1,3,0)
 ;;=3^Acute Panmyelosis w/ Myelofibrosis,In Remission
 ;;^UTILITY(U,$J,358.3,6492,1,4,0)
 ;;=4^C94.41
 ;;^UTILITY(U,$J,358.3,6492,2)
 ;;=^5001844
 ;;^UTILITY(U,$J,358.3,6493,0)
 ;;=D62.^^30^396^18
 ;;^UTILITY(U,$J,358.3,6493,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6493,1,3,0)
 ;;=3^Acute Posthemorrhagic Anemia
 ;;^UTILITY(U,$J,358.3,6493,1,4,0)
 ;;=4^D62.
 ;;^UTILITY(U,$J,358.3,6493,2)
 ;;=^267986
 ;;^UTILITY(U,$J,358.3,6494,0)
 ;;=C92.41^^30^396^19
 ;;^UTILITY(U,$J,358.3,6494,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6494,1,3,0)
 ;;=3^Acute Promyelocytic Leukemia,In Remission
 ;;^UTILITY(U,$J,358.3,6494,1,4,0)
 ;;=4^C92.41
 ;;^UTILITY(U,$J,358.3,6494,2)
 ;;=^5001802
 ;;^UTILITY(U,$J,358.3,6495,0)
 ;;=C92.40^^30^396^20
 ;;^UTILITY(U,$J,358.3,6495,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6495,1,3,0)
 ;;=3^Acute Promyelocytic Leukemia,Not in Remission
 ;;^UTILITY(U,$J,358.3,6495,1,4,0)
 ;;=4^C92.40
 ;;^UTILITY(U,$J,358.3,6495,2)
 ;;=^5001801
 ;;^UTILITY(U,$J,358.3,6496,0)
 ;;=D56.0^^30^396^21
 ;;^UTILITY(U,$J,358.3,6496,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6496,1,3,0)
 ;;=3^Alpha Thalassemia
 ;;^UTILITY(U,$J,358.3,6496,1,4,0)
 ;;=4^D56.0
 ;;^UTILITY(U,$J,358.3,6496,2)
 ;;=^340494
 ;;^UTILITY(U,$J,358.3,6497,0)
 ;;=D63.1^^30^396^23
 ;;^UTILITY(U,$J,358.3,6497,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6497,1,3,0)
 ;;=3^Anemia in Chronic Kidney Disease
 ;;^UTILITY(U,$J,358.3,6497,1,4,0)
 ;;=4^D63.1
 ;;^UTILITY(U,$J,358.3,6497,2)
 ;;=^332908
 ;;^UTILITY(U,$J,358.3,6498,0)
 ;;=D63.0^^30^396^24
 ;;^UTILITY(U,$J,358.3,6498,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6498,1,3,0)
 ;;=3^Anemia in Neoplastic Disease
 ;;^UTILITY(U,$J,358.3,6498,1,4,0)
 ;;=4^D63.0
 ;;^UTILITY(U,$J,358.3,6498,2)
 ;;=^321978
 ;;^UTILITY(U,$J,358.3,6499,0)
 ;;=D63.8^^30^396^22
 ;;^UTILITY(U,$J,358.3,6499,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6499,1,3,0)
 ;;=3^Anemia in Chronic Diseases Classified Elsewhere
 ;;^UTILITY(U,$J,358.3,6499,1,4,0)
 ;;=4^D63.8
 ;;^UTILITY(U,$J,358.3,6499,2)
 ;;=^5002343
 ;;^UTILITY(U,$J,358.3,6500,0)
 ;;=C22.3^^30^396^25
 ;;^UTILITY(U,$J,358.3,6500,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6500,1,3,0)
 ;;=3^Angiosarcoma of Liver
 ;;^UTILITY(U,$J,358.3,6500,1,4,0)
 ;;=4^C22.3
 ;;^UTILITY(U,$J,358.3,6500,2)
 ;;=^5000936
 ;;^UTILITY(U,$J,358.3,6501,0)
 ;;=D61.9^^30^396^26
 ;;^UTILITY(U,$J,358.3,6501,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6501,1,3,0)
 ;;=3^Aplastic Anemia,Unspec
 ;;^UTILITY(U,$J,358.3,6501,1,4,0)
 ;;=4^D61.9
 ;;^UTILITY(U,$J,358.3,6501,2)
 ;;=^5002342
 ;;^UTILITY(U,$J,358.3,6502,0)
 ;;=D56.1^^30^396^28
 ;;^UTILITY(U,$J,358.3,6502,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6502,1,3,0)
 ;;=3^Beta Thalassemia
 ;;^UTILITY(U,$J,358.3,6502,1,4,0)
 ;;=4^D56.1
 ;;^UTILITY(U,$J,358.3,6502,2)
 ;;=^340495
 ;;^UTILITY(U,$J,358.3,6503,0)
 ;;=C83.79^^30^396^29
 ;;^UTILITY(U,$J,358.3,6503,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6503,1,3,0)
 ;;=3^Burkitt Lymphoma,Extranodal/Solid Organ Sites
 ;;^UTILITY(U,$J,358.3,6503,1,4,0)
 ;;=4^C83.79
 ;;^UTILITY(U,$J,358.3,6503,2)
 ;;=^5001600
 ;;^UTILITY(U,$J,358.3,6504,0)
 ;;=C83.70^^30^396^30
 ;;^UTILITY(U,$J,358.3,6504,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6504,1,3,0)
 ;;=3^Burkitt Lymphoma,Unspec Site
 ;;^UTILITY(U,$J,358.3,6504,1,4,0)
 ;;=4^C83.70
 ;;^UTILITY(U,$J,358.3,6504,2)
 ;;=^5001591
 ;;^UTILITY(U,$J,358.3,6505,0)
 ;;=D09.0^^30^396^37
 ;;^UTILITY(U,$J,358.3,6505,1,0)
 ;;=^358.31IA^4^2
