TIUEDI1 ; SLC/MAM - Additional Edit Code ;March 25, 2004
 ;;1.0;TEXT INTEGRATION UTILITIES;**7,22,66,61,100,166**;Jun 20, 1997
GETREC(DFN,TIU,TIUCREAT,TIUNEW,TIUDPRM,TIUINQ,TIUPERSN) ;Returns
 ;new or existing document DA.
 ; Receives TIUPERSN (optional) = person asking to edit/create docmt,
 ;             or for upload, = author of document.
 ;             If not received, assumed to be DUZ.
 ;             New **ID** parameter, backward compatible
 ; Requires array TIUTYP where
 ;   TIUTYP = title DA
 ;   TIUTYP(1) = 1^title DA^Name
 ; Receives TIUCREAT for backward compatibility place holder only
 S TIUPERSN=$G(TIUPERSN,DUZ)
 S DA=$$GETRECNW^TIUEDI3(DFN,.TIU,TIUTYP(1),.TIUNEW,.TIUDPRM,+$G(TIUINQ),TIUPERSN)
 Q +$G(DA)
 ;
INQUIRE() ; Ask user whether to create a new note anyway
 N TIUY,TIUPRMT
 S TIUY=0,TIUPRMT="Do you want to create a new record anyway"
 S TIUY=+$$READ^TIUU("Y",TIUPRMT,"NO")
 Q TIUY
SCANDAD(TIUTYP,TIUDA) ; Search "DAD" index for component record
 N TIUC,TIUY
 S (TIUY,TIUC)=0
 F  S TIUC=$O(^TIU(8925,"DAD",+TIUDA,TIUC)) Q:+TIUC'>0!(+TIUY>0)  D
 . I +TIUTYP=+$G(^TIU(8925,+TIUC,0)) S TIUY=TIUC Q
 . I +$O(^TIU(8925,"DAD",+TIUC,0)) S TIUY=$$SCANDAD(TIUTYP,TIUC)
 Q TIUY
GETCOMP(TIUTYP,TIUDA,TIU,DFN) ; Adds components to document
 N DIC,DA,X,Y,DIE,DR,TIUC,TIUCMP,TIUMOM,TIUMTYP,TIUY,TIUFPRIV
 N DLAYGO ;10/3/00
 S TIUFPRIV=1,(TIUY,TIUC)=0
 S TIUY=$$SCANDAD(TIUTYP,TIUDA)
 I +TIUY G GETCX
 S (DIC,DLAYGO)=8925,DIC(0)="FL"
 S X="""`"_+TIUTYP_""""
 D ^DIC
 I +Y'>0 W !,X," component could not be created.",! G GETCX
 S (TIUY,DA)=+Y,DIE=DIC
 S TIUMOM=+$$RUMYMTHR(TIUDA,DA,+TIUTYP,+$G(^TIU(8925,+DA,0)))
 S TIUMTYP=+$G(^TIU(8925,+TIUMOM,0))
 S DR=".02////"_DFN_";.03////"_$P($G(TIU("VISIT")),U)_";.04////"_TIUMTYP_";.06////"_TIUMOM
 D ^DIE W "."
GETCX Q TIUY
RUMYMTHR(MOM,BRAT,MOMTYP,BRATYP) ; Get appropriate parent for component
 N TIUI,GOTMOM,CNDMOM,CNDTYP,TIUMOM S (GOTMOM,TIUI)=0
 I +$O(^TIU(8925.1,"AD",+BRATYP,MOMTYP,0)) S GOTMOM=1 G RUMYX
 S CNDMOM=0
 F  S CNDMOM=$O(^TIU(8925,"DAD",+MOM,+CNDMOM)) Q:+CNDMOM'>0  D
 . S CNDTYP=+$G(^TIU(8925,+CNDMOM,0))
 . S TIUMOM=$$RUMYMTHR(CNDMOM,BRAT,CNDTYP,BRATYP) I $P(TIUMOM,U,2)=1 S MOM=+TIUMOM,GOTMOM=1 Q
RUMYX Q MOM_U_GOTMOM
DELCOMP(TIUDA) ; Cleans up all components of a document
 N DA,DIE,DR,TIUCDA S TIUCDA=0,DIE="^TIU(8925,"
 F  S TIUCDA=$O(^TIU(8925,"DAD",TIUDA,TIUCDA)) Q:+TIUCDA'>0  D
 . W !,$P(^TIU(8925.1,+^TIU(8925,TIUCDA,0),0),U)_" Component Deleted"
 . S DR=".01///@",DA=TIUCDA D ^DIE W "."
 . I +$O(^TIU(8925,"DAD",TIUCDA,0))>0  D DELCOMP(TIUCDA)
 Q
