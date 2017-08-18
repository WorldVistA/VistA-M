DGRPECE ;ALB/MRY,ERC,BAJ,NCA - REGISTRATION CATASTROPHIC EDITS ; 10/4/06 3:27pm
 ;;5.3;Registration;**638,682,700,720,653,688,750,831,907**;Aug 13, 1993;Build 28
 ;
CEDITS(DFN) ;catastrophic edits  - buffer values, save after check
 ;Input;
 ;  DFN  := patient ien
 ;Catastrophic edits will prompt for name, ssn, dob, and sex.  Placing
 ;responses into a buffer space.  User will be alerted on catastrophic
 ;edits on the following conditions:
 ; 1. Two or more catastrophic edits will generate a warning message.
 ; 2. Acceptance of two or more catastrophic edits will generate an alert
 ; to appropriate supervising staff holding the DG CATASTROPHIC EDIT key.
 ; 3. Acceptance of <2 catastrophic edits will process normally.
 ;
 ; Arrays: BEFORE - Holds patient values before the edit process
 ;                  (before snapshot).
 ;         BUFFER - initialized with BEFORE array, holds edited changes
 ;                  (after snapshot).
 ;         SAVE   - holds only edited changes for filing into file #2.
 ;
 N DA,DIR,DIRUT,Y,BUFFER,BEFORE,SAVE,DG20IEN,XUNOTRIG
 D BEFORE(DFN,.BEFORE,.BUFFER) ;retrieve before patient values
 ;buffer - get name
 K DG20NAME
 S BUFFER("NAME")=$$NCEDIT^DPTNAME(DFN,,.DG20NAME)
 I BUFFER("NAME")="" S BUFFER("NAME")=BEFORE("NAME")
 I $D(DG20NAME("FAMILY")) S BUFFER("FAMILY")=DG20NAME("FAMILY")
 I $D(DG20NAME("GIVEN")) S BUFFER("GIVEN")=DG20NAME("GIVEN")
 I $D(DG20NAME("MIDDLE")) S BUFFER("MIDDLE")=DG20NAME("MIDDLE")
 I $D(DG20NAME("SUFFIX")) S BUFFER("SUFFIX")=DG20NAME("SUFFIX")
 ; the formal name is last name, first name, middle name and suffix
 ; the prefix and degree are only stored in file 20
 I $D(DG20NAME("PREFIX")) S BUFFER("PREFIX")=DG20NAME("PREFIX")
 I $D(DG20NAME("DEGREE")) S BUFFER("DEGREE")=DG20NAME("DEGREE")
 K DG20NAME
 ;DG*5.3*688 BAJ if SSN is verified, do not allow edits
 I BEFORE("SSNV")="VERIFIED" D  G DOB
 . S BUFFER("SSN")=BEFORE("SSN")
 . W !,"SSN: "_BUFFER("SSN")
 . W !,"SOCIAL SECURITY NUMBER "_BUFFER("SSN")_" has been verified by SSA --NO EDITING"
 ;buffer - get ssn
 S DIR(0)="2,.09^^"
 S DA=DFN D ^DIR
 I $D(DIRUT) D CECHECK Q
 S BUFFER("SSN")=Y
 ;if SSN is pseudo, Pseudo SSN Reason is req. - DG*5.3*653, ERC
 I $G(BUFFER("SSN"))["P" D  I $D(DIRUT) D CECHECK Q
REAS . ;
 . N DGREA,DGQSSN,DIR
 . S DGQSSN=0
 . S DGREA=$P($G(^DPT(DFN,"SSN")),U)
 . S DIR(0)="2,.0906^^"
 . S DA=DFN
 . D ^DIR
 . I ($D(DUOUT)!($D(DTOUT))!($D(DIRUT))),($G(BUFFER("SSNREAS"))']"") D
 . . W !?10,"PSSN Reason Required if SSN is a Pseudo."
 . . I $G(BEFORE("SSN"))["P" G REAS
 . . I $G(BEFORE("SSN"))']"" G REAS
 . . S DIR(0)="YA",DIR("A")="          Delete Pseudo SSN?: ",DIR("?")="If the SSN is a Pseudo SSN there must be a Pseudo SSN Reason.",DIR("B")="YES"
 . . D ^DIR
 . . I Y=1 S BUFFER("SSN")=BEFORE("SSN"),DGQSSN=1,Y="" Q
 . . G REAS
 . I DGQSSN=1 Q
 . S BUFFER("SSNREAS")=Y
 . I $D(DIRUT)!('$D(BUFFER("SSN"))) D CECHECK Q
DOB ;buffer - get dob
 S DIR(0)="2,.03^^"
 S DA=DFN D ^DIR
 I $D(DIRUT) D CECHECK Q
 S BUFFER("DOB")=Y
SEX ;buffer - get sex
 S DIR(0)="2,.02^^"
 S DIR("A")="BIRTH SEX"   ; DG*5.3*907
 S DA=DFN D ^DIR
 K DIR("A")   ; DG*5.3*907
 I $D(DIRUT) D CECHECK Q
 S BUFFER("SEX")=Y
 ; DG*5.3*907 - begin of SIGI change in this section
SIGI ;buffer - get Self-Identified Gender Identity    ; DG*5.3*907
 S DIR(0)="SAB^M:Male;F:Female;TM:Transmale/Transman/Female-to-Male;TF:Transfemale/Transwoman/Male-to-Female;O:Other;N:individual chooses not to answer"
 S DIR("?",1)="Select the code that specifies the patient's preferred gender."
 S DIR("?",2)="This SELF IDENTIFIED GENDER value indicates the patient's view of"
 S DIR("?")="their gender identity, if they choose to provide it."
 S DIR("A")="SELF-IDENTIFIED GENDER IDENTITY: " S:$G(BEFORE("SIGI"))'="" DIR("B")=$$GET1^DIQ(2,+DFN_",",.024)
 D ^DIR
 K DIR("A"),DIR("B")
 I $D(DIRUT) S BUFFER("SIGI")=BEFORE("SIGI") D CECHECK Q
 S BUFFER("SIGI")=Y
 ; DG*5.3*907 - end-section of SIGI 
MBI ; buffer - get MBI (multiple birth indicator)
 S DIR(0)="2,994^^"
 S DA=DFN D ^DIR
 S BUFFER("MBI")=Y
 I $D(DIRUT) D CECHECK Q
CECHECK ;do catastrophic edit checks, alert, and save
 N DGCNT,DGCEFLG
 ;Compare before/buffer arrays, putting edits into save array.S DIR("A")="SELF IDENTIFIED GENDER IDENTITY"
 S DGCNT=$$AFTER(.BEFORE,.BUFFER,.SAVE)
 ;   DGCNT:  0  = no changes
 ;           1  = only one edit change, ok to save w/o CE message
 ;           >1 = more then 1 edit, give CE message
 I DGCNT>1 D  ;give CE message
 . S DGCEFLG=$$WARNING()
 . ;    DGCEFLG: 0  = exit without saving changes
 . ;             1  = send alert and save
 . I DGCEFLG=0 S DGCNT=0
 I DGCNT>0 D SAVE(DFN) I $D(DGCEFLG),DGCEFLG D ALERT
 Q
 ;
SAVE(DFN) ;store accepted/edited values into patient file
 N FDATA,DIERR
 I $D(SAVE("NAME")) S FDATA(2,+DFN_",",.01)=SAVE("NAME")
 I $D(SAVE("DOB")) S FDATA(2,+DFN_",",.03)=SAVE("DOB")
 I $D(SAVE("SEX")) S FDATA(2,+DFN_",",.02)=SAVE("SEX")
 I $D(SAVE("SSN")) S FDATA(2,+DFN_",",.09)=SAVE("SSN")
 I $D(SAVE("SSNREAS")) S FDATA(2,+DFN_",",.0906)=SAVE("SSNREAS")
 I $D(SAVE("MBI")) S FDATA(2,+DFN_",",994)=SAVE("MBI")
 I $D(SAVE("SIGI")) S FDATA(2,+DFN_",",.024)=SAVE("SIGI")   ; DG*5.3*907
 D FILE^DIE("","FDATA","DIERR")
 K FDATA,DIERR
 I '$D(^VA(20,DG20IEN)) S DG20IEN=$$GET1^DIQ(2,+DFN_",",1.01,"I")
 I $D(SAVE("NAME")) D
 .S FDATA(20,+DG20IEN_",",1)=BUFFER("FAMILY")
 .S FDATA(20,+DG20IEN_",",2)=BUFFER("GIVEN")
 .S FDATA(20,+DG20IEN_",",3)=BUFFER("MIDDLE")
 .S FDATA(20,+DG20IEN_",",5)=BUFFER("SUFFIX")
 .S XUNOTRIG=1
 .D FILE^DIE("","FDATA","DIERR")
 .K FDATA,DIERR
 I $D(BUFFER("PREFIX")) S FDATA(20,+DG20IEN_",",4)=BUFFER("PREFIX")
 I $D(BUFFER("DEGREE")) S FDATA(20,+DG20IEN_",",6)=BUFFER("DEGREE")
 I $D(SAVE("PREFIX")) S FDATA(20,+DG20IEN_",",4)=SAVE("PREFIX")
 I $D(SAVE("DEGREE")) S FDATA(20,+DG20IEN_",",6)=SAVE("DEGREE")
 D FILE^DIE("","FDATA","DIERR")
 K FDATA,DIERR
 Q
 ;
BEFORE(IEN,BEF,BUF) ;save original name, ssn, dob, sex, mbi, prefix, degree
 N DG20
 S BEF("NAME")=$$GET1^DIQ(2,+IEN_",",.01),BUF("NAME")=BEF("NAME")
 S BEF("SSN")=$$GET1^DIQ(2,+IEN_",",.09),BUF("SSN")=BEF("SSN")
 ;Get SSN Verification flag DG*5.3*688 BAJ 11/22/2005
 S BEF("SSNV")=$$GET1^DIQ(2,+IEN_",",.0907),BUF("SSNV")=BEF("SSNV")
 S BEF("SSNREAS")=$$GET1^DIQ(2,+IEN_",",.0906),BUF("SSNREAS")=BEF("SSNREAS")
 S BEF("DOB")=$$GET1^DIQ(2,+IEN_",",.03,"I"),BUF("DOB")=BEF("DOB")
 S BEF("SEX")=$$GET1^DIQ(2,+IEN_",",.02,"I"),BUF("SEX")=BEF("SEX")
 S BEF("MBI")=$$GET1^DIQ(2,+IEN_",",994,"I"),BUF("MBI")=BEF("MBI")
 S BEF("SIGI")=$$GET1^DIQ(2,+IEN_",",.024,"I"),BUF("SIGI")=BEF("SIGI")   ; DG*5.3*907
 D GETS^DIQ(2,+IEN_",",1.01,"I","DG20")
 S BEF("FAMILY")="",BEF("GIVEN")="",BUF("FAMILY")="",BUF("GIVEN")=""
 S BEF("MIDDLE")="",BEF("SUFFIX")="",BUF("MIDDLE")="",BUF("SUFFIX")=""
 S BEF("PREFIX")="",BEF("DEGREE")="",BUF("PREFIX")="",BUF("DEGREE")=""
 S DG20IEN=DG20(2,+IEN_",",1.01,"I")
 I $$GET1^DIQ(20,+DG20IEN_",",.03)[+IEN D
 . S BEF("FAMILY")=$$GET1^DIQ(20,+DG20IEN_",",1),BUF("FAMILY")=BEF("FAMILY")
 . S BEF("GIVEN")=$$GET1^DIQ(20,+DG20IEN_",",2),BUF("GIVEN")=BEF("GIVEN")
 . S BEF("MIDDLE")=$$GET1^DIQ(20,+DG20IEN_",",3),BUF("MIDDLE")=BEF("MIDDLE")
 . S BEF("SUFFIX")=$$GET1^DIQ(20,+DG20IEN_",",5),BUF("SUFFIX")=BEF("SUFFIX")
 . S BEF("PREFIX")=$$GET1^DIQ(20,+DG20IEN_",",4),BUF("PREFIX")=BEF("PREFIX")
 . S BEF("DEGREE")=$$GET1^DIQ(20,+DG20IEN_",",6),BUF("DEGREE")=BEF("DEGREE")
 ;add some demographic information (before snapshot)
 S BEF("MAIDEN")=$E($$GET1^DIQ(2,+IEN_",",.2403),1,17)
 S BEF("POBCITY")=$E($$GET1^DIQ(2,+IEN_",",.092),1,15)
 S BEF("POBSTATE")=$$GET1^DIQ(2,+IEN_",",.093,"I")
 Q
 ;
AFTER(BEF,BUF,SAV) ;prevent catastrophic edit checks
 N DGCNT,DG20CNT S (DGCNT,DG20CNT)=0
 I $D(BUF("FAMILY")),BUF("FAMILY")'="",BUF("FAMILY")'=BEF("FAMILY") D
 . S DG20CNT=DG20CNT+1
 . S SAV("NAME")=BUF("NAME")
 I $D(BUF("GIVEN")),BUF("GIVEN")'="",BUF("GIVEN")'=BEF("GIVEN") D
 . S DG20CNT=DG20CNT+1
 . S SAV("NAME")=BUF("NAME")
 I $D(BUF("MIDDLE")),BUF("MIDDLE")'=BEF("MIDDLE") D
 . S SAV("NAME")=BUF("NAME") ; minor change doesn't count
 I $D(BUF("SUFFIX")),BUF("SUFFIX")'=BEF("SUFFIX") D
 . S SAV("NAME")=BUF("NAME") ; minor change doesn't count
 I DG20CNT>0 S DGCNT=1
 I $D(BUF("PREFIX")),BUF("PREFIX")'=BEF("PREFIX") D
 . S SAV("PREFIX")=BUF("PREFIX")
 I $D(BUF("DEGREE")),BUF("DEGREE")'=BEF("DEGREE") D
 . S SAV("DEGREE")=BUF("DEGREE")
 I $D(BUF("SIGI")),BUF("SIGI")'="",BUF("SIGI")'=BEF("SIGI") D   ; DG*5.3*907
 . S SAV("SIGI")=BUF("SIGI")                                    ; DG*5.3*907
 I $D(BUF("DOB")),BUF("DOB")'="",BUF("DOB")'=BEF("DOB") D
 . S SAV("DOB")=BUF("DOB"),DGCNT=DGCNT+1
 I $D(BUF("SEX")),BUF("SEX")'="",BUF("SEX")'=BEF("SEX") D
 . S SAV("SEX")=BUF("SEX"),DGCNT=DGCNT+1
 I $D(BUF("SSN")),BUF("SSN")'="",BUF("SSN")'=BEF("SSN") D
 . S SAV("SSN")=BUF("SSN"),DGCNT=DGCNT+1
 I $D(BUF("SSNREAS")),BUF("SSNREAS")'="",BUF("SSNREAS")'=BEF("SSNREAS") D
 . S SAV("SSNREAS")=BUF("SSNREAS")
 I $D(BUF("MBI")),BUF("MBI")'=BEF("MBI") D
 . S SAV("MBI")=BUF("MBI")
 I DGCNT=0,$D(SAV("NAME")) Q 1 ;minor name change (i.e. middle name or suffix)
 I DGCNT=0,$D(SAV("PREFIX"))!($D(SAV("DEGREE"))) Q 1 ; prefix or degree change
 I DGCNT=0,$D(SAV("MBI")) Q 1 ; multiple birth indicator change
 I DGCNT=0,$D(SAV("SIGI")) Q 1  ; DG*5.3*907 - Add SIGI indicator change
 I DGCNT=0 Q 0 ;no changes
 ;DG*750 check audit file for previous changes made during the current day
 I DGCNT=1 D DGAUD^DGRPAUD(DFN,.DGCNT)
 ;Use temp file created in DGRPAUD to get information for other changes
 ;that were made during the day to print on the alert.
 N DGAUDIEN,DGFLD,DGTYP
 S DGAUDIEN=0
 F   S DGAUDIEN=$O(^TMP("DGRPAUD",$J,DFN,DGAUDIEN)) Q:'DGAUDIEN  D
 .S DGFLD=$P(^TMP("DGRPAUD",$J,DFN,DGAUDIEN),U,2),DGTYP=$P(^TMP("DGRPAUD",$J,DFN,DGAUDIEN),U,5)
 .I DGFLD=.01 S BEF("NAME")=DGTYP
 .I DGFLD=.09 S BEF("SSN")=DGTYP
 .I DGFLD=.02 S BEF("SEX")=DGTYP
 .I DGFLD=.03 S BEF("DOB")=DGTYP
 .I DGFLD=.024 S BEF("SIGI")=DGTYP    ; DG*5.3*907
 I DGCNT<2 Q 1 ;make one change w/o CE message
 I DGCNT>1 Q 2 ;more than 1 change, send CE message
 K ^TMP("DGRPAUD")
 ;
WARNING() ;CE warning message
 ;Output     0  = exit without saving changes
 ;           1  = send alert and save
 W !!,?25,"**WARNING!!**"
 W !!,"The edits you are about to make, may potentially change the identity of"
 W !,"this patient.  Please verify that you have selected the correct patient"
 W !,"and ensure that supporting documentation exists for these changes.  If"
 W !,"you continue with these edits, an alert will be generated and sent to"
 W !,"your Supervisor and ADPAC, notifying them of the changes."
 N DIR,DGANS,Y
 S DIR(0)="Y",DIR("A")="Do you wish to continue and save your edits:"
 S DIR("B")="NO" D ^DIR K DIR S DGANS=Y
 S DGANS=$S(Y=1:1,1:0) ;0=don't save, 1=save with CE alert
 Q DGANS
 ;
ALERT ;Queue alert
 X ^%ZOSF("UCI") S ZTUCI=Y,ZTRTN="ALERT^DGRPECE1",ZTDTH=$H,ZTIO="",IEN=DFN
 F V="IEN","BEFORE(","BUFFER(","SAVE(","XQY" S ZTSAVE(V)=""
 S ZTDESC="Patient Catastrophic Edits alert" K V,ZTSK N X D ^%ZTLOAD  Q
 ;D ALERT^DGRPECE1(DFN,.BEFORE,.BUFFER,.SAVE)
 Q
