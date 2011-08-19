RAMAIN2 ;HISC/GJC-Radiology Utility File Maintenance (Part Two) ;8/15/05 10:07am
 ;;5.0;Radiology/Nuclear Medicine;**45,62,71,65**;Mar 16, 1998;Build 8
 ; 08/12/2005 bay/kam Remedy Call 104630 Patch 62
 ; 03/02/2006 BAY/KAM Remedy Call 131482 Patch RA*5*71
 ; 
 ;Supported IA #10141 reference to MES^XPDUTL
 ;Supported IA #10142 reference to EN^DDIOL
 ;Supported IA #10103 reference to DT^XLFDT
 ; 
2 ;;Procedure Enter/Edit
 ; *** This subroutine once resided in RAMAIN i.e, '2^RAMAIN'. ***
 ; RA PROCEDURE option
 N RACTIVE,RAENALL,RAY,RAFILE,RASTAT,RAXIT
 S (RAENALL,RANEW71,RAXIT)=0
 N RADIO,RAPTY,RAASK,RAROUTE ;used by the edit template
 F  D  Q:$G(RAXIT)
 . K DA,DD,DIC,DINUM,DLAYGO,DO,RACMDIFF,RATRKCMA,RATRKCMB
 . S DIC="^RAMIS(71,",DIC(0)="QEAMLZ",DLAYGO=71,DIC("DR")=6
 . W ! D ^DIC K D,DD,DIC,DINUM,DLAYGO,DO
 . S:+Y<0 RAXIT=1 I $G(RAXIT) K D,X,Y Q
 . S (DA,RADA)=+Y,RAY=Y,RAFILE=71
 . ;RA*5*71 changed next line for Remedy Call 131482
 . S RANEW71=$S($P(Y,U,3)=1:1,1:0) ;used in template, edit CPT Code if new rec.
 . L +^RAMIS(RAFILE,RADA):5
 . I '$T D  Q
 .. W !?5,"This record is currently being edited by another user."
 .. W !?5,"Try again later!",$C(7) S RAXIT=1
 .. Q
 . S RAPNM=$P($G(Y(0)),U) ;proc. name for display purposes in template
 . S RACTIVE=$P($G(^RAMIS(71,RADA,"I")),"^")
 . S RASTAT=$S(RACTIVE="":1,RACTIVE>DT:1,1:0)
 . D TRKCMB^RAMAINU(DA,.RATRKCMB) ;tracks existing
 . ; CM definition before editing. RATRKCMB ids the before CM values
 . S DIE="^RAMIS(71,",DR="[RA PROCEDURE EDIT]" D ^DIE
 . K RAPNM S RAPROC(0)=$G(^RAMIS(71,RADA,0))
 . ;
 . ;check for data consistency between the 'CONTRAST MEDIA USED' &
 . ;'CONTRAST MEDIA' fields.
 . D CMINTEG^RAMAINU1(RADA,RAPROC(0))
 . ;
 . D TRKCMA^RAMAINU(RADA,RATRKCMB,.RATRKCMA,.RACMDIFF)
 . I $O(^RAMIS(71,RADA,"NUC",0)),($P(RAPROC(0),"^",2)=1) D DELRADE(RADA)
 . S RACTIVE=$P($G(^RAMIS(71,RADA,"I")),"^")
 . S RASTAT=RASTAT_"^"_$S(RACTIVE="":1,RACTIVE>DT:1,1:0)
 . ; 08/12/2005 104630 KAM - added '$G(RANEW71) to next line
 . I RAPROC(0)]"",("^B^P^"'[(U_$P(RAPROC(0),"^",6)_U)),('+$P(RAPROC(0),"^",9)),'+$G(RANEW71) D
 .. K %,C,D0,DE,DI,DIE,DQ,DR
 .. W !?5,$C(7),"...no CPT code entered..."
 .. W !?5,"...will change type to a 'broad' procedure.",!
 .. S DA=RADA,DIE="^RAMIS(71,",DR="6///B" D ^DIE
 .. Q
 . ;08/12/2005 104630 - KAM added next 5 lines
 . I RAPROC(0)]"",("^B^P^"'[(U_$P(RAPROC(0),"^",6)_U)),('+$P(RAPROC(0),"^",9)),+$G(RANEW71) D
 .. K %,C,D0,DE,DI,DIK,DQ,DR
 .. W !?5,$C(7),"...no CPT code entered..."
 .. W !?5,"...will delete the record at this time.",!
 .. S DIK="^RAMIS(71,",DA=RADA D ^DIK K DIK
 . ;if an active parent w/o descendants, inactivate the parent
 . I $P(RASTAT,U,2),($P(RAPROC(0),U,6)="P"),('$O(^RAMIS(71,RADA,4,0))) D
 .. K D,D0,D1,DA,DI,DIC,DIE,DQ,DR
 .. W !!?5,"Inactivating this parent procedure - no descendents.",!,$C(7)
 .. S DA=RADA,DIE="^RAMIS(71,",DR="100///"_$S($D(DT):DT,1:$$DT^XLFDT())
 .. D ^DIE K D,D0,D1,DA,DI,DIC,DIE,DQ,DR S $P(RASTAT,U,2)=0 ;inactive
 .. Q
 . I $P($G(^RA(79.2,+$P(RAPROC(0),U,12),0)),U,5)="Y",(+$O(^RAMIS(71,RADA,"NUC",0))) D VRDIO(RADA)
 . I "^B^P^"[(U_$P(RAPROC(0),U,6)_U),($P(RAPROC(0),U,9)]"") D
 .. K %,D,D0,DA,DE,DIC,DIE,DQ,DR
 .. S DA=RADA,DIE="^RAMIS(71,",DR="9///@" D ^DIE
 .. W !!?5,"...CPT code deleted because "_$S($P(RAPROC(0),U,6)="B":"Broad",1:"Parent")_" procedures",!?5,"should not have CPT codes.",!,$C(7)
 .. Q
 . K %,%X,%Y,C,D,D0,D1,DA,DE,DI,DIE,DQ,DR,RAIMAG,RAMIS,RAPROC,X,Y
 .;send Orderable Item HL7 msg to CPRS if the ORDER DIALOG (#101.41)
 .;file exists unconditionally
 .D:$$ORQUIK^RAORDU()=1 PROC^RAO7MFN(RAENALL,RAFILE,RASTAT,RAY)
 .;
 . L -^RAMIS(RAFILE,RADA) K RADA
 .;unconditionally update the parent procedure if the descendent
 .I $O(^RAMIS(71,"ADESC",+RAY,0)) D UPDATP^RAO7UTL(RAY)
 .;has been edited
 . Q
 K DIR,RACMDIFF,RATRKCMA,RATRKCMB
 S DIR(0)="YA",DIR("B")="NO"
 S DIR("A")="Want to run a validity check on CPT and stop codes? "
 S DIR("?",1)="Answer 'YES' to print a list of Radiology/Nuclear Medicine Procedures"
 S DIR("?",2)="with missing or invalid CPT's and/or Credit Clinic Stop Code(s)."
 S DIR("?",3)="Broad procedures with invalid codes are included for information"
 S DIR("?",4)="only.  Inactive procedures are not required to have valid codes."
 S DIR("?",5)="To be valid, Stop Codes must be in the Imaging Stop Codes file 71.5;"
 S DIR("?",6)="CPT's must be nationally active."
 S DIR("?")="Please answer 'YES' or 'NO'."
 W ! D ^DIR K DIR G:$D(DIRUT) EXIT
 D:Y ^RAPERR
EXIT K RADA,RANEW71,X,Y
 Q
13 ;;Rad/Nuc Med Common Procedure File Enter/Edit
 ; RA COMMON PROCEDURE option
 N RADA,RAENALL,RAY,RAFILE,RALOW,RAMIS713,RASTAT,RAIMGTYI S RAENALL=0
 W ! D EN1^RAUTL17 G:Y'>0 Q13 S RAIMGTYI=Y
131 S DIC="^RAMIS(71.3,",DIC(0)="AELMQZ",DLAYGO=71.3
 S DIC("S")="N RA S RA=+$P(^(0),U) I RAIMGTYI=$P($G(^RAMIS(71,RA,0)),U,12)"
 S DIC("W")="N RA4 S RA4=$P($G(^(0)),""^"",4) W:RA4]"""" ""   (""_RA4_"")"" W:RA4']"""" ""   (no sequence number)"""
 W ! D ^DIC K DIC,DLAYGO,D,X
 I Y<0 D Q13 G RESEQ
 ; If a sequence # exists, the Common Proc. is active
 S RADA=+Y,RAY=Y,RAFILE=71.3 L +^RAMIS(RAFILE,RADA):5
 I '$T D  G Q13
 . W !?5,"This record is currently being edited by another user."
 . W !?5,"Try again later!",$C(7)
 . Q
 S RASTAT=$S($P(Y(0),"^",4)]"":1,1:0)_"^"
 I '+$P(RASTAT,"^") S RALOW=$$LOW(RAIMGTYI)
 S DA=RADA,DIE="^RAMIS(71.3,",DR="[RA COMMON PROCEDURE EDIT]" D ^DIE
 S RAMIS713(0)=$G(^RAMIS(71.3,RADA,0))
 ; If the procedure is different than the one originally selected and
 ; the CPRS Order Dialog file exists, send the Orderable Item Update
 ; message to CPRS.
 I $P(RAMIS713(0),"^")'=$P(RAY,"^",2),($$ORQUIK^RAORDU()=1) D
 . S RASTAT=RASTAT_0 D PROC^RAO7MFN(RAENALL,RAFILE,RASTAT,RAY)
 . S RAY=RADA_"^"_$P($G(^RAMIS(71.3,RADA,0)),"^")_"^"_1,RASTAT=0_"^"
 . Q
 K %,%X,%Y,C,D,D0,DA,DE,DI,DIE,DQ,DR,X,Y
 S RASTAT=RASTAT_$S($P($G(^RAMIS(71.3,+RAY,0)),"^",4)]"":1,1:0)
 ; If before & after statuses differ, and the CPRS Order Dialog file
 ; exists, send the Orderable Item Update message to CPRS.
 I $$ORQUIK^RAORDU()=1,(($P(RASTAT,"^")+$P(RASTAT,"^",2))=1) D
 . D PROC^RAO7MFN(RAENALL,RAFILE,RASTAT,RAY)
 . Q
 L -^RAMIS(RAFILE,RADA)
 G 131