DELAUDIT(TIUDA) ; Cleans up all AUDIT TRAIL entries for a document
 N DA,DIK,DR,TIUADA S TIUADA=0,DIK="^TIU(8925.5,"
 F  S TIUADA=$O(^TIU(8925.5,"B",TIUDA,TIUADA)) Q:+TIUADA'>0  D
 . ; W !," Audit trail record #",TIUADA," Deleted"
 . S DA=TIUADA D ^DIK ; W "."
 I $L($T(DEL^PXRMGECU)) D DEL^PXRMGECU(+TIUDA)
 Q
ISCOMP(TIUTYP,X) ; Is the text provided a component tag
 N DIC,TIULEVEL,TIUY,Y,TIUFPRIV S TIULEVEL=0,TIUFPRIV=1
 S DIC=8925.1,DIC(0)="FX"
 S DIC("S")="I $P(^TIU(8925.1,+Y,0),U,4)=""CO"""
 D ^DIC K DIC("S")
 I +Y'>0 S TIUY=0 G ISCMPX
 I +$O(^TIU(8925.1,+TIUTYP,10,"B",+Y,0))'>0 S TIUY=0 G ISCMPX
 S TIUY=Y
ISCMPX Q TIUY
MERGTEMP(TIUDA) ; Merge text from components into TEMP node for edit
 N TIUC,TIUI,TIUJ,TIULINE
 S (TIUC,TIULINE)=0,TIUJ=+$P($G(^TIU(8925,+TIUDA,"TEMP",0)),U,3)
 F  S TIUC=$O(^TIU(8925,"DAD",TIUDA,TIUC)) Q:+TIUC'>0  D
 . I +$$ISADDNDM^TIULC1(+TIUC) Q
 . S TIUI=0 F  S TIUI=$O(^TIU(8925,+TIUC,"TEXT",TIUI)) Q:+TIUI'>0  D
 . . S TIUJ=+$G(TIUJ)+1
 . . S ^TIU(8925,+TIUDA,"TEMP",TIUJ,0)=$G(^TIU(8925,+TIUC,"TEXT",TIUI,0))
 . . K ^TIU(8925,+TIUC,"TEXT",TIUI,0) ; Clear the way for edits
 . . S ^TIU(8925,+TIUC,"TEXT",0)="^^^^"_DT_"^^"
 . . S ^TIU(8925,+TIUDA,"TEMP",0)="^^"_TIUJ_"^"_TIUJ_"^"_DT_"^^"
 . I +$O(^TIU(8925,"DAD",+TIUC,0)) D MERGGRAN(TIUDA,+TIUC)
 . S TIUJ=+$P($G(^TIU(8925,+TIUDA,"TEMP",0)),U,3)
 I $D(^TIU(8925,+TIUDA,"TEMP",1))>9 M ^TIU(8925,+TIUDA,"TEXT")=^TIU(8925,+TIUDA,"TEMP")
 Q
MERGGRAN(TIUDA,TIUC) ; Merge sub-components into TEMP node of original
 N TIUC1,TIUI,TIUJ,TIULINE
 S (TIUC1,TIULINE)=0,TIUJ=+$P($G(^TIU(8925,+TIUDA,"TEMP",0)),U,3)
 F  S TIUC1=$O(^TIU(8925,"DAD",TIUC,TIUC1)) Q:+TIUC1'>0  D
 . S TIUI=0 F  S TIUI=$O(^TIU(8925,+TIUC1,"TEXT",TIUI)) Q:+TIUI'>0  D
 . . S TIUJ=+$G(TIUJ)+1
 . . S ^TIU(8925,+TIUDA,"TEMP",TIUJ,0)=$G(^TIU(8925,+TIUC1,"TEXT",TIUI,0))
 . . K ^TIU(8925,+TIUC1,"TEXT",TIUI,0) ; Clear the way for edits
 . . S ^TIU(8925,+TIUC1,"TEXT",0)="^^^^"_DT_"^^"
 . . S ^TIU(8925,+TIUDA,"TEMP",0)="^^"_TIUJ_"^"_TIUJ_"^"_DT_"^^"
 . I +$O(^TIU(8925,"DAD",+TIUC1,0)) D MERGGRAN(TIUDA,+TIUC1)
 . S TIUJ=+$P($G(^TIU(8925,+TIUDA,"TEMP",0)),U,3)
 Q
