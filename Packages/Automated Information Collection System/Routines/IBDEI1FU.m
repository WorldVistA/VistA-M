IBDEI1FU ; ; 12-AUG-2014
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 15, 2014
 Q:'DIFQR(358.4)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.4,1165,0)
 ;;=CONSULTATION^3^120
 ;;^UTILITY(U,$J,358.4,1166,0)
 ;;=ALPHA ORDER (A)^2^121
 ;;^UTILITY(U,$J,358.4,1167,0)
 ;;=ALPHA ORDER (B)^3^121
 ;;^UTILITY(U,$J,358.4,1168,0)
 ;;=ALPHA ORDER (C)^4^121
 ;;^UTILITY(U,$J,358.4,1169,0)
 ;;=ALPHA ORDER (D)^5^121
 ;;^UTILITY(U,$J,358.4,1170,0)
 ;;=ALPHA ORDER (E)^6^121
 ;;^UTILITY(U,$J,358.4,1171,0)
 ;;=ALPHA ORDER (F)^7^121
 ;;^UTILITY(U,$J,358.4,1172,0)
 ;;=ALPHA ORDER (G)^8^121
 ;;^UTILITY(U,$J,358.4,1173,0)
 ;;=ALPHA ORDER (H)^9^121
 ;;^UTILITY(U,$J,358.4,1174,0)
 ;;=ALPHA ORDER (I)^10^121
 ;;^UTILITY(U,$J,358.4,1175,0)
 ;;=ALPHA ORDER (K)^11^121
 ;;^UTILITY(U,$J,358.4,1176,0)
 ;;=ALPHA ORDER (L)^12^121
 ;;^UTILITY(U,$J,358.4,1177,0)
 ;;=ALPHA ORDER (M)^13^121
 ;;^UTILITY(U,$J,358.4,1178,0)
 ;;=ALPHA ORDER (N)^14^121
 ;;^UTILITY(U,$J,358.4,1179,0)
 ;;=ALPHA ORDER (O)^15^121
 ;;^UTILITY(U,$J,358.4,1180,0)
 ;;=ALPHA ORDER (P)^16^121
 ;;^UTILITY(U,$J,358.4,1181,0)
 ;;=ALPHA ORDER (R)^17^121
 ;;^UTILITY(U,$J,358.4,1182,0)
 ;;=ALPHA ORDER (S)^18^121
 ;;^UTILITY(U,$J,358.4,1183,0)
 ;;=ALPHA ORDER (T)^19^121
 ;;^UTILITY(U,$J,358.4,1184,0)
 ;;=ALPHA ORDER (U)^20^121
 ;;^UTILITY(U,$J,358.4,1185,0)
 ;;=ALPHA ORDER (V)^21^121
 ;;^UTILITY(U,$J,358.4,1186,0)
 ;;=ALPHA ORDER (X)^22^121
 ;;^UTILITY(U,$J,358.4,1187,0)
 ;;=V CODES^23^121
 ;;^UTILITY(U,$J,358.4,1188,0)
 ;;=INCISION & DRAINAGE^10^122
 ;;^UTILITY(U,$J,358.4,1189,0)
 ;;=DEBRIDEMENT^5^122
 ;;^UTILITY(U,$J,358.4,1190,0)
 ;;=SHAVING EPIDERMAL/DERMAL LESIONS^24^122
 ;;^UTILITY(U,$J,358.4,1191,0)
 ;;=NAILS^14^122
 ;;^UTILITY(U,$J,358.4,1192,0)
 ;;=PARING OR CUTTING^19^122
 ;;^UTILITY(U,$J,358.4,1193,0)
 ;;=DESTRUCTION-BENIGN OR PREMALIGANT^6^122
 ;;^UTILITY(U,$J,358.4,1194,0)
 ;;=EXCISION-BENIGN LESION (EXCEPT SKIN TAG)^7^122
 ;;^UTILITY(U,$J,358.4,1195,0)
 ;;=EXCISION-MALIGNANT LESIONS^9^122
 ;;^UTILITY(U,$J,358.4,1196,0)
 ;;=REPAIR/CLOSURE^23^122
 ;;^UTILITY(U,$J,358.4,1197,0)
 ;;=BURNS^3^122
 ;;^UTILITY(U,$J,358.4,1198,0)
 ;;=OTHER SKIN PROCEDURES^18^122
 ;;^UTILITY(U,$J,358.4,1199,0)
 ;;=INJECTIONS^12^122
 ;;^UTILITY(U,$J,358.4,1200,0)
 ;;=INJECTION SUBSTANCE^13^122
 ;;^UTILITY(U,$J,358.4,1201,0)
 ;;=REPAIR, REVISE and/or RECONSTRUCT^22^122
 ;;^UTILITY(U,$J,358.4,1202,0)
 ;;=INCISION-FOOT/TOES^11^122
 ;;^UTILITY(U,$J,358.4,1203,0)
 ;;=EXCISION-FOOT/TOES^8^122
 ;;^UTILITY(U,$J,358.4,1204,0)
 ;;=OTHER PROCEDURES^17^122
 ;;^UTILITY(U,$J,358.4,1205,0)
 ;;=OPEN OR CLOSED TREATMENT OF FRACTURES^15^122
 ;;^UTILITY(U,$J,358.4,1206,0)
 ;;=ARTHRODESIS^2^122
 ;;^UTILITY(U,$J,358.4,1207,0)
 ;;=CASTS/SPLINTS/STRAPPING APPLICATION^4^122
 ;;^UTILITY(U,$J,358.4,1208,0)
 ;;=REMOVAL/REPAIR OF CASTS^21^122
 ;;^UTILITY(U,$J,358.4,1209,0)
 ;;=OTHER ORTHOTICS^16^122
 ;;^UTILITY(U,$J,358.4,1210,0)
 ;;=SUPPLIES^25^122
 ;;^UTILITY(U,$J,358.4,1211,0)
 ;;=REMOVAL^20^122
 ;;^UTILITY(U,$J,358.4,1212,0)
 ;;=AMPUTATION^1^122
 ;;^UTILITY(U,$J,358.4,1213,0)
 ;;=GRAFT^10^122
 ;;^UTILITY(U,$J,358.4,1214,0)
 ;;=NAILS^2^123
 ;;^UTILITY(U,$J,358.4,1215,0)
 ;;=OTHER ORTHOTICS^3^123
 ;;^UTILITY(U,$J,358.4,1216,0)
 ;;=IMMUNIZATIONS^1^123
 ;;^UTILITY(U,$J,358.4,1217,0)
 ;;=ESTABLISHED PATIENT^1^124
 ;;^UTILITY(U,$J,358.4,1218,0)
 ;;=ALPHA ORDER (A)^2^125
 ;;^UTILITY(U,$J,358.4,1219,0)
 ;;=ALPHA ORDER (B)^3^125
 ;;^UTILITY(U,$J,358.4,1220,0)
 ;;=ALPHA ORDER (C)^4^125
 ;;^UTILITY(U,$J,358.4,1221,0)
 ;;=ALPHA ORDER (D)^5^125
 ;;^UTILITY(U,$J,358.4,1222,0)
 ;;=ALPHA ORDER (E)^6^125
 ;;^UTILITY(U,$J,358.4,1223,0)
 ;;=ALPHA ORDER (F)^7^125
 ;;^UTILITY(U,$J,358.4,1224,0)
 ;;=ALPHA ORDER (G)^8^125
 ;;^UTILITY(U,$J,358.4,1225,0)
 ;;=ALPHA ORDER (H)^9^125