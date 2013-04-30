DGBTDLT1 ;BLD-REPRINT BENEFICIARY TRAVEL DENIAL LETTER; 03/04/2012@1400; 03/04/2012
 ;;1.0;Beneficiary Travel;**20**;March 4, 2012;Build 185
 ;
 Q
 ;************************************************************************************************************
 ;                              THIS WILL PRINT DENIAL LETTERS
 ;************************************************************************************************************
 ;
REPRINT ;
 ;
 D QUIT
 W !
 K ^UTILITY($J,"W"),^TMP("DGBT",$J)
 S QUIT=0
 ;
 ;DIVISN ; if MED CTR DIV file set up (first record) and record does not exist, write warning, kill variables, and exit
 S X=$G(^DG(40.8,0)) I X="" W !,"WARNING...MEDICAL CENTER DIVISION FILE IS NOT SET UP",!,"USE THE ADT PARAMETER OPTION FILE TO SET UP DIVISION" Q
 ;  check if multi-divisional center (GL node exists and 2nd piece=1). Do lookup, if it exists-set local variables
 S DGBTMD=0 I $D(^DG(43,1,"GL")),$P(^("GL"),U,2) D  Q:Y'>0  ;D PATIENT
 . S DIC="^DG(40.8,",DIC(0)="AEQMNZ",DIC("A")="Select DIVISION: " W !!
 . D ^DIC K DIC Q:Y'>0
 . S DGBTDIVI=+Y,DGBTDIV=$P(Y,U,2)
 . D INSTIT S DGBTMD=1
 ;  if not a multi-divisional center, default to institution name
 I 'DGBTMD S DGBTDIVI=$O(^DG(40.8,0)),DGBTDIV=$P(^DG(40.8,DGBTDIVI,0),U) D INSTIT
 ;
 D PATIENT Q:$G(DFN)=""  ;I '$D(^DGBT(392,"ADENIED",DFN)) W !!,"THERE ARE NO DENIAL LETTERS TO PRINT FOR: ",VADM(1) K DFN D QUIT Q  ;D REPRINT,QUIT Q
 D LIST2 I $G(CHZFLG)="" D QUIT Q
 S DGBTDLTR=$$GET1^DIQ(392,DGBTDTI,45,"I")
 I 'DGBTDLTR D QUIT Q
 S DGBTCMTY=$$GET1^DIQ(392,DGBTDTI,56,"I")
 D DEVICE^DGBTDLT("DENIAL LETTER","LTR^DGBTDLT1") I $D(DTOUT)!($D(DUOUT)) S QUIT=1 D QUIT Q
 I $G(DGBTQ) D QUIT Q
 D LTR
 D QUIT
 Q
 ;
