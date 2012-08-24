PXRMFFDB ;SLC/PKR - Function finding data structure builder. ;06/09/2011
 ;;2.0;CLINICAL REMINDERS;**4,6,12,18**;Feb 04, 2005;Build 152
 ;
 ;===========================================
BASE2(NUM) ;Convert a base 10 integer to base 2.
 N BD,BIN
 S BIN=""
 F  Q:NUM=0  D
 . S BD=$S((NUM\2)=(NUM/2):0,1:1)
 . S BIN=BD_BIN,NUM=NUM\2
 Q BIN
 ;
 ;===========================================
CRESLOG(NUM,FLIST,RESLOG) ;Check the resolution logic to see if
 ;it can be made true solely by function findings. If that is the case
 ;warn the user. Called by BLDRESLS^PXRMLOGX
 N AGEFI,BP,FI,FF,FFL,IND,JND,KND,LE,LEN,LND,NFF,NTC,SEXFI,TEMP,VALUE
 S (AGEFI,SEXFI)=0
 S NFF=0
 F IND=1:1:NUM D
 . S JND=$P(FLIST,";",IND)
 . I +JND=JND S FI(JND)=0 Q
 . I JND["FF" S NFF=NFF+1,FF=$P(JND,"FF",2),FFL(NFF)=FF
 I NFF=0 Q
 ;Generate and test all combinations of true and false FFs.
 S VALUE=0
 S NTC=$$PWR^XLFMTH(2,NFF)-1
 F IND=1:1:NTC Q:VALUE  D
 . S BIN=$$BASE2(IND)
 . S LEN=$L(BIN)
 . S LE=NFF-LEN
 .;Fill in the values for the implied preceding 0s.
 . F JND=1:1:LE S KND=FFL(JND),FF(KND)=0
 . S LND=0
 . F JND=LE+1:1:NFF D
 .. S KND=FFL(JND),LND=LND+1
 .. S FF(KND)=$E(BIN,LND)
 . I @RESLOG
 . S VALUE=$T
 I VALUE D
 . N RESLSTR
 . S RESLSTR=RESLOG
 . F IND=1:1:NUM D
 .. S JND=$P(FLIST,";",IND)
 .. S TEMP=$S(JND["FF":"FF("_$P(JND,"FF",2)_")",1:"FI("_JND_")")
 .. S RESLOG=$$STRREP^PXRMUTIL(RESLOG,TEMP,@TEMP)
 . S RESLOG=$$STRREP^PXRMUTIL(RESLOG,"AGE",AGEFI)
 . S RESLOG=$$STRREP^PXRMUTIL(RESLOG,"SEX",SEXFI)
 . W !!,"Warning - your resolution logic can be satisfied by function findings only."
 . W !,"If this happens it will not be possible to calculate a resolution date and"
 . W !,"the reminder will not be resolved. Here is a case where the logic evaluates"
 . W !,"to true:"
 . W !,RESLSTR
 . W !,RESLOG
 . W !
 Q
 ;
 ;===========================================
FFBUILD(X,DA) ;Given a function finding logical string build the data
 ;structure. This is called by a new-style cross-reference after
 ;the function string has passed the input transform so we don't need
 ;to validate the elements.
 ;Do not execute as part of a verify fields.
 I $G(DIUTIL)="VERIFY FIELDS" Q
 ;Do not execute as part of exchange.
 I $G(PXRMEXCH) Q
 N FDA,FUNNUM,FUNP,IENB,IENS,IND,JND,L2,L3,LEN,LIST,LOGIC,OPERS,MSG
 N PFSTACK,REPL,RS,TEMP,TS
 S IENB=DA_","_DA(1)_","
 S OPERS=$$GETOPERS
 D POSTFIX^PXRMSTAC(X,OPERS,.PFSTACK)
 S (FUNNUM,L2)=0
 F IND=1:1:PFSTACK(0) D
 . S TEMP=PFSTACK(IND)
 . I $D(^PXRMD(802.4,"B",TEMP)) D
 .. S FUNP=$O(^PXRMD(802.4,"B",TEMP,""))
 .. S FUNNUM=FUNNUM+1,L2=L2+1
 .. S IENS="+"_L2_","_IENB
 .. S FDA(811.9255,IENS,.01)=FUNNUM
 .. S FDA(811.9255,IENS,.02)=FUNP
 .. S IND=IND+1
 .. S LIST=$TR(PFSTACK(IND),"~"," ")
 .. S REPL(FUNNUM)=TEMP_"("_LIST_")"_U_"FN("_FUNNUM_")"
 .. S L3=L2
 .. S LEN=$L(LIST,",")
 .. F JND=1:1:LEN D
 ... S L3=L3+1
 ... S IENS="+"_L3_",+"_L2_","_IENB
 ... S TS=$P(LIST,",",JND)
 ... S TS=$TR(TS,"""","")
 ... S FDA(811.9256,IENS,.01)=TS
 .. S L2=L3
 ;Build the logic string
 S LOGIC=X
 F IND=1:1:FUNNUM D
 . S TS=$P(REPL(IND),U,1)
 . S RS=$P(REPL(IND),U,2)
 . S LOGIC=$$STRREP^PXRMUTIL(LOGIC,TS,RS)
 S FDA(811.925,IENB,10)=LOGIC
 D UPDATE^DIE("","FDA","IENB","MSG")
 I $D(MSG) D
 . W !,"The update failed, UPDATE^DIE returned the following error message:"
 . D AWRITE^PXRMUTIL("MSG")
 Q
 ;
 ;===========================================
FFKILL(X,DA) ;This is the kill logic for the function string.
 ;Do not execute as part of a verify fields.
 I $G(DIUTIL)="VERIFY FIELDS" Q
 ;Do not execute as part of exchange.
 I $G(PXRMEXCH) Q
 K ^PXD(811.9,DA(1),25,DA,5),^PXD(811.9,DA(1),25,DA,10)
 Q
 ;
 ;===========================================
GETOPERS() ;Return the list of operators that can be used in a function string.
 Q "!&-+*/\#<>=']['='<'>"
 ;
 ;===========================================
ISGRV(VAR) ;VAR can be a global reminder variable by itself or used in a
 ;$P.
 N DELIM,EXPR,FROM,TO,VALID
 S EXPR=$P(VAR,",",1)
 S VALID=$S(EXPR="PXRMAGE":1,EXPR="PXRMDOB":1,EXPR="PXRMLAD":1,EXPR="PXRMSEX":1,1:0)
 I 'VALID Q 0
 S DELIM=$P(VAR,",",2)
 S VALID=$S(DELIM="":1,1:$$ISSTR(DELIM))
 I 'VALID Q 0
 S FROM=$P(VAR,",",3)
 S VALID=$S(FROM="":1,FROM=+FROM:1,1:0)
 I 'VALID Q 0
 S TO=$P(VAR,",",4)
 S VALID=$S(TO="":1,TO=+TO:1,1:0)
 Q VALID
 ;
 ;===========================================
ISSTR(STRING) ;Return true if STRING really is a string and it is not
 ;executable MUMPS code.
 N VALID,X
 S VALID=0
 ;First and last character is a quote and there are an even number of
 ;quotes in the string.
 I ($E(STRING,1)=""""),($E(STRING,$L(STRING))=""""),($L(STRING,"""")#2=1) S VALID=1
 ;Check for ,DELIMITER,FROM,TO associated with $P.
 I 'VALID D
 . I STRING?1","1""""1.E1""""0.1(1","1.N)0.1(1","1.N) S VALID=1
 . I STRING?1",U"0.1(1","1.N)0.1(1","1.N) S VALID=1
 I 'VALID Q VALID
 S X=STRING
 D ^DIM
 S VALID=$S($D(X)=0:1,1:0)
 Q VALID
 ;
 ;===========================================
VFFORM(FUN,ARGLIST,FSTRING) ;Make sure the function is followed by an argument
 ;list i.e., FUN(...).
 N TSTRING,VALID
 S TSTRING=FUN_"("_ARGLIST_")"
 S VALID=$S(FSTRING[TSTRING:1,1:0)
 I 'VALID D
 . N TEXT
 . S TEXT="Function "_FUN_" must be followed by an argument list!"
 . D EN^DDIOL(.TEXT)
 Q VALID
 ;
 ;===========================================
VFINDING(X,DAI) ;Make sure a finding number is a valid member of the
 ;definition finding multiple. Input transform for function
 ;finding finding number.
 ;Do not execute as part of a verify fields.
 I $G(DIUTIL)="VERIFY FIELDS" Q 1
 ;Do not execute as part of exchange.
 I $G(PXRMEXCH) Q 1
 I '$D(DAI) Q 1
 ;If X is not numeric it is not a finding number.
 I +X'=X Q 0
 I $D(^PXD(811.9,DAI,20,X,0)) Q 1
 E  D  Q 0
 . N TEXT
 . S TEXT="Finding number "_X_" does not exist!"
 . D EN^DDIOL(TEXT)
 ;
 ;===========================================
VFSTRING(FFSTRING,DA) ;Make sure a function finding string is valid.
 ;The elements can be functions, operators, and numbers.
 ;Do not execute as part of a verify fields.
 ;I $G(DIUTIL)="VERIFY FIELDS" Q 1
 ;Do not execute as part of exchange.
 I $G(PXRMEXCH) Q 1
 I '$D(DA) Q 1
 N DAI,DATE,FUNIEN,IND,LIST,MFUN,OPERS,PFSTACK,TEMP,TEXT,VALID
 S DAI=DA(1)
 S OPERS=$$GETOPERS
 ;Define the allowed M functions.
 S MFUN("$P")=""
 D POSTFIX^PXRMSTAC(FFSTRING,OPERS,.PFSTACK)
 S VALID=1
 F IND=1:1:PFSTACK(0) Q:'VALID  D
 . S TEMP=PFSTACK(IND)
 . I $D(^PXRMD(802.4,"B",TEMP)) D  Q
 .. S FUNIEN=$O(^PXRMD(802.4,"B",TEMP,""))
 .. S IND=IND+1
 .. S LIST=$G(PFSTACK(IND))
 .. S VALID=$$VFFORM(TEMP,LIST,X)
 .. I 'VALID Q
 .. I $G(^PXRMD(802.4,FUNIEN,2))'="" S VALID=$$VALISTS(LIST,DAI,TEMP,FUNIEN)
 .. I $G(^PXRMD(802.4,FUNIEN,3))'="" S VALID=$$VALISTM(LIST,DAI,TEMP,FUNIEN)
 .;Check for an operator. Unary operators have a "U" appended.
 . I OPERS[$P(TEMP,"U",1) Q
 .;Check for number
 . I TEMP=+TEMP Q
 .;Check for allowed M function.
 . I $D(MFUN(TEMP)) Q
 .;Check for a global reminder variable
 . I $$ISGRV(TEMP) Q
 .;Check for a non-executable string.
 . I $$ISSTR(TEMP) Q
 . S VALID=0
 . S TEXT=TEMP_" is not a valid function finding element!"
 . D EN^DDIOL(TEXT)
 I VALID D
 . N X
 . S X="I "_FFSTRING
 . D ^DIM
 . I $D(X)=0 S VALID=0
 I 'VALID D
 . S TEMP=FFSTRING_" is not a valid function string!"
 . D EN^DDIOL(TEMP)
 Q VALID
 ;
 ;===========================================
VALISTS(LIST,DAI,FUNCTION,FUNIEN) ;Make sure the function argument list
 ;s valid. This check is for functions where a single pattern can
 ;be used.
 N AT,IND,LEN,PATTERN,VALID,X
 S LEN=$L(LIST,",")
 I LEN=0 D  Q 0
 . N TEXT
 . S TEXT="The argument list is not defined!"
 . D EN^DDIOL(TEXT)
 S PATTERN=^PXRMD(802.4,FUNIEN,2)
 S VALID=$S(LIST?@PATTERN:1,1:0)
 I 'VALID D  Q 0
 . N TEXT
 . S TEXT="Argument list "_LIST_" is not correct for function "_$P(^PXRMD(802.4,FUNIEN,0),U,1)
 . D EN^DDIOL(TEXT)
 F IND=1:1:LEN D
 . S X=$P(LIST,",",IND)
 . S AT=$$ARGTYPE^PXRMFFAT(FUNCTION,IND)
 . I AT="U" S VALID=0 Q
 . I AT="F",'$$VFINDING(X,DAI) S VALID=0
 Q VALID
 ;
 ;===========================================
VALISTM(LIST,DAI,FUNCTION,FUNIEN) ;Make sure the function argument list
 ;is valid. This check is for functions where a different pattern is
 ;required for each argument.
 N ARG,AT,IND,LEN,NL,PAT,PATTERNS,TEXT,VARG,VALID
 S LEN=$L(LIST,",")
 I LEN=0 D  Q 0
 . N TEXT
 . S TEXT="The argument list is not defined!"
 . D EN^DDIOL(TEXT)
 S PATTERNS=^PXRMD(802.4,FUNIEN,3)
 S LEN=$L(PATTERNS,"~")
 I LEN=0 D  Q 0
 . N TEXT
 . S TEXT="The pattern list is not defined!"
 . D EN^DDIOL(TEXT)
 S NL=0,VALID=1
 F IND=1:1:LEN D
 . S ARG=$P(LIST,",",IND)
 . S PAT=$P(PATTERNS,"~",IND)
 . S VARG=ARG?@PAT
 . I 'VARG S VALID=0,NL=NL+1,TEXT(NL)="Function argument number "_IND_" is incorrect." Q
 . S AT=$$ARGTYPE^PXRMFFAT(FUNCTION,IND)
 . I AT="U" S VARG=0
 . I 'VARG S VALID=0,NL=NL+1,TEXT(NL)="Function argument number "_IND_" is the wrong type." Q
 . I AT="F",'$$VFINDING(ARG,DAI) S VARG=0
 I 'VALID D EN^DDIOL(.TEXT)
 Q VALID
 ;
