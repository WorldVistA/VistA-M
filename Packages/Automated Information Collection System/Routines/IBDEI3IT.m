IBDEI3IT ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.4)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.4,2053,0)
 ;;=EXC-MAL LESION-FACE,MUCOUS^10^185
 ;;^UTILITY(U,$J,358.4,2054,0)
 ;;=SHAVING-EPIDERM-SCALP,NK,HAND,FT,GENITAL^31^185
 ;;^UTILITY(U,$J,358.4,2055,0)
 ;;=SHAVING-EPIDERM-FACE,MUCOUS^30^185
 ;;^UTILITY(U,$J,358.4,2056,0)
 ;;=REPAIR-SIMPLE-FACE,MUCOUS^28^185
 ;;^UTILITY(U,$J,358.4,2057,0)
 ;;=REPAIR-INTERM-NK,HAND,FT,GENITALIA^26^185
 ;;^UTILITY(U,$J,358.4,2058,0)
 ;;=REPAIR-INTERM-FACE,MUCOUS^25^185
 ;;^UTILITY(U,$J,358.4,2059,0)
 ;;=WOUND HEALING^39^185
 ;;^UTILITY(U,$J,358.4,2060,0)
 ;;=SKIN TEST^33^185
 ;;^UTILITY(U,$J,358.4,2061,0)
 ;;=MICROBIOLOGY^15^185
 ;;^UTILITY(U,$J,358.4,2062,0)
 ;;=MOHS CHEMOSURGERY^17^185
 ;;^UTILITY(U,$J,358.4,2063,0)
 ;;=INJECTIONS^14^185
 ;;^UTILITY(U,$J,358.4,2064,0)
 ;;=PEEL^19^185
 ;;^UTILITY(U,$J,358.4,2065,0)
 ;;=PHOTOTHERAPY^20^185
 ;;^UTILITY(U,$J,358.4,2066,0)
 ;;=REPAIR-COMPLEX-FACE^23^185
 ;;^UTILITY(U,$J,358.4,2067,0)
 ;;=REPAIR-COMPLEX-NK/HAND/FT^24^185
 ;;^UTILITY(U,$J,358.4,2068,0)
 ;;=REPAIR-COMPLEX-TRUNK^21^185
 ;;^UTILITY(U,$J,358.4,2069,0)
 ;;=TISSUE REARRANGMNT-FACE/NECK/HAND/FOOT^36^185
 ;;^UTILITY(U,$J,358.4,2070,0)
 ;;=TISSUE REARRANGMNT-SCALP/ARMS/LEGS^35^185
 ;;^UTILITY(U,$J,358.4,2071,0)
 ;;=TISSUE REARRANGMNT-TRUNK^34^185
 ;;^UTILITY(U,$J,358.4,2072,0)
 ;;=REPAIR-COMPLEX-SCALP^22^185
 ;;^UTILITY(U,$J,358.4,2073,0)
 ;;=TISSUE REARRANGMNT-EYELID/NOSE/EAR/LIP^37^185
 ;;^UTILITY(U,$J,358.4,2074,0)
 ;;=BIOPSY^1^185
 ;;^UTILITY(U,$J,358.4,2075,0)
 ;;=TISSUE REARRANGEMENT-ANY AREA^38^185
 ;;^UTILITY(U,$J,358.4,2076,0)
 ;;=PLASTIC SURGERY DX^1^186
 ;;^UTILITY(U,$J,358.4,2077,0)
 ;;=NAILS^2^187
 ;;^UTILITY(U,$J,358.4,2078,0)
 ;;=OTHER ORTHOTICS^3^187
 ;;^UTILITY(U,$J,358.4,2079,0)
 ;;=IMMUNIZATIONS^1^187
 ;;^UTILITY(U,$J,358.4,2080,0)
 ;;=ESTABLISHED PATIENT^1^188
 ;;^UTILITY(U,$J,358.4,2081,0)
 ;;=A^1^189
 ;;^UTILITY(U,$J,358.4,2082,0)
 ;;=B^2^189
 ;;^UTILITY(U,$J,358.4,2083,0)
 ;;=C^3^189
 ;;^UTILITY(U,$J,358.4,2084,0)
 ;;=D^4^189
 ;;^UTILITY(U,$J,358.4,2085,0)
 ;;=E^5^189
 ;;^UTILITY(U,$J,358.4,2086,0)
 ;;=F^6^189
 ;;^UTILITY(U,$J,358.4,2087,0)
 ;;=G^7^189
 ;;^UTILITY(U,$J,358.4,2088,0)
 ;;=H^8^189
 ;;^UTILITY(U,$J,358.4,2089,0)
 ;;=I^9^189
 ;;^UTILITY(U,$J,358.4,2090,0)
 ;;=L^12^189
 ;;^UTILITY(U,$J,358.4,2091,0)
 ;;=M^13^189
 ;;^UTILITY(U,$J,358.4,2092,0)
 ;;=N^14^189
 ;;^UTILITY(U,$J,358.4,2093,0)
 ;;=O^15^189
 ;;^UTILITY(U,$J,358.4,2094,0)
 ;;=P^16^189
 ;;^UTILITY(U,$J,358.4,2095,0)
 ;;=R^17^189
 ;;^UTILITY(U,$J,358.4,2096,0)
 ;;=S^18^189
 ;;^UTILITY(U,$J,358.4,2097,0)
 ;;=T^19^189
 ;;^UTILITY(U,$J,358.4,2098,0)
 ;;=U^21^189
 ;;^UTILITY(U,$J,358.4,2099,0)
 ;;=V^22^189
 ;;^UTILITY(U,$J,358.4,2100,0)
 ;;=W^23^189
 ;;^UTILITY(U,$J,358.4,2101,0)
 ;;=X^24^189
 ;;^UTILITY(U,$J,358.4,2102,0)
 ;;=Z CODES^25^189
 ;;^UTILITY(U,$J,358.4,2103,0)
 ;;=NEW PATIENT^2^190
 ;;^UTILITY(U,$J,358.4,2104,0)
 ;;=ESTABLISHED PATIENT^1^190
 ;;^UTILITY(U,$J,358.4,2105,0)
 ;;=CONSULTATION^3^190
 ;;^UTILITY(U,$J,358.4,2106,0)
 ;;=INCISION & DRAINAGE^12^191
 ;;^UTILITY(U,$J,358.4,2107,0)
 ;;=DEBRIDEMENT^6^191
 ;;^UTILITY(U,$J,358.4,2108,0)
 ;;=SHAVING EPIDERMAL/DERMAL LESIONS^26^191
 ;;^UTILITY(U,$J,358.4,2109,0)
 ;;=NAILS^16^191
 ;;^UTILITY(U,$J,358.4,2110,0)
 ;;=PARING OR CUTTING^21^191
 ;;^UTILITY(U,$J,358.4,2111,0)
 ;;=DESTRUCTION-BENIGN OR PREMALIGANT^7^191
 ;;^UTILITY(U,$J,358.4,2112,0)
 ;;=EXCISION-BENIGN LESION (EXCEPT SKIN TAG)^8^191
 ;;^UTILITY(U,$J,358.4,2113,0)
 ;;=EXCISION-MALIGNANT LESIONS^10^191
 ;;^UTILITY(U,$J,358.4,2114,0)
 ;;=REPAIR/CLOSURE^24^191
 ;;^UTILITY(U,$J,358.4,2115,0)
 ;;=BURNS^4^191
 ;;^UTILITY(U,$J,358.4,2116,0)
 ;;=BIOPSIES^3^191