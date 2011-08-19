SDRRPXC ;;10N20/MAH;Recall Reminder Utilities ;01/18/2008  11:32
 ;;5.3;Scheduling;**536**;Aug 13, 1993;Build 53
  ;
STOPCODE(SDRRI) ; Return a clinic stop code
 Q $S('SDRRI:SDRRI,1:$P($G(^DIC(40.7,SDRRI,0)),U,2))
PERDIV(SDRRDIV) ;
 S I=0
 F  S I=$O(SDRRDIV(I)) Q:'I  S SDRRDIV(I)=$P($G(^DG(40.8,I,0),"Unknown Division"),U)
 Q
ASKDIV(SDRRDIV) ;
 N DIC,X,Y,I,DUOUT,DTOUT
 K SDRRDIV
 S SDRRDIV=0
 W !
 S DIC("A")="Select Medical Center Division: All// "
 S DIC="^DG(40.8,"
 S DIC(0)="AEQMN"
 F  D  Q:Y=-1
 . D ^DIC Q:Y=-1
 . S SDRRDIV(+Y)=$P(Y,U,2)
 . S DIC("A")="Another Medical Center Division: "
 Q:$D(DTOUT)!$D(DUOUT)
 S I=0
 I $O(SDRRDIV(0)) D  Q
 . F  S I=$O(SDRRDIV(I)) Q:'I  S SDRRDIV=SDRRDIV+1
 F  S I=$O(^DG(40.8,I)) Q:'I  S SDRRDIV(I)=$P(^(I,0),U),SDRRDIV=SDRRDIV+1
 Q
ASKCLIN(SDRRDIV,SDRRST,SDRRND) ;
 N DIR,X,Y,DIRUT,SDRRABORT
 W !!,"Now you'll select the clinics."
 S DIR(0)="SO^R:Range of Clinics;I:Individual Clinics;S:Stop Codes"
 S DIR("A")="Select Clinics by"
 S DIR("?",1)="Choose 'Range of Clinics' if you want to select a group of clinics in"
 S DIR("?",2)="consecutive name order.  You'll be asked for the starting clinic and the"
 S DIR("?",3)="ending clinic.  All the clinics in that range will be selected for you."
 S DIR("?",4)=""
 S DIR("?",5)="Choose 'Individual Clinics' if you want to select clinics individually."
 S DIR("?",6)="You'll be able to use ranges here, too, as well as wild cards.  You'll"
 S DIR("?",7)="even be able to de-select clinics."
 S DIR("?",8)=""
 S DIR("?",9)="Choose 'Stop Codes' if you want to select Stop Codes.  All clinics whose"
 S DIR("?",10)="Stop Codes or Credit Stops match the ones you've chosen will be selected"
 S DIR("?",11)="for you."
 D ^DIR I $D(DIRUT) S SDRRABORT=1 Q
 D @Y
 Q
I ; Select individual clinics
 N SDRRDIC,SDRRNAME,SDRRIEN,SDRRREC
 W !!,"You'll be able to use ranges and wild cards to select clinics."
 W !,"You'll even be able to deselect clinics."
 W !,"Enter '?' at the prompt to see how."
 S SDRRDIC=44
 S SDRRDIC(0)="AEMNQZ"
 S SDRRDIC("A")="Select Clinic: "
 S SDRRDIC("B")="All"
 S SDRRDIC("S")="I $$ACTIVE^SDRRPXC(+Y,.SDRRDIV,.SDRRST,.SDRRND,^(0))"
 I '$$EN^SDRRSLCT(.SDRRDIC,"SDRR") S SDRRABORT=1 Q
 S (SDRRNAME,SDRRIEN)=""
 F  S SDRRNAME=$O(^TMP($J,"SDRR",SDRRNAME)) Q:SDRRNAME=""  D
 . F  S SDRRIEN=$O(^TMP($J,"SDRR",SDRRNAME,SDRRIEN)) Q:SDRRIEN=""  D
 . . S SDRRREC=$G(^SC(SDRRIEN,0))
 . . S ^TMP("SDRR",$J,"DIV",$P(SDRRREC,U,15),"CLIN",$P(SDRRREC,U))=SDRRIEN_U_$$STOPCODE($P(SDRRREC,U,7))_U_$$STOPCODE($P(SDRRREC,U,18))
 K ^TMP($J,"SDRR")
 Q
R ; Select range of clinics
 N SDRRCLIN,SDRRIEN,SDRRREC,SDRRFROM,SDRRTHRU,SDRRI
 D ASKRANGE(.SDRRCLIN,.SDRRDIV,.SDRRST,.SDRRND)
 I 'SDRRCLIN S SDRRABORT=1 Q
 S SDRRI=0
 F  S SDRRI=$O(SDRRCLIN(SDRRI)) Q:'SDRRI  D
 . S SDRRFROM=$P($P(SDRRCLIN(SDRRI),":"),U,2)
 . S SDRRFROM=$O(^SC("B",SDRRFROM),-1)
 . S SDRRTHRU=$P($P(SDRRCLIN(SDRRI),":",2),U,2)
 . S SDRRCLIN=SDRRFROM
 . F  S SDRRCLIN=$O(^SC("B",SDRRCLIN)) Q:SDRRCLIN=""  D  Q:SDRRCLIN=SDRRTHRU
 . . S SDRRIEN=$O(^SC("B",SDRRCLIN,0))
 . . S SDRRREC=$G(^SC(SDRRIEN,0))
 . . Q:'$$ACTIVE(SDRRIEN,.SDRRDIV,.SDRRST,.SDRRND,SDRRREC)
 . . S ^TMP("SDRR",$J,"DIV",$P(SDRRREC,U,15),"CLIN",$P(SDRRREC,U))=SDRRIEN_U_$$STOPCODE($P(SDRRREC,U,7))_U_$$STOPCODE($P(SDRRREC,U,18))
 Q
S ; Select stop codes
 N SDRRDIC,SDRRSC,SDRRSCI,SDRRNDX,SDRRIEN,SDRRREC
 S SDRRDIC=40.7
 S SDRRDIC(0)="AEMQZ"
 S SDRRDIC("A")="Select Stop Code: "
 S SDRRDIC("S")="S %=$P(^(0),U,3) I '%!(%>"_$G(SDRRST,DT)_")"
 I '$$EN^SDRRSLCT(.SDRRDIC,"SDRR") S SDRRABORT=1 Q
 S (SDRRSC,SDRRSCI,SDRRIEN)=""
 F  S SDRRSC=$O(^TMP($J,"SDRR",SDRRSC)) Q:SDRRSC=""  D
 . F  S SDRRSCI=$O(^TMP($J,"SDRR",SDRRSC,SDRRSCI)) Q:'SDRRSCI  D
 . . F SDRRNDX="AST","ACST" D  ; xrefs on STOP CODE and CREDIT STOP fields
 . . . F  S SDRRIEN=$O(^SC(SDRRNDX,SDRRSCI,SDRRIEN)) Q:'SDRRIEN  D
 . . . . S SDRRREC=$G(^SC(SDRRIEN,0))
 . . . . Q:'$$ACTIVE(SDRRIEN,.SDRRDIV,.SDRRST,.SDRRND,SDRRREC)
 . . . . S ^TMP("SDRR",$J,"DIV",$P(SDRRREC,U,15),"CLIN",$P(SDRRREC,U))=SDRRIEN_U_$$STOPCODE($P(SDRRREC,U,7))_U_$$STOPCODE($P(SDRRREC,U,18))
 K ^TMP($J,"SDRR")
 Q
ASKRANGE(SDRRCLIN,SDRRDIV,SDRRST,SDRRND) ;
 N DIC,X,Y,DTOUT,DUOUT,SDRRCNT,SDRRFROM
 S SDRRCNT=0
 S DIC="^SC(",DIC(0)="AEQM"
 W !
 W !,"To select a range of clinics, first you select the start of the range,"
 W !,"or the 'from' clinic.  Next, you select the end of the range,"
 W !,"or the 'thru' clinic.  We'll select all the clinics in that range for you."
 F  D  Q:Y<0
 . W !
 . S DIC("A")="From Clinic: "
 . S DIC("S")="I $$ACTIVE^SDRRPXC(+Y,.SDRRDIV,.SDRRST,.SDRRND,^(0))"
 . D ^DIC Q:Y<0
 . S SDRRFROM=Y ;S SDRRDIV(+Y)=$P(Y,U,2)
 . S DIC("A")="Thru Clinic: "
 . S DIC("S")="I $P(^(0),U)]"""_$O(^SC("B",$P(SDRRFROM,U,2)),-1)_""",$$ACTIVE^SDRRPXC(+Y,.SDRRDIV,.SDRRST,.SDRRND,^(0))"
 . D ^DIC Q:Y<0
 . S SDRRCNT=SDRRCNT+1
 . S SDRRCLIN(SDRRCNT)=SDRRFROM_":"_Y
 I $D(DTOUT)!$D(DUOUT) K SDRRCLIN S SDRRCLIN=0
 S SDRRCLIN=SDRRCNT
 Q
ACTIVE(SDRRIEN,SDRRDIV,SDRRST,SDRRND,SDRRREC) ; Is the clinic active?
 ; SDRRIEN - IEN of clinic in HOSPITAL LOCATION (#44) file
 ; SDRRDIV - (optional) clinic must be in Division(s)
 ;          SDRRDIV=ien  or SDRRDIV(ien)="", where ien is IEN in file 40.8
 ; SDRRST  - (optional) date range start date - default=DT
 ; SDRRND  - (optional) date range end date - default=SDRRST
 ; SDRRREC - (optional) zero node of clinic
 I '$D(SDRRREC) S SDRRREC=$G(^SC(SDRRIEN,0))
 Q:$P(SDRRREC,U,3)'="C" 0  ; Not a clinic
 Q:$P(SDRRREC,U,1)["*" 0
 I $D(SDRRDIV)=1,$P(SDRRREC,U,15)'=SDRRDIV Q 0
 I $D(SDRRDIV)>9,'$D(SDRRDIV(+$P(SDRRREC,U,15))) Q 0
 S SDRRREC=$G(^SC(SDRRIEN,"I"))
 Q:'SDRRREC 1
 I '$G(SDRRST) S SDRRST=DT
 I '$G(SDRRND) S SDRRND=SDRRST
 I $P(SDRRREC,U,1)<SDRRST Q $S($P(SDRRREC,U,2)="":0,$P(SDRRREC,U,2)>SDRRND:0,1:1)
 Q 1  ; Active
