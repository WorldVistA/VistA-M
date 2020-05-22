IBDEI1BE ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,21017,1,4,0)
 ;;=4^F10.280
 ;;^UTILITY(U,$J,358.3,21017,2)
 ;;=^5003096
 ;;^UTILITY(U,$J,358.3,21018,0)
 ;;=F10.980^^95^1043^7
 ;;^UTILITY(U,$J,358.3,21018,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21018,1,3,0)
 ;;=3^Alcohol Induced Anxiety D/O w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,21018,1,4,0)
 ;;=4^F10.980
 ;;^UTILITY(U,$J,358.3,21018,2)
 ;;=^5003110
 ;;^UTILITY(U,$J,358.3,21019,0)
 ;;=F10.26^^95^1043^8
 ;;^UTILITY(U,$J,358.3,21019,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21019,1,3,0)
 ;;=3^Alcohol Induced Maj Neurocog D/O,Amnestic Cofabul Type w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,21019,1,4,0)
 ;;=4^F10.26
 ;;^UTILITY(U,$J,358.3,21019,2)
 ;;=^5003094
 ;;^UTILITY(U,$J,358.3,21020,0)
 ;;=F10.96^^95^1043^9
 ;;^UTILITY(U,$J,358.3,21020,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21020,1,3,0)
 ;;=3^Alcohol Induced Maj Neurocog D/O,Amnestic Cofabul Type w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,21020,1,4,0)
 ;;=4^F10.96
 ;;^UTILITY(U,$J,358.3,21020,2)
 ;;=^5003108
 ;;^UTILITY(U,$J,358.3,21021,0)
 ;;=F10.27^^95^1043^10
 ;;^UTILITY(U,$J,358.3,21021,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21021,1,3,0)
 ;;=3^Alcohol Induced Maj Neurocog D/O,Nonamnestic Confabul Type,w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,21021,1,4,0)
 ;;=4^F10.27
 ;;^UTILITY(U,$J,358.3,21021,2)
 ;;=^5003095
 ;;^UTILITY(U,$J,358.3,21022,0)
 ;;=F10.97^^95^1043^11
 ;;^UTILITY(U,$J,358.3,21022,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21022,1,3,0)
 ;;=3^Alcohol Induced Maj Neurocog D/O,Nonamnestic Confabul Type w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,21022,1,4,0)
 ;;=4^F10.97
 ;;^UTILITY(U,$J,358.3,21022,2)
 ;;=^5003109
 ;;^UTILITY(U,$J,358.3,21023,0)
 ;;=F10.288^^95^1043^12
 ;;^UTILITY(U,$J,358.3,21023,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21023,1,3,0)
 ;;=3^Alcohol Induced Mild Neurocog D/O w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,21023,1,4,0)
 ;;=4^F10.288
 ;;^UTILITY(U,$J,358.3,21023,2)
 ;;=^5003099
 ;;^UTILITY(U,$J,358.3,21024,0)
 ;;=F10.988^^95^1043^13
 ;;^UTILITY(U,$J,358.3,21024,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21024,1,3,0)
 ;;=3^Alcohol Induced Mild Neurocog D/O w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,21024,1,4,0)
 ;;=4^F10.988
 ;;^UTILITY(U,$J,358.3,21024,2)
 ;;=^5003113
 ;;^UTILITY(U,$J,358.3,21025,0)
 ;;=F10.159^^95^1043^14
 ;;^UTILITY(U,$J,358.3,21025,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21025,1,3,0)
 ;;=3^Alcohol Induced Psychotic D/O w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,21025,1,4,0)
 ;;=4^F10.159
 ;;^UTILITY(U,$J,358.3,21025,2)
 ;;=^5003075
 ;;^UTILITY(U,$J,358.3,21026,0)
 ;;=F10.259^^95^1043^15
 ;;^UTILITY(U,$J,358.3,21026,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21026,1,3,0)
 ;;=3^Alcohol Induced Psychotic D/O w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,21026,1,4,0)
 ;;=4^F10.259
 ;;^UTILITY(U,$J,358.3,21026,2)
 ;;=^5003093
 ;;^UTILITY(U,$J,358.3,21027,0)
 ;;=F10.959^^95^1043^16
 ;;^UTILITY(U,$J,358.3,21027,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21027,1,3,0)
 ;;=3^Alcohol Induced Psychotic D/O w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,21027,1,4,0)
 ;;=4^F10.959
 ;;^UTILITY(U,$J,358.3,21027,2)
 ;;=^5003107
 ;;^UTILITY(U,$J,358.3,21028,0)
 ;;=F10.181^^95^1043^17
 ;;^UTILITY(U,$J,358.3,21028,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21028,1,3,0)
 ;;=3^Alcohol Induced Sexual Dysfunction w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,21028,1,4,0)
 ;;=4^F10.181
