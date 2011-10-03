PXRMXT ; SLC/PJH - Reminder Reports Template Load ;11/21/2005
 ;;2.0;CLINICAL REMINDERS;**4**;Feb 04, 2005;Build 21
 ; 
 ; Called from PXRMYD,PXRMXD
 ;
 ;Select Template
 ;---------------
START N X,Y,CNT,FOUND,PXRMFLD,DIC,MSG
 K DIROUT,DIRUT,DTOUT,DUOUT
 S PXRMTMP="",FOUND=0
 ;
 ;Check if any templates exist for this report type
 Q:'$$FIND(PXRMTYP)
 ;
 ;Select template required
 W !
 S CNT=0,DIC=810.1,DIC(0)="AEQMZ"
 S DIC("A")="Select an existing REPORT TEMPLATE or return to continue: "
 S DIC("S")="I $P(^PXRMPT(810.1,+Y,0),U,3)=PXRMTYP"
 D ^DIC
 I X=(U_U) S DTOUT=1
 I '$D(DTOUT),('$D(DUOUT)) D
 .I +Y'=-1 D  Q
 ..S CNT=CNT+1,ARRAY(CNT)=Y_U_Y(0,0)_U_$P(Y(0),U,3)
 K DIC
 ;
 ;Load template into local array
 I (+Y'=-1)&('$D(DTOUT))&('$D(DUOUT)) D
 .L +^PXRMPT(810.1,$P(Y,U)):0
 .E  W !!?5,"Another user is editing this entry." S DUOUT=1 Q
 .;Load template into an array
 .S PXRMTMP=Y_U_$P(Y(0),U,2) D LOAD
 .L -^PXRMPT(810.1,$P(PXRMTMP,U))
 .;Exit if problem loading template
 .I $D(MSG) S DTOUT=1 Q
 .;Display Template information
 .D:'$D(MSG) ^PXRMXTD
 ;
EXIT Q
 ;
 ;Check if any templates exist for this report type
 ;-------------------------------------------------
FIND(TYP) ;
 N SUB,FOUND
 S SUB=0,FOUND=0
 F  S SUB=$O(^PXRMPT(810.1,SUB)) Q:'SUB  D  Q:FOUND
 .I $P($G(^PXRMPT(810.1,SUB,0)),U,3)=TYP S FOUND=1
 Q FOUND
 ;
 ;
 ;Load variables from report template (both INT and EXT)
 ;------------------------------------------------------
LOAD N ARRAY
 D GETS^DIQ(810.1,$P(PXRMTMP,U),"**","IE","ARRAY","MSG")
 I $D(MSG) D  Q
 .W !!,"File read failed, GETS^DIQ returned the following error message:"
 .N IC S IC="MSG"
 .F  S IC=$Q(@IC) Q:IC=""  W !,IC,"=",@IC
 .W !,"Examine the above error message for the reason.",!
 .H 2
 ;
 N MREF,ORDER,ORDERC,SUB,SUB1,XREF
 ;
 S SUB1=$O(ARRAY(810.1,""))
 D XREF^PXRMXTB
 S SUB="" F  S SUB=$O(XREF(SUB)) Q:SUB=""  D 
 .S @SUB=$G(ARRAY(810.1,SUB1,XREF(SUB),"I"))
 ;
 S PXRMFLD=$G(ARRAY(810.1,SUB1,XREF("PXRMSEL"),"E"))
 S RUN=$G(ARRAY(810.1,SUB1,XREF("RUN"),"E"))
 ;Update name if template has been renamed
 S $P(PXRMTMP,U,2)=$G(ARRAY(810.1,SUB1,XREF("NAME"),"E"))
 S TITLE=$G(ARRAY(810.1,SUB1,XREF("TITLE"),"E")),$P(PXRMTMP,U,3)=TITLE
 ;
MULT ;Clear multiple field arrays
 K PXRMREM,PXRMPAT,PXRMPRV,PXRMOTM,PXRMFAC,PXRMLCHL,PXRMCS,PXRMCGRP
 K PXRMFACN,PXRMCSN,PXRMCGRN,PXRMRCAT,REMINDER
 ;
 ;Load Multiple fields
 D SUB(.PXRMREM,810.12,"REMINDER",1)
 ;Load Patients
 D SUB(.PXRMPAT,810.16,"PATIENT",1)
 ;Load Providers
 D SUB(.PXRMPRV,810.14,"PROVIDER",1)
 ;Load OE/RR Teams
 D SUB(.PXRMOTM,810.17,"OERR TEAM",1)
 ;Load PCMM Teams
 D SUB(.PXRMPCM,810.18,"PCMM TEAM",1)
 ;Load Facility codes
 D SUB(.PXRMFAC,810.13,"FACILITY",1)
 ;Load Hospital Location codes
 D SUB(.PXRMLCHL,810.11,"LOCATION",2)
 ;Load Clinic Stop codes
 D SUB(.PXRMCS,810.111,"STOP CODE",2)
 ;Load Clinic Groups
 D SUB(.PXRMCGRP,810.112,"CLINIC GROUP",1)
 ;Load Reminder Categories
 D SUB(.PXRMRCAT,810.113,"REMINDER CATEGORY",1)
 ;Load Patient lists
 D SUB(.PXRMLIST,810.114,"PXRMLIST",1)
 ;
 ;Build PXRMFACN/PXRMLOCN array IEN's and counters NHL/NFAC
 D NUM
 ;
 ;Build Service Category array
 I $L(PXRMSCAT)>0 F IC=1:1:$L(PXRMSCAT,",") S PXRMSCAT($P(PXRMSCAT,",",IC))=""
 ;
 ;Add Descriptions for Reminders
 D DES(.PXRMREM,"^PXD(811.9",4)
 ;Add Descriptions for Reminder Categories
 D DES(.PXRMRCAT,"^PXRMD(811.7",4)
 ;Add Descriptions for Teams
 D DES(.PXRMOTM,"^OR(100.21",3)
 ;Add Display Codes for Stops
 D CODE(.PXRMCS,"^DIC(40.7",3)
 ;
 ;Sort Reminders into display order
 D SORT(.PXRMREM,.ORDER)
 ;Sort Reminders categories into display order
 D SORT(.PXRMRCAT,.ORDERC)
 ;
 ;Combine individual reminders and category reminders
 D MERGE^PXRMXS1
 Q
 ;
 ;
 ;Extract INTernal and EXTernal format from ARRAY
 ;-----------------------------------------------
SUB(OUTPUT,SUB,VAR,ORD) ; 
 K OUTPUT
 N IC,INT,EXT,SUB1,DISP
 S SUB1="",IC=0
 F  S SUB1=$O(ARRAY(SUB,SUB1)) Q:SUB1=""  D
 .S INT=$P($G(ARRAY(SUB,SUB1,MREF(VAR),"I")),";")
 .S EXT=$G(ARRAY(SUB,SUB1,MREF(VAR),"E"))
 .S IC=IC+1
 .I ORD=1 S OUTPUT(IC)=INT_U_EXT
 .I ORD'=1 S OUTPUT(IC)=EXT_U_INT
 .I (VAR'="REMINDER")&(VAR'="REMINDER CATEGORY") Q
 .;Get display order
 .S DISP=$G(ARRAY(SUB,SUB1,MREF("DISPLAY ORDER"),"I"))
 .;Store in PXRMREM for display
 .S OUTPUT(IC)=OUTPUT(IC)_U_DISP
 .;Put reminders with no sequence number last
 .I DISP="" S DISP=99
 .;Create order array for sorting entries later
 .I VAR="REMINDER" S ORDER(DISP,IC)=""
 .I VAR="REMINDER CATEGORY" S ORDERC(DISP,IC)=""
 Q
 ;
 ;Build array PXRMFACN and NFAC
 ;-----------------------------
NUM N IC,FACN,FACNAM
 K PXRMLOCN,PXRMCSN,PXRMCGRN,PXRMFACN
 S IC=""
 F  S IC=$O(PXRMFAC(IC)) Q:IC=""  D
 .S FACN=$P(PXRMFAC(IC),U),FACNAM=$P(PXRMFAC(IC),U,2)
 .S PXRMFACN(FACN)=FACNAM_U_FACN,NFAC=IC
 ; Build Array PXRMLOCN and NHL
 N LOCN
 F  S IC=$O(PXRMLCHL(IC)) Q:IC=""  D
 .S LOCN=$P(PXRMLCHL(IC),U,2)
 .S PXRMLOCN(LOCN)=IC,NHL=IC
 ; Build Array PXRMCSN and NCS
 N CSN
 F  S IC=$O(PXRMCS(IC)) Q:IC=""  D
 .S CSN=$P(PXRMCS(IC),U,2)
 .S PXRMCSN(CSN)=IC,NCS=IC
 ; Build Array PXRMCGRN and NCGRP
 N GRPN
 F  S IC=$O(PXRMCGRP(IC)) Q:IC=""  D
 .S GRPN=$P(PXRMCGRP(IC),U,1)
 .S PXRMCGRN(GRPN)=IC,NCGRP=IC
 Q
 ;
 ;Add print name to OUTPUT array
 ;-------------------------------
DES(OUTPUT,GLOB,POSN) ;
 N IC,IEN,DES
 S IC=""
 F  S IC=$O(OUTPUT(IC)) Q:IC=""  D
 .S IEN=$P(OUTPUT(IC),U,1)
 .X "S DES=$P($G("_GLOB_",IEN,0)),U,3)"
 .S $P(OUTPUT(IC),U,POSN)=DES
 Q
 ;
 ;Add stop code to OUTPUT array
 ;-------------------------------
CODE(OUTPUT,GLOB,POSN) ;
 N IC,IEN,CODE
 S IC=""
 F  S IC=$O(OUTPUT(IC)) Q:IC=""  D
 .S IEN=$P(OUTPUT(IC),U,2)
 .X "S CODE=$P($G("_GLOB_",IEN,0)),U,2)"
 .S $P(OUTPUT(IC),U,POSN)=CODE
 Q
 ;
 ;Sort reminders into display order (allow for duplicates)
 ;--------------------------------------------------------
SORT(INPUT,ORDER) ;
 N IC,DISP,OUTPUT,IC1
 S DISP="",IC1=0
 F  S DISP=$O(ORDER(DISP)) Q:DISP=""  D
 .S IC=""
 .F  S IC=$O(ORDER(DISP,IC)) Q:IC=""  D
 ..S IC1=IC1+1,OUTPUT(IC1)=INPUT(IC)
 ; Move results back
 K INPUT M INPUT=OUTPUT
 Q
