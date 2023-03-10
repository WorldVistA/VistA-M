DGOTHBT2 ;SLC/SS,JC - OTH AND PP APIs ; 09/22/2020
 ;;5.3;Registration;**1029,1035,1047**;Aug 13, 1993;Build 13
 ;
 ;ICRs:
 ;$$INSUR^IBBAPI - DBIA4419 
 ;
 ;/** Returns Category I PRF information
 ;Input:
 ; DGDFN - IEN in the file (#2)
 ;Output:
 ; Piece #1: 
 ;       "Y" patient has at least one Category I PRF flag
 ;       "N" patient does not have any Category I PRF flags
 ; Piece #2: 
 ;       "A" patient has at least one active PRF
 ;       "" patient does not have any active PRF flags
 ; Piece #3: 
 ;       "I" patient has at least one inactive PRF 
 ;       "" patient does not have any inactive PRF flags
 ;
 ; DGRET - subscript for ^TMP($J,DGRET,DFN)array to return data from $$GETALL^DGPFAA
 ;
 ;Example of the returned value:
 ; Y^A - if only one active  flag
 ; Y^^I - if only one inactive  flag
 ; Y^A^I - if have both active and inactive  flag
 ; N  - if there are no PRF flags 
 ;Example of the array:
 ;PRFARR("A","BEHAVIORAL")=123
 ;PRFARR("A","HIGH RISK FOR SUICIDE")=121
 ;PRFARR("I","MISSING PATIENT")=122
 ;*/
 ;
PRFINFO(DGDFN,DGRETGL) ;
 N DGIENS,DGIEN,DGARR,DGRETVL,DGIEN2,DGRET2,DGFLSARR,DGRET
 K DGRET
 S DGRETVL="N"
 K ^TMP($J,DGRETGL,DGDFN)
 ; get all assignment ien's for the patient for
 ;   - both active and inactive flags, the 3rd parameter = ""
 ;   - only Category I (national flag), the 4th parameter = 1
 ;Selected patient has no record flag assignments on file.
 I '$$GETALL^DGPFAA(DGDFN,.DGRET2,"",1) Q DGRETVL
 ;check what statuses we have at the moment for each flag and set the return value's pieces accordingly
 S DGIEN="" F  S DGIEN=$O(DGRET2(DGIEN)) Q:DGIEN=""  D
 . K DGARR
 . S DGIEN2=DGIEN_","
 . D GETS^DIQ(26.13,DGIEN2,".02;.03","IE","DGARR")
 . I $G(DGARR(26.13,DGIEN2,.03,"E"))="ACTIVE" S DGRET("A",$G(DGARR(26.13,DGIEN2,.02,"E")))=DGIEN,$P(DGRETVL,U,2)="A",$P(DGRETVL,U,1)="Y"
 . E  I $G(DGARR(26.13,DGIEN2,.03,"E"))="INACTIVE" S DGRET("I",$G(DGARR(26.13,DGIEN2,.02,"E")))=DGIEN,$P(DGRETVL,U,3)="I",$P(DGRETVL,U,1)="Y"
 ;merge the result with ^TMP
 M ^TMP($J,DGRETGL,DGDFN)=DGRET
 ;add all other related information about the flags, its history and patient data to the ^TMP
 D:$P(DGRETVL,U,3)="I" PRFAPI(DGDFN,DGRETGL,"I")
 D:$P(DGRETVL,U,2)="A" PRFAPI(DGDFN,DGRETGL,"A")
 Q DGRETVL
 ; 
PRFAPI(DGDFN,DGRETGL,DGACT) ;
 N DGARFLAG,DGIEN,DGPRFFL,DGARRHS
 S DGPRFFL="" F  S DGPRFFL=$O(^TMP($J,DGRETGL,DGDFN,DGACT,DGPRFFL)) Q:DGPRFFL=""  S DGIEN=+$G(^TMP($J,DGRETGL,DGDFN,DGACT,DGPRFFL)) I DGIEN>0 K DGARFLAG I $$GETASGN^DGPFAA(DGIEN,.DGARFLAG) D
 . M ^TMP($J,DGRETGL,DGDFN,DGACT,DGPRFFL,"D")=DGARFLAG
 . K DGARRHS D GETHIST(DGIEN,.DGARRHS)
 . M ^TMP($J,DGRETGL,DGDFN,DGACT,DGPRFFL,"H")=DGARRHS
 Q
 ;
 ;Get history
 ;Input:
 ; DGIEN13 - IEN of #26.14
 ; DGACT - "A" for active, "I" for inactive
 ; DGPRFFL - full name of the flag (MISSING PATIENT, BEHAVIORAL or HIGH RISK FOR SUICIDE)
 ; DGARRFL - array to return (merge with)
