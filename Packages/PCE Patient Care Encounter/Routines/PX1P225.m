PX1P225 ;ALB/TXH - Update CVX Code; May 18, 2020@14:52
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**225**;Aug 12, 1996;Build 4
 ;
 ; This routine updates local entries that have no CVX code mapped
 ; regardless of case in the IMMUNIZATION file (#9999999.14).
 ;
 Q
 ;
PRETRAN ; Load CVX code table into KIDS build
 ;
 M @XPDGREF@("PXVCVX")=^XTMP("PXVCVX")
 Q
 ;
POST ; Post installation processes
 ;
 D BMES^XPDUTL("*** PX*1.0*225 Post-Install started ***")
 D MES^XPDUTL(" ")
 N D0,DA,DIE,DR,PXCVX,PXI,PXII,PXNM,PXVC,PXNAME
 D LOAD
 D UPD
 D BMES^XPDUTL("*** PX*1.0*225 Post-Install completed ***")
 D MES^XPDUTL(" ")
 Q
 ;
LOAD ; Load local immunization with CVX code provided by VHA SMEs
 ;
 K ^XTMP("PXVCVX")
 M ^XTMP("PXVCVX")=@XPDGREF@("PXVCVX")
 I '$D(^XTMP("PXVCVX")) W !,"Mapping table not loaded - INSTALLATION ABORTED" S XPDQUIT=2 Q
 ; Set auto-delete date from XTMP global - purge dt/creation dt
 S ^XTMP("PXVCVX",0)=$$FMADD^XLFDT(DT,30)_"^"_DT_"^Patch PX*1.0*225 Gold CVX Codes"
 ; abort installation if error loading table
 I +$G(XPDQUIT) Q
 Q
 ;
UPD ; Read local immunization from XTMP and update local entries that
 ; have no CVX code mapped regardless of case in the IMMUNIZATION file.
 ;
 N PXI,PXREC,PXNM,PXVIEN,PXNAME,D0,PXCVX,DA,DR,DIE,PXCNT
 S PXCNT=0
 ; Get name from ^XTMP("PXVCVX")
 F PXI=0:0 S PXI=$O(^XTMP("PXVCVX",PXI)) Q:PXI'>0  D
 . S PXREC=$G(^XTMP("PXVCVX",PXI))
 . S PXNM=$P(PXREC,U,1)
 . ; Get name from ^AUTTIMM
 . F PXVIEN=0:0 S PXVIEN=$O(^AUTTIMM("B",PXNM,PXVIEN)) Q:PXVIEN=""  D
 . . S PXNAME=$P($G(^AUTTIMM(PXVIEN,0)),U,1)
 . . ; Compare names in upper case
 . . I $$UP^XLFSTR(PXNM)=$$UP^XLFSTR(PXNAME) D
 . . . ; check if it is local
 . . . S D0=0 S D0=$O(^AUTTIMM("B",PXNAME,D0)) Q:D0=""  D
 . . . . I $G(^AUTTIMM(D0,100))="L" D ADDCVX
 ;
 D BMES^XPDUTL("    Total "_PXCNT_" CVX codes have been updated at your site.")
 Q
 ;
ADDCVX ; Update CVX code
 ;
 I $P(^AUTTIMM(D0,0),U,3)'="" Q
 S PXCVX=$P(PXREC,U,2)
 I $L(PXCVX)=1 S PXCVX="0"_PXCVX  ; append zero if only 1 digit
 S DA=D0,DR=".03////^S X=PXCVX",DIE=9999999.14
 D ^DIE
 D MES^XPDUTL("    Update CVX code for local entry "_PXNM)
 S PXCNT=PXCNT+1
 Q
