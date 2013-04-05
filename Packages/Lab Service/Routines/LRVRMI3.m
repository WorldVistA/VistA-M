LRVRMI3 ;DALOI/STAFF - LAB MICRO LEDI INTERFACE ;11/23/11  12:25
 ;;5.2;LAB SERVICE;**350**;Sep 27, 1994;Build 230
 ;
 ; Part of Micro LEDI interface.  It is a continuation of ^LRVRMI4 and ^LRVRMI2. Processes data in the temp global ^TMP("LRMI")
 ; and stores it into the appropriate sections of the Lab Data Microbiology file (#63.05).
 ;
 ;
NODE(LRNODE) ;  Process similar multiples - nodes 15,19-31
 ; Call with LRNODE = node in MI subscript to process
 ;
 N DIERR,IEN,LRCMT,LRFDA,LRFDAIEN,LRFILE,LRERR,LRIEN,LRMSG,LRPL,LRX,X
 ; Mycology smear/prep^^^^Preliminary bacteriology comment^Preliminary virology comment^Preliminary parasite comment^Preliminary mycology comment^Preliminary TB comment^
 ; Parasitology smear/prep^Bacteriology smear/prep^Bacteriology test^Parasite test^Mycology test^TB test^Virology test^Sterility test
 ;
 S LRFILE=$P("63.371^^^^63.06^63.431^63.1^63.11^63.18^63.341^63.291^63.061^63.361^63.111^63.181^63.432^63.292^","^",LRNODE-14)
 M LRCMT=^LR(LRDFN,"MI",LRIDT,LRNODE)
 ;
 S IEN=0
 F  S IEN=$O(^TMP("LRMI",$J,LRDFN,"MI",LRIDT,LRNODE,IEN)) Q:IEN<1  D
 . S LRX=$G(^TMP("LRMI",$J,LRDFN,"MI",LRIDT,LRNODE,IEN,0)),LRX=$S(LRX'="":LRX,1:" ")
 . I LRX'=" ",$$DUPCHK^LRVRMI3(LRLL,LRPROF,.LRCMT,LRX) Q
 . S LRFDA(1,LRFILE,"+"_IEN_","_LRIDT_","_LRDFN_",",.01)=LRX
 . S LRFDAIEN(IEN)=IEN
 . S LRX=$G(^TMP("LRMI",$J,LRDFN,"MI",LRIDT,LRNODE,0))
 . I $P(LRX,"^") S LRPL(IEN)=$P(LRX,"^") Q
 . ;
 . I $D(^TMP("LRMI",$J,LRDFN,"MI",LRIDT,LRNODE,IEN,0,0)) D  ;
 . . S LRX=$G(^TMP("LRMI",$J,LRDFN,"MI",LRIDT,LRNODE,IEN,0,0))
 . . S X=$P(LRX,"^",4)
 . . D STAT4CMT(LRFILE,X,.LRSTATUS)
 . . I $P(LRX,"^") S LRPL(IEN)=$P(LRX,"^")
 . ;
 ;
 I '$D(LRFDA) Q
 ;
 D UPDATE^DIE("","LRFDA(1)","LRFDAIEN","LRERR")
 S IEN=0
 F  S IEN=$O(LRPL(IEN)) Q:'IEN  D
 . I $G(LRFDAIEN(IEN)) D SETPL^LRRPLUA(LRDFN_",MI,"_LRIDT_","_LRNODE_","_LRFDAIEN(IEN),LRPL(IEN))
 ;
 ;
 ; Update d/t approved and user approving
 S LRX=$$RPTDT(LRDFN,LRIDT,LRNODE,LRNOW,$S($G(LRDUZ):LRDUZ,1:$G(DUZ)))
 ;
 Q
 ;
 ;
SETPL(NODE) ; Setup LRPL array
 ; Call with NODE = node in MI subscript to retrieve the performing lab
 ;
 N LRX
 S LRX=^TMP("LRMI",$J,LRDFN,"MI",LRIDT,NODE,IEN,0,0)
 I $P(LRX,"^") S LRPL(IEN)=$P(LRX,"^")
 Q
 ;
 ;
STOREPL(NODE) ; Set performing lab
 ; Call with NODE = node in MI subscript to retrieve the performing lab
 N IEN
 S IEN=0
 F  S IEN=$O(LRPL(IEN)) Q:'IEN  I $G(LRFDAIEN(IEN)) D SETPL^LRRPLUA(LRDFN_",MI,"_LRIDT_","_NODE_","_LRFDAIEN(IEN),LRPL(IEN))
 Q
 ;
 ;
DUPCHK(LRLL,LRPROF,LRCMT,LRCOM) ; Check for duplicates - comment stripped if spaces, force to upper case unless
 ; flag set to store duplicates (Field #2.2 of PROFILE multiple in file #68.2)
 ;
 ; Call with  LRLL = load/work list ien
 ;          LRPROF = profile ien in load/worklist
 ;           LRCMT = array containing current comments on file
 ;           LRCOM = new comment to check
 ;
 ; Returns LRDUP = 0 (no duplicate), 1 (duplicate)
 ;
 N LRDUP,LRI,LRX,LRY
 S LRDUP=0
 I '$P($G(^LRO(68.2,LRLL,10,+$G(LRPROF),0)),U,4) D
 . S LRI=0,LRY=$TR(LRCOM," ",""),LRY=$$UP^XLFSTR(LRY)
 . F  S LRI=$O(LRCMT(LRI)) Q:'LRI  D  Q:LRDUP
 . . S LRX=$P(LRCMT(LRI,0),U),LRX=$TR(LRX," ",""),LRX=$$UP^XLFSTR(LRX)
 . . I LRX=LRY S LRDUP=1
 Q LRDUP
 ;
 ;
STAT4CMT(FILE,STAT,LRSTATUS) ; Calculate status for comment nodes (eg BACT SMEAR)
 ; Inputs
 ;       FILE: The file # of the comment field in #63.
 ;       STAT: The status (eg F)
 ;   LRSTATUS:<byref>  Input and Output
 ; Outputs
 ;   LRSTATUS:
 N SUBF,FLD
 S (FLD,SUBF)=""
 ;
 I FILE=63.291 S SUBF=63.05,FLD=11.5 ; Bact Smear
 I FILE=63.341 S SUBF=63.05,FLD=15 ; Para Smear
 I FILE=63.371 S SUBF=63.05,FLD=19 ; Myco Smear
 ;
 I FLD,SUBF D BLDSTAT^LRVRMI4A(SUBF,FLD,STAT,.LRSTATUS)
 ;
 Q
 ;
 ;
RPTDT(LRDFN,LRIDT,SUBSCR,RPTDT,USER) ; File Report Approved Date and Person Reporting
 ; Inputs
 ;  LRDFN: LRDFN
 ;  LRIDT: LRIDT
 ; SUBSCR: MI Result Subscript (eg 19,21,23,24,25,26)
 ;  RPTDT: Report Approved Date/Time
 ;   USER: Person Reporting (#200)
 ; Outputs
 ;  Returns 0^ErrNum^ErrMsg on error, 1 on success
 N DIERR,FLDS,IEN,LRFDA,LRMSG,LRX
 ;
 S LRDFN=$G(LRDFN),LRIDT=$G(LRIDT),SUBSCR=$G(SUBSCR),(FLDS,LRX)=""
 ;
 I $G(RPTDT)'>0 S RPTDT=$$NOW^XLFDT()
 I $G(USER)="" S USER=$S($G(LRDUZ):LRDUZ,1:$G(DUZ))
 I LRDFN,LRIDT,SUBSCR S FLDS=$$NODE2FLD(SUBSCR)
 ;
 I FLDS'="" D
 . S IEN=LRIDT_","_LRDFN_","
 . S LRFDA(1,63.05,IEN,$P(FLDS,"^",1))=RPTDT
 . S LRFDA(1,63.05,IEN,$P(FLDS,"^",2))=USER
 . D FILE^DIE("","LRFDA(1)","LRMSG")
 . I '$D(LRMSG) S LRX=1 Q
 . S LRX="0^2^FileMan error"
 E  S LRX="0^1^No Field #s found"
 ;
 Q LRX
 ;
 ;
NODE2FLD(NODE) ; Resolve the fields to update based on the node
 ; Call with NODE = node in MI subscript to process
 ;
 ; Returns FIELDS = Report Date Approved^Person Reporting field #s
 ;
 N FIELDS
 S NODE=$G(NODE),FIELDS=""
 ;
 I NODE'="" D
 . I NODE?1(1"19",1"25",1"26",1"31") S FIELDS="11^11.55" Q
 . I NODE?1(1"23",1"29") S FIELDS="22^25.5" Q
 . I NODE?1(1"21",1"24",1"27") S FIELDS="14^15.5" Q
 . I NODE?1(1"15",1"22",1"28") S FIELDS="18^19.5" Q
 . I NODE?1(1"20",1"30") S FIELDS="33^35" Q
 ;
 Q FIELDS
