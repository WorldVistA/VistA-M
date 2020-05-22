XUMVIENU ;MVI/CKN,MKO - Master Veteran Index Enrich New Person ;29 Jan 2020  11:24 AM
 ;;8.0;KERNEL;**711,724**;Jul 10, 1995;Build 2
 ;Per VA Directive 6402, this routine should not be modified.
 ;**711,Story 977838 (mko/ckn): New routine
 ;Entry point: UPDATE^XUMVIENU(XURET,.XUARR,XUFLAG)
 ; called from rpc: XUS MVI ENRICH NEW PERSON
 ;
 ; Input:
 ;   XUARR(subscript)=value to update
 ;   XUFLAG = "A" : if RPC is being called to add a record to the New Person file
 ;            "U" : if RPC is being called to edit an existing New Person file record.
 ;
 ; Return Parameter:
 ;   On success:
 ;     DUZ of New Person File entry edited or added
 ;       Returned if there were no issues adding or editing the entry.
 ;
 ;     DUZ^-1^errorMessage
 ;       Returned if entry was edited, but some data was not valid and could
 ;       not be filed.
 ;
 ;   On failure:
 ;     -1^errorMessage
 ;       Returned for example if required data was not passed, entry could
 ;       not be added when FLAG="A", or entry could not be found based on
 ;       the NPI when FLAG="U".
 ;
UPDATE(XURET,XUARR,XUFLAG) ;RPC to enrich New Pperson file entry
 N XUDBSEQ
 S XUDBSEQ=$$RECORD(.XUARR,$G(XUFLAG))
 D PROC(.XURET,.XUARR,.XUFLAG)
 D RETURN(XUDBSEQ,XURET)
 Q
 ;
PROC(XURET,XUARR,XUFLAG) ;Main code for RPC
 N FDA,OLDTDATE,XUDUZ
 K XURET
 ;
 ;Check inputs
 S XURET=$$CHKINPUT(.XUARR,.XUFLAG)
 Q:XURET<0
 ;
 ;Add or get New Person IEN in XUDUZ
 S XURET=""
 I $G(XUFLAG)="A" D
 . ;Call entry point to add the record
 . D:$G(XUARR("SubjectOrgan"))=""!($G(XUARR("SubjectOrganID"))="") SUBJDEF(.XUARR)
 . S XUDUZ=$$ADDUSER^XUMVINPA(.XUARR)
 . I XUDUZ<0 S XURET=XUDUZ ;If error, we'll return -1^errorMessage
 . E  I $P(XUDUZ,U,3)=1 S XUDUZ=+XUDUZ ;If record was added, set XUDUZ to new IEN
 . E  S XURET=+XUDUZ ;If record was found, not added, we'll just return DUZ -- no edit will take place
 E  D
 . ;Lookup user based on NPI
 . ;S XATTRIB(8)=XUARR("NPI") ; NPI
 . ;S XUDUZ=$$FINDUSER^XUESSO2(.XATTRIB) ; find user based on NPI ; returns -1^Not authorized if DUZ("LOA")<2
 . S XUDUZ=$O(^VA(200,"ANPI",XUARR("NPI"),0))
 . S:XUDUZ'>0 XURET="-1^User with NPI "_XUARR("NPI")_" not found."
 ;
 ;If add or lookup above set XURET, we're done
 Q:XURET]""
 ;
 ;Update the NAME first. (Within a FILE^DIE call, triggers on the .01 that in turn call FILE^DIE
 ;may cause the Filer flag to change from "E", to "".)
 I $G(XUFLAG)'="A",$D(XUARR("NAME"))#2 D
 . N NAME
 . S NAME=$P($G(XUARR("NAME")),"|",5)
 . S:NAME="" NAME=$$FMNAME^HLFNC($G(XUARR("NAME")),"|")
 . I NAME]"" S FDA(200,+XUDUZ_",",.01)=NAME D FILER(.FDA,"E",.XURET)
 ;
 ;Set up FDA
 D SETFDA(XUDUZ,.XUARR,.FDA)
 ;
 ;Remove Termination Date from FDA if it's in the future
 D TERMDATE(.FDA,.XURES)
 ;
 ;Save the original Termination Date
 S OLDTDATE=$P($G(^VA(200,XUDUZ,0)),U,11)
 ;
 ;Call the Filer
 D FILER(.FDA,"E",.XURET)
 ;
 ;If Termination Date was added or deleted, remove or add Security keys PROVIDER and XUORES
 D SECKEYS(XUDUZ,OLDTDATE,.XURET)
 ;
 ;File the Person Class data
 D PERSCLAS(XUDUZ,.XUARR,.XURET)
 ;
 ;File the DEA data
 I $$PATCH^XPDUTL("XU*8.0*688"),$$VFIELD^DILFD(200,53.21),$$VFILE^DILFD(8991.9) D
 . ;File NEW DEA #'S in multiple and add/edit entries in File #8991.9
 . D NEWDEA(XUDUZ,.XUARR,.XURET)
 . ;File first NEW DEA data into single-valued fields of NP file
 . D NPDEA(XUDUZ,.XUARR,.XURET)
 E  D
 . ;File first valid DEA # into file (NEW DEA#'s multiple doesn't exist)
 . D FIRSTDEA(XUDUZ,.XUARR,.XURET)
 ;
 ;Return DUZ in first piece. If errors, also return -1^errMsg in 2nd and 3rd pieces.
 S XURET=XUDUZ_$S(XURET<0:U_XURET,1:"")
 Q
 ;
