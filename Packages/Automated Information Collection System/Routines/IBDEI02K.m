IBDEI02K ; ; 09-FEB-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,3008,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3008,1,3,0)
 ;;=3^Chondromalacia patellae, lft knee
 ;;^UTILITY(U,$J,358.3,3008,1,4,0)
 ;;=4^M22.42
 ;;^UTILITY(U,$J,358.3,3008,2)
 ;;=^5011187
 ;;^UTILITY(U,$J,358.3,3009,0)
 ;;=M23.91^^12^118^4
 ;;^UTILITY(U,$J,358.3,3009,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3009,1,3,0)
 ;;=3^Intrnl derangement of rt knee, unspec
 ;;^UTILITY(U,$J,358.3,3009,1,4,0)
 ;;=4^M23.91
 ;;^UTILITY(U,$J,358.3,3009,2)
 ;;=^5133806
 ;;^UTILITY(U,$J,358.3,3010,0)
 ;;=M23.92^^12^118^3
 ;;^UTILITY(U,$J,358.3,3010,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3010,1,3,0)
 ;;=3^Intrnl derangement of lft knee, unspec
 ;;^UTILITY(U,$J,358.3,3010,1,4,0)
 ;;=4^M23.92
 ;;^UTILITY(U,$J,358.3,3010,2)
 ;;=^5133807
 ;;^UTILITY(U,$J,358.3,3011,0)
 ;;=M02.00^^12^119^1
 ;;^UTILITY(U,$J,358.3,3011,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3011,1,3,0)
 ;;=3^Arthropathy following intest bypass, unspec site
 ;;^UTILITY(U,$J,358.3,3011,1,4,0)
 ;;=4^M02.00
 ;;^UTILITY(U,$J,358.3,3011,2)
 ;;=^5009718
 ;;^UTILITY(U,$J,358.3,3012,0)
 ;;=L52.^^12^119^2
 ;;^UTILITY(U,$J,358.3,3012,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3012,1,3,0)
 ;;=3^Erythema nodosum
 ;;^UTILITY(U,$J,358.3,3012,1,4,0)
 ;;=4^L52.
 ;;^UTILITY(U,$J,358.3,3012,2)
 ;;=^42065
 ;;^UTILITY(U,$J,358.3,3013,0)
 ;;=L40.59^^12^119^3
 ;;^UTILITY(U,$J,358.3,3013,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3013,1,3,0)
 ;;=3^Psoriatic arthropathy, oth
 ;;^UTILITY(U,$J,358.3,3013,1,4,0)
 ;;=4^L40.59
 ;;^UTILITY(U,$J,358.3,3013,2)
 ;;=^5009170
 ;;^UTILITY(U,$J,358.3,3014,0)
 ;;=M02.30^^12^119^4
 ;;^UTILITY(U,$J,358.3,3014,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3014,1,3,0)
 ;;=3^Reiter's disease, unspec site
 ;;^UTILITY(U,$J,358.3,3014,1,4,0)
 ;;=4^M02.30
 ;;^UTILITY(U,$J,358.3,3014,2)
 ;;=^5009790
 ;;^UTILITY(U,$J,358.3,3015,0)
 ;;=M94.1^^12^119^5
 ;;^UTILITY(U,$J,358.3,3015,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3015,1,3,0)
 ;;=3^Relapsing polychondritis
 ;;^UTILITY(U,$J,358.3,3015,1,4,0)
 ;;=4^M94.1
 ;;^UTILITY(U,$J,358.3,3015,2)
 ;;=^5015328
 ;;^UTILITY(U,$J,358.3,3016,0)
 ;;=I20.9^^13^120^1
 ;;^UTILITY(U,$J,358.3,3016,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3016,1,3,0)
 ;;=3^Angina Pectoris,Unspec
 ;;^UTILITY(U,$J,358.3,3016,1,4,0)
 ;;=4^I20.9
 ;;^UTILITY(U,$J,358.3,3016,2)
 ;;=^5007079
 ;;^UTILITY(U,$J,358.3,3017,0)
 ;;=I25.10^^13^120^2
 ;;^UTILITY(U,$J,358.3,3017,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3017,1,3,0)
 ;;=3^Athscl Hrt Disease Native Coronary Artery w/o Ang Pctrs
 ;;^UTILITY(U,$J,358.3,3017,1,4,0)
 ;;=4^I25.10
 ;;^UTILITY(U,$J,358.3,3017,2)
 ;;=^5007107
 ;;^UTILITY(U,$J,358.3,3018,0)
 ;;=I48.91^^13^120^3
 ;;^UTILITY(U,$J,358.3,3018,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3018,1,3,0)
 ;;=3^Atrial Fibrillation,Unspec
 ;;^UTILITY(U,$J,358.3,3018,1,4,0)
 ;;=4^I48.91
 ;;^UTILITY(U,$J,358.3,3018,2)
 ;;=^5007229
 ;;^UTILITY(U,$J,358.3,3019,0)
 ;;=I48.0^^13^120^6
 ;;^UTILITY(U,$J,358.3,3019,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3019,1,3,0)
 ;;=3^Paroxysmal Atrial Fibrillation
 ;;^UTILITY(U,$J,358.3,3019,1,4,0)
 ;;=4^I48.0
 ;;^UTILITY(U,$J,358.3,3019,2)
 ;;=^90473
 ;;^UTILITY(U,$J,358.3,3020,0)
 ;;=I48.1^^13^120^7
 ;;^UTILITY(U,$J,358.3,3020,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3020,1,3,0)
 ;;=3^Persistent Atrial Fibrillation
 ;;^UTILITY(U,$J,358.3,3020,1,4,0)
 ;;=4^I48.1
 ;;^UTILITY(U,$J,358.3,3020,2)
 ;;=^5007225
 ;;^UTILITY(U,$J,358.3,3021,0)
 ;;=I48.2^^13^120^4
 ;;^UTILITY(U,$J,358.3,3021,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3021,1,3,0)
 ;;=3^Chronic Atrial Fibrillation
 ;;^UTILITY(U,$J,358.3,3021,1,4,0)
 ;;=4^I48.2
 ;;^UTILITY(U,$J,358.3,3021,2)
 ;;=^5007226
 ;;^UTILITY(U,$J,358.3,3022,0)
 ;;=Z95.0^^13^120^8
 ;;^UTILITY(U,$J,358.3,3022,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3022,1,3,0)
 ;;=3^Presence of Cardiac Pacemaker
 ;;^UTILITY(U,$J,358.3,3022,1,4,0)
 ;;=4^Z95.0
 ;;^UTILITY(U,$J,358.3,3022,2)
 ;;=^5063668
 ;;^UTILITY(U,$J,358.3,3023,0)
 ;;=I50.9^^13^120^5
 ;;^UTILITY(U,$J,358.3,3023,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3023,1,3,0)
 ;;=3^Heart Failure,Unspec
 ;;^UTILITY(U,$J,358.3,3023,1,4,0)
 ;;=4^I50.9
 ;;^UTILITY(U,$J,358.3,3023,2)
 ;;=^5007251
 ;;^UTILITY(U,$J,358.3,3024,0)
 ;;=V49.9XXA^^13^121^1
 ;;^UTILITY(U,$J,358.3,3024,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3024,1,3,0)
 ;;=3^Car Occupant Traffic Accident Injury,Init Encntr
 ;;^UTILITY(U,$J,358.3,3024,1,4,0)
 ;;=4^V49.9XXA
 ;;^UTILITY(U,$J,358.3,3024,2)
 ;;=^5057368
 ;;^UTILITY(U,$J,358.3,3025,0)
 ;;=V59.9XXA^^13^121^7
 ;;^UTILITY(U,$J,358.3,3025,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3025,1,3,0)
 ;;=3^Truck/Van Occupant Traffic Accident Injury,Init Encntr
 ;;^UTILITY(U,$J,358.3,3025,1,4,0)
 ;;=4^V59.9XXA
 ;;^UTILITY(U,$J,358.3,3025,2)
 ;;=^5057659
 ;;^UTILITY(U,$J,358.3,3026,0)
 ;;=V69.9XXA^^13^121^5
 ;;^UTILITY(U,$J,358.3,3026,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3026,1,3,0)
 ;;=3^Heavy Transport Vehicle Occupant Traffic Accident Injury,Init Encntr
 ;;^UTILITY(U,$J,358.3,3026,1,4,0)
 ;;=4^V69.9XXA
 ;;^UTILITY(U,$J,358.3,3026,2)
 ;;=^5057950
 ;;^UTILITY(U,$J,358.3,3027,0)
 ;;=V89.2XXA^^13^121^6
 ;;^UTILITY(U,$J,358.3,3027,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3027,1,3,0)
 ;;=3^Person injured in Motor-Vehicle Traffic Accident,Init Encntr
 ;;^UTILITY(U,$J,358.3,3027,1,4,0)
 ;;=4^V89.2XXA
 ;;^UTILITY(U,$J,358.3,3027,2)
 ;;=^5058688
 ;;^UTILITY(U,$J,358.3,3028,0)
 ;;=W07.XXXA^^13^121^3
 ;;^UTILITY(U,$J,358.3,3028,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3028,1,3,0)
 ;;=3^Fall from Chair,Init Encntr
 ;;^UTILITY(U,$J,358.3,3028,1,4,0)
 ;;=4^W07.XXXA
 ;;^UTILITY(U,$J,358.3,3028,2)
 ;;=^5059562
 ;;^UTILITY(U,$J,358.3,3029,0)
 ;;=W06.XXXA^^13^121^2
 ;;^UTILITY(U,$J,358.3,3029,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3029,1,3,0)
 ;;=3^Fall from Bed,Init Encntr
 ;;^UTILITY(U,$J,358.3,3029,1,4,0)
 ;;=4^W06.XXXA
 ;;^UTILITY(U,$J,358.3,3029,2)
 ;;=^5059559
 ;;^UTILITY(U,$J,358.3,3030,0)
 ;;=W19.XXXA^^13^121^4
 ;;^UTILITY(U,$J,358.3,3030,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3030,1,3,0)
 ;;=3^Fall,Unspec,Init Encntr
 ;;^UTILITY(U,$J,358.3,3030,1,4,0)
 ;;=4^W19.XXXA
 ;;^UTILITY(U,$J,358.3,3030,2)
 ;;=^5059833
 ;;^UTILITY(U,$J,358.3,3031,0)
 ;;=F32.9^^13^122^2
 ;;^UTILITY(U,$J,358.3,3031,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3031,1,3,0)
 ;;=3^MDD,Single Episode,Unspec
 ;;^UTILITY(U,$J,358.3,3031,1,4,0)
 ;;=4^F32.9
 ;;^UTILITY(U,$J,358.3,3031,2)
 ;;=^5003528
 ;;^UTILITY(U,$J,358.3,3032,0)
 ;;=Z71.89^^13^122^1
 ;;^UTILITY(U,$J,358.3,3032,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3032,1,3,0)
 ;;=3^Counseling NEC
 ;;^UTILITY(U,$J,358.3,3032,1,4,0)
 ;;=4^Z71.89
 ;;^UTILITY(U,$J,358.3,3032,2)
 ;;=^5063253
 ;;^UTILITY(U,$J,358.3,3033,0)
 ;;=G56.01^^13^123^6
 ;;^UTILITY(U,$J,358.3,3033,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3033,1,3,0)
 ;;=3^Carpal Tunnel Syndrome,Right Upper Limb
 ;;^UTILITY(U,$J,358.3,3033,1,4,0)
 ;;=4^G56.01
 ;;^UTILITY(U,$J,358.3,3033,2)
 ;;=^5004018
 ;;^UTILITY(U,$J,358.3,3034,0)
 ;;=G56.02^^13^123^5
 ;;^UTILITY(U,$J,358.3,3034,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3034,1,3,0)
 ;;=3^Carpal Tunnel Syndrome,Left Upper Limb
 ;;^UTILITY(U,$J,358.3,3034,1,4,0)
 ;;=4^G56.02
 ;;^UTILITY(U,$J,358.3,3034,2)
 ;;=^5004019
 ;;^UTILITY(U,$J,358.3,3035,0)
 ;;=M19.90^^13^123^11
 ;;^UTILITY(U,$J,358.3,3035,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3035,1,3,0)
 ;;=3^Osteoarthritis,Site Unspec
 ;;^UTILITY(U,$J,358.3,3035,1,4,0)
 ;;=4^M19.90
 ;;^UTILITY(U,$J,358.3,3035,2)
 ;;=^5010853
 ;;^UTILITY(U,$J,358.3,3036,0)
 ;;=M47.812^^13^123^16
 ;;^UTILITY(U,$J,358.3,3036,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3036,1,3,0)
 ;;=3^Spondylosis w/o Myelopathy/Radiculopathy,Cervical Region
 ;;^UTILITY(U,$J,358.3,3036,1,4,0)
 ;;=4^M47.812
 ;;^UTILITY(U,$J,358.3,3036,2)
 ;;=^5012069
 ;;^UTILITY(U,$J,358.3,3037,0)
 ;;=M47.12^^13^123^15
 ;;^UTILITY(U,$J,358.3,3037,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3037,1,3,0)
 ;;=3^Spondylosis w/ Myelopathy,Cervical Region NEC
 ;;^UTILITY(U,$J,358.3,3037,1,4,0)
 ;;=4^M47.12
 ;;^UTILITY(U,$J,358.3,3037,2)
 ;;=^5012052
 ;;^UTILITY(U,$J,358.3,3038,0)
 ;;=M50.30^^13^123^7
 ;;^UTILITY(U,$J,358.3,3038,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3038,1,3,0)
 ;;=3^Cervical Disc Degeneration,Unspec Cervical Region NEC
 ;;^UTILITY(U,$J,358.3,3038,1,4,0)
 ;;=4^M50.30
 ;;^UTILITY(U,$J,358.3,3038,2)
 ;;=^5012227
 ;;^UTILITY(U,$J,358.3,3039,0)
 ;;=M48.02^^13^123^14
 ;;^UTILITY(U,$J,358.3,3039,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3039,1,3,0)
 ;;=3^Spinal Stenosis,Cervical Region
 ;;^UTILITY(U,$J,358.3,3039,1,4,0)
 ;;=4^M48.02
 ;;^UTILITY(U,$J,358.3,3039,2)
 ;;=^5012089
 ;;^UTILITY(U,$J,358.3,3040,0)
 ;;=M54.2^^13^123^8
 ;;^UTILITY(U,$J,358.3,3040,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3040,1,3,0)
 ;;=3^Cervicalgia
 ;;^UTILITY(U,$J,358.3,3040,1,4,0)
 ;;=4^M54.2
 ;;^UTILITY(U,$J,358.3,3040,2)
 ;;=^5012304
 ;;^UTILITY(U,$J,358.3,3041,0)
 ;;=R53.81^^13^123^10
 ;;^UTILITY(U,$J,358.3,3041,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3041,1,3,0)
 ;;=3^Malaise NEC
 ;;^UTILITY(U,$J,358.3,3041,1,4,0)
 ;;=4^R53.81
 ;;^UTILITY(U,$J,358.3,3041,2)
 ;;=^5019518
 ;;^UTILITY(U,$J,358.3,3042,0)
 ;;=Z89.511^^13^123^2
 ;;^UTILITY(U,$J,358.3,3042,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3042,1,3,0)
 ;;=3^Acquired Absence of Right Leg Below Knee
 ;;^UTILITY(U,$J,358.3,3042,1,4,0)
 ;;=4^Z89.511
 ;;^UTILITY(U,$J,358.3,3042,2)
 ;;=^5063566
 ;;^UTILITY(U,$J,358.3,3043,0)
 ;;=Z89.512^^13^123^1
 ;;^UTILITY(U,$J,358.3,3043,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3043,1,3,0)
 ;;=3^Acquired Absence of Left Leg Below Knee
 ;;^UTILITY(U,$J,358.3,3043,1,4,0)
 ;;=4^Z89.512
 ;;^UTILITY(U,$J,358.3,3043,2)
 ;;=^5063567
 ;;^UTILITY(U,$J,358.3,3044,0)
 ;;=Z46.89^^13^123^9
 ;;^UTILITY(U,$J,358.3,3044,1,0)
 ;;=^358.31IA^4^2
