ACKQPCE1 ;HCIOFO/AG - Quasar/PCE Interface; August 1999. ; 5/6/03 11:06am
 ;;3.0;QUASAR;**1,2,5,7,8,16**;Feb 11, 2000;Build 37
 ;Per VHA Directive 2004-038, this routine SHOULD NOT be modified.
 ; this routine contains the code for sending a Quasar visit to PCE
 ; it is called from ACKQPCE.
 ;
SENDPCE(ACKVIEN,ACKPKG,ACKSRC) ; send a Quasar Visit to PCE.
 ; see SENDPCE^ACKQPCE for entry parameters and processing notes.
 ; this routine should not be called directly, only from ACKQPCE
 ; (this routine assumes all the entry parameters are passed!)
 N ACKSENT,ACKLOCK,ACKRSN,ACKMSG,ACKFDA,ACKFDA2,ACKPCE,ACKE,ACKERR,ACKNARR
 N ACKVDT,ACKVTM,ACKPAT,ACKSC,ACKAO,ACKIR,ACKEC,ACKCHKDT,ACKELIG,ACKPROCP
 N ACKVSC,ACKCAT,ACKAPI,ACKCT,ACKPRIM,ACKSCND,ACKSTUD,ACKIEN,ACKICD9
 N ACKCPT,ACKVOL,ACKIEN2,ACKMOD,ACKPROB,ACKARR,ACKDATE,ACKDPRIM,ACKK5,ACKHNC,ACKCV
 ; initialize
 S ACKSENT=0,ACKLOCK=0,ACKERR=0
 D NOW^%DTC S ACKDATE=%  ; to be used for LAST SENT TO PCE field
 ;
 ; lock the visit
 L +^ACK(509850.6,ACKVIEN):$G(DILOCKTM,3) S ACKLOCK=$T
 ; if unable to lock then exit
 I 'ACKLOCK G SENDPCEX
 ;
 ; initialize temp file
 K ^TMP("ACKQPCE1",$J)
 ;
 ; remove PCE errors from the visit
 D CLEAR^ACKQPCE(ACKVIEN)
 ;
 ; get the visit data and place in temp file
 D GETDATA
 ;
 ; if this visit exists in PCE then remove workload data
 D CHKPCE I ACKERR G SENDPCEX
 ;
 ; build the temp file for sending to PCE
 D BUILD
 ;
 ; now send
 D SENDIT
 ;
SENDPCEX ; exit point
 ;
 ; if visit was locked, unlock it
 I ACKLOCK L -^ACK(509850.6,ACKVIEN)
 ;
 ; clear the temp file
 ;K ^TMP("ACKQPCE1",$J)
 ;
 ; return
 Q ACKSENT
 ;
GETDATA ; get the visit data and place in temp file
 S ACKFDA=$NA(^TMP("ACKQPCE1",$J,"FDA"))
 D GETS^DIQ(509850.6,ACKVIEN_",","**","I",ACKFDA,"")
 S ACKFDA2=$NA(^TMP("ACKQPCE1",$J,"FDA",509850.6,ACKVIEN_","))
 ; data now stored in ..
 ;  ^TMP("ACKQPCE1",$J,"FDA",509850.6,visit_",",fldnum,"I")=internal value
 ;  simplified to @ACKFDA2@(fldnum,"I")=internal value
 ;  get the PCE visit ien
 S ACKPCE=@ACKFDA2@(125,"I")
 ; get the visit date and time, patient and clinic
 S ACKVDT=@ACKFDA2@(.01,"I")
 S ACKVTM=@ACKFDA2@(55,"I")
 S ACKPAT=@ACKFDA2@(1,"I")
 S ACKCLN=@ACKFDA2@(2.6,"I")
 ; end of getdata
 Q
 ;
