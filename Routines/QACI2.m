QACI2 ; OAKOIFO/TKW - DATA MIGRATION - BUILD SUPPORTING TABLE AND ROC DATA TO MIGRATE ;1/24/07  17:14
 ;;2.0;Patient Representative;**19**;07/25/1995;Build 55
EN ; Main entry point for building both legacy supporting table data
 ; and ROC data to be migrated. Skip entries that have already
 ; been migrated.
 ;
 I $P($G(^XTMP("QACMIGR","AUTO","C")),"^",2)=1 W !!,"*** CAUTION! Another user is trying to auto-close ROCs. Allow the process to",!,"finish before moving data. ***"
 ; Make sure list of valid sites has been downloaded from the EMC
 I '$D(^XTMP("QACMIGR","STDINSTITUTION")) D STAERR Q
 I '$D(^XTMP("QACMIGR","AUTO","C")) W !!,"** No Contacts were Auto-Closed. **"
 Q:$$ASK^QACI2A("")'=1
 ; If called from ^QACI0 (pre-migration error report), QACI0 will be set to 1.
 N QACI0 S QACI0=0
 ; Kill Taskman task that rolls up data to Austin for VSSC reports, Put Patient Rep menus OUT OF ORDER
 I '$$EN1^QACI5 Q
 ;
EN0 ; Entry point from ^QACI0 (Just check for errors, don't save data to staging area for migration)
 ; If called from ^QACI0, QACI0 will be set to 1.
 ; 
 ; Get QA Site Parameter station number, and VISN Name
 N PARENT,VISNNAME D PARVISN^QACI2A(.PARENT,.VISNNAME)
 I VISNNAME="" W !!,"QA Site Parameter Station Number or VISN cannot be found!" Q
 I $L(PARENT)'=3 W !!,"QA Site Parameter Station Number not 3 digits!" Q
 ;
 N TYPE,ROCIEN,ROC0,ROC2,ROC7,ROCNO,OLDROC,CONDATE,DFN,STATION,INFOBY,ENTBY,CC,EMPINV,FSOS,ROCISS,ISSIEN,PATSDT,HL,CE,MOC,MOCSTR,TS,PHONE,PHDESC,PATID,RESDATE,INTAPPL
 N CURRDT,EDITEBY,EDITIBY,EDITDIV,EDITITXT,EDITRTXT,ITXTCNT,ITXTLN,ELIGSTAT,CATEGORY,CCNAME,PATSDUZ2,DOTCNT,PATSCNT,PATSERR,SRVRSTA,RLUPSTAT,QACDIV,DIK,DA,I,X
 ; PATSDT will be current date in a format Oracle will recognize
 S CURRDT=$$DT^XLFDT()
 S PATSDT=$$FMTE^XLFDT(CURRDT,5)
 ; Set header node for migration data. Data will be automatically purged in 30 days.
 S $P(^XTMP("QACMIGR",0),"^",1,2)=$$FMADD^XLFDT(CURRDT,30)_"^"_CURRDT
 S DOTCNT=199
 ; Kill existing lists of data to be migrated and set counters to 0.
 F TYPE="ROC","HL","USER","PT","CC","EMPINV","FSOS" D
 . K ^XTMP("QACMIGR",TYPE,"U"),^("E")
 . S PATSCNT(TYPE)=0 Q
 ; Retrieve and save station data (IA #1518)
 D  I SRVRSTA="" W !!,"Server Station Number cannot be found!" Q
 . S SRVRSTA=$$STA^XUAF4(+$$GET1^DIQ(8989.3,1,217,"I")) Q:SRVRSTA=""
 . ; load list of divisions from MEDICAL CENTER DIVISION file for error checking
 . F I=0:0 S I=$O(^DG(40.8,I)) Q:'I  S X=$P($G(^(I,0)),"^",7) S:X QACDIV(X)=""
 . ; Quit if only running CHK option.
 . Q:QACI0
 . ; Put VISN and Computing facility data from QAC SITE PARAMETERS into output global
 . ; for ROC and Facility Service or Section.
 . S ^XTMP("QACMIGR","FSOS","U",0)=VISNNAME
 . S ^XTMP("QACMIGR","ROC","U",0)=VISNNAME_"^"_PARENT_"^"_SRVRSTA
 . ; Save computing station number for server in ROC and User nodes
 . S ^XTMP("QACMIGR","USER","U",0)=SRVRSTA
 . S ^XTMP("QACMIGR","EMPINV","U",0)=SRVRSTA Q
 I SRVRSTA'=PARENT W !!,"QA Site Parameter Station Number not the same as Computing Station!" Q
 ; Build mapping lists for contacting_entity, method_of_contact, treatment_status.
 D CEMOCTS^QACI2A
 ; Build temporary list of valid Migrated Issue Codes
 I '$G(^XTMP("QACMIGR","ISS","D")) D BLDISS^QACI2A
 ;
 ; Build Reference Tables Lists for Congressional Contact
 D BLDCC^QACI2A(PARENT,.PATSCNT)
 ;
 ;
 ; Read through ROCs, check for errors, and if QACI0'=1 move data to staging area.
 D ^QACI20
 ; If not called from ^QACI0, update the counts of migrated data.
 I 'QACI0 D UPDCNT^QACI2E(.PATSCNT)
 ; Update the counts of errors.
 D UPDERRCT^QACI2E
 ; Print error report
 D ERRPT^QACI2E(QACI0)
 Q
 ;
ENLDSTA(PATSBY,QACSLIST) ; Load list of stations from sdsadm.std_institution table
 ; PATSBY is set to 1 if this runs to completion, to 0 otherwise.
 ; QACSLIST is an input array of station numbers
 S PATSBY=0
 I $O(QACSLIST(""))="" Q
 K ^XTMP("QACMIGR","STDINSTITUTION")
 ; Set header node for migration data. Data will be automatically purged in 30 days.
 I '$D(^XTMP("QACMIGR")) D
 . N CURRDT S CURRDT=$$DT^XLFDT()
 . S $P(^XTMP("QACMIGR",0),"^",1,2)=$$FMADD^XLFDT(CURRDT,30)_"^"_CURRDT
 . Q
 N I,QACSTA S I=""
 F  S I=$O(QACSLIST(I)) Q:I=""  S QACSTA=QACSLIST(I) D:QACSTA]""
 . S ^XTMP("QACMIGR","STDINSTITUTION",QACSTA)=""
 . Q
 S PATSBY=1
 Q
 ;
STAERR ; Display error if national stations not downloaded from EMC
 W !!,"*** You must first run the option to download the list of nationally ***",!
 W "*** recognized stations. See the PATS Data Migration Guide. ***" Q
 ;   
 ;
