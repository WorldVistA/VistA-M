ICDEXLK ;SLC/KER - ICD Extractor - Lookup ;04/21/2014
 ;;18.0;DRG Grouper;**57**;Oct 20, 2000;Build 1
 ;               
 ; Global Variables
 ;    ^ICDS(              N/A
 ;    ^TMP("ICD0")        SACC 2.3.2.5.1
 ;    ^TMP("ICD9")        SACC 2.3.2.5.1
 ;    ^TMP("ICDEXLK")     SACC 2.3.2.5.1
 ;               
 ; External References
 ;    ^DIM                ICR  10016
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
 ;               If supplied only active codes on that date
 ;               will be included in the selection list.
 ;               
 ;               If not supplied, the date will default to
 ;               TODAY and all codes may be selected, active
 ;               and inactive.
 ;               
 ;               In both cases the display will be altered
 ;               based on the date.
 ;    
 ;    Coding System (from file 80.4) (new)
 ;    
 ;      ICDSYS  or
 ;      ^TMP("ICDEXLK",$J,"ICDSYS"
 ;    
 ;                1    ICD    ICD-9-CM
 ;                2    ICP    ICD-9 Proc
 ;               30    10D    ICD-10-CM
 ;               31    10P    ICD-10-PCS
 ;    
 ;    Display Format (numeric, 1-4) (new)
 ;    
 ;      ICDFMT or
 ;      ^TMP("ICDEXLK",$J,"ICDFMT"
 ;    
 ;             1 = Fileman format, code and short text (default)
 ; 
 ;                 250.00    DMII CMP NT ST UNCNTR
 ;    
 ;             2 = Fileman format, code and description
 ;    
 ;                 250.00    DIABETES MELLITUS NO MENTION OF
 ;                           COMPLICATION, TYPE II OR UNSPECIFIED
 ;                           TYPE, NOT STATED AS UNCONTROLLED
 ;    
 ;             3 = Lexicon format, short text followed by code
 ;    
 ;                 DMII CMP NT ST UNCNTR (250.00)
 ;    
 ;             4 = Lexicon format, description followed by code
 ;    
 ;                 DIABETES MELLITUS NO MENTION OF COMPLICATION,
 ;                 TYPE II OR UNSPECIFIED TYPE, NOT STATED AS
 ;                 UNCONTROLLED (250.00)
 ;    
 ; Special Lookup
 ;    ^DD(80,0,"DIC")="ICDEXLK"
 ;    ^DD(80.1,0,"DIC")="ICDEXLK"
 ;   
 ; FileMan Variables
 ; 
 ; X          If DIC(0) does not contain an A, then the variable
 ;            X must be defined equal to the value you want to 
 ;            find in the requested Index(es). 
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
 ;               A   Ask the entry; if erroneous, ask again
 ;               E   Echo information
 ;               F   Forget the lookup value
 ;               I   Ignore the special lookup program
 ;               M   Multiple-index lookup allowed
 ;               O   Only find one entry if it matches exactly
 ;               S   Suppresses display of .01
 ;               X   EXact match required 
 ;               Z   Zero node in Y(0), external form in Y(0,0)  
 ;       
 ;            Not Applicable to a versioned lookup
 ;               C   Versioned cross-references not turned off
 ;               B   There is no B index to use
 ;               K   Primary Key not established
 ;               L   Learning a new entry LAYGO not allowed
 ;               N   Uppercase, IEN lookup allowed (not forced)
 ;               n   ICD has no pure numeric entries
 ;               Q   Input is pre-processed, ?? not necessary
 ;               U   All values are external
 ;               T   All versioned Indexes are used
 ;               V   Verification is not optional
 ;    
 ; DIC("A")   (Optional) A prompt that is displayed prior to the 
 ;            reading of the X input. If DIC("A") is not defined,
 ;            a prompt will be supplied by the special lookup
 ;            routines.
 ;            
 ; DIC("B")   (Optional) The default answer which is presented to
 ;            the user when the lookup prompt is issued. If a
 ;            terminal user simply presses the Enter/Return key,
 ;            the DIC("B") default value will be used, and
 ;            returned in X. DIC("B") will only be used if it is
 ;            non-null. 
 ;            
 ; DIC("S")   (Optional) DIC("S") is a string of M code that DIC 
 ;            executes to screen an entry from selection. 
 ;            DIC("S") must contain an IF statement to set the
 ;            value of $T. Those entries that the IF sets as 
 ;            $T=0 will not be displayed or selectable. If the
 ;            DIC("S") code is executed, the local variable Y is
 ;            the internal number of the entry being screened
 ;            and the M naked indicator is at the global level
 ;            @(DIC_"Y,0)"). 
 ; 
 ; DIC("W")   (Optional) An M command string which is executed
 ;            when DIC displays each of the entries that match
 ;            the user's input. The condition of the variable
 ;            Y and of the naked indicator is the same as for
 ;            DIC("S"). If DIC("W") is defined, it overrides
 ;            the display of any identifiers of the file. Thus,
 ;            if DIC("W")="", the display of identifiers will
 ;            be suppressed. 
 ;            
 ; DIC("?N",<file>)=n 
 ;            (Optional) The number "n" should be an integer set
 ;            to the number of entries to be displayed on the
 ;            screen at one time when using "?" help in a lookup. 
 ;
 ; FileMan Variables not used:
 ; 
 ;            DIC("DR")
 ;            DIC("PTRIX",<from>,<to>,<file>)
 ;            DIC("T")
 ;            DIC("V")
 ;            DIC("?PARAM",<file>,"INDEX")
 ;            DIC("?PARAM",<file>,"FROM",<subscript>)
 ;            DIC("?PARAM",<file>,"PART",<subscript>)
 ;            
 ; FileMan Variables KILLed:
 ; 
 ;            DLAYGO
 ;            DINUM
 ; 
 ; Output
 ;
 ;    Y        IEN ^ Code           Fileman
 ;    
 ;    If DIC(0) contains "Z"
 ;    
 ;       Y(0)     0 Node               Fileman
 ;       Y(0,0)   Code                 Fileman
 ;       Y(0,1)   $$ICDDX or $$ICDOP   Non-Fileman
 ;       Y(0,2)   Long Description     Non-Fileman
 ;   
 K ^TMP("ICD9",$J),^TMP("ICD0",$J) D DIE
 N DIRUT,DIROUT,FILE,ROOT,SUB,SBI,FND,ICDDICA,ICDDICB,ICDDICN,ICDDICW,ICDDICS,ICDDICSS
 N ICDDICST,ICDDIC0,ICDOLD0,ICDDIC00,ICDCDT,ICDCSY,ICDISF,ICDOUT,ICDVER,ICDX,ICDXP,KEY,INP,INP2,INP1,ERR
 N ICDOFND,ICDOSEL,ICDOINP,ICDREDO,ICDOREV,ICDISCD,ICDOUPA
 S (ICDOFND,ICDOSEL,ICDOREV,ICDOUPA)=0,ICDXP=$G(X)
 K DLAYGO,DINUM S (ICDOINP,ICDX)=$S($E($G(X),1)'=" ":$$TM($G(X)),1:$G(X))
 K X,Y,DTOUT,DUOUT S ICDCSY=0,ROOT=$G(DIC),FILE=$$FILE^ICDEX(ROOT)
 I "^80^80.1^"'[("^"_FILE_"^") S ERR="Invalid File" G ERR
 S ROOT=$$ROOT^ICDEX(FILE)
 I "^ICD9(^ICD0(^"'[("^"_$E(ROOT,2,$L(ROOT))_"^") S ERR="Invalid Global Root" G ERR
 I $L(ICDXP) D
 . N ICD0,ICD1,ICD2 S ICD0=$TR(ICDXP,"""",""),ICD1=$O(@(ROOT_"""BA"","""_ICD0_""",0)"))
 . S ICD2=$O(@(ROOT_"""BA"","""_ICD0_""","" "")"),-1) I ICD1>0,ICD1=ICD2 S (X,ICDX)="`"_+ICD1
 I $G(ICDX)[";" D
 . N ICD1,ICD2 S ICD1=$P(ICDX,";",1),ICD2=("^"_$P(ICDX,";",2))
 . Q:ICD2'=DIC  Q:ICD1'?1N.N  S:$D(@(ROOT_+ICD1_",0)")) (X,ICDX)="`"_+ICD1
 ; System
 S ICDCSY=0
 S:$L($G(ICDSYS)) ICDCSY=$G(ICDSYS)
 S:'$L($G(ICDSYS))&($L($G(^TMP("ICDEXLK",$J,"ICDSYS")))) ICDCSY=$G(^TMP("ICDEXLK",$J,"ICDSYS"))
 S ICDCSY=$$SYS^ICDEX($G(ICDCSY))
 ; Date
 S:$L($G(ICDVDT)) ICDCDT=$G(ICDVDT)
 S:'$L($G(ICDVDT))&($L($G(^TMP("ICDEXLK",$J,"ICDVDT")))) ICDCDT=$G(^TMP("ICDEXLK",$J,"ICDVDT"))
 ; Format
 S ICDOUT=0 S:$L($G(ICDFMT)) ICDOUT=$G(ICDFMT)
 I $D(DDS) S:$D(ICDFMT) ICDFMT=1 S ICDOUT=1
 S:'$L($G(ICDFMT))&($L($G(^TMP("ICDEXLK",$J,"ICDFMT")))) ICDOUT=$G(^TMP("ICDEXLK",$J,"ICDFMT"))
 S:+ICDOUT'>0 ICDOUT=1 S:+ICDOUT>4 ICDOUT=1
 S:$L($G(ICDFMT))!($L($G(^TMP("ICDEXLK",$J,"ICDFMT")))) ICDISF=1
 ; Versioned Lookup
 S ICDVER=$S($G(ICDCDT)?7N:1,1:0)  S:$G(ICDCDT)'?7N ICDCDT=$$DT^XLFDT
 ; Enforce Business Rule for Date
 I ICDVER'>0 S:$D(^ICDS(+ICDCSY,0)) ICDCDT=$$DTBR^ICDEX(ICDCDT,,+($G(ICDCSY)))
 ; Space Bar Return (passed)
 I $D(ICDX),$G(ICDX)=" ",DIC(0)'["A" D SBR^ICDEXLK2  G:+($G(Y))>0 QUIT K Y
 ; TMP global
 S SUB=$TR(ROOT,"^(","") K ^TMP(SUB,$J)
 ; Save DIC
 S ICDDICA=$G(DIC("A")),ICDDICB=$G(DIC("B")),ICDDICW=$G(DIC("W"))
 S ICDDICS="",ICDDICST=$$DICS($G(DIC("S"))) S:$L(ICDDICST) ICDDICS=ICDDICST
 S ICDDICSS="" I $L($G(DICR(1,31))) D
 . Q  N X S X=$G(DICR(1,31)) D ^DIM S:$D(X) ICDDICSS=X
 S ICDDICN=$G(DIC("?N",FILE)) S:+ICDDICN'>0 ICDDICN=5
 S ICDDIC00=$G(DIC(0)),(ICDDIC0,DIC(0))=$$DIC0^ICDEXLK6($G(DIC(0)))
 K:+($G(ICDISF))>0 DIC("W") K:$D(DDS) DIC("W")
 I $L(ICDX)'>4,ICDX'["." D
 . S:ICDX?3N&($D(@(ROOT_"""BA"","""_ICDX_". "")"))) ICDX=ICDX_"."
 . S:$E(ICDX,1)="E"&($E(ICDX,2,4)?3N)&($D(@(ROOT_"""BA"","""_ICDX_". "")"))) ICDX=ICDX_"."
 . S:$E(ICDX,1)?1U&($E(ICDX,2,3)?2N)&($D(@(ROOT_"""BA"","""_ICDX_". "")"))) ICDX=ICDX_"."
 I ICDX="?",$G(DIC(0))'["A" D  I $L($G(DIE)),$L($G(DIC)),$G(DIE)'=$G(DIC) S Y=-1 W:'$D(DDS) ! Q
 . D INPH^ICDEXLK2(FILE) S ICDX="" S:$G(DIC(0))'["A" DIC(0)=DIC(0)_"A"
 I ICDX="??",$G(DIC(0))'["A" D  I $L($G(DIE)),$L($G(DIC)),$G(DIE)'=$G(DIC) S Y=-1 W:'$D(DDS) ! Q
 . D INPH2^ICDEXLK2(FILE) S ICDX="" S:$G(DIC(0))'["A" DIC(0)=DIC(0)_"A"
LKR ; Lookup Recursive
 ; QUASAR
 I '$D(DIC("S")),$G(DICR(2,1))="^ACK(509850.1," S DIROUT=1,X="^^",ICDX="",Y=-1 G QUIT
 I $D(DICR),+($G(ICDOREV))>0,+($G(ICDOFND))>0,+($G(ICDOSEL))'>0 N ICDDICS S ICDDICS=""
 S FND=0 S:'$L(DIC(0)) DIC(0)="AEM" S ICDREDO=""
 S:$L($G(DIC(0))) DIC(0)=$TR(DIC(0),"CL","")
 I +($G(ICDOREV))>0 D
 . S (ICDOFND,ICDOSEL,ICDOREV)=0 K X S ICDX=""
 I $G(DIC(0))["A" D  I '$L(X),$G(DIC(0))'["T" S X="",ICDOREV=1 G ERR
 . S X=$$INP^ICDEXLK2(FILE,$G(ICDVER),$G(ICDCDT))
 I $D(DTOUT)!($D(DUOUT)) G ERR
 I ($G(DIC(0))["A"),('$L(X)!(X="^")),$G(DIC(0))["T" S X="" K Y G LKR
 I $G(DIC(0))'["A"&($L($G(ICDX))) S X=$G(ICDX)
 I $G(X)["^" S DUOUT="" G ERR
 I '$L($G(X)) G ERR
 S X=$$TM(X),INP=X,INP1=$E(INP,1),INP2=$E(INP,2,245)
 ; Forced IEN
 K Y I INP1="`",INP2?1N.N,+INP2>0 D  G:$L(X)&(+($G(Y))<0) QUIT I +($G(FND))'>0 K X,Y G LKR
 . D IEN^ICDEXLK5 I +FND'>0,$G(DIC(0))["Q" D
 . . W:'$D(DICR(1))&('$D(DIROUT))&('$D(DUOUT))&('$D(DTOUT))&('$D(DDS))&(+($G(ICDOREV))'>0) " ??"
 . . W:$D(DICR(1))&('$D(DDS)) !
 I $D(Y) S:+Y<0 X=INP G QUIT
 ; Lookup X
 I X'?1N.N G:$L($G(X))'>0!($E($G(X))="^")!($G(X)["^^")!($D(DTOUT))!($D(DUOUT)) ERR
 N LOUD S LOUD="" S ICDX=X I +($G(FND))'>0 D
 . S:$L(ICDX)&($L(ICDX)>1) FND=$$LK^ICDEXLK3($G(X),FILE,ICDCDT,ICDCSY,ICDVER,ICDOUT)
 . S:$L(ICDX)&($L(ICDX)'>1) FND=$$CD^ICDEXLK3($G(X),FILE,ICDCDT,ICDCSY,ICDVER,ICDOUT)
 . S:+($G(FND))>0 ICDOFND=+($G(FND)) S:$L($G(ICDX)) X=$G(ICDX)
 I +FND'>0,$G(DIC(0))["Q" W:'$D(DICR(1))&('$D(DIROUT))&('$D(DUOUT))&('$D(DTOUT))&('$D(DDS))&(+($G(ICDOREV))'>0) " ??"
 I +FND'>0,$L(INP),$E(INP,1)'=" ",'$D(DTOUT),'$D(DUOUT),$G(DIC(0))["A",'($G(DIC(0))["N"&(INP?1N.N)) K X,Y G LKR
 S:+FND'>0 X=INP
 ; Check Numeric - DIC(0)["N" and DIC(0)'["E"
 I +$G(ICDOSEL)'>0,$G(DIC(0))["N",INP?1N.N D  G:+($G(Y))>0 QUIT
 . Q:DIC(0)["E"&(+$G(ICDOSEL)'>0)&(+$G(ICDOFND)>0)  K Y N XX
 . I $D(@(ROOT_+INP_",0)")) S FND=1 D  Q
 . . N IEN S IEN=+INP S (FND,ICDOFND,ICDOSEL)=1
 . . S X=$P($G(@(ROOT_+X_",0)")),"^",1)
 . . D Y^ICDEXLK2($G(ROOT),IEN,$G(ICDCDT))
 . I '$D(@(ROOT_+INP_",0)")) D  Q
 . . S X=$S($L($G(INP)):INP,1:$G(X))
 . . S Y="-1^Numeric value not found"
 . S XX=$$LD^ICDEX(FILE,+$G(INP),ICDCDT)
 . I $E(XX,1,2)="-1" D  Q
 . . S Y="-1^Long description not found",X=$G(INP)
 . W:$G(DIC(0))["E"&('$D(DDS)) "   ",XX S X=$G(INP)
 . D Y^ICDEXLK2($G(ROOT),$G(X),$G(ICDCDT))
 . S:+Y>0&(+X'<0) X=XX S:+Y<0 X=INP
 I +FND'>0,$G(DIC(0))["N",X?1N.N,+($G(Y))<0 G ERR
 I +FND'>0,$L($G(ICDX)),$L($G(DIC("S"))),$L($G(DICR(1))),$L($G(DICR(1,1))) K DIC("S") K Y G LKR
 I +FND'>0,$L($G(ICDX)),'$D(DIC("S")),$L($G(DICR(1))),$G(DICR(1))=$G(ICDX),$L($G(DICR(1,1))) D  G QUIT
 . S X=$S($L($G(INP)):INP,1:$G(X)),Y="-1^No matches found"
 I +FND'>0,$G(DIC(0))'["T" D  G QUIT
 . W:$G(DIC(0))["E"&('$L($G(DICR(1))))&('$D(DDS)) !,"  No matches found"
 . S X=$S($L($G(INP)):INP,1:$G(X)),Y="-1^No matches found"
 I +FND'>0,$G(DIC(0))["T" K Y G LKR
 S ICDOUPA=0 D ASK^ICDEXLK2
 I $D(DUOUT),$D(DIROUT) D  G QUIT
 . S (DUOUT,DIRUT)=1,X="^^"
 . S ICDX="",Y=-1
 I +FND=1,$G(ICDOFND)=1,$G(ICDOSEL)=0,$G(ICDOREV)=1,'$D(DICR(1)) D  G:$D(DIROUT)!($G(DIC(0))'["A") QUIT G:DIC(0)["A" LKR
 . S (ICDX,INP1,INP2,ICDOINP,X)="",Y="-1^No selection made"
 I +FND=1,$G(ICDOFND)=1,$G(ICDOSEL)=0,$G(ICDOREV)=1,$D(DICR(1)) D  G:$D(DIROUT)!($G(DIC(0))'["A") QUIT N ICDDICS G:DIC(0)["A" LKR
 . S:$D(DICR("1")) DICR("1")=ICDX S X=ICDX S:$D(DIROUT)!($G(DIC(0))'["A") (ICDX,INP1,INP2,ICDOINP,X)="",Y="-1^No selection made"
 I +FND>1,$G(ICDOSEL)=0,$G(ICDOREV)=1 D  G:$D(DUOUT)!($G(DIC(0))'["A") QUIT G:DIC(0)["A" LKR
 . S X="",Y=-1
 I $G(ICDOUPA)>0,'$D(DICR(1)),'$D(DIE),'$D(DR),'$D(DDS),DIC(0)["A" S (X,ICDX)="" K Y G LKR
 I $D(DUOUT),'$D(DIROUT) S (DUOUT,DIRUT)=1,X="^",ICDX="",Y=-1 D  I '$D(DICR(1)),'$D(DDS) G:+($G(ICDOREV))>0 QUIT G:+($G(ICDOREV))'>0 LKR
 . Q:$D(DICR(1))!($D(DDS))  S:+($G(ICDOREV))>0 (X,ICDX)="^",Y=-1 I +($G(ICDOREV))'>0 S ICDX="" K DUOUT,DIRUT,DIROUT,DTOUT,X,Y
 I ($D(DUOUT)!($D(DIROUT)))&($D(DICR(1))) D  G ERR
 . S:$D(DUOUT) X="^",DUOUT=1 S:$D(DIROUT) X="^^",DUOUT=1,DIROUT=1 W:'$D(DDS) !
 I +($G(FND))>1,+($G(ICDOFND))>1,+($G(ICDOSEL))=0,+($G(ICDOREV))=1,$D(DICR(1)),'$D(DIC("S")) D  G QUIT
 . S (ICDOFND,ICDOSEL,ICDOREV)=0,Y=-1,(X,ICDX,ICDOINP,DICR("1"))=""
 I $L($G(ICDREDO)) D  G LKR
 . S DIC(0)=$TR(DIC(0),"A","") S:'$L(DIC(0)) DIC(0)="EMQ" K DIC("S")
 . S (ICDX,X,INP)=ICDREDO K Y
 ; If found, all reviewed and no selection made
 I +($G(ICDOFND))>0,+($G(ICDOSEL))'>0,+($G(ICDOREV))>0 D  G:$G(DIC(0))'["A" ERR  G:$G(DIC(0))["A" LKR
 . K ICDX,Y,INP,INP1,INP2,KEY,^TMP(SUB,$J),X S (FND,ICDOFND,ICDOSEL,ICDOREV)=0 S:$D(DICR("1")) DICR("1")=""
 ; If found, not all are reviewed and no selection made, single up arrow
 I +($G(ICDOFND))>0,+($G(ICDOSEL))'>0,+($G(ICDOREV))'>0,$D(DUOUT),'$D(DIROUT) D  G:$G(DIC(0))'["A" ERR  G:$G(DIC(0))["A" LKR
 . K ICDX,Y,INP,INP1,INP2,KEY,^TMP(SUB,$J),X S (FND,ICDOFND,ICDOSEL,ICDOREV)=0 S:$D(DICR("1")) DICR("1")=""
 ; If found, no selection made, no up arrow and no timeout
 I +($G(ICDOFND))>0,+($G(ICDOSEL))'>0,'$D(DUOUT),'$D(DTOUT),$G(DIC(0))["E" G LKR
 G:+($G(Y))'>0&($D(DUOUT))&('$D(DIROUT)) LKR
 G:+($G(ICDOSEL))'>0 ERR
 G:+($G(Y))'>0&('$D(DUOUT))&('$D(DTOUT)) LKR
 G:+($G(Y))'>0&($D(DUOUT))&('$D(DIROUT)) LKR
 G:+($G(Y))'>0 ERR
 D RED,UDIC
 Q
LKQ ;   Quit
 Q
ERR ;   Quit On Error
 N ICDX,ICDY,ICDE S ICDY=$G(Y),ICDX=$G(X) K X,Y S Y=-1
 S:$L($P($G(ICDY),"^",2)) Y=Y_"^"_$P($G(ICDY),"^",2)
 I $D(DTOUT),$G(DIC(0))["E",'$D(DDS) W !!,?2,"Try again later" K ERR
 I $D(DUOUT),$G(DIC(0))["E" K ERR
 I '$D(DUOUT),+($G(ICDOFND)>0),+($G(ICDOSEL)'>0),$G(DIC(0))["E" K ERR
 I $L($G(ERR)),$G(DIC(0))["E",'$D(DDS) W !!,?2,$G(ERR)
 S:$E(ICDY,1,2)="-1"&($L($P(ICDY,"^",2))) Y=ICDY
 S X=ICDX I $D(DTOUT) S X="",Y="-1^Search timed out"
 I Y="-1",+($G(ICDOFND)>0),+($G(ICDOSEL)'>0) S Y="-1^No Selection Made"
 N XX S XX=$G(X) S X="" S:XX="^"!(XX="^^") X=XX D QUIT
 Q
QUIT ;   Quit without Error
 N ICDUA S ICDUA=$$UA($G(ICDX))
 I ICDUA="^" S X=ICDUA,Y="-1^Search aborted (up-arrow detected)"
 I ICDUA="^^" S X=ICDUA,Y="-1^Search aborted (up-arrow detected)"
 S:ICDUA["^"&(+($G(ICDOUPA))=2) Y="-1^Search aborted (doupble up-arrow detected)"
 I +Y>0 D Y^ICDEXLK2($G(ROOT),+Y,$G(ICDCDT))
 I $P($G(X),"`",2)=$P($G(Y),"^",1),$L($P($G(Y),"^",2)) S (ICDX,X)=$P($G(Y),"^",2)
 D UDIC I $D(DDS) S:$L($G(ICDOINP))&(+Y'>0) X=$G(ICDOINP)
 S:$L($G(ICDX)) X=$G(ICDX) S X=$G(X) D RED
 Q
UDIC ;   Undo DIC
 S:$L($G(ICDDICW)) DIC("W")=$G(ICDDICW)
 S:$L($G(ICDDICA)) DIC("A")=$G(ICDDICA)
 S:$L($G(ICDDICB)) DIC("B")=$G(ICDDICB)
 S:$L($G(ICDDICS)) DIC("S")=$G(ICDDICS)
 S:$L($G(ICDDIC0)) DIC(0)=$G(ICDDIC0)
 S:$L($G(ICDDIC00)) DIC(0)=$G(ICDDIC00)
 Q
DIE ;   Set for DIE call
 Q:'$L($G(DIE))  S:'$L($G(DIC("A")))&($L($G(DIP))) DIC("A")=$G(DIP)
 S:$L($G(DIC("A")))&($G(DIC("A"))'[": ") DIC("A")=$G(DIC("A"))_":  "
 N DIE,DIP,DZ,X1
 Q
DICS(ICDS) ;   Check DIC("S")
 N ICDT1,ICDT2,ICDTS S ICDT1=$D(X),ICDT2=$G(X) Q:'$L($G(ICDS)) ""
 S (ICDTS,X)=$G(ICDS) D ^DIM I '$D(X) S:ICDT1>0 X=$G(ICDT2) Q ""
 S ICDS=$G(ICDTS) S:ICDT1>0 X=$G(ICDT2) S:$L($G(ICDX)) X=$G(ICDX)
 Q ICDS
RED ;   Re-Display
 Q:+($G(Y))'>0  Q:'$L($P(Y,"^",2))  Q:$G(FILE)'>0  Q:$D(DDS)  Q:$G(DIC(0))'["E"
 Q:$G(DICR(2,1))="^ACK(509850.1,"
 N CODE,EXP,CC,STA S CODE=$P(Y,"^",2) S CODE=CODE_$J(" ",(10-$L(CODE)))
 S CC="" S:FILE=80 CC=$$VCC^ICDEX(+Y,$G(ICDCDT))
 S CC=$S(CC="1":"(CC)",CC="2":"(Major CC)",1:"")
 S STA=$O(@(ROOT_+Y_",66,""B"","_(+($G(ICDCDT))+.000001)_")"),-1)
 S STA=$O(@(ROOT_+Y_",66,""B"","_+STA_","" "")"),-1)
 S STA=$P($G(@(ROOT_+Y_",66,"_+STA_",0)")),"^",2)
 S STA=$S($G(STA)?1N&(+$G(STA)'>0):" (Inactive)",$G(STA)'?1N&(+$G(STA)'>0):" (Pending)",1:"")
 S:$G(ICDFMT)=2!($G(ICDFMT)=4) EXP=$$VLT^ICDEX(FILE,+Y,$G(ICDCDT))
 S:$G(ICDFMT)=1!($G(ICDFMT)=3)!($G(ICDFMT)="") EXP=$$VST^ICDEX(FILE,+Y,$G(ICDCDT))
 W:$L(CODE)&($L(EXP))&($D(DPP(1))) !,?5 W:$L(CODE)&($L(EXP)) "   ",$G(CODE),$G(EXP),$G(CC),$G(STA)
 Q
UA(X) ;   Up Arrow
 Q:($D(DUOUT)!($D(DIROUT)))&($D(DICR(1))) "^^"
 K:$G(ICDOUPA)>0&($G(ICDOUPA)'>1) DIROUT
 Q:$D(DUOUT)&('$D(DIROUT)) "^" Q:$D(DUOUT)&($D(DIROUT)) "^^"
 Q:$G(INP)["^"&($G(INP)'["^^") "^" Q:$G(INP)["^"&($G(INP)["^^") "^^"
 Q:$G(X)["^"&($G(X)'["^^") "^" Q:$G(X)["^"&($G(X)["^^") "^^"
 Q X
TM(X,Y) ;   Trim Y
 S Y=$G(Y) S:'$L(Y) Y=" "
 F  Q:$E(X,1)'=Y  S X=$E(X,2,$L(X))
 F  Q:$E(X,$L(X))'=Y  S X=$E(X,1,($L(X)-1))
 S X=$TR(X,"""","")
 Q X
CLR ; Clear Environment
 K DDS,DICR N ICDTEST,DPP,DR
 Q
