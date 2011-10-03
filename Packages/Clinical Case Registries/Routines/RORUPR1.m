RORUPR1 ;HCIOFO/SG - SELECTION RULES PREPARATION  ; 11/20/05 4:56pm
 ;;1.5;CLINICAL CASE REGISTRIES;**12**;Feb 17, 2006;Build 1
 ;
 ;01/04/2011 BAY/KAM ROR*1.5*12 Remedy Call 421530 Populate a variable
 ;                              to assist with Lab Test Result Code
 ;                              identification in GCPR^LA7QRY
 Q
 ;
 ;***** MARKS PARENT FILES TO PROCESS
 ;
 ; This function analyzes file dependencies defined by the 'ROR
 ; METADATA' file and guaranties that all necessary files will be
 ; processed during the registry update.
 ;
FILETREE() ;
 N FILE,PF,RC
 S FILE="",RC=0
 F  S FILE=$O(RORUPD("SR",FILE))  Q:FILE=""  D  Q:RC<0
 . S PF=+FILE,RC=0
 . ;--- Follow a path that leads from this file to
 . ;    the root of the "file-processing tree".
 . F  D  Q:RC
 . . ;--- Check if metadata for the file is defined
 . . I '$D(^ROR(799.2,PF))  D  Q
 . . . S RC=$$ERROR^RORERR(-63,,,,PF)
 . . ;--- Get the number of the parent file
 . . S PF=+$$GET1^DIQ(799.2,PF_",",1,"I",,"RORMSG")
 . . I $G(DIERR)  D  Q
 . . . S RC=$$DBS^RORERR("RORMSG",-9)
 . . ;--- Stop if the root of the "file-processing tree" has been
 . . ;    reached or the file is already marked for processing.
 . . ;    Otherwise, mark the file and continue moving up.
 . . I 'PF!$D(RORUPD("SR",PF))  S RC=1  Q
 . . S RORUPD("SR",PF)=""
 Q $S(RC<0:RC,1:0)
 ;
 ;***** RETURNS LEVEL OF THE FILE IN 'THE FILE PROCESSING' TREE
 ;
 ; FILE          File number
 ;
FLEVEL(FILE) ;
 N LEVEL
 S LEVEL=1
 F  S FILE=+$P($G(^ROR(799.2,FILE,0)),U,2)  Q:'FILE  S LEVEL=LEVEL+1
 Q LEVEL
 ;
 ;***** LOADS AND PREPARES LAB SEARCH INDICATORS
 ;
 ; Return Values:
 ;        0  Ok
 ;       <0  Error code
 ;
LABSRCH() ;
 N I,IND,IR,LRCODE,LSICNT,LSIEN,RC,RORBUF,RORMSG,TMP,VAL
 K RORLRC
 ;--- Browse through the list of Lab searches
 S LSIEN="",RC=0
 F  S LSIEN=$O(@RORUPDPI@(4,LSIEN))  Q:LSIEN=""  D  Q:RC<0
 . K RORBUF  S TMP=","_LSIEN_","
 . D LIST^DIC(798.92,TMP,"@;.01;.02;1I;2",,,,,"B",,,"RORBUF","RORMSG")
 . S RC=$$DBS^RORERR("RORMSG",-9)  Q:RC<0
 . ;--- Browse through the list of search indicators
 . S IR="",LSICNT=0
 . F  S IR=$O(RORBUF("DILIST","ID",IR))  Q:IR=""  D  Q:RC<0
 . . K LRCODE
 . . ;--- Check if the indicator should be ignored
 . . S IND=$G(RORBUF("DILIST","ID",IR,1))  Q:IND'>0
 . . ;--- Get the result code (LOINC and/or NLT)
 . . S LRCODE=$G(RORBUF("DILIST","ID",IR,.01))
 . . I LRCODE>0  D  Q:LRCODE<0  S LRCODE(LRCODE_"^LN")=""
 . . . S LRCODE=$$LNCODE^RORUTL02(LRCODE)
 . . S LRCODE=$G(RORBUF("DILIST","ID",IR,.02))
 . . S:LRCODE>0 LRCODE(LRCODE_"^NLT")=""
 . . ;--- Either LOINC or NLT must be defined
 . . Q:$D(LRCODE)<10
 . . M RORLRC("B")=LRCODE
 . . ;--- Prepare and store the search indicator
 . . S VAL=$G(RORBUF("DILIST","ID",IR,2))
 . . I VAL="",IND'=1,IND'=6  Q
 . . S LSICNT=LSICNT+1
 . . S LRCODE=""
 . . F  S LRCODE=$O(LRCODE(LRCODE))  Q:LRCODE=""  D
 . . . S I=$O(@RORUPDPI@("LS",LRCODE,LSIEN,""),-1)+1
 . . . S @RORUPDPI@("LS",LRCODE,LSIEN,I)=IND_U_VAL
 . Q:(RC<0)!(LSICNT>0)
 . ;--- Record a warning if no indicators are defined
 . S TMP=$$GET1^DIQ(798.9,LSIEN_",",.01,,,"RORMSG")
 . S TMP=$$ERROR^RORERR(-55,,,,TMP)
 Q:RC<0 RC
 ;--- Prepare a list of Lab result codes for GCPR^LA7QRY
 ;01/04/2011 BAY/KAM ROR*1.5*12 added RORLRC variable set to next line
 S LRCODE="",RORLRC="CH"
 F IR=1:1  S LRCODE=$O(RORLRC("B",LRCODE))  Q:LRCODE=""  D
 . S RORLRC(IR)=LRCODE
 K RORLRC("B")
 Q 0
 ;
 ;***** LOADS SELECTION RULES DATA
 ;
 ; .REGLST       Reference to a local array containing registry names
 ;               as subscripts and optional registry IENs as values
 ;
 ; Return Values:
 ;        0  Ok
 ;       <0  Error code
 ;
