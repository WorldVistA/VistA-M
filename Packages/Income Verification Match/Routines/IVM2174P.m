IVM2174P ;ALB/JAM - IVM*2.0*174 POST-INSTALL TO FIX DEPENDENT SSN IN (#408.13) FILE ;9/26/2018 3:21pm
 ;;2.0;INCOME VERIFICATION MATCH;**174**;21-OCT-94;Build 15
 ;
 Q
EP ; Entry Point
 ; Extend the expiration date of the ^XTMP("DG53970P") global to +120 days
 S $P(^XTMP("DG53970P",0),"^",1)=$$FMADD^XLFDT(DT,120)
 ;
 N ZTRTN,ZTDESC,ZTDTH,IVMTEXT,ZTIO,ZTSK
 S IVMTEXT(1)="    >>> Tasking job to gather list of ICNs/DFNs in ^XTMP(""DG53970P"" global"
 S IVMTEXT(2)="    that need an update of dependent SSNs..."
 D BMES^XPDUTL(.IVMTEXT)
 ; Quit if already installed
 I $$PATCH^XPDUTL("IVM*2.0*174") D MES^XPDUTL("    Job does not need to be run since patch has been installed previously.") Q
 ;queue off job
 S ZTRTN="TASK^IVM2174P"
 S ZTDESC="IVM*2.0*174 Gather list of ICNs/DFNs in ^XTMP(""DG53970P"") that need update of dependent SSNs."
 S ZTDTH=$$NOW^XLFDT
 S ZTIO=""
 D ^%ZTLOAD
 K IVMTEXT
 S IVMTEXT(1)="    The task number is "_$G(ZTSK)_"."
 D MES^XPDUTL(.IVMTEXT)
 Q
TASK ;Build and send MailMan message with list of patient records needing SSN updates
 N JOB,DFN,IEN,PCNT,ICN,I,DCNT,IENCNT,VAL,XIEN,FOUND,LINE
 S (PCNT,JOB,DCNT)=0
 K ^TMP("IVM2174P")
 S JOB=$O(^XTMP("DG53970P",JOB))
 I JOB D GETDATA
 D MSG
 K ^TMP("IVM2174P")
 Q
GETDATA ; loop over DFNs in ^XTMP("DG53970P",JOB,"DFN") - store all data in ^TMP global 
 S DFN=0
 F I=1:1 S DFN=$O(^XTMP("DG53970P",JOB,"DFN",DFN)) Q:'DFN  D
 . S PCNT=PCNT+1
 . ; get the ICN and store the ICN/DFN
 . S ICN=$$GETICN^MPIF001(DFN)
 . S ^TMP("IVM2174P",$J,"DFN",I)=ICN_"/"_DFN
 . ; for this DFN, loop over the associated IENs in the 408.12 file "B" index
 . S IEN="" F  S IEN=$O(^DGPR(408.12,"B",DFN,IEN)) Q:'IEN  D
 . . ; get the related 408.13 IEN
 . . S VAL=$P(^DGPR(408.12,IEN,0),"^",3)
 . . I $P(VAL,";",2)'="DGPR(408.13," Q
 . . S XIEN=$P(VAL,";",1)
 . . ; If this IEN is in ^XTMP("DG53970P",JOB,"SSN",count)=IEN, it still needs SSN update - so store the info
 . . ;  If there is an error logged when the SSN was unsuccessfully updated, include that error in ^TMP global
 . . S FOUND=0
 . . S IENCNT=0 F  S IENCNT=$O(^XTMP("DG53970P",JOB,"SSN",IENCNT)) Q:'IENCNT  D  Q:FOUND
 . . . I ^XTMP("DG53970P",JOB,"SSN",IENCNT)=XIEN S DCNT=DCNT+1,FOUND=1,^TMP("IVM2174P",$J,"DFN",I,XIEN)=$G(^XTMP("DG53970P",JOB,"SSNERR",XIEN))
 Q
MSG ; All data is collected in ^TMP("IVM2174P") - put together email message
 N XMSUB,XMDUZ,XMY,XMTEXT,MSG,LN,IVMSITE,ERRMSG
 S IVMSITE=$$SITE^VASITE
 S XMY("G.IVM20174MONITOR@FORUM.VA.GOV")=""
 S XMY(DUZ)=""
 S XMTEXT="MSG("
 S XMDUZ=.5,XMSUB="IVM*2.0*174-#"_$P(IVMSITE,"^",3)_"-VHA/ES CLEANUP OF SSNs IN (#408.13) FILE"
 S MSG($$LN)=""
 S MSG($$LN)="The job completed to check if patient records still exist in the"
 S MSG($$LN)="^XTMP(""DG53970P"" global and require a push of corrected SSN data from ES"
 S MSG($$LN)="via an HL7(ORU-Z10) message."
 S MSG($$LN)=""
 S MSG($$LN)="Job Results:"
 S MSG($$LN)="------------"
 S MSG($$LN)=" Facility Name: "_$P(IVMSITE,"^",2)
 S MSG($$LN)="Station Number: "_$P(IVMSITE,"^",3)
 S MSG($$LN)=""
 S MSG($$LN)="Total patients (ICN/DFN) with dependents not updated: "_PCNT
 S MSG($$LN)="                  Total dependent (IENs) not updated: "_DCNT
 F I=1:1:PCNT D
 . SET DFN=^TMP("IVM2174P",$J,"DFN",I)
 . S MSG($$LN)=""
 . S MSG($$LN)="Patient ICN/DFN: "_DFN
 . ; loop over IENs - include the error message if there is one.
 . S IEN="",LINE=0 F  S IEN=$O(^TMP("IVM2174P",$J,"DFN",I,IEN)) Q:'IEN  D
 . . S ERRMSG=^TMP("IVM2174P",$J,"DFN",I,IEN)
 . . I ERRMSG'="" S ERRMSG="  ("_ERRMSG_")"
 . . I LINE=0 S MSG($$LN)=" Dependent IENs: "_IEN_ERRMSG,LINE=1
 . . E  S MSG($$LN)="                 "_IEN_ERRMSG
 ; send mail message with results
 D ^XMD
 ; if we have data in the ^XTMP global, requeue this job to run in 2 days
 I PCNT D
 . N ZTRTN,ZTDESC,ZTDTH,ZTIO,ZTSK
 . S ZTRTN="TASK^IVM2174P"
 . S ZTDESC="IVM*2.0*174 Gather list of ICNs/DFNs in ^XTMP(""DG53970P"") that need update of dependent SSNs."
 . S ZTDTH=$$SCH^XLFDT("2D",$$NOW^XLFDT)
 . S ZTIO=""
 . D ^%ZTLOAD
 Q
LN() ;Increment line counter
 S LN=$G(LN)+1
 Q LN
