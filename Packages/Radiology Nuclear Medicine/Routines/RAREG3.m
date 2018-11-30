RAREG3 ;HISC/CAH,DAD,FPT,GJC-Register Rad/NM Patient (cont.) ;16 Jan 2018 10:04 AM
 ;;5.0;Radiology/Nuclear Medicine;**8,137**;Mar 16, 1998;Build 4
 ;
RSBIT ; renumber selections by imaging type
 ; The RAORDS array has the list of orders the user selected to register
 ; in the order the user entered them. This subroutine will reorganize
 ; the array so the orders are arranged by imaging type of their
 ; procedure starting with the imaging type the user is currently signed
 ; on with followed by the ascending internal entry number of the
 ; remaining imaging types.
 ;
 Q:'$D(RAORDS)
 K RALOOP,RAORDST
 F RALOOP=1:1 Q:'$D(RAORDS(RALOOP))  D
 .S RAON=+$P(RAORDS(RALOOP),U,1) Q:'RAON
 .S RAPN=+$P(^RAO(75.1,RAON,0),U,2) Q:'RAPN
 .S RAIN=+$P(^RAMIS(71,RAPN,0),U,12) Q:'RAIN
 .S RAORDST(RAIN,RALOOP)=RAON
 .Q
 S RAIMGTYN=+$O(^RA(79.2,"B",RAIMGTY,0)) Q:'RAIMGTYN
 K RAORDS S (RALOOP,RAIN)=0
 I $D(RAORDST(RAIMGTYN)) F  S RAIN=$O(RAORDST(RAIMGTYN,RAIN)) Q:'RAIN  S RALOOP=RALOOP+1,RAORDS(RALOOP)=+RAORDST(RAIMGTYN,RAIN) K RAORDST(RAIMGTYN,RAIN)
 I $D(RAORDST) S RAIMGTYN=0 F  S RAIMGTYN=$O(RAORDST(RAIMGTYN)) Q:'RAIMGTYN  S RAIN=0 F  S RAIN=$O(RAORDST(RAIMGTYN,RAIN)) Q:'RAIN  S RALOOP=RALOOP+1,RAORDS(RALOOP)=+RAORDST(RAIMGTYN,RAIN)
 K RAIMGTYN,RAIN,RALOOP,RAON,RAORDST,RAPN
 Q
SETDISV ; when registering procedures of different imaging types set imaging
 ; location default value in DIC("B") if only one location associated with
 ; imaging type.
 N RACNT,RAITNHLD,RAITNXT,RALOOP
 S (RACNT,RAITNXT)=0
 F RALOOP=0:0 S RAITNXT=$O(^RA(79.1,"BIMG",RAITN,RAITNXT)) Q:'RAITNXT  S RACNT=RACNT+1,RAITNHLD=RAITNXT
 ;I RACNT=1 S ^DISV(+DUZ,"^RA(79.1,")=RAITNHLD
 I RACNT=1,RAITNHLD,$G(^RA(79.1,RAITNHLD,0))]"" S DIC("B")=$P($G(^SC(+^(0),0)),"^")
 Q
SL ; switch locations
 ; Prompt the user to switch locations if the current sign-on imaging
 ; type does not match the procedure's imaging type.
 ; comment out 06/10/97 D EXAMSET^RAREG2 S RAPARENT=0
 S RAITN=$P(^RAMIS(71,+$P(Y,U,2),0),U,12)
 I RAITN'=+$O(^RA(79.2,"B",RAIMGTY,0)) D
 .S RAMLCHLD=RAMLC,RAYHOLD=Y,RAPROLOC=$P(^RA(79.2,RAITN,0),U,1),RAMDIVHD=RAMDIV
 .D LABEL
 .W !!?7,"Current Imaging Type: ",RAIMGTY
 .W !?5,"Procedure Imaging Type: ",RAPROLOC
 .W !!,"You must switch to a location of ",RAPROLOC," imaging type.",!!
 .D SETDISV
 .K RAMLC S RASWLOC=""
 .D SET^RAPSET1
 .K RASWLOC
 .I '$D(RAMLC) S RAQUIT=1,RAMLC=RAMLCHLD Q
 .I RAMDIVHD'=RAMDIV W !!,"You have switched Divisions from: ",$P(^DIC(4,+RAMDIVHD,0),U),!,?30,"to: ",$P(^DIC(4,+RAMDIV,0),U),!
 .D DT Q:RAQUIT
 .S Y=RAYHOLD
 .Q
 K RAITN,RAMDIVHD,RAMLCHLD,RAPROLOC,RAYHOLD
 Q
