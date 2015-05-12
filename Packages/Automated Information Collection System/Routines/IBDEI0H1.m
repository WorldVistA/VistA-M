IBDEI0H1 ; ; 19-NOV-2014
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,23006,1,2,0)
 ;;=2^Abulatory Surgical Boot,Each
 ;;^UTILITY(U,$J,358.3,23006,1,3,0)
 ;;=3^L3260
 ;;^UTILITY(U,$J,358.3,23007,0)
 ;;=A4500^^124^1398^17^^^^1
 ;;^UTILITY(U,$J,358.3,23007,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,23007,1,2,0)
 ;;=2^Surgical Stocking Below Knee Length,Each
 ;;^UTILITY(U,$J,358.3,23007,1,3,0)
 ;;=3^A4500
 ;;^UTILITY(U,$J,358.3,23008,0)
 ;;=A5501^^124^1398^3^^^^1
 ;;^UTILITY(U,$J,358.3,23008,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,23008,1,2,0)
 ;;=2^Diabetic Shoes,Custom Fit,per Shoe
 ;;^UTILITY(U,$J,358.3,23008,1,3,0)
 ;;=3^A5501
 ;;^UTILITY(U,$J,358.3,23009,0)
 ;;=A6530^^124^1398^7^^^^1
 ;;^UTILITY(U,$J,358.3,23009,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,23009,1,2,0)
 ;;=2^Grad Compression Stocking BK 18-30
 ;;^UTILITY(U,$J,358.3,23009,1,3,0)
 ;;=3^A6530
 ;;^UTILITY(U,$J,358.3,23010,0)
 ;;=A6545^^124^1398^8^^^^1
 ;;^UTILITY(U,$J,358.3,23010,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,23010,1,2,0)
 ;;=2^Grand Compression Wrap Non-Elastic BK
 ;;^UTILITY(U,$J,358.3,23010,1,3,0)
 ;;=3^A6545
 ;;^UTILITY(U,$J,358.3,23011,0)
 ;;=A6206^^124^1398^2^^^^1
 ;;^UTILITY(U,$J,358.3,23011,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,23011,1,2,0)
 ;;=2^Contact Layer <= 16 Sq In
 ;;^UTILITY(U,$J,358.3,23011,1,3,0)
 ;;=3^A6206
 ;;^UTILITY(U,$J,358.3,23012,0)
 ;;=A6402^^124^1398^16^^^^1
 ;;^UTILITY(U,$J,358.3,23012,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,23012,1,2,0)
 ;;=2^Sterile Gauze <= 16 Sq In
 ;;^UTILITY(U,$J,358.3,23012,1,3,0)
 ;;=3^A6402
 ;;^UTILITY(U,$J,358.3,23013,0)
 ;;=A6262^^124^1398^18^^^^1
 ;;^UTILITY(U,$J,358.3,23013,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,23013,1,2,0)
 ;;=2^Wound Filler Dry Form/Gram
 ;;^UTILITY(U,$J,358.3,23013,1,3,0)
 ;;=3^A6262
 ;;^UTILITY(U,$J,358.3,23014,0)
 ;;=A6261^^124^1398^19^^^^1
 ;;^UTILITY(U,$J,358.3,23014,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,23014,1,2,0)
 ;;=2^Wound Filler Gel/Paste per Oz
 ;;^UTILITY(U,$J,358.3,23014,1,3,0)
 ;;=3^A6261
 ;;^UTILITY(U,$J,358.3,23015,0)
 ;;=Q4131^^124^1398^4^^^^1
 ;;^UTILITY(U,$J,358.3,23015,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,23015,1,2,0)
 ;;=2^Epifix
 ;;^UTILITY(U,$J,358.3,23015,1,3,0)
 ;;=3^Q4131
 ;;^UTILITY(U,$J,358.3,23016,0)
 ;;=L3040^^124^1398^5^^^^1
 ;;^UTILITY(U,$J,358.3,23016,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,23016,1,2,0)
 ;;=2^Foot Arch Support Premold Longit
 ;;^UTILITY(U,$J,358.3,23016,1,3,0)
 ;;=3^L3040
 ;;^UTILITY(U,$J,358.3,23017,0)
 ;;=L3219^^124^1398^13^^^^1
 ;;^UTILITY(U,$J,358.3,23017,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,23017,1,2,0)
 ;;=2^Orthopedic Mens Shoes Oxford,Each
 ;;^UTILITY(U,$J,358.3,23017,1,3,0)
 ;;=3^L3219
 ;;^UTILITY(U,$J,358.3,23018,0)
 ;;=L3221^^124^1398^12^^^^1
 ;;^UTILITY(U,$J,358.3,23018,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,23018,1,2,0)
 ;;=2^Orthopedic Mens Shoes Dpth Inlay,Each
 ;;^UTILITY(U,$J,358.3,23018,1,3,0)
 ;;=3^L3221
 ;;^UTILITY(U,$J,358.3,23019,0)
 ;;=Q4102^^124^1398^11^^^^1
 ;;^UTILITY(U,$J,358.3,23019,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,23019,1,2,0)
 ;;=2^Oasis Wound Matrix
 ;;^UTILITY(U,$J,358.3,23019,1,3,0)
 ;;=3^Q4102
 ;;^UTILITY(U,$J,358.3,23020,0)
 ;;=L4360^^124^1398^14^^^^1
 ;;^UTILITY(U,$J,358.3,23020,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,23020,1,2,0)
 ;;=2^Pneumatic Walking Splint
 ;;^UTILITY(U,$J,358.3,23020,1,3,0)
 ;;=3^L4360
 ;;^UTILITY(U,$J,358.3,23021,0)
 ;;=28190^^124^1399^8^^^^1
 ;;^UTILITY(U,$J,358.3,23021,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,23021,1,2,0)
 ;;=2^Removal of foreign body, foot; subcutaneous
 ;;^UTILITY(U,$J,358.3,23021,1,3,0)
 ;;=3^28190
 ;;^UTILITY(U,$J,358.3,23022,0)
 ;;=28192^^124^1399^7^^^^1
 ;;^UTILITY(U,$J,358.3,23022,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,23022,1,2,0)
 ;;=2^Removal of foreign body, foot; deep
 ;;^UTILITY(U,$J,358.3,23022,1,3,0)
 ;;=3^28192
 ;;^UTILITY(U,$J,358.3,23023,0)
 ;;=28193^^124^1399^6^^^^1
 ;;^UTILITY(U,$J,358.3,23023,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,23023,1,2,0)
 ;;=2^Removal of foreign body, foot; complicated
 ;;^UTILITY(U,$J,358.3,23023,1,3,0)
 ;;=3^28193
 ;;^UTILITY(U,$J,358.3,23024,0)
 ;;=20520^^124^1399^4^^^^1
 ;;^UTILITY(U,$J,358.3,23024,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,23024,1,2,0)
 ;;=2^Removal of foreign body in muscle or tendon sheath; simple
 ;;^UTILITY(U,$J,358.3,23024,1,3,0)
 ;;=3^20520
 ;;^UTILITY(U,$J,358.3,23025,0)
 ;;=20525^^124^1399^5^^^^1
 ;;^UTILITY(U,$J,358.3,23025,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,23025,1,2,0)
 ;;=2^Removal of foreign body in muscle or tendon sheath; deep or complicated
 ;;^UTILITY(U,$J,358.3,23025,1,3,0)
 ;;=3^20525
 ;;^UTILITY(U,$J,358.3,23026,0)
 ;;=20670^^124^1399^10^^^^1
 ;;^UTILITY(U,$J,358.3,23026,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,23026,1,2,0)
 ;;=2^Removal of implant; superficial (eg, buried wire, pin or rod)
 ;;^UTILITY(U,$J,358.3,23026,1,3,0)
 ;;=3^20670
 ;;^UTILITY(U,$J,358.3,23027,0)
 ;;=20680^^124^1399^9^^^^1
 ;;^UTILITY(U,$J,358.3,23027,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,23027,1,2,0)
 ;;=2^Removal of implant; deep (eg, buried wire, pin, screw, metal band, nail, rod or plate)
 ;;^UTILITY(U,$J,358.3,23027,1,3,0)
 ;;=3^20680
 ;;^UTILITY(U,$J,358.3,23028,0)
 ;;=S0630^^124^1399^3^^^^1
 ;;^UTILITY(U,$J,358.3,23028,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,23028,1,2,0)
 ;;=2^Removal of Sutures
 ;;^UTILITY(U,$J,358.3,23028,1,3,0)
 ;;=3^S0630
 ;;^UTILITY(U,$J,358.3,23029,0)
 ;;=28805^^124^1400^1^^^^1
 ;;^UTILITY(U,$J,358.3,23029,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,23029,1,2,0)
 ;;=2^Amputation, foot; transmetatarsal
 ;;^UTILITY(U,$J,358.3,23029,1,3,0)
 ;;=3^28805
 ;;^UTILITY(U,$J,358.3,23030,0)
 ;;=28810^^124^1400^2^^^^1
 ;;^UTILITY(U,$J,358.3,23030,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,23030,1,2,0)
 ;;=2^Amputation, metatarsal, with toe, single
 ;;^UTILITY(U,$J,358.3,23030,1,3,0)
 ;;=3^28810
 ;;^UTILITY(U,$J,358.3,23031,0)
 ;;=28820^^124^1400^4^^^^1
 ;;^UTILITY(U,$J,358.3,23031,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,23031,1,2,0)
 ;;=2^Amputation, toe; metatarsophalangeal joint
 ;;^UTILITY(U,$J,358.3,23031,1,3,0)
 ;;=3^28820
 ;;^UTILITY(U,$J,358.3,23032,0)
 ;;=28825^^124^1400^3^^^^1
 ;;^UTILITY(U,$J,358.3,23032,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,23032,1,2,0)
 ;;=2^Amputation, toe; interphalangeal joint
 ;;^UTILITY(U,$J,358.3,23032,1,3,0)
 ;;=3^28825
 ;;^UTILITY(U,$J,358.3,23033,0)
 ;;=15271^^124^1400^5^^^^1
 ;;^UTILITY(U,$J,358.3,23033,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,23033,1,2,0)
 ;;=2^Skin Sub Graft Trnk/Arm/Leg,1st 25 sq cm
 ;;^UTILITY(U,$J,358.3,23033,1,3,0)
 ;;=3^15271
 ;;^UTILITY(U,$J,358.3,23034,0)
 ;;=15272^^124^1400^6^^^^1
 ;;^UTILITY(U,$J,358.3,23034,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,23034,1,2,0)
 ;;=2^Skin Sub Graft Trnk/Arm/Leg,Ea Addl 25 sq cm
 ;;^UTILITY(U,$J,358.3,23034,1,3,0)
 ;;=3^15272
 ;;^UTILITY(U,$J,358.3,23035,0)
 ;;=15275^^124^1401^1^^^^1
 ;;^UTILITY(U,$J,358.3,23035,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,23035,1,2,0)
 ;;=2^Skin Sub Graft FN/HF/G 1st 25 sq cm
 ;;^UTILITY(U,$J,358.3,23035,1,3,0)
 ;;=3^15275
 ;;^UTILITY(U,$J,358.3,23036,0)
 ;;=15276^^124^1401^2^^^^1
 ;;^UTILITY(U,$J,358.3,23036,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,23036,1,2,0)
 ;;=2^Skin Sub Graft FN/HF/G Ea Addl 25 sq cm
 ;;^UTILITY(U,$J,358.3,23036,1,3,0)
 ;;=3^15276
 ;;^UTILITY(U,$J,358.3,23037,0)
 ;;=Q4106^^124^1401^3^^^^1
 ;;^UTILITY(U,$J,358.3,23037,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,23037,1,2,0)
 ;;=2^Dermagraft per sq cm
 ;;^UTILITY(U,$J,358.3,23037,1,3,0)
 ;;=3^Q4106
 ;;^UTILITY(U,$J,358.3,23038,0)
 ;;=99201^^125^1402^1
 ;;^UTILITY(U,$J,358.3,23038,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,23038,1,1,0)
 ;;=1^Problem Focus
 ;;^UTILITY(U,$J,358.3,23038,1,2,0)
 ;;=2^99201
 ;;^UTILITY(U,$J,358.3,23039,0)
 ;;=99202^^125^1402^2
 ;;^UTILITY(U,$J,358.3,23039,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,23039,1,1,0)
 ;;=1^Expanded Problem Focus
 ;;^UTILITY(U,$J,358.3,23039,1,2,0)
 ;;=2^99202
 ;;^UTILITY(U,$J,358.3,23040,0)
 ;;=99203^^125^1402^3
 ;;^UTILITY(U,$J,358.3,23040,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,23040,1,1,0)
 ;;=1^Detailed
 ;;^UTILITY(U,$J,358.3,23040,1,2,0)
 ;;=2^99203
 ;;^UTILITY(U,$J,358.3,23041,0)
 ;;=99204^^125^1402^4
 ;;^UTILITY(U,$J,358.3,23041,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,23041,1,1,0)
 ;;=1^Comprehensive, Moderate
 ;;^UTILITY(U,$J,358.3,23041,1,2,0)
 ;;=2^99204
 ;;^UTILITY(U,$J,358.3,23042,0)
 ;;=99205^^125^1402^5
 ;;^UTILITY(U,$J,358.3,23042,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,23042,1,1,0)
 ;;=1^Comprehensive, High
 ;;^UTILITY(U,$J,358.3,23042,1,2,0)
 ;;=2^99205
 ;;^UTILITY(U,$J,358.3,23043,0)
 ;;=99211^^125^1403^1
 ;;^UTILITY(U,$J,358.3,23043,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,23043,1,1,0)
 ;;=1^Brief (no MD seen)
 ;;^UTILITY(U,$J,358.3,23043,1,2,0)
 ;;=2^99211
 ;;^UTILITY(U,$J,358.3,23044,0)
 ;;=99212^^125^1403^2
 ;;^UTILITY(U,$J,358.3,23044,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,23044,1,1,0)
 ;;=1^Problem Focused
 ;;^UTILITY(U,$J,358.3,23044,1,2,0)
 ;;=2^99212
 ;;^UTILITY(U,$J,358.3,23045,0)
 ;;=99213^^125^1403^3
 ;;^UTILITY(U,$J,358.3,23045,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,23045,1,1,0)
 ;;=1^Expanded Problem Focus
 ;;^UTILITY(U,$J,358.3,23045,1,2,0)
 ;;=2^99213
 ;;^UTILITY(U,$J,358.3,23046,0)
 ;;=99214^^125^1403^4
 ;;^UTILITY(U,$J,358.3,23046,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,23046,1,1,0)
 ;;=1^Detailed
 ;;^UTILITY(U,$J,358.3,23046,1,2,0)
 ;;=2^99214
 ;;^UTILITY(U,$J,358.3,23047,0)
 ;;=99215^^125^1403^5
 ;;^UTILITY(U,$J,358.3,23047,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,23047,1,1,0)
 ;;=1^Comprehensive
 ;;^UTILITY(U,$J,358.3,23047,1,2,0)
 ;;=2^99215
 ;;^UTILITY(U,$J,358.3,23048,0)
 ;;=90471^^126^1404^1^^^^1
 ;;^UTILITY(U,$J,358.3,23048,1,0)
 ;;=^358.31IA^3^2
