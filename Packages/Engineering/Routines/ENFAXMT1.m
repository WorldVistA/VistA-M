ENFAXMT1 ;WASHINGTON IRMFO/KLD/DH; CREATE Fx2, Fx3, FxA DOCS ;3/21/96
 ;;7.0;ENGINEERING;**29**;Aug 17, 1993
 ;This routine should not be modified.
ST ;Build X(2) thru X(4)
 Q:ENFAP("DOC")="FR"  ; not executed for FR doc
FA I ENFAP("DOC")="FA" D
 . ; don't send FA2
 . S X(3)="LIN^~"
 . S X(4)="FAA"_U_$P(ENEQ(9),U,9) ; equity account 1
 . S X(4)=X(4)_"^^^^^^^^"_$P(ENEQ(2),U,3) ; asset value 1
 . S X(4)=X(4)_"^^^^^^^^~"
FB I ENFAP("DOC")="FB" D
 . S X(2)="FB2^^^^^^^"_$P(ENFAP(4),U,4)_"^^~"
 . S X(3)="LIN^~"
 . S X(4)="FBA"_U_$P(ENFAP(6),U,2) ; equity account 1
 . S X(4)=X(4)_"^^^^^^^^"_$P(ENFAP(4),U,4) ; asset value 1
 . S X(4)=X(4)_"^^^^^^^^~"
FC I ENFAP("DOC")="FC" D
 . S X(2)="FC2^^^^^^^"_$P(ENFAP(4),U,3)_"^^^^"_$P(ENFAP(4),U,6)
 . S X(2)=X(2)_"^^^^^^^^^^"
 . I $P($G(ENFAP(4)),U,14)]"" S X(2)=X(2)_$P(ENFAP(4),U,14,16)
 . E  S X(2)=X(2)_"^^"
 . S $P(X(2),U,27)="~"
 . S X(3)="LIN^~"
 . S X(4)="FCA"
 . S X(4)=X(4)_U I $P(ENFAP(4),U,6)]"" D  ; only send equity when $ chg'd
 . . I $P(ENFAP(3),U,8)="00" S X(4)=X(4)_$P(ENEQ(9),U,9) ; equity for FA
 . . E  S X(4)=X(4)_$P($G(^ENG(6915.3,ENFB("DA"),6)),U,2) ; equity for FB
 . S X(4)=X(4)_"^^^^^^^^"_$P(ENFAP(4),U,6) ; asset value 1
 . S X(4)=X(4)_"^^^^^^^^~"
FD I ENFAP("DOC")="FD" D
 . ; FD2 not defined
 . S X(3)="LIN^~"
 . S X(4)="FDA"
 . D FANUM^ENFAXMT3(4) S X(4)=X(4)_U_$P(ENFAP(5),U,4,9)_"^~"
 Q
 ;
 ;ENFAXMT1
