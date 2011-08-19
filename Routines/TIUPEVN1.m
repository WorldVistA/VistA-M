TIUPEVN1 ; SLC/JER - Event logger Cont'd ;05/20/10  14:09
 ;;1.0;TEXT INTEGRATION UTILITIES;**81,250**;Jun 20, 1997;Build 14
 ;
 ; ICR #10006    - ^DIC Routine & DIC, DLAYGO, X, & Y local vars
 ;     #10018    - ^DIE Routine & DIE, DA, DR, DTOUT, & DUOUT local vars
 ;     #10004    - EN^DIQ Routine & DIC, DA, X, & Y local vars
 ;     #10015    - EN^DIQ1 Routine & DIC, DIQ, DA, & DR local vars
 ;     #10081    - SETUP^XQALERT Routine & XQADATA, XQAID, XQAMSG, & XQAROU  local vars
 ;
FIELDS(EVNTDA,MSG) ; ---- Log missing/incorrect field errors for
 ;                      specific fields in UPLOAD LOG file (#8925.4),
 ;                      in multiple fl. TIU*1*81 moved from TIUPEVNT
 N TIUI S TIUI=0
 F  S TIUI=$O(MSG("DIERR",TIUI)) Q:+TIUI'>0  D
 . N DA,DR,DIC,DIE,DLAYGO,X,Y S DIC="^TIU(8925.4,"_EVNTDA_",1,",DIC(0)="L"
 . I '$D(MSG("DIERR",TIUI,"PARAM","FILE")) Q
 . S ^TIU(8925.4,EVNTDA,1,0)="^8925.42^^",DA(1)=EVNTDA
 . S DLAYGO=8925.42,X=""""_MSG("DIERR",TIUI,"PARAM","FILE")_""""
 . D ^DIC Q:+Y'>0
 . S DIE=DIC,DA(1)=EVNTDA,DA=+Y
 . S DR=".02///"_+$G(MSG("DIERR",TIUI,"PARAM","IENS"))_";.03///"_$G(MSG("DIERR",TIUI,"PARAM","FIELD"))_";.04///"_$G(MSG("DIERR",TIUI,"PARAM",3))
 . D ^DIE,FLDALRT(EVNTDA,DA,$P($G(^TIU(8925.4,+EVNTDA,0)),U,4))
 Q
FLDALRT(EVNTDA,EVNTDA1,ERRMSG) ; ---- Send alerts for missing field errors
 ;                              TIU*1*81 moved from TIUPEVNT
 N XQA,XQAID,XQADATA,XQAMSG,XQAKILL,XQAROU,TIUI,TIUSUB,TYPE,EVNTDA10
 N NOTEDA,NOTE0
 ; ---- TIU*1*81 If this is a TIU docmt, get its title for TYPE
 S EVNTDA10=$G(^TIU(8925.4,EVNTDA,1,EVNTDA1,0))
 I $P(EVNTDA10,U)=8925 D
 . S NOTEDA=$P(EVNTDA10,U,2),NOTE0=$G(^TIU(8925,NOTEDA,0)),TYPE=+NOTE0
 . ; ---- TIU*1*81 If note is addendum, get type of parent note instead
 . I +$$ISADDNDM^TIULC1(NOTEDA) S TYPE=+$$DADTYPE^TIUPUTC(NOTEDA)
 ; ---- else get TYPE from $HDR line, e.g. Progress Notes (3)
 I $G(TYPE)'>0 S TYPE=+$G(TIUREC("TYPE"))
 I TYPE D WHOGETS^TIUPEVN1(.XQA,TYPE)
 ; ---- If no docmt def param recipients found, try site recipients
 I $D(XQA)'>9 D
 . S TIUI=$O(^TIU(8925.99,"B",+$G(DUZ(2)),0)) S:+TIUI'>0 TIUI=+$O(^TIU(8925.99,0))
 . S TIUSUB=0 F  S TIUSUB=$O(^TIU(8925.99,+TIUI,2,TIUSUB)) Q:TIUSUB'>0  D
 . . S XQA($G(^TIU(8925.99,+TIUI,2,TIUSUB,0)))=""
 Q:$D(XQA)'>9
 S XQAID="TIUERR"_","_EVNTDA_","_EVNTDA1
 S XQAMSG=ERRMSG
 W:'$D(ZTQUEUED) !!,XQAMSG
 S XQADATA=ERRMSG_";"_EVNTDA_";"_EVNTDA1
 S XQAROU="FLDISP^TIUPEVN1" ; TIU*1*81 moved from TIUPEVNT
 D SETUP^XQALERT
 Q
FLDISP ; ---- Alert follow-up action for missing field errors
        ;      TIU*1*81 moved from TIUPEVNT
 N DIE,DA,DR,EVNTDA,EVNTDA1,EVNTREC,TIUFIX,TIULINK S TIUFIX=0
 S EVNTDA=+$P(XQADATA,";",2),EVNTDA1=+$P(XQADATA,";",3)
 S EVNTREC=$G(^TIU(8925.4,EVNTDA,1,EVNTDA1,0)) Q:+EVNTREC'>0
 S DIE=$P(EVNTREC,U),DA=$P(EVNTREC,U,2)
 S DR=$P(EVNTREC,U,3)_"//"_$P(EVNTREC,U,4)
 S TIUFIX=$$FIXED(DIE,+DA,+DR)
 I +TIUFIX>0 D  Q
 . W:TIUFIX=1 !!,"Missing field already filled in by another method..."
 . W:TIUFIX=2 !!,"Record #",DA," has been deleted by an authorized user..."
 . W !,"  Nothing left to resolve." H 3
 . S XQAKILL=0 D FLDRSLV(EVNTDA)
 W !!,"You may now enter the correct information:",!
 W !,$P(XQADATA,";"),!
 D RECDISP(DIE,DA)
 I DIE=8925,(+DR=1405) D
 . N TIUREASX,TIUDA
 . S TIUDA=+DA
 . S TIUREASX=$$REASSIGN^TIULC1(+$G(^TIU(8925,+TIUDA,0)))
 . I TIUREASX]"" X TIUREASX S TIULINK=1
 I '+$G(TIULINK) D ^DIE
 ; ---- If TIU Document, do post-filing action send signature alerts
 I DIE="^TIU(8925," D
 . N TIUREC,TIUPOST,DR,DIE,TYPE,TIUD12,TIUD13,TIUEBY,TIUAU,TIUEC
 . S TYPE=$S(+$$ISADDNDM^TIULC1(DA):+$G(^TIU(8925,+$P(^TIU(8925,DA,0),U,6),0)),1:+$G(^TIU(8925,DA,0)))
 . S TIUPOST=$$POSTFILE^TIULC1(TYPE)
 . S TIUREC("#")=DA
 . I TIUPOST]"" X TIUPOST I 1
 . ;if not entered by the author or expected cosigner record VBC Line Count
 . S TIUD12=$G(^TIU(8925,DA,12)),TIUD13=$G(^(13))
 . S TIUEBY=$P(TIUD13,U,2),TIUAU=$P(TIUD12,U,2),TIUEC=$P(TIUD13,U,8)
 . I ((+TIUEBY>0)&(+TIUAU>0))&((TIUEBY'=TIUAU)&(TIUEBY'=TIUEC)) D LINES^TIUSRVPT(DA)
 . D SEND^TIUALRT(DA)
 S TIUFIX=$$FIXED(DIE,+DA,+DR)
 I +$G(TIUFIX)'>0 K XQAKILL Q
 S XQAKILL=0
 ; ---- If field is fixed, evaluate whether whole event is resolved
 D FLDRSLV(EVNTDA)
 Q
