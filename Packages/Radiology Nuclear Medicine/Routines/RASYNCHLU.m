RASYNCHLU ;HISC/GJC-Case Number Lookup Synch Logic ; Dec 05, 2024@14:35:25
 ;;5.0;Radiology/Nuclear Medicine;**198,222**;Mar 16, 1998;Build 1
 ;
 ;Routine              File     IA          Type
 ;----------------------------------------------
 ;                     100      6475        (C)
 ;
EN ;Entry point for 'Synch Canceled/Completed Exams with CPRS & RIS Orders'
 ;note: RADFN is defined after successfully selecting a radiology patient record from ^RADPA
 ;Returns: RAQS the user selection (globally scoped local)
 ;
 ;Note: To save key strokes 'out of synch' will be abbreviated as 'OoS'
 ;
 I '$D(RADFN)#2 W !!?2,"Patient information is missing, exiting the option." QUIT
 N RABS5,RACEXST,RACPRS,RADATE,RADIV,RADTPRT,RAEXDT,RAEXST,RAHDFLG,RAHDR,RAI,RAII,RAIMAGE
 N RAOIFN,RAORIFN,RAORSTS,RAPRC,RAPTNAME,RAREQST,RAROOT,RASSN,RAX,RAY2,RAY3,RAXIT
 S (RAHDFLG,RACNT,RAXIT)=0,RAHDR="<<<< Synch Exams with CPRS/Radiology Orders >>>>"
 D SEL Q:$O(^TMP($J,"RASYNCH",0))'>0
 ;now display the existing data
 S RAI=0,RAROOT=$NA(^TMP($J,"RASYNCH"))
 F  S RAI=$O(@RAROOT@(RAI)) Q:RAI'>0  D  Q:RAXIT>0!(RAQS>0)
 .S RAX=$G(@RAROOT@(RAI))
 .F RAII=1:1:7 S @$P("RADFN^RADTI^RADTE^RACNI^RACN^RAOIFN^RAACC","^",RAII)=$P(RAX,"^",RAII)
 .D SETUP,DATA
 .Q
 Q
 ;
SEL ; selection criteria part one
 Q:'$D(^DPT(RADFN,0))#2  S RADFN(0)=$G(^DPT(RADFN,0)),RASSN=$$SSN^RAUTL,RAPTNAME=$P(RADFN(0),"^")
 D HOME^%ZIS S (RACNT,RADTI,RAQS)=0
 F  S RADTI=$O(^RADPT(RADFN,"DT",RADTI)) Q:RADTI'>0  D  Q:RAQS>0!(RAXIT>0)
 .S RAY2=$G(^RADPT(RADFN,"DT",RADTI,0)),RADTE=+$P(RAY2,U) D SEL2
 .Q
 Q
 ;
SEL2 ; selection criteria part two
 S RADIV=+$P(RAY2,U,3),RAIMAGE=+$P(RAY2,U,2)
 S RADIV=+$G(^RA(79,RADIV,0)),RADIV=$P($G(^DIC(4,RADIV,0)),U)
 S:RADIV']"" RADIV="Unknown"
 S RAIMAGE=$P($G(^RA(79.2,RAIMAGE,0)),U)
 S:RAIMAGE']"" RAIMAGE="Unknown" S RACNI=0
 F  S RACNI=$O(^RADPT(RADFN,"DT",RADTI,"P",RACNI)) Q:RACNI'>0  D  Q:RAQS>0!(RAXIT>0)
 .S RAY3=$G(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0)) S RACN=+$P(RAY3,U)
 .D SAVE
 .QUIT
 Q
