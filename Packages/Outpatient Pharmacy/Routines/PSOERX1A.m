PSOERX1A ;ALB/BWF - eRx Utilities/RPC's ; 8/3/2016 5:14pm
 ;;7.0;OUTPATIENT PHARMACY;**467**;DEC 1997;Build 153
 ;
 Q
 ; select an item
SI ;
 N RESP,ERXIEN,ERXDAT,LINE,LINEVAR,ERXPAT,ERXLOCK
 S DIR(0)="N^"_VALMBG_":"_VALMLST_":0" D ^DIR
 I 'Y S VALMBCK="R" Q
 S RESP=Y
 S ERXIEN=$O(@VALMAR@("IDX",RESP,"")) Q:'ERXIEN
 ; Get the patient IEN
 S ERXPAT=$$GET1^DIQ(52.49,ERXIEN,.04,"I")
 S ERXLOCK=$$L(ERXPAT,1)
 I 'ERXLOCK S DIR(0)="E" D ^DIR K DIR S VALMBCK="R" Q
 D EN^PSOERX1(ERXIEN)
 D UL(ERXPAT)
 K %
 S VALMBCK="R"
 Q
SBN ;
 N Y,ERXIEN
 S Y=+$P(XQORNOD(0),"=",2)
 I 'Y S VALMBCK="R" Q
 S ERXIEN=$O(@VALMAR@("IDX",Y,"")) Q:'ERXIEN
 S ERXPAT=$$GET1^DIQ(52.49,ERXIEN,.04,"I")
 S ERXLOCK=$$L(ERXPAT,1)
 I 'ERXLOCK S DIR(0)="E" D ^DIR K DIR S VALMBCK="R" Q
 D EN^PSOERX1(ERXIEN)
 D UL(ERXPAT)
 S VALMBCK="R"
 K %
 Q
L(DFN,DIS) ; 
 I $G(PSONOLCK) Q 1
 N FLAG S ^XTMP("PSOERXLOCK",0)=$$PDATE
 I '$D(^XTMP("PSOERXLOCK",DFN)) D  Q FLAG
 . D NOW^%DTC S ^XTMP("PSOERXLOCK",DFN)=DUZ_"^"_%
 . L +^XTMP("PSOERXLOCK",DFN):$S($G(DILOCKTM)>0:DILOCKTM,1:3) S FLAG=$S($T=1:$T,1:0)
 I $D(^XTMP("PSOERXLOCK",DFN)) Q $$R
UL(DFN) ; unlock
 I $G(PSONOLCK) Q
 L -^XTMP("PSOERXLOCK",DFN) K ^XTMP("PSOERXLOCK",DFN)
 Q
 ;
R() ; check lock on node
 ;if user has same patient already locked, Q 1, will only lock once
 I $P($G(^XTMP("PSOERXLOCK",DFN)),"^")=DUZ Q 1
 L +^XTMP("PSOERXLOCK",DFN):$S($G(DILOCKTM)>0:DILOCKTM,1:3)
 I $T=1 D NOW^%DTC S ^XTMP("PSOERXLOCK",DFN)=DUZ_"^"_% Q 1
 I $T=0 W:DIS=1 !,$$WHO(DFN) S Y=$P($G(^XTMP("PSOERXLOCK",DFN)),"^",2) X ^DD("DD") Q $S(DIS=0:0_"^"_$P($G(^VA(200,+$P($G(^XTMP("PSOERXLOCK",DFN)),"^"),0)),"^")_"^"_Y,1:0)
 ;
PDATE() ;
 N X1,X2 S X1=DT,X2=+14 D C^%DTC
 Q X_"^"_DT_"^eRx Pharmacy patient locks"
 ;
WHO(DFN) ;
 S Y=$P($G(^XTMP("PSOERXLOCK",DFN)),"^",2) X ^DD("DD")
 Q $P($G(^VA(200,+$P($G(^XTMP("PSOERXLOCK",DFN)),"^"),0)),"^")_" is editing orders for this patient ("_Y_")"
 ;
 ;
 ; TEXT - variable where text is stored (passed by reference)
 ; HDR - header text
 ; DATA - data associated with the header
 ; STRT - start location (column)
 ; LEN - total length for header and data