CHKINPUT(XUARR,XUFLAG) ;Check inputs
 ;Returns: "-1^errorMsg" if problem; otherwise return 0
 Q:'$D(XUARR) "-1^No data passed"
 Q:$G(XUARR("NPI"))="" "-1^Missing NPI"
 Q:'$$CHKDGT^XUSNPI($G(XUARR("NPI"))) "-1^NPI is not valid"
 Q:$G(XUARR("WHO"))="" "-1^Missing requesting Station number"
 ;
 S:$G(XUFLAG)="" XUFLAG="U"
 Q:"^A^U^"'[(U_$G(XUFLAG)_U) "-1^Invalid flag "_XUFLAG_" was passed."
 Q 0
 ;
SETFDA(IEN,XUARR,FDA) ;Set FDA from XUARR for filing into File #200
 N IENS,WHO
 S WHO=$G(XUARR("WHO"))
 S IENS=+IEN_","
 ;
 ;DEGREE
 S:$D(XUARR("DEGREE"))#2 FDA(200,IENS,10.6)=$$TRIM^XLFSTR(XUARR("DEGREE"))
 ;
 ;Subject Organization and ID
 D:$G(XUARR("SubjectOrgan"),"<undef>")=""!($G(XUARR("SubjectOrganID"),"<undef>")="") SUBJDEF(.XUARR)
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
 . S FDA(200,IENS,.111)=$E(STR1,1,$$MAXLEN(200,.111))
 . S FDA(200,IENS,.112)=$E(STR2,1,$$MAXLEN(200,.112))
 . S FDA(200,IENS,.113)=$E(STR3,1,$$MAXLEN(200,.113))
 . S FDA(200,IENS,.114)=$E(CITY,1,$$MAXLEN(200,.114))
 . S FDA(200,IENS,.115)=$$STATEIEN(STATE)
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
 I $G(XUARR("Remarks"))="",WHO="200PIEV",$P($G(^VA(200,+IEN,"PS")),U,9)="" S XUARR("Remarks")="NON-VA PROVIDER"
 S:$D(XUARR("Remarks"))#2 FDA(200,IENS,53.9)=$E(XUARR("Remarks"),1,$$MAXLEN(200,53.9))
 ;
 ;Title
 I $G(XUARR("Title"))="",WHO="200PIEV",$P($G(^VA(200,+IEN,0)),U,9)="" S XUARR("Title")="NON-VA PROVIDER"
 D:$D(XUARR("Title"))#2
 . ;Add Title to TITLE file (#3.1) if not already there
 . N DIERR,DIHELP,DIMSG,XUMSG
 . S XUARR("Title")=$E($$UP^XLFSTR(XUARR("Title")),1,$$MAXLEN(200,8))
 . D:$$FIND1^DIC(3.1,"","X",XUARR("Title"),"","","XUMSG")'>0
 .. N TITLEFDA
 .. S TITLEFDA(3.1,"+1,",.01)=XUARR("Title")
 .. D UPDATER(.TITLEFDA,"E",.XURET)
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
SUBJDEF(XUARR) ;Set default Subject Organization and ID
 S XUARR("SubjectOrgan")="Department Of Veterans Affairs"
 S XUARR("SubjectOrganID")="urn:oid:2.16.840.1.113883.4.349"
 Q
 ;
TERMDATE(FDA,XURES) ;Remove Termination Date from FDA if it's in the future,
 ;or if Termination Date is passed but user has a Primary Menu, and return an error message
 N IENS,TDATE
 S IENS=$O(FDA(200,"")) Q:IENS=""
 Q:"@"[$G(FDA(200,IENS,9.2))
 ;
 ;Get internal form
 S TDATE=$$GETINT(200,9.2,FDA(200,IENS,9.2)) Q:TDATE=U
 ;
 I $P($G(^VA(200,+IENS,201)),U)]"" D  Q
 . D ADDERR(.XURET,"User has a PRIMARY MENU and cannot be terminated.")
 . K FDA(200,IENS,9.2)
 ;
 ;Remove from FDA if it's a future date, and add an error message
 D:TDATE>DT
 . D ADDERR(.XURET,"TERMINATION DATE '"_FDA(200,IENS,9.2)_"' is in the future.")
 . K FDA(200,IENS,9.2)
 Q
 ;
SECKEYS(XUDUZ,OLDTDATE,XURET) ;Add or remove Security Keys PROVIDER and XUORES
 ;based on whether Termination Date is deleted or created
 N KEY,KEYIEN,NEWTDATE
 S XUDUZ=+$G(XUDUZ),OLDTDATE=$G(OLDTDATE)
 S NEWTDATE=$P($G(^VA(200,XUDUZ,0)),U,11)
 Q:$G(OLDTDATE)=NEWTDATE
 ;
 F KEY="PROVIDER","XUORES" D
 . S KEYIEN=$O(^DIC(19.1,"B",KEY,0)) Q:KEYIEN'>0
 . I OLDTDATE="",NEWTDATE]"" D
 .. ;Delete the key
 .. N DA,DIK
 .. S DA=$O(^VA(200,XUDUZ,51,"B",KEYIEN,0)) Q:DA'>0
 .. S DA(1)=XUDUZ,DIK="^VA(200,"_XUDUZ_",51,"
 .. D ^DIK
 . E  I OLDTDATE]"",NEWTDATE="" D
 .. ;Add the key
 .. ;**724,Story 1209890 (mko): The #.01 of the KEYS multiple is DINUM'd, so pass IEN(1).
 .. ;  Also, GIVEN BY (#1) and DATE GIVEN (#2) are triggered by the #.01.
 .. N IENS,FDA,IEN
 .. Q:$O(^VA(200,XUDUZ,51,"B",KEYIEN,0))
 .. S IENS="+1,"_XUDUZ_","
 .. S (FDA(200.051,IENS,.01),IEN(1))=KEYIEN
 .. D UPDATER(.FDA,"",.XURET,.IEN)
 Q
 ;
PERSCLAS(XUDUZ,XUARR,XURET) ;Update PERSON CLASS multiple
 N CNT,CURVAL,D0,FDA,IEN,IENS,NEWVAL,PCIEN,VACODE,X12CODE
 S CNT=0 F  S CNT=$O(XUARR("PersonClass",CNT)) Q:'CNT  D
 . S X12CODE=$G(XUARR("PersonClass",CNT,"PersonClass")) Q:X12CODE=""
 . ;
 . ;Lookup the Person Class entry in the multiple
 . S PCIEN=0
 . S VACODE=$S(X12CODE="207LP3000X":"V110403",X12CODE="2084B0040X":"V182914",X12CODE="390200000X":"V115500",1:"") I VACODE'="" S PCIEN=$O(^USC(8932.1,"F",VACODE,0)) ;to resolve duplicate x12 codes
 . I 'PCIEN S PCIEN=$O(^USC(8932.1,"G",X12CODE,0))
 . S IEN=$O(^VA(200,+XUDUZ,"USC1","B",+PCIEN,0))
 . ;
 . ;If not found, add it
 . I IEN'>0 D  Q:IEN'>0
 .. S FDA(200.05,"+1,"_+XUDUZ_",",.01)=PCIEN ;now passing internal value of X12CODE
 .. S IEN=$$UPDATER(.FDA,"",.XURET)
 . ;
 . ;Update the other values in the Person Class multiple
 . S IENS=+IEN_","_+XUDUZ_","
 . S CURVAL=$P($G(^VA(200,+XUDUZ,"USC1",+IEN,0)),U,2)
 . S NEWVAL=$G(XUARR("PersonClass",CNT,"PersonClassActive"))
 . I NEWVAL="",'$$ISPCACTV(XUDUZ,IEN) S FDA(200.05,IENS,2)="TODAY",FDA(200.05,IENS,3)="@"
 . E  I NEWVAL]"" S FDA(200.05,IENS,2)=NEWVAL
 . S:$D(XUARR("PersonClass",CNT,"PersonClassExpire"))#2 FDA(200.05,IENS,3)=XUARR("PersonClass",CNT,"PersonClassExpire")
 . S D0=+XUDUZ ;Needed by input transform of Effective Date (200.05,2)
 . D FILER(.FDA,"E",.XURET)
 Q
 ;
