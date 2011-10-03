TIUT ; SLC/JER - Release from or Send back to transcription ;03/04/10  09:29
 ;;1.0;TEXT INTEGRATION UTILITIES;**3,4,32,100,250**;Jun 20, 1997;Build 14
 ;
 ; ICR #2053    - ^DIE
 ;     #2324    - $$ISA^USRLM
 ;     #10076   - ^XUSEC("TIU AUTOVERIFY",DUZ) Global Var
 ;
SENDBACK(DA) ; Send Document back to transcription
 N DIE,DR,TIUTYP,TIUSBOK
 I $$DADORKID^TIUGBR(DA) S TIUSBOK="0^You cannot send back interdisciplinary entries. They must be detached first."
 I '$D(TIUSBOK) S TIUSBOK=$$CANDO^TIULP(DA,"SEND BACK")
 I +TIUSBOK'>0 D  Q
 . W !,$C(7),$P(TIUSBOK,U,2) ; Echo denial message
 . I $$READ^TIUU("EA","Press RETURN to continue...") W "" ; pause
 L +^TIU(8925,+DA):1
 E  W !?5,$C(7),"Another user is editing this entry." H 3 Q
 S TIUTYP=$P($P(^TIU(8925.1,+^TIU(8925,+DA,0),0),U),U)
 I +$$CANSEND^TIULP1(DA) D
 . S DR=".05///UNRELEASED;1501///@;1306///@;1305///@;1304///@",DIE=8925 D ^DIE
 . W !,TIUTYP," Sent Back." H 2
 . D SENDTRAN^TIUALRT(DA) S TIUCHNG=1
 . ; D UPDTIRT^TIUIRT(.TIU,+DA)
 E  D
 . W !,$C(7),$C(7),$C(7),TIUTYP," Not Sent Back." H 2
 L -^TIU(8925,+DA)
 Q
