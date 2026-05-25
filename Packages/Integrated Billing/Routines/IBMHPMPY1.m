IBMHPMPY1 ;EDE/WCJ-Multi-site maintain IB MH VISIT TRACKING FILE (#351.83) - (aka PushMi-PullYu); 22-OCT-23
 ;;2.0;INTEGRATED BILLING;**779**;21-MAR-94;Build 7
 ;;Per VA Directive 6402, this routine should not be modified.
 ;; DBIA#1621 %ZTER (ERROR RECORDING)
 ;; DBIA#2729 MESSAGE ACTION API
 ;; DBIA#4678 VAFCTFU GET TREATING LIST
 ;; DBIA#3144 DIRECT RPC CALLS
 ;; DBIA#3149 XWBDRPC
 ; 
 G AWAY
 ;
AWAY Q  ;thought I was being figurative??? Haha, Guess again!
 ;
 ; This routine is for maintaining file entries in the IB MH VISIT TRACKING (#351.83) file across all treating facilites that a veteran has been seen at.
 ; So, while the file will not be the same at each facility, entries for a single veteran should match at each of his/her treating facilities.  
 ;
 ; Every time a record is added/updated in this file by a user, the UPDATED (#1.01) field is set.
 ; Nightly, this process will look for all the records in the file that have been updated.
 ; For each record that has been updated, this process will look for all the facilities a veteran has been treated at and execute a stored procedure (RPC) at each of those facilities
 ; to update their file.  If successful at all of the veteran's treating facilities, the UPDATED field will be removed.
 ; If not successful, the record will remain flagged to indicate that it needs to be tried again at a later time. 
 ;
 ; There are multiple calling entry points
 ; UPDATED - pretty much the process described above.
 ; DFN - synch the entries for one veteran across her/his treating facilities.  This one is used when a veteran gets treated at a new facility and the new facility need to get
 ;       caught up
 ; PULLTHEM - This is used when a veteran is seen at a new treatiing facility.  It reaches out to each of the treating facilities and requests that all the veterans file entries that
 ;       were created at a facility to be sent to the new one.
 ;
 ;  High level process flow
 ; 1) get all the records that you want to update (either by UPDATED flag or DFN)
 ; 2) loop through those and for each, get the veteran and his/her treating facilities
 ; 3) loop through treating facilities and executing remote RPC passing in the information about the specific entry
 ; 4) wait a reasonable amount on time for results from the remote treating facilities
 ; 5) remove from index if successful
 ; 6) rinse, repeat
 ;
