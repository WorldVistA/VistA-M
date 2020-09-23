EAS1192P ;DEV/BJR - EAS*1.0*192 POST-INSTALL ; Jun 09, 2020@10:51
 ;;1.0;ENROLLMENT APPLICATION SYSTEM;**192**;MAR 15,2001;Build 7
 ;
 Q
 ;
 ; ICR #10141 supports BMES^XPDUTL call
 ; ICR #2054 supports IENS^DILF and CLEAN^DILF calls
 ; ICR #2053 supports UPDATE^DIE call
 ; ICR #10103 supports FMADD^XLFDT call
 ; ICR #10056 supports ^DIC(5) direct global read
 ; ICR #10104 supports UP^XLFSTR call
 ;
PRETRAN ;Load tables
 I $G(DUZ("AG"))'="V" Q
 M @XPDGREF@("EAS1192")=^XTMP("EAS1192")
 Q
 ;
EN ; Display a message to inform the user that there will be a slight
 ; delay when installing the patch.
 ;
 N EASMESS
 S EASMESS(1)="POST-INSTALLATION PROCESSING"
 S EASMESS(2)="---------------------------"
 S EASMESS(3)="This installation will take some time due to the large size of the file."
 S EASMESS(4)="Please be patient and allow the process to complete.  Thank you!"
 S EASMESS(5)=""
 D BMES^XPDUTL(.EASMESS)
 D ADD
 Q
ADD ; Parse the data coming in and file it to the globals
 K ^XTMP("EAS1192")
 M ^XTMP("EAS1192")=@XPDGREF@("EAS1192")
 S ^XTMP("EAS1192",0)=$$FMADD^XLFDT(DT,30)_U_DT_U_"Create Zip Code FIPS code Xref"
 S ^XTMP("EAS1192H",0)=$$FMADD^XLFDT(DT,30)_U_DT_U_"Duplicate FIPS not filed"
 N EASGMT,EASCNTR,EASCNT,EASJ,EASRECA,EASRECR,EASDATA,EASMSG,EASADD,EASX,EASNODE
 S EASRECA=0,EASRECR=0
 S EASCNTR="" F  S EASCNTR=$O(^XTMP("EAS1192","DATA",2020,EASCNTR)) Q:'EASCNTR  D
 .S EASGMT("YEAR")=3200000
 .S EASGMT("COUNTY NAME")=$$UP^XLFSTR($P(^XTMP("EAS1192","DATA",2020,EASCNTR),U,2))
 .S EASGMT("STATE")=$P(^XTMP("EAS1192","DATA",2020,EASCNTR),U)
 .S EASGMT("MSA")=$P(^XTMP("EAS1192","DATA",2020,EASCNTR),U,4)
 .I EASGMT("MSA")=10000 S EASGMT("MSA")=0
 .F EASCNT=1:1:8 S EASGMT("THR"_EASCNT)=$P(^XTMP("EAS1192","DATA",2020,EASCNTR),U,(EASCNT+4))
 .S EASGMT("STATE")=$E("00",1,2-$L(EASGMT("STATE")))_EASGMT("STATE")
 .S EASGMT("FIPS")=$P(^XTMP("EAS1192","DATA",2020,EASCNTR),U,3)
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
 ..S ^XTMP("EAS1192H",EASRECR)=EASNODE_"^"_$G(EASERR)
 S EASMSG(1)="Number of records added: "_EASRECA
 S EASMSG(2)="Number of duplicate records: "_EASRECR
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
 ; Example: To add a record in subfile 2.0361 in the record with ien=353
 ; with the field .01 value = 21:
 ; S EASDATA(.01)=21,EASENDA(1)=353 I $$FILE^EAS1192(2.0361,.EASENDA,.EASDATA) W!,"DONE"
 ;
 ; Example: If creating a record not in a subfile, would look like this:
 ; S EASDATA(.01)=21 I $$FILE^EAS1192(867,,.EASDATA) W !,"DONE"
 ;
 N EASFDA,EASFLD,EASIENA,EASIENS,EASERRS,EASIEN,DIERR
 ;
 ;EASIENS - Internal Entry Number String defined by FM
 ;EASIENA - the Internal Entry Numebr Array defined by FM
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
