ENWONEW3 ;WIRMFO/SAB-Incoming Inspection Work Order ;12.18.97
 ;;7.0;ENGINEERING;**35,47**;Aug 17, 1993
 ;
IIWO(ENEQ) ; Generate Incoming Inspection Work Order
 ; called from ENEQ1, ENEQ3
 ; In
 ;   ENEQ - equipment entry #
 ;   ENMA("IIWO")       - (optional) flag; true when multi equip entry
 ;   ENMA("IIWO","DA")  - (optional) w.o. ien generated for 1st equip
 ;   ENMA("IIWO","ION") - (optional) device ion used with 1st equip w.o.
 ;   ENMA("IIWO","QDT") - (optional) queued date/time of 1st w.o. print
 ; Out
 ;   ENDA  - work order ien
 ;   ENWO  - work order number
 ;   also when $G(ENMA("IIWO")) true and device selected for output
 ;       ENION - device ion used for (auto)print
 ;       ENQDT - queued date/time when output queued
 ;
 N AUTOPRT,DA,DIC,DIE,DR,ENEDPM,ENI,ENJ,ENTEC,ENX
 N NUMBER,SHOPDEV,SHOPKEY,WARD
 K ENION,ENQDT S (ENDA,ENWO)=""
 ; determine user privileges
 S ENEDPM=$D(^XUSEC("ENEDPM",DUZ))
 ; determine shop of work order
 I $G(ENMA("IIWO","DA")) S SHOPKEY=$P($G(^ENG(6920,ENMA("IIWO","DA"),2)),U)
 E  D
 . S SHOPKEY=$P(^DIC(6910,1,0),U,13) ; incoming inspection section
 . I SHOPKEY="" D  ; or responsible shop
 . . S ENI=$O(^ENG(6914,ENEQ,4,0))
 . . I ENI S SHOPKEY=$P(^ENG(6914,ENEQ,4,ENI,0),U)
 . I SHOPKEY="" S SHOPKEY=$P(^DIC(6910,1,0),U,6) ; or temp w.o. section
 . ; ask shop if blank or user holds key
 . I SHOPKEY=""!ENEDPM F  D  Q:SHOPKEY]""
 . . S DIC="^DIC(6922,",DIC(0)="AQEM"
 . . I SHOPKEY S DIC("B")=$P($G(^DIC(6922,SHOPKEY,0)),U)
 . . I 'ENEDPM S DIC("S")="I Y#100>89"  ; restrict to receiving areas
 . . D ^DIC K DIC
 . . I $D(DTOUT)!$D(DUOUT) S SHOPKEY="^" Q
 . . I Y>0 S SHOPKEY=+Y Q
 . . W !,"Shop required. Enter '^' if you don't want to create a W.O.",!
 I SHOPKEY'>0 W !,"Unspecified Shop. Work Order was NOT created." G EXIT
 ;
 ; create work order
 D WONUM^ENWONEW I NUMBER="" D  G EXIT
 . W $C(7),!,"Can't seem to add to Work Order File."
 . W !,"You will need to manually create the incoming inspection W.O."
 S ENDA=DA,ENWO=NUMBER
 W !,"WORK ORDER #: ",NUMBER
 ; lock work order
 L +^ENG(6920,DA):5 I '$T D  G EXIT
 . W $C(7),!,"Can't lock the new work order. Please contact IRM."
 ; populate work order
 ;   with standard data for an electronic work order
 S WARD=1 D WOFILL^ENWONEW S WARD=0
 ;   with data for an incoming inspection work order
 S DIE="^ENG(6920,"
 S DR="6///Incoming Inspection"
 S DR=DR_";17///AVERAGE"
 S DR=DR_";32///"_$S(SHOPKEY#100>89:"PENDING",1:"IN PROGRESS")
 I SHOPKEY#100>89 S DR=DR_";10///TODAY"
 D ^DIE
 K ENFDA S ENFDA(6920.035,"+2,"_DA_",",.01)="I1"
 D UPDATE^DIE("E","ENFDA")
 ;   with equipment related data
 S DIE="^ENG(6920,"
 S DR="18///"_ENEQ
 S ENX=$$GET1^DIQ(6914,ENEQ,24) I ENX]"" S DR=DR_";3///"_ENX
 D ^DIE
 ;   with user specified data
 S DIE="^ENG(6920,",DR=""
 I $G(ENMA("IIWO","DA")) D
 . ; copy comments from 1st work order
 . I $D(^ENG(6920,ENMA("IIWO","DA"),6)) D
 . . D WP^DIE(6920,DA_",",40,"","^ENG(6920,ENMA(""IIWO"",""DA""),6)")
 . ; copy other user editable fields from 1st work order into DR
 . S ENX=$P($G(^ENG(6920,ENMA("IIWO","DA"),2)),U,2) ; tech
 . I ENX]"" S DR=DR_";16////"_ENX
 . S ENX=$P($G(^ENG(6920,ENMA("IIWO","DA"),1)),U,3) ; contact
 . I ENX]"" S DR=DR_";7////"_ENX
 . S ENX=$P($G(^ENG(6920,ENMA("IIWO","DA"),1)),U,4) ; phone
 . I ENX]"" S DR=DR_";8////"_ENX
 I '$G(ENMA("IIWO","DA")) D
 . ; build DR string for user editable fields
 . ; determine responsible technician (if any)
 . S ENI=$O(^ENG(6914,ENEQ,4,0))
 . S ENJ=$S(ENI:$P(^ENG(6914,ENEQ,4,ENI,0),U,2),1:"")
 . S ENTEC=$S(ENJ:$P($G(^ENG("EMP",ENJ,0)),U),1:"")
 . I ENTEC]""!ENEDPM D
 . . S DR=DR_";16"
 . . I ENTEC]"" S DR=DR_"//"_$S(ENEDPM:"",1:"/")_ENTEC ; resp. tech
 . S DR=DR_";7;8;40"
 I $E(DR)=";" S DR=$E(DR,2,245)
 D ^DIE
