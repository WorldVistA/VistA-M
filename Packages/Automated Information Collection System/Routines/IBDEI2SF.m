IBDEI2SF ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,44454,1,3,0)
 ;;=3^Suicide Attempt,Subsequent Encntr
 ;;^UTILITY(U,$J,358.3,44454,1,4,0)
 ;;=4^T14.91XD
 ;;^UTILITY(U,$J,358.3,44454,2)
 ;;=^5151780
 ;;^UTILITY(U,$J,358.3,44455,0)
 ;;=T14.91XS^^164^2205^5
 ;;^UTILITY(U,$J,358.3,44455,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,44455,1,3,0)
 ;;=3^Suicide Attempt,Sequela
 ;;^UTILITY(U,$J,358.3,44455,1,4,0)
 ;;=4^T14.91XS
 ;;^UTILITY(U,$J,358.3,44455,2)
 ;;=^5151781
 ;;^UTILITY(U,$J,358.3,44456,0)
 ;;=F19.14^^164^2206^1
 ;;^UTILITY(U,$J,358.3,44456,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,44456,1,3,0)
 ;;=3^Oth/Unk Substance Induced Dep D/O w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,44456,1,4,0)
 ;;=4^F19.14
 ;;^UTILITY(U,$J,358.3,44456,2)
 ;;=^5003421
 ;;^UTILITY(U,$J,358.3,44457,0)
 ;;=F19.24^^164^2206^2
 ;;^UTILITY(U,$J,358.3,44457,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,44457,1,3,0)
 ;;=3^Oth/Unk Substance Induced Dep D/O w/ Mod/Sev Use D/O
 ;;^UTILITY(U,$J,358.3,44457,1,4,0)
 ;;=4^F19.24
 ;;^UTILITY(U,$J,358.3,44457,2)
 ;;=^5003441
 ;;^UTILITY(U,$J,358.3,44458,0)
 ;;=F19.94^^164^2206^3
 ;;^UTILITY(U,$J,358.3,44458,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,44458,1,3,0)
 ;;=3^Oth/Unk Substance Induced Dep D/O w/o Use D/O
 ;;^UTILITY(U,$J,358.3,44458,1,4,0)
 ;;=4^F19.94
 ;;^UTILITY(U,$J,358.3,44458,2)
 ;;=^5003460
 ;;^UTILITY(U,$J,358.3,44459,0)
 ;;=F19.17^^164^2206^4
 ;;^UTILITY(U,$J,358.3,44459,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,44459,1,3,0)
 ;;=3^Oth/Unk Substance Induced Maj Neurocog D/O w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,44459,1,4,0)
 ;;=4^F19.17
 ;;^UTILITY(U,$J,358.3,44459,2)
 ;;=^5003426
 ;;^UTILITY(U,$J,358.3,44460,0)
 ;;=F19.27^^164^2206^5
 ;;^UTILITY(U,$J,358.3,44460,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,44460,1,3,0)
 ;;=3^Oth/Unk Substance Induced Maj Neurocog D/O w/ Mod/Sev Use D/O
 ;;^UTILITY(U,$J,358.3,44460,1,4,0)
 ;;=4^F19.27
 ;;^UTILITY(U,$J,358.3,44460,2)
 ;;=^5003446
 ;;^UTILITY(U,$J,358.3,44461,0)
 ;;=F19.97^^164^2206^6
 ;;^UTILITY(U,$J,358.3,44461,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,44461,1,3,0)
 ;;=3^Oth/Unk Substance Induced Maj Neurocog D/O w/o Use D/O
 ;;^UTILITY(U,$J,358.3,44461,1,4,0)
 ;;=4^F19.97
 ;;^UTILITY(U,$J,358.3,44461,2)
 ;;=^5003465
 ;;^UTILITY(U,$J,358.3,44462,0)
 ;;=F19.188^^164^2206^7
 ;;^UTILITY(U,$J,358.3,44462,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,44462,1,3,0)
 ;;=3^Oth/Unk Substance Induced Mild Neurocog D/O w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,44462,1,4,0)
 ;;=4^F19.188
 ;;^UTILITY(U,$J,358.3,44462,2)
 ;;=^5133361
 ;;^UTILITY(U,$J,358.3,44463,0)
 ;;=F19.288^^164^2206^8
 ;;^UTILITY(U,$J,358.3,44463,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,44463,1,3,0)
 ;;=3^Oth/Unk Substance Induced Mild Neurocog D/O w/ Mod/Sev Use D/O
 ;;^UTILITY(U,$J,358.3,44463,1,4,0)
 ;;=4^F19.288
 ;;^UTILITY(U,$J,358.3,44463,2)
 ;;=^5133362
 ;;^UTILITY(U,$J,358.3,44464,0)
 ;;=F19.988^^164^2206^9
 ;;^UTILITY(U,$J,358.3,44464,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,44464,1,3,0)
 ;;=3^Oth/Unk Substance Induced Mild Neurocog D/O w/o Use D/O
 ;;^UTILITY(U,$J,358.3,44464,1,4,0)
 ;;=4^F19.988
 ;;^UTILITY(U,$J,358.3,44464,2)
 ;;=^5133363
 ;;^UTILITY(U,$J,358.3,44465,0)
 ;;=F19.159^^164^2206^10
 ;;^UTILITY(U,$J,358.3,44465,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,44465,1,3,0)
 ;;=3^Oth/Unk Substance Induced Psychotic D/O w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,44465,1,4,0)
 ;;=4^F19.159
