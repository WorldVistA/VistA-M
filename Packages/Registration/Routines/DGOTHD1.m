DGOTHD1 ;SLC/SS,RM,MKN - OTHD (OTHER THAN HONORABLE DISCHARGE) APIs ;12/27/17
 ;;5.3;Registration;**952**;Aug 13, 1993;Build 160
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
 ;ICR#   TYPE       DESCRIPTION
 ;-----  ----       ---------------------
 ;10103  Sup        ^XLFDT  : $$FMADD,$$FMTE,$$FMDIFF
 ;10142  Sup        ^DDIOL  : EN
 ; 2053  Sup        ^DIE    : FILE, HELP
 ; 2056  Sup        ^DIQ    : GET1
 ; 2050  Sup        ^DIALOG : MSG
 ;
 ;
 ;Set the first entry in file #33 (OTH ELIGIBILITY)
 ;Parameters:
 ; DGDFN - patient IEN
 ; DGSTRTDT - starting date
 ;Return values:
 ; <0 if error
 ; 1 if everything was created properly
FRSTNTRY(DGDFN,DGSTRDT,DGEXPMH) ;
 N DGIEN33,DGIEN365,DGIEN90,OTHDATA
 ;does the patient already have an entry in file #33 (OTH ELIGIBILITY)?
 S DGIEN33=$$HASENTRY^DGOTHD2(DGDFN) I DGIEN33>0 Q -2  ;already has an entry
 ;if no entry in file 33
 I DGIEN33=0 D
 . ;create the top level of file 33
 . S DGIEN33=$$CROTHENT^DGOTHD2(DGDFN)
 . ;if not OTH-90, do not create 365 and 90 day entry
 . Q:DGEXPMH=1
 . ;create the very first 365 and 90 day clock
 . D OTHDATA(1,1)
 . D FILAUTH^DGOTHUT1(DGDFN,OTHDATA)
 ;if error then return error
 I DGIEN33<0 Q DGIEN33
 Q 1
 ;
OTHDATA(DG365,DG90) ;
 K OTHDATA
 S $P(OTHDATA,U)=DG365
 S $P(OTHDATA,U,2)=DG90
 S $P(OTHDATA,U,6)=DT
 S $P(OTHDATA,U,7)=$S($G(DUZ)>0:$$UP^XLFSTR($$NAME^XUSER(DUZ,"F")),1:"POSTMASTER")
 S $P(OTHDATA,U,8)=$$GETSITE^DGOTHD2(.DUZ)
 S $P(OTHDATA,U,9)=$$NOW^XLFDT()
 Q
 ;
 ;Build 6 Sprint 3
 ;DG*5.3*952
 ;prompt for EXPANDED MH CARE TYPE
 ;called from input template [DG LOAD EDIT SCREEN 7]
