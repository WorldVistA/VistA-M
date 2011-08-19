PRSPESR ;WOIFO/JAH - part-time physicians ESR Edit ;11/16/04
 ;;4.0;PAID;**93**;Sep 21, 1995;Build 7
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;Allow PTP employee w/ a memorandum to review memo status
 ;then edit, update, and sign daily ESRs.
 ;call from option-"Electronic Subsidiary Record".   
 Q
 ;
MAIN ; main entry point called from ESR edit option
 N PICKLIST,PRSIEN,OUT,PLIST,PICK
 ;
 ;get users PRSIEN
 S PRSIEN=$$PRSIEN^PRSPUT2(1)
 Q:PRSIEN'>0
 ;
 ;While PTP is not done continue 
 ;
 S OUT=0
 F  D  Q:OUT
 .; BUILD OPTION PICK LIST--MEMO ACTIONS, PRIOR, CURRENT AND NEXT PP ESRs
 .;
 .;
 .  K PLIST
 .  D BLDPICK(.PLIST,PRSIEN)
 .;
 .  W @IOF,!
 .; get out if there's nothing in the list.
 .  I '$D(PLIST) D  Q
 ..    W !,"No ESR records available.",!!!
 ..    S OUT=$$ASK^PRSLIB00(1)
 ..    S OUT=1
 .; get users choice of action
 .  S PICK=$$CHOICE(.PLIST)
 .  I PICK=0 S OUT=1 Q
 .  I $P(PLIST(PICK),U)="M" D MEMO(PRSIEN,PLIST(PICK)) ;### CALL MEMO OPTION
 .  I "NCP"[$P(PLIST(PICK),U) D 
 ..   ;Make sure we have a signature code before continuing
 ..   I '$$ESIGC^PRSPUT2(1) W !! S OUT=$$ASK^PRSLIB00(1) Q
 ..   ;
 ..   D ESR(PRSIEN,$P(PLIST(PICK),U,2),$P(PLIST(PICK),U,3),.OUT)
 ;
 Q
BLDPICK(PL,PRSIEN) ; Build option pick list with memo, prior ESR,
 ; current ESR and next ESR actions in the PL array
 ;PPE,I - current Pay period  (E)xternal (I)nternal entry #
 ;NXPPE
 ;PI - picklist counter/array subscript
 ;MAI - memo action counter
 ;AMIEN - active memo ien for a prior pay period
 ;Get any actions required for Memorandum.
 N PI,PPE,NXPPE,MIEN,MAI,PPDT1,AMIEN,MTXT,RANGE,FR,TO,PRTXT
 S PI=0
 ; get array of memos with status reconcile started
 ; this may need to be replaced with API call ###
 D GETMEMOS(.MIEN,PRSIEN,3)
 I $G(MIEN(0))>0 D
 .  S MAI=0
 .  F  S MAI=$O(MIEN(MAI)) Q:MAI'>0  D
 ..   Q:$P($G(^PRST(458.7,MAI,2)),U)>0
 ..   S PI=PI+1,PL(PI)=$$BLDMACT(MAI,MIEN(MAI))
 ;
 ;Travel ESR status xref (<4) )for incomplete ESR days
 ;
 S PRTXT="Edit ESR for PRIOR pay period "
 S PPE=""
 F  S PPE=$O(^PRST(458,"AEA",PRSIEN,PPE)) Q:PPE=""  D
 . S PPI=$O(^PRST(458,"B",PPE,0))
 . Q:PPI'>0
 .;### call to active memo API to determine if pp should be edited
 .;  Get 1st day of pp
 .  D NX^PRSAPPU S PPDT1=D1
 .  S AMIEN=+$$MIEN^PRSPUT1(PRSIEN,PPDT1)
 .  I AMIEN>0 D
 ..    S PI=PI+1
 ..    S RANGE=$G(^PRST(458,PPI,2))
 ..    S FR=$P(RANGE,U,1),TO=$P(RANGE,U,14)
 ..    S MTXT=PRTXT_PPE_" ["_FR_" - "_TO_"]"
 ..    S PL(PI)="P^"_PPI_"^"_AMIEN_U_MTXT
 ;
 ;  current pay period to list, overwrite PI array if current
 ; pay period is also a prior pay period selection already
 N PPE,PPI,PP4Y,DAY,D1,PPDT1,AMIEN,OVRITE
 S (PPDT1,D1)=DT D PP^PRSAPPU
 I PPI'="" D
 .  S OVRITE=$$PPICHK(.PL,PPI)
 .  I OVRITE>0 S PI=OVRITE
 .  E  S PI=PI+1
 .  S AMIEN=+$$MIEN^PRSPUT1(PRSIEN,PPDT1)
 .  I AMIEN>0 D
 ..    S RANGE=$G(^PRST(458,PPI,2))
 ..    S FR=$P(RANGE,U,1),TO=$P(RANGE,U,14)
 ..    S MTXT="Edit ESR for CURRENT pay period "_PPE_" ["_FR_" - "_TO_"]"
 ..    S PL(PI)="C^"_PPI_U_AMIEN_U_MTXT
 ;
 ; add next pay period to list if open and covered by memo
 S PPE=$E($$NXTPP^PRSAPPU(PPE),3,7)
 D NX^PRSAPPU S PPDT1=D1
 I $D(^PRST(458,"B",PPE)) D 
 .  S PPI=$O(^PRST(458,"B",PPE,0))
 .  S AMIEN=+$$MIEN^PRSPUT1(PRSIEN,PPDT1)
 .  I AMIEN>0 D
 ..   S OVRITE=$$PPICHK(.PL,PPI)
 ..   I OVRITE>0 S PI=OVRITE
 ..   E  S PI=PI+1
 ..   S RANGE=$G(^PRST(458,PPI,2))
 ..   S FR=$P(RANGE,U,1),TO=$P(RANGE,U,14)
 ..   S MTXT="Edit ESR for NEXT pay period "_PPE_" ["_FR_" - "_TO_"]"
 ..   S PL(PI)="N^"_PPI_"^"_AMIEN_U_MTXT
 ;
 Q
 ;
