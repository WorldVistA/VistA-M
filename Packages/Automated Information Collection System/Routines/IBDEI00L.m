IBDEI00L ; ; 09-FEB-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,444,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,444,1,3,0)
 ;;=3^Tubulo-Interstitial Nephritis
 ;;^UTILITY(U,$J,358.3,444,1,4,0)
 ;;=4^N12.
 ;;^UTILITY(U,$J,358.3,444,2)
 ;;=^5015575
 ;;^UTILITY(U,$J,358.3,445,0)
 ;;=N30.90^^1^7^42
 ;;^UTILITY(U,$J,358.3,445,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,445,1,3,0)
 ;;=3^Cystitis w/o Hematuria,Unspec
 ;;^UTILITY(U,$J,358.3,445,1,4,0)
 ;;=4^N30.90
 ;;^UTILITY(U,$J,358.3,445,2)
 ;;=^5015642
 ;;^UTILITY(U,$J,358.3,446,0)
 ;;=N30.91^^1^7^41
 ;;^UTILITY(U,$J,358.3,446,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,446,1,3,0)
 ;;=3^Cystitis w/ Hematuria,Unspec
 ;;^UTILITY(U,$J,358.3,446,1,4,0)
 ;;=4^N30.91
 ;;^UTILITY(U,$J,358.3,446,2)
 ;;=^5015643
 ;;^UTILITY(U,$J,358.3,447,0)
 ;;=N70.92^^1^7^81
 ;;^UTILITY(U,$J,358.3,447,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,447,1,3,0)
 ;;=3^Oophoritis,Unspec
 ;;^UTILITY(U,$J,358.3,447,1,4,0)
 ;;=4^N70.92
 ;;^UTILITY(U,$J,358.3,447,2)
 ;;=^5015807
 ;;^UTILITY(U,$J,358.3,448,0)
 ;;=N73.9^^1^7^51
 ;;^UTILITY(U,$J,358.3,448,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,448,1,3,0)
 ;;=3^Female Pelvic Inflammatory Disease,Unspec
 ;;^UTILITY(U,$J,358.3,448,1,4,0)
 ;;=4^N73.9
 ;;^UTILITY(U,$J,358.3,448,2)
 ;;=^5015820
 ;;^UTILITY(U,$J,358.3,449,0)
 ;;=N72.^^1^7^69
 ;;^UTILITY(U,$J,358.3,449,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,449,1,3,0)
 ;;=3^Inflammatory Disease of Cervix Uteri
 ;;^UTILITY(U,$J,358.3,449,1,4,0)
 ;;=4^N72.
 ;;^UTILITY(U,$J,358.3,449,2)
 ;;=^5015812
 ;;^UTILITY(U,$J,358.3,450,0)
 ;;=N76.0^^1^7^12
 ;;^UTILITY(U,$J,358.3,450,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,450,1,3,0)
 ;;=3^Acute Vaginitis
 ;;^UTILITY(U,$J,358.3,450,1,4,0)
 ;;=4^N76.0
 ;;^UTILITY(U,$J,358.3,450,2)
 ;;=^5015826
 ;;^UTILITY(U,$J,358.3,451,0)
 ;;=N76.1^^1^7^103
 ;;^UTILITY(U,$J,358.3,451,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,451,1,3,0)
 ;;=3^Vaginitis,Subacute/Chronic
 ;;^UTILITY(U,$J,358.3,451,1,4,0)
 ;;=4^N76.1
 ;;^UTILITY(U,$J,358.3,451,2)
 ;;=^5015827
 ;;^UTILITY(U,$J,358.3,452,0)
 ;;=L03.011^^1^7^27
 ;;^UTILITY(U,$J,358.3,452,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,452,1,3,0)
 ;;=3^Cellulitis of Right Finger
 ;;^UTILITY(U,$J,358.3,452,1,4,0)
 ;;=4^L03.011
 ;;^UTILITY(U,$J,358.3,452,2)
 ;;=^5009019
 ;;^UTILITY(U,$J,358.3,453,0)
 ;;=L03.012^^1^7^20
 ;;^UTILITY(U,$J,358.3,453,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,453,1,3,0)
 ;;=3^Cellulitis of Left Finger
 ;;^UTILITY(U,$J,358.3,453,1,4,0)
 ;;=4^L03.012
 ;;^UTILITY(U,$J,358.3,453,2)
 ;;=^5009020
 ;;^UTILITY(U,$J,358.3,454,0)
 ;;=L03.031^^1^7^30
 ;;^UTILITY(U,$J,358.3,454,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,454,1,3,0)
 ;;=3^Cellulitis of Right Toe
 ;;^UTILITY(U,$J,358.3,454,1,4,0)
 ;;=4^L03.031
 ;;^UTILITY(U,$J,358.3,454,2)
 ;;=^5009025
 ;;^UTILITY(U,$J,358.3,455,0)
 ;;=L03.032^^1^7^23
 ;;^UTILITY(U,$J,358.3,455,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,455,1,3,0)
 ;;=3^Cellulitis of Left Toe
 ;;^UTILITY(U,$J,358.3,455,1,4,0)
 ;;=4^L03.032
 ;;^UTILITY(U,$J,358.3,455,2)
 ;;=^5009026
 ;;^UTILITY(U,$J,358.3,456,0)
 ;;=L03.211^^1^7^18
 ;;^UTILITY(U,$J,358.3,456,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,456,1,3,0)
 ;;=3^Cellulitis of Face
 ;;^UTILITY(U,$J,358.3,456,1,4,0)
 ;;=4^L03.211
 ;;^UTILITY(U,$J,358.3,456,2)
 ;;=^5009043
 ;;^UTILITY(U,$J,358.3,457,0)
 ;;=L03.221^^1^7^25
 ;;^UTILITY(U,$J,358.3,457,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,457,1,3,0)
 ;;=3^Cellulitis of Neck
 ;;^UTILITY(U,$J,358.3,457,1,4,0)
 ;;=4^L03.221
 ;;^UTILITY(U,$J,358.3,457,2)
 ;;=^5009045
 ;;^UTILITY(U,$J,358.3,458,0)
 ;;=L03.319^^1^7^32
 ;;^UTILITY(U,$J,358.3,458,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,458,1,3,0)
 ;;=3^Cellulitis of Trunk,Unspec
 ;;^UTILITY(U,$J,358.3,458,1,4,0)
 ;;=4^L03.319
 ;;^UTILITY(U,$J,358.3,458,2)
 ;;=^5009054
 ;;^UTILITY(U,$J,358.3,459,0)
 ;;=L03.113^^1^7^31
 ;;^UTILITY(U,$J,358.3,459,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,459,1,3,0)
 ;;=3^Cellulitis of Right Upper Limb
 ;;^UTILITY(U,$J,358.3,459,1,4,0)
 ;;=4^L03.113
 ;;^UTILITY(U,$J,358.3,459,2)
 ;;=^5009033
 ;;^UTILITY(U,$J,358.3,460,0)
 ;;=L03.114^^1^7^24
 ;;^UTILITY(U,$J,358.3,460,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,460,1,3,0)
 ;;=3^Cellulitis of Left Upper Limb
 ;;^UTILITY(U,$J,358.3,460,1,4,0)
 ;;=4^L03.114
 ;;^UTILITY(U,$J,358.3,460,2)
 ;;=^5009034
 ;;^UTILITY(U,$J,358.3,461,0)
 ;;=L03.115^^1^7^28
 ;;^UTILITY(U,$J,358.3,461,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,461,1,3,0)
 ;;=3^Cellulitis of Right Lower Limb
 ;;^UTILITY(U,$J,358.3,461,1,4,0)
 ;;=4^L03.115
 ;;^UTILITY(U,$J,358.3,461,2)
 ;;=^5009035
 ;;^UTILITY(U,$J,358.3,462,0)
 ;;=L03.116^^1^7^21
 ;;^UTILITY(U,$J,358.3,462,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,462,1,3,0)
 ;;=3^Cellulitis of Left Lower Limb
 ;;^UTILITY(U,$J,358.3,462,1,4,0)
 ;;=4^L03.116
 ;;^UTILITY(U,$J,358.3,462,2)
 ;;=^5133645
 ;;^UTILITY(U,$J,358.3,463,0)
 ;;=M00.9^^1^7^88
 ;;^UTILITY(U,$J,358.3,463,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,463,1,3,0)
 ;;=3^Pyogenic Arthritis,Unspec
 ;;^UTILITY(U,$J,358.3,463,1,4,0)
 ;;=4^M00.9
 ;;^UTILITY(U,$J,358.3,463,2)
 ;;=^5009693
 ;;^UTILITY(U,$J,358.3,464,0)
 ;;=M86.10^^1^7^7
 ;;^UTILITY(U,$J,358.3,464,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,464,1,3,0)
 ;;=3^Acute Osteomyelitis,Unspec Site,NEC
 ;;^UTILITY(U,$J,358.3,464,1,4,0)
 ;;=4^M86.10
 ;;^UTILITY(U,$J,358.3,464,2)
 ;;=^5014521
 ;;^UTILITY(U,$J,358.3,465,0)
 ;;=M86.20^^1^7^95
 ;;^UTILITY(U,$J,358.3,465,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,465,1,3,0)
 ;;=3^Subacute Osteomyelitis,Unspec Site
 ;;^UTILITY(U,$J,358.3,465,1,4,0)
 ;;=4^M86.20
 ;;^UTILITY(U,$J,358.3,465,2)
 ;;=^5014535
 ;;^UTILITY(U,$J,358.3,466,0)
 ;;=M86.60^^1^7^33
 ;;^UTILITY(U,$J,358.3,466,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,466,1,3,0)
 ;;=3^Chronic Osteomyelitis,Unspec Site,NEC
 ;;^UTILITY(U,$J,358.3,466,1,4,0)
 ;;=4^M86.60
 ;;^UTILITY(U,$J,358.3,466,2)
 ;;=^5014630
 ;;^UTILITY(U,$J,358.3,467,0)
 ;;=R50.9^^1^7^52
 ;;^UTILITY(U,$J,358.3,467,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,467,1,3,0)
 ;;=3^Fever,Unspec
 ;;^UTILITY(U,$J,358.3,467,1,4,0)
 ;;=4^R50.9
 ;;^UTILITY(U,$J,358.3,467,2)
 ;;=^5019512
 ;;^UTILITY(U,$J,358.3,468,0)
 ;;=C77.0^^1^8^8
 ;;^UTILITY(U,$J,358.3,468,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,468,1,3,0)
 ;;=3^Secondary Malig Neop of Head/Face/Neck Lymph Nodes
 ;;^UTILITY(U,$J,358.3,468,1,4,0)
 ;;=4^C77.0
 ;;^UTILITY(U,$J,358.3,468,2)
 ;;=^5001329
 ;;^UTILITY(U,$J,358.3,469,0)
 ;;=C77.1^^1^8^12
 ;;^UTILITY(U,$J,358.3,469,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,469,1,3,0)
 ;;=3^Secondary Malig Neop of Intrathoracic Lymph Nodes
 ;;^UTILITY(U,$J,358.3,469,1,4,0)
 ;;=4^C77.1
 ;;^UTILITY(U,$J,358.3,469,2)
 ;;=^267315
 ;;^UTILITY(U,$J,358.3,470,0)
 ;;=C77.2^^1^8^10
 ;;^UTILITY(U,$J,358.3,470,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,470,1,3,0)
 ;;=3^Secondary Malig Neop of Intra-Abdominal Lymph Nodes
 ;;^UTILITY(U,$J,358.3,470,1,4,0)
 ;;=4^C77.2
 ;;^UTILITY(U,$J,358.3,470,2)
 ;;=^267316
 ;;^UTILITY(U,$J,358.3,471,0)
 ;;=C77.3^^1^8^1
 ;;^UTILITY(U,$J,358.3,471,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,471,1,3,0)
 ;;=3^Secondary Malig Neop of Axilla/Upper Limb Lymph Nodes
 ;;^UTILITY(U,$J,358.3,471,1,4,0)
 ;;=4^C77.3
 ;;^UTILITY(U,$J,358.3,471,2)
 ;;=^5001330
 ;;^UTILITY(U,$J,358.3,472,0)
 ;;=C77.4^^1^8^9
 ;;^UTILITY(U,$J,358.3,472,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,472,1,3,0)
 ;;=3^Secondary Malig Neop of Inguinal/Lower Limb Lymph Nodes
 ;;^UTILITY(U,$J,358.3,472,1,4,0)
 ;;=4^C77.4
 ;;^UTILITY(U,$J,358.3,472,2)
 ;;=^5001331
 ;;^UTILITY(U,$J,358.3,473,0)
 ;;=C77.5^^1^8^11
 ;;^UTILITY(U,$J,358.3,473,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,473,1,3,0)
 ;;=3^Secondary Malig Neop of Intrapelvic Lymph Nodes
 ;;^UTILITY(U,$J,358.3,473,1,4,0)
 ;;=4^C77.5
 ;;^UTILITY(U,$J,358.3,473,2)
 ;;=^267319
 ;;^UTILITY(U,$J,358.3,474,0)
 ;;=C77.8^^1^8^16
 ;;^UTILITY(U,$J,358.3,474,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,474,1,3,0)
 ;;=3^Secondary Malig Neop of Mult Region Lymph Nodes
 ;;^UTILITY(U,$J,358.3,474,1,4,0)
 ;;=4^C77.8
 ;;^UTILITY(U,$J,358.3,474,2)
 ;;=^5001332
 ;;^UTILITY(U,$J,358.3,475,0)
 ;;=C78.01^^1^8^18
 ;;^UTILITY(U,$J,358.3,475,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,475,1,3,0)
 ;;=3^Secondary Malig Neop of Right Lung
 ;;^UTILITY(U,$J,358.3,475,1,4,0)
 ;;=4^C78.01
 ;;^UTILITY(U,$J,358.3,475,2)
 ;;=^5001335
 ;;^UTILITY(U,$J,358.3,476,0)
 ;;=C78.02^^1^8^14
 ;;^UTILITY(U,$J,358.3,476,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,476,1,3,0)
 ;;=3^Secondary Malig Neop of Left Lung
 ;;^UTILITY(U,$J,358.3,476,1,4,0)
 ;;=4^C78.02
 ;;^UTILITY(U,$J,358.3,476,2)
 ;;=^5001336
 ;;^UTILITY(U,$J,358.3,477,0)
 ;;=C79.19^^1^8^21
 ;;^UTILITY(U,$J,358.3,477,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,477,1,3,0)
 ;;=3^Secondary Malig Neop of Urinary Organs NEC
 ;;^UTILITY(U,$J,358.3,477,1,4,0)
 ;;=4^C79.19
 ;;^UTILITY(U,$J,358.3,477,2)
 ;;=^267332
 ;;^UTILITY(U,$J,358.3,478,0)
 ;;=C79.11^^1^8^2
 ;;^UTILITY(U,$J,358.3,478,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,478,1,3,0)
 ;;=3^Secondary Malig Neop of Bladder
 ;;^UTILITY(U,$J,358.3,478,1,4,0)
 ;;=4^C79.11
 ;;^UTILITY(U,$J,358.3,478,2)
 ;;=^5001346
 ;;^UTILITY(U,$J,358.3,479,0)
 ;;=C79.2^^1^8^20
 ;;^UTILITY(U,$J,358.3,479,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,479,1,3,0)
 ;;=3^Secondary Malig Neop of Skin
 ;;^UTILITY(U,$J,358.3,479,1,4,0)
 ;;=4^C79.2
 ;;^UTILITY(U,$J,358.3,479,2)
 ;;=^267333
 ;;^UTILITY(U,$J,358.3,480,0)
 ;;=C79.31^^1^8^5
 ;;^UTILITY(U,$J,358.3,480,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,480,1,3,0)
 ;;=3^Secondary Malig Neop of Brain
 ;;^UTILITY(U,$J,358.3,480,1,4,0)
 ;;=4^C79.31
 ;;^UTILITY(U,$J,358.3,480,2)
 ;;=^5001347
 ;;^UTILITY(U,$J,358.3,481,0)
 ;;=C79.32^^1^8^7
 ;;^UTILITY(U,$J,358.3,481,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,481,1,3,0)
 ;;=3^Secondary Malig Neop of Cerebral Meninges