GETHIST(DGIEN13,DGARRFL) ;
 N DGIEN14,DGDTTM,DGIENS,DGARRH
 I '$$GETALLDT^DGPFAAH(DGIEN13,.DGIENS) Q
 S DGDTTM="" F  S DGDTTM=$O(DGIENS(DGDTTM)) Q:+DGDTTM=0  S DGIEN14=$G(DGIENS(DGDTTM)) I DGIEN14 D
 . K DGARRH
 . I $$GETHIST^DGPFAAH(DGIEN14,.DGARRH,1) M DGARRFL(DGDTTM)=DGARRH
 Q
 ;/**
 ;show inactive PRF only
 ; Inactive Flag (non-OTH, non-PP, but has inactive HRFS and/or MISSING PATIENT PRF(s)) -> "Inactive Flag"
 ; Note: "BEHAVIORAL" should not be displayed according requirements
 ;Input:
 ; DGDFN - IEN in the file (#2)
 ; PRFARR - returned by S PRFINF=$$PRFINFO^DGOTHBT2(DGDFN,.PRFARR)
 ; RET - local array to return information to send back to CPRS
 ;Output:
 ; RET - local array to return information to send back to CPRS
 ; 
 ;Example:DGPFAPIH
 ;
 ;*/
INPRFONL(DGDFN,PRFTMP,RET) ;
 N DGFLIEN1,DGFLIEN2,DGCNT,DGRECN,DGMXHRFS
 N NUMHRFS,NUMMISS
 S (NUMHRFS,NUMMISS)=0
 S RET(0)=0
 S DGFLIEN1=+$G(^TMP($J,PRFTMP,DGDFN,"I","HIGH RISK FOR SUICIDE"))
 S DGFLIEN2=+$G(^TMP($J,PRFTMP,DGDFN,"I","MISSING PATIENT"))
 I 'DGFLIEN1,'DGFLIEN2 Q
 I DGFLIEN1 S NUMHRFS=$$HISTLEN(PRFTMP,DGDFN,"I","HIGH RISK FOR SUICIDE")
 I DGFLIEN2 S NUMMISS=$$HISTLEN(PRFTMP,DGDFN,"I","MISSING PATIENT")
 D HISTRECS("N",.NUMHRFS,.NUMMISS) ;
 D ADDLINE(.RET,"Inactive Flag^Patient has Inactive Flag(s), click to view")
 D ADDLINE(.RET," ")
 I DGFLIEN1 D SETHRFS(.RET,PRFTMP,DGDFN,NUMHRFS)
 I DGFLIEN1 D ADDLINE(.RET," ")
 I DGFLIEN2 D SETMISP(.RET,PRFTMP,DGDFN,NUMMISS)
 Q
 ;
 ;/**
 ;set header and history for HRfS
 ;RET to set array for CPRS
 ;PRFTMP - subscript in the TMP global
 ;DGDFN - ien in the file #2
 ;DGHISNUM - number of history records to show
 ; - if patient has both HRfS and MISSING flags 
 ; then  HRfS will be shown first but we need to save a space for MISSING as well
 ; therefore we have to show fewer history entries for HRfS i.e. just 1 entry
 ; - if patient has only one HRfS flag then we show 2 entries
 ;*/
SETHRFS(RET,PRFTMP,DGDFN,DGHISNUM) ;
 D ADDLINE(.RET,"Flag name: HIGH RISK FOR SUICIDE   Status: INACTIVE")
 D ADDLINE(.RET,"  Initial Assigned Date: "_$$FLGASSDT(PRFTMP,DGDFN,"I","HIGH RISK FOR SUICIDE"))
 D ADDLINE(.RET,"  Originating Site: "_$$FORGSITE(PRFTMP,DGDFN,"I","HIGH RISK FOR SUICIDE"))
 D ADDLINE(.RET,"  Owner Site: "_$$FLOWNSITE(PRFTMP,DGDFN,"I","HIGH RISK FOR SUICIDE"))
 D ADDHIST(.RET,PRFTMP,DGDFN,"HIGH RISK FOR SUICIDE","I",DGHISNUM)
 Q
 ;
 ;/**
 ;return FLG ASSIG DATE
 ;parameters:
 ;DGPRFTMP
 ;DGDFN
 ;DGSTATUS
 ;DGFLGNAM
 ;returns
 ;*/
