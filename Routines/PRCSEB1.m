PRCSEB1 ;WISC/SAW,DGL-CONTROL POINT ACTIVITY EDITS CON'T; [7/21/98 3:35pm]
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
ENOD ;ENTER OBLIGATION DATA
 W !,"This option is no longer in use." Q
ENOD1 ;
 W !,"Committed (Estimated) Cost: " I $D(^PRCS(410,DA,4)),$P(^(4),U)]"" W ?28,$J($P(^(4),U),0,2)
 E  W ?28,"None entered."
 S DR="[PRCSENOD]",DIE=DIC D ^DIE S:'$D(PRCS) PRCS=DA Q:$D(PRCSOB)  G EXIT
ENCAD ;ENTER FMS DATA
 D EN3^PRCSUT G W2:'$D(PRC("SITE")),EXIT:Y<0
 S DIC="^PRCS(410,",DIC(0)="AEQ",DIC("A")="Select PURCHASE ORDER/OBLIGATION NO: ",D="D"
 S DIC("S")="I +^(0),$D(^(3)),+^(3)=+$P(PRC(""CP""),"" ""),$P(^(0),""^"",5)=PRC(""SITE"") I $D(^PRC(420,""A"",DUZ,PRC(""SITE""),+PRC(""CP""),1))!($D(^(2)))" D ^PRCSDIC G EXIT:Y<0 K DIC("S"),DIC("A")
 S DA=+Y L +^PRCS(410,DA):15 G ENCAD:$T=0 S DIC(0)="AEMQ",DIE=DIC,DR="[PRCSENCAD]" D ^DIE L -^PRCS(410,DA) S T(1)="FMS (820)" D W3 G EXIT:%'=1 W !! G ENCAD
ENA ;ENTER AN ADJUSTMENT
 N AMOUNT,PO,REC,PODATE,SITE
 D EN^PRCSUT G W2:'$D(PRC("SITE")) G EXIT:'$D(PRC("QTR"))!(Y<0)
 D EN1^PRCSUT3 Q:'X  S X1=X D EN2^PRCSUT3 Q:'$D(X1)  S X=X1 D W L +^PRCS(410,DA):15 G ENA:$T=0 S $P(^PRCS(410,DA,0),U,2)="A"
 D ADDADJ
 S T(1)="Adjustment" K PRCS58 D W3 G EXIT:%'=1 W !! G ENA
 ;
 ;D EN1^PRCSUT3 Q:'X  S X1=X D EN2^PRCSUT3 Q:'$D(X1)  S X=X1 D W L +^PRCS(410,DA):15 G ENA:$T=0 S $P(^PRCS(410,DA,0),U,2)="A"
 ;
ADDADJ S DIE="^PRCS(410,",DR="450////O;449////"_$P($$QTRDATE^PRC0D(PRC("FY"),PRC("QTR")),"^",7) D ^DIE K DR
ENA1 S DIC(0)="AEMQ",DIE=DIC,DR="24OBLIGATION NUMBER~R" D ^DIE K DR G CT:$D(Y)
 S SITE=PRC("SITE"),$P(^PRCS(410,DA,7),"^")=DUZ
 N PRCX442 S PRCX442=X,PRCX442=$$UPPER^PRCFFU5(PRCX442) D OBL^PRCSES2 S X=PRCX442
 S DIC(0)="AEMQ",DIE="^PRCS(410,"
ENA2 K DR S DR="[PRCSENA]" I $D(PRCS58) S DR="[PRCSENA 1358]"
 D ^DIE G CT:$D(Y) I '$D(^PRCS(410,DA,4)) W $C(7),!,"You must enter an Adjustment $ Amount for this transaction.",! G ENA2
 I $D(^PRC(420,PRC("SITE"),1,+PRC("CP"),0)),$P(^(0),U,12)>0 G ENA3
 I $D(^PRCS(410,DA,4)) S X=$P(^(4),"^",6),X2=^(3),X1=$P(X2,"^",7)+$P(X2,"^",9) I $J(X,0,2)'=$J(X1,0,2) W $C(7),!,"Adjustment $ Amount does not equal the total of BOC $ Amounts.",!,"Please correct the error.",! G ENA2
 S AMOUNT=$P($G(^PRCS(410,DA,4)),"^",6),$P(^PRCS(410,DA,4),"^",8)=AMOUNT
