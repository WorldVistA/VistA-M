IBDEI0KW ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,9240,1,3,0)
 ;;=3^GTube Change Bedside (Simple)
 ;;^UTILITY(U,$J,358.3,9241,0)
 ;;=43763^^70^628^5^^^^1
 ;;^UTILITY(U,$J,358.3,9241,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9241,1,2,0)
 ;;=2^43763
 ;;^UTILITY(U,$J,358.3,9241,1,3,0)
 ;;=3^GTube Change Bedside (Complicated)
 ;;^UTILITY(U,$J,358.3,9242,0)
 ;;=69200^^70^629^3^^^^1
 ;;^UTILITY(U,$J,358.3,9242,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9242,1,2,0)
 ;;=2^69200
 ;;^UTILITY(U,$J,358.3,9242,1,3,0)
 ;;=3^Remove FB,External Ear Canal
 ;;^UTILITY(U,$J,358.3,9243,0)
 ;;=69209^^70^629^4^^^^1
 ;;^UTILITY(U,$J,358.3,9243,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9243,1,2,0)
 ;;=2^69209
 ;;^UTILITY(U,$J,358.3,9243,1,3,0)
 ;;=3^Remove Impacted Ear Wax w/ Lavage,Unilat
 ;;^UTILITY(U,$J,358.3,9244,0)
 ;;=62270^^70^629^1^^^^1
 ;;^UTILITY(U,$J,358.3,9244,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9244,1,2,0)
 ;;=2^62270
 ;;^UTILITY(U,$J,358.3,9244,1,3,0)
 ;;=3^Lumbar Puncture
 ;;^UTILITY(U,$J,358.3,9245,0)
 ;;=64450^^70^629^2^^^^1
 ;;^UTILITY(U,$J,358.3,9245,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9245,1,2,0)
 ;;=2^64450
 ;;^UTILITY(U,$J,358.3,9245,1,3,0)
 ;;=3^Peripheral Nerve Block
 ;;^UTILITY(U,$J,358.3,9246,0)
 ;;=31505^^70^629^5^^^^1
 ;;^UTILITY(U,$J,358.3,9246,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9246,1,2,0)
 ;;=2^31505
 ;;^UTILITY(U,$J,358.3,9246,1,3,0)
 ;;=3^Indirect Laryngoscopy
 ;;^UTILITY(U,$J,358.3,9247,0)
 ;;=42809^^70^629^6^^^^1
 ;;^UTILITY(U,$J,358.3,9247,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9247,1,2,0)
 ;;=2^42809
 ;;^UTILITY(U,$J,358.3,9247,1,3,0)
 ;;=3^Remove FB,Pharynx
 ;;^UTILITY(U,$J,358.3,9248,0)
 ;;=30901^^70^629^7^^^^1
 ;;^UTILITY(U,$J,358.3,9248,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9248,1,2,0)
 ;;=2^30901
 ;;^UTILITY(U,$J,358.3,9248,1,3,0)
 ;;=3^Control Nosebleed,Ant Simple (Packing)
 ;;^UTILITY(U,$J,358.3,9249,0)
 ;;=30905^^70^629^8^^^^1
 ;;^UTILITY(U,$J,358.3,9249,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9249,1,2,0)
 ;;=2^30905
 ;;^UTILITY(U,$J,358.3,9249,1,3,0)
 ;;=3^Control Nosebleed,Post,Init
 ;;^UTILITY(U,$J,358.3,9250,0)
 ;;=65220^^70^629^9^^^^1
 ;;^UTILITY(U,$J,358.3,9250,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9250,1,2,0)
 ;;=2^65220
 ;;^UTILITY(U,$J,358.3,9250,1,3,0)
 ;;=3^Remove FB,Cornea w/o Slit Lamp
 ;;^UTILITY(U,$J,358.3,9251,0)
 ;;=65222^^70^629^10^^^^1
 ;;^UTILITY(U,$J,358.3,9251,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9251,1,2,0)
 ;;=2^65222
 ;;^UTILITY(U,$J,358.3,9251,1,3,0)
 ;;=3^Remove FB,Cornea w/ Slit Lamp
 ;;^UTILITY(U,$J,358.3,9252,0)
 ;;=65205^^70^629^11^^^^1
 ;;^UTILITY(U,$J,358.3,9252,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9252,1,2,0)
 ;;=2^65205
 ;;^UTILITY(U,$J,358.3,9252,1,3,0)
 ;;=3^Remove FB,External Eye/Conjuctiva
 ;;^UTILITY(U,$J,358.3,9253,0)
 ;;=65210^^70^629^12^^^^1
 ;;^UTILITY(U,$J,358.3,9253,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9253,1,2,0)
 ;;=2^65210
 ;;^UTILITY(U,$J,358.3,9253,1,3,0)
 ;;=3^Remove FB,External Eye/Conjuctivl-Embedded
 ;;^UTILITY(U,$J,358.3,9254,0)
 ;;=12051^^70^630^14^^^^1
 ;;^UTILITY(U,$J,358.3,9254,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9254,1,2,0)
 ;;=2^12051
 ;;^UTILITY(U,$J,358.3,9254,1,3,0)
 ;;=3^Intermd < 2.5cm Face/Ears/Eyelids/Mucous Membranes
 ;;^UTILITY(U,$J,358.3,9255,0)
 ;;=12052^^70^630^15^^^^1
 ;;^UTILITY(U,$J,358.3,9255,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9255,1,2,0)
 ;;=2^12052
