IBDEI0SC ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,28484,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28484,1,3,0)
 ;;=3^Refractory anemia with excess of blasts 2
 ;;^UTILITY(U,$J,358.3,28484,1,4,0)
 ;;=4^D46.22
 ;;^UTILITY(U,$J,358.3,28484,2)
 ;;=^5002249
 ;;^UTILITY(U,$J,358.3,28485,0)
 ;;=D46.C^^105^1382^3
 ;;^UTILITY(U,$J,358.3,28485,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28485,1,3,0)
 ;;=3^Myelodysplastic syndrome w isolated del(5q) chromsoml abnlt
 ;;^UTILITY(U,$J,358.3,28485,1,4,0)
 ;;=4^D46.C
 ;;^UTILITY(U,$J,358.3,28485,2)
 ;;=^5002253
 ;;^UTILITY(U,$J,358.3,28486,0)
 ;;=D46.9^^105^1382^4
 ;;^UTILITY(U,$J,358.3,28486,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28486,1,3,0)
 ;;=3^Myelodysplastic syndrome, unspecified
 ;;^UTILITY(U,$J,358.3,28486,1,4,0)
 ;;=4^D46.9
 ;;^UTILITY(U,$J,358.3,28486,2)
 ;;=^334031
 ;;^UTILITY(U,$J,358.3,28487,0)
 ;;=D47.1^^105^1382^1
 ;;^UTILITY(U,$J,358.3,28487,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28487,1,3,0)
 ;;=3^Chronic myeloproliferative disease
 ;;^UTILITY(U,$J,358.3,28487,1,4,0)
 ;;=4^D47.1
 ;;^UTILITY(U,$J,358.3,28487,2)
 ;;=^5002256
 ;;^UTILITY(U,$J,358.3,28488,0)
 ;;=D47.Z1^^105^1382^12
 ;;^UTILITY(U,$J,358.3,28488,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28488,1,3,0)
 ;;=3^Post-transplant lymphoproliferative disorder (PTLD)
 ;;^UTILITY(U,$J,358.3,28488,1,4,0)
 ;;=4^D47.Z1
 ;;^UTILITY(U,$J,358.3,28488,2)
 ;;=^5002261
 ;;^UTILITY(U,$J,358.3,28489,0)
 ;;=D48.7^^105^1382^8
 ;;^UTILITY(U,$J,358.3,28489,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28489,1,3,0)
 ;;=3^Neoplasm of uncertain behavior of other specified sites
 ;;^UTILITY(U,$J,358.3,28489,1,4,0)
 ;;=4^D48.7
 ;;^UTILITY(U,$J,358.3,28489,2)
 ;;=^267779
 ;;^UTILITY(U,$J,358.3,28490,0)
 ;;=D48.9^^105^1382^11
 ;;^UTILITY(U,$J,358.3,28490,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28490,1,3,0)
 ;;=3^Neoplasm of uncertain behavior, unspecified
 ;;^UTILITY(U,$J,358.3,28490,1,4,0)
 ;;=4^D48.9
 ;;^UTILITY(U,$J,358.3,28490,2)
 ;;=^5002269
 ;;^UTILITY(U,$J,358.3,28491,0)
 ;;=D49.0^^105^1383^8
 ;;^UTILITY(U,$J,358.3,28491,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28491,1,3,0)
 ;;=3^Neoplasm of unspecified behavior of digestive system
 ;;^UTILITY(U,$J,358.3,28491,1,4,0)
 ;;=4^D49.0
 ;;^UTILITY(U,$J,358.3,28491,2)
 ;;=^5002270
 ;;^UTILITY(U,$J,358.3,28492,0)
 ;;=D49.1^^105^1383^12
 ;;^UTILITY(U,$J,358.3,28492,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28492,1,3,0)
 ;;=3^Neoplasm of unspecified behavior of respiratory system
 ;;^UTILITY(U,$J,358.3,28492,1,4,0)
 ;;=4^D49.1
 ;;^UTILITY(U,$J,358.3,28492,2)
 ;;=^5002271
 ;;^UTILITY(U,$J,358.3,28493,0)
 ;;=D49.2^^105^1383^5
 ;;^UTILITY(U,$J,358.3,28493,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28493,1,3,0)
 ;;=3^Neoplasm of unspecified behavior of bone, soft tissue, and skin
 ;;^UTILITY(U,$J,358.3,28493,1,4,0)
 ;;=4^D49.2
 ;;^UTILITY(U,$J,358.3,28493,2)
 ;;=^5002272
 ;;^UTILITY(U,$J,358.3,28494,0)
 ;;=D49.3^^105^1383^7
 ;;^UTILITY(U,$J,358.3,28494,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28494,1,3,0)
 ;;=3^Neoplasm of unspecified behavior of breast
 ;;^UTILITY(U,$J,358.3,28494,1,4,0)
 ;;=4^D49.3
 ;;^UTILITY(U,$J,358.3,28494,2)
 ;;=^5002273
 ;;^UTILITY(U,$J,358.3,28495,0)
 ;;=D49.4^^105^1383^4
 ;;^UTILITY(U,$J,358.3,28495,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28495,1,3,0)
 ;;=3^Neoplasm of unspecified behavior of bladder
 ;;^UTILITY(U,$J,358.3,28495,1,4,0)
 ;;=4^D49.4
 ;;^UTILITY(U,$J,358.3,28495,2)
 ;;=^5002274
 ;;^UTILITY(U,$J,358.3,28496,0)
 ;;=D49.5^^105^1383^10
 ;;^UTILITY(U,$J,358.3,28496,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28496,1,3,0)
 ;;=3^Neoplasm of unspecified behavior of other genitourinary organs
 ;;^UTILITY(U,$J,358.3,28496,1,4,0)
 ;;=4^D49.5
 ;;^UTILITY(U,$J,358.3,28496,2)
 ;;=^5002275
 ;;^UTILITY(U,$J,358.3,28497,0)
 ;;=D49.6^^105^1383^6
 ;;^UTILITY(U,$J,358.3,28497,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28497,1,3,0)
 ;;=3^Neoplasm of unspecified behavior of brain
 ;;^UTILITY(U,$J,358.3,28497,1,4,0)
 ;;=4^D49.6
 ;;^UTILITY(U,$J,358.3,28497,2)
 ;;=^5002276
 ;;^UTILITY(U,$J,358.3,28498,0)
 ;;=D49.7^^105^1383^9
 ;;^UTILITY(U,$J,358.3,28498,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28498,1,3,0)
 ;;=3^Neoplasm of unspecified behavior of endo glands
 ;;^UTILITY(U,$J,358.3,28498,1,4,0)
 ;;=4^D49.7
 ;;^UTILITY(U,$J,358.3,28498,2)
 ;;=^5002277
 ;;^UTILITY(U,$J,358.3,28499,0)
 ;;=D49.81^^105^1383^13
 ;;^UTILITY(U,$J,358.3,28499,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28499,1,3,0)
 ;;=3^Neoplasm of unspecified behavior of retina and choroid
 ;;^UTILITY(U,$J,358.3,28499,1,4,0)
 ;;=4^D49.81
 ;;^UTILITY(U,$J,358.3,28499,2)
 ;;=^5002278
 ;;^UTILITY(U,$J,358.3,28500,0)
 ;;=D49.89^^105^1383^11
 ;;^UTILITY(U,$J,358.3,28500,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28500,1,3,0)
 ;;=3^Neoplasm of unspecified behavior of other specified sites
 ;;^UTILITY(U,$J,358.3,28500,1,4,0)
 ;;=4^D49.89
 ;;^UTILITY(U,$J,358.3,28500,2)
 ;;=^5002279
 ;;^UTILITY(U,$J,358.3,28501,0)
 ;;=D49.9^^105^1383^14
 ;;^UTILITY(U,$J,358.3,28501,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28501,1,3,0)
 ;;=3^Neoplasm of unspecified behavior of unspecified site
 ;;^UTILITY(U,$J,358.3,28501,1,4,0)
 ;;=4^D49.9
 ;;^UTILITY(U,$J,358.3,28501,2)
 ;;=^5002280
 ;;^UTILITY(U,$J,358.3,28502,0)
 ;;=D68.51^^105^1383^1
 ;;^UTILITY(U,$J,358.3,28502,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28502,1,3,0)
 ;;=3^Activated protein C resistance
 ;;^UTILITY(U,$J,358.3,28502,1,4,0)
 ;;=4^D68.51
 ;;^UTILITY(U,$J,358.3,28502,2)
 ;;=^5002358
 ;;^UTILITY(U,$J,358.3,28503,0)
 ;;=D68.52^^105^1383^16
 ;;^UTILITY(U,$J,358.3,28503,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28503,1,3,0)
 ;;=3^Prothrombin gene mutation
 ;;^UTILITY(U,$J,358.3,28503,1,4,0)
 ;;=4^D68.52
 ;;^UTILITY(U,$J,358.3,28503,2)
 ;;=^5002359
 ;;^UTILITY(U,$J,358.3,28504,0)
 ;;=D68.59^^105^1383^15
 ;;^UTILITY(U,$J,358.3,28504,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28504,1,3,0)
 ;;=3^Primary Thrombophilia NEC
 ;;^UTILITY(U,$J,358.3,28504,1,4,0)
 ;;=4^D68.59
 ;;^UTILITY(U,$J,358.3,28504,2)
 ;;=^5002360
 ;;^UTILITY(U,$J,358.3,28505,0)
 ;;=D68.61^^105^1383^2
 ;;^UTILITY(U,$J,358.3,28505,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28505,1,3,0)
 ;;=3^Antiphospholipid syndrome
 ;;^UTILITY(U,$J,358.3,28505,1,4,0)
 ;;=4^D68.61
 ;;^UTILITY(U,$J,358.3,28505,2)
 ;;=^185421
 ;;^UTILITY(U,$J,358.3,28506,0)
 ;;=D68.62^^105^1383^3
 ;;^UTILITY(U,$J,358.3,28506,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28506,1,3,0)
 ;;=3^Lupus anticoagulant syndrome
 ;;^UTILITY(U,$J,358.3,28506,1,4,0)
 ;;=4^D68.62
 ;;^UTILITY(U,$J,358.3,28506,2)
 ;;=^5002361
 ;;^UTILITY(U,$J,358.3,28507,0)
 ;;=Z85.810^^105^1384^3
 ;;^UTILITY(U,$J,358.3,28507,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28507,1,3,0)
 ;;=3^Personal history of malignant neoplasm of tongue
 ;;^UTILITY(U,$J,358.3,28507,1,4,0)
 ;;=4^Z85.810
 ;;^UTILITY(U,$J,358.3,28507,2)
 ;;=^5063438
 ;;^UTILITY(U,$J,358.3,28508,0)
 ;;=Z85.818^^105^1384^4
 ;;^UTILITY(U,$J,358.3,28508,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28508,1,3,0)
 ;;=3^Personal history of malignant neoplasm of site of lip, oral cav, & pharynx
 ;;^UTILITY(U,$J,358.3,28508,1,4,0)
 ;;=4^Z85.818
 ;;^UTILITY(U,$J,358.3,28508,2)
 ;;=^5063439
 ;;^UTILITY(U,$J,358.3,28509,0)
 ;;=Z85.01^^105^1384^5
 ;;^UTILITY(U,$J,358.3,28509,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28509,1,3,0)
 ;;=3^Personal history of malignant neoplasm of esophagus
 ;;^UTILITY(U,$J,358.3,28509,1,4,0)
 ;;=4^Z85.01
 ;;^UTILITY(U,$J,358.3,28509,2)
 ;;=^5063395
 ;;^UTILITY(U,$J,358.3,28510,0)
 ;;=Z85.028^^105^1384^6
 ;;^UTILITY(U,$J,358.3,28510,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28510,1,3,0)
 ;;=3^Personal history of malignant neoplasm of stomach NEC
 ;;^UTILITY(U,$J,358.3,28510,1,4,0)
 ;;=4^Z85.028
