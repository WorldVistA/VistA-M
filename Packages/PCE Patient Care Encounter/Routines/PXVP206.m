PXVP206 ;BPOIFO/CLR - POST INSTALL ;01/14/15 12:38pm
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**206**;Aug 12, 1996;Build 50
 ;
 ; This routine uses the following IAs:
 ; #4639 - ^HDISVCMR calls     (supported)
 ; #4651 - ^HDISVF09 calls     (supported)
 ; #4640 - ^HDISVF01 calls     (supported)
 ;
 Q
 ;
PRETRAN ;Load spreadsheet
 M @XPDGREF@("PXVSKX")=^XTMP("PXVSKX")
 Q
 ;
PRE ;
 N PXVI,PXVNM,I,PXVC
 ;delete SHORT NAME identifier
 I $D(^DD(9999999.14,0,"ID",.02)) K ^DD(9999999.14,0,"ID",.02)
 I $$DUP() D  Q
 . D BMES^XPDUTL("DUPLICATE Names were found in the SKIN TEST file - INSTALLATION ABORTED")
 . S XPDABORT=1
 D DELETE(920) ;kills file
 Q
 ;
POST ;Post installation
 ;standardize SKIN Test file
 ;
 N ERRCNT,PXVCPDT,XUMF,PXVGL,PXVF
 S XUMF=1
 K ^XTMP("PXVSKX"),^XTMP("PXVERR")
 M ^XTMP("PXVSKX")=@XPDGREF@("PXVSKX")
 I '$D(^XTMP("PXVSKB")) M ^XTMP("PXVSKB",9999999.28)=^AUTTSK
 S PXVCPDT=$$FMADD^XLFDT(DT,90)
 S ^XTMP("PXVSKX",0)=PXVCPDT_"^"_DT  ;set purge ddt/creation dt
 S PXVCPDT=$$FMADD^XLFDT(DT,60)
 S ^XTMP("PXVSKB",0)=PXVCPDT_"^"_DT
 ;backup files populated in PX*1*201
 I '$D(^XTMP("PXVBKUP")) D
 . F PXVF=920.1,920.2,920.3,9999999.04,9999999.14,920.4,920.5 D
 . . S PXVGL=$$ROOT^DILFD(PXVF,"",1) Q:PXVGL=""
 . . M ^XTMP("PXVBKUP",PXVF)=@PXVGL
 S ^XTMP("PXVBKUP",0)=PXVCPDT_"^"_DT  ;90 days
 D DATA ;restores original SKIN TEST file
 D SELECT ;standardizes entries in skin test file
 D REMAIN  ;inactivates non-standard entries
 D SHORTNM  ;fixes spelling error
 D MAIL
 I $D(^XTMP("PXVERR")) D  Q 
 . D BMES^XPDUTL("Master File Server Seeding was aborted because of errors in the SKIN TEST file conversion!!")
 D CLEAN  ;deletes MAX# IN SERIES values
 D HDIS  ;seeds if no errors
 Q
 ;
SELECT ;Select standard in local file entries
 N I,PXVIEN,PXVNM,PXVZ,PXVOUT,PXVERR,PXVNAT
 F I=0:0 S I=$O(^XTMP("PXVSKX",I)) Q:I=""  D
 . S PXVZ=$G(^XTMP("PXVSKX",I,0))
 . S PXVNM=$P(PXVZ,U,2)
 . S PXVIEN=$$IEN(PXVNM)
 . I $P(PXVZ,U)="" D  Q
 . . Q:'+PXVIEN  ;quit if not in file
 . . D LOCAL(PXVIEN)
 . S PXVZ=PXVIEN_"^"_I_"~"_PXVZ
 . S PXVOUT=$$STANDARD(PXVZ)
 Q
 ;
