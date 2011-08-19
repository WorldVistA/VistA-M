RORUPR ;HCIOFO/SG - SELECTION RULES PREPARATION  ; 5/12/05 9:22am
 ;;1.5;CLINICAL CASE REGISTRIES;;Feb 17, 2006
 ;
 Q
 ;
 ;***** PREPARES SELECTION RULES AND OTHER DATA
 ;
 ; .REGLST       Reference to a local array containing registry names
 ;               as subscripts and optional registry IENs as values
 ;
 ; [LMODE]       When stop looping through records of the patient:
 ;                 0  always loop through all records
 ;                 1  all top level rules have been triggered (deflt)
 ;                 2  patient has been marked for addition to all
 ;                    registries being processed
 ;
 ; [DSBEG]       Start date/time of the data scan (the earliest
 ;               registry update date by default)
 ;
 ; [DSEND]       End date/time of the data scan (NOW by default)
 ;
 ; Return Values:
 ;        0  Ok
 ;       <0  Error code
 ;
PREPARE(REGLST,LMODE,DSBEG,DSEND) ;
 N FILE,I,RC
 ;--- Clear loop control lists
 K RORUPD("LM")  S RORUPD("LM")=+$G(LMODE,1)
 ;--- Load registry parameters
 S RC=$$PREPARE1(.REGLST,$G(DSBEG),$G(DSEND))  Q:RC<0 RC
 ;--- Load selection rules
 S RC=$$LOAD^RORUPR1(.REGLST)        Q:RC<0 $$ERROR^RORERR(-19)
 ;--- Load and prepare Lab search data
 S RC=$$LABSRCH^RORUPR1()            Q:RC<0 $$ERROR^RORERR(-12)
 ;--- Sort loaded rules
 S RC=$$SORT()                       Q:RC<0 $$ERROR^RORERR(-20)
 ;--- Load and prepare metadata
 S RC=$$METADATA^RORUPR1()           Q:RC<0 RC
 Q 0
 ;
 ;***** LOADS REGISTRY PARAMETERS
 ;
 ; .REGLST       Reference to a local array containing
 ;               registry names as subscripts
 ;
 ; [DSBEG]       Start date of the data scan (the earliest registry
 ;               update date by default). Time part of the parameter
 ;               value is ignored.
 ;
 ; [DSEND]       End date/time of the data scan (NOW by default).
 ;
 ; Return Values:
 ;        0  Ok
 ;       <0  Error code
 ;
PREPARE1(REGLST,DSBEG,DSEND) ;
 N DATE,EVTPROT,I,RC,REGIEN,REGNAME,RORBUF,TMP,UPDSTART
 K RORUPD("LD"),RORUPD("LM2"),RORUPD("UPD")
 S DSBEG=$G(DSBEG)\1,DSEND=+$G(DSEND)
 S UPDSTART=$$DT^XLFDT,EVTPROT=0
 ;---
 S REGNAME="",RC=0
 F  S REGNAME=$O(REGLST(REGNAME))  Q:REGNAME=""  D  Q:RC<0
 . S TMP="1I;6.1;6.2;15.1;25I;26I"
 . S REGIEN=$$REGIEN^RORUTL02(REGNAME,TMP,.RORBUF)
 . I REGIEN'>0  S RC=$$ERROR^RORERR(-46,,REGNAME)  Q
 . ;--- Add an item to the static list of registries
 . S RORUPD("LM2",REGIEN)=U_$G(RORBUF("DILIST","ID",1,26))
 . ;--- Load and verify update entry points
 . S RC=0
 . F I=1,2  D  Q:RC<0
 . . S TMP=$G(RORBUF("DILIST","ID",1,+("6."_I)))
 . . S TMP=$$TRIM^XLFSTR(TMP)  Q:TMP=""
 . . S RC=$$VERIFYEP^RORUTL01(TMP)
 . . S:RC'<0 RORUPD("UPD",REGIEN,I)=TMP
 . I RC<0  S RC=$$ERROR^RORERR(-6,,REGNAME,,TMP)  Q
 . ;--- Calculate the earliest update date for the registries
 . ;    being processed
 . S DATE=$G(RORBUF("DILIST","ID",1,1))\1
 . I DATE  S:DATE<UPDSTART UPDSTART=DATE
 . ;--- Calculate the longest lag interval
 . S TMP=$G(RORBUF("DILIST","ID",1,15.1))
 . S:TMP>$G(RORUPD("LD",1)) RORUPD("LD",1)=TMP
 . ;--- Check if event references should be used
 . S:$G(RORBUF("DILIST","ID",1,25)) EVTPROT=1
 Q:RC<0 RC
 ;--- Check the lag interval
 S:$G(RORUPD("LD",1))'>0 RORUPD("LD",1)=1
 ;--- Define data scan period
 S RORUPD("DT")=$$NOW^XLFDT
 S RORUPD("DSBEG")=$S(DSBEG:DSBEG,1:UPDSTART)
 S RORUPD("DSEND")=$S(DSEND:DSEND,1:RORUPD("DT"))
 ;--- Check if we have event references in the file #798.3
 S RORUPD("EETS")=$O(^RORDATA(798.3,"AT",""))
 S:'RORUPD("EETS") EVTPROT=0
 ;--- Check the control flags
 S:'EVTPROT RORUPD("FLAGS")=$TR($G(RORUPD("FLAGS")),"E")
 Q 0
 ;
 ;***** PUTS THE RULE INTO THE LIST
 ;
 ; RULENAME      Name of the rule
 ; MODE          "A" (process after subfiles) or
 ;               "B" (process before subfiles)
 ; PARENT        Name of the parent rule
 ; 
 ; Return Values:
 ;        0  Ok
 ;       <0  Error code
 ;
