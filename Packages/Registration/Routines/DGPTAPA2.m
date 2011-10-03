DGPTAPA2 ;ALB/MTC - PTF A/P ARCHIVE UTILITY CONT. ; 10-19-92
 ;;5.3;Registration;;Aug 13, 1993
 ;
AR401 ;-- this function will load the 401 information
 N X,X1,Y,I,J,K,OSEQ,SEQ
 S OSEQ=$G(^DGP(45.62,DGTMP,100,0)) Q:OSEQ']""
 S SEQ=$P(OSEQ,U,3),REF="^DGP(45.62,"_DGTMP_",100)"
 ;
 S (K,I)=0 F  S I=$O(^DGPT(DGPTF,"S",I)) Q:'I  D
 . S K=K+1,SEQ=SEQ+1,X=$G(^DGPT(DGPTF,"S",I,0)) Q:X']""
 .;-- surgery date (4)
 . S Y=DGPTF_U_"401"_U_K_U_$S($P(X,U):$P(X,U),1:"")
 .;-- sur specialty (5)
 . S Y=Y_U_$S($P(X,U,3):$P($G(^DIC(45.3,$P(X,U,3),0)),U,2),1:"")
 .;-- cat of chief sur (6)
 . S Y=Y_U_$S($P(X,U,4):$P($P($P(^DD(45.01,4,0),U,3),";",$P(X,U,4)),":",2),$P(X,U,4)="V":"VA TEAM",$P(X,U,4)="M":"MIXED VA&NON VA",$P(X,U,4)="N":"NON VA",1:"")
 .;-- cat of first ass (7), pric ana (8), source of pay (9)
 . F J=5,6,7 S Y=Y_U_$S($P(X,U,J):$P($P($P(^DD(45.01,J,0),U,3),";",$P(X,U,J)),":",2),1:"")
 .;
 .;-- check for ICD codes (10-14)
 . F J=8:1:12 D
 .. S Y=Y_U_$S($P(X,U,J):$P(^ICD0($P(X,U,J),0),U),1:"")
 .;
 .;-- check for 300 node information (15)
 . S X2=$G(^DGPT(DGPTF,"S",I,300))
 . S Y=Y_U_$S($P(X2,U,2)=1:"Live Donor",$P(X2,U,2)=2:"Cadaver",1:"")
 . S SEQ=SEQ+1,@REF@(SEQ,0)=Y
 .;
 .;-- 401P 
 .;-- ICD codes (4-9)
 . S X3=$G(^DGPT(DGPTF,"401P")) I X3]"" D  S @REF@(SEQ,0)=Y
 .. S SEQ=SEQ+1,Y=DGPTF_U_"401P"_U_K F J=1:1:5 I $P(X3,U,J) D
 ... S Y=Y_U_$P(^ICD0($P(X3,U,J),0),U)
 .;
 ;
 ;-- update
 S $P(^DGP(45.62,DGTMP,100,0),U,3,4)=SEQ_U_SEQ
 Q
 ;
AR601 ;-- this function will load the 601 information
 N X,Y,I,J,K,OSEQ,SEQ
 S OSEQ=$G(^DGP(45.62,DGTMP,100,0)) Q:OSEQ']""
 S SEQ=$P(OSEQ,U,3),REF="^DGP(45.62,"_DGTMP_",100)"
 ;
 S (K,I)=0 F  S I=$O(^DGPT(DGPTF,"P",I)) Q:'I  D
 . S K=K+1,SEQ=SEQ+1,X=$G(^DGPT(DGPTF,"P",I,0)) Q:X']""
 .;-- procedure date (4)
 . S Y=DGPTF_U_"601"_U_K_U_$S($P(X,U):$P(X,U),1:"")
 .;-- specialty (5)
 . S Y=Y_U_$P($G(^DIC(42.4,+$P(X,U,2),0)),U,1)
 .;-- dialysis type (6)
 . S Y=Y_U_$P($G(^DG(45.4,+$P(X,U,3),0)),U)
 .;-- # of treat (7)
 . S Y=Y_U_+$P(X,U,4)
 .;-- ICD codes (8-12)
 . F J=5:1:9 D
 .. S Y=Y_U_$S($P(X,U,J):$P(^ICD0($P(X,U,J),0),U),1:"")
 . S @REF@(SEQ,0)=Y
 ;
 ;-- update
 S $P(^DGP(45.62,DGTMP,100,0),U,3,4)=SEQ_U_SEQ
 Q
 ;
