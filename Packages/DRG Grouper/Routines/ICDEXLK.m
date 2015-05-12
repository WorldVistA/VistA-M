ICDEXLK ;SLC/KER - ICD Extractor - Lookup ;12/19/2014
 ;;18.0;DRG Grouper;**57,67**;Oct 20, 2000;Build 1
 ;               
 ; Global Variables
 ;    ^ICDS(              N/A
 ;    ^TMP("ICD0")        SACC 2.3.2.5.1
 ;    ^TMP("ICD9")        SACC 2.3.2.5.1
 ;    ^TMP("ICDEXLK")     SACC 2.3.2.5.1
 ;               
 ; External References
 ;    $$DT^XLFDT          ICR  10103
 ;               
 ; Local Variables NEWed or KILLed Elsewhere
 ;     DIC,ICDFMT,ICDSYS,ICDVDT
 ; 
LK ; Lookup
 ;
 ; This is the Special Lookup program for files 80 and 80.1.
 ; Only the ^DIC call honors the special lookup routines. 
 ; Those calls that allow the user to specify the indexes 
 ; (IX^DIC and MIX^DIC1), and the Data Base Server calls 
 ; (FIND^DIC, $$FIND1^DIC, and UPDATE^DIE) all ignore the
 ; Special Lookup Program.  Also, if DIC(0) contains an 
 ; "I" then the Special Lookup program will be ignored.
 ; 
 ; Local Variables Newed or Killed by Calling Application
 ; 
 ;    Versioning Date (Fileman format) (OLD, CSV)
 ;    
 ;      ICDVDT or
 ;      ^TMP("ICDEXLK",$J,"ICDVDT"
 ;    
 ;          If supplied only active codes on that date
 ;          will be included in the selection list.
 ;               
 ;          If not supplied, the date will default to
 ;          TODAY and all codes may be selected, active
 ;          and inactive.
 ;    
 ;    Coding System (from file 80.4) (new)
 ;    
 ;      ICDSYS  or
 ;      ^TMP("ICDEXLK",$J,"ICDSYS"
 ;    
 ;            1    ICD    ICD-9-CM
 ;            2    ICP    ICD-9 Proc
 ;           30    10D    ICD-10-CM
 ;           31    10P    ICD-10-PCS
 ;    
 ;    Display Format (numeric, 1-4) (new)
 ;    
 ;      ICDFMT or
 ;      ^TMP("ICDEXLK",$J,"ICDFMT"
 ;    
 ;         1 = Fileman format, code and short text (default)
 ; 
 ;             250.00    DMII CMP NT ST UNCNTR
 ;    
 ;         2 = Fileman format, code and description
 ;    
 ;             250.00    DIABETES MELLITUS NO MENTION OF
 ;                       COMPLICATION, TYPE II OR UNSPECIFIED TYPE
 ;    
 ;         3 = Lexicon format, short text followed by code
 ;    
 ;             DMII CMP NT ST UNCNTR (250.00)
 ;    
 ;         4 = Lexicon format, description followed by code
 ;    
 ;             DIABETES MELLITUS NO MENTION OF COMPLICATION,
 ;             TYPE II OR UNSPECIFIED TYPE (250.00)
 ;    
 ; Special Lookup
 ;    ^DD(80,0,"DIC")="ICDEXLK"
 ;    ^DD(80.1,0,"DIC")="ICDEXLK"
 ;   
 ; FileMan Variables
 ; 
 ; X          If DIC(0) does not contain an A, then the variable
 ;            X must be defined
 ;            
 ; DIC        Global root or File Number
 ; 
 ;                ^ICD9( or 80
 ;                ^ICD0( or 80.1
 ; 
 ; DIC(0)     (Optional) A string of characters which alter how
 ;            DIC responds. Default value for ICD files "AEM"
 ; 
 ;            Applicable to a versioned lookup
 ;               A   Ask
 ;               E   Echo
 ;               F   Forget lookup value
 ;               I   Ignore lookup program
 ;               O   Find one exact match
 ;               Q   Question Input ??
 ;               S   Suppresses display of .01
 ;               X   EXact match required 
 ;               Z   Expand output Y variable
 ;       
 ;            Not Applicable/Used in a versioned lookup
 ;            
 ;               C, B, K, L, M, N, n, U, T and V
 ;    
 ; DIC("A")   (Optional) A prompt that is displayed prior to the 
 ;            reading of the X input.  
 ;                        
 ; DIC("B")   (Optional) The default answer which is presented to
 ;            the user when the lookup prompt is issued. 
 ;            
 ; DIC("S")   (Optional) DIC("S") Screen M code that sets the
 ;            value of $T.  
 ; 
 ; DIC("W")   (Optional) An M command string displays each entry
 ;            that matches the user's input 
 ;            
 ; DIC("?N",<file>)=n 
 ;            (Optional) The number "n" should be an integer set
 ;            to the number of entries to be displayed
 ;
 ; FileMan Variables KILLed:  DLAYGO and DINUM
 ; 
 ; Output
 ;
 ;    Y  IEN ^ Code           Fileman
 ;    
 ;    If DIC(0) contains "Z"
 ;    
 ;       Y(0)     0 Node               Fileman
 ;       Y(0,0)   Code                 Fileman
 ;       Y(0,1)   $$ICDDX or $$ICDOP   Non-Fileman
 ;       Y(0,2)   Long Description     Non-Fileman
 ;   
 K ^TMP("ICD9",$J),^TMP("ICD0",$J) D DIE^ICDEXLK6
 N DIRUT,DIROUT,FILE,ROOT,SUB,SBI,ICDDICA,ICDDICB,ICDDICN,ICDDICW,ICDDICS,ICDDICST
 N ICDDIC0,ICDOLD0,ICDDIC00,ICDCDT,ICDCSY,ICDISF,ICDOUT,ICDVER,ICDX,ICDXP,KEY,INP,INP2,INP1
 N INPE,ERR,ICDOFND,ICDOSEL,ICDOINP,ICDREDO,ICDOREV,ICDISCD,ICDOUPA,ICDOTIM,ICDOPTR,ICDOVAL
 S (ICDOFND,ICDOSEL,ICDOREV,ICDOUPA,ICDOTIM)=0,ICDXP=$$XT^ICDEXLK6($G(X)),ICDOPTR=+($O(DICR(" "),-1))
 K DLAYGO,DINUM S (ICDOINP,ICDX)=$$XT^ICDEXLK6($S($E($G(X),1)'=" ":$$TM^ICDEXLK6($G(X)),1:$G(X)))
 K X,Y,DTOUT,DUOUT S ICDCSY=0,ROOT=$G(DIC),FILE=$$FILE^ICDEX(ROOT),ICDOVAL=1
 I "^80^80.1^"'[("^"_FILE_"^") S ERR="Invalid File" G ERR
 S ROOT=$$ROOT^ICDEX(FILE)
 I "^ICD9(^ICD0(^"'[("^"_$E(ROOT,2,$L($G(ROOT)))_"^") S ERR="Invalid Global Root" G ERR
 ; Exact code entered, no subordinates
 I $L($G(ICDXP)),$G(DIC(0))'["A" D
 . N ICDTMP F ICDTMP=ICDXP,($TR(ICDXP,"""","")_".") D  Q:$G(ICDX)["`"
 . . N ICD0,ICD1,ICD2,ICDF S ICD0=$TR(ICDTMP,"""","")
 . . S ICD1=$O(@(ROOT_"""BA"","""_ICD0_""",0)"))
 . . S ICD2=$O(@(ROOT_"""BA"","""_ICD0_""","" "")"),-1)
 . . I ICD1>0,ICD1=ICD2 S (X,ICDX)="`"_+ICD1 Q
 . . S ICD1=$O(@(ROOT_"""BA"","""_ICD0_" "",0)"))
 . . S ICD2=$O(@(ROOT_"""BA"","""_ICD0_" "","" "")"),-1)
 . . I ICD1>0,ICD1=ICD2 S (X,ICDX)="`"_+ICD1
 I $G(ICDX)[";" D
 . N ICD1,ICD2,ICD3 S ICD1=$P(ICDX,";",1),ICD2=("^"_$P(ICDX,";",2))
 . Q:ICD2'=DIC  Q:ICD1'?1N.N  S ICD3=$P($G(@(ROOT_+ICD1_",0)")),"^",1)
 . I $D(@(ROOT_+ICD1_",0)")) S (X,ICDX)="`"_+ICD1
 ;   System
 S ICDCSY=0
 S:$L($G(ICDSYS)) ICDCSY=$G(ICDSYS)
 S:'$L($G(ICDSYS))&($L($G(^TMP("ICDEXLK",$J,"ICDSYS")))) ICDCSY=$G(^TMP("ICDEXLK",$J,"ICDSYS"))
 S ICDCSY=$$SYS^ICDEX($G(ICDCSY))
 ;   Date
 S:$L($G(ICDVDT)) ICDCDT=$G(ICDVDT)
 S:'$L($G(ICDVDT))&($L($G(^TMP("ICDEXLK",$J,"ICDVDT")))) ICDCDT=$G(^TMP("ICDEXLK",$J,"ICDVDT"))
 ;   Format
 S ICDOUT=0 S:$L($G(ICDFMT)) ICDOUT=$G(ICDFMT)
 I $D(DDS) S:$D(ICDFMT) ICDFMT=1 S ICDOUT=1
 S:'$L($G(ICDFMT))&($L($G(^TMP("ICDEXLK",$J,"ICDFMT")))) ICDOUT=$G(^TMP("ICDEXLK",$J,"ICDFMT"))
 S:+ICDOUT'>0 ICDOUT=1 S:+ICDOUT>4 ICDOUT=1
 S:$L($G(ICDFMT))!($L($G(^TMP("ICDEXLK",$J,"ICDFMT")))) ICDISF=1
 ;   Versioned Lookup
 S ICDVER=$S($G(ICDCDT)?7N:1,1:0)  S:$G(ICDCDT)'?7N ICDCDT=$$DT^XLFDT
 ;   Enforce Business Rule for Date
 I ICDVER'>0 S:$D(^ICDS(+ICDCSY,0)) ICDCDT=$$DTBR^ICDEX(ICDCDT,,+($G(ICDCSY)))
 ;   Space Bar Return (passed)
 I $D(ICDX),$G(ICDX)=" ",DIC(0)'["A" D SBR^ICDEXLK2 S:+($G(Y))>0&(X'=ICDX) ICDX=X G:+($G(Y))>0 QUIT K Y
 ;   TMP global
 S SUB=$TR(ROOT,"^(","") K ^TMP(SUB,$J)
 ;   Save DIC
 S ICDDICA=$G(DIC("A")),ICDDICB=$G(DIC("B")),ICDDICW=$G(DIC("W"))
 S ICDDICS="",ICDDICST=$$DICS^ICDEXLK6($G(DIC("S"))) S:$L($G(ICDDICST)) ICDDICS=ICDDICST
 S ICDDICN=$G(DIC("?N",FILE)) S:+ICDDICN'>0 ICDDICN=5
 S ICDDIC00=$G(DIC(0)),(ICDDIC0,DIC(0))=$$DIC0^ICDEXLK6($G(DIC(0)))
 K:+($G(ICDISF))>0 DIC("W") K:$D(DDS) DIC("W")
 I $L($G(ICDX))'>4,ICDX'["." D
 . S:ICDX?3N&($D(@(ROOT_"""BA"","""_ICDX_". "")"))) ICDX=ICDX_".",ICDXP=ICDXP_"."
 . S:$E(ICDX,1)="E"&($E(ICDX,2,4)?3N)&($D(@(ROOT_"""BA"","""_ICDX_". "")"))) ICDX=ICDX_".",ICDXP=ICDXP_"."
 . S:$E(ICDX,1)?1U&($E(ICDX,2,3)?2N)&($D(@(ROOT_"""BA"","""_ICDX_". "")"))) ICDX=ICDX_".",ICDXP=ICDXP_"."
 I ICDX="?",$G(DIC(0))'["A" D  I $L($G(DIE)),$L($G(DIC)),$G(DIE)'=$G(DIC) S Y=-1 W:'$D(DDS) ! Q
 . D INPH^ICDEXLK2(FILE) S ICDX="" S:$G(DIC(0))'["A" DIC(0)=DIC(0)_"A"
 I ICDX="??",$G(DIC(0))'["A" D  I $L($G(DIE)),$L($G(DIC)),$G(DIE)'=$G(DIC) S Y=-1 W:'$D(DDS) ! Q
 . D INPH2^ICDEXLK2(FILE) S ICDX="" S:$G(DIC(0))'["A" DIC(0)=DIC(0)_"A"
LKR ; Lookup Recursive
 S:$G(DIC(0))'["A"&($L($G(ICDX)))&('$L($G(X))) X=ICDX
 S (INPE,ICDOFND)=0,ICDOVAL=1 S:'$L($G(DIC(0))) DIC(0)="AEM" S ICDREDO=""
 S:$L($G(DIC(0))) DIC(0)=$TR(DIC(0),"CL","")
 ;   User Input
 I +($G(ICDOREV))>0 D
 . S (ICDOFND,ICDOSEL,ICDOREV)=0 K X S ICDX=""
 S (ICDOUPA,ICDOTIM)=0 I $G(DIC(0))["A" D
 . N ICDT S ICDOVAL=1,X=$$INP^ICDEXLK2(FILE,$G(ICDVER),$G(ICDCDT)) S ICDT=$$XT^ICDEXLK6(X)
 . S:ICDT'=X ICDOVAL=0,X=ICDT
 I '$L($G(X)),$G(DIC(0))'["T",+($G(ICDOUPA))'>1,+($G(ICDOVAL))>0 S X="",ICDOREV=1 G ERR
 I '$L($G(X)),+($G(ICDOVAL))'>0,+($G(ICDOUPA))'>0,+($G(ICDOTIM))'>0 D  G LKR
 . W:ICDOUPA'>0&(ICDOTIM'>0)&('$D(DDS)) " ??"
 S:ICDOTIM>0 DTOUT=1 G:ICDOTIM>0 ERR S:ICDOUPA>0 DUOUT=1 G:ICDOUPA>0 ERR
 I ($G(DIC(0))["A"),('$L($G(X))!(X="^")),$G(DIC(0))["T" S X="" K Y G LKR
 I $G(DIC(0))'["A"&($L($G(ICDX))) S X=$G(ICDX)
 I $G(X)["^" S DUOUT="" G ERR
 I '$L($G(X)) G ERR
 S X=$$TM^ICDEXLK6(X),INP=X,INP1=$E(INP,1),INP2=$E(INP,2,245) S:INP1="`"&(INP2?1N.N) INPE=1
 ;   Search #1 - Forced IEN
 K Y S (ICDOUPA,ICDOTIM)=0 I INPE>0 D
 . D IEN^ICDEXLK5 S ICDOUPA=+($G(ICDOUPA)),ICDOTIM=+($G(ICDOTIM))
 . S:+($G(Y))>0&($L($P($G(Y),"^",2))>0) (ICDX,X)=$P($G(Y),"^",2)
 . I '$L($G(X)),+($G(Y))<0,$G(DIC(0))'["A" D  Q
 . . S (X,ICDX,ICDXP,INP,INP1,INP2)="",Y="-1^No Selection Made"
 . . S:$L($G(DICR("1"))) DICR("1")=""
 . I +($G(ICDOFND))'>0,$G(DIC(0))["Q" D
 . . W:(ICDOPTR'>0)&(ICDOUPA'>0)&(ICDOTIM'>0)&('$D(DDS))&(+($G(ICDOREV))'>0) " ??"
 . . W:(ICDOPTR>0)&('$D(DDS)) !
 . I +($G(ICDOFND))'>0 S (ICDX,X)="",Y=-1 S:$D(ICDOINP) ICDOINP=""
 ;     Abort Search #1
 I INPE>0,'$L($G(X)),+($G(Y))<0,$G(DIC(0))'["A" G QUIT
 I INPE>0,$L($G(X)),+($G(Y))>0,$P($G(Y),"^",2)=$G(X) G QUIT
 I INPE>0 G:($L($G(X))&(+($G(Y))>0))!($G(ICDOUPA)=2) QUIT G:+($G(ICDOTIM))>0 QUIT
 I INPE>0 G:(+($G(ICDOFND))'>0!($G(ICDOUPA)=1))&($G(DIC(0))["A") LKR
 I INPE>0 G:+($G(ICDOFND))>0&($G(ICDOSEL)'>0)&($G(ICDOREV)>0)&($G(DIC(0))["A") LKR
 I $D(Y) S:+Y<0 X=INP G QUIT
 ;   Search #2 - Lookup X
 S (ICDOUPA,ICDOTIM)=0 N LOUD S LOUD="" S ICDX=X I +($G(ICDOFND))'>0 D
 . ;     Text Search
 . S:$L($G(ICDX))&($L($G(ICDX))>1) ICDOFND=$$LK^ICDEXLK3($G(X),FILE,ICDCDT,ICDCSY,ICDVER,ICDOUT)
 . ;     Code Search
 . S:$L($G(ICDX))&($L($G(ICDX))'>1) ICDOFND=$$CD^ICDEXLK3($G(X),FILE,ICDCDT,ICDCSY,ICDVER,ICDOUT)
 . S ICDOFND=+($G(ICDOFND)) S:$L($G(ICDX)) X=$G(ICDX)
 ;     Abort Search #2
 I +($G(ICDOFND))'>0,$G(DIC(0))["Q" D
 . W:(ICDOPTR'>0)&('$D(DDS))&(+($G(ICDOREV))'>0) " ??"
 I +($G(ICDOFND))'>0,$L($G(INP)),$E(INP,1)'=" ",$G(DIC(0))["A" K ICDX,X,Y,INP,INP1,INP2 G LKR
 S:+($G(ICDOFND))'>0 X=$G(INP)
 ;     Nothing Found
 I +($G(ICDOFND))'>0,$G(DIC(0))'["T" D  G QUIT
 . W:$G(DIC(0))["E"&(ICDOPTR'>0)&('$D(DDS)) !,"  No matches found"
 . S X=$S($L($G(INP)):INP,1:$G(X)),Y="-1^No matches found"
 I +($G(ICDOFND))'>0,$G(DIC(0))["T" K Y G LKR
 ;     Results found
 S (ICDOUPA,ICDOTIM)=0 D ASK^ICDEXLK2 G:$D(DTOUT) ERR
 S:ICDOTIM>0 DTOUT=1 G:ICDOTIM>0 ERR
 I +($G(ICDOUPA))>1 S DUOUT=1 W:'$D(DDS) ! G QUIT
 G:+($G(ICDOUPA))=1&(DIC(0)'["A") QUIT
 G:+($G(ICDOUPA))=1&(DIC(0)["A") LKR
 I +($G(ICDOFND))>0,+($G(ICDOSEL))'>0,+($G(ICDOREV))>0,+($G(ICDOPTR))>0 D  G QUIT
 . S X=ICDX S:$G(DIC(0))'["A" (ICDX,INP1,INP2,ICDOINP,X)="",Y="-1^No selection made"
 I +($G(ICDOFND))>0,+($G(ICDOSEL))'>0,+($G(ICDOREV))>0,+($G(ICDOPTR))'>0 D  G:$G(ICDOUPA)>1!($G(DIC(0))'["A") QUIT G:DIC(0)["A" LKR
 . S (ICDX,INP1,INP2,ICDOINP,X)="",Y="-1^No selection made"
 G:+($G(Y))'>0 ERR D QUIT
 Q
LKQ ;   Quit
 Q
ERR ;   Quit On Error/Time Out
 N ICDX,ICDY S ICDY=$G(Y),ICDX=$G(X) K X,Y S Y=-1
 S:$L($P($G(ICDY),"^",2)) Y=Y_"^"_$P($G(ICDY),"^",2)
 I $G(ICDOTIM)>0,$G(DIC(0))["E",'$D(DDS) W !!,?2,"Try again later" K ERR
 I $G(ICDOUPA)>0,$G(DIC(0))["E" K ERR
 I $G(ICDOUPA)>0,+($G(ICDOFND)>0),+($G(ICDOSEL)'>0),$G(DIC(0))["E" K ERR
 I $L($G(ERR)),$G(DIC(0))["E",'$D(DDS) W !!,?2,$G(ERR)
 S:$E(ICDY,1,2)="-1"&($L($P($G(ICDY),"^",2))) Y=ICDY S X=ICDX
 I $E(Y,1,2)="-1",+($G(ICDOFND)>0),+($G(ICDOSEL)'>0) S Y="-1^No Selection Made"
 D QUIT
 Q
QUIT ;   Quit without Error
 K DUOUT,DTOUT S:ICDOUPA=1 DUOUT=1,X="^",Y="-1^Search aborted (up-arrow detected)"
 S:ICDOUPA=2 DUOUT=1,X="^^",Y="-1^Search aborted (double up-arrow detected)"
 S:ICDOTIM>0 DTOUT=1,X="",Y="-1^Search aborted (timed out)" Q:$D(DUOUT)!($D(DTOUT))
 I $G(ICDOFND)>0,$G(ICDOREV)>0,$G(ICDOSEL)'>0 S X="",Y="-1^No Selection Made" Q
 I '$L(($G(ICDX)_$G(X))),+Y<0,'$L($P($G(Y),"^",2)),$G(DIC(0))'["A" S Y="-1^No user input" Q
 D:+Y>0 Y^ICDEXLK2($G(ROOT),+Y,$G(ICDCDT))
 I $P($G(X),"`",2)=$P($G(Y),"^",1),$L($P($G(Y),"^",2)) S (ICDX,X)=$P($G(Y),"^",2)
 I +($G(Y))>0,X=$P($G(Y),"^",1),$L($P($G(Y),"^",2)) S (ICDX,X)=$P($G(Y),"^",2)
 I X=" ",$P($G(Y),"^",1)>0,$L($P($G(Y),"^",2)),$D(@(ROOT_+($P($G(Y),"^",1))_",0)")) S X=$P($G(Y),"^",2)
 D DICU^ICDEXLK6 I $D(DDS) S:$L($G(ICDOINP))&(+Y'>0) X=$G(ICDOINP)
 I ICDOTIM'>0,$G(DIC(0))["A",$L($G(INP)),+($G(Y))>0,$L($P($G(Y),"^",2)) S (ICDX,X)=INP
 S:$L($G(ICDX)) X=$G(ICDX) S X=$G(X) D RED
 Q
RED ;   Re-Display
 Q:+($G(Y))'>0  Q:'$L($P($G(Y),"^",2))  Q:$G(FILE)'>0  Q:$D(DDS)  Q:$G(DIC(0))'["E"
 Q:ICDOPTR>1  N CODE,EXP,CC,STA S CODE=$P(Y,"^",2) S CODE=CODE_$J(" ",(10-$L($G(CODE))))
 S CC="" S:FILE=80 CC=$$VCC^ICDEX(+Y,$G(ICDCDT))
 S CC=$S(CC="1":" (CC)",CC="2":" (Major CC)",1:"")
 S STA=$O(@(ROOT_+Y_",66,""B"","_(+($G(ICDCDT))+.000001)_")"),-1)
 S STA=$O(@(ROOT_+Y_",66,""B"","_+STA_","" "")"),-1)
 S STA=$P($G(@(ROOT_+Y_",66,"_+STA_",0)")),"^",2)
 S STA=$S($G(STA)?1N&(+$G(STA)'>0):" (Inactive)",$G(STA)'?1N&(+$G(STA)'>0):" (Pending)",1:"")
 S:$G(ICDFMT)=2!($G(ICDFMT)=4) EXP=$$VLT^ICDEX(FILE,+Y,$G(ICDCDT))
 S:$G(ICDFMT)=1!($G(ICDFMT)=3)!($G(ICDFMT)="") EXP=$$VST^ICDEX(FILE,+Y,$G(ICDCDT))
 W:$L($G(CODE))&($L($G(EXP)))&($D(DPP(1))) !,?5 W:$L($G(CODE))&($L($G(EXP))) "   ",$G(CODE),$G(EXP),$G(CC),$G(STA)
 Q
CLR ; Clear Environment
 K DDS,DICR N ICDTEST,DPP,DR
 Q
