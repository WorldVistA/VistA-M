IBDEI0BD ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,4835,2)
 ;;=^5008288
 ;;^UTILITY(U,$J,358.3,4836,0)
 ;;=J11.00^^37^320^3
 ;;^UTILITY(U,$J,358.3,4836,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4836,1,3,0)
 ;;=3^Flu d/t Flu Virus w/ Unspec Type of Pneumonia
 ;;^UTILITY(U,$J,358.3,4836,1,4,0)
 ;;=4^J11.00
 ;;^UTILITY(U,$J,358.3,4836,2)
 ;;=^5008156
 ;;^UTILITY(U,$J,358.3,4837,0)
 ;;=C34.91^^37^320^8
 ;;^UTILITY(U,$J,358.3,4837,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4837,1,3,0)
 ;;=3^Malig Neop Right Bronchus/Lung
 ;;^UTILITY(U,$J,358.3,4837,1,4,0)
 ;;=4^C34.91
 ;;^UTILITY(U,$J,358.3,4837,2)
 ;;=^5000967
 ;;^UTILITY(U,$J,358.3,4838,0)
 ;;=C34.92^^37^320^5
 ;;^UTILITY(U,$J,358.3,4838,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4838,1,3,0)
 ;;=3^Malig Neop Left Bronchus/Lung
 ;;^UTILITY(U,$J,358.3,4838,1,4,0)
 ;;=4^C34.92
 ;;^UTILITY(U,$J,358.3,4838,2)
 ;;=^5000968
 ;;^UTILITY(U,$J,358.3,4839,0)
 ;;=I26.99^^37^320^15
 ;;^UTILITY(U,$J,358.3,4839,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4839,1,3,0)
 ;;=3^Pulmonary Embolism w/o Acute Cor Pulmonale
 ;;^UTILITY(U,$J,358.3,4839,1,4,0)
 ;;=4^I26.99
 ;;^UTILITY(U,$J,358.3,4839,2)
 ;;=^5007150
 ;;^UTILITY(U,$J,358.3,4840,0)
 ;;=R07.82^^37^320^4
 ;;^UTILITY(U,$J,358.3,4840,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4840,1,3,0)
 ;;=3^Intercostal Pain
 ;;^UTILITY(U,$J,358.3,4840,1,4,0)
 ;;=4^R07.82
 ;;^UTILITY(U,$J,358.3,4840,2)
 ;;=^5019199
 ;;^UTILITY(U,$J,358.3,4841,0)
 ;;=R07.89^^37^320^2
 ;;^UTILITY(U,$J,358.3,4841,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4841,1,3,0)
 ;;=3^Chest Pain,Other
 ;;^UTILITY(U,$J,358.3,4841,1,4,0)
 ;;=4^R07.89
 ;;^UTILITY(U,$J,358.3,4841,2)
 ;;=^5019200
 ;;^UTILITY(U,$J,358.3,4842,0)
 ;;=C34.11^^37^320^10
 ;;^UTILITY(U,$J,358.3,4842,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4842,1,3,0)
 ;;=3^Malig Neop Right Bronchus/Lung,Upper Lobe
 ;;^UTILITY(U,$J,358.3,4842,1,4,0)
 ;;=4^C34.11
 ;;^UTILITY(U,$J,358.3,4842,2)
 ;;=^5000961
 ;;^UTILITY(U,$J,358.3,4843,0)
 ;;=C34.12^^37^320^7
 ;;^UTILITY(U,$J,358.3,4843,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4843,1,3,0)
 ;;=3^Malig Neop Left Bronchus/Lung,Upper Lobe
 ;;^UTILITY(U,$J,358.3,4843,1,4,0)
 ;;=4^C34.12
 ;;^UTILITY(U,$J,358.3,4843,2)
 ;;=^5000962
 ;;^UTILITY(U,$J,358.3,4844,0)
 ;;=C34.31^^37^320^9
 ;;^UTILITY(U,$J,358.3,4844,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4844,1,3,0)
 ;;=3^Malig Neop Right Bronchus/Lung,Lower Lobe
 ;;^UTILITY(U,$J,358.3,4844,1,4,0)
 ;;=4^C34.31
 ;;^UTILITY(U,$J,358.3,4844,2)
 ;;=^5133321
 ;;^UTILITY(U,$J,358.3,4845,0)
 ;;=C34.32^^37^320^6
 ;;^UTILITY(U,$J,358.3,4845,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4845,1,3,0)
 ;;=3^Malig Neop Left Bronchus/Lung,Lower Lobe
 ;;^UTILITY(U,$J,358.3,4845,1,4,0)
 ;;=4^C34.32
 ;;^UTILITY(U,$J,358.3,4845,2)
 ;;=^5133322
 ;;^UTILITY(U,$J,358.3,4846,0)
 ;;=M47.12^^37^321^4
 ;;^UTILITY(U,$J,358.3,4846,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4846,1,3,0)
 ;;=3^Spondylosis w/ Myelopathy,Cervical Region
 ;;^UTILITY(U,$J,358.3,4846,1,4,0)
 ;;=4^M47.12
 ;;^UTILITY(U,$J,358.3,4846,2)
 ;;=^5012052
 ;;^UTILITY(U,$J,358.3,4847,0)
 ;;=M17.9^^37^321^1
 ;;^UTILITY(U,$J,358.3,4847,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4847,1,3,0)
 ;;=3^Osteoarthritis of Knee,Unspec
 ;;^UTILITY(U,$J,358.3,4847,1,4,0)
 ;;=4^M17.9
 ;;^UTILITY(U,$J,358.3,4847,2)
 ;;=^5010794
 ;;^UTILITY(U,$J,358.3,4848,0)
 ;;=M48.06^^37^321^3
 ;;^UTILITY(U,$J,358.3,4848,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4848,1,3,0)
 ;;=3^Spinal Stenosis,Lumbar Region
 ;;^UTILITY(U,$J,358.3,4848,1,4,0)
 ;;=4^M48.06
 ;;^UTILITY(U,$J,358.3,4848,2)
 ;;=^5012093
 ;;^UTILITY(U,$J,358.3,4849,0)
 ;;=M48.02^^37^321^2
