DIFROM7 ;SFISC/(SLC/STAFF)-SITE TRACKING INSTALL BULLETIN ;01:06 PM  23 Aug 1993
 ;;22.0;VA FileMan;;Mar 30, 1999
 ;Per VHA Directive 10-93-142, this routine should not be modified.
SETUP(ROUTINE,STATUS) ;
 K ^TMP($J) N LINE,LINE1,LINE2,NUM,OK,ROUTINIS,TXT
 D LOAD(ROUTINE,"^TMP($J,",0)
 I $P($P(^TMP($J,1,0),";")," ")'?1U1.3UN1"INIT" S STATUS="not changed" Q
 S ROUTINIS=$P(ROUTINE,"INIT")_"INIS"
 S (OK,LINE)=0 F  S LINE=$O(^TMP($J,LINE)) Q:LINE<0  S TXT=^(LINE,0) S:TXT[("PAC^"_ROUTINIS) OK=2 Q:OK=2  I TXT["=DIFROM G Q^DIFROM" S OK=1 Q
 I 'OK S STATUS="not installed" Q
 I OK=1 D
 .S ^TMP($J,LINE-.9,0)=" I DIFROM,$D(^%ZTSK) S X="""_ROUTINIS_""" X ^%ZOSF(""TEST"") D:$T PAC^"_ROUTINIS_"($T(IXF),.DIFROM)"
 .D SAVE(ROUTINE,"^TMP($J,",0)
 .S STATUS="site tracking installed"
 I OK=2 S STATUS="already installed"
 S LINE1=ROUTINIS_$P(^TMP($J,1,0),ROUTINE,2,99),LINE2=^TMP($J,2,0) K ^TMP($J)
 S ^TMP($J,1,0)=LINE1,^TMP($J,2,0)=LINE2
 F NUM=3:1 S LINE=$P($T(NMSPINIS+NUM),";",3,99) Q:LINE=""  D
 .I LINE["@@@@@@" S LINE=$P(LINE,"@@@@@@")_ROUTINIS_$P(LINE,"@@@@@@",2)
 .S ^TMP($J,NUM,0)=LINE
 D SAVE(ROUTINIS,"^TMP($J,",0)
 S STATUS=STATUS_" -- "_ROUTINIS_" saved"
 K ^TMP($J)
 Q
LOAD(X,DIF,XCNP) X ^%ZOSF("LOAD")
 Q
SAVE(X,DIE,XCN) X ^%ZOSF("SAVE")
 Q
NMSPINIS ;;
 ;;
 ;;
 ;;PAC(PKG,VER) ; called from package init (DIFROM7 created this routine)
 ;; ; PKG = $T(IXF) of the INIT routine.
 ;; ; VER is an array that is contained in DIFROM from the INIT routine
 ;; ;
 ;; N %,%I,%H,DATE,DIFROM,NOW,PACKAGE,RUN,SERVER,SITE,START,X,XMDUZ,XMSUB,XMTEXT,XMY,Y K ^TMP("@@@@@@",$J)
 ;; ;
 ;; ; Site tracking updates only occur if run in a VA production primary domain
 ;; ; account.
 ;; I $G(^XMB("NETNAME"))'[".VA.GOV" Q
 ;; Q:'$D(^%ZOSF("UCI"))  Q:'$D(^%ZOSF("PROD"))
 ;; X ^%ZOSF("UCI") I Y'=^%ZOSF("PROD") Q
 ;; ;
 ;; S SERVER="S.A5CSTS@FORUM.VA.GOV"
 ;; S PACKAGE=$P($P(PKG,";",3),U)
 ;; S SITE=$G(^XMB("NETNAME"))
 ;; S START=$P($G(^DIC(9.4,VER(0),"PRE")),U,2) I '$L(START) S START="Unknown"
 ;; D  ; check if ok to use kernel functions
 ;; .S X="XLFDT" X ^%ZOSF("TEST") I $T D  Q
 ;; ..S NOW=$$HTFM^XLFDT($H)
 ;; ..S RUN="Unknown" I START S RUN=$$FMDIFF^XLFDT(NOW,START,3)
 ;; ..S START=$$FMTE^XLFDT(START)
 ;; ..S DATE=NOW\1
 ;; ..S NOW=$$FMTE^XLFDT(NOW)
 ;; .D NOW^%DTC S NOW=%,DATE=X
 ;; .S RUN="" ; don't bother to compute
 ;; .S Y=START D DD^%DT S START=Y
 ;; .S Y=NOW D DD^%DT S NOW=Y
 ;; ;
 ;; ; Message for server
 ;; S ^TMP("@@@@@@",$J,1,0)="PACKAGE INSTALL"
 ;; S ^TMP("@@@@@@",$J,2,0)="SITE: "_SITE
 ;; S ^TMP("@@@@@@",$J,3,0)="PACKAGE: "_PACKAGE
 ;; S ^TMP("@@@@@@",$J,4,0)="VERSION: "_VER
 ;; S ^TMP("@@@@@@",$J,5,0)="Start time: "_START
 ;; S ^TMP("@@@@@@",$J,6,0)="Completion time: "_NOW
 ;; S ^TMP("@@@@@@",$J,7,0)="Run time: "_RUN
 ;; S ^TMP("@@@@@@",$J,8,0)="DATE: "_DATE
 ;; ;
 ;; ; Data is sent to server on FORUM - S.A5CSTS
 ;; S XMY(SERVER)="",XMDUZ=.5,XMTEXT="^TMP(""@@@@@@"",$J,",XMSUB=PACKAGE_" VERSION "_VER_" INSTALLATION"
 ;; D ^XMD
 ;; K ^TMP("@@@@@@",$J)
 ;; Q
 ;;
