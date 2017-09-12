MAGIP138 ;WOIFO/PMK,NST,MAT - Install code for MAG*3.0*138 (DIX) ; 31 Jul 2013  12:20 PM
 ;;3.0;IMAGING;**138**;Mar 19, 2002;Build 5380;Sep 03, 2013
 ;; Per VHA Directive 2004-038, this routine should not be modified.
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; | Use of unreleased versions of this software requires the user |
 ;; | to execute a written test agreement with the VistA Imaging    |
 ;; | Development Office of the Department of Veterans Affairs,     |
 ;; | telephone (301) 734-0100.                                     |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a medical device.  As such, it may not be changed in any way. |
 ;; | Modifications to this software may result in an adulterated   |
 ;; | medical device under 21CFR820, the use of which is considered |
 ;; | to be a violation of US Federal Statutes.                     |
 ;; +---------------------------------------------------------------+
 ;;
 ; There are no environment checks here but the MAGIP138 has to be
 ; referenced by the "Environment Check Routine" field of the KIDS
 ; build so that entry points of the routine are available to the
 ; KIDS during all installation phases.
 Q
 ;
 ;+++++ INSTALLATION ERROR HANDLING
ERROR ;
 S:$D(XPDNM) XPDABORT=1
 ;--- Display the messages and store them to the INSTALL file
 D DUMP^MAGUERR1(),ABTMSG^MAGKIDS()
 Q
 ;
 ;***** PRE-INSTALL CODE
PRE ;
 N DA,DIK
 D CONVERT1
 ;--- P130
 ; Image Never Existed Status added to field 113 in 2005
 S DIK="^DD(2006.1,",DA=113,DA(1)=2005 D ^DIK
 ; Image Never Existed Status added to field 113 in 2005.1
 S DIK="^DD(2006.1,",DA=113,DA(1)=2005.1 D ^DIK
 Q
 ;
 ;***** POST-INSTALL CODE
