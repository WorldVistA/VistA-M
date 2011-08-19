TIUEDI3 ; SLC/MAM - Additional Edit Code ;4/19/05
 ;;1.0;TEXT INTEGRATION UTILITIES;**100,113,184**;Jun 20, 1997
 ;
GETRECNW(DFN,TIU,TIUTYP1,TIUNEW,TIUDPRM,TIUINQ,PERSON,EDIT) ; New GETREC.
 ;  Code rewritten from the old GETREC^TIUEDI1.
 ;  GETREC^TIUEDI1 now calls this code.
 ;  New parameters: Left out TIUCREAT since we always used it as 1.
 ;                  Added PERSON and EDIT. 
 ;  Can be called directly, or via GETREC^TIUEDI1 for
 ;backward compatibility. GETREC^TIUEDI1 uses OLD parameters.
 ;  There are 3 functional differences between GETRECNW and the old 
 ;GETREC: First, GETRECNW no longer does RETRY since there should no 
 ;longer be editable entries with no time in the visit field.
 ;Second, if user when creating new docmt is asked if user wants
 ;to edit existing docmt instead, and user says no, and user
 ;cannot create a new docmt, then user is no longer given the
 ;existing record to addend.  User must use a separate addend action.
 ;Third, because code is restructured, code no longer quits before
 ;creating a new docmt if GETRECNW is called with DUOUT, etc defined.
 ;So quit before calling GETRECNW if DUOUT, etc.
 ; Returns document record DA, where DA is:
 ;   new docmt for user to continue entering, or
 ;   existing docmt for user to edit or addend.
 ; If called by upload, DA is:
 ;   new docmt to continue entering, or
 ;   existing docmt for text replacement or addendum.
 ;
 ; Call with:
 ; DFN, TIU array, TIUTYP1 are REQUIRED.
 ;    [DFN] --> Patient IFN.
 ;    [TIU] --> Visit info array
 ;              References TIU("VSTR") = LOC;VDT;VTYP
 ;                         TIU("VISIT") = Visit File IFN
 ;                         TIU("LOC")
 ;                         TIU("VLOC")
 ;                         TIU("STOP") = mark to defer workload
 ; [TIUTYP1] --> Title info variable of form:
 ;              TIUTYP1 = 1^title DA^title Name, where the 1
 ;              is just style to imitate XQORNOD
 ; [TIUNEW] --> flag, passed back with
 ;              TIUNEW = 1 if returned docmt is new
 ;              TIUNEW = 0 if returned docmt already existed,
 ;              timeout, etc
 ;
 ;[TIUDPRM] --> Docmt param array where
 ;              $P($G(TIUDPRM(0)),U,10), = 1 if
 ;              more than ONE record/visit is allowed.
 ;              If TIUDPRM not received, don't worry about
 ;              creating multiple documents
 ; [TIUINQ] --> Ask user flag, where
 ;              TIUINQ = 1: ask re edit/addend existing docmt
 ;              (Interactive List Manager options, TRY docmt def)
 ;              TIUINQ = 0: don't ask (Upload & GUI options)
 ; [PERSON] --> IFN of person asking to edit/create docmt,
 ;              or for upload, = author of document
 ;              If not received, assumed to be DUZ.
 ;   [EDIT] --> flag, passed back with EDIT = 1 if returned
 ;              PREEXISTING docmt can be edited by PERSON. If
 ;              preexisting docmt returned and 'EDIT, then
 ;              docmt cannot be edited by person.
 N TIUVSTR,MULTOK,DA,TLFULL,XISONE
 N EDABLEDA,YESDOIT ;10/3/00
 N TIUTYPDA,TIUTYPNM
 I '$G(PERSON) S PERSON=DUZ
 S TIUVSTR=TIU("VSTR")
 ; -- If just testing a document definition (TRY) rather than
 ;    doing a real note, skip inquiry into existing notes: --
 I +$G(NOSAVE) S DA=$$CREATREC(DFN,.TIU,TIUTYP1),TIUNEW=1 G GETNWX
 ; --  MULTOK: More than ONE record/visit is OK (param permits,
 ;             or didn't care enough to send the parameter)
 ;     TLFULL: Only 1 docmt allowed, and it
 ;                already exists on this title/pt/vst --
 I '$D(TIUDPRM(0)) S MULTOK=1
 E  S MULTOK=+$P(TIUDPRM(0),U,10)
 S (TIUNEW,EDIT,DA,TLFULL,EDABLEDA)=0
 S TIUTYPDA=$P(TIUTYP1,U,2),TIUTYPNM=$P(TIUTYP1,U,3)
 S XISONE=$$EXIST(DFN,TIUTYPDA,TIUVSTR)
 I 'MULTOK,XISONE S TLFULL=1
 ; -- Find existing editable docmts for patient, title, & visit:--
 S EDABLEDA=+$$EXIST(DFN,TIUTYPDA,TIUVSTR,1,PERSON)
 ; -- If there are NO such docmts,
 ;    then create new if title not full,
 ;    or return existing [NONeditable] for addendum [if user wants]: --
 I 'EDABLEDA D  G GETNWX
 . I 'TLFULL S DA=$$CREATREC(DFN,.TIU,TIUTYP1),TIUNEW=1 Q
 . I +$G(TIUINQ) D  Q
 . . W !!,"There is already a ",TIUTYPNM,".",!
 . . W "Only ONE record of this type per Visit is allowed...",!
 . . S YESDOIT=+$$READ^TIUU("Y"," Would you like to addend the existing record","NO")
 . . I YESDOIT S DA=XISONE
 . I '+$G(TIUINQ) S DA=XISONE
 . Q
 ; -- If there ARE such docmts, then
 ;      If title is full, return existing docmt for edit.
 ;      If title is NOT full, return existing docmt for edit,
 ;        or ask user.
 I EDABLEDA D  G GETNWX
 . I TLFULL D:+$G(TIUINQ)  S DA=EDABLEDA,EDIT=1 Q
 . . W !!,"There is already a ",TIUTYPNM," which you may edit."
 . . W !,"Only ONE record of this type per Visit is allowed...",!
 . . W "Opening the existing record"
 . . S TIUCHNG("EXIST")=1
 . I 'TLFULL D  Q
 . . I '+$G(TIUINQ) S DA=EDABLEDA,EDIT=1 Q
 . . W !!,"There is already a ",TIUTYPNM," which you may edit."
 . . S YESDOIT=+$$INQUIRE ; "Create new anyway?"
 . . I $D(DUOUT)!$D(DTOUT)!$D(DIROUT) Q
 . . I YESDOIT S DA=$$CREATREC(DFN,.TIU,TIUTYP1),TIUNEW=1 Q
 . . W !!,"Okay, I'll open the existing record then!"
 . . S DA=EDABLEDA,EDIT=1,TIUCHNG("EXIST")=1
GETNWX ;
 I TIUNEW,'DA S TIUNEW=0
 Q +$G(DA)
 ;
EXIST(DFN,TIUTYPDA,TIUVSTR,REQEDIT,PERSON) ; If a docmt already
 ;EXISTS for the given patient, title, and visit, then return it.
 ; Ignore: - docmts of status deleted or retracted
 ;         - all docmts if run across a docmt w/ requesting pkg
 ;         - all docmts if Title is PRF Title
 ;         - I REQEDIT, then also ignore docmts PERSON cannot edit.
 ; If there are more than one, get the smallest DA.
 ; Receives TIUVSTR = LOC;VDT;VTYP
 ; Needs TIUTYPDA = title DA
 ; REQEDIT & PERSON are optional
 N REQUEST,DA,TIUI,STATUS,RETRY
 S REQEDIT=+$G(REQEDIT)
 I '$G(PERSON) S PERSON=DUZ
 S (REQUEST,TIUI,DA)=0
 I $$ISPFTTL^TIUPRFL(TIUTYPDA) G EXISTEX
LOOP ; -- Find existing docmt for given patient, title, & visit:--
 F  S TIUI=+$O(^TIU(8925,"APTLD",DFN,TIUTYPDA,TIUVSTR,TIUI)) Q:'TIUI  D  Q:REQUEST  Q:DA
 . ; -- If TIUI doesn't exist, reject it and keep looking: --
 . I '$D(^TIU(8925,TIUI,0)) D  Q
 . . K ^TIU(8925,"APTLD",DFN,TIUTYPDA,TIUVSTR,TIUI)
 . ; -- If TIUI has requesting package (e.g. Consults),
 . ;    then reject it and quit looking: --
 . I +$P($G(^TIU(8925,TIUI,14)),U,5) S REQUEST=1 Q  ; **22**
 . ; -- If TIUI has status deleted or retracted, reject it
 . ;    and keep looking: TIU*1*61 --
 . S STATUS=+$P($G(^TIU(8925,TIUI,0)),U,5)
 . I STATUS=14!(STATUS=15) Q
 . ; -- If OK so far, and record not required to be editable,
 . ;then grab existing record and stop looking: --
 . I 'REQEDIT S DA=TIUI Q
 . ; -- If REQEDIT & PERSON can edit existing record,
 . ;    then grab it and stop looking: --
 . N CANEDIT S CANEDIT=+$$CANDO^TIULP(TIUI,"EDIT RECORD",PERSON)
 . I +CANEDIT>0 S DA=TIUI
 ; -- If record not required to be editable & still haven't
 ;    found a record, check for records with no visit time: --
 ;    (Early anomaly with DSs at Boston)
 I +DA'>0,($P(TIUVSTR,";",3)="H"),(+$G(RETRY)'>0) D  G LOOP
 . S RETRY=1,$P(TIUVSTR,";",2)=$P($P(TIUVSTR,";",2),".")