ADDITEM(TEXT,HDR,DATA,STRT,LEN) ;
 N LLEN,FULLDAT,L
 S FULLDAT=$G(HDR)_$G(DATA)
 S TEXT=$G(TEXT,"") I STRT=1 S TEXT=TEXT_$E(FULLDAT,1,LEN) Q
 S LLEN=$L(TEXT)
 I LLEN<STRT D
 .F L=$L(TEXT):1:STRT-1 D
 ..S TEXT=TEXT_" "
 S TEXT=TEXT_$E(FULLDAT,1,LEN)
 Q
 ; provider information display
PROV ;
 I '$$GET1^DIQ(52.49,PSOIEN,2.3,"I") S XQORM("B")="Edit"
 D EN^PSOERXR1
 Q
 ; patient information display
PAT ;
 I '$$GET1^DIQ(52.49,PSOIEN,.05,"I") S XQORM("B")="Edit"
 D EN^PSOERXP1
 Q
 ; drug information display
DRUG ;
 I '$$GET1^DIQ(52.49,PSOIEN,3.2,"I") S XQORM("B")="Edit"
 D EN^PSOERXD1
 Q
 ; edit validation
 ; EDTYPE - D=drug, P=patient, PR=provider
EDIT(EDTYP,SBN) ;
 N DIR,Y,ITEM,RES,TAG,PQUIT,RXSTAT
 D FULL^VALM1
 S SBN=$G(SBN,"")
 S VALMBCK="R"
 Q:'$G(PSOIEN)
 S RXSTAT=$$GET1^DIQ(52.49,PSOIEN,1,"E") I RXSTAT="RJ"!(RXSTAT="RM")!(RXSTAT="PR") D  Q
 .W !!,"Cannot edit a prescription with a status of 'Rejected', 'Removed',",!,"or 'Processed",!
 .S DIR(0)="E" D ^DIR
 S PSOIENS=PSOIEN_","
 Q:'$D(EDTYP)
 I EDTYP="D" D  Q
 .D PLSTRNG(1,10,.RES,SBN)
 .I '$O(RES(0)) Q
 .D DERX1^PSOERXD2(PSOIEN,PSOIENS)
 .S (ITEM,PQUIT)=0 F  S ITEM=$O(RES(ITEM)) Q:'ITEM!(PQUIT)  D
 ..S TAG="VDRG"_ITEM_"^PSOERXD2(PSOIEN,PSOIENS)" D @TAG
 .K @VALMAR D INIT^PSOERXD1
 I EDTYP="P" D VPAT K @VALMAR D INIT^PSOERXP1 Q
 I EDTYP="PR" D VPROV K @VALMAR D INIT^PSOERXR1 Q
 Q
 ; edit provider
