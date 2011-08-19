RARTRPV ;HISC/FPT-Resident Pre-Verify Report ;09/26/08  16:29
 ;;5.0;Radiology/Nuclear Medicine;**26,56,95**;Mar 16, 1998;Build 7
 ;Supported IA #10104 REPEAT^XLFSTR
 ;Supported IA #10035 ^DPT(
 ;Supported IA #10060 and 2056 GET1^DIQ of file 200
 ;Supported IA #10076 ^XUSEC
 N DIERR
 D SET^RAPSET1 I $D(XQUIT) K XQUIT Q
 K RAVER S:$D(^VA(200,DUZ,0)) RAVER=$P(^(0),"^") I '$D(RAVER) W !!,$C(7),"Your name must be defined in the NEW PERSON File to continue." G Q
 I '$D(^VA(200,"ARC","R",DUZ)) W !!,$C(7),"You are not classified as a Rad/Nuc Med Interpreting Resident." G Q
 S RAINACT=$$GET1^DIQ(200,DUZ_",",53.4,"I") ; grab Inactive Date (if any)
 I RAINACT,(RAINACT'>DT) W !!,$C(7),"You are not classified as an active Rad/Nuc Med Interpreting Resident." K RAINACT G Q
 K RAINACT S RAONLINE="" W ! D ES^RASIGU G Q:'%
 S RARAD=DUZ,RAD="ARES"
 ;
SRTRPT K RA,RARPTX,^TMP($J,"RA") S (RATOT,RARPT)=0
 F  S RARPT=$O(^RARPT(RAD,RARAD,RARPT)) Q:'RARPT  I $D(^RARPT(RARPT,0)) S RARTDT=$S($P(^(0),"^",6)="":9999999.9999,1:$P(^(0),"^",6)) I $P(^RARPT(RARPT,0),U,12)="" D
 .Q:$$STUB^RAEDCN1(RARPT)  ;skip stub report 031501
 .Q:"^V^EF^X^"[("^"_$P($G(^RARPT(+RARPT,0)),"^",5)_"^")  ;skip if V,EF,X
 .S ^TMP($J,"RA","DT",RARTDT,RARPT)=""
 .S RATOT=RATOT+1
 I 'RATOT W !!,"You have no Unverified Reports." G Q
 ;
SELRPT S RARD("A")="Do you wish to review "_$S(RATOT=1:"this one report",1:"all "_RATOT_" reports")_"?  ",RARD(1)="Yes^review all reports",RARD(2)="No^choose which reports to review",RARD("B")=1,RARD(0)="S"
 D SET^RARD K RARD S X=$E(X) G Q:X["^"!(X="N"&(RATOT=1)),RPTLP:X="Y" D ^RARTVER1 G Q:$D(RAOUT)!('$D(RARPTX))
 ;
RPTLP S DIR(0)="S^P:PAGE AT A TIME;E:ENTIRE REPORT",DIR("B")="P",DIR("A")="How would you like to view the reports?"
 S DIR("?",1)="If you would like to pause after each page of the report enter 'P'.",DIR("?")="Otherwise enter 'E' to view an entire report at one time."
 D ^DIR K DIR G Q:$D(DIRUT) I Y="E" S RARTVERF=1
 I $D(^TMP($J,"RA","DT")) S RARPT=0 F RARTDT=0:0 S RARTDT=$O(^TMP($J,"RA","DT",RARTDT)) Q:'RARTDT  S RARDX="" D GETRPT Q:RARDX="^"
 I $D(^TMP($J,"RA","XREF")) S (RPTX,RARPT)=0 D GETRPT
 ;
Q K %,%DT,%W,%Y1,DA,DGO,DI,DIC,DIWF,DIWR,I,OREND,POP,RA,RACN,RACNI,RACS,RACT,RAD,RADATE,RADFN,RADIV,RADTE,RADTI,RADUP,RADUZ,RAERR,RAFLG,RAIMGTYJ,RAJ1,RAPRIT,RANM,RANME,RANUM,RAONLINE,RAOR,RAOUT,RAPRC,RARAD,RARDX,RARPDT,RARPT
 K RARPTX,RARTDT,RARTVER,RARTVERF,RASET,RASIG,RASN,RASTI,RATOT,RAVER,RAVNB,RAXIT,RAXX,RPTX,X,Y,^TMP($J,"RA")
 K %X,D,D0,D1,DDER,DDH,DLAYGO
 K C,DIRUT,DUOUT,HLN,HLRESLT,HLSAN,J,RADFLDS,RAPRTSET,X1
 Q
 ;
GETRPT I $G(RARPT) L -^RARPT(RARPT)
 S:$D(^TMP($J,"RA","XREF")) RPTX=RPTX+1 S RARPT=$S($D(^TMP($J,"RA","DT")):$O(^TMP($J,"RA","DT",RARTDT,RARPT)),$D(^TMP($J,"RA","XREF")):+$G(RARPTX(RPTX)),1:0) Q:'RARPT  L +^RARPT(RARPT):2 G:'$T LOCK G:$P($G(^RARPT(RARPT,0)),U,5)="V" VER
 D DISRPT
 I RAIMGTYJ']"" D  Q
 . I $G(RARPT) L -^RARPT(RARPT)
 . Q
ASK W !,$$REPEAT^XLFSTR("=",80)
 S RARD(1)="Print^print this report for editing",RARD(2)="Edit^edit this report",RARD(3)="Top^display the report from the beginning",RARD(4)="Continue^continue normal processing"
 S RARD(5)="Status & Print^edit Status, then print report",RARD("B")=4,RARD(0)="S"
 D SET^RARD K RARD S RARDX=$E(X) I RARDX="^" L -^RARPT(RARPT) Q
 I "PT"[RARDX D PRTRPT:RARDX="P",DISRPT:RARDX="T" G ASK
 I RARDX="E" D EDTCHK I RARDX="E" D  G ASK
 .W !!,"EDITING REPORT",!,"--------------",!
 .D EDTRPT^RARTRPV1
 .D:RACT'="V" UP1^RAUTL1
 .I $D(DTOUT) K ^TMP($J,"RA")
 .Q
 G NOEDIT^RARTRPV1 ;pre-verify report, no report text edit
 ;
DISRPT S (RAIMGTYJ,RARTVER)="" D RASET Q:'Y!(RAIMGTYJ']"")  D DISP^RART1 K RARTVER
 Q
PRTRPT D SAVE^RARTVER2
 S ION=$P(RAMLC,"^",10),IOP=$S(ION]"":"Q;"_ION,1:"Q")
 S RAMES="W !!,""Report has been queued for printing on device "",ION,"".""" D Q^RARTR
 D RESTORE^RARTVER2
 Q
 ;
RASET S Y=RARPT D RASET^RAUTL2 Q:'Y
 S Y(0)=Y,RANME=$S($D(^DPT(RADFN,0)):$P(^(0),"^"),1:"UNKNOWN")
 S RAPRC=$S($D(^RAMIS(71,+$P(Y(0),"^",2),0)):$P(^(0),"^"),1:"UNKNOWN")
 S RAIMGTYJ=$$IMGTY^RAUTL12("e",RADFN,RADTI)
 I RAIMGTYJ']"" D
 . W !?5,"Imaging Type data appears to be missing for this exam.",$C(7)
 . Q
 Q
LOCK S RACN=+$P(^RARPT(RARPT,0),"^",4)
 W !!,$C(7),"Another user is editing this report",$S($G(RACN)]"":" (Case # "_RACN_")",1:""),".  Please try again later." H 4 K RACN G GETRPT
 Q
VER ; report was verified since tmp global was built
 S RACN=$G(^RARPT(RARPT,0))
 S RACN("CASE")=+$P(RACN,U,4)
 S RACN("PAT")=+$P(RACN,U,2)
 S RACN("VER")=+$P(RACN,U,9)
 W !!,$C(7),$$GET1^DIQ(200,+RACN("VER")_",",.01)_" verified report for "_$P(^DPT(RACN("PAT"),0),U)
 W !,"(Case # "_RACN("CASE")_") since you began this option."
 H 4 K RACN G GETRPT
 Q
EDTCHK ; is user permitted to edit report
 S RASTATUS=+$P($G(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0)),"^",3)
 I $P($G(^RA(72,RASTATUS,0)),"^",3)>0 K RASTATUS Q
 K RASTATUS
 I $D(^XUSEC("RA MGR",DUZ)) Q
 I $P(RAMDV,"^",22)=1 Q
 W $C(7),!!,"The STATUS for this case is CANCELLED. You may not enter a report.",!!
 S RARDX="C" ;Reset RARDX so user can only verify.
 Q
