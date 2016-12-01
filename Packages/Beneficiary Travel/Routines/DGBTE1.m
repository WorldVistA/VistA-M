DGBTE1 ;ALB/SCK/GAH - BENEFICIARY TRAVEL FIND OLD CLAIM DATES;10/10/06@11:17am
 ;;1.0;Beneficiary Travel;**8,12,13,20,21,22,25,28**;September 25, 2001;Build 12
DATE ;  get date for claim, either new or past date
 N DGBTDCLM
 K ^TMP("DGBT",$J),^TMP("DGBTARA",$J),DIR
 I 'DGBTNEW S DIR("A",2)="Enter a 'P' to display Past CLAIM dates for editing."
 S DIR("A",3)="Time is required when adding a new CLAIM.",DIR("A",4)="",DIR("A",1)="",DIR("A")="Select TRAVEL CLAIM DATE/TIME",DIR("?")="^D HELP^DGBTE1A"
 S DIR(0)="F",DIR("B")="NOW" D ^DIR K DIR G ERR1:$D(DIRUT)
 S CHZFLG=0,%DT="EXR",DTSUB=$S(Y="N":"NOW",Y="P":"OLD",Y="p":"OLD",1:"OTHR")_"^DGBTE1A" D @DTSUB   ;PAVEL - DGBT*1*20
 S:$P(DTSUB,U,1)="OLD"&(Y1>0) DGBTOLD=1 K DTSUB        ;PAVEL DGBT*1*20
 G ERR1:$D(DTOUT),DATE:Y1<0 S DGBTA=Y1 G SET:CHZFLG    ;PAVEL DGBT*1*20
