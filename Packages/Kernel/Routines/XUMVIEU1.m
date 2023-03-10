XUMVIEU1 ;MVI/CKN - Master Veteran Index Enrich New Person ; 1/22/21 5:05pm
 ;;8.0;KERNEL;**744**;Jul 10, 1995;Build 1
 ;Per VA Directive 6402, this routine should not be modified.
 ;**744,Story VAMPI_3039 (ckn): New routine
 ;
SETFDA(IEN,XUARR,FDA) ;Set FDA from XUARR for filing into File #200
 N IENS,WHO,VAL
 S WHO=$G(XUARR("WHO"))
 S IENS=+IEN_","
 ;
 ;DEGREE
 S:$D(XUARR("DEGREE"))#2 FDA(200,IENS,10.6)=$$TRIM^XLFSTR(XUARR("DEGREE"))
 ;
 ;Subject Organization and ID
 D:$G(XUARR("SubjectOrgan"),"<undef>")=""!($G(XUARR("SubjectOrganID"),"<undef>")="") SUBJDEF^XUMVIENU(.XUARR)
 S:$D(XUARR("SubjectOrgan"))#2 FDA(200,IENS,205.2)=XUARR("SubjectOrgan")
 S:$D(XUARR("SubjectOrganID"))#2 FDA(200,IENS,205.3)=XUARR("SubjectOrganID")
 ;
 ;GENDER
 S:$D(XUARR("GENDER"))#2 FDA(200,IENS,4)=XUARR("GENDER")
 ;
 ;ADDRESS DATA
 D:$D(XUARR("ADDRESS DATA"))#2
 . N ADDR,STR1,STR2,STR3,CITY,STATE,ZIP,OPHN,FAX
 . S ADDR=XUARR("ADDRESS DATA")
 . S STR1=$P(ADDR,"|"),STR2=$P(ADDR,"|",2),STR3=$P(ADDR,"|",3)
 . S CITY=$P(ADDR,"|",4),STATE=$P(ADDR,"|",5),ZIP=$P(ADDR,"|",6)
 . S OPHN=$P(ADDR,"|",7),FAX=$P(ADDR,"|",8)
 . I $L(ZIP)=9,ZIP'["-" S ZIP=$E(ZIP,1,5)_"-"_$E(ZIP,6,9)
 . S FDA(200,IENS,.111)=$E(STR1,1,$$MAXLEN^XUMVIENU(200,.111))
 . S FDA(200,IENS,.112)=$E(STR2,1,$$MAXLEN^XUMVIENU(200,.112))
 . S FDA(200,IENS,.113)=$E(STR3,1,$$MAXLEN^XUMVIENU(200,.113))
 . S FDA(200,IENS,.114)=$E(CITY,1,$$MAXLEN^XUMVIENU(200,.114))
 . S FDA(200,IENS,.115)=$$STATEIEN^XUMVIENU(STATE)
 . S FDA(200,IENS,.116)=ZIP
 . S FDA(200,IENS,.132)=OPHN
 . S FDA(200,IENS,.136)=FAX
 ;
 ;Tax ID
 S:$D(XUARR("TaxID"))#2 FDA(200,IENS,53.92)=XUARR("TaxID")
 ;
 ;Termination
 S:$D(XUARR("Termination"))#2 FDA(200,IENS,9.2)=XUARR("Termination")
 ;Inactivate
 S:$D(XUARR("Inactivate"))#2 FDA(200,IENS,53.4)=XUARR("Inactivate")
 ;
 ;Remarks
 I $G(XUARR("Remarks"))="",WHO="200PIEV" D
 .I $P($G(^VA(200,+IEN,"PS")),U,9)="" S XUARR("Remarks")="NON-VA PROVIDER"
 .E  K XUARR("Remarks")
 S:$D(XUARR("Remarks"))#2 FDA(200,IENS,53.9)=$E(XUARR("Remarks"),1,$$MAXLEN^XUMVIENU(200,53.9))
 ;
 ;Title
 I $G(XUARR("Title"))="",WHO="200PIEV" D
 .I $P($G(^VA(200,+IEN,0)),U,9)="" S XUARR("Title")="NON-VA PROVIDER"
 .E  K XUARR("Title")
 D:$D(XUARR("Title"))#2
 . ;Add Title to TITLE file (#3.1) if not already there
 . N DIERR,DIHELP,DIMSG,XUMSG
 . S XUARR("Title")=$E($$UP^XLFSTR(XUARR("Title")),1,$$MAXLEN^XUMVIENU(200,8))
 . D:$$FIND1^DIC(3.1,"","X",XUARR("Title"),"","","XUMSG")'>0
 .. N TITLEFDA
 .. S TITLEFDA(3.1,"+1,",.01)=XUARR("Title")
 .. D UPDATER^XUMVIENU(.TITLEFDA,"E",.XURET)
 . S FDA(200,IENS,8)=XUARR("Title")
 ;
 ;Authorized to Write Med Orders
 D:$D(XUARR("AuthWriteMedOrders"))#2
 . S VAL=$$UP^XLFSTR(XUARR("AuthWriteMedOrders")) S:VAL=0!(VAL="N")!(VAL="NO") VAL=""
 . S FDA(200,IENS,53.1)=VAL
 ;
 ;Provider Class
 S:$D(XUARR("ProviderClass"))#2 FDA(200,IENS,53.5)=XUARR("ProviderClass")
 ;
 ;Non VA Prescriber
 I WHO="200PIEV",$G(XUARR("NonVAPrescriber"))="" S FDA(200,IENS,53.91)=1
 E  S:$D(XUARR("NonVAPrescriber"))#2 FDA(200,IENS,53.91)=XUARR("NonVAPrescriber")
 ;
 ;Provider Type
 D:$D(XUARR("ProviderType"))#2
 . N PROVTYPE
 . S PROVTYPE=$P(XUARR("ProviderType"),"|")
 . S:PROVTYPE="" PROVTYPE=$P(XUARR("ProviderType"),"|",2)
 . S FDA(200,IENS,53.6)=PROVTYPE
 ;
 ;SECID
 S:$D(XUARR("SECID"))#2 FDA(200,IENS,205.1)=XUARR("SECID")
 ;Unique User ID
 S:$D(XUARR("UniqueUserID"))#2 FDA(200,IENS,205.4)=XUARR("UniqueUserID")
 ;ADUPN (Email)
 S:$D(XUARR("ADUPN"))#2 FDA(200,IENS,205.5)=XUARR("ADUPN")
 ;EMAIL ADDRESS
 S:$D(XUARR("EMAIL"))#2 FDA(200,IENS,.151)=XUARR("EMAIL")
 ;Network Username
 S:$D(XUARR("NTUSERNAME"))#2 FDA(200,IENS,501.1)=XUARR("NTUSERNAME")
 Q
 ;
CPRSNVA(IEN,XUARR,OLDTDATE) ;**744 - VAMPI-3039 (ckn)
 ;CPRS TAB
 N IENS,ORDIEN,CPRSEXP,NVAIEN,FDA,NEWTDATE
 S IENS=+IEN_","
 S NEWTDATE=$P($G(^VA(200,IEN,0)),U,11) ;Termination Date
 I NEWTDATE]"" Q  ;Quit as Terminated record
 ;
 S ORDIEN=$O(^ORD(101.13,"B","NVA","")) Q:ORDIEN=""
 ;ADD - If CPRS TAB field does not have date for "NVA", add new record in CPRS TAB multiple field
 I '$D(^VA(200,+IEN,"ORD","B",ORDIEN)) D  Q
 .S FDA(200.010113,"+1,"_IENS,.01)="NVA"
 .S FDA(200.010113,"+1,"_IENS,.02)=$$DT^XLFDT()
 .I $G(XUARR("Inactivate"))'="" S FDA(200.010113,"+1,"_IENS,.03)=$G(XUARR("Inactivate"))
 .D UPDATE^DIE("E","FDA")
 .K FDA
 ;
 ;UPDATE - Existing CPRS TAB field for "NVA" AND Termination date is deleted in this update,
 ;Update CPRS TAB multiple field and Quit
 S NVAIEN=$O(^VA(200,+IEN,"ORD","B",ORDIEN,"")),CPRSEXP=$P($G(^VA(200,+IEN,"ORD",NVAIEN,0)),"^",3)
 I OLDTDATE]"",NEWTDATE="" D  Q
 .S FDA(200.010113,NVAIEN_","_IENS,.02)=$$DT^XLFDT()
 .S FDA(200.010113,NVAIEN_","_IENS,.03)=$S($G(XUARR("Inactivate"))'="":$G(XUARR("Inactivate")),1:"@")
 .D FILE^DIE("E","FDA")
 .K FDA
 ;
 ;UPDATE - Existing CPRS TAB field for "NVA" and No Termination Date
 ;Update only Expiration Date if Inactivation is sent AND it is different than existing
 I $G(XUARR("Inactivate"))'="" D
 .I CPRSEXP'="",(XUARR("Inactivate")=$$FMTHL7^XLFDT(CPRSEXP)) Q
 .S FDA(200.010113,NVAIEN_","_IENS,.03)=$G(XUARR("Inactivate"))
 .D FILE^DIE("E","FDA")
 .K FDA
 Q
