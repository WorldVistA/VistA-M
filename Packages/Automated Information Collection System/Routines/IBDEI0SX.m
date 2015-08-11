IBDEI0SX ; ; 20-MAY-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,14260,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14260,1,2,0)
 ;;=2^Adrenal Bilat Selective
 ;;^UTILITY(U,$J,358.3,14260,1,4,0)
 ;;=4^75733
 ;;^UTILITY(U,$J,358.3,14261,0)
 ;;=75736^^86^880^25^^^^1
 ;;^UTILITY(U,$J,358.3,14261,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14261,1,2,0)
 ;;=2^Pelvic Selective
 ;;^UTILITY(U,$J,358.3,14261,1,4,0)
 ;;=4^75736
 ;;^UTILITY(U,$J,358.3,14262,0)
 ;;=75741^^86^880^30^^^^1
 ;;^UTILITY(U,$J,358.3,14262,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14262,1,2,0)
 ;;=2^Pulmonary Unilat Selective
 ;;^UTILITY(U,$J,358.3,14262,1,4,0)
 ;;=4^75741
 ;;^UTILITY(U,$J,358.3,14263,0)
 ;;=75743^^86^880^28^^^^1
 ;;^UTILITY(U,$J,358.3,14263,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14263,1,2,0)
 ;;=2^Pulmonary Bilat Selective
 ;;^UTILITY(U,$J,358.3,14263,1,4,0)
 ;;=4^75743
 ;;^UTILITY(U,$J,358.3,14264,0)
 ;;=75746^^86^880^29^^^^1
 ;;^UTILITY(U,$J,358.3,14264,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14264,1,2,0)
 ;;=2^Pulmonary By Nonselective
 ;;^UTILITY(U,$J,358.3,14264,1,4,0)
 ;;=4^75746
 ;;^UTILITY(U,$J,358.3,14265,0)
 ;;=75756^^86^880^21^^^^1
 ;;^UTILITY(U,$J,358.3,14265,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14265,1,2,0)
 ;;=2^Internal Mammary
 ;;^UTILITY(U,$J,358.3,14265,1,4,0)
 ;;=4^75756
 ;;^UTILITY(U,$J,358.3,14266,0)
 ;;=75774^^86^880^41^^^^1
 ;;^UTILITY(U,$J,358.3,14266,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14266,1,2,0)
 ;;=2^Selective Ea Addl Vessel w/ Above
 ;;^UTILITY(U,$J,358.3,14266,1,4,0)
 ;;=4^75774
 ;;^UTILITY(U,$J,358.3,14267,0)
 ;;=75791^^86^880^7^^^^1
 ;;^UTILITY(U,$J,358.3,14267,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14267,1,2,0)
 ;;=2^Arteriovenous Shunt
 ;;^UTILITY(U,$J,358.3,14267,1,4,0)
 ;;=4^75791
 ;;^UTILITY(U,$J,358.3,14268,0)
 ;;=75962^^86^880^59^^^^1
 ;;^UTILITY(U,$J,358.3,14268,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14268,1,2,0)
 ;;=2^Translum Ball Angioplasty,Peripheral Art
 ;;^UTILITY(U,$J,358.3,14268,1,4,0)
 ;;=4^75962
 ;;^UTILITY(U,$J,358.3,14269,0)
 ;;=75964^^86^880^10^^^^1
 ;;^UTILITY(U,$J,358.3,14269,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14269,1,2,0)
 ;;=2^Each Addl Artery (w/75962)
 ;;^UTILITY(U,$J,358.3,14269,1,4,0)
 ;;=4^75964
 ;;^UTILITY(U,$J,358.3,14270,0)
 ;;=76000^^86^880^9^^^^1
 ;;^UTILITY(U,$J,358.3,14270,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14270,1,2,0)
 ;;=2^Cardiac Fluoro<1 hr
 ;;^UTILITY(U,$J,358.3,14270,1,4,0)
 ;;=4^76000
 ;;^UTILITY(U,$J,358.3,14271,0)
 ;;=76506^^86^880^11^^^^1
 ;;^UTILITY(U,$J,358.3,14271,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14271,1,2,0)
 ;;=2^Echoencephalography,Real Time w/ Image
 ;;^UTILITY(U,$J,358.3,14271,1,4,0)
 ;;=4^76506
 ;;^UTILITY(U,$J,358.3,14272,0)
 ;;=37200^^86^880^57^^^^1
 ;;^UTILITY(U,$J,358.3,14272,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14272,1,2,0)
 ;;=2^Transcatheter Biopsy
 ;;^UTILITY(U,$J,358.3,14272,1,4,0)
 ;;=4^37200
 ;;^UTILITY(U,$J,358.3,14273,0)
 ;;=37236^^86^880^55^^^^1
 ;;^UTILITY(U,$J,358.3,14273,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14273,1,2,0)
 ;;=2^Transcath Plcmt Stent,Open/Perc,Init Art
 ;;^UTILITY(U,$J,358.3,14273,1,4,0)
 ;;=4^37236
 ;;^UTILITY(U,$J,358.3,14274,0)
 ;;=37237^^86^880^53^^^^1
 ;;^UTILITY(U,$J,358.3,14274,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14274,1,2,0)
 ;;=2^Transcath Plcmt Stent,Open/Perc,Ea Addl Art
 ;;^UTILITY(U,$J,358.3,14274,1,4,0)
 ;;=4^37237
 ;;^UTILITY(U,$J,358.3,14275,0)
 ;;=37238^^86^880^56^^^^1
 ;;^UTILITY(U,$J,358.3,14275,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14275,1,2,0)
 ;;=2^Transcath Plcmt Stent,Open/Perc,Init Vein
 ;;^UTILITY(U,$J,358.3,14275,1,4,0)
 ;;=4^37238
