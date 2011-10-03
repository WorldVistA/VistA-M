IBARXMN ;LL/ELZ-PHARMCAY COPAY CAP RX PROCESSING ;17-NOV-2000
 ;;2.0;INTEGRATED BILLING;**150,158,156,186,308**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
TRACK(DFN) ; checks out patient if tracked already
 I '$D(^IBAM(354.7,DFN,0)) D QUERY(DFN,$E(DT,1,5)_"00")
 Q
 ;
QUERY(DFN,IBDT) ; if there are treating facilities, perform query
 N IBT,IBX,IBS,IBD,IBB,DIE,DA,DR,X,IBA,IBP,IBZ,IBY,IBFD,IBTD
 S IBB=0,IBP=$$PRIORITY^IBARXMU(DFN)
 D ADD^IBARXMU(DFN) Q:'IBP
 S IBT=$$TFL^IBARXMU(DFN,.IBT) Q:'IBT
 D CAP^IBARXMC(IBDT,IBP,.IBZ,.IBY,.IBFD,.IBTD) I 'IBY,'IBZ Q
 I 'IBFD!('IBTD) Q
 W !!,"This patient has never had billing information tracked before",!,"Now querying other facilities..."
 S IBX=0 F  S IBX=$O(IBT(IBX)) Q:IBX<1  W !,"Now sending query to ",$P(IBT(IBX),"^",2)," ..." D
 . ;
 . ; need to query every month in the cap billing period
 . S IBDT=IBFD D  F  S IBDT=$$NEXTMO^IBARXMC(IBDT) Q:IBDT>IBTD  D
 .. D UQUERY^IBARXMU(DFN,$E(IBDT,1,5)_"00",IBX,.IBD)
 .. ;
 .. ; error returned
 .. I -1=+$G(IBD,"-1") Q
 .. ;
 .. ; loop through query and file data
 .. S X=0 F  S X=$O(IBD(X)) Q:X<1  S:$E(IBD(X),1,4)=+IBT(IBX)_"-" IBA=$$ADD(DFN,IBD(X)),IBB=IBB+$P(IBD(X),"^",11)
 .. K IBD
 ;
 Q
 ;
ACCT(DFN,IBB,IBU,IBDT,IBS) ; - update amount in patient account
 ; IBB = amount to be added to pt account (billed)
 ; IBU = amount to be added to pt account (not billable)
 ; IBDT = effective date for amount
 ; IBS = flag, if passed the amounts are totals not to be added to what is already there
 ;
 N DIE,DR,DO,DIC,DA,Y,IBA
 ;
 S DA(1)=DFN,IBDT=$E(IBDT,1,5)_"00"
 ;
 ; check to see if there is already that mo/year there and add if not
 S DA=$O(^IBAM(354.7,DFN,1,"B",IBDT,0))
 I 'DA S DIC="^IBAM(354.7,"_DFN_",1,",DIC(0)="",X=IBDT D FILE^DICN S DA=+Y
 ;
 ; now edit and add the new amount
 S IBA=^IBAM(354.7,DFN,1,DA,0)
 S:'$D(IBS) IBB=IBB+$P(IBA,"^",2),IBU=IBU+$P(IBA,"^",4)
 L +^IBAM(354.7,DFN):10 I '$T Q
 S DIE="^IBAM(354.7,"_DFN_",1,",DR=".02///^S X=IBB;.04///^S X=IBU"
 D ^DIE L -^IBAM(354.7,DFN)
 ;
 D FLAG^IBARXMC(DFN,IBDT)
 ;
 Q
 ;
UPCHG(IBX,IBU,IBC) ; update a charge (from one that is on hold only)
 ; IBX = ien in 354.71
 ; IBU = updated # of units
 ; IBC = updated charge amount
 N IBO,IBY,DIE,DA,DR
 W !,"Updating copay cap account records..."
 S IBO=^IBAM(354.71,IBX,0)
 ;
 ; first update 354.71 entry
 S DIE="^IBAM(354.71,",DA=IBX,DR=".07///^S X=IBU;.08///^S X=IBC;.11///^S X=IBC;.05///P"
 L +^IBAM(354.71,DA):10 I '$T W !!,"Unable to update records, entry locked!!" Q
 D ^DIE L -^IBAM(354.71,DA)
 ;
 ; now update account
 D ACCT($P(IBO,"^",2),IBC-$P(IBO,"^",11),0,$P(IBO,"^",3))
 ;
 ; send to IDX
 I $$SWSTAT^IBBAPI S IBO=$$QUEUE^VDEFQM("DFT^P03","SUBTYPE=CPIN^IEN="_IBX,,"PFSS OUTBOUND")
 ;
 ; finally clean transmission record
 D CLEAN(IBX)
 ;
 Q
