DGMTSCU1 ;ALB/RMO/CAW - Means Test Screen Display Utilities ;21 JAN 1992 8:00 pm
 ;;5.3;Registration;**166**;Aug 13, 1993
 ;
YN(X) ;Output Yes/No
 ; Input  -- X  1, 0 or ""
 ; Output -- YES, NO or UNANSWERED
 N Y
 S Y=$S(X:"YES",X="":"UNANSWERED",1:"NO")
 Q $G(Y)
 ;
AMT(X) ;Output Dollar Amount
 ; Input  -- X      Amount
 ; Output -- Dollar amount
 N Y
 I X]"" S $P(X,".",2)=$E($P(X,".",2)_"00",1,2)
 S Y=$S(X]"":"$"_X,1:"-")
 Q $G(Y)
 ;
DATE(X) ;Output Date
 ; Input  -- X      Date
 ; Output -- Date
 N Y
 S Y=$$FMTE^XLFDT(X,"5DF") I Y]"" S Y=$TR(Y," ","0")
 Q $G(Y)
 ;
LYR(X) ;Last Year
 ; Input  -- X      Date
 ; Output -- Last Year
 N Y
 S Y=$E(X,1,3)-1_"0000"
 Q $G(Y)
 ;
TOT(X,R1,R2) ;Compute Total
 ;         Input  -- X     String to total
 ;                   R1    Beginning of range
 ;                   R2    End of Range
 ;         Output -- Total
 N I,Y
 S Y=0 F I=R1:1:R2 S Y=Y+$P(X,"^",I)
 Q $G(Y)
 ;
UL(X,L) ;Underline
 ; Input  -- X      Underline Character
 ; Output -- Underline String
 W ?131,$C(13) W:X["-" !
 Q $G(L)
 ;
HIGH(Z,ACT) ; Highlight certain text
 ;  Input -- Z         Character(s) to highlight
 ;           ACT       MT action
 ;  Ouput -- Hightlighted character
 W ! S Z=$S(ACT="VEW":"<"_Z_">",1:"["_Z_"]")
 I ACT="VEW" W Z Q
 I ACT'="VEW"!($E(Z)="[") W DGVI,Z,DGVO
 Q
