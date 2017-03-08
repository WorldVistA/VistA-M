XOBWP004 ;OAK/BDT - HWSC ::XOBW*1*4 ; 06/28/2016
 ;;1.0;HwscWebServiceClient;**4**;September 13, 2010;Build 9
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 ; ***** IMPORTANT NOTE *******************************************
 ; This routine requires access to the manager (%SYS) namespace and
 ; can only be run by a user with permissions to that namespace.
 ; ****************************************************************
 ;
 N XUSL,X
 N DIF,XCNP K ^TMP($J,369)
 S X="XOBWLIB"
 S DIF="^TMP($J,369,",XCNP=0 X ^%ZOSF("LOAD")
 I $G(^TMP($J,369,2,0))'[";Build 31" D BMES^XPDUTL("Your system is missing latest build 31st of the XOBW*1.0*0 package") S XPDABORT=1
 Q
 ;
POST ;  -- main entry point for post-init
 D POST^XOBWPA04
 D POST^XOBWPB04
 D CHECK
 Q
 ;
CHECK ; check privillege
 N XOBWNOTE
 I ($ROLES["%All")!($ROLES["%Manager") D SSLCONF Q
 DO INCOMP
 D MES^XPDUTL(" ** Warning **")
 S XOBWNOTE="The SSL/TLS Configuration could not be installed at this time.  "
 S XOBWNOTE=XOBWNOTE_"You don't have the required privileged Role.  "
 S XOBWNOTE=XOBWNOTE_"A System Administrator must complete this step.  "
 S XOBWNOTE=XOBWNOTE_"Please follow the Post-Installation Instructions."
 D MES^XPDUTL(XOBWNOTE)
 Q
 ;
INCOMP ; generate incomplete-installation message
 S ^TMP("PSC DATA",$J,1)="Patch XOBW*1.0*4 has been installed but an extra step needs to be completed."
 S ^TMP("PSC DATA",$J,2)=""
 S ^TMP("PSC DATA",$J,3)="Please follow the instructions in the Post-Installation Instructions "
 S ^TMP("PSC DATA",$J,4)="to request your respective System Administration support group "
 S ^TMP("PSC DATA",$J,5)="(Region Operation Center) to assist you in completing the installation "
 S ^TMP("PSC DATA",$J,6)="of this patch."
 I $$PROD^XUPROD() DO MESSAGE
 Q
 ;
MESSAGE ;set up message and address list
 S MSG=$NA(^TMP("PSC DATA",$J))
 S MSGSBJ="XOBW*1.0*4 "_$G(^XMB("NETNAME"))
 S WHO("G.PATCH TRACKING XOBW_1_4@FORUM.DOMAIN.EXT")=""
 S WHO("Jose.Luis-Garcia@domain.ext")=""
 S WHO(DUZ)=""
 D SENDMSG^XMXAPI(DUZ,MSGSBJ,.MSG,.WHO)
 K ^TMP("PSC DATA",$J),WHO,MSG
 Q
 ;
SSLCONF ;Install SSL Configuration for encryption-only
 N XOBNAME,XOBPROP
 S XOBNAME="encrypt_only"
 ;I $$EXISTS(XOBNAME,.XOBPROP) D  Q
 ;.D BMES^XPDUTL(" o  '"_XOBNAME_"' SSL Config already exists and will not be replaced.")
 ; .D DISPL(.XOBPROP)
 ; .Q
 ; delete
 D DELETE(XOBNAME)
 ; create
 I $$CRSSL(XOBNAME,.XOBPROP) D  Q
 .D BMES^XPDUTL(" o  '"_XOBNAME_"' SSL Config successfully installed")
 .D DISPL(.XOBPROP)
 .Q
 ;
 D BMES^XPDUTL(" o  '"_XOBNAME_"' SSL Config could not be installed")
 Q
 ;
DISPL(XOBPROP) ; Print out the result
  N XOBW,XOBWI
  W !!,?20,"Configuration Values"
  S XOBWI="" F  S XOBWI=$O(XOBPROP(XOBWI)) Q:XOBWI=""  W !,?10,XOBWI,?30," : ",$G(XOBPROP(XOBWI))
  W !!
  Q 
 ;
EXISTS(XOBWIN,XOBPROP) ; check an existed SSL
 N XOBEXSTS,XOBNAME
 D
 .S XOBNAME=$G(XOBWIN,"encrypt_only"),XOBEXSTS=0
 .; change to %SYS namespace then revert upon finishing
 .N $NAMESPACE ;Push current namespace onto the stack
 .S $NAMESPACE="%SYS" ;Change namespace, revert back upon "Q"
  .; Check if SSL configuration exists
 .S XOBEXSTS=##class(Security.SSLConfigs).Get(XOBNAME,.XOBPROP)
 .Q
 Q $G(XOBEXSTS)
 ;
CRSSL(XOBWIN,XOBPROP) ; create a new SSL
 N XOBSTAT,XOBNAME
 DO
 .N XOBCONFG,XOBPROP2,XOBSTAT2
 .S XOBNAME=$G(XOBWIN,"encrypt_only"),XOBSTAT=0
 .; change to %SYS namespace then revert upon finishing
 .N $NAMESPACE ;Push current namespace onto the stack
 .S $NAMESPACE="%SYS" ;Change namespace, revert back upon "Q"
 .S XOBPROP2("Description")="Patch XOBW*1*4"
 .S XOBPROP2("Enabled")=1
 .S XOBPROP2("Protocols")=2
 .S XOBCONFG=##class(Security.SSLConfigs).%New()
 .S XOBSTAT=XOBCONFG.Create(XOBNAME,.XOBPROP2)
 .; get complete set of properties
 .S XOBSTAT2=##class(Security.SSLConfigs).Get(XOBNAME,.XOBPROP)
 .Q
 Q $G(XOBSTAT)
 ;
CHCKEXST(XOBNAME) ;check and display an SSL
 N XOBPROP
 S XOBNAME=$G(XOBNAME,"encrypt_only")
 I $$EXISTS(XOBNAME,.XOBPROP) D  Q
 . D DISPL(.XOBPROP)
 D BMES^XPDUTL(" >>>>  '"_XOBNAME_"' SSL Config doesn't exist.")
 D BMES^XPDUTL("")
 Q
DELETE(XOBWIN) ; delete an existing SSL configuration
 N XOBNAME,XOBSTAT
 D
 .S XOBNAME=$G(XOBWIN,"encrypt_only")
 .; change to %SYS namespace then revert upon finishing
 .N $NAMESPACE ;Push current namespace onto the stack
 .S $NAMESPACE="%SYS" ;Change namespace, revert back upon "Q"
  .; Check if SSL configuration exists
 .S XOBSTAT=##class(Security.SSLConfigs).Delete(XOBNAME)
 .Q
 Q
