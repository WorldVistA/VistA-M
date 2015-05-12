IBDEI048 ; ; 09-FEB-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,5160,0)
 ;;=C79.2^^22^224^17
 ;;^UTILITY(U,$J,358.3,5160,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5160,1,3,0)
 ;;=3^Secondary Malig Neop of Skin
 ;;^UTILITY(U,$J,358.3,5160,1,4,0)
 ;;=4^C79.2
 ;;^UTILITY(U,$J,358.3,5160,2)
 ;;=^267333
 ;;^UTILITY(U,$J,358.3,5161,0)
 ;;=C79.19^^22^224^18
 ;;^UTILITY(U,$J,358.3,5161,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5161,1,3,0)
 ;;=3^Secondary Malig Neop of Urinary Organs
 ;;^UTILITY(U,$J,358.3,5161,1,4,0)
 ;;=4^C79.19
 ;;^UTILITY(U,$J,358.3,5161,2)
 ;;=^267332
 ;;^UTILITY(U,$J,358.3,5162,0)
 ;;=C79.01^^22^224^14
 ;;^UTILITY(U,$J,358.3,5162,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5162,1,3,0)
 ;;=3^Secondary Malig Neop of Right Kidney/Renal Pelvis
 ;;^UTILITY(U,$J,358.3,5162,1,4,0)
 ;;=4^C79.01
 ;;^UTILITY(U,$J,358.3,5162,2)
 ;;=^5001343
 ;;^UTILITY(U,$J,358.3,5163,0)
 ;;=C79.10^^22^224^19
 ;;^UTILITY(U,$J,358.3,5163,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5163,1,3,0)
 ;;=3^Secondary Malig Neop of Urinary Organs,Unspec
 ;;^UTILITY(U,$J,358.3,5163,1,4,0)
 ;;=4^C79.10
 ;;^UTILITY(U,$J,358.3,5163,2)
 ;;=^5001345
 ;;^UTILITY(U,$J,358.3,5164,0)
 ;;=C79.61^^22^224^16
 ;;^UTILITY(U,$J,358.3,5164,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5164,1,3,0)
 ;;=3^Secondary Malig Neop of Right Ovary
 ;;^UTILITY(U,$J,358.3,5164,1,4,0)
 ;;=4^C79.61
 ;;^UTILITY(U,$J,358.3,5164,2)
 ;;=^5001353
 ;;^UTILITY(U,$J,358.3,5165,0)
 ;;=C01.^^22^225^2
 ;;^UTILITY(U,$J,358.3,5165,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5165,1,3,0)
 ;;=3^Malig Neop of Base of Tongue
 ;;^UTILITY(U,$J,358.3,5165,1,4,0)
 ;;=4^C01.
 ;;^UTILITY(U,$J,358.3,5165,2)
 ;;=^266996
 ;;^UTILITY(U,$J,358.3,5166,0)
 ;;=C02.0^^22^225^4
 ;;^UTILITY(U,$J,358.3,5166,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5166,1,3,0)
 ;;=3^Malig Neop of Dorsal Surface of Tongue
 ;;^UTILITY(U,$J,358.3,5166,1,4,0)
 ;;=4^C02.0
 ;;^UTILITY(U,$J,358.3,5166,2)
 ;;=^266997
 ;;^UTILITY(U,$J,358.3,5167,0)
 ;;=C02.1^^22^225^3
 ;;^UTILITY(U,$J,358.3,5167,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5167,1,3,0)
 ;;=3^Malig Neop of Border of Tongue
 ;;^UTILITY(U,$J,358.3,5167,1,4,0)
 ;;=4^C02.1
 ;;^UTILITY(U,$J,358.3,5167,2)
 ;;=^5000888
 ;;^UTILITY(U,$J,358.3,5168,0)
 ;;=C02.2^^22^225^22
 ;;^UTILITY(U,$J,358.3,5168,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5168,1,3,0)
 ;;=3^Malig Neop of Ventral Surface of Tongue
 ;;^UTILITY(U,$J,358.3,5168,1,4,0)
 ;;=4^C02.2
 ;;^UTILITY(U,$J,358.3,5168,2)
 ;;=^266999
 ;;^UTILITY(U,$J,358.3,5169,0)
 ;;=C02.3^^22^225^1
 ;;^UTILITY(U,$J,358.3,5169,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5169,1,3,0)
 ;;=3^Malig Neop of Anterior 2/3 of Tongue,Part Unspec
 ;;^UTILITY(U,$J,358.3,5169,1,4,0)
 ;;=4^C02.3
 ;;^UTILITY(U,$J,358.3,5169,2)
 ;;=^5000889
 ;;^UTILITY(U,$J,358.3,5170,0)
 ;;=C02.8^^22^225^17
 ;;^UTILITY(U,$J,358.3,5170,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5170,1,3,0)
 ;;=3^Malig Neop of Overlapping Sites of Tongue
 ;;^UTILITY(U,$J,358.3,5170,1,4,0)
 ;;=4^C02.8
 ;;^UTILITY(U,$J,358.3,5170,2)
 ;;=^5000890
 ;;^UTILITY(U,$J,358.3,5171,0)
 ;;=C02.4^^22^225^9
 ;;^UTILITY(U,$J,358.3,5171,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5171,1,3,0)
 ;;=3^Malig Neop of Lingual Tonsil
 ;;^UTILITY(U,$J,358.3,5171,1,4,0)
 ;;=4^C02.4
 ;;^UTILITY(U,$J,358.3,5171,2)
 ;;=^267002
 ;;^UTILITY(U,$J,358.3,5172,0)
 ;;=C00.0^^22^225^6
 ;;^UTILITY(U,$J,358.3,5172,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5172,1,3,0)
 ;;=3^Malig Neop of External Upper Lip
 ;;^UTILITY(U,$J,358.3,5172,1,4,0)
 ;;=4^C00.0
 ;;^UTILITY(U,$J,358.3,5172,2)
 ;;=^5000882
 ;;^UTILITY(U,$J,358.3,5173,0)
 ;;=C00.1^^22^225^5
 ;;^UTILITY(U,$J,358.3,5173,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5173,1,3,0)
 ;;=3^Malig Neop of External Lower Lip
 ;;^UTILITY(U,$J,358.3,5173,1,4,0)
 ;;=4^C00.1
 ;;^UTILITY(U,$J,358.3,5173,2)
 ;;=^5000883
 ;;^UTILITY(U,$J,358.3,5174,0)
 ;;=C00.3^^22^225^21
 ;;^UTILITY(U,$J,358.3,5174,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5174,1,3,0)
 ;;=3^Malig Neop of Upper Lip,Inner Aspect
 ;;^UTILITY(U,$J,358.3,5174,1,4,0)
 ;;=4^C00.3
 ;;^UTILITY(U,$J,358.3,5174,2)
 ;;=^266989
 ;;^UTILITY(U,$J,358.3,5175,0)
 ;;=C00.4^^22^225^12
 ;;^UTILITY(U,$J,358.3,5175,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5175,1,3,0)
 ;;=3^Malig Neop of Lower Lip,Inner Aspect
 ;;^UTILITY(U,$J,358.3,5175,1,4,0)
 ;;=4^C00.4
 ;;^UTILITY(U,$J,358.3,5175,2)
 ;;=^266990
 ;;^UTILITY(U,$J,358.3,5176,0)
 ;;=C00.9^^22^225^10
 ;;^UTILITY(U,$J,358.3,5176,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5176,1,3,0)
 ;;=3^Malig Neop of Lip,Unspec
 ;;^UTILITY(U,$J,358.3,5176,1,4,0)
 ;;=4^C00.9
 ;;^UTILITY(U,$J,358.3,5176,2)
 ;;=^5000887
 ;;^UTILITY(U,$J,358.3,5177,0)
 ;;=C02.9^^22^225^19
 ;;^UTILITY(U,$J,358.3,5177,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5177,1,3,0)
 ;;=3^Malig Neop of Tongue,Unspec
 ;;^UTILITY(U,$J,358.3,5177,1,4,0)
 ;;=4^C02.9
 ;;^UTILITY(U,$J,358.3,5177,2)
 ;;=^5000891
 ;;^UTILITY(U,$J,358.3,5178,0)
 ;;=C03.0^^22^225^20
 ;;^UTILITY(U,$J,358.3,5178,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5178,1,3,0)
 ;;=3^Malig Neop of Upper Gum
 ;;^UTILITY(U,$J,358.3,5178,1,4,0)
 ;;=4^C03.0
 ;;^UTILITY(U,$J,358.3,5178,2)
 ;;=^267011
 ;;^UTILITY(U,$J,358.3,5179,0)
 ;;=C03.1^^22^225^11
 ;;^UTILITY(U,$J,358.3,5179,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5179,1,3,0)
 ;;=3^Malig Neop of Lower Gum
 ;;^UTILITY(U,$J,358.3,5179,1,4,0)
 ;;=4^C03.1
 ;;^UTILITY(U,$J,358.3,5179,2)
 ;;=^267012
 ;;^UTILITY(U,$J,358.3,5180,0)
 ;;=C03.9^^22^225^8
 ;;^UTILITY(U,$J,358.3,5180,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5180,1,3,0)
 ;;=3^Malig Neop of Gum,Unspec
 ;;^UTILITY(U,$J,358.3,5180,1,4,0)
 ;;=4^C03.9
 ;;^UTILITY(U,$J,358.3,5180,2)
 ;;=^5000892
 ;;^UTILITY(U,$J,358.3,5181,0)
 ;;=C04.0^^22^225^13
 ;;^UTILITY(U,$J,358.3,5181,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5181,1,3,0)
 ;;=3^Malig Neop of Mouth,Anterior Floor
 ;;^UTILITY(U,$J,358.3,5181,1,4,0)
 ;;=4^C04.0
 ;;^UTILITY(U,$J,358.3,5181,2)
 ;;=^5000893
 ;;^UTILITY(U,$J,358.3,5182,0)
 ;;=C04.1^^22^225^14
 ;;^UTILITY(U,$J,358.3,5182,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5182,1,3,0)
 ;;=3^Malig Neop of Mouth,Lateral Floor
 ;;^UTILITY(U,$J,358.3,5182,1,4,0)
 ;;=4^C04.1
 ;;^UTILITY(U,$J,358.3,5182,2)
 ;;=^5000894
 ;;^UTILITY(U,$J,358.3,5183,0)
 ;;=C04.8^^22^225^15
 ;;^UTILITY(U,$J,358.3,5183,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5183,1,3,0)
 ;;=3^Malig Neop of Overlapping Site of Floor of Mouth
 ;;^UTILITY(U,$J,358.3,5183,1,4,0)
 ;;=4^C04.8
 ;;^UTILITY(U,$J,358.3,5183,2)
 ;;=^5000895
 ;;^UTILITY(U,$J,358.3,5184,0)
 ;;=C14.0^^22^225^18
 ;;^UTILITY(U,$J,358.3,5184,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5184,1,3,0)
 ;;=3^Malig Neop of Pharynx,Unspec
 ;;^UTILITY(U,$J,358.3,5184,1,4,0)
 ;;=4^C14.0
 ;;^UTILITY(U,$J,358.3,5184,2)
 ;;=^5000916
 ;;^UTILITY(U,$J,358.3,5185,0)
 ;;=C14.2^^22^225^23
 ;;^UTILITY(U,$J,358.3,5185,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5185,1,3,0)
 ;;=3^Malig Neop of Waldeyer's Ring
 ;;^UTILITY(U,$J,358.3,5185,1,4,0)
 ;;=4^C14.2
 ;;^UTILITY(U,$J,358.3,5185,2)
 ;;=^267052
 ;;^UTILITY(U,$J,358.3,5186,0)
 ;;=C14.8^^22^225^16
 ;;^UTILITY(U,$J,358.3,5186,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5186,1,3,0)
 ;;=3^Malig Neop of Overlapping Sites of Lip/Oral Cavity/Pharynx
 ;;^UTILITY(U,$J,358.3,5186,1,4,0)
 ;;=4^C14.8
 ;;^UTILITY(U,$J,358.3,5186,2)
 ;;=^5000917
 ;;^UTILITY(U,$J,358.3,5187,0)
 ;;=C04.9^^22^225^7
 ;;^UTILITY(U,$J,358.3,5187,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5187,1,3,0)
 ;;=3^Malig Neop of Floor of Mouth,Unspec
 ;;^UTILITY(U,$J,358.3,5187,1,4,0)
 ;;=4^C04.9
 ;;^UTILITY(U,$J,358.3,5187,2)
 ;;=^5000896
 ;;^UTILITY(U,$J,358.3,5188,0)
 ;;=Z66.^^22^226^5
 ;;^UTILITY(U,$J,358.3,5188,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5188,1,3,0)
 ;;=3^Do Not Resuscitate
 ;;^UTILITY(U,$J,358.3,5188,1,4,0)
 ;;=4^Z66.
 ;;^UTILITY(U,$J,358.3,5188,2)
 ;;=^5063187
 ;;^UTILITY(U,$J,358.3,5189,0)
 ;;=H93.3X1^^22^226^11
 ;;^UTILITY(U,$J,358.3,5189,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5189,1,3,0)
 ;;=3^Right Acoustic Nerve Disorders
 ;;^UTILITY(U,$J,358.3,5189,1,4,0)
 ;;=4^H93.3X1
 ;;^UTILITY(U,$J,358.3,5189,2)
 ;;=^5006989
 ;;^UTILITY(U,$J,358.3,5190,0)
 ;;=H93.3X2^^22^226^7
 ;;^UTILITY(U,$J,358.3,5190,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5190,1,3,0)
 ;;=3^Left Acoustic Nerve Disorders
 ;;^UTILITY(U,$J,358.3,5190,1,4,0)
 ;;=4^H93.3X2
 ;;^UTILITY(U,$J,358.3,5190,2)
 ;;=^5006990
 ;;^UTILITY(U,$J,358.3,5191,0)
 ;;=H93.3X9^^22^226^3
 ;;^UTILITY(U,$J,358.3,5191,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5191,1,3,0)
 ;;=3^Bilateral Acoustic Nerve Disorders
 ;;^UTILITY(U,$J,358.3,5191,1,4,0)
 ;;=4^H93.3X9
 ;;^UTILITY(U,$J,358.3,5191,2)
 ;;=^5006992
 ;;^UTILITY(U,$J,358.3,5192,0)
 ;;=G50.0^^22^226^12
 ;;^UTILITY(U,$J,358.3,5192,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5192,1,3,0)
 ;;=3^Trigeminal Neuralgia
 ;;^UTILITY(U,$J,358.3,5192,1,4,0)
 ;;=4^G50.0
 ;;^UTILITY(U,$J,358.3,5192,2)
 ;;=^121978
 ;;^UTILITY(U,$J,358.3,5193,0)
 ;;=I77.0^^22^226^2
 ;;^UTILITY(U,$J,358.3,5193,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5193,1,3,0)
 ;;=3^Arteriovenous Fistula,Acquired
 ;;^UTILITY(U,$J,358.3,5193,1,4,0)
 ;;=4^I77.0
 ;;^UTILITY(U,$J,358.3,5193,2)
 ;;=^46674
 ;;^UTILITY(U,$J,358.3,5194,0)
 ;;=Q28.2^^22^226^1
 ;;^UTILITY(U,$J,358.3,5194,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5194,1,3,0)
 ;;=3^AVM (Brain) congenital
 ;;^UTILITY(U,$J,358.3,5194,1,4,0)
 ;;=4^Q28.2
 ;;^UTILITY(U,$J,358.3,5194,2)
 ;;=^5018595
 ;;^UTILITY(U,$J,358.3,5195,0)
 ;;=M61.40^^22^226^10
 ;;^UTILITY(U,$J,358.3,5195,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5195,1,3,0)
 ;;=3^Postoperative Heterotopic Calcification
 ;;^UTILITY(U,$J,358.3,5195,1,4,0)
 ;;=4^M61.40
 ;;^UTILITY(U,$J,358.3,5195,2)
 ;;=^5012515
 ;;^UTILITY(U,$J,358.3,5196,0)
 ;;=L91.0^^22^226^6
 ;;^UTILITY(U,$J,358.3,5196,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5196,1,3,0)
 ;;=3^Keloid Scar
