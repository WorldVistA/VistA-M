IB20P229 ;ISP/TJH - Post-Init routine for IB*2.0*229 ;07/22/2003
 ;;2.0;INTEGRATED BILLING;**229**;21-MAR-94
POST ; This routine converts BILL STATUS MESSAGEs prior to 3/24/2003
 ; that have a REVIEW STATUS of 0, to a REVIEW STATUS of 2.
 ; Code introduced by IB*2.0*197 on 3/24/2003 should now be doing
 ; this automatically but records prior to that time were not converted
 ; and have become a nuisance.  Responding to NOIS FGH-0203-31133.
 ;
REV ; Convert REVIEW STATUS if appropriate
 I '$D(^IBM(361,"AREV",0)) D  Q
 . D BMES^XPDUTL("No records to convert.  Processing complete.")
 D BMES^XPDUTL("Conversion of ^IBM(361,""AREV"",0 started.")
 K ^TMP("IB20P229",$J)
 N DA,DIE,DR,IBA,IBM
 S DA=0
 ; loop through AREV x-ref 0 entries
 F  S DA=$O(^IBM(361,"AREV",0,DA)) Q:DA=""  D
 . D GETS^DIQ(361,DA_",",".02;.03","I","IBA","IBM")
 . ; check for problems with the record
 . I '$D(IBA) S ^TMP("IB20P229",$J,DA)=$G(IBM("DIERR",1,"TEXT",1)) Q
 . ; select records older than 3/24/03 with a message severity of Information/Warning
 . I (IBA(361,DA_",",.02,"I")<3030324)&(IBA(361,DA_",",.03,"I")="I") D
 .. ; and convert those records to Review Complete, Final Review Action=F and Auto Filed=Yes
 .. S DR=".09////2;.1////F;.14////1",DIE="^IBM(361," D ^DIE
 . K IBA,IBM
 I $D(^TMP("IB20P229",$J)) D TMMSG
 K ^TMP("IB20P229",$J)
 D END
 Q
 ;
END ; display message that pre-init has completed successfully
 D BMES^XPDUTL("Conversion complete.")
 Q
 ;
TMMSG ; Send message reporting any database issues found by FM during conversion
 N DA,IBC,IBGROUP,IBPARAM,IBTXT,XMDUZ,XMSUB,XMTEXT,XMY
 S XMSUB="IB*2.0*229 ERROR REPORT"
 S XMDUZ=DUZ,XMTEXT="IBTXT"
 S IBPARAM("FROM")="PATCH IB*2.0*229 CONVERSION"
 S IBGROUP="IB EDI SUPERVISOR"
 I '$D(^XMB(3.8,"B",IBGROUP)) S IBGROUP=DUZ ; billing group not defined - send to the user
 E  S IBGROUP="G."_IBGROUP
 S XMY(IBGROUP)="",XMY("HOLLOWAY.THOMAS_J@FORUM.VA.GOV")=""
 ;
 S IBC=0
 S IBC=IBC+1,IBTXT(IBC)="This message has been sent by patch IB*2.0*229 at the completion of"
 S IBC=IBC+1,IBTXT(IBC)="the conversion of the 'Information/Warning' records in file #361."
 S IBC=IBC+1,IBTXT(IBC)="The purpose of this message is to report any errors encountered during"
 S IBC=IBC+1,IBTXT(IBC)="the conversion."
 S IBC=IBC+1,IBTXT(IBC)="  "
 S IBC=IBC+1,IBTXT(IBC)="The following IENs in the AREV cross reference were not found in the main file."
 S DA=0
 F  S DA=$O(^TMP("IB20P229",$J,DA)) Q:DA=""  D  Q:IBC>110
 . S IBC=IBC+1
 . I IBC>110 S IBTXT(IBC)="Additional errors exist.  Your system manager should be consulted." Q
 . S IBTXT(IBC)=DA_":  "_^TMP("IB20P229",$J,DA)
 D SENDMSG^XMXAPI(XMDUZ,XMSUB,XMTEXT,.XMY,.IBPARAM,"","")
 S IBTXT="Conversion timing message "_$S($D(XMERR):"not sent due to error in message set up.",1:"sent to IB EDI SUPERVISOR mail group and to the patch developer.")
 D BMES^XPDUTL(IBTXT)
 Q
