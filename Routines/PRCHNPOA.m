PRCHNPOA ;WISC/RL/DXH - CHANGE TRANS. NUMBER FOR PCO INITIATED 2237 ;8.2.99
V ;;5.1;IFCAP;**135**;Oct 20, 2000;Build 7
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ; This code is called after a user electronically signs a purchase
 ; card order.  If the FCP on the 2237 does not match the one in the 
 ; the transaction number for the 2237 entry, this code will change
 ; the existing transaction number for the 2237.   To do this, a new
 ; ien is created and populated with info from the existing transaction,
 ; then canceled.  The original transaction is updated with the new
 ; transaction number.
 ; (This code is a simplified of ANTN^PRCSUT2, which is called by the
 ; IFCAP option "Change Existing Transaction Number" 
 ;
 ;Inputs: param PCODA is the IEN of the Purchase Card Order in 442 file.
 ;Return Values: none
 ;Globals modified: ^PRCS(410  (if necessary)
 ;
CHECKFCP(PCODA) ;Check FCP in 2237 entry of the 410 file to see if it matches Trans #
 ;
 N CURFCP,ODA,OTNUM,OCP,OLDFYQ,CURFYQ,TDATE,SDATE
 S ODA=+$P($G(^PRC(442,PCODA,23)),U,23) ; ODA is the IEN for the old 410 entry
 S OTNUM=$P($G(^PRCS(410,ODA,0)),U,1) ; OTNUM is transaction # for old 410 entry
 S OCP=$P(OTNUM,"-",4) ;               OCP is the original FCP for trans.
 S CURFCP=$P($G(^PRCS(410,ODA,3)),U,1) ;  CURFCP is the current (valid) FCP for trans.
 ;Patch prc*5.1*135 now checks order date change, besides FCP
 S OLDFYQ=$P(OTNUM,"-",2,3),CURFYQ=PRC("FY")_"-"_PRC("QTR")
 Q:CURFCP=""&(OCP="") 
 I (+CURFCP'=+OCP)!(CURFYQ'=OLDFYQ) D MODTXN
 Q
 ;
MODTXN ;Modify the transaction number for the 2237 entry in the 410 file
 N %,%Y,D,DA,DIC,DIE,DR,I,J,L,ONODE0,N,PNW,PRCS,PRCSAPP,PRCSDIC,PRCSIP
 N PRCSL,PRCSY,T,T0,T1,T2,T4,T5,TX1,X,X1,Y,Z0
 L +^PRCS(410,ODA):1
 I $T=0 W !,"File being accessed...please change the transaction number later" G EXIT
 S ONODE0=^PRCS(410,ODA,0) ; node 0 string of txn to be replaced
 S T2=OTNUM ;T2 is needed in PRCSUT call later
 S T5=$P(ONODE0,"^",10) ; substation
 S T4=$P(ONODE0,"^",2) ; txn type of transaction to be replaced
 S PRC("SITE")=$P(OTNUM,"-"),PRC("CP")=CURFCP
 S PRC("BBFY")=$$BBFY^PRCSUT(PRC("SITE"),PRC("FY"),+PRC("CP"),1)
 S X=PRC("SITE")_"-"_PRC("FY")_"-"_$P(CURFCP," ")
 S Z=PRC("SITE")_"-"_PRC("FY")_"-"_PRC("QTR")_"-"_$P(CURFCP," ")
 D EN1^PRCSUT3 ; generate new name for txn and put in X
 G:'$G(X) EXIT
 S TX1=X
 S (DIC,DIE)="^PRCS(410,"
CK K DA
 S DLAYGO=410,DIC="^PRCS(410,",DIC(0)="LXZ"
 D ^DIC
 K DLAYGO
 G:Y'>0 EXIT
 S DA=+Y
 L +^PRCS(410,DA):1 ; Lock new ien
 I '$T W !," Cannot create new number...please try again later." G EXIT
 ;
 ; swap transaction xrefs between iens (kill old, then set reversed)
 ; (nodes 'B','B2','B3','AE')
 K ^PRCS(410,"B",TX1,DA)
 K ^PRCS(410,"B2",$P(TX1,"-",5),DA)
 K ^PRCS(410,"B3",$P(TX1,"-",2)_"-"_$P(TX1,"-",5),DA)
 K ^PRCS(410,"AE",$P(TX1,"-",1,4),DA)
 K ^PRCS(410,"B",OTNUM,ODA)
 K ^PRCS(410,"B2",$P(OTNUM,"-",5),ODA)
 K ^PRCS(410,"B3",$P(OTNUM,"-",2)_"-"_$P(OTNUM,"-",5),ODA)
 K ^PRCS(410,"AE",$P(OTNUM,"-",1,4),ODA)
 K ^PRCS(410,"RB",$P(ONODE0,U,11)_"-"_$P(OTNUM,"-")_"-"_$P(OTNUM,"-",4)_"-"_$P(OTNUM,"-",2)_"-"_$P(OTNUM,"-",5),ODA)
 S ^PRCS(410,"B",OTNUM,DA)=""
 S ^PRCS(410,"B2",$P(OTNUM,"-",5),DA)=""
 S ^PRCS(410,"B3",$P(OTNUM,"-",2)_"-"_$P(OTNUM,"-",5),DA)=""
 S ^PRCS(410,"AE",$P(OTNUM,"-",1,4),DA)=""
 S ^PRCS(410,"B",TX1,ODA)=""
 S ^PRCS(410,"B2",$P(TX1,"-",5),ODA)=""
 S ^PRCS(410,"B3",$P(TX1,"-",2)_"-"_$P(TX1,"-",5),ODA)=""
 S ^PRCS(410,"AE",$P(TX1,"-",1,4),ODA)=""
 ;
CK1 ; set old txn name into new ien, new txn nam into old (original) ien
 ;
 S $P(^PRCS(410,DA,0),"^")=OTNUM
 S $P(^PRCS(410,ODA,0),"^")=TX1
 S PRC("OCP")=$P(^PRCS(410,ODA,3),U)
 ; cancel txn at new ien; force old site & CP info into new ien
 S DIE="^PRCS(410,",DR=".5///"_+OTNUM_";S X=X;15///"_$$EXPANDCP(+OTNUM,OCP)
 S DR=DR_";60///Transaction "_OTNUM_" replaced by trans. "_TX1
 S DR=DR_";450///C" ;put cancel flag in Running Bal status 
 D ^DIE
 I T5'="" S $P(^PRCS(410,DA,0),U,10)=T5 ; save substation in new ien
 S $P(^PRCS(410,DA,0),U,2)="CA" ; cancel txn at new ien
 D ERS410^PRC0G(DA_"^C")
 D W5^PRCSEB ; kill flags & x-refs indicating cancel txn is ready to approve
 L -^PRCS(410,DA) ; release new ien
 I $D(^PRC(443,ODA,0)) S DA=ODA,DIK="^PRC(443," D ^DIK K DA,DIK
EN S PNW=ODA,PNW(1)=TX1
 N A,B
 S A=TX1 D RBQTR ; returns B for DR string (RB Qrtr date)
 S DA=PNW,DR=B_$S(+OTNUM:"1///"_T4,1:"")_$S(PRC("SITE")'=+OTNUM:";S X=X;.5///"_PRC("SITE"),1:"")_$S(PRC("CP")'=CURFCP:";S X=X;15///"_PRC("CP"),1:"")_$S($D(PRCSIP):";4////"_PRCSIP,1:"")
 D ^DIE
 S PRC("ACC")=$$ACC^PRC0C(PRC("SITE"),PRC("CP")_"^"_PRC("FY")_"^"_PRC("BBFY"))
 S PRCSAPP=$P(PRC("ACC"),"^",11)
 S $P(^PRCS(410,DA,3),"^")=PRC("CP")
 S $P(^PRCS(410,DA,3),"^",2)=PRCSAPP
 S $P(^PRCS(410,DA,3),"^",12)=$P(PRC("ACC"),"^",3)
 S $P(^PRCS(410,DA,3),"^",11)=$P($$DATE^PRC0C(PRC("BBFY"),"E"),"^",7)
 N MYY S MYY="" D EN2B^PRCSUT3 ; save substation & process with status of entered
 D K^PRCSUT1 ; kill 'F', 'F1', x-refs
 S (DA,PRCS,PRCSY)=PNW
EN1 K PRCSQ
 L -^PRCS(410,ODA)
 G EXIT
EXIT I $D(ODA) L -^PRCS(410,ODA)
 K PRC("ACC"),PRC("OCP")
 Q
 ;
RBQTR N C,D S B="",B=$S(B="":$P(A,"-",2)_"^F",1:+$$DATE^PRC0C(B,"I"))
 S C=$$QTRDT^PRC0G($P(A,"-",1)_"^"_$P(A,"-",4)_"^"_B)
 S D=$$QTRDATE^PRC0D($P(A,"-",2),$P(A,"-",3)),D=$P(D,"^",7)
 S B=$S(D<$P(C,"^",3):$P(C,"^",3),$P(C,"^",2)<D:$P(C,"^",2),1:D)
 S B="449////"_B_";"
 QUIT
 ;
EXPANDCP(STA,CP) ;RETURN FULL CP NAME BASED ON CP NUMBER AND STATION #
 N Z
 S Z=$P($G(^PRC(420,STA,1,+CP,0)),"^",1)
 I (Z="") S Z=CP
 Q Z
