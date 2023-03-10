IBDEI07E ; ; 01-AUG-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;AUG 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,18006,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18006,1,2,0)
 ;;=2^59430
 ;;^UTILITY(U,$J,358.3,18006,1,3,0)
 ;;=3^POST PARTUM CARE ONLY
 ;;^UTILITY(U,$J,358.3,18007,0)
 ;;=99401^^60^725^1^^^^1
 ;;^UTILITY(U,$J,358.3,18007,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18007,1,2,0)
 ;;=2^99401
 ;;^UTILITY(U,$J,358.3,18007,1,3,0)
 ;;=3^PREVENTIVE COUNSELING INDIV,15MIN
 ;;^UTILITY(U,$J,358.3,18008,0)
 ;;=99402^^60^725^2^^^^1
 ;;^UTILITY(U,$J,358.3,18008,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18008,1,2,0)
 ;;=2^99402
 ;;^UTILITY(U,$J,358.3,18008,1,3,0)
 ;;=3^PREVENTIVE COUNSELING INDIV,30MIN
 ;;^UTILITY(U,$J,358.3,18009,0)
 ;;=99403^^60^725^3^^^^1
 ;;^UTILITY(U,$J,358.3,18009,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18009,1,2,0)
 ;;=2^99403
 ;;^UTILITY(U,$J,358.3,18009,1,3,0)
 ;;=3^PREVENTIVE COUNSELING INDIV,45MIN
 ;;^UTILITY(U,$J,358.3,18010,0)
 ;;=99395^^60^726^1^^^^1
 ;;^UTILITY(U,$J,358.3,18010,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18010,1,2,0)
 ;;=2^99395
 ;;^UTILITY(U,$J,358.3,18010,1,3,0)
 ;;=3^PREV VISIT EST AGE 18-39
 ;;^UTILITY(U,$J,358.3,18011,0)
 ;;=99396^^60^726^2^^^^1
 ;;^UTILITY(U,$J,358.3,18011,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18011,1,2,0)
 ;;=2^99396
 ;;^UTILITY(U,$J,358.3,18011,1,3,0)
 ;;=3^PREV VISIT EST AGE 40-64
 ;;^UTILITY(U,$J,358.3,18012,0)
 ;;=99397^^60^726^3^^^^1
 ;;^UTILITY(U,$J,358.3,18012,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18012,1,2,0)
 ;;=2^99397
 ;;^UTILITY(U,$J,358.3,18012,1,3,0)
 ;;=3^PREV VISIT EST 65 & OVER
 ;;^UTILITY(U,$J,358.3,18013,0)
 ;;=99385^^60^727^1^^^^1
 ;;^UTILITY(U,$J,358.3,18013,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18013,1,2,0)
 ;;=2^99385
 ;;^UTILITY(U,$J,358.3,18013,1,3,0)
 ;;=3^PREV VISIT NEW AGE 18-39
 ;;^UTILITY(U,$J,358.3,18014,0)
 ;;=99386^^60^727^2^^^^1
 ;;^UTILITY(U,$J,358.3,18014,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18014,1,2,0)
 ;;=2^99386
 ;;^UTILITY(U,$J,358.3,18014,1,3,0)
 ;;=3^PREV VISIT NEW AGE 40-64
 ;;^UTILITY(U,$J,358.3,18015,0)
 ;;=99387^^60^727^3^^^^1
 ;;^UTILITY(U,$J,358.3,18015,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18015,1,2,0)
 ;;=2^99387
 ;;^UTILITY(U,$J,358.3,18015,1,3,0)
 ;;=3^PREV VISIT NEW 65 & OVER
 ;;^UTILITY(U,$J,358.3,18016,0)
 ;;=A4247^^60^728^2^^^^1
 ;;^UTILITY(U,$J,358.3,18016,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18016,1,2,0)
 ;;=2^A4247
 ;;^UTILITY(U,$J,358.3,18016,1,3,0)
 ;;=3^BETADINE/IODINE SWABS/WIPES,BOX
 ;;^UTILITY(U,$J,358.3,18017,0)
 ;;=A4332^^60^728^3^^^^1
 ;;^UTILITY(U,$J,358.3,18017,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18017,1,2,0)
 ;;=2^A4332
 ;;^UTILITY(U,$J,358.3,18017,1,3,0)
 ;;=3^LUBE STERILE PACKET
 ;;^UTILITY(U,$J,358.3,18018,0)
 ;;=A4208^^60^728^1^^^^1
 ;;^UTILITY(U,$J,358.3,18018,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18018,1,2,0)
 ;;=2^A4208
 ;;^UTILITY(U,$J,358.3,18018,1,3,0)
 ;;=3^3 CC STERILE SYRINGE & NEEDLE
 ;;^UTILITY(U,$J,358.3,18019,0)
 ;;=99354^^60^729^1^^^^1
 ;;^UTILITY(U,$J,358.3,18019,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18019,1,2,0)
 ;;=2^99354
 ;;^UTILITY(U,$J,358.3,18019,1,3,0)
 ;;=3^Prolng Svc Outpt/Obsv 30-74 min
 ;;^UTILITY(U,$J,358.3,18020,0)
 ;;=99355^^60^729^2^^^^1
 ;;^UTILITY(U,$J,358.3,18020,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18020,1,2,0)
 ;;=2^99355
 ;;^UTILITY(U,$J,358.3,18020,1,3,0)
 ;;=3^Prolng Svc Outpt/Obsv,Ea Addl 30 min
 ;;^UTILITY(U,$J,358.3,18021,0)
 ;;=99356^^60^729^3^^^^1
 ;;^UTILITY(U,$J,358.3,18021,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18021,1,2,0)
 ;;=2^99356
 ;;^UTILITY(U,$J,358.3,18021,1,3,0)
 ;;=3^Prolng Svc Inpt 30-74 min
 ;;^UTILITY(U,$J,358.3,18022,0)
 ;;=99357^^60^729^4^^^^1
 ;;^UTILITY(U,$J,358.3,18022,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18022,1,2,0)
 ;;=2^99357
 ;;^UTILITY(U,$J,358.3,18022,1,3,0)
 ;;=3^Prolng Svc Inpt,Ea Addl 30 min
 ;;^UTILITY(U,$J,358.3,18023,0)
 ;;=99358^^60^729^5^^^^1
 ;;^UTILITY(U,$J,358.3,18023,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18023,1,2,0)
 ;;=2^99358
 ;;^UTILITY(U,$J,358.3,18023,1,3,0)
 ;;=3^Prolng Svc w/o Pt 30-74 min
 ;;^UTILITY(U,$J,358.3,18024,0)
 ;;=99359^^60^729^6^^^^1
 ;;^UTILITY(U,$J,358.3,18024,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18024,1,2,0)
 ;;=2^99359
 ;;^UTILITY(U,$J,358.3,18024,1,3,0)
 ;;=3^Prolng Svc w/o Pt,Ea Addl 30 min
 ;;^UTILITY(U,$J,358.3,18025,0)
 ;;=99415^^60^729^7^^^^1
 ;;^UTILITY(U,$J,358.3,18025,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18025,1,2,0)
 ;;=2^99415
 ;;^UTILITY(U,$J,358.3,18025,1,3,0)
 ;;=3^Prolng Clin Staff Svc 45-74 min
 ;;^UTILITY(U,$J,358.3,18026,0)
 ;;=99416^^60^729^8^^^^1
 ;;^UTILITY(U,$J,358.3,18026,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18026,1,2,0)
 ;;=2^99416
 ;;^UTILITY(U,$J,358.3,18026,1,3,0)
 ;;=3^Prolng Clin Staff Svc,Ea Addl 30 min
 ;;^UTILITY(U,$J,358.3,18027,0)
 ;;=99417^^60^729^9^^^^1
 ;;^UTILITY(U,$J,358.3,18027,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18027,1,2,0)
 ;;=2^99417
 ;;^UTILITY(U,$J,358.3,18027,1,3,0)
 ;;=3^Prolng Clin Staff Svc,Ea 15 min;Only w/ 99205/99215
 ;;^UTILITY(U,$J,358.3,18028,0)
 ;;=99202^^61^730^1
 ;;^UTILITY(U,$J,358.3,18028,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,18028,1,1,0)
 ;;=1^SF MDM or 15-29 mins
 ;;^UTILITY(U,$J,358.3,18028,1,2,0)
 ;;=2^99202
 ;;^UTILITY(U,$J,358.3,18029,0)
 ;;=99203^^61^730^2
 ;;^UTILITY(U,$J,358.3,18029,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,18029,1,1,0)
 ;;=1^Low Complex MDM or 30-44 mins
 ;;^UTILITY(U,$J,358.3,18029,1,2,0)
 ;;=2^99203
 ;;^UTILITY(U,$J,358.3,18030,0)
 ;;=99204^^61^730^3
 ;;^UTILITY(U,$J,358.3,18030,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,18030,1,1,0)
 ;;=1^Mod Complex MDM or 45-59 mins
 ;;^UTILITY(U,$J,358.3,18030,1,2,0)
 ;;=2^99204
 ;;^UTILITY(U,$J,358.3,18031,0)
 ;;=99205^^61^730^4
 ;;^UTILITY(U,$J,358.3,18031,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,18031,1,1,0)
 ;;=1^High Complex MDM or 60-74 mins
 ;;^UTILITY(U,$J,358.3,18031,1,2,0)
 ;;=2^99205
 ;;^UTILITY(U,$J,358.3,18032,0)
 ;;=99211^^61^731^1
 ;;^UTILITY(U,$J,358.3,18032,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,18032,1,1,0)
 ;;=1^Nurse Visit (no MD seen)
 ;;^UTILITY(U,$J,358.3,18032,1,2,0)
 ;;=2^99211
 ;;^UTILITY(U,$J,358.3,18033,0)
 ;;=99212^^61^731^2
 ;;^UTILITY(U,$J,358.3,18033,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,18033,1,1,0)
 ;;=1^SF MDM or 10-19 mins
 ;;^UTILITY(U,$J,358.3,18033,1,2,0)
 ;;=2^99212
 ;;^UTILITY(U,$J,358.3,18034,0)
 ;;=99213^^61^731^3
 ;;^UTILITY(U,$J,358.3,18034,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,18034,1,1,0)
 ;;=1^Low Complex MDM or 20-29 mins
 ;;^UTILITY(U,$J,358.3,18034,1,2,0)
 ;;=2^99213
 ;;^UTILITY(U,$J,358.3,18035,0)
 ;;=99214^^61^731^4
 ;;^UTILITY(U,$J,358.3,18035,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,18035,1,1,0)
 ;;=1^Mod Complex MDM or 30-39 mins
 ;;^UTILITY(U,$J,358.3,18035,1,2,0)
 ;;=2^99214
 ;;^UTILITY(U,$J,358.3,18036,0)
 ;;=99215^^61^731^5
 ;;^UTILITY(U,$J,358.3,18036,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,18036,1,1,0)
 ;;=1^High Complex MDM or 40-54 mins
 ;;^UTILITY(U,$J,358.3,18036,1,2,0)
 ;;=2^99215
 ;;^UTILITY(U,$J,358.3,18037,0)
 ;;=99024^^61^731^6
 ;;^UTILITY(U,$J,358.3,18037,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,18037,1,1,0)
 ;;=1^Post Op Visit in Global
 ;;^UTILITY(U,$J,358.3,18037,1,2,0)
 ;;=2^99024
 ;;^UTILITY(U,$J,358.3,18038,0)
 ;;=99241^^61^732^1
 ;;^UTILITY(U,$J,358.3,18038,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,18038,1,1,0)
 ;;=1^Prob Focused Exam
 ;;^UTILITY(U,$J,358.3,18038,1,2,0)
 ;;=2^99241
 ;;^UTILITY(U,$J,358.3,18039,0)
 ;;=99242^^61^732^2
 ;;^UTILITY(U,$J,358.3,18039,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,18039,1,1,0)
 ;;=1^Exp Prob Focused Exam
 ;;^UTILITY(U,$J,358.3,18039,1,2,0)
 ;;=2^99242
 ;;^UTILITY(U,$J,358.3,18040,0)
 ;;=99243^^61^732^3
 ;;^UTILITY(U,$J,358.3,18040,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,18040,1,1,0)
 ;;=1^Detailed Exam
 ;;^UTILITY(U,$J,358.3,18040,1,2,0)
 ;;=2^99243
 ;;^UTILITY(U,$J,358.3,18041,0)
 ;;=99244^^61^732^4
 ;;^UTILITY(U,$J,358.3,18041,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,18041,1,1,0)
 ;;=1^Comprehensive,Moderate
 ;;^UTILITY(U,$J,358.3,18041,1,2,0)
 ;;=2^99244
 ;;^UTILITY(U,$J,358.3,18042,0)
 ;;=99245^^61^732^5
 ;;^UTILITY(U,$J,358.3,18042,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,18042,1,1,0)
 ;;=1^Comprehensive,High
 ;;^UTILITY(U,$J,358.3,18042,1,2,0)
 ;;=2^99245
 ;;^UTILITY(U,$J,358.3,18043,0)
 ;;=O01.9^^62^733^15
 ;;^UTILITY(U,$J,358.3,18043,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18043,1,3,0)
 ;;=3^Hydatidiform mole, unspecified
 ;;^UTILITY(U,$J,358.3,18043,1,4,0)
 ;;=4^O01.9
 ;;^UTILITY(U,$J,358.3,18043,2)
 ;;=^5015977
 ;;^UTILITY(U,$J,358.3,18044,0)
 ;;=O02.81^^62^733^16
 ;;^UTILITY(U,$J,358.3,18044,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18044,1,3,0)
 ;;=3^Inapprop chg quantitav hCG in early pregnancy
 ;;^UTILITY(U,$J,358.3,18044,1,4,0)
 ;;=4^O02.81
 ;;^UTILITY(U,$J,358.3,18044,2)
 ;;=^340611
 ;;^UTILITY(U,$J,358.3,18045,0)
 ;;=O02.1^^62^733^17
 ;;^UTILITY(U,$J,358.3,18045,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18045,1,3,0)
 ;;=3^Missed abortion
 ;;^UTILITY(U,$J,358.3,18045,1,4,0)
 ;;=4^O02.1
 ;;^UTILITY(U,$J,358.3,18045,2)
 ;;=^1259
 ;;^UTILITY(U,$J,358.3,18046,0)
 ;;=O08.7^^62^733^56
 ;;^UTILITY(U,$J,358.3,18046,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18046,1,3,0)
 ;;=3^Venous comp following an ectopic and molar pregnancy NEC
 ;;^UTILITY(U,$J,358.3,18046,1,4,0)
 ;;=4^O08.7
 ;;^UTILITY(U,$J,358.3,18046,2)
 ;;=^5016042
 ;;^UTILITY(U,$J,358.3,18047,0)
 ;;=O08.81^^62^733^13
 ;;^UTILITY(U,$J,358.3,18047,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18047,1,3,0)
 ;;=3^Cardiac arrest following an ectopic and molar pregnancy
 ;;^UTILITY(U,$J,358.3,18047,1,4,0)
 ;;=4^O08.81
 ;;^UTILITY(U,$J,358.3,18047,2)
 ;;=^5016043
 ;;^UTILITY(U,$J,358.3,18048,0)
 ;;=O08.83^^62^733^55
 ;;^UTILITY(U,$J,358.3,18048,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18048,1,3,0)
 ;;=3^Urinary tract infection fol an ectopic and molar pregnancy
 ;;^UTILITY(U,$J,358.3,18048,1,4,0)
 ;;=4^O08.83
 ;;^UTILITY(U,$J,358.3,18048,2)
 ;;=^5016045
 ;;^UTILITY(U,$J,358.3,18049,0)
 ;;=O08.89^^62^733^14
 ;;^UTILITY(U,$J,358.3,18049,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18049,1,3,0)
 ;;=3^Complications following an ectopic and molar pregnancy NEC
 ;;^UTILITY(U,$J,358.3,18049,1,4,0)
 ;;=4^O08.89
 ;;^UTILITY(U,$J,358.3,18049,2)
 ;;=^5016046
 ;;^UTILITY(U,$J,358.3,18050,0)
 ;;=O20.0^^62^733^54
 ;;^UTILITY(U,$J,358.3,18050,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18050,1,3,0)
 ;;=3^Threatened abortion
 ;;^UTILITY(U,$J,358.3,18050,1,4,0)
 ;;=4^O20.0
 ;;^UTILITY(U,$J,358.3,18050,2)
 ;;=^1287
 ;;^UTILITY(U,$J,358.3,18051,0)
 ;;=O44.01^^62^733^21
 ;;^UTILITY(U,$J,358.3,18051,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18051,1,3,0)
 ;;=3^Placenta Previa,Complete w/o Hemorrhage,1st Trimester
 ;;^UTILITY(U,$J,358.3,18051,1,4,0)
 ;;=4^O44.01
 ;;^UTILITY(U,$J,358.3,18051,2)
 ;;=^5017437
 ;;^UTILITY(U,$J,358.3,18052,0)
 ;;=O44.02^^62^733^22
 ;;^UTILITY(U,$J,358.3,18052,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18052,1,3,0)
 ;;=3^Placenta Previa,Complete w/o Hemorrhage,2nd Trimester
 ;;^UTILITY(U,$J,358.3,18052,1,4,0)
 ;;=4^O44.02
 ;;^UTILITY(U,$J,358.3,18052,2)
 ;;=^5017438
 ;;^UTILITY(U,$J,358.3,18053,0)
 ;;=O44.03^^62^733^23
 ;;^UTILITY(U,$J,358.3,18053,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18053,1,3,0)
 ;;=3^Placenta Previa,Complete w/o Hemorrhage,3rd Trimester
 ;;^UTILITY(U,$J,358.3,18053,1,4,0)
 ;;=4^O44.03
 ;;^UTILITY(U,$J,358.3,18053,2)
 ;;=^5017439
 ;;^UTILITY(U,$J,358.3,18054,0)
 ;;=O44.11^^62^733^18
 ;;^UTILITY(U,$J,358.3,18054,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18054,1,3,0)
 ;;=3^Placenta Previa,Complete w/ Hemorrhage,1st Trimester
 ;;^UTILITY(U,$J,358.3,18054,1,4,0)
 ;;=4^O44.11
 ;;^UTILITY(U,$J,358.3,18054,2)
 ;;=^5017441
 ;;^UTILITY(U,$J,358.3,18055,0)
 ;;=O44.12^^62^733^19
 ;;^UTILITY(U,$J,358.3,18055,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18055,1,3,0)
 ;;=3^Placenta Previa,Complete w/ Hemorrhage,2nd Trimester
 ;;^UTILITY(U,$J,358.3,18055,1,4,0)
 ;;=4^O44.12
 ;;^UTILITY(U,$J,358.3,18055,2)
 ;;=^5017442
 ;;^UTILITY(U,$J,358.3,18056,0)
 ;;=O44.13^^62^733^20
 ;;^UTILITY(U,$J,358.3,18056,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18056,1,3,0)
 ;;=3^Placenta Previa,Complete w/ Hemorrhage,3rd Trimester
 ;;^UTILITY(U,$J,358.3,18056,1,4,0)
 ;;=4^O44.13
 ;;^UTILITY(U,$J,358.3,18056,2)
 ;;=^5017443
 ;;^UTILITY(U,$J,358.3,18057,0)
 ;;=O45.8X1^^62^733^48
 ;;^UTILITY(U,$J,358.3,18057,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18057,1,3,0)
 ;;=3^Prem separtn of placenta, first trimester NEC
 ;;^UTILITY(U,$J,358.3,18057,1,4,0)
 ;;=4^O45.8X1
 ;;^UTILITY(U,$J,358.3,18057,2)
 ;;=^5017459
 ;;^UTILITY(U,$J,358.3,18058,0)
 ;;=O45.8X2^^62^733^49
 ;;^UTILITY(U,$J,358.3,18058,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18058,1,3,0)
 ;;=3^Prem separtn of placenta, second trimester NEC
 ;;^UTILITY(U,$J,358.3,18058,1,4,0)
 ;;=4^O45.8X2
 ;;^UTILITY(U,$J,358.3,18058,2)
 ;;=^5017460
 ;;^UTILITY(U,$J,358.3,18059,0)
 ;;=O45.8X3^^62^733^50
 ;;^UTILITY(U,$J,358.3,18059,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18059,1,3,0)
 ;;=3^Prem separtn of placenta, third trimester NEC
 ;;^UTILITY(U,$J,358.3,18059,1,4,0)
 ;;=4^O45.8X3
 ;;^UTILITY(U,$J,358.3,18059,2)
 ;;=^5017461
 ;;^UTILITY(U,$J,358.3,18060,0)
 ;;=O45.91^^62^733^51
 ;;^UTILITY(U,$J,358.3,18060,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18060,1,3,0)
 ;;=3^Prem separtn of placenta, unsp, first trimester
 ;;^UTILITY(U,$J,358.3,18060,1,4,0)
 ;;=4^O45.91
 ;;^UTILITY(U,$J,358.3,18060,2)
 ;;=^5017464
 ;;^UTILITY(U,$J,358.3,18061,0)
 ;;=O45.92^^62^733^52
 ;;^UTILITY(U,$J,358.3,18061,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18061,1,3,0)
 ;;=3^Prem separtn of placenta, unsp, second trimester
 ;;^UTILITY(U,$J,358.3,18061,1,4,0)
 ;;=4^O45.92
 ;;^UTILITY(U,$J,358.3,18061,2)
 ;;=^5017465
 ;;^UTILITY(U,$J,358.3,18062,0)
 ;;=O45.93^^62^733^53
 ;;^UTILITY(U,$J,358.3,18062,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18062,1,3,0)
 ;;=3^Prem separtn of placenta, unsp, third trimester
 ;;^UTILITY(U,$J,358.3,18062,1,4,0)
 ;;=4^O45.93
 ;;^UTILITY(U,$J,358.3,18062,2)
 ;;=^5017466
 ;;^UTILITY(U,$J,358.3,18063,0)
 ;;=O45.001^^62^733^39
 ;;^UTILITY(U,$J,358.3,18063,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18063,1,3,0)
 ;;=3^Prem separtn of placenta w coag defect, unsp, first tri
 ;;^UTILITY(U,$J,358.3,18063,1,4,0)
 ;;=4^O45.001
 ;;^UTILITY(U,$J,358.3,18063,2)
 ;;=^5017444
 ;;^UTILITY(U,$J,358.3,18064,0)
 ;;=O45.002^^62^733^40
 ;;^UTILITY(U,$J,358.3,18064,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18064,1,3,0)
 ;;=3^Prem separtn of placenta w coag defect, unsp, second tri
 ;;^UTILITY(U,$J,358.3,18064,1,4,0)
 ;;=4^O45.002
 ;;^UTILITY(U,$J,358.3,18064,2)
 ;;=^5017445
 ;;^UTILITY(U,$J,358.3,18065,0)
 ;;=O45.003^^62^733^41
 ;;^UTILITY(U,$J,358.3,18065,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18065,1,3,0)
 ;;=3^Prem separtn of placenta w coag defect, unsp, third tri
 ;;^UTILITY(U,$J,358.3,18065,1,4,0)
 ;;=4^O45.003
 ;;^UTILITY(U,$J,358.3,18065,2)
 ;;=^5017446
 ;;^UTILITY(U,$J,358.3,18066,0)
 ;;=O45.011^^62^733^36
 ;;^UTILITY(U,$J,358.3,18066,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18066,1,3,0)
 ;;=3^Prem separtn of placenta w afibrinogenemia, first trimester
 ;;^UTILITY(U,$J,358.3,18066,1,4,0)
 ;;=4^O45.011
 ;;^UTILITY(U,$J,358.3,18066,2)
 ;;=^5017448
 ;;^UTILITY(U,$J,358.3,18067,0)
 ;;=O45.012^^62^733^37
 ;;^UTILITY(U,$J,358.3,18067,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18067,1,3,0)
 ;;=3^Prem separtn of placenta w afibrinogenemia, second trimester
 ;;^UTILITY(U,$J,358.3,18067,1,4,0)
 ;;=4^O45.012
 ;;^UTILITY(U,$J,358.3,18067,2)
 ;;=^5017449
 ;;^UTILITY(U,$J,358.3,18068,0)
 ;;=O45.013^^62^733^38
 ;;^UTILITY(U,$J,358.3,18068,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18068,1,3,0)
 ;;=3^Prem separtn of placenta w afibrinogenemia, third trimester
 ;;^UTILITY(U,$J,358.3,18068,1,4,0)
 ;;=4^O45.013
 ;;^UTILITY(U,$J,358.3,18068,2)
 ;;=^5017450
 ;;^UTILITY(U,$J,358.3,18069,0)
 ;;=O45.021^^62^733^42
 ;;^UTILITY(U,$J,358.3,18069,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18069,1,3,0)
 ;;=3^Prem separtn of placenta w dissem intravasc coag, first tri
 ;;^UTILITY(U,$J,358.3,18069,1,4,0)
 ;;=4^O45.021
 ;;^UTILITY(U,$J,358.3,18069,2)
 ;;=^5017452
 ;;^UTILITY(U,$J,358.3,18070,0)
 ;;=O45.022^^62^733^43
 ;;^UTILITY(U,$J,358.3,18070,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18070,1,3,0)
 ;;=3^Prem separtn of placenta w dissem intravasc coag, second tri
 ;;^UTILITY(U,$J,358.3,18070,1,4,0)
 ;;=4^O45.022
 ;;^UTILITY(U,$J,358.3,18070,2)
 ;;=^5017453
 ;;^UTILITY(U,$J,358.3,18071,0)
 ;;=O45.023^^62^733^44
 ;;^UTILITY(U,$J,358.3,18071,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18071,1,3,0)
 ;;=3^Prem separtn of placenta w dissem intravasc coag, third tri
 ;;^UTILITY(U,$J,358.3,18071,1,4,0)
 ;;=4^O45.023
 ;;^UTILITY(U,$J,358.3,18071,2)
 ;;=^5017454
 ;;^UTILITY(U,$J,358.3,18072,0)
 ;;=O45.091^^62^733^45
 ;;^UTILITY(U,$J,358.3,18072,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18072,1,3,0)
 ;;=3^Prem separtn of placenta w oth coag defect, first trimester
 ;;^UTILITY(U,$J,358.3,18072,1,4,0)
 ;;=4^O45.091
 ;;^UTILITY(U,$J,358.3,18072,2)
 ;;=^5017456
 ;;^UTILITY(U,$J,358.3,18073,0)
 ;;=O45.092^^62^733^46
 ;;^UTILITY(U,$J,358.3,18073,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18073,1,3,0)
 ;;=3^Prem separtn of placenta w oth coag defect, second trimester
 ;;^UTILITY(U,$J,358.3,18073,1,4,0)
 ;;=4^O45.092
 ;;^UTILITY(U,$J,358.3,18073,2)
 ;;=^5017457
 ;;^UTILITY(U,$J,358.3,18074,0)
 ;;=O45.093^^62^733^47
 ;;^UTILITY(U,$J,358.3,18074,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18074,1,3,0)
 ;;=3^Prem separtn of placenta w oth coag defect, third trimester
 ;;^UTILITY(U,$J,358.3,18074,1,4,0)
 ;;=4^O45.093
 ;;^UTILITY(U,$J,358.3,18074,2)
 ;;=^5017458
 ;;^UTILITY(U,$J,358.3,18075,0)
 ;;=O46.001^^62^733^4
 ;;^UTILITY(U,$J,358.3,18075,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18075,1,3,0)
 ;;=3^Antepartum hemorrhage w coag defect, unsp, first trimester
 ;;^UTILITY(U,$J,358.3,18075,1,4,0)
 ;;=4^O46.001
 ;;^UTILITY(U,$J,358.3,18075,2)
 ;;=^5017467
 ;;^UTILITY(U,$J,358.3,18076,0)
 ;;=O46.002^^62^733^5
 ;;^UTILITY(U,$J,358.3,18076,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18076,1,3,0)
 ;;=3^Antepartum hemorrhage w coag defect, unsp, second trimester
 ;;^UTILITY(U,$J,358.3,18076,1,4,0)
 ;;=4^O46.002
 ;;^UTILITY(U,$J,358.3,18076,2)
 ;;=^5017468
 ;;^UTILITY(U,$J,358.3,18077,0)
 ;;=O46.003^^62^733^6
 ;;^UTILITY(U,$J,358.3,18077,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18077,1,3,0)
 ;;=3^Antepartum hemorrhage w coag defect, unsp, third trimester
 ;;^UTILITY(U,$J,358.3,18077,1,4,0)
 ;;=4^O46.003
 ;;^UTILITY(U,$J,358.3,18077,2)
 ;;=^5017469
 ;;^UTILITY(U,$J,358.3,18078,0)
 ;;=O46.011^^62^733^1
 ;;^UTILITY(U,$J,358.3,18078,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18078,1,3,0)
 ;;=3^Antepartum hemorrhage w afibrinogenemia, first trimester
 ;;^UTILITY(U,$J,358.3,18078,1,4,0)
 ;;=4^O46.011
