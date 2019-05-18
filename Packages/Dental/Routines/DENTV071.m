DENTV071 ;DSS/AJ - Post init DENTAL Patch 71;9/14/2017 10:17
 ;;1.2;DENTAL;**71**;Aug 10, 2001;Build 3
 ;Copyright 1995-2016, Document Storage Systems, Inc., All Rights Reserved
 ;   ICR#  SUPPORTED
 ;  -----  ---------  --------------------------------------
 ;                    ^XTMP - SACC allowed
 ;   2053      x      FILE^DIE
 ;   2055      x      $$EXTERNAL^DILFD
 ;   2172      x      UPDATE^XPDID
 ;   2263      x      XPAR:  CHG, DEL, GETLIST
 ;  10005      x      DT^DICRW
 ;  10009      x      FILE^DICN
 ;  10013      x      IX1^DIK
 ;  10063      X      %ZTLOAD
 ;  10070      x      ^XMD
 ;  10086      x      HOME^%ZIS
 ;  10103      x      XLFDT:  $$FMADD, $$NOW
 ;
 Q
PRE ;  pre-install
 D SAVE ;save off 228 data so that we can restore their ICDs and $Values
 Q
POST ;queue off the restore of file 228 data
 D INACTIVE,TASK
 Q
MSG(DENTVX) ;
 S DENTVX="   >>>>> "_DENTVX_" <<<<<"
 ; D MES^DSICXPDU(DENTVX,1)
 Q
 ;
TASK ;task off the code to set VISIT DATE in 228.2
 N DENTVX,DENTVY,DENTVZ,ZTSK,ZTIO,ZTRTN,ZTDTH,ZTSAVE,ZTDESC
 ; NOTE: XPDNM is DENTVA variable which exists during the KID installation
 ;        process.  It is not controlled via Dental routines, rather
 ;        its existence is simply checked.
 I '$D(XPDNM) D  Q:'DENTVX
 .I $G(DUZ)<.5 W !!,"Please sign on properly through the Kernel" S DENTVX=0
 .E  D HOME^%ZIS,DT^DICRW S DENTVX=1
 .Q
 S ZTIO="",ZTDTH=$H,ZTRTN="PS^DENTV071",ZTDESC="DENTV PATCH 71 POST-INSTALL"
 D ^%ZTLOAD S DENTVX="Patch 71 post-install successfully queued, task# "_$G(ZTSK)
 I $G(ZTSK) D MSG(DENTVX)
 I '$G(ZTSK) D MSG("Could not queue the Post-Install!"),MSG("Enter DENTVA Dental Remedy ticket.")
 Q
 ;
PS ;post-install
 D RESTORE ;restore the ICDs and $Values saved in the pre-install
 D MM
 Q