XPANDED(DGDFN) ;
 ;
 ; Input :
 ;  DGDFN - Patient IEN
 ; Output:
 ;  1. Display warning message related to the patient's
 ;     primary eligibility code EXPANDED MH CARE NON-ENROLLEE
 ;  2. Create a new entry in field #.5501 node #.55 in Patient File (#2)
 ;  3. Create a new OTH ELIGIBILITY PATIENT (#33) entry.
 ;
 S DGEMHCNVT=0
 Q:'$G(DGDFN)
 N EMHCNV,DGMSG,DGQUIT,DGIEN33,DGERR,DGYN,DGARR
 S EMHCNV=$$ISOTHD^DGOTHD(DGDFN)  ;check if primary eligibility is EXPANDED MH CARE NON-ENROLLEE
 I 'EMHCNV D INACT33^DGOTHEL(DGDFN) Q
 ;display EXPANDED MH CARE  warning message
 S DGMSG(1)="  "
 S DGMSG(2)="  This code is used ONLY for Other Than Honorable veterans"
 S DGMSG(3)="  seeking mental healthcare prior to VBA ADJUDICATION."
 S DGMSG(4)="  "
 D EN^DDIOL(.DGMSG)
 ;
 ;before prompting for EXPANDED MH CARE TYPE check if patient is a former OTH patient
 ;if true, prompt user if they wish to continue editing the patient's primary eligibility
 I $$HASENTRY^DGOTHD2(DGDFN) S DGYN=1 D  Q:'$G(DGYN)
 . ;compare the previous and current primary eligibility of the patient
 . I $G(DGPRVSPE)'=$$GET1^DIQ(2,DGDFN_",",.361,"I") D
 . . ;patient has been INACTIVATED, presumably patient has received adjudication
 . . W !,"  *** A record on file indicates that this patient was previously"
 . . W !,"      defined as OTH.",!
 . . S DGYN=$$QUITYN("Do you still want to continue (Y/N)")
 . . I 'DGYN D  Q
 . . . W !!,"  NO ACTION TAKEN!!!",!
 . . . ;restore the previous primary eligibility code of the patient
 . . . D PREVSEL(DGDFN)
 . . . S Y=$S($G(DGECODE)'="":.323,1:"@7031")
 . . E  W !
 ;prompt for EXPANDED MH CARE TYPE
 ;Create a new entry in field #.5501 node #.55 in Patient File (#2)
 ;DGEMHC = 0   No entry created
 ;DGEMHC = 1   Create/Change EXPANDED MH CARE TYPE entry
 N DGEMHC
 S DGEMHC=$$EMHCTYP(DGDFN)
 D:DGEMHC UPDTEMHT(DGDFN)
 ;Call point to create a new OTH ELIGIBILITY PATIENT (#33) entry.
 D:DGEMHC STRDATE^DGOTHD(DGDFN)
 S Y=$S(Y=U:"",$G(DGECODE)'="":.323,1:"@7031")
 Q
 ;
EMHCTYP(DGDFN) ;prompt for EXPANDED MH CARE TYPE
 ;field #.5501 node #.55 in Patient File (#2)
 ; Input :
 ;  DGDFN - Patient IEN
 ; Output:
 ;  0 - No entry created
 ;  1 - Create/Change EXPANDED MH CARE TYPE entry
 ;
 N DA,DGDIRB,DIR,DTOUT,DUOUT,DIROUT,DIRUT
 N DONE,FILE,FIELD,DGTYPHLP
 S FILE=2,FIELD=.5501
 S DIR(0)=FILE_","_FIELD_"AO",DONE=0 S:DGDFN DA=DGDFN
 S DGDIRB=$$GET1^DIQ(2,DGDFN_",",.5501,"I")
 I DGDIRB'=""  S DIR("B")=$$OTHSOC^DGOTHD1(DGDIRB)
 S DIR("T")=1200 ;time specification to be used instead of DTIME
 F  D  Q:DONE
 . ;keep prompting until user enter a valid entry
 . K DGTYPHLP
 . D ^DIR
 . ;if the user times out
 . I $D(DTOUT) D  Q
 . . S DONE=1,DGQUIT=0
 . . I $G(DGDIRB)'="" Q  ;do not remove what is already there
 . . D PREVSEL(DGDFN)
 . ;if the user entered a caret (^) or two carets (^^)
 . I $D(DUOUT)!$D(DIROUT) D  Q
 . . S (DONE,DGEMHCNVT)=1,DGQUIT=0
 . . ;new patient
 . . I '$$HASENTRY^DGOTHD2(DGDFN),DGEMHCNVT D PREVSEL(DGDFN)
 . . ;existing patient
 . . I '$$ISOTH^DGOTHD(DGDIRB),$$HASENTRY^DGOTHD2(DGDFN) D PREVSEL(DGDFN)
 . ;if the user pressed Enter, or entering the at-sign (@), signifying deletion
 . I $D(DIRUT) D  Q
 . . I $$ISOTH^DGOTHD(DGDIRB),$$HASENTRY^DGOTHD2(DGDFN) D  Q
 . . . W !!,"  DELETION NOT ALLOWED!!!",!
 . . . S (DONE,DGQUIT)=0
 . . I X=Y D  Q
 . . . W ! D HELP^DIE(FILE,"",FIELD,"?","DGTYPHLP(1)"),MSG^DIALOG("WH","","","","DGTYPHLP(1)")
 . . . W ! S (DONE,DGQUIT)=0
 . . W !,"  No Expanded MH Care Type found."
 . . W !,"  Nothing to delete.",!
 . S (DONE,DGQUIT)=1
 K DIR
 Q DGQUIT
 ;
QUITYN(QUESTION) ;
 N DIR,Y
 S DIR(0)="Y"
 S DIR("A")=QUESTION
 S DIR("?")=" "
 S DIR("?",1)="Enter 'Y'es if you want to change the patient's primary eligibility code."
 S DIR("?",2)="Otherwise, enter 'N'o"
 D ^DIR
 Q +Y
 ; 
UPDTEMHT(DGDFN) ;set the associated EXPANDED MH CARE TYPE
 ; Input :
 ;  DGDFN - Patient IEN
 ; Output:
 ;  Create EXPANDED MH CARE TYPE entry in field #.5501 node #.55 in Patient File (#2)
 N DGFDA,DGERR
 I $$CHCKPAT^DGOTHD2(DGDFN)'>0 Q -2  ;patient does not exist
 S DGFDA(2,DGDFN_",",.5501)=Y
 D FILE^DIE("K","DGFDA","DGERR")
 D CRTEELCH^DGOTHEL(DGDFN,$$HASENTRY^DGOTHD2(DGDFN),$$NOW^XLFDT())
 Q
 ;
OTHSOC(EMHCT) ;Extract OTHER THAN HONORABLE set of codes
 ;
 ; Input : EMHCT - The internal set of code value
 ; Output: The external set of code value
 ;
 N DGERR,I,DGOTHSOC,YY
 S DGOTHSOC=$$GET1^DID(2,.5501,,"SET OF CODES",,"DGERR")
 Q:$D(DGERR)
 F I=1:1:$L(DGOTHSOC,";") S YY=$P(DGOTHSOC,";",I) Q:YY=""  S DGOTHSOC($P(YY,":"))=$P(YY,":",2)
 Q $S($D(DGOTHSOC(EMHCT)):DGOTHSOC(EMHCT),1:"Expanded Type Not Found")
 ;
EMHCT(DGDFN) ;EXPANDED MH CARE TYPE 'OTH' in Patient file #2
 ; Input :
 ;  DGDFN - Patient IEN
 ; Output:
 ;  Remove EXPANDED MH CARE TYPE entry in field #.5501 node #.55 in Patient File (#2)
 Q:'$G(DGDFN)
 N DGFDART,DGOTHERR
 S DGFDART($J,2,DGDFN_",",.5501)=""
 D FILE^DIE("U","DGFDART($J)","DGOTHERR")
 I $D(DGOTHERR) W !!,"An error occurred during filing."
 Q
 ;
PREVSEL(DGDFN) ;put back the patient's previous primary eligibility code
 ; Input :
 ;  DGDFN - Patient IEN
 N DA,DGEH,DGFDART,DGIEN33,DIK,DGOTHERR,DGPREEL
 S DGFDART($J,2,DGDFN_",",.361)=$S($G(DGPRVSPE)>0:DGPRVSPE,1:"")
 D FILE^DIE("U","DGFDART($J)","DGOTHERR")
 I $D(DGOTHERR) W !!,"An error occurred during filing."
 Q
 ;
