DGFFP01 ; ALB/SCK - FUGITIVE FELON PROGRAM ROUTINE ; 11/08/2002
 ;;5.3;Registration;**485**;Aug 13, 1993
 ;
 Q
 ;
GETPAT(ACTION) ;  Retrieve patient name
 N DIR,Y,X,DIRUT,RSLT
 ;
 S ACTION=$G(ACTION)
 S RSLT=-1
 S DIR(0)="PAO^2:EMZ"
 S DIR("A")="Select Patient: "
 S DIR("?")="Enter the name of a patient to update the Fugitive Felon Flag for."
 I ACTION S DIR("S")="I $P($G(^DPT(Y,""FFP"")),U,1)=1"
 D ^DIR K DIR
 ;
 I $D(DIRUT)
 E  S:+Y RSLT=Y
 Q RSLT
 ;
CONT() ;  Query to continue processing
 N DIR,Y,X
 ;
 S DIR(0)="YA"
 S DIR("A",1)=""
 S DIR("A")="Process another felon entry? "
 S DIR("B")="YES"
 S DIR("?")="Enter 'YES' to continue processing, 'NO' to exit."
 D ^DIR K DIR
 Q +$G(Y)
 ;
CONFIRM(DGACT,DGPAT) ; Query to confirm set/clear the fugitive felon flag
 N DIR,DIRUT,X,Y,DGABRT
 ;
 I "S"[DGACT D  I $G(DGABRT) Q 0
 . I $D(^DPT("AXFFP",1,+DGPAT)) D  Q
 . . W !?2,"The Fugitive Felon Flag is already set..."
 . . S DGABRT=1
 . S DIR("A",1)=""
 . S DIR("A",2)="  >> This will set the Fugitive Felon Flag for "_$P(DGPAT,U,2)_"."
 . S DIR("A")="  >> Continue with setting the flag? "
 . S DIR("?")="Enter 'YES' to set the flag, 'NO' to skip."
 ;
 I "C"[DGACT D
 . S DIR("A",1)=""
 . S DIR("A",2)="  >> This will clear the Fugitive Felon Flag for "_$P(DGPAT,U,2)_"."
 . S DIR("A")="  >> Continue with clearing the flag? "
 . S DIR("?")="Enter 'YES' to set the flag, 'NO' to skip."
 ;
 S DIR(0)="YA",DIR("B")="NO"
 D ^DIR K DIR
 Q $G(Y)
 ;
SETFLAG ;  Set the Fugitive Felon Flag
 N DGPAT,DGFDA,DGERR
 ;
SET1 S DGPAT=$$GETPAT
 I +DGPAT<0 G QSET
 I $$CONFIRM("S",DGPAT) D
 . S DGFDA(1,2,+DGPAT_",",1100.01)=1
 . D FILE^DIE("","DGFDA(1)","DGERR")
 . I $D(DGERR) D MSG^DIALOG("EAW","",70,5,"DGERR")
 ;
 I '$$CONT G QSET
 G SET1
QSET Q
 ;
CLRFLAG ;  Clear the Fugitive Felon Flag
 N DGPAT,DGFDA,DGERR
 ;
CLR1 S DGPAT=$$GETPAT(1)
 I +DGPAT<0 G QCLR
 I $$CONFIRM("C",DGPAT) D
 . S DGFDA(1,2,+DGPAT_",",1100.01)="@"
 . D FILE^DIE("","DGFDA(1)","DGERR")
 . I $D(DGERR) D MSG^DIALOG("EAW","",70,5,"DGERR")
 ;
 I '$$CONT G QCLR
 G CLR1
QCLR Q
 ;
DD(DFN) ;  CALLED BY AUFFP X-REF ON THE FUGITIVE FELON FLAG FIELD
 ; #1100.01 IN THE PATIENT FILE #2.
 ;
 ; This procedure will set the following fields:
 ;  FFF ENTERED BY, Field #1100.02 
 ;  FFF DATE ENTERED, Field #1100.03
 ;  FFF REMOVED BY, Field 1100.04
 ;  FFF DATE REMOVED,, Field 1100.05
 ;  FFF REMOVAL REMARKS, Field 1100.09
 ;
 ; Check Input
 I +$G(DFN),$D(^DPT(DFN,0))
 E  Q
 ;
 N DGFDA,DGIEN,DGOLD
 ;
 S DGIEN=DFN_","
 S DGOLD=$G(^DPT(DFN,"FFP"))
 I +DGOLD D
 . I $P(DGOLD,"^",2)>0
 . E  D
 . . S DGFDA(1,2,DGIEN,1100.02)=DUZ
 . . S DGFDA(1,2,DGIEN,1100.03)=$$NOW^XLFDT
 . I $P(DGOLD,"^",4)>0 D
 . . S DGFDA(1,2,DGIEN,1100.04)="@"
 . . S DGFDA(1,2,DGIEN,1100.05)="@"
 . . S DGFDA(1,2,DGIEN,1100.09)="@"
 E  D
 . ;S DGFDA(1,2,DGIEN,1100.02)="@"
 . ;S DGFDA(1,2,DGIEN,1100.03)="@"
 . S DGFDA(1,2,DGIEN,1100.04)=DUZ
 . S DGFDA(1,2,DGIEN,1100.05)=$$NOW^XLFDT
 . S DGFDA(1,2,DGIEN,1100.09)=$$RMRK
 ;
 D:$D(DGFDA) FILE^DIE("","DGFDA(1)")
 Q
 ;
RMRK() ;
 N DIR
 ;
AGN S DIR(0)="FA",DIR("A",1)="  >> Enter a brief remark on why this flag is being cleared."
 S DIR("A",2)="  >> This is a required field."
 S DIR("A")="  --> "
 S DIR("?",1)="  Remark must be between 2-80 characters.  Please be brief"
 S DIR("?")="  This field is required when clearing the Fugitive Felon Flag"
 D ^DIR K DIR
 I $L(Y)>80!($L(Y)<2) K Y G AGN
 Q $G(Y)
