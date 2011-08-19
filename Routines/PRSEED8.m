PRSEED8 ;HISC/MD-PRSE ATTENDANCE UPDATE ;06/09/94
 ;;4.0;PAID;**18**;Sep 21, 1995
EN1 ; ENTRY FROM OPTION PRSE-ATTD-CLS
 S X=$G(^PRSE(452.7,1,"OFF")) I X=""!(X=1) D MSG6^PRSEMSG Q
 D EN2^PRSEUTL3($G(DUZ)) I PRSESER=""&'(DUZ(0)="@") D MSG3^PRSEMSG G Q
 ;
 S NOUT=0,DIR(0)="SO^M:Mandatory Training (MI);C:Continuing Education;O:Other/Miscellaneous;W:Ward/Unit-Location Training",DIR("A")="Select a Training Type" D ^DIR K DIR G:$D(DTOUT)!($D(DUOUT))!(U[X)!(Y="") Q S PRSETYP=Y
 ;
 W ! K Y S PRSE=0,DIC="^PRSE(452.1,",DIC("A")="Select CLASS: ",DIC(0)="AEMQZ",DIC("W")="W ?($X+5),$P($G(^PRSP(454.1,+$P(^(0),U,8),0)),U),""  """,DIC("S")="I +$$DICS1^PRSEUTL(.PRSE)"
 D ^DIC K DIC I $D(DTOUT)!($D(DTOUT))!(U[X)!'(+Y>0) G Q
 S PRSEMI=+Y,PRSEPROG(1)=Y(0),PRSELEN=+$P(Y(0),U,3),X=$P(Y,U,2),DIC="^PRSE(452.8,",DIC(0)="Z",DIC("S")="I $P(^(0),U)=PRSEMI" K Y D ^DIC K DIC I $D(DTOUT)!($D(DUOUT))!'(+Y>0)!(U[X) S POUT=1 G Q
 ;
 S (PRX,PRDA(2))=+Y,PRSEY=Y(0),PRSEPROG=Y(0,0),Y=$$EN8^PRSEUTL3($G(PRX)) S:$G(Y)'="" DIC("B")=PRSEDT
DATE W ! S DA(1)=PRDA(2),DIC(0)="AEMQZ",DIC="^PRSE(452.8,DA(1),3,",DIC("S")="I '(+^(0)\1>DT)",DIC("W")="I $P(^(0),U,5)=0 W ?($X+1),""* REGISTRATION UNAVAILABLE *"""
 D ^DIC K DIC I $D(DTOUT)!($D(DUOUT))!("^"[X) G Q
 W ! S PRDA(1)=+Y,PRDAT=$P(Y,U,2),Y=""
 ;
STUD ; STUDENT SELECTION
 K POUT
 I $S($G(DUZ(0))["@":1,+$$EN4^PRSEUTL3($G(DUZ)):1,1:0) I $P($G(^PRSE(452.7,1,0)),U,3) D  G:$G(POUT(1)) Q G STUD1
 . ;allow adding to 200 if user authorized
 . W !
 . S X=$$ADD^XUSERNEW(9)
 . I +$G(X)'>0 S POUT(1)=1 Q
 . S PRDA=+X,X=$P(X,U,2)
 ;
 I $S(+$P($G(^PRSE(452.7,1,0)),U,3)'>0:1,'+$$EN4^PRSEUTL3($G(DUZ)):1,$G(DUZ(0))'["@":1,1:0) D
 . ;if laygo to 200 not allowed
 . S DIC("A")="Select Student Name: "
 . S DIC=200,DIC(0)="AEQM"
 . W ! D ^DIC K DIC I +Y'>0 S POUT(1)=1 Q
 . S X=$P(Y,U,2),PRDA=+Y,PRDA(0)=Y
 . ;S DA=PRDA,DIE=DIC,DR="9R" D ^DIE K DIC,DIE,DR,DA
 . S Y=PRDA(0)
 ;
STUD1 G:$G(POUT(1)) Q
 ; **** PROCESS RESGISTERED STUDENT *****
 S DA(2)=PRDA(2),DA(1)=PRDA(1) I $D(^PRSE(452.8,DA(2),3,DA(1),1,0)) S DIC="^PRSE(452.8,DA(2),3,DA(1),1,",DIC(0)="EMZ",DIC("W")="S PRDA=+^(0) W ?($X+3),$P($G(^PRSP(454.1,+$$EN3^PRSEUTL3($G(PRDA)),0)),U)" K Y D ^DIC K DIC G:(X=U) Q
 I +Y>0,$P(Y,U,2)>0 S N1=+$P(Y,U,2)
 I '(+Y>0)!(X["?") D
 .  ; **** PROCESS UNREGISTERED NON-EMPLOYEE *****
 .  I +$G(PRDA)>0 S N1=+PRDA Q
 .  Q
 S:'$G(N1) N1=+$G(PRDA)
 G Q:$D(POUT(1)) S VA200DA=+$G(N1),N1=$P(^VA(200,VA200DA,0),U)
 S PRSESSN=$P($G(^VA(200,VA200DA,1)),U,9) I $G(PRSESSN)="" W $C(7),!!,"NO SSN OR NEW PERSON (#200) FILE ENTRY FOR THIS EMPLOYEE-CANNOT CONTINUE" W ! S X="?" Q
 D ADD I $G(POUT)=1 K POUT G STUD
 S Y="" W ! G STUD
ADD ;
 I $D(^PRSE(452,"AA",PRSETYP,VA200DA,PRSEPROG,9999999-PRDAT)) W !!?5,$C(7),N1," completed "_PRSEPROG_" on this date." S Y="",DA=$O(^PRSE(452,"AA",PRSETYP,VA200DA,PRSEPROG,9999999-PRDAT,0)) D DEL1^PRSEED3 Q
 S PRSESVC=+$$EN3^PRSEUTL3($G(VA200DA)),PRSESVC=$P($G(^PRSP(454.1,+PRSESVC,0)),U) S:PRSESVC="" PRSESVC="NON-EMPLOYEE"
 W !!,"Do you want to credit "_N1_" - "_PRSESVC_" for attending ",!,PRSEPROG S %=1 D YN^DICN I %=0 W $C(7),!!,"Answer YES or NO." G ADD
 I '(%=1) S POUT=1 Q
 D ADD^PRSEED9 I '$D(POUT) W !!?7,N1,$C(7),?($X+3),PRSEPROG,?39," " S Y=PRDAT D DT^DIQ W !
UNLOC L -^PRSE(452.8,DA(2),0) K DIR
 Q
KILL K:X[""""!($A(X)=45) X I $D(X) K:$L(X)>30!($L(X)<3)!(X'?1U.UP1","1U.UP) X
 Q
Q ;
 D ^PRSEKILL
 Q