PUTRULE(RULENAME,MODE,PARENT) ;
 N CODE,DSTNODE,DEPNAME,HDR,FILE,IR,IC
 S HDR=$G(@RORUPDPI@(3,RULENAME)),FILE=+$P(HDR,U,2)
 ;--- If the rule has already been processed, try to remove it from
 ;    the dependency list of the parent rule
 I $P(HDR,U,3)  D REMOVE(RULENAME,FILE,MODE,$G(PARENT))  Q 0
 ;--- If the rule is in the list of parent rules already, it has been
 ;    mentioned ; somewhere above in the current processing path.
 ;    So, we have "cirle refrenece" (the rule directly or inderectly
 ;    depends on itself)
 Q:$D(LSTRUL(RULENAME)) $$ERROR^RORERR(-5,,RULENAME)
 ;--- Put the rule into the list of parent rules
 S LSTRUL(RULENAME)=""
 ;--- Process the rules that this one depends on
 S DEPNAME=""
 F  S DEPNAME=$O(@RORUPDPI@(3,RULENAME,3,DEPNAME))  Q:DEPNAME=""  D  Q:RC<0
 . S RC=$$PUTRULE(DEPNAME,MODE,RULENAME)
 ;--- Remove the rule from the list of parent rules
 K LSTRUL(RULENAME)  Q:RC<0 RC
 ;--- Process the rule (put it in the sorted list of rules) if there
 ;    are no rules left in its dependency list
 D:$D(@RORUPDPI@(3,RULENAME,3))<10
 . S IR=$O(RORUPD("SR",FILE,MODE,""),-1)+1
 . S DSTNODE=$NA(RORUPD("SR",FILE,MODE,IR))
 . S @DSTNODE=RULENAME_U_+HDR_U_$P(HDR,U,4)
 . S @DSTNODE@(1)=@RORUPDPI@(3,RULENAME,1)
 . M @DSTNODE@(2)=@RORUPDPI@(3,RULENAME,2)
 . S $P(@RORUPDPI@(3,RULENAME),U,3)=1
 . ;--- Try to remove the rule from the dependency list of
 . ;    the parent rule
 . D REMOVE(RULENAME,FILE,MODE,$G(PARENT))
 Q 0
 ;
 ;***** REMOVES THE RULE FROM THE DEPENDENCY LIST OF THE PARENT RULE
 ;
 ; RULENAME      Name of the rule
 ; FILE          File number
 ; MODE          "A" (process after subfiles) or
 ;               "B" (process before subfiles)
 ; PARENT        Name of the parent rule
 ;
 ; During the first pass of the sort ("before" rules) a rule is
 ; removed from the parent's dependency list only if the rule is
 ; associated with the same file as its parent.
 ;
 ; Rules are always removed from the dependency list during
 ; the second sort pass ("after" rules").
 ;
REMOVE(RULENAME,FILE,MODE,PARENT) ;
 Q:$G(PARENT)=""
 K:(+$P($G(@RORUPDPI@(3,PARENT)),U,2)=FILE)!(MODE="A") @RORUPDPI@(3,PARENT,3,RULENAME)
 Q
 ;
 ;***** SORTS SELECTION RULES
 ;
 ; Return Values:
 ;        0  Ok
 ;       <0  Error code
 ;
SORT() ;
 N LSTRUL        ; List of names of the parent rules above in the path
 ;
 N FILE,MODE,RC,RULENAME
 S RC=0  K RORUPD("SR")
 ;--- Process "before" selection rules first and then process
 ;  "after" rules
 F MODE="B","A"  D  Q:RC
 . S FILE=""             ; Loop through affected files
 . F  S FILE=$O(@RORUPDPI@(1,FILE))  Q:FILE=""  D  Q:RC
 . . S RULENAME=""       ; Loop through top level rules
 . . F  S RULENAME=$O(@RORUPDPI@(1,FILE,"S",RULENAME))  Q:RULENAME=""  D  Q:RC<0
 . . . S RC=$$PUTRULE(RULENAME,MODE)
 ;---
 Q $S(RC<0:RC,1:0)
