DGPTAPA3 ;ALB/MTC - PTF A/P ARCHIVE UTILITY CONT. ; 10-19-92
 ;;5.3;Registration;;Aug 13, 1993
 ;
AR501 ;-- this function will load the 501 information
 N X,Y,I,J,K,OSEQ,SEQ
 S OSEQ=$G(^DGP(45.62,DGTMP,100,0)) Q:OSEQ']""
 S SEQ=$P(OSEQ,U,3),REF="^DGP(45.62,"_DGTMP_",100)"
 ;
 S (K,I)=0 F  S I=$O(^DGPT(DGPTF,"M",I)) Q:'I  D
 . S K=K+1,SEQ=SEQ+1,X=$G(^DGPT(DGPTF,"M",I,0)) Q:X']""
 .;-- movement date (4)
 . S Y=DGPTF_U_"501"_U_K_U_$S($P(X,U,10):$P(X,U,10),1:"")
 .;-- treated for and SC condition (5)
 . S Y=Y_U_$S($P(X,U,18)=1:"YES",1:"NO")
 .;-- leave days (6)
 . S Y=Y_U_$S($P(X,U,3):$P(X,U,3),1:"")
 .;-- pass days (7)
 . S Y=Y_U_$S($P(X,U,4):$P(X,U,4),1:"")
 .;-- losing specilaty (8)
 . S Y=Y_U_$S($P(X,U,2):$P(^DIC(42.4,$P(X,U,2),0),U),1:"")
 .;
 .;-- check for ICD codes (9-18)
 . F J=5:1:9,11:1:15 D
 .. S Y=Y_U_$S($P(X,U,J):$P(^ICD9($P(X,U,J),0),U),1:"")
 .;
 .;-- check for 300 node information (19-24)
 .;
 . S X2=$G(^DGPT(DGPTF,"M",I,300))
 . S Y=Y_U_$$AR300^DGPTAPA1(X2)
 . S SEQ=SEQ+1,@REF@(SEQ,0)=Y
 ;-- update
 S $P(^DGP(45.62,DGTMP,100,0),U,3,4)=SEQ_U_SEQ
 Q
 ;
AR535 ;-- this function will load the 535 information
 N Y,X,I,DG535,OSEQ,SEQ
 S OSEQ=$G(^DGP(45.62,DGTMP,100,0)) Q:OSEQ']""
 S SEQ=$P(OSEQ,U,3),REF="^DGP(45.62,"_DGTMP_",100)"
 ;
 S (I,DG535)=0 F  S DG535=$O(^DGPT(DGPTF,535,DG535)) Q:'DG535  D
 . S I=I+1,SEQ=SEQ+1,X=$G(^DGPT(DGPTF,535,DG535,0)),X1=""
 .;-- physical movement # (4)
 . S Y=DGPTF_U_"535"_U_I_U_$S($P(X,U,10):$P(X,U,10),1:"")
 .;-- losing specialty (5)
 . S Y=Y_U_$P(^DIC(42.4,$P(X,U,2),0),U,1)
 .;-- leave days (6)
 . S Y=Y_U_$P(X,U,3)
 .;-- pass days (7)
 . S Y=Y_U_$P(X,U,4)
 .; losing ward (8)
 . S Y=Y_U_$P(^DIC(42,$P(X,U,6),0),U)
 . S @REF@(SEQ,0)=Y
 ;-- update
 S $P(^DGP(45.62,DGTMP,100,0),U,3,4)=SEQ_U_SEQ
 Q
 ;
