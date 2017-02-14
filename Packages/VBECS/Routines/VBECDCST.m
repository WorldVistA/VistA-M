VBECDCST ;hoifo/gjc-print data from VBECS STANDARD TABLE DATA (#6007);Nov 21, 2002
 ;;2.0;VBEC;;Jun 05, 2015;Build 4
 ;
 ;Medical Device #:
 ;Note: The food and Drug Administration classifies this software as a
 ;medical device.  As such, it may not be changed in any way.
 ;Modifications to this software may result in an adulterated medical
 ;device under 21CFR820, the use of which is considered to be a
 ;violation of US Federal Statutes.  Acquiring and implementing this
 ;software through the Freedom of Information Act requires the
 ;implementer to assume total responsibility for the software, and
 ;become a registered manufacturer of a medical device, subject to FDA
 ;regulations.
 ;
 ;Call to $$NEWERR^%ZTER is supported by IA: 1621
 ;Call to EN1^DIP is supported by IA: 10010
 ;Call to ^DIR is supported by IA: 10026
 ;Execution of ^%ZOSF("TEST") is supported by IA: 10096
 ;
EN ; entry point for standard table data report
 ;
 I $S($D(DUZ)[0:1,$D(DUZ(0))[0:1,'DUZ:1,DUZ=.5:1,1:0) W !!?3,$C(7),"DUZ & DUZ(0) must be defined to an active user (not POSTMASTER) in order to",!?3,"proceed." Q
 ;
 ; initialize the error trap
 I $$NEWERR^%ZTER N $ETRAP,$ESTACK S $ETRAP="D ERR^VBECDCU1"
 E  S X="D ERR^VBECDCU1",@^%ZOSF("TRAP")
 ;
 ; check to see that data exists in the VBECS STANDARD TABLE DATA FILE
 ; (#6007).
 I '+$O(^VBEC(6007,0)) D  Q
 .W !!?3,"There is no data in the VBECS STANDARD TABLE DATA FILE (#6007)",!,"to be printed.",$C(7)
 .Q
 ;
 S VBECXIT=0 F  D  Q:VBECXIT
 .; enter the FROM range for the attribute name
 .S DIR(0)="FAO^1:175^K:X'?1AN.ANP X",DIR("A")="Start With Attribute Name: "
 .S DIR("?",1)="  To sort in sequence, starting with a particular Attribute Name, enter that"
 .S DIR("?",2)="  Attribute Name.  Some displays might take a while due to the number of"
 .S DIR("?")="  records in the file."
 .D ^DIR S:$D(DTOUT)!$D(DUOUT) VBECXIT=-1 Q:VBECXIT
 .S VBECFR=Y K DIR,DIRUT,DTOUT,DUOUT,X,Y
 .; enter the TO range for the attribute name
 .S DIR(0)="FAO^1:175^K:X'?1AN.ANP X",DIR("A")="Go To Attribute Name: "
 .S DIR("?",1)="  To sort in sequence, up to a particular Attribute Name, enter that"
 .S DIR("?",2)="  Attribute Name.  Some displays might take a while due to the number"
 .S DIR("?")="  of records in the file."
 .D ^DIR S:$D(DTOUT)!$D(DUOUT) VBECXIT=-1 Q:VBECXIT
 .S VBECTO=Y K DIR,DIRUT,DTOUT,DUOUT,X,Y
 .I $L(VBECFR),$L(VBECTO),(VBECFR]VBECTO) W !!,"'Go To' value must follow the 'Start With' value.",!
 .ELSE  S VBECXIT=1
 .Q
 I VBECXIT=-1 D XIT QUIT
 I VBECFILE=61.3 D GO613
 I VBECFILE=65.4 D GO654
 Q
 ;
GO613 ; entry point for antigen/antibody report
 S L=0,DIC="^VBEC(6007,"
 S FLDS=".01;C1;L28;""Name"",.04;C30;""Antibody/Antigen"",.02;C50;""SNOMED"""
 S BY=".11,.01",FR="61.3,"_VBECFR,TO="61.3,"_VBECTO D EN1^DIP
 D XIT
 Q
 ;
GO654 ; entry point for transfusion reaction report
 S L=0,DIC="^VBEC(6007,"
 S FLDS=".01;C1;""Transfusion Reaction"""
 S BY=".11,.01",FR="65.4,"_VBECFR,TO="65.4,"_VBECTO D EN1^DIP
 D XIT
 Q
 ;
XIT ; clean up symbol table, exit
 K BY,D0,DIC,DIR,DIROUT,DIRUT,DTOUT,DUOUT,DIWF,FR,L,POP,TO,VBECFR,VBECTO,VBECXIT,X,Y
 Q
 ;
