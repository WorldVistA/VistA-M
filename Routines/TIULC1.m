TIULC1 ; SLC/JER - More computational functions ;11/01/03
 ;;1.0;TEXT INTEGRATION UTILITIES;**3,4,40,49,100,131,113,112**;Jun 20, 1997
 ; External References
 ; DBIA 2324  $$ISA^USRLM
 ; Any patch which makes ANY changes to this rtn must include a
 ;note in the patch desc reminding sites to update the Imaging
 ;Gateway.  See IA # 3622.
 ; IN ADDITION, if changes are made to components used by Imaging, 
 ;namely PNAME, backward compatibility may not be enough. If
 ;changes call additional rtns, TIU should consult with Imaging
 ;on need to add additional rtns to list of TIU rtns copied for
 ;Imaging Gateway.
 ;                         ****
 ;
ENCRYPT(X,X1,X2) ; Encrypt Text Strings
 D EN^XUSHSHP
 Q X
DECRYPT(X,X1,X2) ; Decrypt Text Strings
 D DE^XUSHSHP
 Q X
WHOSIGNS(DA) ; Evaluate who should be the expected signer
 N Y,TIU12
 S TIU12=$G(^TIU(8925,+DA,12))
 I $P(TIU12,U,2)'=$P(TIU12,U,9) S Y=$P(TIU12,U,2)
 E  S Y=$P(TIU12,U,9)
 Q Y
WHOCOSIG(DA) ; Evaluate who should be the expected cosigner
 N Y,TIU12
 S TIU12=$G(^TIU(8925,+DA,12))
 I $P(TIU12,U,2)=$P(TIU12,U,9) D
 . I $P(TIU12,U,8)]"" S Y="@"
 . E  S Y=""
 E  S Y=$P(TIU12,U,9)
 Q Y
 ;