MM ;send message
 Q:'DUZ  N DENTVCNT,DENTVTXT,XMDUZ,XMSUB,XMTEXT,XMY,IEN,DENTVX,DENTVY,DENTVJ,ICD,DATA,DIFROM
 S XMDUZ=DUZ,XMSUB="New ADA Codes for Dental"
 S (DENTVCNT,IEN)=0,XMY(XMDUZ)="",XMY("G.DENTV ADA CODE MAPPING")=""
 S DENTVCNT=DENTVCNT+1,DENTVTXT(DENTVCNT,0)="The following CPT Codes were added:"
 S DENTVCNT=DENTVCNT+1,DENTVTXT(DENTVCNT,0)="69714"
 S DENTVCNT=DENTVCNT+1,DENTVTXT(DENTVCNT,0)=""
 S DENTVCNT=DENTVCNT+1,DENTVTXT(DENTVCNT,0)="The following NEW ADA Codes were added:"
 S DENTVCNT=DENTVCNT+1,DENTVTXT(DENTVCNT,0)="D0411, D5511, D5512, D5611, D5612, D5621, D5622, D6096,"
 S DENTVCNT=DENTVCNT+1,DENTVTXT(DENTVCNT,0)="D6118, D6119, D7296, D7297, D7979, D8695, D9222, D9239,"
 S DENTVCNT=DENTVCNT+1,DENTVTXT(DENTVCNT,0)="D9995, D9996"
 S DENTVCNT=DENTVCNT+1,DENTVTXT(DENTVCNT,0)=""
 S DENTVCNT=DENTVCNT+1,DENTVTXT(DENTVCNT,0)="The following ADA Codes were inactivated:"
 S DENTVCNT=DENTVCNT+1,DENTVTXT(DENTVCNT,0)="D5510, D5610, D5620"
 S DENTVCNT=DENTVCNT+1,DENTVTXT(DENTVCNT,0)=""
 S DENTVCNT=DENTVCNT+1,DENTVTXT(DENTVCNT,0)="The following CPT Codes were edited:"
 S DENTVCNT=DENTVCNT+1,DENTVTXT(DENTVCNT,0)="21248, 21249"
 S DENTVCNT=DENTVCNT+1,DENTVTXT(DENTVCNT,0)=""
 S DENTVCNT=DENTVCNT+1,DENTVTXT(DENTVCNT,0)="The following ADA Codes were edited:"
 S DENTVCNT=DENTVCNT+1,DENTVTXT(DENTVCNT,0)="D0171, D0180, D0191, D0330, D1110, D1206, D1330, D3120,"
 S DENTVCNT=DENTVCNT+1,DENTVTXT(DENTVCNT,0)="D4210, D4211, D4212, D4230, D4231, D4240, D4241, D4245,"
 S DENTVCNT=DENTVCNT+1,DENTVTXT(DENTVCNT,0)="D4260, D4261, D4263, D4264, D4265, D4266, D4267, D4268,"
 S DENTVCNT=DENTVCNT+1,DENTVTXT(DENTVCNT,0)="D4270, D4273, D4275, D4276, D4277, D4278, D4283, D4285,"
 S DENTVCNT=DENTVCNT+1,DENTVTXT(DENTVCNT,0)="D4341, D4342, D4346, D4355, D4381, D4910, D4920, D4921,"
 S DENTVCNT=DENTVCNT+1,DENTVTXT(DENTVCNT,0)="D4999, D5982, D6081, D7140, D7210, D7272, D9910, D9911"
 S XMTEXT="DENTVTXT("
 D ^XMD
 Q
 ;-----------------Backup and Restore Functionality-----------------------------
 ;
 ;  Following tags called from either pre or post install subroutines
 ;
 ;  These subroutine should only be invoked when exporting file 228
 ;
 ;  local variables expect to exist
 ;  XPDNM - from KIDS install process
 ;
