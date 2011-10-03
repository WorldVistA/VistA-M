LAMSPAN ;SLC/DLG - MICROSCAN PROTOCALL ROUTINE W/ ACK-NAK  ;7/20/90  09:50 ;
 ;;5.2;AUTOMATED LAB INSTRUMENTS;;Sep 27, 1994
A L ^LA(T) I '$D(^LA(T,"P")) S ^("P")="MICROSCAN^IN"
 S MODE=$P(^LA(T,"P"),"^",2),CTRL=$S($F(IN,"~")=$L(IN):$P(IN,"~",2),1:" ") D @MODE L  Q
 ;
IN ;C= <STX>+<LF>+<CR> or there replaced values.
 Q:"BU"[CTRL  G I2:"C"[CTRL I CTRL["E" S OUT=$C(6) Q
 G:CTRL["D" SETOUT
 S C=2+13+13 F I=1:1:$L(IN) S C=C+$A(IN,I)
 S ^LA(T,"P1")=C#256 Q
I2 S C=$A(IN,1)-64*16+$A(IN,2)-64,CHK=$S($D(^LA(T,"P1")):^("P1"),1:-1),OUT=$S(C=CHK:$C(6),1:$C(21))
 I C'=CHK S CNT=^LA(T,"I")-2,^("I")=$S(CNT'<0:CNT,1:0)
 Q
OUT I CTRL'="F" S CNT=^LA(T,"O",0)-2,^(0)=$S(CNT'<0:CNT,1:0) ;drop into next line
 Q:'$D(^LA(T,"O",0))  S CNT=^LA(T,"O",0)+1 I '$D(^LA(T,"O",CNT)) K ^LA(T) Q  ;Clean up and leave
 S ^(0)=CNT,OUT=^LA(T,"O",CNT)
 L ^LA("Q") S Q=^LA("Q")+1,^LA("Q")=Q,^("Q",Q)=T
 Q
SETOUT ;Change to output
 Q:'$D(^LA(T,"O",0))  Q:^LA(T,"O")'>^LA(T,"O",0)
 S $P(^LA(T,"P"),"^",2)="OUT" L ^LA("Q") S Q=^LA("Q"),^LA("Q",Q+1)=T,^(Q+2)=T,^LA("Q")=Q+2
 Q
 ;The MicroScan needs to have the field delimiter set to | (124)
 ;LF is set to @ (64). Set " to 0.
 ;Timeout set to a min of 20, Protocall set to ACK/NAK.
 ;STX = ~B, ETX = ~C, EOT = ~D, ENQ = ~E, ACK = ~F, NAK = ~U
