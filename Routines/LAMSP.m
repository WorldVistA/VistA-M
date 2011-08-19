LAMSP ;SLC/DLG - MICROSCAN PROTOCALL ROUTINE W/O ACK-NAK ;7/20/90  09:49 ;
 ;;5.2;AUTOMATED LAB INSTRUMENTS;;Sep 27, 1994
A L ^LA(T,"P") I '$D(^LA(T,"P")) S ^("P")="MICROSCAN^IN"
 S MODE=$P(^LA(T,"P"),"^",2),CTRL=$S($F(IN,"~")=$L(IN):$P(IN,"~",2),1:" ") D @MODE L  Q
 ;
IN ;C= <STX>+<LF>+<CR> or there replaced values.
 G:CTRL["D" SETOUT S:CTRL["E" OUT=$C(6),$P(^LA(T,"P"),"^",2)="IN" Q
OUT Q
SETOUT ;Change to output
 Q:'$D(^LA(T,"O",0))  Q:^LA(T,"O")'>^LA(T,"O",0)  S $P(^LA(T,"P"),"^",2)="OUT" Q
 ;The MicroScan needs to have the field delimiter set to | (124)
 ;LF is set to @ (64). Set " to 0.
 ;Timeout set to a min of 20, Protocall set to ACK/NAK.
 ;STX = ~B, ETX = ~C, EOT = ~D, ENQ = ~E, ACK = ~F, NAK = ~U
