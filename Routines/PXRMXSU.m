PXRMXSU ; SLC/PJH - Reminder Reports DIC Prompts;01/06/2006
 ;;2.0;CLINICAL REMINDERS;**4**;Feb 04, 2005;Build 21
 ;
 ;Called by PXRMXD
 ;
 ;Exits from SEL subroutine
QUIT() I $D(DTOUT)!$D(DUOUT) Q 1
 ;Only one entry allowed
 I ONE="D",(CNT>0) Q 1
 ;Mandatory entry
 I Y=-1,(CHECK=3)!(CNT>0) Q 1
 ;Categories may already contain reminders
 I Y=-1,CHECK=2,$D(REMCAT) Q 1
 ;Otherwise
 Q 0
 ;
 ;Repeated Prompt using DIC
 ;-------------------------
SEL(FILE,MODE,CNT,ARRAY,ONE,CHECK) ;
 ;
 ; ONE   = only allows one entry
 ; CHECK = number or null - validation of facility
 ;
 N X,Y,ARRAYN
 K DIROUT,DIRUT,DTOUT,DUOUT
 W !
 F  D  Q:$$QUIT
 .S DIC=FILE,DIC(0)=MODE
 .; Set up ^DIC("S") for duplicate check
 .S DIC("S")="I '$D(ARRAYN(+Y))"
 .I CHECK=1 D FACT^PXRMXAP
 .I CHECK=2 S DIC("S")=DIC("S")_",'(+$P(^(0),U,6))"
 .I CHECK=3 S DIC("S")=DIC("S")_",$$OK^PXRMXS1(+Y)"
 .I CHECK=4 S DIC("S")=DIC("S")_",$P($G(^PXRMXP(810.5,+Y,30,0)),U,3)>0"
 .I CHECK=5 S DIC("S")=DIC("S")_",$P($G(^OR(100.21,+Y,10,0)),U,3)>0"
 .I CNT>0 S DIC("A")=LIT
 .D ^DIC
 .I X=(U_U) S DTOUT=1
 .I $D(DTOUT)!$D(DUOUT) Q
 .I +Y'=-1 D  Q
 ..I $D(ARRAYN(+Y)) W !,"Error - Duplicate entry" Q
 ..S CNT=CNT+1,ARRAY(CNT)=Y_U_Y(0,0)_U_$P(Y(0),U,3)
 ..S ARRAYN(+Y)=""
 .I CNT=0,'$$QUIT W !,LIT1
 .K DIC
 Q
 ;
 ;Establish the LOCATION criteria
LOC(ADEF,BDEF) ;
 N X,Y,DIR
LOC0 K DIROUT,DIRUT,DTOUT,DUOUT
 S DIR(0)="S"_U_"HA:All Outpatient Locations;"
 S DIR(0)=DIR(0)_"HAI:All Inpatient Locations;"
 S DIR(0)=DIR(0)_"HS:Selected Hospital Locations;"
 S DIR(0)=DIR(0)_"CA:All Clinic Stops(with encounters);"
 S DIR(0)=DIR(0)_"CS:Selected Clinic Stops;"
 S DIR(0)=DIR(0)_"GS:Selected Clinic Groups;"
 S DIR("A")=ADEF
 S DIR("B")=BDEF
 S DIR("?")="Select from the codes displayed. For detailed help type ??"
 S DIR("??")=U_"D HELP^PXRMXHLP(8)"
 D ^DIR K DIR
 I $D(DIROUT) S DTOUT=1
 I $D(DTOUT)!($D(DUOUT)) Q
 S PXRMLCSC=Y_U_Y(0)
 ;If locations are to be selected individually get the list.
 I Y="HS" D HLOC Q:$D(DTOUT)  G:$D(DUOUT) LOC0
 I Y="CS" D CSTOP Q:$D(DTOUT)  G:$D(DUOUT) LOC0
 I Y="GS" D CGRP(.PXRMCGRP) Q:$D(DTOUT)  G:$D(DUOUT) LOC0
 Q
 ;
 ;Build a list of hospital locations
