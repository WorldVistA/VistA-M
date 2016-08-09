IBDEI05B ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,5045,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5045,1,3,0)
 ;;=3^Dermatitis,Herpes Simplex
 ;;^UTILITY(U,$J,358.3,5045,1,4,0)
 ;;=4^B00.1
 ;;^UTILITY(U,$J,358.3,5045,2)
 ;;=^5000468
 ;;^UTILITY(U,$J,358.3,5046,0)
 ;;=L24.0^^32^334^13
 ;;^UTILITY(U,$J,358.3,5046,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5046,1,3,0)
 ;;=3^Dermatitis,Irritant Contact d/t Detergents
 ;;^UTILITY(U,$J,358.3,5046,1,4,0)
 ;;=4^L24.0
 ;;^UTILITY(U,$J,358.3,5046,2)
 ;;=^5009126
 ;;^UTILITY(U,$J,358.3,5047,0)
 ;;=L24.81^^32^334^14
 ;;^UTILITY(U,$J,358.3,5047,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5047,1,3,0)
 ;;=3^Dermatitis,Irritant Contact d/t Metals
 ;;^UTILITY(U,$J,358.3,5047,1,4,0)
 ;;=4^L24.81
 ;;^UTILITY(U,$J,358.3,5047,2)
 ;;=^5009134
 ;;^UTILITY(U,$J,358.3,5048,0)
 ;;=L24.2^^32^334^15
 ;;^UTILITY(U,$J,358.3,5048,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5048,1,3,0)
 ;;=3^Dermatitis,Irritant Contact d/t Solvents
 ;;^UTILITY(U,$J,358.3,5048,1,4,0)
 ;;=4^L24.2
 ;;^UTILITY(U,$J,358.3,5048,2)
 ;;=^5009128
 ;;^UTILITY(U,$J,358.3,5049,0)
 ;;=E08.620^^32^334^22
 ;;^UTILITY(U,$J,358.3,5049,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5049,1,3,0)
 ;;=3^Diabetes d/t Underlying Condition w/ DM Dermatitis
 ;;^UTILITY(U,$J,358.3,5049,1,4,0)
 ;;=4^E08.620
 ;;^UTILITY(U,$J,358.3,5049,2)
 ;;=^5002533
 ;;^UTILITY(U,$J,358.3,5050,0)
 ;;=E08.621^^32^334^24
 ;;^UTILITY(U,$J,358.3,5050,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5050,1,3,0)
 ;;=3^Diabetes d/t Underlying Conditions w/ Foot Ulcer
 ;;^UTILITY(U,$J,358.3,5050,1,4,0)
 ;;=4^E08.621
 ;;^UTILITY(U,$J,358.3,5050,2)
 ;;=^5002534
 ;;^UTILITY(U,$J,358.3,5051,0)
 ;;=T81.33XA^^32^334^27
 ;;^UTILITY(U,$J,358.3,5051,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5051,1,3,0)
 ;;=3^Disruption Traumatic Inj/Wound Repair,Init Encntr
 ;;^UTILITY(U,$J,358.3,5051,1,4,0)
 ;;=4^T81.33XA
 ;;^UTILITY(U,$J,358.3,5051,2)
 ;;=^5054476
 ;;^UTILITY(U,$J,358.3,5052,0)
 ;;=L60.3^^32^334^30
 ;;^UTILITY(U,$J,358.3,5052,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5052,1,3,0)
 ;;=3^Dystrophic Nails
 ;;^UTILITY(U,$J,358.3,5052,1,4,0)
 ;;=4^L60.3
 ;;^UTILITY(U,$J,358.3,5052,2)
 ;;=^5009236
 ;;^UTILITY(U,$J,358.3,5053,0)
 ;;=M71.30^^32^334^25
 ;;^UTILITY(U,$J,358.3,5053,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5053,1,3,0)
 ;;=3^Digital Mucous Cyst
 ;;^UTILITY(U,$J,358.3,5053,1,4,0)
 ;;=4^M71.30
 ;;^UTILITY(U,$J,358.3,5053,2)
 ;;=^5013149
 ;;^UTILITY(U,$J,358.3,5054,0)
 ;;=L30.4^^32^335^9
 ;;^UTILITY(U,$J,358.3,5054,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5054,1,3,0)
 ;;=3^Erythema Intertrigo
 ;;^UTILITY(U,$J,358.3,5054,1,4,0)
 ;;=4^L30.4
 ;;^UTILITY(U,$J,358.3,5054,2)
 ;;=^5009157
 ;;^UTILITY(U,$J,358.3,5055,0)
 ;;=R60.0^^32^335^6
 ;;^UTILITY(U,$J,358.3,5055,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5055,1,3,0)
 ;;=3^Edema,Localized
 ;;^UTILITY(U,$J,358.3,5055,1,4,0)
 ;;=4^R60.0
 ;;^UTILITY(U,$J,358.3,5055,2)
 ;;=^5019532
 ;;^UTILITY(U,$J,358.3,5056,0)
 ;;=L53.0^^32^335^13
 ;;^UTILITY(U,$J,358.3,5056,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5056,1,3,0)
 ;;=3^Erythema Toxic
 ;;^UTILITY(U,$J,358.3,5056,1,4,0)
 ;;=4^L53.0
 ;;^UTILITY(U,$J,358.3,5056,2)
 ;;=^5009207
 ;;^UTILITY(U,$J,358.3,5057,0)
 ;;=L53.1^^32^335^8
 ;;^UTILITY(U,$J,358.3,5057,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5057,1,3,0)
 ;;=3^Erythema Annulare Centrifugum
 ;;^UTILITY(U,$J,358.3,5057,1,4,0)
 ;;=4^L53.1
 ;;^UTILITY(U,$J,358.3,5057,2)
 ;;=^5009208
 ;;^UTILITY(U,$J,358.3,5058,0)
 ;;=L51.9^^32^335^11
 ;;^UTILITY(U,$J,358.3,5058,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5058,1,3,0)
 ;;=3^Erythema Multiforme,Unspec
 ;;^UTILITY(U,$J,358.3,5058,1,4,0)
 ;;=4^L51.9
 ;;^UTILITY(U,$J,358.3,5058,2)
 ;;=^336759
 ;;^UTILITY(U,$J,358.3,5059,0)
 ;;=L12.35^^32^335^7
 ;;^UTILITY(U,$J,358.3,5059,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5059,1,3,0)
 ;;=3^Epidermolysis Bullosa,Acquired
 ;;^UTILITY(U,$J,358.3,5059,1,4,0)
 ;;=4^L12.35
 ;;^UTILITY(U,$J,358.3,5059,2)
 ;;=^5009100
 ;;^UTILITY(U,$J,358.3,5060,0)
 ;;=L52.^^32^335^12
 ;;^UTILITY(U,$J,358.3,5060,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5060,1,3,0)
 ;;=3^Erythema Nodosum
 ;;^UTILITY(U,$J,358.3,5060,1,4,0)
 ;;=4^L52.
 ;;^UTILITY(U,$J,358.3,5060,2)
 ;;=^42065
 ;;^UTILITY(U,$J,358.3,5061,0)
 ;;=L49.0^^32^335^24
 ;;^UTILITY(U,$J,358.3,5061,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5061,1,3,0)
 ;;=3^Exfoliation d/t Erythematous Cond w/ < 10% Body Surface
 ;;^UTILITY(U,$J,358.3,5061,1,4,0)
 ;;=4^L49.0
 ;;^UTILITY(U,$J,358.3,5061,2)
 ;;=^5009190
 ;;^UTILITY(U,$J,358.3,5062,0)
 ;;=L49.1^^32^335^15
 ;;^UTILITY(U,$J,358.3,5062,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5062,1,3,0)
 ;;=3^Exfoliation d/t Erythematous Cond w/ 10-19% Body Surface
 ;;^UTILITY(U,$J,358.3,5062,1,4,0)
 ;;=4^L49.1
 ;;^UTILITY(U,$J,358.3,5062,2)
 ;;=^5009191
 ;;^UTILITY(U,$J,358.3,5063,0)
 ;;=L49.2^^32^335^16
 ;;^UTILITY(U,$J,358.3,5063,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5063,1,3,0)
 ;;=3^Exfoliation d/t Erythematous Cond w/ 20-29% Body Surface
 ;;^UTILITY(U,$J,358.3,5063,1,4,0)
 ;;=4^L49.2
 ;;^UTILITY(U,$J,358.3,5063,2)
 ;;=^5009192
 ;;^UTILITY(U,$J,358.3,5064,0)
 ;;=L49.3^^32^335^17
 ;;^UTILITY(U,$J,358.3,5064,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5064,1,3,0)
 ;;=3^Exfoliation d/t Erythematous Cond w/ 30-39% Body Surface
 ;;^UTILITY(U,$J,358.3,5064,1,4,0)
 ;;=4^L49.3
 ;;^UTILITY(U,$J,358.3,5064,2)
 ;;=^5009193
 ;;^UTILITY(U,$J,358.3,5065,0)
 ;;=L49.4^^32^335^18
 ;;^UTILITY(U,$J,358.3,5065,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5065,1,3,0)
 ;;=3^Exfoliation d/t Erythematous Cond w/ 40-49% Body Surface
 ;;^UTILITY(U,$J,358.3,5065,1,4,0)
 ;;=4^L49.4
 ;;^UTILITY(U,$J,358.3,5065,2)
 ;;=^5009194
 ;;^UTILITY(U,$J,358.3,5066,0)
 ;;=L49.5^^32^335^19
 ;;^UTILITY(U,$J,358.3,5066,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5066,1,3,0)
 ;;=3^Exfoliation d/t Erythematous Cond w/ 50-59% Body Surface
 ;;^UTILITY(U,$J,358.3,5066,1,4,0)
 ;;=4^L49.5
 ;;^UTILITY(U,$J,358.3,5066,2)
 ;;=^5009195
 ;;^UTILITY(U,$J,358.3,5067,0)
 ;;=L49.6^^32^335^20
 ;;^UTILITY(U,$J,358.3,5067,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5067,1,3,0)
 ;;=3^Exfoliation d/t Erythematous Cond w/ 60-69% Body Surface
 ;;^UTILITY(U,$J,358.3,5067,1,4,0)
 ;;=4^L49.6
 ;;^UTILITY(U,$J,358.3,5067,2)
 ;;=^5009196
 ;;^UTILITY(U,$J,358.3,5068,0)
 ;;=L49.7^^32^335^21
 ;;^UTILITY(U,$J,358.3,5068,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5068,1,3,0)
 ;;=3^Exfoliation d/t Erythematous Cond w/ 70-79% Body Surface
 ;;^UTILITY(U,$J,358.3,5068,1,4,0)
 ;;=4^L49.7
 ;;^UTILITY(U,$J,358.3,5068,2)
 ;;=^5009197
 ;;^UTILITY(U,$J,358.3,5069,0)
 ;;=L49.8^^32^335^22
 ;;^UTILITY(U,$J,358.3,5069,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5069,1,3,0)
 ;;=3^Exfoliation d/t Erythematous Cond w/ 80-89% Body Surface
 ;;^UTILITY(U,$J,358.3,5069,1,4,0)
 ;;=4^L49.8
 ;;^UTILITY(U,$J,358.3,5069,2)
 ;;=^5009198
 ;;^UTILITY(U,$J,358.3,5070,0)
 ;;=L49.9^^32^335^25
 ;;^UTILITY(U,$J,358.3,5070,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5070,1,3,0)
 ;;=3^Exfoliation d/t Erythematous Cond w/ > 89% Body Surface
 ;;^UTILITY(U,$J,358.3,5070,1,4,0)
 ;;=4^L49.9
 ;;^UTILITY(U,$J,358.3,5070,2)
 ;;=^5009199
 ;;^UTILITY(U,$J,358.3,5071,0)
 ;;=Z65.5^^32^335^26
 ;;^UTILITY(U,$J,358.3,5071,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5071,1,3,0)
 ;;=3^Exposure to Disaster/War/Hostilities
 ;;^UTILITY(U,$J,358.3,5071,1,4,0)
 ;;=4^Z65.5
 ;;^UTILITY(U,$J,358.3,5071,2)
 ;;=^5063184
 ;;^UTILITY(U,$J,358.3,5072,0)
 ;;=Z77.22^^32^335^27
 ;;^UTILITY(U,$J,358.3,5072,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5072,1,3,0)
 ;;=3^Exposure to/Contact w/ Environmental Tobacco Smoke
 ;;^UTILITY(U,$J,358.3,5072,1,4,0)
 ;;=4^Z77.22
 ;;^UTILITY(U,$J,358.3,5072,2)
 ;;=^5063324
 ;;^UTILITY(U,$J,358.3,5073,0)
 ;;=L30.9^^32^335^5
