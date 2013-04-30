LRVRMI4A ;DALOI/STAFF - LAH/TMP TO FILE 63 ;03/24/11  17:08
 ;;5.2;LAB SERVICE;**350**;Sep 27, 1994;Build 230
 ;
 ; Reference to global ^DD(filenumber,"GL") supported by ICR 999
 ; Extracts the information in the ^TMP("LRMI",$J) global and stores it into the Lab Data micro subfile.
 ;
 Q
 ;
N3 ;Process Organism
 ;
 N DIERR,IEN,LRFDA,LRIEN,LRIENS,LRMSG
 ;
 ;ZEXCEPT: LRDFN,LRDUZ,LRIDT,LRNOW
 ;
 S IEN=0
 F  S IEN=$O(^TMP("LRMI",$J,LRDFN,"MI",LRIDT,3,IEN)) Q:IEN<1  D N3A
 ;
 K LRFDA,LRIENS,LRMSG,DIERR
 S LRIEN=LRIDT_","_LRDFN_","
 S LRFDA(3,63.05,LRIEN,11)=LRNOW
 S LRFDA(3,63.05,LRIEN,11.55)=$S($G(LRDUZ):LRDUZ,1:$G(DUZ))
 D FILE^DIE("","LRFDA(3)","LRMSG")
 Q
 ;
 ;