CHKPCE ; check if the visit is already in PCE and remove workload if it is
 I 'ACKPCE Q
 ;
 ; check PCE visit is for same Patient, Clinic, Date and Time
 ;  if any item different then this Qsr visit is treated as new
 ;   and any data from Quasar is deleted from the original PCE visit
 ;  (sending ACKPKG and ACKSRC ensures that only data that originally
 ;  came from Quasar will be removed).
 I +$$PCECHK^ACKQUTL3(ACKPCE,ACKVDT,ACKVTM,ACKPAT,ACKCLN)'=2 D  Q
 . S ACKE=$$DELVFILE^PXAPI("ALL",ACKPCE,ACKPKG,ACKSRC,0,0,"")
 . S ACKPCE=""  ; remove PCE Visit ien from Qsr visit
 . K ACKARR S ACKARR(509850.6,ACKVIEN_",",125)="@"
 . D FILE^DIE("","ACKARR","")
 ;
 ; remove all workload data from the PCE visit
 S ACKE=$$DELVFILE^PXAPI("CPT^POV^PRV^VISIT",ACKPCE,"","",0,0,"")
 S ACKERR=$S(ACKE>-1:0,ACKE=-4:0,1:1)
 ;
 ; if error occurred then store on visit file
 I ACKERR D  Q
 . K ACKRSN S ACKMSG="Unable to delete original PCE visit data (error code="_ACKE_")"
 . D ADDRSN^ACKQPCE2("PCE VISIT",ACKPCE,"",ACKMSG,.ACKRSN)
 . D FILERSN^ACKQPCE(ACKVIEN,.ACKRSN)   ; file errors on visit file
 ;
 ; if no error, check to see if the entire PCE visit has been deleted
 ;  and if so, blank out the PCE Visit ien variable so that a new one
 ;  can be allocated.
 K ^TMP("PXKENC",$J)
 D ENCEVENT^PXAPI(ACKPCE)
 I '$D(^TMP("PXKENC",$J,ACKPCE)) D
 . K ACKARR S ACKARR(509850.6,ACKVIEN_",",125)="@"
 . D FILE^DIE("","ACKARR","")
 . S ACKPCE=""
 K ^TMP("PXKENC",$J)
 ;
 ; return
 Q
 ;
 ;