FLGASSDT(DGPRFTMP,DGDFN,DGSTATUS,DGFLGNAM) ;
 N DG2613,DGDTTM
 S DGDTTM=0
 S DG2613=$G(^TMP($J,DGPRFTMP,DGDFN,DGSTATUS,DGFLGNAM))
 I DG2613 S DGDTTM=+$$GETADT^DGPFAAH(DG2613)
 I DGDTTM>0 Q $$DATETM(DGDTTM)
 Q "UNKNOWN"
 ; 
 ;return FLG SITE
FORGSITE(DGPRFTMP,DGDFN,DGSTATUS,DGFLGNAM) ;
 Q $P($G(^TMP($J,DGPRFTMP,DGDFN,DGSTATUS,DGFLGNAM,"D","ORIGSITE")),U,2)
 ;
 ;return flag owner site
FLOWNSITE(DGPRFTMP,DGDFN,DGSTATUS,DGFLGNAM) ;
 Q $P($G(^TMP($J,DGPRFTMP,DGDFN,DGSTATUS,DGFLGNAM,"D","OWNER")),U,2)
 ;
 ;return ARR array with DGNUM of history entries 
 ;RET to set array for CPRS
 ;PRFTMP - subscript in the TMP global
 ;DGDFN - ien in the file #2
 ;DGHISNUM - number of history records to show
ADDHIST(RET,PRFTMP,DGDFN,DGFLAG,DGSTAT,DGNUM) ;
 N DGCNT,DGDTTM,DGACTION,DGSITE,DGMOREHI,DGZ,DGPRSITE,DGDTTIME
 S DGPRSITE=""
 S DGDTTM=99999999,DGCNT=0,DGMOREHI=0
 F  S DGDTTM=$O(^TMP($J,PRFTMP,DGDFN,DGSTAT,DGFLAG,"H",DGDTTM),-1) Q:+DGDTTM=0!(DGCNT'<DGNUM)  D
 . S DGACTION=$P($G(^TMP($J,PRFTMP,DGDFN,DGSTAT,DGFLAG,"H",DGDTTM,"ACTION")),U,2)
 . ;if not one of them then don't use (don't display)
 . S DGZ="^"_DGACTION_"^"
 . I "^INACTIVATE^REACTIVATE^CONTINUE^"'[DGZ Q
 . S DGSITE=$G(^TMP($J,PRFTMP,DGDFN,DGSTAT,DGFLAG,"H",DGDTTM,"ORIGFAC"))
 . S DGDTTIME=$G(^TMP($J,PRFTMP,DGDFN,DGSTAT,DGFLAG,"H",DGDTTM,"ASSIGNDT"))
 . I DGPRSITE'=$P(DGSITE,U,2) D ADDLINE(.RET,"  "_$P(DGSITE,U,2)_" changes:")
 . D ADDLINE(.RET,"    DATE/TIME: "_$P(DGDTTIME,U,2)_"    ACTION: "_DGACTION)
 . S DGPRSITE=$P(DGSITE,U,2)
 . S DGCNT=DGCNT+1
 ;are there are more items to show?
 I $$IFMORE(PRFTMP,DGDFN,DGSTAT,DGFLAG,DGDTTM)>0 D ADDLINE(.RET,"  *****additional info is in vista*****")
 Q
 ;
 ;check is we have more entries with INACTIVATE,REACTIVATE and CONTINUE to display
