IBDEI0JI ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8562,1,3,0)
 ;;=3^Bx,Tangential,Skin,Single Lesion
 ;;^UTILITY(U,$J,358.3,8563,0)
 ;;=11103^^66^572^11^^^^1
 ;;^UTILITY(U,$J,358.3,8563,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8563,1,2,0)
 ;;=2^11103
 ;;^UTILITY(U,$J,358.3,8563,1,3,0)
 ;;=3^Bx,Tangential,Skin,Ea Addl Lesion
 ;;^UTILITY(U,$J,358.3,8564,0)
 ;;=14301^^66^573^1^^^^1
 ;;^UTILITY(U,$J,358.3,8564,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8564,1,2,0)
 ;;=2^14301
 ;;^UTILITY(U,$J,358.3,8564,1,3,0)
 ;;=3^Tissue Rearrangement,30.1-60.0sq cm
 ;;^UTILITY(U,$J,358.3,8565,0)
 ;;=14302^^66^573^2^^^^1
 ;;^UTILITY(U,$J,358.3,8565,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8565,1,2,0)
 ;;=2^14302
 ;;^UTILITY(U,$J,358.3,8565,1,3,0)
 ;;=3^Tissue Rearrangement,Ea Addl 30.0sq cm
 ;;^UTILITY(U,$J,358.3,8566,0)
 ;;=15050^^66^574^11^^^^1
 ;;^UTILITY(U,$J,358.3,8566,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8566,1,2,0)
 ;;=2^15050
 ;;^UTILITY(U,$J,358.3,8566,1,3,0)
 ;;=3^Pinch grft,Sgl/Mlt to Cover Sm Ulcer/Tip of Digit,Up to 2cm
 ;;^UTILITY(U,$J,358.3,8567,0)
 ;;=15100^^66^574^14^^^^1
 ;;^UTILITY(U,$J,358.3,8567,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8567,1,2,0)
 ;;=2^15100
 ;;^UTILITY(U,$J,358.3,8567,1,3,0)
 ;;=3^Splt-Thickness,Trnk/Arm/Leg;1st 100 sq cm
 ;;^UTILITY(U,$J,358.3,8568,0)
 ;;=15101^^66^574^15^^^^1
 ;;^UTILITY(U,$J,358.3,8568,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8568,1,2,0)
 ;;=2^15101
 ;;^UTILITY(U,$J,358.3,8568,1,3,0)
 ;;=3^Splt-Thickness,Trnk/Arm/Leg;Ea Addl 100 sq cm
 ;;^UTILITY(U,$J,358.3,8569,0)
 ;;=15120^^66^574^12^^^^1
 ;;^UTILITY(U,$J,358.3,8569,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8569,1,2,0)
 ;;=2^15120
 ;;^UTILITY(U,$J,358.3,8569,1,3,0)
 ;;=3^Splt-Thickness,Face/Sclp/Orbti/Extrem/Genitals;1st 100 sq cm
 ;;^UTILITY(U,$J,358.3,8570,0)
 ;;=15121^^66^574^13^^^^1
 ;;^UTILITY(U,$J,358.3,8570,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8570,1,2,0)
 ;;=2^15121
 ;;^UTILITY(U,$J,358.3,8570,1,3,0)
 ;;=3^Splt-Thickness,Face/Sclp/Orbti/Extrem/Genitals;Ea Addl 100 sq cm
 ;;^UTILITY(U,$J,358.3,8571,0)
 ;;=15200^^66^574^3^^^^1
 ;;^UTILITY(U,$J,358.3,8571,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8571,1,2,0)
 ;;=2^15200
 ;;^UTILITY(U,$J,358.3,8571,1,3,0)
 ;;=3^Full-Thick,Free,Incl Dir Clsr of Donor site,Trk,up to 20 sq cm
 ;;^UTILITY(U,$J,358.3,8572,0)
 ;;=15201^^66^574^4^^^^1
 ;;^UTILITY(U,$J,358.3,8572,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8572,1,2,0)
 ;;=2^15201
 ;;^UTILITY(U,$J,358.3,8572,1,3,0)
 ;;=3^Full-Thick,Free,Incl Dir Clsr of Donor site,Trk,Ea Addl 20 sq cm
 ;;^UTILITY(U,$J,358.3,8573,0)
 ;;=15240^^66^574^5^^^^1
 ;;^UTILITY(U,$J,358.3,8573,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8573,1,2,0)
 ;;=2^15240
 ;;^UTILITY(U,$J,358.3,8573,1,3,0)
 ;;=3^Full-Thick,Free,Incl Dir Clsr of Donor site,Face/Extrm/Gen,up to 20 sq cm
 ;;^UTILITY(U,$J,358.3,8574,0)
 ;;=15241^^66^574^6^^^^1
 ;;^UTILITY(U,$J,358.3,8574,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8574,1,2,0)
 ;;=2^15241
 ;;^UTILITY(U,$J,358.3,8574,1,3,0)
 ;;=3^Full-Thick,Free,Incl Dir Clsr of Donor site,Face/Extrm/Gen,Ea Addl 20 sq cm
 ;;^UTILITY(U,$J,358.3,8575,0)
 ;;=15260^^66^574^7^^^^1
 ;;^UTILITY(U,$J,358.3,8575,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8575,1,2,0)
 ;;=2^15260
 ;;^UTILITY(U,$J,358.3,8575,1,3,0)
 ;;=3^Full-Thick,Free,Incl Dir Clsr of Donor site,Nose/Ears/Eyelid/Lip,up to 20 sq cm
 ;;^UTILITY(U,$J,358.3,8576,0)
 ;;=15261^^66^574^8^^^^1