PRT ; print work order?
 S ENI=$O(^ENG(6910.2,"B","AUTO PRINT NEW W.O.",0))
 S AUTOPRT=$S(ENI:$P(^ENG(6910.2,ENI,0),U,2),1:"")
 S SHOPDEV=$$GET1^DIQ(6922,SHOPKEY,2)
 ; if no user interaction required then call woprnt
 I "^L^S^"[(U_AUTOPRT_U),SHOPDEV]"" S WARD=0 D WOPRNT^ENWONEW G PRTX
 ; if not autoprinted and shop is receiving area then skip
 I SHOPKEY#100>89 G PRTX
 ; if subsequent equipment of multiple then use previous device (if any)
 I $G(ENMA("IIWO","DA")) D  G PRTX
 . S IOP=$G(ENMA("IIWO","ION"))
 . I IOP]"" S %ZIS="Q" D ^%ZIS Q:POP  D PRTL
 ; if not autoprinted, not receiving area, and not subsequent then ask
 S DIR(0)="Y",DIR("A")="Print this work order",DIR("B")="YES"
 D ^DIR K DIR Q:Y'>0
 D DEV^ENLIB I POP D HOME^%ZIS G PRTX
 I $G(ENMA("IIWO")) S ENION=$S($D(IO("Q")):"Q;"_ION,1:ION)
 D PRTL
PRTX ;
 ; unlock work order
 L -^ENG(6920,DA)
EXIT ;
 Q
 ;
PRTL ; Print W.O. Long Format
 ; determine required variables
 N ENBARCD,ENWO
 S ENBARCD=0
 S ENI=$O(^ENG(6910.2,"B","PRINT BAR CODES ON W.O."))
 I ENI,$P(^ENG(6910.2,ENI,0),U,2)="Y" S ENBARCD=1
 S ENWO=$P(^ENG(6920,DA,0),U)
 ;
 I $D(IO("Q")) D  Q
 . S ZTRTN="PRT1^ENWOD",ZTDESC="Enginering Work Order"
 . S ZTIO=ION
 . ; when subsequent entry during multiple use date/time of 1st for task
 . I +$G(ENMA("IIWO","QDT")) S ZTDTH=ENMA("IIWO","QDT")
 . F ENX="DA","ENBARCD","ENWO" S ZTSAVE(ENX)=""
 . D ^%ZTLOAD
 . ; when 1st of multiple entry return date/time queued
 . I $G(ENMA("IIWO")),$G(ENION)]"" S ENQDT=$G(ZTSK("D"))
 . D HOME^%ZIS K ZTSK
 ;
 D PRT1^ENWOD
 I $E(IOST,1,2)="C-" D HOLD^ENWOD2
 K ENDSTAT,ENX,ENINV
 Q
 ;
 ;ENWONEW3
