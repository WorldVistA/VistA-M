RCEVGEN ;WASH-ISC@ALTOONA,PA/RGY - Account Management Adjustment ; 7/3/03 2:03pm
V ;;4.5;Accounts Receivable;**198,400**;Mar 20, 1995;Build 13
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
EN(TYPE) ;
DEB ;Make an adjustment to a debtor account
 N DLAYGO,DPTNOFZY,DPTNOFZK S (DPTNOFZY,DPTNOFZK)=1
 S DIC="^RCD(340,",DIC(0)="QEAML",DLAYGO=340 D ^DIC I Y>0 D ADJ(+Y,$G(TYPE))
 Q
ADJ(DEBT,TYPE) ;Adjust an account for DEBT (340 entry)
 NEW DIC,DA,X,Y,ERR,EVN,DIE,DR
 S SITE=$$SITE^RCMSITE() G:SITE'>0 Q2
 S DEBT=$P($G(^RCD(340,+$G(DEBT),0)),"^") G:'DEBT Q2
 I $G(TYPE)="" S DIC="^RC(341.1,",DIC(0)="QEAMZ",DIC("S")="I $G(^(1))]""""",DIC("A")="Type of EVENT or ADJUSTMENT: " D ^DIC G:Y<0 Q2 S TYPE=$P(Y(0),"^",2)
 D OPEN^RCEVDRV1(TYPE,DEBT,DT,DUZ,SITE,.ERR,.EVN)
 I ERR]""!(EVN<0) W !,"*** Oops, I experienced an error (",ERR,") trying to open a new event ***",! G Q2
 W !,"...OK, reference number assigned: ",$P(^RC(341,EVN,0),"^"),!
EDT S DR=$P($G(^RC(341.1,$O(^RC(341.1,"AC",TYPE,0)),1)),"^"),DIE="^RC(341,",DA=EVN D:DR]"" ^DIE
 S X=$$OK(EVN) G:X=0 EDT I X<0!(X["^") D DEL^RCEVDRV1(EVN) W " ... OK, Deleted",! G Q2
 D CLOSE^RCEVDRV1(EVN,.ERR)
 I ERR]"" W !,"*** Oops, I experienced an error ("_ERR_")",!,"...  trying to close this event ***"
Q2 Q
OK(EVN) ;OK an event or delete it
 NEW L,FLDS,BY,TO,DIC,IOP,DIR,DIRUT,DIROUT,DUOUT
 S L=0,FLDS=$P($G(^RC(341.1,+$O(^RC(341.1,"AC",+$P($G(^RC(341,EVN,0)),"^",2),0)),1)),"^",2),BY="@NUMBER",(FR,TO)=EVN,IOP=ION,DIC="^RC(341," D:FLDS]"" EN1^DIP
 W ! S DIR(0)="YA",DIR("B")="YES",DIR("A")="Is this OK? " D ^DIR K DIR
 S:$D(DTOUT) Y=-1
 Q Y
 ;
HRFSCMNT(DEBTOR) ; add a "patient high risk flag is set" comment to AR DEBTOR file  PRCA*4.5*400
 ;
 ; DEBTOR - file 340 ien
 ;
 D ADDCMNT(DEBTOR,"High Risk flag has been set","High Risk patient flag has been set for this debtor")
 Q
 ;
ADDCMNT(DEBTOR,BRIEF,FULL) ; add a comment to AR DEBTOR file (no user interaction) PRCA*4.5*400
 ;
 ; DEBTOR - file 340 ien
 ; BRIEF - brief comment (3-30 chars)
 ; FULL - full comment
 ;
 N DEBT,ERR,EVN,FDA,IENS,N0,SITE,TMP
 I DEBTOR'>0 Q
 I $G(BRIEF)=""!($G(FULL)="") Q
 S N0=$G(^RCD(340,DEBTOR,0)) I N0="" Q
 S SITE=$$SITE^RCMSITE() I SITE'>0 Q
 S DEBT=$P(N0,U)
 S TMP(1)=FULL
 D OPEN^RCEVDRV1(1,DEBT,DT,DUZ,SITE,.ERR,.EVN)  ; open an event, "comment" type
 I ERR]""!(EVN<0) Q
 S IENS=EVN_","
 S FDA(341,IENS,.06)=DT
 S FDA(341,IENS,2.01)="TMP"
 S FDA(341,IENS,4.01)=BRIEF
 L +^RCD(341,EVN):5 I '$T Q
 D FILE^DIE("","FDA")
 L -^RCD(341,EVN)
 D CLOSE^RCEVDRV1(EVN,.ERR)
 Q
