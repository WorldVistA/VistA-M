IBDEI050 ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,6172,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6172,1,3,0)
 ;;=3^Conjunctival Hemorrhage,Right Eye
 ;;^UTILITY(U,$J,358.3,6172,1,4,0)
 ;;=4^H11.31
 ;;^UTILITY(U,$J,358.3,6172,2)
 ;;=^5004782
 ;;^UTILITY(U,$J,358.3,6173,0)
 ;;=H01.002^^26^395^3
 ;;^UTILITY(U,$J,358.3,6173,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6173,1,3,0)
 ;;=3^Blepharitis Unspec,Right Lower Eyelid
 ;;^UTILITY(U,$J,358.3,6173,1,4,0)
 ;;=4^H01.002
 ;;^UTILITY(U,$J,358.3,6173,2)
 ;;=^5004239
 ;;^UTILITY(U,$J,358.3,6174,0)
 ;;=H01.004^^26^395^2
 ;;^UTILITY(U,$J,358.3,6174,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6174,1,3,0)
 ;;=3^Blepharitis Unspec,Left Upper Eyelid
 ;;^UTILITY(U,$J,358.3,6174,1,4,0)
 ;;=4^H01.004
 ;;^UTILITY(U,$J,358.3,6174,2)
 ;;=^5004241
 ;;^UTILITY(U,$J,358.3,6175,0)
 ;;=H01.005^^26^395^1
 ;;^UTILITY(U,$J,358.3,6175,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6175,1,3,0)
 ;;=3^Blepharitis Unspec,Left Lower Eyelid
 ;;^UTILITY(U,$J,358.3,6175,1,4,0)
 ;;=4^H01.005
 ;;^UTILITY(U,$J,358.3,6175,2)
 ;;=^5133380
 ;;^UTILITY(U,$J,358.3,6176,0)
 ;;=H01.001^^26^395^4
 ;;^UTILITY(U,$J,358.3,6176,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6176,1,3,0)
 ;;=3^Blepharitis Unspec,Right Upper Eyelid
 ;;^UTILITY(U,$J,358.3,6176,1,4,0)
 ;;=4^H01.001
 ;;^UTILITY(U,$J,358.3,6176,2)
 ;;=^5004238
 ;;^UTILITY(U,$J,358.3,6177,0)
 ;;=H57.13^^26^395^10
 ;;^UTILITY(U,$J,358.3,6177,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6177,1,3,0)
 ;;=3^Ocular Pain,Bilateral
 ;;^UTILITY(U,$J,358.3,6177,1,4,0)
 ;;=4^H57.13
 ;;^UTILITY(U,$J,358.3,6177,2)
 ;;=^5006384
 ;;^UTILITY(U,$J,358.3,6178,0)
 ;;=H57.12^^26^395^11
 ;;^UTILITY(U,$J,358.3,6178,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6178,1,3,0)
 ;;=3^Ocular Pain,Left Eye
 ;;^UTILITY(U,$J,358.3,6178,1,4,0)
 ;;=4^H57.12
 ;;^UTILITY(U,$J,358.3,6178,2)
 ;;=^5006383
 ;;^UTILITY(U,$J,358.3,6179,0)
 ;;=H57.11^^26^395^12
 ;;^UTILITY(U,$J,358.3,6179,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6179,1,3,0)
 ;;=3^Ocular Pain,Right Eye
 ;;^UTILITY(U,$J,358.3,6179,1,4,0)
 ;;=4^H57.11
 ;;^UTILITY(U,$J,358.3,6179,2)
 ;;=^5006382
 ;;^UTILITY(U,$J,358.3,6180,0)
 ;;=S05.02XA^^26^396^3
 ;;^UTILITY(U,$J,358.3,6180,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6180,1,3,0)
 ;;=3^Inj Conjunctiva/Corneal Abrasion w/o FB,Left Eye,Init
 ;;^UTILITY(U,$J,358.3,6180,1,4,0)
 ;;=4^S05.02XA
 ;;^UTILITY(U,$J,358.3,6180,2)
 ;;=^5020582
 ;;^UTILITY(U,$J,358.3,6181,0)
 ;;=S05.01XA^^26^396^4
 ;;^UTILITY(U,$J,358.3,6181,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6181,1,3,0)
 ;;=3^Inj Conjunctiva/Corneal Abrasion w/o FB,Right Eye,Init
 ;;^UTILITY(U,$J,358.3,6181,1,4,0)
 ;;=4^S05.01XA
 ;;^UTILITY(U,$J,358.3,6181,2)
 ;;=^5020579
 ;;^UTILITY(U,$J,358.3,6182,0)
 ;;=T15.02XA^^26^396^1
 ;;^UTILITY(U,$J,358.3,6182,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6182,1,3,0)
 ;;=3^Foreign Body in Cornea,Left Eye,Init Encntr
 ;;^UTILITY(U,$J,358.3,6182,1,4,0)
 ;;=4^T15.02XA
 ;;^UTILITY(U,$J,358.3,6182,2)
 ;;=^5046387
 ;;^UTILITY(U,$J,358.3,6183,0)
 ;;=T15.01XA^^26^396^2
 ;;^UTILITY(U,$J,358.3,6183,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6183,1,3,0)
 ;;=3^Foreign Body in Cornea,Right Eye,Init Encntr
 ;;^UTILITY(U,$J,358.3,6183,1,4,0)
 ;;=4^T15.01XA
 ;;^UTILITY(U,$J,358.3,6183,2)
 ;;=^5046384
 ;;^UTILITY(U,$J,358.3,6184,0)
 ;;=S00.252A^^26^396^5
 ;;^UTILITY(U,$J,358.3,6184,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6184,1,3,0)
 ;;=3^Superficial FB of Left Eyelid/Periocular Area,Init Encntr
 ;;^UTILITY(U,$J,358.3,6184,1,4,0)
 ;;=4^S00.252A
 ;;^UTILITY(U,$J,358.3,6184,2)
 ;;=^5019820
 ;;^UTILITY(U,$J,358.3,6185,0)
 ;;=S00.251A^^26^396^6
 ;;^UTILITY(U,$J,358.3,6185,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6185,1,3,0)
 ;;=3^Superficial FB of Right Eyelid/Periocular Area,Init Encntr
 ;;^UTILITY(U,$J,358.3,6185,1,4,0)
 ;;=4^S00.251A
 ;;^UTILITY(U,$J,358.3,6185,2)
 ;;=^5019817
 ;;^UTILITY(U,$J,358.3,6186,0)
 ;;=B96.81^^26^397^57
 ;;^UTILITY(U,$J,358.3,6186,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6186,1,3,0)
 ;;=3^H. Pylori as the Cause of Diseases Classified Elsewhere
 ;;^UTILITY(U,$J,358.3,6186,1,4,0)
 ;;=4^B96.81
 ;;^UTILITY(U,$J,358.3,6186,2)
 ;;=^5000857
 ;;^UTILITY(U,$J,358.3,6187,0)
 ;;=B15.9^^26^397^59
 ;;^UTILITY(U,$J,358.3,6187,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6187,1,3,0)
 ;;=3^Hepatitis A,Acute w/o Hepatic Coma
 ;;^UTILITY(U,$J,358.3,6187,1,4,0)
 ;;=4^B15.9
 ;;^UTILITY(U,$J,358.3,6187,2)
 ;;=^5000536
 ;;^UTILITY(U,$J,358.3,6188,0)
 ;;=B16.9^^26^397^60
 ;;^UTILITY(U,$J,358.3,6188,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6188,1,3,0)
 ;;=3^Hepatitis B,Acute w/o Delta-Agent & w/o Hepatic Coma
 ;;^UTILITY(U,$J,358.3,6188,1,4,0)
 ;;=4^B16.9
 ;;^UTILITY(U,$J,358.3,6188,2)
 ;;=^5000540
 ;;^UTILITY(U,$J,358.3,6189,0)
 ;;=B19.10^^26^397^62
 ;;^UTILITY(U,$J,358.3,6189,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6189,1,3,0)
 ;;=3^Hepatitis B,Viral w/o Hepatic Coma,Unspec
 ;;^UTILITY(U,$J,358.3,6189,1,4,0)
 ;;=4^B19.10
 ;;^UTILITY(U,$J,358.3,6189,2)
 ;;=^5000552
 ;;^UTILITY(U,$J,358.3,6190,0)
 ;;=B18.1^^26^397^61
 ;;^UTILITY(U,$J,358.3,6190,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6190,1,3,0)
 ;;=3^Hepatitis B,Chronic Viral w/o Delta-Agent
 ;;^UTILITY(U,$J,358.3,6190,1,4,0)
 ;;=4^B18.1
 ;;^UTILITY(U,$J,358.3,6190,2)
 ;;=^5000547
 ;;^UTILITY(U,$J,358.3,6191,0)
 ;;=B17.10^^26^397^63
 ;;^UTILITY(U,$J,358.3,6191,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6191,1,3,0)
 ;;=3^Hepatitis C,Acute w/o Hepatic Coma
 ;;^UTILITY(U,$J,358.3,6191,1,4,0)
 ;;=4^B17.10
 ;;^UTILITY(U,$J,358.3,6191,2)
 ;;=^5000542
 ;;^UTILITY(U,$J,358.3,6192,0)
 ;;=B18.2^^26^397^64
 ;;^UTILITY(U,$J,358.3,6192,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6192,1,3,0)
 ;;=3^Hepatitis C,Chronic Viral
 ;;^UTILITY(U,$J,358.3,6192,1,4,0)
 ;;=4^B18.2
 ;;^UTILITY(U,$J,358.3,6192,2)
 ;;=^5000548
 ;;^UTILITY(U,$J,358.3,6193,0)
 ;;=B18.8^^26^397^66
 ;;^UTILITY(U,$J,358.3,6193,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6193,1,3,0)
 ;;=3^Hepatitis,Oth Chronic Viral
 ;;^UTILITY(U,$J,358.3,6193,1,4,0)
 ;;=4^B18.8
 ;;^UTILITY(U,$J,358.3,6193,2)
 ;;=^5000549
 ;;^UTILITY(U,$J,358.3,6194,0)
 ;;=B17.8^^26^397^67
 ;;^UTILITY(U,$J,358.3,6194,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6194,1,3,0)
 ;;=3^Hepatitis,Oth Spec Acute Viral
 ;;^UTILITY(U,$J,358.3,6194,1,4,0)
 ;;=4^B17.8
 ;;^UTILITY(U,$J,358.3,6194,2)
 ;;=^5000544
 ;;^UTILITY(U,$J,358.3,6195,0)
 ;;=B18.9^^26^397^65
 ;;^UTILITY(U,$J,358.3,6195,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6195,1,3,0)
 ;;=3^Hepatitis,Chronic Viral Unspec
 ;;^UTILITY(U,$J,358.3,6195,1,4,0)
 ;;=4^B18.9
 ;;^UTILITY(U,$J,358.3,6195,2)
 ;;=^5000550
 ;;^UTILITY(U,$J,358.3,6196,0)
 ;;=B37.81^^26^397^18
 ;;^UTILITY(U,$J,358.3,6196,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6196,1,3,0)
 ;;=3^Candidal Esophagitis
 ;;^UTILITY(U,$J,358.3,6196,1,4,0)
 ;;=4^B37.81
 ;;^UTILITY(U,$J,358.3,6196,2)
 ;;=^5000620
 ;;^UTILITY(U,$J,358.3,6197,0)
 ;;=D12.0^^26^397^12
 ;;^UTILITY(U,$J,358.3,6197,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6197,1,3,0)
 ;;=3^Benign Neop of Cecum
 ;;^UTILITY(U,$J,358.3,6197,1,4,0)
 ;;=4^D12.0
 ;;^UTILITY(U,$J,358.3,6197,2)
 ;;=^5001963
 ;;^UTILITY(U,$J,358.3,6198,0)
 ;;=D12.6^^26^397^13
 ;;^UTILITY(U,$J,358.3,6198,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6198,1,3,0)
 ;;=3^Benign Neop of Colon,Unspec
 ;;^UTILITY(U,$J,358.3,6198,1,4,0)
 ;;=4^D12.6
 ;;^UTILITY(U,$J,358.3,6198,2)
 ;;=^5001969
 ;;^UTILITY(U,$J,358.3,6199,0)
 ;;=D12.1^^26^397^10
 ;;^UTILITY(U,$J,358.3,6199,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6199,1,3,0)
 ;;=3^Benign Neop of Appendix
 ;;^UTILITY(U,$J,358.3,6199,1,4,0)
 ;;=4^D12.1
 ;;^UTILITY(U,$J,358.3,6199,2)
 ;;=^5001964
 ;;^UTILITY(U,$J,358.3,6200,0)
 ;;=K63.5^^26^397^76
 ;;^UTILITY(U,$J,358.3,6200,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6200,1,3,0)
 ;;=3^Polyp of Colon
 ;;^UTILITY(U,$J,358.3,6200,1,4,0)
 ;;=4^K63.5
 ;;^UTILITY(U,$J,358.3,6200,2)
 ;;=^5008765
 ;;^UTILITY(U,$J,358.3,6201,0)
 ;;=D12.3^^26^397^17
 ;;^UTILITY(U,$J,358.3,6201,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6201,1,3,0)
 ;;=3^Benign Neop of Transverse Colon
 ;;^UTILITY(U,$J,358.3,6201,1,4,0)
 ;;=4^D12.3
 ;;^UTILITY(U,$J,358.3,6201,2)
 ;;=^5001966
 ;;^UTILITY(U,$J,358.3,6202,0)
 ;;=D12.2^^26^397^11
 ;;^UTILITY(U,$J,358.3,6202,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6202,1,3,0)
 ;;=3^Benign Neop of Ascending Colon
 ;;^UTILITY(U,$J,358.3,6202,1,4,0)
 ;;=4^D12.2
 ;;^UTILITY(U,$J,358.3,6202,2)
 ;;=^5001965
 ;;^UTILITY(U,$J,358.3,6203,0)
 ;;=D12.5^^26^397^16
 ;;^UTILITY(U,$J,358.3,6203,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6203,1,3,0)
 ;;=3^Benign Neop of Sigmoid Colon
 ;;^UTILITY(U,$J,358.3,6203,1,4,0)
 ;;=4^D12.5
 ;;^UTILITY(U,$J,358.3,6203,2)
 ;;=^5001968
 ;;^UTILITY(U,$J,358.3,6204,0)
 ;;=D12.4^^26^397^14
 ;;^UTILITY(U,$J,358.3,6204,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6204,1,3,0)
 ;;=3^Benign Neop of Descending Colon
 ;;^UTILITY(U,$J,358.3,6204,1,4,0)
 ;;=4^D12.4
 ;;^UTILITY(U,$J,358.3,6204,2)
 ;;=^5001967
 ;;^UTILITY(U,$J,358.3,6205,0)
 ;;=D73.2^^26^397^19
 ;;^UTILITY(U,$J,358.3,6205,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6205,1,3,0)
 ;;=3^Congestive Splenomegaly,Chronic
 ;;^UTILITY(U,$J,358.3,6205,1,4,0)
 ;;=4^D73.2
 ;;^UTILITY(U,$J,358.3,6205,2)
 ;;=^268000
 ;;^UTILITY(U,$J,358.3,6206,0)
 ;;=I85.00^^26^397^47
 ;;^UTILITY(U,$J,358.3,6206,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6206,1,3,0)
 ;;=3^Esophageal Varices w/o Bleeding
 ;;^UTILITY(U,$J,358.3,6206,1,4,0)
 ;;=4^I85.00
 ;;^UTILITY(U,$J,358.3,6206,2)
 ;;=^5008023
 ;;^UTILITY(U,$J,358.3,6207,0)
 ;;=K20.9^^26^397^48
 ;;^UTILITY(U,$J,358.3,6207,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6207,1,3,0)
 ;;=3^Esophagitis,Unspec
 ;;^UTILITY(U,$J,358.3,6207,1,4,0)
 ;;=4^K20.9
 ;;^UTILITY(U,$J,358.3,6207,2)
 ;;=^295809
 ;;^UTILITY(U,$J,358.3,6208,0)
 ;;=K21.9^^26^397^56
 ;;^UTILITY(U,$J,358.3,6208,1,0)
 ;;=^358.31IA^4^2
