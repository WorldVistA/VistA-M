IBDEI3IY ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.4)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.4,2371,0)
 ;;=BONE/ARTICULAR CARTILAGE^6^209
 ;;^UTILITY(U,$J,358.4,2372,0)
 ;;=SKIN^39^209
 ;;^UTILITY(U,$J,358.4,2373,0)
 ;;=MESOTHELIAL/SOFT TISSUE^25^209
 ;;^UTILITY(U,$J,358.4,2374,0)
 ;;=RETROPERITONEUM/PERITONEUM^34^209
 ;;^UTILITY(U,$J,358.4,2375,0)
 ;;=THYROID/ENDOCRINE GLANDS^42^209
 ;;^UTILITY(U,$J,358.4,2376,0)
 ;;=SECONDARY MALIG NEOP-LYMPH NODES^36^209
 ;;^UTILITY(U,$J,358.4,2377,0)
 ;;=SECONDARY MALIG NEOP-RESP/DIGESTIVE^37^209
 ;;^UTILITY(U,$J,358.4,2378,0)
 ;;=EDUCATION/TRAINING^1^210
 ;;^UTILITY(U,$J,358.4,2379,0)
 ;;=PROCEDURE CODES-GROUP^3^210
 ;;^UTILITY(U,$J,358.4,2380,0)
 ;;=SPECIALTY GRP PROCEDURES^4^210
 ;;^UTILITY(U,$J,358.4,2381,0)
 ;;=FAMILY TRAINING-GROUP^2^210
 ;;^UTILITY(U,$J,358.4,2382,0)
 ;;=RECREATION THERAPY DX^1^211
 ;;^UTILITY(U,$J,358.4,2383,0)
 ;;=1-1 THERAPEUTIC PROCEDURES^1^212
 ;;^UTILITY(U,$J,358.4,2384,0)
 ;;=EDUCATION/TRAINING^3^212
 ;;^UTILITY(U,$J,358.4,2385,0)
 ;;=TEAM CONFERENCE^6^212
 ;;^UTILITY(U,$J,358.4,2386,0)
 ;;=ASSESSMENT^2^212
 ;;^UTILITY(U,$J,358.4,2387,0)
 ;;=FAMILY TRAINING^4^212
 ;;^UTILITY(U,$J,358.4,2388,0)
 ;;=SPECIALTY PROCEDURES-INDIVIDUAL^5^212
 ;;^UTILITY(U,$J,358.4,2389,0)
 ;;=RECREATION THERAPY DX^1^213
 ;;^UTILITY(U,$J,358.4,2390,0)
 ;;=NEW PATIENT^2^214
 ;;^UTILITY(U,$J,358.4,2391,0)
 ;;=ESTABLISHED PATIENT^1^214
 ;;^UTILITY(U,$J,358.4,2392,0)
 ;;=CONSULTATIONS^3^214
 ;;^UTILITY(U,$J,358.4,2393,0)
 ;;=THERAPY MODALITIES/PROCEDURES^12^215
 ;;^UTILITY(U,$J,358.4,2394,0)
 ;;=INJECTIONS/DRUGS^5^215
 ;;^UTILITY(U,$J,358.4,2395,0)
 ;;=ORTHOTIC DEVICES^8^215
 ;;^UTILITY(U,$J,358.4,2396,0)
 ;;=KINESIOTHERAPY^6^215
 ;;^UTILITY(U,$J,358.4,2397,0)
 ;;=THERAPY EVALUATIONS^11^215
 ;;^UTILITY(U,$J,358.4,2398,0)
 ;;=WOUND CARE^13^215
 ;;^UTILITY(U,$J,358.4,2399,0)
 ;;=CARDIAC REHAB^1^215
 ;;^UTILITY(U,$J,358.4,2400,0)
 ;;=EDUCATION/TRAINING^2^215
 ;;^UTILITY(U,$J,358.4,2401,0)
 ;;=HOME THERAPY SERVICES^4^215
 ;;^UTILITY(U,$J,358.4,2402,0)
 ;;=NEUROMUSCULAR TESTING^7^215
 ;;^UTILITY(U,$J,358.4,2403,0)
 ;;=TEAM CONFERENCE^10^215
 ;;^UTILITY(U,$J,358.4,2404,0)
 ;;=HEALTH BEHAVIORS^3^215
 ;;^UTILITY(U,$J,358.4,2405,0)
 ;;=RECREATION THERAPY^9^215
 ;;^UTILITY(U,$J,358.4,2406,0)
 ;;=AMPUTATION STATUS^1^216
 ;;^UTILITY(U,$J,358.4,2407,0)
 ;;=BRAIN DISORDERS^2^216
 ;;^UTILITY(U,$J,358.4,2408,0)
 ;;=CARDIOPULMONARY^4^216
 ;;^UTILITY(U,$J,358.4,2409,0)
 ;;=COMPLICATIONS DUE TO^5^216
 ;;^UTILITY(U,$J,358.4,2410,0)
 ;;=MUSCULOSKELETAL/CONNECTIVE TISSUE^11^216
 ;;^UTILITY(U,$J,358.4,2411,0)
 ;;=Z CODES^16^216
 ;;^UTILITY(U,$J,358.4,2412,0)
 ;;=BRAIN INJURY - TRAUMATIC^3^216
 ;;^UTILITY(U,$J,358.4,2413,0)
 ;;=FEMUR/THIGH/KNEE FRACTURE^6^216
 ;;^UTILITY(U,$J,358.4,2414,0)
 ;;=FOOT/TOE/ANKLE FRANCTURE^7^216
 ;;^UTILITY(U,$J,358.4,2415,0)
 ;;=HAND/FINGER FRACTURE^8^216
 ;;^UTILITY(U,$J,358.4,2416,0)
 ;;=HIP/PELVIS FRACTURE^9^216
 ;;^UTILITY(U,$J,358.4,2417,0)
 ;;=HUMERUS/SHOULDER FRACTURE^10^216
 ;;^UTILITY(U,$J,358.4,2418,0)
 ;;=TIBIA/FIBULA FRACTURE^14^216
 ;;^UTILITY(U,$J,358.4,2419,0)
 ;;=SPINE FRACTURE^13^216
 ;;^UTILITY(U,$J,358.4,2420,0)
 ;;=WRIST/FOREARM FRACTURE^15^216
 ;;^UTILITY(U,$J,358.4,2421,0)
 ;;=OTHER FRACTURE^12^216
 ;;^UTILITY(U,$J,358.4,2422,0)
 ;;=IMMUNIZATIONS/INJECTIONS^4^217
 ;;^UTILITY(U,$J,358.4,2423,0)
 ;;=RESPIRATORY^8^217
 ;;^UTILITY(U,$J,358.4,2424,0)
 ;;=SLEEP STUDIES^9^217
 ;;^UTILITY(U,$J,358.4,2425,0)
 ;;=PULMONARY FUNCTION TESTS^7^217
 ;;^UTILITY(U,$J,358.4,2426,0)
 ;;=OTHER^5^217
 ;;^UTILITY(U,$J,358.4,2427,0)
 ;;=ABG^1^217
 ;;^UTILITY(U,$J,358.4,2428,0)
 ;;=OXYGEN CLINIC^6^217
 ;;^UTILITY(U,$J,358.4,2429,0)
 ;;=CPAP^2^217