MERGTEXT(TIUDA,TIU) ; Merge TEMP node from parent document into components
 N TIUTYP
 S TIUTYP=+$P(^TIU(8925,+TIUDA,0),U)
 ; -- If document has components, add/update them
 I +$O(^TIU(8925.1,+TIUTYP,10,0))>0 D
 . N TIUC,TIUI,TIUJ,TIUX,TIUCMP S (TIUI,TIUJ,TIUCMP)=0
 . F  S TIUI=$O(^TIU(8925,+TIUDA,"TEMP",TIUI)) Q:+TIUI'>0  D
 . . S TIUX=$G(^TIU(8925,+TIUDA,"TEMP",TIUI,0))
 . . S TIUC=+$$ISCOMP(TIUTYP,$P(TIUX,":"))
 . . I TIUX[":",+TIUC D
 . . . S TIUJ=0 ; Reinitialize line count for new component
 . . . S TIUCMP=$$GETCOMP(TIUC,TIUDA,.TIU,DFN)
 . . S TIUJ=+$G(TIUJ)+1
 . . I +TIUCMP>0 D
 . . . S ^TIU(8925,+TIUCMP,"TEXT",TIUJ,0)=$G(^TIU(8925,+TIUDA,"TEMP",+TIUI,0))
 . . . S ^TIU(8925,+TIUCMP,"TEXT",0)="^^"_TIUJ_"^"_TIUJ_"^"_DT_"^^"
 . . E  D
 . . . S ^TIU(8925,+TIUDA,"TEXT",TIUJ,0)=$G(^TIU(8925,+TIUDA,"TEMP",TIUJ,0))
 . . . S ^TIU(8925,+TIUDA,"TEXT",0)="^^"_TIUJ_"^"_TIUJ_"^"_DT_"^^"
 ; -- If no components, merge "TEMP" into "TEXT" for current document
 I +$O(^TIU(8925.1,+TIUTYP,10,0))'>0 M ^TIU(8925,+TIUDA,"TEXT")=^TIU(8925,+TIUDA,"TEMP")
 Q
GETTMPL(TIUTYP) ; Get edit template, enforce inheritance
 N TIUDAD,TIUY S TIUDAD=0
 S TIUY=$G(^TIU(8925.1,+TIUTYP,5))
 I TIUY']"",($P(^TIU(8925.1,+TIUTYP,0),U)["ADDENDUM") D
 . S TIUDAD=+$P($G(^TIU(8925,+$P($G(^TIU(8925,+$G(TIUDA),0)),U,6),0)),U)
 . I +TIUDAD S TIUY=$$GETTMPL(TIUDAD)
 I TIUY']"" S TIUDAD=$O(^TIU(8925.1,"AD",+TIUTYP,0))
 I +TIUDAD S TIUY=$$GETTMPL(TIUDAD)
 Q TIUY
AUDIT(TIUDA,TIUCKSM0,TIUCKSM1) ; Update audit trail
 N DIC,DIE,DA,DR,X,Y
 S X=""""_"`"_TIUDA_"""",(DIC,DLAYGO)=8925.5,DIC(0)="FLX" D ^DIC Q:+Y'>0
 S DIE=DIC,DR=".02////"_$$NOW^TIULC_";.03////"_DUZ_";.04////"_TIUCKSM0_";.05////"_TIUCKSM1
 S DA=+Y D ^DIE
 Q
GETLMETH(TIUTYP) ; Get Visit Linkage method, enforce inheritance
 N TIUDAD,TIUY S TIUDAD=0
 S TIUY=$G(^TIU(8925.1,+TIUTYP,7))
 I TIUY']"" S TIUDAD=$O(^TIU(8925.1,"AD",+TIUTYP,0))
 I +TIUDAD S TIUY=$$GETLMETH(TIUDAD)
 Q TIUY
GETVMETH(TIUTYP) ; Get Validation method, enforce enheritance
 N TIUDAD,TIUY S TIUDAD=0
 S TIUY=$G(^TIU(8925.1,+TIUTYP,8))
 I TIUY']"" S TIUDAD=$O(^TIU(8925.1,"AD",+TIUTYP,0))
 I +TIUDAD S TIUY=$$GETVMETH(TIUDAD)
 Q TIUY
 ;
