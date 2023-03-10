EC2P156 ;ALB/CMD - EC Procedure Reasons Update ;12/22/21  18:59
 ;;2.0;EVENT CAPTURE;**156**;8 May 96;Build 28
 ;
 ; This routine is used as a post-init in a KIDS build
 ; to update the EC Procedure Reasons file (#720.4).
 ;
 ; Reference to ^DIE supported by ICR# 10018
 ; Reference to ^XMD supported by ICR #10070
 ; Reference to ^TMP($J)  supported by SACC 2.3.2.5.1
 ; Reference to ^XUSEC(key) supported by ICR #10076
 ;
POST ;Post-install activities
 ;Update Procedure Reasons to Inactivate CHAPLAIN Procedure Reasons and send mail message with results
 D INACTPR ;inactivate all CHAPLAIN procedure reasons
 Q
 ;
INACTPR ;Inactivate all CHAPLAIN Procedure Reasons and send mail message with results
 N ECPRNM,ECPRIEN,ECPR,DA,DIE,DR
 S ECPRNM=""
 F  S ECPRNM=$O(^ECR("B",ECPRNM)) Q:ECPRNM=""  I $E(ECPRNM,1,5)="CHAP " D
 . S ECPRIEN=$O(^ECR("B",ECPRNM,""))
 . I '$P(^ECR(ECPRIEN,0),"^",2) Q  ;Skip if procedure reason is already inactive
 . ;Inactivate the CHAP Procedure Reason
 . S DA=ECPRIEN,DR=".02////0",DIE="^ECR(" D ^DIE
 . S ECPR(ECPRNM)=""
 D MAIL(.ECPR) ;Send mail with results
 Q
 ;
MAIL(PROREAS) ; Send email with results to holders of the ECMGR key
 N XMSUB,XMTEXT,XMDUZ,XMY,XMZ,CNT,DIFROM,ECTEXT,NUM,NAME
 S XMDUZ="PATCH EC*2.0*156 POST-INSTALL"
 D GETXMY("ECMGR",.XMY)
 S XMSUB="Inactivation of CHAPLAINS Procedure Reasons"
 S XMTEXT="ECTEXT("
 S CNT=1
 I '$D(PROREAS) D
 .S ECTEXT(CNT)="No CHAPLAIN Procedure Reasons were inactivated, as no Active CHAPLAIN Procedure Reasons were found.",CNT=CNT+1
 I $D(PROREAS) D
 .S NAME=""
 .S ECTEXT(CNT)="The following CHAPLAIN Procedure Reasons have been inactivated: ",CNT=CNT+1
 .S ECTEXT(CNT)=" ",CNT=CNT+1
 .F  S NAME=$O(PROREAS(NAME)) Q:NAME=""  D
 ..S ECTEXT(CNT)=NAME,CNT=CNT+1
 D ^XMD
 Q
GETXMY(KEY,XMY) ;Put holders of the KEY into the XMY array to be recipients of the email
 I $G(KEY)'="" M XMY=^XUSEC(KEY)
 S:$G(DUZ) XMY(DUZ)="" ;Make sure there's at least one recipient
 Q
