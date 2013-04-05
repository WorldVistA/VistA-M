LRUTIL2 ;DALOI/JDB -- Lab KIDS Utilities ;04/30/12  10:04
 ;;5.2;LAB SERVICE;**350**;Sep 27, 1994;Build 230
 ;
 ;File 19/10156
 ;
 Q
 ;
ENVCHK(CJ,LM,POS,QUIET) ;
 ; Perform basic environment checks
 N ERR
 S CJ=$G(CJ)
 S LM=$G(LM)
 S POS=$G(POS)
 S QUIET=$G(QUIET)
 S ERR=0
 I $S('$G(IOM):1,'$G(IOSL):1,$G(U)'="^":1,1:0) D  ;
 . I 'QUIET D BMES("Terminal Device is not defined.")
 . S ERR="1^1"
 ;
 I $S('$G(DUZ):1,$D(DUZ)[0:1,$D(DUZ(0))[0:1,1:0) D  ;
 . I 'QUIET D BMES("Please login to set local DUZ variables.")
 . S $P(ERR,"^",1)=1 S $P(ERR,"^",3)=1
 ;
 I $G(DUZ) I $P($$ACTIVE^XUSER(DUZ),"^")'=1 D  ;
 . I 'QUIET D BMES("You are not a valid user on this system.")
 . S $P(ERR,"^",1)=1 S $P(ERR,"^",4)=1
 Q ERR
 ;
BMES(STR,CJ,LM,POS) ;
 ; Display messages using BMES^XPDUTL or MES^XPDUTL
 ; Accepts single string or string array
 ; Inputs
 ;  STR:<byref><byval> The string to display.
 ;   CJ:<opt> Center text?  1=yes  0=no  <dflt=1>
 ;   LM:<opt> Left Margin (padding)  <dflt=0>
 ;  POS <opt> value for $$CJ^XLFSTR (80=default)
 ;
 N I,X
 S CJ=$G(CJ,1)
 S LM=$G(LM)
 S:LM<0 LM=0
 S POS=$G(POS)
 I POS'>1 S POS=$G(IOM,80)
 ; If an array, step through it and pass each node to MES
 ; since $$CJ^XLFSTR can't handle arrays
 I $D(STR)>9 D  ;
 . S I=0
 . F  S I=$O(STR(I)) Q:'I  D  ;
 . . D MES(STR(I),CJ,LM,POS)
 . ;
 ;
 I $D(STR)=1 D MES(STR,CJ,LM,POS)
 Q
 ;
MES(STR,CJ,LM,POS) ;
 ; Display a string using MES^XPDUTL
 ;  Inputs
 ;  STR:<byref>or<byval> String to display
 ;   CJ:<opt> Center text?  1=yes 0=1 <dflt=1>
 ;   LM:<opt> Left Margin (padding) dflt=0
 ;  POS:<opt> <dflt=IOM,80>
 N X,I,LRSTR2
 S CJ=$G(CJ,1)
 S LM=$G(LM)
 S POS=$G(POS)
 I LM<0 S LM=0
 I POS'>1 S POS=$G(IOM,80)
 I $G(STR)'="" S STR(.00001)=STR
 S I=0
 F  S I=$O(STR(I)) Q:'I  D  ;
 . S LRSTR2=STR(I)
 . I CJ S LRSTR2=$$TRIM^XLFSTR($$CJ^XLFSTR(LRSTR2,POS),"R"," ")
 . I 'CJ I LM S X="" S $P(X," ",LM)=" " S LRSTR2=X_LRSTR2
 . D MES^XPDUTL(LRSTR2)
 Q
 ;
ALERT(MSG,RECIPS) ;
 ; Send an Alert message.
 ; Inputs
 ;     MSG: Message text
 ;  RECIPS:<byref><opt> Array of Recipients <dflt=G.LMI>
 ;        : Set RECIPS("-G.LMI") to exclude LMI group.
 ;
 N DA,DIK,XQA,XQAMSG
 S XQAMSG=$G(MSG)
 S XQA("G.LMI")=""
 I $D(RECIPS) M XQA=RECIPS
 I $D(XQA("-G.LMI")) K XQA("G.LMI"),XQA("-G.LMI")
 Q:$D(XQA)'>9
 D SETUP^XQALERT
 Q
 ;
OPTOOO(LROPT,MODE) ;
 ;File 19/10156
 ; Mark Option Out of Order (OOO) or clear OOO.
 ; If the Option is already marked OOO, no action taken.
 ; If the Option was not marked OOO by this API, it will
 ; not be re-enabled by this API.
 ; Note: OPTDE^XPDUTL API doesnt work in ENV check.
 ; Inputs
 ;   LROPT: The OPTION name to act on.
 ;    MODE: 0 or 1 (0=disable  1=enable)
 ; Outputs
 ;   Mode=0
 ;     1 if the option was disabled, 0 if not (or already disabled)
 ;   Mode=1
 ;     1 if option enabled, 0 if not (or disabled previously)
 N R19,STATUS,LROOO,LRFDA,LRMSG,DIERR,OOM
 S LROPT=$G(LROPT)
 S MODE=$G(MODE)
 S STATUS=0
 S R19=$$FIND1^DIC(19,"","OX",LROPT,"B")
 I 'R19 Q "0^1^Option not found"
 K DIERR
 S OOM=$$GET1^DIQ(19,R19_",",2,"","","LRMSG")
 S LROOO=""
 I OOM="" I 'MODE D  ;
 . I $G(XPDNM)'="" S LROOO="OOO VIA "_$TR(XPDNM,"^","~")
 . I $G(XPDNM)="" S LROOO="OOO VIA OPTOOO~LRUTIL2"
 ;
 I OOM="" I MODE D  ;
 . S LROOO="@"
 ;
 ; pre-existing OOO message
 I OOM'="" I $G(XPDNM)'="" D  ;
 . I OOM'="OOO VIA "_$TR(XPDNM,"^","~") Q
 . I MODE S LROOO="@"
 I OOM'="" I $G(XPDNM)="" D  ;
 . I OOM'="OOO VIA OPTOOO~LRUTIL2" Q
 . I MODE S LROOO="@"
 ;
 I LROOO="" D  ;
 . I 'MODE S STATUS="0^2^Already OOO"
 . I MODE S STATUS="0^3^Can't re-enable"
 ;
 K DIERR,LRFDA
 I LROOO'="" D  ;
 . S LRFDA(1,19,R19_",",2)=$TR(LROOO,"^","~")
 . D FILE^DIE("","LRFDA(1)","LRMSG")
 . S STATUS=1
 Q STATUS
 ;
ENDDIOL(TXT,GBL,FMT,USENP,CHKABORT,ABORT,PGDATA) ;
 ; Substitute for EN^DDIOL API.
 ; Enhanced for pagination control.
 ; Inputs
 ;      TXT:<byval><byref> Text to display
 ;      GBL:<byval><opt> Global reference of text. (See EN^DDIOL)
 ;      FMT:<opt> Format array. (See EN^DDIOL)
 ;    USENP:<opt> Use NP (use pagination) 1=yes  0=no <dflt=0>
 ; CHKABORT:<opt> Check for user abort 1=check 0=dont  <dflt=0>
 ;    ABORT:<byref><opt> User abort status (output)
 ;   PGDATA:<byref><opt> Page Data array (see NP^LRUTIL)
 ; Outputs
 ;    Displays the text.
 ;   ABORT:
 ;  PGDATA:
 ;
 N NODE,ADDPRMPT
 S GBL=$G(GBL)
 S FMT=$G(FMT)
 S USENP=$G(USENP)
 S CHKABORT=$G(CHKABORT)
 ;
 I '$D(PGDATA) D  ;
 . Q:CHKABORT
 . S ADDPRMPT=1
 . S PGDATA("PROMPT")=$$TRIM^XLFSTR($$CJ^XLFSTR("'ENTER' to continue",$G(IOM,80)," "),"R"," ")
 I 'USENP D  ;
 . I $D(TXT) D  ;
 . . I $D(TXT)=1 D EN^DDIOL(TXT,"",FMT) Q
 . . D EN^DDIOL(.TXT)
 . I GBL'="" D EN^DDIOL("",GBL,FMT) Q
 Q:'USENP
 ;
 I $D(TXT) D  Q:CHKABORT&ABORT  ;
 . I $D(TXT)=1 S TXT(.0000001)=TXT
 . S NODE="TXT(0)"
 . F  S NODE=$Q(@NODE) Q:NODE=""  D  Q:CHKABORT&ABORT  ;
 . . D EN^DDIOL(@NODE,"",$S($D(TXT)=1:FMT,1:""))
 . . D NP^LRUTIL(.ABORT,.PGDATA)
 . . I CHKABORT Q:ABORT
 . K TXT(.0000001)
 ;
 I $G(ADDPRMPT) K PGDATA("PROMPT")
 Q
