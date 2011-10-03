RAPTLU ;HISC/CAH,FPT,GJC AISC/MJK,RMO-Patient's Exam Lookup ;11/13/00  09:13
 ;;5.0;Radiology/Nuclear Medicine;**2,8,15,23,56**;Mar 16, 1998;Build 3
 ;Supported EA #10001 DT^DIO2
 ;Supported IA #2378 ORCHK^GMRAOR
 ;Supported IA #10035 ^DPT(
 ;Supported IA #10040 ^SC(
 ;Private IA #1123 RACHK^GMRARAD, RADD^GMRARAD
 ;***********************************************************************
 ;                         <<< NOTE >>>
 ; 'RANOSCRN' is set in the entry actions of various options.
 ; If the variable exists, the screen is ignored.  Code is in line
 ; label PRT+0.
 ;***********************************************************************
CASE D SEL S:'RACNT X="^" G Q:X="^"!($D(RAF1)) F I=1:1:11 S @$P("RADFN^RADTI^RACNI^RANME^RASSN^RADATE^RADTE^RACN^RAPRC^RARPT^RAST","^",I)=$P(Y,"^",I)
 S ^DISV($S($D(DUZ)#2:DUZ,1:0),"RA","CASE #")=RADFN_"^"_RADTI_"^"_RACNI,Y(0)=^RADPT(RADFN,"DT",RADTI,"P",RACNI,0)
Q K RTESC,RTFL,RACNT,RAERR,RASTP,RAELOC,RADTPRT,^TMP("MAG",$J,"COL"),^TMP("MAG",$J,"ROW") Q
 ;
SEL Q:'$D(^DPT(RADFN,0))  S RANME=^(0),RASSN=$$SSN^RAUTL,RANME=$P(RANME,"^") K ^TMP($J,"RAEX") D HOME^%ZIS D HD S X="",RACNT=0
 ;I $$IMAGE^RARIC1 D MED^MAGSET3,ERASE^MAGSET3 ;don't call MAG 111300
 S X=""
 F RADTI=0:0 Q:X="^"!(X>0)  S RADTI=$O(^RADPT(RADFN,"DT",RADTI)) Q:RADTI'>0  I $D(^(RADTI,0)) S RANODE=^(0),RADTE=+^(0) D SEL2 ;swm080398
 Q:X="^"!(X>0)  I 'RACNT W !?3,$C(7),"No matches found!" Q
 ;**Next line commented out - was causing selection screen to disappear
 ;  and automatically go on to detailed screen if there was only one
 ;  case for the patient
 D ASK^RAUTL4 S:X="" X="^"
 Q
SEL2 ; per RACNLU, check loc access, need split For Loop,swm080398
 S RADIV=+$P(RANODE,"^",3),RAIMAGE=+$P(RANODE,"^",2)
 S RADIV=+$G(^RA(79,RADIV,0)),RADIV=$P($G(^DIC(4,RADIV,0)),"^")
 S:RADIV']"" RADIV="Unknown"
 S RAIMAGE=$P($G(^RA(79.2,RAIMAGE,0)),"^")
 S:RAIMAGE']"" RAIMAGE="Unknown"
 I '$D(ORVP),($D(RANOSCRN)),('$D(RADUPSCN)) I $D(^TMP($J,"RA D-TYPE"))!($D(^TMP($J,"RA I-TYPE"))) Q:'$D(^TMP($J,"RA D-TYPE",RADIV))!('$D(^TMP($J,"RA I-TYPE",RAIMAGE)))  ;this stmt taken from RACNLU
 ; continue, since user has loc access
 F RACNI=0:0 S RACNI=$O(^RADPT(RADFN,"DT",RADTI,"P",RACNI)) Q:RACNI'>0  I $D(^(RACNI,0)) S RACN=^(0) D PRT Q:X="^"!(X>0)
 Q
