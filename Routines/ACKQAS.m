ACKQAS ;AUG/JLTP BIR/PTD HCIOFO/BH-New Clinic Visits ;  04/01/99 
 ;;3.0;QUASAR;**1,10,15**;Feb 11, 2000;Build 2
 ;Call DEM^VADPT supported by DBIA #10061
 ;
 ;Per VHA Directive 10-93-142, this routine SHOULD NOT be modified.
 ;
IVD ;  INITIAL VISIT DATE  ** TRIGGERED FROM PATIENT NAME ***
 N Y,DDD,DD,DFN,D0,%DT
 S DFN=X,X=$S('$D(^ACK(509850.2,DFN,0)):"",'$P(^(0),U,2):"",1:$P(^(0),U,2))
 I 'X D
 . F  D  Q:X=""!(X'>DT)
 .. S Y=ACKVD D DD^%DT S %DT="AEP",%DT("A")="INITIAL VISIT DATE: "
 .. S %DT("B")=Y D ^%DT K %DT S X=$S(Y<1:"",1:Y)
 .. I X>DT W !,"No Future Dates Allowed",!
 K A1
 Q
 ;
VISIT ;  New visit data input
 N ACKOUT
 I '$O(^ACK(509850.8,0)) W !,"A&SP site parameters must be established before visits can be entered.",! Q
 ;
 D LIST^DIC(509850.83,",1,",".01","I","*","","","","","","ACKTRGT","ACKMSG")
 I '$P($G(ACKTRGT("DILIST",0)),U,1) W !,"No Divisions have been set up select the Site Parameters function to set up",!,"Division entries.",! Q
 ;
 ;  Get the Division
DIV ;
 I $D(ACKDVN),$D(CLINVARR),$P($G(ACKDVN),U,2)=1,$G(CLINVARR)<2 G VEXIT
 D VEXIT
 S ACKDVN=$$DIV^ACKQUTL2(1,.ACKDIV) G:$P(ACKDVN,U,1)="0" VEXIT
 I '$P(ACKDVN,U,2) W !!!!!,"No Active Divisions Set up on Site Parameters File" W ! H 1 G VEXIT
 S ACKDIV=$O(ACKDIV("")),ACKDIV=$P(ACKDIV(ACKDIV),U,1)  ;  use division IEN of Parameter file   
 I $P(ACKDVN,U,2)>1 W "            Station Number : "_$$GET1^DIQ(40.8,ACKDIV,1)
 ;
 ;  Get clinic
CLIN S ACKCLIN=$$CLIN^ACKQASU1(ACKDIV,"U") G:ACKCLIN=""&($P($G(ACKDVN),U,2)=1) VEXIT  G:ACKCLIN="" DIV
 I ACKCLIN=0 W !!!!!,"No Clinics set up for Division " W ! H 1 G DIV
 S ACKCLIN=$P(ACKCLIN,U,1)  ;  Use clinic IEN from Clinic file
 ;  Get Clinic stop code
 D STOP
 ;
 W !!!,"Clinic: ",$$GET1^DIQ(44,ACKCLIN,.01),"          Stop Code: ",ACKCSC(1)
 ;
 ;  Get visit date
VDATE S DIR(0)="D^:DT:AEX",DIR("A")="Enter Visit Date",DIR("B")="TODAY"
 S DIR("?")="Enter the visit date or press return for TODAY. Future dates not allowed",DIR("??")="^D HELP^%DTC"
 D ^DIR K DIR I X?1"^"1.E W !,"Jumping not allowed." G VDATE
 G:$D(DIRUT) DIV
 S ACKVD=Y
 ;
 ;
PATIENT S DIC="^ACK(509850.2,",DIC(0)="AEMQL",DLAYGO=509850.2
 S DIC("W")="N ACKA,ACKB S ACKA=$$GET1^DIQ(2,Y,.03),ACKB=$$GET1^DIQ(2,Y,.09),ACKA=$E(ACKA,1,2)_""-""_$E(ACKA,4,5)_""-""_$E(ACKA,9,10) W ?36,ACKA_""     ""_ACKB"
 S ACKLAYGO="" D ^DIC I X?1"^"1.E W !,"Jumping not allowed." G PATIENT
 G:$D(DTOUT) DIV
 I X="^" G DIV
 I Y<0 W !,"This is a required response. Enter '^' to exit" G PATIENT
 S (ACKPAT,DFN)=+Y
 S ACKDFN=DFN
 ;; ACKQ*3*10  ADD CHECK FOR DECEASED PATIENT
 S ACKOUT=0
 D CHKDTH
 I ACKOUT=1 S ACKOUT=0 G PATIENT
 ;; END ACKQ*3*10
 ;  Check to see if Patient has a Primary Eligibility
 I '$$ELIGCHK^ACKQASU W !!,"DATA ERROR : Patient has no Primary Eligibility defined on the Patient File.",!,"This requires updating before QUASAR processing can commence.",! D VEXIT G DIV
 ;
 ; check for duplicate visits (same date/same patient) allow user to select one
 S ACKVSEL=$$DUPCHK^ACKQASU1(ACKPAT,ACKVD) G:ACKVSEL=-1 DIV
 S (DA,ACKY)=ACKVSEL  ; either 0 (no visit selected) or selected visit ien
 ;
 S (ACKFLG1,ACKFLG2)=0 I DA D  I (ACKFLG1)!(ACKFLG2) D VEXIT G VISIT
 .;  Compare clinic location/stop code of selected visit with
 .;  original clinic location/stop code.
 .S ACKESITE=$P($G(^ACK(509850.6,ACKY,0)),U,6),ACKECSC=$P($G(^ACK(509850.6,ACKY,2)),U)
 .I ACKESITE'=ACKCLIN S ACKFLG1=1
 .I ACKECSC'=ACKCSC S ACKFLG2=1
 .I (ACKFLG1)!(ACKFLG2) K DA D
 ..W !!,"The "_$S(ACKFLG1:"clinic location",1:"clinic stop code")_" for the selected appointment does not match",!,"the current "_$S(ACKFLG1:"clinic location",1:"clinic stop code")_".  Transaction not allowed.",!
 ;
 ; Get PCE flag - 1 if division set to send to PCE else 0
 S ACKPCE=$$PCE^ACKQUTL4(ACKDIV,ACKVD)
 ;
 ;  Existing A&SP Patient
 I DA D EDIT^ACKQAS5 G VISIT
 ;
 ;  New visit
 K DD,DO,DA,D0
 S ACKVISIT="NEW",ACKVTME=""   ;  indicates this is a new visit
 ;             
 ; If PCE interface not on skip to Call Template logic
 I 'ACKPCE S ACKVTME="" G FILE
 ;
PCE ;  Select a PCE visit
 ;
 ;  Run function to check if there is a PCE visit for today
 I '$$PCEVST1^ACKQASU1(ACKVD,ACKPAT,ACKCLIN) G APPMNT
 ;
 ;  As PCE visits must exist on the visit date run the API that displays
 ;  them and prompts the user to either select one or add a new visit.
 S ACKPCENO=$$VISITLST^PXAPI(ACKPAT,ACKVD,ACKVD,ACKCLIN,"APO","","A")
 I ACKPCENO="-1" G DIV  ;  Go back to Division prompt if '^' entered
 S ACKVTME=""
 ;  I ACKPCENO="A" 'ADD' selected user wishes to create new visit
 I ACKPCENO'="A" G FILE
 ;
APPMNT ;  Check for any appointments for the patient on this date.
 S VASD("C",ACKCLIN)="",VASD("T")=ACKVD,VASD("F")=ACKVD
 S VASD("W")="129"
 K ^UTILITY("VASD",$J) D SDA^VADPT
 I '$D(^UTILITY("VASD",$J)) G FILE  ;  If no appointments goto PCE check
 ;
 ;  Displays headings and appointments
 ;
 D DISP^ACKQASU
 ;
 ;  User is prompted to choose or create a new visit.
 ;
APPMNT1 S ACKNUM=$O(^UTILITY("VASD",$J,""),-1)
 S DIR("A")=" Select Appointment (1-"_ACKNUM_") or (N)ew Visit "
 S DIR("B")=1
 S DIR("?")=" Select number on left of the list or 'N' for New Visit"
 S DIR(0)="F^1:2^S:X=""n"" X=""N"" K:X'=""N""&((+X<1)!(+X>ACKNUM)) X"
 D ^DIR K DIR,ACKNUM
 I X?1"^"1.E W !,"Jumping not allowed." G APPMNT1
 G:$D(DIRUT) DIV  ;  Go back to division if '^' entered.
 ;
 I X'="N"&(X'="n") S X=+X,ACKVTME=$P(^UTILITY("VASD",$J,X,"I"),U,1),ACKVTME=$P(ACKVTME,".",2),ACKAPMNT=1
 K ^UTILITY("VASD",$J)
 ;