LOAD(REGLST) ;
 N I,IENS,RC,REGIEN,REGNAME,RORBUF,RORMSG,RULENAME
 K RORUPD("LM1")
 S REGNAME="",RC=0
 F  S REGNAME=$O(REGLST(REGNAME))  Q:REGNAME=""  D  Q:RC<0
 . S REGIEN=+$G(REGLST(REGNAME))
 . I REGIEN'>0  D  I REGIEN'>0  S RC=REGIEN  Q
 . . S REGIEN=$$REGIEN^RORUTL02(REGNAME)
 . S @RORUPDPI@(2,REGIEN)=REGNAME
 . ;--- Load selection rules
 . K RORBUF  S IENS=","_REGIEN_","
 . D LIST^DIC(798.13,IENS,"@;.01E","U",,,,"B",,,"RORBUF","RORMSG")
 . S RC=$$DBS^RORERR("RORMSG",-9)  Q:RC<0
 . S I=""
 . F  S I=$O(RORBUF("DILIST","ID",I))  Q:I=""  D  Q:RC<0
 . . S RULENAME=RORBUF("DILIST","ID",I,.01)
 . . S RC=$$LOADRULE(RULENAME,REGIEN)
 Q $S(RC<0:RC,1:0)
 ;
 ;***** LOADS THE SELECTION RULE
 ;
 ; RULENAME      Name of the rule
 ; REGIEN        Registry IEN
 ; [LEVEL]       Level of the rule (O for top level rules)
 ;
 ; Return Values:
 ;        0  Ok
 ;       <0  Error code
 ;
