IBDEI031 ; ; 09-FEB-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,3632,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3632,1,3,0)
 ;;=3^Acute cystitis w/ hematuria
 ;;^UTILITY(U,$J,358.3,3632,1,4,0)
 ;;=4^N30.01
 ;;^UTILITY(U,$J,358.3,3632,2)
 ;;=^5015633
 ;;^UTILITY(U,$J,358.3,3633,0)
 ;;=N30.10^^18^167^7
 ;;^UTILITY(U,$J,358.3,3633,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3633,1,3,0)
 ;;=3^Interstitial cystitis w/o hematuria
 ;;^UTILITY(U,$J,358.3,3633,1,4,0)
 ;;=4^N30.10
 ;;^UTILITY(U,$J,358.3,3633,2)
 ;;=^5015634
 ;;^UTILITY(U,$J,358.3,3634,0)
 ;;=N30.11^^18^167^6
 ;;^UTILITY(U,$J,358.3,3634,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3634,1,3,0)
 ;;=3^Interstitial cystitis w/ hematuria
 ;;^UTILITY(U,$J,358.3,3634,1,4,0)
 ;;=4^N30.11
 ;;^UTILITY(U,$J,358.3,3634,2)
 ;;=^5015635
 ;;^UTILITY(U,$J,358.3,3635,0)
 ;;=N30.40^^18^167^9
 ;;^UTILITY(U,$J,358.3,3635,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3635,1,3,0)
 ;;=3^Irradiation cystitis w/o hematuria
 ;;^UTILITY(U,$J,358.3,3635,1,4,0)
 ;;=4^N30.40
 ;;^UTILITY(U,$J,358.3,3635,2)
 ;;=^5015639
 ;;^UTILITY(U,$J,358.3,3636,0)
 ;;=N30.41^^18^167^8
 ;;^UTILITY(U,$J,358.3,3636,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3636,1,3,0)
 ;;=3^Irradiation cystitis w/ hematuria
 ;;^UTILITY(U,$J,358.3,3636,1,4,0)
 ;;=4^N30.41
 ;;^UTILITY(U,$J,358.3,3636,2)
 ;;=^5015640
 ;;^UTILITY(U,$J,358.3,3637,0)
 ;;=N32.0^^18^167^4
 ;;^UTILITY(U,$J,358.3,3637,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3637,1,3,0)
 ;;=3^Bladder-neck obstruction
 ;;^UTILITY(U,$J,358.3,3637,1,4,0)
 ;;=4^N32.0
 ;;^UTILITY(U,$J,358.3,3637,2)
 ;;=^5015649
 ;;^UTILITY(U,$J,358.3,3638,0)
 ;;=N31.9^^18^167^10
 ;;^UTILITY(U,$J,358.3,3638,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3638,1,3,0)
 ;;=3^Neuromuscular dysfunction of bladder, Unspec
 ;;^UTILITY(U,$J,358.3,3638,1,4,0)
 ;;=4^N31.9
 ;;^UTILITY(U,$J,358.3,3638,2)
 ;;=^5015648
 ;;^UTILITY(U,$J,358.3,3639,0)
 ;;=N31.0^^18^167^12
 ;;^UTILITY(U,$J,358.3,3639,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3639,1,3,0)
 ;;=3^Uninhibited neuropathic bladder, NEC
 ;;^UTILITY(U,$J,358.3,3639,1,4,0)
 ;;=4^N31.0
 ;;^UTILITY(U,$J,358.3,3639,2)
 ;;=^5015644
 ;;^UTILITY(U,$J,358.3,3640,0)
 ;;=N31.1^^18^167^11
 ;;^UTILITY(U,$J,358.3,3640,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3640,1,3,0)
 ;;=3^Reflex neuropathic bladder NEC
 ;;^UTILITY(U,$J,358.3,3640,1,4,0)
 ;;=4^N31.1
 ;;^UTILITY(U,$J,358.3,3640,2)
 ;;=^5015645
 ;;^UTILITY(U,$J,358.3,3641,0)
 ;;=D30.01^^18^168^4
 ;;^UTILITY(U,$J,358.3,3641,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3641,1,3,0)
 ;;=3^Benign neoplasm of right kidney
 ;;^UTILITY(U,$J,358.3,3641,1,4,0)
 ;;=4^D30.01
 ;;^UTILITY(U,$J,358.3,3641,2)
 ;;=^5002101
 ;;^UTILITY(U,$J,358.3,3642,0)
 ;;=D30.02^^18^168^1
 ;;^UTILITY(U,$J,358.3,3642,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3642,1,3,0)
 ;;=3^Benign neoplasm of left kidney
 ;;^UTILITY(U,$J,358.3,3642,1,4,0)
 ;;=4^D30.02
 ;;^UTILITY(U,$J,358.3,3642,2)
 ;;=^5002102
 ;;^UTILITY(U,$J,358.3,3643,0)
 ;;=D30.11^^18^168^5
 ;;^UTILITY(U,$J,358.3,3643,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3643,1,3,0)
 ;;=3^Benign neoplasm of right renal pelvis
 ;;^UTILITY(U,$J,358.3,3643,1,4,0)
 ;;=4^D30.11
 ;;^UTILITY(U,$J,358.3,3643,2)
 ;;=^5002104
 ;;^UTILITY(U,$J,358.3,3644,0)
 ;;=D30.12^^18^168^2
 ;;^UTILITY(U,$J,358.3,3644,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3644,1,3,0)
 ;;=3^Benign neoplasm of left renal pelvis
 ;;^UTILITY(U,$J,358.3,3644,1,4,0)
 ;;=4^D30.12
 ;;^UTILITY(U,$J,358.3,3644,2)
 ;;=^5002105
 ;;^UTILITY(U,$J,358.3,3645,0)
 ;;=D30.21^^18^168^6
 ;;^UTILITY(U,$J,358.3,3645,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3645,1,3,0)
 ;;=3^Benign neoplasm of right ureter
 ;;^UTILITY(U,$J,358.3,3645,1,4,0)
 ;;=4^D30.21
 ;;^UTILITY(U,$J,358.3,3645,2)
 ;;=^5002107
 ;;^UTILITY(U,$J,358.3,3646,0)
 ;;=D30.22^^18^168^3
 ;;^UTILITY(U,$J,358.3,3646,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3646,1,3,0)
 ;;=3^Benign neoplasm of left ureter
 ;;^UTILITY(U,$J,358.3,3646,1,4,0)
 ;;=4^D30.22
 ;;^UTILITY(U,$J,358.3,3646,2)
 ;;=^5002108
 ;;^UTILITY(U,$J,358.3,3647,0)
 ;;=N18.6^^18^169^7
 ;;^UTILITY(U,$J,358.3,3647,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3647,1,3,0)
 ;;=3^End stage renal disease
 ;;^UTILITY(U,$J,358.3,3647,1,4,0)
 ;;=4^N18.6
 ;;^UTILITY(U,$J,358.3,3647,2)
 ;;=^303986
 ;;^UTILITY(U,$J,358.3,3648,0)
 ;;=N18.9^^18^169^4
 ;;^UTILITY(U,$J,358.3,3648,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3648,1,3,0)
 ;;=3^Chronic kidney disease Unspec
 ;;^UTILITY(U,$J,358.3,3648,1,4,0)
 ;;=4^N18.9
 ;;^UTILITY(U,$J,358.3,3648,2)
 ;;=^332812
 ;;^UTILITY(U,$J,358.3,3649,0)
 ;;=N13.30^^18^169^10
 ;;^UTILITY(U,$J,358.3,3649,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3649,1,3,0)
 ;;=3^Hydronephrosis,Unspec
 ;;^UTILITY(U,$J,358.3,3649,1,4,0)
 ;;=4^N13.30
 ;;^UTILITY(U,$J,358.3,3649,2)
 ;;=^5015578
 ;;^UTILITY(U,$J,358.3,3650,0)
 ;;=N13.2^^18^169^8
 ;;^UTILITY(U,$J,358.3,3650,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3650,1,3,0)
 ;;=3^Hydronephrosis w/ Renal & Ureteral Calculous Obstruction
 ;;^UTILITY(U,$J,358.3,3650,1,4,0)
 ;;=4^N13.2
 ;;^UTILITY(U,$J,358.3,3650,2)
 ;;=^5015577
 ;;^UTILITY(U,$J,358.3,3651,0)
 ;;=N13.39^^18^169^9
 ;;^UTILITY(U,$J,358.3,3651,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3651,1,3,0)
 ;;=3^Hydronephrosis,Other
 ;;^UTILITY(U,$J,358.3,3651,1,4,0)
 ;;=4^N13.39
 ;;^UTILITY(U,$J,358.3,3651,2)
 ;;=^5015579
 ;;^UTILITY(U,$J,358.3,3652,0)
 ;;=N20.0^^18^169^1
 ;;^UTILITY(U,$J,358.3,3652,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3652,1,3,0)
 ;;=3^Calculus of kidney
 ;;^UTILITY(U,$J,358.3,3652,1,4,0)
 ;;=4^N20.0
 ;;^UTILITY(U,$J,358.3,3652,2)
 ;;=^67056
 ;;^UTILITY(U,$J,358.3,3653,0)
 ;;=N20.2^^18^169^2
 ;;^UTILITY(U,$J,358.3,3653,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3653,1,3,0)
 ;;=3^Calculus of kidney w/ calculus of ureter
 ;;^UTILITY(U,$J,358.3,3653,1,4,0)
 ;;=4^N20.2
 ;;^UTILITY(U,$J,358.3,3653,2)
 ;;=^5015609
 ;;^UTILITY(U,$J,358.3,3654,0)
 ;;=N20.1^^18^169^3
 ;;^UTILITY(U,$J,358.3,3654,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3654,1,3,0)
 ;;=3^Calculus of ureter
 ;;^UTILITY(U,$J,358.3,3654,1,4,0)
 ;;=4^N20.1
 ;;^UTILITY(U,$J,358.3,3654,2)
 ;;=^5015608
 ;;^UTILITY(U,$J,358.3,3655,0)
 ;;=N28.1^^18^169^5
 ;;^UTILITY(U,$J,358.3,3655,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3655,1,3,0)
 ;;=3^Cyst of kidney, acquired
 ;;^UTILITY(U,$J,358.3,3655,1,4,0)
 ;;=4^N28.1
 ;;^UTILITY(U,$J,358.3,3655,2)
 ;;=^270380
 ;;^UTILITY(U,$J,358.3,3656,0)
 ;;=R30.0^^18^169^6
 ;;^UTILITY(U,$J,358.3,3656,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3656,1,3,0)
 ;;=3^Dysuria
 ;;^UTILITY(U,$J,358.3,3656,1,4,0)
 ;;=4^R30.0
 ;;^UTILITY(U,$J,358.3,3656,2)
 ;;=^5019322
 ;;^UTILITY(U,$J,358.3,3657,0)
 ;;=R30.9^^18^169^13
 ;;^UTILITY(U,$J,358.3,3657,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3657,1,3,0)
 ;;=3^Painful micturition, Unspec
 ;;^UTILITY(U,$J,358.3,3657,1,4,0)
 ;;=4^R30.9
 ;;^UTILITY(U,$J,358.3,3657,2)
 ;;=^5019324
 ;;^UTILITY(U,$J,358.3,3658,0)
 ;;=S37.001A^^18^169^12
 ;;^UTILITY(U,$J,358.3,3658,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3658,1,3,0)
 ;;=3^Injury Right Kidney,Init Encntr,Unspec
 ;;^UTILITY(U,$J,358.3,3658,1,4,0)
 ;;=4^S37.001A
 ;;^UTILITY(U,$J,358.3,3658,2)
 ;;=^5025817
 ;;^UTILITY(U,$J,358.3,3659,0)
 ;;=S37.002A^^18^169^11
 ;;^UTILITY(U,$J,358.3,3659,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3659,1,3,0)
 ;;=3^Injury Left Kidney,Init Encntr,Unspec
 ;;^UTILITY(U,$J,358.3,3659,1,4,0)
 ;;=4^S37.002A
 ;;^UTILITY(U,$J,358.3,3659,2)
 ;;=^5025820
 ;;^UTILITY(U,$J,358.3,3660,0)
 ;;=C61.^^18^170^12
 ;;^UTILITY(U,$J,358.3,3660,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3660,1,3,0)
 ;;=3^Malig Neop of prostate
 ;;^UTILITY(U,$J,358.3,3660,1,4,0)
 ;;=4^C61.
 ;;^UTILITY(U,$J,358.3,3660,2)
 ;;=^267239
 ;;^UTILITY(U,$J,358.3,3661,0)
 ;;=C62.12^^18^170^2
 ;;^UTILITY(U,$J,358.3,3661,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3661,1,3,0)
 ;;=3^Malig Neop of descended left testis
 ;;^UTILITY(U,$J,358.3,3661,1,4,0)
 ;;=4^C62.12
 ;;^UTILITY(U,$J,358.3,3661,2)
 ;;=^5001235
 ;;^UTILITY(U,$J,358.3,3662,0)
 ;;=C62.11^^18^170^3
 ;;^UTILITY(U,$J,358.3,3662,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3662,1,3,0)
 ;;=3^Malig Neop of descended right testis
 ;;^UTILITY(U,$J,358.3,3662,1,4,0)
 ;;=4^C62.11
 ;;^UTILITY(U,$J,358.3,3662,2)
 ;;=^5001234
 ;;^UTILITY(U,$J,358.3,3663,0)
 ;;=C62.91^^18^170^17
 ;;^UTILITY(U,$J,358.3,3663,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3663,1,3,0)
 ;;=3^Malig Neop of right testis, unsp descended or undescended
 ;;^UTILITY(U,$J,358.3,3663,1,4,0)
 ;;=4^C62.91
 ;;^UTILITY(U,$J,358.3,3663,2)
 ;;=^5001237
 ;;^UTILITY(U,$J,358.3,3664,0)
 ;;=C62.92^^18^170^9
 ;;^UTILITY(U,$J,358.3,3664,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3664,1,3,0)
 ;;=3^Malig Neop of left testis, unsp descended or undescended
 ;;^UTILITY(U,$J,358.3,3664,1,4,0)
 ;;=4^C62.92
 ;;^UTILITY(U,$J,358.3,3664,2)
 ;;=^5001238
 ;;^UTILITY(U,$J,358.3,3665,0)
 ;;=C60.0^^18^170^11
 ;;^UTILITY(U,$J,358.3,3665,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3665,1,3,0)
 ;;=3^Malig Neop of prepuce
 ;;^UTILITY(U,$J,358.3,3665,1,4,0)
 ;;=4^C60.0
 ;;^UTILITY(U,$J,358.3,3665,2)
 ;;=^267244
 ;;^UTILITY(U,$J,358.3,3666,0)
 ;;=C60.1^^18^170^4
 ;;^UTILITY(U,$J,358.3,3666,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3666,1,3,0)
 ;;=3^Malig Neop of glans penis
 ;;^UTILITY(U,$J,358.3,3666,1,4,0)
 ;;=4^C60.1
 ;;^UTILITY(U,$J,358.3,3666,2)
 ;;=^267245
 ;;^UTILITY(U,$J,358.3,3667,0)
 ;;=C60.2^^18^170^1
 ;;^UTILITY(U,$J,358.3,3667,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3667,1,3,0)
 ;;=3^Malig Neop of body of penis
 ;;^UTILITY(U,$J,358.3,3667,1,4,0)
 ;;=4^C60.2
 ;;^UTILITY(U,$J,358.3,3667,2)
 ;;=^267246
 ;;^UTILITY(U,$J,358.3,3668,0)
 ;;=C63.01^^18^170^13
 ;;^UTILITY(U,$J,358.3,3668,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3668,1,3,0)
 ;;=3^Malig Neop of right epididymis
 ;;^UTILITY(U,$J,358.3,3668,1,4,0)
 ;;=4^C63.01