HASADDEN(DA,IDKIDFLG) ; Evaluate whether a given record has addenda
 ; **100**:
 ; If +IDKIDFLG, check interdisciplinary kids of DA, as well as DA.
 N TIUI,TIUY,TIUJ,TIUK
 S (TIUI,TIUJ,TIUY)=0
 F  S TIUI=$O(^TIU(8925,"DAD",+DA,TIUI)) Q:+TIUI'>0  D  Q:TIUY
 . I $P($G(^TIU(8925.1,+$G(^TIU(8925,+TIUI,0)),0)),U)["ADDENDUM" S TIUY=1
 I TIUY!'$G(IDKIDFLG) G HASX
 ;**100** Check ID kids for addenda:
 F  S TIUJ=$O(^TIU(8925,"GDAD",+DA,TIUJ)) Q:+TIUJ'>0  D  Q:TIUY
 . S TIUK=0
 . F  S TIUK=$O(^TIU(8925,"DAD",TIUJ,TIUK)) Q:+TIUK'>0  D  Q:TIUY
 . . I $P($G(^TIU(8925.1,+$G(^TIU(8925,+TIUK,0)),0)),U)["ADDENDUM" S TIUY=1
HASX Q TIUY
 ;
ISADDNDM(DA) ; Evaluate whether a given record IS an addendum
 N TIUY S TIUY=0
 I $P($G(^TIU(8925.1,+$G(^TIU(8925,+DA,0)),0)),U)["ADDENDUM",+$P($G(^TIU(8925,+DA,0)),U,6)>0 S TIUY=1
 Q TIUY
PNAME(DA) ; Receives pointer to 8925.1, returns display name of
 ; document class
 N TIUY,TIUMOM S TIUMOM=0
 I +$G(DA)'>0 Q "UNKNOWN"
 S TIUMOM=$O(^TIU(8925.1,"AD",DA,TIUMOM))
 I $P($G(^TIU(8925.1,+DA,0)),U,4)="CO" S TIUMOM=0
 I +$P($G(^TIU(8925.1,+DA,0)),U,9)=0 S TIUMOM=0
 I +TIUMOM>0  D
 . S TIUY=$P($G(^TIU(8925.1,+TIUMOM,0)),U,3)
 . I TIUY']"" S TIUY=$$MIXED^TIULS($P($G(^TIU(8925.1,+TIUMOM,0)),U))
 I +TIUMOM'>0 D
 . S TIUY=$P($G(^TIU(8925.1,+DA,0)),U,3)
 . I TIUY']"" S TIUY=$$MIXED^TIULS($P($G(^TIU(8925.1,+DA,0)),U))
 Q TIUY
ABBREV(DA) ; Get abbreviaton for a document type or class
 Q $P($G(^TIU(8925.1,+DA,0)),U,2)
PERSNAME(USER) ; Receives pointer to 200, returns name field
 N X S X=$$GET1^DIQ(200,USER,.01)
 Q $S($L(X):X,1:"UNKNOWN")
BEEP(USER) ; Get beeper #'s 
 Q $P($G(^VA(200,+USER,.13)),U,7,8)
DOCPRM(TIUTYP,TIUDPRM,TIUDA) ; Get Document Parameters, support inheritance
 N TIUI,TIUDAD
 S (TIUDPRM(0),TIUDPRM(5))=""
 I $P($G(^TIU(8925.1,+TIUTYP,0)),U)["ADDENDUM",+$G(TIUDA) S TIUTYP=+$G(^TIU(8925,+$P($G(^TIU(8925,+TIUDA,0)),U,6),0))
 S TIUI=+$O(^TIU(8925.95,"B",+TIUTYP,0))
 I +TIUI D  Q
 . S TIUDPRM(0)=$G(^TIU(8925.95,+TIUI,0))
 . I +$O(^TIU(8925.95,+TIUI,5,0)) D
 . . N TIUJ S TIUJ=0
 . . F  S TIUJ=$O(^TIU(8925.95,+TIUI,5,TIUJ)) Q:+TIUJ'>0  D
 . . . S $P(TIUDPRM(5),U,TIUJ)=+$G(^TIU(8925.95,+TIUI,5,+TIUJ,0))
 S TIUDAD=$O(^TIU(8925.1,"AD",+TIUTYP,0))
 I +TIUDAD D DOCPRM(TIUDAD,.TIUDPRM)
 Q
POSTFILE(TIUTYP) ; Get Post-filing Code, support inheritance
 N TIUPOST,TIUDAD
 S TIUPOST=$G(^TIU(8925.1,+TIUTYP,4.5))
 I TIUPOST]"" G POSTFILX
 S TIUDAD=$O(^TIU(8925.1,"AD",+TIUTYP,0))
 I +TIUDAD S TIUPOST=$$POSTFILE(TIUDAD)
POSTFILX Q TIUPOST
FIXCODE(TIUTYP) ; Get Error Resolution Code, support inheritance
 N TIUFIX,TIUDAD
 S TIUFIX=$G(^TIU(8925.1,+TIUTYP,4.8))
 I TIUFIX]"" G FIXCODX
 S TIUDAD=$O(^TIU(8925.1,"AD",+TIUTYP,0))
 ; Don't inherit PN code for consults: TIU*1*131
 I +TIUTYP=$$CLASS^TIUCNSLT,TIUDAD=3 G FIXCODX
 I +TIUDAD S TIUFIX=$$FIXCODE(TIUDAD)
FIXCODX Q TIUFIX
DOCCLASS(TIUTYP) ; Given a document type, find its parent document class
 Q +$O(^TIU(8925.1,"AD",+TIUTYP,0))
CLINDOC(TIUTYP,TIUDA) ; Given a document type, find the Clinical Document
 ;                 subclass to which it belongs
 N TIUI,TIUY S (TIUI,TIUY)=0
 I +$G(TIUDA),+$$ISADDNDM(TIUDA) S TIUTYP=+$G(^TIU(8925,+$P($G(^TIU(8925,+TIUDA,0)),U,6),0))
 S TIUI=$O(^TIU(8925.1,"AD",+TIUTYP,TIUI))
 I +TIUI'>0 G CLINDOX
 I TIUI=38 S TIUY=TIUTYP
 I TIUI'=38 S TIUY=$$CLINDOC(TIUI)
CLINDOX Q TIUY
REQVER(TIUTYP,TIUDA) ; Does a given document type require verification
 N TIUDPRM,TIUY
 I +$G(TIUDA),+$$ISADDNDM(TIUDA) S TIUTYP=+$G(^TIU(8925,+$P($G(^TIU(8925,+TIUDA,0)),U,6),0))
 D DOCPRM(TIUTYP,.TIUDPRM)
 I +$P($G(TIUDPRM(0)),U,3) S TIUY=1
 Q +$G(TIUY)
REFDATE(TIU,TIUDICDT) ; Identify Reference date
 N TIURDT
 I +$G(TIU("LDT")) S TIURDT=+$G(TIU("LDT"))_"^0"
 I +$G(TIU("LDT"))'>0 D
 . S TIURDT=$S(+$G(TIUDICDT):+$G(TIUDICDT),1:+$$NOW^TIULC)_"^1"
 . S TIU("LDT")=TIURDT_U_$$DATE^TIULS(TIURDT,"AMTH DD, CCYY@HR:MIN:SEC")
 Q TIURDT
WHATMPL(USER) ; What List Template should a given user get?
 N TIUY
 I +$$ISA^USRLM(USER,"PROVIDER") S TIUY="TIU BROWSE FOR CLINICIAN" G WHAX
 I +$$ISA^USRLM(USER,"MEDICAL RECORDS TECHNICIAN") S TIUY="TIU BROWSE FOR MRT" G WHAX
 I +$$ISA^USRLM(USER,"CHIEF, MIS") S TIUY="TIU BROWSE FOR MGR" G WHAX
 I +$$ISA^USRLM(USER,"MEDICAL STUDENT") S TIUY="TIU BROWSE FOR CLINICIAN" G WHAX
 S TIUY="TIU BROWSE FOR READ ONLY"
WHAX Q TIUY
SUPPVSIT(TIUTYP) ; Evaluate whether to suppress visit matching
 N TIUI,TIUY S TIUY=0
 I +$P($G(^TIU(8925.1,+TIUTYP,3)),U,3) S TIUY=1 G SUPPVSIX
 I $L($P($G(^TIU(8925.1,+TIUTYP,3)),U,3)),($P($G(^(3)),U,3)=0) S TIUY=0 G SUPPVSIX ; ** SLC/JER - NOIS NYC-1298-11472
 S TIUI=0 F  S TIUI=$O(^TIU(8925.1,"AD",+TIUTYP,TIUI)) Q:+TIUI'>0!(+TIUY>0)  D
 . S TIUY=+$$SUPPVSIT(+TIUI)
SUPPVSIX Q TIUY
PTNAME(DFN) ; Resolve Patient Name
 N TIUY S TIUY=$P($G(^DPT(DFN,0)),U)
 S:TIUY']"" TIUY="NAME UNKNOWN"
 Q TIUY
POSTSIGN(TIUTYP) ; Get Post-Signature Code, support inheritance
 N TIUPOST,TIUDAD
 S TIUPOST=$G(^TIU(8925.1,+TIUTYP,4.9))
 I TIUPOST]"" G POSTSIGX
 S TIUDAD=$O(^TIU(8925.1,"AD",+TIUTYP,0))
 I +TIUDAD S TIUPOST=$$POSTSIGN(TIUDAD)
POSTSIGX Q TIUPOST
COMMIT(TIUTYP) ; Get Commitment action, support inheritance
 N TIUCOMM,TIUDAD
 S TIUCOMM=$G(^TIU(8925.1,+TIUTYP,4.1))
 I TIUCOMM]"" G COMMITX
 S TIUDAD=$O(^TIU(8925.1,"AD",+TIUTYP,0))
 I +TIUDAD S TIUCOMM=$$COMMIT(TIUDAD)