UPDATED ; Get all in File that were UPDATED and not yet pushed out. They may have gotten to some sites but not all sites
 ; 
 D MULTI("AC",1)   ; "AC" index for updated (1's) records
 ; Need IB 761 released as a proof of concept before this is uncommented
 ;D EXTEMAIL ; Send email to mail group notifying of any exceptions
 Q
 ;
 ; This was set up to pass in 1 regular index and an internal lookup value which it does an exact match on.
 ; This leads to the most efficient database call acording to the FileMan manual (didn't actually run performance tests)
 ; Any changes to this behavior would need to be tested/verified and potentially recoded.
MULTI(IBINDEX,IBLOOKUP) ;
 ; IBINDEX = a single regular fileman index
 ; IBLOOKUP = internal value for that index
 ;
 K ^TMP("IBMHPMPY",$J)  ; start fresh
 ;
 ;D FIND^DIC(file[,iens][,fields][,flags],[.]value[,number][,[.]indexes][,[.]screen][,identifier][,target_root][,msg_root])  ; this line is just for reference
 ; get all the requested entries
 D FIND^DIC(351.83,"",".01;.02:99;.03I;.04I;.05;.06I;.07I;1.01I","QEP",IBLOOKUP,"",IBINDEX)
 ;
 ; this is what the file looks like so you know what is being grabbed above.
 ;^IBMH(351.83,D0,0)= (#.01) PATIENT [1P:2] ^ (#.02) SITE [2P:4] ^ (#.03) VISIT DATE [3D] ^ (#.04) STATUS [4S] ^ (#.05) BILL NUMBER 
 ;                ==>[5P:350] ^ (#.06) COMMENT [6S] ^ (#.07) UNIQUE ID 
 ;
 I '+$G(^TMP("DILIST",$J,0)) Q  ; nothing to see here folks - the FIND returned no results (maybe a slow day).
 ;
 ; and this is what the results look like - returned in the TMP global - I am a visual person so bear with me
 ;^TMP("DILIST",1720,0)="50^*^0^"
 ;^TMP("DILIST",1720,0,"MAP")="IEN^.01I^.01^C2^.03I^.04I^.05^.06I^.07I^1.01I"
 ;^TMP("DILIST",1720,1,0)="1^1234567^PATIENT,TEST A^999^3190801^2^999-K909Z09^^^1"
 ; have at them
 N IBLOOP,IBDATA,IBIEN,IBDFN,IBSITE,IBFAC,IBVISDT,IBSTAT,IBBILL,IBCOMM,IBUNIQ,IBEXSITE,IBTFL,IBT,IBICN,IBH,IBX,IBR,IBERR,IBHERE,IBC,IBZ,IBOSITEEX,IBPATPR,IBELGRP
 ;
 S IBPATPR=IBINDEX="B"  ; Set IBPAT flag since behaviour will be even differenter than the others and we may need to check the flag often
 ;
 D SITE^IBAUTL   ; returns IBSITE (external#) and IBFAC (internal#) based on IB SITE PARAMETERS for this site
 ;
 S (IBERR,IBLOOP)=0
 F IBLOOP=1:1:+$G(^TMP("DILIST",$J,0)) D
 . S IBDATA=$G(^TMP("DILIST",$J,IBLOOP,0))   ; data is packed in format described above
 . Q:IBDATA=""
 . S IBIEN=$P(IBDATA,U)
 . S IBDFN=$P(IBDATA,U,2)
 . ;
 . S IBOSITEEX=$P(IBDATA,U,4)  ; IEN file 4 (originating site external)
 . I IBOSITEEX'=IBSITE D REMOVE(IBIEN) Q  ; if treatment is not for the current site, don't push out - it was pushed here.  Only originating sites should push.
 . ;
 . K IBTFL
 . S IBT=$$TFL(IBDFN,IBOSITEEX,.IBTFL)
 . I 'IBT D REMOVE(IBIEN) Q   ; not seen at other treating facilites so no where to send - done with entry
 . ; 
 . S IBICN=$$ICN^IBARXMU(IBDFN)
 . I 'IBICN D LOGRES(IBDFN,.IBERR,"Failed local ICN lookup.") Q  ; no ICN - leave in the index and try again tomorrow since people eventually get ICNs according the MPI documentation
 . ;
 . S IBVISDT=$P(IBDATA,U,5)
 . S IBSTAT=$P(IBDATA,U,6)
 . S IBBILL=$P(IBDATA,U,7)
 . S IBCOMM=$P(IBDATA,U,8)
 . S IBUNIQ=$P(IBDATA,U,9)
 . S:IBUNIQ="" IBUNIQ=IBSITE_"_"_IBIEN  ; The UNIQUE ID = SITE_IEN
 . ;
 . ; send off calls to other treating facilities that this veteran has been seen at
 . ; the calls fire off the RPC (stored procedure) at each site
 . ; DBIA#3144 DIRECT RPC CALLS
 . ; DBIA#3149 XWBDRPC
 . S IBX=0 F  S IBX=$O(IBTFL(IBX)) Q:IBX<1  D
 .. N IBH
 .. D:'IBPATPR EN1^XWB2HL7(.IBH,+IBTFL(IBX),"IBMH COPAY SYNCH","",IBICN,IBOSITEEX,IBVISDT,IBSTAT,IBBILL,IBCOMM,IBUNIQ) ; push one record
 .. D:IBPATPR EN1^XWB2HL7(.IBH,+IBTFL(IBX),"IBMH COPAY SYNCH","",IBICN,IBOSITEEX)  ; push a request for all records for a patient (used when playing catch up - possibly adding a treating facility)
 .. ; check for handle
 .. I $G(IBH(0))="" D  Q
 ... S IBTFL(IBX,"ERR")="No handle returned from RPC"
 ... D LOGRES(,.IBERR,"No handle returned from call to site "_+IBTFL(IBX)_".") Q
 .. S $P(IBTFL(IBX),"^",3)=IBH(0) ; save handle for later.
 . ;
 . ; now lets look for the remote data
 . N IBREMOVE
 . S IBREMOVE=1  ; default this to remove from index
 . S IBX=0 F  S IBX=$O(IBTFL(IBX)) Q:IBX<1  D
 .. I $D(IBTFL(IBX,"ERR")) S IBREMOVE=0 Q
 .. ;
 .. ; try up to 10 times for 2 seconds each (at each site)
 .. N IBR
 .. F IBC=1:1:10 D RPCCHK^XWB2HL7(.IBR,$P(IBTFL(IBX),U,3)) Q:$G(IBR(0))["Done"  H 2
 .. ;
 .. ; If not done at one (or more) facility set a flag so it does not get removed from the index 
 .. I $G(IBR(0))'["Done" D LOGRES(IBDFN,.IBERR,"No reply from site "_+IBTFL(IBX)_".") S IBREMOVE=0
 .. ; if done get data.
 .. I $G(IBR(0))["Done" D
 ... K IBR,IBHERE
 ... D RTNDATA^XWBDRPC(.IBHERE,$P(IBTFL(IBX),"^",3))
 ... I $D(IBHERE)>10 D   ; not sure if was success or failure so save for now
 .... S IBERR=IBERR+1
 .... M ^TMP("IBMHPMPY",$J,IBDFN,IBERR,+IBTFL(IBX))=IBHERE
 .... ;WCJ;IB761; If the site that was just successful had previously logged a user correctable error then remove the error
 .... I $P(IBTFL(IBX),U)=$$GET1^DIQ(351.83,IBIEN_",","3.03:99"),+$G(IBHERE(0))'<0 D CLEARERR(IBIEN)   ;WCJ;IB761
 .... I +$G(IBHERE(0))<0 D CHKERR ;IB*2.0*761
 .... I +$G(IBHERE(0))<0 S IBREMOVE=0   ; it failed to leave it
 ... E  D
 .... S IBERR=IBERR+1
 .... M ^TMP("IBMHPMPY",$J,IBDFN,IBERR,+IBTFL(IBX))=^TMP($J,"XWB")
 .... K ^TMP($J,"XWB")
 .... S IBREMOVE=0   ; if any failed then leave it in to retry
 ... D CLEAR^XWBDRPC(.IBZ,$P(IBTFL(IBX),"^",3))
 .. E  D LOGRES(IBDFN,.IBERR,"Unable to get remote information from this site.") S IBREMOVE=0  ; IBR(0) did not contain 'Done'
 . I IBREMOVE D REMOVE(IBIEN) Q
 . Q
 ;
 ; It was nice that we flagged the errors and stored in a TMP global but we should probably alert somebody
 D ALERTSO
 ;
 ; clean up
 K ^TMP("IBMHPMPY",$J)
 Q
 ;
LOGRES(IBDFN,ERR,RESMESS) ; log results
 S ERR=ERR+1
 I $G(IBDFN)="" N IBDFN S IBDFN=0   ; if no DFN then it's a generic type error not really specific to a patient
 S ^TMP("IBMHPMPY",$J,IBDFN,ERR)=RESMESS
 Q
 ;
 ; I stole (and modified) from another routine because I wanted to parameterize site.
 ; they were using $$VASITE while we are using SITE^IBAUTL which grabs from different places. 
TFL(DFN,IBS,IBT) ; returns treating facility list (pass IBT by reference)
 ; supported references ia #2990, value returned is count
 ; needed to N Y because VAFCTFU1 will kill it
 ; DFN - Patient IEN
 ; IBS - External site
 ; IBT - By reference for results
 ;
 N IBC,IBZ,IBFT,Y
 D TFL^VAFCTFU1(.IBZ,DFN)
 Q:+$G(IBZ(1))=1 0
 S (IBZ,IBC)=0
 ; Return only remote facilities of certain types:
 S IBFT="^VAMC^M&ROC^RO-OC^"
 ; skip CERNER for now 200CRNR
 F  S IBZ=$O(IBZ(IBZ)) Q:IBZ<1  I +IBZ(IBZ)>0,+IBZ(IBZ)'=IBS,IBFT[("^"_$P(IBZ(IBZ),U,5)_"^"),$P(IBZ(IBZ),U,1)'="200CRNR" S IBT(+IBZ(IBZ))=IBZ(IBZ),IBC=IBC+1
 Q IBC
 ;
ALERTSO ; alert someone
 ; what is needed to actually be informative - maybe PATIENT NAME, FULL ICN (if available), RECEIVING SITE, ERROR MESSAGE
 ; screen out all but errors (get rid of 0's (info only) and 1's (successes))
 ;
 Q:'$D(^TMP("IBMHPMPY",$J))
 N SUBJ,MSG,XMTO,LN,IBDFN,IBRES,IBDATA,IBFAC,IBLN,IBL4,IBAD,IBLP
 S SUBJ="IBMH COPAY exceptions"
 S LN=0,IBDFN=""
 F  S IBDFN=$O(^TMP("IBMHPMPY",$J,IBDFN)) Q:+IBDFN'=IBDFN  D
 . S IBAD=0
 . S IBRES=0 F  S IBRES=$O(^TMP("IBMHPMPY",$J,IBDFN,IBRES))  Q:'IBRES  D
 .. I IBDFN D   ; only for patient errors and not generic ones
 ... S IBLN=$P($$GET1^DIQ(2,IBDFN,.01),",",1)   ; last name
 ... S IBL4=$$GET1^DIQ(2,IBDFN,.09),IBL4=$E(IBL4,$L(IBL4)-3,9999)  ; last 4
 .. S IBDATA=$G(^TMP("IBMHPMPY",$J,IBDFN,IBRES))
 .. I IBDATA]"" D
 ... I $D(^TMP("IBMHPMPY",$J,"INDX",IBDFN,IBDATA)) S ^TMP("IBMHPMPY",$J,"INDX",IBDFN,IBDATA)=^TMP("IBMHPMPY",$J,"INDX",IBDFN,IBDATA)+1 Q
 ... I IBDFN=0,'IBAD S LN=LN+1,MSG(LN)="Generic Errors (not patient specific):",IBAD=1
 ... I IBDFN,'IBAD S LN=LN+1,MSG(LN)=IBLN_" "_IBL4,IBAD=1
 ... S LN=LN+1,MSG(LN)=IBDATA
 ... S ^TMP("IBMHPMPY",$J,"INDX",IBDFN,IBDATA)=1
 .. S IBFAC=0 F  S IBFAC=$O(^TMP("IBMHPMPY",$J,IBDFN,IBRES,IBFAC))  Q:'IBFAC  D
 ... S IBLP="" F  S IBLP=$O(^TMP("IBMHPMPY",$J,IBDFN,IBRES,IBFAC,IBLP)) Q:IBLP=""  D
 .... S IBDATA=$G(^TMP("IBMHPMPY",$J,IBDFN,IBRES,IBFAC,IBLP))
 .... I +IBDATA<0 D
 ..... I $D(^TMP("IBMHPMPY",$J,"INDX",IBDFN,IBFAC,IBDATA)) S ^TMP("IBMHPMPY",$J,"INDX",IBDFN,IBFAC,IBDATA)=^TMP("IBMHPMPY",$J,"INDX",IBDFN,IBFAC,IBDATA)+1 Q
 ..... I IBDFN,'IBAD S LN=LN+1,MSG(LN)=IBLN_" "_IBL4,IBAD=1
 ..... S LN=LN+1,MSG(LN)=$P(IBDATA,U,2,999)
 ..... S ^TMP("IBMHPMPY",$J,"INDX",IBDFN,IBFAC,IBDATA)=1
 . I $D(MSG)>1 S LN=LN+1,MSG(LN)=" "
 Q:'LN
 S XMTO("G.IBMH EXCEPTIONS")=""
 D SENDMSG^XMXAPI(DUZ,SUBJ,"MSG",.XMTO)
 D CLEAN^DILF
 Q
 ;
REMOVE(IBIEN) ; remove from UPDATED index - only called if sent to ALL other treating facilities successfully.
 N FDA,IENS,RETURN
 S IENS=IBIEN_","
 S FDA(351.83,IENS,1.01)=0
 D FILE^DIE("","FDA","RETURN")
 D CLEARERR(IBIEN)  ;WCJ;IB761;just in case
 Q
 ;
 ;WCJ;IB761; Added CLEARERR tag
CLEARERR(IBIEN) ; remove from UPDATED index - only called if sent to ALL other treating facilities successfully.
 N FDA,IENS,RETURN
 S IENS=IBIEN_","
 S FDA(351.83,IENS,3.01)="@"
 S FDA(351.83,IENS,3.02)="@"
 S FDA(351.83,IENS,3.03)="@"
 D FILE^DIE("","FDA","RETURN")
 Q
 ;
CHKERR ; Check error code and set file 351.83 fields 3.01, 3.02.&3.03 IB*2.0*761
 N IBERR,IBERRCD
 S IBERR="" F  S IBERR=$O(IBHERE(IBERR)) Q:IBERR=""  D
 . S IBERRCD=+$G(IBHERE(IBERR))
 . I IBERRCD'<0 Q
 . ;SET FIELDS 3.01,3.02,3.03 IN File #351.83
 . S DIE=351.83 S DA=IBIEN
 . S DR="3.01///1;3.03///"_$P(IBTFL(IBX),U)_";"
 . I IBERRCD=-2 S DR=DR_"3.02///E" ;Exception Reason
 . I IBERRCD=-3 S DR=DR_"3.02///N" ;Exception Reason
 . I IBERRCD'=-2&(IBERRCD'=-3) K DIE,DR,DA Q  ;Don't set field if error code is not -2 or -3
 . D ^DIE
 Q
EXTEMAIL ; IB*2.0*761
 N IBMHIEN,CNT,LINE,XMDUZ,XMTEXT,XMY,XMSUB
 S (IBMHIEN,CNT)=0
 K ^TMP($J,"IBMHEXCP")
 F  S IBMHIEN=$O(^IBMH(351.83,"AT",1,IBMHIEN)) Q:IBMHIEN=""  S CNT=CNT+1
 I CNT=0 Q
 S XMSUB="MENTAL HEALTH VISIT EXEPTIONS PRESENT"
 S ^TMP($J,"IBMHEXCP",1)="Exceptions occurred during the transmission of Mental Health visit data to other VAMCs. Please review the VistA Mental Health Copay Transmission Exception Report and/or your VistA MailMan bulletin for further details."
 S XMTEXT="^TMP($J,""IBMHEXCP"","
 S XMDUZ=.5
 S XMY("G.IB MH REMOTE")=""
 D ^XMD
 Q
 ;
