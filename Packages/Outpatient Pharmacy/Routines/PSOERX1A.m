PSOERX1A ;ALB/BWF - eRx Utilities/RPC's ; 8/3/2016 5:14pm
 ;;7.0;OUTPATIENT PHARMACY;**467,527,508,551,581,617,669,700,743,746,770**;DEC 1997;Build 145
 ;
 Q
 ; select an item
SI ;
 N RESP,ERXIEN,ERXDAT,LINE,LINEVAR,ERXPAT,ERXLOCK,DIR,NEWRXIEN,REQIEN,MTYPE,Y
 D FULL^VALM1
 S DIR(0)="N^"_VALMBG_":"_VALMLST_":0" D ^DIR
 I 'Y S VALMBCK="R" Q
 S RESP=Y
 S ERXIEN=$O(@VALMAR@("IDX",RESP,"")) Q:'ERXIEN
 ; Get the patient IEN
 S ERXPAT=$$GETPAT^PSOERXU5(ERXIEN)
 S MTYPE=$$GET1^DIQ(52.49,ERXIEN,.08,"I")
 I 'ERXPAT,"IEOE"[MTYPE D EN^PSOERX1(ERXIEN) S VALMBCK="R" Q
 I '$D(PCV) D  Q
 .S ERXLOCK=$$L(ERXPAT,1)
 .I 'ERXLOCK S DIR(0)="E" D ^DIR K DIR S VALMBCK="R" Q
 .D EN^PSOERX1(ERXIEN)
 .D UL(ERXPAT)
 .K % S VALMBCK="R"
 D EN^PSOERX1(ERXIEN)
 K %
 S VALMBCK="R"
 Q
SBN ;
 N Y,ERXIEN,ERXPAT,DIR,MTYPE
 D FULL^VALM1
 S Y=+$P(XQORNOD(0),"=",2)
 I 'Y S VALMBCK="R" Q
 S ERXIEN=$O(@VALMAR@("IDX",Y,"")) Q:'ERXIEN
 S ERXPAT=$$GETPAT^PSOERXU5(ERXIEN)
 S MTYPE=$$GET1^DIQ(52.49,ERXIEN,.08,"I")
 I 'ERXPAT,"IEOE"[MTYPE D EN^PSOERX1(ERXIEN) S VALMBCK="R" Q
 I '$D(PCV) D  Q
 .S ERXLOCK=$$L(ERXPAT,1)
 .I 'ERXLOCK S DIR(0)="E" D ^DIR K DIR S VALMBCK="R" Q
 .D EN^PSOERX1(ERXIEN)
 .D UL(ERXPAT)
 .S VALMBCK="R" K %
 D EN^PSOERX1(ERXIEN)
 S VALMBCK="R"
 K %
 Q
