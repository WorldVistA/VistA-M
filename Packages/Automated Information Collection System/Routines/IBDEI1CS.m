IBDEI1CS ; ; 20-MAY-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,24280,1,2,0)
 ;;=2^11057
 ;;^UTILITY(U,$J,358.3,24280,1,3,0)
 ;;=3^Trim Corn/Callous, 5 or more
 ;;^UTILITY(U,$J,358.3,24281,0)
 ;;=12011^^144^1513^26^^^^1
 ;;^UTILITY(U,$J,358.3,24281,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24281,1,2,0)
 ;;=2^12011
 ;;^UTILITY(U,$J,358.3,24281,1,3,0)
 ;;=3^Suture Simple wounds, Face,2.5 cm or less
 ;;^UTILITY(U,$J,358.3,24282,0)
 ;;=97597^^144^1513^10^^^^1
 ;;^UTILITY(U,$J,358.3,24282,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24282,1,2,0)
 ;;=2^97597
 ;;^UTILITY(U,$J,358.3,24282,1,3,0)
 ;;=3^Debridement open wnd 1st 20sq cm
 ;;^UTILITY(U,$J,358.3,24283,0)
 ;;=97598^^144^1513^11^^^^1
 ;;^UTILITY(U,$J,358.3,24283,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24283,1,2,0)
 ;;=2^97598
 ;;^UTILITY(U,$J,358.3,24283,1,3,0)
 ;;=3^Debridement open wnd ea addl 20sq cm
 ;;^UTILITY(U,$J,358.3,24284,0)
 ;;=11200^^144^1513^23^^^^1
 ;;^UTILITY(U,$J,358.3,24284,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24284,1,2,0)
 ;;=2^11200
 ;;^UTILITY(U,$J,358.3,24284,1,3,0)
 ;;=3^Removal Skin Tags,up to 15 Lesions
 ;;^UTILITY(U,$J,358.3,24285,0)
 ;;=11201^^144^1513^22^^^^1
 ;;^UTILITY(U,$J,358.3,24285,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24285,1,2,0)
 ;;=2^11201
 ;;^UTILITY(U,$J,358.3,24285,1,3,0)
 ;;=3^Removal Skin Tags,ea addl 10 Lesions
 ;;^UTILITY(U,$J,358.3,24286,0)
 ;;=11100^^144^1513^7^^^^1
 ;;^UTILITY(U,$J,358.3,24286,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24286,1,2,0)
 ;;=2^11100
 ;;^UTILITY(U,$J,358.3,24286,1,3,0)
 ;;=3^Biopsy Skin Lesion,Single Lesion
 ;;^UTILITY(U,$J,358.3,24287,0)
 ;;=11101^^144^1513^8^^^^1
 ;;^UTILITY(U,$J,358.3,24287,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24287,1,2,0)
 ;;=2^11101
 ;;^UTILITY(U,$J,358.3,24287,1,3,0)
 ;;=3^Biopsy Skin Lesion,ea addl Lesion
 ;;^UTILITY(U,$J,358.3,24288,0)
 ;;=10030^^144^1513^18^^^^1
 ;;^UTILITY(U,$J,358.3,24288,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24288,1,2,0)
 ;;=2^10030
 ;;^UTILITY(U,$J,358.3,24288,1,3,0)
 ;;=3^Image Guided Collec by Cath,Abscess
 ;;^UTILITY(U,$J,358.3,24289,0)
 ;;=20604^^144^1513^1^^^^1
 ;;^UTILITY(U,$J,358.3,24289,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24289,1,2,0)
 ;;=2^20604
 ;;^UTILITY(U,$J,358.3,24289,1,3,0)
 ;;=3^Arthrocentesis,Small Jt w/ US Guidance
 ;;^UTILITY(U,$J,358.3,24290,0)
 ;;=20606^^144^1513^3^^^^1
 ;;^UTILITY(U,$J,358.3,24290,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24290,1,2,0)
 ;;=2^20606
 ;;^UTILITY(U,$J,358.3,24290,1,3,0)
 ;;=3^Arthrocentesis,Intermediate Jt w/ US Guidance
 ;;^UTILITY(U,$J,358.3,24291,0)
 ;;=20611^^144^1513^5^^^^1
 ;;^UTILITY(U,$J,358.3,24291,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24291,1,2,0)
 ;;=2^20611
 ;;^UTILITY(U,$J,358.3,24291,1,3,0)
 ;;=3^Arthrocentesis,Major Jt w/ US Guidance
 ;;^UTILITY(U,$J,358.3,24292,0)
 ;;=29105^^144^1514^2^^^^1
 ;;^UTILITY(U,$J,358.3,24292,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24292,1,2,0)
 ;;=2^29105
 ;;^UTILITY(U,$J,358.3,24292,1,3,0)
 ;;=3^Long Arm Splint
 ;;^UTILITY(U,$J,358.3,24293,0)
 ;;=29125^^144^1514^4^^^^1
 ;;^UTILITY(U,$J,358.3,24293,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24293,1,2,0)
 ;;=2^29125
 ;;^UTILITY(U,$J,358.3,24293,1,3,0)
 ;;=3^Short Arm Splint; Static
 ;;^UTILITY(U,$J,358.3,24294,0)
 ;;=29126^^144^1514^3^^^^1
 ;;^UTILITY(U,$J,358.3,24294,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24294,1,2,0)
 ;;=2^29126
 ;;^UTILITY(U,$J,358.3,24294,1,3,0)
 ;;=3^Short Arm Splint; Dynamic
 ;;^UTILITY(U,$J,358.3,24295,0)
 ;;=29130^^144^1514^1^^^^1
 ;;^UTILITY(U,$J,358.3,24295,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24295,1,2,0)
 ;;=2^29130