VPROV ;
 N EXPRVIEN,VAPRVIEN,MANVAL,PRVDAT,EXPRNAME,EXPRLNAM,EXPRFNAM,PSOIENS
 N EXPRIENS,SELPRV,QUIT,VAPNM,NEWPIEN,VANPI
 S PSOIENS=PSOIEN_","
 S VAPNM=$$GET1^DIQ(52.49,PSOIEN,2.3,"E")
 S EXPRVIEN=$$GET1^DIQ(52.49,PSOIEN,2.1,"I")
 S EXPRIENS=EXPRVIEN_","
 D GETS^DIQ(52.48,EXPRIENS,".01;.02;.03;1.5;1.6","E","PRVDAT")
 S EXPRNAME=$G(PRVDAT(52.48,EXPRIENS,.01,"E"))
 S EXPRLNAM=$G(PRVDAT(52.48,EXPRIENS,.02,"E"))
 S EXPRFNAM=$G(PRVDAT(52.48,EXPRIENS,.03,"E"))
 S MANVAL=$$GET1^DIQ(52.49,PSOIEN,1.3,"I")
 S VAPIEN=$$GET1^DIQ(52.49,PSOIEN,2.3,"I")
 I VAPIEN D  Q
 .W !,"Current Vista provider: "_VAPNM,!
 .S DIR(0)="YO",DIR("A")="Would you like to modify the current provider"
 .I MANVAL S DIR("A",1)="This provider has already been validated."
 .S DIR("B")="NO" D ^DIR
 .Q:'Y
 .S DIC=200,DIC("A")="Select PROVIDER NAME: ",DIC(0)="AEMQ",DIC("S")="I $$CHKPRV2^PSOERX1A(Y)" D ^DIC
 .Q:Y<1
 .S NEWPIEN=$P(Y,U) K Y
 .S ERXMMFLG=$$PRVWARN(PSOIEN,VAPIEN)
 .S DIR(0)="Y",DIR("A")="Would you like to use this provider"
 .S DIR("A",1)="You have selected provider: "_$$GET1^DIQ(200,NEWPIEN,.01,"E")
 .S DIR("B")=$S(ERXMMFLG:"NO",1:"YES") D ^DIR
 .I Y<1 S QUIT=1 Q
 .; change existing entry
 .S FDA(52.49,PSOIENS,2.3)=NEWPIEN
 .; if the provider is different, clear manual validation
 .I VAPIEN'=NEWPIEN S FDA(52.49,PSOIENS,1.3)="",FDA(52.49,PSOIENS,1.8)="",FDA(52.49,PSOIENS,1.9)=""
 .D FILE^DIE(,"FDA") K FDA
 .I $$GET1^DIQ(52.49,PSOIEN,1,"E")="N" D UPDSTAT^PSOERXU1(PSOIEN,"I")
 ; for now, only list providers that are authorized to write med orders and whose dea is not expired
 S DIC=200,DIC("A")="Select PROVIDER NAME: ",DIC(0)="AEMQ",DIC("S")="I $$CHKPRV2^PSOERX1A(Y)" D ^DIC
 Q:Y<1
 S SELPRV=$P(Y,U)
 S ERXMMFLG=$$PRVWARN(PSOIEN,SELPRV)
 S DIR(0)="Y",DIR("A")="Would you like to use this provider"
 S DIR("A",1)="You have selected provider: "_$$GET1^DIQ(200,SELPRV,.01,"E")
 S DIR("B")=$S(ERXMMFLG:"NO",1:"YES") D ^DIR
 Q:Y<1
 S FDA(52.49,PSOIENS,2.3)=$P(SELPRV,U)
 D FILE^DIE(,"FDA","ERR") K FDA
 I $$GET1^DIQ(52.49,PSOIEN,1,"E")="N" D UPDSTAT^PSOERXU1(PSOIEN,"I")
 Q
PRVWARN(PSOIEN,VAPIEN) ;
 N EXPRVNPI,VANPI,ERXDEA,VADEA,ERXMMFLG,I,ERXMSG,ERXPIEN,EXPRVDEA
 S ERXMMFLG=0
 S ERXPIEN=$$GET1^DIQ(52.49,PSOIEN,2.1,"I")
 S EXPRVNPI=$$GET1^DIQ(52.48,ERXPIEN,1.5,"E")
 S EXPRVDEA=$$GET1^DIQ(52.48,ERXPIEN,1.6,"E")
 I '$G(VAPIEN) S VAPIEN=$$GET1^DIQ(52.49,PSOIEN,2.3,"I") I '$G(VAPIEN) Q 0
 I EXPRVNPI]"",'$D(^VA(200,"ANPI",EXPRVNPI,VAPIEN)) S ERXMMFLG=1,ERXMSG(1)="Provider NPI Mismatch."
 I EXPRVDEA]"",'$D(^VA(200,"PS1",EXPRVDEA,VAPIEN)) S ERXMMFLG=1,ERXMSG(2)="Provider DEA Mismatch."
 I 'ERXMMFLG Q ERXMMFLG
 W !!,"******************************WARNING********************************"
 S I=0 F  S I=$O(ERXMSG(I)) Q:'I  D
 .W !,$G(ERXMSG(I))
 W !,"*********************************************************************"
 Q ERXMMFLG
