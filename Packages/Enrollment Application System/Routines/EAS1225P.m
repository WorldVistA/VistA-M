EAS1225P ;ALB/SJD - EAS*1.0*225 POST-INSTALL ;AUG 27, 2025@09:25
 ;;1.0;ENROLLMENT APPLICATION SYSTEM;**225**;MAR 15,2001;Build 1
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
 M @XPDGREF@("EAS1225")=^XTMP("EAS1225")
 Q
 ;
EN ; Display a message to inform the user that there will be a slight delay when installing the patch.
 ;
 N EASMESS,Y,EASDTS,EASDTE
 D NOW^%DTC S Y=% D DD^%DT
 S EASDTS=Y  ;Start Time
 S EASMESS(1)=">>> Beginning the EAS*1.0*225 Post-install routine..."
 S EASMESS(2)=" "
 S EASMESS(3)="     Updating GMT THRESHOLDS (#712.5) file with the updates for the"
 S EASMESS(4)="     calendar year 2026 (income year 2025). These updates should "
 S EASMESS(5)="     take under 2 minutes.  Please be patient and allow the process "
 S EASMESS(6)="     to complete. "
 S EASMESS(7)=""
 D BMES^XPDUTL(.EASMESS)
 D ADD
 Q
 ;
ADD ; Parse the data coming in and file it to the globals
 K ^XTMP("EAS1225")
 K ^XTMP("EAS1225H")
 M ^XTMP("EAS1225")=@XPDGREF@("EAS1225")
 S ^XTMP("EAS1225",0)=$$FMADD^XLFDT(DT,30)_U_DT_U_"EAS*1.0*225 - Create Zip Code FIPS code Xref"
 S ^XTMP("EAS1225H",0)=$$FMADD^XLFDT(DT,30)_U_DT_U_"EAS*1.0*225 - Duplicate FIPS not filed"
 N EASGMT,EASCNTR,EASCNT,EASJ,EASRECA,EASRECR,EASDATA,EASMSG,EASADD,EASX,EASNODE
 S EASRECA=0,EASRECR=0
 D BMES^XPDUTL("     Updating.")
 S EASCNTR="" F  S EASCNTR=$O(^XTMP("EAS1225","DATA",2025,EASCNTR)) Q:'EASCNTR  D
 .S EASGMT("YEAR")=3250000
 .; Start extracting data from HUD data set in ^XTMP
 .S EASGMT("COUNTY NAME")=$$UP^XLFSTR($P(^XTMP("EAS1225","DATA",2025,EASCNTR),U,2))
 .S EASGMT("STATE")=$P(^XTMP("EAS1225","DATA",2025,EASCNTR),U)
 .S EASGMT("MSA")=$P(^XTMP("EAS1225","DATA",2025,EASCNTR),U,4)
 .F EASCNT=1:1:8 S EASGMT("THR"_EASCNT)=$P(^XTMP("EAS1225","DATA",2025,EASCNTR),U,(EASCNT+4))
 .S EASGMT("STATE")=$E("00",1,2-$L(EASGMT("STATE")))_EASGMT("STATE")
 .S EASGMT("FIPS")=$P(^XTMP("EAS1225","DATA",2025,EASCNTR),U,3)
 .S EASGMT("ST IEN")=$O(^DIC(5,"C",EASGMT("STATE"),""))
 .; Start setting EASDATA array with HUD data to populate File (#712.5)
 .; Data will be passed into tag FILE
 .; Data Descriptions:
 .;   .01 - Fiscal Year       
 .;   .02 - FIPS (ZIP Code)   
 .;   .03 - State IEN         
 .;   .04 - State County Name
 .;   .05 - MSA 
 .;   .11 through .18 - l80 HUD thresholds (pieces 5 - 12)
 .S EASDATA(.01)=$G(EASGMT("YEAR"))
 .S EASDATA(.02)=$G(EASGMT("FIPS"))
 .S EASDATA(.03)=$G(EASGMT("ST IEN"))
 .S EASDATA(.04)=$G(EASGMT("COUNTY NAME"))
 .S EASDATA(.05)=$G(EASGMT("MSA"))
 .F EASJ=1:1:8 S EASDATA(.10+(EASJ*.01))=$G(EASGMT("THR"_EASJ))
 .S EASX="" F  S EASX=$O(EASDATA(EASX)) Q:'EASX
 .S EASADD=$$FILE(712.5,,.EASDATA,.EASERR)
 .I EASADD S EASRECA=EASRECA+1
 .; If an error is returned from the FILE tag, set error data and message (Duplicates)
 .I 'EASADD D
 ..S EASRECR=EASRECR+1
 ..S EASNODE=EASDATA(.01)_"^"_EASDATA(.02)_"^"_EASDATA(.03)_"^"_EASDATA(.04)_"^"_EASDATA(.05)
 ..S EASNODE=EASNODE_"^"_EASDATA(.11)_"^"_EASDATA(.12)_"^"_EASDATA(.13)_"^"_EASDATA(.14)
 ..S EASNODE=EASNODE_"^"_EASDATA(.15)_"^"_EASDATA(.16)_"^"_EASDATA(.17)_"^"_EASDATA(.18)
 ..S ^XTMP("EAS1225H",EASRECR)=EASNODE_"^"_$G(EASERR)
 .I '$D(ZTQUEUED),'(EASCNTR#500) W "."
 D NOW^%DTC S Y=% D DD^%DT
 S EASDTE=Y  ;End time
 S EASMSG(1)="     Process Complete!"
 S EASMSG(2)=" "
 S EASMSG(3)="     Job Start Date and Time: "_EASDTS
 S EASMSG(4)="     Job End Date and Time: "_EASDTE
 S EASMSG(5)=" "
 S EASMSG(6)="     Number of records added: "_EASRECA
 S EASMSG(7)="     Number of duplicate records: "_EASRECR
 S EASMSG(8)=" "
 S EASMSG(9)="     NOTE: Only one entry per Year/State and County Code is filed and the "
 S EASMSG(10)="     remaining are identified as duplicates and cannot be uploaded."
 S EASMSG(11)=" "
 S EASMSG(12)="     Added records are stored in ^XTMP("_"""EAS1225"_""")"
 S EASMSG(13)="     Duplicates will not be filed in the GMT THRESHOLDS (#712.5) file."
 S EASMSG(14)="     Duplicate records are stored in ^XTMP("_"""EAS1225H"_""")"
 S EASMSG(15)="     These globals will be automatically purged in 30 days."
 S EASMSG(16)=" "
 S EASMSG(17)=">>> Patch EAS*1.0*225 Post-install complete."
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
