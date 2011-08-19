ORY107 ;DAN/SLC Clean up non-canonic dates ;3/14/01  14:03
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**107**;Mar 15, 2001
 ;This routine will find all order date/time entries that
 ;are non-canonical and enter them in canonic form.
 N ORI,ORIEN,ORACT,ORMSG,DA,DIE,DR
 S ORMSG(1)="A task is being queued in the background to identify"
 S ORMSG(2)="any orders whose DATE/TIME ENTERED field is a non-canonic"
 S ORMSG(3)="number (having trailing zeros)."
 S ORMSG(4)=""
 S ORMSG(5)="These entries will be set to the correct canonic form"
 S ORMSG(6)="by the background job and a mail message will be sent"
 S ORMSG(7)="to the initiator of this patch at completion."
 S ORMSG(8)=""
 S ZTRTN="DQ^ORY107",ZTIO="",ZTDESC="DATE/TIME ORDER field clean up - Patch 107",ZTDTH=$H,ZTSAVE("DUZ")="" D ^%ZTLOAD
 S ORMSG(9)="The task number is "_$G(ZTSK)
 D MES^XPDUTL(.ORMSG) I '$D(ZTQUEUED) N DIR,Y S DIR(0)="E",DIR("A")="Press return to continue installation" D ^DIR
 Q
DQ ;Start processing here
 S ORI="00" F  S ORI=$O(^OR(100,"AF",ORI)) Q:ORI=""  I ORI'=+ORI D  ;if date/time is non-canonic then fix
 .S ORIEN="" F  S ORIEN=$O(^OR(100,"AF",ORI,ORIEN)) Q:ORIEN=""  S ORACT="" F  S ORACT=$O(^OR(100,"AF",ORI,ORIEN,ORACT)) Q:ORACT=""  D UPDATE
 .Q
 D MAIL ;send email notifying initiator that clean up is finished
 Q
UPDATE ;change date/time to canonic form and call DIE to reset cross references
 S DIE="^OR(100,"_ORIEN_",8,",DA=ORACT,DA(1)=ORIEN,DR=".01///"_+ORI
 D ^DIE
 Q
MAIL ; -- Send completion message to user who initiated conversion
 N XMSUB,XMTEXT,XMDUZ,XMY,XMZ,XMMG,ORTXT
 S XMDUZ="PATCH OR*3*107 CLEAN-UP",XMY(.5)="" S:$G(DUZ) XMY(DUZ)=""
 S ORTXT(1)="The DATE/TIME ORDERED field clean up for patch OR*3*107"
 S ORTXT(2)="completed at "_$$FMTE^XLFDT($$NOW^XLFDT)_"."
 S XMTEXT="ORTXT(",XMSUB="PATCH OR*3*107 Clean Up COMPLETED"
 D ^XMD
 Q
