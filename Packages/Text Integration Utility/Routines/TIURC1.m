TIURC1 ; SLC/JER - Additional Review screen actions ;4/13/05
 ;;1.0;TEXT INTEGRATION UTILITIES;**100,113,184**;Jun 20, 1997
COPY ; Copy
 N DA,DIE,DR,TIU,TIUCHNG,TIUDATA,TIUI,TIUY,Y,DIROUT
 N TIUVIEW,TIULST,TIUNREC,TIUDAARY,OLDNREC
 I '$D(VALMY) D EN^VALM2(XQORNOD(0))
 S TIUI=0
 F  S TIUI=$O(VALMY(TIUI)) Q:+TIUI'>0  D  Q:$D(DIROUT)
 . N TIU,RSTRCTD
 . S TIUDATA=$G(^TMP("TIURIDX",$J,TIUI))
 . S TIUDA=+$P(TIUDATA,U,2) S RSTRCTD=$$DOCRES^TIULRR(TIUDA)
 . I RSTRCTD D  Q
 . . W !!,$C(7),"Ok, no harm done...",!
 . . I $$READ^TIUU("EA","RETURN to continue...") ; pause
 . S TIUVIEW=$$CANDO^TIULP(TIUDA,"VIEW")
 . I +TIUVIEW'>0 D  Q
 . . W !!,$C(7),$P(TIUVIEW,U,2),!
 . . I $$READ^TIUU("EA","RETURN to continue...") ; pause
 . S OLDNREC=$G(TIUNREC)
 . ; -- Single docmt copy.  Does COPY1.
 . ;    Generates list TIUNREC of new recs for feedback
 . D EN^VALM("TIU COPY DOCUMENT")
 . K ^TMP("TIUVIEW",$J)
 . I $G(TIUNREC)'=OLDNREC D
 . . S TIUDAARY(TIUI)=TIUDA
 . . S TIULST=$G(TIULST)_$S($G(TIULST)]"":",",1:"")_TIUI
 I +$G(TIUNREC) D
 . N TIUI,TIUNDA,TIUITEM
 . F TIUI=1:1:$L($G(TIUNREC),",") D
 . . S TIUNDA=$P(TIUNREC,",",TIUI),TIUITEM=+$G(^TMP("TIUR",$J,0))
 . . D ADDELMNT^TIUR2(TIUNDA,+TIUITEM,1)
 S TIUCHNG("REFRESH")=1
 D UPRBLD^TIURL(.TIUCHNG,.VALMY) K VALMY
 S VALMBCK="R"
 D VMSG^TIURS1($G(TIULST),.TIUDAARY,"copied")
 Q
