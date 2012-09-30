VAFCTFU ;ALB/JLU-UTILITIES FOR THE TREATING FACILITY FILE 391.91 ; 5/23/12 12:58pm
 ;;5.3;Registration;**149,240,261,255,316,392,440,428,474,520,697,800,821,837,856**;Aug 13, 1993;Build 5
 ;
 ;Reference to EXC^RGHLLOG and STOP^RGHLLOG supported by IA #2796
 ;Reference to $$UPDATE^ MPIFAPI supported by IA #2706
 ;
 ;CHKSUB & GETSCN line tags removed, patch DG*5.3*697
 ;Subscriptions are no longer used and errors are being
 ;generated when attempting to add a subscription.
 ;
FILETF(PAT,INST) ;programmer entry point.
 ;INPUT   PAT - This is the patient's ICN
 ;       INST - This is the IEN of the institution or Treating Facility
 ;it also contains the date of treatment in FM format.  It is to be
 ;stored in an array structure to allow for multiple treating
 ;facilities.
 ;  EX.   X(1)=500^2960101
 ;        x(2)=425^2960202
 ;
 ;OUTPUT  0 (ZERO) If no errors
 ;        1^error description if there was an error.
 ;
 N PDFN,LP,VAFCER,X
 S VAFCER=0
 I '$G(PAT)!('$D(INST)) S VAFCER="1^Parameter missing." G FILETFQ
 I $D(@INST)<10 S VAFCER="1^Institution array not populated." G FILETFQ
 S X="MPIF001" X ^%ZOSF("TEST") I '$T G FILETFQ
 S PDFN=$$GETDFN^MPIF001(PAT)
 I PDFN<0 S VAFCER="1^No patient DFN." G FILETFQ
 N FSTRG
 F LP=0:0 S LP=$O(@INST@(LP)) Q:'LP  D FILE(PDFN,@INST@(LP))
 ;
FILETFQ Q VAFCER
 ;
 ; both the SET & QUERYTF subroutines have been moved to VAFCTFU1 as
 ; the result of DG*5.3*261  *261 gjc@120899
 ;
