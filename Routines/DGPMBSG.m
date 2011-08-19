DGPMBSG ;ALB/LM - BED STATUS GENERATION; 6 JUNE 90
 ;;5.3;Registration;**34**;Aug 13, 1993
 ;
1 D ^DGPMBSG1
 S M=MV("MT") ;  Movement type
 S T=MV("TT") ;  Transaction type
2 I T'=1,'REM D ^DGPMBSG2
3 D ^DGPMBSG3
 I T=2 D TRF ; if Transfer
 I '$D(E("LW")) S ^UTILITY("DGCN",$J,+MV("LWD"))=LW
 I '$D(E("PW")) S ^UTILITY("DGCN",$J,+MV("PWD"))=PW
 I '$D(E("LT")) S ^UTILITY("DGSN",$J,LTSDV,+MV("LTS"))=LT
 I '$D(E("PT")) S ^UTILITY("DGSN",$J,PTSDV,+MV("PTS"))=PT
K K E,II,JJ,LDV,LT,LW,M,MP,PT,PW,X,X1,Z
Q K E Q
 ;
TRF ;  T=2 (Transfer)
 ; M=44 (resume ASIH in parent facility)  M=45 (change ASIH other facility)
 I "^44^45^"[("^"_M_"^") S (E("LW"),E("LT"),E("PW"),E("PT"))="" Q
 ;
 ;  M=13 (to ASIH) 43=TO ASIH (OTHER FAC)  20=To ASIH  24=Cum Losses
 I "^13^43^"[("^"_M_"^") S $P(LW,"^",20)=$P(LW,"^",20)+1,$P(LW,"^",24)=$P(LW,"^",24)+1,$P(LT,"^",20)=$P(LT,"^",20)+1,$P(LT,"^",24)=$P(LT,"^",24)+1 K E S (E("PW"),E("PT"))="" Q
 ;
 ;  M=14 (From ASIH)  19=From ASIH  28=Gains Total
 I M=14 S $P(LW,"^",19)=$P(LW,"^",19)+1,$P(LW,"^",28)=$P(LW,"^",28)+1,$P(LT,"^",19)=$P(LT,"^",19)+1,$P(PT,"^",28)=$P(PT,"^",28)+1 K E S E("PW")="" Q
 ;
 ;  M=2 (AA)  M=3 (UA)  24=Cum Losses  26=Cum AA  27=Cum UA
 I "^2^3^"[("^"_M_"^") S $P(LW,"^",24)=$P(LW,"^",24)+1,$P(LW,"^",(M+24))=$P(LW,"^",(M+24))+1,$P(LT,"^",24)=$P(LT,"^",24)+1,$P(LT,"^",(M+24))=$P(LT,"^",(M+24))+1 K E S (E("PW"),E("PT"))="" Q
 ;
 ; M=22 (From UA) 28=Gain Cum
 I M=22 S $P(LW,"^",28)=$P(LW,"^",28)+1,$P(PT,"^",28)=$P(PT,"^",28)+1 K E S (E("PW"),E("LT"))="" Q
 ;
 ; M=24 (From AA) 28=Gain Cum
 I M=24 S $P(LW,"^",28)=$P(LW,"^",28)+1,$P(PT,"^",28)=$P(PT,"^",28)+1 K E S (E("PW"),E("LT"))="" Q
 ;
 ; M=25 (From AA to UA)  26=Cum AA
 I M=25 S $P(LW,"^",26)=$P(LW,"^",26)+1,$P(PT,"^",26)=$P(PT,"^",26)+1 K E S (E("PW"),E("LT"))="" Q
 ;
 ; M=26 (From UA to AA)  27=Cum UA
 I M=26 S $P(LW,"^",27)=$P(LW,"^",27)+1,$P(PT,"^",27)=$P(PT,"^",27)+1 K E S (E("PW"),E("LT"))="" Q
 ;
WDC Q:'WDC  ;  Ward Change
 ;  28=Gain Cum, 23=Cum InterServ Xfer In, 8=Cum InterServ Xfer Out, 6=Cum Inter Xfer, 24=Cum Losses, 29=Cum IWT
 S $P(LW,"^",28)=$P(LW,"^",28)+1,X=$S($D(^DIC(42,+MV("LWD"),0)):$P(^(0),"^",3),1:0),X1=$S($D(^DIC(42,+MV("PWD"),0)):$P(^(0),"^",3),1:0) I X'=X1 S $P(LW,"^",23)=$P(LW,"^",23)+1,$P(PW,"^",8)=$P(PW,"^",8)+1
 S $P(PW,"^",6)=$P(PW,"^",6)+1,$P(PW,"^",24)=$P(PW,"^",24)+1,$P(LW,"^",29)=$P(LW,"^",29)+1
 Q
