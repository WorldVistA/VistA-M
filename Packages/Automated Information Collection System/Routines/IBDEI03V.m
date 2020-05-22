IBDEI03V ; ; 01-MAY-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 01, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,9251,1,3,0)
 ;;=3^Cataract,Unspec
 ;;^UTILITY(U,$J,358.3,9251,1,4,0)
 ;;=4^H26.9
 ;;^UTILITY(U,$J,358.3,9251,2)
 ;;=^5005363
 ;;^UTILITY(U,$J,358.3,9252,0)
 ;;=H10.9^^48^482^10
 ;;^UTILITY(U,$J,358.3,9252,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9252,1,3,0)
 ;;=3^Conjunctivitis,Unspec
 ;;^UTILITY(U,$J,358.3,9252,1,4,0)
 ;;=4^H10.9
 ;;^UTILITY(U,$J,358.3,9252,2)
 ;;=^5004716
 ;;^UTILITY(U,$J,358.3,9253,0)
 ;;=H11.32^^48^482^8
 ;;^UTILITY(U,$J,358.3,9253,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9253,1,3,0)
 ;;=3^Conjunctival Hemorrhage,Left Eye
 ;;^UTILITY(U,$J,358.3,9253,1,4,0)
 ;;=4^H11.32
 ;;^UTILITY(U,$J,358.3,9253,2)
 ;;=^5004783
 ;;^UTILITY(U,$J,358.3,9254,0)
 ;;=H11.31^^48^482^9
 ;;^UTILITY(U,$J,358.3,9254,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9254,1,3,0)
 ;;=3^Conjunctival Hemorrhage,Right Eye
 ;;^UTILITY(U,$J,358.3,9254,1,4,0)
 ;;=4^H11.31
 ;;^UTILITY(U,$J,358.3,9254,2)
 ;;=^5004782
 ;;^UTILITY(U,$J,358.3,9255,0)
 ;;=H01.002^^48^482^3
 ;;^UTILITY(U,$J,358.3,9255,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9255,1,3,0)
 ;;=3^Blepharitis Unspec,Right Lower Eyelid
 ;;^UTILITY(U,$J,358.3,9255,1,4,0)
 ;;=4^H01.002
 ;;^UTILITY(U,$J,358.3,9255,2)
 ;;=^5004239
 ;;^UTILITY(U,$J,358.3,9256,0)
 ;;=H01.004^^48^482^2
 ;;^UTILITY(U,$J,358.3,9256,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9256,1,3,0)
 ;;=3^Blepharitis Unspec,Left Upper Eyelid
 ;;^UTILITY(U,$J,358.3,9256,1,4,0)
 ;;=4^H01.004
 ;;^UTILITY(U,$J,358.3,9256,2)
 ;;=^5004241
 ;;^UTILITY(U,$J,358.3,9257,0)
 ;;=H01.005^^48^482^1
 ;;^UTILITY(U,$J,358.3,9257,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9257,1,3,0)
 ;;=3^Blepharitis Unspec,Left Lower Eyelid
 ;;^UTILITY(U,$J,358.3,9257,1,4,0)
 ;;=4^H01.005
 ;;^UTILITY(U,$J,358.3,9257,2)
 ;;=^5133380
 ;;^UTILITY(U,$J,358.3,9258,0)
 ;;=H01.001^^48^482^4
 ;;^UTILITY(U,$J,358.3,9258,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9258,1,3,0)
 ;;=3^Blepharitis Unspec,Right Upper Eyelid
 ;;^UTILITY(U,$J,358.3,9258,1,4,0)
 ;;=4^H01.001
 ;;^UTILITY(U,$J,358.3,9258,2)
 ;;=^5004238
 ;;^UTILITY(U,$J,358.3,9259,0)
 ;;=H57.13^^48^482^12
 ;;^UTILITY(U,$J,358.3,9259,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9259,1,3,0)
 ;;=3^Ocular Pain,Bilateral
 ;;^UTILITY(U,$J,358.3,9259,1,4,0)
 ;;=4^H57.13
 ;;^UTILITY(U,$J,358.3,9259,2)
 ;;=^5006384
 ;;^UTILITY(U,$J,358.3,9260,0)
 ;;=H57.12^^48^482^13
 ;;^UTILITY(U,$J,358.3,9260,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9260,1,3,0)
 ;;=3^Ocular Pain,Left Eye
 ;;^UTILITY(U,$J,358.3,9260,1,4,0)
 ;;=4^H57.12
 ;;^UTILITY(U,$J,358.3,9260,2)
 ;;=^5006383
 ;;^UTILITY(U,$J,358.3,9261,0)
 ;;=H57.11^^48^482^14
 ;;^UTILITY(U,$J,358.3,9261,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9261,1,3,0)
 ;;=3^Ocular Pain,Right Eye
 ;;^UTILITY(U,$J,358.3,9261,1,4,0)
 ;;=4^H57.11
 ;;^UTILITY(U,$J,358.3,9261,2)
 ;;=^5006382
 ;;^UTILITY(U,$J,358.3,9262,0)
 ;;=H01.00B^^48^482^5
 ;;^UTILITY(U,$J,358.3,9262,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9262,1,3,0)
 ;;=3^Blepharitis,Unspec,Left Upper & Lower Eyelids
 ;;^UTILITY(U,$J,358.3,9262,1,4,0)
 ;;=4^H01.00B
 ;;^UTILITY(U,$J,358.3,9262,2)
 ;;=^5157319
 ;;^UTILITY(U,$J,358.3,9263,0)
 ;;=H01.00A^^48^482^6
 ;;^UTILITY(U,$J,358.3,9263,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9263,1,3,0)
 ;;=3^Blepharitis,Unspec,Right Upper & Lower Eyelids
 ;;^UTILITY(U,$J,358.3,9263,1,4,0)
 ;;=4^H01.00A
 ;;^UTILITY(U,$J,358.3,9263,2)
 ;;=^5157318
 ;;^UTILITY(U,$J,358.3,9264,0)
 ;;=S05.02XA^^48^483^3
 ;;^UTILITY(U,$J,358.3,9264,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9264,1,3,0)
 ;;=3^Inj Conjunctiva/Corneal Abrasion w/o FB,Left Eye,Init
 ;;^UTILITY(U,$J,358.3,9264,1,4,0)
 ;;=4^S05.02XA
 ;;^UTILITY(U,$J,358.3,9264,2)
 ;;=^5020582
 ;;^UTILITY(U,$J,358.3,9265,0)
 ;;=S05.01XA^^48^483^4
 ;;^UTILITY(U,$J,358.3,9265,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9265,1,3,0)
 ;;=3^Inj Conjunctiva/Corneal Abrasion w/o FB,Right Eye,Init
 ;;^UTILITY(U,$J,358.3,9265,1,4,0)
 ;;=4^S05.01XA
 ;;^UTILITY(U,$J,358.3,9265,2)
 ;;=^5020579
 ;;^UTILITY(U,$J,358.3,9266,0)
 ;;=T15.02XA^^48^483^1
 ;;^UTILITY(U,$J,358.3,9266,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9266,1,3,0)
 ;;=3^Foreign Body in Cornea,Left Eye,Init Encntr
 ;;^UTILITY(U,$J,358.3,9266,1,4,0)
 ;;=4^T15.02XA
 ;;^UTILITY(U,$J,358.3,9266,2)
 ;;=^5046387
 ;;^UTILITY(U,$J,358.3,9267,0)
 ;;=T15.01XA^^48^483^2
 ;;^UTILITY(U,$J,358.3,9267,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9267,1,3,0)
 ;;=3^Foreign Body in Cornea,Right Eye,Init Encntr
 ;;^UTILITY(U,$J,358.3,9267,1,4,0)
 ;;=4^T15.01XA
 ;;^UTILITY(U,$J,358.3,9267,2)
 ;;=^5046384
 ;;^UTILITY(U,$J,358.3,9268,0)
 ;;=S00.252A^^48^483^5
 ;;^UTILITY(U,$J,358.3,9268,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9268,1,3,0)
 ;;=3^Superficial FB of Left Eyelid/Periocular Area,Init Encntr
 ;;^UTILITY(U,$J,358.3,9268,1,4,0)
 ;;=4^S00.252A
 ;;^UTILITY(U,$J,358.3,9268,2)
 ;;=^5019820
 ;;^UTILITY(U,$J,358.3,9269,0)
 ;;=S00.251A^^48^483^6
 ;;^UTILITY(U,$J,358.3,9269,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9269,1,3,0)
 ;;=3^Superficial FB of Right Eyelid/Periocular Area,Init Encntr
 ;;^UTILITY(U,$J,358.3,9269,1,4,0)
 ;;=4^S00.251A
 ;;^UTILITY(U,$J,358.3,9269,2)
 ;;=^5019817
 ;;^UTILITY(U,$J,358.3,9270,0)
 ;;=B96.81^^48^484^63
 ;;^UTILITY(U,$J,358.3,9270,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9270,1,3,0)
 ;;=3^H. Pylori as the Cause of Diseases Classified Elsewhere
 ;;^UTILITY(U,$J,358.3,9270,1,4,0)
 ;;=4^B96.81
 ;;^UTILITY(U,$J,358.3,9270,2)
 ;;=^5000857
 ;;^UTILITY(U,$J,358.3,9271,0)
 ;;=B15.9^^48^484^65
 ;;^UTILITY(U,$J,358.3,9271,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9271,1,3,0)
 ;;=3^Hepatitis A,Acute w/o Hepatic Coma
 ;;^UTILITY(U,$J,358.3,9271,1,4,0)
 ;;=4^B15.9
 ;;^UTILITY(U,$J,358.3,9271,2)
 ;;=^5000536
 ;;^UTILITY(U,$J,358.3,9272,0)
 ;;=B16.9^^48^484^66
 ;;^UTILITY(U,$J,358.3,9272,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9272,1,3,0)
 ;;=3^Hepatitis B,Acute w/o Delta-Agent & w/o Hepatic Coma
 ;;^UTILITY(U,$J,358.3,9272,1,4,0)
 ;;=4^B16.9
 ;;^UTILITY(U,$J,358.3,9272,2)
 ;;=^5000540
 ;;^UTILITY(U,$J,358.3,9273,0)
 ;;=B19.10^^48^484^68
 ;;^UTILITY(U,$J,358.3,9273,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9273,1,3,0)
 ;;=3^Hepatitis B,Viral w/o Hepatic Coma,Unspec
 ;;^UTILITY(U,$J,358.3,9273,1,4,0)
 ;;=4^B19.10
 ;;^UTILITY(U,$J,358.3,9273,2)
 ;;=^5000552
 ;;^UTILITY(U,$J,358.3,9274,0)
 ;;=B18.1^^48^484^67
 ;;^UTILITY(U,$J,358.3,9274,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9274,1,3,0)
 ;;=3^Hepatitis B,Chronic Viral w/o Delta-Agent
 ;;^UTILITY(U,$J,358.3,9274,1,4,0)
 ;;=4^B18.1
 ;;^UTILITY(U,$J,358.3,9274,2)
 ;;=^5000547
 ;;^UTILITY(U,$J,358.3,9275,0)
 ;;=B17.10^^48^484^69
 ;;^UTILITY(U,$J,358.3,9275,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9275,1,3,0)
 ;;=3^Hepatitis C,Acute w/o Hepatic Coma
 ;;^UTILITY(U,$J,358.3,9275,1,4,0)
 ;;=4^B17.10
 ;;^UTILITY(U,$J,358.3,9275,2)
 ;;=^5000542
 ;;^UTILITY(U,$J,358.3,9276,0)
 ;;=B18.2^^48^484^70
 ;;^UTILITY(U,$J,358.3,9276,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9276,1,3,0)
 ;;=3^Hepatitis C,Chronic Viral
 ;;^UTILITY(U,$J,358.3,9276,1,4,0)
 ;;=4^B18.2
 ;;^UTILITY(U,$J,358.3,9276,2)
 ;;=^5000548
 ;;^UTILITY(U,$J,358.3,9277,0)
 ;;=B18.8^^48^484^72
 ;;^UTILITY(U,$J,358.3,9277,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9277,1,3,0)
 ;;=3^Hepatitis,Oth Chronic Viral
 ;;^UTILITY(U,$J,358.3,9277,1,4,0)
 ;;=4^B18.8
 ;;^UTILITY(U,$J,358.3,9277,2)
 ;;=^5000549
 ;;^UTILITY(U,$J,358.3,9278,0)
 ;;=B17.8^^48^484^73
 ;;^UTILITY(U,$J,358.3,9278,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9278,1,3,0)
 ;;=3^Hepatitis,Oth Spec Acute Viral
 ;;^UTILITY(U,$J,358.3,9278,1,4,0)
 ;;=4^B17.8
 ;;^UTILITY(U,$J,358.3,9278,2)
 ;;=^5000544
 ;;^UTILITY(U,$J,358.3,9279,0)
 ;;=B18.9^^48^484^71
 ;;^UTILITY(U,$J,358.3,9279,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9279,1,3,0)
 ;;=3^Hepatitis,Chronic Viral Unspec
 ;;^UTILITY(U,$J,358.3,9279,1,4,0)
 ;;=4^B18.9
 ;;^UTILITY(U,$J,358.3,9279,2)
 ;;=^5000550
 ;;^UTILITY(U,$J,358.3,9280,0)
 ;;=B37.81^^48^484^18
 ;;^UTILITY(U,$J,358.3,9280,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9280,1,3,0)
 ;;=3^Candidal Esophagitis
 ;;^UTILITY(U,$J,358.3,9280,1,4,0)
 ;;=4^B37.81
 ;;^UTILITY(U,$J,358.3,9280,2)
 ;;=^5000620
 ;;^UTILITY(U,$J,358.3,9281,0)
 ;;=D12.0^^48^484^12
 ;;^UTILITY(U,$J,358.3,9281,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9281,1,3,0)
 ;;=3^Benign Neop of Cecum
 ;;^UTILITY(U,$J,358.3,9281,1,4,0)
 ;;=4^D12.0
 ;;^UTILITY(U,$J,358.3,9281,2)
 ;;=^5001963
 ;;^UTILITY(U,$J,358.3,9282,0)
 ;;=D12.6^^48^484^13
 ;;^UTILITY(U,$J,358.3,9282,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9282,1,3,0)
 ;;=3^Benign Neop of Colon,Unspec
 ;;^UTILITY(U,$J,358.3,9282,1,4,0)
 ;;=4^D12.6
 ;;^UTILITY(U,$J,358.3,9282,2)
 ;;=^5001969
 ;;^UTILITY(U,$J,358.3,9283,0)
 ;;=D12.1^^48^484^10
 ;;^UTILITY(U,$J,358.3,9283,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9283,1,3,0)
 ;;=3^Benign Neop of Appendix
 ;;^UTILITY(U,$J,358.3,9283,1,4,0)
 ;;=4^D12.1
 ;;^UTILITY(U,$J,358.3,9283,2)
 ;;=^5001964
 ;;^UTILITY(U,$J,358.3,9284,0)
 ;;=K63.5^^48^484^83
 ;;^UTILITY(U,$J,358.3,9284,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9284,1,3,0)
 ;;=3^Polyp of Colon
 ;;^UTILITY(U,$J,358.3,9284,1,4,0)
 ;;=4^K63.5
 ;;^UTILITY(U,$J,358.3,9284,2)
 ;;=^5008765
 ;;^UTILITY(U,$J,358.3,9285,0)
 ;;=D12.3^^48^484^17
 ;;^UTILITY(U,$J,358.3,9285,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9285,1,3,0)
 ;;=3^Benign Neop of Transverse Colon
 ;;^UTILITY(U,$J,358.3,9285,1,4,0)
 ;;=4^D12.3
 ;;^UTILITY(U,$J,358.3,9285,2)
 ;;=^5001966
 ;;^UTILITY(U,$J,358.3,9286,0)
 ;;=D12.2^^48^484^11
 ;;^UTILITY(U,$J,358.3,9286,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9286,1,3,0)
 ;;=3^Benign Neop of Ascending Colon
 ;;^UTILITY(U,$J,358.3,9286,1,4,0)
 ;;=4^D12.2
 ;;^UTILITY(U,$J,358.3,9286,2)
 ;;=^5001965
 ;;^UTILITY(U,$J,358.3,9287,0)
 ;;=D12.5^^48^484^16
 ;;^UTILITY(U,$J,358.3,9287,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9287,1,3,0)
 ;;=3^Benign Neop of Sigmoid Colon
 ;;^UTILITY(U,$J,358.3,9287,1,4,0)
 ;;=4^D12.5
 ;;^UTILITY(U,$J,358.3,9287,2)
 ;;=^5001968
 ;;^UTILITY(U,$J,358.3,9288,0)
 ;;=D12.4^^48^484^14
 ;;^UTILITY(U,$J,358.3,9288,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9288,1,3,0)
 ;;=3^Benign Neop of Descending Colon
 ;;^UTILITY(U,$J,358.3,9288,1,4,0)
 ;;=4^D12.4
 ;;^UTILITY(U,$J,358.3,9288,2)
 ;;=^5001967
 ;;^UTILITY(U,$J,358.3,9289,0)
 ;;=D73.2^^48^484^19
 ;;^UTILITY(U,$J,358.3,9289,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9289,1,3,0)
 ;;=3^Congestive Splenomegaly,Chronic
 ;;^UTILITY(U,$J,358.3,9289,1,4,0)
 ;;=4^D73.2
 ;;^UTILITY(U,$J,358.3,9289,2)
 ;;=^268000
 ;;^UTILITY(U,$J,358.3,9290,0)
 ;;=I85.00^^48^484^53
 ;;^UTILITY(U,$J,358.3,9290,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9290,1,3,0)
 ;;=3^Esophageal Varices w/o Bleeding
 ;;^UTILITY(U,$J,358.3,9290,1,4,0)
 ;;=4^I85.00
 ;;^UTILITY(U,$J,358.3,9290,2)
 ;;=^5008023
 ;;^UTILITY(U,$J,358.3,9291,0)
 ;;=K20.9^^48^484^54
 ;;^UTILITY(U,$J,358.3,9291,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9291,1,3,0)
 ;;=3^Esophagitis,Unspec
 ;;^UTILITY(U,$J,358.3,9291,1,4,0)
 ;;=4^K20.9
 ;;^UTILITY(U,$J,358.3,9291,2)
 ;;=^295809
 ;;^UTILITY(U,$J,358.3,9292,0)
 ;;=K21.9^^48^484^62
 ;;^UTILITY(U,$J,358.3,9292,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9292,1,3,0)
 ;;=3^Gastroesophageal Reflux Disease w/o Esophagitis
 ;;^UTILITY(U,$J,358.3,9292,1,4,0)
 ;;=4^K21.9
 ;;^UTILITY(U,$J,358.3,9292,2)
 ;;=^5008505
 ;;^UTILITY(U,$J,358.3,9293,0)
 ;;=K25.7^^48^484^57
 ;;^UTILITY(U,$J,358.3,9293,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9293,1,3,0)
 ;;=3^Gastric Ulcer w/o Hemorrhage/Perforation,Chronic
 ;;^UTILITY(U,$J,358.3,9293,1,4,0)
 ;;=4^K25.7
 ;;^UTILITY(U,$J,358.3,9293,2)
 ;;=^5008521
 ;;^UTILITY(U,$J,358.3,9294,0)
 ;;=K26.9^^48^484^49
 ;;^UTILITY(U,$J,358.3,9294,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9294,1,3,0)
 ;;=3^Duadenal Ulcer w/o Hemorrhage/Perforation,Unspec
 ;;^UTILITY(U,$J,358.3,9294,1,4,0)
 ;;=4^K26.9
 ;;^UTILITY(U,$J,358.3,9294,2)
 ;;=^5008527
 ;;^UTILITY(U,$J,358.3,9295,0)
 ;;=K27.9^^48^484^82
 ;;^UTILITY(U,$J,358.3,9295,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9295,1,3,0)
 ;;=3^Peptic Ulcer w/o Hemorrhage/Perforation,Unspec
 ;;^UTILITY(U,$J,358.3,9295,1,4,0)
 ;;=4^K27.9
 ;;^UTILITY(U,$J,358.3,9295,2)
 ;;=^5008536
 ;;^UTILITY(U,$J,358.3,9296,0)
 ;;=K29.70^^48^484^58
 ;;^UTILITY(U,$J,358.3,9296,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9296,1,3,0)
 ;;=3^Gastritis w/o Bleeding,Unspec
 ;;^UTILITY(U,$J,358.3,9296,1,4,0)
 ;;=4^K29.70
 ;;^UTILITY(U,$J,358.3,9296,2)
 ;;=^5008552
 ;;^UTILITY(U,$J,358.3,9297,0)
 ;;=K29.90^^48^484^59
 ;;^UTILITY(U,$J,358.3,9297,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9297,1,3,0)
 ;;=3^Gastroduodenitis w/o Bleeding,Unspec
 ;;^UTILITY(U,$J,358.3,9297,1,4,0)
 ;;=4^K29.90
 ;;^UTILITY(U,$J,358.3,9297,2)
 ;;=^5008556
 ;;^UTILITY(U,$J,358.3,9298,0)
 ;;=K30.^^48^484^50
 ;;^UTILITY(U,$J,358.3,9298,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9298,1,3,0)
 ;;=3^Dyspepsia,Functional
 ;;^UTILITY(U,$J,358.3,9298,1,4,0)
 ;;=4^K30.
 ;;^UTILITY(U,$J,358.3,9298,2)
 ;;=^5008558
 ;;^UTILITY(U,$J,358.3,9299,0)
 ;;=K31.89^^48^484^39
 ;;^UTILITY(U,$J,358.3,9299,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9299,1,3,0)
 ;;=3^Diseases of Stomach & Duodenum,Other
 ;;^UTILITY(U,$J,358.3,9299,1,4,0)
 ;;=4^K31.89
 ;;^UTILITY(U,$J,358.3,9299,2)
 ;;=^5008569
 ;;^UTILITY(U,$J,358.3,9300,0)
 ;;=K31.9^^48^484^38
 ;;^UTILITY(U,$J,358.3,9300,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9300,1,3,0)
 ;;=3^Disease of Stomach & Duodenum,Unspec
 ;;^UTILITY(U,$J,358.3,9300,1,4,0)
 ;;=4^K31.9
 ;;^UTILITY(U,$J,358.3,9300,2)
 ;;=^5008570
 ;;^UTILITY(U,$J,358.3,9301,0)
 ;;=K40.90^^48^484^75
 ;;^UTILITY(U,$J,358.3,9301,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9301,1,3,0)
 ;;=3^Inguinal Hernia,Unilat w/o Obst or Gangrene
 ;;^UTILITY(U,$J,358.3,9301,1,4,0)
 ;;=4^K40.90
 ;;^UTILITY(U,$J,358.3,9301,2)
 ;;=^5008591
 ;;^UTILITY(U,$J,358.3,9302,0)
 ;;=K40.20^^48^484^74
 ;;^UTILITY(U,$J,358.3,9302,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9302,1,3,0)
 ;;=3^Inguinal Hernia,Bilat w/o Obst or Gangrene
 ;;^UTILITY(U,$J,358.3,9302,1,4,0)
 ;;=4^K40.20
 ;;^UTILITY(U,$J,358.3,9302,2)
 ;;=^5008585
 ;;^UTILITY(U,$J,358.3,9303,0)
 ;;=K44.9^^48^484^36
 ;;^UTILITY(U,$J,358.3,9303,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9303,1,3,0)
 ;;=3^Diaphragmatic Hernia w/o Obst or Gangrene
 ;;^UTILITY(U,$J,358.3,9303,1,4,0)
 ;;=4^K44.9
 ;;^UTILITY(U,$J,358.3,9303,2)
 ;;=^5008617
 ;;^UTILITY(U,$J,358.3,9304,0)
 ;;=K46.9^^48^484^1
 ;;^UTILITY(U,$J,358.3,9304,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9304,1,3,0)
 ;;=3^Abdominal Hernia w/o Obst or Gangrene,Unspec
 ;;^UTILITY(U,$J,358.3,9304,1,4,0)
 ;;=4^K46.9
 ;;^UTILITY(U,$J,358.3,9304,2)
 ;;=^5008623
 ;;^UTILITY(U,$J,358.3,9305,0)
 ;;=K50.90^^48^484^31
 ;;^UTILITY(U,$J,358.3,9305,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9305,1,3,0)
 ;;=3^Crohn's Disease w/o Complications,Unspec
 ;;^UTILITY(U,$J,358.3,9305,1,4,0)
 ;;=4^K50.90
 ;;^UTILITY(U,$J,358.3,9305,2)
 ;;=^5008645
 ;;^UTILITY(U,$J,358.3,9306,0)
 ;;=K50.911^^48^484^29
 ;;^UTILITY(U,$J,358.3,9306,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9306,1,3,0)
 ;;=3^Crohn's Disease w/ Rectal Bleeding,Unspec
 ;;^UTILITY(U,$J,358.3,9306,1,4,0)
 ;;=4^K50.911
 ;;^UTILITY(U,$J,358.3,9306,2)
 ;;=^5008646
 ;;^UTILITY(U,$J,358.3,9307,0)
 ;;=K50.912^^48^484^27
 ;;^UTILITY(U,$J,358.3,9307,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9307,1,3,0)
 ;;=3^Crohn's Disease w/ Intestinal Obstruction,Unspec
 ;;^UTILITY(U,$J,358.3,9307,1,4,0)
 ;;=4^K50.912
 ;;^UTILITY(U,$J,358.3,9307,2)
 ;;=^5008647
 ;;^UTILITY(U,$J,358.3,9308,0)
 ;;=K50.919^^48^484^30
 ;;^UTILITY(U,$J,358.3,9308,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9308,1,3,0)
 ;;=3^Crohn's Disease w/ Unspec Complications,Unspec
 ;;^UTILITY(U,$J,358.3,9308,1,4,0)
 ;;=4^K50.919
 ;;^UTILITY(U,$J,358.3,9308,2)
 ;;=^5008651
 ;;^UTILITY(U,$J,358.3,9309,0)
 ;;=K50.914^^48^484^25
 ;;^UTILITY(U,$J,358.3,9309,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9309,1,3,0)
 ;;=3^Crohn's Disease w/ Abscess,Unspec
 ;;^UTILITY(U,$J,358.3,9309,1,4,0)
 ;;=4^K50.914
 ;;^UTILITY(U,$J,358.3,9309,2)
 ;;=^5008649
 ;;^UTILITY(U,$J,358.3,9310,0)
 ;;=K50.913^^48^484^26
 ;;^UTILITY(U,$J,358.3,9310,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9310,1,3,0)
 ;;=3^Crohn's Disease w/ Fistula,Unspec
 ;;^UTILITY(U,$J,358.3,9310,1,4,0)
 ;;=4^K50.913
 ;;^UTILITY(U,$J,358.3,9310,2)
 ;;=^5008648
 ;;^UTILITY(U,$J,358.3,9311,0)
 ;;=K50.918^^48^484^28
 ;;^UTILITY(U,$J,358.3,9311,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9311,1,3,0)
 ;;=3^Crohn's Disease w/ Oth Complication,Unspec
 ;;^UTILITY(U,$J,358.3,9311,1,4,0)
 ;;=4^K50.918
 ;;^UTILITY(U,$J,358.3,9311,2)
 ;;=^5008650
 ;;^UTILITY(U,$J,358.3,9312,0)
 ;;=K51.90^^48^484^90
 ;;^UTILITY(U,$J,358.3,9312,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9312,1,3,0)
 ;;=3^Ulcerative Colitis w/o Complications,Unspec
 ;;^UTILITY(U,$J,358.3,9312,1,4,0)
 ;;=4^K51.90
 ;;^UTILITY(U,$J,358.3,9312,2)
 ;;=^5008694
 ;;^UTILITY(U,$J,358.3,9313,0)
 ;;=K51.919^^48^484^89
 ;;^UTILITY(U,$J,358.3,9313,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9313,1,3,0)
 ;;=3^Ulcerative Colitis w/ Unspec Complications,Unspec
 ;;^UTILITY(U,$J,358.3,9313,1,4,0)
 ;;=4^K51.919
 ;;^UTILITY(U,$J,358.3,9313,2)
 ;;=^5008700
 ;;^UTILITY(U,$J,358.3,9314,0)
 ;;=K51.918^^48^484^87
 ;;^UTILITY(U,$J,358.3,9314,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9314,1,3,0)
 ;;=3^Ulcerative Colitis w/ Oth Complication,Unspec
 ;;^UTILITY(U,$J,358.3,9314,1,4,0)
 ;;=4^K51.918
 ;;^UTILITY(U,$J,358.3,9314,2)
 ;;=^5008699
 ;;^UTILITY(U,$J,358.3,9315,0)
 ;;=K51.914^^48^484^84
 ;;^UTILITY(U,$J,358.3,9315,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9315,1,3,0)
 ;;=3^Ulcerative Colitis w/ Abscess,Unspec
 ;;^UTILITY(U,$J,358.3,9315,1,4,0)
 ;;=4^K51.914
 ;;^UTILITY(U,$J,358.3,9315,2)
 ;;=^5008698
 ;;^UTILITY(U,$J,358.3,9316,0)
 ;;=K51.913^^48^484^85
 ;;^UTILITY(U,$J,358.3,9316,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9316,1,3,0)
 ;;=3^Ulcerative Colitis w/ Fistula,Unspec
 ;;^UTILITY(U,$J,358.3,9316,1,4,0)
 ;;=4^K51.913
 ;;^UTILITY(U,$J,358.3,9316,2)
 ;;=^5008697
 ;;^UTILITY(U,$J,358.3,9317,0)
 ;;=K51.912^^48^484^86
 ;;^UTILITY(U,$J,358.3,9317,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9317,1,3,0)
 ;;=3^Ulcerative Colitis w/ Intestinal Obstruction,Unspec
 ;;^UTILITY(U,$J,358.3,9317,1,4,0)
 ;;=4^K51.912
 ;;^UTILITY(U,$J,358.3,9317,2)
 ;;=^5008696
 ;;^UTILITY(U,$J,358.3,9318,0)
 ;;=K51.911^^48^484^88
 ;;^UTILITY(U,$J,358.3,9318,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9318,1,3,0)
 ;;=3^Ulcerative Colitis w/ Rectal Bleeding,Unspec
 ;;^UTILITY(U,$J,358.3,9318,1,4,0)
 ;;=4^K51.911
 ;;^UTILITY(U,$J,358.3,9318,2)
 ;;=^5008695
 ;;^UTILITY(U,$J,358.3,9319,0)
 ;;=K52.89^^48^484^61
 ;;^UTILITY(U,$J,358.3,9319,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9319,1,3,0)
 ;;=3^Gastroenteritis & Colitis,Oth Spec Noninfective
 ;;^UTILITY(U,$J,358.3,9319,1,4,0)
 ;;=4^K52.89
 ;;^UTILITY(U,$J,358.3,9319,2)
 ;;=^5008703