FILE(PDFN,FSTRG,TICN,VAFCSLT,ERROR,IPP,SOURCEID,IDENSTAT,AA,IDTYP) ;this module files the individual entry
 ;W KKKKK
 ;PDFN is the patient's DFN
 ;FSTRG = institution or treating facility^Date of treatment^Event reason
 ;TICN - if 1 suppress add entries to ADT HL7 PIVOT (#391.71) file
 ;VAFCSLT - (optional) if 1 suppress exception logging and return error in the ERROR array
 ;ERROR - (optional) 
 ;Ex  500^2960202^A1
 ;
 N X,Y,TMPFLG
 I $G(VAFCSLT)="" S VAFCSLT=0
 S X="MPIF001" X ^%ZOSF("TEST") Q:'$T
 S X="MPIFQ0" X ^%ZOSF("TEST") Q:'$T
 N TFIEN,PDLT,FAC,EVNTR,VAFCER,CMOR,ICN,STA,ECNT
 S ECNT=1
 S FAC=$P(FSTRG,U,1),PDLT=$P(FSTRG,U,2),EVNTR=$P(FSTRG,U,3)
 S STA=$$STA^XUAF4(FAC)
 ;
 I '$$FIND1^DIC(4,"","MX","`"_FAC) D  Q
 . I 'VAFCSLT D EXC^RGHLLOG(212,"Msg#"_$G(HL("MID"))_" unknown Institution IEN "_FAC_" passed into TF update.",PDFN) D STOP^RGHLLOG(1) Q
 . I VAFCSLT S ERROR(STA)="Update of "_STA_" Failed at "_$P($$SITE^VASITE,"^",3)_" due to unknown Institution IEN "_FAC_" passed into TF update."
 I PDLT'="" K %DT S %DT="T" S X=PDLT D ^%DT K %DT I Y<0 S VAFCER="1^Not a FM date." D  Q
 .I 'VAFCSLT D EXC^RGHLLOG(212,"TF updated in msg#"_$G(HL("MID"))_" for Institution IEN "_FAC_" but with invalid date "_PDLT_" for DFN "_PDFN,PDFN)
 .I VAFCSLT S ERROR(STA)="Update of "_STA_" Failed at "_$P($$SITE^VASITE,"^",3)_" due to invalid date "_PDLT_" for DFN "_PDFN
 ;**856 - MVI 1371 (ckn)
 ;Default assigning authority and Id type if not passed in as parameter
 I $$GET1^DIQ(4,FAC_",",13,"E")'="OTHER" D
 . I $G(AA)="" S AA="USVHA"
 . I $G(IDTYP)="" S IDTYP="PI"
 I $$STA^XUAF4(FAC)="200DOD" S AA="USDOD",IDTYP="NI"
 ;Quit if incoming values are null for Source ID, AA, ID Type and Identifier Status. We do not want to create or update entry.
 ;I $G(SOURCEID)="",$G(IDENSTAT)="",$G(AA)="",$G(IDTYP)="" Q
 ;removed code for adding local ICN's
 S ICN=+$$MPINODE^MPIFAPI(PDFN)
 ;**837 - MVI_791 (ckn) - Loop through all existing entries for TF to decide to update or add after comparing incoming values.
 ;S TFIEN=$O(^DGCN(391.91,"APAT",PDFN,FAC,0)) D
 S TMPFLG=0
 S TFIEN=0 F  S TFIEN=$O(^DGCN(391.91,"APAT",PDFN,FAC,TFIEN)) Q:+TFIEN=0!(TMPFLG)  D
 .;TFIEN is used in other places so quit after adding new entry
 .;**837 - MVI_791 (ckn)
 .I 'TFIEN Q
 .N TMPAA,TMPIDTYP,TMPSID,TMPIDST
 .;GET EXISTING FIELDS TO COMPARE WITH INCOMING VALUES
 .S TMPAA=$P($G(^DGCN(391.91,TFIEN,2)),"^") ;Existing Assigning Authority
 .S TMPIDTYP=$P($G(^DGCN(391.91,TFIEN,0)),"^",9) ;Existing IDtype
 .S TMPSID=$P($G(^DGCN(391.91,TFIEN,2)),"^",2) ;Existing Source ID
 .S TMPIDST=$P($G(^DGCN(391.91,TFIEN,2)),"^",3) ;Existing Identifier Status
 .;NOW COMPARE INCOMING FIELDS AND EXISTING FIELDS TO DETERMINE UNIQUE ENTRY
 .I TMPAA=$G(AA),TMPIDTYP=$G(IDTYP),TMPSID=$G(SOURCEID),TMPIDST=$G(IDENSTAT) S TMPFLG=1
 .I TMPFLG D FILEDIT(TFIEN,PDLT,PDFN,FAC,EVNTR,VAFCSLT,.ERROR,$G(IPP),$G(SOURCEID),$G(IDENSTAT),$G(AA),$G(IDTYP))
 I 'TMPFLG D FILENEW(PDFN,FAC,PDLT,EVNTR,VAFCSLT,.ERROR,$G(IPP),$G(SOURCEID),$G(IDENSTAT),$G(AA),$G(IDTYP)) Q
 ;look to see if CMOR is in TF list if not add
 ;S CMOR=$$GETVCCI^MPIF001(PDFN)
 ;S CMOR=$$LKUP^XUAF4(CMOR) ; **520 REMOVED +
 ;check to see if CMOR exist if not add it
 ;MVI-791 (ckn) - no need to check for CMOR and add new
 ;I +$G(CMOR)>0 D:'$D(^DGCN(391.91,"APAT",PDFN,CMOR)) FILENEW^VAFCTFU(PDFN,CMOR)
 ;create the entry in the pivot to broadcast the MFU.
 ; Note: we will not broadcast to the MFU if the TFL record
 ; has an event reason. See comments in FILEDIT. *261 gjc@120199
 I $G(TICN)'=1,$P($$SEND^VAFHUTL,"^",2)>0 D SETSND(PDFN)
FILEQ Q
 ;
FILENEW(PDFN,FAC,PDLT,EVNTR,VAFCSLT,ERROR,IPP,SOURCEID,IDENSTAT,AA,IDTYP) ;
 N DGSENFLG ;**240 added y
 K DD,DO,DIC,DA,RESULT
 S DGSENFLG=""
 N FDA,FDAIEN,ERR S ERR=""
 I $G(EVNTR)'="" D CHK^DIE(391.91,.07,"",EVNTR,.RESULT) I +RESULT>0 S EVNTR=RESULT
 S FDA(1,391.91,"+1,",.01)=PDFN
 S FDA(1,391.91,"+1,",.02)=FAC
 S FDA(1,391.91,"+1,",.03)=$G(PDLT)
 S FDA(1,391.91,"+1,",.07)=$G(EVNTR)
 S FDA(1,391.91,"+1,",.08)=$G(IPP)
 ;**837 - MVI_791 (ckn)
 S FDA(1,391.91,"+1,",10)=$G(AA) ;Assigning Authority
 S FDA(1,391.91,"+1,",.09)=$G(IDTYP) ;Source Id Type
 S FDA(1,391.91,"+1,",11)=$G(SOURCEID) ;Source ID
 S FDA(1,391.91,"+1,",12)=$G(IDENSTAT) ;Identifier Status
 L +^DGCN(391.91,0):30
 D UPDATE^DIE("","FDA(1)","FDAIEN","ERR") I $D(ERR("DIERR",1)) S ERROR(STA)="Add of "_STA_" Failed at "_$P($$SITE^VASITE,"^",3)_" due to "_$G(ERR("DIERR",1,"TEXT",1))
 ;**837 (ckn) - MVI_791 - No more Source ID multiple
 ;I $G(SOURCEID)'="",$G(FDAIEN(1))'="" D UPDSID(PDFN,FAC,SOURCEID,IDENSTAT,FDAIEN(1))  ;Update SourceID multiple
 ;removed code to add a subscription
 L -^DGCN(391.91,0)
 K DIC,DD,DO,DA
 Q
 ;
UPDSID(PDFN,FAC,SID,IDSTAT,TFIEN) ;Update sourceid multiple
 N FDA,DGENDA,FILE,IENS
 S FILE=391.9101
 I $D(^DGCN(391.91,TFIEN,1,"B",SID)) D  Q  ;Update existing sub record
 . S DGENDA=$O(^DGCN(391.91,TFIEN,1,"B",SID,0))
 . S DGENDA(1)=TFIEN,IENS=$$IENS^DILF(.DGENDA)
 . S FDA(FILE,IENS,.01)=SID,FDA(FILE,IENS,1)=IDSTAT
 . D FILE^DIE("K","FDA","ERRORS(1)")
 ;add new sub record
 S DGENDA="+1",DGENDA(1)=TFIEN,IENS=$$IENS^DILF(.DGENDA)
 S FDA(FILE,IENS,.01)=SID,FDA(FILE,IENS,1)=IDSTAT
 D UPDATE^DIE("","FDA","IENA","ERRORS(1)")
 Q
SETSND(PDFN) ;sets the pivot file entry to send MFU
 ;
 N ANS,X
 S X="MPIF001" X ^%ZOSF("TEST") Q:'$T
 ; check if other facilities other than CMOR in TF list
 N SIT,CMOR,STOP
 S CMOR=$$GETVCCI^MPIF001(PDFN)
 S CMOR=$$LKUP^XUAF4(CMOR) ; **520 REMOVED +
 I CMOR=$P($$SITE^VASITE,"^") D
 .S SIT=0
 .S SIT=$O(^DGCN(391.91,"APAT",PDFN,SIT))
 .I SIT=CMOR S SIT=$O(^DGCN(391.91,"APAT",PDFN,SIT)) I SIT="" S STOP=""
 I $D(STOP) QUIT
 S ANS=$$PIVNW^VAFHPIVT(PDFN,DT,5,PDFN_";DPT(")
 I 'ANS QUIT
 D XMITFLAG^VAFCDD01(0,+ANS,0)
SETSNDQ Q
 ;
FILEDIT(TFIEN,PDLT,PDFN,FAC,EVNTR,VAFCSLT,ERROR,IPP,SOURCEID,IDENSTAT,AA,IDTYP) ;
 N DGSENFLG,FDA,FDAIEN,ERR,RESULT S DGSENFLG="",ERR=""
 I $G(PDLT)'=""!($G(IPP)'="")!($G(AA)'="")!($G(IDTYP)'="")!($G(SOURCEID)'="")!($G(IDENSTAT)'="") D
 .S TFIEN(0)=$G(^DGCN(391.91,TFIEN,0))
 .I $G(EVNTR)'="" D CHK^DIE(391.91,.07,"",EVNTR,.RESULT) I +RESULT>0 S EVNTR=RESULT
 .I $G(PDLT)'="" S FDA(1,391.91,+TFIEN_",",.03)=$G(PDLT)
 .S FDA(1,391.91,+TFIEN_",",.07)=$G(EVNTR)
 .I $G(IPP)'="" S FDA(1,391.91,+TFIEN_",",.08)=$G(IPP)
 .;**837 - MVI_791 (ckn)
 .I $G(AA)'="" S FDA(1,391.91,+TFIEN_",",10)=$G(AA)
 .I $G(IDTYP)'="" S FDA(1,391.91,+TFIEN_",",.09)=$G(IDTYP)
 .I $G(SOURCEID)'="" S FDA(1,391.91,+TFIEN_",",11)=$G(SOURCEID)
 .I $G(IDENSTAT)'="" S FDA(1,391.91,+TFIEN_",",12)=$G(IDENSTAT)
 .D FILE^DIE("K","FDA(1)","ERR") I VAFCSLT I $D(ERR("DIERR",1)) S ERROR(STA)="Edit of "_STA_" Failed at "_$P($$SITE^VASITE,"^",3)_" due to "_$G(ERR("DIERR",1,"TEXT",1))
 ;**837 - MVI_791 (ckn) - no more updates to multiples
 ;I $G(SOURCEID)'="" D UPDSID(PDFN,FAC,SOURCEID,IDENSTAT,TFIEN)
 ;remove code to add a subscription
 Q
 ;