EXISTEX ;
 Q +$G(DA)
 ;
CREATREC(DFN,TIU,TIUTYP1) ; Create document record - Returns DA
 ; Receives array TIU as in GETRECNW
 ; Needs var TIUTYP1 as in GETRECNW
 N DIC,DLAYGO,X,Y,TIUFPRIV,TIUVTYP,RETRY,TIUVSTR,TIUVISIT,DA
 N TIUTYPDA,TIUTYPNM
 S TIUTYPDA=$P(TIUTYP1,U,2),TIUTYPNM=$P(TIUTYP1,U,3)
 S TIUVSTR=TIU("VSTR")
 S DA=0,TIUFPRIV=1
 S (DIC,DLAYGO)=8925,DIC(0)="FL"
 S X=""""_"`"_TIUTYPDA_"""" D ^DIC
 I +Y'>0 W !,TIUTYPNM," record could not be created.",! G CREXIT
 ; -- Stuff patient, visit, parent doc type, status,
 ;    visit type, hosp loc, visit loc, division: --
 S DA=+Y
 N DIE,DR S DIE=8925
 S TIUVTYP=$P($G(TIUVSTR),";",3)
 S TIUVISIT=$S(+$G(TIU("VISIT")):+$G(TIU("VISIT")),1:"")
 S DR=".02////"_DFN_";.03////"_TIUVISIT_";.04////"_$$DOCCLASS^TIULC1(+$P(Y,U,2))_";.05///"_$$UP^XLFSTR($$STATUS^TIULC(DA))_";.13////"_TIUVTYP_";1205////"_$P($G(TIU("LOC")),U)_";1211////"_$P($G(TIU("VLOC")),U)_";1212////"_$P($G(TIU("INST")),U)
 D ^DIE
 ; -- [Mark record for deferred crediting of stop code (fld #.11)]: --
 I +$G(TIU("STOP")) D DEFER^TIUVSIT(DA,+$G(TIU("STOP")))
CREXIT Q +$G(DA)
 ;
INQUIRE() ; Ask user whether to create a new note anyway
 N TIUY,TIUPRMT
 S TIUY=0,TIUPRMT="Do you want to create a new record anyway"
 S TIUY=+$$READ^TIUU("Y",TIUPRMT,"NO")
 Q TIUY
 ;