FILE ; Set up dummy record and run input template 
 ;
 ; If Appointment Time is not yet known, but a PCE Visit was selected, get the time
 I ACKVTME="",ACKPCE,$G(ACKPCENO)'="",$G(ACKPCENO)'="A" D
 . S ACKVTME=$$GETPCETM^ACKQASU(ACKPCENO),ACKVTME=$P($P(ACKVTME,U,1),".",2)
 . I 'ACKVTME S ACKVTME="" Q
 ;
 I ACKPCE,$G(ACKAPMNT)'=1,'$$ACKAPMNT^ACKQASU7(ACKVD,ACKVTME,ACKCLIN,ACKPAT) D VEXIT,HEADING G VISIT
 K ACKAPMNT
 ;
 ;  Check to see if entry is on 'APCE' cross ref. if so either return to 
 ;  Division prompt or null out appointment time variable. 
 I ACKVTME'="",$D(^ACK(509850.6,"APCE",ACKPAT,ACKCLIN,ACKVD,"."_ACKVTME)) D  I 'ACKQCHK D UNLOCK,VEXIT,HEADING G VISIT
 . S ACKQCHK=$$DUPEDATA^ACKQASU(ACKPAT,ACKCLIN,ACKVD,"."_ACKVTME)
 . I 'ACKQCHK Q
 . ; user has decided to continue, so TIME is deleted and PCE VISIT is deleted
 . ; this ensures that the visit is treated as brand new when sent to PCE
 . S ACKVTME=""   ; time
 . S ACKPCENO=""  ; pce visit ien
 ;
 ; create new visit entry
 ;
 S DIC="^ACK(509850.6,",DIC(0)="L",DLAYGO=509850.6,ACKLAYGO=""
 S X=ACKVD D FILE^DICN,CHKDT  ;  File a dummy record prior to template
 S ACKVIEN=+$P(Y,U,1)         ; Get visit IEN from Y value.
 ;
 K ACKARR
 S ACKARR(509850.6,ACKVIEN_",",2.6)=ACKCLIN
 S ACKARR(509850.6,ACKVIEN_",",60)=ACKDIV
 I +ACKVTME S ACKARR(509850.6,ACKVIEN_",",55)="."_ACKVTME        ; file time if known
 I +$G(ACKPCENO)'=0 S ACKARR(509850.6,ACKVIEN_",",125)=ACKPCENO  ; file PCE number if one selected
 D STOP S ACKARR(509850.6,ACKVIEN_",",4)=ACKCSC                  ; file visit stop (required by COPYPCE)
 D FILE^DIE("","ACKARR")
 ;
 ; Lock the record
 L +^ACK(509850.6,ACKVIEN)
 ;
 ;  Write away any derived PCE values to visit record 
 I ACKPCE,$G(ACKPCENO)'="",$G(ACKPCENO)'="A" D  I +ACKERR D DEL,UNLOCK,VEXIT,HEADING G VISIT
 . S ACKERR=$$COPYPCE^ACKQASU4(ACKVIEN,ACKPCENO)
 . ; if error found, display and reset ACKERR according to whether the 
 . ; user wants to continue (SHOWPCE returns 1=exit,0=continue)
 . I +ACKERR S ACKERR=$$SHOWPCE^ACKQASU7($NA(^TMP("ACKQASU4",$J,"COPYPCE","ERROR")))
 ;
 ;
