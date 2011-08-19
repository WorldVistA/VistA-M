ACKQASU1 ;HCIOFO/BH-Quasar New Visit Utilities routine ; 04/01/99
 ;;3.0;QUASAR;;Feb 11, 2000
 ;Per VHA Directive 10-93-142, this routine SHOULD NOT be modified.
 ;
CLIN(ACKDIV,ACKOPT) ; prompt for clinic
 ; inputs: - ACKDIV - selected Division
 ;           ACKOPT - set to U to force uppercase entry
 ; returns:  0 - if no valid clinics to select from
 ;          null - if no clinic selected
 ;          or X^Y^ where
 ;                 X - ien of selected clinic
 ;               & Y - clinic name
 ;
 N ACKIEN,ACKDEF,ACKCLINN,ACKC,ACKCLIN,ACKDFLT
 ;
 ; get the clinics for the selected Division
 D GETCLIN(ACKDIV,.CLINVARR,$G(ACKOPT))
 ;
 ; if no valid clinics then exit
 I CLINVARR=0 S ACKCLIN=0 G CLINX
 ;
 ; only one clinic exists, select it then exit
 I CLINVARR=1 D  G CLINX
 . S ACKCLIN=$P(CLINVARR(1,1),U,1,2)_U
 ;
 ; find users last clinic selection 
 S ACKDEF=$$FIND1^DIC(509850.831,","_ACKDIV_",1,",""," ")
 S ACKDEF=$S(ACKDEF:$$EXTERNAL^DILFD(509850.831,".01","",ACKDEF),1:"")
 ;
 ; ensure users last selection is valid
 S ACKDEF=$$UP("U",ACKDEF) ; convert to uppercase
 I ACKDEF'="",'$D(CLINVARR(2,ACKDEF)) S ACKDEF=""
 S ACKDFLT=$S(ACKDEF="":"",1:"2^"_ACKDEF)  ; passed to input fnctn as default
 ;
 ; multiple clinics exist, only one required.
 I CLINVARR>1 D  G CLINX
 . D SELECT^ACKQSEL(1,"CLINVARR(2)","CLINVARR(4)","CLINIC^35","D CLINHLP^ACKQASU1",ACKDFLT)
 . ; get CLINIC IEN
 . I $O(CLINVARR(4,""))="" S ACKCLIN="" Q  ; quit or timed out
 . S ACKCLINN=$O(CLINVARR(4,"")),ACKC=CLINVARR(2,ACKCLINN)
 . S ACKIEN=$P(CLINVARR(1,ACKC),U,1)
 . D RECALL^DILFD(509850.831,ACKIEN_","_ACKDIV_",1,",DUZ)
 . S ACKCLIN=$P(CLINVARR(1,ACKC),U,1,2)_U
 ;
CLINX ; end
 Q ACKCLIN
 ;
CLINHLP ; displays help text for the clinic prompt
 N X,DIWL,DIWR,DIWF
 S DIWL=1,DIWR=80,DIWF=""
 ;
 S X="     " D ^DIWP
 S X="    Enter the name of a Clinic from the A&SP Site Parameters File." D ^DIWP
 S X="    Enter '??' to see a list of the available Clinics, '^' to exit." D ^DIWP
 D ^DIWW
 Q
 ;
 ;
GETCLIN(ACKDIV,CLINVARR,ACKOPT) ; get all the valid clinics and put them in CLINVARR
 ;
 ;   INPUT:   ACKDIV - the selected Division
 ;            CLINVARR - array used to return clinics (passed by reference)
 ;            ACKOPT - set to U for Uppercase entry only
 ;   RETURNS: CLINVARR= number found (n)
 ;            CLINVARR(1,n)=x^name
 ;            CLINVARR(2,name)=n
 ;        and CLINVARR(3,x)=n
 ;              where x=IEN of clinic from parameters file
 ;                and name=the clinic name
 ;
 N ACKTGT,ACKMSG,ACKSCRN,ACK,CLIN,CLINNAME
 K CLINVARR
 D LIST^DIC(509850.831,","_ACKDIV_",1,",".01","I","*","","","","","","ACKTGT","ACKMSG")
 ; now transfer to output array
 S CLINVARR=$P(ACKTGT("DILIST",0),U,1)
 FOR ACK=1:1:CLINVARR D
 . S CLIN=ACKTGT("DILIST",1,ACK)
 . S CLINNAME=$$GET1^DIQ(44,CLIN,.01)
 . S CLINVARR(1,ACK)=CLIN_U_CLINNAME
 . S CLINVARR(2,$$UP($G(ACKOPT),CLINNAME))=ACK
 . S CLINVARR(3,CLIN)=ACK
 Q
 ;
