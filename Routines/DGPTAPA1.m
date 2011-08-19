DGPTAPA1 ;ALB/MTC - PTF A/P ARCHIVE UTILITY ; 10-19-92
 ;;5.3;Registration;;Aug 13, 1993
 ;
ARINT ;
 D ARMAIN,AR401^DGPTAPA2,AR601^DGPTAPA2,AR501^DGPTAPA3,AR535^DGPTAPA3
 Q
 ;
ARMAIN ;-- This function will load the array containing the
 ; PTF detailed information.
 ;  INPUT : DGPTF - Valid PTF entry
 ;          DGTMP - IEN of the template used
 ;
 N I,X,Y,DG70,NUMREC,SEQ,OSEQ,REF
 ;--
 S OSEQ=$G(^DGP(45.62,DGTMP,100,0)) Q:OSEQ']""
 S SEQ=$P(OSEQ,U,3),REF="^DGP(45.62,"_DGTMP_",100)"
 S DG70=$G(^DGPT(DGPTF,70))
 ;
 ;--patient name (2)
 S Y=DGPTF_U_$P(^DPT(+^DGPT(DGPTF,0),0),U)
 ;--admission date (3)
 S Y=Y_U_$P(^DGPT(DGPTF,0),U,2)
 ;--discharge date (4)
 S Y=Y_U_$S(+DG70:+DG70,1:"")
 ;--discharge specilaty (5)
 S Y=Y_U_$S($P(DG70,U,2):$P(^DIC(42.4,$P(DG70,U,2),0),U),1:""),X=$P(DG70,U,3)
 ;--type of disposition (6)
 S Y=Y_U_$S(X:$P($P($P(^DD(45,72,0),U,3),";",X),":",2),1:"")
 S X=$P(DG70,U,14)
 ;--discharge status (7)
 S Y=Y_U_$S(X:$P($P($P(^DD(45,72.1,0),U,3),";",X),":",2),1:"")
 S X=$P(DG70,U,4)
 ;--outpatient treatment (8)
 S Y=Y_U_$S(X=1:"YES",1:"NO")
 ;-- ASIH days (9)
 S Y=Y_U_$S($P(DG70,U,8)]"":$P(DG70,U,8),1:"")
 S X=$P(DG70,U,9)
 ;-- C&P Status (10)
 S Y=Y_U_$S(X:$P($P($P(^DD(45,78,0),U,3),";",X),":",2),1:"")
 ;-- VA Auspices (11)
 S Y=Y_U_$S($P(DG70,U,5)=1:"YES",1:"NO")
 ;-- income (12)
 S DGINC=$P($G(^DGPT(DGPTF,101)),U,7)
 S Y=Y_U_$S(DGINC]"":DGINC,1:"")
 ;
 ;-- check for ICD codes (13-22)
 F I=10,15:1:24 D
 . S Y=Y_U_$S($P(DG70,U,I):$P(^ICD9($P(DG70,U,I),0),U),1:"")
 ;
 ;-- check for 300 node information (23-28)
 S X=$G(^DGPT(DGPTF,300))
 S Y=Y_U_$$AR300(X),SEQ=SEQ+1,@REF@(SEQ,0)=Y
 ;
 ;-- update
 S $P(^DGP(45.62,DGTMP,100,0),U,3,4)=SEQ_U_SEQ
 ;
 Q
 ;
AR300(N300) ;-- load 300 node information
 ; INPUT N300 - Contains 300 node
 ; OUTPUT   - Load display array
 ;
 N Y,X
 ;-- suicide indicator
 S Y=$S($P(N300,U,2)=1:"Attempted",$P(N300,U,2)=2:"Accomplished",1:"")_U
 ;-- legionnaire's
 S Y=Y_$S($P(N300,U,3)=1:"YES",1:"NO")_U
 ;-- abused substance
 S Y=Y_$S($P(N300,U,4):$P($G(^DIC(45.61,$P(N300,U,4),0)),U),1:"")_U
 ;-- psych class severity
 I $P(N300,U,5)]"" D
 . S X=$P(N300,U,5)
 . S Y=Y_$S(X]"":$P($P($P(^DD(45.02,300.05,0),U,3),";",X),":",2),1:"")_U
 I $P(N300,U,5)="" S Y=Y_U
 ;-- current func assessment
 S Y=Y_$S($P(N300,U,6):$P(N300,U,6),1:"")_U
 ;-- high level psych class
 S Y=Y_$S($P(N300,U,7):$P(N300,U,7),1:"")_U
 Q Y
 ;