TPLATE ;   Call template
 S DIE="^ACK(509850.6,",(DA,ACKDA)=ACKVIEN,DR="[ACKQAS VISIT ENTRY]" D ^DIE
 ;
 K ACKREQ
 I $G(ACKLOSS)'="",$$AUDIO^ACKQUTL4 D UTLAUD^ACKQASU2
 S ACKQTST=$$POST^ACKQASU2(ACKVIEN) I 'ACKQTST S ACKDFN=DFN G TPLATE
 I ACKPCE,ACKQTST=1 I '$$PCESEND^ACKQASU3(ACKVIEN) S ACKDFN=DFN G TPLATE
 D UNLOCK,VEXIT,HEADING G VISIT
 ;
VEXIT ;  Kill off variables at end of processing
 ;
 D KILL^ACKQASU
 D KILL^%ZISS
 Q
 ;
AOA ;  COMPUTE AGE ON APPOINTMENT DATE
 N DFN,VA,VADM,VAERR,X1,X2 S DFN=$P(^ACK(509850.6,D0,0),U,2),X1=$P(^(0),U) D DEM^VADPT S X2=+VADM(3),X=X1-X2\10000
 Q
 ;
CHKDT ;
 S ACKMON=$E(X,1,5) S ACKGEN=$S($D(^ACK(509850.7,ACKMON,0)):^(0),1:"")
 Q:'$L(ACKGEN)  I $P(ACKGEN,U,4) W !!,$C(7),"Capitation data for that time period has already been compiled.",!,"To insure proper credit for this visit, please make sure the capitation",!,"data is regenerated.",!
 Q
 ;
