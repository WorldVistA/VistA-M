TIULG ; SLC/JER - More Library functions ;5/27/03
 ;;1.0;TEXT INTEGRATION UTILITIES;**1,89,137**;Jun 20, 1997
 ;
TYPSHORT(INTTYPE) ; Return "TL" for Interior Type "DOC",
 ;Return int type for others
 N TIUY
 S TIUY=$S(INTTYPE="DOC":"TL",1:INTTYPE)
 Q TIUY
TYPEXT(INTTYPE) ; Given interior type DOC, DC, or CL of Docmt Def,
 ;return exterior type
 N TIUY
 S TIUY=$S(INTTYPE="DOC":"TITLE",INTTYPE="DC":"DOCUMENT CLASS",INTTYPE="CL":"CLASS",1:"Document Definition")
 Q TIUY
 ;
BADSIG(TIUX,NOAUTH) ; Sig failed
 N TIUTNAME
 I TIUX=0 D
 . W !!,"Use 'Edit Electronic Signature Code' option"
 . W !,"on Secondary Menu under User's Toolbox." H 4
 I +$G(NOAUTH) W !!,$C(7),$C(7),"Only authorized PROVIDERS may sign.  Contact IRM for PROVIDER Key allocation."
 S TIUTNAME=$S(+$G(TIUTYP):$$PNAME^TIULC1(TIUTYP),$G(TIUTYP)]"":TIUTYP,1:"DOCUMENT")
 W !!,$C(7),"< ",$$UPPER^TIULS($G(TIUTNAME))
 W " SAVED - WITHOUT SIGNATURE >",!
 S TIUX=$$READ^TIUU("FOA","Press RETURN to continue...")
 Q
PRNTMTHD(TIUTYP,TIUDA) ; Get print method/enforce inheritance
 N TIUDAD,TIUY S TIUDAD=0
 I +$G(TIUDA),+$$ISADDNDM^TIULC1(TIUDA) S TIUTYP=$$PRNTYP(TIUDA)
 S TIUY=$G(^TIU(8925.1,+TIUTYP,6))
 I TIUY']"" S TIUDAD=$O(^TIU(8925.1,"AD",+TIUTYP,0))
 I +TIUDAD S TIUY=$$PRNTMTHD(TIUDAD)
 Q TIUY
PRNTGRP(TIUTYP,TIUDA) ; Get print group/enforce inheritance
 N TIUDAD,TIUY S TIUDAD=0
 I +$G(TIUDA),+$$ISADDNDM^TIULC1(TIUDA) S TIUTYP=$$PRNTYP(TIUDA)
 S TIUY=$P($G(^TIU(8925.1,+TIUTYP,6.1)),U,3)
 I TIUY']"" S TIUDAD=$O(^TIU(8925.1,"AD",+TIUTYP,0))
 I +TIUDAD S TIUY=$$PRNTGRP(TIUDAD)
 Q TIUY
PRNTHDR(TIUTYP,TIUDA) ; Get print form header/enforce inheritance
 N TIUDAD,TIUY S TIUDAD=0
 I +$G(TIUDA),+$$ISADDNDM^TIULC1(TIUDA) S TIUTYP=$$PRNTYP(TIUDA)
 S TIUY=$P($G(^TIU(8925.1,+TIUTYP,6.1)),U)
 I TIUY']"" S TIUDAD=$O(^TIU(8925.1,"AD",+TIUTYP,0))
 I +TIUDAD S TIUY=$$PRNTHDR(TIUDAD)
 Q TIUY
PRNTNBR(TIUTYP,TIUDA) ; Get print form number/enforce inheritance
 N TIUDAD,TIUY S TIUDAD=0
 I +$G(TIUDA),+$$ISADDNDM^TIULC1(TIUDA) S TIUTYP=$$PRNTYP(TIUDA)
 S TIUY=$P($G(^TIU(8925.1,+TIUTYP,6.1)),U,2)
 I TIUY']"" S TIUDAD=$O(^TIU(8925.1,"AD",+TIUTYP,0))
 I +TIUDAD S TIUY=$$PRNTNBR(TIUDAD)
 Q TIUY
PRNTYP(TIUDA)   ; Get the type of an addendum's parent document
 N TIUDADA
 S TIUDADA=+$P($G(^TIU(8925,+TIUDA,0)),U,6)
 Q +$G(^TIU(8925,+TIUDADA,0))
XTRASGNR(TIUY,TIUDA) ; Get List of Extra Expected Signers
 N TIUI S TIUI=0
 F  S TIUI=$O(^TIU(8925.7,"B",TIUDA,TIUI)) Q:+TIUI'>0  D
 . N TIUDUZ,TIUREQ
 . S TIUDUZ=+$P(^TIU(8925.7,+TIUI,0),U,3),TIUREQ=$P(^(0),U,2)
 . Q:+TIUDUZ'>0!(+$P($G(^TIU(8925.7,+TIUI,0)),U,4)>0)
 . S TIUY(TIUDUZ)=TIUREQ_U_$$SIGNAME^TIULS(TIUDUZ)_U_$$SIGTITL^TIULS(TIUDUZ)
 Q
 ;
ACTIVATE(TIUARRAY,SUCCESS) ; Activate DDEFs
 ; Activates IENs in received array TIUARRAY(IEN)=whatever
 ; Sets SUCCESS(IEN) = 1 if IEN activated successfully
 ;                   = 0^whynot if not
 ; Sets SUCCESS = 1 if all activated successfully
 ;               = 0 if not
 ; Called when exporting new DDEFS and Business Rules, after we
 ;know that rules were created successfully.
 ; Skips safeguards present when using DDEF utility to
 ;activate DDEFs
 N IEN,TIUFPRIV
 S IEN=0,TIUFPRIV=1
 S SUCCESS=1
 F  S IEN=$O(TIUARRAY(IEN)) Q:'IEN  D
 . N FDA,TIUERR
 . S FDA(8925.1,IEN_",",.07)="ACTIVE"
 . D FILE^DIE("KE","FDA","TIUERR")
 . I '$D(TIUERR) S SUCCESS(IEN)=1 Q
 . S SUCCESS(IEN)="0^"_$G(TIUERR("DIERR",1,"TEXT",1))
 . S SUCCESS=0
 Q
