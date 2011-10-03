RORTSK13 ;HIOFO/SG,VAC - PARSER FOR REPORT PARAMETERS ;4/7/09 2:05pm
 ;;1.5;CLINICAL CASE REGISTRIES;**1,8**;Feb 17, 2006;Build 8
 ;
 ; Modified March 2009 to support ICD9FILT parameter passed in
 ;
 ; This routine uses the following IAs:
 ;
 ; #1995         $$CODEN^ICPTCOD (supported)
 ; #3990         $$CODEN^ICDCODE (supported)
 ; #4149         EN^MXMLPRSE (supported)
 ;
 ; RORXML -------------- DESCRIPTOR FOR THE XML PARSING
 ;
 ; RORXML(
 ;
 ;   "ERR")              Number of parsing errors
 ;
 ;   "PATH")             Path to the current XML tag
 ;
 ;   "RXGRP")            Name of the current drug group
 ;
 ;   "TI")               Number of the current text line of
 ;                       the current tag value
 ;
 Q
 ;
 ;***** START DOCUMENT CALLBACK FOR THE SAX PARSER
DOCSTART ;
 S RORXML("PATH")="",RORXML("ERR")=0
 K RORXML("RXGRP")
 Q
 ;
 ;***** DUMMY CALLBACKS FOR THE SAX PARSER
DUMMY(DUMMY1,DUMMY2,DUMMY3) ;
DUMMY1 Q
 ;
 ;***** END ELEMENT CALLBACK FOR THE SAX PARSER
 ;
 ; ELMT          Name of the element
 ;
ELEND(ELMT) ;
 ;--- Reset the drug group name in the end of the group
 K:RORXML("PATH")="PARAMS,DRUGS,GROUP" RORXML("RXGRP")
 ;--- Reset the ICD-9 group name in the end of the group
 K:RORXML("PATH")="PARAMS,ICD9LST,GROUP" RORXML("ICD9GRP")
 K:RORXML("PATH")="PARAMS,ICD9FILT,GROUP" RORXML("ICD9GRP")
 ;--- Update the current element path
 S RORXML("PATH")=$P(RORXML("PATH"),",",1,$L(RORXML("PATH"),",")-1)
 Q
 ;
 ;***** START DOCUMENT CALLBACK FOR THE SAX PARSER
 ;
 ; ELMT          Name of the element
 ; .ATTR         List of attributes and their values
 ;