N3A ; Process each organism
 ;
 N DATA,DIERR,DNFLDS,FLD,I,IEN2,ISOID
 N LRCSR,LRCMT,LRDATA,LRFDA,LRI,LRIEN,LRIENS,LRMSG,LRN3,LRX,R633,STAT
 ;
 ; ZEXCEPT: IEN,LRDFN,LRIDT,LRLL,LRPROF,LRSTATUS
 ;
 S LRN3=$G(^TMP("LRMI",$J,LRDFN,"MI",LRIDT,3,IEN,0))
 Q:LRN3=""
 S ISOID=$G(^TMP("LRMI",$J,LRDFN,"MI",LRIDT,3,IEN,.1))
 Q:ISOID=""
 ;
 ; Delete ISOID entry if it exists
 S R633=$O(^LR(LRDFN,"MI",LRIDT,3,"C",ISOID,0))
 I R633 D
 . K LRFDA,LRMSG
 . S LRIEN=R633_","_LRIDT_","_LRDFN_","
 . S LRFDA(3,63.3,LRIEN,.01)="@"
 . D FILE^DIE("","LRFDA(3)","LRMSG")
 ; existing ISOID was deleted so always add record
 ;
 S LRIEN="+1,"_LRIDT_","_LRDFN_","
 S LRFDA(3,63.3,LRIEN,.01)=$P(LRN3,U)
 S LRFDA(3,63.3,LRIEN,.1)=ISOID
 S LRFDA(3,63.3,LRIEN,1)=$P(LRN3,U,2)
 D UPDATE^DIE("","LRFDA(3)","LRIENS","LRMSG")
 S R633=$G(LRIENS(1))
 Q:'R633
 ;
 ; Store code system references
 S LRX=$G(^TMP("LRMI",$J,LRDFN,"MI",LRIDT,3,IEN,0,.01))
 F LRI=1:1:3 I $P(LRX,"^",LRI) D
 . N LRDATA
 . S LRDATA(.01)=LRDFN_",MI,"_LRIDT_",3,"_R633_",0"
 . S LRDATA(.02)=$S(LRI<3:2,1:3),LRDATA(.03)=$P(LRX,"^",LRI),LRDATA(.04)=$P("LN^NLT^SCT","^",LRI)
 . D SETREF^LRUCSR(LRDFN,LRDATA(.01),.LRDATA,1)
 ;
 ; Store performing lab
 S LRX=$G(^TMP("LRMI",$J,LRDFN,"MI",LRIDT,3,IEN,0,.01,1))
 I $P(LRX,"^") D SETPL^LRRPLUA(LRDFN_",MI,"_LRIDT_",3,"_R633_",0",$P(LRX,"^"))
 ;
 S STAT=$G(^TMP("LRMI",$J,LRDFN,"MI",LRIDT,3,IEN,0,.01,0))
 S STAT=$P(STAT,U,1)
 D BLDSTAT(63.05,11.5,STAT,.LRSTATUS)
 ;
 ; Process organism comments
 K LRFDA,LRIENS,LRMSG,DIERR
 M LRCMT=^LR(LRDFN,"MI",LRIDT,3,IEN,1)
 S IEN2=0
 F  S IEN2=$O(^TMP("LRMI",$J,LRDFN,"MI",LRIDT,3,IEN,1,IEN2)) Q:'IEN2  D
 . S DATA=^TMP("LRMI",$J,LRDFN,"MI",LRIDT,3,IEN,1,IEN2,0),DATA=$S(DATA'="":DATA,1:" ")
 . I DATA'=" ",$$DUPCHK^LRVRMI3(LRLL,LRPROF,.LRCMT,DATA) Q
 . S LRIEN="+"_IEN2_","_R633_","_LRIDT_","_LRDFN_","
 . S LRFDA(3,63.31,LRIEN,.01)=DATA
 I $D(LRFDA) D UPDATE^DIE("","LRFDA(3)","","LRMSG")
 ;
 ; Add drug susceptibilities
 S IEN2=2
 K LRFDA,LRIENS,LRMSG,DIERR
 F  S IEN2=$O(^TMP("LRMI",$J,LRDFN,"MI",LRIDT,3,IEN,IEN2)) Q:'IEN2  D
 . S STAT=$G(^TMP("LRMI",$J,LRDFN,"MI",LRIDT,3,IEN,IEN2,.01,0))
 . S STAT=$P(STAT,U,1)
 . D BLDSTAT(63.05,11.5,STAT,.LRSTATUS)
 . S LRIEN=R633_","_LRIDT_","_LRDFN_","
 . S DATA=^TMP("LRMI",$J,LRDFN,"MI",LRIDT,3,IEN,IEN2)
 . S DNFLDS=$$DN2FLDS(IEN2,,3)
 . F I=1:1:3 D  ;
 . . S FLD=$P(DNFLDS,"^",I)
 . . Q:'FLD
 . . S LRFDA(3,63.3,LRIEN,FLD)=$P(DATA,U,I)
 . S LRX=$G(^TMP("LRMI",$J,LRDFN,"MI",LRIDT,3,IEN,IEN2,.01))
 . F I=1:1:3 I $P(LRX,"^",I) S LRCSR(IEN2_";1",$S(I<3:2,1:3),$P("LN^NLT^SCT","^",I))=$P(LRX,"^",I)
 ; File susceptibilities
 I $D(LRFDA) D FILE^DIE("","LRFDA(3)","LRMSG")
 ;
 ; Store code system references
 I $D(LRCSR) D CSR(.LRCSR,LRDFN_",MI,"_LRIDT_",3,"_IEN_",")
 ;
 Q
 ;
 ;
N6 ; Process Parasite
 ;
 N DIERR,IEN,LRFDA,LRIEN,LRIENS,LRMSG
 ;
 ;ZEXCEPT: LRDFN,LRDUZ,LRIDT,LRLL,LRNOW,LRPROF,LRSTATUS
 ;
 S IEN=0
 F  S IEN=$O(^TMP("LRMI",$J,LRDFN,"MI",LRIDT,6,IEN)) Q:IEN<1  D N6A
 ;
 S LRIEN=LRIDT_","_LRDFN_","
 S LRFDA(6,63.05,LRIEN,14)=LRNOW
 S LRFDA(6,63.05,LRIEN,15.5)=$S($G(LRDUZ):LRDUZ,1:$G(DUZ))
 D FILE^DIE("","LRFDA(6)","LRMSG")
 Q
 ;
 ;
N6A ; Process individual parasite result
 ;
 N DIERR,IEN2,ISOID,LRFDA,LRI,LRIEN,LRIENS,LRMSG,LRN6,LRX,R6334,STAT
 ;
 ;ZEXCEPT: LRDFN,LRIDT,LRSTATUS,IEN
 ;
 S LRN6=$G(^TMP("LRMI",$J,LRDFN,"MI",LRIDT,6,IEN,0))
 Q:LRN6=""
 S ISOID=$G(^TMP("LRMI",$J,LRDFN,"MI",LRIDT,6,IEN,.1))
 Q:ISOID=""
 ; Delete ISOID if it exists
 S R6334=$O(^LR(LRDFN,"MI",LRIDT,6,"C",ISOID,0))
 I R6334 D
 . K LRFDA,LRMSG,LRIENS,DIERR
 . S LRIEN=R6334_","_LRIDT_","_LRDFN_","
 . S LRFDA(6,63.34,LRIEN,.01)="@"
 . D FILE^DIE("","LRFDA(6)","LRMSG")
 ;
 K LRFDA,LRMSG,LRIENS,DIERR
 S LRIEN="+1,"_LRIDT_","_LRDFN_","
 S LRFDA(6,63.34,LRIEN,.01)=LRN6
 S LRFDA(6,63.34,LRIEN,.1)=ISOID
 D UPDATE^DIE("","LRFDA(6)","LRIENS","LRMSG")
 S R6334=$G(LRIENS(1))
 Q:'R6334
 ;
 ; Store code system references
 S LRX=$G(^TMP("LRMI",$J,LRDFN,"MI",LRIDT,6,IEN,0,.01))
 F LRI=1:1:3 I $P(LRX,"^",LRI) D
 . N LRDATA
 . S LRDATA(.01)=LRDFN_",MI,"_LRIDT_",6,"_IEN_",0"
 . S LRDATA(.02)=$S(LRI<3:2,1:3),LRDATA(.03)=$P(LRX,"^",LRI),LRDATA(.04)=$P("LN^NLT^SCT","^",LRI)
 . D SETREF^LRUCSR(LRDFN,LRDATA(.01),.LRDATA,1)
 ;
 ; Store performing lab
 S LRX=$G(^TMP("LRMI",$J,LRDFN,"MI",LRIDT,6,IEN,0,.01,1))
 I $P(LRX,"^") D SETPL^LRRPLUA(LRDFN_",MI,"_LRIDT_",6,"_R6334_",0",$P(LRX,"^"))
 ;
 S STAT=$G(^TMP("LRMI",$J,LRDFN,"MI",LRIDT,6,IEN,0,.01,0))
 S STAT=$P(STAT,U,1)
 D BLDSTAT(63.05,15,STAT,.LRSTATUS)
 ;
 ; Stage results
 K LRFDA,LRMSG,LRIENS,DIERR
 S IEN2=0
 F  S IEN2=$O(^TMP("LRMI",$J,LRDFN,"MI",LRIDT,6,IEN,1,IEN2)) Q:'IEN2  D N6B
 ;
 Q
 ;
 ;
N6B ; Process Parasite Stage results
 ;
 N DATA,DIERR,IEN3,LRCMT,LRCSR,LRFDA,LRI,LRIEN,LRIENS,LRMSG,LRPL,LRX,R6335,STAGE,STAT
 ;
 ;ZEXCEPT: ISOID,LRDFN,LRIDT,LRLL,LRPROF,IEN,IEN2,LRSTATUS,R6334
 ;
 ; Delete STAGE if it exists
 S STAGE=$G(^TMP("LRMI",$J,LRDFN,"MI",LRIDT,6,IEN,1,IEN2,0))
 S STAGE=$P(STAGE,U,1)
 S R6335=$O(^LR(LRDFN,"MI",LRIDT,6,IEN,1,"B",ISOID,0))
 I R6335 D
 . K LRFDA,LRMSG,LRIENS,DIERR
 . S LRIEN=R6335_","_LRIDT_","_LRDFN_","
 . S LRFDA(6,63.35,LRIEN,.01)="@"
 . D FILE^DIE("","LRFDA(6)","LRMSG")
 ;
 K LRFDA,LRMSG,LRIENS,DIERR
 S LRIEN="+"_IEN2_","_R6334_","_LRIDT_","_LRDFN_","
 S DATA=$G(^TMP("LRMI",$J,LRDFN,"MI",LRIDT,6,IEN,1,IEN2,0))
 S LRFDA(6,63.35,LRIEN,.01)=$P(DATA,U,1) ;stage
 S LRFDA(6,63.35,LRIEN,1)=$P(DATA,U,2) ;qty
 D UPDATE^DIE("","LRFDA(6)","LRIENS","LRMSG")
 ;
 S R6335=$G(LRIENS(IEN2))
 Q:'R6335
 S STAT=$G(^TMP("LRMI",$J,LRDFN,"MI",LRIDT,6,IEN,1,IEN2,0,.01,0))
 S STAT=$P(STAT,U,1)
 ;
 ; Store code system references for stage
 S LRX=$G(^TMP("LRMI",$J,LRDFN,"MI",LRIDT,6,IEN,1,IEN2,.01))
 F LRI=1:1:3 I $P(LRX,"^",LRI) D
 . N LRDATA
 . S LRDATA(.01)=LRDFN_",MI,"_LRIDT_",6,"_R6334_",1,"_R6335_",0;1"
 . S LRDATA(.02)=$S(LRI<3:2,1:3),LRDATA(.03)=$P(LRX,"^",LRI),LRDATA(.04)=$P("LN^NLT^SCT","^",LRI)
 . D SETREF^LRUCSR(LRDFN,LRDATA(.01),.LRDATA,1)
 ;
 ; Store code system references for quantity
 S LRX=$G(^TMP("LRMI",$J,LRDFN,"MI",LRIDT,6,IEN,1,IEN2,1))
 F LRI=1:1:3 I $P(LRX,"^",LRI) D
 . N LRDATA
 . S LRDATA(.01)=LRDFN_",MI,"_LRIDT_",6,"_R6334_",1,"_R6335_",0;2"
 . S LRDATA(.02)=$S(LRI<3:2,1:3),LRDATA(.03)=$P(LRX,"^",LRI),LRDATA(.04)=$P("LN^NLT^SCT","^",LRI)
 . D SETREF^LRUCSR(LRDFN,LRDATA(.01),.LRDATA,1)
 ;
 ; Store performing lab
 S LRX=$G(^TMP("LRMI",$J,LRDFN,"MI",6,IEN,1,IEN2,0,.01,1))
 I $P(LRX,"^") D SETPL^LRRPLUA(LRDFN_",MI,"_LRIDT_",6,"_R6334_",1,"_R6335_",0",$P(LRX,"^"))
 ;
 D BLDSTAT(63.05,15,STAT,.LRSTATUS)
 ;
 ; get stage comments
 K LRFDA,LRMSG,LRIENS,DIERR
 M LRCMT=^LR(LRDFN,"MI",LRIDT,6,IEN,1,IEN2,1)
 S LRX=$G(^TMP("LRMI",$J,LRDFN,"MI",LRIDT,6,IEN,1,IEN2,1,0))
 S STAT=$P(LRX,U,4)
 D BLDSTAT(63.05,15,STAT,.LRSTATUS)
 S IEN3=0
 F  S IEN3=$O(^TMP("LRMI",$J,LRDFN,"MI",LRIDT,6,IEN,1,IEN2,1,IEN3)) Q:IEN3<1  D
 . S DATA=$G(^TMP("LRMI",$J,LRDFN,"MI",LRIDT,6,IEN,1,IEN2,1,IEN3,0)),DATA=$S(DATA'="":DATA,1:" ")
 . I DATA'=" ",$$DUPCHK^LRVRMI3(LRLL,LRPROF,.LRCMT,DATA) Q
 . S LRIEN="+"_IEN3_","_R6335_","_R6334_","_LRIDT_","_LRDFN_","
 . S LRFDA(6,63.351,LRIEN,.01)=DATA
 . I $P(LRX,"^") S LRPL(IEN3)=$P(LRX,"^")
 . I $P(LRX,"^",3) S LRCSR(IEN3,2,"LN")=$P(LRX,"^",3)
 ;
 I '$D(LRFDA) Q
 ;
 D UPDATE^DIE("","LRFDA(6)","LRIENS","LRMSG")
 ;
 ; Store performing lab
 S IEN3=0
 F  S IEN3=$O(LRPL(IEN3)) Q:'IEN3  I $G(LRIENS(IEN3)) D SETPL^LRRPLUA(LRDFN_",MI,"_LRIDT_",6,"_LRIENS(IEN3),LRPL(IEN3))
 ;
 ; Store code system references
 I $D(LRCSR) D CSR^LRVRMI4(.LRCSR,.LRIENS,LRDFN_",MI,"_LRIDT_",6,")
 Q
 ;
 ;
DN2FLDS(DN,FN,SUB) ;
 ; Convert a drug node to a field number
 ;File ^DD(filenumber,"GL")/999
 ; Inputs
 ;   DN : Drug Node (ie 2.0003)
 ;   FN : <opt> File Number (ie 63.3)
 ;  SUB : <opt> Subscript (ie 3)
 ;       : Note: either FN or SUB must be supplied
 ; Output
 ;   The three associated field numbers for the drug node
 ;     ie 15^15.1^15.2
 N FLDS,I,X
 S DN=$G(DN),FN=$G(FN),SUB=$G(SUB)
 S FLDS=""
 I FN="" D  ;
 . I SUB=3 S FN=63.3
 . I SUB=6 S FN=63.34
 . I SUB=9 S FN=63.37
 . I SUB=12 S FN=63.39
 . I SUB=17 S FN=63.43
 I $D(^DD(FN,"GL",DN)) D  ;
 . F I=1:1:3 S X=$O(^DD(FN,"GL",DN,I,0)) I X S $P(FLDS,"^",I)=X
 Q FLDS
 ;
 ;
BLDSTAT(FN,FLD,STAT,DATA) ;
 ; Builds the DATA array used for setting status(es)
 ; Inputs
 ;   FN : File Number  (ie 63.5)
 ;  FLD : Field Number  (ie 19)
 ; STAT : Status  (ie "F")
 ; DATA <byref> : See Outputs
 ;
 ; Outputs
 ; DATA <byref> : DATA(file#,field#)=status  DATA(63.05,19)="P"
 ;
 N CURR
 I $G(STAT)="" Q
 I STAT'?1(1"P",1"F",1"C") S STAT="P"
 S CURR=$G(DATA(FN,FLD))
 I CURR="" S DATA(FN,FLD)=STAT Q
 I CURR=STAT Q
 I CURR="P" Q
 I CURR="F" D
 . I STAT="P" S DATA(FN,FLD)="P" Q
 . I STAT="C" S DATA(FN,FLD)="C" Q
 Q
 ;
 ;
SETSTAT(DATA) ;
 ; Goes thru DATA array and files the status(es)
 ; Inputs
 ;   DATA <byref> : DATA(file#,field#)=status  ie DATA(63.05,19)="P"
 ; Outputs
 ;   DATA <byref> : Sets DATA(0)=overall status (P,F,C)
 ;
 N FLD,FN,LRFDA,LRIEN,LRMSG,NODE,STAT,STAT2
 ;
 ;ZEXCEPT: LRDFN,LRIDT
 ;
 S LRIEN=LRIDT_","_LRDFN_",",STAT2=""
 S NODE="DATA(0)"
 F  S NODE=$Q(@NODE) Q:NODE=""  D
 . S FN=$QS(NODE,1),FLD=$QS(NODE,2)
 . I 'FN!('FLD) Q
 . S STAT=DATA(FN,FLD)
 . ; derive "overall" status
 . ; P > C > F
 . I STAT2="" S STAT2=STAT
 . I STAT="P" S STAT2="P"
 . I STAT="C",STAT2'="P" S STAT2="C"
 . I STAT="F",STAT2'="C",STAT2'="P" S STAT2="F"
 . ;
 . ;convert "C" to "F"
 . I STAT="C" S STAT="F"
 . S LRFDA(1,FN,LRIEN,FLD)=STAT
 I $D(LRFDA) D FILE^DIE("","LRFDA(1)","LRMSG")
 S DATA(0)=STAT2
 Q
 ;
 ;
CSR(LRCSR,LRREF) ; Store code system references
 ; Call with LRCSR = array of ien/codes to store as references (pass by value)
 ;           LRREF = root of reference to build full reference to data
 ;
 N IEN,LRDATA,LRDATAREF,LRDFN,LRROOT,ROLE,TYPE
 ;
 S LRROOT="LRCSR",LRDFN=$P(LRREF,",")
 F  S LRROOT=$Q(@LRROOT) Q:LRROOT=""  D
 . S IEN=$QS(LRROOT,1),ROLE=$QS(LRROOT,2),TYPE=$QS(LRROOT,3),LRDATAREF=LRREF_IEN
 . S LRDATA(.01)=LRDATAREF,LRDATA(.02)=ROLE,LRDATA(.03)=LRCSR(IEN,ROLE,TYPE),LRDATA(.04)=TYPE
 . D SETREF^LRUCSR(LRDFN,LRDATAREF,.LRDATA,1)
 Q
