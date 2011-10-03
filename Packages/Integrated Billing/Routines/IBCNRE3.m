IBCNRE3 ;DAOU/DMK - Edit PHARMACY BENEFITS MANAGER (PBM) APPLICATION Sub-file ;23-DEC-2003
 ;;2.0;INTEGRATED BILLING;**251**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ; Specific to E-PHARM APPLICATION Entry
 ; Edit LOCAL ACTIVE? Field
 ;
 ; 366.023 PHARMACY BENEFITS MANAGER (PBM) APPLICATION
 ;    .01  APPLICATION
 ;    .03  LOCAL ACTIVE?
 ;
1000 ; Control processing
 N ANAME,APIEN,FIELDNO,FILENO,FILENO1,QUIT
 N DISYS
 ;
 D INIT1
 D HEADING
 F  D 2000 Q:QUIT
 Q
 ;
2000 ; Control processing
 N IEN,IENS,IENS1,KEY
 ;
 S QUIT=0
 ;
 ; Control file entry selection and subfile entry validation
 D IEN
 I IEN=-1 S QUIT=1 Q
 I APIEN=-1 Q
 ;
 ; Control file entry printing
 D PRINT1
 ;
 ; Control subfile entry printing
 D PRINT2
 ;
 ; Control subfile entry editing
 D EDIT
 Q
 ;
EDIT ; Edit subfile entry data
 ; 366.023 PHARMACY BENEFITS MANAGER (PBM) APPLICATION Subfile
 ;
 N DA,DIDEL,DIC,DIE,DLAYGO,DR,DTOUT,X,Y
 N %,A,D,D0,DDER,DI,DISYS,DQ,OLD
 ;
 S DA=APIEN,DA(1)=IEN
 S DIE=$$ROOT^DILFD(FILENO1,","_IEN_",")
 ;
 ; .03  LOCAL ACTIVE
 S DR=".03R"_"~"_KEY_" - Local Active?"
 ;
 ; Quit if value unchanged
 ; OLD = old value
 ;   X = new value
 S OLD=$$GET1^DIQ(FILENO1,IENS1,.03,"I")
 S DR=DR_";"_"S:OLD=X Y="""""
 ;
 ; .04  USER EDITED LOCAL
 S DR=DR_";"_".04////"_DUZ
 ;
 ; .05  DATE/TIME LOCAL EDITED
 S DR=DR_";"_".05////"_$$NOW^XLFDT()
 ;
 D ^DIE
 ;
 W !
 Q
 ;
HEADING ; Print heading
 W @IOF
 W "PHARMACY BENEFITS MANAGER (PBM) File Inquiry and Edit (E-PHARM)",!
 Q
 ;
IEN ; Select file entry
 N I
 ;
 S IEN=$$SELECT1^IBCNRFM1(FILENO,"Select Pharmacy Benefits Manager (PBM) Name: ")
 I IEN=-1 Q
 S IENS=IEN_","
 ;
 ; E-PHARM APPLICATION Defined?
 S APIEN=$$LOOKUP2^IBCNRFM1(FILENO,IEN,FIELDNO,ANAME)
 I APIEN=-1 W " E-PHARM APPLICATION not defined" Q
 S IENS1=APIEN_","_IEN_","
 Q
 ;
INIT1 ; Initialize variables
 S ANAME="E-PHARM"
 S FIELDNO=3
 S FILENO=366.02
 S FILENO1=FILENO_FIELDNO
 I '$D(IOF) D HOME^%ZIS
 Q
 ;
PRINT1 ; Print file entry data
 ; 366.02 PHARMACY BENEFITS MANAGER (PBM) File
 ;
 N A
 ;
 W !!
 ;
 D GETS^DIQ(FILENO,IENS,"*","","A")
 ;
 ; .01 NAME
 S KEY=A(FILENO,IENS,.01)
 W $J("Pharmacy Benefits Manager (PBM) Name: ",40),$G(A(FILENO,IENS,.01)),!
 ;
 ; .02 DATE/TIME CREATED
 W $J("Date/Time Created: ",40),$G(A(FILENO,IENS,.02)),!
 Q
 ;
PRINT2 ; Print subfile entry data
 ; 366.023 PHARMACY BENEFITS MANAGER (PBM) APPLICATION Subfile
 ;
 N A
 ;
 W !
 ;
 D GETS^DIQ(FILENO1,IENS1,"*","","A")
 ;
 ; .01 APPLICATION
 W $J("Application: ",40),$G(A(FILENO1,IENS1,.01)),!
 ;
 ; .13 DATE/TIME CREATED
 W $J("Date/Time Created: ",40),$G(A(FILENO1,IENS1,.13)),!
 ;
 ; .11 DEACTIVATED
 W $J("Deactivated? ",40),$G(A(FILENO1,IENS1,.11)),!
 ;
 ; .12 DATE/TIME DEACTIVATED
 W $J("Date/Time Deactivated: ",40),$G(A(FILENO1,IENS1,.12)),!
 ;
 ; .02 NATIONAL ACTIVE
 W $J("National Active? ",40),$G(A(FILENO1,IENS1,.02)),!
 ;
 ; .06 DATE/TIME NATIONAL EDITED
 W $J("Date/Time National Edited: ",40),$G(A(FILENO1,IENS1,.06)),!
 ;
 ; .03 LOCAL ACTIVE
 W $J("Local Active? ",40),$G(A(FILENO1,IENS1,.03)),!
 ;
 ; .05 DATE/TIME LOCAL EDITED
 W $J("Date/Time Local Edited: ",40),$G(A(FILENO1,IENS1,.05)),!
 ;
 ; .04 USER EDITED LOCAL
 W $J("User Edited Local: ",40),$G(A(FILENO1,IENS1,.04)),!
 Q
