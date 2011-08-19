RADD3 ;HISC/SWM-Radiology Data Dictionary Utility Routine ;9/11/97  16:23
 ;;5.0;Radiology/Nuclear Medicine;**18,65**;Mar 16, 1998;Build 8
 ;
 ;Supported IA #2056 reference to GET1^DIQ
 ;Supported IA #10142 reference to EN^DDIOL
 ;Supported IA #2053 reference to UPDATE^DIE, FILE^DIE
 ;Supported IA #10103 reference to NOW^XLFDT
 ;
PAIR ;
 ; called from file 71.9's field SOURCE
 ; SOURCE may be added normally via the "RA NM EDIT LOT" option,
 ; or it may be added via one of the 3 exam edits when the LOT
 ; prompt appears for the case's Radiopharm.  This LOT prompt
 ; allows adding new LOT on-the-fly, which causes the LOT's
 ; associated SOURCE, EXPIRATION DATE, KIT # to be prompted
 ; and the current case's Radiopharm to be stuffed into the new LOT's
 ; Radiopharm field.  The SOURCE field invokes this subroutine to:
 ;   re-set DR string to stuff matching radiopharm
 ;   not allow spacebar return for radioph
 ; RA*5*65 removed the Fileman Identifier for file 79.1's RADIOPHARM
 ; so by default, the DR will just be "2;3;4;" without the "5;".
 ;
 N RA1,RA2,RA3
 I $D(RAOPT("EDITPT"))!($D(RAOPT("EDITCN")))!($D(RAOPT("STATRACK"))) D
 . S RA1=$$EN1^RAPSAPI(RAPSDRUG,.01)
 . I $G(DR)'[";5",$G(DIE)="^RAMIS(71.9,",+$G(RAPSDRUG),RA1]"" S DR=DR_"5///"_RA1 K ^DISV(DUZ,"^RAMIS(71.9,")
 . Q
 ; check pairing of number/id with source
 ; called by input transform of file 71.9'S field 2 (source)
 S (RA1,RA2,RA3)=""
 Q:$G(DA)=""  Q:$G(D)=""
 F  S RA1=$O(^RAMIS(71.9,"B",$P(D,U),RA1)) Q:'RA1  I DA'=RA1 S:$P(^RAMIS(71.9,RA1,0),U,2)=+Y RA2=1 ;found a match so set ra2=1
 W:RA2 !!,"** There's already a NUMBER/ID=",$P(D,U),"  and SOURCE=",$P(Y,U,2)," **",!
 K:RA2 X
 Q