ISPCACTV(XUDUZ,SUBIEN) ;Is the Person Class active?
 N EFFDT,EXPDT,ND
 S ND=$G(^VA(200,+$G(XUDUZ),"USC1",+$G(SUBIEN),0)) Q:ND="" 0
 S EFFDT=$P(ND,U,2),EXPDT=$P(ND,U,3)
 I EFFDT,DT'<EFFDT,DT'>EXPDT Q 1
 Q 0
 ;
NEWDEA(XUDUZ,XUARR,XURET) ;Update DEA NUMBERS File #8991.9
 ;and the NEW PERSON File NEW DEA #'s multiple
 N CNT,DEA,DIERR,DIHELP,DIMSG,FDA,IEN,IENS,NDEAIEN,XUERR
 N STR1,STR2,STR3,CITY,STATE,ZIP
 ;
 ;Get address parts
 D:$D(XUARR("ADDRESS DATA"))#2
 . S ADDR=XUARR("ADDRESS DATA")
 . S STR1=$E($P(ADDR,"|"),1,$$MAXLEN(8991.9,1.2))
 . S STR2=$E($P(ADDR,"|",2),1,$$MAXLEN(8991.9,1.3))
 . S STR3=$E($P(ADDR,"|",3),1,$$MAXLEN(8991.9,1.4))
 . S CITY=$E($P(ADDR,"|",4),1,$$MAXLEN(8991.9,1.5))
 . S STATE=$P(ADDR,"|",5)
 . S ZIP=$TR($P(ADDR,"|",6),"-")
 ;
 S CNT=0 F  S CNT=$O(XUARR("DEA",CNT)) Q:'CNT  D
 . S DEA=$G(XUARR("DEA",CNT,"DEA"))
 . Q:DEA=""
 . ;
 . ;Lookup or add a record to File #8991.9 with the passed DEA #
 . S NDEAIEN=$O(^XTV(8991.9,"B",DEA,0))
 . I NDEAIEN'>0 D  Q:NDEAIEN'>0
 .. K FDA
 .. S IENS="+1,"
 .. S FDA(8991.9,IENS,.01)=DEA
 .. S FDA(8991.9,IENS,10.2)="NOW"
 .. S NDEAIEN=$$UPDATER(.FDA,"E",.XURET)
 . ;
 . ;Update Expiration Date, Address, and Schedule fields for this File #8991.9 entry
 . K FDA
 . S IENS=NDEAIEN_","
 . D:$D(XUARR("ADDRESS DATA"))#2
 .. S FDA(8991.9,IENS,1.2)=STR1
 .. S FDA(8991.9,IENS,1.3)=STR2
 .. S FDA(8991.9,IENS,1.4)=STR3
 .. S FDA(8991.9,IENS,1.5)=CITY
 .. S FDA(8991.9,IENS,1.6)=$$STATEIEN(STATE)
 .. S FDA(8991.9,IENS,1.7)=ZIP
 . S:$D(XUARR("DEA",CNT,"Detox"))#2 FDA(8991.9,IENS,.03)=XUARR("DEA",CNT,"Detox")
 . S:$D(XUARR("DEA",CNT,"DEAExpire"))#2 FDA(8991.9,IENS,.04)=XUARR("DEA",CNT,"DEAExpire")
 . S:$D(XUARR("DEA",CNT,"SchedIINarc"))#2 FDA(8991.9,IENS,2.1)=XUARR("DEA",CNT,"SchedIINarc")
 . S:$D(XUARR("DEA",CNT,"SchedIINonNarc"))#2 FDA(8991.9,IENS,2.2)=XUARR("DEA",CNT,"SchedIINonNarc")
 . S:$D(XUARR("DEA",CNT,"SchedIIINarc"))#2 FDA(8991.9,IENS,2.3)=XUARR("DEA",CNT,"SchedIIINarc")
 . S:$D(XUARR("DEA",CNT,"SchedIIINonNarc"))#2 FDA(8991.9,IENS,2.4)=XUARR("DEA",CNT,"SchedIIINonNarc")
 . S:$D(XUARR("DEA",CNT,"SchedIV"))#2 FDA(8991.9,IENS,2.5)=XUARR("DEA",CNT,"SchedIV")
 . S:$D(XUARR("DEA",CNT,"SchedV"))#2 FDA(8991.9,IENS,2.6)=XUARR("DEA",CNT,"SchedV")
 . S:$D(FDA) FDA(8991.9,IENS,10.1)=$S($G(DUZ):"`"_DUZ,1:""),FDA(8991.9,IENS,10.2)="NOW"
 . D FILER(.FDA,"E",.XURET)
 . ;
 . ;Lookup or add corresponding entry in New Person NEW DEA #'S multiple
 . S IEN=$O(^VA(200,+XUDUZ,"PS4","B",DEA,0))
 . I IEN'>0 D  Q:IEN'>0
 .. K FDA
 .. S FDA(200.5321,"+1,"_+XUDUZ_",",.01)=DEA
 .. S IEN=$$UPDATER(.FDA,"E",.XURET)
 . ;
 . ;Update the DEA POINTER value in the NEW DEA #'s multiple
 . K FDA
 . S FDA(200.5321,+IEN_","_+XUDUZ_",",.03)=NDEAIEN
 . D FILER(.FDA,"",.XURET)
 Q
 ;