SAVE ; Screen only if entered through Rad/Nuc Med must be canceled/completed exams (determined by order #)
 S RAEXST=+$P(RAY3,U,3),RAEXST(0)=$G(^RA(72,RAEXST,0))
 Q:RAEXST(0)=""  S RAEXST(1)=$P(RAEXST(0),U)
 ;quit if exam is not canceled or not complete
 I $P(RAEXST(0),U,3)'=0,($P(RAEXST(0),U,3)'=9) Q
 S RACN=$P(RAY3,U) S:RACN="" RACN="error"
 S RAEXDT=$E(RADTE,4,5)_"/"_$E(RADTE,6,7)_"/"_$E(RADTE,2,3)
 S RAPRC(0)=$G(^RAMIS(71,+$P(RAY3,U,2),0)),RAPRC=$P(RAPRC(0),U)
 S RAOIFN=+$P(RAY3,U,11),RAOIFN(0)=$G(^RAO(75.1,RAOIFN,0))
 ;
 ;// begin RA*5.0*222 modifications //
 ;we do not care what the RIS order status is; we only care that the CPRS order
 ;status is 'active' when associated with cancelled exams & when the CPRS order
 ;status is not 'complete' when associated with completed exams.
 ;
 S RAREQST=$$GET1^DIQ(75.1,RAOIFN_",",5) ;RIS external
 S RAORIFN=+$P(RAOIFN(0),U,7) ;CPRS ptr to file #100
 S RAORSTS=$$GET1^DIQ(100,RAORIFN_",",5) ;CPRS external
 ;CPRS order must be 'active' (for OoS cancelled exams)
 ;or not 'complete' (for OoS completed exams).
 ;
 I $P(RAEXST(0),U,3)=9,(RAORSTS="COMPLETE") QUIT
 ;
 ;Note: Only 'active' orders and cancelled exams are checked.
 I $P(RAEXST(0),U,3)=0,(RAORSTS'="ACTIVE") QUIT
 ;
 ;For active orders only: check this specific cancelled exam, for this specific
 ;'active' CPRS order, to see if there are other non-cancelled exams tied to this
 ;'active' CPRS order.
 ;-if true do not discontinue the order; else discontinue the order.
 I $P(RAEXST(0),U,3)=0  Q:$$OTHERS(RAOIFN,RADFN)
 ;// end RA*5.0*222 modifications //
 ;
 ;-- accession #
 I $P(RAY3,U,31)'="" S RAACC=$P(RAY3,U,31)
 E  S RAACC=$E(RADTE,4,7)_$E(RADTE,2,3)_"-"_RACN
 ;--
 S (RADTPRT,Y)=RADTE D D^RAUTL S RADATE=Y,RACNT=RACNT+1
 S ^TMP($J,"RASYNCH",RACNT)=RADFN_U_RADTI_U_RADTE_U_RACNI_U_RACN_U_RAOIFN_U_RAACC
 Q
 ;
DATA ;display data here
 ;RAROOT = $NA(^TMP($J,"RASYNCH",RACNT))
 D:RAHDFLG=0 HD ;mimics 'Case No. Exam Edit' & 'Edit Exam by Patient' options screen display
 ;
 S RACEXST=$P($G(^RA(72,+$P(RAY3,U,3),0)),U)
 W !,RAI,?4,RAACC,?21,$E(RAPRC,1,17),?41,RAEXDT,?52,$E(RACEXST,1,9),?62,RAORIFN
 ;condition: if at end of screen check and more patient data stop and ask user for a selection
 ;the user can enter return at the selection prompt (RAQS=0) move to next set of data
 I (($Y+4)>IOSL) D
 .D USRSEL Q:RAXIT>0!(RAQS>0)
 .W:$O(@RAROOT@(RAI))>0 @IOF
 .Q
 ;condition: if not at end of screen and no more patient data ask user for their choice
 E  D:$O(@RAROOT@(RAI))'>0 USRSEL
 Q
 ;
HD ;print header once
 S RAHDFLG=1,RABS5=" ("_$E(RAPTNAME,1)_$P(RASSN,"-",3)_")"
 W @IOF,?25,RAHDR,!!,"Patient's Name: ",$E(RAPTNAME,1,20),RABS5,?59,"Run Date: " S Y=DT D DT^DIO2
 W !!,$$CJ^XLFSTR("========== Synch Exams with CPRS/Radiology Orders ==========",IOM)
 W !!?4,"Accession #",?21,"Procedure",?41,"Exam DT",?52,"Exam ST",?62,"CPRS Order #"
 W !?4,"-----------",?21,"---------",?41,"-------",?52,"-------",?62,"------------" Q
 Q
 ;
USRSEL ;prompt user for selection.
 ;Input : RACNT = # of records displayed
 ;Output: RAQS = the # (between 1 & RACNT) of user's selection
 N DA,DIC,DIE,DIR,DIROUT,DIRUT,DR,DTOUT,DUOUT,X,Y
 S DIR(0)="NO^1:"_RAI_":0",DIR("A")="Enter your numeric selection"
 S DIR("?",1)="Enter the number identifying the accession number of the exam to"
 S DIR("?",2)="be re-synchronized. Only one exam can be re-synchronized at a time."
 S DIR("?")="Enter a number between 1 and "_RAI_"." D ^DIR
 I $D(DTOUT)#2!($D(DUOUT)#2)!($D(DIROUT)#2) S RAXIT=1 QUIT
 S RAQS=+Y
 QUIT
 ;
SETUP ;setup basic exam and order data.
 S RAY2=$G(^RADPT(RADFN,"DT",RADTI,0)) Q:RAY2=""
 S RAY3=$G(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0)) Q:RAY3=""
 S RAPRC(0)=$G(^RAMIS(71,+$P(RAY3,U,2),0)),RAPRC=$P(RAPRC(0),U)
 S RAEXDT=$E(RADTE,4,5)_"/"_$E(RADTE,6,7)_"/"_$E(RADTE,2,3)
 S RAOIFN=+$P(RAY3,U,11),RAOIFN(0)=$G(^RAO(75.1,RAOIFN,0))
 S RAREQST=$$GET1^DIQ(75.1,RAOIFN_",",5) ;RIS external
 S RAORIFN=+$P(RAOIFN(0),U,7) ;CPRS ptr to file #100
 S RAORSTS=$$GET1^DIQ(100,RAORIFN_",",5) ;CPRS external
 QUIT
 ;
OTHERS(RAOIFN,RADFN) ;For the cancelled exam check only: Are there other
 ;non-canceled exams tied to the 'active' CPRS order status?
 ; Input: RAOIFN = RIS order IEN
 ;         RADFN = DFN of patient
 ;
 ; returns: RAR: 1 If another non-canceled exam associated
 ;                 to the 'active' CPRS order status.
 ;               0 The else condition (the default)
 N RA0,RA1,RA72,RAA,RAC,RAQ,RAR S (RA1,RAR)=0
 F  S RA1=$O(^RADPT("AO",RAOIFN,RADFN,RA1)) Q:RA1'>0  D  Q:RAR
 .S RA0=0 F  S RA0=$O(^RADPT("AO",RAOIFN,RADFN,RA1,RA0)) Q:RA0'>0  D  Q:RAR
 ..S RAQ=$G(^RADPT(RADFN,"DT",RA1,"P",RA0,0)) Q:RAQ=""  ;bad data
 ..S RA72=+$P(RAQ,U,3),RA72(0)=$G(^RA(72,RA72,0))
 ..S:$P(RA72(0),U,3)>0 RAR=1
 ..Q
 .Q
 Q RAR
 ;
