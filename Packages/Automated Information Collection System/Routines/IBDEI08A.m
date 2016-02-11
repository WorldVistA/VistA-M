IBDEI08A ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,3318,1,4,0)
 ;;=4^E10.8
 ;;^UTILITY(U,$J,358.3,3318,2)
 ;;=^5002625
 ;;^UTILITY(U,$J,358.3,3319,0)
 ;;=E10.9^^28^252^6
 ;;^UTILITY(U,$J,358.3,3319,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3319,1,3,0)
 ;;=3^Diabetes Type 1 w/o Complications
 ;;^UTILITY(U,$J,358.3,3319,1,4,0)
 ;;=4^E10.9
 ;;^UTILITY(U,$J,358.3,3319,2)
 ;;=^5002626
 ;;^UTILITY(U,$J,358.3,3320,0)
 ;;=E11.40^^28^252^15
 ;;^UTILITY(U,$J,358.3,3320,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3320,1,3,0)
 ;;=3^Diabetes Type 2 w/ Diabetic Neuropathy,Unspec
 ;;^UTILITY(U,$J,358.3,3320,1,4,0)
 ;;=4^E11.40
 ;;^UTILITY(U,$J,358.3,3320,2)
 ;;=^5002644
 ;;^UTILITY(U,$J,358.3,3321,0)
 ;;=E11.620^^28^252^11
 ;;^UTILITY(U,$J,358.3,3321,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3321,1,3,0)
 ;;=3^Diabetes Type 2 w/ Diabetic Dermatitis
 ;;^UTILITY(U,$J,358.3,3321,1,4,0)
 ;;=4^E11.620
 ;;^UTILITY(U,$J,358.3,3321,2)
 ;;=^5002655
 ;;^UTILITY(U,$J,358.3,3322,0)
 ;;=E11.610^^28^252^14
 ;;^UTILITY(U,$J,358.3,3322,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3322,1,3,0)
 ;;=3^Diabetes Type 2 w/ Diabetic Neuropathic Arthropathy
 ;;^UTILITY(U,$J,358.3,3322,1,4,0)
 ;;=4^E11.610
 ;;^UTILITY(U,$J,358.3,3322,2)
 ;;=^5002653
 ;;^UTILITY(U,$J,358.3,3323,0)
 ;;=E11.52^^28^252^17
 ;;^UTILITY(U,$J,358.3,3323,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3323,1,3,0)
 ;;=3^Diabetes Type 2 w/ Diabetic Periph Angiopathy w/ Gangrene
 ;;^UTILITY(U,$J,358.3,3323,1,4,0)
 ;;=4^E11.52
 ;;^UTILITY(U,$J,358.3,3323,2)
 ;;=^5002651
 ;;^UTILITY(U,$J,358.3,3324,0)
 ;;=E11.51^^28^252^18
 ;;^UTILITY(U,$J,358.3,3324,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3324,1,3,0)
 ;;=3^Diabetes Type 2 w/ Diabetic Periph Angiopathy w/o Gangrene
 ;;^UTILITY(U,$J,358.3,3324,1,4,0)
 ;;=4^E11.51
 ;;^UTILITY(U,$J,358.3,3324,2)
 ;;=^5002650
 ;;^UTILITY(U,$J,358.3,3325,0)
 ;;=E11.621^^28^252^21
 ;;^UTILITY(U,$J,358.3,3325,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3325,1,3,0)
 ;;=3^Diabetes Type 2 w/ Foot Ulcer
 ;;^UTILITY(U,$J,358.3,3325,1,4,0)
 ;;=4^E11.621
 ;;^UTILITY(U,$J,358.3,3325,2)
 ;;=^5002656
 ;;^UTILITY(U,$J,358.3,3326,0)
 ;;=E11.44^^28^252^8
 ;;^UTILITY(U,$J,358.3,3326,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3326,1,3,0)
 ;;=3^Diabetes Type 2 w/ Diabetic Amyotrophy
 ;;^UTILITY(U,$J,358.3,3326,1,4,0)
 ;;=4^E11.44
 ;;^UTILITY(U,$J,358.3,3326,2)
 ;;=^5002648
 ;;^UTILITY(U,$J,358.3,3327,0)
 ;;=E11.59^^28^252^7
 ;;^UTILITY(U,$J,358.3,3327,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3327,1,3,0)
 ;;=3^Diabetes Type 2 w/ Circulatory Complications
 ;;^UTILITY(U,$J,358.3,3327,1,4,0)
 ;;=4^E11.59
 ;;^UTILITY(U,$J,358.3,3327,2)
 ;;=^5002652
 ;;^UTILITY(U,$J,358.3,3328,0)
 ;;=E11.638^^28^252^25
 ;;^UTILITY(U,$J,358.3,3328,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3328,1,3,0)
 ;;=3^Diabetes Type 2 w/ Oral Complications
 ;;^UTILITY(U,$J,358.3,3328,1,4,0)
 ;;=4^E11.638
 ;;^UTILITY(U,$J,358.3,3328,2)
 ;;=^5002660
 ;;^UTILITY(U,$J,358.3,3329,0)
 ;;=E11.628^^28^252^27
 ;;^UTILITY(U,$J,358.3,3329,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3329,1,3,0)
 ;;=3^Diabetes Type 2 w/ Skin Complications
 ;;^UTILITY(U,$J,358.3,3329,1,4,0)
 ;;=4^E11.628
 ;;^UTILITY(U,$J,358.3,3329,2)
 ;;=^5002658
 ;;^UTILITY(U,$J,358.3,3330,0)
 ;;=E11.630^^28^252^26
 ;;^UTILITY(U,$J,358.3,3330,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3330,1,3,0)
 ;;=3^Diabetes Type 2 w/ Periodontal Disease
 ;;^UTILITY(U,$J,358.3,3330,1,4,0)
 ;;=4^E11.630
 ;;^UTILITY(U,$J,358.3,3330,2)
 ;;=^5002659
 ;;^UTILITY(U,$J,358.3,3331,0)
 ;;=E11.8^^28^252^28
 ;;^UTILITY(U,$J,358.3,3331,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3331,1,3,0)
 ;;=3^Diabetes Type 2 w/ Unspec Complications
