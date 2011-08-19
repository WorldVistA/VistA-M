GMRCIR ;SLC/JAK - IFC Request data & statistics ;03/05/02 08:20
 ;;3.0;CONSULT/REQUEST TRACKING;**22**;DEC 27, 1997
EN ; -- main entry point for GMRC IF CONSULTS
 K GMRCSVC,GMRCSVCP
 N GMRCCK,GMRCDG,GMRCIS,GMRCSTAT
 N GMRCDT1,GMRCDT2,GMRCEDT1,GMRCEDT2
 I $D(GMRCREMP),$D(GMRCRF) D
 .I '$D(^GMR(123,"AIP")) D
 ..W !!,$C(7),"No entries with Remote Ordering Provider data.",!
 ..S GMRCQUT=1
 .E  D
 ..N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 ..S DIR(0)="PO^4:EMQ"
 ..S DIR("S")="I $$STA^XUAF4(+Y)=+$$STA^XUAF4(+Y)"
 ..S DIR("A")="Select Requesting site"
 ..D ^DIR I $D(DIRUT) S GMRCQUT=1 Q
 ..S GMRCRF=+Y
 ..W !
 ..N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 ..S DIR(0)="FO^2:40^D UP^GMRCA2 K:'$D(^GMR(123,""AIP"",X)) X"
 ..S DIR("?")="^D HELPR^GMRCIR"
 ..S DIR("A",1)="   Enter the ENTIRE name in proper CASE, exactly as it"
 ..S DIR("A",2)="   appears in the list (including any credentials)."
 ..S DIR("A",3)="   Use copy/paste to avoid typing errors."
 ..S DIR("A",4)="   NO partial matches are done."
 ..S DIR("A",5)="   Enter ? to display a list of possible entries."
 ..S DIR("A")="Select Remote Ordering Provider"
 ..D ^DIR I $D(DIRUT) S GMRCQUT=1 Q
 ..D UP^GMRCA2 S Y=X,GMRCREMP=Y
 .S GMRCIS="C"
 E  D
 .N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 .S DIR(0)="SB^R:REQUESTING;C:CONSULTING"
 .S DIR("A")="Are you the Requesting site or the Consulting site"
 .D ^DIR I $D(DIRUT) S GMRCQUT=1 Q
 .S GMRCIS=Y
 I $D(GMRCQUT) D EXIT Q
 ;Get the statuses
 S GMRCSTAT=$$STS^GMRCPC1
 I $D(GMRCQUT) D EXIT Q
 I $D(GMRCEACT),$L(GMRCEACT) D  I '$D(^GMR(123.5,$G(GMRCSVC),0)) D EXIT Q
 .S GMRCSVCP=GMRCEACT
 .S GMRCSVC=$O(^GMR(123.5,"B",GMRCSVCP,0))
 .Q:'$D(^GMR(123.5,$G(GMRCSVC),0))
 .;Build service array
 .S GMRCDG=GMRCSVC
 .D SERV1^GMRCASV
 .;Set date range to ALL
 .S GMRCDT1="ALL"
 .S GMRCDT2=0
 .D LISTDATE^GMRCSTU1(GMRCDT1,GMRCDT2,.GMRCEDT1,.GMRCEDT2)
 ;If no service ask for one
 I '$L($G(GMRCSVC)) D EN^GMRCSTLM I $D(GMRCQUT) D EXIT Q
 ;Quit if no array of services
 I '$O(^TMP("GMRCSLIST",$J,0)) S GMRCQUT=1 D EXIT Q
 ;
 D EN^VALM("GMRC IF CONSULTS")
 Q
 ;
HDR ; -- header code
 Q:$D(GMRCQUT)!'$D(GMRCCT)
 S VALMHDR(1)="IFC Requests: "_$S(GMRCIS="R":"Requesting",1:"Consulting")_" Site"
 S VALMHDR(2)="Service: "_GMRCHEAD
 S VALMHDR(3)="From: "_$G(GMRCEDT1)_"   To: "_$G(GMRCEDT2)
 I $G(GMRCCTRL)=1 S VALMCAP="     "_VALMCAP
 Q
 ;
HELP ; -- help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ; -- exit code
 K CNT,CTRLCOL,GMRCCT,GMRCQUT,GMRCSVC,GMRCSVCP,VALMHDR
 K GMRCEDT1,GMRCEDT2,GMRCSVNM
 K GMRCCTRL,GMRCSTAT,GMRCARRN
 K ^TMP("GMRCS",$J),^TMP("GMRCSLIST",$J),^TMP("GMRCR",$J,"IFC"),^TMP("GMRCRINDEX",$J),^TMP("GMRCTOT",$J)
 Q
 ;
EXPND ; -- expand code
 Q
 ;
CWIDTH(GMRCCTRL) ;Prints a message about how wide the report is.
 N WIDTH
 S WIDTH=128
 I GMRCCTRL#100\10 D
 .I GMRCCTRL#100\10=1 S WIDTH=WIDTH+5
 .E  S WIDTH=WIDTH+10
 I GMRCCTRL#1000\100 S WIDTH=WIDTH-6
 Q WIDTH
 ;