CLEAN(IBX) ; clean out transmission record
 N IBA,DA,DIK,X,Y
 S IBA=0 F  S IBA=$O(^IBAM(354.71,IBX,1,IBA)) Q:IBA<1  S DA=IBA,DA(1)=IBX,DIK="^IBAM(354.71,"_IBX_",1," D ^DIK
 Q
 ;
CANCEL(DFN,IBX,IBY,IBR) ; cancel a transaction (flags old one and creates a new one)
 ; IBX is the ien from 354.71, IBY is the error flag (y) passed by ref
 ; IBR is optional, it is the reason to cancel
 ;
 N IBN,IBD,DIE,DA,DR,X,Y
 ;
 ; is IBX there or is this an old transaction
 S IBD=$G(^IBAM(354.71,+IBX,0)) I 'IBD S IBN=0 G CANQ
 S IBAMP=$P($G(^IBAM(354.71,+$P(IBD,"^",10),0)),"^")
 ;
 ; set flag for at or above cap
 S:'$D(IBCAP) IBCAP=+$P($G(^IBAM(354.7,DFN,1,+$O(^IBAM(354.7,DFN,1,"B",$E($P(IBD,"^",3),1,5)_"00",0)),0)),"^",3)
 ;
 ; flag old one as canceled, and clean out transmission record.
 S DIE="^IBAM(354.71,",DA=IBX,DR=".05///Y;.16///"_DUZ_";.17///"_$$NOW^XLFDT_";.19///"_$S($D(IBR):IBR,1:16)
 L +^IBAM(354.71,IBX):5 I '$T S IBY="-1^IB318",IBN=0 G CANQ
 D ^DIE L -^IBAM(354.71,IBX)
 D CLEAN(IBX)
 ;
 ; send to IDX
 I $$SWSTAT^IBBAPI S IBO=$$QUEUE^VDEFQM("DFT^P03","SUBTYPE=CPIN^IEN="_IBX,,"PFSS OUTBOUND")
 ;
 ; now create new transaction to adjust amounts
 ; first set up parent, clear out .01, set facility, - dollar amt, status
 S $P(IBD,"^",10)=$P(IBD,"^"),$P(IBD,"^")="",$P(IBD,"^",13)=+$P($$FAC^IBARXMU(+$$SITE^IBARXMU),"^",2),$P(IBD,"^",11)=-$P(IBD,"^",11),$P(IBD,"^",12)=-$P(IBD,"^",12),$P(IBD,"^",5)="P"
 S IBN=$$ADD(DFN,$P(IBD,"^",1,13)) I IBN<1 S IBY="-1^IB316"
 ;
 ; set up variable to check for cap and re-bill if necessary
 S IBCAP($E($P(IBD,"^",3),1,5)_"00")=""
 ;
 ; now check to see if the patient has previously reached cap and has some unbilled (only if not updating, check for flag)
 ;I '$G(IBUPDATE) D CANCEL^IBARXMC(DFN,$P(IBD,"^",3))
 ;D CANCEL^IBARXMC(DFN,$P(IBD,"^",3))
 ;
CANQ Q IBN
 ;
