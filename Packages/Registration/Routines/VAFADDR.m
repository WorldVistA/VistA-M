VAFADDR ;ALB/MIR - ADDRESS UTILITIES (INPUT AND OUTPUT TRANSFORM) ; 25 JAN 93
 ;;5.3;Registration;;Aug 13, 1993
 ;
 ; This routine contains generic input and output transforms for the
 ; ZIP+extension fields which reside in DHCP
 ;
ZIPIN ; input transform for ZIP - massages user input and returns data
 ; in FileMan internal format (no '-'s)
 ;
 ;  Input:  X as user entered value
 ; Output:  X as internal value of user input OR
 ;            undefined if input from user was invalid
 ;
 N %
 I X'?.N F %=1:1:$L(X) I $E(X,%)?1P S X=$E(X,0,%-1)_$E(X,%+1,20),%=%-1
 I X'?5N,(X'?9N) K X
 Q
 ;
 ;
ZIPOUT ; output transform for ZIP - prints either ZIP or ZIP+4 (in 12345-1234)
 ; format.
 ;
 ;  Input:  Y as FileMan internal value
 ; Output:  Y as external format (12345 or 12345-1234)
 ;
 S Y=$E(Y,1,5)_$S($E(Y,6,9)]"":"-"_$E(Y,6,9),1:"")
 Q
