EAS1220P ;ALB/KUM - EAS*1.0*220 POST-INSTALL ;OCT 24, 2022@09:25
 ;;1.0;ENROLLMENT APPLICATION SYSTEM;**220**;MAR 15,2001;Build 6
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;ICRs
 ; Reference to BMES^XPDUTL in ICR #10141
 ; Reference to IENS^DILF,CLEAN^DILF in ICR #2054
 ; Reference to UPDATE^DIE in ICR #2053
 ; Reference to FMADD^XLFDT in ICR #10103
 ; Reference to ^DIC(5) in ICR #10056
 ; Reference to UP^XLFSTR in ICR #10104
 ;
 Q
 ;
PRETRAN ;Load tables
 I $G(DUZ("AG"))'="V" Q
 M @XPDGREF@("EAS1220")=^XTMP("EAS1220")
 Q
 ;
EN ; Display a message to inform the user that there will be a slight delay when installing the patch.
 ;
 N EASMESS
 S EASMESS(1)=">>>Beginning the EAS*1.0*220 Post-install routine..."
 S EASMESS(2)=" "
 S EASMESS(3)="     Updating GMT THRESHOLDS (#712.5) file with the updates for the"
 S EASMESS(4)="     calendar year 2023 (income year 2022). These updates should "
 S EASMESS(5)="     take under 2 minutes.  Please be patient and allow the process "
 S EASMESS(6)="     to complete. "
 S EASMESS(7)=""
 D BMES^XPDUTL(.EASMESS)
 D ADD
 Q
 ;
ADD ; Parse the data coming in and file it to the globals
 K ^XTMP("EAS1220")
 K ^XTMP("EAS1220H")
 M ^XTMP("EAS1220")=@XPDGREF@("EAS1220")
 S ^XTMP("EAS1220",0)=$$FMADD^XLFDT(DT,30)_U_DT_U_"EAS*1.0*220 - Create Zip Code FIPS code Xref"
 S ^XTMP("EAS1220H",0)=$$FMADD^XLFDT(DT,30)_U_DT_U_"EAS*1.0*220 - Duplicate FIPS not filed"
 N EASGMT,EASCNTR,EASCNT,EASJ,EASRECA,EASRECR,EASDATA,EASMSG,EASADD,EASX,EASNODE
 S EASRECA=0,EASRECR=0
 D BMES^XPDUTL("     Updating.")
 S EASCNTR="" F  S EASCNTR=$O(^XTMP("EAS1220","DATA",2022,EASCNTR)) Q:'EASCNTR  D
 .S EASGMT("YEAR")=3220000
 .S EASGMT("COUNTY NAME")=$$UP^XLFSTR($P(^XTMP("EAS1220","DATA",2022,EASCNTR),U,2))
 .S EASGMT("STATE")=$P(^XTMP("EAS1220","DATA",2022,EASCNTR),U)
 .S EASGMT("MSA")=$P(^XTMP("EAS1220","DATA",2022,EASCNTR),U,4)
 .;I EASGMT("MSA")=10000 S EASGMT("MSA")=0
 .F EASCNT=1:1:8 S EASGMT("THR"_EASCNT)=$P(^XTMP("EAS1220","DATA",2022,EASCNTR),U,(EASCNT+4))
 .S EASGMT("STATE")=$E("00",1,2-$L(EASGMT("STATE")))_EASGMT("STATE")
 .S EASGMT("FIPS")=$P(^XTMP("EAS1220","DATA",2022,EASCNTR),U,3)
 .S EASGMT("ST IEN")=$O(^DIC(5,"C",EASGMT("STATE"),""))
 .S EASDATA(.01)=$G(EASGMT("YEAR"))
 .S EASDATA(.02)=$G(EASGMT("FIPS"))
 .S EASDATA(.03)=$G(EASGMT("ST IEN"))
 .S EASDATA(.04)=$G(EASGMT("COUNTY NAME"))
 .S EASDATA(.05)=$G(EASGMT("MSA"))
 .F EASJ=1:1:8 S EASDATA(.10+(EASJ*.01))=$G(EASGMT("THR"_EASJ))
 .S EASX="" F  S EASX=$O(EASDATA(EASX)) Q:'EASX
 .S EASADD=$$FILE(712.5,,.EASDATA,.EASERR)
 .I EASADD S EASRECA=EASRECA+1
 .I 'EASADD D
 ..S EASRECR=EASRECR+1
 ..S EASNODE=EASDATA(.01)_"^"_EASDATA(.02)_"^"_EASDATA(.03)_"^"_EASDATA(.04)_"^"_EASDATA(.05)
 ..S EASNODE=EASNODE_"^"_EASDATA(.11)_"^"_EASDATA(.12)_"^"_EASDATA(.13)_"^"_EASDATA(.14)
 ..S EASNODE=EASNODE_"^"_EASDATA(.15)_"^"_EASDATA(.16)_"^"_EASDATA(.17)_"^"_EASDATA(.18)
 ..S ^XTMP("EAS1220H",EASRECR)=EASNODE_"^"_$G(EASERR)
 .I '$D(ZTQUEUED),'(EASCNTR#500) W "."
 S EASMSG(1)="     Process Complete!"
 S EASMSG(2)=" "
 S EASMSG(3)="     Number of records added: "_EASRECA
 S EASMSG(4)="     Number of duplicate records: "_EASRECR
 S EASMSG(5)=" "
 S EASMSG(6)="     NOTE: Only one entry per Year/State and County Code is filed and the "
 S EASMSG(7)="     remaining are identified as duplicates and cannot be uploaded."
 S EASMSG(8)=" "
 S EASMSG(9)="     Added records are stored in ^XTMP("_"""EAS1220"_""")"
 S EASMSG(10)="     Duplicates will not be filed in the GMT Threshold file (#712.5)."
 S EASMSG(11)="     Duplicate records are stored in ^XTMP("_"""EAS1220H"_""")"
 S EASMSG(12)="     These globals will be automatically purged in 30 days."
 S EASMSG(13)=" "
 S EASMSG(14)=">>> Patch EAS*1.0*220 Post-install complete."
 D BMES^XPDUTL(.EASMSG)
 Q
