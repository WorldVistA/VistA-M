XUA4A71(X) ;DFW/MRL - BETTER SOUNDEX ;1/3/95  16:18
 ;;8.0;KERNEL;;Jul 10, 1995
 ;Extrinsic function, Call with string, Returns converted string.
 G 1
EN(X) ;EF,New SAC complient entry point
1 N D,E,F,I,I1,J,J1,L,S,T,W,X1,Z
2 S (E(1),E)="" F I=1:1:$L(X) S L=$E(X,I) Q:L=","  I L?1A S:$A(L)>95 L=$C($A(L)-32) I L'=E(1) S E(1)=L,E=E_L ;make uppercase---keep only alpha---drop duplicate's
 S E="#"_E D CONV S F=$E(E,1,3) F I=4:2 Q:I>$L(E)  I +$E(E,I-2,I-1)'=+$E(E,I,I+1) S F=F_$E(E,I,I+1)
 Q $E(F_"0000000000000",2,9)
 ;
CONV ;Convert word to numerics (first four sounds)
 S X=$P($T(SH),";;",2),D=0 F I=1:1 S S=$P(X,";",I) Q:S']""!(D)  F J="S","N" S F=S_J,T=31_$S(J="S":24,1:21) D E Q:D
 F F="TIARY","TEARY","TIARE","TEARE" S T=31_$E(F,2,5) D E Q:D
 S X=$P($T(END+1),";;",2) F I=1:1 S J=$P(X,";",I) Q:J']""  S F=$P(J,":",1),T=$P(J,":",2) D E Q:D
 ;F I=1,2 S X(I)=$P($T(VOWEL+I),";;",2)
DOUB ;Double Vowels
 S D=0 F J=1,2 S X=$P($T(VOWEL+J),";;",2) D
 . F I=1:1 S X1=$P(X,";",I) Q:X1']""  I E[$P(X1,":",1) S D=1,F=$P(X1,":",1),T=$P(X1,":",2),E=$P(E,F,1)_T_$P(E,F,2)
 G DOUB:D
 F I="START","CHNG","END1","CHNG1" S W=$E(I) F I1=1:1 S X=$P($T(@I+I1),";;",2) Q:X']""  F J=1:1 S J1=$P(X,";",J) Q:J1']""  S F=$P(J1,":",1),T=$P(J1,":",2) I E[F D @W
 Q
 ;
C ;Change sound to another
 S E=$P(E,F,1)_T_$P(E,F,2,99) G C:E[F Q
 ;
S ;Change 'Starts with' sound to another
 I $E(E,2,$L(F)+1)=F S E=$P(E,F,1)_T_$P(E,F,2)
 Q
E ;Change 'Ends with' sound to another
 S Z=$L(E)-($L(F))+1,Z=$S(Z>1:Z,1:2) I $E(E,Z,$L(E))=F S E=$E(E,1,Z-1)_T,D=1
 Q
 ;
SH ;;TEOU;TIOU;TOU;TIOU;TU;TYOU;SHU;SHI;CHU;CHO;XIOU;XOU;XU;XIU;CIOU;COU;CU;CO;SIOU;CEOU;CE;XEOU;XE;SEOU;SHOU;CHOU;CHE;CHI;SU;TIO
 ;
VOWEL ;
 ;;AE:A;AI:A;AO:O;AU:O;AW:O;AY:A;EA:E;EI:E;EO:O;EU:U;EW:U;EY:I;IA:A;IE:E;IO:I;IU:O;IW:I;IY:I;OA:O;OE:O;OI:O;OU:U;GH:;
 ;;OWE:O;OW:O;OY:O;UA:A;UE:U;UI:I;UO:O;UW:U;UY:I;WA:A;WE:E;WI:I;WO:O;WU:U;WY:I;YA:A;YE:E;YI:I;YO:O:YU:U;AA:A;EE:E;II:I;OO:O;UU:U;YY:I
 ;
END ;
 ;;VOUS:1512;RTIAL:R3118;GUE:16;
 ;
START ;
 ;;MAC:MC;WR:23:GU:16;QU:17;TH:14
 ;
CHNG ;
 ;;PE:22;GU:16;CA:24A;CE:24E;CI:24I;CY:24Y;AL:18;EL:18;IL:18;OL:18;UL:18;WL:18;YL:18;AN:21;EN:21;IN:21;AR:23;AV:15;V:15;BH:13;BT:13;ED:14;ER:23;IM:19;IT:14;IR:23;OR:23;EM:19;YT:14
 ;;OM:19;ON:21;UR:23;US:24;ES:24;UN:21;GN:21;KN:21;LK:14;LM:19;LN:21;CHM:19;TSCH:31;TSH:31;TCH:31;TSCH:31;SCH:31;SH:31;CH:31;DJ:16;MB:19;MN:21;PHN:21;PH:15;PN:21;YR:23;YN:21
 ;;WH:12;YL:18;RH:23
 ;
END1 ;
 ;;CE:24;ZE:24;TE:14;E;;ATES:24;ES:24;IS:24;OS:24;US:24;YS:24;WS:24;EZ:24;Z:24;TI:14;TY:14;CY:2411;CI:2411;TE:14;NTS:N24;21TS:2124;21T24:2124;S:24
CHNG1 ;
 ;;A:11;B:13;C:17;D:14;E:11;F:15;G:16;H:;I:11;J:16;K:17;L:18;M:19;N:21;O:12;P:22;Q:17;R:23;S:24;T:14;U:12;V:15;W:12;X:24;Y:11;Z:24