CHKPRV2(Y) ;
 ;Ref. to ^VA(200 supp. by IA 224
 I '$P($G(^VA(200,Y,"PS")),U) Q 0
 Q 1
 ; validate drug
 ; prompt list or range
 ; LOW - lowest number to prompt for
 ; HIGH - highest number to prompt for
 ; EDIT - returned list of selected values
 ;        EDIT(n1)=""
 ;        EDIT(n2)=""
 ;        EDIT(n3)=""
PLSTRNG(LOW,HIGH,EDIT,SBN) ;
 N DIR,DONE,DONE2,Y,NUMCHK,NUM,VAL,I,LIST
 I '$G(LOW)!'$G(HIGH) S LIST=0 Q
 S DONE=0
 F  D  Q:DONE
 .I $$GET1^DIQ(52.49,PSOIEN,3.2,"I")="" S Y="A"
 .I '$D(Y),'$O(^PS(52.49,PSOIEN,21,0)) S Y="A"
 .I SBN']"",'$D(Y) D
 ..S DIR(0)="FO^",DIR("A")="Which field(s) would you like to edit? ("_LOW_"-"_HIGH_") or 'A'll"
 ..S DIR("?")="Enter a number, range, or a list of numbers (i.e. 3, 1-5, 3,7,9, or 'A'll)"
 ..S DIR("B")="A"
 ..D ^DIR K DIR
 ..I Y="^" S DONE=1 Q
 .I SBN]"",'$D(Y) S Y=SBN
 .Q:Y["."
 .I Y="^" S DONE=1 Q
 .S Y=$$UP^XLFSTR(Y)
 .I Y="A"!(Y="ALL") D  Q
 ..F I=LOW:1:HIGH D
 ...S EDIT(I)=""
 ..S DONE=1
 .; check for a range or list of numbers
 .I Y'["-",Y'[",",Y'<LOW,Y'>HIGH S EDIT(+Y)="" S DONE=1 Q
 .I Y?1.2N1"-"1.2N D
 ..F I=$P(Y,"-"):1:$P(Y,"-",2) D
 ...Q:I<LOW!(I>HIGH)
 ...S EDIT(I)=""
 .I $D(EDIT) S DONE=1 Q
 .I Y["," D
 ..; check to see if there are alpha-numerics if there are, quit and reprompt
 ..S NUMCHK=$TR(Y,",","") I 'NUMCHK W !,"Invalid response." Q
 ..S DONE2=0
 ..F NUM=1:1 D  Q:DONE2
 ...S VAL=$P(Y,",",NUM)
 ...I 'VAL S DONE2=1 Q
 ...I VAL<LOW!(VAL>HIGH) Q
 ...S EDIT(VAL)=""
 .I $D(EDIT) S DONE=1 Q
 .W !,"Invalid Response."
 .W !,"Answer must be numeric (1-10), a series of numbers (3,5,7), 'A' or 'ALL'."
 .S DIR(0)="E" D ^DIR K Y,DIR
 .;S DONE=1
 Q
 ; validate patient
VPAT ;
 N ERXPIEN,VAPIEN,MANVAL,ERXLNAME,ERXFNAME,DIR,Y,PSOIENS,VAPIEN,MANVAL,DIR,DIC,SELPAT,PDONE,DFN,I
 S PSOIENS=PSOIEN_","
 S ERXPIEN=$$GET1^DIQ(52.49,PSOIEN,.04,"I")
 S ERXLNAME=$$GET1^DIQ(52.46,ERXPIEN,.02,"E")
 S ERXFNAME=$$GET1^DIQ(52.46,ERXPIEN,.03,"E")
 S VAPIEN=$$GET1^DIQ(52.49,PSOIEN,.05,"I")
 S MANVAL=$$GET1^DIQ(52.49,PSOIEN,1.7,"I")
 ; if there is a patient currently defined
 I VAPIEN D  Q
 .W !,"Current Vista patient: "_$$GET1^DIQ(2,VAPIEN,.01,"E"),!
 .S DIR(0)="YO",DIR("A")="Would you like to edit the patient"
 .S DIR("A",1)="A patient has already matched to a vista patient."
 .S DIR("B")="NO" D ^DIR
 .Q:Y'=1
 .S SELPAT=$$PATPRMT() K DUOUT Q:'SELPAT
 .S DFN=SELPAT D DEM^VADPT
 .I $P($G(VADM(6)),U)]"" W "[PATIENT DIED ON "_$P($G(VADM(6)),U,2)_"]" Q
 .S ERXMMFLG=$$PATWARN(PSOIEN,SELPAT)
 .S DIR(0)="Y",DIR("A")="Would you like to use this patient"
 .S DIR("A",1)="You have selected patient: "_$$GET1^DIQ(2,SELPAT,.01,"E")
 .S DIR("B")=$S($G(ERXMMFLG):"NO",1:"YES") D ^DIR
 .Q:Y'=1
 .; change existing entry
 .S FDA(52.49,PSOIENS,.05)=SELPAT
 .I SELPAT'=VAPIEN S FDA(52.49,PSOIENS,1.7)="",FDA(52.49,PSOIENS,1.13)="",FDA(52.49,PSOIENS,1.14)=""
 .D FILE^DIE(,"FDA") K FDA
 .I $$GET1^DIQ(52.49,PSOIEN,1,"E")="N" D UPDSTAT^PSOERXU1(PSOIEN,"I")
 S SELPAT=$$PATPRMT() K DUOUT I 'SELPAT S XQORM("B")="Edit" Q
 S DFN=SELPAT D DEM^VADPT
 I $P($G(VADM(6)),U)]"" W "[PATIENT DIED ON "_$P($G(VADM(6)),U,2)_"]" S DIR(0)="E" D ^DIR K DIR Q
 S ERXMMFLG=$$PATWARN(PSOIEN,SELPAT)
 S DIR(0)="Y",DIR("A")="Would you like to use this patient"
 S DIR("A",1)="You have selected patient: "_$$GET1^DIQ(2,SELPAT,.01,"E")
 S DIR("B")=$S($G(ERXMMFLG):"NO",1:"YES") D ^DIR
 I Y'=1 S XQORM("B")="Edit" Q
 S FDA(52.49,PSOIENS,.05)=SELPAT
 D FILE^DIE(,"FDA") K FDA
 I $$GET1^DIQ(52.49,PSOIEN,1,"E")="N" D UPDSTAT^PSOERXU1(PSOIEN,"I")
 Q
PATWARN(PSOIEN,SELPAT) ;
 N ERXPIEN,ERXSSN,ERXDOB,ERXGEN,ERXMMFLG,ERXMSG,EXPRVDEA
 S ERXMMFLG=0
 S ERXPIEN=$$GET1^DIQ(52.49,PSOIEN,.04,"I")
 S ERXSSN=$$GET1^DIQ(52.46,ERXPIEN,1.4,"E"),ERXSSN=$TR(ERXSSN,"-","")
 S ERXDOB=$$GET1^DIQ(52.46,ERXPIEN,.08,"I")
 S ERXGEN=$$GET1^DIQ(52.46,ERXPIEN,.07,"I")
 ; if the selected patient is not defined, use the va matched patient because we are doing this check
 ; during accept validation
 I '$G(SELPAT) S SELPAT=$$GET1^DIQ(52.49,PSOIEN,.05,"I") Q:'$G(SELPAT) 0
 I '$D(VADM) S DFN=SELPAT D DEM^VADPT
 I ERXSSN,'$D(^DPT("SSN",ERXSSN,SELPAT)) S ERXMMFLG=1,ERXMSG(1)="SSN mismatch."
 I ERXDOB,'$D(^DPT("ADOB",ERXDOB,SELPAT)) S ERXMMFLG=1,ERXMSG(2)="Date of Birth mismatch."
 I ERXGEN]"",$P($G(VADM(5)),U)'=ERXGEN S ERXMMFLG=1,ERXMSG(3)="Gender mismatch."
 Q:'ERXMMFLG 0
 W !!,"******************************WARNING********************************"
 S I=0 F  S I=$O(ERXMSG(I)) Q:'I  D
 .W !,$G(ERXMSG(I))
 W !,"*********************************************************************"
 Q 1
PATPRMT() ;
 N Y
 D ^DPTLK
 I $P(Y,U)<1 Q 0
 Q $P(Y,U)