SAVE ;  save local changes made to national mapping of ICD to cpt
 ;  delete the old ADA mapping table
 ;     NODE = DENT228*<patch number>
 ;  ^xtmp(node,0) = p1^p2^p3^p4^p5^p6^p7  where
 ;     p1 = purge date.time          p5 = 1 if save completed
 ;     p2 = date.time save started   p6 = 1 if restore started
 ;     p3 = duz of installer         p7 = 1 if restore completed
 ;     p4 = 1 if save started        p8 = total count of nodes saved
 ;                          C = VACO   L = local code
 ;  ^xtmp(node,cpt_ien)   = C/L^ICD-1^ICD-2^ICD-3^ICD-4^ICD-5^VA cost^Private cost^RVU^VA-DSS Group
 ;  ^xtmp(node,cpt_ien,3) = ADMIN GUIDELINE
 ;   
 N DENTVI,DENTVX,DENTVY,Y10,DENTVZ,CNT,CPT,NODE,TYPE,DATA,NEWDD,TOTMAP
 D MSG2(1,2,1),NODE
 S DENTVX=$G(^XTMP(NODE,0))
 ;
 ;  check to see if previous aborted install had saved table
 ;  if previous save never completed, then that process failed to
 ;  finish pre-installation process
 ;
 I DENTVX'="",'$P(DENTVX,U,5) K ^XTMP(NODE)
 I $P(DENTVX,U,5)!$P(DENTVX,U,6) Q
 S NEWDD=1
 S DENTVX=$$FMADD^XLFDT(DT,7)_U_$$NOW^XLFDT_U_DUZ_U_1
 S ^XTMP(NODE,0)=DENTVX,DENTVI=0
 F  S DENTVI=$O(^DENT(228,DENTVI)) Q:'DENTVI  S DENTVX=^DENT(228,DENTVI,0),DENTVY=$G(^DENT(228,DENTVI,1)),Y10=$G(^DENT(228,DENTVI,7)) D
 .I DENTVI=81400 D
 ..Q
 .S CPT=$P(DENTVX,U),TYPE=$S($P(DENTVX,U,7)="NATIONAL CODES":"C",1:$P(DENTVX,U,15)) Q:'CPT
 .S DATA=TYPE_U_$P(DENTVY,U,1,5),$P(DATA,U,7)=$P(DENTVY,U,14),$P(DATA,U,8)=$P(DENTVY,U,15)
 .S $P(DATA,U,9)=$P(DENTVX,U,18),$P(DATA,U,10)=$P(DENTVX,U,16),$P(DATA,U,11)=NEWDD
 .S ^XTMP(NODE,CPT)=DATA
 .S ^XTMP(NODE,CPT,3)=$P($G(^DENT(228,DENTVI,3)),U)
 .I TYPE="L",$D(^DENT(228,DENTVI,5)) M ^XTMP(NODE,CPT,5)=^DENT(228,DENTVI,5)
 .I TYPE="L",$D(^DENT(228,DENTVI,6)) M ^XTMP(NODE,CPT,6)=^DENT(228,DENTVI,6)
 .I 'NEWDD Q
 .S TOTMAP=+DENTVY I $D(^DENT(228,DENTVI,5)) F  S TOTMAP=$O(^DENT(228,DENTVI,5,TOTMAP)) Q:'TOTMAP  D
 ..S ^XTMP(NODE,CPT,5,TOTMAP,0)=$G(^DENT(228,DENTVI,5,TOTMAP,0)) ;save site added Dxs
 ..Q
 .S TOTMAP=+Y10 I $D(^DENT(228,DENTVI,6))  F  S TOTMAP=$O(^DENT(228,DENTVI,6,TOTMAP)) Q:'TOTMAP  D
 ..S ^XTMP(NODE,CPT,6,TOTMAP,0)=$G(^DENT(228,DENTVI,6,TOTMAP,0)) ;save site added Dxs
 ..Q 
 .Q
 ;  Mark save completed, kill off the old table
 D SET(5),MES(3)
 Q
 S DENTVX=$P(^DENT(228,0),U,1,2) K ^DENT(228) S ^DENT(228,0)=DENTVX
 Q
 ;
