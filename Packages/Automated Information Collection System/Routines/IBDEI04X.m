IBDEI04X ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,1780,2)
 ;;=^5008174
 ;;^UTILITY(U,$J,358.3,1781,0)
 ;;=J15.211^^3^53^8
 ;;^UTILITY(U,$J,358.3,1781,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1781,1,3,0)
 ;;=3^Pneumonia due to methicillin suscep staph
 ;;^UTILITY(U,$J,358.3,1781,1,4,0)
 ;;=4^J15.211
 ;;^UTILITY(U,$J,358.3,1781,2)
 ;;=^336833
 ;;^UTILITY(U,$J,358.3,1782,0)
 ;;=J15.212^^3^53^6
 ;;^UTILITY(U,$J,358.3,1782,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1782,1,3,0)
 ;;=3^Pneumonia due to Methicillin resistant Staphylococcus aureus
 ;;^UTILITY(U,$J,358.3,1782,1,4,0)
 ;;=4^J15.212
 ;;^UTILITY(U,$J,358.3,1782,2)
 ;;=^336602
 ;;^UTILITY(U,$J,358.3,1783,0)
 ;;=J15.9^^3^53^1
 ;;^UTILITY(U,$J,358.3,1783,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1783,1,3,0)
 ;;=3^Bacterial Pneumonia,Unspec
 ;;^UTILITY(U,$J,358.3,1783,1,4,0)
 ;;=4^J15.9
 ;;^UTILITY(U,$J,358.3,1783,2)
 ;;=^5008178
 ;;^UTILITY(U,$J,358.3,1784,0)
 ;;=J18.9^^3^53^10
 ;;^UTILITY(U,$J,358.3,1784,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1784,1,3,0)
 ;;=3^Pneumonia, unspecified organism
 ;;^UTILITY(U,$J,358.3,1784,1,4,0)
 ;;=4^J18.9
 ;;^UTILITY(U,$J,358.3,1784,2)
 ;;=^95632
 ;;^UTILITY(U,$J,358.3,1785,0)
 ;;=J09.X1^^3^53^2
 ;;^UTILITY(U,$J,358.3,1785,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1785,1,3,0)
 ;;=3^Flu d/t ident novel influenza A virus w pneumonia
 ;;^UTILITY(U,$J,358.3,1785,1,4,0)
 ;;=4^J09.X1
 ;;^UTILITY(U,$J,358.3,1785,2)
 ;;=^5008144
 ;;^UTILITY(U,$J,358.3,1786,0)
 ;;=J09.X2^^3^53^3
 ;;^UTILITY(U,$J,358.3,1786,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1786,1,3,0)
 ;;=3^Flu d/t ident novel influenza A virus w oth resp manifest
 ;;^UTILITY(U,$J,358.3,1786,1,4,0)
 ;;=4^J09.X2
 ;;^UTILITY(U,$J,358.3,1786,2)
 ;;=^5008145
 ;;^UTILITY(U,$J,358.3,1787,0)
 ;;=J09.X3^^3^53^4
 ;;^UTILITY(U,$J,358.3,1787,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1787,1,3,0)
 ;;=3^Flu d/t ident novel influenza A virus w GI manifest
 ;;^UTILITY(U,$J,358.3,1787,1,4,0)
 ;;=4^J09.X3
 ;;^UTILITY(U,$J,358.3,1787,2)
 ;;=^5008146
 ;;^UTILITY(U,$J,358.3,1788,0)
 ;;=J09.X9^^3^53^5
 ;;^UTILITY(U,$J,358.3,1788,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1788,1,3,0)
 ;;=3^Flu d/t ident novel influenza A virus w oth manifest
 ;;^UTILITY(U,$J,358.3,1788,1,4,0)
 ;;=4^J09.X9
 ;;^UTILITY(U,$J,358.3,1788,2)
 ;;=^5008147
 ;;^UTILITY(U,$J,358.3,1789,0)
 ;;=I26.92^^3^54^7
 ;;^UTILITY(U,$J,358.3,1789,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1789,1,3,0)
 ;;=3^Saddle embolus of pulmonary artery w/o acute cor pulmonale
 ;;^UTILITY(U,$J,358.3,1789,1,4,0)
 ;;=4^I26.92
 ;;^UTILITY(U,$J,358.3,1789,2)
 ;;=^5007149
 ;;^UTILITY(U,$J,358.3,1790,0)
 ;;=I26.99^^3^54^4
 ;;^UTILITY(U,$J,358.3,1790,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1790,1,3,0)
 ;;=3^Pulmonary embolism without acute cor pulmonale NEC
 ;;^UTILITY(U,$J,358.3,1790,1,4,0)
 ;;=4^I26.99
 ;;^UTILITY(U,$J,358.3,1790,2)
 ;;=^5007150
 ;;^UTILITY(U,$J,358.3,1791,0)
 ;;=I27.0^^3^54^3
 ;;^UTILITY(U,$J,358.3,1791,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1791,1,3,0)
 ;;=3^Primary pulmonary hypertension
 ;;^UTILITY(U,$J,358.3,1791,1,4,0)
 ;;=4^I27.0
 ;;^UTILITY(U,$J,358.3,1791,2)
 ;;=^265310
 ;;^UTILITY(U,$J,358.3,1792,0)
 ;;=I27.2^^3^54^8
 ;;^UTILITY(U,$J,358.3,1792,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1792,1,3,0)
 ;;=3^Secondary pulmonary hypertension NEC
 ;;^UTILITY(U,$J,358.3,1792,1,4,0)
 ;;=4^I27.2
 ;;^UTILITY(U,$J,358.3,1792,2)
 ;;=^5007151
 ;;^UTILITY(U,$J,358.3,1793,0)
 ;;=I27.89^^3^54^6
 ;;^UTILITY(U,$J,358.3,1793,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1793,1,3,0)
 ;;=3^Pulmonary heart diseases NEC
