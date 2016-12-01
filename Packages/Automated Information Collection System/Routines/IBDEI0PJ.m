IBDEI0PJ ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,33820,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,33820,1,2,0)
 ;;=2^97602
 ;;^UTILITY(U,$J,358.3,33820,1,3,0)
 ;;=3^Wound Care, non-selective debridement
 ;;^UTILITY(U,$J,358.3,33821,0)
 ;;=51701^^99^1476^8^^^^1
 ;;^UTILITY(U,$J,358.3,33821,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,33821,1,2,0)
 ;;=2^51701
 ;;^UTILITY(U,$J,358.3,33821,1,3,0)
 ;;=3^Insert Catheter for Residual Urine
 ;;^UTILITY(U,$J,358.3,33822,0)
 ;;=51702^^99^1476^9^^^^1
 ;;^UTILITY(U,$J,358.3,33822,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,33822,1,2,0)
 ;;=2^51702
 ;;^UTILITY(U,$J,358.3,33822,1,3,0)
 ;;=3^Insert Foley Cath
 ;;^UTILITY(U,$J,358.3,33823,0)
 ;;=51798^^99^1476^14^^^^1
 ;;^UTILITY(U,$J,358.3,33823,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,33823,1,2,0)
 ;;=2^51798
 ;;^UTILITY(U,$J,358.3,33823,1,3,0)
 ;;=3^Ultrasound for Resid Urine
 ;;^UTILITY(U,$J,358.3,33824,0)
 ;;=96360^^99^1476^4^^^^1
 ;;^UTILITY(U,$J,358.3,33824,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,33824,1,2,0)
 ;;=2^96360
 ;;^UTILITY(U,$J,358.3,33824,1,3,0)
 ;;=3^Hydration,IV,first hour
 ;;^UTILITY(U,$J,358.3,33825,0)
 ;;=96361^^99^1476^5^^^^1
 ;;^UTILITY(U,$J,358.3,33825,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,33825,1,2,0)
 ;;=2^96361
 ;;^UTILITY(U,$J,358.3,33825,1,3,0)
 ;;=3^Hydration,IV,EA addl hour
 ;;^UTILITY(U,$J,358.3,33826,0)
 ;;=96365^^99^1476^6^^^^1
 ;;^UTILITY(U,$J,358.3,33826,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,33826,1,2,0)
 ;;=2^96365
 ;;^UTILITY(U,$J,358.3,33826,1,3,0)
 ;;=3^Infusion,IV up to 1 hour
 ;;^UTILITY(U,$J,358.3,33827,0)
 ;;=96366^^99^1476^7^^^^1
 ;;^UTILITY(U,$J,358.3,33827,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,33827,1,2,0)
 ;;=2^96366
 ;;^UTILITY(U,$J,358.3,33827,1,3,0)
 ;;=3^Infusion,IV ea add hr
 ;;^UTILITY(U,$J,358.3,33828,0)
 ;;=17000^^99^1477^13^^^^1
 ;;^UTILITY(U,$J,358.3,33828,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,33828,1,2,0)
 ;;=2^17000
 ;;^UTILITY(U,$J,358.3,33828,1,3,0)
 ;;=3^Destr ben les, any method, 1st les
 ;;^UTILITY(U,$J,358.3,33829,0)
 ;;=17003^^99^1477^14^^^^1
 ;;^UTILITY(U,$J,358.3,33829,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,33829,1,2,0)
 ;;=2^17003
 ;;^UTILITY(U,$J,358.3,33829,1,3,0)
 ;;=3^Destr ben les, any method,ea addl les (2-14)
 ;;^UTILITY(U,$J,358.3,33830,0)
 ;;=17004^^99^1477^15^^^^1
 ;;^UTILITY(U,$J,358.3,33830,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,33830,1,2,0)
 ;;=2^17004
 ;;^UTILITY(U,$J,358.3,33830,1,3,0)
 ;;=3^Destr ben les,15 or more
 ;;^UTILITY(U,$J,358.3,33831,0)
 ;;=10060^^99^1477^17^^^^1
 ;;^UTILITY(U,$J,358.3,33831,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,33831,1,2,0)
 ;;=2^10060
 ;;^UTILITY(U,$J,358.3,33831,1,3,0)
 ;;=3^I&D Abscess
 ;;^UTILITY(U,$J,358.3,33832,0)
 ;;=10061^^99^1477^18^^^^1
 ;;^UTILITY(U,$J,358.3,33832,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,33832,1,2,0)
 ;;=2^10061
 ;;^UTILITY(U,$J,358.3,33832,1,3,0)
 ;;=3^I&D Complicated Abscess
 ;;^UTILITY(U,$J,358.3,33833,0)
 ;;=12001^^99^1477^31^^^^1
 ;;^UTILITY(U,$J,358.3,33833,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,33833,1,2,0)
 ;;=2^12001
 ;;^UTILITY(U,$J,358.3,33833,1,3,0)
 ;;=3^Suture Simple Wound,Trunk/Ext 2.5 cm or <
 ;;^UTILITY(U,$J,358.3,33834,0)
 ;;=12002^^99^1477^32^^^^1
 ;;^UTILITY(U,$J,358.3,33834,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,33834,1,2,0)
 ;;=2^12002
 ;;^UTILITY(U,$J,358.3,33834,1,3,0)
 ;;=3^Suture Simple Wound,Trunk/Ext 2.6-7.5 cm
 ;;^UTILITY(U,$J,358.3,33835,0)
 ;;=11042^^99^1477^12^^^^1
 ;;^UTILITY(U,$J,358.3,33835,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,33835,1,2,0)
 ;;=2^11042
 ;;^UTILITY(U,$J,358.3,33835,1,3,0)
 ;;=3^Debridement, Skin & Subcu. Tissue,1st 20sq cm
 ;;^UTILITY(U,$J,358.3,33836,0)
 ;;=20550^^99^1477^21^^^^1
 ;;^UTILITY(U,$J,358.3,33836,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,33836,1,2,0)
 ;;=2^20550
 ;;^UTILITY(U,$J,358.3,33836,1,3,0)
 ;;=3^Injection, Tendon Sheath, Ligament, Ganglion Cyst
 ;;^UTILITY(U,$J,358.3,33837,0)
 ;;=20551^^99^1477^20^^^^1
 ;;^UTILITY(U,$J,358.3,33837,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,33837,1,2,0)
 ;;=2^20551
 ;;^UTILITY(U,$J,358.3,33837,1,3,0)
 ;;=3^Injection, Tendon Origin/Insertion
 ;;^UTILITY(U,$J,358.3,33838,0)
 ;;=20552^^99^1477^22^^^^1
 ;;^UTILITY(U,$J,358.3,33838,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,33838,1,2,0)
 ;;=2^20552
 ;;^UTILITY(U,$J,358.3,33838,1,3,0)
 ;;=3^Injection, Trigger Point, 1 or 2 Muscle groups
 ;;^UTILITY(U,$J,358.3,33839,0)
 ;;=20600^^99^1477^6^^^^1
 ;;^UTILITY(U,$J,358.3,33839,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,33839,1,2,0)
 ;;=2^20600
 ;;^UTILITY(U,$J,358.3,33839,1,3,0)
 ;;=3^Arthrocentesis,Small Jt w/o US Guidance
 ;;^UTILITY(U,$J,358.3,33840,0)
 ;;=20605^^99^1477^2^^^^1
 ;;^UTILITY(U,$J,358.3,33840,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,33840,1,2,0)
 ;;=2^20605
 ;;^UTILITY(U,$J,358.3,33840,1,3,0)
 ;;=3^Arthrocentesis,Intermediate Jt w/o US Guidance
 ;;^UTILITY(U,$J,358.3,33841,0)
 ;;=20610^^99^1477^4^^^^1
 ;;^UTILITY(U,$J,358.3,33841,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,33841,1,2,0)
 ;;=2^20610
 ;;^UTILITY(U,$J,358.3,33841,1,3,0)
 ;;=3^Arthrocentesis,Major Jt w/o US Guidance
 ;;^UTILITY(U,$J,358.3,33842,0)
 ;;=92950^^99^1477^9^^^^1
 ;;^UTILITY(U,$J,358.3,33842,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,33842,1,2,0)
 ;;=2^92950
 ;;^UTILITY(U,$J,358.3,33842,1,3,0)
 ;;=3^CPR
 ;;^UTILITY(U,$J,358.3,33843,0)
 ;;=11055^^99^1477^35^^^^1
 ;;^UTILITY(U,$J,358.3,33843,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,33843,1,2,0)
 ;;=2^11055
 ;;^UTILITY(U,$J,358.3,33843,1,3,0)
 ;;=3^Trim Corn/Callous, One
 ;;^UTILITY(U,$J,358.3,33844,0)
 ;;=11056^^99^1477^33^^^^1
 ;;^UTILITY(U,$J,358.3,33844,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,33844,1,2,0)
 ;;=2^11056
 ;;^UTILITY(U,$J,358.3,33844,1,3,0)
 ;;=3^Trim Corn/Callous, 2 to 4
 ;;^UTILITY(U,$J,358.3,33845,0)
 ;;=11057^^99^1477^34^^^^1
 ;;^UTILITY(U,$J,358.3,33845,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,33845,1,2,0)
 ;;=2^11057
 ;;^UTILITY(U,$J,358.3,33845,1,3,0)
 ;;=3^Trim Corn/Callous, 5 or more
 ;;^UTILITY(U,$J,358.3,33846,0)
 ;;=12011^^99^1477^29^^^^1
 ;;^UTILITY(U,$J,358.3,33846,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,33846,1,2,0)
 ;;=2^12011
 ;;^UTILITY(U,$J,358.3,33846,1,3,0)
 ;;=3^Suture Simple Wound,Face,2.5 cm or <
 ;;^UTILITY(U,$J,358.3,33847,0)
 ;;=97597^^99^1477^10^^^^1
 ;;^UTILITY(U,$J,358.3,33847,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,33847,1,2,0)
 ;;=2^97597
 ;;^UTILITY(U,$J,358.3,33847,1,3,0)
 ;;=3^Debridement open wnd 1st 20sq cm
 ;;^UTILITY(U,$J,358.3,33848,0)
 ;;=97598^^99^1477^11^^^^1
 ;;^UTILITY(U,$J,358.3,33848,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,33848,1,2,0)
 ;;=2^97598
 ;;^UTILITY(U,$J,358.3,33848,1,3,0)
 ;;=3^Debridement open wnd ea addl 20sq cm
 ;;^UTILITY(U,$J,358.3,33849,0)
 ;;=11200^^99^1477^26^^^^1
 ;;^UTILITY(U,$J,358.3,33849,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,33849,1,2,0)
 ;;=2^11200
 ;;^UTILITY(U,$J,358.3,33849,1,3,0)
 ;;=3^Removal Skin Tags,up to 15 Lesions
 ;;^UTILITY(U,$J,358.3,33850,0)
 ;;=11201^^99^1477^25^^^^1
 ;;^UTILITY(U,$J,358.3,33850,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,33850,1,2,0)
 ;;=2^11201
 ;;^UTILITY(U,$J,358.3,33850,1,3,0)
 ;;=3^Removal Skin Tags,ea addl 10 Lesions
 ;;^UTILITY(U,$J,358.3,33851,0)
 ;;=11100^^99^1477^7^^^^1
 ;;^UTILITY(U,$J,358.3,33851,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,33851,1,2,0)
 ;;=2^11100
 ;;^UTILITY(U,$J,358.3,33851,1,3,0)
 ;;=3^Biopsy Skin Lesion,Single Lesion
 ;;^UTILITY(U,$J,358.3,33852,0)
 ;;=11101^^99^1477^8^^^^1
 ;;^UTILITY(U,$J,358.3,33852,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,33852,1,2,0)
 ;;=2^11101
 ;;^UTILITY(U,$J,358.3,33852,1,3,0)
 ;;=3^Biopsy Skin Lesion,ea addl Lesion
 ;;^UTILITY(U,$J,358.3,33853,0)
 ;;=10030^^99^1477^19^^^^1
 ;;^UTILITY(U,$J,358.3,33853,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,33853,1,2,0)
 ;;=2^10030
 ;;^UTILITY(U,$J,358.3,33853,1,3,0)
 ;;=3^Image Guided Collec by Cath,Abscess
 ;;^UTILITY(U,$J,358.3,33854,0)
 ;;=20604^^99^1477^5^^^^1
 ;;^UTILITY(U,$J,358.3,33854,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,33854,1,2,0)
 ;;=2^20604
 ;;^UTILITY(U,$J,358.3,33854,1,3,0)
 ;;=3^Arthrocentesis,Small Jt w/ US Guidance
 ;;^UTILITY(U,$J,358.3,33855,0)
 ;;=20606^^99^1477^1^^^^1
 ;;^UTILITY(U,$J,358.3,33855,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,33855,1,2,0)
 ;;=2^20606
 ;;^UTILITY(U,$J,358.3,33855,1,3,0)
 ;;=3^Arthrocentesis,Intermediate Jt w/ US Guidance
 ;;^UTILITY(U,$J,358.3,33856,0)
 ;;=20611^^99^1477^3^^^^1
 ;;^UTILITY(U,$J,358.3,33856,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,33856,1,2,0)
 ;;=2^20611
 ;;^UTILITY(U,$J,358.3,33856,1,3,0)
 ;;=3^Arthrocentesis,Major Jt w/ US Guidance
 ;;^UTILITY(U,$J,358.3,33857,0)
 ;;=10021^^99^1477^16^^^^1
 ;;^UTILITY(U,$J,358.3,33857,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,33857,1,2,0)
 ;;=2^10021
 ;;^UTILITY(U,$J,358.3,33857,1,3,0)
 ;;=3^Fine Needle Aspiration w/o Guidance
 ;;^UTILITY(U,$J,358.3,33858,0)
 ;;=11300^^99^1477^27^^^^1
 ;;^UTILITY(U,$J,358.3,33858,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,33858,1,2,0)
 ;;=2^11300
 ;;^UTILITY(U,$J,358.3,33858,1,3,0)
 ;;=3^Shave Epidermal Lesion,Trunk/Ext,0.5 cm or <
 ;;^UTILITY(U,$J,358.3,33859,0)
 ;;=11301^^99^1477^28^^^^1
 ;;^UTILITY(U,$J,358.3,33859,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,33859,1,2,0)
 ;;=2^11301
 ;;^UTILITY(U,$J,358.3,33859,1,3,0)
 ;;=3^Shave Epidermal Lesion,Trunk/Ext,0.6-1.0 cm
 ;;^UTILITY(U,$J,358.3,33860,0)
 ;;=12013^^99^1477^30^^^^1
 ;;^UTILITY(U,$J,358.3,33860,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,33860,1,2,0)
 ;;=2^12013
 ;;^UTILITY(U,$J,358.3,33860,1,3,0)
 ;;=3^Suture Simple Wound,Face,2.6-5.0 cm
 ;;^UTILITY(U,$J,358.3,33861,0)
 ;;=69209^^99^1477^23^^^^1
 ;;^UTILITY(U,$J,358.3,33861,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,33861,1,2,0)
 ;;=2^69209
 ;;^UTILITY(U,$J,358.3,33861,1,3,0)
 ;;=3^Removal Impacted Cerumen/Irrigate/Lavage
