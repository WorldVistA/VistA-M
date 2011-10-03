ACKQUTL7 ;HCIOFO/BH-Template Inquire - A&SP Patient/Visit ; 04/01/99 
 ;;3.0;QUASAR;**8**;Feb 11, 2000
 ;Per VHA Directive 10-93-142, this routine SHOULD NOT be modified.
 ;
 ;
INP ;  PRINT INPATIENT INFO
 W !,"WARD: ",ACK(6),?20,"ROOM/BED: ",ACK(7),?40,"TREATING SPEC:"
 W $E(ACK(8),1,25)
 Q
 ;
 ;
EN ;  Get Demographics
 N I,X,Y K ACKDIRUT
 D DEM^VADPT,INP^VADPT,ELIG^VADPT
 S ACKIVD=$$NUMDT^ACKQUTL($P(^ACK(509850.2,ACKPAT,0),U,2))
 K ACK S ACK(1)=VADM(1),ACK(2)=$P(VADM(3),U,2),ACK(3)=$P(VADM(2),U,2)
 S ACK(4)=VADM(7),ACK(6)=$P(VAIN(4),U,2)
 S ACKINP=$S($L(ACK(6)):1,1:0),ACK(5)="Patient is "_$S(ACKINP:"",1:"not ")_"currently an inpatient."
 S ACK(7)=VAIN(5),ACK(8)=$P(VAIN(3),U,2),ACK(9)=$P(VAEL(1),U,2)
PRINT ;
 W @IOF
 S X="QUASAR V.3.  "_ACKVISIT_" VISIT ENTRY" D CNTR^ACKQUTL(X)
 ;
 ;
 D TPLTE
 ;
 ;
 ;  D RATDIS^ACKQNQ  ;  Display any Rated Disabilities
 ;
 W !!,"Patient Diagnostic History",!
 W $S($P(VADM(5),U)="F":"Ms. ",1:"Mr. "),$P(VADM(1),",")
 W " has been seen for the following:",!
 I $Y>(IOSL-8) S DIR(0)="E" D ^DIR K DIR Q:$D(DIRUT)  W @IOF
 D DIHEAD,ICDSORT
 K DIRUT W !
 I '$O(ACKICD("")) W !,"No A&SP Diagnostic Data for this Patient" G EXIT
 S ACKI=""
 F  S ACKI=$O(ACKICD(ACKI)) Q:ACKI=""  D:$Y>(IOSL-5) WAIT Q:$D(DIRUT)  W !,$P(ACKICD(ACKI),U),?15,$P(ACKICD(ACKI),U,3),?60,$$NUMDT^ACKQUTL($P(ACKICD(ACKI),U,4))
EXIT ;
 I $G(DIRUT)=1 S ACKDIRUT=1  ;  Quit flag for template
 W !!
 K %ZIS,ACK,ACKDC,ACKDD,ACKDFN,ACKDN,ACKI,ACKICD,ACKINP,ACKIVD,ACKLINE
 K ACKRD,DIRUT,DTOUT,DUOUT,VA,VADM,VAEL,VAERR,VAIN,X,X1,Y,ZTDESC,ZTIO
 K ZTRTN,ZTSAVE
 W:$E(IOST)'="C" @IOF D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@"
 Q
 ;
WAIT ;
 K DIRUT I $E(IOST)'="C" W @IOF Q
 S DIR(0)="E" D ^DIR K DIR Q:$D(DIRUT)  W @IOF,"Patient Diagnostic History (Cont'd)","  (",ACK(1),")" D DIHEAD
 Q
DIHEAD ;
 W !,"DIAGNOSIS",?60,"DATE ENTERED" S ACKLINE="",$P(ACKLINE,"-",IOM)="" W !,ACKLINE
 Q
ICDSORT ;
 S ACKI=0 F  S ACKI=$O(^ACK(509850.2,DFN,1,ACKI)) Q:'ACKI  D
 . S ACKDC=^ACK(509850.2,DFN,1,ACKI,0),ACKDD=$P(ACKDC,U,2)
 . D GETS^DIQ(80,+ACKDC_",",".01;2","E","ACKTGT","ACKMSG")
 . S ACKDN=ACKTGT(80,+ACKDC_",",.01,"E")
 . S ACKICD(ACKDN)=ACKDN_U_ACKTGT(80,+ACKDC_",",2,"E")_U_$$DIAGTXT^ACKQUTL8(+ACKDC,ACKDD)_U_ACKDD
 K ACKTGT,ACKMSG
 Q
 ;