STANDARD(PXVZ) ;set up standard record
 ;  .01          NAME
 ;  .02          CODE
 ;  .03          INACTIVE FLAG
 ;  .11          CPT CODE
 ;  3            CODING SYSTEM  (multiple)
 ;  1201         PRINT NAME
 ;  8801         MNEMONIC
 ;IEN/0^ROW #~CLASS^NAME^PRINT NAME^STATUS^CPT^MAP NAME
 N PXV,PXVT,PXVNM,PXVRNM,PXVMAPN,PXVPRT,PXVIEN,PXVERR
 Q:PXVZ="" 1
 Q:$D(PXVNAT($P(PXVZ,U,4))) 1 ;duplicate National record
 I $P(PXVZ,U,7)'="" Q:$D(^AUTTSK("B",$P(PXVZ,U,7))) 1  ;quit if record exists with map name
 S XUMF=1
 S (PXV,PXVIEN(1))=+$P(PXVZ,U)
 I '+$P(PXVZ,U) D
 . S PXVIEN(1)=100+(+$P($P(PXVZ,U,2),"~")),PXV="+1"  ;get IEN
 S PXVRNM=$S(PXV="+1":"",1:$P($G(^AUTTSK(+$P(PXVZ,U),0)),U))  ;Record Name
 S PXVNM=$$UP^XLFSTR($P(PXVZ,U,3))  ;Name
 S PXVPRT=$P(PXVZ,U,4)  ;Print Name
 S PXVMAPN=$P(PXVZ,U,7)  ;Map Name
 I PXV="+1",$D(^AUTTSK("B",PXVPRT)) D
 . ;if record already exists with print name, use that record
 . S (PXV,PXVIEN(1))=$O(^AUTTSK("B",PXVPRT,""))
 . S PXVRNM=PXVPRT
 I $$UP^XLFSTR(PXVRNM)'=PXVPRT D
 . S PXVT(9999999.28,PXV_",",.01)=PXVPRT  ;REPLACE NAME W/PRINT NAME
 S PXVT(9999999.28,PXV_",",1201)=$S(PXVMAPN]"":PXVMAPN,1:PXVNM)
 I PXV'="+1",(+$P($G(^AUTTSK(PXV,0)),U,3)) S $P(^AUTTSK(PXV,0),U,3)=""  ;uneditable prevents FM edit
 S PXVT(9999999.28,PXV_",",100)="NATIONAL"
 S PXVNAT(PXVPRT)=""
 D UPDATE^DIE("E","PXVT","PXVIEN","PXVERR")
 I $D(PXVERR) D ERROR(.PXVERR),BMES(PXVIEN(1)) Q 1
 ;CODING SYSTEM->CODE
 I $P(PXVZ,U,6) D MANY(PXVIEN(1),.PXVZ)
 Q $G(PXV)_U_$S($D(PXVERR):1,1:0)
 ;
MANY(IEN,PXVZ) ;populates Coding Multiple
 N PXVL,PXVCOL,PXVITEM,I,PXVT,PXVERR,PXVLL,PXVREC
 ;CODING SYSTEM
 S PXVCOL="CPT",PXVL=1
 S PXVT(9999999.283,"?+"_PXVL_","_IEN_",",.01)=PXVCOL
 ;CPT CODES
 S PXVLL=PXVL,PXVL=PXVL+1,PXVCOL=$P(PXVZ,U,6)
 F I=1:1 S PXVITEM=$P(PXVCOL,"|",I) Q:PXVITEM=""  D
 . S PXVT(9999999.2831,"?+"_PXVL_",?+"_PXVLL_","_IEN_",",.01)=PXVITEM
 . S PXVL=PXVL+1
 D UPDATE^DIE(,"PXVT",,"PXVERR")
 I $D(PXVERR) D ERROR(.PXVERR),BMES(IEN)
 Q
 ;
REMAIN ;
 ;loop through file entries with no Class code
 N PXVIEN,PXVZ
 F PXVIEN=0:0 S PXVIEN=$O(^AUTTSK(PXVIEN)) Q:PXVIEN'>0  D
 . S PXVZ=$G(^AUTTSK(+PXVIEN,0))
 . I $P($G(^AUTTSK(PXVIEN,100)),U)="" D LOCAL(PXVIEN)
 Q
 ;
