DG53970P ;ALB/JAM - REGISTRATION EMERGENCY PATCH POST-INSTALL TO FIX BLANK SSN IN PERSON INCOME FILE ;9/4/2018 3:21pm
 ;;5.3;Registration;**970**;Aug 13,1993;Build 14
 ;
 Q
EP ; Entry Point
 D BMES^XPDUTL(">>> Cleanup of SSNs in INCOME PERSON file (#408.13)...")
 ; Quit if already installed and ^XTMP exists
 I $$PATCH^XPDUTL("DG*5.3*970"),$D(^XTMP("DG53970P")) D MES^XPDUTL("    Job does not need to be run since patch has been installed previously.") Q
 ;queue off SSN cleanup
 N ZTRTN,ZTDESC,ZTDTH,DGTEXT,ZTIO,ZTSK
 S ZTRTN="CLEANUP^DG53970P"
 S ZTDESC="DG*5.3*970 Emergency patch to clean up SSNs in INCOME PERSON file (#408.13)."
 S ZTDTH=$$NOW^XLFDT
 S ZTIO=""
 D ^%ZTLOAD
 S DGTEXT(1)=" Cleanup of SSN fields queued."
 S DGTEXT(2)=" The task number is "_$G(ZTSK)_"."
 D MES^XPDUTL(.DGTEXT)
 Q
CLEANUP ; Entry point
 ; sweep through 408.13 file looking at SSN field (Piece 9) for values " " OR " P"
 ; - modify the SSN field to NULL
 ; - clean up the xrefs
 ; - get the associated DFN and store it
 ;
 ; Information from the cleanup will be placed in ^XTMP (120 day expiration) and sent in a Mailman message
 K ^XTMP("DG53970P")
 S ^XTMP("DG53970P",0)=$$FMADD^XLFDT(DT,120)_U_DT_U_"EMERGENCY PATCH DG*5.3*970-SSN CLEANUP"
 ; Collect stats: start/end time and the number of records scanned and number of SSNs cleaned
 N %,ZTDTS,ZTDTE,PCNT,SSN,SSNCNT,DFN,IEN,DGFIL,Y
 D NOW^%DTC S Y=% D DD^%DT
 S ZTDTS=Y
 S (PCNT,SSNCNT)=0
 S IEN=0,DGFIL=408.13
 F  S IEN=$O(^DGPR(DGFIL,IEN)) Q:'IEN  D
 . S PCNT=PCNT+1
 . S SSN=$P(^DGPR(DGFIL,IEN,0),"^",9)
 . I SSN=" "!(SSN=" P") D
 . . S $P(^DGPR(DGFIL,IEN,0),"^",9)=""
 . . ; we have to assume the xrefs are bad and need to be cleaned up
 . . D XREF(IEN,DGFIL)
 . . ; track number of records with SSN data cleaned
 . . S SSNCNT=SSNCNT+1
 . . ; Place IEN affected in ^XTMP global
 . . S ^XTMP("DG53970P",$J,"SSN",SSNCNT)=IEN
 . . ; retrieve the associated patient (DFN) for this record from the PATIENT RELATION file (#408.12)
 . . S DFN=$$GETDFN(IEN)
 . . ; we should always get a DFN but just in case we don't, log this and quit
 . . I 'DFN S ^XTMP("DG53970P",$J,"ERR",IEN)="" Q
 . . ; log the DFN in ^XTMP
 . . S ^XTMP("DG53970P",$J,"DFN",DFN)=""
 ; job completed, capture stats and send mailman message
 D NOW^%DTC S Y=% D DD^%DT
 S ZTDTE=Y
 D SENDMSG
 ; Place job data into ^XTMP Global
 S ^XTMP("DG53970P",$J,"DGSTART")=$G(ZTDTS) ;job start date/time
 S ^XTMP("DG53970P",$J,"DGEND")=$G(ZTDTE) ;job end date/time
 S ^XTMP("DG53970P",$J,"TOTAL")=SSNCNT ; total records affected
 Q
XREF(IEN,DGFIL) ; clean "SSN", "BS" and "BS5" xrefs for this INCOME PERSON file (#408.13) record
 N VAL,XREF
 F XREF="SSN","BS","BS5" D
 . S VAL=""
 . F  S VAL=$O(^DGPR(DGFIL,XREF,VAL)) Q:VAL=""  D
 . . I $D(^DGPR(DGFIL,XREF,VAL,IEN)) K ^DGPR(DGFIL,XREF,VAL,IEN)
 Q
GETDFN(IEN) ; retrieve DFN for this IEN from 408.12
 N DFN,VAL,GLOC,XIEN,RELIEN
 S VAL="",DFN=""
 ; step through "C" xref
 F  S VAL=$O(^DGPR(408.12,"C",VAL)) Q:VAL=""  D  Q:DFN
 . ; the format of VAL we are looking for is IEN;GLOBAL REFERENCE
 . ; where the IEN matches the IEN passed in and the GLOBAL REF is "DGRP(408.13,"
 . S GLOC=$P(VAL,";",2),XIEN=+VAL
 . ; if we have what we are looking for, the next node in the xref will be the 408.12 IEN we want 
 . I XIEN=IEN,GLOC="DGPR(408.13," D
 . . S RELIEN=$O(^DGPR(408.12,"C",VAL,""))
 . . Q:RELIEN=""
 . . ; the DFN will be piece 1 of this IEN record
 . . S DFN=$P(^DGPR(408.12,RELIEN,0),"^",1)
 Q DFN
SENDMSG ;Send MailMan message when process completes
 N XMSUB,XMDUZ,XMY,XMTEXT,MSG,LN
 S XMY(DUZ)="",XMTEXT="MSG("
 S XMDUZ=.5,XMSUB="DG*5.3*970 JOB TO CORRECT SSNs IN INCOME PERSON FILE (#408.13)"
 S MSG($$LN)="The DG*5.3*970 process has completed."
 S MSG($$LN)=""
 S MSG($$LN)="This process ran through the INCOME PERSON file #408.13 and checked each"
 S MSG($$LN)="record for the Social Security Number (#.09) field having a 'space' or"
 S MSG($$LN)="a 'space' followed by a 'P' and deleted the field."
 S MSG($$LN)=""
 S MSG($$LN)="The process statistics:"
 S MSG($$LN)=""
 S MSG($$LN)="Job Start Date/Time: "_$G(ZTDTS)
 S MSG($$LN)="  Job End Date/Time: "_$G(ZTDTE)
 S MSG($$LN)=""
 S MSG($$LN)="Total INCOME PERSON file (#408.13) records searched: "_+$G(PCNT)
 S MSG($$LN)="Total records with SSN data updated: "_+$G(SSNCNT)
 S MSG($$LN)=""
 S MSG($$LN)=" View global ^XTMP(""DG53970P"","_$J_",""SSN"" for the list of records in the"
 S MSG($$LN)="  INCOME PERSON file that had SSN data updated."
 S MSG($$LN)=" View global ^XTMP(""DG53970P"","_$J_",""DFN"" for the list of Patients (DFNs)"
 S MSG($$LN)="  associated with the updated INCOME PERSON file records."
 S MSG($$LN)=" View global ^XTMP(""DG53970P"","_$J_",""ERR"" for the list of records in the"
 S MSG($$LN)="  INCOME PERSON file for which a DFN was not found."
 D ^XMD
 Q
LN() ;Increment line counter
 S LN=$G(LN)+1
 Q LN