BUILD ; now build array for passing data to PCE
 K ^TMP("ACKQPCE1",$J,"PXAPI")
 S ACKAPI=$NA(^TMP("ACKQPCE1",$J,"PXAPI"))
 ;
 ; ----------encounter date/time----------------
 S @ACKAPI@("ENCOUNTER",1,"ENC D/T")=(ACKVDT\1+ACKVTM)
 ; --------------patient-----------------------
 S @ACKAPI@("ENCOUNTER",1,"PATIENT")=ACKPAT
 ; ---------------clinic-----------------------
 S @ACKAPI@("ENCOUNTER",1,"HOS LOC")=ACKCLN
 ; ------------service connected---------------
 S ACKSC=@ACKFDA2@(20,"I")
 S @ACKAPI@("ENCOUNTER",1,"SC")=ACKSC
 ; -------------agent orange,MST etc---------------
 S ACKAO=@ACKFDA2@(25,"I")
 S @ACKAPI@("ENCOUNTER",1,"AO")=ACKAO
 S ACKIR=@ACKFDA2@(30,"I")
 S @ACKAPI@("ENCOUNTER",1,"IR")=ACKIR
 S ACKEC=@ACKFDA2@(35,"I")
 S @ACKAPI@("ENCOUNTER",1,"EC")=ACKEC
 S ACKMST=@ACKFDA2@(90,"I")
 S @ACKAPI@("ENCOUNTER",1,"MST")=ACKMST
 S ACKHNC=@ACKFDA2@(40,"I")
 S @ACKAPI@("ENCOUNTER",1,"HNC")=ACKHNC
 S ACKCV=@ACKFDA2@(45,"I")
 S @ACKAPI@("ENCOUNTER",1,"CV")=ACKCV
 ; -------------checkout date/time-------------
 D NOW^%DTC S ACKCHKDT=%
 S @ACKAPI@("ENCOUNTER",1,"CHECKOUT D/T")=ACKCHKDT
 ; -------------visit eligibility--------------
 S ACKELIG=@ACKFDA2@(80,"I")
 S @ACKAPI@("ENCOUNTER",1,"ELIGIBILITY")=ACKELIG
 ; --------------service category--------------
 S ACKVSC=@ACKFDA2@(4,"I")
 S ACKCAT=$S(ACKVSC="AT":"T",ACKVSC="ST":"T",1:"X")
 S @ACKAPI@("ENCOUNTER",1,"SERVICE CATEGORY")=ACKCAT
 ; ---------------encounter type---------------
 S @ACKAPI@("ENCOUNTER",1,"ENCOUNTER TYPE")="P"
 ;
 S ACKCT=0
 ; ------------secondary provider-------------
 S ACKK5=""
 F  S ACKK5=$O(^TMP("ACKQPCE1",$J,"FDA",509850.66,ACKK5)) Q:ACKK5=""  D
 . I $P(ACKK5,",",2)'=ACKVIEN Q
 . S ACKSCND=$G(^TMP("ACKQPCE1",$J,"FDA",509850.66,ACKK5,".01","I"))
 . I ACKSCND="" Q
 . S ACKSCND=$$CONVERT1^ACKQUTL4(ACKSCND)
 . S ACKCT=ACKCT+1,@ACKAPI@("PROVIDER",ACKCT,"NAME")=ACKSCND
 ; ------------primary provider----------------
 S ACKPRIM=@ACKFDA2@(6,"I")
 I ACKPRIM'="" D
 . S ACKPRIM=$$CONVERT1^ACKQUTL4(ACKPRIM)
 . S ACKCT=ACKCT+1,@ACKAPI@("PROVIDER",ACKCT,"NAME")=ACKPRIM
 . S @ACKAPI@("PROVIDER",ACKCT,"PRIMARY")=1
 ;
 ; ----------------diagnosis------------------
 N ACKPBLM,ACKPBLMP,ACKIFN,ACKPLQT
 S ACKCT=0,(ACKIEN,ACKDPRIM,ACKNARR,ACKPBLM,ACKPBLMP)=""
 F  S ACKIEN=$O(@ACKFDA@(509850.63,ACKIEN)) Q:ACKIEN=""  D
 . I $P(ACKIEN,",",2)'=ACKVIEN Q
 . S ACKICD9=@ACKFDA@(509850.63,ACKIEN,.01,"I")
 . S ACKCT=ACKCT+1,@ACKAPI@("DX/PL",ACKCT,"DIAGNOSIS")=ACKICD9
 . S ACKNARR=$$LDIAGTXT^ACKQUTL8(ACKICD9,ACKVD)
 . I ACKNARR'="" S @ACKAPI@("DX/PL",ACKCT,"NARRATIVE")=ACKNARR
 . ; check for updating PCE problem list flag
 . S ACKPBLM=@ACKFDA@(509850.63,ACKIEN,.13,"I") I ACKPBLM D
 . . ; don't send if diagnosis provider blank
 . . S ACKPBLMP=@ACKFDA@(509850.63,ACKIEN,.14,"I") Q:'ACKPBLMP
 . . S ACKPLQT=$$PLIST^ACKQUTL6(ACKPAT,ACKICD9)
 . . ; send new problem if not on list
 . . I 'ACKPLQT S @ACKAPI@("DX/PL",ACKCT,"PL ADD")=1
 . . ; make existing problem active if currently inactive
 . . I +ACKPLQT=1 D
 . . . S @ACKAPI@("DX/PL",ACKCT,"PL IEN")=$P(ACKPLQT,U,2)
 . . . S @ACKAPI@("DX/PL",ACKCT,"PL ACTIVE")="A"
 . . ; send event date and encounter provider if updating list
 . . I +ACKPLQT'=2 D
 . . . S @ACKAPI@("DX/PL",ACKCT,"EVENT D/T")=ACKVD
 . . . S ACKPBLMP=$$CONVERT1^ACKQUTL4(ACKPBLMP)
 . . . S @ACKAPI@("DX/PL",ACKCT,"ENC PROVIDER")=ACKPBLMP
 . ; Check for primary diagnosis
 . I 'ACKDPRIM,@ACKFDA@(509850.63,ACKIEN,.12,"I")=1 D
 . . S @ACKAPI@("DX/PL",ACKCT,"PRIMARY")=1
 . . S ACKDPRIM=1
 ; First Diagnosis sent as Primary if No Primary defined on Visit file
 I 'ACKDPRIM,ACKCT>0 S @ACKAPI@("DX/PL",1,"PRIMARY")=1
 ;
 ; -----------------procedures----------------
 S ACKCT=0,ACKIEN="",ACKPROCP=""
 F  S ACKIEN=$O(@ACKFDA@(509850.61,ACKIEN)) Q:ACKIEN=""  D
 . I $P(ACKIEN,",",2)'=ACKVIEN Q
 . S ACKCPT=@ACKFDA@(509850.61,ACKIEN,.01,"I")    ; CPT IEN
 . S ACKVOL=@ACKFDA@(509850.61,ACKIEN,.03,"I")    ; Volume
 . S ACKPROCP=@ACKFDA@(509850.61,ACKIEN,.05,"I")  ; Provider
 . I ACKPROCP'="" S ACKPROCP=$$CONVERT1^ACKQUTL4(ACKPROCP)   ;  Convert from QSR to Vista
 . S ACKCT=ACKCT+1,@ACKAPI@("PROCEDURE",ACKCT,"PROCEDURE")=ACKCPT
 . S @ACKAPI@("PROCEDURE",ACKCT,"QTY")=$S(ACKVOL:ACKVOL,1:1)
 . I ACKPROCP'="" S @ACKAPI@("PROCEDURE",ACKCT,"ENC PROVIDER")=ACKPROCP
 . ; --------------procedure modifiers-------------
 . S ACKIEN2=""
 . F  S ACKIEN2=$O(@ACKFDA@(509850.64,ACKIEN2)) Q:ACKIEN2=""  D
 . . I $P(ACKIEN2,",",2,3)'=$P(ACKIEN,",",1,2) Q
 . . S ACKMOD=@ACKFDA@(509850.64,ACKIEN2,.01,"I")
 . . S ACKMOD=$$GET1^DIQ(509850.5,ACKMOD,.01,"E")
 . . I $D(@ACKAPI@("PROCEDURE",ACKCT,"MODIFIERS"))#10=0 D
 . . . S @ACKAPI@("PROCEDURE",ACKCT,"MODIFIERS")=""
 . . S @ACKAPI@("PROCEDURE",ACKCT,"MODIFIERS",ACKMOD)=""
 ;
 ; end of build
 Q
 ;
