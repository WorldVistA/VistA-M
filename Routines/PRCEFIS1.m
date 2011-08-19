PRCEFIS1 ;WISC/CTB/CLH-RETURN 1358 TO SERVICE ; 08/25/93  9:53 AM
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 N PRC,PRCFA,PRCF,DIR,DIE,DIC,DA,DR,X,Y,%,AMT,MSG,PRCFAT
 S PRCF("X")="AB" D ^PRCFSITE Q:'%  S TT="OA" D LOOKUP^PRCEOB Q:Y<0  S (DA,TRDA)=+Y,TRDA(0)=Y(0)
 W ! S DIR("A")="Is this the correct transaction",DIR("B")="YES",DIR(0)="Y"
 S DIR("?",1)="Enter 'YES' or'Y' or 'RETURN' if it correct."
 S DIR("?")="Enter 'NO' or 'N' or '^' to exit this option."
 D ^DIR K DIR Q:'Y
 W ! S DIR("A",1)="This action will remove the electronic signature of the approving official"
 S DIR("A",2)="and will allow editing or cancellation of the request.",DIR("A",3)=" "
 S DIR(0)="Y",DIR("A")="OK to continue",DIR("B")="YES"
 S DIR("?",1)="Enter 'RETURN' or 'YES'  or 'Y' to return this request to the service."
 S DIR("?")="Enter 'NO' or 'N' or '^' to exit this option."
 D ^DIR K DIR Q:Y=0!(Y["^")
 S DIE="^PRCS(410,",DR="61" D ^DIE I $D(Y) S X="No action taken*" D MSG^PRCFQ G OUT
 ;S AMT=$P(^PRCS(410,DA,4),"^",8),X=AMT D TRANK^PRCSES S $P(^PRCS(410,DA,7),"^",5,7)="^^",$P(^PRCS(410,DA,10),"^",4)=$O(^PRCD(442.3,"AC",9,0))
 S AMT=$P(^PRCS(410,DA,4),"^",8),X=AMT D TRANK^PRCSES S $P(^PRCS(410,DA,7),"^",5)="" D REMOVE^PRCSC1(DA) S $P(^PRCS(410,DA,10),"^",4)=$O(^PRCD(442.3,"AC",9,0))
 D EN,OUT G V
EN ;SENDS RETURNING TRANSACTION MESSAGE.
 S PRCFAT=$P(TRDA(0),"^",4),PRCFAT=$S($P(^PRCS(410.5,PRCFAT,0),"^")'["1358":"2237",1:"1358")
 I $S('$D(PRCFA("WHO")):1,PRCFA("WHO")="":1,1:0) S PRCFA("WHO")=1
 S PRCFA("WHO")=$P("FISCAL^PURCHASING AND CONTRACTING^PROPERTY MANAGEMENT","^",PRCFA("WHO"))
 K MSG S MSG(1,0)="The following "_PRCFAT_" transaction was not processed ",MSG(2,0)="by "_PRCFA("WHO")_" and is returned without action",MSG(3,0)="for the reason(s) indicated.",MSG(4,0)="   "
 S MSG(5,0)="Transaction Number: "_$P(TRDA(0),"^")_"    Amount: $ "_$J($P(^PRCS(410,DA,4),"^",8),0,2),MSG(6,0)="   ",MSG(7,0)=$S(PRCFAT="2237":"Justification: ",1:"Purpose:  ")
 I $D(^PRCS(410,DA,8,0)) S N=0 F MSG=7:1 S N=$O(^PRCS(410,DA,8,N)) Q:'N  I $D(^(N,0)),^(0)]"" S MSG(MSG,0)=$S($D(MSG(MSG,0)):MSG(MSG,0)_^(0),1:^(0))
 S (MSG,N)=3 F I=1:1 S N=$O(MSG(N)) Q:'N  S MSG=N I $D(MSG(MSG,0)),$D(PRCFASK) W !,MSG(MSG,0)
 S:$D(MSG(MSG,0)) MSG=MSG+1 S MSG(MSG,0)="    "
 S X="Reason for Return: "_$S($D(^PRCS(410,DA,13,0)):"",1:"Not Specified")
 K ^UTILITY($J,"W") S DIWL=0,DIWR=79,DIWF="" D DIWP^PRCUTL($G(DA)) F PRCFI=0:0 S PRCFI=$O(^PRCS(410,DA,13,PRCFI)) Q:'PRCFI  I $D(^(PRCFI,0)) S X=^(0) D DIWP^PRCUTL($G(DA))
 S N=0,X=MSG+1 F MSG=X:1 S N=$O(^UTILITY($J,"W",0,N)) Q:'N  I $D(^(N,0)),^(0)]"" S MSG(MSG,0)=^(0)
 K ^UTILITY($J,"W") S XMSUB=PRCFAT_" TRANSACTION RETURN NOTIFICATION" D MSG
 I $D(PRCFASK) K PRCFASK S X="Transaction returned, bulletin transmitted.*" D MSG^PRCFQ Q
 Q
OUT ;EXIT LINE FOR ROUTINE
 D DIWKILL^PRCFQ
 K %H,%I,AMT,C,D,D0,DA,DI,DIC,DIE,DIWF,DIWL,DIWR,DQ,DR,DWLW,ER,H,I,J,K,M,MSG,N,PATNUM,PRCF,PRCFA,TRDA,X,X1,X2,XMDUZ,XMSUB,XMTEXT,XMY,Y,PRCFASK,PRCFA("WHO"),PRCFAT Q
BULLET ;FIRE BULLETIN FOR OBLIGATION
 K ^UTILITY($J),MSG S DIWL=0,DIWR=79,DIWF=""
 S MSG(1,0)="A 1358 transaction with number "_$P(TRNODE(0),"^")_" has just been obligated by Fiscal Service.  Transaction information is as follows:"
 S MSG(2,0)="   ",MSG(3,0)="Transaction Number: "_$P(TRNODE(0),"^")_"        Amount: $"_$J(AMT,0,2),MSG(4,0)="   ",MSG(5,0)=" Obligation Number: "_PATNUM,MSG(6,0)="   ",MSG(7,0)="Purpose: "
 S N=0 F I=7:1 S N=$O(^PRCS(410,DA,8,N)) Q:'N  I $D(^(N,0)),^(0)]"" S MSG(I,0)=$S($D(MSG(I,0)):MSG(I,0)_^(0),1:^(0))
 S MSG(I,0)="    ",MSG(I+1,0)="Please note the assigned obligation number for future reference.",XMSUB="1358 OBLIGATION NOTIFICATION"
 D MSG W !!,"...Control Point has been notified of this transaction...",!
 Q
MSG ;SET VARIABLES AND CALL XMD
 S XMDUZ=DUZ,X=$S($D(^PRCS(410,DA,7)):^(7),1:"") F I=1,3 I $P(X,"^",I)]"" S X1=$P(X,"^",I) I X1]"" S XMY(X1)=""
 S PRC("CP")=$P(^PRCS(410,DA,0),"-",4) D NAMES^PRCBBUL S XMTEXT="MSG(" D WAIT^PRCFYN,^XMD Q
RETURN ;ENTRY POINT FOR NON 1358 TRANSACTION RETURNS
 ;REQUIRES PRCFA("TRDA")=INTERNAL NUMBER IN FILE 410, PRCFA("WHO")=SERVICE RETURNING TRANSACTION. 1=FISCAL, 2=P&C, 3=PPM  IF MISSING WILL AUTOMATICALLY MAKE IT FISCAL.
 I '$D(PRCFA("TRDA")) Q
 S (TRDA,DA)=PRCFA("TRDA"),TRDA(0)=^PRCS(410,TRDA,0),PRC("SITE")=+TRDA(0)
 D EN,DIWKILL^PRCFQ K DN,MSG,PRCFAT,PRCFA("WHO"),TRDA,DA,XMTEXT,XMSUB,XMDUZ,XMY,J,K,N,PRCFI,X,X1,X2
 Q