LTR ;
 ;
 N NAME,DGBTCDT,DGBTDR,DIWL,DIWR
 K ^UTILITY($J,"W")
 S DGBTDR=$$GET1^DIQ(392,DGBTDTI,45.4,"I")
 I $$GET1^DIQ(392.8,DGBTDR,1,,"REASON")
 D DIVISN(.DGBTINST)                            ;this will set up the DGBTINST array containing the current VA location address
 ;D DEVICE("DENIAL LETTER") I $D(DTOUT)!($D(DUOUT)) S QUIT=1 Q
 D HEADER(.DGBTINST)                            ;this will print the current VA location information
 S QUIT=1
 S DIWL=5   ;left margin
 S DIWR=75   ;right margin
 S DGBTCDT(1)=$P(DGBTDTE,"@",1)                                                        ;invoice date
 S NAME=$$GET1^DIQ(200,DUZ,.01),DGBTCDT(2)=$P(NAME,",",2)_" "_$P(NAME,",",1)           ;user name
 S DGBTCDT(3)=$$GET1^DIQ(200,DUZ,8)             ;user title
 I DGBTCMTY="M" D               ;for mileage claims
 .I $$GET1^DIQ(392.6,1,1,,"LETTERS1")
 .S LINENBR=0
 .F  S LINENBR=$O(LETTERS1(LINENBR)) Q:'LINENBR  D  D ^DIWP
 ..S X=LETTERS1(LINENBR)
 .S NBR=0
 .F  S NBR=$O(REASON(NBR)) Q:'NBR  D  D ^DIWP
 ..S X=REASON(NBR)
 .I $$GET1^DIQ(392.6,2,1,,"LETTERS2")
 .F  S LINENBR=$O(LETTERS2(LINENBR)) Q:'LINENBR  D  D ^DIWP
 ..S X=LETTERS2(LINENBR) Q:X=""
 .D ^DIWW
 ;
 K LETTERS1,KETTERS2
 I DGBTCMTY="S" D                        ;for Special Mode Claims
 .I $$GET1^DIQ(392.6,3,3,,"LETTERS1")
 .S LINENBR=0
 .F  S LINENBR=$O(LETTERS1(LINENBR)) Q:'LINENBR  D  D ^DIWP
 ..S X=LETTERS1(LINENBR)
 .S NBR=0
 .F  S NBR=$O(REASON(NBR)) Q:'NBR  D  D ^DIWP
 ..S X=REASON(NBR)
 .I $$GET1^DIQ(392.6,4,3,,"LETTERS2")
 .F  S LINENBR=$O(LETTERS2(LINENBR)) Q:'LINENBR  D  D ^DIWP
 ..S X=LETTERS2(LINENBR) Q:X=""
 .D ^DIWW
 D:'IOST'["C-" ^%ZISC
 Q
 ;
PATIENT ; patient lookup, quit if patient doesn't exist
 N VAEL
 S DGBTTOUT="",DIC="^DPT(",DIC(0)="AEQMZ",DIC("A")="Select PATIENT: "
 W !! D ^DIC K DIC I +Y'>0 K DFN Q
 ; get patient information#, call return patient return variables routine and set wether new claim or not
 S DFN=+Y D 6^VADPT,PID^VADPT
 S DGBTNEW=$S($D(^DGBT(392,"C",DFN)):0,1:1)
 Q
 ;
LIST2 ;  find all previous claims, get total count in DGBTC and put those claims in utility file
 N X1,YY,DGBTCDT,DGBTC,CNT
 S (CNTR,DGBTCH,DGBTCH1,DGBTCDT)=0
 S DGBTC=""
 I $D(^DGBT(392,"ADENIED",DFN))'>1 W !!?10,"There are no entries on file for this patient",! S Y1=-1 D QUIT Q
 ;
 F I=1:1 S DGBTC=$O(^DGBT(392,"ADENIED",DFN,DGBTC),-1) Q:'DGBTC  D
 .S Y=DGBTC D DD^%DT
 .S CNTR=$G(CNTR)+1
 .S DGBTARY(CNTR,DGBTC)=Y ;K DGBTARY(DGBTC)
 ;
LIST3 ;  list claims (in external format) from temporary global, 5 at a time. Loop thru list until selection made.
 S (CNTR,DGBTCH)=""
 S DGBTC=""
 W !
 F  S CNTR=$O(DGBTARY(CNTR)) Q:'CNTR  D  Q:$G(CHZFLG)!$G(DTOUT)!$G(DUOUT)
 .F  S DGBTC=$O(DGBTARY(CNTR,DGBTC)) Q:DGBTC=""  D  Q:$G(CHZFLG)
 ..W !?5,CNTR,".",?10,DGBTARY(CNTR,DGBTC) I CNTR#5=0!($O(DGBTARY(CNTR))="") D CHOZ I $D(DUOUT)!$D(DTOUT)!(Y>0) Q
 I '$D(DTOUT)&Y="" D LIST3 Q
 S DGBTDTI=$O(DGBTARY(CNTR,"")),DGBTDTE=DGBTARY(CNTR,DGBTDTI)
 K DIR
 Q
 ;
CHOZ ;  select from the displayed past claims dates for claim to be edited.
 N DGBTCH1,CHOICE
 S CHOICE=1
 W !! S (Y1,Y)=0,DGBTCH1=I,DIR(0)="FO^1:5",DIR("A")="Select CLAIM"
 S DIR("A",1)="Type '^' to exit date list, or <RETURN> to display more dates"
 S DIR("?")="Entering a '^' will exit the Past CLAIM list, entering <RETURN> will continue to scroll through past dates.",DIR("?",1)="Select a Past CLAIM date by number."
 D ^DIR K DIR I $D(DTOUT)!($D(DUOUT)) S Y1=-1 Q
 I Y="",$O(DGBTARY(CNTR))'="" Q
 I X<CHOICE!(X>DGBTCH1)!(X'=+X) W !?25,*7,"INVALID ENTRY!" D CHOZ Q  ; value must be between 1 and last displayed number
 S CHZFLG=Y,DGBTDTI=$O(DGBTARY(Y,""))
 S CNTR=$G(Y)
 Q
 ;
DIVISN(DGBTINST) ; if MED CTR DIV file set up (first record) and record does not exist, write warning, kill variables, and exit
 S DGBTDIVI=$$GET1^DIQ(392,DGBTDTI,11,"I"),DGBTDIV=$$GET1^DIQ(40.8,DGBTDIVI,.01) ; RFE DGBT*1.0*20
 I ($G(DGBTDIVI)'="")&($G(DGBTDIV)'="") D INSTIT(.DGBTINST) Q  ; RFE DGBT*1.0*20
 S DGBTDIVI=$O(^DG(40.8,0)),DGBTDIV=$P(^DG(40.8,DGBTDIVI,0),U) D INSTIT(.DGBTINST)
 Q
 ; 
INSTIT(DGBTINST) ;  check for pointer to institution file and for address information on institution
 N MAILCODE,INSTADD,INSTNODE
 S DGBTDIVN=$P(^DG(40.8,DGBTDIVI,0),"^",7)
 I 'DGBTDIVN W !!,"INSTITUTION HAS NOT BEEN DEFINED FOR ",$P(^(0),"^"),!,"USE THE ADT PARAMETER OPTION TO UPDATE",! Q
 I $D(^DIC(4,DGBTDIVN,0)),$S($D(^(1))#10=0:1,$P(^(1),"^",3)']"":1,1:0) W !!,"INSTITUTION ADDRESS NOT ENTERED.  PLEASE UPDATE USING THE INSTITUTION FILE ENTER/EDIT",! Q
 ;
 S INSTNODE=^DIC(4,DGBTDIVN,0)
 S INSTADD=^DIC(4,DGBTDIVN,1)
 ; 
 S DGBTINST("ORG NAME")="DEPARTMENT OF VETERANS AFFAIRS"
 S DGBTINST("INST NAME")=$$GET1^DIQ(4,DGBTDIVN,.01)
 S DGBTINST("INST ADDRESS 1")=$$GET1^DIQ(4,DGBTDIVN,1.01)
 S DGBTINST("INST ADDRESS 2")=$$GET1^DIQ(4,DGBTDIVN,1.02)
 S DGBTINST("INST CITY")=$$GET1^DIQ(4,DGBTDIVN,1.03)
 S DGBTINST("INST STATE")=$$GET1^DIQ(4,DGBTDIVN,.02)
 S DGBTINST("INST ZIP CODE")=$$GET1^DIQ(4,DGBTDIVN,1.04)
 S DGBTINST("FAC NUMBER")=$$GET1^DIQ(40.8,DGBTDIVI,1)
 S MAILCODE=$O(^DIC(49,"B","BENEFICIARY TRAVEL",""))
 S DGBTINST("MAIL CODE")=$$GET1^DIQ(49,MAILCODE,1.5)
 Q
 ;
HEADER(DGBTINST) ;this will print all of the standard information at the top of the letter. IT WILL NOT PRINT LOGO'S ETC
 ;
 I $G(DGBTINST("ORG NAME"))="" D  Q
 .W !!,"INSTITUTION INFORMATION IS UNAVAILABLE. PLEASE UPDATE USING THE INSTITUTION FILE ENTER/EDIT."
 N ORG,ADD1,ADD2,CITY,STATE,ZIP,INSTNAME,LOC,LOC2,DGBTDTFILED
 ;
 S ORG=DGBTINST("ORG NAME")
 S INSTNAME=DGBTINST("INST NAME")
 S ADD1=DGBTINST("INST ADDRESS 1")
 S ADD2=DGBTINST("INST ADDRESS 2")
 S CITY=DGBTINST("INST CITY")
 S STATE=DGBTINST("INST STATE")
 S ZIP=DGBTINST("INST ZIP CODE")
 ;
 D DEM^VADPT
 S PATSEX=$P(VADM(5),"^",1),PATSEX=$S(PATSEX="M":"Mr",1:"Ms")_". "
 S PATADD1=VAPA(1),PATADD2=VAPA(2)
 S PATCITY=VAPA(4)_", ",PATST=$P(VAPA(5),"^",2)_" ",PATZIP=VAPA(6)
 S PATNAME=VADM(1),PATNAME=$P(PATNAME,",",2)_" "_$P(PATNAME,",",1)
 ;
 S LOC2=5
 S LOC=80-$L(ORG) W !,?LOC/2,ORG
 S LOC=80-$L(INSTNAME) W !,?LOC/2,INSTNAME
 S LOC=80-$L(ADD1) W !,?LOC/2,ADD1
 I $G(ADD2)'="" S LOC=80-$L(ADD2) W !,?LOC/2,ADD2
 S CITYSTZIP=CITY_", "_STATE_" "_ZIP
 S LOC=80-$L(CITYSTZIP) W !,?LOC/2,CITYSTZIP,!
 ;S LOC=80-$L(DGBTDTE) W !?LOC,$P(DGBTDTE,"@",1)
 S DGBTDTFILED=$$GET1^DIQ(392,DGBTDTI,13,"E")
 S DGBTDTFILED=$S(DGBTDTFILED'="":DGBTDTFILED,1:DT)
 S DGBTDTFILED=$$FMTE^XLFDT(DGBTDTFILED)
 S LOC=80-$L(DGBTDTFILED) W !,?LOC,DGBTDTFILED
 W !,?LOC,DGBTINST("FAC NUMBER")
 W ?LOC,"/"_$S(DGBTINST("MAIL CODE")'="":DGBTINST("MAIL CODE"),1:"136B"),!
 W ?LOC,$E(VADM(1),1)_$E($P(VADM(2),"^",1),6,99)
 W !,?LOC2,$G(PATSEX),$G(PATNAME)
 W !,?LOC2,$G(PATADD1)
 W:$G(PATADD2)'="" !,?LOC2,PATADD2
 W !,?LOC2,PATCITY,PATST,PATZIP,!!
 ;
 Q
 ;
DEVICE(DGBTRPT) N %ZIS,ZTSK,ZTRTN,ZTIO,ZTDESC,ZTSAVE,POP
 S %ZIS="QM"
 D ^%ZIS
 I POP S DGBTQ=1
 ;
 ;Check for exit
 I $G(DGBTQ) Q
 ;
 S DGBTSCR=$S($E($G(IOST),1,2)="C-":1,1:0)
 I $D(IO("Q")) D  S DGBTQ=1
 . S ZTRTN="RUN^DGBTBORP0(DGBTEXCEL,DGBTRPT,DGBTSMDET)"
 . S ZTIO=ION
 . S ZTSAVE("*")=""
 . S ZTDESC="DGBT REPORT: "_DGBTRPT
 . D ^%ZTLOAD
 . W !,$S($D(ZTSK):"REQUEST QUEUED TASK="_ZTSK,1:"REQUEST CANCELLED")
 . D HOME^%ZIS
 U IO
 Q
 ;
QUIT ;will kill all local variables used by this routine
 ;
 K DFN,DGBTNEW,VACNTRY,VADAT,VADM,VAERR,VAPA,Y,Z,J,DGBTINST,DGBTNEW,DGBTTOUT,DGBTDLTR,DGBTDIVN,DGBTDIVI,DGBTDIV,DGBTCMTY,DGTCH1,DGBTCH,DGBTC,DGBTMD
 K ^TMP("DGBT",$J),DFN,CITYSTZIP,CHZFLG,C,QUIT
 K X1,YY,DGBTCHK,^TMP("DGBT",$J),^TMP("DGBTARA",$J)
 K DRIEN,REASON,LETTERS1,LETTERS2,LINENBR,NBR,DGBTDNLTR,DGBTFDA,DGBTSCR,DGBTDR,DGBTISSUED,VADM,PATSEX,PATADD1,PATADD2,PATCITY,PATST,PATZIP,PATNAME
 K CNTR,DFN,DGBTARY,DGBTCH,DGBTCH1,DGBTDTE,DGBTDTI,DGBTNEW,DGBTTOUT,DGBTARY,VA,VACNTRY,VAPA,DUOUT,DTOUT,DGBTQ,DGBTQ1
 Q
