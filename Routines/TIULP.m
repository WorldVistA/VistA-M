TIULP ; SLC/JER - Functions determining privilege ; 12/13/10 3:45pm
 ;;1.0;TEXT INTEGRATION UTILITIES;**98,100,116,109,138,152,175,157,182,184,217,236,234,232,241**;Jun 20, 1997;Build 7
 ; CANDO^USRLA: ICA 2325, ISA^USRLM: ICA 2324
 ; 8930.1,2,8: IACS 3129,3128,3104 
CANDO(TIUDA,TIUACT,PERSON) ; Can PERSON perform action now
 ; Receives: TIUDA=Record number in file 8925
 ;           TIUACT=Name of user action in 8930.8 (USR ACTION)
 ;           PERSON=New Person file IFN.
 ;                  Assumed to be DUZ if not received.
 ;                  New **100** ID param, backward compatible.
 ;  Returns:   TIUY=1:yes,0:no_"^"_why not message
 N TIUI,TIUTYP,TIUROLE,STATUS,TIUY,TIUATYP,MSG,WHO,MODIFIER,TIUD0,TIUACTW
 S TIUY=0 I '$G(PERSON) S PERSON=DUZ
 S TIUD0=$G(^TIU(8925,+TIUDA,0)) I 'TIUD0 G CANDOX
 I $$ISPRFDOC^TIUPRF(TIUDA),((TIUACT="ATTACH ID ENTRY")!(TIUACT="ATTACH TO ID NOTE")) S TIUY="0^Patient Record Flag notes may not be used as Interdisciplinary notes." G CANDOX
 S TIUACTW=$G(TIUACT)
 ;**100** was I +TIUACT'>0 S TIUACT etc.
 S TIUACT=$$USREVNT(TIUACT) I +TIUACT'>0 G CANDOX
 ; -- Historical Procedures - Prohibit actions detailed in
 ;    HPCAN^TIUCP: P182
 N HPCAN I $$ISHISTCP^TIUCP(+TIUD0) S HPCAN=$$HPCAN^TIUCP(+TIUACT) I 'HPCAN S TIUY=HPCAN G CANDOX
 ; **152 Get status
 S STATUS=+$P(TIUD0,U,5)
 ; **152[234] prevents editing or sending back a completed or uncosigned document.
 I STATUS>5,(+TIUACT=9)!(+TIUACT=17) D  G CANDOX
 . ; **152[234] Displays message to user
 . I +TIUACT=9 S TIUY="0^ You may not edit uncosigned or completed documents."
 . I +TIUACT=17 S TIUY="0^You may not send back uncosigned or completed documents."
 ; -- In case business rules have changed, & children already existed:
 I +TIUACT=24,$D(^TIU(8925,"GDAD",TIUDA)) D  G CANDOX
 . S TIUY="0^ This note cannot be attached; it has its own children."
 I +TIUACT=25,+$G(^TIU(8925,TIUDA,21)) D  G CANDOX
 . S TIUY="0^ This note cannot receive interdisciplinary children; it is itself a child."
 ;VMP/AM P241 If note is administratively closed, then bypass check for blank characters
 I $P($G(^TIU(8925,+TIUDA,16)),U,13)'="S",+TIUACT=4!(+TIUACT=5),+$$BLANK^TIULC(TIUDA) D  G CANDOX ;Sets TIUPRM1
 . S TIUY="0^ Contains blanks ("_$P(TIUPRM1,U,6)_") which must be filled before "_$P(TIUACT,U,2)_"ATURE."
 S TIUROLE=$$USRROLE(TIUDA,PERSON)
 S TIUTYP=+TIUD0
 I $$ISADDNDM^TIULC1(+TIUDA) S TIUATYP=TIUTYP,TIUTYP=+$G(^TIU(8925,+$P(TIUD0,U,6),0))
 I TIUROLE']"" S TIUY=$$CANDO^USRLA(TIUTYP,STATUS,+TIUACT,PERSON)
 F TIUI=1:1:($L(TIUROLE,U)-1) D  Q:+$G(TIUY)>0
 . S TIUY=$$CANDO^USRLA(TIUTYP,STATUS,+TIUACT,PERSON,$P(TIUROLE,U,TIUI))
 I +$G(TIUATYP) S TIUTYP=+$G(TIUATYP)
 ;**100** update for PERSON param; update for verb modifier:
 I +TIUY'>0 D  G CANDOX
 . S WHO=" You"
 . ;I PERSON'=DUZ S WHO=$P(^VA(200,PERSON,0),U),WHO=$$NAME^TIULS(WHO,"FIRST LAST")
 . I PERSON'=DUZ S WHO=$$NAME^TIULS($$GET1^DIQ(200,PERSON,.01),"FIRST LAST") ;P182
 . S MODIFIER=$P(TIUACT,U,3) I $L(MODIFIER) S MODIFIER=" "_MODIFIER
 . ;e.g. "You may not ATTACH this UNSIGNED TELEPHONE NOTE TO AN ID NOTE."
 . S MSG=WHO_" may not "_$P(TIUACT,U,2)_" this "_$P($G(^TIU(8925.6,+STATUS,0)),U)_" "_$$PNAME^TIULC1(TIUTYP)_MODIFIER_"."
 . S TIUY=TIUY_U_MSG
 I +TIUACT=15,$$HASIMG^TIURB2(+TIUDA) D  G CANDOX
 . S TIUY="0^ This document contains linked images. You must ""delete"" the Images using the Imaging package before proceeding."
 ;VMP/ELR P217. Do not allow deletion of a parent with child
 I $G(TIUACTW)["DELETE RECORD",$$HASIDKID^TIUGBR(+TIUDA) D  G CANDOX
 . ;VMP/ELR P232. Create new error msg.
 . NEW TIUMSG D IDMSG^TIULP3(.TIUMSG) S TIUY="0^"_TIUMSG
 ;VMP/ELR P232 do not allow edit, delete or addendum on NIR and Anesthesia report  IA3356 FOR XQY0
 I (($G(XQY0)["OR CPRS GUI CHART")!($G(XQY0)["TIU ")),$$ACTION^TIULP3($G(TIUACTW)),$$ISSURG^TIULP3(+TIUDA) D  G CANDOX
 . S TIUY="0^ "_$$SURMSG^TIULP3($G(TIUACTW))
CANDOX Q TIUY
 ;
CANLINK(TIUTYP) ; Can user (DUZ) link (attach) a document of a particular type
 ;to an ID note.
 ; For use in ADD NEW ID NOTE, where docmt is not entered yet.
 ; Assume most favorable circumstances (user will complete
 ;the note, so if user still can't attach, can tell them no,
 ;when they first select title for the new entry.
 ; Rule out if TIUTYP can be an ID parent, since ID parent
 ;and ID kid function as mutually exclusive, (regardless of
 ;business rules).
 N TIUACT,STATUS,USRROLE,TIUY
 S TIUACT=$$USREVNT("ATTACH TO ID NOTE"),STATUS=7 ; complete
 S USRROLE=+$O(^USR(8930.2,"B","COMPLETER",0))
 S TIUY=$$CANDO^USRLA(TIUTYP,STATUS,+TIUACT,DUZ,USRROLE)
 I '$G(TIUY) S TIUY="0^ You may not use this title for interdisciplinary child entries." Q TIUY
 ; -- If user can attach a certain note, but note can also receive
 ;    ID entries, don't let user attach it. --
 I $$POSSPRNT^TIULP(TIUTYP) S TIUY="0^ This interdisciplinary PARENT title cannot be used for CHILD entries."
 ; -- If selected type is a CWAD, don't let user attach it: --
 I $$ISCWAD^TIULX(TIUTYP) S TIUY="0^ CWAD titles cannot be used for interdisciplinary entries."
 ; -- If selected type is a PRF, don't let user attach it: --
 I $$ISPFTTL^TIUPRFL(TIUTYP) S TIUY="0^ Patient Record Flag titles cannot be used for interdisciplinary entries."
 ; -- If selected type is a consult, don't let user attach it: --
 I $$ISA^TIULX(TIUTYP,+$$CLASS^TIUCNSLT) S TIUY="0^ Consult titles cannot be used for interdisciplinary entries."
 Q TIUY
 ;
POSSPRNT(TIUTYP) ; Is a docmt intended as a possible ID parent?
 ;Returns 1^WHYCAN'TATTACH if there are business rules permitting ANYONE
 ;to attach ID entries to notes of type TIUTYP.
 ;Else returns 0.
 N TIUACT,STATUS,TIUY,DADTYP
 S TIUY=0,TIUACT=+$$USREVNT("ATTACH ID ENTRY")
 F STATUS=6,7,8 D  G:TIUY POSSX
 . I $O(^USR(8930.1,"AR",TIUTYP,STATUS,TIUACT,0)) S TIUY=1 Q
 . I $O(^USR(8930.1,"AC",TIUTYP,STATUS,TIUACT,0)) S TIUY=1
 ; -- If no rules for TIUTYP, try its parent: --
 S DADTYP=$O(^TIU(8925.1,"AD",TIUTYP,0)) G:DADTYP'>0 POSSX
 S TIUY=$$POSSPRNT(DADTYP)
POSSX I TIUY S TIUY="1^ Interdisciplinary PARENT notes cannot be attached as CHILD entries."
 Q TIUY
 ;
CANENTR(TIUTYP) ; Evaluate privilege to enter a document of a particular type
 N TIUACT,STATUS,USRROLE,TIUY
 S TIUACT=$$USREVNT("ENTRY"),STATUS=2 ; untranscribed
 S USRROLE=3 ; transcriber
 S TIUY=$$CANDO^USRLA(TIUTYP,STATUS,+TIUACT,DUZ,USRROLE)
 Q TIUY
USRROLE(TIUDA,PERSON) ; Identify the user's role with respect to the document
 ; 3/20/00 **100** Added role COMPLETER
 ; 3/20/00 **100** Added PERSON param
 N TIU0,TIU12,TIU13,TIUY,TIU15,COMPLTR,STATUS
 S PERSON=$G(PERSON,DUZ)
 S TIU0=$G(^TIU(8925,+TIUDA,0)),STATUS=$P(TIU0,U,5)
 S TIU12=$G(^TIU(8925,+TIUDA,12))
 S TIU13=$G(^TIU(8925,+TIUDA,13)),TIU15=$G(^TIU(8925,+TIUDA,15))
 I PERSON=+$P(TIU13,U,2) S TIUY=+$O(^USR(8930.2,"B","TRANSCRIBER",0))_U
 I PERSON=+$P(TIU12,U,2) S TIUY=$G(TIUY)_+$O(^USR(8930.2,"B","AUTHOR/DICTATOR",0))_U
 I PERSON=+$P(TIU12,U,9) S TIUY=$G(TIUY)_+$O(^USR(8930.2,"B","ATTENDING PHYSICIAN",0))_U
 I PERSON=+$P(TIU12,U,4) S TIUY=$G(TIUY)_+$O(^USR(8930.2,"B","EXPECTED SIGNER",0))_U
 I PERSON=+$P(TIU12,U,8) S TIUY=$G(TIUY)_+$O(^USR(8930.2,"B","EXPECTED COSIGNER",0))_U
 I $$ASURG^TIUADSIG(TIUDA) S TIUY=$G(TIUY)_+$O(^USR(8930.2,"B","SURROGATE",0))_U ;P157
 ;Check if the person can be an Interpreter for this document via a Consult API
 I $$CPINTERP^GMRCCP(+TIUDA,PERSON) S TIUY=$G(TIUY)_+$O(^USR(8930.2,"B","INTERPRETER",0))_U
 I STATUS>6 D  I COMPLTR S TIUY=$G(TIUY)_+$O(^USR(8930.2,"B","COMPLETER",0))_U
 . S COMPLTR=0
 . I PERSON=+$P(TIU15,U,8) S COMPLTR=1 Q
 . I '$P(TIU15,U,8),PERSON=+$P(TIU15,U,2) S COMPLTR=1
 I +$O(^TIU(8925.7,"AE",+TIUDA,+PERSON,0)) D
 . N TIUXTRA S TIUXTRA=+$O(^TIU(8925.7,"AE",+TIUDA,+PERSON,0))
 . I +$P($G(^TIU(8925.7,+TIUXTRA,0)),U,4) Q
 . S TIUY=$G(TIUY)_+$O(^USR(8930.2,"B","ADDITIONAL SIGNER",0))_U
 Q $G(TIUY)
USREVNT(EVENT) ; Given event name, return:
 ;EVENT = event pointer^user verb^verb modifier
 ; **100** added verb modifier piece (.07)
 N TIUY,TIUDA,NODE0
 S TIUDA=+$O(^USR(8930.8,"B",EVENT,0))
 S NODE0=$G(^USR(8930.8,TIUDA,0))
 S TIUY=TIUDA_U_$P(NODE0,U,5)_U_$P(NODE0,U,7)
 Q TIUY
CANPICK(TIUTYP) ; Screens selection of title by title status and
 ;(for status TEST), by owner.
 N TIUPOWN,TIUCOWN,TIUT0,TIUTSTAT,TIUY S TIUY=0
 S TIUT0=$G(^TIU(8925.1,+TIUTYP,0)),TIUTSTAT=$P(TIUT0,U,7)
 I TIUTSTAT']"" S TIUY=0 G CANPIX
 I TIUTSTAT=13 S TIUY=0 G CANPIX
 I TIUTSTAT=11 S TIUY=1 G CANPIX
 S TIUPOWN=$P(TIUT0,U,5),TIUCOWN=+$P(TIUT0,U,6)
 I TIUTSTAT=10 S TIUY=$S(TIUPOWN=DUZ:1,+$$ISA^USRLM(DUZ,TIUCOWN):1,1:0)
CANPIX Q +$G(TIUY)
REQCOSIG(TIUTYP,TIUDA,USER,TIUDT) ; Evaluate whether user requires cosignature
 N TIUI,TIUY,TIUDPRM S USER=$S(+$G(USER):+$G(USER),1:+$G(DUZ))
 D DOCPRM^TIULC1(TIUTYP,.TIUDPRM,+$G(TIUDA))
 I $G(TIUDPRM(5))="" G REQCOSX
 I +$G(TIUDT)'>0 S TIUDT=+$P($P(+$G(^TIU(8925,+$G(TIUDA),13)),U),".")
 F TIUI=1:1:$L(TIUDPRM(5),U) D  Q:+TIUY>0
 . S TIUY=+$$ISA^USRLM(+USER,+$P(TIUDPRM(5),U,TIUI),,+$G(TIUDT))
REQCOSX Q +$G(TIUY)
 ;
REQCPF(TIUCDA) ;Check if clinical procedure fields are required
 ; Input  -- TIUCDA   Request/Consult File (#123) IEN
 ; Output -- 1=Required and 0=Not Required
 N TIUCPACT,REQF
 I '$G(TIUCDA) G REQCPFQ
 S TIUCPACT=$$CPACTM^GMRCCP(TIUCDA)
 I TIUCPACT=1!(TIUCPACT=3) S REQF=1
REQCPFQ Q +$G(REQF)
