FBSHAUT ;WCIOFO/SAB-ENTER/EDIT STATE HOME AUTHORIZATION ;2/9/1999
 ;;3.5;FEE BASIS;**13**;JAN 30, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
ADD ; Enter new authorization
 ; Called from option FBSH ENTER AUTH
 D SETUP
 I 'FBPOP F  D  Q:'$G(DFN)
 . ; select patient
 . D PAT Q:'$G(DFN)
 . ; show patient demographics
 . S FBPROG(0)=FBPROG
 . S FBPROG="I $P(^(0),U,3)=FBPROG(0)"
 . D ^FBAADEM
 . S FBPROG=FBPROG(0)
 . ; get dates
 . D BDATES
 . I FBBEGDT]"" D
 . . ; add/edit authorization
 . . S DA(1)=DFN,X=FBBEGDT
 . . S DIC="^FBAAA("_DA(1)_",1,",DIC(0)="LQ",DLAYGO=161
 . . S DIC("DR")=".02////^S X=FBENDDT;.03////^S X=FBPROG;.095////4;100////^S X=DUZ;S FBTYPE=FBPROG;.07"
 . . S DIC("P")=$P(^DD(161,1,0),U,2)
 . . K DD,DO D FILE^DICN K DIC,DLAYGO
 . . I Y'>0 W $C(7),!,"AUTH. NOT ADDED" Q
 . . S (DA,FBAAADA)=+Y
 . . ; edit remaining fields
 . . S DIE="^FBAAA("_DA(1)_",1,"
 . . S DR=".04;.021"
 . . D ^DIE K DIE
 . . ; queue MRA
 . . S FBX=$$QMRA(DFN,FBAAADA,"A")
 . ;
 . ; unlock patient
 . L -^FBAAA(DFN,FBPROG)
 D WRAPUP
 Q
 ;
CHANGE ; Change existing authorization
 ; Called from option FBSH CHANGE AUTH
 D SETUP
 I 'FBPOP F  D  Q:'$G(DFN)
 . ; select patient
 . D PAT Q:'$G(DFN)
 . ; select existing authorization
 . S FBPROG(0)=FBPROG
 . S FBPROG="I $P(^(0),U,3)=FBPROG(0)"
 . D GETAUTH^FBAAUTL1 S FBPROG=FBPROG(0)
 . I FTP'="" D
 . . S (DA,FBAAADA)=FTP,DA(1)=DFN
 . . I $P($G(FBDMRA),U) W $C(7),!,"AUTH IS AUSTIN DELETED. USE THE REINSTATE OPTION TO CHANGE IT." Q
 . . ; save current data
 . . S FBAOLD=$G(^FBAAA(DA(1),1,DA,0)),FBANEW=""
 . . S FBBEGDT=$P(FBAOLD,U),FBENDDT=$P(FBAOLD,U,2)
 . . ; display current data
 . . W !!,"FROM DATE: ",$$FMTE^XLFDT(FBBEGDT)," (No Editing)"
 . . ; edit TO DATE and check for conflicts
 . . D TDATE Q:FBENDDT=""
 . . ; update/edit fields
 . . S DIE="^FBAAA("_DA(1)_",1,"
 . . S DR=".02////^S X=FBENDDT;100////^S X=DUZ;S FBTYPE=FBPROG;.07;.04;.021"
 . . D ^DIE K DIE
 . . ; if TO DATE or PURPOSE OF VISIT changed then queue MRA
 . . S FBANEW=$G(^FBAAA(DA(1),1,DA,0))
 . . I $P(FBANEW,U,2)'=$P(FBAOLD,U,2)!($P(FBANEW,U,7)'=$P(FBAOLD,U,7)) D
 . . . ; queue MRA
 . . . S FBX=$$QMRA(DFN,FBAAADA,"C")
 . ;
 . ; unlock patient
 . L -^FBAAA(DFN,FBPROG)
 D WRAPUP
 Q
 ;