POS ;
 N CALLBACK,MENU
 D CLEAR^MAGUERR(1)
 ;
 ;=== RPC REGISTRATION ===
 ;
 ;--- P79 Link new remote procedures to context option MAG DICOM VISA.
 S CALLBACK="$$ADDRPCS^"_$NA(MAGKIDS1("RPCL079^"_$T(+0),"MAG DICOM VISA"))
 I $$CP^MAGKIDS("MAG ATTACH RPCS P79",CALLBACK)<0 D ERROR Q
 ;
 ;--- P110 Link new remote procedures to the Broker context option.
 S CALLBACK="$$ADDRPCS^"_$NA(MAGKIDS1("RPCL110^"_$T(+0),"MAG WINDOWS"))
 I $$CP^MAGKIDS("MAG ATTACH RPCS P110 WIN",CALLBACK)<0  D ERROR  Q
 ;
 ;--- P130 Link new remote procedures to context option MAG WINDOWS.
 S CALLBACK="$$ADDRPCS^"_$NA(MAGKIDS1("RPCL130^"_$T(+0),"MAG WINDOWS"))
 I $$CP^MAGKIDS("MAG ATTACH RPCS P130",CALLBACK)<0  D ERROR  Q
 ;
 ;--- P136 Link new remote procedures to context option MAG DICOM VISA.
 S CALLBACK="$$ADDRPCS^"_$NA(MAGKIDS1("RPCL136V^"_$T(+0),"MAG DICOM VISA"))
 I $$CP^MAGKIDS("MAG ATTACH RPCS P136",CALLBACK)<0 D ERROR  Q
 ;
 ;--- P137 Link new remote procedures to context option MAG DICOM VISA.
 S CALLBACK="$$ADDRPCS^"_$NA(MAGKIDS1("RPCL137V^"_$T(+0),"MAG DICOM VISA"))
 I $$CP^MAGKIDS("MAG ATTACH RPCS P137",CALLBACK)<0 D ERROR  Q
 ;
 ;--- P138 Link new remote procedures to context option MAGTP WORKLIST MGR.
 S CALLBACK="$$ADDRPCS^"_$NA(MAGKIDS1("RPCL138V^"_$T(+0),"MAGTP WORKLIST MGR"))
 I $$CP^MAGKIDS("MAG ATTACH RPCS P138",CALLBACK)<0 D ERROR  Q
 ;
 ;=== Various Updates ===
 ;
 ;--- P79 Add WORKLIST entry.
 S CALLBACK="$$ADDWRKLS^MAGI138O()"
 I $$CP^MAGKIDS("MAG ADD WORKLIST ENTRY",CALLBACK)<0 D ERROR Q
 ;
 ;--- P79 Add MAG WORK ITEM STATUS entries.
 S CALLBACK="$$ADDSTATS^MAGI138O()"
 I $$CP^MAGKIDS("MAG ADD WORK ITEM STATUS",CALLBACK)<0 D ERROR Q
 ;
 ;--- P79 Add StorageCommit entry to the MAG WORK ITEM SUBTYPE file.
 S CALLBACK="$$ADDSUBTP^MAGI138O()"
 I $$CP^MAGKIDS("MAG ADD WORK ITEM SUBTYPE",CALLBACK)<0 D ERROR Q
 ;
 ;--- P110 Update Driver
 I $$CP^MAGKIDS("MAG P110 UPDATE","$$UPD110^"_$T(+0))<0  D ERROR  Q
 ;
 ;--- P130 Various Updates
 I $$CP^MAGKIDS("MAG P130 UPDATE","$$UPD130^MAGI138O()")<0  D ERROR  Q
 ;
 ;--- P138TP Various Updates
 I $$CP^MAGKIDS("MAG TP UPDATE","$$UPD138^MAGI138O()")<0 D ERROR  Q  ;UPD138
 ;
 ;--- Menu addition
 ; Edit CLINICAL SPECIALTY DICOM & HL7 file
 S MENU=$$ADD^XPDMENU("MAGD DICOM MENU","MAGD EDIT CLIN SPEC DICOM/HL7","ECS",99)
 I MENU'=1 D MES^MAGKIDS("MAGD DICOM MENU option MAGD EDIT CLIN SPEC DICOM/HL7 not installed: "_MENU)
 ;
 ; Print DICOM Object Output File Status
 S MENU=$$ADD^XPDMENU("MAGD DICOM MENU","MAGD PRINT DICOM OBJECT EXPORT","EXP",99)
 I MENU'=1 D MES^MAGKIDS("MAGD DICOM MENU option MAGD PRINT DICOM OBJECT EXPORT not installed: "_MENU)
 ;
 D DELRTNS^MAGI138O
 ; Delete MAGI138O
 D
 . N X,DEL
 . S X="MAGI138O"
 . S DEL=^%ZOSF("DEL")
 . X DEL
 . D MES^MAGKIDS(""""_X_""" routine has been deleted.")
 . Q
 ;--- Send the notification e-mail
 D BMES^XPDUTL("Post Install Mail Message: "_$$FMTE^XLFDT($$NOW^XLFDT))
 D INS^MAGQBUT4(XPDNM,DUZ,$$NOW^XLFDT,XPDA)
 Q
 ;
 ;+++++ Various updates
UPD110() ;
 ;
 D CONVERT2
 D NEW7792
 D NEW7794
 D ENTRYACT("MAGD RECEIVE EVENTS","D ^MAGDHOWC") ; CPRS Consult Request Tracking
 D ENTRYACT("MAGD APPOINTMENT","D ^MAGDHOWS") ; SDAM Scheduling/Appointment Management
 D ADTSUBS
 D MAILUPDT
 Q 0
 ;
MAILUPDT ; Add the mail group and subject for MAGDHOW* processing errors
 D BMES^XPDUTL("Add CPRS DICOM & HL7 Mail Message group to the Mail Group file: "_$$FMTE^XLFDT($$NOW^XLFDT))
 D ADDMG ; Add CPRS DICOM & HL7 Mail Message group to the Mail Group file (XMB(3.8)
 D BMES^XPDUTL("Add Message Subject for Mail Management to Site Parameters - with interval: "_$$FMTE^XLFDT($$NOW^XLFDT))
 D ADDMS(0) ; Add Message Subject for Mail Management to Site Parameters - with interval
 D BMES^XPDUTL("Add CPRS DICOM & HL7 Mail groups to BP Message subfile: "_$$FMTE^XLFDT($$NOW^XLFDT))
 D DLKP ; Add CPRS DICOM & HL7 Mail groups to BP Message subfile 
 Q
 ;
CONVERT1 ; convert file 2006.5831 to the new global format - don't build indices
 N CLINCNT,CLINIC,CLINIEN,CPTIEN,DIK,HL7SUBLIST,IPROCIDX,ISPECIDX
 N LOCATION,NEWIEN,OLDIEN,PROCEDURE,SERVICE,X,Y
 ;
 I $G(^MAG(2006.5831,0))?1"CLINICAL SPECIALTY DICOM & HL7".E D  Q
 . D MES^MAGKIDS("Conversion to the new format has already been performed.")
 . Q
 ;
 L +^MAG(2006.5831):1E9
 ;
 D MES^MAGKIDS("Converting DICOM HEALTHCARE PROVIDER SERVICE file (#2006.5831) to new format.")
 ;
 K ^TMP("MAG",$J,"P110")
 ;
 S (NEWIEN,OLDIEN)=0
 F  S OLDIEN=$O(^MAG(2006.5831,OLDIEN)) Q:'OLDIEN  D
 . S NEWIEN=NEWIEN+1
 . S X=^MAG(2006.5831,OLDIEN,0)
 . S SERVICE=$P(X,"^",1),ISPECIDX=$P(X,"^",2),LOCATION=$P(X,"^",3)
 . S (PROCEDURE,IPROCIDX,HL7SUBLIST,CPTIEN)=""
 . S Y=SERVICE_"^"_PROCEDURE_"^"_ISPECIDX_"^"_IPROCIDX_"^"_LOCATION_"^"_CPTIEN_"^"_HL7SUBLIST
 . S ^TMP("MAG",$J,"P110",NEWIEN,0)=Y
 . S (CLINCNT,CLINIEN)=0 F  S CLINIEN=$O(^MAG(2006.5831,SERVICE,1,CLINIEN)) Q:'CLINIEN  D
 . . S CLINCNT=CLINCNT+1,CLINIC=^MAG(2006.5831,SERVICE,1,CLINIEN,0)
 . . S ^TMP("MAG",$J,"P110",NEWIEN,1,CLINCNT,0)=CLINIC
 . . Q
 . I CLINCNT S ^TMP("MAG",$J,"P110",NEWIEN,1,0)="^2006.58311^"_CLINCNT_"^"_CLINCNT
 . Q
 S ^TMP("MAG",$J,"P110",0)="CLINICAL SPECIALTY DICOM & HL7^2006.5831P^"_NEWIEN_"^"_NEWIEN
 S DIK="^MAG(2006.5831,"
 D ENALL2^DIK  ; Delete all cross-reference
 L -^MAG(2006.5831)
 ;
 ; Delete DICOM HEALTHCARE PROVIDER SERVICE file (#2006.5831) 
 D DELFILE^MAGKIDS(2006.5831,"DE","")
 Q
 ;
CONVERT2 ; restore the new file 2006.5831 and build cross-references
 N DIK
 ;
 I $G(^MAG(2006.5831,0))?1"CLINICAL SPECIALTY DICOM & HL7".E,$P(^(0),"^",4) D  Q
 . D MES^MAGKIDS("Conversion to the new format has already been performed.")
 . Q
 ;
 ; Update file #2006.5831 security here because of the FileMan bug
 N SECURITY
 S SECURITY("AUDIT")="@"
 S SECURITY("DD")="@"
 S SECURITY("DEL")="@"
 S SECURITY("LAYGO")="@"
 S SECURITY("RD")="@"
 S SECURITY("WR")="@"
 D FILESEC^DDMOD(2006.5831,.SECURITY)  ; supported ICR #2916
 ;
 L +^MAG(2006.5831):1E9
 K ^MAG(2006.5831)
 M ^MAG(2006.5831)=^TMP("MAG",$J,"P110")
 K ^TMP("MAG",$J,"P110")
 S DIK="^MAG(2006.5831," D IXALL^DIK ; create all the cross-references
 D MES^MAGKIDS("Conversion to CLINICAL SPECIALTY DICOM & HL7 file (#2006.5831) complete.")
 L -^MAG(2006.5831)
 Q
 ;
NEW7792 ; create the MAGD SENDER entry in the HLO APPLICATION REGISTRY (file 779.2)
 N DESCRIPTION,DIC,DIERR,I,IENS,MAGERR,MAGFDA,MAGIENS,NAME,PACKAGE,OWNER,X,Y
 ;
 S NAME="MAGD SENDER"
 ;
 ; check to see if <NAME> already exists
 S DIC=779.2,DIC(0)="BX",X=NAME D ^DIC
 I Y>0 D  Q
 . D MES^MAGKIDS(""""_NAME_""" already exists in the HLO APPLICATION REGISTRY.")
 . Q
 ;
 ; get package file number for IMAGING
 S DIC=9.4,DIC(0)="BX",X="IMAGING" D ^DIC
 I Y=-1 D  Q
 . D MES^MAGKIDS("""IMAGING"" does not exist in the PACKAGE file (#9.4).")
 . Q
 S PACKAGE=+Y
 ;
 S IENS="+1,"
 S MAGFDA(779.2,IENS,.01)=NAME        ; APPLICATION NAME
 S MAGFDA(779.2,IENS,2)=PACKAGE       ; PACKAGE FILE LINK
 D UPDATE^DIE("","MAGFDA","MAGIENS","MAGERR")
 I $D(DIERR) D  Q
 . D MES^MAGKIDS("Error in creating """_NAME_""" in the HLO APPLICATION REGISTRY.")
 . F I=1:1 Q:'$D(MAGERR("DIERR",1,"TEXT",I))  D
 . . D MES^MAGKIDS(MAGERR("DIERR",1,"TEXT",I))
 . . Q
 . Q
 Q
 ;
NEW7794 ; create the entries in the HLO SUBSCRIPTION REGISTRY (file 779.4)
 N DESCRIPTION,NAME,OWNER
 ;
 ; create the MAGD ADT entry
 S NAME="MAGD ADT"
 S DESCRIPTION="ADT subscription list for clinical specialty systems"
 S OWNER="MAGD (ADT)"
 D NEW7794A(NAME,DESCRIPTION,OWNER)
 ;
 ; create the MAGD DEFAULT entry
 S NAME="MAGD DEFAULT"
 S DESCRIPTION="Default subscription list for CPRS consults & procedures"
 S OWNER="MAGD (Imaging Default)"
 D NEW7794A(NAME,DESCRIPTION,OWNER)
 ;
 Q
 ;
NEW7794A(NAME,DESCRIPTION,OWNER) ; create the entry in file 779.4
 N DIC,DIERR,I,IENS,MAGERR,MAGFDA,MAGIENS,X,Y
 ;
 ; check to see if <NAME> already exists
 S DIC=779.4,DIC(0)="BX",X=NAME D ^DIC
 I Y>0 D  Q
 . D MES^MAGKIDS(""""_NAME_""" already exists in the HLO SUBSCRIPTION REGISTRY.")
 . Q
 ;
 S IENS="+1,"
 S MAGFDA(779.4,IENS,.01)=NAME        ; NAME
 S MAGFDA(779.4,IENS,.02)=OWNER       ; OWNER
 S MAGFDA(779.4,IENS,.03)=DESCRIPTION ; DESCRIPTION
 D UPDATE^DIE("","MAGFDA","MAGIENS","MAGERR")
 I $D(DIERR) D  Q
 . D MES^MAGKIDS("Error in creating """_NAME_""" in the HLO SUBSCRIPTION REGISTRY.")
 . F I=1:1 Q:'$D(MAGERR("DIERR",1,"TEXT",I))  D
 . . D MES^MAGKIDS(MAGERR("DIERR",1,"TEXT",I))
 . . Q
 . Q
 Q
 ;
ENTRYACT(PROTOCOL,ACTION) ; update the protocol's ENTRY ACTION
 N DIC,IENS,MAGERR,MAGFDA,MAGIENS,X,Y
 S DIC=101,DIC(0)="BX",X=PROTOCOL D ^DIC
 I Y=-1 D  Q
 . D MES^MAGKIDS("Error in updating protocol "_X_" - it is not defined.")
 . Q
 S IENS=+Y_","
 S MAGFDA(101,IENS,20)=ACTION        ; ENTRY ACTION
 D UPDATE^DIE("","MAGFDA","MAGIENS","MAGERR")
 I $D(DIERR) D  Q
 . D MES^MAGKIDS("Error in updating protocol "_X_".")
 . F I=1:1 Q:'$D(MAGERR("DIERR",1,"TEXT",I))  D
 . . D MES^MAGKIDS(MAGERR("DIERR",1,"TEXT",I))
 . . Q
 . Q
 Q
 ;
ADTSUBS ; add new subscribers to MAG CPACS A01 - A13 ADT event drives
 ;
 D ADTSUBS1("A01","inpatient admission")
 D ADTSUBS1("A02","patient transfer")
 D ADTSUBS1("A03","patient discharge")
 D ADTSUBS1("A11","admission cancellation")
 D ADTSUBS1("A12","transfer cancellation")
 D ADTSUBS1("A13","discharge cancellation")
 ;
 Q
 ;
ADTSUBS1(EVENT,TYPE) ; add one subscriber
 N DESCRIPTION,EVENTDRIVER,EVENTDRIVERIEN,ITEMTEXT,SUBSCRIBER,SUBSCRIBERIEN
 N DIC,IENS,MAGERR,MAGFDA,MAGIENS,X,Y
 ;
 S EVENTDRIVER="MAG CPACS "_EVENT,SUBSCRIBER=EVENTDRIVER_" SUBS-HLO"
 S ITEMTEXT="Routes "_TYPE_"s using HLO"
 S DESCRIPTION(1)="This protocol routes "_TYPE_" messages"
 S DESCRIPTION(2)="a commercial PACS using the HL7 Optimized package."
 ;
 ;
 ; first, find the event driver protocol - it must exist
 S DIC=101,DIC(0)="BX",X=EVENTDRIVER D ^DIC
 I Y=-1 D  Q
 . D MES^MAGKIDS("Error in updating protocol "_X_" - it is not defined.")
 . Q
 S EVENTDRIVERIEN=+Y
 ;
 ;
 ; second, find the HLO subscriber protocol - it shouldn't exist
 S DIC=101,DIC(0)="BX",X=SUBSCRIBER D ^DIC
 I Y'=-1 D  Q
 . D MES^MAGKIDS("Note: Updating protocol "_X_" - it is already defined.")
 . Q
 ;
 ;
 ; third, create the HLO subscriber protocol
 S IENS="+1,"
 S MAGFDA(101,IENS,.01)=SUBSCRIBER           ; NAME
 S MAGFDA(101,IENS,1)=ITEMTEXT               ; ITEM TEXT
 S MAGFDA(101,IENS,3.5)="DESCRIPTION"        ; DESCRIPTION (wp field)
 S MAGFDA(101,IENS,4)="S"                    ; TYPE (subscriber)
 S MAGFDA(101,IENS,5)=DUZ                    ; CREATOR
 S MAGFDA(101,IENS,99)=$H                    ; TIMESTAMP
 S MAGFDA(101,IENS,770.2)="MAGD-CLIENT"      ; RECEIVING APPLICATION <------------------------
 S MAGFDA(101,IENS,770.3)="ADT"              ; TRANSACTION MESSAGE TYPE
 S MAGFDA(101,IENS,770.4)=EVENT              ; EVENT TYPE
 S MAGFDA(101,IENS,770.11)="ACK"             ; RESPONSE MESSAGE TYPE
 S MAGFDA(101,IENS,771)="D ENTRY^MAGDHOWA"   ; PROCESSING ROUTINE
 D UPDATE^DIE("","MAGFDA","MAGIENS","MAGERR")
 I $D(DIERR) D  Q
 . D MES^MAGKIDS("Error in updating subscriber protocol "_X_".")
 . F I=1:1 Q:'$D(MAGERR("DIERR",1,"TEXT",I))  D
 . . D MES^MAGKIDS(MAGERR("DIERR",1,"TEXT",I))
 . . Q
 . Q
 S SUBSCRIBERIEN=MAGIENS(1)
 ;
 ; fourth, add the new HLO subscriber to the event driver protocol
 S IENS="+2,"_EVENTDRIVERIEN_","
 S MAGFDA(101.0775,IENS,.01)=SUBSCRIBERIEN
 D UPDATE^DIE("","MAGFDA","MAGIENS","MAGERR")
 I $D(DIERR) D  Q
 . D MES^MAGKIDS("Error in updating event driver protocol "_X_".")
 . F I=1:1 Q:'$D(MAGERR("DIERR",1,"TEXT",I))  D
 . . D MES^MAGKIDS(MAGERR("DIERR",1,"TEXT",I))
 . . Q
 . Q
 Q
 ;
 ; code to handle adding a mail message for MAGDHOW* errors
 ;
ADDMS(INTERVAL) ; Add Message Subjects for Mail Management
 N I,J,K,MAGFDA,MSG,IEN,MAGERR
 S IEN=0
 F  S IEN=$O(^MAG(2006.1,IEN)) Q:'IEN  D
 . F J=1:1:1 S K=$P($T(TEXT+J),";",3) D
 . . Q:$D(^MAG(2006.1,IEN,6,"B",K))  ; Do not re-configure
 . . S MAGFDA(2006.166,"?+1,"_IEN_",",.01)=K
 . . S MAGFDA(2006.166,"?+1,"_IEN_",",1)=INTERVAL
 . . D UPDATE^DIE("","MAGFDA","","MAGERR")
 . . I $D(DIERR) D BMES^XPDUTL("Error updating the BP Mail Message Subfile: "_MAGERR("DIERR",1,"TEXT",1)) K DIERR,MAGERR
 . . Q
 . Q
 Q
ADDMG ; Add Mail Message groups to the Mail Group file (XMB(3.8))
 N PL,NMSP
 S PL=0
 F  S PL=$O(^MAG(2006.1,PL)) Q:'PL  D
 . S NMSP=$P($G(^MAG(2006.1,PL,0)),U,2)
 . Q:NMSP=""
 . D ADD(NMSP)
 . D ADDDUZ(NMSP)
 . Q
 Q 
ADD(NMSP) ;
 N J,K,L,MAGFDA,MSG,IEN,MAGIEN,MAGERR
 F J=1:1:1 S K=$P($T(TEXT+J),";",3) D
 . I '$D(^XMB(3.8,"B","MAG_"_NMSP_"_"_$E($$TRIM^MAGQBUT4(K),1,20))) D
 . . S L=$O(^XMB(3.8,"B","MAG_"_NMSP_"_"_$E($$TRIM^MAGQBUT4(K),1,20),""))
 . . S MAGFDA(3.8,"?+"_J_",",.01)="MAG_"_NMSP_"_"_$E($$TRIM^MAGQBUT4(K),1,20)
 . . D UPDATE^DIE("","MAGFDA","MAGIEN","MAGERR")
 . . I $D(DIERR) D BMES^XPDUTL("Error Adding Imaging Mail Groups: "_MAGERR("DIERR",1,"TEXT",1)) K DIERR,MAGERR,MAGFDA Q
 . . K MAGFDA,DIERR,MAGERR
 . . S MAGFDA(3.8,MAGIEN(J)_",",4)="PU"
 . . D FILE^DIE("I","MAGFDA","MAGERR")
 . . K DIERR,MAGERR,MAGFDA,MAGIEN
 . . Q
 . Q
 Q
 ;
ADDDUZ(NMSP) ;
 N J,K,L,MAGFDA,MSG,IEN,MAGIEN,MAGERR
 F J=1:1:1 S K=$P($T(TEXT+J),";",3) D
 . S L=$O(^XMB(3.8,"B","MAG_"_NMSP_"_"_$E($$TRIM^MAGQBUT4(K),1,20),""))
 . S MAGFDA(3.81,"?+1,"_L_",",.01)=DUZ
 . D UPDATE^DIE("","MAGFDA","MAGIEN","MAGERR")
 . I $D(DIERR) D BMES^XPDUTL("Error Adding Imaging Mail Group member: "_MAGERR("DIERR",1,"TEXT",1))
 . K DIERR,MAGERR,MAGFDA,MAGIEN
 Q
 ;
DLKP ; Add Generic Mail groups to BP Message subfile
 N PL,I,J,MAGFDA,MSGROOT,MG,DIERR,MAGIEN,MAGERR,NMSP
 S PL=0
 F  S PL=$O(^MAG(2006.1,PL)) Q:'PL  D
 . S I=0,NMSP=$P($G(^MAG(2006.1,PL,0)),U,2)
 . Q:NMSP=""
 . F  S I=$O(^MAG(2006.1,PL,6,I)) Q:'I  D
 . . S MG=$P($G(^MAG(2006.1,PL,6,I,0)),"^",1)
 . . S J=$$FIND1^DIC(3.8,"","","MAG_"_NMSP_"_"_$E($$TRIM^MAGQBUT4(MG),1,20),"","","MSGROOT")
 . . Q:$D(^MAG(2006.1,PL,6,I,1,"B",J))  ; Do not re-configure
 . . I J  D
 . . . S MAGFDA(2006.1662,"+1,"_I_","_PL_",",.01)=J
 . . . D UPDATE^DIE("","MAGFDA","MAGIEN","MAGERR")
 . . . I $D(DIERR) D BMES^XPDUTL("Error Adding Generic Mail Groups: "_MAGERR("DIERR",1,"TEXT",1)) K DIERR,MAGERR
 . . . Q
 . . Q
 . Q
 K MAGFDA,MSGROOT,MAGIEN,MSGROOT
 Q
TEXT ; Message Subjects
 ;;CPRS_DICOM_and_HL7
 Q
 ;+++++ LIST OF NEW REMOTE PROCEDURES
 ; have a list in format ;;MAG4 IMAGE LIST
RPCL110 ;
 ;;MAG3 TELEREADER CPT CODELOOKUP
 Q
RPCL130 ;
 ;;MAG GET DICOM QUEUE LIST
 ;;MAG SEND IMAGE
 ;;MAGV CREATE WORK ITEM
 ;;MAGV GET WORK ITEM
 ;;MAGV GET NEXT WORK ITEM
 ;;MAGV FIND WORK ITEM
 ;;MAGV UPDATE WORK ITEM
 ;;MAGV ADD WORK ITEM TAGS
 ;;MAGV DELETE WORK ITEM
 Q
 ;
RPCL079 ;
 ;;MAG DICOM CHECK AE TITLE
 ;;MAG DICOM GET AE ENTRY
 ;;MAG DICOM GET AE ENTRY LOC
 ;;MAGVC WI DELETE
 ;;MAGVC WI GET
 ;;MAGVC WI LIST
 ;;MAGVC WI SUBMIT NEW
 ;;MAGVC WI UPDATE STATUS
 Q
 ;
RPCL136V ;
 ;;MAGV GET RAD DX CODES
 ;;MAGV GET RAD IMAGING LOCATIONS
 ;;MAGV GET RAD STD RPTS
 ;;MAGV GENERATE DICOM UID
 Q
 ;
RPCL137V ;
 ;;MAGV GET IRRADIATION DOSE
 ;;MAGV ATTACH IRRADIATION DOSE
 Q
 ;
RPCL138V ;
 ;;MAGTP GET ACTIVE
 ;;MAGTP GET CASES
 ;;MAGTP GET CPRS REPORT
 ;;MAGTP GET NOTE
 ;;MAGTP GET PREFERENCES
 ;;MAGTP GET RETENTION DAYS
 ;;MAGTP GET SLIDES
 ;;MAGTP GET USER
 ;;MAGTP PUT NOTE
 ;;MAGTP PUT PREFERENCES
 ;;MAGTP RESERVE CASE
 ;;MAGTP SET RETENTION DAYS
 ;;MAGTP USER
 ;;MAGG GET TIMEOUT
 ;;MAGG INSTALL
 ;;MAGG PAT INFO
 ;;MAGG VERIFY ESIG
 ;;MAGGUPREFGET
 ;;MAGGUPREFSAVE
 ;;MAGGUSERKEYS
 ;;MAG BROKER SECURITY
 ;;VAFCTFU CONVERT DFN TO ICN
 ;;VAFCTFU CONVERT ICN TO DFN
 ;;DG SENSITIVE RECORD ACCESS
 ;;DG SENSITIVE RECORD BULLETIN
 ;;XWB CREATE CONTEXT
 ;;MAG3 SET TIMEOUT
 ;;MAGGHSLIST
 ;;MAGGHS
 Q
 ;
 ; MAGIP138