Q13 K DDC,DDH,DISYS,I,POP,RA713
 Q
RESEQ ;Resequence the common procedure list
 N D,D0,DI,DQ,H,I,J,CNT,DIC,DIE,DR,DA,TXT,X
 I $D(XPDNM) D  ; if called during package install
 . S TXT(1)=" "
 . S TXT(2)="Resequencing the Rad/Nuc Med Common Procedure List."
 . Q
 E  W !!?5,"Resequencing the Rad/Nuc Med Common Procedure List"
 S DIE="^RAMIS(71.3,",(I,CNT)=0
 F  S I=$O(^RAMIS(71.3,"AA",RAIMGTYI,I)) Q:I'>0  D
 . S J=0
 . F  S J=$O(^RAMIS(71.3,"AA",RAIMGTYI,I,J)) Q:J'>0  I $D(^RAMIS(71.3,J,0)) D
 .. S DA=J,CNT=CNT+1 N I,J
 .. S DR="3////^S X=CNT" D ^DIE W:'$D(XPDNM) "."
 .. Q
 . Q
 I $D(XPDNM) D  ; if called during package install
 . S TXT(2)=$G(TXT(2))_"  Done!"
 . D MES^XPDUTL(.TXT)
 . Q
 E  W "  Done!"
 Q