DELETE ; Delete existing authorization
 ; Called from option FBSH DELETE AUTH
 D SETUP
 I 'FBPOP F  D  Q:'$G(DFN)
 . ; select patient
 . D PAT Q:'$G(DFN)
 . ; select existing authorization
 . S FBPROG(0)=FBPROG
 . S FBPROG="I $P(^(0),U,3)=FBPROG(0)"
 . D GETAUTH^FBAAUTL1 S FBPROG=FBPROG(0)
 . I FTP'="" D
 . . N FBY
 . . S (DA,FBAAADA)=FTP,DA(1)=DFN
 . . ; confirm
 . . S FBY=$G(^FBAAA(DFN,1,FTP,0))
 . . S DIR(0)="Y",DIR("A")="OK to DELETE the "_$$FMTE^XLFDT($P(FBY,U),2)_"-"_$$FMTE^XLFDT($P(FBY,U,2),2)_" authorization"
 . . D ^DIR K DIR Q:'Y
 . . ; queue MRA, update ADEL node
 . . S FBX=$$QMRA(DFN,FBAAADA,"D")
 . . S $P(^FBAAA(DFN,1,FBAAADA,"ADEL"),U,1,2)="1^"_DT
 . ;
 . ; unlock patient
 . L -^FBAAA(DFN,FBPROG)
 D WRAPUP
 Q
 ;
REINSTA ; Reinstate deleted authorization
 ; Called from option FBSH REINSTATE AUTH
 D SETUP
 I 'FBPOP F  D  Q:'$G(DFN)
 . ; select patient
 . D PAT Q:'$G(DFN)
 . ; select existing deleted authorization
 . S FBPROG(0)=FBPROG
 . S FBPROG="I $P(^(0),U,3)=FBPROG(0),$P($G(^(""ADEL"")),U)"
 . D GETAUTH^FBAAUTL1 S FBPROG=FBPROG(0)
 . I FTP'="" D
 . . S (DA,FBAAADA)=FTP,DA(1)=DFN
 . . ; confirm
 . . ; save current data
 . . S FBAOLD=$G(^FBAAA(DA(1),1,DA,0)),FBANEW=""
 . . S FBBEGDT=$P(FBAOLD,U),FBENDDT=$P(FBAOLD,U,2)
 . . ; display current data
 . . W !!,"FROM DATE: ",$$FMTE^XLFDT(FBBEGDT)," (No Editing)"
 . . ; edit TO DATE and check for conflicts
 . . D TDATE Q:FBENDDT=""
 . . ; update/edit fields
 . . S DIE="^FBAAA("_DA(1)_",1,"
 . . S DR=".02////^S X=FBENDDT;100////^S X=DUZ;S FBTYPE=FBPROG;.07;.04;.021"
 . . D ^DIE K DIE
 . . ; queue MRA, clear ADEL node
 . . S FBX=$$QMRA(DFN,FBAAADA,"R")
 . . K ^FBAAA(DFN,1,FBAAADA,"ADEL")
 . ;
 . ; unlock patient
 . L -^FBAAA(DFN,FBPROG)
 D WRAPUP
 Q
 ;
SETUP ; initial setup - returns FBPOP = 1 when problem
 D SITEP^FBAAUTL Q:FBPOP
 S FBAADDYS=+$P(FBSITE(0),"^",13),FBAAASKV=$P(FBSITE(1),"^",1)
 ;
 S FBPROG=$O(^FBAA(161.8,"B","STATE HOME",0))
 I 'FBPROG D  Q
 . W $C(7)
 . W !,"ERROR. STATE HOME not found in FEE BASIS PROGRAM (#161.8) file."
 . W !,"Unable to process State Home authorization. Please contact IRM."
 . S FBPOP=1
 Q
 ;