DELETETF(PAT,INST,DTIEN) ;deletion entry point
 ;This entry point is used to delete a single Treating Facility from
 ;the Treating Facility list.
 ;**837 - MVI_791 (ckn) - Now we will have multiple entries in TF file so it is determined which entry to be deleted before calling this api. Hence, Treating Facility IEN is passed in. Unused code is commented out.
 ;INPUT  PAT - the ICN of the patient.
 ;       INST - the IEN of the institution to be deleted.
 ;       DTIEN - the IEN of Treating Facility file
 ;OUTPUT  0 (zero) - If no errors
 ;        1^error description if there was a problem
 ;
 ;**837 v4 MVI 791 (ckn) - check if DTIEN is passed
 I $G(DTIEN)="" Q "-1^DTIEN - IEN of Treating Facility not defined"
 N VAFCER,PDFN,TFIEN,X,VAFCSCN,LINK,VAFCLLN,IEN
 S VAFCER=0
 I '$G(PAT)!('$G(INST)) S VAFCER="1^Parameter missing." S ERROR(INST)="212"_"^"_$G(HL("MID"))_"^"_"Delete Failed: "_$P(VAFCER,"^") G DELTFQ
 S X="MPIF001" X ^%ZOSF("TEST") I '$T G FILETFQ
 S PDFN=$$GETDFN^MPIF001(+PAT)
 I PDFN<0 S VAFCER="1^No patient DFN." G FILETFQ
 I '$$FIND1^DIC(4,"","MX","`"_INST) S VAFCER="1^Not an Institution IEN." G DELTFQ
 I '$D(^DGCN(391.91,DTIEN)) S VAFCER="1^Could not find Treating Facility." G DELTFQ
 D DELETE(DTIEN)
 I $D(^DGCN(391.91,DTIEN)) S VAFCER="1^DIK failed to delete entry" G DELTFQ
 ;terminate the subscription if there is one
 S VAFCSCN=+$P($$MPINODE^MPIFAPI(PDFN),"^",5) I +$G(VAFCSCN)>0 D
 .;get logical link
 . D LINK^HLUTIL3(INST,.LINK) S VAFCLLN=$O(LINK(0)) I +$G(VAFCLLN)>0 S VAFCLLN=LINK(VAFCLLN) D UPD^HLSUB(VAFCSCN,VAFCLLN,0,,$$NOW^XLFDT,,.HLER)
 ;**837 - MVI_791 (ckn) - no need to retire pdr anymore as it is not used
 ;D RETPDR^VAFCEHU2(PDFN,INST) ;**474 retire pdr when deleting tf
DELTFQ Q VAFCER
 ;
DELETE(TFIEN) ;the actual deletion code
 ;
 K DIK,DA
 S DIK="^DGCN(391.91,"
 S DA=TFIEN
 D ^DIK K DIK,DA
 Q
 ;
DELALLTF(PAT) ;Entry point to delete all Treating Facilities for a single
 ;patient.
 ;INPUT  PAT - The patient's ICN
 ;OUTPUT 0 (zero) - If no errors
 ;       1^error description if an error
 ;
 N VAFCER,PDFN,LP,TFIEN,X
 S VAFCER=0
 I '$G(PAT) Q "1^Parameter missing."
 S X="MPIF001" X ^%ZOSF("TEST") I '$T Q 0
 S PDFN=$$GETDFN^MPIF001(PAT)
 I PDFN<0 Q "1^No patient DFN."
 F LP=0:0 S LP=$O(^DGCN(391.91,"APAT",PDFN,LP)) Q:LP'>0  D
 . S TFIEN=0
 . F  S TFIEN=$O(^DGCN(391.91,"APAT",PDFN,LP,TFIEN)) Q:TFIEN'>0  D DELETE(TFIEN)
 ;
 Q VAFCER
 ;
