IBDEI0P0 ; ; 12-AUG-2014
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,12332,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,12332,1,4,0)
 ;;=4^789.06
 ;;^UTILITY(U,$J,358.3,12332,1,5,0)
 ;;=5^Epigastric Pain
 ;;^UTILITY(U,$J,358.3,12332,2)
 ;;=Epigastric Pain^303323
 ;;^UTILITY(U,$J,358.3,12333,0)
 ;;=788.0^^84^806^7
 ;;^UTILITY(U,$J,358.3,12333,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,12333,1,4,0)
 ;;=4^788.0
 ;;^UTILITY(U,$J,358.3,12333,1,5,0)
 ;;=5^Kidney Pain
 ;;^UTILITY(U,$J,358.3,12333,2)
 ;;=^265306
 ;;^UTILITY(U,$J,358.3,12334,0)
 ;;=719.40^^84^806^6
 ;;^UTILITY(U,$J,358.3,12334,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,12334,1,4,0)
 ;;=4^719.40
 ;;^UTILITY(U,$J,358.3,12334,1,5,0)
 ;;=5^Joint Pain
 ;;^UTILITY(U,$J,358.3,12334,2)
 ;;=^66375
 ;;^UTILITY(U,$J,358.3,12335,0)
 ;;=724.2^^84^806^8
 ;;^UTILITY(U,$J,358.3,12335,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,12335,1,4,0)
 ;;=4^724.2
 ;;^UTILITY(U,$J,358.3,12335,1,5,0)
 ;;=5^Low Back Pain
 ;;^UTILITY(U,$J,358.3,12335,2)
 ;;=^71885
 ;;^UTILITY(U,$J,358.3,12336,0)
 ;;=608.9^^84^806^14
 ;;^UTILITY(U,$J,358.3,12336,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,12336,1,4,0)
 ;;=4^608.9
 ;;^UTILITY(U,$J,358.3,12336,1,5,0)
 ;;=5^Scrotal Pain
 ;;^UTILITY(U,$J,358.3,12336,2)
 ;;=^123856
 ;;^UTILITY(U,$J,358.3,12337,0)
 ;;=607.9^^84^806^13
 ;;^UTILITY(U,$J,358.3,12337,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,12337,1,4,0)
 ;;=4^607.9
 ;;^UTILITY(U,$J,358.3,12337,1,5,0)
 ;;=5^Penile Pain
 ;;^UTILITY(U,$J,358.3,12337,2)
 ;;=^270442
 ;;^UTILITY(U,$J,358.3,12338,0)
 ;;=996.74^^84^807^24
 ;;^UTILITY(U,$J,358.3,12338,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,12338,1,4,0)
 ;;=4^996.74
 ;;^UTILITY(U,$J,358.3,12338,1,5,0)
 ;;=5^  Vascular Graft/Implant
 ;;^UTILITY(U,$J,358.3,12338,2)
 ;;=^276297
 ;;^UTILITY(U,$J,358.3,12339,0)
 ;;=996.71^^84^807^21
 ;;^UTILITY(U,$J,358.3,12339,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,12339,1,4,0)
 ;;=4^996.71
 ;;^UTILITY(U,$J,358.3,12339,1,5,0)
 ;;=5^  Heart Valve
 ;;^UTILITY(U,$J,358.3,12339,2)
 ;;=^276294
 ;;^UTILITY(U,$J,358.3,12340,0)
 ;;=1^1^84^807^1^Device Causing Pain/Bleed/Embolism/Thrombus^1
 ;;^UTILITY(U,$J,358.3,12340,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,12340,1,4,0)
 ;;=4
 ;;^UTILITY(U,$J,358.3,12340,1,5,0)
 ;;=5
 ;;^UTILITY(U,$J,358.3,12341,0)
 ;;=996.72^^84^807^22
 ;;^UTILITY(U,$J,358.3,12341,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,12341,1,4,0)
 ;;=4^996.72
 ;;^UTILITY(U,$J,358.3,12341,1,5,0)
 ;;=5^  Cardiac Graft/Implant
 ;;^UTILITY(U,$J,358.3,12341,2)
 ;;=^276295
 ;;^UTILITY(U,$J,358.3,12342,0)
 ;;=996.73^^84^807^23
 ;;^UTILITY(U,$J,358.3,12342,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,12342,1,4,0)
 ;;=4^996.73
 ;;^UTILITY(U,$J,358.3,12342,1,5,0)
 ;;=5^  Renal Dialysis Graft/Implant
 ;;^UTILITY(U,$J,358.3,12342,2)
 ;;=^276296
 ;;^UTILITY(U,$J,358.3,12343,0)
 ;;=996.75^^84^807^26
 ;;^UTILITY(U,$J,358.3,12343,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,12343,1,4,0)
 ;;=4^996.75
 ;;^UTILITY(U,$J,358.3,12343,1,5,0)
 ;;=5^  Nervous System Graft/Implant
 ;;^UTILITY(U,$J,358.3,12343,2)
 ;;=^276298
 ;;^UTILITY(U,$J,358.3,12344,0)
 ;;=996.76^^84^807^27
 ;;^UTILITY(U,$J,358.3,12344,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,12344,1,4,0)
 ;;=4^996.76
 ;;^UTILITY(U,$J,358.3,12344,1,5,0)
 ;;=5^  Genitourinary Graft/Implant
 ;;^UTILITY(U,$J,358.3,12344,2)
 ;;=^276299
 ;;^UTILITY(U,$J,358.3,12345,0)
 ;;=996.77^^84^807^28
 ;;^UTILITY(U,$J,358.3,12345,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,12345,1,4,0)
 ;;=4^996.77
 ;;^UTILITY(U,$J,358.3,12345,1,5,0)
 ;;=5^  Joint Prosthesis
 ;;^UTILITY(U,$J,358.3,12345,2)
 ;;=^276300
 ;;^UTILITY(U,$J,358.3,12346,0)
 ;;=996.78^^84^807^29