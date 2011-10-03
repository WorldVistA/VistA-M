LAH717H ;SLC/DLG - HITACHI 717 WITH JT-717 PROTOCOL CONTROLLER ;7/20/90  09:10 ;
 ;;5.2;AUTOMATED LAB INSTRUMENTS;;Sep 27, 1994
 ;;
 ;Call with T set to Instrument data is to/from
RCHK S CTRL=$P(IN,"~",2),IN=$P(IN,"~",1) G:CTRL]"" @CTRL
 Q
B ;
D ;
F Q
C ;
W I "CEKN"'[$E(IN,3) S OUT=$C(4),T=T-BASE Q
 S FTN=$E(IN,1,2) I FTN'=51,FTN'=55 Q
 S C=^LA(T,"C",0)+2 I '$D(^(C-1))#2 S OUT=$C(4),T=T-BASE Q
 S ^LA(T,"C",0)=C,OUT=$C(2)_FTN_^LA(T,"C",C-1)_$C(23)
 S LRECORD=$C(2)_FTN_^LA(T,"C",C)_$C(3)
 L ^LA(T,"O") S (O,^LA(T,"O"))=^LA(T,"O")+2,^("O",O-1)=OUT,^(O)=LRECORD,^(0)=^LA(T,"O",0)+1 L ^LA("Q") S (Q,^LA("Q"))=^LA("Q")+1,^LA("Q",Q)=T,T=T-BASE L
 Q
U S Q=^LA(T,"O",0)-1,^LA(T,"O",0)=Q,OUT=^(Q) L ^LA("Q") S Q=^LA("Q")+1,^("Q")=Q,^("Q",Q)=T,T=T-BASE L
 Q