NPDEA(XUDUZ,XUARR,XURET) ;Set the single-valued fields in the New Person file for
 ; DEA#, Detox #, DEA Expiration Date, and the Schedule fields from the first entry in
 ; the NEW DEA#'s multiple; Also default Auth to Write Med Orders to 1 if not already set,
 ; WHO is 200PIEV, and there's a DEA#
 N DEAIEN,FDA,IENS,ND0,ND2,NDEAIEN
 S DEAIEN=$O(^VA(200,XUDUZ,"PS4",0)) Q:'DEAIEN
 S NDEAIEN=$P(^VA(200,XUDUZ,"PS4",DEAIEN,0),U,3) Q:NDEAIEN'>0
 ;
 ;Set up FDA with data from DEA NUMBERS entry
 S IENS=+XUDUZ_","
 S ND0=$G(^XTV(8991.9,+NDEAIEN,0)),ND2=$G(^(2)) Q:$P(ND0,U)=""
 S FDA(200,IENS,53.2)=$P(ND0,U) ;DEA#
 S FDA(200,IENS,53.11)=$P(ND0,U,3)  ;DETOX NUMBER
 S FDA(200,IENS,747.44)=$P(ND0,U,4) ;DEA EXPIRATION DATE
 S FDA(200,IENS,55.1)=$P(ND2,U) ;SCHEDULE II NARCOTIC
 S FDA(200,IENS,55.2)=$P(ND2,U,2) ;SCHEDULE II NON-NARCOTIC
 S FDA(200,IENS,55.3)=$P(ND2,U,3) ;SCHEDULE III NARCOTIC
 S FDA(200,IENS,55.4)=$P(ND2,U,4) ;SCHEDULE III NON-NARCOTIC
 S FDA(200,IENS,55.5)=$P(ND2,U,5) ;SCHEDULE IV
 S FDA(200,IENS,55.6)=$P(ND2,U,6) ;SCHEDULE V
 I $G(XUARR("WHO"))="200PIEV",$G(XUARR("AuthWriteMedOrders"))="" S FDA(200,IENS,53.1)=1
 D FILER(.FDA,"",.XURET)
 Q
 ;