SCRLOT() ;screen lot # from file 70.2
 ;lot's exp. dt must be within d/t dose admin, if no admin, use exam dt
 ;  if lot's exp. dt is null, allow as choice (don't check)
 ;lot's radiopharm must match exam's radiopharm
 ;  if lot's radiopharm is null, don't allow as choice
 ;Y            pointer to lot file
 ;RA0A         date/time dose administered
 ;RA0E         date/time exam
 ;RALOTEXP     lot's expiration date
 ;RA0RAD       exam's radiopharmaceutical
 ;RALOTRAD     lot's radiopharmaceutical
 ;RARETUR      return value of screen, 0=failed, 1=passed
 I '$D(Y)#2!('$D(DA))!('$D(DA(1))) Q 0
 N RA0A,RA0E,RALOTEXP,RA0RAD,RALOTRAD,RARETURN
 S RARETURN=0
 S RA0E=$P(^RADPTN(DA(1),0),U,2),RA0A=$P(^("NUC",DA,0),U,8),RA0RAD=$P(^(0),U),RALOTEXP=$P(^RAMIS(71.9,+Y,0),U,3),RALOTRAD=$P(^(0),U,5)
 I $S(RALOTEXP="":1,RA0A:RALOTEXP>RA0A,1:RALOTEXP>RA0E),(RA0RAD=RALOTRAD) S RARETURN=1
 Q RARETURN
 ;
GETID(Y) ; Pass back a string of data which will be used as an
 ; identifier when lookups are done on the Imaging Locations (79.1) file
 ; Input : Y -> ien of entry in 79.1
 ; Output: string of data relevent to the entry in file 79.1
 ;         Location I-type_"-"_Station # of Rad/Nuc Med Division 
 N RA791 S RA791(0)=$G(^RA(79.1,Y,0))
 S RA791("DIV")=$G(^RA(79.1,Y,"DIV"))
 Q "("_$$GET1^DIQ(79.2,+$P(RA791(0),"^",6),.01)_"-"_$$GET1^DIQ(4,+$P(RA791("DIV"),"^"),99)_")"
 ;
DELDESC(RAIEN) ; This sub-routine will determine if descendents can be
 ; deleted from parent procedures.  If only one descendent exists, and
 ; the parent is on the common procedure list do not allow the deletion
 ; of the descendent.
 ; Input : RAIEN (the DA array for the Rad/Nuc Med Procedure file.)
 ; Output: 0 if ok to delete, 1 if not ok to delete
 ; Called from: ^DD(71.05,.01,"DEL",1,0) node
 N I,RA713,RATTL S (I,RA713,RATTL)=0
 S:$D(^RAMIS(71.3,"B",RAIEN(1))) RA713=+$O(^RAMIS(71.3,"B",RAIEN(1),0))
 S:RA713>0 RA713(0)=$G(^RAMIS(71.3,RA713,0))
 F  S I=$O(^RAMIS(71,RAIEN(1),4,I)) Q:I'>0  S RATTL=RATTL+1
 I RA713,($P(RA713(0),"^",5)=""),(RATTL=1) D  Q 1
 . ; don't allow deletion of the last descendent on procedures that are
 . ; currently active in the common procedure file.
 . N RATXT S RATXT(1)=" "
 . S RATXT(2)="You cannot delete the last or only descendent from a"
 . S RATXT(3)="parent procedure when the parent procedure is an active"
 . S RATXT(4)="common procedure.",RATXT(5)=$C(7) D EN^DDIOL(.RATXT)
 . Q
 Q 0 ; common procedure with more than one descendent, ok to delete
 ;
REACMMN(RADA) ; Check to see if a commom procedure can be re-activated.
 ; This sub-routine checks if this common is a parent w/o descendents.
 ; If true, this common procedure cannot be re-activated.
 ; Input : RADA - ien of the entry in 71.3
 ; Output: 0 if ok to delete, 1 if not ok to delete
 ; Called from ^DD(71.3,4,"DEL",1,0)
 N RA713 S RA713=$G(^RAMIS(71.3,RADA,0))
 I $P($G(^RAMIS(71,+RA713,0)),"^",6)="P",('$O(^RAMIS(71,+RA713,4,0))) D  Q 1
 . N RATXT S RATXT(1)=" "
 . S RATXT(2)="You cannot re-activate a common parent procedure without descendents."
 . S RATXT(3)=$C(7) D EN^DDIOL(.RATXT)
 . Q
 Q 0 ; ok to delete
 ;
X7005(RADFN,RADTI,RACNI,RAMDV,RAQED,RASTI,RAWHO) ;update the EXAM
 ; STATUS TIMES (70.05) multiple.  Called from RASTED (will be
 ; called from RAUTL1 in the future)
 ;
 ; input variables:
 ; ----------------
 ; RADFN=patient dfn, RADTI=exam date/time (inverse)
 ; RACNI=exam record ien (70.03), RAMDV=division parameters
 ; RAQED=task queued(1=yes;0=no), RASTI=exam status
 ; RAWHO=editing person
 ;
 N %,D,D0,DA,DIC,DIE,DQ,DR,RAFDA,RAIEN,RAIENS,X,Y
 S RAQED=+$G(RAQED) ; if tasked 1, else 0
 S RAIENS="+1,"_RACNI_","_RADTI_","_RADFN_","
 S RAFDA(70.05,RAIENS,.01)=$$MIDNGHT^RAUTL5($$NOW^XLFDT())
 D UPDATE^DIE(,"RAFDA","RAIEN") ; RAIEN(1)=ien of new record
 K RAFDA,RAIENS Q:'$D(RAIEN(1))  ; record not added
 I $P(RAMDV,"^",11),('RAQED) D
 .S DIE="^RADPT("_RADFN_",""DT"","_RADTI_",""P"","_RACNI_",""T"","
 .S DA=RAIEN(1),DR=".01" D ^DIE
 S RAIENS=RAIEN(1)_","_RACNI_","_RADTI_","_RADFN_","
 S RAFDA(70.05,RAIENS,2)=RASTI
 S RAFDA(70.05,RAIENS,3)=$G(RAWHO)
 D FILE^DIE(,"RAFDA")
 Q
A7007(RADFN,RADTI,RACNI,RAWHO,RATC) ; update the ACTIVITY LOG (70.07)
 ; multiple.  Called from RASTED (will be called from RAUTL1 in the
 ; future)
 ;
 ; input variables:
 ; ----------------
 ; RADFN=patient dfn, RADTI=exam date/time (inverse)
 ; RACNI=exam record ien (70.03), RAWHO=editing person
 ; RATC=technologist comments (optional)
 ;
 N %,D,D0,DA,DIC,DIE,DQ,DR,RAFDA,RAIEN,RAIENS,X,Y
 S RAIENS="+1,"_RACNI_","_RADTI_","_RADFN_","
 S RAFDA(70.07,RAIENS,.01)="NOW"
 D UPDATE^DIE("E","RAFDA","RAIEN") ;RAIEN(1)=ien of new record
 K RAFDA,RAIENS  Q:'$D(RAIEN(1))  ; record not added
 S RAIENS=RAIEN(1)_","_RACNI_","_RADTI_","_RADFN_","
 S RAFDA(70.07,RAIENS,2)="U"
 S RAFDA(70.07,RAIENS,3)=$G(RAWHO)
 S:$G(RATC)]"" RAFDA(70.07,RAIENS,4)=RATC
 D FILE^DIE(,"RAFDA")
 Q
 ;
 ;updates EXAM STATUS
U70033(RA18DFN,RA18DTI,RA18CNI,RA18ST) ;
 N %,D,D0,DA,DIC,DIE,DQ,DR,RA18FDA,RA18IENS,X,Y
 S RA18IENS=RA18CNI_","_RA18DTI_","_RA18DFN_","
 S RA18FDA(70.03,RA18IENS,3)=RA18ST
 D FILE^DIE(,"RA18FDA")
 Q
 ;
