TIURD3  ; SLC/JER - Reassign actions ;11/01/03
 ;;1.0;TEXT INTEGRATION UTILITIES;**61,124,113,112**;Jun 20, 1997
REASSIGO ; Reassign an original Document
 N TIU,TIUASK,TIUDPRM
 W !!,"Please choose the correct PATIENT and CARE EPISODE:",!
 ; --- Get a patient ---
 S DFN=+$$PATIENT^TIULA
 ; --- If no pt. selected, QUIT ---
 I +$G(DFN)'>0 D  Q
 . S TIUOUT=1
 . W !!,"No PATIENT Selected: Aborting Transaction, No Harm Done...",!
 . I $$READ^TIUU("EA","Press RETURN to continue...") ; pause
 ; --- If document is a Surgical Report, redirect processing ---
 I +$$ISA^TIULX(TIUTYPE,+$$CLASS^TIUSROI("SURGICAL REPORTS")) D REASSOP^TIUSROI(DFN,TIUDA) Q
 ; --- If moving to another pt keep retracted original ---
 I +$G(DFN)'=$P(TIUD0(0),U,2),(+$P(TIUD0(0),U,5)>5) D
 . W !!,"Moving signed document to another Patient...A RETRACTED copy will be retained.",!
 . S TIUODA=TIUDA,TIUDA=+$$RETRACT^TIURD2(TIUDA)
 I TIUDA'>0 D  Q
 . S TIUOUT=1
 . W !!,"Creation of a new Copy of the RETRACTED record failed...Contact IRM.",!
 . I $$READ^TIUU("EA","Press RETURN to continue...") ; pause
 ; --- Get Document Parameters for TIUTYPE
 D DOCPRM^TIULC1(TIUTYPE,.TIUDPRM)
 ; --- Get associated visit ---
 S TIULMETH=$$GETLMETH^TIUEDI1(TIUTYPE)
 I '$L(TIULMETH) D  Q
 . S TIUOUT=1
 . W !!,$C(7),"No Visit Linkage Method defined for "
 . W $$PNAME^TIULC1(TIUTYPE),".",!,"Please contact IRM...",!
 . I $$READ^TIUU("EA","Press RETURN to continue...") ; pause
 X TIULMETH
 I '$D(TIU) D  Q
 . S TIUOUT=1
 . W !!,$C(7),"Patient & Visit required: Aborting Transaction...No Harm Done.",!
 . I $$READ^TIUU("EA","Press RETURN to continue...") ; pause
 ; --- Validate Selection ---
 S TIUVMETH=$$GETVMETH^TIUEDI1(TIUTYPE)
 I '$L(TIUVMETH) D  Q
 . S TIUOUT=1
 . W !!,$C(7),"No Validation Method defined for "
 . W $$PNAME^TIULC1(TIUTYPE),".",!,"Please contact IRM...",!
 . I $$READ^TIUU("EA","Press RETURN to continue...") ; pause
 X TIUVMETH
 I +$G(TIUASK)'>0 D  Q
 . S TIUOUT=1
 . W !!,$C(7),"Okay, No Harm Done.",!
 . I $$READ^TIUU("EA","Press RETURN to continue...") W ""
 ; --- If same Pt & Visit, abort transaction ---
 I +$G(TIU("VISIT"))=$P(TIUD0(0),U,3) D  Q:+$G(TIUOUT)
 . I +$G(TIUADD0),+$P($G(TIUDPRM(0)),U,10) Q
 . S TIUOUT=1
 . W !!,$C(7),$C(7),$C(7),"This ",$$PNAME^TIULC1(TIUTYPE)," is already associated with the selected visit...",!
 . W !,"No action taken.",!
 . I $$READ^TIUU("EA","Press RETURN to continue...") ; pause
 ; --- If valid Pt and Visit, Reassign the document ---
 I $L($G(TIU("VSTR"))) D
 . N DA,DR,DIE,TIUORIG,TIUOLD0
 . S TIUORIG=+$O(^TIU(8925,"APTLD",DFN,TIUTYPE,$G(TIU("VSTR")),0))
 . S TIUOLD0=$G(^TIU(8925,+TIUORIG,0))
 . ; If record exists and >1 documents/visit NOT allowed, offer
 . ; chance to attach record as addendum
 . I +TIUORIG,(+$P(TIUDPRM(0),U,10)'>0),(+$P(TIUOLD0,U,5)'>13) D  Q
 . . N TIUATT
 . . I TIUORIG=TIUDA D  Q
 . . . W !,$C(7),$C(7),$C(7),"This ",$$PNAME^TIULC1(TIUTYPE)," is already associated with the selected visit...",!
 . . . W !,"No action taken.",!
 . . . I $$READ^TIUU("EA","Press RETURN to continue...") ; pause
 . . W !!,$C(7),$C(7),$C(7),"This patient already has a "
 . . W $$UP^XLFSTR($$PNAME^TIULC1(TIUTYPE))," for the selected care"
 . . W !,"episode. Do you wish to make the current record an ADDENDUM of that ",!,$$UP^XLFSTR($$PNAME^TIULC1(TIUTYPE)),"?",!
 . . S TIUATT=$$READ^TIUU("YOA","   ...OK? ","YES")
 . . I +TIUATT'>0 D  Q
 . . . W !!,"All right. No harm done.",!
 . . . S TIUOUT=1
 . . . I $$READ^TIUU("EA","Press RETURN to continue...") ; pause
 . . D DELIRT^TIUDIRT($S(+$G(TIUODA):+TIUODA,1:+TIUDA))
 . . D ATTACH^TIURD2(+TIUORIG,TIUDA),SEND^TIUALRT(TIUDA) S TIUCHNG=1
 . ; --- Roll back old IRT data ---
 . D DELIRT^TIUDIRT($S(+$G(TIUODA):+TIUODA,1:+TIUDA))
 . ; --- Set up the ^DIE Call ---
 . S DR=$G(DR)_".02////"_DFN_";.03////"_$S(+$P($G(TIU("VISIT")),U):$P($G(TIU("VISIT")),U),1:"@")_";.07////"_$P($G(TIU("EDT")),U)_";.08////"_$S(+$G(TIU("LDT")):$P($G(TIU("LDT")),U),1:"@")_";.13////"_$P($G(TIU("VSTR")),";",3)
 . S DR=DR_";1205////"_$P($G(TIU("LOC")),U)_";1401////"_$S($L($G(TIU("AD#"))):+$G(TIU("AD#")),1:"@")_";1402////"_$P($G(TIU("TS")),U)_";1211////"_$P($G(TIU("VLOC")),U)_";1212////"_$P($G(TIU("INST")),U)
 . S:+$$ISDS^TIULX(TIUTYPE) DR=DR_";1301////^S X="_$$REFDTO^TIURD2(TIUDA,.TIU)
 . ; --- Don't ask author or cosigner for documents that have been signed ---
 . S:+$P($G(^TIU(8925,+TIUDA,0)),U,5)'>5 DR=DR_";1202;1204////^S X=$P(^TIU(8925,DA,12),U,2);I '+$P($G(^TIU(8925,+TIUDA,12)),U,8) S Y=0;1208"
 . ; --- Call ^DIE to affect the Reassignment ---
 . S DA=TIUDA,DIE=8925 D ^DIE
 . ; --- Post-reassignment Steps ---
 . ; 1. Package Reassign Action:
 . D PKGACT(TIUDA,.TIUD0,.TIUD12,.TIUD13,.TIUD14,.TIUOUT)
 . Q:+$G(TIUOUT)
 . W !!,$G(TIUNAME)," Reassigned.",!
 . ; 2. Attach document to new Visit
 . D QUE^TIUPXAP1
 . ; 3. Update Addenda to Document
 . D UPDTADD^TIURD2(TIUDA)
 . ; 4. Update IRT Record
 . D UPDTIRT^TIUDIRT(.TIU,+TIUDA)
 . ; 5. Send Signature Alerts
 . D SEND^TIUALRT(TIUDA)
 . ; 6. Audit Reassignment
 . S TIUD0(1)=$G(^TIU(8925,+TIUDA,0)),TIUD12(1)=$G(^(12))
 . D AUDREASS^TIURB1(TIUDA,.TIUD0,.TIUD12)
 . ; 7. If document was retracted, register audit trail for it
 . I +$G(TIUODA) D AUDREASS^TIURB1(TIUODA,.TIUD0,.TIUD12)
 . I +$P($G(TIUD0(0)),U,3) D WKLD(.TIUD0,.TIUD12)
 . ;Finally, collect workload for target visit as appropriate
 . I (+$P(^TIU(8925,+TIUDA,0),U,5)>6),+$P(^TIU(8925,+TIUDA,0),U,11) D
 . . I $P(+$G(TIU("EDT")),".")'>DT D  Q:'+TIUASK
 . . . W !!,"You may now edit the encounter data for the DESTINATION Visit...",!
 . . . W !,"Patient: ",$G(TIU("PNM")),!,"  Visit: ",$P($G(TIU("EDT")),U,2)," to ",$P($G(TIU("VLOC")),U,2)
 . . . W ! S TIUASK=+$$READ^TIUU("Y","Do you wish to do this now","NO")
 . . ;If no workload process using TIU's interview
 . . ;else, process using PCE's interview
 . . I '$$CHKVST^TIUPXAP2(+TIUDA) D  I 1
 . . . N TIUCONT,TIUPRMT
 . . . Q:$D(XWBOS)
 . . . I $P(+$P(^TIU(8925,+TIUDA,0),U,7),".")>DT D  Q
 . . . . W !!
 . . . . D QUE^TIUPXAP1
 . . . . I $$READ^TIUU("EA","Press RETURN to continue...") ; pause
 . . . ;W !!
 . . . ;need workload? if yes enter
 . . . I $$CHKWKL^TIUPXAP2(+TIUDA,.TIUDPRM) D CREDIT^TIUVSIT(TIUDA)
 . . E  D
 . . . ;need workload? if yes enter
 . . . I $$CHKWKL^TIUPXAP2(+TIUDA,.TIUDPRM) D EDTENC^TIUPXAP2(TIUDA)
 . S TIUCHNG=1 S:+$G(TIUODA) TIUCHNG=TIUCHNG_U_TIUDA
 . W ! I $$READ^TIUU("EA","Press RETURN to continue...") ; pause
 Q
 ;