ENA3 ;D:$O(^PRCS(410,DA,12,0)) SCPC0^PRCSED
 S PO=$P($G(^PRCS(410,DA,4)),"^",5) I PO'="",$D(^PRC(442,"C",PO)) S REC=$O(^PRC(442,"C",PO,0)),PODATE=$P($G(^PRC(442,+REC,1)),"^",15) S DR="23///^S X=PODATE",DIE="^PRCS(410," D ^DIE
 L -^PRCS(410,DA)
 QUIT
ENFIS ;from fiscal's option
 N PRC,AMOUNT,PO,REC,PODATE,SITE
 N A,B,C,X,Y,Z
 D SITE^PRCB0C G EXIT:'$G(PRC("SITE"))
 D SUBSITE^PRCB0C G EXIT:'$G(PRC("SST"))&$D(^PRC(411,"UP",+PRC("SITE")))
 D FY^PRCB0C G EXIT:PRC("FY")="^" D QTR^PRCB0C G EXIT:'$G(PRC("QTR"))
 D FCP^PRCB0C G EXIT:'$G(PRC("CP")) D BBFY^PRCB0C G:'$G(PRC("BBFY")) EXIT
 S Z=PRC("SITE")_"-"_PRC("FY")_"-"_PRC("QTR")_"-"_$P(PRC("CP")," "),X=$P(Z,"-",1,2)_"-"_$P(PRC("CP")," ")
 D EN1^PRCSUT3 Q:'X  S X1=X D EN2^PRCSUT3 Q:'$D(X1)  S X=X1 D W L +^PRCS(410,DA):15 G ENFIS:$T=0 S $P(^PRCS(410,DA,0),U,2)="A"
 S DIE="^PRCS(410,",DR="25.5//NO" D ^DIE K DR G CT:$D(Y)
 D ADDADJ
 S T(1)="Adjustment" K PRCS58 D W3 G EXIT:%'=1 W !! G ENFIS
CT ;CANCEL AN ADJUSTMENT TRANSACTION
 S T=$P(^PRCS(410,DA,0),"^"),$P(^(11),"^",3)="",$P(^(0),"^",2)="CA",$P(^(5),"^")=0,$P(^(6),"^")=0 K ^PRCS(410,"F",+T_"-"_+PRC("CP")_"-"_$P(T,"-",5),DA),^PRCS(410,"F1",$P(T,"-",5)_"-"_+T_"-"_+PRC("CP"),DA),^PRCS(410,"AQ",1,DA)
 K ZX I $D(^PRCS(410,DA,4)) S ZX=^(4),X=-$P(ZX,"^",8) D EBAL^PRCSEZ(PRC("SITE")_"^"_PRC("CP")_"^"_PRC("FY")_"^"_PRC("QTR")_"^"_X,"C") I $P(ZX,"^",14)'="Y" D EBAL^PRCSEZ(PRC("SITE")_"^"_PRC("CP")_"^"_PRC("FY")_"^"_PRC("QTR")_"^"_X,"O")
 F I=1,3,6,8 S $P(ZX,"^",I)=0
 I $D(ZX) S ^PRCS(410,DA,4)=ZX K ZX
 I $D(^PRCS(410,DA,12,0)) S N=0 F  S N=$O(^PRCS(410,DA,12,N)) Q:N'>0  S X=$P(^(N,0),"^",2) I X S DA(1)=DA,DA=N D TRANK^PRCSEZZ S DA=DA(1)
 W !!,"This adjustment has been cancelled." G EXIT
