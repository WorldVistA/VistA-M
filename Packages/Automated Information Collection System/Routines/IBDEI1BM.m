IBDEI1BM ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,21110,1,3,0)
 ;;=3^Opioid Intoxication w/ Perceptual Disturbance w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,21110,1,4,0)
 ;;=4^F11.222
 ;;^UTILITY(U,$J,358.3,21110,2)
 ;;=^5003131
 ;;^UTILITY(U,$J,358.3,21111,0)
 ;;=F11.922^^95^1046^20
 ;;^UTILITY(U,$J,358.3,21111,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21111,1,3,0)
 ;;=3^Opioid Intoxication w/ Perceptual Disturbance w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,21111,1,4,0)
 ;;=4^F11.922
 ;;^UTILITY(U,$J,358.3,21111,2)
 ;;=^5003145
 ;;^UTILITY(U,$J,358.3,21112,0)
 ;;=F11.99^^95^1046^24
 ;;^UTILITY(U,$J,358.3,21112,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21112,1,3,0)
 ;;=3^Opioid Related Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,21112,1,4,0)
 ;;=4^F11.99
 ;;^UTILITY(U,$J,358.3,21112,2)
 ;;=^5133352
 ;;^UTILITY(U,$J,358.3,21113,0)
 ;;=F11.11^^95^1046^1
 ;;^UTILITY(U,$J,358.3,21113,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21113,1,3,0)
 ;;=3^Opioid Abuse,In Remission
 ;;^UTILITY(U,$J,358.3,21113,1,4,0)
 ;;=4^F11.11
 ;;^UTILITY(U,$J,358.3,21113,2)
 ;;=^268246
 ;;^UTILITY(U,$J,358.3,21114,0)
 ;;=F13.180^^95^1047^5
 ;;^UTILITY(U,$J,358.3,21114,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21114,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Anxiety D/O w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,21114,1,4,0)
 ;;=4^F13.180
 ;;^UTILITY(U,$J,358.3,21114,2)
 ;;=^5003197
 ;;^UTILITY(U,$J,358.3,21115,0)
 ;;=F13.280^^95^1047^6
 ;;^UTILITY(U,$J,358.3,21115,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21115,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Anxiety D/O w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,21115,1,4,0)
 ;;=4^F13.280
 ;;^UTILITY(U,$J,358.3,21115,2)
 ;;=^5003216
 ;;^UTILITY(U,$J,358.3,21116,0)
 ;;=F13.980^^95^1047^7
 ;;^UTILITY(U,$J,358.3,21116,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21116,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Anxiety D/O w/o Use D/O
 ;;^UTILITY(U,$J,358.3,21116,1,4,0)
 ;;=4^F13.980
 ;;^UTILITY(U,$J,358.3,21116,2)
 ;;=^5003235
 ;;^UTILITY(U,$J,358.3,21117,0)
 ;;=F13.14^^95^1047^1
 ;;^UTILITY(U,$J,358.3,21117,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21117,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Abuse w/ Induced Mood Disorder
 ;;^UTILITY(U,$J,358.3,21117,1,4,0)
 ;;=4^F13.14
 ;;^UTILITY(U,$J,358.3,21117,2)
 ;;=^5003193
 ;;^UTILITY(U,$J,358.3,21118,0)
 ;;=F13.24^^95^1047^3
 ;;^UTILITY(U,$J,358.3,21118,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21118,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Dependence w/ Induced Mood Disorder
 ;;^UTILITY(U,$J,358.3,21118,1,4,0)
 ;;=4^F13.24
 ;;^UTILITY(U,$J,358.3,21118,2)
 ;;=^5003210
 ;;^UTILITY(U,$J,358.3,21119,0)
 ;;=F13.94^^95^1047^28
 ;;^UTILITY(U,$J,358.3,21119,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21119,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Use w/ Induced Mood Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,21119,1,4,0)
 ;;=4^F13.94
 ;;^UTILITY(U,$J,358.3,21119,2)
 ;;=^5003229
 ;;^UTILITY(U,$J,358.3,21120,0)
 ;;=F13.921^^95^1047^29
 ;;^UTILITY(U,$J,358.3,21120,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21120,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Use w/ Intoxication Delirium
 ;;^UTILITY(U,$J,358.3,21120,1,4,0)
 ;;=4^F13.921
 ;;^UTILITY(U,$J,358.3,21120,2)
 ;;=^5003223
 ;;^UTILITY(U,$J,358.3,21121,0)
 ;;=F13.27^^95^1047^8
 ;;^UTILITY(U,$J,358.3,21121,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21121,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Maj Neurocog D/O w/ Mod-Sev Use D/O