LOCAL(PXVIEN) ;
 N PXVT,PXVERR
 I $P($G(^AUTTSK(+PXVIEN,0)),U,3)="" S PXVT(9999999.28,PXVIEN_",",.03)="INACTIVE"
 S PXVT(9999999.28,PXVIEN_",",100)="LOCAL"
 D UPDATE^DIE("E","PXVT",,"PXVERR")
 I $D(PXVERR) D ERROR(.PXVERR),BMES(PXVIEN)
 Q
 ;
DUP() ;
 ; Returns 0: No duplicates
 ;         1: Duplicate
 N PXVARY,PXVFLG,PXV,PXVIEN
 S PXVFLG=0,PXV=-1 F  S PXV=$O(^AUTTSK("B",PXV)) Q:PXV=""!(PXVFLG)  D
 . F PXVIEN=0:0 S PXVIEN=$O(^AUTTSK("B",PXV,PXVIEN)) Q:PXVIEN=""  D
 . . I '$D(PXVARY($$UP^XLFSTR(PXV))) S PXVARY($$UP^XLFSTR(PXV))="" Q
 . . S PXVFLG=1
 Q PXVFLG
 ; 
IEN(PXVNM) ;
 ;Returns 0:   No match
 ;        IEN: Matching IEN
 N PXVI,PXVIEN
 S PXVIEN="",PXVI=""
 F PXVNM=PXVNM,$$LOW^XLFSTR(PXVNM),$$SENTENCE^XLFSTR(PXVNM),$$TITLE^XLFSTR(PXVNM) D
 . F  S PXVI=$O(^AUTTSK("B",PXVNM,PXVI)) Q:PXVI=""  D
 . . S PXVIEN=PXVI
 Q +PXVIEN
 ;