RECDISP(DIC,DA) ; ---- Call DIQ to display the existing record
 ;              TIU*1*81 moved from TIUPEVNT
 N X,Y,DIQ,DR
 I '+$$READ^TIUU("Y","Display ENTIRE existing record","NO") Q
 W ! S DIC=$G(^DIC(DIC,0,"GL"))
 D EN^DIQ
 Q
FIXED(DIC,DA,DR) ; ---- Evaluate whether the field has been filled in
 ;                      TIU*1*81 moved from TIUPEVNT
 N DIQ,X,Y,TIUY,TIUFIX S TIUY=0,DIQ="TIUFIX",DIQ(0)="IN"
 I '$D(^TIU(8925,DA,0)) S TIUY=2 G FIXX
 D EN^DIQ1 I $D(TIUFIX) S TIUY=1
FIXX Q TIUY
FLDRSLV(ERRDA) ; ---- Evaluate missing field errors; mark resolved
 ;              TIU*1*81 moved from TIUPEVNT
 N TIUK,TIUFLD,RSLVED
 S TIUK=0,RSLVED=1
 ; ---- TIU*1*81 Mark resolved only if ALL missing fields are fixed
 F  S TIUK=$O(^TIU(8925.4,+ERRDA,1,TIUK)) Q:+TIUK'>0  Q:'RSLVED  D
 . N DIC,DIQ,DA,DR S DA=TIUK,DIC="^TIU(8925.4,"_+ERRDA_",1,"
 . S DR=".01:.04",DIQ="TIUFLD(" D EN^DIQ1 Q:$D(TIUFLD)'>9
 . I '$$FIXED(8925,+$G(TIUFLD(8925.42,DA,.02)),+$G(TIUFLD(8925.42,DA,.03)))=1 S RSLVED=0
 Q:'RSLVED
 N DIE,DR
 S DA=+ERRDA,DIE=8925.4,DR=".06////1;.07////"_$$NOW^TIULC D ^DIE
 Q
 ;
WHOGETS(TIUY,TIUTYP) ; ---- Who gets filing error/missing field alerts;
 ;                      Get 8925.95 (document parameter) recipients.
 ; ---- TIUTYP is title IFN in 8925.1 if valid title was uploaded, else
 ;             is IFN of entry from $HDR line:     e.g. PROGRESS NOTES
 ;      Starts at initial TIUTYP; goes up hierarchy til it finds entry.
 ; ---- TIU*1*81 Don't new TIUDAD HERE!
 N TIUI,TIUJ
 ; ---- TIU*1*81 TIUTITLE is killed before missing fld alerts are sent,
 ;      so don't use it here
 Q:+$G(TIUTYP)'>0
 S TIUI=$O(^TIU(8925.95,"B",+TIUTYP,0))
 ; ---- If TIUTYP has docmt parameter, get recipients and don't look
 ;      further up:
 I +TIUI D  Q
 . S TIUJ=0
 . F  S TIUJ=$O(^TIU(8925.95,+TIUI,4,+TIUJ)) Q:+TIUJ'>0  D
 . . N TIUDUZ
 . . S TIUDUZ=+$G(^TIU(8925.95,+TIUI,4,+TIUJ,0)) Q:+TIUDUZ'>0
 . . S TIUY(TIUDUZ)=""
 ; ---- If none found, try further up
 S TIUDAD=$O(^TIU(8925.1,"AD",+TIUTYP,0))
 I +TIUDAD D WHOGETS(.TIUY,TIUDAD)
 Q