FILE(EASFILE,EASENDA,EASDATA,EASERR) ; File Data
 ;Description: Creates a new record and files the data.
 ; Input:
 ; EASFILE - File or sub-file number
 ; EASENDA - New name for traditional FileMan DA array with same
 ; meaning. Pass by reference.  Only needed if adding to a
 ; subfile.
 ; EASDATA - Data array to file, pass by reference
 ; Format: EASDATA(<field #>)=<value>
 ;
 ; Output:
 ; Function Value - If no error then it returns the ien of the created record, else returns NULL.
 ; EASENDA - returns the ien of the new record, NULL if none created.  If needed, pass by reference.
 ; EASERR - optional error message - if needed, pass by reference
 ;
 ;
 N EASFDA,EASFLD,EASIENA,EASIENS,EASERRS,EASIEN,DIERR
 ;
 ;EASIENS - Internal Entry Number String defined by FM
 ;EASIENA - the Internal Entry Number Array defined by FM
 ;EASFDA - the FDA array defined by FM
 ;EASIEN - the ien of the new record
 ;
 S EASENDA="+1"
 S EASIENS=$$IENS^DILF(.EASENDA)
 S EASFLD=0
 F  S EASFLD=$O(EASDATA(EASFLD)) Q:'EASFLD  D
 .S EASFDA(EASFILE,EASIENS,EASFLD)=$G(EASDATA(EASFLD))
 D UPDATE^DIE("","EASFDA","EASIENA","EASERRS(1)")
 I +$G(DIERR) D
 .S EASERR=$G(EASERRS(1,"DIERR",1,"TEXT",1))
 .S EASIEN=""
 E  D
 .S EASIEN=EASIENA(1)
 .S EASERR=""
 D CLEAN^DILF
 S EASENDA=EASIEN
 Q EASIEN