LOW(X) ; Find the lowest available sequence number for a procedure within
 ; a specific Imaging Type.  Seq. #'s range from 1 to 40.  If the
 ; range changes in the DD i.e, ^DD(71.3,3, this code as well as the 
 ; code if EN3^RAUTL18 must also be altered.
 ; If RAHIT is passed back as "", there is no available sequence number.
 N RA,RAHIT S RAHIT=""
 F RA=1:1:40 D  Q:RAHIT
 . Q:$D(^RAMIS(71.3,"AA",X,RA))
 . S:RAHIT="" RAHIT=RA
 . Q
 Q RAHIT
VRDIO(RADA) ; Validate the 'Usual Dose' field within the 'Default Radiopha-
 ; rmaceuticals' multiple.  'Usual Dose' must fall within the 'Low Adult
 ; Dose' & 'High Adult Dose' range.  This subroutine will display the
 ; Radiopharmaceutical in question along with the values in question if
 ; inconsistencies are found.
 ;
 ; Input Variable: 'RADA' the ien of the Procedure
 N RANUC S RADA(1)=RADA,RADA=0 D EN^DDIOL("","","!")
 F  S RADA=$O(^RAMIS(71,RADA(1),"NUC",RADA)) Q:RADA'>0  D
 . S RANUC(0)=$G(^RAMIS(71,RADA(1),"NUC",RADA,0))
 . Q:$P(RANUC(0),"^",2)=""  ; no need to validate, nothing input
 . I '$$USUAL^RADD2(.RADA,$P(RANUC(0),"^",2)) D
 .. N RARRY S RARRY(1)="For Radiopharmaceutical: "
 .. S RARRY(1)=RARRY(1)_$$EN1^RAPSAPI(+$P(RANUC(0),"^"),.01)_$C(7)
 .. S RARRY(2)="" D EN^DDIOL(.RARRY,"")
 .. Q
 . Q
 Q
DELRADE(RADA) ; Delete the Default Radiopharmaceuticals multiple 
 N RADA1 S RADA1=0
 W !!?3,"Deleting default radiopharmaceuticals for this procedure...",!
 F  S RADA1=$O(^RAMIS(71,RADA,"NUC",RADA1)) Q:RADA1'>0  D
 . K %,%X,%Y,D,D0,DA,DI,DIC,DIE,DQ,DR,X,Y
 . S DA(1)=RADA,DA=RADA1,DIE="^RAMIS(71,"_RADA_",""NUC"","
 . S DR=".01///@" D ^DIE
 . Q
 K %,%X,%Y,D,D0,DA,DI,DIC,DIE,DQ,DR,X,Y
 Q
 ;
