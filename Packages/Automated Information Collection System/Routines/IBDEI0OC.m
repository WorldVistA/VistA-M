IBDEI0OC ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,10943,1,4,0)
 ;;=4^F11.222
 ;;^UTILITY(U,$J,358.3,10943,2)
 ;;=^5003131
 ;;^UTILITY(U,$J,358.3,10944,0)
 ;;=F11.922^^42^494^20
 ;;^UTILITY(U,$J,358.3,10944,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10944,1,3,0)
 ;;=3^Opioid Intoxication w/ Perceptual Disturbance w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,10944,1,4,0)
 ;;=4^F11.922
 ;;^UTILITY(U,$J,358.3,10944,2)
 ;;=^5003145
 ;;^UTILITY(U,$J,358.3,10945,0)
 ;;=F11.99^^42^494^24
 ;;^UTILITY(U,$J,358.3,10945,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10945,1,3,0)
 ;;=3^Opioid Related Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,10945,1,4,0)
 ;;=4^F11.99
 ;;^UTILITY(U,$J,358.3,10945,2)
 ;;=^5133352
 ;;^UTILITY(U,$J,358.3,10946,0)
 ;;=F11.11^^42^494^1
 ;;^UTILITY(U,$J,358.3,10946,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10946,1,3,0)
 ;;=3^Opioid Abuse,In Remission
 ;;^UTILITY(U,$J,358.3,10946,1,4,0)
 ;;=4^F11.11
 ;;^UTILITY(U,$J,358.3,10946,2)
 ;;=^268246
 ;;^UTILITY(U,$J,358.3,10947,0)
 ;;=F13.180^^42^495^5
 ;;^UTILITY(U,$J,358.3,10947,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10947,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Anxiety D/O w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,10947,1,4,0)
 ;;=4^F13.180
 ;;^UTILITY(U,$J,358.3,10947,2)
 ;;=^5003197
 ;;^UTILITY(U,$J,358.3,10948,0)
 ;;=F13.280^^42^495^6
 ;;^UTILITY(U,$J,358.3,10948,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10948,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Anxiety D/O w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,10948,1,4,0)
 ;;=4^F13.280
 ;;^UTILITY(U,$J,358.3,10948,2)
 ;;=^5003216
 ;;^UTILITY(U,$J,358.3,10949,0)
 ;;=F13.980^^42^495^7
 ;;^UTILITY(U,$J,358.3,10949,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10949,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Anxiety D/O w/o Use D/O
 ;;^UTILITY(U,$J,358.3,10949,1,4,0)
 ;;=4^F13.980
 ;;^UTILITY(U,$J,358.3,10949,2)
 ;;=^5003235
 ;;^UTILITY(U,$J,358.3,10950,0)
 ;;=F13.14^^42^495^1
 ;;^UTILITY(U,$J,358.3,10950,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10950,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Abuse w/ Induced Mood Disorder
 ;;^UTILITY(U,$J,358.3,10950,1,4,0)
 ;;=4^F13.14
 ;;^UTILITY(U,$J,358.3,10950,2)
 ;;=^5003193
 ;;^UTILITY(U,$J,358.3,10951,0)
 ;;=F13.24^^42^495^3
 ;;^UTILITY(U,$J,358.3,10951,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10951,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Dependence w/ Induced Mood Disorder
 ;;^UTILITY(U,$J,358.3,10951,1,4,0)
 ;;=4^F13.24
 ;;^UTILITY(U,$J,358.3,10951,2)
 ;;=^5003210
 ;;^UTILITY(U,$J,358.3,10952,0)
 ;;=F13.94^^42^495^28
 ;;^UTILITY(U,$J,358.3,10952,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10952,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Use w/ Induced Mood Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,10952,1,4,0)
 ;;=4^F13.94
 ;;^UTILITY(U,$J,358.3,10952,2)
 ;;=^5003229
 ;;^UTILITY(U,$J,358.3,10953,0)
 ;;=F13.921^^42^495^29
 ;;^UTILITY(U,$J,358.3,10953,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10953,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Use w/ Intoxication Delirium
 ;;^UTILITY(U,$J,358.3,10953,1,4,0)
 ;;=4^F13.921
 ;;^UTILITY(U,$J,358.3,10953,2)
 ;;=^5003223
 ;;^UTILITY(U,$J,358.3,10954,0)
 ;;=F13.27^^42^495^8
 ;;^UTILITY(U,$J,358.3,10954,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10954,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Maj Neurocog D/O w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,10954,1,4,0)
 ;;=4^F13.27
 ;;^UTILITY(U,$J,358.3,10954,2)
 ;;=^5003215