ELSTART(ELMT,ATTR) ;
 N GROUP,ID,IEN,ITEM,LIST,LVL,RC,SECTION,TMP
 ;--- Update the current element path
 S RORXML("PATH")=RORXML("PATH")_$S(RORXML("PATH")'="":",",1:"")_ELMT
 S RORXML("TI")=1
 ;--- Ignore everything except parameters
 Q:$P(RORXML("PATH"),",")'="PARAMS"
 S LVL=$L(RORXML("PATH"),",")
 ;
 ;=== Store 3-level lists
 I LVL=5  D  Q
 . S LIST=$P(RORXML("PATH"),",",LVL-3,LVL-1)
 . ;--- Medications and drug classes
 . I $P(LIST,",",1,2)="DRUGS,GROUP"  D  Q
 . . S GROUP=$G(RORXML("RXGRP"))  Q:GROUP=""
 . . S SECTION=$P(LIST,",",3)     Q:SECTION=""
 . . S ID=$G(ATTR("ID"))          Q:ID=""
 . . S RORTSK("PARAMS","DRUGS","G",GROUP,SECTION,ID)=$G(ATTR("CODE"))
 ;
 ;=== Store 2-level lists
 I LVL=4  D  Q
 . S LIST=$P(RORXML("PATH"),",",LVL-2,LVL-1)
 . ;--- ICD-9 diagnosis or procedure codes
 . I LIST="ICD9LST,GROUP"  D  Q
 . . S GROUP=$G(RORXML("ICD9GRP"))  Q:GROUP=""
 . . S ID=$G(ATTR("ID"))            Q:ID=""
 . . S TMP=$S($G(RORTSK("PARAMS","ICD9LST","A","PROCMODE")):80.1,1:80)
 . . S IEN=+$$CODEN^ICDCODE(ID,TMP)
 . . S:IEN>0 RORTSK("PARAMS","ICD9LST","G",GROUP,"C",IEN)=ID
 .;--- ICD9 codes
 . I LIST="ICD9FILT,GROUP" D  Q
 . . S GROUP=$G(RORXML("ICD9GRP"))  Q:GROUP=""
 . . S ID=$G(ATTR("ID"))            Q:ID=""
 . . S IEN=+$$CODEN^ICDCODE(ID,80)
 . . S:IEN>0 RORTSK("PARAMS","ICD9FILT","G",GROUP,"C",IEN)=ID
 ;
 ;=== Store the lists
 I LVL=3  D  Q
 . S LIST=$P(RORXML("PATH"),",",LVL-1)
 . ;--- List of ICD-9 codes
 . I LIST="CPTLST"  D:ELMT="CPT"  Q
 . . S ID=$G(ATTR("ID"))  Q:ID=""
 . . S IEN=+$$CODEN^ICPTCOD(ID)
 . . S:IEN>0 RORTSK("PARAMS",LIST,"C",IEN)=ID
 . ;--- Name of the current drug group and its attributes
 . I LIST="DRUGS"  D:ELMT="GROUP"  Q
 . . S (RORXML("RXGRP"),ID)=$G(ATTR("ID"))  Q:ID=""
 . . M RORTSK("PARAMS","DRUGS","G",ID,"A")=ATTR
 . . K RORTSK("PARAMS","DRUGS","G",ID,"A","ID")
 . ;--- Name of the current ICD-9 group
 . I (LIST="ICD9LST")!(LIST="ICD9FILT")  D:ELMT="GROUP"  Q
 . . S RORXML("ICD9GRP")=$G(ATTR("ID"))
 . ;--- List of ICD-9 codes
 . ;I LIST="ICD9LST"  D:ELMT="ICD9"  Q
 . ;. S ID=$G(ATTR("ID"))  Q:ID=""
 . ;. S TMP=$S($G(RORTSK("PARAMS","ICD9LST","A","PROC")):80.1,1:80)
 . ;. S IEN=+$$CODEN^ICDCODE(ID,TMP)
 . ;. S:IEN>0 RORTSK("PARAMS",LIST,"C",IEN)=ID
 . ;--- Lab tests
 . I LIST="LABTESTS"  D:ELMT="LT"  Q
 . . S ID=$G(ATTR("ID"))  Q:ID=""
 . . S RORTSK("PARAMS","LABTESTS","C",ID)=""
 . . S TMP=$G(ATTR("LOW"))
 . . S:TMP'="" RORTSK("PARAMS","LABTESTS","C",ID,"L")=TMP
 . . S TMP=$G(ATTR("HIGH"))
 . . S:TMP'="" RORTSK("PARAMS","LABTESTS","C",ID,"H")=TMP
 . ;--- Laboratory test ranges
 . I LIST="LRGRANGES"  D:ELMT="LRGRANGE"  Q
 . . S ID=$G(ATTR("ID"))  Q:'$G(ATTR("USE"))!(ID="")
 . . S RORTSK("PARAMS",LIST,"C",ID)=""
 . . S TMP=$G(ATTR("LOW"))
 . . S:TMP'="" RORTSK("PARAMS",LIST,"C",ID,"L")=TMP
 . . S TMP=$G(ATTR("HIGH"))
 . . S:TMP'="" RORTSK("PARAMS",LIST,"C",ID,"H")=TMP
 . ;--- "Include/Exclude" list processing
 . I (LIST="LOCAL_FIELDS")!(LIST="OTHER_REGISTRIES")  D  Q
 . . S ID=$G(ATTR("ID"))  Q:ID=""
 . . S TMP=+$G(ATTR("MODE"))  ; 1 - Include; -1 - Exclude
 . . S:TMP RORTSK("PARAMS",LIST,"C",ID)=TMP
 . ;--- Default processing
 . S TMP=","_LIST_","
 . Q:'(",CLINICS,DIVISIONS,OPTIONAL_COLUMNS,PATIENTS,SELRULES,UTIL_TYPES,"[TMP)
 . S ID=$G(ATTR("ID"))
 . S:ID'="" RORTSK("PARAMS",LIST,"C",ID)=""
 ;
 ;=== Store the top-level attributes
 I LVL=2  D  Q
 . ;--- Date range(s)
 . I ELMT?1"DATE_RANGE".1(1"_"1.N)  D  Q
 . . N STDT,ENDT
 . . S RC=$$DTRANGE^RORTSK14(.ATTR,.STDT,.ENDT)  Q:RC<0
 . . S RORTSK("PARAMS",ELMT,"A","START")=STDT
 . . S RORTSK("PARAMS",ELMT,"A","END")=ENDT
 . ;--- Ignore internal nodes
 . Q:ELMT="PANELS"
 . ;--- Default processing
 . M RORTSK("PARAMS",ELMT,"A")=ATTR
 ;
 ;--- Ignore everything else
 Q
 ;
 ;***** TEXT CALLBACK FOR THE SAX PARSER
 ;
 ; TXT           Line of unmarked text
 ;
ELTEXT(TXT) ;
 N ITEM,LIST,LVL
 S LVL=$L(RORXML("PATH"),",")
 ;--- Store top-level values
 I LVL=2  D  Q
 . S ITEM=$P(RORXML("PATH"),",",LVL)
 . S RORTSK("PARAMS",ITEM)=$G(RORTSK("PARAMS",ITEM))_TXT
 ;--- Ignore everything else
 Q
 ;
 ;***** ERROR CALLBACK FOR THE SAX PARSER
 ;
 ; .ERR          Reference to a local variable containing
 ;               informations about the error
 ;
ERROR(ERR) ;
 N ERRCODE,RORINFO,TMP
 I ERR("SEV")  D
 . S ERRCODE=-105,RORXML("ERR")=$G(RORXML("ERR"))+1
 E  S ERRCODE=-104
 ;--- Prepare message details
 S RORINFO(1)=$TR(ERR("MSG"),U,"~")
 S TMP=$P("Warning^Validation Error^Conformance Error",U,ERR("SEV")+1)
 S RORINFO(2)=TMP_" in line #"_ERR("LIN")_" (pos#"_ERR("POS")_")"
 S RORINFO(3)=$TR(ERR("XML"),$C(9,10,13)," ")
 ;--- Record the error message
 D ERROR^RORERR(ERRCODE,,.RORINFO)
 Q
 ;
 ;***** PARSES AND PREPARES THE REPORT PARAMETERS
 ;
 ; .PARAMS       Reference to a local variable that contains report
 ;               parameters in XML format. This variable is KILL'ed
 ;               by this function.
 ;
 ; .RORTSK       Reference to a local variable that contains a task
 ;               descriptor.
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;
PARSEPRM(PARAMS,RORTSK) ;
 K RORTSK("PARAMS")
 Q:$D(PARAMS)<10 0
 ;---
 N CBK,RORSRC,RORSUBS,RORTMP,RORXML
 S RORSRC=$$ALLOC^RORTMP()          ; Source buffer for XML
 S RORTMP=$$ALLOC^RORTMP(.RORSUBS)  ; Temporary buffer
 ;--- Copy the XML document into a global since the parser
 ;--- cannot read it from a local variable
 M @RORSRC=PARAMS  K PARAMS
 ;--- Parse the parameters
 S CBK("CHARACTERS")="ELTEXT^RORTSK13"
 S CBK("COMMENT")="DUMMY^RORTSK13"
 S CBK("DOCTYPE")="DUMMY^RORTSK13"
 S CBK("ENDDOCUMENT")="DUMMY1^RORTSK13"
 S CBK("ENDELEMENT")="ELEND^RORTSK13"
 S CBK("ERROR")="ERROR^RORTSK13"
 S CBK("EXTERNAL")="DUMMY^RORTSK13"
 S CBK("NOTATION")="DUMMY^RORTSK13"
 S CBK("PI")="DUMMY^RORTSK13"
 S CBK("STARTDOCUMENT")="DOCSTART^RORTSK13"
 S CBK("STARTELEMENT")="ELSTART^RORTSK13"
 D EN^MXMLPRSE(RORSRC,.CBK,"W")
 ;--- Cleanup
 D FREE^RORTMP(RORTMP),FREE^RORTMP(RORSRC)
 Q $S($G(RORXML("ERR"))>0:$$ERROR^RORERR(-106),1:0)