FIRSTDEA(XUDUZ,XUARR,XURET) ;File the first valid DEA in the XUARR input array
 ;into the single-value DEA fields of the NP file
 N CNT,DEA,FDA,FIRST,IENS
 ;
 ;Find the first valid DEA number in the input array
 S FIRST="",CNT=0 F  S CNT=$O(XUARR("DEA",CNT)) Q:'CNT  D  Q:FIRST
 . S DEA=$G(XUARR("DEA",CNT,"DEA")) Q:DEA=""
 . S DEA=$$GETINT(200,53.2,DEA)
 . S:DEA'=U FIRST=CNT
 Q:'FIRST
 ;
 ;Set up FDA with data from DEA NUMBERS entry
 S IENS=XUDUZ_","
 S FDA(200,IENS,53.2)=DEA
 S:$D(XUARR("DEA",FIRST,"Detox"))#2 FDA(200,IENS,53.11)=XUARR("DEA",FIRST,"Detox")
 S:$D(XUARR("DEA",FIRST,"DEAExpire"))#2 FDA(200,IENS,747.44)=XUARR("DEA",FIRST,"DEAExpire")
 S:$D(XUARR("DEA",FIRST,"SchedIINarc"))#2 FDA(200,IENS,55.1)=XUARR("DEA",FIRST,"SchedIINarc")
 S:$D(XUARR("DEA",FIRST,"SchedIINonNarc"))#2 FDA(200,IENS,55.2)=XUARR("DEA",FIRST,"SchedIINonNarc")
 S:$D(XUARR("DEA",FIRST,"SchedIIINarc"))#2 FDA(200,IENS,55.3)=XUARR("DEA",FIRST,"SchedIIINarc")
 S:$D(XUARR("DEA",FIRST,"SchedIIINonNarc"))#2 FDA(200,IENS,55.4)=XUARR("DEA",FIRST,"SchedIIINonNarc")
 S:$D(XUARR("DEA",FIRST,"SchedIV"))#2 FDA(200,IENS,55.5)=XUARR("DEA",FIRST,"SchedIV")
 S:$D(XUARR("DEA",FIRST,"SchedV"))#2 FDA(200,IENS,55.6)=XUARR("DEA",FIRST,"SchedV")
 I $G(XUARR("WHO"))="200PIEV",$G(XUARR("AuthWriteMedOrders"))="" S FDA(200,IENS,53.1)=1
 D FILER(.FDA,"E",.XURET)
 Q
 ;
