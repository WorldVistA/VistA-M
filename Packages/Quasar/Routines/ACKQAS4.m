ACKQAS4 ;HCIOFO/AG - Delete a Quasar Visit ; 04/01/99
 ;;3.0;QUASAR;;Feb 11, 2000
 ;Per VHA Directive 10-93-142, this routine SHOULD NOT be modified.
 ;
 N DIC,X,Y,ACKVIEN,DFN,ACKPAT,VADM,ACKPATNM,ACKPATSS,ACKCLNNM,ACKDIVNM
 N ACKDATE,ACKTM,ACKTIME,ACKPIEN,ACKP,ACKIFACE,ACKPCES,ACKDIV,ACKVDT
 N ACKPCED,ACKPCEDT,DIR,ACKOK,ACKARR
 ;
OPTN ;  Introduce option.
 W @IOF
 W !!,"This option is used to DELETE an existing A&SP Clinic Visit.",!!
 ;
DATE ;  Enter date
 W !
 S DIC("W")="W $$DISPLAY^ACKQUTL3(Y,$X)"
 S DIC=509850.6,DIC(0)="AEQZ" D ^DIC
 I X?1"^"1.E W !,"Jumping not allowed.",! G DATE
 G:Y<0 EXIT
 G:$D(DIRUT) EXIT
 ;
 ; set visit ien variable
 S ACKVIEN=+Y
 ;
 ; Attempt to Lock record if lock fails display error and re-prompt
 L +^ACK(509850.6,ACKVIEN):2 I '$T D  G DATE
 . W !!,"This record is locked by another process - Please try again later.",!!
 ;
 ; display summary details about the visit
 S (DFN,ACKPAT)=+$$GET1^DIQ(509850.6,ACKVIEN_",",1,"I")
 D DEM^VADPT
 S ACKPATNM=VADM(1)
 S ACKPATSS=$P(VADM(2),U,2)
 S ACKCLNNM=$$GET1^DIQ(509850.6,ACKVIEN_",",2.6,"E") ; clinic external
 S ACKDIVNM=$$GET1^DIQ(509850.6,ACKVIEN_",",60,"E")  ; division external
 S ACKDATE=$$GET1^DIQ(509850.6,ACKVIEN_",",.01,"E")  ; date external
 S ACKTM=$$GET1^DIQ(509850.6,ACKVIEN_",",55,"I"),ACKTIME=$$FMT^ACKQUTL6(ACKTM,0)
 S ACKPIEN=$$GET1^DIQ(509850.6,ACKVIEN_",",125,"I")  ; pce visit ien
 S ACKP=$S(ACKPIEN:".",1:"") ; pce flag
 W !!?2," Patient: ",$E(ACKPATNM,1,35)
 W ?48,"             SSN: ",ACKPATSS
 W !?2,"  Clinic: ",$E(ACKCLNNM,1,35)
 W ?48,"      Visit Date: ",$E(ACKDATE,1,12)
 W !?2,"Division: ",$E(ACKDIVNM,1,35)
 W ?48,"Appointment Time: ",ACKTIME_ACKP
 W !
 ;
 ; determine whether the PCE Interface is ON
 S ACKIFACE=0
 S ACKPCES=$$GET1^DIQ(509850.8,"1,",2,"I")
 S ACKDIV=$$GET1^DIQ(509850.6,ACKVIEN_",",60,"I")
 S ACKVDT=$$GET1^DIQ(509850.6,ACKVIEN_",",.01,"I")
 S ACKPCED=$$GET1^DIQ(509850.83,ACKDIV_",1,",.03,"I")
 S ACKPCEDT=$$GET1^DIQ(509850.83,ACKDIV_",1,",.08,"I")
 ; if Site switch is ON and Division switch is ON and Visit Date is
 ;  after PCE Interface Start Date, then Interface is ON.
 I ACKPCES=1,ACKPCED=1,ACKVDT'<ACKPCEDT S ACKIFACE=1
 ;
 ; if interface is not on, but visit has a PCE Visit IEN, then display warning
 I ACKIFACE=0,ACKPIEN D WARNING
 ;
DELETE ; ask user to confirm the deletion
 S DIR(0)="Y",DIR("B")="NO"
 S DIR("A")="Do you wish to DELETE this Visit from QUASAR"
 D ^DIR
 I $D(DTOUT) G EXIT   ; timed out
 I $D(DUOUT) G EXIT   ; user exited
 I Y?1"^"1.E W !,"Jumping not allowed.",! G DELETE
 I Y=0 G EXIT         ; user chose not to delete
 W !
 ;
 ; if the interface is not on, or the visit does not exist in PCE
 ;  then proceed with deletion from QUASAR
 I (ACKIFACE=0)!('ACKPIEN) G DOIT
 ;
DELPCE ; call the function to delete the visit from PCE
 S ACKOK=$$KILLPCE^ACKQPCE(ACKVIEN)
 ;
 ; if deletion succeeded then jump to deletion point
 I ACKOK G DOIT
 ;
FAILED ; if deletion failed then display errors
 W !!?2,"ERROR: The PCE Visit linked to this QUASAR Visit could not be deleted."
 W !!?2,"If you choose to continue, the QUASAR visit will be deleted but the PCE Visit"
 W !?2,"will remain. Corrective action to the PCE Visit will be required using the"
 W !?2,"PCE System.",!
 ;
CONFIRM ; prompt whether to continue
 S DIR(0)="Y",DIR("B")="NO"
 S DIR("A")="Do you wish to DELETE just the QUASAR Visit"
 D ^DIR
 I $D(DTOUT) G EXIT   ; timed out
 I $D(DUOUT) G EXIT   ; user exited
 I Y?1"^"1.E W !,"Jumping not allowed.",! G CONFIRM
 I Y=0 G EXIT         ; user chose to exit
 ;
DOIT ; ok - delete the visit from Quasar
 K ACKARR
 S ACKARR(509850.6,ACKVIEN_",",.01)="@"
 D FILE^DIE("","ACKARR","")
 W !?10,"* * * Visit deleted from QUASAR. * * *",!
 ; now update the problem list for the patient
 D PROBLIST^ACKQUTL3(ACKPAT,1)
 ;
 ; all done
EXIT ;
 ; unlock
 L
 ;
 ; clean up all variables
 K DIC,Y,ACKVIEN,DFN,ACKPAT,ACKPATSS,VADM,ACKPATNM,ACKCLNNM,ACKDIVNM
 K ACKDATE,ACKTM,ACKTIME,DIR,ACKOK,ACKARR,ACKP
 Q
 ;
WARNING ; display a warning to the user that the interface is not on so this
 ; deletion will not be replicated in the PCE database.
 W !?2,"WARNING - This QUASAR Visit is linked to a PCE Visit but the PCE Interface"
 W !?2,"is not active. If you delete this visit, it will be deleted from QUASAR but"
 W !?2,"the corresponding PCE Visit will remain. To delete the visit from PCE you"
 W !?2,"must use the PCE package options.",!
 Q
 ;
