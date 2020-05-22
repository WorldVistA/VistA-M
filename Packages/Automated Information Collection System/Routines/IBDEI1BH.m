IBDEI1BH ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,21052,1,3,0)
 ;;=3^Cannabis Intoxication w/o Perceptual Disturbances w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,21052,1,4,0)
 ;;=4^F12.229
 ;;^UTILITY(U,$J,358.3,21052,2)
 ;;=^5003171
 ;;^UTILITY(U,$J,358.3,21053,0)
 ;;=F12.122^^95^1044^15
 ;;^UTILITY(U,$J,358.3,21053,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21053,1,3,0)
 ;;=3^Cannabis Intoxication w/ Perceptual Disturbances w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,21053,1,4,0)
 ;;=4^F12.122
 ;;^UTILITY(U,$J,358.3,21053,2)
 ;;=^5003158
 ;;^UTILITY(U,$J,358.3,21054,0)
 ;;=F12.222^^95^1044^16
 ;;^UTILITY(U,$J,358.3,21054,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21054,1,3,0)
 ;;=3^Cannabis Intoxication w/ Perceptual Disturbances w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,21054,1,4,0)
 ;;=4^F12.222
 ;;^UTILITY(U,$J,358.3,21054,2)
 ;;=^5003170
 ;;^UTILITY(U,$J,358.3,21055,0)
 ;;=F12.922^^95^1044^17
 ;;^UTILITY(U,$J,358.3,21055,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21055,1,3,0)
 ;;=3^Cannabis Intoxication w/ Perceptual Disturbances w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,21055,1,4,0)
 ;;=4^F12.922
 ;;^UTILITY(U,$J,358.3,21055,2)
 ;;=^5003181
 ;;^UTILITY(U,$J,358.3,21056,0)
 ;;=F12.980^^95^1044^6
 ;;^UTILITY(U,$J,358.3,21056,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21056,1,3,0)
 ;;=3^Cannabis Induced Anxiety Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,21056,1,4,0)
 ;;=4^F12.980
 ;;^UTILITY(U,$J,358.3,21056,2)
 ;;=^5003186
 ;;^UTILITY(U,$J,358.3,21057,0)
 ;;=F12.159^^95^1044^7
 ;;^UTILITY(U,$J,358.3,21057,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21057,1,3,0)
 ;;=3^Cannabis Induced Psychotic Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,21057,1,4,0)
 ;;=4^F12.159
 ;;^UTILITY(U,$J,358.3,21057,2)
 ;;=^5003162
 ;;^UTILITY(U,$J,358.3,21058,0)
 ;;=F12.259^^95^1044^8
 ;;^UTILITY(U,$J,358.3,21058,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21058,1,3,0)
 ;;=3^Cannabis Induced Psychotic Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,21058,1,4,0)
 ;;=4^F12.259
 ;;^UTILITY(U,$J,358.3,21058,2)
 ;;=^5003174
 ;;^UTILITY(U,$J,358.3,21059,0)
 ;;=F12.959^^95^1044^9
 ;;^UTILITY(U,$J,358.3,21059,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21059,1,3,0)
 ;;=3^Cannabis Induced Psychotic Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,21059,1,4,0)
 ;;=4^F12.959
 ;;^UTILITY(U,$J,358.3,21059,2)
 ;;=^5003185
 ;;^UTILITY(U,$J,358.3,21060,0)
 ;;=F12.988^^95^1044^11
 ;;^UTILITY(U,$J,358.3,21060,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21060,1,3,0)
 ;;=3^Cannabis Induced Sleep Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,21060,1,4,0)
 ;;=4^F12.988
 ;;^UTILITY(U,$J,358.3,21060,2)
 ;;=^5003187
 ;;^UTILITY(U,$J,358.3,21061,0)
 ;;=F12.929^^95^1044^19
 ;;^UTILITY(U,$J,358.3,21061,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21061,1,3,0)
 ;;=3^Cannabis Intoxication w/o Perceptual Disturbances w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,21061,1,4,0)
 ;;=4^F12.929
 ;;^UTILITY(U,$J,358.3,21061,2)
 ;;=^5003182
 ;;^UTILITY(U,$J,358.3,21062,0)
 ;;=F12.180^^95^1044^4
 ;;^UTILITY(U,$J,358.3,21062,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21062,1,3,0)
 ;;=3^Cannabis Induced Anxiety Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,21062,1,4,0)
 ;;=4^F12.180
 ;;^UTILITY(U,$J,358.3,21062,2)
 ;;=^5003163
 ;;^UTILITY(U,$J,358.3,21063,0)
 ;;=F12.280^^95^1044^5
 ;;^UTILITY(U,$J,358.3,21063,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21063,1,3,0)
 ;;=3^Cannabis Induced Anxiety Disorder w/ Moderate/Severe Use Disorder
