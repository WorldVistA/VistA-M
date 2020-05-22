IBECEA38 ;EDE/WCJ-Multi-site maintain UC VISIT TRACKING FILE (#351.82) - RPC RETURN ; 2-DEC-19
 ;;2.0;INTEGRATED BILLING;**663,671**;21-MAR-94;Build 13
 ;;Per VA Directive 6402, this routine should not be modified.
 ;; DBIA#1621 %ZTER (ERROR RECORDING)
 G AWAY
 ;
AWAY Q  ;thought I was being figurative??? Guess again!
 ;
 ; RPC endpoint
 ; this is where the RPC is actually called at the remote facility.
RETURN(IBR,IBICN,IBOSITEEX,IBVISDT,IBSTAT,IBBILL,IBCOMM,IBUNIQ,IBELGRP) ;
 ;
 ; INPUT:
 ;        IBR - Results go here
 ;        IBICN - Patients ICN so that we can find the patient across sites
 ;        IBOSITEEX - external site number
 ;        IBVISDT - Visit date
 ;        IBSTAT - Status
 ;        IBBILL - Bill number or possibly free text description such as 'ONHOLD'
 ;        IBCOMM - Cancel reason
 ;        IBUPDATE - 1 if this is the originating site and data should be pushed out to other treating facilities, otherwise 0
 ;        IBUNIQ - Unique ID consiting of external site number underscor ien of file 351.82 on originating site ex. 442_1234567
 ;        IBELGRP - Eligibity Group coming in - must match receiving system
 ; OUTPUT:
 ;        results are returned in the results array as described in INPUT section
 ;        "-1^Error message"
 ;        "0^No action taken (nor needed) message"
 ;        "1^Success message"    
 ;
 ; 1) check if the entry is already there based on the unique ID (external originating site and their IEN from file 351.82) passed in.
 ; 2) if it's already there, see if anything changed (might be an update).
 ;   a) if already there and no changes, don't do anything with it but also don't return an error message.  Any cheerful, uplifting response would do and then gracefully exit.
 ;   b) if already there but allowable fields being updated, then do so, let them know, and quitely ride off into the sunset.
 ; 3) If you got this far, add it to the file.
 ; 4) return something to let them know how you did
 ;
 I '$D(IBR) S IBR=$NA(^TMP("IBECEA37",$J)) ; didn't think I would need, but...
 ;
 N IBDFN,IBSCREEN,IBIEN4,IBDATA,IBIEN351P82,IBADDED,IBUPDATED,IBRETURN,IBMISS,IBFAC,IBSITE
 D SITE^IBAUTL  ; returns IBSITE (external) and IBFAC (internal)
 ;
 ; see if it's a pull for specific patient.  It will only have the patient's ICN and the site it's pulling to
 I '$D(IBVISDT),'$D(IBSTAT),'$D(IBBILL),'$D(IBCOMM),'$D(IBUNIQ),$G(IBICN),$G(IBOSITEEX) D  Q
 . D PULL(.IBR,IBFAC,IBSITE,IBICN,IBOSITEEX)
 . Q
 ;
 ; Make sure everything needed is here. Better doublecheck on what is needed.
 S IBMISS=$S('$D(IBICN):1,'$D(IBOSITEEX):2,'$D(IBVISDT):3,'$D(IBSTAT):4,'$D(IBBILL):5,'$D(IBCOMM):6,'$D(IBUNIQ):7,'$D(IBELGRP):8,1:0)
 I IBMISS S @IBR@(1)="-1^Missing required input parameter: "_$P("IBICN.IBOSITEEX.IBVISDT.IBSTAT.IBBILL.IBCOMM.IBUNIQ.IBELGRP",".",IBMISS) Q
 ;
 I IBOSITEEX=IBSITE S @IBR@(1)="0^No action performed.  Current site# "_IBSITE_" equals originating site# "_IBOSITEEX Q
 ;
 S IBIEN4=$$FIND1^DIC(4,,"X",IBOSITEEX,"D")   ; get the internal site number (File 4 IEN) - should be the same across sites but then again shouldn't have to.
 I 'IBIEN4 S @IBR@(1)="-1^Site# "_IBOSITEEX_" not found in INSTITUTION (#4) file lookup" Q
 ;
 ; make sure the patient is identifiable from this ICN
 ; if not, not much I can do
 S IBDFN=+$$DFN^IBARXMU($G(IBICN))
 I 'IBDFN S @IBR@(1)="-1^Patient ICN: "_IBICN_" not found at site# "_IBSITE Q
 ;
 I $$GETELGP^IBECEA36(IBDFN,IBVISDT)'=IBELGRP D  Q
 . N Y S Y=IBVISDT X ^DD("DD")
 . S @IBR@(1)="-1^Patient's eligibility group differs between sites for date of service "_Y_"."
 . S @IBR@(2)="-1^Site# "_IBSITE_" = "_$$GETELGP^IBECEA36(IBDFN,IBVISDT)
 . S @IBR@(3)="-1^Site# "_IBOSITEEX_" = "_IBELGRP
 . Q
 ;
 ;D FIND^DIC(file[,iens][,fields][,flags],[.]value[,number][,[.]indexes][,[.]screen][,identifier][,target_root][,msg_root])  ; this line is just for reference
 ;
 ; this sets the screen for the FIND call.
 ; FIND is by IBUNIQ (the unique ID consisting of the external site # and the the IEN to file 351.82 at that site.
 ; It if finds one, it's a potential edit and we will deal with that.
 ; If it finds more than one, not much I can do except throw my hands in the air.  Since adding the unique ID, that really shouldn't happen.
 ; 
 D FIND^DIC(351.82,"",".01;.02:99;.03I;.04I;.05;.06I;.07I;1.01I","QEPX",IBUNIQ,"","AUID")
 ;
 ; found one - see if anything changed and update if needed
 ; now what can really change - IBSTAT, IBBILL, IBCOMM are only fields allowed to change 
 I +$G(^TMP("DILIST",$J,0))=1 D  Q
 . S IBDATA=$G(^TMP("DILIST",$J,1,0))
 . S IBIEN351P82=+IBDATA
 . I $P(IBDATA,U,6)=IBSTAT,$P(IBDATA,U,7)=IBBILL,$P(IBDATA,U,8)=IBCOMM S @IBR@(1)="0^No changes requested" Q
 . S IBUPDATED=$$UPDATE(IBIEN351P82,IBSTAT,IBBILL,IBCOMM,1,.IBRETURN)
 . I 'IBUPDATED D  Q
 .. S @IBR@(1)="-1^Unable to UPDATE record at site# "_IBSITE_"."
 ..; S:IBRETURN["MAX free" @IBR@(1)=@IBR@(1)_" "_IBRETURN
 .. S:IBRETURN["MAX free" @IBR@(2)=-1_U_IBRETURN
 ..; D APPERROR^%ZTER("RETURN(UPDATE)^IBECEA37")  ; only use for debugging purposes
 . S @IBR@(1)="1^successfully updated" Q
 . Q
 ;
 ; found "many" (could be two or a jillion).  Should not happen now that we add a unique identifier (KEYWORDS: should + not + unique)
 I +$G(^TMP("DILIST",$J,0))>1 D  Q
 . S @IBR@(1)="-1^Could not uniquely identify entry being updated - more than one match.  Originating site# "_$P(IBUNIQ,"_")_" and IEN:"_$P(IBUNIQ,"_",2) Q
 ;
 ; no matches, feel free to add one
 I '$G(^TMP("DILIST",$J,0)) D  Q
 . S IBADDED=$$ADD(IBDFN,IBOSITEEX,IBVISDT,IBSTAT,IBBILL,IBCOMM,0,IBUNIQ,.IBRETURN)
 . I 'IBADDED D  Q
 .. S @IBR@(1)="-1^Unable to ADD record at site# "_IBSITE_"."
 ..; S:IBRETURN["MAX free" @IBR@(1)=@IBR@(1)_" "_IBRETURN
 .. S:IBRETURN["MAX free" @IBR@(2)=-1_U_@IBRETURN
 ..; D APPERROR^%ZTER("RETURN(ADD)^IBECEA37")
 . S @IBR@(1)="1^successfully added" Q
 . Q
 Q
 ;
ADD(IBDFN,IBSITE,IBVISDT,IBSTAT,IBBILL,IBCOMM,IBUPDATE,IBUNIQ,RETURN) ; Add an entry to the file
 ; INPUT:
 ;        IBDFN - Pointer to the patient number
 ;        IBSITE - external site number
 ;        IBVISDT - Visit date
 ;        IBSTAT - Status
 ;        IBBILL - Bill number or possibly free text description such as 'ONHOLD'
 ;        IBCOMM - Cancel reason
 ;        IBUPDATE - 1 if this is the originating site and data should be pushed out to other treating facilities, otherwise 0
 ;        IBUNIQ - Unique ID consiting of external site number underscor ien of file 351.82 on originating site ex. 442_1234567
 ; OUTPUT:
 ;        RETURN - This is any information returned by FileMan if update was unsuccessful
 ;  
 ; Function call returns 0 or 1 if successful.
 ; data must be all internal or all external - no mashup of the two allowed
 ; I vote internal and since I am coding...
 ; the incoming parameters were all internal except site #.
 ; NOTE to self: internal data is filed without validation so be sure it's cool
 ;
 N IBCTS,IBMAXFR
 S IBMAXFR=3  ; max free visits in a calendar year
 S IBCTS=$$GETVST^IBECEA36(IBDFN,IBVISDT)
 I $G(IBSTAT)=1,$P(IBCTS,U,2)'<IBMAXFR D  Q 0
 . N Y
 . S Y=IBVISDT X ^DD("DD")
 . S RETURN="Exceeds MAX free visits in a calendar year.  Can't add "_Y_"."
 ;
 N FDA,IENS
 S IENS="+1,"
 S FDA(351.82,IENS,.01)=IBDFN
 S FDA(351.82,IENS,.02)=$$FIND1^DIC(4,,"X",IBSITE,"D")   ; turn external site # into internal one
 S FDA(351.82,IENS,.03)=IBVISDT
 S FDA(351.82,IENS,.04)=$G(IBSTAT)
 S FDA(351.82,IENS,.05)=$G(IBBILL)
 S FDA(351.82,IENS,.06)=$G(IBCOMM)
 S FDA(351.82,IENS,.07)=$G(IBUNIQ)
 S FDA(351.82,IENS,1.01)=$G(IBUPDATE)  ; While technically being added, this is not the originating site so don't mark as such.  The flag is used to determine which entries to push.
 ;
 ; first parameter is currently "" so internal it is for now
 D UPDATE^DIE("","FDA","","RETURN")
 ;
 ; if RETURN is defined then BAD else GOOD
 Q $S($D(RETURN):0,1:1)
 ;
UPDATE(IBIEN,IBSTAT,IBBILL,IBCOMM,IBUPDATE,RETURN) ; update an entry to the file
 ;  INPUT:
 ;        IBIEN - internal entry number into 351.82 that is being edited
 ;        IBSTAT - Status
 ;        IBBILL - Bill number or possibly free text description such as 'ONHOLD'
 ;        IBCOMM - Cancel reason 
 ;        IBUPDATE  - 1 if this is the originating site and data should be pushed out to other treating facilities, otherwise 0
 ;  OUTPUT:
 ;        RETURN - This is any information returned by FileMan if update was unsuccessful
 ;  
 ; Function call returns 0 or 1 if successful.
 ;    
 ; limiting edits to a few fields
 ; data must be all internal or all external - no mashup of the two allowed
 ; I still vote internal and since I am still coding...
 ; the incoming parameters were all internal
 ; NOTE to self: internal data is filed without validation so be sure it's cool
 ;
 ; returns 1 if added sucessfully
 ; returns 0 otherwise
 ;
 N IBCTS,IBMAXFR,IBDFN,IBVISDT
 S IBDFN=$$GET1^DIQ(351.82,IBIEN,.01,"I")
 S IBVISDT=$$GET1^DIQ(351.82,IBIEN,.03,"I")
 S IBMAXFR=3  ; max free visits in a calendar year
 S IBCTS=$$GETVST^IBECEA36(IBDFN,IBVISDT)
 I $G(IBSTAT)=1,$P(IBCTS,U,2)'<IBMAXFR D  Q 0
 . N Y
 . S Y=IBVISDT X ^DD("DD")
 . S RETURN="Exceeds MAX free visits in a calendar year.  Can't update "_Y_"."
 ;
 N FDA,IENS
 S IENS=IBIEN_","
 S FDA(351.82,IENS,.04)=$G(IBSTAT)
 S FDA(351.82,IENS,.05)=$G(IBBILL)
 S FDA(351.82,IENS,.06)=$G(IBCOMM)
 S FDA(351.82,IENS,1.01)=$G(IBUPDATE,0)
 ;
 ; first parameter is currently "" so internal it is for now
 D FILE^DIE("","FDA","RETURN")
 ;
 ; if RETURN is defined then BAD else GOOD
 Q $S($D(RETURN):0,1:1)
 ;
PULL(RETURN,IBFAC,IBSITE,IBICN,IBOSITEEX) ; more "PULL" than PULL.  It's a request to be PUSHed back.
 ; This is actually going to a site and telling them which records to push back since the push was already coded and we will be leveraging that.
 ; RETURN - array
 ; IBFAC - this site internal
 ; IBSITE - this site external
 ; IBICN - Patient being pulled
 ; IBOSITEEX - Requesting site
 ;
 N IBIEN4,IBDFN,IBSCREEN,IBDATA,IBLOOP,IBADD,IBRESULTS
 S IBIEN4=$$FIND1^DIC(4,,"X",IBOSITEEX,"D")   ; get the internal site number (File 4 IEN) - should be the same across sites but then again shouldn't have to.
 I 'IBIEN4 S @RETURN@(1)="-1^Site# "_IBOSITEEX_" not found in INSTITUTION (#4) file lookup" Q
 ;
 ; make sure the patient is identifiable from this ICN
 ; if not, not much I can do
 S IBDFN=+$$DFN^IBARXMU($G(IBICN))
 I 'IBDFN S @RETURN@(1)="-1^Patient ICN: "_IBICN_" not found at site# "_IBSITE Q
 ;
 ; Get all/only the records for the patient which originated at this site.
 S IBSCREEN="I $P(^(0),U,2)=IBFAC"
 D FIND^DIC(351.82,"",".01;.02:99;.03I;.04I;.05;.06I;.07I;1.01I","QEP",IBDFN,"","B",IBSCREEN)
 ;
 I '+$G(^TMP("DILIST",$J,0)) D  Q
 . N IBLN,IBL4
 . S IBLN=$P($$GET1^DIQ(2,IBDFN,.01),",",1)   ; last name
 . S IBL4=$$GET1^DIQ(2,IBDFN,.09),IBL4=$E(IBL4,$L(IBL4)-3,9999)  ; last 4
 . S @RETURN@(0)="0^No records to pull for patient "_IBLN_" ("_IBL4_") at site# "_IBSITE
 ;
 ; mark them somehow
 F IBLOOP=1:1:+$G(^TMP("DILIST",$J,0)) D
 . S IBDATA=$G(^TMP("DILIST",$J,IBLOOP,0))
 . Q:'+IBDATA   ; not sure how this would happen
 . S IBADD=$$MARKPULL(+IBDATA,IBIEN4,.IBRESULTS)
 . I 'IBADD S @RETURN@(1)="-1^Problem pulling from site# "_IBSITE
 I $G(IBADD) S @RETURN@(1)="1^Successfully requested records from site# "_IBSITE
 ;
 ; taskman a process to walk that new "APULL" index and send them where they ought to go.
 N ZTRTN,ZTDESC,ZTDTH,ZTIO,ZTSK,ZTSAVE
 S ZTRTN="PULLTASK^IBECEA37",ZTDESC="Query Remote Facilities for CC Urgent Care Visits"
 S ZTDTH=$$FMADD^XLFDT($$NOW^XLFDT)
 S (ZTIO,ZTSAVE("IBOSITEEX"))=""
 D ^%ZTLOAD
 Q
 ;
MARKPULL(IBIEN,IBOSITEIN,IBRESULTS) ; add this facility to subfile as a pull request for this record.  Puts in the "APULL" index as well.
 ; IBIEN - internal enrtry number to file 351.82
 ; IBOSITEIN - originating site internal entry (pointer to file #4)
 ;
 N FDA,IENS,IBNOW,RETIEN,%
 S IENS="?+1,"_IBIEN_","
 S FDA(351.821,IENS,.01)=IBOSITEIN
 D NOW^%DTC S IBNOW=%
 S FDA(351.821,IENS,.02)=IBNOW
 D UPDATE^DIE("","FDA","RETIEN","IBRESULTS")
 ; if IBRESULTS is defined then BAD else GOOD
 ;I $D(IBRESULTS) D APPERROR^%ZTER("MARKPULL^IBECEA38")
 Q $S($D(IBRESULTS):0,1:1)