COMMITX Q TIUCOMM
RELEASE(TIUTYP) ; Get Release Action, support inheritance
 N TIUREL,TIUDAD
 S TIUREL=$G(^TIU(8925.1,+TIUTYP,4.2))
 I TIUREL]"" G RELEASX
 S TIUDAD=$O(^TIU(8925.1,"AD",+TIUTYP,0))
 I +TIUDAD S TIUREL=$$RELEASE(TIUDAD)
RELEASX Q TIUREL
VERIFY(TIUTYP) ; Get Verification action, support inheritance
 N TIUVER,TIUDAD
 S TIUVER=$G(^TIU(8925.1,+TIUTYP,4.3))
 I TIUVER]"" G VERIFYX
 S TIUDAD=$O(^TIU(8925.1,"AD",+TIUTYP,0))
 I +TIUDAD S TIUVER=$$VERIFY(TIUDAD)
VERIFYX Q TIUVER
DELETE(TIUTYP) ; Get Delete Action, support inheritance
 N TIUDEL,TIUDAD
 S TIUDEL=$G(^TIU(8925.1,+TIUTYP,4.4))
 I TIUDEL]"" G DELETEX
 S TIUDAD=$O(^TIU(8925.1,"AD",+TIUTYP,0))
 I +TIUDAD S TIUDEL=$$DELETE(TIUDAD)