RELEASE(DA,TIUREL) ; Release Document from transcription
 ; TIUREL=1 ==> Document released
 N DADTYP,DIE,DR,TIUD0,TIUTYP,TIUTNM,TIULINE,TIUDPRM
 S TIUD0=$G(^TIU(8925,+DA,0)),TIUTYP=+TIUD0,TIUTNM=$$PNAME^TIULC1(TIUTYP)
 ; If status is beyond unsigned quit
 I +$P(TIUD0,U,5)>5 Q
 ; If a document is already released quit
 I +$P($G(^TIU(8925,DA,13)),U,4) Q
 ;S TIUREL=$S($G(TIUREL)]"":+$G(TIUREL),+$P($G(^TIU(8925,DA,13)),U,4):1,1:0)
 D DOCPRM^TIULC1(TIUTYP,.TIUDPRM,DA)
 ; If Release is required, and not automatic, prompt user to determine
 ; whether document is ready...
 I '+$G(TIUREL),+$P($G(TIUDPRM(0)),U,2) D  Q:'+TIUREL
 . S TIUREL=$$READ^TIUU("YO","Is this "_TIUTNM_" ready to release from DRAFT","YES","^D REL^TIUDIRH")
 . I '+TIUREL W !," NOT RELEASED." H 2
 ; If release is not required, release automatically this assures alerts
 ; printing, etc. happen appropriately, even for documents where release
 ; from draft is not a "normal" processing step
 I '+$G(TIUREL),'+$P($G(TIUDPRM(0)),U,2) S TIUREL=1
 I +$G(TIUREL) D
 . N TIUVBC,TIUAU,TIUEBY,TIUEC,TIUD12,TIUD13
 . L +^TIU(8925,+DA):1
 . E  W:'$D(ZTQUEUED) !?5,$C(7),"Another user is editing this entry." H 3 Q
 . S TIUD12=$G(^TIU(8925,DA,12)),TIUD13=$G(^(13))
 . S TIUAU=$P(TIUD12,U,2),TIUEC=$P(TIUD12,U,8),TIUEBY=$P(TIUD13,U,2)
 . S TIULINE=$$LINECNT^TIULC(DA),TIUVBC=$$VBCLINES^TIULC(+DA)
 . S DR=".05///"_$S(+$$REQVER^TIULC(+DA,+$P($G(TIUDPRM(0)),U,3)):"UNVERIFIED",1:"UNSIGNED")
 . S DR=DR_";.1////"_TIULINE
 . ; If entered by someone other than the author or expected cosigner, store VBC Line Count
 . I (TIUEBY]""),(TIUAU]""),(TIUEBY'=TIUAU) D
 . . I (TIUEC]""),(TIUEBY=TIUEC) Q
 . . S DR=DR_";1801////"_TIUVBC
 . ; If verification is required and user holds autoverify key, stuff
 . ; verifying clerk and verification date
 . I +$$REQVER^TIULC(+DA,+$P($G(TIUDPRM(0)),U,3)),+$D(^XUSEC("TIU AUTOVERIFY",DUZ)) S DR=DR_";1306////"_DUZ_";1305////"_$$NOW^TIULC
 . S DR=DR_";1304////"_$$NOW^TIULC,DIE=8925 D ^DIE
 . L -^TIU(8925,+DA)
 . I '$D(ZTQUEUED),+$$ISA^USRLM(DUZ,"TRANSCRIPTIONIST") W !,"LINES TYPED: ",TIULINE W:DR[";1801////" !?2,"VBC LINES: ",TIUVBC
 I '$D(ZTQUEUED),(+$P($G(TIUDPRM(0)),U,2)=1) W !,$$PNAME^TIULC1(TIUTYP),$S(+$G(TIUREL):" Released.",1:" Unreleased.") H 2
 I +$G(TIUREL) D
 . N TIURELX
 . S TIURELX=$$RELEASE^TIULC1(+TIUD0)
 . I TIURELX]"" X TIURELX
 . I +$P($G(TIUDPRM(0)),U,8)'>0 D MAIN^TIUPD(+DA,"R")
 . D ALERTDEL^TIUALRT(DA)
 . ;If the document does not require verification, or if the document
 . ;does require verification, but the user holds the AUTOVERIFY key,
 . ;send alerts
 . I $S('+$$REQVER^TIULC(+DA,+$P($G(TIUDPRM(0)),U,3)):1,(+$$REQVER^TIULC(+DA,+$P($G(TIUDPRM(0)),U,3))&$D(^XUSEC("TIU AUTOVERIFY",+DUZ))):1,1:0) D SEND^TIUALRT(DA)
 Q
VERIFY(DA) ; Evaluate requirements for verification, prompt as appropriate
 N DADTYP,TIUTYP,TIUDPRM,TIUTNM,TIUD13,TIUY
 S TIUD13=$G(^TIU(8925,+DA,13))
 S TIUTYP=+$G(^TIU(8925,+DA,0))
 ; I +$$ISADDNDM^TIULC1(DA) D  I 1
 ; . S DADTYP=+$G(^TIU(8925,+$P(^TIU(8925,+DA,0),U,6),0))
 ; . D DOCPRM^TIULC1(DADTYP,.TIUDPRM)
 D DOCPRM^TIULC1(TIUTYP,.TIUDPRM,+DA)
 ; If verification isn't required, or if the user is not authorized to
 ; verify the document, then quit
 I '$D(TIUDPRM(0)) Q
 I '+$$REQVER^TIULC(+DA,+$P(TIUDPRM(0),U,3)) Q
 I '+$$CANDO^TIULP(+DA,"VERIFICATION") Q
 S TIUTNM=$$PNAME^TIULC1(TIUTYP)
 I +$P(TIUD13,U,5) D  I 1
 . W !!,"This "_TIUTNM_" is already verified."
 . S TIUY=$$READ^TIUU("YO","Do you want to UNVERIFY this "_TIUTNM,"NO","^D UNVER^TIUDIRH")
 . I +TIUY W !," UNVERIFIED." D
 . . N DIE,DR
 . . S DIE=8925,DR="1305///@;1306///@" D ^DIE W "."
 . . D ALERTDEL^TIUALRT(DA)
 E  D
 . N DIE,DR,TIUVERX
 . S TIUY=$$READ^TIUU("YO","VERIFY this "_TIUTNM,"NO","^D VER^TIUDIRH")
 . I '+TIUY W !," NOT VERIFIED." Q
 . S DIE=8925,DR=".05///UNSIGNED;1305////"_+$G(DT)_";1306////"_DUZ D ^DIE
 . I +DA W !," VERIFIED." D MAIN^TIUPD(+DA,"V"),SEND^TIUALRT(DA)
 . S TIUVERX=$$VERIFY^TIULC1(+TIUTYP) I TIUVERX]"" X TIUVERX
 Q
