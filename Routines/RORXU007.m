RORXU007 ;HCIOFO/SG - PHARMACY-RELATED REPORT PARAMETERS ; 11/25/05 6:00pm
 ;;1.5;CLINICAL CASE REGISTRIES;;Feb 17, 2006
 ;
 ; This routine uses the following IAs:
 ;
 ; #4533         ZERO^PSS50 (supported)
 ; #4540         ZERO^PSN50P6 (supported)
 ; #4543         IEN^PSN50P65 (supported)
 ;
 Q
 ;
 ;***** PROCESSES THE "DRUGS" REPORT PARAMETER
 ;
 ; .RORTSK       Task number and task parameters
 ;
 ; PARTAG        Reference (IEN) to the parent tag
 ;
 ; .ROR8LST      Reference to a local variable, which contains a
 ;               closed root of an array. IEN's of dispensed drugs
 ;               will be returned into this array.
 ;
 ;                 @ROR8LTST@(DrugIEN,Group#) = ""
 ;
 ;               If this parameter is undefined or empty, then a
 ;               temporary buffer is allocated by the $$ALLOC^RORTMP
 ;               function and its root is returned via this parameter.
 ;
 ;               If all drugs are requested (the "ALL" attribute of
 ;               the "DRUGS" tag), then "*" is returned.
 ;
 ; [.GRPLST]     Reference to a local variable that will contain
 ;               the list of drug groups.
 ;
 ;                 GRPLST(
 ;                   "C",Group#)    = GroupName
 ;                   "N",GroupName) = Group#
 ;
 ; Return Values:
 ;       <0  Error code
 ;       >0  IEN of the DRUGS element
 ;
DRUGLST(RORTSK,PARTAG,ROR8LST,GRPLST) ;
 N LTAG,RC,RXALL,RXOPTS,TMP
 S RXALL=+$$PARAM^RORTSK01("DRUGS","ALL")
 S (LTAG,RC)=0
 ;
 ;=== Validate parameters
 I RXALL  D  S ROR8LST="*"
 . F TMP="INVESTIG","REGMDES"  K RORTSK("PARAMS","DRUGS","A",TMP)
 E  D  K @ROR8LST
 . S:$G(ROR8LST)="" ROR8LST=$$ALLOC^RORTMP()
 . ;--- Aggregate by individual formulations if investigational
 . ;--- medications are selected (they are not linked to generics)
 . D:$$PARAM^RORTSK01("DRUGS","AGGR_GENERIC")
 . . N GRPNAME,INV,NODE
 . . I '$$PARAM^RORTSK01("DRUGS","INVESTIG")  S INV=0  D  Q:'INV
 . . . S NODE=$NA(RORTSK("PARAMS","DRUGS","G"))
 . . . S GRPNAME=""
 . . . F  S GRPNAME=$O(@NODE@(GRPNAME))  Q:GRPNAME=""  D  Q:INV
 . . . . S:$G(@NODE@(GRPNAME,"A","INVESTIG")) INV=1
 . . K RORTSK("PARAMS","DRUGS","A","AGGR_GENERIC")
 . . S RORTSK("PARAMS","DRUGS","A","AGGR_FORMUL")=1
 . . S RORTSK("PARAMS","DRUGS","A","AGGR_FORCED")=1
 ;
 ;=== Process the drug options (if present)
 M RXOPTS=RORTSK("PARAMS","DRUGS","A")
 I $D(RXOPTS)>1  D  Q:LTAG'>0 LTAG
 . N ATTR,REGIEN
 . S ATTR=$S(RXALL:"ALL",1:"")
 . S LTAG=$$ADDVAL^RORTSK11(RORTSK,"DRUGS",ATTR,PARTAG)
 . Q:LTAG'>0
 . ;--- Output option attributes
 . S ATTR="",RC=0
 . F  S ATTR=$O(RXOPTS(ATTR))  Q:ATTR=""  D  Q:RC<0
 . . S RC=$$ADDATTR^RORTSK11(RORTSK,LTAG,ATTR,"1")
 . I RC<0  S LTAG=RC  Q
 . S ATTR=$$OPTXT^RORXU002(.RXOPTS)
 . D:ATTR'="" ADDATTR^RORTSK11(RORTSK,LTAG,"DESCR",ATTR)
 . ;--- Add registry-specific and/or investigational drugs
 . Q:RXALL
 . S REGIEN=+$$PARAM^RORTSK01("REGIEN"),TMP="AR"
 . S:$G(RXOPTS("INVESTIG")) TMP=TMP_"C"
 . S:$G(RXOPTS("REGMEDS")) TMP=TMP_"DG"
 . S RC=$$DRUGLIST^RORUTL16(ROR8LST,REGIEN,TMP)
 ;
 ;=== Process the list of drugs (if present)
 I 'RXALL  D:$D(RORTSK("PARAMS","DRUGS","G"))>1
 . N GRPNAME,GRPTAG,IG,NODE
 . I LTAG'>0  D  Q:LTAG'>0
 . . S LTAG=$$ADDVAL^RORTSK11(RORTSK,"DRUGS",,PARTAG)
 . ;---
 . S NODE=$NA(RORTSK("PARAMS","DRUGS","G"))
 . S GRPNAME="",RC=0
 . F  S GRPNAME=$O(@NODE@(GRPNAME))  Q:GRPNAME=""  D  Q:RC<0
 . . S IG=$O(GRPLST("C",""),-1)+1
 . . S GRPLST("C",IG)=GRPNAME,GRPLST("N",GRPNAME)=IG
 . . S GRPTAG=$$DRUGLST1(LTAG,GRPNAME,IG)
 . . I GRPTAG'>0  S RC=GRPTAG  Q
 . . ;--- Individual Formulations
 . . S RC=$$DRUGLSTF(GRPTAG,GRPNAME,IG)  Q:RC<0
 . . ;--- Generic Names
 . . S RC=$$DRUGLSTG(GRPTAG,GRPNAME,IG)  Q:RC<0
 . . ;--- Drug Classes
 . . S RC=$$DRUGLSTC(GRPTAG,GRPNAME,IG)  Q:RC<0
 ;
 ;===
 Q $S(RC<0:RC,1:LTAG)
 ;
 ;***** PROCESS THE GROUP ATTRIBUTES
 ;
 ; PTAG          Reference (IEN) to the parent tag
 ; GRPNAME       Group Name
 ; GRPCODE       Group Code (sequential number)
 ;
 ; Return Values:
 ;       <0  Error code
 ;       >0  IEN of the GROUP element
 ;
DRUGLST1(PTAG,GRPNAME,GRPCODE) ;
 N GRPOPTS,GRPTAG,RC,TMP
 ;--- Create the group tag
 S GRPTAG=$$ADDVAL^RORTSK11(RORTSK,"GROUP",,PTAG)
 Q:GRPTAG'>0 GRPTAG
 D ADDATTR^RORTSK11(RORTSK,GRPTAG,"NAME",GRPNAME)
 ;--- Process the group attributes
 M GRPOPTS=RORTSK("PARAMS","DRUGS","G",GRPNAME,"A")
 I $D(GRPOPTS)>1  S RC=0  D  Q:RC<0 RC
 . N ATTR,REGIEN  S ATTR=""
 . F  S ATTR=$O(GRPOPTS(ATTR))  Q:ATTR=""  D  Q:RC<0
 . . S RC=$$ADDATTR^RORTSK11(RORTSK,GRPTAG,ATTR,"1")
 . Q:RC<0
 . S TMP=$$OPTXT^RORXU002(.GRPOPTS)
 . D:TMP'="" ADDATTR^RORTSK11(RORTSK,GRPTAG,"DESCR",TMP)
 . ;--- Add registry-specific and/or investigational drugs
 . S REGIEN=+$$PARAM^RORTSK01("REGIEN"),TMP="AR"
 . S:$G(GRPOPTS("INVESTIG")) TMP=TMP_"C"
 . S:$G(GRPOPTS("REGMEDS")) TMP=TMP_"DG"
 . S RC=$$DRUGLIST^RORUTL16(ROR8LST,REGIEN,TMP,GRPCODE)
 ;---
 Q GRPTAG
 ;
 ;***** PROCESS DRUG CLASSES
 ;
 ; PTAG          Reference (IEN) to the parent tag
 ; GRPNAME       Group Name
 ; GRPCODE       Group Code (sequential number)
 ;
 ; Return Values:
 ;       <0  Error code
 ;       >0  IEN of the VARXCLS element
 ;
DRUGLSTC(PTAG,GRPNAME,GRPCODE) ;
 N CODE,IEN,LTAG,NODE,RORTMP,SUBS
 S NODE=$NA(RORTSK("PARAMS","DRUGS","G",GRPNAME,"VARXCLS"))
 Q:$D(@NODE)<10 0
 S LTAG=$$ADDVAL^RORTSK11(RORTSK,"VARXCLS",,PTAG)
 Q:LTAG<0 LTAG
 ;---
 S RORTMP=$$ALLOC^RORTMP(.SUBS)
 S IEN=0
 F  S IEN=$O(@NODE@(IEN))  Q:IEN'>0  D
 . D IEN^PSN50P65(IEN,,SUBS)
 . S CODE=$G(@RORTMP@(IEN,.01))  Q:CODE=""
 . D ADDVAL^RORTSK11(RORTSK,"VARXCL",CODE,LTAG,,IEN)
 . D RXADDVCL^RORUTL16(ROR8LST,IEN,1,GRPCODE)
 D FREE^RORTMP(RORTMP)
 ;---
 Q LTAG
 ;
 ;***** PROCESS INDIVIDUAL FORMULATIONS
 ;
 ; PTAG          Reference (IEN) to the parent tag
 ; GRPNAME       Group Name
 ; GRPCODE       Group Code (sequential number)
 ;
 ; Return Values:
 ;       <0  Error code
 ;       >0  IEN of the FORMULATIONS element
 ;
DRUGLSTF(PTAG,GRPNAME,GRPCODE) ;
 N IEN,LTAG,NAME,NODE,RORTMP,SUBS
 S NODE=$NA(RORTSK("PARAMS","DRUGS","G",GRPNAME,"FORMULATIONS"))
 Q:$D(@NODE)<10 0
 S LTAG=$$ADDVAL^RORTSK11(RORTSK,"FORMULATIONS",,PTAG)
 Q:LTAG<0 LTAG
 ;---
 S RORTMP=$$ALLOC^RORTMP(.SUBS)
 S IEN=0
 F  S IEN=$O(@NODE@(IEN))  Q:IEN'>0  D
 . D ZERO^PSS50(IEN,,,,,SUBS)
 . S NAME=$G(@RORTMP@(IEN,.01))  Q:NAME=""
 . D ADDVAL^RORTSK11(RORTSK,"DRUG",NAME,LTAG,,IEN)
 . S @ROR8LST@(IEN,GRPCODE)=""
 D FREE^RORTMP(RORTMP)
 ;---
 Q LTAG
 ;
 ;***** PROCESS GENERIC NAMES
 ;
 ; PTAG          Reference (IEN) to the parent tag
 ; GRPNAME       Group Name
 ; GRPCODE       Group Code (sequential number)
 ;
 ; Return Values:
 ;       <0  Error code
 ;       >0  IEN of the GENERIC element
 ;
DRUGLSTG(PTAG,GRPNAME,GRPCODE) ;
 N IEN,LTAG,NAME,NODE,RORTMP,SUBS
 S NODE=$NA(RORTSK("PARAMS","DRUGS","G",GRPNAME,"GENERIC"))
 Q:$D(@NODE)<10 0
 S LTAG=$$ADDVAL^RORTSK11(RORTSK,"GENERIC",,PTAG)
 Q:LTAG<0 LTAG
 ;---
 S RORTMP=$$ALLOC^RORTMP(.SUBS)
 S IEN=0
 F  S IEN=$O(@NODE@(IEN))  Q:IEN'>0  D
 . D ZERO^PSN50P6(IEN,,,,SUBS)
 . S NAME=$G(@RORTMP@(IEN,.01))  Q:NAME=""
 . D ADDVAL^RORTSK11(RORTSK,"DRUG",NAME,LTAG,,IEN)
 . D RXADDGEN^RORUTL16(ROR8LST,IEN,1,GRPCODE)
 D FREE^RORTMP(RORTMP)
 ;---
 Q LTAG
 ;
 ;***** FUNCTION FOR THE PHARMACY SEARCH API
 ;
 ; .RORDST       Reference to the search descriptor
 ; DRUGIEN       IEN of an individual formulation (dispensed drug)
 ; ROR8LST       Closed root of the drug list generated by the
 ;               $$DRUGLST^RORXU007 function or "*" for all drugs.
 ;
 ; Return Values:
 ;        0  Ok
 ;        1  Skip the record
 ;
RXGRPCHK(RORDST,DRUGIEN,ROR8LST) ;
 Q:ROR8LST="*" 0
 Q:$D(@ROR8LST@(DRUGIEN))<10 1
 N GRP  S GRP=""
 F  S GRP=$O(@ROR8LST@(DRUGIEN,GRP))  Q:GRP=""  D
 . K RORDST("RORXGRP",GRP)
 Q 0