DT ; prompt for new imaging date/time when imaging type changes
 Q:'$D(^RADPT(RADFN,"DT",RADTI,0))
 N RAHRS S RAHRS=+$P($G(^RA(79,+RAMDIV,.1)),"^",24) ;How many hrs in adv?
 R !!,"Imaging Exam Date/Time: NOW// ",X:DTIME
 I '$T!(X=" ")!(X="^") S RAQUIT=1 Q
 S:X="" RANOW="",X="NOW"
 I X="NOW" S RADTICHK=9999999.9999-($E($$NOW^XLFDT,1,12)) I $D(^RADPT(RADFN,"DT",RADTICHK,0)) D SUB1MIN K RADTICHK
 S %DT(0)=-$$FMADD^XLFDT($$NOW^XLFDT,0,RAHRS,0,0),%DT="ETXR"
 D ^%DT K %DT G DT:Y<0
DT1 S RADTE=Y,RADTI=9999999.9999-RADTE I $D(^RADPT(RADFN,"DT",RADTI,0)) W !,$C(7),"Patient already has exams entered for this date/time.",!,"....use 'Add Exams to Last Visit' option." G DT
DT2 K RADTEBAD S RADTEBAD=$O(^RADPT(RADFN,"DT","B",RADTE)) I RADTEBAD[RADTE D SUB1MIN S RADTE=X,RADTI=RADTICHK G DT2
 K RADTEBAD
 I $D(RANOW),$D(RAWARD) S RACAT="INPATIENT"
 I '$D(RANOW) K RAWARD,RABED,RASER D ^RASERV S:$D(RAWARD) RACAT="INPATIENT"
 Q
SUB1MIN ; subtract 1 minute from NOW to get an unused date/time
 F RALOOP=1:1 S X=$$FMADD^XLFDT(RADTE,0,0,-RALOOP,0) S RADTICHK=9999999.9999-X Q:'$D(^RADPT(RADFN,"DT",RADTICHK,0))
 K RALOOP
 Q
 ;
LABEL ; *** Print labels
 I $D(RAPX) D
 . W ! S RAPX=RADFN,RAZIS=1
 . S RASAV2=$G(^RADPT(+$G(RADFN),"DT",+$G(RADTI),0))
 . S RASAV3=$G(^RADPT(+$G(RADFN),"DT",+$G(RADTI),"P",$S($G(RACNI):RACNI,1:+$O(^RADPT(+$G(RADFN),"DT",+$G(RADTI),"P",0))),0))
 . D FLH^RAFLH K RANUMF
 . I $P(RAMDV,U,8) D JAC^RAJAC
 . S RADFN=RAPX K RAZIS
 . I $P($G(^DIC(195.4,1,"UP")),U,2) D ^RTQ5
 . K RAPX
 . Q
 Q
 ;
PRNRQ ;Print Request at Registration - P137/KLM
 I '$D(RAPX) Q  ;registration process aborted
 I '$D(RAORDS) Q  ;no order array
 N RAJ,RAOIFN,RAILOC,RAION,RAARY
 S RAJ=0 F  S RAJ=$O(RAORDS(RAJ)) Q:RAJ=""  D
 .S RAOIFN=$G(RAORDS(RAJ)) Q:RAOIFN=""
 .S RAILOC=$$GET1^DIQ(75.1,RAOIFN,20,"I") Q:RAILOC=""  ;get i-loc from order
 .S RAION=$$GET1^DIQ(79.1,RAILOC,28) Q:RAION=""  ;Registered Request printer defined?
 .;Orders for registered exams may span modalities
 .;order status is active/registered - build RAARY(DEVICE NAME,ORDER IEN)
 .I $$GET1^DIQ(75.1,RAOIFN,5,"I")=6 S RAARY(RAION,RAOIFN)=""
 .;End RAJ loop on RAORDS
 ;Setup task vars for each reg req device with orders
 I $D(RAARY) D
 .S RAION="" F  S RAION=$O(RAARY(RAION)) Q:RAION=""  D
 ..N RAORS
 ..S ZTIO=RAION
 ..S RAOIFN=0 F  S RAOIFN=$O(RAARY(RAION,RAOIFN)) Q:RAOIFN=""  D
 ...S RAORS(RAOIFN)=""
 ...;End RAOIFN loop - Order IEN
 ..S ZTDESC="Rad/Nuc Med Registered Request Print"
 ..S ZTDTH=$H,ZTRTN="PRNRQ1^RAREG3"
 ..S ZTSAVE("RADFN")="",ZTSAVE("RAORS(")="" D ^%ZTLOAD
 ..K ZTIO,ZTDTH,ZTSAVE,ZTDESC,ZTRTN
 ..I $D(ZTSK) W !!,"Task "_ZTSK_": registered request(s) queued to print on device ",RAION,!
 ..;End RAION loop - Device Name
 .;End RAARY
 K RAORS,RAION,RAJ,RAILOC,RAARY,RAOIFN
 Q
PRNRQ1 ;task entry point - P137
 N RAPAGE,RAX,RAOIFN
 S RAPAGE=0,RAX="" ;needed for ^RAORD5
 S RAOIFN=0 F  S RAOIFN=$O(RAORS(RAOIFN)) Q:RAOIFN=""  D
 .U IO D ^RAORD5
 K RAPAGE,RAX,RAOIFN
 Q
