ECX3P193 ;MNTVBB/JWB - NATIONAL CLINIC (#728.441) File Update; JAN 10, 2025
 ;;3.0;DSS EXTRACTS;**193**;Dec 22, 1997;Build 5
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; This routine is used as a post-init in a KIDS build to
 ; update the NATIONAL CLINIC (#728.441) file for FY25 Mid-Year.
 ;
 ; Reference(s) to $$FIND1^DIC supported by ICR# 2051
 ; Reference(s) to FILE^DIE supported by ICR# 2053
 ; Reference(s) to UPDATE^DIE supported by ICR# 2053
 ; Reference(s) to BMES^XPDUTL supported by ICR# 10141
 ; Reference(s) to MES^XPDUTL supported by ICR# 10141
 ;
 Q
 ;
POST ;routine entry point
 ;
 ; Start of Install
 D BMES^XPDUTL("Update NATIONAL CLINIC (#728.441) file start.")
 N ECX193FILES
 S ECX193FILE=""
 S ECX193FILES="728.441"
 S ECXCNT=0
 F ECXCNT=1:1:$L(ECX193FILES,"^") D
 . S ECX193FILE=$P(ECX193FILES,"^",ECXCNT)
 . D GLBBKUP
 . Q
 D INACT ;inactivate code
 D UPDATE ;change short description of existing clinic codes
 D BMES^XPDUTL("Update complete.")
 D MES^XPDUTL("")
 Q
 ;
UPDATE ;changing short description of existing entries
 ;ECXREC is in format: code^short description
 ;
 N ECXCODE,ECXDESC,ECXIEN,DIE,DA,DR,ECXI,ECXREC,ECXERR
 ;
 D BMES^XPDUTL(">>> Updating entries in the NATIONAL CLINIC (728.441) file...")
 ;
 F ECXI=1:1 S ECXREC=$P($T(UPDCLIN+ECXI),";;",2) Q:ECXREC="QUIT"  D
  .S ECXCODE=$P(ECXREC,"^"),ECXDESC=$P(ECXREC,"^",2)
  .S ECXIEN=$$FIND1^DIC(728.441,"","X",ECXCODE,"","","ECXERR")
  .I 'ECXIEN D  Q
  ..D BMES^XPDUTL(">>>....Unable to find code: "_ECXCODE_".")
  ..D BMES^XPDUTL("*** Please contact support for assistance. ***")
  .K FDA
  .S FDA(728.441,ECXIEN_",",1)=ECXDESC
  .D FILE^DIE(,"FDA","ECXERR")
  .I '$D(ECXERR) D BMES^XPDUTL(">>>...."_ECXCODE_" - "_$P(ECXREC,U,2)_" updated")
  .I $D(ECXERR) D BMES^XPDUTL(">>>....Unable to update code "_ECXCODE_".") D
  ..D BMES^XPDUTL("*** Please contact support for assistance. ***")
 ;
 Q
 ;
INACT ;adding inactivation date to existing clinics
 N ECXCODE,ECXDATE,ECXIEN,DIE,DA,DR,ECXI
 D BMES^XPDUTL(">>>Inactivating entry in the NATIONAL CLINIC (728.441) file..")
 F ECXI=1:1 S ECXREC=$P($T(INCLIN+ECXI),";;",2) Q:ECXREC="QUIT"  D
 .S ECXCODE=$P(ECXREC,"^"),ECXDATE=$P(ECXREC,"^",2)
 .S ECXIEN=$$FIND1^DIC(728.441,"","X",ECXCODE,"","","ERR")
 .I 'ECXIEN D  Q
 ..D BMES^XPDUTL(">>>....Unable to inactivate "_ECXCODE_" "_$P(ECXREC,U,2)_".")
 ..D BMES^XPDUTL(">>>....Contact support for assistance")
 .S DIE="^ECX(728.441,",DA=ECXIEN,DR="3///^S X=ECXDATE"
 .D ^DIE
 .D BMES^XPDUTL(">>>...."_ECXCODE_" "_$P(ECXREC,U,2)_" inactivated")
 Q
 ;
GLBBKUP  ; XTMP Backup of file(s)
 S ECXBKUPNDE="ECX*3.0*193-Update NATIONAL CLINIC Mid Year 2025 Char4 (#728.441)"
 S ^XTMP("ECX3P193",0)=$$FMADD^XLFDT(DT,120)_"^"_DT_"^"_ECXBKUPNDE
 M ^XTMP("ECX3P193",ECX193FILE,$H)=^ECX(ECX193FILE)
 Q
 ;
UPDCLIN ;Contains the NATIONAL CLINIC entry description to be updated
 ;;CDBC^CRH PCMHI CoCM
 ;;CDFC^CRH VA Health Connect VCV (Provider) Hub Side
 ;;EXPX^Military Environmental Exposure (MEE)
 ;;QUIT
 ;
INCLIN ;contains the NATIONAL CLINIC entry inactivation date
 ;;CGCC^3250401
 ;;CGPA^3250401
 ;;CGRD^3250401
 ;;CGSW^3250401
 ;;CNSR^3250401
 ;;CSCL^3250401
 ;;CSCT^3250401
 ;;DECC^3250401
 ;;DENP^3250401
 ;;DEPT^3250401
 ;;DERD^3250401
 ;;DERN^3250401
 ;;DESC^3250401
 ;;DESW^3250401
 ;;DMPC^3250401
 ;;DMPT^3250401
 ;;DMSW^3250401
 ;;FDLC^3250401
 ;;GLDV^3250401
 ;;GLDX^3250401
 ;;GLDY^3250401
 ;;PLTW^3250401
 ;;PLTX^3250401
 ;;PLTY^3250401
 ;;PLTZ^3250401
 ;;SVRW^3250401
 ;;SVRX^3250401
 ;;SVRY^3250401
 ;;SVRZ^3250401
 ;;YCBC^3250401
 ;;YCPX^3250401
 ;;YELT^3250401
 ;;YELU^3250401
 ;;YELV^3250401
 ;;YELW^3250401
 ;;YELX^3250401
 ;;YELY^3250401
 ;;QUIT
 ;
