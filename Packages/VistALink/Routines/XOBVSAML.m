XOBVSAML ;ALB/WPB - RPC to validate VistA Log on using 2FA ;6 APR 2017
 ;;1.6;VistALink;**3**;Apr 5, 2017;Build 17
 ;Per VHA Directive 6402, this routine should not be modified
 Q
 ;
SAML(RTN,SAML) ; if new 2FA RPC, XUS ESSO VALIDATE is being called need to parse the string parameter into a temp global and pass that by reference
 N I,IEND,ISTART,ISTOP,DOC
 K RTN
 K ^TMP("SAML_XUS",$J)
 S ISTOP=$L(SAML),IEND=0
 F I=1:1  Q:IEND>ISTOP  D
 . S ISTART=IEND+1
 . S IEND=IEND+200
 . S ^TMP("SAML_XUS",$J,I)=$E(SAML,ISTART,IEND)
 .Q
 S DOC=$NA(^TMP("SAML_XUS",$J))
 D SETUP^XUSRB,GETENV^%ZOSV S XUENV=Y,XUCI=$P(Y,U,1),XQVOL=$P(Y,U,2),XUOSVER=$$VERSION^%ZOSV
 D ESSO^XUESSO4(.RTN,DOC)
 K X,XQVOL,XUCI,XUENV,XUOSVER,Y,^TMP("SAML_XUS",$J)
 Q
