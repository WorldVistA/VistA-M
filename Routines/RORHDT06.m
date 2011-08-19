RORHDT06 ;HCIOFO/SG - HISTORICAL DATA EXTRACTION PARAMETERS ; 11/30/05 10:03am
 ;;1.5;CLINICAL CASE REGISTRIES;;Feb 17, 2006
 ;
 Q
 ;
 ;***** UPDATES COMPLETION DATE FOR THE REGISTRY
 ;
 ; HDTIEN        IEN of the data extraction definition
 ; REGNAME       Registry name
 ; [DATE]        Completion date/time (current, if omitted)
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;
COMPLETE(HDTIEN,REGNAME,DATE) ;
 Q:HDTIEN'>0 0
 Q:$G(^RORDATA(799.6,+HDTIEN,0))="" 0
 N IEN,IENS,INFO,RORFDA,RORMSG,TMP,TYPE
 ;--- Search for the registry record in the backpull definition
 S IENS=","_(+HDTIEN)_","
 S IEN=$$FIND1^DIC(799.63,IENS,"QX",REGNAME,"B",,"RORMSG")
 Q:$G(DIERR) $$DBS^RORERR("RORMSG",-9,,,799.63,IENS)
 Q:IEN'>0 0
 ;--- Update the completion date
 S DATE=$S($G(DATE,-1)<0:$$NOW^XLFDT,'DATE:"",1:DATE)
 S RORFDA(799.63,IEN_IENS,.02)=DATE
 D FILE^DIE(,"RORFDA","RORMSG")
 Q:$G(DIERR) $$DBS^RORERR("RORMSG",-9,,,799.63,IEN_IENS)
 ;--- Success
 S TMP=$$MSG^RORERR20(-109,.TYPE)
 S INFO(1)=$$GET1^DIQ(799.6,(+HDTIEN)_",",.01,,,"RORMSG")
 S INFO(2)=REGNAME
 D LOG^RORLOG(TYPE,TMP,,.INFO)
 Q 0
 ;
 ;***** SEARCHES FOR A PENDING HISTORICAL DATA EXTRACTION
 ;
 ; .RORGLST      Reference to a local array containing registry names
 ;               as subscripts and optional registry IENs as values.
 ;            
 ;               If a definition of a pending historical data
 ;               extraction is found, then the function removes
 ;               the registries, which are not referenced by the
 ;               definition, from this list.
 ;
 ; [.SDT]        Reference to a local variable where the start
 ;               date of the main time frame for the historical
 ;               extraction will be returned.
 ;
 ; [.EDT]        Reference to a local variable where the end
 ;               date of the main time frame for the historical
 ;               extraction will be returned.
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  There are no pending historical data extractions
 ;       >0  IEN of the data extraction definition
 ;
FIND(RORGLST,SDT,EDT) ;
 N HDTIEN,NODE,REGNAME,RORBUF,RORMSG,SCR,TMP
 S (EDT,SDT)=""
 ;--- Search for a pending historical data extraction
 S TMP="@;.03I;.04I"
 S SCR="I $P($G(^(0)),U,7)\1'>DT,$$FINDSCR^RORHDT06(Y)"
 D LIST^DIC(799.6,,TMP,"Q",1,,,"ADNAUTO",SCR,,"RORBUF","RORMSG")
 Q:$G(DIERR) $$DBS^RORERR("RORMSG",-9,,,799.6)
 Q:$G(RORBUF("DILIST",0))'>0 0
 S HDTIEN=+$G(RORBUF("DILIST",2,1))
 Q:HDTIEN'>0 0
 ;--- Keep only the registries referenced by the definition
 S NODE=$$ROOT^DILFD(799.63,","_HDTIEN_",",1)
 S REGNAME=""
 F  S REGNAME=$O(RORGLST(REGNAME))  Q:REGNAME=""  D
 . K:'$D(@NODE@("ANC",REGNAME)) RORGLST(REGNAME)
 ;--- Return the dates and IEN
 S SDT=$G(RORBUF("DILIST","ID",1,.03))
 S EDT=$G(RORBUF("DILIST","ID",1,.04))
 Q HDTIEN
 ;
 ;***** CHECKS IF THE BACKPULL SHOULD BE PROCESSED BY THE TASK
 ;
 ; HDTIEN        IEN of the data extraction definition
 ;
 ; Return Values:
 ;        0  Skip
 ;        1  Include
 ;
FINDSCR(HDTIEN) ;
 N REGNAME  S REGNAME=""
 F  D  Q:REGNAME=""  Q:$D(RORGLST(REGNAME))
 . S REGNAME=$O(^RORDATA(799.6,HDTIEN,3,"ANC",REGNAME))
 Q (REGNAME'="")
 ;
 ;***** PREPARES HISTORICAL DATA EXTRACTION PARAMETERS
 ;
 ; HDTIEN        IEN of the data extraction definition
 ;
 ; Return Values:
 ;        0  Ok
 ;       <0  Error code
 ;
PREPARE(HDTIEN) ;
 N DAC,HDTNAME,IENS,NODE,RC,RORBUF,RORMSG,SCR,SDT,TMP,TYPE
 I $G(HDTIEN)'>0  D  Q 0
 . K ROREXT("HDTIEN")
 S ROREXT("HDTIEN")=+HDTIEN,RC=0
 ;--- Load the parameters
 S IENS=+HDTIEN_","
 D GETS^DIQ(799.6,IENS,".01;.06;1*","I","RORBUF","RORMSG")
 Q:$G(DIERR) $$DBS^RORERR("RORMSG",-9,,,799.6,IENS)
 S HDTNAME=$G(RORBUF(799.6,IENS,.01,"I"))
 ;--- Override the maximum message size (if requested)
 S TMP=$G(RORBUF(799.6,IENS,.06,"I"))
 I TMP>0  S ROREXT("MAXHL7SIZE")=(TMP*1048576)\1
 E  K:TMP=0 ROREXT("MAXHL7SIZE")
 ;--- Override the data areas
 K ROREXT("DTAR")
 S NODE=$$ROOT^DILFD(799.33,,1)
 S IENS=""
 F  S IENS=$O(RORBUF(799.61,IENS))  Q:IENS=""  D
 . S DAC=+$G(RORBUF(799.61,IENS,.01,"I"))
 . Q:'$D(@NODE@(DAC))
 . S SDT=+$G(RORBUF(799.61,IENS,.02,"I"))  ; Start Date
 . I SDT'>0  S ROREXT("DTAR",DAC)=""  Q
 . S TMP=+$G(RORBUF(799.61,IENS,.03,"I"))  ; End Date
 . S:TMP>0 ROREXT("DTAR",DAC)=SDT_U_TMP
 ;--- Ignore the lag days
 K ROREXT("LD")
 ;--- Set the special batch message date (BHS-6) to make
 ;    sure that timestamps of historical clinical units are
 ;--- earlier than those of the regular ones.
 S ROREXT("HL7DT")=$$FMADD^XLFDT(ROREXT("DXEND")\1,,,1)
 ;--- Success
 S TMP=$$MSG^RORERR20(-108,.TYPE)
 D LOG^RORLOG(TYPE,TMP,,HDTNAME)
 Q 0
 ;
 ;***** STORES THE BACKPULL REFERENCE INTO THE REGISTRY PARAMETERS
 ;
 ; .REGLST       Reference to a local array containing registry
 ;               names as subscripts and registry IENs as values.
 ;
 ; HDTIEN        IEN of the data extraction definition
 ;
REGREF(REGLST,HDTIEN) ;
 N RC,REGIEN,REGNAME,RORFDA,RORMSG
 S REGNAME="",RC=0
 F  S REGNAME=$O(REGLST(REGNAME))  Q:REGNAME=""  D  Q:RC<0
 . S REGIEN=+REGLST(REGNAME)
 . I REGIEN'>0  D  I REGIEN'>0  S RC=REGIEN  Q
 . . S REGIEN=$$REGIEN^RORUTL02(REGNAME)
 . K RORFDA,RORMSG
 . S RORFDA(798.1,REGIEN_",",21.01)=$S(HDTIEN>0:+HDTIEN,1:"@")
 . D FILE^DIE(,"RORFDA","RORMSG")
 . S:$G(DIERR) RC=$$DBS^RORERR("RORMSG",-9,,,798.1,REGIEN_",")
 ;---
 Q $S(RC<0:RC,1:0)
