GMRCSTLM ;SLC/DCM,dee,MA - List Manager Format Routine - Get Active Consults by service - pending,active,scheduled,incomplete,etc. ;11/21/02  05:29
 ;;3.0;CONSULT/REQUEST TRACKING;**1,7,21,23,22,29,63**;DEC 27, 1997;Build 10
 ; Patch #21 added a initialization KILL for ^TMP("GMRCTOT",$J)
 ; Patch #23 remove the default prompt "ALL SERVICES"
 Q
 ;
EN ;Ask for new service and date range
 K GMRCQUT
 N DIROUT,DTOUT,DUOUT,DIR
 ;
 ;Ask for service
 N Y
 S DIR(0)="PO^123.5:EMQ",DIR("??")="^D LISTALL^GMRCASV"
 S DIR("A")="Select Service/Specialty"
 D ^DIR
 I Y<1 S VALMBCK="Q" Q
 S GMRCDG=+Y,GMRCSVNM=$P(Y,U,2)
 D SERV1^GMRCASV
 I '$O(^TMP("GMRCSLIST",$J,0)) S VALMBCK="Q" Q 
 ;
 ;Ask for date range
 D ^GMRCSPD
 I $D(GMRCQUT) S VALMBCK="Q" G EXIT
 D LISTDATE^GMRCSTU1(GMRCDT1,GMRCDT2,.GMRCEDT1,.GMRCEDT2)
 Q
 ;
ENOR(RETURN,GMRCSVC,GMRCDT1,GMRCDT2,GMRCSTAT,GMRCCTRL,GMRCARRN) ;Entry point for GUI interface.
 ;.RETURN:   This is the root to the returned temp array.
 ;GMRCSVC:  Service for which consults are to be displayed.
 ;GMRCDT1:  Starting date or "ALL"
 ;GMRCDT2:  Ending date if not GMRCDT1="ALL"
 ;GMRCSTAT: The list of status to include separated by commas
 ;GMRCCTRL:   0, null or not define then just the display list is 
 ;                displayed
 ;            1 then the list will be two pieces with the first piece 
 ;                being the ien of the consult for selection in the gui
 ;                and the second piece being the display text.
 ;           10 then the consults will have a line number on them for
 ;                selection
 ;           20 then the consults will have the consult number displayed
 ;          100 then use abbreviations for the statuses
 ;      1, (10 or 20) and 100 can be added together to add there features
 ;GMRCARRN: List Template Array Name
 ;          "CP": pending; "IFC": inter-facility
 ;
 ;This temp array is used internally by the report:
 ;^TMP("GMRCSLIST",$J,n)=ien^name^parient ien^"+" if grouper^status
 ;  status is "" tracking and/or grouper
 ;            1  grouper only
 ;            2  tracking only
 ;            9  disabled
 ;
 N GMRCEDT1,GMRCEDT2,GMRCDG,GMRCHEAD,GMRCCT,GMRCGRP,VALMCNT,VALMBCK
 K ^TMP("GMRCR",$J,GMRCARRN)
 S RETURN="^TMP(""GMRCR"",$J,GMRCARRN)"
 I '($D(GMRCSVC)#2) S GMRCSVC=1
 Q:'$D(^GMR(123.5,$G(GMRCSVC),0))
 ;Build service array
 S GMRCDG=GMRCSVC
 D SERV1^GMRCASV
 ;Get external form of date range
 I '($D(GMRCDT1)#2) S GMRCDT1="ALL"
 S:GMRCDT1="ALL" GMRCDT2=0
 D LISTDATE^GMRCSTU1(GMRCDT1,$G(GMRCDT2),.GMRCEDT1,.GMRCEDT2)
 G ENORSTR
 ;
ENORLM(GMRCARRN) ;Entry point for List Manager interface.
 ; Input -- GMRCARRN  List Template Array Name
 ;          "CP": pending; "IFC": inter-facility
 ; Output - None
 D WAIT^DICD
 ;
