IBDEI02J ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,2080,1,4,0)
 ;;=4^I21.02
 ;;^UTILITY(U,$J,358.3,2080,2)
 ;;=^5007081
 ;;^UTILITY(U,$J,358.3,2081,0)
 ;;=I21.01^^14^162^5
 ;;^UTILITY(U,$J,358.3,2081,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2081,1,3,0)
 ;;=3^STEMI Involving Left Main Coronary Artery
 ;;^UTILITY(U,$J,358.3,2081,1,4,0)
 ;;=4^I21.01
 ;;^UTILITY(U,$J,358.3,2081,2)
 ;;=^5007080
 ;;^UTILITY(U,$J,358.3,2082,0)
 ;;=I21.19^^14^162^3
 ;;^UTILITY(U,$J,358.3,2082,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2082,1,3,0)
 ;;=3^STEMI Involving Coronary Artery of Inferior Wall
 ;;^UTILITY(U,$J,358.3,2082,1,4,0)
 ;;=4^I21.19
 ;;^UTILITY(U,$J,358.3,2082,2)
 ;;=^5007084
 ;;^UTILITY(U,$J,358.3,2083,0)
 ;;=I22.1^^14^162^8
 ;;^UTILITY(U,$J,358.3,2083,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2083,1,3,0)
 ;;=3^Subsequent STEMI of Inferior Wall
 ;;^UTILITY(U,$J,358.3,2083,1,4,0)
 ;;=4^I22.1
 ;;^UTILITY(U,$J,358.3,2083,2)
 ;;=^5007090
 ;;^UTILITY(U,$J,358.3,2084,0)
 ;;=I21.4^^14^162^1
 ;;^UTILITY(U,$J,358.3,2084,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2084,1,3,0)
 ;;=3^NSTEMI
 ;;^UTILITY(U,$J,358.3,2084,1,4,0)
 ;;=4^I21.4
 ;;^UTILITY(U,$J,358.3,2084,2)
 ;;=^5007088
 ;;^UTILITY(U,$J,358.3,2085,0)
 ;;=I21.3^^14^162^6
 ;;^UTILITY(U,$J,358.3,2085,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2085,1,3,0)
 ;;=3^STEMI of Unspec Site
 ;;^UTILITY(U,$J,358.3,2085,1,4,0)
 ;;=4^I21.3
 ;;^UTILITY(U,$J,358.3,2085,2)
 ;;=^5007087
 ;;^UTILITY(U,$J,358.3,2086,0)
 ;;=I34.2^^14^163^2
 ;;^UTILITY(U,$J,358.3,2086,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2086,1,3,0)
 ;;=3^Nonrheumatic Mitral Valve Stenosis
 ;;^UTILITY(U,$J,358.3,2086,1,4,0)
 ;;=4^I34.2
 ;;^UTILITY(U,$J,358.3,2086,2)
 ;;=^5007171
 ;;^UTILITY(U,$J,358.3,2087,0)
 ;;=I35.0^^14^163^1
 ;;^UTILITY(U,$J,358.3,2087,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2087,1,3,0)
 ;;=3^Nonrheumatic Aortic Valve Stenosis
 ;;^UTILITY(U,$J,358.3,2087,1,4,0)
 ;;=4^I35.0
 ;;^UTILITY(U,$J,358.3,2087,2)
 ;;=^5007174
 ;;^UTILITY(U,$J,358.3,2088,0)
 ;;=I36.1^^14^163^4
 ;;^UTILITY(U,$J,358.3,2088,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2088,1,3,0)
 ;;=3^Nonrheumatic Tricuspid Valve Insufficiency
 ;;^UTILITY(U,$J,358.3,2088,1,4,0)
 ;;=4^I36.1
 ;;^UTILITY(U,$J,358.3,2088,2)
 ;;=^5007180
 ;;^UTILITY(U,$J,358.3,2089,0)
 ;;=I37.0^^14^163^3
 ;;^UTILITY(U,$J,358.3,2089,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2089,1,3,0)
 ;;=3^Nonrheumatic Pulmonary Valve Stenosis
 ;;^UTILITY(U,$J,358.3,2089,1,4,0)
 ;;=4^I37.0
 ;;^UTILITY(U,$J,358.3,2089,2)
 ;;=^5007184
 ;;^UTILITY(U,$J,358.3,2090,0)
 ;;=I51.1^^14^164^1
 ;;^UTILITY(U,$J,358.3,2090,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2090,1,3,0)
 ;;=3^Rupture of Chordae Tendineae NEC
 ;;^UTILITY(U,$J,358.3,2090,1,4,0)
 ;;=4^I51.1
 ;;^UTILITY(U,$J,358.3,2090,2)
 ;;=^5007253
 ;;^UTILITY(U,$J,358.3,2091,0)
 ;;=I51.2^^14^164^2
 ;;^UTILITY(U,$J,358.3,2091,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2091,1,3,0)
 ;;=3^Rupture of Papillary Muscle NEC
 ;;^UTILITY(U,$J,358.3,2091,1,4,0)
 ;;=4^I51.2
 ;;^UTILITY(U,$J,358.3,2091,2)
 ;;=^5007254
 ;;^UTILITY(U,$J,358.3,2092,0)
 ;;=I38.^^14^165^4
 ;;^UTILITY(U,$J,358.3,2092,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2092,1,3,0)
 ;;=3^Endocarditis Valve,Unspec
 ;;^UTILITY(U,$J,358.3,2092,1,4,0)
 ;;=4^I38.
 ;;^UTILITY(U,$J,358.3,2092,2)
 ;;=^40327
 ;;^UTILITY(U,$J,358.3,2093,0)
 ;;=T82.01XA^^14^165^1
 ;;^UTILITY(U,$J,358.3,2093,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2093,1,3,0)
 ;;=3^Breakdown of Heart Valve Prosthesis,Init Encntr
 ;;^UTILITY(U,$J,358.3,2093,1,4,0)
 ;;=4^T82.01XA
 ;;^UTILITY(U,$J,358.3,2093,2)
 ;;=^5054668
 ;;^UTILITY(U,$J,358.3,2094,0)
 ;;=T82.02XA^^14^165^2
 ;;^UTILITY(U,$J,358.3,2094,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2094,1,3,0)
 ;;=3^Displacement of Heart Valve Prosthesis,Init Encntr
 ;;^UTILITY(U,$J,358.3,2094,1,4,0)
 ;;=4^T82.02XA
 ;;^UTILITY(U,$J,358.3,2094,2)
 ;;=^5054671
 ;;^UTILITY(U,$J,358.3,2095,0)
 ;;=T82.03XA^^14^165^5
 ;;^UTILITY(U,$J,358.3,2095,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2095,1,3,0)
 ;;=3^Leakage of Heart Valve Prosthesis,Init Encntr
 ;;^UTILITY(U,$J,358.3,2095,1,4,0)
 ;;=4^T82.03XA
 ;;^UTILITY(U,$J,358.3,2095,2)
 ;;=^5054674
 ;;^UTILITY(U,$J,358.3,2096,0)
 ;;=T82.09XA^^14^165^7
 ;;^UTILITY(U,$J,358.3,2096,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2096,1,3,0)
 ;;=3^Mech Compl of Heart Valve Prosthesis,Init Encntr
 ;;^UTILITY(U,$J,358.3,2096,1,4,0)
 ;;=4^T82.09XA
 ;;^UTILITY(U,$J,358.3,2096,2)
 ;;=^5054677
 ;;^UTILITY(U,$J,358.3,2097,0)
 ;;=T82.817A^^14^165^3
 ;;^UTILITY(U,$J,358.3,2097,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2097,1,3,0)
 ;;=3^Embolism of Cardiac Prosthetic Device/Implant/Graft,Init Encntr
 ;;^UTILITY(U,$J,358.3,2097,1,4,0)
 ;;=4^T82.817A
 ;;^UTILITY(U,$J,358.3,2097,2)
 ;;=^5054914
 ;;^UTILITY(U,$J,358.3,2098,0)
 ;;=T82.867A^^14^165^10
 ;;^UTILITY(U,$J,358.3,2098,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2098,1,3,0)
 ;;=3^Thrombosis of Cardiac Prosthetic Device/Implant/Graft,Init Encntr
 ;;^UTILITY(U,$J,358.3,2098,1,4,0)
 ;;=4^T82.867A
 ;;^UTILITY(U,$J,358.3,2098,2)
 ;;=^5054944
 ;;^UTILITY(U,$J,358.3,2099,0)
 ;;=Z95.2^^14^165^9
 ;;^UTILITY(U,$J,358.3,2099,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2099,1,3,0)
 ;;=3^Presence of Prosthetic Heart Valve
 ;;^UTILITY(U,$J,358.3,2099,1,4,0)
 ;;=4^Z95.2
 ;;^UTILITY(U,$J,358.3,2099,2)
 ;;=^5063670
 ;;^UTILITY(U,$J,358.3,2100,0)
 ;;=Z98.89^^14^165^8
 ;;^UTILITY(U,$J,358.3,2100,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2100,1,3,0)
 ;;=3^Postprocedural States NEC
 ;;^UTILITY(U,$J,358.3,2100,1,4,0)
 ;;=4^Z98.89
 ;;^UTILITY(U,$J,358.3,2100,2)
 ;;=^5063754
 ;;^UTILITY(U,$J,358.3,2101,0)
 ;;=Z79.01^^14^165^6
 ;;^UTILITY(U,$J,358.3,2101,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2101,1,3,0)
 ;;=3^Long Term Current Use of Anticoagulants
 ;;^UTILITY(U,$J,358.3,2101,1,4,0)
 ;;=4^Z79.01
 ;;^UTILITY(U,$J,358.3,2101,2)
 ;;=^5063330
 ;;^UTILITY(U,$J,358.3,2102,0)
 ;;=I65.1^^14^166^75
 ;;^UTILITY(U,$J,358.3,2102,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2102,1,3,0)
 ;;=3^Occlusion/Stenosis of Basilar Artery
 ;;^UTILITY(U,$J,358.3,2102,1,4,0)
 ;;=4^I65.1
 ;;^UTILITY(U,$J,358.3,2102,2)
 ;;=^269747
 ;;^UTILITY(U,$J,358.3,2103,0)
 ;;=I63.22^^14^166^52
 ;;^UTILITY(U,$J,358.3,2103,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2103,1,3,0)
 ;;=3^Cerebral Inarction d/t Unspec Occlusion/Stenosis of Basilar Arteries
 ;;^UTILITY(U,$J,358.3,2103,1,4,0)
 ;;=4^I63.22
 ;;^UTILITY(U,$J,358.3,2103,2)
 ;;=^5007315
 ;;^UTILITY(U,$J,358.3,2104,0)
 ;;=I65.21^^14^166^81
 ;;^UTILITY(U,$J,358.3,2104,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2104,1,3,0)
 ;;=3^Occlusion/Stenosis of Right Carotid Artery
 ;;^UTILITY(U,$J,358.3,2104,1,4,0)
 ;;=4^I65.21
 ;;^UTILITY(U,$J,358.3,2104,2)
 ;;=^5007360
 ;;^UTILITY(U,$J,358.3,2105,0)
 ;;=I65.22^^14^166^78
 ;;^UTILITY(U,$J,358.3,2105,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2105,1,3,0)
 ;;=3^Occlusion/Stenosis of Left Carotid Artery
 ;;^UTILITY(U,$J,358.3,2105,1,4,0)
 ;;=4^I65.22
 ;;^UTILITY(U,$J,358.3,2105,2)
 ;;=^5007361
 ;;^UTILITY(U,$J,358.3,2106,0)
 ;;=I65.23^^14^166^76
 ;;^UTILITY(U,$J,358.3,2106,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2106,1,3,0)
 ;;=3^Occlusion/Stenosis of Bilateral Carotid Arteries
 ;;^UTILITY(U,$J,358.3,2106,1,4,0)
 ;;=4^I65.23
 ;;^UTILITY(U,$J,358.3,2106,2)
 ;;=^5007362
 ;;^UTILITY(U,$J,358.3,2107,0)
 ;;=I63.031^^14^166^56
 ;;^UTILITY(U,$J,358.3,2107,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2107,1,3,0)
 ;;=3^Cerebral Infarction d/t Thrombosis of Right Carotid Artery
 ;;^UTILITY(U,$J,358.3,2107,1,4,0)
 ;;=4^I63.031
 ;;^UTILITY(U,$J,358.3,2107,2)
 ;;=^5007299
 ;;^UTILITY(U,$J,358.3,2108,0)
 ;;=I65.01^^14^166^82
 ;;^UTILITY(U,$J,358.3,2108,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2108,1,3,0)
 ;;=3^Occlusion/Stenosis of Right Vertebral Artery
