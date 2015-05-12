IBDEI00E ; ; 09-FEB-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,180,1,4,0)
 ;;=4^I25.10
 ;;^UTILITY(U,$J,358.3,180,2)
 ;;=^5007107
 ;;^UTILITY(U,$J,358.3,181,0)
 ;;=I50.9^^1^4^9
 ;;^UTILITY(U,$J,358.3,181,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,181,1,3,0)
 ;;=3^Congestive Heart Failure
 ;;^UTILITY(U,$J,358.3,181,1,4,0)
 ;;=4^I50.9
 ;;^UTILITY(U,$J,358.3,181,2)
 ;;=^5007251
 ;;^UTILITY(U,$J,358.3,182,0)
 ;;=I65.21^^1^4^16
 ;;^UTILITY(U,$J,358.3,182,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,182,1,3,0)
 ;;=3^Occlusion/Stenosis of Right Carotid Artery
 ;;^UTILITY(U,$J,358.3,182,1,4,0)
 ;;=4^I65.21
 ;;^UTILITY(U,$J,358.3,182,2)
 ;;=^5007360
 ;;^UTILITY(U,$J,358.3,183,0)
 ;;=I65.22^^1^4^14
 ;;^UTILITY(U,$J,358.3,183,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,183,1,3,0)
 ;;=3^Occlusion/Stenosis of Left Carotid Artery
 ;;^UTILITY(U,$J,358.3,183,1,4,0)
 ;;=4^I65.22
 ;;^UTILITY(U,$J,358.3,183,2)
 ;;=^5007361
 ;;^UTILITY(U,$J,358.3,184,0)
 ;;=I65.23^^1^4^13
 ;;^UTILITY(U,$J,358.3,184,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,184,1,3,0)
 ;;=3^Occlusion/Stenosis of Bilateral Carotid Arteries
 ;;^UTILITY(U,$J,358.3,184,1,4,0)
 ;;=4^I65.23
 ;;^UTILITY(U,$J,358.3,184,2)
 ;;=^5007362
 ;;^UTILITY(U,$J,358.3,185,0)
 ;;=I65.8^^1^4^15
 ;;^UTILITY(U,$J,358.3,185,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,185,1,3,0)
 ;;=3^Occlusion/Stenosis of Precerebral Arteries NEC
 ;;^UTILITY(U,$J,358.3,185,1,4,0)
 ;;=4^I65.8
 ;;^UTILITY(U,$J,358.3,185,2)
 ;;=^5007364
 ;;^UTILITY(U,$J,358.3,186,0)
 ;;=I70.211^^1^4^8
 ;;^UTILITY(U,$J,358.3,186,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,186,1,3,0)
 ;;=3^Athscl Native Arteries of Right Leg w/ Intrmt Claud
 ;;^UTILITY(U,$J,358.3,186,1,4,0)
 ;;=4^I70.211
 ;;^UTILITY(U,$J,358.3,186,2)
 ;;=^5007578
 ;;^UTILITY(U,$J,358.3,187,0)
 ;;=I70.212^^1^4^7
 ;;^UTILITY(U,$J,358.3,187,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,187,1,3,0)
 ;;=3^Athscl Native Arteries of Left Leg w/ Intrmt Claud
 ;;^UTILITY(U,$J,358.3,187,1,4,0)
 ;;=4^I70.212
 ;;^UTILITY(U,$J,358.3,187,2)
 ;;=^5007579
 ;;^UTILITY(U,$J,358.3,188,0)
 ;;=I70.213^^1^4^6
 ;;^UTILITY(U,$J,358.3,188,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,188,1,3,0)
 ;;=3^Athscl Native Arteries of Bilateral Legs w/ Intrmt Claud
 ;;^UTILITY(U,$J,358.3,188,1,4,0)
 ;;=4^I70.213
 ;;^UTILITY(U,$J,358.3,188,2)
 ;;=^5007580
 ;;^UTILITY(U,$J,358.3,189,0)
 ;;=I71.2^^1^4^20
 ;;^UTILITY(U,$J,358.3,189,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,189,1,3,0)
 ;;=3^Thoracic Aortic Aneurysm w/o Rupture
 ;;^UTILITY(U,$J,358.3,189,1,4,0)
 ;;=4^I71.2
 ;;^UTILITY(U,$J,358.3,189,2)
 ;;=^5007787
 ;;^UTILITY(U,$J,358.3,190,0)
 ;;=I71.4^^1^4^1
 ;;^UTILITY(U,$J,358.3,190,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,190,1,3,0)
 ;;=3^AAA w/o Rupture
 ;;^UTILITY(U,$J,358.3,190,1,4,0)
 ;;=4^I71.4
 ;;^UTILITY(U,$J,358.3,190,2)
 ;;=^5007789
 ;;^UTILITY(U,$J,358.3,191,0)
 ;;=I73.9^^1^4^17
 ;;^UTILITY(U,$J,358.3,191,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,191,1,3,0)
 ;;=3^Peripheral Vascular Disease,Unspec
 ;;^UTILITY(U,$J,358.3,191,1,4,0)
 ;;=4^I73.9
 ;;^UTILITY(U,$J,358.3,191,2)
 ;;=^184182
 ;;^UTILITY(U,$J,358.3,192,0)
 ;;=I74.2^^1^4^11
 ;;^UTILITY(U,$J,358.3,192,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,192,1,3,0)
 ;;=3^Embolism/Thrombosis of Upper Extremity Arteries
 ;;^UTILITY(U,$J,358.3,192,1,4,0)
 ;;=4^I74.2
 ;;^UTILITY(U,$J,358.3,192,2)
 ;;=^5007801
 ;;^UTILITY(U,$J,358.3,193,0)
 ;;=I74.3^^1^4^10
 ;;^UTILITY(U,$J,358.3,193,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,193,1,3,0)
 ;;=3^Embolism/Thrombosis of Lower Extremity Arteries
 ;;^UTILITY(U,$J,358.3,193,1,4,0)
 ;;=4^I74.3
 ;;^UTILITY(U,$J,358.3,193,2)
 ;;=^5007802
 ;;^UTILITY(U,$J,358.3,194,0)
 ;;=I83.019^^1^4^22
 ;;^UTILITY(U,$J,358.3,194,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,194,1,3,0)
 ;;=3^Varicose Veins Right Lower Extrem w/ Ulcer
 ;;^UTILITY(U,$J,358.3,194,1,4,0)
 ;;=4^I83.019
 ;;^UTILITY(U,$J,358.3,194,2)
 ;;=^5007979
 ;;^UTILITY(U,$J,358.3,195,0)
 ;;=I83.029^^1^4^21
 ;;^UTILITY(U,$J,358.3,195,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,195,1,3,0)
 ;;=3^Varicose Veins Left Lower Extrem w/ Ulcer
 ;;^UTILITY(U,$J,358.3,195,1,4,0)
 ;;=4^I83.029
 ;;^UTILITY(U,$J,358.3,195,2)
 ;;=^5007986
 ;;^UTILITY(U,$J,358.3,196,0)
 ;;=I83.91^^1^4^4
 ;;^UTILITY(U,$J,358.3,196,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,196,1,3,0)
 ;;=3^Asymptomatic Varicose Veins Right Lower Extremity
 ;;^UTILITY(U,$J,358.3,196,1,4,0)
 ;;=4^I83.91
 ;;^UTILITY(U,$J,358.3,196,2)
 ;;=^5008020
 ;;^UTILITY(U,$J,358.3,197,0)
 ;;=I83.92^^1^4^3
 ;;^UTILITY(U,$J,358.3,197,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,197,1,3,0)
 ;;=3^Asymptomatic Varicose Veins Left Lower Extremity
 ;;^UTILITY(U,$J,358.3,197,1,4,0)
 ;;=4^I83.92
 ;;^UTILITY(U,$J,358.3,197,2)
 ;;=^5008021
 ;;^UTILITY(U,$J,358.3,198,0)
 ;;=I83.93^^1^4^2
 ;;^UTILITY(U,$J,358.3,198,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,198,1,3,0)
 ;;=3^Asymptomatic Varicose Veins Bilateral Lower Extremities
 ;;^UTILITY(U,$J,358.3,198,1,4,0)
 ;;=4^I83.93
 ;;^UTILITY(U,$J,358.3,198,2)
 ;;=^5008022
 ;;^UTILITY(U,$J,358.3,199,0)
 ;;=M79.604^^1^4^18
 ;;^UTILITY(U,$J,358.3,199,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,199,1,3,0)
 ;;=3^Right Limb Pain
 ;;^UTILITY(U,$J,358.3,199,1,4,0)
 ;;=4^M79.604
 ;;^UTILITY(U,$J,358.3,199,2)
 ;;=^5013328
 ;;^UTILITY(U,$J,358.3,200,0)
 ;;=M79.605^^1^4^12
 ;;^UTILITY(U,$J,358.3,200,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,200,1,3,0)
 ;;=3^Left Limb Pain
 ;;^UTILITY(U,$J,358.3,200,1,4,0)
 ;;=4^M79.605
 ;;^UTILITY(U,$J,358.3,200,2)
 ;;=^5013329
 ;;^UTILITY(U,$J,358.3,201,0)
 ;;=Z13.6^^1^4^19
 ;;^UTILITY(U,$J,358.3,201,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,201,1,3,0)
 ;;=3^Screening for Cardiovascular Disorders
 ;;^UTILITY(U,$J,358.3,201,1,4,0)
 ;;=4^Z13.6
 ;;^UTILITY(U,$J,358.3,201,2)
 ;;=^5062707
 ;;^UTILITY(U,$J,358.3,202,0)
 ;;=B48.8^^1^5^60
 ;;^UTILITY(U,$J,358.3,202,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,202,1,3,0)
 ;;=3^Mycoses NEC
 ;;^UTILITY(U,$J,358.3,202,1,4,0)
 ;;=4^B48.8
 ;;^UTILITY(U,$J,358.3,202,2)
 ;;=^5000689
 ;;^UTILITY(U,$J,358.3,203,0)
 ;;=C49.9^^1^5^58
 ;;^UTILITY(U,$J,358.3,203,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,203,1,3,0)
 ;;=3^Malig Neop of Connective/Soft Tissue,Unspec
 ;;^UTILITY(U,$J,358.3,203,1,4,0)
 ;;=4^C49.9
 ;;^UTILITY(U,$J,358.3,203,2)
 ;;=^5001136
 ;;^UTILITY(U,$J,358.3,204,0)
 ;;=C85.80^^1^5^64
 ;;^UTILITY(U,$J,358.3,204,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,204,1,3,0)
 ;;=3^Non-Hodgkin Lymphoma,Unspec Site NEC
 ;;^UTILITY(U,$J,358.3,204,1,4,0)
 ;;=4^C85.80
 ;;^UTILITY(U,$J,358.3,204,2)
 ;;=^5001721
 ;;^UTILITY(U,$J,358.3,205,0)
 ;;=C85.89^^1^5^63
 ;;^UTILITY(U,$J,358.3,205,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,205,1,3,0)
 ;;=3^Non-Hodgkin Lymphoma of Extranodal/Solid Organ Sites
 ;;^UTILITY(U,$J,358.3,205,1,4,0)
 ;;=4^C85.89
 ;;^UTILITY(U,$J,358.3,205,2)
 ;;=^5001730
 ;;^UTILITY(U,$J,358.3,206,0)
 ;;=E11.9^^1^5^21
 ;;^UTILITY(U,$J,358.3,206,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,206,1,3,0)
 ;;=3^Diabetes Type 2 w/o Complications
 ;;^UTILITY(U,$J,358.3,206,1,4,0)
 ;;=4^E11.9
 ;;^UTILITY(U,$J,358.3,206,2)
 ;;=^5002666
 ;;^UTILITY(U,$J,358.3,207,0)
 ;;=E10.9^^1^5^20
 ;;^UTILITY(U,$J,358.3,207,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,207,1,3,0)
 ;;=3^Diabetes Type 1 w/o Complications
 ;;^UTILITY(U,$J,358.3,207,1,4,0)
 ;;=4^E10.9
 ;;^UTILITY(U,$J,358.3,207,2)
 ;;=^5002626
 ;;^UTILITY(U,$J,358.3,208,0)
 ;;=D50.0^^1^5^55
 ;;^UTILITY(U,$J,358.3,208,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,208,1,3,0)
 ;;=3^Iron Deficiency Anemia Secondary to Blood Loss
 ;;^UTILITY(U,$J,358.3,208,1,4,0)
 ;;=4^D50.0
 ;;^UTILITY(U,$J,358.3,208,2)
 ;;=^267971
 ;;^UTILITY(U,$J,358.3,209,0)
 ;;=D50.9^^1^5^56
 ;;^UTILITY(U,$J,358.3,209,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,209,1,3,0)
 ;;=3^Iron Deficiency Anemia,Unspec
 ;;^UTILITY(U,$J,358.3,209,1,4,0)
 ;;=4^D50.9
 ;;^UTILITY(U,$J,358.3,209,2)
 ;;=^5002283
 ;;^UTILITY(U,$J,358.3,210,0)
 ;;=D62.^^1^5^3
 ;;^UTILITY(U,$J,358.3,210,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,210,1,3,0)
 ;;=3^Acute Posthemorrhagic Anemia
 ;;^UTILITY(U,$J,358.3,210,1,4,0)
 ;;=4^D62.
 ;;^UTILITY(U,$J,358.3,210,2)
 ;;=^267986
 ;;^UTILITY(U,$J,358.3,211,0)
 ;;=D64.9^^1^5^6
 ;;^UTILITY(U,$J,358.3,211,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,211,1,3,0)
 ;;=3^Anemia,Unspec
 ;;^UTILITY(U,$J,358.3,211,1,4,0)
 ;;=4^D64.9
 ;;^UTILITY(U,$J,358.3,211,2)
 ;;=^5002351
 ;;^UTILITY(U,$J,358.3,212,0)
 ;;=F03.90^^1^5^19
 ;;^UTILITY(U,$J,358.3,212,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,212,1,3,0)
 ;;=3^Dementia w/o Behavioral Disturbance,Unspec
 ;;^UTILITY(U,$J,358.3,212,1,4,0)
 ;;=4^F03.90
 ;;^UTILITY(U,$J,358.3,212,2)
 ;;=^5003050
 ;;^UTILITY(U,$J,358.3,213,0)
 ;;=G30.9^^1^5^5
 ;;^UTILITY(U,$J,358.3,213,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,213,1,3,0)
 ;;=3^Alzheimer's Disease,Unspec
 ;;^UTILITY(U,$J,358.3,213,1,4,0)
 ;;=4^G30.9
 ;;^UTILITY(U,$J,358.3,213,2)
 ;;=^5003808
 ;;^UTILITY(U,$J,358.3,214,0)
 ;;=G58.9^^1^5^59
 ;;^UTILITY(U,$J,358.3,214,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,214,1,3,0)
 ;;=3^Mononeuropathy,Unspec
 ;;^UTILITY(U,$J,358.3,214,1,4,0)
 ;;=4^G58.9
 ;;^UTILITY(U,$J,358.3,214,2)
 ;;=^5004065
 ;;^UTILITY(U,$J,358.3,215,0)
 ;;=I10.^^1^5^49
 ;;^UTILITY(U,$J,358.3,215,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,215,1,3,0)
 ;;=3^Hypertension,Essential
 ;;^UTILITY(U,$J,358.3,215,1,4,0)
 ;;=4^I10.
 ;;^UTILITY(U,$J,358.3,215,2)
 ;;=^5007062
 ;;^UTILITY(U,$J,358.3,216,0)
 ;;=I26.99^^1^5^69
 ;;^UTILITY(U,$J,358.3,216,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,216,1,3,0)
 ;;=3^Pulmonary Embolism w/o Acute Cor Pulmonale
 ;;^UTILITY(U,$J,358.3,216,1,4,0)
 ;;=4^I26.99
 ;;^UTILITY(U,$J,358.3,216,2)
 ;;=^5007150
 ;;^UTILITY(U,$J,358.3,217,0)
 ;;=G45.9^^1^5^79
 ;;^UTILITY(U,$J,358.3,217,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,217,1,3,0)
 ;;=3^Transient Cerebral Ischemic Attack,Unspec
