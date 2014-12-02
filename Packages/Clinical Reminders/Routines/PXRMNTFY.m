PXRMNTFY ;SLC/PKR - Routines for notifications. ;07/25/2012
 ;;2.0;CLINICAL REMINDERS;**24**;Feb 04, 2005;Build 193
 ;
 ;========================
DELOPEN(DFN,ORN) ;Delete open OE/RR Notifications.
 N ALIST,IND,ORID,XQAID
 ;DBIA #10081
 D PATIENT^XQALERT("ALIST",DFN)
 F IND=1:1:ALIST D
 . S XQAID=$P(ALIST(IND),U,2)
 . S ORID=$P(XQAID,";",1)
 . I $P(ORID,",",3)=ORN D DELETE^XQALERT
 Q
 ;
 ;========================
SUICIDE(EVENT,DFN,VISIT) ;Send an alert if the patient attempted or
 ;completed suicide, as marked by a health factor. This is called
 ;from DATACHGR^PXRMPINF which is invoked by the protocol PXK VISIT
 ;DATA EVENT.
 N DATE,HAFIEN,HFBIEN,HFSAIEN,HFSCIEN,MSG,VHFIEN
 S HFSAIEN=$$FIND1^DIC(9999999.64,"","","MH SUICIDE ATTEMPTED")
 S HFSCIEN=$$FIND1^DIC(9999999.64,"","","MH SUICIDE COMPLETED")
 S (MSG,VHFIEN)=""
 F  S VHFIEN=$O(^XTMP(EVENT,VISIT,"HF",VHFIEN)) Q:VHFIEN=""  D
 . S HFAIEN=$P($G(^XTMP(EVENT,VISIT,"HF",VHFIEN,0,"AFTER")),U,1)
 . S HFBIEN=$P($G(^XTMP(EVENT,VISIT,"HF",VHFIEN,0,"BEFORE")),U,1)
 .;If after is null then the health factor has been deleted so delete
 .;any open alerts.
 . I HFAIEN="",HFBIEN'="" D DELOPEN^PXRMNTFY(DFN,77) Q
 .;If the before and after are the same the HF is not new so do not
 .;send the alert.
 . I HFAIEN=HFBIEN Q
 . I HFAIEN=HFSAIEN S MSG="Suicide attempted"
 . I HFAIEN=HFSCIEN S MSG="Suicide completed"
 I MSG="" Q
 ;DBIA #2028
 S DATE=$P(^AUPNVSIT(VISIT,0),U,1)
 ;If DATE is more than 30 days in the past do not send the alert.
 I $$FMDIFF^XLFDT(DT,DATE)>30 Q
 S MSG=MSG_" on "_$$FMTE^XLFDT(DATE,"5Z")
 ;DBIA #1362
 D EN^ORB3(77,DFN,"","",MSG,"")
 Q
 ;