DELETEX Q TIUDEL
REASSIGN(TIUTYP) ; Get Package Reassign Action, support inheritance
 N TIUREASS,TIUDAD
 S TIUREASS=$G(^TIU(8925.1,+TIUTYP,4.45))
 I TIUREASS]"" G REASSIX
 S TIUDAD=$O(^TIU(8925.1,"AD",+TIUTYP,0))
 I +TIUDAD S TIUREASS=$$REASSIGN(TIUDAD)
REASSIX Q TIUREASS
ONBROWSE(TIUTYP)        ; Get OnBrowse Event, support inheritance
 N TIUBRWS,TIUDAD
 S TIUBRWS=$G(^TIU(8925.1,+TIUTYP,6.5))
 I TIUBRWS]"" G ONBRWSX
 S TIUDAD=$O(^TIU(8925.1,"AD",+TIUTYP,0))
 I +TIUDAD S TIUBRWS=$$ONBROWSE(TIUDAD)
ONBRWSX Q TIUBRWS
ONRTRCT(TIUTYP) ; Get OnRetract Event, support inheritance
 N TIURTRCT,TIUDAD
 S TIURTRCT=$G(^TIU(8925.1,+TIUTYP,6.51))
 I TIURTRCT]"" G ONRTRX
 S TIUDAD=$O(^TIU(8925.1,"AD",+TIUTYP,0))
 I +TIUDAD S TIURTRCT=$$ONRTRCT(TIUDAD)
ONRTRX Q TIURTRCT
DIVISION(TIULOC) ; Get Division
 ; Input  -- TIULOC  HOSPITAL LOCATION file (#44) IEN
 ; Output -- TIUIN   INSTITUTION file (#4) IEN^
 ;                   INSTITUTION file (#4) NAME
 N TIUDVHL,TIUSTN,TIUIN
 S TIUDVHL=$P($G(^SC(+TIULOC,0)),U,15)
 I +TIUDVHL D
 . S TIUSTN=$$SITE^VASITE(,TIUDVHL)
 . I $P(TIUSTN,U)>0,($P(TIUSTN,U,2)]"") D
 . . S TIUIN=$P(TIUSTN,U)_U_$P(TIUSTN,U,2)
 I '$G(TIUIN) D
 . S TIUIN=+$G(DUZ(2))_U_$P($$NS^XUAF4(+$G(DUZ(2))),U)
 Q TIUIN