FILER(XUMVIFDA,FLAG,XURET) ;Call the Filer
 N DIERR,DIHELP,DIMSG,IENS,FILE,ROOT,XUMVIERR
 Q:'$D(XUMVIFDA)
 S FILE=$O(XUMVIFDA(0)),IENS=$O(XUMVIFDA(+FILE,"")),ROOT=$$ROOT^DILFD(FILE,IENS)_+IENS_")"
 I $G(ROOT)="" D ADDERR(.XURET,"Unable to determine global root of File #"_FILE_", IENS '"_IENS_".") Q
 L +@ROOT:10 E  D ADDERR(.XURET,"Unable to lock global "_ROOT_".") Q
 D FILE^DIE($G(FLAG),"XUMVIFDA","XUMVIERR")
 L -@ROOT
 D:$G(DIERR) ADDERR(.XURET,$$BLDERR("XUMVIERR"))
 Q
 ;
UPDATER(XUMVIFDA,FLAG,XURET,XUMVIIEN) ;Call the Updater
 ;**724,Story 1209890 (mko): Add XUMVIIEN as an input paramater to allow controlling IEN of new record
 N DIERR,DIHELP,DIMSG,XUMVIERR
 D UPDATE^DIE(FLAG,"XUMVIFDA","XUMVIIEN","XUMVIERR")
 I $G(DIERR) D ADDERR(.XURET,$$BLDERR("XUMVIERR")) Q 0
 Q +$G(XUMVIIEN(1))
 ;
ADDERR(XURET,MSG) ;Add error MSG to XURET
 Q:$G(MSG)=""
 S XURET=$S(XURET]"":XURET_" ",1:"-1^")_MSG
 Q
 ;
STATEIEN(STATE) ;Return "`"_IEN if valid abbreviation, VA code, or name
 N IEN
 Q:$G(STATE)="" ""
 S IEN=$S(STATE="FG":$O(^DIC(5,"B","FOREIGN COUNTRY",0)),STATE="OT":$O(^DIC(5,"B","OTHER",0)),STATE="EU":$O(^DIC(5,"B","EUROPE",0)),1:$O(^DIC(5,"C",STATE,0)))
 S:'IEN IEN=$O(^DIC(5,"B",STATE,""))
 Q $S(IEN>0:"`"_IEN,1:STATE)
 ;