COPY1 ; Copy a document
 N TIUOD0,TIUOD12,TIUD13,TIUOD14,TIUOD17,TIUI,TIUPAT,TIUTNM,TIUTYP
 N TIUDPRM,TIUPOP,TIUCOPY,TIUVSUPP,DUOUT,DIROUT,DTOUT,TIUASK
 S TIUPOP=0
 I +$$ISADDNDM^TIULC1(TIUDA) D  Q
 . W !,$C(7),"ADDENDA may not be copied."
 . I $$READ^TIUU("EA","Press RETURN to continue...") W ""
 S TIUCOPY=$$CANDO^TIULP(TIUDA,"COPY RECORD")
 I +TIUCOPY'>0 D  Q
 . W !!,$C(7),$P(TIUCOPY,U,2),!
 . I $$READ^TIUU("EA","RETURN to continue...") ; pause
 S TIUOD0=$G(^TIU(8925,+TIUDA,0)),TIUOD12=$G(^(12)),TIUD13=$G(^(13))
 S TIUOD14=$G(^TIU(8925,+TIUDA,14)),TIUOD17=$G(^TIU(8925,+TIUDA,17))
 S TIUTYP=+TIUOD0
 D FULL^VALM1
 I $$CHKTITLE(+TIUTYP) D  Q:$G(TIUOUT)=1
 . N TIUDOC0,TIUDCLS
 . S TIUDOC0=$G(^TIU(8925.1,TIUTYP,0))
 . W !
 . I $P(TIUDOC0,U,7)=13 D
 . . W !,$C(7),$P(TIUDOC0,U,3)," is an inactive title."
 . W !,"You must now select a new, active title BEFORE the note is copied:",!
 . S TIUDCLS=+$$CLINDOC^TIULC1(+TIUTYP,TIUDA),TIUTYP=0
 . D DOCSPICK^TIULA2(.TIUTYP,TIUDCLS,"1A","","","+$$CANPICK^TIULP(+Y),+$$CANENTR^TIULP(+Y)")
 . I TIUTYP'>0 S TIUOUT=1
 . E  D
 . . S TIUTYP=$P($G(TIUTYP(1)),U,2)
 . . I $$CHKTITLE(+TIUTYP) S TIUOUT=1
 D DOCPRM^TIULC1(TIUTYP,.TIUDPRM,TIUDA)
 S TIUTNM=$$PNAME^TIULC1(+TIUTYP)
 S TIUTYP(1)="1^"_+TIUTYP_U_TIUTNM_U
 W !!,"Please Choose One or More Patients for whom the document should be copied:",!
 F  D  Q:+TIUPOP
 . D PATIENT^ORU1(.TIUPAT,1)
 . I +TIUPAT'>0 D  Q
 . . W !,$C(7),"No patient(s) selected..."
 . . I $$READ^TIUU("EA","Press RETURN to continue...") W !
 . . S TIUCHNG=0,TIUPOP=1
 . S TIUI=0 F  S TIUI=$O(TIUPAT(TIUI)) Q:+TIUI'>0  D
 . . N DA,DR,DFN,TIU,TIULMETH,TIUVMETH,TIUPATNM
 . . S DFN=+TIUPAT(TIUI),TIUPATNM=$P(TIUPAT(TIUI),U,2)
 . . S TIUVSUPP=+$$SUPPVSIT^TIULC1(TIUTYP)
 . . I TIUVSUPP'>0 D  I 1
 . . . S TIULMETH=$$GETLMETH^TIUEDI1(TIUTYP)
 . . . I '$L(TIULMETH) D  S TIUOUT=1 Q
 . . . . W !,$C(7),"No Visit Linkage Method defined for "
 . . . . W $$PNAME^TIULC1(TIUTYP),".",!,"Please contact IRM..."
 . . . . I $$READ^TIUU("EA","Press RETURN to continue...") W ""
 . . . W !!,"For Patient ",TIUPATNM
 . . . X TIULMETH
 . . E  D EVENT^TIUSRVP1(.TIU,DFN)
 . . I '$D(TIU("VSTR")) W !,$C(7),"Patient & Visit required." H 2 Q
 . . S TIUVMETH=$$GETVMETH^TIUEDI1(TIUTYP)
 . . I '$L(TIUVMETH) D  S TIUOUT=1 Q
 . . . W !,$C(7),"No Validation Method defined for "
 . . . W $$PNAME^TIULC1(TIUTYP),".",!,"Please contact IRM..."
 . . X TIUVMETH
 . . I $D(TIU),+$G(TIUASK) D
 . . . N TIUNEW,TIUITEM,DA,DR,DIE
 . . . S DA=$$GETRECNW^TIUEDI3(DFN,.TIU,TIUTYP(1),.TIUNEW,.TIUDPRM) Q:+DA'>0
 . . . I '+$G(TIUNEW) D  Q
 . . . . W !!,$C(7),"A ",$P(TIUTYP(1),U,3)," already exists for this visit."
 . . . . W !,"You may not use the copy function to overwrite an existing ",!,$$UPPER^TIULS($$STATUS^TIULC(DA))," ",$P(TIUTYP(1),U,3),".",!
 . . . . I $$READ^TIUU("EA","Press RETURN to continue...") W ""
 . . . D COPY0(DA,TIUOD0,.TIU),COPY12(DA,TIUOD0,TIUOD12,.TIU),COPY13(DA,TIUD13)
 . . . D COPY14(DA,TIUOD14,.TIU),COPY17(DA,TIUOD17),COPYTEXT(TIUDA,DA)
 . . . I $D(^TIU(8925,DA,"TEMP")) D MERGTEXT^TIUEDI1(DA,.TIU) K ^TIU(8925,+DA,"TEMP")
 . . . S DR=".05///"_$$UPPER^TIULS($$STATUS^TIULC(DA)),DIE=8925 D ^DIE
 . . . I +$D(^TIU(8925,+DA,"TEXT"))>9!(+$O(^TIU(8925,"DAD",+DA,0))>0) D
 . . . . N TIUDA,TIUCPYNG S TIUDA=+DA,TIUCPYNG=1 D EDIT1^TIURA
 . . . I '$G(DA) Q  ;Docmt deleted in TIURA
 . . . S TIUCHNG=1,TIUNREC=$G(TIUNREC)_$S(+$G(TIUNREC):",",1:"")_DA
 . S TIUPOP='+$$AGAIN
 Q