PAT ; select patient
 ; returns DFN as patient ien (or undef if not selected)
 K DFN
 W ! S DIC="^DPT(",DIC(0)="QEAZM" D ^DIC Q:Y'>0  S DFN=+Y
 I $P($G(^DPT(DFN,.361)),"^")="" W !!,"ELIGIBILITY HAS NOT BEEN DETERMINED NOR PENDING, CANNOT ENTER AN AUTHORIZATION." G PAT
 I $P($G(^DPT(DFN,.32)),"^",4)=2 W !!?4,"VETERAN HAS A DISHONORABLE DISCHARGE, " S X=$P($G(^(.321)),"^") W $S(X="Y":"ONLY ELIGIBLE FOR AGENT ORANGE EXAM.",1:"NOT ELIGIBLE FOR BENEFITS.")
 I "N"[$E(X) W ! S DIR("A")="Do you want to continue",DIR(0)="Y",DIR("B")="No" D ^DIR K DIR G PAT:$S($D(DIRUT):1,'Y:1,1:0)
 ; if patient not in file #161 then add
 I '$D(^FBAAA(DFN,0)) D   I Y'>0 W $C(7),!,"ERROR ADDING TO #161" K DFN Q
 . S DA=DFN
 . L +^FBAAA(DA):5 I '$T S Y="" Q
 . K DD,DO S (X,DINUM)=DA
 . S DIC="^FBAAA(",DIC(0)="LM",DLAYGO=161
 . D FILE^DICN K DIC,DINUM
 . L -^FBAAA(DFN)
 ; lock patient/program
 L +^FBAAA(DFN,FBPROG):5 I '$T D  G PAT
 . W $C(7),!,"ANOTHER USER IS EDITING THIS PATIENT & PROGRAM. PLEASE TRY AGAIN LATER."
 Q
 ;
WRAPUP ; clean-up
 K DFN,FB,FBAAADA,FBAAASKV,FBAADDYS,FBANEW,FBAOLD,FBBEGDT
 K FBDMRA,FBENDDT,FBOPT,FBPOP,FBPROG,FBSITE,FTP,FBTYPE,FBX
 K DA,DIC,DIE,DIR,DIROUT,DIRUT,DR,DTOUT,DUOUT,X,Y
 Q
 ;
BDATES ; get both from and to dates of new authorization
 ; input
 ;   DFN     patient ien in file 161
 ;   FBPROG  program ien in file 
 ; output
 ;   FBBEGDT From Date, FileMan format, null if dates not selected
 ;   FBENDDT To Date, FileMan format, null if dates not selected
 ;
 S %DT("A")="Enter FROM DATE: ",%DT="AEX"
 D ^%DT K %DT I Y'>0 S (FBBEGDT,FBENDDT)="" Q
 S FBBEGDT=Y
 ;
 S %DT("A")="Enter TO DATE: ",%DT="AEX",%DT(0)=FBBEGDT
 D ^%DT K %DT I Y'>0 S (FBBEGDT,FBENDDT)="" Q
 S FBENDDT=Y
 ; ensure dates do not conflict with existing authorization
 S FBX=$$CONFLICT(DFN,FBPROG,FBBEGDT,FBENDDT,1)
 I FBX D RCON(DFN,FBX) G BDATES
 Q
 ;
TDATE ; get to date for existing authorization
 ; input
 ;   DFN     patient ien in file 161
 ;   FBPROG  program ien in file
 ;   FBBEGDT From Date, FileMan format
 ;   FBENDDT (optional) current value of To Date
 ; output
 ;   FBENDDT To Date, FileMan format, null if date not selected
 ;
 S %DT("A")="Enter TO DATE: ",%DT="AEX",%DT(0)=FBBEGDT
 I $G(FBENDDT)]"" S %DT("B")=$$FMTE^XLFDT(FBENDDT)
 D ^%DT K %DT I Y'>0 S FBENDDT="" Q
 S FBENDDT=Y
 ;
 S FBX=$$CONFLICT(DFN,FBPROG,FBBEGDT,FBENDDT,0)
 I FBX D RCON(DFN,FBX) G TDATE
 Q
 ;
CONFLICT(DFN,PRG,FDT,TDT,NEWAUT) ; check for conflict with existing auth.
 ; input
 ;   DFN     - patient ien
 ;   PRG     - program ien
 ;   FDT     - from date in fileman format
 ;   TDT     - to date in fileman format
 ;   NEWAUT  - optional flag, true if dates for a new authorization
 ; returns string with value =
 ;   list of authorization iens (delimited by ^) that conflict OR
 ;   null when no conflict found
 ;
 ; A conflict exists if
 ;   1) the from date of a new authorization has already been used as
 ;      the from date for an existing authorization (including deleted)
 ;      for the same FEE program.
 ;   OR
 ;   2) the date range (FROM-TO) of this authorization overlaps the
 ;      date range of a different, active (does not include deleted)
 ;      authorization for the same FEE program. Note that the from date
 ;      of one authorization can equal the to date of a different
 ;      authorization and would not be in conflict.
 ;
 N FBI,FBRET,FBY
 S FBRET=""
 ; loop thru authorizations
 S FBI=0 F  S FBI=$O(^FBAAA(DFN,1,FBI)) Q:'FBI  D
 . S FBY=$G(^FBAAA(DFN,1,FBI,0))
 . Q:$P(FBY,U,3)'=PRG  ; not program of interest
 . Q:$P(FBY,U)=""!($P(FBY,U,2)="")  ; date missing - invalid
 . ; if same from date and not new then must be the selected auth.
 . ; and wouldn't conflict with self. if new then conflict found.
 . I $P(FBY,U)=FDT S:NEWAUT FBRET=FBRET_FBI_U Q  ; same from date
 . Q:$P($G(^FBAAA(DFN,1,FBI,"ADEL")),U)  ; austin deleted
 . I FDT<$P(FBY,U,2),TDT>$P(FBY,U) S FBRET=FBRET_FBI_U  ; conflict
 Q FBRET
 ;