RESTORE ;  restore locally added cpt codes and ICD changes
 ;  Definition of codes not added back
 ;  ------------------------------------------------------------
 ;  ^tmp("dent",$j,cpt_code) = 1 if non-ADA code is inactive
 ;  ^tmp("dent",$j,cpt_code,ICD_code) = "" if the CPT code was
 ;                  active but the prior ICD code was inactive
 ;  $D(^tmp("dent",$j,cpt_code)) = 10 if the active cpt code had
 ;                         inactive diagnosis codes mapped to it
 ;
 ;  Definition of some key local variables  where n = 1,2,3,4,5
 ;  -----------------------------------------------------------
 ;  n=1,2,3,4,5   DENT() redefined per cpt code
 ;  DENT("LICD",icdien)=locally mapped (added) ICD
 ;
 N DENTVI,DENTVX,X1,DENTVY,ACT,CNT,CPT,CPTN,DATA,IEN,NODE,DENT,DENTX,DATA3,NEWDD,NI,NX,IC,SP
 D NODE Q:'$D(^XTMP(NODE))  D MES(5)
 F DENTVI=1:1:10 L +^DENT(228):2 Q:$T
 ;
 D SET(6) K ^TMP("DENT",$J)
 S (CNT,CPT)=0
 F  S CPT=$O(^XTMP(NODE,CPT)) Q:'CPT  S DATA=^XTMP(NODE,CPT),DATA3=$G(^XTMP(NODE,CPT,3)) D
 .I CPT=81400 D
 ..Q
 .K DENT S CNT=CNT+1,NEWDD=$P(DATA,U,11)
 .S DENTVX=$$CPT^DSICCPT(,CPT,,,,1),CPTN=$P(DENTVX,U,2),ACT=$P(DENTVX,U,7)
 .;
 .;  check for inactive local cpt codes
 .;  we will leave inactive codes here for reporting P53
 .;I 'ACT S:CPTN'?1"D"4N ^TMP("DENT",$J,CPTN)=1 Q
 .;
 .; Get IEN if cpt exist in new table
 .S IEN=$O(^DENT(228,"B",CPT,0))
 .; ALWAYS put $Values back and/or admin guideline
 .I IEN I $P(DATA,U,7)!$P(DATA,U,8)!(DATA3]"") K DENTX D
 ..S:$P(DATA,U,7) DENTX(228,IEN_",",1.14)=$P(DATA,U,7)
 ..S:$P(DATA,U,8) DENTX(228,IEN_",",1.15)=$P(DATA,U,8)
 ..S:DATA3]"" DENTX(228,IEN_",",3)=DATA3 ; ADMIN GUIDELINE
 ..D FILE^DIE(,"DENTX")
 ..Q
 .;  setup local ICD array with codes we want to add back
 .I 'NEWDD,$P(DATA,U)="L" F DENTVI=2:1:6 S NX=$P(DATA,U,DENTVI) I NX D
 ..S DENTVY=$$ICD^DENTVICD(,$$EXTERNAL^DILFD(228.06,.01,,NX),DT,1)
 ..I '$P(DENTVY,U,10) S ^TMP("DENT",$J,CPTN,$P(DENTVY,U,2))="" Q
 ..I IEN,$D(^DENT(228,IEN,5,"B",NX)) Q  ;already in the multiple
 ..S DENT("LICD",NX)=""
 ..Q
 .I NEWDD S NI=0 F  S NI=$O(^XTMP(NODE,CPT,5,NI)) Q:'NI  D
 ..S NX=+$G(^XTMP(NODE,CPT,5,NI,0)) Q:'NX
 ..S DENTVY=$$ICD^DENTVICD(,$$EXTERNAL^DILFD(228.06,.01,,NX),DT,1)
 ..I '$P(DENTVY,U,10) S ^TMP("DENT",$J,CPTN,$P(DENTVY,U,2))="" Q
 ..I IEN,$D(^DENT(228,IEN,5,"B",NX)) Q  ;already in the multiple
 ..S DENT("LICD",NX)=""
 ..Q
 .I NEWDD S NI=0 F  S NI=$O(^XTMP(NODE,CPT,6,NI)) Q:'NI  D
 ..S NX=+$G(^XTMP(NODE,CPT,6,NI,0)) Q:'NX
 ..S DENTVY=$$ICD^DENTVICD(,$$EXTERNAL^DILFD(228.06,.01,,NX),DT,1)
 ..I '$P(DENTVY,U,10) S ^TMP("DENT",$J,CPTN,$P(DENTVY,U,2))="" Q
 ..I IEN,$D(^DENT(228,IEN,6,"B",NX)) Q  ;already in the multiple
 ..S DENT("LICD10",NX)=""
 ..Q
 .;  if cpt is not in file 228, then add only if A local code and has ICD codes
 .I 'IEN,$P(DATA,U)="L",($D(DENT("LICD"))!($D(DENT("LICD10")))) D
 ..N X0,X1,DA,DD,DO,DIC,DIE,DIK,IC
 ..S (DENTVX,X0,DA)=CPT
 ..S DENTVY=^DENT(228,0),$P(DENTVY,U,3)=DA,$P(DENTVY,U,4)=1+$P(DENTVY,U,4),^DENT(228,0)=DENTVY
 ..S $P(X0,U,6)="LOCAL CODES",$P(X0,U,15)="L"
 ..S $P(X0,U,16)=$P(DATA,U,10),$P(X0,U,18)=$P(DATA,U,9) ;VA-DSS Group and RVU
 ..S $P(X1,U,14)=$P(DATA,U,7),$P(X1,U,15)=$P(DATA,U,8) ;$Values
 ..S ^DENT(228,DA,0)=X0,^DENT(228,DA,1)=X1 S:DATA3]"" ^DENT(228,DA,3)=DATA3
 ..S DIK="^DENT(228," D IX1^DIK
 ..S IEN=CPT
 ..Q
 .Q:'IEN  Q:(('$O(DENT("LICD10",0)))&('$O(DENT("LICD",0))))
 .;
 .;site added to natl ICD mapping, put back local ICD(s) OR add local icd for new codes
 .S IC=0 F  S IC=$O(DENT("LICD",IC)) Q:'IC  D ICD(IEN,IC)
 .S IC=0 F  S IC=$O(DENT("LICD10",IC)) Q:'IC  D ICD10(IEN,IC)
 .Q
 L -^DENT(228)
 K ^XTMP(NODE)
 Q:'$D(^TMP("DENT",$J))
 ;
 ;  some problems encountered during restore, send message
 D MSG2(7,9) S DENTVI=3,CPTN=0,DENTVX="   ",SP="          "
 F  S CPTN=$O(^TMP("DENT",$J,CPTN)) Q:CPTN=""  D:$G(^TMP("DENT",$J,CPTN))
 .K ^TMP("DENT",$J,CPTN) S DENTVX=DENTVX_$E(CPTN_SP,1,10)
 .I $L(DENTVX)>70 S DENTVI=DENTVI+1,DENTVZ(DENTVI)=DENTVX,DENTVX="   "
 .Q
 I $L(DENTVX)>3 S DENTVI=DENTVI+1,DENTVZ(DENTVI)=DENTVX
 I $D(DENTVZ) D M
 Q:'$D(^TMP("DENT",$J))
 ;
 D MSG2(11,13) S DENTVI=3,CPTN=0
 F  S CPTN=$O(^TMP("DENT",$J,CPTN)) Q:CPTN=""  D
 .S DENTVX="   "_CPTN_":  ",DENTVY=0
 .F  S DENTVY=$O(^TMP("DENT",$J,CPTN,DENTVY)) Q:DENTVY=""  S DENTVX=DENTVX_$E(DENTVY_SP,1,10)
 .S DENTVI=DENTVI+1,DENTVZ(DENTVI)=DENTVX
 .Q
 D M K ^TMP("DENT",$J)
 Q
INACTIVE ; Clean out inactivated codes from user parameters
 N DENTPROV S DENTPROV=0
 F  S DENTPROV=$O(^DENT(220.5,"B",$G(DENTPROV))) Q:$G(DENTPROV)'?1.N  D QUICK,LINK,SPEED
 Q
 ;-------------------------  SUBROUTINES  -------------------------
 ;
ICD(ADAI,ICDI) ;FILE^DICN returns new ien of multiple^icd ien (.01) field^1 (added)
 I $D(^DENT(228,ADAI,5,"B",ICDI)) Q  ;already there
 N DENTARR
 S DENTARR(228.05,"+1,"_ADAI_",",.01)=ICDI
 D UPDATE^DIE("K","DENTARR")
 Q
ICD10(ADAI,ICDI) ;FILE^DICN returns new ien of multiple^icd ien (.01) field^1 (added)
 I $D(^DENT(228,ADAI,6,"B",ICDI)) Q  ;already there
 N DENTARR
 S DENTARR(228.06,"+1,"_ADAI_",",.01)=ICDI
 D UPDATE^DIE("K","DENTARR")
 Q
MES(DENTVX) ;  display messages during install
 ;;Saving your $Value mappings to ADA/CPT codes
 ;;Saving any locally added codes from your ADA/CPT Mapping table
 ;;Deleting entries in old ADA mapping file (#228)
 ;;
 ;;Restoring local CPT codes and $Values to ADA/CPT Mapping table
 ;;
 ;;The following is A list of locally added CPT codes which were not put
 ;;back into the ADA Mapping Table (file 228) as these codes are
 ;;inactive:
 ;;
 ;;The following CPT codes had one or more inactive diagnosis codes
 ;;mapped to them.  These inactive diagnosis codes were not put back
 ;;into the ADA Mapping Table (file 228):
 ;;
 I +DENTVX=DENTVX S DENTVX=">>>>> "_$P($T(MES+DENTVX),";",3)_" <<<<<"
 ; D MES^DSICXPDU(DENTVX,1)
 Q
 ;
MSG2(DENTVX,DENTVY,DENTVA) ;
 K DENTVZ N DENTVI,DENTVJ S DENTVJ=0
 F DENTVI=DENTVX:1:DENTVY S DENTVJ=DENTVJ+1,DENTVZ(DENTVJ)=$TR($T(MES+DENTVI),";"," ")
 Q:'$G(DENTVA)
M ; D MES^DSICXPDU(.DENTVZ)
 Q
 ;
NODE N DENTVP,DENTVV,DENTVX,DENTVY S DENTVX=$T(+2),DENTVV=$P(DENTVX,";",3),DENTVY=$P(DENTVX,"**",2),DENTVP=$P(DENTVY,",",$L(DENTVY,","))
 S NODE="DENT228*"_$S(DENTVP:DENTVP,1:DENTVV)
 Q
 ;
SET(DENTVX) S $P(^XTMP(NODE,0),U,DENTVX)=1 Q
QUICK ; Removing quickcodes which are inactivated
 N DENTLIST,DENTINST,DENTX
 D GETLST^XPAR(.DENTLIST,"USR.`"_DENTPROV,"DENTV CPT QUICK LIST","E")
 Q:'DENTLIST
 F  S DENTX=$O(DENTLIST($G(DENTX))) Q:DENTX=""  D
 .S DENTINST=$P(DENTLIST(DENTX),U)
 .Q:+$$ACTCPT^DSICCPT(,DENTINST,,,1)
 .D DEL^XPAR("USR.`"_DENTPROV,"DENTV CPT QUICK LIST",DENTINST)
 Q
LINK ; Removing codelinks which are inactivated
 N DENTLIST,DENTCODE,DENTINST,DENTX,DENTY,DENTLINK,DENTMULT
 D GETLST^XPAR(.DENTLIST,"USR.`"_DENTPROV,"DENTV TX CODELINKS","E")
 Q:'DENTLIST
 F  S DENTX=$O(DENTLIST($G(DENTX))) Q:DENTX=""  D
 .S DENTINST=$P(DENTLIST(DENTX),U)
 .S DENTMULT=$P(DENTLIST(DENTX),U,2)
 .I '+$$ACTCPT^DSICCPT(,DENTINST,,,1) D DEL^XPAR("USR.`"_DENTPROV,"DENTV TX CODELINKS",DENTINST)
 .F DENTY=1:1 S DENTCODE(DENTY)=$P(DENTMULT,";",DENTY) Q:DENTCODE(DENTY)=""  D
 ..K:'+$$ACTCPT^DSICCPT(,DENTCODE(DENTY),,,1) DENTCODE(DENTY)
 ..S:$D(DENTCODE(DENTY)) DENTLINK=$G(DENTLINK)_$G(DENTCODE(DENTY))_";"
 .Q:DENTMULT=$G(DENTLINK)
 .D:$G(DENTLINK)'="" CHG^XPAR("USR.`"_DENTPROV,"DENTV TX CODELINKS",DENTINST,DENTLINK)
 .D:$G(DENTLINK)="" DEL^XPAR("USR.`"_DENTPROV,"DENTV TX CODELINKS",DENTINST)
 Q
SPEED ; Removing speedcodes which are inactivated
 N DENTLIST,DENTINST,DENTX,DENTMULT,DENTINFO,DENTFULL
 D GETLST^XPAR(.DENTLIST,"USR.`"_DENTPROV,"DENTV TX SPEEDCODES","E")
 Q:'DENTLIST
 F  S DENTX=$O(DENTLIST($G(DENTX))) Q:DENTX=""  D
 .N DENTLINK,DENTCODE
 .S DENTINST=$P(DENTLIST(DENTX),U)
 .S DENTINFO=$P($P(DENTLIST(DENTX),U,2),";",1,4)
 .S DENTMULT=$P($P(DENTLIST(DENTX),";",5,9999),"!",2)
 .F DENTY=1:1 S DENTCODE(DENTY)=$P(DENTMULT,";",DENTY) Q:DENTCODE(DENTY)=""  D  Q:$G(DENTLINK)=""
 ..K:'+$$ACTCPT^DSICCPT(,DENTCODE(DENTY),,,1) DENTCODE(DENTY)
 ..I $G(DENTLINK)="",$D(DENTCODE(DENTY)) S DENTLINK=DENTINFO_";!"_DENTCODE(DENTY)_";" Q
 ..I $D(DENTCODE(DENTY)) S DENTLINK=$G(DENTLINK)_DENTCODE(DENTY)_";"
 .Q:$P(DENTLIST(DENTX),U,2)=$G(DENTLINK)
 .D:$G(DENTLINK)'="" CHG^XPAR("USR.`"_DENTPROV,"DENTV TX SPEEDCODES",DENTINST,DENTLINK)
 .D:$G(DENTLINK)="" DEL^XPAR("USR.`"_DENTPROV,"DENTV TX SPEEDCODES",DENTINST)
 Q