WKLD(TIUD0,TIUD12) ; Allow user to clean up workload for visit from which document was removed
 N TIUVSIT,TIUWHAT,TIUERR,TIUDFN,TIUEDT,TIUHL
 I $S($P(TIUD0(0),U,13)="H":1,$P(TIUD0(0),U,13)="E":1,1:0) Q
 S TIUHL=$P(TIUD12(0),U,11)
 I $P($G(^SC(+TIUHL,0)),U,3)'="C" Q
 S TIUDFN=$P(TIUD0(0),U,2),TIUEDT=$P(TIUD0(0),U,7),TIUVSIT=$P(TIUD0(0),U,3)
 W !,"You may now clean up the encounter data for the ORIGINAL Visit...",!
 W !,"Patient: ",$$PTNAME^TIULC1(TIUDFN),!,"  Visit: ",$$DATE^TIULS(TIUEDT,"AMTH DD, CCYY@HR:MIN")," to ",$$VLOC^TIURD2(TIUHL)
 W ! I '+$$READ^TIUU("Y","Do you wish to do this now","NO") Q
 I $G(VALMAR)'="^TMP(""TIUR"",$J)" W !!,"Editing Encounter Data...",!
 S TIUWHAT=$S($$CHKAPPT^TIUPXAP2(TIUVSIT,TIUDFN,TIUEDT,TIUHL):"INTV",1:"ADDEDIT")
 S TIUERR=$$INTV^PXAPI(TIUWHAT,"TIU","TEXT INTEGRATION UTILITIES",.TIUVSIT,$S(+$G(TIUVSIT):"",1:TIUHL),TIUDFN,$S(+$G(TIUVSIT):"",1:TIUEDT))
 ;
 ;If an error is returned prompt to continue otherwise if a Visit
 ;IEN is returned and one is not already defined update the document
 ;I +TIUERR<0 D  I 1
 ;. W ! I $$READ^TIUU("EA","Press RETURN to continue...") ; pause
 ;E  I +$G(TIUVSIT),(+$G(TIUVSIT)'=$P($G(^TIU(8925,+TIUDA,0)),U,3)) D
 ;.  
 Q
PKGACT(TIUDA,TIUD0,TIUD12,TIUD13,TIUD14,TIUOUT) ; Get/Execute Package Reassign Action
 N TIUREASX,TIUPOP
 S TIUREASX=$$REASSIGN^TIULC1(+$G(^TIU(8925,+TIUDA,0)))
 I TIUREASX]"" D  Q:+$G(TIUPOP)
 . X TIUREASX
 . I +$G(TIUPOP) D  Q
 . . S TIUOUT=1
 . . D WHOABACK(TIUDA,TIUD0(0),TIUD12(0),TIUD13(0),TIUD14(0))
 . . W !!,$C(7),"Can't Reassign this document...",!
 . . I $$READ^TIUU("EA","Press RETURN to continue...") ; pause
 . ; --- If original was retracted, call package Delete Action to roll-back ---
 . I +$G(TIUODA) D
 . . N TIUDA,TIUDELX
 . . S TIUDA=TIUODA
 . . S TIUDELX=$$DELETE^TIULC1(+$G(^TIU(8925,+TIUDA,0)))
 . . I TIUDELX]"" X TIUDELX
 Q
 ;
WHOABACK(DA,TIUD0,TIUD12,TIUD13,TIUD14) ; Undo Reassign when fails
 N DIE,DR S DIE=8925
 S DR=".02////"_$P(TIUD0,U,2)_";.03////"_$P(TIUD0,U,3)_";.07////"_$P(TIUD0,U,7)_";.08////"_$P(TIUD0,U,8)_";.13////"_$P(TIUD0,U,13)
 S DR=DR_";1205////"_$P(TIUD12,U,5)_";1401////"_$P(TIUD14,U)_";1402////"_$P(TIUD14,U,2)_";1211////"_$P(TIUD12,U,11)_";1212////"_$P(TIUD12,U,12)
 D ^DIE
 I +$P($G(^TIU(8925,+DA,0)),U,5)'>5 D
 . S DR="1202////"_$P(TIUD12,U,2)_";1305////"_$P(TIUD13,U,5)_";1306////"_$P(TIUD13,U,6)_";1208////"_$P(TIUD12,U,8)_";1209////"_$P(TIUD12,U,9)
 . S DIE=8925 D ^DIE
 Q
