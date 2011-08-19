ACKQASU ;HCIOFO/BH-New/Edit Visit Utilities  ;  04/01/99
 ;;3.0;QUASAR;**8,15,16**;Feb 11, 2000;Build 37
 ;Per VHA Directive 2004-038, this routine SHOULD NOT be modified.
 ;
ELIGCHK() ; Checks to see if there is a Primary Eligibility (which there
 ; always should be) if there's not (i.e. data error) pass back zero.
 ;         
 N ACKFLG
 D ELIG^VADPT S:VAEL(1)="" ACKFLG="0"  S:VAEL(1)'="" ACKFLG=1
 K VAEL
 Q ACKFLG
 ;
DISP ;  Displays headings and Patient Appointments 
 ;
 ;  CLEAR SCREEN WRITE FROM TOP 
 D ENS^%ZISS
 W @IOF
 ;  Get date for display
 D NOW^%DTC S Y=% D DD^%DT S ACKDDT1=$TR(Y,"@"," "),ACKDDT2=X
 S ACKSSN=$$GET1^DIQ(2,ACKPAT,".09")
 W "                            - ",IOUON,"APPOINTMENT LIST",IOUOFF," -",!
 W !," Name : "_$$GET1^DIQ(2,ACKPAT,".01")
 W ?38,"SSN    : ",$E(ACKSSN,1,3)_"-"_$E(ACKSSN,4,5)_"-"_$E(ACKSSN,6,9)
 W !," Date : "_$E(ACKDDT2,4,5)_"/"_$E(ACKDDT2,6,7)_"/"_$E(ACKDDT2,2,3)
 W ?38,"Clinic : "_$$GET1^DIQ(44,ACKCLIN,.01)
 W !,IOUON,"                                                                                ",IOUOFF
 ;
 ;
 W !!,"    ",IOUON,"Appt Date/Time",IOUOFF,"     ",IOUON,"Status",IOUOFF,"                    ",IOUON,"Appointment Type",IOUOFF
 K ACKDDT1,ACKDDT2,ACKSSN
 ;
 S ACKK3=""
 F  S ACKK3=$O(^UTILITY("VASD",$J,ACKK3)) Q:ACKK3=""  D
 . S ACKSTRIN=^UTILITY("VASD",$J,ACKK3,"E")
 . W !!," "_ACKK3_"."
 . W ?4,$P($P(ACKSTRIN,U,1),"@",1)_" "_$P($P(ACKSTRIN,U,1),"@",2)
 . W ?23,$S($P(ACKSTRIN,U,3)'="":$P(ACKSTRIN,U,3),1:"NO ACTION TAKEN")
 . W ?49,$P(ACKSTRIN,U,4)
 W !!!
 Q
 ;
KILL ;  Kill off values at end of processing
 K ACK0,ACK2,ACKCAT,ACKCD,ACKCDN,ACKCLN,ACKCNT,ACKCP,ACKDA,ACKDC,ACKDUP
 K ACKDUPN,ACKECSC,ACKESITE,ACKFLD,ACKFLG1,ACKFLG2,ACKGEN,ACKI,ACKLAYGO
 K ACKMOD,ACKMON,ACKQCPS,ACKQCPT,ACKQRAW,ACKRAW,ACKREQ,ACKSEL,ACKSTF
 K ACKSIG,ACKTM,ACKVD,ACKY,ACKDEF,ACKDIVN,ACKCSC,ACKCPNO,ACKCLNO,ACKCLIN
 K ACKL1,ACKL2,ACKL3,ACKL4,ACKR1,ACKR2,ACKR3,ACKR4,ACKTITL,%,%DT,%I,%X
 K %Y,C,D0,DA,DFN,DIC,DIE,DIK,DIRUT,DLAYGO,DR,DTOUT,DUOUT,I,J,VA,VADM
 K VAERR,X,X1,X4,Y,ACKELIG,ACKIEN,ACKK2,ACKLAMD,ACKLOSS,ACKN,ACKPCE
 K ACKVISIT,ACKPAT,ACKVIEN,ACKDIV,ACLCLIN,ACKCHK,ACKVIEN,ACKAO,ACKSC
 K CLINVAR,DIVARR,ACKRAD,ACKENV,ACKPROV,ACKDIAGD,ACKCPTDS,ACKDIRUT
 K ACKPCENO,VSAD,DIVARR,DIV,CLINVARR,ACKTME,ACKSCR,ACKELGCT,ACKELG1
 K ACKTRGT,ACKDVN,ACKACKBA,ACKAUDIO,ACKATS,ACKQUIT,ACKMSG,ACKQTST
 K ACKQSER,ACKQORG,ACKQIR,ACKQECON,ACKAPMNT,ICPTVDT,ICDVDT,ACKHNC,ACKCV
 Q
 ;
 ;
DC ;  CHECK OUT DIAGNOSTIC CONDITION - ENTER IF NEEDED
 N ACKY
 Q:$D(^ACK(509850.2,DFN,1,"B",ACKDC))
 S ACKY=Y D DEM^VADPT S Y=ACKY,X=$$GET1^DIQ(80,ACKDC,.01),ACKLN=$P(VADM(1),","),ACKSX=$P(VADM(5),U)
 I $G(ACKBGRD)'="1" D
 . W !!,X,"   ",$$DIAGTXT^ACKQUTL8(ACKDC,ACKVD)
 . W !,"We have no previous record of diagnostic condition ",X," for ",$S(ACKSX="F":"Ms.",1:"Mr.")," ",ACKLN,"." D ADCODE
 . W !,"Ok, I've added this code to ",$S(ACKSX="F":"her",1:"his")," permanent record !",!
 I $G(ACKBGRD)=1 D ADCODE
 K ACK0,ACKLN,ACKSX,VA,VADM,VAERR,X Q
 ;
ADCODE ;  Adds ICD to permanent record.
 N D,D0,D1,DA,DB,DC,DD,DDTM,DE,DF,DG,DH,DI,DIC,DIE,DIEL,DIFLD,DIOV,DIP,DJ,DK,DL,DM,DN,DO,DP,DQ,DR,DU,DV,DW,DXS,DZ,I,Y ;we're calling this from FM
 F  L +^ACK(509850.2,DFN,1,0):$G(DILOCKTM,3) Q:$T  W:$G(ACKBGRD)'="1" !,"Another user is editing this record."
 S (DIC,DIE)="^ACK(509850.2,"_DFN_",1,",DIC(0)="L",DLAYGO=509850.2,ACKLAYGO=""
 S DIC("P")=$P(^DD(509850.2,2,0),"^",2),DA(1)=DFN,X=ACKDC D FILE^DICN Q:Y<0  S DA=+Y,DR="2;1///"_ACKVD D ^DIE
 L -^ACK(509850.2,DFN,1,0) Q
 ;
 Q
 ;
GETPCETM(ACKPCENO) ; get appointment time from a PCE Visit ien
 ; inputs:- ACKPCENO - PCE Visit ien (from ^AUPNVSIT)
 ; returned :-   0^ - error (visit not found)
 ;               '.nnnnnn^' - time portion of PCE visit date/time
 N ACKDATE,ACKTM
 K ^TMP("PXKENC",$J)
 D ENCEVENT^PXAPI(ACKPCENO)
 S ACKDATE=$P($G(^TMP("PXKENC",$J,ACKPCENO,"VST",ACKPCENO,0)),U,1)
 S ACKTM=$S(ACKDATE="":0,1:ACKDATE#1)
 K ^TMP("PXKENC",$J)
 Q ACKTM_U
 ;
DUPEDATA(ACKPAT,ACKCLIN,ACKVD,ACKTM) ;  If an appointment or PCE visit has been selected for a visit
 ; which is at the same time, for the same patient, on the same day 
 ; within the same clinic this processing is run.
 ; inputs:- ACKPAT - patient ien
 ;          ACKCLIN - clinic ien
 ;          ACKVD - visit date (internal)
 ;          ACKTM - appointment time (.NNN - internal)
 W !!?4,"ERROR - A visit already exists in QUASAR with the following details..",!
 W !?7,"Visit Date: ",$$DATE(ACKVD),"    Appointment Time: ",$$TIME(ACKTM)
 W !?7,"    Clinic: ",$$GET1^DIQ(44,ACKCLIN_",",.01,"E")
 W !?7,"   Patient: ",$$GET1^DIQ(509850.2,ACKPAT_",",.01,"E")
 W !!?4,"If you choose to continue you must enter a different Appointment Time."
 ;
 ; W !!,"There is already an entry within Quasar for this Patient, within the same"
 ; W !,"Clinic, on the same date at the same time."
 ; W !!,"Enter '^' to terminate and quit back to the Division prompt"
 ; W !,"or <RETURN> to continue."
 W !
 K DIR S DIR(0)="E" D ^DIR K DIR  ;  Return to Continue '^' to Exit 
 I X="^" Q 0
 Q 1
 ;
DATE(ACKDATE) ; convert ACKDATE to external format
 S Y=ACKDATE D DD^%DT
 Q Y
TIME(ACKTIME) ; convert Time to external format
 Q $$FMT^ACKQUTL6(ACKTIME,1)