PRT ; Screen only if entered through Rad/Nuc Med
 I '$D(ORVP),'$D(RANOSCRN),'$D(RAOPT("DOSAGE TICKET")),'$D(RAOPT("UNCORRECTED REPORTS")) Q:$$IMGTY^RAUTL12("e",RADFN,RADTI)'=RAIMGTY
 ; "Duplicate Dosage Ticket" option has its own screen
 I $D(RAOPT("DOSAGE TICKET")) Q:$P($G(^RA(79.2,+$P(^RADPT(RADFN,"DT",RADTI,0),U,2),0)),U,5)'="Y"
 S RARPT=+$P(RACN,"^",17)
 Q:$D(RAOPT("UNCORRECTED REPORTS"))&('$O(^RARPT(RARPT,"ERR",0)))
 S RAST=+$P(RACN,"^",3),RAPRC=$S($D(^RAMIS(71,+$P(RACN,"^",2),0)):$P(^(0),"^"),1:"Unknown"),RACN=+RACN S (RADTPRT,Y)=RADTE D D^RAUTL S RADATE=Y
 S RAELOC=$P($G(^SC(+$P($G(^RA(79.1,+$P($G(^RADPT(RADFN,"DT",RADTI,0)),U,4),0)),U),0)),U),RADTPRT=$E(RADTPRT,4,5)_"/"_$E(RADTPRT,6,7)_"/"_$E(RADTPRT,2,3)
 S:RAELOC="" RAELOC="* MISSING *"
 S RACNT=RACNT+1,^TMP($J,"RAEX",RACNT)=RADFN_"^"_RADTI_"^"_RACNI_"^"_RANME_"^"_RASSN_"^"_RADATE_"^"_RADTE_"^"_RACN_"^"_RAPRC_"^"_RARPT_"^"_RAST
 I $D(RAREPORT) D
 . S RAIMGTYI=$$IMGTY^RAUTL12("e",RADFN,RADTI)
 . S RASTP=$E($$GET1^DIQ(74,+RARPT,5),1,16) ;get all possible Rpt Statuss
 . I RASTP="",RAIMGTYI'="" S RASTP=RASTP_$S($D(^RA(72,"AA",RAIMGTYI,0,+RAST)):" (Exam Dc'd)",1:"")
 . Q
 I '$D(RAREPORT) S RASTP=$S($D(^RA(72,RAST,0)):$P(^(0),"^"),1:"Unknown")
 ; D:$$IMAGE^RARIC1 DISPA^MAGRIC ;don't call MAG 111300
 N RAPRTSET,RAMEMLOW D EN1^RAUTL20
 W !,RACNT,?5,$S(RAMEMLOW:"+",RAPRTSET:".",1:" "),?6,RACN,?11,$$IMGDISP(RARPT),?13,$E(RAPRC,1,26),?41,RADTPRT,?52,$E(RASTP,1,16),?69,$E(RAELOC,1,11)
 I (($Y+6)>IOSL),($O(^RADPT(RADFN,"DT",RADTI,"P",RACNI))!($O(^RADPT(RADFN,"DT",RADTI)))) D ASK^RAUTL4 W @IOF
 Q
 ;
HD I '$D(RTFL) W @IOF,?25,RAHEAD,!!,"Patient's Name: ",$E(RANME,1,20),"  ",RASSN,?55,"Run Date: " S Y=DT D DT^DIO2
 I $D(RTFL) D ESC^RTRD:($Y+6)>IOSL Q:$D(RTESC)  W !!,"============================ Exam Procedure Profile =========================="
 W !!?3,"Case No.",?13,"Procedure",?41,"Exam Date",?52,"Status of " W $S($D(RAREPORT):"Report",1:"Exam"),?69,"Imaging Loc"
 W !?3,"--------",?13,"-------------",?41,"---------",?52,"----------------",?69,"-----------" Q
 ;
PTUPD ;Update Patient Info
 S DIC(0)="AEMQL" D ^RADPA K DIC,RAIC Q:Y<0  S DIE="^RADPT(",DA=+Y,DR=".04;1" D ^DIE
PTUPD0 K DIR S DIR(0)="SOMA^Y:YES;N:NO;",DIR("A")="CONTRAST MEDIUM ALLERGY: "
 S ALLERGY=$$ORCHK^GMRAOR(DA,"CM")
 I ALLERGY]"" S DIR("B")=$S(ALLERGY=1:"YES",1:"NO")
 S DIR("?")="^D PTUPDH1^RAPTLU",DIR("??")="^D PTUPDH2^RAPTLU"
 D ^DIR K DIR I $D(DIRUT) G PTUPDX
 I ALLERGY'=$TR(Y,"YN","10") S X=0 D  G:'X PTUPDX W " ??",$C(7) G PTUPD0
 . I Y="N" S X=$$RACHK^GMRARAD(DA,Y)
 . I Y="Y" S X=($$RADD^GMRARAD(DA,"p",Y)'>0)
 . Q
PTUPDX K %,%Y,ALLERGY,C,D,D0,DA,DE,DQ,DIE,DIR,DR,RAPTFL,DIC,X,Y
 Q
PTUPDH1 W !?5,"If this patient has had an allergic reaction to contrast medium, enter 'Y'"
 W !?5,"for YES at this prompt.  If not, enter 'N' for NO."
 D PTUPDH3
 Q
PTUPDH2 ;
 W !?5,"The value in this field is used to indicate if this Radiology"
 W !?5,"/Nuclear Medicine patient has had an allergic reaction to the contrast"
 W !?5,"medium during a Radiology/Nuclear Medicine procedure.  It may contain a"
 W !?5,"'Y' for YES, or 'N' for NO.  If YES, then a warning message is"
 W !?5,"displayed to the receptionist whenever this patient is"
 W !?5,"registered for a procedure that may involve contrast material."
 D PTUPDH3
 Q
PTUPDH3 W !?5,"CHOOSE FROM:"
 W !?5," Y        YES"
 W !?5," N        NO"
 Q
IMGDISP(RARPT) ; Display "i" if an image is associated with the Rad/Nuc Med
 ; Report.  Called from RAPROS - Exam Profile (Selected Sort)
 ; Input : RARPT - ien of the report
 ; Output: "i" if an image exists, else null ("")
 Q $S(+$O(^RARPT(RARPT,2005,0)):"i",1:"")