SITE ;
 S DIR(0)="P^ACK(509850.8,1,1,:AEMQ",DA(1)=1
 S DIR("A")="Select Clinic Location"
 S DIR("?")="Choose the clinic location that should be associated with these visits."
 D ^DIR K DIR S:'$D(DIRUT) ACKSITE=+Y Q:$D(DIRUT)
 ; 
STOP ;
 S ACKCSCP=$$GET1^DIQ(44,ACKCLIN,8,"I")
 S ACKCSC(1)=$S('ACKCSCP:0,1:$$GET1^DIQ(40.7,ACKCSCP,1))
 S ACKCSC=""
 I ACKCSC(1)=203 S ACKCSC="A"
 I ACKCSC(1)=204 S ACKCSC="S"
 I ACKCSC="" D
 . S ACKCSCP=$$GET1^DIQ(44,ACKCLIN,2503,"I")
 . S ACKCSC(1)=$S('ACKCSCP:0,1:$$GET1^DIQ(40.7,ACKCSCP,1))
 . I ACKCSC(1)=203 S ACKCSC="AT"
 . I ACKCSC(1)=204 S ACKCSC="ST"
 ;
 K ACKCSCP
 Q
 ;
 ;
UNLOCK ;  Unlock Locked record
 L
 Q
 ;
HEADING ;
 W @IOF
 W !,"This option is used to enter new A&SP clinic visits.  Existing clinic",!,"visits should be updated with the Edit an Existing Visit option.",!
 Q
 ;
DEL W !!,$C(7),"<<INCOMPLETE RECORD DELETED!!>>",!!
 S DIK="^ACK(509850.6,",DA=ACKVIEN D ^DIK
 Q
 ;
CHKDTH ;; ACKQ*3*10  ADD CHECK FOR DECEASED PATIENT
 N I,X,Y,ACKDIRUT,ACK,VA,VADM,VAERR
 D DEM^VADPT
 S ACK(4)=""
 I VADM(6)'="" D
 .S Y=$P(VADM(6),"^",2)
 .X ^DD("DD")
 .S ACK(4)="[PATIENT DIED ON "_$P(Y,"@")_"]"
 I ACK(4)'="" W !!,ACK(4),! S ACKOUT=1
 ;; END ACKQ*3*10
 Q