PWIDTH(GMRCCTRL) ;Prints a message about how wide the report is.
 W !!,"This print out is "_$$CWIDTH(GMRCCTRL)_" columns wide."
 Q
 ;
HELPR ;Help for Remote Ordering Provider prompt
 N GMRCRP,GMRCQUT
 S GMRCRP=""
 W @IOF
 F  S GMRCRP=$O(^GMR(123,"AIP",GMRCRP)) Q:GMRCRP=""!$D(GMRCQUT)  D
 .W GMRCRP,!
 .I $Y>(IOSL-4) N X,Y D  W:Y @IOF I 'Y S GMRCQUT=1 Q
 ..N DIR,DIROUT,DIRUT,DTOUT,DUOUT
 ..S DIR(0)="E" D ^DIR
 I $D(GMRCQUT) Q
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 S DIR(0)="E",DIR("A")="Enter RETURN or '^' to exit" D ^DIR
 Q
 ;
DESC ;Displays Description from Option file
 N GMRCDESC,GMRCNUM,GMRCOPT,GMRCOPTN,GMRCQUT
 S GMRCNUM=""
 S GMRCOPTN="GMRC IFC RPT CONSULTS"
 S GMRCOPT=$$FIND1^DIC(19,"","X",GMRCOPTN)
 I 'GMRCOPT Q
 S GMRCDESC=$$GET1^DIQ(19,GMRCOPT,3.5,"","GMRCDESC") ; DBIA #10075
 I '$O(GMRCDESC(0)) Q
 W @IOF F  S GMRCNUM=$O(GMRCDESC(GMRCNUM)) Q:GMRCNUM=""!$D(GMRCQUT)  D
 .W GMRCDESC(GMRCNUM),!
 .I $Y>(IOSL-4) N X,Y D  W:+Y @IOF I '+Y S GMRCQUT=1 Q
 ..N DIR,DIROUT,DIRUT,DTOUT,DUOUT
 ..S DIR(0)="E" D ^DIR
 I $D(GMRCQUT) Q
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 S DIR(0)="E",DIR("A")="Enter RETURN or '^' to exit" D ^DIR
 Q
 ;
PRNTONLY(GMRCCTRL) ;Option to just send the report to a device.
 N GMRCQUT,RETURN,GMRCDG,GMRCSTAT,VALMBCK
 N GMRCDT1,GMRCDT2,GMRCEDT1,GMRCEDT2
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,GMRCIS,GMRCCK,X,Y
 S DIR(0)="SB^R:REQUESTING;C:CONSULTING"
 S DIR("A")="Are you the Requesting site or the Consulting site"
 D ^DIR Q:$D(DIRUT)  S GMRCIS=Y
 ;Get the statuses
 S GMRCSTAT=$$STS^GMRCPC1
 I $D(GMRCQUT) D EXIT Q
 ;Get the service and date range.
 D EN^GMRCSTLM
 I $D(GMRCQUT) D EXIT Q
 ;Quit if no array of services
 I '$O(^TMP("GMRCSLIST",$J,0)) S GMRCQUT=1 D EXIT Q
 I '($D(GMRCCTRL)#2) S GMRCCTRL=0 ; default to just the list
 ;Get description?
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 S DIR(0)="Y",DIR("B")="NO"
 S DIR("A")="Want to view a description of the data for this report now"
 D ^DIR I $D(DIRUT) D EXIT Q
 I Y>0 D DESC
 D PWIDTH(GMRCCTRL)
 ;Get the device
 D PRNTASK^GMRCSTU
 I $D(GMRCQUT) D EXIT Q
 ;Save some things if the report is queued
 I $D(IO("Q")) D
 .S ZTSAVE("GMRCCTRL")=""
 .S ZTSAVE("GMRCIS")=""
 .S ZTSAVE("GMRCSTAT")=""
 ;Create the report if not queued
 E  D ENOR^GMRCSTLM(.RETURN,GMRCDG,GMRCDT1,GMRCDT2,GMRCSTAT,GMRCCTRL,"IFC")
 ;Print the report
 D PRNTIT^GMRCSTU("IFC","PRNTQ^GMRCIR","CONSULT/REQUEST PACKAGE PRINT INTER-FACILITY CONSULT REQUESTS FROM OPTION")
 D EXIT
 Q
 ;
PRNTQ ;Print Queued report from ^TMP global then kill off ^TMP & ^XTMP
 ;Create the report
 N RETURN,INDEX
 D ENOR^GMRCSTLM(.RETURN,GMRCDG,GMRCDT1,GMRCDT2,GMRCSTAT,GMRCCTRL,"IFC")
 U IO
 S INDEX=""
 F  S INDEX=$O(^TMP("GMRCR",$J,TMPNAME,INDEX)) Q:INDEX=""  W ^TMP("GMRCR",$J,TMPNAME,INDEX,0),!
 K ^TMP("GMRCR",$J,TMPNAME),^XTMP("GMRCR",J,DOLLARH,"PRINT"),J,DOLLARH
 D ^%ZISC
 D EXIT
 Q
 ;