IFMORE(PRFTMP,DGDFN,DGSTAT,DGFLAG,DGDTTM) ;
 N DGZ,DGFND
 S DGDTTM=DGDTTM+.00000000001
 S DGFND=0
 F  S DGDTTM=$O(^TMP($J,PRFTMP,DGDFN,DGSTAT,DGFLAG,"H",DGDTTM),-1) Q:+DGDTTM=0!(DGFND>0)  D
 . S DGACTION=$P($G(^TMP($J,PRFTMP,DGDFN,DGSTAT,DGFLAG,"H",DGDTTM,"ACTION")),U,2)
 . ;if not one of them then don't use (don't display)
 . S DGZ="^"_DGACTION_"^"
 . I "^INACTIVATE^REACTIVATE^CONTINUE^"[DGZ S DGFND=1
 Q DGFND
 ;
 ;/**
 ;set header and history for MISSING PATIENT
 ;RET to set array for CPRS
 ;PRFTMP - subscript in the TMP global
 ;DGDFN - ien in the file #2
 ;*/
SETMISP(RET,PRFTMP,DGDFN,DGHISNUM) ;
 D ADDLINE(.RET,"Flag name: MISSING PATIENT                Status: INACTIVE")
 D ADDLINE(.RET,"  Initial Assigned Date: "_$$FLGASSDT(PRFTMP,DGDFN,"I","MISSING PATIENT"))
 D ADDLINE(.RET,"  Originating Site: "_$$FORGSITE(PRFTMP,DGDFN,"I","MISSING PATIENT"))
 D ADDLINE(.RET,"  Owner Site: "_$$FLOWNSITE(PRFTMP,DGDFN,"I","MISSING PATIENT"))
 D ADDHIST(.RET,PRFTMP,DGDFN,"MISSING PATIENT","I",DGHISNUM)
 Q
 ;
 ;/**
 ;show OTH + PRF
 ;Input:
 ; DGDFN - IEN in the file (#2)
 ; DGEXP - OTH data from $$GETEXPR^DGOTHD(DGDFN)
 ; PRFTMP - subscript to ^TMP($J,PRFTMP) with PRF data
 ; RET - to return an array with data
 ;Output:
 ; RET(0)=0  - nothing to display
 ;or
 ; RET(0)>0, RET - with data to display on the button
 ;
 ;*/
OTHINPRF(DGDFN,DGEXP,PRFTMP,RET) ;
 N DGOTHTYP
 S RET(0)=0
 ;determine the OTH type
 S DGOTHTYP=$$ISOTH^DGOTHD(DGEXP)
 ;if OTH-EXT
 ;Button label:
 ; OTH and Inactive Flag (OTH EXT and has inactive HRFS and/or MISSING PATIENT PRF(s)) "OTH/Inactive Flag"
 ; OTH-EXT and Inactive Flag: 
 ;Button Hover text 1st line: 'Other than Honorable, click for details'
 ;Button Hover text 2nd line: 'Patient has Inactive Flag(s), click to view'
 I DGOTHTYP=1 D  Q
 .S RET(0)=11
 .S RET(1)="OTH-EXT^Other than Honorable, click for details"
 .S RET(2)="Inactive Flag^Patient has Inactive Flag(s), click to view"
 .S RET(3)="Other than Honorable - Extended"
 .S RET(4)=" "
 .S RET(5)="Eligible for Mental Health care only unless Veteran has positive MST screen."
 .S RET(6)=" "
 .S RET(7)="If MST Screen is positive, Veteran is eligible for MST related mental health and medical care."
 .S RET(8)="Please review MST checkbox or complete MST screening."
 .S RET(9)=" "
 .S RET(10)="Not time limited - pending VBA adjudication."
 .S RET(11)="Adjudication will determine eligibility for continuing care."
 .D PRWTHOTH(DGDFN,"DGPRINFO",.RET)
 .Q
 ;
 ;if OTH-90
 ;Button label:
 ; OTH-90 and Inactive Flag (OTH-90 and has inactive HRFS and/or MISSING PATIENT PRF(s)) "OTH/Inactive Flag"
 ; OTH and Inactive Flag 
 ;1st line on button hover text: 'Other Than Honorable, click for details'
 ;2nd line on button hover text: 'Patient has Inactive Flag(s), click to view'
 I DGOTHTYP=2 D  Q
 .D OTH90^DGOTHBTN(DGDFN,.RET)
 .;overwrite label and hover text
 .S RET(1)="OTH-90^Other than Honorable, click for details"
 .S RET(2)="Inactive Flag^Patient has Inactive Flag(s), click to view"
 .D PRWTHOTH(DGDFN,"DGPRINFO",.RET)
 ;if nothing
 Q
 ;
 ;/**
 ;show inactive PRF with OTH
 ; Note: "BEHAVIORAL" should not be displayed according requirements
 ;Input:
 ; DGDFN - IEN in the file (#2)
 ; PRFARR - returned by S PRFINF=$$PRFINFO^DGOTHBT2(DGDFN,.PRFARR)
 ; RET - local array to return information to send back to CPRS
 ;Output:
 ; RET - local array to return information to send back to CPRS
 ; 
 ;Example:DGPFAPIH
 ;
 ;*/
PRWTHOTH(DGDFN,PRFTMP,RET) ;
 N DGFLIEN1,DGFLIEN2,DGCNT,DGRECN,DGMXHRFS
 N NUMHRFS,NUMMISS
 S (NUMHRFS,NUMMISS)=0
 S DGFLIEN1=+$G(^TMP($J,PRFTMP,DGDFN,"I","HIGH RISK FOR SUICIDE"))
 S DGFLIEN2=+$G(^TMP($J,PRFTMP,DGDFN,"I","MISSING PATIENT"))
 I DGFLIEN1 S NUMHRFS=$$HISTLEN(PRFTMP,DGDFN,"I","HIGH RISK FOR SUICIDE")
 I DGFLIEN2 S NUMMISS=$$HISTLEN(PRFTMP,DGDFN,"I","MISSING PATIENT")
 D HISTRECS("O",.NUMHRFS,.NUMMISS) ;
 D ADDLINE(.RET," ")
 I DGFLIEN1 D SETHRFS(.RET,PRFTMP,DGDFN,NUMHRFS)
 I DGFLIEN1 D ADDLINE(.RET," ")
 I DGFLIEN2 D SETMISP(.RET,PRFTMP,DGDFN,NUMMISS)
 Q
 ;
 ;/**
 ;show inactive PRF with PP
 ; Note: "BEHAVIORAL" should not be displayed according requirements
 ;Input:
 ; DGDFN - IEN in the file (#2)
 ; PRFARR - returned by S PRFINF=$$PRFINFO^DGOTHBT2(DGDFN,.PRFARR)
 ; RET - local array to return information to send back to CPRS
 ;Output:
 ; RET - local array to return information to send back to CPRS
 ; 
 ;Example:DGPFAPIH
 ;
 ;*/
PRWITHPP(DGDFN,PRFTMP,RET) ;
 N DGFLIEN1,DGFLIEN2,DGCNT,DGRECN,DGMXHRFS
 N NUMHRFS,NUMMISS
 S (NUMHRFS,NUMMISS)=0
 S RET(2)="Inactive Flag^Patient has Inactive Flag(s), click to view"
 S DGFLIEN1=+$G(^TMP($J,PRFTMP,DGDFN,"I","HIGH RISK FOR SUICIDE"))
 S DGFLIEN2=+$G(^TMP($J,PRFTMP,DGDFN,"I","MISSING PATIENT"))
 I DGFLIEN1 S NUMHRFS=$$HISTLEN(PRFTMP,DGDFN,"I","HIGH RISK FOR SUICIDE")
 I DGFLIEN2 S NUMMISS=$$HISTLEN(PRFTMP,DGDFN,"I","MISSING PATIENT")
 D HISTRECS("P",.NUMHRFS,.NUMMISS) ;
 D ADDLINE(.RET," ")
 I DGFLIEN1 D SETHRFS(.RET,PRFTMP,DGDFN,NUMHRFS)
 I DGFLIEN1 D ADDLINE(.RET," ")
 I DGFLIEN2 D SETMISP(.RET,PRFTMP,DGDFN,NUMMISS)
 Q
 ;
 ;/** Check if any mailman message was already sent today and send the MailMan message for this patient
 ;Input parameters:
 ; DGDFN = IEN of patient in file #2
 ;*/
SENDMAIL(DGDFN) ;
 N DGSENTON
 ;get the date when the message was sent last time (if we have a record for this)
 S DGSENTON=$$MMSENTON(DGDFN)
 ;if there is no any ^XTM record about last mailman  message then MailMan message can be sent now and create the ^XTMP global entry
 I DGSENTON=0 D COMPSEND(DGDFN) Q
 ;if the date MM was sent last time is the same as today then do not sent message
 I DGSENTON=DT Q
 ;if the date MM was sent last time on a different day then send the message and update the ^XTMP global entry
 D COMPSEND(DGDFN)
 Q
 ;
 ;/** Compose the message that notifies the Registration users added to the DGEN ELIGIBILITY ALERT group 
 ; and send it
 ; and update ^XTMP entry
 ;Input parameters:
 ; DGDFN = IEN of patient in file #2
 ;--------------------------------------------------------------
 ;*/
COMPSEND(DGDFN) ;
 N DGMSG
 ;send email
 D COMPMSG(DGDFN,.DGMSG)
 D SENDMSG(.DGMSG,"Presumptive Psychosis information needed")
 D SETXTMP(DGDFN)
 Q
 ;
 ;
 ;/** Compose the message that notifies the Registration users added to the  DGEN ELIGIBILITY ALERT group
 ;that PP workaround settings are not completed for the patient
 ;
 ;Input parameters:
 ; DGDFN = IEN of patient in file #2
 ;
 ;the mockup of the message sent to the DGEN ELIGIBILITY ALERT mail group: 
 ;--------------------------------------------------------------
 ;The following patient has PRESUMED PSYCHOSIS indicated,but all fields have not
 ;been completed to support this. All fields must be completed in order for this
 ;patient to be eligible for treatment under the Presumed Psychosis Program.  
 ;
 ;Required Fields: Screen 7, Field 3
 ;                 Screen 11, Field 4
 ;
 ;PATIENT NAME:    ZZTEST,PRESUMED PSYCHOSIS
 ;                 Last 4 SSN:   1234
 ;--------------------------------------------------------------
 ;*/
COMPMSG(DGDFN,DGMSG) ;
 N DGNAME,DGSSN,DGPAT,DGDFN1
 S DGDFN1=DGDFN_","
 D GETS^DIQ(2,DGDFN1,".01;.09","EI","DGPAT") I '$D(DGPAT) Q
 S DGSSN=DGPAT(2,DGDFN1,.09,"E")
 S DGNAME=DGPAT(2,DGDFN1,.01,"E")
 S DGMSG(1)="The following patient has PRESUMED PSYCHOSIS indicated,but all fields have not"
 S DGMSG(2)="been completed to support this. All fields must be completed in order for this"
 S DGMSG(3)="patient to be eligible for treatment under the Presumed Psychosis Program."
 S DGMSG(4)=" "
 S DGMSG(5)="Required Fields: Screen 7,  Field 3"
 S DGMSG(6)="                 Screen 11, Field 4"
 S DGMSG(7)="PATIENT NAME:    "_DGNAME
 S DGMSG(8)="                 Last 4 SSN:   "_$E(DGSSN,$L(DGSSN)-3,$L(DGSSN))
 Q
 ;
 ;/** Send MailMan message to DGEN ELIGIBILITY ALERT group
 ;Input parameters:
 ; DGMSG - array with the text
 ; DGSUBJ - mailman subject
 ;*/
SENDMSG(DGMSG,DGSUBJ) ;
 N XMDUZ,XMTEXT,XMY,XMSUB
 S XMSUB=DGSUBJ
 S XMDUZ="POSTMASTER",XMTEXT="DGMSG(",XMY("G.DGEN ELIGIBILITY ALERT@"_^XMB("NETNAME"))=""
 D ^XMD ; Returns: XMZ(if no error),XMMG(if error)
 Q
 ;
 ;/**
 ;mailman was sent last time on the date?
 ;Input parameters:
 ; DGDFN = IEN of patient in file #2
 ;output parameters:
 ; returns 
 ; 0 - there is no any ^XTM record about last mailman  message (which means message can be sent now)
 ; 1 - the date when the message was sent last time
 ;*/
MMSENTON(DGDFN) ;
 N DGVAL
 S DGVAL=$G(^XTMP("DGPPMSGFOR"_DGDFN,0))
 I +DGVAL=0 Q 0
 Q $P(DGVAL,U,2)
 ; 
 ;/** Set ^XTMP entry so we can check for it and prevent sending the mailman message more than once a day
 ;Input parameters:
 ; DGDFN = IEN of patient in file #2
 ;*/
SETXTMP(DGDFN) ;
 N DGPURGE,DGNODE
 S DGPURGE=$$FMADD^XLFDT(DT,1)
 S DGNODE="DGPPMSGFOR"_DGDFN
 S ^XTMP(DGNODE,0)=DGPURGE_U_DT_U_"DG PP MSG WAS SENT"
 Q
 ;
 ;/**add lines to the CPRS array RET
 ; RET - the local array by reference
 ; DGTEXT - text to add
 ;*/
ADDLINE(RET,DGTEXT) ;
 S RET(0)=$G(RET(0))+1
 S RET(RET(0))=DGTEXT
 Q 
 ;
 ;FM date to MON DD, YYYY@HH:MM
DATETM(Y) ;
 D DD^%DT W Y
 Q Y
 ;
 ;/*
 ;returns number of records in the PRF history 
 ;Note: will count only INACTIVATE,REACTIVATE,CONTINUE
 ;PRFTMP - subscript in the TMP global
 ;DGDFN - ien in the file #2
 ;DGSTAT - status ("A" or "I")
 ;DGFLAG - full flag name
 ;*/
HISTLEN(PRFTMP,DGDFN,DGSTAT,DGFLAG) ;
 N DGCNT,DGDTTM,DGZ,DGACTION
 S DGCNT=0,DGDTTM=""
 F  S DGDTTM=$O(^TMP($J,PRFTMP,DGDFN,DGSTAT,DGFLAG,"H",DGDTTM)) Q:+DGDTTM=0  D
 . S DGACTION=$P($G(^TMP($J,PRFTMP,DGDFN,DGSTAT,DGFLAG,"H",DGDTTM,"ACTION")),U,2)
 . ;if not one of the three below then don't count and don't use (don't display)
 . S DGZ="^"_DGACTION_"^"
 . I "^INACTIVATE^REACTIVATE^CONTINUE^"'[DGZ Q
 . S DGCNT=DGCNT+1
 Q DGCNT
 ;
 ;
 ;Calculate max number of history records to display for HRfS and MISSING if 
 ;  we have PP
 ;          OTH 
 ;  and when we don't have any of PP or OTH 
 ;
 ;this number depends on the number of history records for each HRFS and MISSING we found for the patient
 ;
 ;Note: HRFS always displayed first, then MISSING
 ;      MISSING should display at least one history record 
 ;
 ;Parameters:
 ; DGPPOTH - "P" if patient has PP
 ;           "O" if patient has OTH
 ;           "N" if patient does not have OTH and PP
 ; NUMHRFS - number of history records for HRfS , passed by reference so it will be adjusted accordingly
 ; NUMMISS - number of history records for MISSING  , passed by reference so it will be adjusted accordingly
 ;
HISTRECS(DGPPOTH,NUMHRFS,NUMMISS) ;
 N MXPRFONL
 S MXPRFONL=6 ;MAX number of records in total if not OTH and no PP, just PRF
 ;if not OTH and no PP
 I DGPPOTH="P" S MXPRFONL=5 ;to allow the space for PP info
 I DGPPOTH="O" S MXPRFONL=5 ;to allow the space for OTH info
 ;if we have only MISSING then set to MAX and it will display all entries less than MAX or upto MAX in ADDHIST function
 I NUMHRFS=0 S NUMMISS=MXPRFONL Q
 ;if we have only HRfS then set to MAX and it will display all entries less than MAX or upto MAX in ADDHIST function
 I NUMMISS=0 S NUMHRFS=MXPRFONL Q
 ;now if we have both HRfS and MISSING ...
 ;
 ;if total number of records is less than MAX ( "less then < MXPRFONL" because generic info for the MISSING will take some space too)
 ;and leave all as is - ADDHIST function will display all entries for each 
 ;example:  NUMHRFS=4,NUMMISS=1 or NUMHRFS=1,NUMMISS=4 or NUMHRFS=3,NUMMISS=2
 I (NUMHRFS+NUMMISS)<MXPRFONL Q
 ;if total number of HRFS history entries no less than MXPRFONL-1 (because generic info for the MISSING will take some space too)
 ;example:  NUMHRFS=5,NUMMISS=1 or NUMHRFS=7,NUMMISS=8
 I NUMHRFS'<(MXPRFONL-1) S NUMHRFS=MXPRFONL-2,NUMMISS=1
 ;if total number of HRFS history entries less than MXPRFONL-1 (because generic info for the MISSING will take some space too)
 ;example:  NUMHRFS=4,NUMMISS=1 or NUMHRFS=3,NUMMISS=8
 I NUMHRFS<(MXPRFONL-1) S NUMMISS=MXPRFONL-NUMHRFS-1
 Q
 ;
 ;return 1 if the patient has a least one inactive flag that qualifies for showing in OTH/PP/Inact PRG button
 ;return 0 if not
 ;Input:
 ; PRFTMP - the node for PRFs used by $$PRFINFO^DGOTHBT2
 ; DGDFN - patient's DFN 
QUALINACT(PRFTMP,DGDFN) ;
 I +$G(^TMP($J,PRFTMP,DGDFN,"I","HIGH RISK FOR SUICIDE")) Q 1
 I +$G(^TMP($J,PRFTMP,DGDFN,"I","MISSING PATIENT")) Q 1
 Q 0
