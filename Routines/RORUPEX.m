RORUPEX ;HCIOFO/SG - SELECTION RULE EXPRESSION PARSER  ; 7/21/03 9:47am
 ;;1.5;CLINICAL CASE REGISTRIES;;Feb 17, 2006
 ;
 Q
 ;
 ;***** GETS THE NEXT CHARACTER FROM THE EXPRESSION
GETCHAR ;
 S LOOK=$E(EXPR,EPTR),EPTR=EPTR+1
 Q
 ;
 ;***** TRANSLATES FIELD OR RULE MACRO TO MUMPS CODE
 ;
 ; The function returns a string containing MUMPS expression
 ; that implements the selection rule macro.
 ;
GETMACRO() ;
 ;;AVG,CNT,E,GDF,GDL,I,LS,MAX,MIN,SDF,SDL,SUM
 ;
 Q:'$$MATCH("{") ""
 N BI,BUF,DATELMT,NAME,PFX,PFXLST,RC,RORMSG,SFX,TMP,XCODE
 S PFXLST=","_$P($T(GETMACRO+1),";;",2)_","
 S BI=1,RC=0
 F  D  Q:RC
 . I LOOK="}"  D GETCHAR  S RC=1  Q
 . I LOOK=":"  D GETCHAR  S BI=BI+1  Q
 . I LOOK="{"  D  Q
 . . I BI<3  D SNTXERR("GETMACRO^RORUPEX")  S RC=1  Q
 . . S BUF(BI)=$G(BUF(BI))_$$GETMACRO()
 . S BUF(BI)=$G(BUF(BI))_LOOK
 . D GETCHAR
 Q:ERRCODE<0 ""
 ;--- Get the parts of the macro
 S BI=1,(NAME,PFX,SFX)=""
 S TMP=$$UP^XLFSTR($$TRIM^XLFSTR($G(BUF(BI))))
 S:PFXLST[(","_TMP_",") PFX=TMP,BI=BI+1
 S NAME=$$TRIM^XLFSTR($G(BUF(BI))),BI=BI+1
 S SFX=$$TRIM^XLFSTR($G(BUF(BI))),BI=BI+1
 ;--- Data element value
 I (PFX="E")!(PFX="I")  S XCODE=""  D  Q XCODE
 . S DATELMT=$S(+NAME=NAME:+NAME,1:$$DATACODE^RORUPDUT(FILE,NAME))
 . I DATELMT<0  S ERRCODE=DATELMT  Q
 . S XCODE="$G(RORVALS(""DV"","_FILE_","_DATELMT_","""_PFX_"""))"
 . S RESULT("F",DATELMT,PFX)=""
 ;--- Lab Search (replace a name of the Lab Search with the IEN)
 I PFX="LS"  D  Q "$$RULE^RORUPD04("_TMP_")"
 . I FILE'=63  D SNTXERR("GETMACRO^RORUPEX")  S TMP=""  Q
 . S TMP="I '$P(^(0),U,2)" ; Only Active
 . S TMP=+$$FIND1^DIC(798.9,"","X",NAME,"B",TMP,"RORMSG")
 . S RC=$$DBS^RORERR("RORMSG",-9,,,798.9)
 . S:RC<0 ERRCODE=RC,TMP=0
 . S:TMP RESULT("L",TMP)=""
 ;--- Trigger date macros (set)
 I PFX="SDF"  Q "$$SDF^RORUPDUT("""_NAME_""","_SFX_")"
 I PFX="SDL"  Q "$$SDL^RORUPDUT("""_NAME_""","_SFX_")"
 ;--- Macros processed after this point cannot reference
 ;    the rule that they are part of the expression of
 S RESULT("R",NAME)=""
 ;--- Trigger date macros (get)
 I (PFX="GDF")!(PFX="GDL")  D  Q XCODE
 . S XCODE="$$SRDT^RORUPDUT("""_NAME_""","""_PFX_""","_SFX_")"
 ;--- Value of the selection rule
 Q:PFX="" "$G(RORVALS(""SV"","""_NAME_"""))"
 Q "$G(RORVALS(""SV"","""_NAME_""","""_PFX_"""))"
 ;
 ;***** GETS A STRING CONSTANT FROM THE EXPRESSION
 ;
 ; The function returns a string argument from the expression.
 ;
GETSTR() ;
 Q:'$$MATCH("""") ""
 N RC,STR
 S STR="",RC=0
 F  D  Q:RC
 . I LOOK=""""  D  Q:RC
 . . D GETCHAR
 . . I LOOK'=""""  S RC=1  Q
 . . S STR=STR_""""
 . S STR=STR_LOOK
 . D GETCHAR
 Q STR
 ;
 ;***** INITIALIZES PARSING PROCESS
INIT ;
 S EPTR=1,ERRCODE=0,RESULT=""
 D GETCHAR,SKIPWHT
 Q
 ;
 ;***** COMPARES LOOK-AHEAD CHARACTER TO THE ARGUMENT
MATCH(CH) ;
 I LOOK=CH  D GETCHAR  Q 1
 D SNTXERR("MATCH^RORUPEX")
 Q 0
 ;
 ;***** PARSES THE EXPRESSION
 ;
 ; FILE          File number
 ; EXPR          Source expression
 ; .RESULT(      Resulting MUMPS code
 ;   "F",        List of data elements to load
 ;     DataCode)
 ;   "L",LS#)    List of Lab Search IENs
 ;   "R",Rule#)  List of rules that this expression depend on
 ;
 ; Return values:
 ;       <0  Error code
 ;        0  Ok
 ;
PARSER(FILE,EXPR,RESULT) ;
 N EPTR          ; Current position in the expression
 N ERRCODE       ; Error code
 N LOOK          ; Look-ahead character
 ;
 ;--- Check if the file exists and supported
 Q:'$$VFILE^DILFD(FILE) $$ERROR^RORERR(-58,"PARSER^RORUPEX",,,FILE)
 Q:'$D(^ROR(799.2,FILE)) $$ERROR^RORERR(-63,"PARSER^RORUPEX",,,FILE)
 ;--- Parse the expression
 D INIT
 F  Q:LOOK=""  D  Q:ERRCODE<0
 . I LOOK=""""  D  Q
 . . S RESULT=RESULT_""""_$$GETSTR()_""""
 . I LOOK="{"  D  Q
 . . S RESULT=RESULT_$$GETMACRO()
 . S RESULT=RESULT_LOOK
 . D GETCHAR
 ;
 Q $S(ERRCODE<0:ERRCODE,1:0)
 ;
 ;***** PROCESSES A SYNTAX ERROR
SNTXERR(PLACE,MSG) ;
 N I,INFO  S I=0
 S:$G(MSG)'="" I=I+1,INFO(I)=MSG
 S I=I+1,INFO(I)="Position: "_EPTR
 S:LOOK'="" INFO(I)=INFO(I)_", Character: '"_LOOK_"'"
 S ERRCODE=$$ERROR^RORERR(-21,$G(PLACE),.INFO)
 Q
 ;
 ;***** SKIPS WHITE SPACES IN THE EXPRESSION
SKIPWHT ;
 F  Q:(" "'[LOOK)!(LOOK="")  D GETCHAR
 Q