HLOC N IEN,SC,X,Y,CHECK
 K DTOUT,DUOUT
 S NHL=0
 S DIC("A")="LOCATION: "
 W !
 F  D  Q:$D(DTOUT)  Q:$D(DUOUT)  Q:(Y=-1)&(NHL>0)
 .S DIC="^SC("
 .S DIC(0)="AEQMZ"
 .I NHL>0 S DIC("A")="Select another LOCATION: "
 .D ^DIC
 .I X=(U_U) S DTOUT=1
 .I $D(DTOUT)!($D(DUOUT)) Q
 .I +Y'=-1 D
 ..S IEN=$P(Y,U,1)
 ..;Check Facility code
 ..N FACILITY S FACILITY=$$FACL^PXRMXAP(IEN)
 ..I FACILITY="" W !,"Location has no facility code" Q
 ..I '$D(PXRMFACN(FACILITY)) D  Q
 ...W !,"Location has a different facility code" Q
 ..;Check for duplicates
 ..I (NHL>0),$$DUP(IEN,.PXRMLCHL,2) W !,"Error - Duplicate entry" Q
 ..S NHL=NHL+1
 ..;Get the stop code.
 ..S X=$P(^SC(IEN,0),U,7)
 ..S SC="Unknown" I +X>0 S SC=$P(^DIC(40.7,X,0),U,2) ; DBIA #557
 ..I $L(SC)=0 S SC="Unknown"
 ..;Save the external form of the name, then IEN, and the stop code.
 ..S PXRMLCHL(NHL)=$P(Y(0,0),U,1)_U_IEN_U_SC
 ..;Check for mixed inpatient and outpatient locations
 ..I (NHL>1),$D(CHECK)=0 D
 ...Q:'$$LOCN^PXRMXAP(.PXRMLCHL)
 ...W !,"Inpatient and Outpatient locations have been selected"
 ...S CHECK="DONE"
 .K DIC
 .I (NHL=0)&(+Y=-1) W !,"You must select a hospital location!"
 ;
 I $D(DUOUT)!($D(DTOUT)) Q
 ;Sort the hospital location list into alphabetical order.
 S NHL=$$SORT(NHL,"PXRMLCHL",2)
 ;Build array by IEN
 S IC=""
 F  S IC=$O(PXRMLCHL(IC)) Q:IC'>0  D
 .S PXRMLOCN($P(PXRMLCHL(IC),U,2))=IC
 Q
 ;---
FACILITY(SEL) ;Select facility (COPIED EX- PXRR)
 N IC,STATION,X,Y,DIC
 K DIRUT,DTOUT,DUOUT
 S NFAC=0
 S DIC("B")=+$P($$SITE^VASITE,U,3)
 S DIC("A")="Select FACILITY: "
 W !
 F  D  Q:$D(DTOUT)  Q:$D(DUOUT)  Q:(Y=-1)&(NFAC>0)
 .S DIC=4
 .S DIC(0)="AEMQZ"
 .I NFAC>0 S DIC("A")="Select another FACILITY: "
 .D ^DIC
 .I X=(U_U) S DTOUT=1
 .I '$D(DTOUT),('$D(DUOUT)),+Y'=-1 D
 ..;Check for duplicates
 ..I (NFAC>0),$$DUP($P(Y,U,1),.PXRMFAC,1) W !,"Error - Duplicate entry" Q
 ..S NFAC=NFAC+1,PXRMFAC(NFAC)=Y_U_Y(0,0)
 .K DIC
 ;
 I $D(DTOUT)!$D(DUOUT) Q
 ;;Save the facility names and station.
 F IC=1:1:NFAC D
 .S X=$P(PXRMFAC(IC),U,1)
 .S STATION=$P($G(^DIC(4,X,99)),U,1)
 .S PXRMFACN(X)=$P(PXRMFAC(IC),U,2)_U_STATION
 ;Sort the facility list into alphabetical order.
 S NFAC=$$SORT(NFAC,"PXRMFAC",2)
 Q
 ; ---
CGRP(TEMP) ; Clinic Group Selection
 N LIT,LIT1,DIC
 S DIC("A")="Select CLINIC GROUP: ",NOTM=0
 S LIT="Select another CLINIC GROUP: "
 S LIT1="You must select a clinic group!"
 D SEL(409.67,"AEQMZ",.NOTM,.TEMP,"","")
 ;Build array by IEN
 S NCGRP=0 N IC S IC=""
 F  S IC=$O(PXRMCGRP(IC)) Q:IC=""  D
 .S PXRMCGRN($P(PXRMCGRP(IC),U,1))=IC,NCGRP=IC
 Q
 ; ---
LIST(TEMP) ; Patient List
 N LIT,LIT1,DIC,NLIST
 S DIC("A")="Select REMINDER PATIENT LIST: ",NLIST=0
 S DIC("?")="Select a patient list to run the reminder report against."
 S LIT="Select another PATIENT LIST: ",LIT1="You must select a list!"
 D SEL(810.5,"AEQMZ",.NLIST,.TEMP,"",4)
 Q
 ;
 ; ---
PCMM(TEMP) ; PCMM teams
 N LIT,LIT1,DIC
 S DIC("A")="Select PCMM TEAM: ",NOTM=0
 S LIT="Select another PCMM TEAM: ",LIT1="You must select a team!"
 D SEL(404.51,"AEQMZ",.NOTM,.TEMP,"",1)
 Q
 ; ---