ENC ;ENTER CEILING TRANSACTION
 D EN^PRCSUT G W2:'$D(PRC("SITE")) G EXIT:'$D(PRC("QTR"))!(Y<0) D EN1^PRCSUT3 Q:'X  S X1=X D EN2^PRCSUT3 Q:'$D(X1)  S X=X1 D W L +^PRCS(410,DA):15 G ENC:$T=0 S DIC(0)="AEMQ",DIE=DIC,DR="[PRCSENC]" D ^DIE
 L -^PRCS(410,DA) S T(1)="Ceiling" D W3 G EXIT:%'=1 W !! G ENC
CPU ;ENTER/EDIT CONTROL POINT USERS
 N PRCSSC S PRCSSC=0
 D EN3^PRCSUT G W2:'$D(PRC("SITE")),EXIT:Y<0 S DA(1)=PRC("SITE"),DA=+PRC("CP")
 I $D(PRCSC) S PRCSSC=PRCSC I '$D(^PRC(420,"A",DUZ,PRC("SITE"),+PRC("CP"),PRCSSC)) W !,"You cannot use this option for this control point." G EXIT
CPU1 D EDIT^PRC0B(.X,"420;^PRC(420,;"_DA(1)_"~420.01;^PRC(420,"_DA(1)_",1,;"_DA,"12;6","L")
 I X=-2 D EN^DDIOL("Fund control point is in use, try later.")
 D TUSER(+$P(PRC("CP")," "))
 Q
TUSER(CP) ;Check for IFCAP terminated users
 N A,XDA,ST,I,J
 W !!,"Checking for IFCAP terminated users...",!
 S XDA=0,ST=PRC("SITE"),I=0,J=0 F  S XDA=$O(^PRC(420,ST,1,CP,1,XDA)) Q:XDA=""  D
 . S A=$G(^VA(200,XDA,0))
 . I A="" D TUSER1 Q  ;Dangling pointer removed
 . I $D(^PRC(411,ST,8,XDA,0))#10=1 S I=I+1 D TUSER1  W !?5,$P(A,"^",1)," is deactivated and was removed as a Control Point User *"
 . D NOW^%DTC
 . I $P(A,"^",11)>0,$P(A,"^",11)<X S J=J+1 D TUSER1  W !?5,$P(A,"^",1)," is terminated and was removed as a Control Point User **"
 W !!
 I I>0 W "* CONTACT THE IFCAP APPLICATION COORDINATOR TO REACTIVATE THE USER" W:I>1 "S" W " *",!
 I J>0  W "** CONTACT IRM TO REACTIVATE IN FILE 200 **",!
 I J+I=0  W ?5,"None found",!
 Q
TUSER1 S DA=XDA,DA(1)=CP,DA(2)=ST,DIK="^PRC(420,"_DA(2)_",1,"_DA(1)_",1," D ^DIK K DIK
 Q
SENDIT2 ;
 N XX,XMDUZ,XMSUB,XMTEXT S XMDUZ="IFCAP PROCESSING",XX=$P($G(^PRCS(410,PRCHSY,7)),"^",1) S:XX="" XX=$P($G(^PRCS(410,PRCHSY,7)),"^",3)
 S XMTEXT="PRCSAR(",XMSUB="SPLIT TRANSACTION NOTIFICATION",XMY(XX)=""
 D ^XMD Q
W W !!,"This transaction is assigned transaction number: ",X Q
W1 W !!,"Sorry, you are not allowed to overcommit funds for control point ",$P(PRC("CP")," "),".",!,"Your current balance of $",PRCST1," is insufficient to cover the cost ($",PRCST,")",!,"of this request.  Contact Fiscal Service.",$C(7) Q
W2 W !!,"You are not an authorized control point user.",!,"Contact your control point official." R X:5 G EXIT
W3 W !!,"Would you like to enter another ",T(1)," transaction" S %=1 D YN^DICN G W3:%=0 Q
EXIT K DA,DIC,DIE,DR,PRCS,PRCS58,PRCSL,T,X,X1,DLAYGO Q