ERROR(PXVERR) ;
 I '$D(^XTMP("PXVERR",0)) S ^XTMP("PXVERR",0)=$$FMADD^XLFDT(DT,30)_"^"_DT
 S ERRCNT=$S('$D(ERRCNT):1,1:ERRCNT+1)
 S $P(^XTMP("PXVERR",0),U,3)=ERRCNT
 M ^XTMP("PXVERR",ERRCNT)=PXVERR
 Q
 ;
MAIL ;
 N PXVTXT,XMSUB,XMTEXT,PXVTXT,XMY,PXVOK,DIFROM
 S PXVOK=$G(^XTMP("PXVERR",0))>0
 S XMSUB="The SKIN TEST file update "
 S XMSUB=XMSUB_$S(PXVOK:"FAILED",1:"was SUCCESSFUL")
 S XMTEXT="PXVTXT("
 I PXVOK D
 . S PXVTXT(1)="Errors occurred during the update of the SKIN TEST (#9999999.28) file."
 . S PXVTXT(2)="Master File Server Seeding was aborted."
 . S PXVTXT(3)="Details of the errors are stored in ^XTMP(""PXVERR"") for the next 30 days."
 . S PXVTXT(4)="Please contact Product Support for assistance."
 I 'PXVOK D
 . S PXVTXT(1)="The SKIN TEST file has been successfully updated."
 S XMY(DUZ)=""
 D ^XMD
 Q
 ;
DATA ;deletes data in the SKIN TEST file and restores from backup
 N PXVI,DA,DIK
 S XUMF=1
 I '$D(^XTMP("PXVSKB")) D BMES^XPDUTL("SKIN TEST was not restored") Q
 F PXVI=0:0 S PXVI=$O(^AUTTSK(PXVI)) Q:PXVI'>0  D
 . S DA=PXVI,DIK="^AUTTSK(" D ^DIK
 S PXVI=-1 F  S PXVI=$O(^XTMP("PXVSKB",9999999.28,PXVI)) Q:PXVI=""  D
 . M ^AUTTSK(PXVI)=^XTMP("PXVSKB",9999999.28,PXVI)
 Q
 ;
DELETE(PXVFN) ;
 ; Delete data in selected file
 N PXVG,J,DIK,DA,XUMF
 S PXVG=$$ROOT^DILFD(PXVFN,0,"GL")
 S XUMF=1
 F J=0:0 S J=$O(@(PXVG_J_")")) Q:J'>0  D 
 . S DA=J,DIK=PXVG D ^DIK
 Q
 ;
BMES(IEN) ; 
 Q:IEN=""
 D BMES^XPDUTL("Fileman error in SKIN TEST record # "_IEN)
 Q
 ;
SHORTNM ;fix short name spelling
 N PXVI,PXVT,PXVERR
 S PXVI=$O(^AUTTIMM("B","VARICELLA","")) Q:PXVI=""  D
 . Q:'$D(^AUTTIMM("D","VARCELLA",PXVI))
 . S PXVT(9999999.14,PXVI_",",.02)="VARICELLA"
 . D UPDATE^DIE("E","PXVT")
 Q
 ;
CLEAN ;deletes MAX#INSERIES
 N PXV
 F PXV=0:0 S PXV=$O(^AUTTIMM(PXV)) Q:PXV'>0  D
 . Q:$P($G(^AUTTIMM(PXV,0)),U,5)=""
 . I $D(^AUTTIMM(PXV,0)) S $P(^AUTTIMM(PXV,0),U,5)=""
 Q
 ;
HDIS ; Call HDIS to begin the 'seeding' process
 N DOMPTR,TMP
 D SETSTAT^HDISVF01(920,,4)  ;sets seeding status of 920 to 'AWAITING ERT UPDATE'
 D ERTBULL  ;sends bulletin to ERT
 S TMP=$$GETIEN^HDISVF09("IMMUNIZATIONS",.DOMPTR)
 D EN^HDISVCMR(DOMPTR,"")
 Q
 ;
UPD ;
 N DIC,DIE,DA,DR,Y,XUMF
 S XUMF=1
 F PXV=0:0 S DIC="^AUTTSK(",DIC(0)="AEQLN" D ^DIC Q:Y<0  D
 . S DIE="^AUTTSK(",DR=".01;.03;3;100;1201;8801",DA=+Y D ^DIE
 Q
 ;
ERTBULL ;
 ;sends bulletin to ERT that 920 is ready for full file update
 N PXVTMP,HDISP,HDISFLAG,HDISTASK
 S PXVTMP=$$SITE^VASITE()
 S HDISP(1)=$P(PXVTMP,"^",2),HDISP(1)=HDISP(1)_" (#"_($P(PXVTMP,"^",3))_") with Domain/IP Address "_$G(^XMB("NETNAME")) ;facility name
 S HDISP(2)="VACCINE INFORMATION STATEMENT (#920)"
 S HDISP(3)=$$NOW^XLFDT N Y S Y=HDISP(3) D DD^%DT S HDISP(3)=Y ;date/time
 S HDISP(4)=$$PROD^XUPROD(),HDISP(4)=$S(HDISP(4):"PRODUCTION",1:"TEST") ;system type
 S HDISP(5)=$P(PXVTMP,"^",3) ;facility number
 S HDISP(6)=920
 S HDISFLAG("FROM")="HDIS Data Standardization Server"
 D TASKBULL^XMXAPI(DUZ,"HDIS NOTIFY ERT",.HDISP,,,.HDISFLAG,.HDISTASK) ;
 Q
 ;
RESTORE(PXVF) ;
 N PXVGL,PXVI
 I (PXVF'=920.1)&(PXVF'=920.2)&(PXVF'=920.3)&(PXVF'=920.4)&(PXVF'=920.5)&(PXVF'=9999999.04)&(PXVF'=9999999.14) D  Q
 . W !,"Only 920.1, 920.2, 920.3, 920.4, 920.5,9999999.04 and 9999999.14 can be restored using this API."
 I '$D(^XTMP("PXVBKUP",PXVF)) W !,"Data backup has been purged.  Restore is aborted." Q
 D DELETE(PXVF)
 S PXVGL=$$ROOT^DILFD(PXVF)
 S PXVI=-1 F  S PXVI=$O(^XTMP("PXVBKUP",PXVF,PXVI)) Q:PXVI=""  D
 . M @(PXVGL_""""_PXVI_""""_")")=^XTMP("PXVBKUP",PXVF,PXVI)
 Q
