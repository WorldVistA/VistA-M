PRC51110 ;VMP/TJH  ; Post Install routine for PRC*5.1*110 ; 07/20/2007
 ;;5.1;IFCAP;**110**;Oct 20, 2000;Build 7
 ;
 Q  ; Do Not Enter at routine label
 ;
EN ; Entry point.
TMMSG ; Send message reporting any address issues found during installation
 D BMES^XPDUTL("Validating VA FSC mailing address, please wait...")
 N PRCSTA,PRCA
 S PRCSTA=0,U="^"
 F  S PRCSTA=$O(^PRC(411,PRCSTA)) Q:'PRCSTA  D
 . S PRCSTN=$O(^DIC(4,"D",$P(^PRC(411,PRCSTA,0),U,1),"")) Q:PRCSTN=""
 . S PRCMAX=0,PRCFSC=0
 . F  S PRCMAX=$O(^PRC(411,PRCSTA,4,PRCMAX)) Q:'PRCMAX  D
 .. S PRCMAN=$P(^PRC(411,PRCSTA,4,PRCMAX,0),U,1)
 .. I $E(PRCMAN,1,6)="VA FSC" S PRCFSC=1
 .. I $E(PRCMAN,1,3)="FMS" S PRCA(PRCSTN,PRCMAX)=PRCMAN
 . I 'PRCFSC S PRCA(PRCSTN,0)="No VA FSC address."
 I '$D(PRCA) D BMES^XPDUTL("Validation complete.") Q  ; if nothing found, don't send MailMan message.
 ;
 N DA,PRCC,PRCGROUP,PRCPARAM,PRCTXT,XMDUZ,XMSUB,XMTEXT,XMY
 N PRC1,PRC2,PRCFSC,PRCMAN,PRCMAX,PRCNP,PRCSTR1,PRCSTR2,PRCTITLE,PRCTX
 S XMSUB="IMPORTANT BULLETIN FROM IFCAP PATCH PRC*5.1*110"
 S XMDUZ=DUZ,XMTEXT="PRCTXT"
 S PRCPARAM("FROM")="PATCH PRC*5.1*110 ADDRESS VERIFICATION"
 ; find purchasing/finance staff to send report to
 S PRCTX=0 K PRCJB
 F  S PRCTX=$O(^DIC(3.1,PRCTX)) Q:'PRCTX  D
 . S PRCTITLE=$P(^DIC(3.1,PRCTX,0),U,1)
 . F PRCSTR1="FISCAL","PURCH","FINAN","PROCUR","IFCAP" I $F(PRCTITLE,PRCSTR1) D
 .. F PRCSTR2="CHIEF","ADMIN","SUPER","COORD" I $F(PRCTITLE,PRCSTR2) S PRCJB(PRCTX)=""
 S PRCNP=1
 F  S PRCNP=$O(^VA(200,PRCNP)) Q:'PRCNP  D
 . S PRCTX=$P($G(^VA(200,PRCNP,0)),U,9)
 . Q:PRCTX=""  ; Quit if there is no job title
 . Q:'$D(PRCJB(PRCTX))  ; Quit if job title not one we're looking for
 . Q:$P(^VA(200,PRCNP,0),U,7)  ; Quit if DISUSERed
 . S XMY(PRCNP)="" ; add this responsible party to mail list.
 S XMY(DUZ)="" ; add the patch installer to the mail list
 ;
 S PRCC=0
 S PRCC=PRCC+1,PRCTXT(PRCC)="This message has been sent by patch PRC*5.1*110 at the completion of"
 S PRCC=PRCC+1,PRCTXT(PRCC)="the verification of the Mailing Address change for VA FSC."
 S PRCC=PRCC+1,PRCTXT(PRCC)="The purpose of this message is to report any remaining addresses which"
 S PRCC=PRCC+1,PRCTXT(PRCC)="might need to be edited and to report any Stations/Substations which"
 S PRCC=PRCC+1,PRCTXT(PRCC)="might need the VA FSC address added.  You can use the 'Site Parameters'"
 S PRCC=PRCC+1,PRCTXT(PRCC)="option to edit the MAIL INVOICE LOCATION entries if necessary."
 S PRCC=PRCC+1,PRCTXT(PRCC)=" "
 S PRCC=PRCC+1,PRCTXT(PRCC)="As reported in the patch description, the Corporate Franchise Data Center"
 S PRCC=PRCC+1,PRCTXT(PRCC)="in Austin has changed the preferred address name for IFCAP communications"
 S PRCC=PRCC+1,PRCTXT(PRCC)="from FMS to VA FSC.  This report lists any stations in your system that"
 S PRCC=PRCC+1,PRCTXT(PRCC)="do not have a MAIL INVOICE LOCATION starting with VA FSC.  The necessity"
 S PRCC=PRCC+1,PRCTXT(PRCC)="for the address only applies to Stations/Substations that will be using"
 S PRCC=PRCC+1,PRCTXT(PRCC)="requisitions.  You will need to make a local determination as to which"
 S PRCC=PRCC+1,PRCTXT(PRCC)="stations this applies to at your facility.  Additionally, the report"
 S PRCC=PRCC+1,PRCTXT(PRCC)="lists addresses which contain the old FMS abbreviation.  These could"
 S PRCC=PRCC+1,PRCTXT(PRCC)="be considered for editing or deletion.  Again, this should be a local"
 S PRCC=PRCC+1,PRCTXT(PRCC)="determination that cannot be automated by this patch."
 S PRCC=PRCC+1,PRCTXT(PRCC)="  "
 S PRCC=PRCC+1,PRCTXT(PRCC)="The following Stations/Substations do not have a VA FSC address entry"
 S PRCC=PRCC+1,PRCTXT(PRCC)="in the ADMIN. ACTIVITY SITE PARAMETER file."
 S DA=0
 F  S DA=$O(PRCA(DA)) Q:DA=""  Q:'$D(PRCA(DA,0))  D
 . S PRCC=PRCC+1
 . S PRCTXT(PRCC)=$P(^DIC(4,DA,99),U,1)
 . K PRCA(DA,0)
 S PRCC=PRCC+1,PRCTXT(PRCC)="  "
 S PRCC=PRCC+1,PRCTXT(PRCC)="The following Stations/Substations have an FMS address which may need"
 S PRCC=PRCC+1,PRCTXT(PRCC)="to be edited."
 S PRC1=0
 F  S PRC1=$O(PRCA(PRC1)) Q:PRC1=""  D
 . S PRC2=0
 . F  S PRC2=$O(PRCA(PRC1,PRC2)) Q:PRC2=""  D
 .. S PRCC=PRCC+1
 .. S PRCTXT(PRCC)=$P(^DIC(4,PRC1,99),U,1)_"    "_PRCA(PRC1,PRC2)
 D SENDMSG^XMXAPI(XMDUZ,XMSUB,XMTEXT,.XMY,.IBPARAM,"","")
 D BMES^XPDUTL("Address validation complete, a MailMan message has been sent listing items")
 D MES^XPDUTL("which may need to be reviewed.")
 Q
