TIUGEDI1 ; SLC/MAM - Enter New ID Document Code; 11/14/00
 ;;1.0;TEXT INTEGRATION UTILITIES;**100**;Jun 20, 1997
 ; New rtn for ID notes
 ; 3/2/00 moved GETRECG from TIUGEDIT to TIUGEDI1
GETRECG(DFN,TIU,TIUTYP,TIUDPRM,TIUNEW,EDIT,DADDA) ; Get record
 ;for ID entry.
 ; Returns DA: new docmt for user to continue entering, or
 ;existing docmt for user to edit, or just link, or addend.
 ; Requires array TIU.  References TIU("VSTR") = LOC;VDT;VTYP
 ;                                 TIU("VISIT") = Visit File IFN
 ;                                 TIU("LOC")
 ;                                 TIU("VLOC")
 ;                                 TIU("STOP") = stop code
 ; Requires array TIUTYP as in MAIN
 ; Passes back flags:
 ;   TIUNEW = 1 if good docmt is returned and it is new
 ;          = 0 if returned docmt already existed, timeout, etc
 ;     EDIT = 1 to open DA for edit (already know Person can edit)
 ;          = 0 to forget the edit
 ; Requires DADDA = IFN of docmt DA will be added to.
 N DA,MULTOK,TLFULL,DALKABLE,YESDOIT
 ;-- Get parameters for selected title, set TLFULL: --
 ;        TLFULL: Already have max # entries on this title/pt/vst
 ;        MULTOK: More than ONE record/visit is OK
 D DOCPRM^TIULC1(TIUTYP,.TIUDPRM) S MULTOK=+$P($G(TIUDPRM(0)),U,10)
 S (TIUNEW,EDIT,TLFULL)=0
 I 'MULTOK,$$EXIST^TIUEDI3(DFN,TIUTYP,TIU("VSTR")) S TLFULL=1
 ; -- Find existing docmts for proposed title/patient/visit
 ;    which are linkable to DADDA: --
 S DALKABLE=$$EXISTLNK(DFN,TIUTYP,TIU("VSTR"),DUZ,DADDA)
 ; -- If there are NO such existing docmts,
 ;    let user create new or tell user they can't, quit: --
 I 'DALKABLE D  G GETX
 . I 'TLFULL S DA=$$CREATREC^TIUEDI3(DFN,.TIU,TIUTYP(1)),TIUNEW=1 Q
 . I TLFULL W !!,"There is already a ",$P(TIUTYP(1),U,3),".",!,"Only ONE record of this type per Visit is allowed...",! H 1 Q
 ; -- There IS such a docmt. --
 ;    -- If docmt is already linked, and user can edit,
 ;       ask if user wants to create new note anyway: --
 I $G(^TIU(8925,DALKABLE,21))=DADDA D  G GETX
 . W !,"The note already has an ID entry you can edit with that title and visit"
 . S YESDOIT=$$READ^TIUU("Y","Would you like to create a new entry anyway","NO")
 . I YESDOIT S DA=$$CREATREC^TIUEDI3(DFN,.TIU,TIUTYP(1)),TIUNEW=1 Q
 . W !,"Opening the existing entry" S DA=DALKABLE,EDIT=1
 ;   -- If docmt is NOT already linked, create new,
 ;      or edit existing, or just link existing: --
 W !,"You already have a document you can link for that patient, title, and visit."
 S YESDOIT=$$READ^TIUU("Y","Would you like to create a new entry anyway","NO")
 I $D(DUOUT)!$D(DTOUT)!$D(DIROUT) G GETX
 I YESDOIT S DA=$$CREATREC^TIUEDI3(DFN,.TIU,TIUTYP(1)) S TIUNEW=1 G GETX
 ;      -- If user says, no don't create, then try edit: --
 N CANDO S CANDO=+$$CANDO^TIULP(DALKABLE,"EDIT RECORD")
 I CANDO W !,"Opening the existing entry" S DA=DALKABLE,EDIT=1 G GETX
 ;         -- If user can't edit, just return it for linking: --
 I 'CANDO D  G GETX
 . S DA=DALKABLE
GETX ;
 I TIUNEW,'$G(DA) W !,"No new entry created" H 2 S TIUNEW=0
 Q +$G(DA)
 ;
EXISTLNK(DFN,TIUTYP,TIUVSTR,PERSON,DADDA) ; If a docmt PERSON
 ;can LINK already EXISTS for the given patient, title, and visit,
 ;then return it. If there are more than one, get the smallest DA.
 ; Receives TIUVSTR = LOC;VDT;VTYP
 ; Needs TIUTYP = title DA
 ; Needs DADDA = IFN of docmt DA will be added to.
 N REQUEST,DA,TIUI,CANLINK,DALKDAD
 I '$G(PERSON) S PERSON=DUZ
 S (REQUEST,TIUI,DA)=0
LOOP ; -- Find existing docmt for given patient, title, & visit:--
 F  S TIUI=+$O(^TIU(8925,"APTLD",DFN,TIUTYP,TIUVSTR,TIUI)) Q:'TIUI  D  Q:REQUEST  Q:DA
 . ; -- If TIUI is bad, reject it and keep looking:
 . I '$D(^TIU(8925,TIUI,0)) D  Q
 . . K ^TIU(8925,"APTLD",DFN,TIUTYP,TIUVSTR,TIUI)
 . ; -- If TIUI has requesting package (e.g. Consults),
 . ;    then reject it and quit looking: --
 . I +$P($G(^TIU(8925,TIUI,14)),U,5) S REQUEST=1 Q  ; **22**
 . N CANLINK S CANLINK=+$$CANDO^TIULP(TIUI,"ATTACH TO ID NOTE",PERSON)
 . ; -- If person can't link it, keep looking: --
 . I 'CANLINK Q
 . ; -- If already linked somewhere else, keep looking: --
 . S DALKDAD=$G(^TIU(8925,TIUI,21))
 . I DALKDAD,DALKDAD'=DADDA Q
 . ; -- If already linked to dad, but can't edit, keep looking: --
 . I DALKDAD,'$$CANDO^TIULP(TIUI,"EDIT RECORD") Q
 . ; -- If already linked to dad & can edit, return it: --
 . I DALKDAD S DA=TIUI Q
 . ; -- If not already linked, return it: --
 . S DA=TIUI
EXISTLX ;
 Q +$G(DA)
