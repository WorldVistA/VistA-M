IBDEI0IJ ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8086,1,3,0)
 ;;=3^Prurigo Nodularis
 ;;^UTILITY(U,$J,358.3,8086,1,4,0)
 ;;=4^L28.1
 ;;^UTILITY(U,$J,358.3,8086,2)
 ;;=^5009148
 ;;^UTILITY(U,$J,358.3,8087,0)
 ;;=H61.001^^65^519^6
 ;;^UTILITY(U,$J,358.3,8087,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8087,1,3,0)
 ;;=3^Perichondritis Right External Ear,Unspec
 ;;^UTILITY(U,$J,358.3,8087,1,4,0)
 ;;=4^H61.001
 ;;^UTILITY(U,$J,358.3,8087,2)
 ;;=^5006499
 ;;^UTILITY(U,$J,358.3,8088,0)
 ;;=H61.002^^65^519^5
 ;;^UTILITY(U,$J,358.3,8088,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8088,1,3,0)
 ;;=3^Perichondritis Left External Ear,Unspec
 ;;^UTILITY(U,$J,358.3,8088,1,4,0)
 ;;=4^H61.002
 ;;^UTILITY(U,$J,358.3,8088,2)
 ;;=^5006500
 ;;^UTILITY(U,$J,358.3,8089,0)
 ;;=L81.0^^65^519^22
 ;;^UTILITY(U,$J,358.3,8089,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8089,1,3,0)
 ;;=3^Postinflammatory Hyperpigmentation
 ;;^UTILITY(U,$J,358.3,8089,1,4,0)
 ;;=4^L81.0
 ;;^UTILITY(U,$J,358.3,8089,2)
 ;;=^5009310
 ;;^UTILITY(U,$J,358.3,8090,0)
 ;;=L81.7^^65^519^16
 ;;^UTILITY(U,$J,358.3,8090,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8090,1,3,0)
 ;;=3^Pigmented Purpuric Dermatosis
 ;;^UTILITY(U,$J,358.3,8090,1,4,0)
 ;;=4^L81.7
 ;;^UTILITY(U,$J,358.3,8090,2)
 ;;=^5009317
 ;;^UTILITY(U,$J,358.3,8091,0)
 ;;=L29.8^^65^519^36
 ;;^UTILITY(U,$J,358.3,8091,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8091,1,3,0)
 ;;=3^Pruritus NEC
 ;;^UTILITY(U,$J,358.3,8091,1,4,0)
 ;;=4^L29.8
 ;;^UTILITY(U,$J,358.3,8091,2)
 ;;=^5009152
 ;;^UTILITY(U,$J,358.3,8092,0)
 ;;=Z85.828^^65^519^10
 ;;^UTILITY(U,$J,358.3,8092,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8092,1,3,0)
 ;;=3^Personal Hx of Malig Neop of Skin
 ;;^UTILITY(U,$J,358.3,8092,1,4,0)
 ;;=4^Z85.828
 ;;^UTILITY(U,$J,358.3,8092,2)
 ;;=^5063443
 ;;^UTILITY(U,$J,358.3,8093,0)
 ;;=B36.0^^65^519^19
 ;;^UTILITY(U,$J,358.3,8093,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8093,1,3,0)
 ;;=3^Pityriasis Versicolor
 ;;^UTILITY(U,$J,358.3,8093,1,4,0)
 ;;=4^B36.0
 ;;^UTILITY(U,$J,358.3,8093,2)
 ;;=^5000608
 ;;^UTILITY(U,$J,358.3,8094,0)
 ;;=Z92.3^^65^519^8
 ;;^UTILITY(U,$J,358.3,8094,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8094,1,3,0)
 ;;=3^Personal Hx of Irradiation (Therapeutic)
 ;;^UTILITY(U,$J,358.3,8094,1,4,0)
 ;;=4^Z92.3
 ;;^UTILITY(U,$J,358.3,8094,2)
 ;;=^5063637
 ;;^UTILITY(U,$J,358.3,8095,0)
 ;;=Z91.82^^65^519^11
 ;;^UTILITY(U,$J,358.3,8095,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8095,1,3,0)
 ;;=3^Personal Hx of Military Deployment
 ;;^UTILITY(U,$J,358.3,8095,1,4,0)
 ;;=4^Z91.82
 ;;^UTILITY(U,$J,358.3,8095,2)
 ;;=^5063626
 ;;^UTILITY(U,$J,358.3,8096,0)
 ;;=L66.0^^65^519^42
 ;;^UTILITY(U,$J,358.3,8096,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8096,1,3,0)
 ;;=3^Pseudopelade
 ;;^UTILITY(U,$J,358.3,8096,1,4,0)
 ;;=4^L66.0
 ;;^UTILITY(U,$J,358.3,8096,2)
 ;;=^191705
 ;;^UTILITY(U,$J,358.3,8097,0)
 ;;=Z85.820^^65^519^9
 ;;^UTILITY(U,$J,358.3,8097,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8097,1,3,0)
 ;;=3^Personal Hx of Malig Melanoma of Skin
 ;;^UTILITY(U,$J,358.3,8097,1,4,0)
 ;;=4^Z85.820
 ;;^UTILITY(U,$J,358.3,8097,2)
 ;;=^5063441
 ;;^UTILITY(U,$J,358.3,8098,0)
 ;;=Z87.2^^65^519^12
 ;;^UTILITY(U,$J,358.3,8098,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8098,1,3,0)
 ;;=3^Personal Hx of Skin Diseases
 ;;^UTILITY(U,$J,358.3,8098,1,4,0)
 ;;=4^Z87.2
 ;;^UTILITY(U,$J,358.3,8098,2)
 ;;=^5063484
 ;;^UTILITY(U,$J,358.3,8099,0)
 ;;=L08.0^^65^519^49
