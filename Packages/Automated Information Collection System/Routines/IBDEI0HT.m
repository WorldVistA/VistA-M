IBDEI0HT ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,7757,1,4,0)
 ;;=4^C34.92
 ;;^UTILITY(U,$J,358.3,7757,2)
 ;;=^5000968
 ;;^UTILITY(U,$J,358.3,7758,0)
 ;;=I26.99^^63^500^16
 ;;^UTILITY(U,$J,358.3,7758,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7758,1,3,0)
 ;;=3^Pulmonary Embolism w/o Acute Cor Pulmonale
 ;;^UTILITY(U,$J,358.3,7758,1,4,0)
 ;;=4^I26.99
 ;;^UTILITY(U,$J,358.3,7758,2)
 ;;=^5007150
 ;;^UTILITY(U,$J,358.3,7759,0)
 ;;=R07.82^^63^500^5
 ;;^UTILITY(U,$J,358.3,7759,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7759,1,3,0)
 ;;=3^Intercostal Pain
 ;;^UTILITY(U,$J,358.3,7759,1,4,0)
 ;;=4^R07.82
 ;;^UTILITY(U,$J,358.3,7759,2)
 ;;=^5019199
 ;;^UTILITY(U,$J,358.3,7760,0)
 ;;=R07.89^^63^500^3
 ;;^UTILITY(U,$J,358.3,7760,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7760,1,3,0)
 ;;=3^Chest Pain,Other
 ;;^UTILITY(U,$J,358.3,7760,1,4,0)
 ;;=4^R07.89
 ;;^UTILITY(U,$J,358.3,7760,2)
 ;;=^5019200
 ;;^UTILITY(U,$J,358.3,7761,0)
 ;;=C34.11^^63^500^11
 ;;^UTILITY(U,$J,358.3,7761,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7761,1,3,0)
 ;;=3^Malig Neop Right Bronchus/Lung,Upper Lobe
 ;;^UTILITY(U,$J,358.3,7761,1,4,0)
 ;;=4^C34.11
 ;;^UTILITY(U,$J,358.3,7761,2)
 ;;=^5000961
 ;;^UTILITY(U,$J,358.3,7762,0)
 ;;=C34.12^^63^500^8
 ;;^UTILITY(U,$J,358.3,7762,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7762,1,3,0)
 ;;=3^Malig Neop Left Bronchus/Lung,Upper Lobe
 ;;^UTILITY(U,$J,358.3,7762,1,4,0)
 ;;=4^C34.12
 ;;^UTILITY(U,$J,358.3,7762,2)
 ;;=^5000962
 ;;^UTILITY(U,$J,358.3,7763,0)
 ;;=C34.31^^63^500^10
 ;;^UTILITY(U,$J,358.3,7763,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7763,1,3,0)
 ;;=3^Malig Neop Right Bronchus/Lung,Lower Lobe
 ;;^UTILITY(U,$J,358.3,7763,1,4,0)
 ;;=4^C34.31
 ;;^UTILITY(U,$J,358.3,7763,2)
 ;;=^5133321
 ;;^UTILITY(U,$J,358.3,7764,0)
 ;;=C34.32^^63^500^7
 ;;^UTILITY(U,$J,358.3,7764,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7764,1,3,0)
 ;;=3^Malig Neop Left Bronchus/Lung,Lower Lobe
 ;;^UTILITY(U,$J,358.3,7764,1,4,0)
 ;;=4^C34.32
 ;;^UTILITY(U,$J,358.3,7764,2)
 ;;=^5133322
 ;;^UTILITY(U,$J,358.3,7765,0)
 ;;=R06.03^^63^500^1
 ;;^UTILITY(U,$J,358.3,7765,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7765,1,3,0)
 ;;=3^Acute Respiratory Distress
 ;;^UTILITY(U,$J,358.3,7765,1,4,0)
 ;;=4^R06.03
 ;;^UTILITY(U,$J,358.3,7765,2)
 ;;=^5151591
 ;;^UTILITY(U,$J,358.3,7766,0)
 ;;=J95.2^^63^500^17
 ;;^UTILITY(U,$J,358.3,7766,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7766,1,3,0)
 ;;=3^Pulmonary Insufficiency,Acute,Following Nonthoracic Surgery
 ;;^UTILITY(U,$J,358.3,7766,1,4,0)
 ;;=4^J95.2
 ;;^UTILITY(U,$J,358.3,7766,2)
 ;;=^5008328
 ;;^UTILITY(U,$J,358.3,7767,0)
 ;;=J95.1^^63^500^18
 ;;^UTILITY(U,$J,358.3,7767,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7767,1,3,0)
 ;;=3^Pulmonary Insufficiency,Acute,Following Thoracic Surgery
 ;;^UTILITY(U,$J,358.3,7767,1,4,0)
 ;;=4^J95.1
 ;;^UTILITY(U,$J,358.3,7767,2)
 ;;=^5008327
 ;;^UTILITY(U,$J,358.3,7768,0)
 ;;=M47.12^^63^501^7
 ;;^UTILITY(U,$J,358.3,7768,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7768,1,3,0)
 ;;=3^Spondylosis w/ Myelopathy,Cervical Region
 ;;^UTILITY(U,$J,358.3,7768,1,4,0)
 ;;=4^M47.12
 ;;^UTILITY(U,$J,358.3,7768,2)
 ;;=^5012052
 ;;^UTILITY(U,$J,358.3,7769,0)
 ;;=M48.02^^63^501^4
 ;;^UTILITY(U,$J,358.3,7769,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7769,1,3,0)
 ;;=3^Spinal Stenosis,Cervical Region
 ;;^UTILITY(U,$J,358.3,7769,1,4,0)
 ;;=4^M48.02
 ;;^UTILITY(U,$J,358.3,7769,2)
 ;;=^5012089