LOADRULE(RULENAME,REGIEN,LEVEL) ;
 ;--- Quit if the rule has already been loaded
 I $D(@RORUPDPI@(3,RULENAME))  D  Q 0
 . S @RORUPDPI@(3,RULENAME,2,REGIEN)=""
 ;---
 N DATELMT,DEPRLC,EXPR,FILE,I,IENS,RORBUF,RORMSG,RULIEN,TMP
 ;--- Load the rule data
 D FIND^DIC(798.2,,"@;1;2I","X",RULENAME,2,"B",,,"RORBUF","RORMSG")
 S RC=$$DBS^RORERR("RORMSG",-9)  Q:RC<0 RC
 Q:$G(RORBUF("DILIST",0))<1 $$ERROR^RORERR(-3,,RULENAME)
 Q:$G(RORBUF("DILIST",0))>1 $$ERROR^RORERR(-4,,RULENAME)
 S RULIEN=+RORBUF("DILIST",2,1),IENS=","_RULIEN_","
 S FILE=+RORBUF("DILIST","ID",1,2)
 ;--- Put the rule data into the temporary global
 S @RORUPDPI@(1,FILE,"S",RULENAME)=""
 S @RORUPDPI@(3,RULENAME)=RULIEN_U_FILE_"^^"_'$G(LEVEL)
 S RC=$$PARSER^RORUPEX(FILE,RORBUF("DILIST","ID",1,1),.EXPR)
 Q:RC<0 RC
 S @RORUPDPI@(3,RULENAME,1)=EXPR
 S @RORUPDPI@(3,RULENAME,2,REGIEN)=""
 M @RORUPDPI@(1,FILE,"F")=EXPR("F")
 S:'$G(LEVEL) RORUPD("LM1",RULENAME)=""
 M @RORUPDPI@(4)=EXPR("L")
 ;--- Load the rules that this rule depends on
 S DEPRLC=""
 F  S DEPRLC=$O(EXPR("R",DEPRLC))  Q:DEPRLC=""  D  Q:RC<0
 . S RC=$$LOADRULE(DEPRLC,REGIEN,$G(LEVEL)+1)
 . S:RC'<0 @RORUPDPI@(3,RULENAME,3,DEPRLC)=""
 Q:RC<0 RC
 ;--- Load a list of additional data elements
 K EXPR,RORBUF,RORMSG
 D LIST^DIC(798.26,IENS,"@;.01I;1I",,,,,"B",,,"RORBUF","RORMSG")
 S RC=$$DBS^RORERR("RORMSG",-9)  Q:RC<0 RC
 S I=""
 F  S I=$O(RORBUF("DILIST","ID",I))  Q:I=""  D
 . S DATELMT=RORBUF("DILIST","ID",I,.01)
 . S TMP=$G(RORBUF("DILIST","ID",I,1))  S:TMP="" TMP="EI"
 . S:TMP["E" @RORUPDPI@(1,FILE,"F",DATELMT,"E")=""
 . S:TMP["I" @RORUPDPI@(1,FILE,"F",DATELMT,"I")=""
 Q 0
 ;
 ;***** LOADS AND PREPARES THE METADATA
METADATA() ;
 N API,DATELMT,DEFL,FILE,I,IENS,IS,PIF,RC,ROOT,RORBUF,RORMSG,TMP,VT
 S RC=$$FILETREE()  Q:RC<0 RC
 S DEFL="@;.02I;1I;4I;4.1;4.2;6I"
 ;--- Load and process the metadata
 S FILE="",RC=0
 F  S FILE=$O(RORUPD("SR",FILE))  Q:FILE=""  D  Q:RC<0
 . S IENS=","_FILE_",",PIF=$NA(@RORUPDPI@(1,FILE))
 . ;--- Global root of the file
 . S RORUPD("ROOT",FILE)=$$ROOT^DILFD(FILE,,1)
 . ;--- Associate data elements with APIs
 . S DATELMT=""
 . F  S DATELMT=$O(@PIF@("F",DATELMT))  Q:DATELMT=""  D  Q:RC<0
 . . ;--- Find and load defintion of the data element
 . . K RORBUF,RORMSG
 . . D FIND^DIC(799.22,IENS,DEFL,"X",DATELMT,,"C",,,"RORBUF","RORMSG")
 . . I $G(DIERR)  D  Q
 . . . S RC=$$DBS^RORERR("RORMSG",-9,,,799.22,IENS)
 . . ;--- Check if search on this element is supported
 . . S API=+$G(RORBUF("DILIST","ID",1,1))
 . . I 'API  D  Q
 . . . S RC=$$ERROR^RORERR(-64,,,,FILE,DATELMT)
 . . ;--- Store the field number (if necessary)
 . . I API=1  D  S RORUPD("SR",FILE,"F",API,DATELMT)=TMP
 . . . S TMP=$G(RORBUF("DILIST","ID",1,6))
 . . ;--- Associate the data element with the API
 . . S VT=$G(RORBUF("DILIST","ID",1,4)),RC=0
 . . F I="E","I"  I $D(@PIF@("F",DATELMT,I))  D  Q:RC<0
 . . . ;--- Check if type of the requested value is supported
 . . . I VT'[I  D  Q
 . . . . S TMP=$$EXTERNAL^DILFD(799.22,4,,I,"RORMSG")
 . . . . S RC=$$ERROR^RORERR(-65,,,,FILE,DATELMT,TMP)
 . . . ;--- Add the API-Element pair to the list
 . . . S TMP=$G(RORBUF("DILIST","ID",1,$$VTFN(I)))
 . . . S RORUPD("SR",FILE,"F",API,DATELMT,I)=TMP
 . Q:RC<0
 . ;--- Add required elements (if any) to the list
 . K RORBUF,RORMSG
 . D FIND^DIC(799.22,IENS,DEFL,"X",1,,"AR",,,"RORBUF","RORMSG")
 . I $G(DIERR)  D  Q
 . . S RC=$$DBS^RORERR("RORMSG",-9,,,799.22,IENS)
 . S IS=""
 . F  S IS=$O(RORBUF("DILIST","ID",IS))  Q:IS=""  D
 . . S DATELMT=+$G(RORBUF("DILIST","ID",IS,.02))  Q:'DATELMT
 . . S API=+$G(RORBUF("DILIST","ID",IS,1))        Q:'API
 . . S VT=$G(RORBUF("DILIST","ID",IS,4))
 . . F I="E","I"  D:VT[I
 . . . S TMP=$G(RORBUF("DILIST","ID",IS,$$VTFN(I)))
 . . . S RORUPD("SR",FILE,"F",API,DATELMT,I)=TMP
 . . ;--- Store the field number (if necessary)
 . . I API=1  D  S RORUPD("SR",FILE,"F",API,DATELMT)=TMP
 . . . S TMP=$G(RORBUF("DILIST","ID",IS,6))
 . ;--- Compile a list of fields (separated by ';') for the GETS^DIQ
 . Q:$D(RORUPD("SR",FILE,"F",1))<10
 . S (DATELMT,RORBUF)=""
 . F  S DATELMT=$O(RORUPD("SR",FILE,"F",1,DATELMT))  Q:DATELMT=""  D
 . . S TMP=+$G(RORUPD("SR",FILE,"F",1,DATELMT))
 . . S:TMP>0 RORBUF=RORBUF_";"_TMP
 . S RORUPD("SR",FILE,"F",1)=$S(RORBUF'="":$P(RORBUF,";",2,999),1:"")
 Q $S(RC<0:RC,1:0)
 ;
 ;***** RETURNS FIELD NUMBER OF ADDITIONAL DATA
VTFN(VT) ;
 Q $S(VT="E":4.1,1:4.2)