TPLTE ;  Display Visit Clinic and Division
 N ACKTMPE
 W !!,"CLINIC: ",$$GET1^DIQ(509850.6,ACKVIEN,"2.6")
 W ?45,"DIVISION: ",$$GET1^DIQ(509850.6,ACKVIEN,60),!
 ;  Display more Patient data
 W "PATIENT: ",ACK(1),?45,"DOB: ",ACK(2),?63,"SSN: ",ACK(3)
 ;  If no Visit Eligibility on visit file display Primary Elig.
 S ACKTMPE=$$GET1^DIQ(509850.6,ACKVIEN_",",80,"E")
 I ACKTMPE D 
 . W !,"VISIT ELIGIBILITY: "_ACKTMPE
 ;
 I 'ACKTMPE D
 .W !,"ELIGIBILITY: ",ACK(9)
 W ?45,"INITIAL VISIT DATE: ",ACKIVD
 W:$L(ACK(4)) !,ACK(4) W !,ACK(5) D:ACKINP INP
 ;  D VISIT
 ;
 Q
 ;
VISIT ;  Displays Service connected data
 ;
 I 'ACKSC Q        ;  If Patient not service connected QUIT
 I 'ACKPCE Q       ;  If system not set up for PCE then QUIT
 ;
 N ACKX,ACKVV,ACKPP,ACKVSC,ACKAAO,ACKEENV,ACKRRAD,ACK,ACKSTR
 ;
 D GETDATA
 I ACKVISIT="NEW",$G(ACKPCENO)="" D UNKNOWN Q
 I 'ACKVSC D NOT("This Visit's Treatment :",ACKAAO,ACKRRAD,ACKEENV) Q
 I ACKVSC D CONNECT
 Q
 ;
 ;
GETDATA ;  Get visit data
 ;
 K ACK
 D GETS^DIQ(509850.6,ACKVIEN,"20;25;30;35","I","ACK")
 S ACKVSC=ACK(509850.6,ACKVIEN_",",20,"I")
 S ACKAAO=ACK(509850.6,ACKVIEN_",",25,"I")
 S ACKEENV=ACK(509850.6,ACKVIEN_",",35,"I")
 S ACKRRAD=ACK(509850.6,ACKVIEN_",",30,"I")
 K ACK
 Q
 ;
CONNECT W !!,"This visit's Treatment is Service Connected.",!
 Q
 ;
NOT(ACKSTR,ACKAAO,ACKRRAD,ACKEENV) ;
 W !!,ACKSTR,!
 W "------------------------------------------------------------------------------"
 ;
 W !,"Related to AGENT ORANGE ? : "_$S(ACKAAO="1":"YES",1:"NO") W ?50,"Service Connected ? : NO"
 ;       
 W !,"Related to RADIATION EXPOSURE ? : "_$S(ACKRRAD="1":"YES",1:"NO")
 ;               
 W !,"Related to ENVIRONMENTAL CONTAMINANTS ? : "_$S(ACKEENV="1":"YES",1:"NO")
 Q
 ;
UNKNOWN N ACKPASS
 S ACKPASS=0
 W !!,"This visit's Treatment:",!
 W "------------------------------------------------------------------------------",!
 I ACKAO W "Related to AGENT ORANGE ? : UNKNOWN" D:'ACKPASS SERV
 I ACKRAD W !,"Related to RADIATION EXPOSURE ? : UNKNOWN" D:'ACKPASS SERV
 I ACKENV W !,"Related to ENVIRONMENTAL CONTAMINANTS ? : UNKNOWN" D:'ACKPASS SERV
 D:'ACKPASS SERV
 W !
 Q
 ;
SERV ;
 W ?50,"Service Connected ? : UNKNOWN" S ACKPASS=1
 Q
 ;
ERROR ; Display error message if registration returns error that indicates
 ; that the Appointment Management database is not available.
 ;
 N ACKERR
 W !!!!,"   ** The Appointment Management Data Base is unavailable. **"
 W !!,"   ** Please report this problem to IRM as soon as possible. **",!!!
 W "   Press any key to continue."
 R ACKERR:DTIME
 ; 
 Q
 ;