PPICHK(PRIARY,PPCH) ; Check if Current or next is already in prior array
 ;  RETURN PPI IF FOUND
 N FOUND,PRNODE
 S FOUND=0,PRNODE=99
 F  S PRNODE=$O(PRIARY(PRNODE),-1) Q:(PRNODE'>0)!(FOUND>0)  D
 .  I PPCH=$P($G(PRIARY(PRNODE)),U,2) S FOUND=PRNODE
 Q FOUND
 ;
BLDMACT(MIEN,ZNODE) ;with zero node of memo build the item screen
 ; Sample appearance for menu item
 N SDT,EDT,TDT,Y,MENUTXT
 S MENUTXT="M^"_MIEN_"^^Reconcile Prior Memorandum from "
 ; Reconcile Prior Memorandum from JUL 2004 TO JUL 2005
 S SDT=$P(ZNODE,U),EDT=$P(ZNODE,U,2),TDT=$P(ZNODE,U,3)
 I $G(TDT)>0,($G(TDT)<$G(EDT)) S EDT=TDT
 S Y=SDT D DD^%DT S SDT=Y
 S Y=EDT D DD^%DT S EDT=Y
 S MENUTXT=MENUTXT_SDT_" TO "_EDT
 Q MENUTXT
CHOICE(PL,DEF) ; return users choice from array of items in PL
 ; return 0 for abort
 N ITEM,ICNT,DIR,DIRUT
 S ICNT=0
 I $G(DEF)>0,($G(PL(DEF))'="") D
 .  S DIR("B")=DEF
 S ITEM=0
 F  S ITEM=$O(PL(ITEM)) Q:ITEM'>0  D
 .  S DIR("A",ITEM)=ITEM_". "_$P($G(PL(ITEM)),U,4)
 .  S ICNT=ICNT+1
 S DIR(0)="NO^1:"_ICNT_":0"
 S DIR("A")="Select an Item "
 D ^DIR
 S PICK=+$G(Y)
 I $G(DIRUT) S PICK=0
 Q PICK
 ;
GETMEMOS(MIEN,PRSIEN,MSTAT) ; Return IEN subscripted array of
 ;  memorandums in a single status (MSTAT)
 ;  INPUT:  EMPLOYEE IEN (PRSIEN)
 ;          STATUS OF MEMORANDUM desired (MSTAT)
 ;          1:NOT STARTED; 2:ACTIVE; 3:RECONCILIATION STARTED;
 ;          4:RECONCILED;
 ;  OUTPUT: returns MIEN array as follows:
 ;          MIEN(0) = 0 when no reconcile actions: 
 ;            OR
 ;          MIEN(0) = integer # of memos that requires reconcile action: 
 ;          MIEN(IEN 1)=start date^end date^termination date
 ;          MIEN(IEN n)=start date n ^end date n ^termination date n
 N ZNODE,TDT,TMPMIEN
 S MIEN(0)=0
 Q:$G(MSTAT)'>0!($G(PRSIEN)'>0)
 S TMPMIEN=0
 F  S TMPMIEN=$O(^PRST(458.7,"AST",PRSIEN,MSTAT,TMPMIEN)) Q:TMPMIEN'>0  D
 .  S ZNODE=$G(^PRST(458.7,TMPMIEN,0))
 .  S TDT=$P($G(^PRST(458.7,TMPMIEN,4)),U)
 .  S MIEN(TMPMIEN)=$P(ZNODE,U,2)_"^"_$P(ZNODE,U,3)_"^"_TDT
 .  S MIEN(0)=MIEN(0)+1
 Q
 ;
MEMO(PRSIEN,LIST) ; CALL OPTION TO RECONCILE A MEMO
 ;INPUT : PRSIEN-user 450 ien,  LIST-pick list array item for memo
 N OUT,MIEN
 S MIEN=$P(LIST,U,2)
 D MAIN^PRSPSRC(PRSIEN,MIEN)
 S OUT=$$ASK^PRSLIB00()
 Q
ESR(PRSIEN,PPI,MIEN,OUT) ; DISPLAY PAY PERIOD AND ASK USER TO PICK A DAY
 ;  WHEN THEY PICK A DAY CALL code to start up a ScreenMan
 ;  form for the day record
 N ESRDAY
 S OUT=0
 F  D  Q:(ESRDAY'>0)
 . W @IOF
 . D WSS(PRSIEN,PPI,MIEN)
 . S ESRDAY=$$WHICHDAY(PPI,PRSIEN)
 . I $$CANPOST(PPI,PRSIEN,ESRDAY,1) D ESRFRM^PRSPESR1(PRSIEN,PPI,ESRDAY)
 I ESRDAY<0 S OUT=1
 Q
CANPOST(PPI,PRSIEN,PRSD,SHMSG) ; Can this day be posted by a PTP?
 ; i show message set to 1 then show message on can't post
 N CANPOST
 S CANPOST=0
 Q:$G(PRSD)'>0 CANPOST
 N TCSTAT,DUM,ESRSTAT,TCSTAT,TOUR
 S CANPOST=1
 ;
 S TOUR=$P($G(^PRST(458,PPI,"E",PRSIEN,"D",PRSD,0)),U,2)
 I TOUR'>0 S CANPOST=0 D  Q CANPOST
 .  I 'CANPOST&($G(SHMSG)>0) D
 ..   W @IOF,!!!,"A Tour of Duty must be entered first.  Please contact your timekeeper.",!!
 ..   S DUM=$$ASK^PRSLIB00(1)
 ;
 S ESRSTAT=$$GETSTAT^PRSPESR1(PRSIEN,PPI,PRSD)
 S TCSTAT=$$TCSTAT^PRSPSAP2(PPI,PRSIEN)
 I TCSTAT'="T" S CANPOST=(ESRSTAT<5) D
 .  I 'CANPOST&($G(SHMSG)>0) D
 ..   W @IOF,!!!,"Only select days with status 'Not Started, 'Pending', 'Signed', or 'Resubmit'."
 ..   W !,"To edit approved days or days off, contact your Time and Leave Supervisor.",!!
 ..   S DUM=$$ASK^PRSLIB00(1)
 Q CANPOST
 ;
WSS(PRSIEN,PPI,MIEN) ; WORK SUMMARY SCREEN
 N SCRTTL
 S SCRTTL="Work Summary Screen for Part Time VA Physician "
 D HDR^PRSPUT1(PRSIEN,SCRTTL,,,PPI)
 D MEM^PRSPUT1(PRSIEN,MIEN)
 D AL^PRSPUT3(PRSIEN,)
 D ESRSTAT^PRSPUT2(PRSIEN,PPI)
 Q
WHICHDAY(PPI,PRSIEN,DEF) ; ASK USER TO SELECT A PAY PERIOD DAY
 ; return 0 for abort OR -1 for double abort "^^"
 N DIR,DIRUT,TCSTAT,I
 S DIR(0)="NO^1:14:0"
 I $G(DEF)>0 S DIR("B")=DEF
 S DIR("A")="Select day "
 D ^DIR
 I $G(DIRUT) D
 .  S PICK=$S($G(Y)["^^":-1,1:0)
 E  D
 .  S PICK=$G(Y)
 Q PICK
 Q