ADD(DFN,IBD,IBT,IBPFSS) ; adds a transaction to 354.71
 ; IBD = data in 354.71 format, if $p(IBD,"^")="" create new number
 ; IBT = action type pointer (optional, but needed for local site)
 ; returns ien in 354.71
 ; IBPFSS optional to indicate came from PFSS system
 ;
 N IBA,DIC,X,IBS,IBN
 Q:'$G(DFN)
 D ADD^IBARXMU(DFN)
 I $P(IBD,"^") S IBA=$O(^IBAM(354.71,"B",$P(IBD,"^"),0)) D  Q IBA
 . ;I IBA D TRANF(DFN,IBA,IBD,$G(IBT)) Q
 . I 'IBA S DIC="^IBAM(354.71,",DIC(0)="",X=$P(IBD,"^") D FILE^DICN S IBA=+Y
 . I IBA>0 D TRANF(DFN,IBA,IBD,$G(IBT)),ACCT(DFN,$P(IBD,"^",11),$P(IBD,"^",12),$P(IBD,"^",3))
 K DO S DIC="^IBAM(354.71,",DIC(0)="",IBS=+$P($$SITE^IBARXMU,"^",3)
 ;
 ; get next number and file
 F  L +^IBAM(354.71,0):20 I $T S IBN=$P(^IBAM(354.71,0),"^",3) S:'IBN IBN=0 Q
 I +$G(^IBAM(354.71,+IBN,0))'=IBS,IBN F  S IBN=$O(^IBAM(354.71,IBN),-1) Q:IBS=+$G(^IBAM(354.71,IBN,0))!('IBN)
 S IBN=$P($P($G(^IBAM(354.71,+IBN,0)),"^"),"-",2)+1 F IBN=IBN:1 S X=IBS_"-"_IBN I '$D(^IBAM(354.71,"B",X)) L +^IBAM(354.71,"B",X):10 I $T D FILE^DICN L -^IBAM(354.71,"B",X) I Y>0 S IBA=+Y Q
 L -^IBAM(354.71,0)
 ;
 D TRANF(DFN,IBA,IBD,$G(IBT),$G(IBPFSS)),ACCT(DFN,$P(IBD,"^",11),$P(IBD,"^",12),$P(IBD,"^",3))
 ;I '$G(IBUPDATE) D CANCEL^IBARXMC(DFN,$P(IBD,"^",3))
 ;
 Q IBA
 ;
TRANF(DFN,IBA,IBD,IBT,IBPFSS) ; file transaction data in 354.71
 ; DFN = patient's dfn
 ; IBA = ien from file 354.71
 ; IBD = data in global file format for file 354.71
 ; piece 2 will be changed to dfn
 ; pieces 10 and 13 will be resolved
 ; pieces 14,15 will be created new if they don't exist
 ; pieces 16,17 will be created new
 ; piece 18 will be filled if not $g(IBT)=""
 ;
 N X,Y,IBZ,IBN,D,IBU,DIC,IBPAR,DA,DIK Q:'$D(^IBAM(354.71,IBA,0))
 ;
 X $S($P(IBD,"^")=$P(IBD,"^",10):"S $P(IBD,""^"",10)=IBA",1:"S X=$P(IBD,""^"",10),D=""B"",DIC=""^IBAM(354.71,"",DIC(0)=""OX"" D IX^DIC S $P(IBD,""^"",10)=$S(Y>0:+Y,1:"""")")
 S IBPAR=$$PARENT^IBARXMC(+$P(IBD,"^",10)) S:IBPAR $P(IBD,"^",10)=IBPAR
 S DIC="^DIC(4,",DIC(0)="O",X=$P(IBD,"^",13),D="D" D IX^DIC
 S IBS=$S(Y>0:+Y,1:"")
 S IBN=$$NOW^XLFDT,IBU=$P(^IBAM(354.71,IBA,0),"^",14,15)
 ;
 S $P(^IBAM(354.71,IBA,0),"^",2,18)=DFN_"^"_$P(IBD,"^",3,12)_"^"_IBS_"^"_$S(+IBU:+IBU,$D(IBDUZ):IBDUZ,1:DUZ)_"^"_$S($P(IBU,"^",2):$P(IBU,"^",2),1:IBN)_"^"_$S($D(IBDUZ):IBDUZ,1:DUZ)_"^"_IBN_$S($G(IBT):"^"_IBT,1:"")
 S DA=IBA,DIK="^IBAM(354.71," D IX^DIK
 I $$SWSTAT^IBBAPI,'$G(IBPFSS) S X=$$QUEUE^VDEFQM("DFT^P03","SUBTYPE=CPIN^IEN="_IBA,,"PFSS OUTBOUND") ; use IBA as the IEN
 Q
