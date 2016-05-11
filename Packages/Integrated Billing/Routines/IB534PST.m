IB534PST ;ALB/DMB - Post Install for IB*2*534 ;10/21/2014
 ;;2.0;INTEGRATED BILLING;**534**;21-MAR-94;Build 18
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
EN ; entry point
 D BMES^XPDUTL("  Starting post-install for IB*2*534")
 ;
 ; Populate the New Non-Billable Status field
 D NBJOB
 ;
 ; Completion Message
 D BMES^XPDUTL("  Finish of IB*2.0*534 post-install")
 Q
 ;
NBJOB ;
 D BMES^XPDUTL("    Queuing background job to update the Non-Billable Status field")
 D MES^XPDUTL("    A Mailman message will be sent when it finishes")
 ;
 ; Setup required variables
 S ZTRTN="NBSTATUS^IB534PST",ZTIO="",ZTDTH=$H
 S ZTDESC="Background job to update the Non-Billable Status field via IB*2*534"
 ;
 ; Task the job
 D ^%ZTLOAD
 ;
 ; Check if task was created
 I $D(ZTSK) D MES^XPDUTL("    Task #"_ZTSK_" queued")
 I '$D(ZTSK) D MES^XPDUTL("   Task not queued.  Please create a support ticket.")
 Q
 ;
NBSTATUS ;
 ; Update the New Non-Billable Status field (#.02) of IB NCPDP EVENT LOG (#366.14)
 ;
 N IEN,IEN1,X0,REASON,NBSTS,ERRCNT,SUCCNT,DIE,DA,DR,X,Y,DTOUT,DUOUT,DIC
 ;
 ; Loop through the IB NCPDP Event Log
 S ERRCNT=0,SUCCNT=0
 S IEN=0 F  S IEN=$O(^IBCNR(366.14,IEN)) Q:'IEN  D
 . S IEN1=0 F  S IEN1=$O(^IBCNR(366.14,IEN,1,IEN1)) Q:'IEN1  D
 .. S X0=$G(^IBCNR(366.14,IEN,1,IEN1,0))
 .. ;
 .. ; If not a Billable Status Check, quit
 .. I +X0'=1 Q
 .. ;
 .. ; If successful, quit
 .. I $P(X0,"^",7)'=0 Q
 .. ;
 .. ; If already populated, quit
 .. S NBSTS=$P(X0,U,2)
 .. I NBSTS]"" Q
 .. ;
 .. ; Get reason and see if it exists
 .. S REASON=$P(X0,U,8)
 .. I REASON="" Q
 .. ; 
 .. ; Convert to the proper format and see if it exists in the IB NCPDP NON-BILLABLE STATUS dictionary
 .. S REASON=$TR($E($$UP^XLFSTR(REASON),1,60),"^")
 .. I $E(REASON,$L(REASON))="." S REASON=$E(REASON,1,$L(REASON)-1)
 .. S NBSTS=$O(^IBCNR(366.17,"B",REASON,""))
 .. ;
 .. ; If it does not exist not, add to the dictionary
 .. I NBSTS="" D  I Y=-1 Q
 ... S DIC="^IBCNR(366.17,",DIC(0)="F",X=REASON
 ... D FILE^DICN
 ... I Y=-1 S ERRCNT=ERRCNT+1
 ... S NBSTS=+Y
 .. ;
 .. ; Update the file
 .. S DIE="^IBCNR(366.14,"_IEN_",1,",DA=IEN1,DA(1)=IEN,DR=".02////^S X=NBSTS"
 .. D ^DIE
 .. S SUCCNT=SUCCNT+1
 ;
 ; Send email with result
 D MAIL(SUCCNT,ERRCNT)
 Q
 ;
MAIL(SUCCNT,ERRCNT) ;
 N CNT,MSG,XMY,XMDUZ,DIFROM,XMSUB,XMTEXT
 S XMY(DUZ)=""
 S XMSUB="IB*2.0*534 Post install is complete",XMDUZ="Patch IB*2.0*534"
 S XMTEXT="MSG("
 S CNT=1,MSG(CNT)=""
 S CNT=CNT+1,MSG(CNT)="Patch IB*2.0*534 post install routine has completed."
 S CNT=CNT+1,MSG(CNT)=""
 S CNT=CNT+1,MSG(CNT)="Updated "_SUCCNT_" records in the IB NCPDP EVENT LOG."
 I ERRCNT D
 . S CNT=CNT+1,MSG(CNT)=ERRCNT_" dictionary entries were not created."
 . S CNT=CNT+1,MSG(CNT)="Create a support ticket to resolve failures."
 S CNT=CNT+1,MSG(CNT)=""
 S CNT=CNT+1,MSG(CNT)="For more information about this post install, review the patch description."
 D ^XMD
 Q