SENDIT ; send the data to PCE
 K ACKPROB
 ;
 ; call the PCE package API
 S ACKE=$$DATA2PCE^PXAPI($NA(^TMP("ACKQPCE1",$J,"PXAPI")),ACKPKG,ACKSRC,.ACKPCE,"",0,.ACKE2,"",.ACKPROB)
 ;
 ; check for returned error messages
 K ACKRSN S ACKRSN=0
 I $D(ACKPROB) D CONVERT^ACKQPCE2(.ACKPROB,ACKAPI,.ACKRSN)
 ;
 ; if update failed but no errors were returned then create a message
 I ACKE'=1,'ACKRSN D
 . S ACKMSG="Unable to update PCE Visit (error code="_ACKE_")"
 . D ADDRSN^ACKQPCE2("PCE VISIT","","",ACKMSG,.ACKRSN)
 . I ACKPCE'>0 D    ; pce ien has been corrupted by the API
 . . K ACKARR S ACKARR(509850.6,ACKVIEN_",",125)="@"
 . . D FILE^DIE("","ACKARR","")
 ;
 ; if errors found then file them on the Visit file and create exception
 I ACKE'=1,ACKRSN D
 . D FILERSN^ACKQPCE(ACKVIEN,.ACKRSN)
 . K ACKARR
 . S ACKARR(509850.6,ACKVIEN_",",125)=ACKPCE  ; for new visits!
 . D FILE^DIE("","ACKARR","")
 ;
 ; if no errors update the PCE fields
 I ACKE=1 D
 . K ACKARR
 . S ACKARR(509850.6,ACKVIEN_",",125)=ACKPCE  ; for new visits!
 . S ACKARR(509850.6,ACKVIEN_",",135)=ACKDATE ; date last sent
 . D FILE^DIE("","ACKARR","")
 . S ACKSENT=1   ; return flag (1=sent,0=not sent)
 ;
 ; end of sendit
 Q
 ;
