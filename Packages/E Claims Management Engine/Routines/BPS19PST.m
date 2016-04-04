BPS19PST ;ALB/DMB - Post-install for BPS*1.0*19 ;10/21/2014
 ;;1.0;E CLAIMS MGMT ENGINE;**19**;JUN 2004;Build 18
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; NCPDP Continuous Maintenance Standards - BPS*1*19 patch post install
 ;
 Q
 ;
EN ; Entry Point for post-install
 D MES^XPDUTL("  Starting post-install for BPS*1*19")
 ;
 ; Update the OTHER PAYER AMT PAID QUALIFIER field in the BPS REQUEST file
 D REQUEST
 ;
 ; Delete the BPS NCPDP FIELD CODE file
 D FLDCD
 ;
 ; Queue background task to update the OTHER PAYER AMT PAID QUALIFIER field in other files
 D JOB
 ;
EX ; exit point
 D BMES^XPDUTL("  Finished post-install of BPS*1*19")
 Q
 ;
REQUEST ;
 ; Loop through BPS REQUESTS and change the OTHER PAYER AMT PAID QUALIFIER from
 ;   a set of codes to a pointer
 N IEN,IEN1,IEN2,OIEN,CODE,CNT,SUCCNT
 D BMES^XPDUTL("    Update BPS REQUESTS file")
 ;
 ; Loop through the BPS REQUESTS file
 S CNT=0,SUCCNT=0
 S IEN=0 F  S IEN=$O(^BPS(9002313.77,IEN)) Q:'IEN  D
 . S CNT=CNT+1
 . I CNT#1000=1 W "."
 . S IEN1=0 F  S IEN1=$O(^BPS(9002313.77,IEN,8,IEN1)) Q:'IEN1  D
 .. S IEN2=0 F  S IEN2=$O(^BPS(9002313.77,IEN,8,IEN1,1,IEN2)) Q:'IEN2  D
 ... S CODE=$P($G(^BPS(9002313.77,IEN,8,IEN1,1,IEN2,0)),"^",2)
 ... I CODE="" Q
 ... I CODE=11 Q   ; This is Sales Tax that was already converted
 ... I CODE="  " S CODE="00"  ; Not Specified (dictionary is '00', NCPDP is "  ".
 ... S OIEN=$O(^BPS(9002313.2,"B",CODE,""))
 ... I OIEN="" Q
 ... S $P(^BPS(9002313.77,IEN,8,IEN1,1,IEN2,0),"^",2)=OIEN
 ... S SUCCNT=SUCCNT+1
 ;
 D MES^XPDUTL("    Complete - Updated "_SUCCNT_" records.")
 Q
 ;
FLDCD ;
 ; Delete the BPS NCPDP FIELD CODE file
 ;
 D BMES^XPDUTL("    Delete the BPS NCPDP FIELD CODE file")
 I '$D(^BPS(9002313.94)),'$D(^DIC(9002313.94)) D MES^XPDUTL("    Already Deleted") Q
 N DIU
 S DIU=9002313.94,DIU(0)="D"
 D EN^DIU2
 D MES^XPDUTL("    Complete")
 Q
 ;
JOB ;
 D BMES^XPDUTL("    Queuing background job to update the OTHER PAYER AMT PAID QUALIFIER field")
 D MES^XPDUTL("    A Mailman message will be sent when it finishes")
 ;
 ; Setup required variables
 N ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSK
 S ZTRTN="UPDATE^BPS19PST",ZTIO="",ZTDTH=$H
 S ZTDESC="Background job to update the OTHER PAYER AMT PAID QUALIFIER field via BPS*1*19"
 ;
 ; Task the job
 D ^%ZTLOAD
 ;
 ; Check if task was created
 I $D(ZTSK) D MES^XPDUTL("    Task #"_ZTSK_" queued")
 I '$D(ZTSK) D MES^XPDUTL("   Task not queued.  Please create a support ticket.")
 Q
 ;
UPDATE ;
 ; Update the OTHER PAYER AMT PAID QUALIFIER in BPS Transaction, BPS Log of Transactions,
 ;   and BPS Certification.
 ;
 N IEN,IEN1,IEN2,IEN3,OIEN,CODE,TRANCNT,LOGCNT,CERTCNT
 ;
 ; Loop through BPS TRANSACTIONs and change the OTHER PAYER AMT PAID QUALIFIER from
 ;   a set of codes to a pointer
 S TRANCNT=0
 S IEN=0 F  S IEN=$O(^BPST(IEN)) Q:'IEN  D
 . S IEN1=0 F  S IEN1=$O(^BPST(IEN,14,IEN1)) Q:'IEN1  D
 .. S IEN2=0 F  S IEN2=$O(^BPST(IEN,14,IEN1,1,IEN2)) Q:'IEN2  D
 ... S CODE=$P($G(^BPST(IEN,14,IEN1,1,IEN2,0)),"^",2)
 ... I CODE="" Q
 ... I CODE=11 Q    ; This is Sales Tax that was already converted
 ... I CODE="  " S CODE="00"  ; Not Specified (dictionary is '00', NCPDP is "  ".
 ... S OIEN=$O(^BPS(9002313.2,"B",CODE,""))
 ... I OIEN="" Q
 ... S $P(^BPST(IEN,14,IEN1,1,IEN2,0),"^",2)=OIEN
 ... S TRANCNT=TRANCNT+1
 ;
 ; Loop through BPS LOG OF TRANSACTIONs and change the OTHER PAYER AMT PAID
 ;   QUALIFIER from a set of codes to a pointer
 S LOGCNT=0
 S IEN=0 F  S IEN=$O(^BPSTL(IEN)) Q:'IEN  D
 . S IEN1=0 F  S IEN1=$O(^BPSTL(IEN,14,IEN1)) Q:'IEN1  D
 .. S IEN2=0 F  S IEN2=$O(^BPSTL(IEN,14,IEN1,1,IEN2)) Q:'IEN2  D
 ... S CODE=$P($G(^BPSTL(IEN,14,IEN1,1,IEN2,0)),"^",2)
 ... I CODE="" Q
 ... I CODE=11 Q   ; This is Sales Tax that was already converted
 ... I CODE="  " S CODE="00"  ; Not Specified (dictionary is '00', NCPDP is "  ".
 ... S OIEN=$O(^BPS(9002313.2,"B",CODE,""))
 ... I OIEN="" Q
 ... S $P(^BPSTL(IEN,14,IEN1,1,IEN2,0),"^",2)=OIEN
 ... S LOGCNT=LOGCNT+1
 ;
 ; Loop through BPS CERTIFICATION and change the OTHER PAYER AMT PAID QUALIFIER from
 ;   a set of codes to a pointer
 S CERTCNT=0
 S IEN=0 F  S IEN=$O(^BPS(9002313.31,IEN)) Q:'IEN  D
 . S IEN1=0 F  S IEN1=$O(^BPS(9002313.31,IEN,2,IEN1)) Q:'IEN1  D
 .. S IEN2=0 F  S IEN2=$O(^BPS(9002313.31,IEN,2,IEN1,3,IEN2)) Q:'IEN2  D
 ... S IEN3=0 F  S IEN3=$O(^BPS(9002313.31,IEN,2,IEN1,3,IEN2,1,IEN3)) Q:'IEN3  D
 .... S CODE=$P($G(^BPS(9002313.31,IEN,2,IEN1,3,IEN2,1,IEN3,0)),"^",2)
 .... I CODE="" Q
 .... I CODE=11 Q   ; This is Sales Tax that was already converted
 .... I CODE="  " S CODE="00"  ; Not Specified (dictionary is '00', NCPDP is "  ".
 .... S OIEN=$O(^BPS(9002313.2,"B",CODE,""))
 .... I OIEN="" Q
 .... S $P(^BPS(9002313.31,IEN,2,IEN1,3,IEN2,1,IEN3,0),"^",2)=OIEN
 .... S CERTCNT=CERTCNT+1
 ;
 ; Send mailman message with results
 D MAIL(TRANCNT,LOGCNT,CERTCNT)
 Q
 ;
MAIL(TRANCNT,LOGCNT,CERTCNT) ;
 N CNT,MSG,XMY,XMDUZ,DIFROM,XMSUB,XMTEXT
 S XMY(DUZ)=""
 S XMSUB="BPS*1.0*19 Post install is complete",XMDUZ="Patch BPS*1.0*19"
 S XMTEXT="MSG("
 S CNT=1,MSG(CNT)=""
 S CNT=CNT+1,MSG(CNT)="Patch BPS*1.0*19 post install routine has completed."
 S CNT=CNT+1,MSG(CNT)=""
 S CNT=CNT+1,MSG(CNT)="Updated "_TRANCNT_" records in the BPS TRANSACTION file."
 S CNT=CNT+1,MSG(CNT)="Updated "_LOGCNT_" records in the BPS LOG OF TRANSACTIONS file."
 S CNT=CNT+1,MSG(CNT)="Updated "_CERTCNT_" records in the BPS CERTIFICATION file."
 S CNT=CNT+1,MSG(CNT)=""
 S CNT=CNT+1,MSG(CNT)="For more information about this post install, review the patch description."
 D ^XMD
 Q
