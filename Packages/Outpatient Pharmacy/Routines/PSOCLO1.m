PSOCLO1 ;BHAM ISC/SAB, HEC/hrub - clozaril Rx lockout logic ;12 May 2019 12:53:12
 ;;7.0;OUTPATIENT PHARMACY;**1,23,37,222,457**;DEC 1997;Build 116
 ;External reference YSCLTST2 supported by DBIA 4556
 ;Reference to ^YSCL(603.01 is supported by DBIA 2697
 ;External reference ^PS(55 supported by DBIA 2228
 ;Reference to ^XMD supported by IA #10070
 ;Reference to ^DPT supported by IA #10035
 ;Reference to $$GET1^DIQ is supported by DBIA 2056
 ;MH package will authorize dispensing of the Clozapine drugs
 K ANQDATA,ANQX,ANQNO,FLG,PSONEW("SAND"),^TMP($J,"PSO"),^TMP($J,"CLOZFLG",DFN)
 N X,Y,%,%DT,J,ANQ,ANQD,ANQJ,ANQRE,DTOUT,DUOUT,DIR,DIRUT,LSTFOUR,PSOYS,PSTYPE,PSREG,CLOZFLG
 ; START NCC REMEDIATION
 W !!,"Now doing Clozapine Order checks.  Please wait...",!
 N PSMSGTXT
 I XQY0["PSO" S PSTYPE=0,PSMSGTXT="prescription" K PSOSAND
 I XQY0["PSJ" S PSTYPE=1,PSMSGTXT="order"
 ;
 S CLOZFLG=0 ; Used to force start/stop dates to four days only
 ; ^PS(55,D0,SAND)= (#53) CLOZAPINE REGISTRATION NUMBER [1F] ^ (#54) CLOZAPINE STATUS [2S] 
 S PSREG=$$GET1^DIQ(55,DFN,53),PSREG("status")=$$GET1^DIQ(55,DFN,54,"I")
 D LABRSLT^PSOCLOU(DFN,.PSOYS,.CLOZPAT) ; get lab tests
 I PSREG=""!(PSREG("status")="D") D  D NOREG Q:'CLOZFLG  S PSREG=$$GET1^DIQ(55,DFN,53)
 . W !!,"*** This patient has no clozapine registration number ***",!
 I PSREG?1U6N S ^TMP($J,"CLOZFLG",DFN)=1
 ;
 ;
 S PSLAST7="" ; ** NCC REMEDIATION ** 457/RTW
 S PSOYS=$$CL^YSCLTST2(DFN)
 ;
 I PSREG("status")="A",PSREG?2U5N,PSOYS("rANC")="",PSOYS("rWBC")="" G OV1
 G:+PSOYS<0 END
 N PSGDSP
 S CLOZPAT=$P(PSOYS,U,7),CLOZPAT=$S(CLOZPAT="M":2,CLOZPAT="B":1,1:0)
 G:+PSOYS=0 OV1
 I +PSOYS=1 D
 .I '$G(CLOZFLG),$G(^TMP($J,"CLOZFLG",DFN)) S CLOZFLG=1  Q
 .D DSP
 I PSOYS("rWBC")>0,PSOYS("rANC")>1499,'$G(CLOZFLG) D:'$G(PSTYPE) DOSE Q
 I $G(ANQRE)'=7,$$OVERRIDE^YSCLTST2(DFN) S ANQRE=7,ANQX=0 W !!,"Permission to dispense clozapine has been authorized by NCCC",!
 I $G(CLOZFLG),+PSOYS=1 S ANQRE=8
 S X=$S(CLOZPAT=2:84,CLOZPAT=1:42,1:21)
 D CL1^YSCLTST2(DFN,X)
 ;/RBN-RJS Begin modification for override bypass
 I $D(^TMP($J,"PSO")) D DSP,CHECK
 I $P(ANQ(1),U,2)>1499,+$G(PSTYPE),'+$G(ANQRE) Q  ;/RJS Emergency override
 I $P(ANQ(1),U,2)>1499,'$G(PSTYPE),'+$G(ANQRE) D DOSE Q  ;/RJS Emergency override
 E  D OVRD
 ;/RBN-RJS End modification for override bypass
 Q
 ;
OV1 ;
 I $$OVERRIDE^YSCLTST2(DFN) S ANQRE=7,ANQX=0 W !!,"Permission to dispense clozapine has been authorized by NCCC",!
 S X=$S(CLOZPAT=2:84,CLOZPAT=1:42,1:21)
 D CL1^YSCLTST2(DFN,X)
 S:$P(PSOYS,U,6)="" $P(PSOYS,U,6)=DT
 I $G(ANQRE)'=7 D DSP,CHECK
 I $G(ANQRE)=8!($G(ANQRE)=7) D OVRD Q
 ; patient is ACTIVE, has no labs, regular registration #
 I 'PSOYS("rWBC"),'PSOYS("rANC"),PSREG("status")="A",PSREG?2U5N D  Q
 . D PKEYCHK Q:$G(ANQX)  ; doesn't hold key
 . D:PSTYPE=1 MSG10^PSOCLUTL  ; inpt
 . D:PSTYPE=0 MSG9^PSOCLUTL  ; outpt
 . S ANQRE=9 D OVRD  ; PRESCRIBER APPROVED 4 DAY SUPPLY
 ;
 I PSOYS("rWBC"),PSOYS("rANC")<1000,PSOYS("rANC")>0 D MSG4^PSOCLUTL,MSG3^PSOCLUTL,MH,QU Q
 I $D(PSREG),'PSOYS("rWBC"),'PSOYS("rANC") D MSG4^PSOCLUTL,MSG3^PSOCLUTL,MH,QU Q
 I PSTYPE=0 D  ; outpatient
 . I PSOYS("rWBC"),'PSOYS("rANC") D MSG9^PSOCLUTL,PKEYCHK,OVRD Q  ;  WBC, no ANC
 . I PSOYS("rWBC"),'PSOYS("rANC") D MSG9^PSOCLUTL,PKEYCHK,OVRD Q  ; No labs
 ;
 I PSTYPE=1 D  ; inpatient
 . I PSOYS("rWBC"),'PSOYS("rANC") D MSG10^PSOCLUTL,OVRD Q  ; WBC, no ANC
 . I 'PSOYS("rWBC"),'PSOYS("rANC") D MSG10^PSOCLUTL,PKEYCHK,OVRD Q  ; No labs
 ;
 I 'PSOYS("rWBC"),PSOYS("rANC") D MSG1^PSOCLUTL Q  ; ANC, no WBC
 Q
CHECK ;
 S:'$$HASKEY(DUZ) ANQX=0 ;RTW added because of undefined ANQX error from PSGOE7 routine 3160303
 I $G(ANQRE)'=7,$G(ANQRE)'=8 S ANQRE=$S('PSOYS("rANC"):9,PSOYS("rANC")<1000:9,'PSOYS("rWBC"):9,PSOYS("rANC")<1500:10,PSLAST7["Y":9,1:0)
 I '$P(PSOYS,U,6) S $P(PSOYS,U,6)=$$NOW^XLFDT
 S (ANQD,ANQD(1))=9999999-$P(PSOYS,U,6)
 S ANQ(1)=PSOYS("rWBC")_U_PSOYS("rANC") D
 .Q:'$D(^TMP($J,"PSO"))
 .F ANQJ=2:1:4 S ANQD=$O(^TMP($J,"PSO",ANQD)) Q:'ANQD  S ANQ(ANQJ)=^(ANQD),ANQD(ANQJ)=ANQD
 S ANQD=$O(ANQ(""),-1)
 I $D(PSREG),PSREG=""!(PSREG?1U6N),PSOYS("rANC")'>1499 D  Q  ; temporary reg # not enough
 . W !,"Emergency overrides for non-registered clozapine patients require",!,"ANC levels greater than or equal to 1500",!
 . S ANQX=1
 I ANQD<2 W !,"*** No previous results to display ***",! Q
 S ANQ=$S($P(ANQ(1),U)!$P(ANQ(1),U,2):ANQD,1:ANQD-1)
 W !,"*** Last "_$S(ANQ=4:"Four ",ANQ=3:"Three ",ANQ=2:"Two ",1:"")_"WBC and NEUTROPHILS ABSOLUTE (ANC) results ***",!
 W !,$J("WBC    ANC",49),!
 F ANQJ=ANQD:-1:1 S ANQD=9999999-ANQD(ANQJ)_"0000" D
 . I $L($P($G(ANQ(ANQJ)),U))!$L($P($G(ANQ(ANQJ)),U,2))  D
 ..  W $$FMTE^XLFDT(ANQD,"5Z") W:ANQD["." "@",$E(ANQD,9,10),":",$E(ANQD,11,12)
 ..  W ?29,"Results: "_$J($P(ANQ(ANQJ),U),4)_"   ",$J($P(ANQ(ANQJ),U,2),4),!
 Q
 ;
OVRD ;
 Q:$G(ANQX)
 N PSREASON
 I ANQRE,'$$HASKEY(DUZ) D  D QU G EXIT
 . S ANQX=1 W !!,"You Are Not Authorized to Override! See Clozapine Manager with PSOLOCKCLOZ key."
 ;
 I $L($G(PSOYS)) D:PSOYS("rANC")<1000  ; severe neutropenia
 . W !,"Test ANC labs daily until levels stabilize to ANC greater than or equal to 1000.",!
 I ANQRE W !,"Override reason: "_$$OVRDTXT^PSOCLOU(ANQRE),! D
 . I ANQRE=7 D  Q
 ..  S PSREASON=$$OVRDTXT^PSOCLOU(ANQRE)
 ..  D OVPRMPT Q:$G(ANQX)
 ..  D OVRD2 Q:$G(ANQX)
 ..  D OVRREA
 . I ANQRE=5 D  Q
 ..  N DIR S DIR("A")="ANC levels are Critically low. Do you want to Cancel the order",DIR(0)="Y",DIR("B")="N"
 ..  D ^DIR I Y=0 D MSG6^PSOCLUTL Q
 ..  I Y(0)="YES"!($D(DTOUT))!($D(DUOUT))!($D(DIROUT)) S ANQX=1 K Q
 . I $G(ANQRE)=8 D  Q
 ..  S ANQX=0 D OVPRMPT Q:$G(ANQX)
 ..  D OVRD2 Q:$G(ANQX)
 ..  D OVRREA Q:$G(ANQX)
 ..  D CRXTMPI(DFN,PSOYS)
 . ;/RBN Begin modifications for new special override condition for inpatient
 . I ANQRE=9,PSTYPE=0 D  Q
 ..  D OVPRMPT Q:$G(ANQX)
 ..  N DIR,DIRUT S DIR(0)="S^1:Weather Related Conditions;2:Mail Order Delay;3:Inpatient Going On Leave"
 ..  S DIR("A")="Prescriber's reason for Special Condition Override " D ^DIR I $D(DIRUT) S ANQX=1 Q
 ..  S PSREASON=Y(0)_": ",^TMP($J,"CLOZFLG",DFN)=1
 ..  D OVRD2 Q:$G(ANQX)
 ..  D OVRREA Q:$G(ANQX)
 ..  S PSREMARK=PSREASON_PSREMARK
 ..  D CRXTMP(DFN,PSOYS)
 . I ANQRE=9,PSTYPE=1 D  Q
 ..  D OVPRMPT Q:$G(ANQX)
 ..  S PSREASON="IP Order Override with Outside Lab Results: ",^TMP($J,"CLOZFLG",DFN)=1
 ..  W !,$P(PSREASON,":"),!
 ..  D OVRREA Q:$G(ANQX)
 ..  D OVRD2 Q:$G(ANQX)
 ..  S PSREMARK=PSREASON_PSREMARK
 ..  D CRXTMPI(DFN,PSOYS)
 . I ANQRE=10 D
 ..  W !,"Test ANC Results 3x weekly until ANC stabilize to greater than or equal to 1500",!
 ..  D OVPRMPT Q:$G(ANQX)
 ..  D OVRD2 Q:$G(ANQX)
 ..  D OVRREA
 ;
 I $G(ANQX) D EXIT Q
 ;
 S PSPROVID="UNKNOWN"
 I $D(ND0) S PSPROVID=$P(ND0,U,2),PSJORN=$P(ND0,U,21),PSJORDER("PSJORN")=PSJORN
 I $D(ORO) S PSPROVID=$P(ORO,U,4),PSJORN=$P(ORO,U),PSJORDER("PSJORN")=PSJORN
 I '$G(PSPROVID),$G(PSTYPE),$G(PSGOEPR) S PSPROVID=+$G(PSGOEPR)
 I $D(DUPRX0) S PSPROVID=$P(DUPRX0,U,4)
 ;/RBN Begin modifications for new special overide condition for inpatient
 ;
 S:ANQRE SANQX=0,PSCLPAT=DFN,ANQDATA=DUZ_U_PSPROVID_U_ANQRE_U_PSREMARK_U_PSSPHARM_U_PSCLPAT_U_$G(PSJORN)
 ;
GDOSE ; set variable to ask daily dose
 N PSOCD
 I $G(PSTYPE) Q
DOSE ;
 S DIR(0)="N^12.5:3000:1",DIR("A")="CLOZAPINE dosage (mg/day) ? " D ^DIR K DIR G EXIT:$D(DIRUT)
 S PSOCD=X
 I PSOCD#25=0,PSOCD'<12.5,PSOCD<900 G EXIT
 I PSOCD#12.5 S DIR(0)="Y",DIR("B")="NO",DIR("A")=PSOCD_" is an unusual dose.  Are you sure" D ^DIR K DIR G EXIT:$D(DIRUT) I 'Y G DOSE
 I PSOCD>900 S DIR(0)="Y",DIR("A")="Recommended maximum daily dose is 900. Are you sure" D ^DIR K DIR G EXIT:$D(DIRUT) I 'Y G DOSE
EXIT ;
 K ^TMP($J,"PSO")
 S:$D(DIRUT) ANQX=1
 I $G(ANQX) W !!,"No "_PSMSGTXT_" entered!" H 2 Q
 ;
 D LABRSLT^PSOCLOU(DFN,.PSOYS,.CLOZPAT) ; if added to files #55 or #603.01 lab results may be available
 S (PSONEW("SAND"),PSOSAND)=PSOCD_U_PSOYS("rWBC")_U_($P($P(PSOYS,U,6),"."))_U_PSOYS("rANC")
 N NDAYS S NDAYS=$S($G(ANQRE)=9!(PSREG?1U6N):4,CLOZPAT=2:28,CLOZPAT=1:14,1:7)
 I $G(PSONEW("DAYS SUPPLY"))>NDAYS D
 .S PSONEW("DAYS SUPPLY")=NDAYS,$P(PSONEW("RX0"),U,8)=NDAYS
 .S PSONEW("DURATION",1)=NDAYS
 .N PSOIENX S PSOIENX="1,"_$G(PSORXIEN)
 .S PSONEW("SCHEDULE",1)=$$GET1^DIQ(52.0113,PSOIENX,7)
 .S PSONEW("DOSE ORDERED",1)=$$GET1^DIQ(52.0113,PSOIENX,1)
 .N SCH,ND,QTY S SCH=PSONEW("SCHEDULE",1)
 .S ND=$$QTSCH^PSOSIG(SCH) Q:'ND   ;number of minutes between meds
 .S ND=1440/ND                     ;times daily
 .S QTY=NDAYS*ND*PSONEW("DOSE ORDERED",1)
 .S PSONEW("QTY")=QTY,$P(PSONEW("RX0"),U,7)=QTY
 Q
 ;
OVPRMPT ; ask user to override
 N DIR
 S DIR("A")="Do you want to override and issue this "_PSMSGTXT,DIR(0)="Y",DIR("B")="N" D ^DIR
 I 'Y!($D(DIROUT)!($D(DTOUT))) S ANQX=1
 Q
 ;
PKEYCHK ; does user have PSOLOCKCLOZ key
 I '$D(PSGSTAT)!($G(PSGSTAT)="PENDING") D
 . Q:$$HASKEY(DUZ)  ; has the security key
 . S ANQX=1 W !,"You Are Not Authorized to Override! See Clozapine Manager with PSOLOCKCLOZ key."
 Q
 ;
MH ;
 W !!,"Also make sure that the LAB test, ANC is set up correctly in the"
 W !,"Mental Health package using the CLOZAPINE MULTI TEST LINK option.",!
 Q
DSP ; subroutine: NCC remediation PSO*7.0*457
 I 'PSOYS("rWBC"),'PSOYS("rANC") Q
 Q:$G(PSGDSP)
 N DIR,Y S Y=$P($$FMTE^XLFDT($P(PSOYS,U,6)),"@")
 W !,"*** Most recent WBC and "_$P(PSOYS,U,5)_" (ANC) results ***"
 W !,"     performed on "_Y_" are: "
 W !!,"    "_$P(PSOYS,U,3)_": "_PSOYS("rWBC")
 W !,"    ANC: "_PSOYS("rANC"),!
 S DIR(0)="EA",DIR("A")="Type <Enter> to continue: " D ^DIR W !
 S PSGDSP=1
 Q
DIR ;
 W !! K DIR S DIR(0)="E",DIR("A")="Press Return to Continue" D ^DIR K DIR,DTOUT,DUOUT,DIRUT
 Q
 ;
END ;
 D MSG5^PSOCLUTL
QU ; no med prescribed 
 S ANQX=1 D DIR
 Q
 ;
 ; /RBN Begin NCC weekend/new patient for PSO*7.0*457
NOREG ; Register a new/discontinued non-registered cloz patient
 ;
 N %,FIRST,FLG,I,LAST,LSTFOUR,MSG,MSGNUM,NAME,NOW,PSO1,PSO2,PSO4,PSONAME,REG,SSN,STAT,TMP1
 N TMP2,X,X1,X2XML,XMSUB,XMTEXT,Y,YSCLFRQ
 ; Check for authorization key
 I '$$HASKEY(DUZ) D  Q
 . S ANQX=1 W !,"You Are Not Authorized to Override! See Clozapine Manager with PSOLOCKCLOZ key." W:PSTYPE=1 !!,"No order entered!"
 ;
 W !,"Do you want to register this patient with a temporary local"
 W !," authorization number in the Clozapine registry? Y/N  "
 S %=2 D YN^DICN I %'=1 S ANQX=1 W !,"Patient Not Registered",! Q
 W !
 S (PSO1,TMP1)=DFN
 S PSO2=$$FINDNEXT^PSOCLOU
 I PSO2=-1 D  S ANQX=1 Q
 . W !!,"All emergency registration numbers have been used."
 . W !,"Emergency registration may no longer be done at this site",!!
 . W !,"Patient Not Registered",!
CONT S TMP2=PSO2
 S (NAME,PSONAME)=$$GET1^DIQ(2,PSO1,.01)
 S PSCLOZ=1
 S DFN=TMP1
 S (PSO2,REG)=TMP2
 ; Check if registration in file #55 failed or was terminated
 S LAST=$P(NAME,","),FIRST=$P($P(NAME,",",2)," ")
 S SSN=$$GET1^DIQ(2,PSO1,.09),LSTFOUR=$E(SSN,6,9),ANQX=1
 D NUMBER1^PSOCLUTL
 Q:$G(ANQX)
 D  ; delete entries in file 603.01 for this patient
 . N DIK,DA
 . S DIK="^YSCL(603.01,",DA="" F  S DA=$O(^YSCL(603.01,"C",DFN,DA)) Q:DA=""  D ^DIK
 S MSG(1)=REG_","_LAST_","_FIRST_","_LSTFOUR
 S XMTEXT="MSG("
 ;/RBN Begin modification for XMSUB gets killed off in NUMBER1^PSOCLUTL
 S XMSUB="ADD"
 N YSPROD S YSPROD=$$GET1^DIQ(8989.3,1,501,"I") D
 . I YSPROD S XMY("G.RUCLDEM@FO-DALLAS.DOMAIN.EXT")="" Q  ; production account
 . S XMY("G.CLOZAPINE ROLL-UP")=""  ; test account
 D ^XMD
 S DFN=TMP1
 I '$G(XMMG) S MSGNUM=$G(XMZ)
 E  W !!,"Failed to connect with the NCCC." S PSOFL=1 Q
 ; Now trick the server into thinking it is sending a message
 ; so we can populate 55 and 603.01
 S PSCLOZ=1,^TMP($J,"CLOZFLG",DFN)=1,XMRG=MSG(1),XMFROM=DUZ,XQDATE=$$NOW^XLFDT
 D ^YSCLSERV
 D XTMPZRO
 S $P(^XTMP("PSJ CLOZ",0),U,4)=REG
 S ^XTMP("PSJ CLOZ",DFN)=DT_U_REG_U_"A"
 S ^XTMP("PSJ CLOZ","B",REG,DFN)=$$FMADD^XLFDT($$NOW^XLFDT,4)  ; four days from now
 S ^XTMP("PSJ CLOZ","C",DFN,REG)=""
 S ANQX=0,CLOZFLG=1
 D LABRSLT^PSOCLOU(DFN,.PSOYS,.CLOZPAT) ; lab results may now be available
 ;
QUIT ;
 Q
 ;
OVRD2 ;
 S PSSPHARM=""  ; clozapine team member IEN
 D OVRDTMBR^PSOCLOU
 S:'PSSPHARM ANQX=1  ; no team member selected, exit
 Q
 ;
OVRREA ; Override reason when order is NCCC Approved
 S ANQX=0
 I $G(ANQRE)>6 D
 . N DIR,DTOUT,DUOUT,DIRUT,DIROUT
 . S DIR(0)="F^5:200"
 . S DIR("A")="REASON FOR OVERRIDE Remarks"
 . I $G(ANQRE)=9 S DIR("A")="Remarks: "_$P(PSREASON,":")
 . S DIR("?")="Response is 5 to 200 characters."
 . D ^DIR
 . I $G(DTOUT)!$G(DUOUT)!$G(DIRUT)!$G(DIROUT) S ANQX=1 Q
 . S PSREMARK=Y
 Q
 ;
CHK4REG(YSCLDFN) ; See if tpatient already has a clozapine registration number
 N YSCLANS
 S YSCLANS=$O(^XTMP("PSJ CLOZ","C",YSCLDFN,""))
 Q YSCLANS
 ;
CHK4DFN(YSCLREG) ; See if this Clozapine registration is assigned
 N YSCLANS
 S YSCLANS=$O(^XTMP("PSJ CLOZ","B",YSCLREG,""))
 Q YSCLANS
 ;
CHK4EXP(YSCLREG,YSCLDFN) ; Check for registration expiration
 ;    RETURNS 0 IF EXPIRED
 ;            1 IF NOT EXPIRED
 N YSCLANS,YSCLDAT
 S YSCLANS=1
 I $D(^XTMP("PSJ CLOZ","B",YSCLREG,YSCLDFN)) D
 .S YSCLDAT=$G(^XTMP("PSJ CLOZ","B",YSCLREG,YSCLDFN))
 .I YSCLDAT<DT D
 ..S YSCLANS=0
 ..S:YSCLDAT>0 $P(^XTMP("PSJ CLOZ",YSCLDFN),U,3)="D"
 Q YSCLANS
 ;
CRXTMP(DFN,PSOYS) ; create XTMP entry for 4 day supply tracking
 I $G(DFN) D CRXTMP^PSOCLUTL(DFN,PSOYS)
 Q
CRXTMPI(DFN,PSOYS) ; create XTMP entry for 4 day supply tracking
 I $G(DFN) D CRXTMPI^PSOCLUTL(DFN,PSOYS)
 Q
 ;
HASKEY(USRNUM) ; Boolean function, does USRNUM hold the PSOLOCKCLOZ security key?
 I '$G(USRNUM)>0 S USRNUM=DUZ  ; default to current user
 Q $S($D(^XUSEC("PSOLOCKCLOZ",USRNUM)):1,1:0)
 ;
XTMPZRO ;set zero node in ^XTMP("PSJ CLOZ")
 N Y
 S Y=$$FMADD^XLFDT($$DT^XLFDT,180)  ; 6 months in the future
 S $P(^XTMP("PSJ CLOZ",0),U)=Y,$P(^XTMP("PSJ CLOZ",0),U,2)=DT,$P(^XTMP("PSJ CLOZ",0),U,3)="CLOZAPINE WEEKEND REGISTRATION"
 Q
 ;
