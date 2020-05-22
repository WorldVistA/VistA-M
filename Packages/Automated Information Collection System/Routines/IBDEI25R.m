IBDEI25R ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,34462,1,4,0)
 ;;=4^F11.21
 ;;^UTILITY(U,$J,358.3,34462,2)
 ;;=^5003128
 ;;^UTILITY(U,$J,358.3,34463,0)
 ;;=Z79.891^^134^1747^1
 ;;^UTILITY(U,$J,358.3,34463,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34463,1,3,0)
 ;;=3^Long Term Opiate/Opioid Analgesic Use
 ;;^UTILITY(U,$J,358.3,34463,1,4,0)
 ;;=4^Z79.891
 ;;^UTILITY(U,$J,358.3,34463,2)
 ;;=^5063342
 ;;^UTILITY(U,$J,358.3,34464,0)
 ;;=F11.11^^134^1747^24
 ;;^UTILITY(U,$J,358.3,34464,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34464,1,3,0)
 ;;=3^Opioid Use DO,Mild,In Remiss
 ;;^UTILITY(U,$J,358.3,34464,1,4,0)
 ;;=4^F11.11
 ;;^UTILITY(U,$J,358.3,34464,2)
 ;;=^268246
 ;;^UTILITY(U,$J,358.3,34465,0)
 ;;=F13.180^^134^1748^1
 ;;^UTILITY(U,$J,358.3,34465,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34465,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Anxiety D/O w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,34465,1,4,0)
 ;;=4^F13.180
 ;;^UTILITY(U,$J,358.3,34465,2)
 ;;=^5003197
 ;;^UTILITY(U,$J,358.3,34466,0)
 ;;=F13.280^^134^1748^2
 ;;^UTILITY(U,$J,358.3,34466,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34466,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Anxiety D/O w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,34466,1,4,0)
 ;;=4^F13.280
 ;;^UTILITY(U,$J,358.3,34466,2)
 ;;=^5003216
 ;;^UTILITY(U,$J,358.3,34467,0)
 ;;=F13.980^^134^1748^3
 ;;^UTILITY(U,$J,358.3,34467,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34467,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Anxiety D/O w/o Use D/O
 ;;^UTILITY(U,$J,358.3,34467,1,4,0)
 ;;=4^F13.980
 ;;^UTILITY(U,$J,358.3,34467,2)
 ;;=^5003235
 ;;^UTILITY(U,$J,358.3,34468,0)
 ;;=F13.14^^134^1748^4
 ;;^UTILITY(U,$J,358.3,34468,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34468,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Bipolar & Rel D/O w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,34468,1,4,0)
 ;;=4^F13.14
 ;;^UTILITY(U,$J,358.3,34468,2)
 ;;=^5003193
 ;;^UTILITY(U,$J,358.3,34469,0)
 ;;=F13.24^^134^1748^5
 ;;^UTILITY(U,$J,358.3,34469,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34469,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Bipolar & Rel D/O w/ Mod-Sev Use D/O 
 ;;^UTILITY(U,$J,358.3,34469,1,4,0)
 ;;=4^F13.24
 ;;^UTILITY(U,$J,358.3,34469,2)
 ;;=^5003210
 ;;^UTILITY(U,$J,358.3,34470,0)
 ;;=F13.94^^134^1748^6
 ;;^UTILITY(U,$J,358.3,34470,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34470,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Bipolar & Rel D/O w/o Use D/O
 ;;^UTILITY(U,$J,358.3,34470,1,4,0)
 ;;=4^F13.94
 ;;^UTILITY(U,$J,358.3,34470,2)
 ;;=^5003229
 ;;^UTILITY(U,$J,358.3,34471,0)
 ;;=F13.921^^134^1748^7
 ;;^UTILITY(U,$J,358.3,34471,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34471,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Delirium
 ;;^UTILITY(U,$J,358.3,34471,1,4,0)
 ;;=4^F13.921
 ;;^UTILITY(U,$J,358.3,34471,2)
 ;;=^5003223
 ;;^UTILITY(U,$J,358.3,34472,0)
 ;;=F13.27^^134^1748^8
 ;;^UTILITY(U,$J,358.3,34472,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34472,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Maj Neurocog D/O w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,34472,1,4,0)
 ;;=4^F13.27
 ;;^UTILITY(U,$J,358.3,34472,2)
 ;;=^5003215
 ;;^UTILITY(U,$J,358.3,34473,0)
 ;;=F13.97^^134^1748^9
 ;;^UTILITY(U,$J,358.3,34473,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34473,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Induced Maj Neurocog D/O w/o Use D/O
 ;;^UTILITY(U,$J,358.3,34473,1,4,0)
 ;;=4^F13.97