L(DFN,DIS,SILENT) ; Locks an eRx Patient
 ; Input: DFN    - Pointer to eRx Patient (Pointer to #52.46)
 ;        DIS    - Display name of the user currently locking the record
 ;     (o)SILENT - 1: Silent call - Nothing displayed back | 0: Display information about the Lock on the screen
 ;Output: 1 - Record Locked Successfully | 0 - Record already Locked by another user
 I $G(PSONOLCK) Q 1
 N FLAG,LKTOUT S ^XTMP("PSOERXLOCK",0)=$$PDATE,LKTOUT=0
 S LKTOUT=$S($$GET1^DIQ(59.7,1,102,"I")="MBM":0,$G(DILOCKTM)>0:DILOCKTM,1:3)
 ; If a lock is already established for this patient and is associated with the current user
 I $P($G(^XTMP("PSOERXLOCK",DFN)),"^",1)=DUZ D  Q FLAG
 . L +^XTMP("PSOERXLOCK",DFN):LKTOUT S FLAG=$T
 . I 'FLAG W:'$G(SILENT) !,"You have this patient locked in another open session"
 I '$D(^XTMP("PSOERXLOCK",DFN)) D  Q FLAG
 . L +^XTMP("PSOERXLOCK",DFN):LKTOUT S FLAG=$T
 . I FLAG D
 . . D NOW^%DTC S ^XTMP("PSOERXLOCK",DFN)=DUZ_"^"_%
 . . S FDA(52.46,DFN_",",6)=DUZ
 . . D UPDATE^DIE(,"FDA") K FDA
 I $D(^XTMP("PSOERXLOCK",DFN)) Q $$R
 ;
UL(DFN) ; unlock
 I $G(PSONOLCK) Q
 L -^XTMP("PSOERXLOCK",DFN) K ^XTMP("PSOERXLOCK",DFN)
 Q
 ;
R() ; check lock on node
 N MBMSITE
 S MBMSITE=$S($$GET1^DIQ(59.7,1,102,"I")="MBM":1,1:0)
 N LKTOUT S LKTOUT=$S($G(MBMSITE):0,$G(DILOCKTM)>0:DILOCKTM,1:3)
 ;if user has same patient already locked, Q 1, will only lock once
 I $P($G(^XTMP("PSOERXLOCK",DFN)),"^")=DUZ Q 1
 L +^XTMP("PSOERXLOCK",DFN):LKTOUT I $T D  Q 1
 .D NOW^%DTC S ^XTMP("PSOERXLOCK",DFN)=DUZ_"^"_%
 .S FDA(52.46,DFN_",",6)=DUZ
 .D UPDATE^DIE(,"FDA") K FDA
 I $T=0 W:DIS=1&'$G(SILENT) !,$$WHO(DFN) S Y=$P($G(^XTMP("PSOERXLOCK",DFN)),"^",2) X ^DD("DD") Q $S(DIS=0:0_"^"_$P($G(^VA(200,+$P($G(^XTMP("PSOERXLOCK",DFN)),"^"),0)),"^")_"^"_Y,1:0)
 Q 0
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
 D FULL^VALM1 I $$DONOTFIL^PSOERXUT(PSOIEN) S VALMBCK="R" Q
 N STAT,RESVAL
 S RESVAL=$$GET1^DIQ(52.49,PSOIEN,52.1,"I")
 S STAT=$$GET1^DIQ(52.49,PSOIEN,1,"E")
 I STAT="RXE",'$$RXEPRMT^PSOERXU7(PSOIEN) Q
 I STAT="CXE",(RESVAL="A"!(RESVAL="AWC"))!(RESVAL="V"),'$$RXEPRMT^PSOERXU7(PSOIEN) Q
 I '$$GET1^DIQ(52.49,PSOIEN,2.3,"I") S XQORM("B")="Edit"
 D EN^PSOERXR1
 D INIT^PSOERSE1
 Q
 ; patient information display
PAT ;
 D FULL^VALM1 I $$DONOTFIL^PSOERXUT(PSOIEN) S VALMBCK="R" Q
 N STAT,RESVAL
 S RESVAL=$$GET1^DIQ(52.49,PSOIEN,52.1,"I")
 S STAT=$$GET1^DIQ(52.49,PSOIEN,1,"E")
 I STAT="RXE",'$$RXEPRMT^PSOERXU7(PSOIEN) Q
 I STAT="CXE",(RESVAL="A"!(RESVAL="AWC"))!(RESVAL="V"),'$$RXEPRMT^PSOERXU7(PSOIEN) Q
 I '$$GET1^DIQ(52.49,PSOIEN,.05,"I") S XQORM("B")="Edit"
 D EN^PSOERXP1
 D INIT^PSOERSE1
 Q
 ; drug information display
DRUG ;
 D FULL^VALM1 I $$DONOTFIL^PSOERXUT(PSOIEN) S VALMBCK="R" Q
 N STAT,RESVAL
 S RESVAL=$$GET1^DIQ(52.49,PSOIEN,52.1,"I")
 S STAT=$$GET1^DIQ(52.49,PSOIEN,1,"E")
 I STAT="RXE",'$$RXEPRMT^PSOERXU7(PSOIEN) Q
 I STAT="CXE",(RESVAL="A"!(RESVAL="AWC"))!(RESVAL="V"),'$$RXEPRMT^PSOERXU7(PSOIEN) Q
 I '$$GET1^DIQ(52.49,PSOIEN,3.2,"I") S XQORM("B")="Edit"
 D EN^PSOERXD1
 D INIT^PSOERSE1
 Q
 ; edit validation
 ; EDTYPE - D=drug, P=patient, PR=provider
EDIT(EDTYP,SBN) ;
 N MBMSITE,DIR,Y,ITEM,RES,TAG,PQUIT,RXSTAT,SUGVARX
 S MBMSITE=$S($$GET1^DIQ(59.7,1,102,"I")="MBM":1,1:0)
 D FULL^VALM1
 S SBN=$G(SBN,"")
 S VALMBCK="R"
 Q:'$G(PSOIEN)
 S RXSTAT=$$GET1^DIQ(52.49,PSOIEN,1,"E") I RXSTAT="RJ"!(RXSTAT="RM")!(RXSTAT="PR")!($G(MBMSITE)&($E(RXSTAT,1,3)="REM")) D  Q
 . W !!,"Cannot edit a prescription with a status of 'Rejected', 'Removed',",!,"or 'Processed",!
 . S DIR(0)="E" D ^DIR
 S PSOIENS=PSOIEN_","
 Q:'$D(EDTYP)
 I EDTYP="D" D  Q
 . S SUGVARX=$$MATCHSUG^PSOERUT6(PSOIEN)
 . I $G(SUGVARX) D  Q
 . . I +$P(SUGVARX,"^",2)=-1 Q  ;if the user ^ in the Patient Instruction prompt, do not update all the fields
 . . W !?64,"Updating..."
 . . D SAVEDRUG^PSOERUT2(PSOIEN,+SUGVARX,$P(SUGVARX,"^",2))
 . . I RXSTAT="N" D UPDSTAT^PSOERXU1(PSOIEN,"I")
 . . I $$GET1^DIQ(52.49,PSOIEN,.08,"I")="RE",RXSTAT'="RXI" D UPDSTAT^PSOERXU1(PSOIEN,"RXI")
 . . K @VALMAR D INIT^PSOERXD1 S VALMBCK="R"
 . . H .5 W "done." H 1
 . W !
 . D PLSTRNG(1,11,.RES,SBN)
 . I '$O(RES(0)) Q
 . I $D(RES(1)) D DERX1^PSOERXD2(PSOIEN,PSOIENS)
 . S (ITEM,PQUIT)=0 F  S ITEM=$O(RES(ITEM)) Q:'ITEM!(PQUIT)  D
 . . S TAG="VDRG"_ITEM_"^PSOERXD2(PSOIEN,PSOIENS)" D @TAG
 . K @VALMAR D INIT^PSOERXD1
 I EDTYP="P" D VPAT K @VALMAR D INIT^PSOERXP1 Q
 I EDTYP="PR" D VPROV K @VALMAR D INIT^PSOERXR1 Q
 Q
 ; edit provider
VPROV ;
 N MBMSITE,EXPRVIEN,VAPRVIEN,MANVAL,PRVDAT,EXPRNAME,EXPRLNAM,EXPRFNAM,PSOIENS,ERXMMFLG,FDA
 N EXPRIENS,SELPRV,QUIT,VAPNM,NEWPIEN,VANPI,MTYPE,RESTYPE,ERXSTAT,NEWVAL,DONE,PSOQUIT
 S MBMSITE=$S($$GET1^DIQ(59.7,1,102,"I")="MBM":1,1:0)
 S PSOIENS=PSOIEN_","
 S VAPNM=$$GET1^DIQ(52.49,PSOIEN,2.3,"E")
 S EXPRVIEN=$$GET1^DIQ(52.49,PSOIEN,2.1,"I")
 S EXPRIENS=EXPRVIEN_","
 D GETS^DIQ(52.48,EXPRIENS,".01;.02;.03;1.5;1.6","E","PRVDAT")
 S EXPRNAME=$G(PRVDAT(52.48,EXPRIENS,.01,"E"))
 S EXPRLNAM=$G(PRVDAT(52.48,EXPRIENS,.02,"E"))
 S EXPRFNAM=$G(PRVDAT(52.48,EXPRIENS,.03,"E"))
 S MANVAL=$$GET1^DIQ(52.49,PSOIEN,1.3,"I")
 S MTYPE=$$GET1^DIQ(52.49,PSOIEN,.08,"I")
 S VAPIEN=$$GET1^DIQ(52.49,PSOIEN,2.3,"I")
 S RESTYPE=$$GET1^DIQ(52.49,PSOIEN,52.1,"I")
 S ERXSTAT=$$GET1^DIQ(52.49,PSOIEN,1,"E")
 ;
 ; There is a Provider currently selected
 S PSOQUIT=0
 I VAPIEN D  I PSOQUIT Q
 . K DIR W !,"Current Vista Provider: "_VAPNM,!
 . S DIR(0)="YO",DIR("A")="Would you like to edit the Provider"
 . I MANVAL S DIR("A",1)="This Provider has already been validated."
 . S DIR("B")="NO" D ^DIR I 'Y!$D(DIRUT)!$D(DIROUT) S PSOQUIT=1 Q
 . W !
 ; Suggesting a VistA Provider
 S NEWPIEN=$$MATCHSUG^PSOERPV1(PSOIEN)
 ;
 I '$G(NEWPIEN) D  I PSOQUIT Q
 . K DIC W ! S DIC=200,DIC(0)="QEAM",DIC("A")="VISTA PROVIDER: ",DIC("S")="I $$CHKPRV2^PSOERX1A(Y)"
 . I $G(MBMSITE) S DIC("W")="D PRVIDS^PSOERPV1"
 . D ^DIC I Y<0 S PSOQUIT=1 Q
 . S NEWPIEN=+Y
 . D CMPPRV^PSOERPV1(PSOIEN,NEWPIEN)
 . S ERXMMFLG=$$PRVWARN("EP",PSOIEN,NEWPIEN)
 . S DIR(0)="Y",DIR("A")="Would you like to use this Provider"
 . S DIR("B")=$S($G(ERXMMFLG):"NO",1:"YES") D ^DIR I 'Y!$D(DIRUT)!$D(DIROUT) S PSOQUIT=1 Q
 ;
 W !?64,"Updating..."
 ; Setting the eRx Audit Log
 S NEWVAL(1)=$$GET1^DIQ(200,NEWPIEN,.01)_" (DEA#: "_$P($$VADEA^PSOERXU8(NEWPIEN,PSOIEN),"^",2)_")"
 D AUDLOG^PSOERXUT(+PSOIENS,"PROVIDER",DUZ,.NEWVAL)
 ;
 ; change existing entry
 S FDA(52.49,PSOIENS,2.3)=NEWPIEN
 ; Removing Manual Validation fields
 S FDA(52.49,PSOIENS,1.3)="",FDA(52.49,PSOIENS,1.8)="",FDA(52.49,PSOIENS,1.9)=""
 ; If auto-matched, change PROV STAT (AUTO-VAL) #1.2 to 2 (VALIDATED/EDITED)
 I $$GET1^DIQ(52.49,+PSOIENS,1.2,"I")=1 S FDA(52.49,PSOIENS,1.2)=2
 D FILE^DIE(,"FDA")
 ;
 ; Updating eRx Status to In Progress 
 I MTYPE="N" D UPDSTAT^PSOERXU1(PSOIEN,"I")
 I MTYPE="RE",RESTYPE="R" D UPDSTAT^PSOERXU1(PSOIEN,"RXI") Q
 I MTYPE="RE" D UPDSTAT^PSOERXU1(PSOIEN,"RXW")
 I MTYPE="CX" D UPDSTAT^PSOERXU1(PSOIEN,"CXI")
 H .5 W "done.",$C(7) H 1
 Q
 ;
PRVWARN(ACTION,PSOIEN,VAPIEN) ; Check whether the Provider Select is valid or not
 ; Input:(r)ACTION - Ation being peformed ("EP": Edit Provider | "VP": Validate Provider)
 ;       (r)PSOIEN - Pointer to the ERX HOLDING QUEUE file (#52.49)
 ;       (r)VAPIEN - Provider -Pointer to the NEW PERSON file (#200)
 ;Output: 1 - No Issues Found with Provider Selected | 2 - Issues Found With Provider Select by Ok to to proceed | 0 - Invalid Provider Selection
 N EXPRVNPI,VANPI,ERXDEA,VADEA,I,ERXMSG,ERXPIEN,EXPRVDEA,ERXDRIEN
 S ERXPIEN=$$GET1^DIQ(52.49,PSOIEN,2.1,"I")
 S ERXDRIEN=+$$GET1^DIQ(52.49,PSOIEN,3.2,"I")
 I '$G(VAPIEN) S VAPIEN=$$GET1^DIQ(52.49,PSOIEN,2.3,"I") I '$G(VAPIEN) Q 0
 D PRDRVAL^PSOERXUT(.ERXMSG,ACTION,PSOIEN,VAPIEN,ERXDRIEN)
 I +ERXMSG Q 1
 W !!,"*******************************",$S($P(ERXMSG,"^",2)="W":"   WARNING(S)   ",1:"INVALID PROVIDER"),"*********************************"
 S I=0 F  S I=$O(ERXMSG(I)) Q:'I  W !,$P(ERXMSG(I),"^")
 W !,"********************************************************************************"
 I $P(ERXMSG,"^",2)="W" Q 2
 Q 0
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
 .I SBN']"",'$D(Y)!($G(Y)[" ")!($G(Y)[".") D
 ..S DIR(0)="FO^",DIR("A")="Which field(s) would you like to edit? ("_LOW_"-"_HIGH_") or 'A'll"
 ..S DIR("?")="Enter a number, range, or a list of numbers (i.e. 3, 1-5, 3,7,9, or 'A'll)"
 ..S DIR("B")="A"
 ..D ^DIR K DIR I $D(DIRUT)!$D(DTOUT) S DONE=1 Q
 ..I Y="^" S DONE=1 Q
 .I SBN']"",Y["-",Y["," D  Q
 ..W !!,"Invalid Response."
 ..W !,"Answer must be numeric (1-11), a series of numbers (3,5,7), 'A' or 'ALL'."
 ..S DIR(0)="E" D ^DIR K Y,DIR I $D(DIRUT)!$D(DTOUT) S DONE=1 Q
 .I SBN']"",(Y[".")!(Y[" ") D  Q
 ..W !!,"Invalid Response."
 ..W !,"Answer must be numeric (1-11), a series of numbers (3,5,7), 'A' or 'ALL'."
 ..S DIR(0)="E" D ^DIR K DIR I $D(DIRUT)!$D(DTOUT) S DONE=1 Q
 ..I Y'[" " K Y
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
 ...S EDIT(+I)=""
 .I $D(EDIT) S DONE=1 Q
 .I Y["," D
 ..; check to see if there are alpha-numerics if there are, quit and reprompt
 ..S NUMCHK=$TR(Y,",","") I 'NUMCHK W !,"Invalid response." Q
 ..S DONE2=0
 ..F NUM=1:1 D  Q:DONE2
 ...S VAL=$P(Y,",",NUM)
 ...I 'VAL S DONE2=1 Q
 ...I VAL<LOW!(VAL>HIGH) Q
 ...S EDIT(+VAL)=""
 .I $D(EDIT) S DONE=1 Q
 .W !,"Invalid Response."
 .W !,"Answer must be numeric (1-11), a series of numbers (3,5,7), 'A' or 'ALL'."
 .K DIR S DIR(0)="E" D ^DIR K Y,DIR
 Q
 ; Match Patient
VPAT ;
 N MBMSITE,ERXPIEN,VAPIEN,MANVAL,ERXLNAME,ERXFNAME,DIR,Y,PSOIENS,VAPIEN,MANVAL,DIC,SELPAT,PDONE,DFN,I,VADM
 N ERXSTAT,RESTYPE,MTYPE,PSOQUIT,FDA,GMRA,GMRAL
 S MBMSITE=$S($$GET1^DIQ(59.7,1,102,"I")="MBM":1,1:0)
 S PSOIENS=PSOIEN_","
 S ERXPIEN=$$GET1^DIQ(52.49,PSOIEN,.04,"I")
 S ERXLNAME=$$GET1^DIQ(52.46,ERXPIEN,.02,"E")
 S ERXFNAME=$$GET1^DIQ(52.46,ERXPIEN,.03,"E")
 S VAPIEN=$$GET1^DIQ(52.49,PSOIEN,.05,"I")
 S MANVAL=$$GET1^DIQ(52.49,PSOIEN,1.7,"I")
 S RESTYPE=$$GET1^DIQ(52.49,PSOIEN,52.1)
 S ERXSTAT=$$GET1^DIQ(52.49,PSOIEN,1,"E")
 S MTYPE=$$GET1^DIQ(52.49,PSOIEN,.08,"I")
 ; There is a patient currently selected
 S PSOQUIT=0
 I VAPIEN D  I PSOQUIT Q
 . K DIR W !,"Current Vista patient: "_$$GET1^DIQ(2,VAPIEN,.01,"E"),!
 . S DIR(0)="YO",DIR("A")="Would you like to edit the patient"
 . I MANVAL S DIR("A",1)="This Patient has already been validated."
 . S DIR("B")="NO" D ^DIR I 'Y!$D(DIRUT)!$D(DIROUT) S PSOQUIT=1 Q
 ; Suggesting a VistA Patient
 S SELPAT=$$MATCHSUG^PSOERPT1(PSOIEN)
 ;
 I '$G(SELPAT) D  I PSOQUIT Q
 . K DIC,DIR W ! S DIC=2,DIC(0)="QEAM",DIC("A")="VISTA PATIENT: ",DIC("S")="I '$$DEAD^PSONVARP(Y)"
 . I $G(MBMSITE) S DIC("W")="D PATIDS^PSOERPT1"
 . D ^DPTLK I Y<0 S PSOQUIT=1 Q
 . S SELPAT=+Y
 . D CMPPAT^PSOERPT1(PSOIEN,SELPAT)
 . S ERXMMFLG=$$PATWARN^PSOERX1E("EP",PSOIEN,SELPAT)
 . S DIR(0)="Y",DIR("A")="Would you like to use this patient"
 . S DIR("B")=$S($G(ERXMMFLG):"NO",1:"YES") D ^DIR I 'Y!$D(DIRUT)!$D(DIROUT) S PSOQUIT=1 Q
 ;
 W !?64,"Updating..."
 ;Setting the eRx Audit Log
 S DFN=SELPAT D DEM^VADPT
 N NEWVAL S NEWVAL(1)=$$GET1^DIQ(2,SELPAT,.01)_" (L4SSN: "_$P($P(VADM(2),"^",2),"-",3)_" | DOB: "_$P(VADM(3),"^",2)_")"
 D AUDLOG^PSOERXUT(+PSOIENS,"PATIENT",DUZ,.NEWVAL)
 ;
 ;Updating eRx Record w/ New Patient
 S FDA(52.49,PSOIENS,.05)=SELPAT
 S FDA(52.49,PSOIENS,1.7)="",FDA(52.49,PSOIENS,1.13)="",FDA(52.49,PSOIENS,1.14)=""
 ; If auto-matched, change PAT STATUS (AUTO-VAL) #1.6 to 2 (VALIDATED/EDITED)
 I $$GET1^DIQ(52.49,+PSOIENS,1.6,"I")=1 S FDA(52.49,PSOIENS,1.6)=2
 D FILE^DIE(,"FDA")
 ;
 ; VistA Patient ChampVA Eligibility Check (MbM Only)
 I $G(MBMSITE),'$$CHVAELIG^PSOERXU9(SELPAT) D  Q
 . I ",N,I,W,RXI,RXN,RXW,RXR,CXI,CXN,CXW,"[(","_$G(ERXSTAT)_",") D
 . . D UPDSTAT^PSOERXU1(PSOIEN,"HEL","Hold due to Eligibility Issue")
 . . W !!,"This eRx has been put on Hold (HEL) because the VistA Patient ("_$$GET1^DIQ(2,SELPAT,.01)_") is not Eligible for ChampVA Rx Benefit."
 . . K DIR D PAUSE^VALM1
 . D AUTOHOLD^PSOERX1E("E",PSOIEN,SELPAT)
 ;
 ;VistA Patient Allergy Check (MbM Only)
 I $G(MBMSITE) D  I $G(GMRAL)="" Q
 . S DFN=SELPAT,GMRA="0^0^111" D EN1^GMRADPT I $G(GMRAL)'="" Q
 . I ",N,I,W,RXI,RXN,RXW,RXR,CXI,CXN,CXW,"[(","_$G(ERXSTAT)_",") D
 . . D UPDSTAT^PSOERXU1(PSOIEN,"HAL","Hold for Allergy Assessment")
 . . W !!,"This eRx has been put on Hold (HAL) because the VistA Patient ("_$$GET1^DIQ(2,SELPAT,.01)_") does not have an Allergy Assessment.."
 . . K DIR D PAUSE^VALM1
 . D AUTOHOLD^PSOERX1E("A",PSOIEN,SELPAT)
 ;
 ;Updating eRx Status to In Progress 
 I MTYPE="N" D UPDSTAT^PSOERXU1(PSOIEN,"I")
 I MTYPE="RE" D UPDSTAT^PSOERXU1(PSOIEN,"RXI")
 I MTYPE="CX" D UPDSTAT^PSOERXU1(PSOIEN,"CXI")
 I MTYPE="RE" D UPDSTAT^PSOERXU1(PSOIEN,"RXI")
 I MTYPE="CX" D UPDSTAT^PSOERXU1(PSOIEN,"CXI")
 I ERXSTAT="N" D UPDSTAT^PSOERXU1(PSOIEN,"I")
 H .5 W "done.",$C(7) H 1
 Q
