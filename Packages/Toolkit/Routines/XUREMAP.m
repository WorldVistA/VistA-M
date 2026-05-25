XUREMAP ;VISS/CEP - Remote Application Registration ; 2-6-2025
 ;;8.0;KERNEL;**759**;Jul 10, 1995;Build 40
 ;Per VA Directive 6402, this routine should not be modified.
 Q
 ;
 ;
RAENABLE(XURET,XURANAME,XUENABLE)    ; entry point for RPC is used exclusively by
 ; the Identity and Access Management (IAM) service to enable or disable an entry
 ; in the REMOTE APPLICATION file (#8994.5).
 ;
 ; INPUT PARAMETER: XURANAME (REQUIRED)--The value of the NAME (#.01)
 ;                  field of the entry in the REMOTE APPLICATION (#8994.5)
 ;                  file, for the REMOTE APPLICATION to be disabled.
 ;
 ; INPUT PARAMETER: XUENABLE (REQUIRED)--boolean: 1 for enable, 0 for disable
 ;                                       
 ; RETURN PARAMETER: XURET--success or failure   
 ;         success:  1 ^ [name of remote application] ^ ENABLED/DISABLED ^ SITE #
 ;         failure: -1 ^ [name of remote application] ^ error text       ^ SITE #
 ;
 ; Since the field is called "DISABLED", and the RPC and entry pont is ...ENABLE,
 ;   we will reverse the parameter to make sense
 ;   so XUENABLE(1)= *not* disabled
 ;      XUENABLE(0)= *disabled*
 N RAIEN,IENS,XUFDA,XUERR,XUSVRB
 I $G(XURANAME)="" D  Q
 . S XURET(0)="-1"_U_"XURANAME input is required."
 S RAIEN=$$FIND1^DIC(8994.5,"","MX",XURANAME,"","","ERR")
 I +RAIEN'>0 D  Q
 .  S XURET(0)="-1"_U_XURANAME_U_"No Remote application found matching "_XURANAME_U_$P($$SITE^VASITE(),U,3)
 ;
 I "^0^1^"'[(U_$G(XUENABLE)_U) D  Q
 .  S XURET(0)="-1"_U_XURANAME_U_"XUENABLE parameter must be either 0 (disable) or 1 (enable)"_U_$P($$SITE^VASITE(),U,3)
 ;
 ; set DISABLED field for RA entry passed (and found)
 ;
 S IENS=RAIEN_","
 S XUSVRB=$S(XUENABLE=1:"ENABLE",1:"DISABLE")
 S XUENABLE='XUENABLE ;TO MAKE FIELD (DISABLED) AGREE WITH INPUT NAME (ENABLE)
 S XUFDA(8994.5,IENS,.05)=+XUENABLE
 D FILE^DIE("K","XUFDA","XUERR")
 I $D(XUERR("DIERR")) D  Q
 . S XURET(0)="-1"_U_XURANAME_U_XUSVRB_" request failure - filer error: "_$G(XUERR("DIERR",1,"TEXT",1))_U_$P($$SITE^VASITE(),U,3)
 S XURET(0)="1"_U_XURANAME_U_XUSVRB_U_$P($$SITE^VASITE(),U,3)
 Q
 ;
ADDRA(XURET,XUARR) ; RPC entry point for XUS IAM RA ADD OR REPLACE
 ;                   to add/update a Remote Application file (#8994) entry 
 ;                        disable REMOTE APPLICATION Entry by passing null in
 ;                        Application Code Field
 ;
 ; The behavior of this API is ADD/REPLACE, as follows:
 ;   1. If the remote application entry passed to the API in array XUARR
 ;      does not exist then the filer attempts to file the entire record.
 ;   2. If the entry exists (input name matches exactly with an entry on
 ;      the target system) then the API will replace the existing entry
 ;      with the input entry if the following condition is met:
 ;      A faux filing of the input record is successful.
 ;      Note: the remote application entry being updated is removed and
 ;            the passed entry completely replaces the original.  Therefore
 ;            it is the consumer's responsibility to send a fully qualified
 ;            and populated entry to replace the original.
 ;
 ; called from rpc: XUS IAM RA ADD OR REPLACE
 ; Input:
 ;   XUARR(#) = FILE #;FIELD #^FIELD NAME^FIELD VALUE
 ;
 ;     notes: 1. content of each field is between < >
 ;            2. # is sequential and unique
 ;            3. CONTEXTOPTION is existing B-Type option or
 ;                 created with ENDPOINTs.  See ADDEP^XUREMAP
 ;            4. APPLICATIONCODE (application security phrase) is sent UNencrypted
 ;
 ;
 ;   XUARR(#)="8994.5;.01^NAME^<name of REM APP>^"
 ;   XUARR(#)="8994.5;.02^CONTEXTOPTION^<name of B type option>^" <-- must exist
 ;   XUARR(#)="8994.5;.03^APPLICATIONCODE^<some code>^"
 ;   XUARR(#)="8994.5;.04^CANADDUSERS^<BOOLEAN>^"
 ;   ---- CALL BACK TYPE MULTIPLE (XUARR optional)
 ;   { 0:n of this block: 
 ;    XUARR(#)="8994.51;.01^CALLBACKTYPE^<call back type code>"
 ;    XUARR(#)="8994.51;.02^CALLBACKPORT^<port number>"
 ;    XUARR(#)="8994.51;.03^CALLBACKSERVER^<server spec>"
 ;    XUARR(#)="8994.51;.04^URLSTRING^<url string>" 
 ;   }
 ;
 N FILE,FILENO,RANAME,XUARRM,FOUND,XUNAME,ERR,TMPXURET,XUARRIN
 S XURET(0)="-1^Nothing Filed."
 S FILE=$$GETFLNUM^XUREMAP1(.XUARR)
 S FILENO=+FILE
 S RANAME=$P(FILE,U,2)
 I +FILENO'=8994.5 D  Q
 .  S XURET(0)="-1^Invalid file number"
 S FOUND=$$FIND1^DIC(+FILENO,"","MX",RANAME,"","","ERR")
 ; make a copy of the input array for debugging purposes to leave input alone
 M XUARRIN=XUARR
 ; parse input into two arrays: a top level entry and the multiple
 D INSPLIT^XUREMAP1(.XUARRIN,.XUARRM)
 ;
 I FOUND D
 .;
 .; make sure INPUT entry will file before removing FOUND entry
 .  D FAUXFL^XUREMAP1(.XURET,.XUNAME,.XUARRIN,.XUARRM)
 .  Q:($G(XURET(0))'>0)
 .  L +^XWB(8994.5,FOUND,0):2 I '$T S XURET(0)="-1^"_RANAME_" entry locked for file:  "_FILENO Q
 .  D REMOVE^XUREMAP1(.TMPXURET,XUNAME,8994.5)
 .;
 .; file the input entry passed in XUARR
 .  D ADDRA^XUREMAP1(.XURET,.XUARRIN,.XUARRM,+FOUND)
 .  L -^XWB(8994.5,FOUND,0)
 E  D
 .; input entry in XUARR not found, so file new entry
 .  D ADDRA^XUREMAP1(.XURET,.XUARRIN,.XUARRM,0)
 Q
 ;
RAQ2(XURET,NAME,FLAGS)   ; API to query the remote application file and return entry data
 ;
 ;INPUT:  NAME = full name of entry to search for OR leading characters
 ;               to return partial matches
 ;        FLAGS= X = NAME input must match an entry exactly
 ;               (AND/OR)
 ;               M = return context option (file 19) data that is pointed
 ;                   to by .02 field (CONTEXTOPTION)
 ;
 ;OUTPUT:
 ;  FAIL:
 ;  XURET(0)="0 ^ matching entries^station #"
 ;
 ;  SUCCESS:
 ;  XURET(0)="n ^ matching entries^station #"
 ;  XURET(1)=file;field no.^ field name^data
 ;  XURET(2)=file;field no.^ field name^data
 ;  
 ;  REPEATED AS:
 ;  {
 ;     XURET(n)=8994.5;.01^NAME ^ ra name
 ;     XURET(n)=8994.5;.02^CONTEXTOPTION ^ ra context option
 ;     XURET(n)=8994.5;.03^APPLICATION CODE ^ ra app code (encrypted)
 ;     XURET(n)=8994.5;.04^CAN ADD USERS ^ ra can add users (boolean YES/NO)
 ;     XURET(n)=8994.5;.05^DISABLED ^ ra disabled (boolean YES/NO)
 ;     XURET(n)=8994.51;.01^CALLBACKTYPE^ ra callback type
 ;     XURET(n)=8994.51;.02^CALLBACKPORT^ ra callback port
 ;     XURET(n)=8994.51;.03^CALLBACKSERVER^ ra callback server
 ;     XURET(n)=8994.51;.04^URLSTRING^ ra url string
 ;  } for each matching entry
 ;
 ;  AND, if the M flag is set for the context multiple, with each entry above...
 ;  {
 ;     XURET(n)=19;.01^NAME^context option name
 ;     XURET(n)=19;1^MENU TEXT^context option menu text
 ;     XURET(n)=19;1.1^UPPERCASE MENU TEXT^context option UC menu text
 ;        { XURET(n)=19;3.5^DESCRIPTION^context option wp ln }
 ;     XURET(n)=19;3.6^CREATOR^context option creator
 ;     XURET(n)=19;4^TYPE^ context option type
 ;     XURET(n)=19;99.1^TIMESTAMP OF PRIMARY MENU^$h timestamp
 ;        { XURET(n)=19.05;.01^RPC^context option attached RPC  }
 ;  }
 ;
 ;
 I $L($G(NAME))'>1 D  Q
 . S XURET(0)="-1"_U_"NAME input must be at least 2 characters."
 N SCREEN,OUT,XUERR,FOUND,EES,COUNT,RAIEN,IENS,OUTCB
 ;
 S FLAGS=$G(FLAGS)
 S SCREEN=""
 I ($G(NAME)'="")&($G(FLAGS)["X") S SCREEN="I $P(^(0),U)=NAME"
 ;
 D LIST^DIC(8994.5,"",".01;.02;.03;.04;.05","","*","",$G(NAME),"B",$G(SCREEN),"","OUT","XUERR")
 ;
 I $D(XUERR("DIERR")) D  Q
 . S XURET(0)="-1^"_$G(XUERR("DIERR",1,"TEXT",1))
 ;
 S FOUND=+$G(OUT("DILIST",0))
 S EES=$S(FOUND>1:"entries",1:"entry")
 S XURET(0)=1_U_FOUND_" matching "_EES_U_$P($$SITE^VASITE(),U,3)
 ;
 ; get each entries CallBackType and Context Option (if flagged)
 ;
 S COUNT=0
 F  S COUNT=$O(OUT("DILIST",2,COUNT)) Q:COUNT'>0  D
 .  S RAIEN=+$G(OUT("DILIST",2,COUNT))
 .  S IENS=","_RAIEN_","
 .  S OUTCB="OUTCB("_RAIEN_")"
 .  D LIST^DIC(8994.51,IENS,".01;.02;.03;.04","","","","","","","",OUTCB,"ERRCB")
 .  ;
 .  ; if requested, get the .02 CONTEXTOPTION pointed to entry data for return,
 .  ;
 .  I FLAGS["M" D GETCNTXT^XUREMAP1(.OUTCTXT,$G(OUT("DILIST","ID",COUNT,.02)),RAIEN) ;
 ;
 D FORMAT^XUREMAP1(.XURET,.OUT,.OUTCB,.OUTCTXT)
 K OUT,ERR,OUTCB,OUTCTXT
 ;
 Q
 ;
 ;
CONTEXTQ(RETURN,NAME)   ; API restricted to IAM to Query Context Options
 ;                        and return entry data
 ;
 ; API restricted to IAM to Query Context Options and return entry data.
 ;
 ; called from rpc: XUS IAM RA CONTEXT QUERY
 ;
 ;
 ;  INPUT:  NAME--full name of entry to search for an exact match.
 ;
 ;   SUCCESS:
 ;     XURET(0)="LOCAL IEN^Option [name of matching entry]^SITE #"
 ;     XURET(1)=file;field no.^ field name^data
 ;     XURET(2)=file;field no.^ field name^data
 ;     ...
 ;     XURET(n)=file;field no.^ field name^data
 ;
 ;   FAIL:
 ;     XURET(0)="-1^Option [name of matching entry] not found.^SITE #"
 ;
 N FOUND
 I $G(NAME)="" D  Q
 . S RETURN(0)="-1"_U_"NAME input cannot be empty."
 S RETURN(0)="-1^Option "_NAME_" not found."
 D GETCNTXT^XUREMAP1(.FOUND,NAME,1)
 I +FOUND(0) S RETURN(0)=FOUND(0)
 ;
 D CONTEXT^XUREMAP1(.RETURN,.FOUND,0,1)
 ;
 Q
 ;
ADDEP(XURET,XUARR) ; RPC to create new or update ENDPOINT entries
 ;
 ; called from rpc: XUS IAM RA CONTEXT ADD
 ; File Entry Even if 1 or more RPCs are not on local system and include unfiled RPCs in return array.
 ;
 ; Input:
 ;   XUARR(#) = FILE #;FIELD #^FIELD NAME^INTERNAL VALUE^EXTERNAL VALUE
 ; content of each field is in between < >
 ;
 ;   XUARR(1)="19;.01^NAME^<name of option>^"
 ;   XUARR(2)="19;1^MENU TEXT^<menu text of option>^"
 ;   XUARR(3)="19;4^TYPE^B^"   ; must be B type
 ;   XUARR(4)="19;3.5^DESCRIPTION^line 1 of option description."
 ;   XUARR(5)="19;3.5^DESCRIPTION^line 2 of option description."
 ;   XUARR(6)="19;3.5^DESCRIPTION^" ;file a blank line
 ;   XUARR(7)="19.05;.01^NAME^<name of endpoint>^"
 ;   XUARR(8)="19.05;1^RPC KEY^<rpc key>^"
 ;   XUARR(9)="19.05;.01^NAME^<>^"
 ;   XUARR(10)="19.05;1^RPC KEY^<rpc key>^"
 ;
 ;  Success:
 ;   XURET(0) = 1
 ;
 ;  Fail:
 ;   XURET(0) = "-1^No data passed"
 ;   XURET(0) = "-1^"_$G(XUERR("DIERR",1,"TEXT",1))
 ;
 ;
 N FILE,FILENO,CTXTNAME,FOUND,XUNAME,TMPXURET,ERR
 S FILE=$$GETFLNUM^XUREMAP1(.XUARR)
 S FILENO=+FILE
 S CTXTNAME=$P(FILE,U,2)
 I +FILENO'=19 D  Q
 .  S XURET(0)="-1^Invalid file number"
 D CHKAEPIN^XUREMAP1(.XURET,.XUARR)
 Q:+$G(XURET(0))<0
 S XURET(0)="-1^Nothing Filed." ;DEFAULT AFTER INPUT CHECK
 S FOUND=$$FIND1^DIC(FILENO,"","MX",CTXTNAME,"","","ERR")
 I FOUND D
 .  D FAUXFL^XUREMAP1(.XURET,.XUNAME,.XUARR)
 .  Q:($G(XURET(0))'>0)
 .  K XURET S XURET(0)="-1^Invalid file number"
 .  L +^DIC(19,FOUND,0):2 I '$T S XURET(0)="-1^"_CTXTNAME_" entry locked for file:  "_FILENO Q
 .  D REMOVE^XUREMAP1(.TMPXURET,XUNAME,FILENO)
 .  ; file the input entry passed in XUARR
 .  D ADDEP^XUREMAP1(.XURET,.XUARR,FOUND)
 .  L -^DIC(19,FOUND,0)
 E  D
 .  D ADDEP^XUREMAP1(.XURET,.XUARR,"")
 Q
CANADD(XURET,XURANAME,XUCANADD) ; entry point for RPC is used exclusively by
 ; the Identity and Access Management (IAM) service to mark an entry in the
 ; remote application file (#8994.5) as either CAN ADD USERS=YES OR CAN ADD USERS=NO
 ;
 ; INPUT PARAMETER: XURANAME (REQUIRED)--The value of the NAME (#.01)
 ;                  field of the entry in the REMOTE APPLICATION (#8994.5)
 ;                  file, for the REMOTE APPLICATION to be disabled.
 ;
 ; INPUT PARAMETER: XUCANADD (REQUIRED)--boolean
 ;                  1 - CAN ADD USERS = YES
 ;                  0 - CAN ADD USERS = NO
 ; RETURN PARAMETER: XURET--success or failure   
 ;         success:  1 ^ [name of remote application] ^ CAN ADD / CANNOT ADD ^ SITE #
 ;         failure: -1 ^ [name of remote application] ^ error text       ^ SITE #
 ;
 N RAIEN,IENS,XUFDA,XUERR,XUSVRB
 I $G(XURANAME)="" D  Q
 . S XURET(0)="-1"_U_"XURANAME input cannot be empty."
 S RAIEN=$$FIND1^DIC(8994.5,"","MX",XURANAME,"","","ERR")
 I +RAIEN'>0 D  Q
 .  S XURET(0)="-1"_U_XURANAME_U_"No Remote application found matching "_XURANAME_U_$P($$SITE^VASITE(),U,3)
 ;
 I "^0^1^"'[(U_$G(XUCANADD)_U) D  Q
 .  S XURET(0)="-1"_U_XURANAME_U_"XUCANADD parameter must be either 0 (disable) or 1 (enable)"_U_$P($$SITE^VASITE(),U,3)
 ;
 ; set DISABLED field for RA entry passed (and found)
 ;
 S IENS=RAIEN_","
 S XUSVRB=$S(XUCANADD=1:"CAN ADD",1:"CANNOT ADD")
 S XUFDA(8994.5,IENS,.04)=+XUCANADD
 D FILE^DIE("K","XUFDA","XUERR")
 I $D(XUERR("DIERR")) D  Q
 . S XURET(0)="-1"_U_XURANAME_U_XUSVRB_" request failure - filer error: "_$G(XUERR("DIERR",1,"TEXT",1))_U_$P($$SITE^VASITE(),U,3)
 S XURET(0)="1"_U_XURANAME_U_XUSVRB_U_$P($$SITE^VASITE(),U,3)
 Q
 ;