UP(ACKOPT,X) ;   Convert X to uppercase (if requested)
 I ACKOPT["U" Q $TR(X,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 Q X
 ;
DUPCHK(ACKPAT,ACKVD) ; Check for Duplicate Visit by this patient on this Date
 ;  this function will determine if the patient has another visit on
 ;  the selected date. If so the user may choose to select an
 ;  existing visit, or confirm that they are entering a new visit.
 ;  inputs: ACKPAT - patient DFN
 ;          ACKVD - visit date
 ;  returns:   -1 if user quit or timed out
 ;              0 create a new visit
 ;                (ie either no duplicates or user did not select
 ;                 a duplicate)
 ;             >0 ien of selected visit
 ;     
 N ACKVIEN,ACKTGT,ACKCP,ACKCLN,ACKVSC,ACKTIME,ACKCT,ACKVSEL,ACKSEL
 N X,Y,%,DIR,ACKSEQ,ACKTIME,ACKVSEL
 S ACKVSEL=0 ; return variable
 ;
 ; initialise temp file for data storage
 K ^TMP("ACKQASU1",$J,"DUPCHK")
 ;
 ; get all visits for patient on given date, create array in time order
 S ACKVIEN=0,ACKCT=0
 F  S ACKVIEN=$O(^ACK(509850.6,"APD",ACKPAT,ACKVD,ACKVIEN)) Q:'ACKVIEN  D
 . K ACKTGT S ACKCT=ACKCT+1
 . D GETS^DIQ(509850.6,ACKVIEN_",","2.5;2.6;4;55","I","ACKTGT")
 . S ACKCP=ACKTGT(509850.6,ACKVIEN_",",2.5,"I")   ; is this C&P?
 . S ACKCLN=ACKTGT(509850.6,ACKVIEN_",",2.6,"I")  ; clinic
 . S ACKVSC=ACKTGT(509850.6,ACKVIEN_",",4,"I")    ; visit stop code
 . S ACKTM=+ACKTGT(509850.6,ACKVIEN_",",55,"I")   ; appointment time
 . S ^TMP("ACKQASU1",$J,"DUPCHK",1,ACKTM,ACKVIEN)=""
 . S ^TMP("ACKQASU1",$J,"DUPCHK",2,ACKVIEN)=ACKVD_U_ACKCP_U_ACKCLN_U_ACKVSC_U_ACKTM_U
 ;
 ; if no duplicate visits found then exit
 I 'ACKCT S ACKVSEL=0 G DUPCHKX
 ;
 ;  Display duplicates for this patient today
 W !,$S(ACKCT=1:"One visit has ",1:ACKCT_" visits have ")_"already been entered for this date and patient.",!
 ;
 ; run down the visits in time order, allocate sequence number and display
 S ACKTM="",ACKSEQ=0
 F  S ACKTM=$O(^TMP("ACKQASU1",$J,"DUPCHK",1,ACKTM)) Q:ACKTM=""  D
 . S ACKVIEN=""
 . F  S ACKVIEN=$O(^TMP("ACKQASU1",$J,"DUPCHK",1,ACKTM,ACKVIEN)) Q:ACKVIEN=""  D
 . . S ACKSEQ=ACKSEQ+1
 . . S $P(^TMP("ACKQASU1",$J,"DUPCHK",3,ACKSEQ),U,1)=ACKVIEN
 . . S TMP=^TMP("ACKQASU1",$J,"DUPCHK",2,ACKVIEN)
 . . S ACKTIME=$$FMT^ACKQUTL6(ACKTM,1)
 . . S ACKVD=$P(TMP,U,1)
 . . S ACKCANDP=$S($P(TMP,U,2):"C&P EXAM",1:"")
 . . S ACKCLN=$P(TMP,U,3),ACKCLNNM=$S(+ACKCLN=0:"",1:$$GET1^DIQ(44,ACKCLN_",",.01,"E")) ; clinic name
 . . S ACKVSC=$P(TMP,U,4),ACKSTOP=$$ACKSTOP(ACKVSC)  ; visit stop code
 . . ; display visits
 . . W !,$J(ACKSEQ,3),". ",$$DATE(ACKVD)
 . . W ?20,ACKTIME,?32,$E(ACKCLNNM,1,30),?64,ACKSTOP,?70,ACKCANDP
 ;
ASK1 ; ask if one of the displayed visits is the one to be edited
 W !!,"Is "_$S(ACKCT=1:"the appointment",1:"one of the appointments")
 W " shown here the one you wish to edit"
 S %=2 D YN^DICN
 I %=-1,%Y?1"^"1.E W !,"Jumping not allowed." G ASK1
 ;
 ; if user does not want an existing visit then exit
 I %=2 D  S ACKVSEL=0 G DUPCHKX
 . W !!,"Ok, adding another visit for this patient/date.",!!
 ; if user quit or timed out then exit
 I %="-1" S ACKVSEL=-1 G DUPCHKX
 ; if any value other than YES, display help and re-prompt
 I %'=1 S ACKQHLP=2 D ^ACKQHLP G ASK1
 ;
 ; if the user answered YES and there is only one visit then exit
 I ACKCT=1 S ACKVSEL=$P(^TMP("ACKQASU1",$J,"DUPCHK",3,1),U,1) G DUPCHKX
 ;
SELECT ; prompt for which visit
 S DIR(0)="N^1:"_ACKSEQ
 S DIR("A")="Select by number"
 S DIR("?")="Select the appointment you wish to edit from the above list"
 D ^DIR K DIR
 I $D(DIRUT) S ACKVSEL=-1 G DUPCHKX   ; quit or timed out
 S ACKSEL=+Y
 ; get selected Visit ien
 S ACKVSEL=$P(^TMP("ACKQASU1",$J,"DUPCHK",3,ACKSEL),U,1)
 ;
DUPCHKX ; exit point
 K ^TMP("ACKQASU1",$J,"DUPCHK")
 Q ACKVSEL
 ;
ACKSTOP(ACKVSC) ; translate visit stop code for display
 I ACKVSC="A" Q "AUD"
 I ACKVSC="S" Q "SPE"
 I ACKVSC="AT" Q "TEL"
 I ACKVSC="ST" Q "TEL"
 Q ""
 ;
DATE(Y) ; convert date portion of Y to external format
 S Y=Y\1 D DD^%DT
 Q Y
 ;
 ;
PCEVST1(ACKVD,ACKPAT,ACKCLIN) ; Checks to see if patients has a PCE visit for
 ;    selected clinic on visit date
 ;
 N ACKDATE,ACK,ACKPASS,ACKPIEN
 S ACKPASS=0
 S X1=ACKVD,X2="-1" D C^%DTC S X=X_".99"
 F  S X=$O(^AUPNVSIT("AET",ACKPAT,X)) Q:X=""!($P(X,".",1)>ACKVD)!(ACKPASS)  D
 . I $D(^AUPNVSIT("AET",ACKPAT,X,ACKCLIN)) S ACKPASS=1
 Q ACKPASS
 ;
 ;
EXCEPT ;  Displays Error message explaining that the visit has previously been
 ;  sent to PCE and that the PCE interface is now off.  The changes 
 ;  made here in Quasar will therefore not be sent to PCE thus causing
 ;  a data disparity between the two systems.  
 W !!,"WARNING"
 W !!,"This visit has Previously been sent to PCE."
 W !,"The edited visit will not be sent to PCE because (within the Site Parameters)"
 W !,"either the INTERFACE WITH PCE field is set to off, the SEND TO PCE field for"
 W !,"this Division is set to off or this visits Visit Date is before the PCE"
 W !,"INTERFACE START DATE."
 W !!,"Data will now be different between the Quasar and the PCE visit."
 W !,"Please take the appropriate corrective action.",!
 W ! K DIR S DIR(0)="E",DIR("A")="Press RETURN to continue" W ! D ^DIR
 Q 
