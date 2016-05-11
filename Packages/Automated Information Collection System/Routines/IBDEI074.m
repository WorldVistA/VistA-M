IBDEI074 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,3016,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3016,1,3,0)
 ;;=3^Vestibular Function Disorder,Left Ear
 ;;^UTILITY(U,$J,358.3,3016,1,4,0)
 ;;=4^H81.92
 ;;^UTILITY(U,$J,358.3,3016,2)
 ;;=^5133552
 ;;^UTILITY(U,$J,358.3,3017,0)
 ;;=H81.93^^18^212^19
 ;;^UTILITY(U,$J,358.3,3017,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3017,1,3,0)
 ;;=3^Vestibular Function Disorder,Bilateral
 ;;^UTILITY(U,$J,358.3,3017,1,4,0)
 ;;=4^H81.93
 ;;^UTILITY(U,$J,358.3,3017,2)
 ;;=^5006889
 ;;^UTILITY(U,$J,358.3,3018,0)
 ;;=R63.0^^18^213^1
 ;;^UTILITY(U,$J,358.3,3018,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3018,1,3,0)
 ;;=3^Anorexia
 ;;^UTILITY(U,$J,358.3,3018,1,4,0)
 ;;=4^R63.0
 ;;^UTILITY(U,$J,358.3,3018,2)
 ;;=^7939
 ;;^UTILITY(U,$J,358.3,3019,0)
 ;;=R64.^^18^213^2
 ;;^UTILITY(U,$J,358.3,3019,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3019,1,3,0)
 ;;=3^Cachexia
 ;;^UTILITY(U,$J,358.3,3019,1,4,0)
 ;;=4^R64.
 ;;^UTILITY(U,$J,358.3,3019,2)
 ;;=^17920
 ;;^UTILITY(U,$J,358.3,3020,0)
 ;;=E86.0^^18^213^4
 ;;^UTILITY(U,$J,358.3,3020,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3020,1,3,0)
 ;;=3^Dehydration
 ;;^UTILITY(U,$J,358.3,3020,1,4,0)
 ;;=4^E86.0
 ;;^UTILITY(U,$J,358.3,3020,2)
 ;;=^332743
 ;;^UTILITY(U,$J,358.3,3021,0)
 ;;=Z86.31^^18^213^75
 ;;^UTILITY(U,$J,358.3,3021,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3021,1,3,0)
 ;;=3^Personal Hx of Diabetic Foot Ulcer
 ;;^UTILITY(U,$J,358.3,3021,1,4,0)
 ;;=4^Z86.31
 ;;^UTILITY(U,$J,358.3,3021,2)
 ;;=^5063467
 ;;^UTILITY(U,$J,358.3,3022,0)
 ;;=E10.8^^18^213^5
 ;;^UTILITY(U,$J,358.3,3022,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3022,1,3,0)
 ;;=3^Diabetes Type 1 w/ Unspec Complications
 ;;^UTILITY(U,$J,358.3,3022,1,4,0)
 ;;=4^E10.8
 ;;^UTILITY(U,$J,358.3,3022,2)
 ;;=^5002625
 ;;^UTILITY(U,$J,358.3,3023,0)
 ;;=E10.9^^18^213^6
 ;;^UTILITY(U,$J,358.3,3023,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3023,1,3,0)
 ;;=3^Diabetes Type 1 w/o Complications
 ;;^UTILITY(U,$J,358.3,3023,1,4,0)
 ;;=4^E10.9
 ;;^UTILITY(U,$J,358.3,3023,2)
 ;;=^5002626
 ;;^UTILITY(U,$J,358.3,3024,0)
 ;;=E11.40^^18^213^15
 ;;^UTILITY(U,$J,358.3,3024,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3024,1,3,0)
 ;;=3^Diabetes Type 2 w/ Diabetic Neuropathy,Unspec
 ;;^UTILITY(U,$J,358.3,3024,1,4,0)
 ;;=4^E11.40
 ;;^UTILITY(U,$J,358.3,3024,2)
 ;;=^5002644
 ;;^UTILITY(U,$J,358.3,3025,0)
 ;;=E11.620^^18^213^11
 ;;^UTILITY(U,$J,358.3,3025,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3025,1,3,0)
 ;;=3^Diabetes Type 2 w/ Diabetic Dermatitis
 ;;^UTILITY(U,$J,358.3,3025,1,4,0)
 ;;=4^E11.620
 ;;^UTILITY(U,$J,358.3,3025,2)
 ;;=^5002655
 ;;^UTILITY(U,$J,358.3,3026,0)
 ;;=E11.610^^18^213^14
 ;;^UTILITY(U,$J,358.3,3026,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3026,1,3,0)
 ;;=3^Diabetes Type 2 w/ Diabetic Neuropathic Arthropathy
 ;;^UTILITY(U,$J,358.3,3026,1,4,0)
 ;;=4^E11.610
 ;;^UTILITY(U,$J,358.3,3026,2)
 ;;=^5002653
 ;;^UTILITY(U,$J,358.3,3027,0)
 ;;=E11.52^^18^213^17
 ;;^UTILITY(U,$J,358.3,3027,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3027,1,3,0)
 ;;=3^Diabetes Type 2 w/ Diabetic Periph Angiopathy w/ Gangrene
 ;;^UTILITY(U,$J,358.3,3027,1,4,0)
 ;;=4^E11.52
 ;;^UTILITY(U,$J,358.3,3027,2)
 ;;=^5002651
 ;;^UTILITY(U,$J,358.3,3028,0)
 ;;=E11.51^^18^213^18
 ;;^UTILITY(U,$J,358.3,3028,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3028,1,3,0)
 ;;=3^Diabetes Type 2 w/ Diabetic Periph Angiopathy w/o Gangrene
 ;;^UTILITY(U,$J,358.3,3028,1,4,0)
 ;;=4^E11.51
 ;;^UTILITY(U,$J,358.3,3028,2)
 ;;=^5002650
 ;;^UTILITY(U,$J,358.3,3029,0)
 ;;=E11.621^^18^213^21
 ;;^UTILITY(U,$J,358.3,3029,1,0)
 ;;=^358.31IA^4^2
