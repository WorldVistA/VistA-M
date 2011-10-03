XUSNPI1 ; OAK/TKW - NATIONAL PROVIDER IDENTIFIER UTILITIES ;6/6/08  11:27
 ;;8.0;KERNEL;**480**; July 10, 1995;Build 38
 ;;Per VHA Directive 2004-038, this routine should not be modified
NPIUSED(XUSNPI,XUSQID,XUSQIL,XUSIEN,XUSRSLT,XUSFLAG) ; Evaluate cases where an NPI is already in use
 ;   and return an error or warning. Called from routines that allow an NPI to be assigned
 ;   to either an INSTITUTION (file 4) or a NEW PERSON (file 200).
 ; XUSNPI = the NPI
 ; XUSQID = the qualified identifier for the file being edited (ex. "Individual_ID")
 ; XUSQIL = the delimited list of entities already using that NPI. This is output
 ;    from $$QI^XUSNPI, in the format:
 ;  Qualified_Identifier^IEN^Effective_date/time^Active/Inactive;
 ;    (Qualified_Identifier=(ex. "Individual_ID")
 ;     IEN=the IEN of the entity who owns the NPI.
 ;    If there are multiple entities who own the NPI, there will
 ;    be multiple entries in XUSQIL, delimited by ";".)
 ; XUSIEN = IEN of entry to which NPI is being assigned
 ; XUSRSLT = an output array returned if an error or warning message is generated.
 ; XUSFLAG = If set to 1, indicates that routine is being called from an input transform.
 ;           If set to 2, indicates we're checking the current NPI prior to delete/replace
 ;           If set to 3, indicates we're checking a new NPI (Either ADD or REPLACE).
 ;
 ; The function will return:
 ;   0 - No Error
 ;   1 - Error
 ;   2 - Warning
 ;   
 N XUSGLOB,XUSERR,XUSWARN,XUSFILE,XUSCNT,XUSFILI,XUSNEWPT,ZZ,X,I
 N XUSOU,XUSOAI,XUSOIEN,XUSOQID,XUSOPT
 K XUSRSLT
 ; If NPI is not already in use, quit 0 (no error)
 I XUSQIL=0 Q 0
 ; If NPI is malformed, quit 1 (error)
 I +XUSQIL=0,$P(XUSQIL,U,2)="Invalid NPI" D  Q 1
 . S XUSRSLT(1)="NPI values have a specific structure to validate them..."
 . S XUSRSLT(2)="The Checksum for this entry is not valid"
 . Q
 D GETLST^XPAR(.ZZ,"PKG.KERNEL","XUSNPI QUALIFIED IDENTIFIER")
 S ZZ=""
 F  S ZZ=$O(ZZ(ZZ)) Q:ZZ'>0  I $P(ZZ(ZZ),U)=XUSQID Q
 I ZZ'>0 S XUSRSLT(1)="Invalid 'Qualified Identifier' Input Parameter "_XUSQID_" passed." Q 1
 S XUSFLAG=+$G(XUSFLAG)
 S XUSIEN=+$G(XUSIEN)
 ; If user being updated is NON-VA Provider, get their Provider Type and file name
 S XUSNEWPT=0,XUSFILI=""
 ; Read through list of entities that already own the NPI
 S (XUSERR,XUSWARN,XUSCNT)=0
 F I=1:1 S XUSOU=$P(XUSQIL,";",I) Q:XUSOU=""!(XUSERR)  D
 . ; Get Qualified Identifier, IEN and Active/Inactive flag for other entity who owns the NPI
 . S XUSOQID=$P(XUSOU,U)
 . S XUSOIEN=+$P(XUSOU,U,2)
 . S XUSOAI=$P(XUSOU,U,4)
 . ; Find Qualified Identifier of file that already owns the NPI in the list of valid QIs
 . S ZZ="" F  S ZZ=$O(ZZ(ZZ)) Q:ZZ'>0  I $P(ZZ(ZZ),U)=XUSOQID Q
 . I ZZ'>0 D  Q
 . . S XUSERR=1
 . . S XUSRSLT(1)="Invalid Qualified Identifier "_XUSOQID_" returned from $$QI^XUSNPI" Q
 . ; Get global reference for file that owns NPI
 . S XUSGLOB="^"_$P(ZZ(ZZ),U,2)
 . ; If called from the input transform, and an entity is trying to enter an NPI they
 . ;    have previously held, it's not an error, unless NPI is inactive.
 . I XUSFLAG=1,XUSQID=XUSOQID,XUSIEN=XUSOIEN,XUSOAI'="Inactive" Q
 . ; Put provider type information into XUSOPT to generate error/warning
 . S XUSOPT=0
 . I XUSFLAG'=1 D
 . . I XUSOQID="Individual_ID" S XUSOPT="2^"
 . . I XUSOQID="Organization_ID" S XUSOPT="1^"
 . . I XUSOQID="Non_VA_Provider_ID" S XUSOPT=$$GETPT(XUSOIEN)
 . . Q
 . ; If editing a VA Provider, and a non-VA Provider has same current NPI, build both the
 . ; warning a user sees prior to replacing or deleting the current NPI, and the warning
 . ; the user will see after replacing the NPI.
 . I XUSFLAG=2 D  Q
 . . Q:XUSOQID'="Non_VA_Provider_ID"
 . . D MSGOLD(XUSNPI,XUSGLOB,XUSOIEN,.XUSCNT,XUSOPT,XUSOAI,.XUSRSLT)
 . . S XUSWARN=1
 . . Q
 . ; If an entity in the same file owns the NPI, it's an error.
 . I $P(XUSOU,U)=XUSQID D  Q
 . . D:XUSFLAG'=1 MSGNEW(XUSNPI,XUSGLOB,XUSOIEN,.XUSCNT,.XUSRSLT,XUSOPT)
 . . S XUSERR=1 Q
 . ; If an entity in the INSTITUTION file (#4) already owns the NPI, it's an error.
 . I $P(XUSOU,U)="Organization_ID" D  Q
 . . D:XUSFLAG'=1 MSGNEW(XUSNPI,XUSGLOB,XUSOIEN,.XUSCNT,.XUSRSLT,XUSOPT)
 . . S XUSERR=1 Q
 . ; If new entry being edited is a VA INSTITUTION and any other entity owns the NPI, it's an error
 . I XUSQID="Organization_ID" D  Q
 . . D:XUSFLAG'=1 MSGNEW(XUSNPI,XUSGLOB,XUSOIEN,.XUSCNT,.XUSRSLT,XUSOPT)
 . . S XUSERR=1 Q
 . ; Providers in file 200 or 355.93 can share an NPI. If NPI in file 355.93 is Active,
 . ; issue a warning, if inactive, issue an error
 . I XUSFLAG'=1 D MSGNEW(XUSNPI,XUSGLOB,XUSOIEN,.XUSCNT,.XUSRSLT,XUSOPT,XUSOAI)
 . I XUSOAI="Inactive" S XUSERR=1 Q
 . S XUSWARN=1
 . Q
 I XUSERR Q 1
 I XUSWARN Q 2
 Q 0
 ;
GETPT(XUSIEN) ; Get provider type for entry in IB NON/OTHER VA BILLING PROVIDER file
 N PT
 S PT=+$$GET1^DIQ(355.93,XUSIEN_",",.02,"I")
 ; Null provider type returned as 3.
 I PT=1 S PT="1^the FACILITY/GROUP provider "
 E  I PT=2 S PT="2^the INDIVIDUAL provider "
 E  S PT="3^"
 K ^TMP("DIERR",$J)
 Q PT
 ;
GETPER(XUSOWNKY) ; Return names of people who own the security key IB PROVIDER EDIT
 N XUSIEN,X
 F XUSIEN=0:0 S XUSIEN=$O(^XUSEC("IB PROVIDER EDIT",XUSIEN)) Q:'XUSIEN  D
 . Q:$G(^VA(200,XUSIEN,0))=""
 . ; Don't return TERMINATED or DISUSERed users
 . S X=$$ACTIVE^XUSER(XUSIEN)
 . I X=""!($P(X,U)=0) Q
 . ; Put users IENs into output array
 . S XUSOWNKY(XUSIEN)="" Q
 Q
 ;
MSGOLD(XUSNPI,XUSGLOB,XUSIEN,XUSCNT,XUSOPT,XUSOAI,XUSRSLT) ;
 ; Generate warning message to display prior to REPLACE/DELETE NPI prompt, when the current 
 ; NPI is also used by a non-va provider
 N XUSFILE,XUSOWNKY,I,J,X
 S XUSFILE=$P(@(XUSGLOB_"0)"),U)
 S X=""
 S:$G(XUSOPT) X=$P(XUSOPT,U,2)
 S XUSCNT=XUSCNT+1,XUSRSLT(XUSCNT)="The NPI of "_XUSNPI_" is also associated with "_X
 S XUSCNT=XUSCNT+1,XUSRSLT(XUSCNT)=$P(@(XUSGLOB_XUSIEN_",0)"),U)
 I XUSOAI="Inactive" S XUSRSLT(XUSCNT)=XUSRSLT(XUSCNT)_" as INACTIVE"
 S XUSRSLT(XUSCNT)=XUSRSLT(XUSCNT)_" in the "_XUSFILE_" file."
 S XUSCNT=XUSCNT+2
 ; Generate warning message to display after REPLACE NPI, when the current NPI 
 ; is also used by a non-va provider
 ;
 S I=$O(XUSRSLT("X",999999999999),-1)
 S XUSRSLT("X",I+1)="Warning: NPI "_XUSNPI_" is also associated with provider "_$P(@(XUSGLOB_XUSIEN_",0)"),U)_"."
 S XUSRSLT("X",I+2)=""
 S XUSRSLT("X",I+3)="A Mailman message has been sent to holders of the ""IB PROVIDER EDIT"""
 S XUSRSLT("X",I+4)="security key."
 S I=$O(XUSRSLT("XMSG",999999999999),-1)
 S XUSRSLT("XMSG",I+1,0)="The NPI "_XUSNPI_" was ^ for ^ in"
 S XUSRSLT("XMSG",I+2,0)="the NEW PERSON file. The NPI "_XUSNPI_" is also associated with"
 S XUSRSLT("XMSG",I+3,0)=$P(@(XUSGLOB_XUSIEN_",0)"),U)_" in the "_XUSFILE_" file."
 S XUSRSLT("XMSG",I+4,0)=" "
 S XUSRSLT("XMSG",I+5,0)="The same change may need to be made to the "_XUSFILE
 S XUSRSLT("XMSG",I+6,0)="using the PROVIDER ID MAINTENANCE option."
 ; Get names of persons to notify
 D GETPER(.XUSOWNKY)
 S I=$O(XUSRSLT("XRCPT",999999999999),-1)
 F J=0:0 S J=$O(XUSOWNKY(J)) Q:'J  S I=I+1,XUSRSLT("XRCPT",I)=J
 Q
 ;
MSGNEW(XUSNPI,XUSGLOB,XUSIEN,XUSCNT,XUSRSLT,XUSOPT,XUSOAI) ;
 ; Generate error or warning message when new NPI is in use.
 N XUSFILE,X
 S XUSFILE=$P(@(XUSGLOB_"0)"),U)
 S X=""
 S:$G(XUSOPT) X=$P(XUSOPT,U,2)
 I $G(XUSOAI)="" D  Q
 . S XUSRSLT(XUSCNT+1)="The NPI of "_XUSNPI_" is now, or was in the past, associated with"
 . S XUSRSLT(XUSCNT+2)=X_$P(@(XUSGLOB_XUSIEN_",0)"),U)_" in the "_XUSFILE_" file."
 . S XUSCNT=XUSCNT+2
 . Q
 S XUSRSLT(XUSCNT+1)="The NPI of "_XUSNPI_" is also associated with "_X
 S XUSRSLT(XUSCNT+2)=$P(@(XUSGLOB_XUSIEN_",0)"),U)_" in the "_XUSFILE_" file."
 S XUSCNT=XUSCNT+2
 I XUSOAI="Inactive" D  Q
 . S XUSCNT=XUSCNT+1,XUSRSLT(XUSCNT)="This NPI is INACTIVE and may not be used."
 . Q
 Q
 ;
 ;