RCON(DFN,LIST) ; Report Conflicts
 N CNT,FBA,FBFD,FBI,FBIEN,FBP
 S CNT=$L(LIST,U)-1
 W $C(7)
 W !!,"The specified dates conflict with other authorization(s)."
 W !,"Please specify different dates for this authorization or"
 W !,"remove the conflcit by first editing the other authorization(s)."
 W !!,"Conflict with  FROM DATE",?30,"TO DATE",?45,"PURPOSE OF VISIT"
 F FBP=1:1 S FBI=$P(LIST,U,FBP) Q:FBI=""  D
 . S FBFD=$P($G(^FBAAA(DFN,1,FBI,0)),U)
 . Q:FBFD=""
 . S FBA(FBFD)=FBI
 S FBFD="" F  S FBFD=$O(FBA(FBFD)) Q:FBFD=""  D
 . S FBI=FBA(FBFD)
 . S FBIEN=FBI_","_DFN_","
 . W !
 . I $P($G(^FBAAA(DFN,1,FBI,"ADEL")),U)]"" D
 . . W !,?2,"**Austin Deleted** - Use Reinstate to reuse this From Date"
 . W ?15,$$GET1^DIQ(161.01,FBIEN,.01)
 . W ?30,$$GET1^DIQ(161.01,FBIEN,.02)
 . W ?45,$$GET1^DIQ(161.01,FBIEN,.07)
 W !
 Q
 ;
QMRA(DFN,AUT,TYP) ; Queue MRA for transmission to Austin
 ; input
 ;   DFN - patient ien (file 2)
 ;   AUT - authorization ien (file 161.01)
 ;   TYP - type of MRA (A, C, D, or R)
 ; returns ien of MRA (file 161.26)
 N DD,DO,DIC,DLAYGO
 S DIC="^FBAA(161.26,",DIC(0)="L",DLAYGO=161.26,X=DFN
 S DIC("DR")="1///^S X=""P"";2///^S X=AUT;3///^S X=TYP"
 K DD,DO D FILE^DICN K DIC,DLAYGO
 Q +Y
 ;
 ;FBSHAUT