OERR(TEAM) ; OE/RR teams
 N LIT,LIT1,DIC
 S DIC("A")="Select TEAM: ",NOTM=0
 S LIT="Select another TEAM: ",LIT1="You must select a team!"
 D SEL(100.21,"AEQMZ",.NOTM,.TEAM,"",5)
 Q
 ; ---
RCAT(REMCAT,REM) ;Reminder Category/Reminder selection
 N CAT,DIC,LIT,LIT1,SEQ
 S NCAT=0 K REMCAT,REM
 ;Reminder Category
RCATS I PXRMREP="S" D  Q:$D(DUOUT)!$D(DTOUT)
 .K REMCAT S NCAT=0
 .S DIC("A")="Select a REMINDER CATEGORY: "
 .S LIT="Select another REMINDER CATEGORY: ",LIT1=""
 .D SEL(811.7,"AEQMZ",.NCAT,.REMCAT,PXRMREP,3)
 ;Individual Reminders
 D REM(.REM) Q:$D(DTOUT)
 I $D(DUOUT),PXRMREP="S" G RCATS
 Q
 ; ---
REM(REM) ;Reminders selection
 N LIT,LIT1,DIC
 K REM S NREM=0
 S DIC("A")="Select individual REMINDER: "
 S LIT="Select another REMINDER: ",LIT1="You must select a reminder!"
 D SEL(811.9,"AEQMZ",.NREM,.REM,PXRMREP,2)
 Q
 ; ---
PAT(VAR) ; Patient select
 N LIT,LIT1,DIC
 S DIC("A")="Select PATIENT: ",NPAT=0
 S LIT="Select another PATIENT: ",LIT1="You must select a patient!"
 D SEL(2,"AEQMZ",.NPAT,.VAR,"","")
 ;Sort the patient list into ascending order.
 S NPAT=$$SORT(NPAT,"VAR")
 Q
 ; ---
PROV(PRV) ;Build a list of selected providers.
 N LIT,LIT1,DIC
 S DIC("A")="Select PROVIDER: ",NPRV=0
 S LIT="Select another PROVIDER: ",LIT1="You must select a provider!"
 D SEL(200,"AEQMZ",.NPRV,.PRV,"","")
 I $D(DTOUT)!($D(DUOUT)) Q
 ;Sort the provider list into ascending order.
 S NPRV=$$SORT(NPRV,"PRV")
 Q
 ; ---
CSTOP ;Get a list of clinic stop codes.
 N LIT,LIT1,DIC,X,Y
 K DIROUT,DIRUT,DTOUT,DUOUT
 S DIC("A")="Select CLINIC STOP: "
 S LIT="Select another CLINIC STOP: "
 S LIT1="You must select a clinic stop!"
 S NCS=0
 W !
 F  D  Q:$D(DTOUT)  Q:$D(DUOUT)  Q:(Y=-1)&(NCS>0)
 .S DIC=40.7,DIC(0)="AEMQZ"
 .I NCS>0 S DIC("A")=LIT
 .D ^DIC
 .I X=(U_U) S DTOUT=1
 .I '$D(DTOUT),('$D(DUOUT)) D
 ..I +Y'=-1 D  Q
 ...S NCS=NCS+1
 ...;Save the external form of the name, the IEN, and the stop code.
 ...S PXRMCS(NCS)=$P(Y(0,0),U,1)_U_$P(Y,U,1)_U_$P(Y(0),U,2)
 ..W:NCS=0 !,LIT1
 ;Sort the clinic stop list into alphabetical order.
 S NCS=$$SORT(NCS,"PXRMCS",2)
 ;Build array by IEN
 S IC=""
 F  S IC=$O(PXRMCS(IC)) Q:IC=""  D
 .S PXRMCSN($P(PXRMCS(IC),U,2))=IC
 Q
 ; ---
SORT(N,ARRAY,KEY)       ;Sort an ARRAY with N elements 
 ;return the number of unique elements.  KEY is the piece of ARRAY on
 ;which to base the sort.  The default is the first piece.
 ;
 K ^TMP($J,"SORT")
 I (N'>0)!(N=1) Q N
 N IC,IND
 I '$D(KEY) S KEY=1
 F IC=1:1:N S ^TMP($J,"SORT",$P(@ARRAY@(IC),U,KEY))=@ARRAY@(IC)
 S IND=""
 F IC=1:1 S IND=$O(^TMP($J,"SORT",IND)) Q:IND=""  D
 .S @ARRAY@(IC)=^TMP($J,"SORT",IND)
 K ^TMP($J,"SORT")
 Q IC-1
 ;
 ;Check for duplicate entries
DUP(VALUE,ARRAY,PIECE) ;
 N IC,DUP
 S IC=0,DUP=0
 F  S IC=$O(ARRAY(IC)) Q:IC=""  D  Q:DUP
 .I $P(ARRAY(IC),U,PIECE)=VALUE S DUP=1
 Q DUP
