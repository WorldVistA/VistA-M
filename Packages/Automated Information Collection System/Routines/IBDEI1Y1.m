IBDEI1Y1 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,32981,1,2,0)
 ;;=2^11200
 ;;^UTILITY(U,$J,358.3,32981,1,3,0)
 ;;=3^Removal Skin Tags,up to 15 Lesions
 ;;^UTILITY(U,$J,358.3,32982,0)
 ;;=11201^^130^1650^25^^^^1
 ;;^UTILITY(U,$J,358.3,32982,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,32982,1,2,0)
 ;;=2^11201
 ;;^UTILITY(U,$J,358.3,32982,1,3,0)
 ;;=3^Removal Skin Tags,ea addl 10 Lesions
 ;;^UTILITY(U,$J,358.3,32983,0)
 ;;=11100^^130^1650^7^^^^1
 ;;^UTILITY(U,$J,358.3,32983,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,32983,1,2,0)
 ;;=2^11100
 ;;^UTILITY(U,$J,358.3,32983,1,3,0)
 ;;=3^Biopsy Skin Lesion,Single Lesion
 ;;^UTILITY(U,$J,358.3,32984,0)
 ;;=11101^^130^1650^8^^^^1
 ;;^UTILITY(U,$J,358.3,32984,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,32984,1,2,0)
 ;;=2^11101
 ;;^UTILITY(U,$J,358.3,32984,1,3,0)
 ;;=3^Biopsy Skin Lesion,ea addl Lesion
 ;;^UTILITY(U,$J,358.3,32985,0)
 ;;=10030^^130^1650^19^^^^1
 ;;^UTILITY(U,$J,358.3,32985,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,32985,1,2,0)
 ;;=2^10030
 ;;^UTILITY(U,$J,358.3,32985,1,3,0)
 ;;=3^Image Guided Collec by Cath,Abscess
 ;;^UTILITY(U,$J,358.3,32986,0)
 ;;=20604^^130^1650^5^^^^1
 ;;^UTILITY(U,$J,358.3,32986,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,32986,1,2,0)
 ;;=2^20604
 ;;^UTILITY(U,$J,358.3,32986,1,3,0)
 ;;=3^Arthrocentesis,Small Jt w/ US Guidance
 ;;^UTILITY(U,$J,358.3,32987,0)
 ;;=20606^^130^1650^1^^^^1
 ;;^UTILITY(U,$J,358.3,32987,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,32987,1,2,0)
 ;;=2^20606
 ;;^UTILITY(U,$J,358.3,32987,1,3,0)
 ;;=3^Arthrocentesis,Intermediate Jt w/ US Guidance
 ;;^UTILITY(U,$J,358.3,32988,0)
 ;;=20611^^130^1650^3^^^^1
 ;;^UTILITY(U,$J,358.3,32988,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,32988,1,2,0)
 ;;=2^20611
 ;;^UTILITY(U,$J,358.3,32988,1,3,0)
 ;;=3^Arthrocentesis,Major Jt w/ US Guidance
 ;;^UTILITY(U,$J,358.3,32989,0)
 ;;=10021^^130^1650^16^^^^1
 ;;^UTILITY(U,$J,358.3,32989,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,32989,1,2,0)
 ;;=2^10021
 ;;^UTILITY(U,$J,358.3,32989,1,3,0)
 ;;=3^Fine Needle Aspiration w/o Guidance
 ;;^UTILITY(U,$J,358.3,32990,0)
 ;;=11300^^130^1650^27^^^^1
 ;;^UTILITY(U,$J,358.3,32990,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,32990,1,2,0)
 ;;=2^11300
 ;;^UTILITY(U,$J,358.3,32990,1,3,0)
 ;;=3^Shave Epidermal Lesion,Trunk/Ext,0.5 cm or <
 ;;^UTILITY(U,$J,358.3,32991,0)
 ;;=11301^^130^1650^28^^^^1
 ;;^UTILITY(U,$J,358.3,32991,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,32991,1,2,0)
 ;;=2^11301
 ;;^UTILITY(U,$J,358.3,32991,1,3,0)
 ;;=3^Shave Epidermal Lesion,Trunk/Ext,0.6-1.0 cm
 ;;^UTILITY(U,$J,358.3,32992,0)
 ;;=12013^^130^1650^30^^^^1
 ;;^UTILITY(U,$J,358.3,32992,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,32992,1,2,0)
 ;;=2^12013
 ;;^UTILITY(U,$J,358.3,32992,1,3,0)
 ;;=3^Suture Simple Wound,Face,2.6-5.0 cm
 ;;^UTILITY(U,$J,358.3,32993,0)
 ;;=69209^^130^1650^23^^^^1
 ;;^UTILITY(U,$J,358.3,32993,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,32993,1,2,0)
 ;;=2^69209
 ;;^UTILITY(U,$J,358.3,32993,1,3,0)
 ;;=3^Removal Impacted Cerumen/Irrigate/Lavage
 ;;^UTILITY(U,$J,358.3,32994,0)
 ;;=69210^^130^1650^24^^^^1
 ;;^UTILITY(U,$J,358.3,32994,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,32994,1,2,0)
 ;;=2^69210
 ;;^UTILITY(U,$J,358.3,32994,1,3,0)
 ;;=3^Removal Impacted Cerumen/Req Instruments
 ;;^UTILITY(U,$J,358.3,32995,0)
 ;;=29105^^130^1651^2^^^^1
 ;;^UTILITY(U,$J,358.3,32995,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,32995,1,2,0)
 ;;=2^29105
 ;;^UTILITY(U,$J,358.3,32995,1,3,0)
 ;;=3^Long Arm Splint
 ;;^UTILITY(U,$J,358.3,32996,0)
 ;;=29125^^130^1651^4^^^^1
 ;;^UTILITY(U,$J,358.3,32996,1,0)
 ;;=^358.31IA^3^2