GETINT(FILE,FLD,VAL) ;Get the internal form of the data; returns "^" if not valid
 N DIERR,DIHELP,DIMSG,XUMSG,XURES
 Q:VAL="" ""
 D CHK^DIE(FILE,FLD,"",VAL,.XURES,"XUMSG")
 Q XURES
 ;
BLDERR(INROOT) ;Build a string containing error messages returned by FileMan
 N ERRSTR,I,XUERMSGS
 D MSG^DIALOG("AE",.XUERMSGS,"","",$G(INROOT))
 S ERRSTR=""
 S I=0 F  S I=$O(XUERMSGS(I)) Q:'I  S:XUERMSGS(I)]"" ERRSTR=ERRSTR_$E(" ",ERRSTR]"")_XUERMSGS(I)
 Q ERRSTR
 ;
MAXLEN(FILE,FLD) ;Return the maximum length of field FLD in file FILE
 N MAX
 S MAX=$$GET1^DID(+FILE,+FLD,"","FIELD LENGTH") S:MAX'>0 MAX=999
 Q MAX
 ;
 ;=================================================
 ; Code for storing debugging information in ^XTMP
 ;=================================================
RECORD(PARAM,FLAG,RPCNAME) ;Record RPC inputs for debugging
 ;Return seq# in ^XTMP
 N NODE,NOW,SEQ,TODAY
 Q:'$$ISDEBUG 0
 S:$G(RPCNAME)="" RPCNAME="XUS MVI ENRICH NEW PERSON"
 S NOW=$$NOW^XLFDT,TODAY=$P(NOW,".")
 S NODE=$$NODE
 ;
 L +^XTMP(NODE):2
 D SETXTMP0(NODE)
 S SEQ=$O(^XTMP(NODE," "),-1)+1
 M ^XTMP(NODE,SEQ,"PARAM")=PARAM
 S ^XTMP(NODE,SEQ,"FLAG")=$G(FLAG)
 S ^XTMP(NODE,SEQ,"DT")=NOW
 S ^XTMP(NODE,SEQ,"DUZ")=$G(DUZ)
 S ^XTMP(NODE,SEQ,"RPC")=RPCNAME
 L -^XTMP(NODE)
 Q SEQ
 ;
RETURN(SEQ,RETURN) ;Record the return value
 Q:'SEQ  Q:'$$ISDEBUG
 M ^XTMP($$NODE,SEQ,"RETURN")=RETURN
 Q
 ;
DBON ;Set DEBUG on
 N NODE
 S NODE=$$NODE
 D SETXTMP0
 S ^XTMP(NODE,"DEBUG")=1
 W !,$NA(^XTMP(NODE,"DEBUG"))_" set to 1.",!
 Q
 ;
DBOFF ;Set DEBUG off
 N NODE
 S NODE=$$NODE
 K ^XTMP(NODE,"DEBUG")
 K:'$O(^XTMP(NODE,0)) ^XTMP(NODE)
 W !,$NA(^XTMP(NODE,"DEBUG"))_" killed.",!
 Q
 ;
ISDEBUG() ;Return 1 if DEBUG mode flag is set
 Q $G(^XTMP($$NODE,"DEBUG"))
 ;
PURGE ;Purge the debugging data stored in ^XTMP
 N ISDEBUG
 S ISDEBUG=$$ISDEBUG
 K ^XTMP($$NODE)
 W !,$NA(^XTMP($$NODE))_" killed.",!
 D:ISDEBUG DBON
 Q
 ;
SETXTMP0(NODE,DESC,LIFE) ;Set 0 node of ^XTMP(node)
 N CREATEDT
 S:$G(NODE)="" NODE=$$NODE
 S CREATEDT=$S($D(^XTMP(NODE,0))#2:$P(^(0),U,2),1:DT)
 S:'$G(LIFE) LIFE=30
 S:$G(DESC)="" DESC="New Person RPC Inputs and Outputs"
 S ^XTMP(NODE,0)=$$FMADD^XLFDT(DT,LIFE)_U_CREATEDT_U_DESC
 Q
 ;
NODE() ;Return ^XTMP Debug subscript
 Q "XU_RPC_DEBUG_NP"