CHKTITLE(TIUTYP) ; Title Status
 N TIUBAD S TIUBAD=0
 I +$$CANPICK^TIULP(+TIUTYP)'>0 S TIUBAD=1 I 1
 E  I +$$CANENTR^TIULP(+TIUTYP)'>0 S TIUBAD=1
 Q TIUBAD
AGAIN() ; Ask again?
 N TIUY W !
 S TIUY=$$READ^TIUU("Y","Copy this note again","No")
 Q TIUY
COPY0(DA,TIUD0,TIU) ; Copy 0-node
 N DR,DIE S DIE=8925
 S DR=".02////"_DFN_";.03////"_$P($G(TIU("VISIT")),U)_";.04////"_$P(TIUD0,U,4)_";.07////"_$P($G(TIU("EDT")),U)_";.08////"_$P($G(TIU("LDT")),U)_";.09////"_$P(TIUD0,U,9)
 I $P($G(TIUDPRM(0)),U,16),'$P($G(^TIU(8925,+DA,0)),U,11),$$WORKOK^TIUPXAP1(+DA) S DR=DR_";.11////1" ;set flag to collect workload
 D ^DIE
 Q
COPY12(DA,TIUD0,TIUD12,TIU) ; Copy 12-node
 N DR,DIE S DIE=8925
 S DR="1201////"_$$NOW^TIULC_";1202////"_+$G(DUZ)_";1203////"_$P(TIUD12,U,3)_";1204////"_$G(DUZ)_";1205////"_$P($G(TIU("LOC")),U)
 S DR=DR_";1206////"_$P(TIUD12,U,6)_";1207////"_$P(TIUD12,U,7)_";1209////"_$P(TIUD12,U,9)
 I +$$REQCOSIG^TIULP(+TIUD0,DA,+$G(DUZ)) S DR=DR_";1208////"_$P(TIUD12,U,8)
 S DR=DR_";1210////"_$P(TIUD12,U,10)_";1211////"_+$G(TIU("VLOC"))_";1212////"_$P($G(TIU("INST")),U)
 D ^DIE
 Q
COPY13(DA,TIUD13,TIU) ; Copy 13-node
 N DR,DIE S DIE=8925
 S DR="1301////"_$$NOW^TIULC_";1302////"_$G(DUZ)_";1303////O;1307////"_$P(TIUD13,U,7)
 D ^DIE
 Q
COPY14(DA,TIUD14,TIU) ; Copy 14-node
 N DR,DIE S DIE=8925
 S DR="1401////"_$P($G(TIU("AD#")),U)_";1402////"_$P($G(TIU("TS")),U)_";1403////"_$P(TIUD14,U,3)_";1404////"_$P(TIUD14,U,4)
 D ^DIE
 Q
COPY17(DA,TIUD17) ; Copy Subject
 N DR,DIE S DIE=8925
 I $G(TIUD17)']"" Q
 S DR="1701////^S X=$G(TIUD17)" D ^DIE
 Q
COPYTEXT(TIUDA,DA) ; Copy text
 N TIUC,TIUI,TIUJ,TIULINE
 I +$O(^TIU(8925,+TIUDA,"TEXT",0)) M ^TIU(8925,+DA,"TEMP")=^TIU(8925,+TIUDA,"TEXT")
 S (TIUC,TIULINE)=0,TIUJ=+$P($G(^TIU(8925,+DA,"TEMP",0)),U,3)
 F  S TIUC=$O(^TIU(8925,"DAD",TIUDA,TIUC)) Q:+TIUC'>0  D
 . I +$$ISADDNDM^TIULC1(TIUC) Q
 . S TIUI=0 F  S TIUI=$O(^TIU(8925,+TIUC,"TEXT",TIUI)) Q:+TIUI'>0  D
 . . S TIUJ=+$G(TIUJ)+1
 . . S ^TIU(8925,+DA,"TEMP",TIUJ,0)=$G(^TIU(8925,+TIUC,"TEXT",TIUI,0))
 . . S ^TIU(8925,+DA,"TEMP",0)="^^"_TIUJ_"^"_TIUJ_"^"_DT_"^^"
 Q
