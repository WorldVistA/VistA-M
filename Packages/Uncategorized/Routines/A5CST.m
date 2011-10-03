A5CST ;SLC/STAFF-SITE TRACKING SEND UPDATE TO SERVER ;3/15/93  08:53
 ;;1.0;Site Tracking Update;;Mar 12, 1993
 ;
PAC(PKG,VER) ; from package init (A5CSTBUL installs code to call this routine)
 ; Compatable with Fileman Version 18 or greater
 ; PKG = $T(IXF) of the INIT routine.
 ; VER is an array that is contained in DIFROM from the INIT routine
 ;
 ; This routine is called using the following code in the INIT routine:
 ; <tab>I DIFROM S X="A5CST" X ^%ZOSF("TEST") D:$T PAC^A5CST($T(IXF),.DIFROM)
 ; The code preceeds the line containing: =DIFROM G Q^DIFROM
 ; ** and make sure that you send this routine out with the package **
 ;
 N DATE,DIFROM,DOMAIN,NOW,PACKAGE,RUN,SERVER,SITE,START,XMDUZ,XMSUB,XMTEXT,XMY,Y K ^TMP("A5CSTS",$J)
 ;
 ; Site tracking updates only occur if run in a VA production primary domain
 ; account and having a domain for FORUM
 I $G(^XMB("NAME"))'[".VA.GOV" Q
 X ^%ZOSF("UCI") I Y'=^%ZOSF("PROD") Q
 I $L($G(^XMB("NAME")),".")>3 Q
 S DOMAIN=$O(^DIC(4.2,"B","FORUM")) I DOMAIN'["FORUM." Q
 ;
 S SERVER="S.A5CSTS@"_DOMAIN
 S PACKAGE=$P($P(PKG,";",3),U)
 S SITE=$G(^XMB("NAME"))
 S START=$P($G(^DIC(9.4,VER(0),"PRE")),U,2) I '$L(START) S START="Unknown"
 S NOW=$$HTFM^XLFDT($H)
 S RUN="Unknown" I START S RUN=$$FMDIFF^XLFDT(NOW,START,3)
 S START=$$FMTE^XLFDT(START)
 S DATE=NOW\1
 S NOW=$$FMTE^XLFDT(NOW)
 ;
 ; Message for server
 S ^TMP("A5CSTS",$J,1,0)="PACKAGE INSTALL"
 S ^TMP("A5CSTS",$J,2,0)="SITE: "_SITE
 S ^TMP("A5CSTS",$J,3,0)="PACKAGE: "_PACKAGE
 S ^TMP("A5CSTS",$J,4,0)="VERSION: "_VER
 S ^TMP("A5CSTS",$J,5,0)="Start time: "_START
 S ^TMP("A5CSTS",$J,6,0)="Completion time: "_NOW
 S ^TMP("A5CSTS",$J,7,0)="Run time: "_RUN
 S ^TMP("A5CSTS",$J,8,0)="DATE: "_DATE
 ;
 ; Data is sent to server on ISC-SLC - S.A5CSTS
 S XMY(SERVER)="",XMDUZ=.5,XMTEXT="^TMP(""A5CSTS"",$J,",XMSUB=PACKAGE_" VERSION "_VER_" INSTALLATION"
 D ^XMD
 K ^TMP("A5CSTS",$J)
 Q