DATE1 ;  for past claims, set DGBTDT to inverse date of claim date
 I $D(^DGBT(392,"C",DFN)) D
 . S DGBTC=0,DGBTDT=9999999-$E(DGBTA,1,7) ; set past claims counter=0
 . ; for latest date (topmost) search for past claims
 . F I=DGBTDT:0 S I=$O(^DGBT(392,"AI",DFN,I)) Q:'I!(I>(DGBTDT_.99999))  S DGBTC=DGBTC+1,DGBT(DGBTC)=9999999.99999-I
 I '$D(DGBT) G LOCK
 W !!,"There are other claims on this date.",!,"Select by number to edit or <RETURN> to add a new CLAIM.",!
 ; convert inverse claim date to external format through VADATE conversion routine
 F I=0:0 S I=$O(DGBT(I)) Q:'I  D
 .S DGBTDCLM=$$GET1^DIQ(392,DGBT(I),45,"I")
 .S VADAT("W")=DGBT(I) D ^VADATE W !?5,I,".",?10,VADATE("E")_$S($G(DGBTDCLM)'="":" (D)",1:"")
 K DIR S DIR("A")="Select 1"_$S(DGBTC=1:"",1:"-"_DGBTC)_", or <RETURN> to add a new claim: ",DIR(0)="NOA^1:"_DGBTC,DIR("?")="Select, by number, one of the displayed claim dates: "
 D ^DIR K DIR S:$G(Y) CHZFLG=1 G QUIT^DGBTEND:$D(DTOUT)!($D(DUOUT))
 G LOCK:Y="" G DATE:'$D(DGBT(Y))
 S DGBTA=DGBT(Y),DGBTOLD=1 G SET
LOCK ;
 L +^DGBT(392,DGBTA):$G(DILOCKTM,3)
 I '$T!$D(^DGBT(392,DGBTA)) L -^DGBT(392,DGBTA) S DGBTA=$$FMADD^XLFDT(DGBTA,,,,1) G LOCK ;dbe patch DGBT*1*21
 S (DGBTDT,VADAT("W"))=DGBTA D ^VADATE W VADATE("E")      ;for CCR235 by RE
ASKADD ;
 W !!,"Are you sure you want to add a new claim"
 S %=1 D YN^DICN G EXIT2^DGBTE:%<0!(%=2)
 I '% W !!,"Enter 'YES' to add a new claim, or 'NO' not to add the claim." G ASKADD
 K DD,DO
 ; create new file entry, stuff patient DFN into name field(pointer)
 S (X,DINUM)=DGBTA,DIC="^DGBT(392,",DIC(0)="L",DIC("DR")="2////"_DFN
 D FILE^DICN K DIC L -^DGBT(392,DGBTA)
 ; go back to patient if no file entry
 G:Y'>0 PATIENT^DGBTE
SET ; call inhouse generic date routine
 S (DA,DGBTDT,VADAT("W"))=DGBTA D ^VADATE
 ; get internal and external formats of converted inverse dates
 S DGBTDTI=$S($G(VADAT("W"))'="":VADAT("W"),1:VADATE("I")),DGBTDTE=VADATE("E") K VADAT,VADATE,DIC,Y
 I $G(DGBTDIVI)'="" S DGBTDIVN=$P(^DG(40.8,DGBTDIVI,0),"^",7)
 D GA^DGBTUTL(DFN,"DGBTINCA",DGBTDTI) ;Get Alternate Income PAVEL
STUFF ;  stuff departure with address data from patient file, dest from institution file
 S DGBTCMTY=$$GET1^DIQ(392,DGBTDT,56)
 S:'$L(DGBTCMTY) DGBTCMTY="M"
 ;dbe patch DGBT*1*25 - removed restrictions below to allow departure and destination fields to get filed for existing claims
 S:'$D(^DGBT(392,DGBTDT,"D")) ^DGBT(392,DGBTDT,"D")=VAPA(1)_"^"_VAPA(2)_"^"_VAPA(3)_"^"_VAPA(4)_"^"_$S(VAPA(5)]"":+VAPA(5),1:"")_"^"_$P(VAPA(11),U,1)
 I '$D(^DGBT(392,DGBTDT,"T")) D
 . S X=$S($D(^DIC(4,DGBTDIVN,1)):^(1),1:"")
 . S ^DGBT(392,DGBTDT,"T")=($P(^DG(40.8,DGBTDIVI,0),U)_"^"_$P(X,U)_"^"_$P(X,U,2)_"^"_$P(X,U,3)_"^"_$P(^DIC(4,DGBTDIVN,0),U,2)_"^"_$TR($P(X,U,4),"-","")) ;*28 remove hyphen from zip code
 Q:$G(DGBTSP2M)  ;dbe patch DGBT*1*25 - added quit when called from routine dgbtee
CHKFILES ; section removed, dependents picked up below in MEANS ; abr 10/94
MEANS ;  find corres. means test entry, gets MT income, status, no. of dependents
 ;DGBTMTS= MT Status;  DGBTCSC= claim Service Connected indicator & %;  DGBTELG=Eligibility status
 N X,X2,X3,Y,DGBTIFL
 S X=$$LST^DGMTCOU1(DFN,DT,3),DGBTMTS=$P(X,U,4)_U_$P(X,U,3) ; returns corres. MT info,X=IEN of last MT. passing a 3 will check both MT and RX Co-Pays
 ; get income, # dependents
 S Y=$$INCOME^VAFMON(DFN,DGBTA,1)
 S:"I^V"[$P(Y,U,2) Y=U ;If income type is I or V ignore it PAVEL
 S:DGBTINCA Y=$P(DGBTINCA,U,2)_U_$E($P(DGBTINCA,U,4)) ;Set Alternate Income
 S X=$P(Y,U),DGBTIFL=$P(Y,U,2) ; returns income & source.
 I X?1N.E!(X<0) D
 .I X<0 S X=0
 .S X2="0$",X3=8 D COMMA^%DTC
 S DGBTINC=X_U_$G(DGBTIFL) K X,X2
 S DGBTDEP=$$DEP^VAFMON(DFN,DGBTA) ; finds dependents Vet, Spouse, Children
 S DGBTDTY=" (Year: "_$$FMTE^XLFDT($E(DGBTDTI,1,3)_"0000")_")" ;Year to be displayed with Income
 S DGBTMTTH=$$MTTH^DGBTMTTH(DGBTDEP,DGBTDTI) ; Means test threshold
 S DGBTRXTH=+$$THRES^IBARXEU1(DGBTDTI,1,DGBTDEP) ; RX co-pay threshold
 S DGBTDYFL=$$DAYFLAG^DGBTUTL ; valid income test y/n
 ;
PREV ; if past claim get SC%, elig.
 I CHZFLG S X=^DGBT(392,DGBTA,0),DGBTELG=$P(X,U,3),DGBTCSC=$P(X,U,4) D
 . S:$P(X,U,11) DGBTDIVI=+$P(X,U,11),DGBTDIVN=$P($G(^DG(40.8,DGBTDIVI,0)),U,7) ;dbe patch DGBT*1*22 - save division of existing claims
 . S:DGBTCSC DGBTCSC=1_U_DGBTCSC S:'DGBTCSC DGBTCSC=0
 . S:DGBTELG DGBTELG=DGBTELG_U_$P(^DIC(8,DGBTELG,0),U)
CERT ;  get last BT certification,  get date, then get eligibility
 I $D(^DGBT(392.2,"C",DFN)) D
 .;cd=cert date in inverse then external format, ce= eligibility, ca* = amt certified
 . S DGBTCD=$O(^DGBT(392.2,"C",DFN,0)),DGBTCE=$P(^DGBT(392.2,DGBTCD,0),"^",3)
 . S DGBTCA=$P(^DGBT(392.2,DGBTCD,0),"^",4),Y=9999999-$P(DGBTCD,".")
 . X ^DD("DD") ; date conversion, y=cert date (internal)
 . S DGBTCD=Y,X=DGBTCA,X2="0$",X3=8 K Y D COMMA^%DTC S DGBTCA=X K X,X2,X3
APPTS ;  search patient file for appointments through claim date (DTI+1),  add dates to array DGBTCL 
 N ERRCODE,DGARRAY,CLIEN,APTDT S DGARRAY("FLDS")="2;3;10;18"
 S DGARRAY(4)=DFN,I=$$SDAPI^SDAMA301(.DGARRAY)
 ; I<0 = Error, I<0 = # of Records retrieved
 I I<0 S ERRCODE=$O(^TMP($J,"SDAMA301","")),I1=1,DGBTCL("ERROR")=^TMP($J,"SDAMA301",ERRCODE)
 I I>0 D
 .S CLIEN=""
 .F  S CLIEN=$O(^TMP($J,"SDAMA301",DFN,CLIEN)) Q:'CLIEN  D
 ..S APTDT=DGBTDTI\1
 ..F  S APTDT=$O(^TMP($J,"SDAMA301",DFN,CLIEN,APTDT)) Q:'APTDT!(APTDT>(DGBTDTI+1))  D
 ...S SDATA=^TMP($J,"SDAMA301",DFN,CLIEN,APTDT)
 ...S DGBTCL(APTDT)=$P($P(^TMP($J,"SDAMA301",DFN,CLIEN,APTDT),U,2),";",2)_U_$P($P(SDATA,U,3),";")
 ...S DGBTCL(APTDT)=DGBTCL(APTDT)_U_$P($P(SDATA,U,18),";")_U_$P($P(SDATA,U,10),";")
 K ^TMP($J,"SDAMA301"),DGARRAY,CLIEN,APTDT
EXIT ; exit routine
 Q
ERR1 ;  error condition
 G QUIT^DGBTEND Q
