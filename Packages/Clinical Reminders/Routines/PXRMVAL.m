PXRMVAL ; SLC/KER - Validate Codes (ICD/ICP/CPT main)    ; 05/16/2000
 ;;2.0;CLINICAL REMINDERS;;Feb 04, 2005
 ;   
 ; This routine checks both the format of a classification code
 ; (pattern matching) and the value of a classification code
 ; provided by a user. Both the format and the value of the
 ; users input must be valid for this routine to return a "true"
 ; condition (1). If either the format or the value is not valid
 ; this routine will return a false condition (0) and the reason
 ; (error) the code was not found to be valid.
 ;   
 ; Entry Points
 ;   
 ;    EN^PXRMVAL                                     Standard Lookup
 ;    ============================================================
 ;   
 ;             Optional input:
 ;   
 ;                X     classification code (ICD/CPT)
 ;   
 ;               DIC    global root/#
 ;   
 ;                      If X equals      then DIC should be set to
 ;                      ------------------------------------------
 ;                      ICD diagnosis         ^ICD9( or 80
 ;                      ICD procedure         ^ICD0( or 80.1
 ;                      CPT procedure         ^ICPT( or 81
 ;   
 ;   
 ;   
 ;    $$CODE^PXRMVAL(<code>,<file>)               Extrinsic Function
 ;    ============================================================
 ;   
 ;             Mandatory input:
 ;   
 ;              <code>  classification code (ICD/CPT), may be null
 ;   
 ;              <file>  file number or global root
 ;   
 ;                      If X equals      then DIC should be set to
 ;                      ------------------------------------------
 ;                      ICD diagnosis         ^ICD9( or 80
 ;                      ICD procedure         ^ICD0( or 80.1
 ;                      CPT procedure         ^ICPT( or 81
 ;                      HCPCS procedure       ^ICPT( or 81
 ;   
 ;   
 ;   
 ; EN^PXRMVAL returns the variable Y and 
 ; $$CODE^PXRMVAL returns a value in the
 ; form of:
 ;   
 ;          <validity>^<input code>^<output code>^<error>^<file>^
 ;          <root>^<type>^<input IEN>^<input inactive flag>^
 ;          <output IEN>^<output inactive flag>^<description>
 ;   
 ;           1  Validity      1=valid   0=invalid
 ;           2  Input code    Code entered by user (input)
 ;           3  Output code   Code (after transformation, output)
 ;           4  Error         Error text
 ;           5  File #        File number used to check code
 ;           6  Root          Global root (location)
 ;           7  Type          Type of code checked (ICD, CPT)
 ;           8  Input IEN     Entry number of input code
 ;           9  Input flag    ""=active  1=inactive
 ;          10  Output IEN    Entry number of output code
 ;          11  Output flag   ""=active  1=inactive
 ;          12  Name          Descriptive name of Coded entry
 ;   
 ;   
 ; If X (code) or DIC (file) do not exist, then the user will be
 ; prompted for the missing data.
 ;   
EN ; Validate a code format (ICD or CPT)
 K Y N FI,TY,OX S FI=$G(DIC) S (OX,X)=$G(X) N DIC S DIC=$G(FI) D FD S Y="0^"_OX_"^"_X_"^Unknown error"
 ;   Quit if no code provided
 S:'$L(X) (OX,X)=$$SO I '$L(X) S Y="0^"_OX_"^"_X_"^No ICD/CPT code provided" Q
 ;   Quit if no file provided
 I $G(DIC)="" S DIC=$G(FI) D FD I '$L(DIC) S DIC=$$FI(OX) D FD
 I '$L(DIC)!(DIC="^")!(DIC="^^") S Y="0^"_OX_"^"_X_"^No classification code file provided (DIC)" Q
 ;   Quit if no file found
 S TY=$$TYPE^PXRMVALU(X,DIC),FI=$G(@(DIC_"0)")) I '$L(FI) S Y="0^"_OX_"^"_X_"^No "_TY_" file found^^^" Q
 S FI=$S(DIC["ICD9":80,DIC["ICD0":80.1,DIC["ICPT":81,1:0) I FI=0 S Y="0^"_OX_"^"_X_"^No "_TY_" file found^^^" Q
 ; Validate code
 S Y=$$VAL(FI,X) Q
 ;   
CODE(X,DIC) ; Extrinsic Function to check code format and value
 S X=$G(X),DIC=$G(DIC) N Y D EN S X=Y Q X
 ;   
VAL(X,Y) ; Validate code
 N FILENUM,CODE S FILENUM=$G(X),CODE=$G(Y)
 Q:+($G(FILENUM))=80 $$ICD^PXRMVALC(CODE)
 Q:+($G(FILENUM))=80.1 $$ICP^PXRMVALC(CODE)
 Q:+($G(FILENUM))=81 $$CPT^PXRMVALC(CODE)
 Q "0^"_CODE_"^"_CODE_"^Unidentified code type"
 ;   
SO(X) ; Prompt user for source code (CODE)
 N DIR,Y,DTOUT,DUOUT,DIRUT,DIROUT
 S X=$G(X),DIR(0)="FAO^3:7"
 S DIR("A")="Enter a classification code:  "
 S:$L(X)>4&($L(X)<8) DIR("B")=X
 D ^DIR S X=Y S:$D(DTOUT)!($D(DUOUT))!($D(DIRUT))!($D(DIROUT)) X=""
 Q X
 ;   
FI(SO) ; Prompt user for file (FI,DIC)
 N DIC,DO,DLAYGO,DINUM,X,Y,DTOUT,DUOUT,FILEDEF,FILENM
 S SO=$G(SO) S FILEDEF=""  S:$L(SO) FILEDEF=$$FILE^PXRMVALU(SO)
 S FILENM=$$FN(+FILEDEF),FILEDEF=$S($L(FILENM):FILENM,1:"")
 S:$L(FILEDEF) DIC("B")=FILEDEF S DIC("A")="Enter classification code file:  "
 S:$L($G(SO)) DIC("A")="Enter classification file for code """_SO_""":  "
 S DIC("S")="I +Y=80!(+Y=80.1)!(+Y=81)"
 S DIC="^DIC(",DIC(0)="AEMQ" D ^DIC S SO=+($G(Y)) S:SO'>0 SO="" Q SO
 ;   
FD ; File and file root based on DIC
 S:'$L(DIC) (FI,DIC)="" Q:'$L(DIC)
 I $L($$GL(+DIC)),+($$DD(+DIC))>0 D  Q
 . S FI=+DIC,DIC=$$GL(+DIC) S:FI'=80&(FI'=80.1)&(FI'=81) (FI,DIC)=""
 I $E(DIC,1)="^",$L($P(DIC,"^",2)),$P(DIC,"^",2)["(",$L(DIC,"^")=2,$D(@(DIC_"0)")) D  Q
 . S FI=+($P($G(@(DIC_"0)")),"^",2)) S:FI'=80&(FI'=80.1)&(FI'=81) (FI,DIC)=""
 S (FI,DIC)="" Q
DD(X) ; DD Exist?  (DBIA #2052)
 N PXRMF S X=+($G(X)) Q:X=0 ""
 D FIELD^DID(X,.01,"N","LABEL","PXRMF") S X=$S($L($G(PXRMF("LABEL"))):1,1:0) Q X
GL(X) ; Global Location (DBIA #2052)
 N PXRMF S X=+($G(X)) Q:X=0 "" D FILE^DID(X,"N","GLOBAL NAME","PXRMF") S X=$G(PXRMF("GLOBAL NAME")) Q X
FN(X) ; File Name (DBIA #2052)
 N PXRMF S X=+($G(X)) Q:X=0 "" D FILE^DID(X,"N","NAME","PXRMF") S X=$G(PXRMF("NAME")) Q X
