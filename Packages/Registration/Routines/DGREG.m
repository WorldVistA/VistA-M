DGREG ;ALB/JDS,MRL,PJR,PHH,ARF,RN,JAM,ARF,SJD - REGISTER PATIENT ; 3/28/14 12:38pm
 ;;5.3;Registration;**1,32,108,147,149,182,245,250,513,425,533,574,563,624,658,864,886,915,926,1024,993,1040,1027,1045,1067,1075,1102,1111,1138**;Aug 13, 1993;Build 3
 ; 
 ; DG*5.3*1075 - Fix line 1 for SAC compliance
 ; Reference to (#350.9,54.01) supported by ICR #7429
 ; Reference to BACKGND^IBCNRDV supported by ICR #4288
 ;
START ;
EN D LO^DGUTL S DGCLPR=""
 N DGDIV
 S DGDIV=$$PRIM^VASITE
 S:DGDIV %ZIS("B")=$P($G(^DG(40.8,+DGDIV,"DEV")),U,1)
 I $P(^DG(43,1,0),U,39) S %ZIS="NQ",%ZIS("A")="Select 1010 printer: " D ^%ZIS Q:POP  S (DGIO(10),DGIO("PRF"),DGIO("RT"),DGIO("HS"))=ION,DGASKDEV="" I $E(IOST,1,2)'["P-" W !,$C(7),"Not a printer" G DGREG
 K %ZIS("B")
 I '$D(DGIO),$P(^DG(43,1,0),U,30) S %ZIS="N",IOP="HOME" D ^%ZIS I $D(IOS),IOS,$D(^%ZIS(1,+IOS,99)),$D(^%ZIS(1,+^(99),0)) S Y=$P(^(0),U,1) W !,"Using closest printer ",Y,! F I=10,"PRF","RT","HS" S DGIO(I)=Y
A D ENDREG($G(DFN))
 ; DG*5.3*1040 - NEW variable DGTMOT and initialize to 0 to track timeout in address and DGADDRE to track the return value of $$ADD^DGADDUTL
 N DGADDRE,DGTMOT S DGTMOT=0,DGADDRE=""
 N DGNEWP   ;**1024 USING DGNEWP INSTEAD OF JUST DGNEWP TO AVOID Y BEING RESET ON US 
 W !! S DIC=2,DIC(0)="ALEQM",DLAYGO=2 K DIC("S"),DIC("B") D ^DIC K DLAYGO G Q1:Y<0 S (DFN,DA)=+Y,DGNEW=$G(DGNEWP) N Y D PAUSE^DG10 D BEGINREG(DFN) I DGNEW D NEW^DGRP
 ;
 ;; ask to continue if patient died - DG*5.3*563 - pjr 10/12/04
 S DOD="" I $G(DFN) S DOD=$P($G(^DPT(DFN,.35)),"^",1)
 I DOD S Y=DOD,DGPME=0 D DIED^DGPMV I DGPME K DFN,DGRPOUT G A
 ;
 D CIRN
 ;
 I +$G(DGNEW) D
 . ; query CMOR for Patient Record Flag Assignments if NEW patient and
 . ; display results.
 . I $$PRFQRY^DGPFAPI(DFN) D DISPPRF^DGPFAPI(DFN)
 . I $$EN^DGPFMPI(DFN)
 ;
 D ROMQRY
 ;
 ; DG*5.3*993 The DO YOU WISH TO ENROLL, ENROLLMENT DATE, and DO YOU WANT AN APPT questions
 ; were moved here from the end of patient registration. Also, if the patient does not wish to enroll
 ; a REGISTRATION REASON question will be asked
 N DGBACK,DGENRDT,DGENRIEN,DGENRRSN,DGENRYN,DGERR,DGEXIT,DGFDA,DGFDD,DGIEN,DGNOW,DGOUT,DGSTA,DGVET,DGX,DGY,DIE,DIR,DR,DTOUT,DUOUT
 ; Do you wish to enroll?
 S DGBACK=0,DGSTA="",DGIEN=$$FINDCUR^DGENA(DFN) I DGIEN S DGSTA=$$GET1^DIQ(27.11,DGIEN_",",.04)
 K DGOUT D GETS^DIQ(2,DFN_",",".3216*","I","DGOUT")
 S DGFDD=0,DGX="" F  S DGX=$O(DGOUT(2.3216,DGX),-1) Q:DGX=""  S DGFDD=+$G(DGOUT(2.3216,DGX,.08)) Q:DGFDD  ;DGFDD=Future Discharge Date
ENRYN S DGBACK=0,DGENRYN="",DGVET=$$VET^DGENPTA(DFN) S:'DGVET DGENRYN=0
 ; DG*5.3*1045 - Newed DGINELIG,DGENPTA,DGIPTAPPLD variables
 N STATUS,DGPREXST,DGPTAPPLD,DGCURR,DGKEY,DGREQNAME,DGENSTAT,DGWSHTOEN,DGRESP,DGDEATH,DGDEAD,DGSHWPRMPT,DGNOENRLL,DGINELIG,DGENPTA,DGIPTAPPLD  ; DG*5.3*1027 - Newed E&E Webservice variables
 I $$GET^DGENPTA(DFN,.DGENPTA) S DGINELIG=$G(DGENPTA("INELDATE")) ;DG*5.3*1045 Below two lines have logic for Ineligible Date 
 S DGDEAD=0,DGIPTAPPLD=""
 S DGDEATH=$$DEATH^DGENPTA(DFN) I DGDEATH'=0 S DGDEAD=1
 S DGPTAPPLD="",DGPREXST="",DGPREXST=$$PREEXIST(DFN),STATUS="",STATUS=$$STATUS^DGENA($G(DFN)) I STATUS=25 S DGENRYN=0,DGPREXST=0
 S DGCURR="",DGCURR=$$FINDCUR^DGENA(DFN) I DGCURR S DGPTAPPLD=$$GET1^DIQ(27.11,DGCURR_",",.14,"I")
 I DGPTAPPLD=1 S DGENRYN=1
 I $G(DGINELIG)'="",$G(DGPTAPPLD)="" S DGIPTAPPLD=$$GET1^DIQ(2,DFN,27.04,"I") ;DG*5.3*1045 Below two lines have logic for Ineligible Date 
 I $G(DGIPTAPPLD)=1 S DGENRYN=1
 ; DG*5.3*1027 Display DO YOU WISH TO ENROLL Prompt if Veteran AND
 ; PT APPLIED FOR ENROLLMENT in the Patient Enrollment file is NO
 ; There is NO Patient Enrollment record and The patient is unknown to ES
 ; Supported DBIA #2701: The supported DBIA is used to access MPI
 ; APIs to retrieve ICN, determine if ICN
 ; is local and if site is LST.
 ; Supported ICRs
 ; #3356 - XQY0 ; Kernel Variable
 K ^TMP($J,"DGOLDVET")
 ; The ^TMP global is cleaned up in DG REGISTER PATIENT option EXIT ACTION
 S ^TMP($J,"DGOLDVET",DFN)=DGVET
 S DGKEY=$$GETICN^MPIF001(DFN)
 S DGREQNAME="VistAData"
 S DGRESP=0,DGSHWPRMPT=0,DGNOENRLL=0
 I $P(DGKEY,"^",1)'=-1 S DGRESP=$$EN^DGREGEEWS(DGKEY,DGREQNAME,.DGENSTAT,.DGWSHTOEN)
 I '$$FINDCUR^DGENA(DFN),+DGRESP=0 S DGNOENRLL=1
 I ((DGNOENRLL=1)!($G(DGPTAPPLD)=0)) S DGSHWPRMPT=1 ; DG*5.3*1027 Modified DGPTAPPLD=0 per RSD
 I 'DGFDD,'DGDEAD,DGVET,DGSHWPRMPT F  D  Q:DGENRYN'=""!(DGBACK)
 . K DIR,DTOUT I ($G(DGPTAPPLD)=0) S DIR("B")="NO"
 . S DIR(0)="Y",DIR("A")="DO YOU WISH TO ENROLL"
 . S DIR("?")="Select Y or YES if the patient wants to apply for enrollment for VHA Healthcare benefits. Select N or NO if the patient only wants to register without applying for enrollment."
 . S DIR("??")="^D HELPENR^DGREG"
 . D ^DIR
 . I ($G(DGPTAPPLD)="")&((X["Y")!(X["y")) D  Q
 . . S DGENRYN=1
 . . N DGFDA,DGIENS,DGRSLT
 . . S DGRSLT=DGENRYN,DGIENS=DFN_",",DGFDA(2,DGIENS,27.04)=DGRSLT
 . . D FILE^DIE("","DGFDA")
 . I ($G(DGPTAPPLD)="")&(X["N")!(X["n") S DGENRYN=0 D  Q
 . . S DGENRYN=0
 . . N DGFDA,DGIENS,DGRSLT
 . . S DGRSLT=DGENRYN,DGIENS=DFN_",",DGFDA(2,DGIENS,27.04)=DGRSLT
 . . D FILE^DIE("","DGFDA") ;DG*5.3*1027
 . . I $P($G(XQY0),"^",1)="DG REGISTER PATIENT",$G(DGENRYN)=0,$$GET1^DIQ(2,DFN,1010.1512,"I")=1 D APPTCHG^DGRPC ; DG*5.3*1027 Remove appointmnet request data when DGENRYN is changed from Y to N (DGPTAPPLD)=1
 . I ($G(DGPTAPPLD)=0)&(X["Y")!(X["y") W !!?5,"This is an existing patient. To complete the enrollment" W !?5,"application process, please use the Enrollment System."
 . I ($G(DGPTAPPLD)=0)&(X["Y")!(X["y") W !!!?5,"Press <Enter> to Continue or '^' to exit:" R X:DTIME
 . S:$D(DTOUT)!(X=U) DGBACK=1
 G:DGBACK A
 S:DGFDD DGENRYN=1
 S DGENRRSN="",DGNOW=$$NOW^XLFDT()
 ;I (DGENRYN=0)&('DGPREXST) D G:DGENRRSN="^" ENRYN ; Check this condition for prexist from DG 993
 I (DGENRYN=0) D  G:DGENRRSN="^" ENRYN
 . ;REGISTRATION ONLY REASON
 . S DGY="",DGX=$$FINDCUR^DGENA(DFN) I DGX?1.N S DGY=$$GET1^DIQ(27.11,DGX_",",.15)
 . I (DGY=""),(STATUS=""),+DGRESP=0 D     ; DG*5.3*1027 Unknown to ES condition added
 . . ;W !,"SELF-REPORTED REGISTRATION ONLY REASON" ;DG*5.3*1027 - not needed - replaced with code below
 . . W ! ;DG*5.3*1027 place a line in between prompts
 . . F  D  Q:(DGENRRSN="^")!(DGENRRSN)
 . . . ; DG*5.3*1027 - Modification of the data entry to field .15 (REGISTRATION ONLY REASON) of the 27.11 (PATIENT ENROLLMENT) file
 . . . K DIR
 . . . S DIR(0)="27.11,.15,AO"
 . . . S DIR("A")="SELF-REPORTED REGISTRATION ONLY REASON: "
 . . . D ^DIR
 . . . I $D(DTOUT)!$D(DUOUT) S DGENRRSN="^" Q
 . . . S DGENRRSN=+Y
 . . . I 'DGENRRSN W !,"This is a required field.",! Q
 . . . S DGENRODT=DGNOW,DGENSRCE=1 ;These fields will be filed in the PATIENT ENROLLMENT file at the end of registration
 N DGBACK,DGENRDTT,ANS,DGAPLDT,DGENRIEN
 S DGENRIEN=$$FINDCUR^DGENA(DFN)
 S DGBACK=0,DGAPLDT=$$GET1^DIQ(27.11,DGENRIEN_",",.01,"I")
 I (DGENRYN=1) S DGEXIT=0 D  G:DGEXIT ENRYN
 . ;ENROLLMENT APPLICATION DATE
 . ; Do not display the Application Prompt if application date exists in 27.11 file
 . ; and do not display APPOINTMENT REQUEST IN 1010EZ prompt
 . K Y I $G(DGAPLDT)="" D PROMPT^DGENU(27.11,.01,"NOW",,1,1) S:$E(Y)="^" DGEXIT=1 Q:DGEXIT  D
 . . S DGENRDTT=Y S:Y?1.N.E DGENRDT=Y\1 S:Y="" DGENRDT=DGNOW\1,DGENRDTT=DGNOW
 . . ; If no value for APPT REQUEST, prompt for it
 . . I $P($G(^DPT(DFN,1010.15)),"^",9)="" D APPTREQ(DGENRDTT,.DGBACK)
 . S DGY="",DGX=$$FINDCUR^DGENA(DFN) S:DGX?1.N DGY=$$GET1^DIQ(27.11,DGX_",",.16) I DGY="" D
 . . S DGENRRSN="",DGENRODT=DGNOW,DGENSRCE=1 ;These fields will be filed in the PATIENT ENROLLMENT file at the end of registration
 ;
 G:DGBACK ENRYN
 ; END OF DG*5.3*993 mods
 S (DGFC,CURR)=0
 D:'$G(DGNEW) WARN S DA=DFN,DGFC="^1",VET=$S($D(^DPT(DFN,"VET")):^("VET")'="Y",1:0)
 S %ZIS="N",IOP="HOME" D ^%ZIS S DGELVER=0 D EN^DGRPD I $D(DGRPOUT) D ENDREG($G(DFN)) D HL7A08^VAFCDD01 K DFN,DGRPOUT G A
 D HINQ^DG10
 ;I $D(^DIC(195.4,1,"UP")) I ^("UP") D ADM^RTQ3;DG*5.3*1111-remove Select Admitting Area
 D REG^IVMCQ($G(DFN)) ; send financial query 
 G A1
 ;
 ;
APPTREQ(DGENRDTT,DGBACK) ; Prompt for DO YOU WANT AN APPT. WITH A VA DOCTOR/PROVIDER AS SOON AS AVAILABLE?
 ; If YES, update fields #2,#1010.159 and #2,#1010.1511 (NOTE: This code came from DGEN)
 ; Input: DGENRDTT - value for ENROLLMENT APPLICATION DATE field 1010.1511 in PATIENT file 
 ; Output: DGBACK (Pass by Reference) - If set, the user has exited from the prompt
 ;
 N DGSXS,DGAPPTAN,DA,DR,DIE
 S DGSXS="",DGBACK=0
 S DGSXS=$$PROMPT^DGENU(2,1010.159,1,.DGAPPTAN,"",1)
 I 'DGSXS S DGBACK=1 Q
 S DA=DFN
 S DIE="^DPT("
 S DR="1010.159///^S X=DGAPPTAN"
 D ^DIE
 K DA,DR,DIE
 ; If patient answered YES to "Do you want an appt" question, set APPOINTMENT REQUEST DATE to DGENRDTT
 I DGAPPTAN D
 . S DIE="^DPT("
 . S DA=DFN
 . S DGENRDTT=$$HLDATE^HLFNC(DGENRDTT,"DT")
 . S DR="1010.1511///^S X=DGENRDTT"
 . D ^DIE
 ; If patient answered NO to "Do you want an appt" question set APPOINTMENT REQUEST DATE to TODAY
 I DGAPPTAN=0 D
 . S DIE="^DPT("
 . S DA=DFN
 . S DR="1010.1511///^S X=DT"
 . D ^DIE
 Q
 ;
PREEXIST(DFN) ;DG*5.3*993 - Did this patient exist before the installation of DG*5.3*993
 N DGX,DGINST,DGINSTAT,DGINSTID,DGICN,DGEXIST,DGARR,DGREC,DGESKNOWN,I
 S (DGEXIST,DGICN)=""
 S DGICN=+($$GETICN^MPIF001(DFN))
 I DGICN=-1 Q 0
 K DGARR I DGICN'=-1 S DGEXIST=$$QUERYTF^VAFCTFU1(DGICN,"DGARR","") ; check Treating Facility returns 1^text if not found
 I $P(DGEXIST,"^",1)=1 Q 0
 S DGX=0,DGESKNOWN=0,I=0,DGREC="",DGINSTID="" F I=1:1 Q:'$D(DGARR(I))  S DGREC=DGARR(I) D  Q:DGESKNOWN=1
 . S DGINSTAT="",DGINST=$P(DGREC,"^",1)
 . S DGINSTID=$P($G(^DIC(4,DGINST,9999,1,0)),"^",2) I DGINSTID="200ESR" S DGINSTAT=$$GET1^DIQ(4,DGINST_",",99)
 . I (DGINSTID="200ESR")&(DGINSTAT="200ESR") S DGESKNOWN=1
 I (DGESKNOWN=1) S DGX=1 ;if exist to ES and applied="" it preexist
 I (DGESKNOWN=0)&(DGEXIST'=0) S DGX=0 ;not known to ES and not in treating facility (new record)
 I (DGESKNOWN=0)&(DGEXIST="") S DGX=0 ;new record 
 Q DGX
 ;
HELPENR ;DG*5.3*993 - Help for ?? on the DO YOU WISH TO ENROLL? question
 W !,"Select Y or YES if the patient wants to apply for enrollment for VHA"
 W !,"Healthcare benefits. Select N or NO if the patient only wants to"
 W !,"register without applying for enrollment."
 Q
 ;
REASON(Y,XQY0) ; DG*5.3*1027 - Screen logic/Input Transform for field .15 (REGISTRATION ONLY REASON) of the 27.11 (PATIENT ENROLLMENT) file
 ; Input: Y - Entry to be checked
 ; XQYO - String containing the option that is being run (may be null when accessing the field from Fileman)
 ; Returns: TRUE if the entry Y is valid
 ;
 ; Supported ICRs:
 ; Reference to variable XQY0 supported by ICR #3356 ; Kernel Variable
 ; Reference to $$GET^XPAR supported by ICR #2263
 ; Reference to $$GET1^DIQ() supported by ICR #2056
 ;
 ; Check the entry in the 408.43 (PATIENT REGISTRATION ONLY REASON) dictionary
 I '$D(^DG(408.43,Y,0)) Q 0
 ; Entries with AVAILABILITY field = 3 (HEC) and 4 (VBA) are not valid. DG*5.3*1138 adds Availability = 4
 I ($P(^DG(408.43,Y,0),U,2)=3)!($P(^DG(408.43,Y,0),U,2)=4) Q 0
 ; DG*5.3*1067 - For Reg Only Reasons added in patch 1067, screen them out until the date/time in XPAR parameter DG PATCH DG*5.3*1067 ACTIVE is reached
 N DGREASON,DGACTTS
 S DGREASON=$$GET1^DIQ(408.43,Y_",",.01)
 I DGREASON="CLINICAL EVALUATION"!(DGREASON="4TH MISSION")!(DGREASON="HUD-VASH")!(DGREASON="IMMUNIZATIONS") D  I $$NOW^XLFDT()<DGACTTS Q 0
 . ; Get the timestamp stored in the parameter
 . S DGACTTS=$$GET^XPAR("PKG","DG PATCH DG*5.3*1067 ACTIVE",1)
 ; Handle the condition where not within a Vista option or in Programmer mode, default to 0
 I $G(XQY0)=""!($P($G(XQY0),U,1)="XUPROGMODE") N DGRET S DGRET=0 D  Q DGRET
 . ; If direct call to DG COLLATERAL, Only entries with AVAILABILITY field = 2 (COLLATERAL) are valid (variable DR set in ^DGCOL)
 . I $G(DR)="[DGCOLLATERAL]" I $P(^DG(408.43,Y,0),U,2)=2 S DGRET=1
 ; XQY0 is defined and is not Programmer mode:
 ; DG*5.3*1067; If non-Veteran, do not allow CLINICAL EVALUATION
 N DGVET
 S DGVET=$$VET1^DGENPTA($G(DFN))
 I 'DGVET,DGREASON="CLINICAL EVALUATION" Q 0
 ; If not in DG COLLATERAL PATIENT option, all other entries are valid
 I $P(XQY0,U,1)'="DG COLLATERAL PATIENT" Q 1
 ; Otherwise, in DG COLLATERAL PATIENT option, only entries with AVAILABILITY field = 2 (COLLATERAL) are valid
 I $P(^DG(408.43,Y,0),U,2)=2 Q 1
 Q 0
 ;
PAUSE ;
 N DIR
 S DIR(0)="E" D ^DIR
 Q
 ;
RT ;I $D(^DIC(195.4,1,"UP")) I ^("UP") S $P(DGFC,U,1)=DIV D ADM^RTQ3 ;DG*5.3*1111-remove Select Admitting Area from Register a Patient
 Q
 ;
 ; DG*5.3*1040 - If variable DGADDRE=-1, branch to Q due to timeout; if DGRPOUT=1, branch to Q as well
A1 W !,"Do you want to ",$S(DGNEW:"enter",1:"edit")," Patient Data" S %=1 D YN^DICN D  G:$G(DGADDRE)=-1 Q G H:'%,CK:%'=1 S DGRPV=0 D EN1^DGRP G:+$G(DGRPOUT) Q G Q:'$D(DA)
 .I +$G(DGNEW) Q
 .S DGADDRE=$$ADD^DGADDUTL($G(DFN)) ; DG*5.3*1040 - Store the return value in DGADDRE
 G CH
 ;DG*5.3*1111 - Remove Is the patient currently being followed in a clinic for the same condition from Register a Patient process 
PR G ABIL ;W !!,"Is the patient currently being followed in a clinic for the same condition" S %=0 D YN^DICN G Q:%=-1
 ;I '% W !?4,$C(7),"Enter 'Y' if the patient is being followed in clinic for condition for which",!?6,"registered, 'N' if not." G PR
 ;S CURR=% G SEEN
 ; Killing ^TMP($J,"DGOLDVET",DFN) below ; DG*5.3*1027 cleaning the temp global
CK S DGEDCN=1 D ^DGRPC
CH S X=$S('$D(^DPT(DFN,.36)):1,$P(^(.36),"^",1)']"":1,1:0),X1=$S('$D(^DPT(DFN,.32)):1,$P(^(.32),"^",3)']"":1,1:0) I 'X,'X1 G CH1
CH1 K ^TMP($J,"DGOLDVET",DFN) S DA=DFN G PR:'$D(^DPT("ADA",1,DA)) W !!,"There is still an open disposition--register aborted.",$C(7),$C(7) G Q
 ;DG*5.3*1111 - remove Is the patient to be examined in the medical center today from Register a Patient process 
SEEN ;W !!,"Is the patient to be examined in the medical center today" S %=1 D YN^DICN S SEEN=% G:%<0 Q I %'>0 W !!,"Enter 'Y' if the patient is to be examined today, 'N' if not.",$C(7) G SEEN
ABIL D ^DGREGG
ENR ; next line appears to be dead code. left commented just to test. mli 4/28/94
 ;S DE=0 F I=0:0 S I=$O(^DPT(DA,"DE",I)) Q:'I I $P(^(I,0),"^",3)'?7N Q D PR:'DE S L=+$P($S($D(^SC(L,0)):^(0),1:""),"^",1)
REG S (DIE,DIC)="^DPT("_DFN_",""DIS"",",%DT="PTEX",%DT("A")="Registration login date/time: NOW// "
 W !,%DT("A") R ANS:DTIME S:'$T ANS="^" S:ANS="" ANS="N" S X=ANS G Q:ANS="^" S DA(1)=DFN D CHK^DIE(2.101,.01,"E",X,.RESULT) G REG:RESULT="^"!('$D(RESULT)),PR3:'(RESULT#1) S Y=RESULT
 I (RESULT'="^") W " ("_RESULT(0)_")"
 S DINUM=9999999-RESULT
 S (DFN1,Y1)=DINUM,APD=Y I $D(^DPT(DFN,"DIS",Y1)) W !!,"You must enter a date that does not exist.",$C(7),$C(7) G REG
 ;patch 886 changed to incremental lock and dilocktm
 G:$D(^DPT("ADA",1,DA)) CH1 L +@(DIE_DINUM_")"):$G(DILOCKTM,3) G:'$T MSG S:'($D(^DPT(DA(1),"DIS",0))#2) ^(0)="^2.101D^^" S DIC(0)="L",X=+Y D ^DIC
 ;
 ;SAVE OFF DATE/TIME OF REGISTRATION FOR HL7 V2.3 MESSAGING, IN VAFCDDT
 S VAFCDDT=X
 ; DG*5.3*993 Decoupling project code for register only 
 N DGSTUS,DGCHK
 S DGCHK=0
 S DGSTUS=$$STATUS^DGENA($G(DFN)) I DGSTUS=25 S DGCHK=1,DGENRYN=0 ; If DGSTUS=25 patient is Register Only ;27.11 TEST
 S DGENRYN=$G(DGENRYN) I DGENRYN=0 S DGCHK=1 ;DG*5.3*993 If DGENRYN=1 patient said YES to enroll
 ;DG*5.3*1111-Comments in COMMENTS^DGREG0
 N DA,SP
 S DA=DFN1,DIE("NO^")=""
 S DA(1)=DFN,DP=2.101
 S DR="3//"_$S($P(^DG(43,1,"GL"),"^",2):"",1:"/")_$S($D(^DG(40.8,+$P(^DG(43,1,"GL"),"^",3),0)):$P(^(0),"^",1),1:"")_";4////"_DUZ
 ;patch 886 changed lock to use dilocktm
 D EL K DIC("A") N DGNDLOCK S DGNDLOCK=DIE_DFN1_")" L +@DGNDLOCK:$G(DILOCKTM,3) G:'$T MSG D ^DIE L -@DGNDLOCK
 I $D(DTOUT) D  G Q
 .K DTOUT
 .N DA,DIK
 .S DA(1)=DFN,DA=DFN1,DIK="^DPT("_DFN_",""DIS"","
 .D ^DIK
 .W !!?5,"User Time-out. Required registration data could be missing."
 .W !,?5,"This registration has been deleted."
 ; check whether facility applying to (division) is inactive
 I '$$DIVCHK^DGREGFAC(DFN,DFN1) G CONT
ASKDIV W !!?5,"The facility chosen either has no pointer to an Institution"
 W !?5,"file record or the Institution file record is inactive."
 W !?5,"Please choose another division."
 S DA=DFN1,DIE("NO^")="",DA(1)=DFN,DP=2.101,DR="3" D ^DIE
 I $$DIVCHK^DGREGFAC(DFN,DFN1) G ASKDIV
CONT ; continue
 S DGXXXD=1 D EL^DGREGE I $P(^DPT(DFN,"DIS",DFN1,0),"^",3)=4 S DA=DFN,DIE="^DPT(",DR=".368;.369" D ^DIE S DIE="^DPT("_DFN_",""DIS"",",DA(1)=DFN,DA=DFN1
 ;S DA=DFN,DR="[DGREG]",DIE="^DPT(" D ^DIE K DIE("NO^") ;DG*5.3*1111 - The DGREG input template prompts grouping is removed 
 I $D(^DPT(DFN,"DIS",DFN1,2)),$P(^(2),"^",1)="Y" S DIE="^DPT(",DR="[DG EMPLOYER]",DA=DFN D ^DIE
 G ^DGREG0
PR2 W !!,"You can only enter new registrations through this option.",$C(7),$C(7) G REG
PR3 W !!,"Time is required to register the patient.",!!,$C(7),$C(7) G REG
H W !?5,"Enter 'YES' to enter/edit registration data or 'NO' to continue." G A1
 ; DG*5.3*1040 - Cleanup variable DGTMOT
Q K DG,DQ,DGTMOT G Q1^DGREG0
Q1 K DGIO,DGASKDEV,DGFC,DGCLRP,CURR,DGELVER,DGNEW Q
EL S DR=DR_";13//" I $D(^DPT(DFN,.36)),$D(^DIC(8,+^(.36),0)) S DR=DR_$P(^(0),"^",1) Q
 S DR=DR_"HUMANITARIAN EMERGENCY" Q
FEE S DGRPFEE=1 D DGREG K DGRPFEE G Q1
 ;
WARN I $S('$D(^DPT(DFN,.1)):0,$P(^(.1),"^",1)']"":0,1:1) W !,$C(7),"***PATIENT IS CURRENTLY AN INPATIENT***",! H 2
 I $S('$D(^DPT(DFN,.107)):0,$P(^(.107),"^",1)']"":0,1:1) W !,$C(7),"***PATIENT IS CURRENTLY A LODGER***",! H 2
 Q
MSG W !,"Another user is editing, try later ..." G Q
 ;
BEGINREG(DFN) ;
 N DGQRY
 ;Description: This is called at the beginning of the registration process.
 ;Concurrent processes can check the lock to determine if the patient is
 ;currently being registered.
 ;
 Q:'$G(DFN) 0
 ; **915, check to see if a query was done within the last 5 minutes so we don't send again
 S DGQRY=$$GET^DGENQRY($$FINDLAST^DGENQRY($G(DFN)),.DGQRY)
 I $$FMDIFF^XLFDT($$NOW^XLFDT,$G(DGQRY("SENT")),2)>300,$$QRY^DGENQRY(DFN) W !!,"Enrollment/Eligibility Query sent ...",!!
 ;patch 886 changed lock to use dilocktm
 L +^TMP(DFN,"REGISTRATION IN PROGRESS"):$G(DILOCKTM,3)
 I $$LOCK^DGENPTA1(DFN) ;try to lock the patient record
 Q
 ;
ENDREG(DFN) ;
 ;Description: releases the lock obtained by calling BEGINREG.
 ;
 Q:'$G(DFN)
 L -^TMP(DFN,"REGISTRATION IN PROGRESS")
 D UNLOCK^DGENPTA1(DFN)
 Q
 ;
IFREG(DFN) ;
 ;Description: tests whether the lock set by BEGINREG is set
 ;
 ;Input: DFN
 ;Output:
 ; Function Value = 1 if lock is set, 0 otherwise
 ;
 N RETURN
 Q:'$G(DFN) 0
 ;patch 886 changed lock to use dilocktm
 L +^TMP(DFN,"REGISTRATION IN PROGRESS"):$G(DILOCKTM,3)
 S RETURN='$T
 L -^TMP(DFN,"REGISTRATION IN PROGRESS")
 Q RETURN
 Q
CIRN ;MPI QUERY
 ;check to see if CIRN PD/MPI is installed
 N X S X="MPIFAPI" X ^%ZOSF("TEST") Q:'$T
 K MPIFRTN
 D MPIQ^MPIFAPI(DFN)
 K MPIFRTN
 Q
ROMQRY ;**926 TRIGGER IB INSURANCE QUERY
 N ZTSAVE,A,ZTRTN,ZTDESC,ZTIO,ZTDTH,DGMSG
 ;Invoke IB Insurance Query (Query was introduced with IB*2.0*214)
 ;DG*1102/TAZ - Check Insurance Import Enabled flag
 ; Reference to Field 54.01 in File 350.9 supported by ICR #7429
 I '$$GET1^DIQ(350.9,"1,",54.01,"I") D  Q
 . S DGMSG(1)="Insurance data retrieval is not currently enabled."
 . S DGMSG(2)=" "  D EN^DDIOL(.DGMSG) R A:5
 S ZTSAVE("IBTYPE")=1,ZTSAVE("DFN")=DFN,ZTSAVE("IBDUZ")=$G(DUZ)
 ; Reference to BACKGND^IBCNRDV supported by ICR #4288
 S ZTRTN="BACKGND^IBCNRDV",ZTDTH=$H,ZTDESC="IBCN INSURANCE QUERY TASK",ZTIO=""
 D ^%ZTLOAD
 ;display busy message to interactive users
 S DGMSG(1)="Insurance data retrieval has been initiated."
 S DGMSG(2)=" " D EN^DDIOL(.DGMSG)
 ;**915 all "register once" functionality eliminated additional
 ; checks that use to be below this line.
 Q  ;**915 all register once functionality no longer executed and removed