ENORSTR ;Common part
 N GMRCDA,NUMCLIN,INDEX,STATUS,LOOP,GROUPER
 N STS,GMRCD,GMRCDT,GMRCSVCG,TEMP
 N GMRCPT,CTRLTEMP,LINETEMP,GMRCLINE
 N GMRCPTN,GMRCPTSN,GMRCDLA,GMRCXDT,GMRCLOC,GMRCSVCP
 N GRP,GMRCIRF,GMRCIRFN,GMRCIDD,GMRCST,GMRCRDT,CNT,IDX
 S:'$D(GMRCARRN) GMRCARRN="CP"
 ;
 ; Patch #21 added the kill for ^TMP("GMRCTOT",$J)
 K ^TMP("GMRCR",$J,GMRCARRN),^TMP("GMRCRINDEX",$J),^TMP("GMRCTOT",$J),^TMP("GMRCT",$J)
 K ^TMP("GMRCTOTX",$J),GMRCCNSLT
 ;
 S CNT=0
 S GMRCCT=0
 S NUMCLIN=0
 S GMRCLINE=0
 S GROUPER=0
 S GROUPER(0)=0
 S GMRCCT=GMRCCT+1
 I '($D(GMRCCTRL)#2) S GMRCCTRL=0 ;default to just the list
 S CTRLTEMP=$S(GMRCCTRL#2:"^",1:"")
 I GMRCARRN="IFC" D
 .S ^TMP("GMRCR",$J,GMRCARRN,GMRCCT,0)=CTRLTEMP_$J("",18)_"IF Consult/Request By Status - "_$S(GMRCIS="R":"Requesting",1:"Consulting")_" Site"
 E  D
 .S ^TMP("GMRCR",$J,GMRCARRN,GMRCCT,0)=CTRLTEMP_$J("",28)_"Consult/Request By Status"
 S GMRCCT=GMRCCT+1
 S TEMP="FROM: "_GMRCEDT1_"   TO: "_GMRCEDT2
 S ^TMP("GMRCR",$J,GMRCARRN,GMRCCT,0)=CTRLTEMP_$J("",40-($L(TEMP)/2)+.5)_TEMP
 I GMRCARRN="IFC",$D(GMRCRF),$D(GMRCREMP) D
 .S GMRCCT=GMRCCT+1
 .S ^TMP("GMRCR",$J,GMRCARRN,GMRCCT,0)=CTRLTEMP_"Routing Facility - "_$$GET1^DIQ(4,GMRCRF,.01)
 .S GMRCCT=GMRCCT+1
 .S ^TMP("GMRCR",$J,GMRCARRN,GMRCCT,0)=CTRLTEMP_"Remote Ordering Provider - "_GMRCREMP
 I GMRCCTRL=120 D
 .S GMRCCT=GMRCCT+1
 .S ^TMP("GMRCR",$J,GMRCARRN,GMRCCT,0)=CTRLTEMP
 .S GMRCCT=GMRCCT+1
 .S ^TMP("GMRCR",$J,GMRCARRN,GMRCCT,0)="   Number St   Last Action         Req Dt   Patient Name            Patient Location"_$S(GMRCARRN="IFC":"         Routing Facility  Days Diff"_$S(GMRCIS="C":"  Rec Dt",1:""),1:"")
 ;
 I '($D(GMRCSVC)#2) S GMRCSVC=1
 I '($D(GMRCDT1)#2) S GMRCDT1="ALL",GMRCDT2=0
 I '($D(GMRCDT2)#2) S GMRCDT2=""
 I '($D(GMRCSTAT)#2),GMRCARRN="CP" S GMRCSTAT="3,4,5,6,8,9,11,99" ;pending consults
 I '($D(GMRCSTAT)#2),GMRCARRN="IFC"  S GMRCSTAT="1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,99"
 ;
CAPTION ;Set the List Mangager Caption Line
 ; Does GMRCCTRL contain 10 i.e. display line numbers
 ;                    or 20 i.e. display consult number
 I $G(VALMAR)="^TMP(""GMRCR"",$J,""CP"")"!($G(VALMAR)="^TMP(""GMRCR"",$J,""IFC"")") D
 .I GMRCCTRL#100\10 D
 ..I GMRCCTRL#100\10=1 D
 ...; Does GMRCCTRL contain 100 i.e. use abbreviations for the statuses
 ...I GMRCCTRL#1000\100 D CHGCAP^VALM("CAPTION LINE","     St    Last Action   Request Date  Patient Name         Pt Location")
 ...; Do not use abbreviations for the statuses
 ...E  D CHGCAP^VALM("CAPTION LINE","     Status      Last Action   Request Date  Patient Name         Pt Location")
 ..; Do not display consult number
 ..E  D
 ...; Does GMRCCTRL contain 100 i.e. use abbreviations for the statuses
 ...I GMRCCTRL#1000\100 D CHGCAP^VALM("CAPTION LINE"," Number   St    Last Action   Request Date  Patient Name         Pt Location")
 ...; Do not use abbreviations for the statuses
 ...E  D CHGCAP^VALM("CAPTION LINE"," Number   Status      Last Action   Request Date  Patient Name         Pt Location")
 .E  D
 ..; Does GMRCCTRL contain 100 i.e. use abbreviations for the statuses
 ..I GMRCCTRL#1000\100 D CHGCAP^VALM("CAPTION LINE","St    Last Action   Request Date  Patient Name         Pt Location")
 ..; Do not use abbreviations for the statuses
 ..E  D CHGCAP^VALM("CAPTION LINE","Status      Last Action      Request Date  Patient Name      Pt Location")
 .I GMRCARRN="IFC" D
 ..D CHGCAP^VALM("CAPTION LINE 1","Routing Facility  Days Diff"_$S(GMRCIS="C":"  Rec Date",1:""))
 ;Set screen width
 S VALM("RM")=$S(GMRCARRN="CP":$$CWIDTH^GMRCPC(GMRCCTRL),1:$$CWIDTH^GMRCIR(GMRCCTRL))
 ;
 S GMRCHEAD=$P($G(^TMP("GMRCSLIST",$J,+$O(^TMP("GMRCSLIST",$J,"")))),"^",2)
 S INDEX=""
SVC ;Loop on Service
 F  S INDEX=$O(^TMP("GMRCSLIST",$J,INDEX)) Q:INDEX=""  D
 .S GMRCSVC=$P(^TMP("GMRCSLIST",$J,INDEX),"^",1)
 .S GMRCSVCP=$P(^TMP("GMRCSLIST",$J,INDEX),"^",2)
 .S GMRCSVCG=$P(^TMP("GMRCSLIST",$J,INDEX),"^",3)
 .S ^TMP("GMRCTOT",$J,1,GMRCSVC,"T")=0
 .S ^TMP("GMRCTOT",$J,1,GMRCSVC,"P")=0
 .S ^TMP("GMRCTOT",$J,2,GMRCSVC,"T")=0
 .S ^TMP("GMRCTOT",$J,2,GMRCSVC,"P")=0
 .I GMRCARRN="IFC" D
 ..S GMRCST(1,GMRCSVC)="0^0"
 ..S GMRCST(2,GMRCSVC)="0^0"
GROUPER .;Check if starting a new Grouper
 .F  Q:GROUPER(GROUPER)=GMRCSVCG  D
 ..;End of a group so print the group totals
 ..D LISTTOT^GMRCSTL1(.GMRCCT,2,GROUPER(GROUPER),$P(^GMR(123.5,GROUPER(GROUPER),0),"^",1),"",GMRCCTRL,GMRCARRN)
 ..;pop grouper from stack
 ..S GROUPER=GROUPER-1
 .I $P(^TMP("GMRCSLIST",$J,INDEX),"^",4)="+" D
 ..;Start of a new group so print the group heading.
 ..S GMRCCT=GMRCCT+1
 ..S ^TMP("GMRCR",$J,GMRCARRN,GMRCCT,0)=CTRLTEMP
 ..S GMRCCT=GMRCCT+1
 ..S TEMP="GROUPER: "_GMRCSVCP
 ..S:GMRCSVCG>0 TEMP=TEMP_"  in Group: "_$P(^GMR(123.5,GMRCSVCG,0),"^",1)
 ..S ^TMP("GMRCR",$J,GMRCARRN,GMRCCT,0)=CTRLTEMP_$J("",40-(($L(TEMP)/2)+.5))_TEMP
 ..;push new grouper on stack
 ..S GROUPER=GROUPER+1
 ..S GROUPER(GROUPER)=GMRCSVC
STAT .;Loop for one status at a time
 .F LOOP=1:1:$L(GMRCSTAT,",") S STATUS=$P(GMRCSTAT,",",LOOP) D ONESTAT^GMRCSTL2(GMRCARRN)
 .F GRP=GROUPER:-1:1 D
 ..;  pending for this service to all of its groupers
 ..I $D(^TMP("GMRCTOTX",$J,GROUPER(GRP),GMRCSVC,"P")) Q
 ..S ^TMP("GMRCTOT",$J,2,GROUPER(GRP),"P")=$G(^TMP("GMRCTOT",$J,2,GROUPER(GRP),"P"))+^TMP("GMRCTOT",$J,1,GMRCSVC,"P")
 ..S ^TMP("GMRCTOTX",$J,GROUPER(GRP),GMRCSVC,"P")=""
 ..I $D(^TMP("GMRCTOTX",$J,GROUPER(GRP),GMRCSVC,"T")) Q
 ..S ^TMP("GMRCTOT",$J,2,GROUPER(GRP),"T")=$G(^TMP("GMRCTOT",$J,2,GROUPER(GRP),"T"))+^TMP("GMRCTOT",$J,1,GMRCSVC,"T")
 ..S ^TMP("GMRCTOTX",$J,GROUPER(GRP),GMRCSVC,"T")=""
 ..;IF Consults
 ..I GMRCARRN="IFC" S GMRCIRFN="" F  S GMRCIRFN=$O(^TMP("GMRCTOT",$J,1,GMRCSVC,"F",GMRCIRFN)) Q:GMRCIRFN=""  D
 ...I '$D(^TMP("GMRCTOT",$J,2,GROUPER(GRP),"F",GMRCIRFN)) D
 ....S ^TMP("GMRCTOT",$J,2,GROUPER(GRP),"F",GMRCIRFN)=0
 ....S GMRCST(2,GROUPER(GRP),GMRCIRFN)="0^0"
 ...S ^TMP("GMRCTOT",$J,2,GROUPER(GRP),"F",GMRCIRFN)=$G(^TMP("GMRCTOT",$J,2,GROUPER(GRP),"F",GMRCIRFN))+^TMP("GMRCTOT",$J,1,GMRCSVC,"F",GMRCIRFN)
 ...I +$P(GMRCST(1,GMRCSVC,GMRCIRFN),"^",2)>0 D
 ....S $P(GMRCST(2,GROUPER(GRP),GMRCIRFN),"^")=($P(GMRCST(2,GROUPER(GRP)),"^"))+($P(GMRCST(1,GMRCSVC,GMRCIRFN),"^"))
 ....S $P(GMRCST(2,GROUPER(GRP),GMRCIRFN),"^",2)=($P(GMRCST(2,GROUPER(GRP),GMRCIRFN),"^",2))+($P(GMRCST(1,GMRCSVC,GMRCIRFN),"^",2))
 ..I GMRCARRN="IFC" D
 ...S $P(GMRCST(2,GROUPER(GRP)),"^")=($P(GMRCST(2,GROUPER(GRP)),"^"))+($P(GMRCST(1,GMRCSVC),"^"))
 ...S $P(GMRCST(2,GROUPER(GRP)),"^",2)=($P(GMRCST(2,GROUPER(GRP)),"^",2))+($P(GMRCST(1,GMRCSVC),"^",2))
 .;
PRINTST .;Print the totals for this service that are >0
 .S GMRCSVNM=GMRCHEAD
 .I ^TMP("GMRCTOT",$J,1,GMRCSVC,"T")>0 D LISTTOT^GMRCSTL1(.GMRCCT,1,GMRCSVC,GMRCSVCP,$P($G(^GMR(123.5,GMRCSVCG,0)),"^",1),GMRCCTRL,GMRCARRN)
 .I ^TMP("GMRCTOT",$J,1,GMRCSVC,"T")=0,GMRCSVNM'="ALL SERVICES" D 
 ..S GMRCCT=GMRCCT+1
 ..S ^TMP("GMRCR",$J,GMRCARRN,GMRCCT,0)=CTRLTEMP
 ..S GMRCCT=GMRCCT+1
 ..S TEMP="SERVICE: "_GMRCSVCP
 ..S:GMRCSVCG>0 TEMP=TEMP_" in Group: "_$P(^GMR(123.5,GMRCSVCG,0),"^",1)
 ..S ^TMP("GMRCR",$J,GMRCARRN,GMRCCT,0)=CTRLTEMP_TEMP
 ..S NUMCLIN=NUMCLIN+1
 ..D LISTTOT^GMRCSTL1(.GMRCCT,1,GMRCSVC,GMRCSVCP,$P($G(^GMR(123.5,GMRCSVCG,0)),"^",1),GMRCCTRL,GMRCARRN)
 .I ^TMP("GMRCTOT",$J,1,GMRCSVC,"T")=0,GMRCSVNM="ALL SERVICES" D
 ..S CNT=CNT+1
 ..S ^TMP("GMRCT",$J,0,GMRCSVC)=""
 ;
 ;Done so
 ;Now list the group totals for the current groups
 F GROUPER=GROUPER:-1:1 D
 .D LISTTOT^GMRCSTL1(.GMRCCT,2,GROUPER(GROUPER),$P(^GMR(123.5,GROUPER(GROUPER),0),"^",1),"",GMRCCTRL,GMRCARRN)
 ;
 I CNT D
 .S GMRCCT=GMRCCT+1
 .S ^TMP("GMRCR",$J,GMRCARRN,GMRCCT,0)=CTRLTEMP,GMRCCT=GMRCCT+1
 .S ^TMP("GMRCR",$J,GMRCARRN,GMRCCT,0)=CTRLTEMP_"The following Consult Services had zero requests for the specified date range:",GMRCCT=GMRCCT+1
 .S ^TMP("GMRCR",$J,GMRCARRN,GMRCCT,0)=CTRLTEMP,GMRCCT=GMRCCT+1
 .S IDX="" F  S IDX=$O(^TMP("GMRCT",$J,0,IDX)) Q:IDX=""  D
 ..I $P(^GMR(123.5,IDX,0),U,2)=1 Q  ;don't add to list if service is a grouper only...
 ..S ^TMP("GMRCR",$J,GMRCARRN,GMRCCT,0)=CTRLTEMP_$P(^GMR(123.5,IDX,0),U,1),GMRCCT=GMRCCT+1
 ;
 S VALMCNT=$O(^TMP("GMRCR",$J,GMRCARRN," "),-1)
 I $D(IOBM),$D(IOTM) S VALMBCK="R"
EXIT Q
 ;
