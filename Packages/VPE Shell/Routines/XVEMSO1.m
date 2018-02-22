XVEMSO1 ;DJB/VSHL**A,E,I,P,R [07/01/94];2017-08-16  10:25 AM
 ;;14.1;VICTORY PROG ENVIRONMENT;;Aug 16, 2017
 ; Original Code authored by David J. Bolduc 1985-2005
 ;
 ;====================================================================
A ;ACTION type option
 I $D(^DIC(19,+OPT,20)) X ^(20)
 Q
 ;====================================================================
P ;PRINT type option
 NEW DIC,PG,L,FLDS,BY,FR,TO,DHD,DCOPIES,DIS,IOP,DHIT,DIOBEG,DIOEND
 S LIST="DIC,PG,L,FLDS,BY,FR,TO,DHD,DCOPIES,DIS(0),IOP,DHIT,DIOBEG,DIOEND"
 S NUM=59 D SET
 I $D(DIS(0))#2 F I=1:1:3 Q:'$D(^DIC(19,+OPT,69+(I/10)))  Q:^(69+(I/10))=""  S DIS(I)=^(69+(I/10))
 I $G(^DIC(19,OPT,79))=1 S DIASKHD=""
 D D1,EN1^DIP
 Q
 ;====================================================================
I ;INQUIRE type option
 D DIC Q:DA=-1
 S DI=DIC,LIST="DIC,DR,DIQ(0)",NUM=79 D SET,D1 S:$D(DIC)[0 DIC=DI
 I $D(^DIC(19,+OPT,63)),$L(^(63)) S FLDS=^(63) G I1
 S:DUZ(0)'="@" DICS="I 1 Q:'$D(^(8))  F DW=1:1:$L(^(8)) I DUZ(0)[$E(^(8),DW) Q"
 W XVV("IOF") D EN^DIQ S Y=OPT G I
I1 ;
 W ! S LIST="DHD",NUM=66 D SET
 KILL ^UTILITY($J),^(U,$J) S ^($J,1,DA)=""
 S @("L=+$P("_DI_"0),U,2)"),DPP(1)=L_"^^^@",L=0
 S C=",",Q="""",DPP=1,DPP(1,"IX")="^UTILITY(U,$J,"_DI_"^2"
 D N^DIP1 S Y=OPT
 G I
 ;====================================================================
R ;RUN ROUTINE type option
 NEW RTN Q:'$D(^DIC(19,OPT,25))
 S RTN=^(25) Q:'$L(RTN)  S:RTN'[U RTN=U_RTN D @RTN
 Q
 ;====================================================================
E ;EDIT type option
 D DIC Q:DA=-1  NEW DIE,DIC
 S LIST="DIE,DR",NUM=49 D SET S LIST="DIE(""W"")",NUM=53 D SET
 I $D(^DIC(19,OPT,53)),$L(^(53)) S %=^(53),DIE("NO^")=$S(%="N":"",1:%)
 S:DIE["(" DIE=U_DIE D ^DIE S Y=OPT
 G E
 ;====================================================================
DIC ;Get FileMan parameters from Option File and do look up
 NEW D,DIC,NUM W !
 S LIST="DIC,DIC(0),DIC(""A""),DIC(""B""),DIC(""S""),DIC(""W""),D",NUM=29 D SET,D1
 I '$D(D) D ^DIC I 1
 E  S:D="" D="B" D IX^DIC
 S DA=+Y,Y=OPT
 Q
D1 ;
 S:DIC["(" DIC=U_DIC
 Q
SET ;Set variables
 NEW I,VAR
 F I=1:1 S VAR=$P(LIST,",",I) Q:VAR=""  KILL @VAR I $D(^DIC(19,+OPT,NUM+I)),^(NUM+I)]"" S @VAR=^(NUM+I)
 I $G(DIC("A"))]"" S DIC("A")=DIC("A")_" "
 Q
