ICD142PT ;;ALB/EG/ABR - ADD NEW ICD DX/OPS/UPDATES ;DEC 15, 1993
 ;;14.0;DRG Grouper;**2**;Apr 03, 1997
 ;
 ;
EN N ACTION,DIC,I,ICDTEST,ICDDEBUG,REF
 S ICDDEBUG=1,ICDTEST=0
 D KILL
 ;D MDC ; add new MDC (FY1996 only)
 D ADDDRG ; add new DRG's
INACT D ACT^ICD142A1 ; inactivate dx and op codes
 D EN^ICD142A2 ; for revised descriptions only - ensures KWIK x-ref's updated
ADOPS D ADDP^ICD142P1 ; add new op codes
 D RIDXP ; reindex new op codes
 ;
 ; add new dx codes
 ;
 D BMES^XPDUTL("Adding or Revising the following Diagnostic codes")
 F ICDI=1:1:2 S ICDX="D ADDP^ICD1420"_ICDI X ICDX
 ; F ICDI=10:1:29 S ICDX="D ADDP^ICDYQ"_ICDI X ICDX ; (used if more than 9 routines)
 ;
 D RIDXD ;reindex new dx codes
 ;
 ; Set new Zero nodes
 ;
DXHDR S $P(^ICD9(0),"^",3)=13380,$P(^(0),"^",4)=13373
OPSHDR S $P(^ICD0(0),"^",3)=4140,$P(^(0),"^",4)=4140
 K ^ICD9("B"),^ICD0("B")
 D BMES^XPDUTL("ICD Codes Updating Done!")
 Q
RIDXP ;reindex procedure entries
 Q:ICDTEST
 D BMES^XPDUTL("Re-indexing the updated procedure codes")
 F ICDI=1:1 S DIK="^ICD0(",ICDX=$P($T(REIDXP+ICDI),";;",2) Q:ICDX=""  F ICDJ=1:1 S DA=$P(ICDX,"^",ICDJ) Q:'DA  D IX^DIK
 K DA,DIK,ICDI,ICDJ,ICDX
 Q
REIDXP ;new and revised procedure entries
 ;;4138^4139^4140
 ;;
RIDXD ;new dx entries
 N DA,DIK
 Q:ICDTEST
 D BMES^XPDUTL("Re-indexing the updated diagnostic codes")
 S DIK="^ICD9("
 ;F DA=0:0 S DA=$O(^TMP("ICDUPD",$J,DA)) Q:'DA  D RIDXD1,IX^DIK
 F DA=0:0 S DA=$O(^TMP("ICDUPD",$J,DA)) Q:'DA  D IX^DIK
 Q
RIDXD1 ;cc exclusion x-ref
 Q:ICDTEST
 Q:'$D(^ICD9(DA,2,0))
 S ICDX=0 F ICDI=1:1 S ICDX=$O(^ICD9(DA,2,ICDX)) Q:ICDX=""  I ICDX>0 S ICDY=$G(^ICD9(DA,2,ICDX,0)) S:ICDY'="" ^ICD9("ACC",DA,ICDY)=""
 K ICDI,ICDX,ICDY
 Q
ADDDRG  ;-- Add any new DRGs, update DRG information
 N DRGX,DRGY
 D BMES^XPDUTL(">>> Adding New DRGs")
 F I=1:1 S X=$T(ADD+I) S ICDDRG=$P(X,";;",2) Q:ICDDRG="EXIT"  X ICDDRG I $P(ICDDRG,",",3) D
 . ; when description set up, displays listing
 . S DRGX=+$P(ICDDRG,"(",2),DRGY=$P(ICDDRG,$C(34),2)
 . D MES^XPDUTL("  DRG"_DRGX_"     "_DRGY_" added.")
 . Q
 D BMES^XPDUTL(">>> Re-indexing DRG file ")
 S DIK="^ICD(" F DA=496:1:503 D IX^DIK
 S ^ICD(0)="DRG^80.2^503^508"
 K DA,DIK,I,ICDDRG,X
 Q
 ;
ADD ;New DRGs
 ;;S ^ICD(496,0)="DRG496^^^^8^1"
 ;;S ^ICD(496,1,0)="^80.21A^1^1"
 ;;S ^ICD(496,1,1,0)="COMBINED ANTERIOR/POSTERIOR SPINAL FUSION"
 ;;S ^ICD(496,1,"B","COMBINED ANTERIOR/POSTERIOR SP",1)=""
 ;;S ^ICD(497,0)="DRG497^^^^8^1"
 ;;S ^ICD(497,1,0)="^80.21A^1^1"
 ;;S ^ICD(497,1,1,0)="SPINAL FUSION W CC"
 ;;S ^ICD(497,1,"B","SPINAL FUSION W CC",1)=""
 ;;S ^ICD(498,0)="DRG498^^^^8^1"
 ;;S ^ICD(498,1,0)="^80.21A^1^1"
 ;;S ^ICD(498,1,1,0)="SPINAL FUSION W/O CC"
 ;;S ^ICD(498,1,"B","SPINAL FUSION W/O CC",1)=""
 ;;S ^ICD(499,0)="DRG499^^^^8^1"
 ;;S ^ICD(499,1,0)="^80.21A^1^1"
 ;;S ^ICD(499,1,1,0)="BACK & NECK PROCS EXCEPT SPINAL FUSION W CC"
 ;;S ^ICD(499,1,"B","BACK & NECK PROCS EXCEPT SPINA",1)=""
 ;;S ^ICD(500,0)="DRG500^^^^8^1"
 ;;S ^ICD(500,1,0)="^80.21A^1^1"
 ;;S ^ICD(500,1,1,0)="BACK & NECK PROCS EXCEPT SPINAL FUSION W/O CC"
 ;;S ^ICD(500,1,"B","BACK & NECK PROCS EXCEPT SPINA",1)=""
 ;;S ^ICD(501,0)="DRG501^^^^8^1"
 ;;S ^ICD(501,1,0)="^80.21A^1^1"
 ;;S ^ICD(501,1,1,0)="KNEE PROC W PDX OF INFECTION W CC"
 ;;S ^ICD(501,1,"B","KNEE PROC W PDX OF INFECTION W",1)=""
 ;;S ^ICD(502,0)="DRG502^^^^8^1"
 ;;S ^ICD(502,1,0)="^80.21A^1^1"
 ;;S ^ICD(502,1,1,0)="KNEE PROC W PDX OF INFECTION W/O CC"
 ;;S ^ICD(502,1,"B","KNEE PROC W PDX OF INFECTION W",1)=""
 ;;S ^ICD(503,0)="DRG503^^^^8^1"
 ;;S ^ICD(503,1,0)="^80.21A^1^1"
 ;;S ^ICD(503,1,1,0)="KNEE PROCEDURES W/O PDX OF INFECTION"
 ;;S ^ICD(503,1,"B","KNEE PROCEDURES W/O PDX OF INF",1)=""
 ;;EXIT
MDC ;add PRE Major Diagnostic Category for lung transplants (fy96)
 Q
KILL K ^TMP("ICDUPD",$J)
