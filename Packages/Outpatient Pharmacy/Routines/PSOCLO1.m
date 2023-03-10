PSOCLO1 ;BHAM ISC/SAB, HEC/hrubovcak - Clozapine Rx lockout logic ;24 Feb 2020 14:00:01
 ;;7.0;OUTPATIENT PHARMACY;**1,23,37,222,457,574,612,621,613**;DEC 1997;Build 10
 ; YSCLTST2 - DBIA 4556
 ;Reference to ^YSCL(603.01 - DBIA 2697
 ;MH package will authorize dispensing of the Clozapine drugs
 K ANQDATA,ANQX,ANQNO,FLG,PSONEW("SAND"),^TMP($J,"PSO"),^TMP($J,"CLOZFLG",DFN)
 N %,ANQ,ANQD,ANQJ,ANQRE,CLOZFLG,D,DIR,DIRUT,DTOUT,DUOUT,J,PSCLZREG,PSMSGTXT,PSOYS,PSTYPE,X,Y
 ; START NCC REMEDIATION
 W !!,"Now doing Clozapine Order checks.  Please wait...",!
 I XQY0["PSO" S PSTYPE=0,PSMSGTXT="prescription" K PSOSAND
 I XQY0["PSJ" S PSTYPE=1,PSMSGTXT="order"
 ;
 ; PSO*7.0*574 ; set PSODFN if coming from IP OE
 I '($G(PSODFN)>0) S:$G(DFN) PSODFN=DFN Q:'($G(PSODFN)>0)  ; must have DFN
 ;Begin: JCH - PSO*7*612
 N PSOYSIEN S PSOYSIEN=$$GETREGYS^PSOCLUTL(PSODFN)
 S D=$P($G(^YSCL(603.01,+$G(PSOYSIEN),0)),U,3),CLOZPAT=$S(D="M":2,D="B":1,1:0)
 ;End: JCH - PSO*7*612
 I $D(PSONEW),$G(PSONEW("IRXN")) D EXPDT(.PSONEW,.CLOZPT)  ; expiration date for new order
 I $D(PSORXED),$G(PSORXED("IRXN")) D EXPDT(.PSORXED,.CLOZPT)  ; determine expiration date for edited order
 S CLOZFLG=0 ; Used to force start/stop dates to four days only
 ; ^PS(55,D0,SAND)= (#53) CLOZAPINE REGISTRATION NUMBER [1F] ^ (#54) CLOZAPINE STATUS [2S] 
 S PSCLZREG=$$GET1^DIQ(55,DFN,53),PSCLZREG("status")=$$GET1^DIQ(55,DFN,54,"I")
 D LABRSLT^PSOCLOU(DFN,.PSOYS,.CLOZPAT) ; get lab tests
 I PSCLZREG=""!(PSCLZREG("status")="D") D  D NOREG Q:'CLOZFLG  S PSCLZREG=$$GET1^DIQ(55,DFN,53)
 . W !!,"*** This patient has no clozapine registration number ***",!
 I PSCLZREG?1U6N S ^TMP($J,"CLOZFLG",DFN)=1
 ;
 S PSLAST7="" ; ** NCC REMEDIATION ** 457/RTW
 S PSOYS=$$CL^YSCLTST2(DFN)
 ;
 I PSCLZREG("status")="A",PSCLZREG?2U5N,PSOYS("rANC")="",PSOYS("rWBC")="" G OV1
 G:+PSOYS<0 END
 S CLOZPAT=$P(PSOYS,U,7),CLOZPAT=$S(CLOZPAT="M":2,CLOZPAT="B":1,1:0)
 G:+PSOYS=0 OV1
 I +PSOYS=1 D
 .I '$G(CLOZFLG),$G(^TMP($J,"CLOZFLG",DFN)) S CLOZFLG=1 ;Q ; JCH - PSO*7*613 Remove Quit
 .D DSP
 ; Begin: JCH - PSO*7*612 - Kill ^XTMP's if patient has Active NCCC registration and valid labs
 I PSOYS("rWBC")>0,PSOYS("rANC")>1499,'$G(CLOZFLG) D:'$G(PSTYPE) GDOSE D  Q
 .I PSCLZREG("status")="A",PSCLZREG?2U5N K ^XTMP("PSO4D-"_DFN) K ^XTMP("PSJ4D-"_DFN)
 ; End - PSO*7*612
 I $G(ANQRE)'=7,$$OVERRIDE^YSCLTST2(DFN) S ANQRE=7,ANQX=0 W !!,"Permission to dispense clozapine has been authorized by NCCC",!
 I $G(CLOZFLG),+PSOYS=1 S ANQRE=8
 S X=$S(CLOZPAT=2:84,CLOZPAT=1:42,1:21)
 D CL1^YSCLTST2(DFN,X)
 ;/RBN-RJS Begin modification for override bypass
 I $D(^TMP($J,"PSO")) D:'$G(CLOZFLG) DSP D CHECK ;AJF - added check for CLOZFLG PSO*574
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
 I 'PSOYS("rWBC"),'PSOYS("rANC"),PSCLZREG("status")="A",PSCLZREG?2U5N D  Q
 . D PKEYCHK Q:$G(ANQX)  ; doesn't hold key
 . D:PSTYPE=1 MSG10^PSOCLUTL  ; inpt
 . D:PSTYPE=0 MSG9^PSOCLUTL  ; outpt
 . S ANQRE=9 D OVRD  ; PRESCRIBER APPROVED 4 DAY SUPPLY
 ;
 I PSOYS("rWBC"),PSOYS("rANC")<1000,PSOYS("rANC")>0 D MSG4^PSOCLUTL,MSG3^PSOCLUTL,MH,QU Q
 I $D(PSCLZREG),'PSOYS("rWBC"),'PSOYS("rANC") D MSG4^PSOCLUTL,MSG3^PSOCLUTL,MH,QU Q
 I PSTYPE=0 D  ; outpatient
 . I PSOYS("rWBC"),'PSOYS("rANC") D MSG9^PSOCLUTL,PKEYCHK,OVRD Q  ; WBC, no ANC
 . I PSOYS("rWBC"),'PSOYS("rANC") D MSG9^PSOCLUTL,PKEYCHK,OVRD Q  ; No labs
 ;
 I PSTYPE=1 D  ; inpatient
 . I PSOYS("rWBC"),'PSOYS("rANC") D MSG10^PSOCLUTL,OVRD Q  ; WBC, no ANC
 . I 'PSOYS("rWBC"),'PSOYS("rANC") D MSG10^PSOCLUTL,PKEYCHK,OVRD Q  ; No labs
 ;
 I 'PSOYS("rWBC"),PSOYS("rANC") D MSG1^PSOCLUTL Q  ; ANC, no WBC
 Q
CHECK ;
 S:'$$HASKEY(DUZ) ANQX=0
 I $G(ANQRE)'=7,$G(ANQRE)'=8 S ANQRE=$S('PSOYS("rANC"):9,PSOYS("rANC")<1000:9,'PSOYS("rWBC"):9,PSOYS("rANC")<1500:10,PSLAST7["Y":9,1:0)
 I '$P(PSOYS,U,6) S $P(PSOYS,U,6)=$$NOW^XLFDT
 S (ANQD,ANQD(1))=9999999-$P(PSOYS,U,6)
 S ANQ(1)=PSOYS("rWBC")_U_PSOYS("rANC") D
 .Q:'$D(^TMP($J,"PSO"))
 .F ANQJ=2:1:4 S ANQD=$O(^TMP($J,"PSO",ANQD)) Q:'ANQD  S ANQ(ANQJ)=^(ANQD),ANQD(ANQJ)=ANQD
 S ANQD=$O(ANQ(""),-1)
 I $D(PSCLZREG),PSCLZREG=""!(PSCLZREG?1U6N),PSOYS("rANC")'>1499 D  Q  ; temporary reg # not enough
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
 S:ANQRE SANQX=0,PSCLPAT=DFN,ANQDATA=DUZ_U_PSPROVID_U_ANQRE_U_PSREMARK_U_PSSPHARM_U_PSCLPAT_U_$G(PSJORN)
 ;
GDOSE ; ask daily dose
 I $G(PSTYPE) Q  ; not for inpatient
 N IENX,PSOCD,PSRXDOS
 D  ; retrieve DOSAGE ORDERED fields
 . ; get parent IEN for new or edited Rx
 . N FLD,IRXNTMP S IENX=$S($G(PSORXED("IRXN")):PSORXED("IRXN"),$G(PSONEW("IRXN")):PSONEW("IRXN"),1:0)
 . S PSRXDOS("CLOZDOSE301")=$$GET1^DIQ(52,IENX,301)  ; (#301) CLOZAPINE DOSAGE (MG/DAY) [1N]
 . S IRXNTMP="1,"_IENX F FLD=.01,1:1:9 S PSRXDOS(FLD)=$$GET1^DIQ(52.0113,IRXNTMP,FLD)
 ;
DOSE ;
 K DIR S DIR(0)="N^12.5:3000:1",DIR("A")="CLOZAPINE dosage (mg/day)? "
 I '(PSRXDOS(.01)<12.5),'(PSRXDOS(.01)>900) S DIR("B")=PSRXDOS(.01)  ; default only for standard dose
 D ^DIR K DIR G EXIT:$D(DIRUT)!$D(DTOUT)
 S PSOCD=X
 ;
 I PSOCD#25=0,PSOCD'<12.5,PSOCD<900 G EXIT
 I PSOCD#12.5 S DIR(0)="Y",DIR("B")="NO",DIR("A")=PSOCD_" is an unusual dose.  Are you sure" D ^DIR K DIR G EXIT:$D(DIRUT) I 'Y G DOSE
 I PSOCD>900 S DIR(0)="Y",DIR("A")="Recommended maximum daily dose is 900. Are you sure" D ^DIR K DIR G EXIT:$D(DIRUT) I 'Y G DOSE
 ;
EXIT ;
 K ^TMP($J,"PSO")
 S:$D(DIRUT) ANQX=1
 I $G(ANQX) W !!,"No "_PSMSGTXT_" entered!" H 2 Q
 ;
 D LABRSLT^PSOCLOU(DFN,.PSOYS,.CLOZPAT) ; if added to files #55 or #603.01 lab results may be available
 S (PSONEW("SAND"),PSOSAND)=PSOCD_U_PSOYS("rWBC")_U_($P($P(PSOYS,U,6),"."))_U_PSOYS("rANC")
 N NDAYS S NDAYS=$S($G(ANQRE)=9!(PSCLZREG?1U6N):4,CLOZPAT=2:28,CLOZPAT=1:14,1:7)
 I $G(PSONEW("DAYS SUPPLY"))>NDAYS D
 . S PSONEW("DAYS SUPPLY")=NDAYS,$P(PSONEW("RX0"),U,8)=NDAYS
 . ; No DURATION set if 4 DAY SUPPLY
 . S:$G(NDAYS)'=4 PSONEW("DURATION",1)=NDAYS
 . N PSOIENX S PSOIENX="1,"_$G(PSORXIEN)
 . S PSONEW("SCHEDULE",1)=$$GET1^DIQ(52.0113,PSOIENX,7)
 . S PSONEW("DOSE ORDERED",1)=$$GET1^DIQ(52.0113,PSOIENX,1)
 . D QTYCHK(.PSONEW,NDAYS)
 ; if Rx edited, then update it
 I $D(PSORXED) D EXPDT(.PSORXED,.CLOZPT)  ; in case of edits
 ;
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
 . Q:$$HASKEY(DUZ)  ; has security key
 . S ANQX=1 W !,"You Are Not Authorized to Override! See Clozapine Manager with PSOLOCKCLOZ key."
 Q
 ;
MH ;
 W !!,"Also make sure that the LAB test, ANC is set up correctly in the"
 W !,"Mental Health package using the CLOZAPINE MULTI TEST LINK option.",!
 Q
DSP ; subroutine: NCC remediation PSO*7.0*457
 I 'PSOYS("rWBC"),'PSOYS("rANC") Q
 N DIR,Y S Y=$P($$FMTE^XLFDT($P(PSOYS,U,6)),"@")
 W !,"*** Most recent WBC and "_$P(PSOYS,U,5)_" (ANC) results ***"
 W !,"     performed on "_Y_" are: "
 W !!,"    "_$P(PSOYS,U,3)_": "_PSOYS("rWBC")
 W !,"    ANC: "_PSOYS("rANC"),!
 S DIR(0)="EA",DIR("A")="Type <Enter> to continue: " D ^DIR W !
 ;
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
NOREG ; Register a new/discontinued non-registered cloz patient
 ;
 N %,I,MSG,MSGNUM,NOW,PSCLZREG,PSO1,PSO2,PSO4,PSONAME,PTINFO,STAT,TMP,X,XMSUB,XMTEXT,Y
 ; Check for authorization key
 I '$$HASKEY(DUZ) D  Q
 . S ANQX=1 W !,"You Are Not Authorized to Override! See Clozapine Manager with PSOLOCKCLOZ key." W:PSTYPE=1 !!,"No order entered!"
 ;
 W !,"Do you want to register this patient with a temporary local"
 W !," authorization number in the Clozapine registry? Y/N  "
 S %=2 D YN^DICN I %'=1 S ANQX=1 W !,"Patient Not Registered",! Q
 W !
 S (PSO1,TMP("DFN"))=DFN
 S PSO2=$$FINDNEXT^PSOCLOU
 I PSO2=-1 D  S ANQX=1 Q
 . W !!,"All emergency registration numbers have been used."
 . W !,"Emergency registration may no longer be done at this site",!!
 . W !,"Patient Not Registered",!
CONT S TMP("PSO2")=PSO2
 S PSONAME=$$GET1^DIQ(2,PSO1,.01)
 S PSCLOZ=1,DFN=TMP("DFN")
 S PSO2=TMP("PSO2")  ; used in NUMBER1^PSOCLUTL
 ; Check if registration in file #55 failed or was terminated
 S PTINFO("surname")=$P(PSONAME,","),PTINFO("firstNm")=$P($P(PSONAME,",",2)," ")
 S PTINFO("ssn")=$$GET1^DIQ(2,PSO1,.09),PTINFO("last4")=$E(PTINFO("ssn"),6,9),ANQX=1
 D NUMBER1^PSOCLUTL
 Q:$G(ANQX)
 S PSCLZREG=TMP("PSO2") D  ; delete entries in file 603.01 for this patient
 . N DA,DIK
 . S DIK="^YSCL(603.01,",DA="" F  S DA=$O(^YSCL(603.01,"C",DFN,DA)) Q:DA=""  D ^DIK
 S MSG(1)=PSCLZREG_","_PTINFO("surname")_","_PTINFO("firstNm")_","_PTINFO("last4")
 S XMTEXT="MSG(",XMSUB="ADD"
 N YSPROD S YSPROD=$$GET1^DIQ(8989.3,1,501,"I") D
 . I YSPROD S XMY("G.RUCLDEM@FO-DALLAS.DOMAIN.EXT")="" Q  ; production account
 . S XMY("G.CLOZAPINE ROLL-UP")=""  ; test account
 D ^XMD
 S DFN=TMP("DFN")
 I '$G(XMMG) S MSGNUM=$G(XMZ)
 E  W !!,"Failed to connect with the NCCC." S PSOFL=1 Q
 ; use the server logic for sending a message to populate 55 and 603.01
 S PSCLOZ=1,^TMP($J,"CLOZFLG",DFN)=1,XMRG=MSG(1),XMFROM=DUZ,XQDATE=$$NOW^XLFDT
 D ^YSCLSERV
 D XTMPZRO^PSOCLOU
 S:PSCLZREG?1U6N $P(^XTMP("PSJ CLOZ",0),U,4)=PSCLZREG  ; save only temp registration #
 S ^XTMP("PSJ CLOZ",DFN)=DT_U_PSCLZREG_U_"A"
 S ^XTMP("PSJ CLOZ","B",PSCLZREG,DFN)=$$FMADD^XLFDT($$NOW^XLFDT,4)  ; four days from now
 S ^XTMP("PSJ CLOZ","C",DFN,PSCLZREG)=""
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
CHK4REG(PSCLDFN) ; See if patient already has a clozapine registration number
 N PSCLRSLT
 S PSCLRSLT=$O(^XTMP("PSJ CLOZ","C",PSCLDFN,""))
 Q PSCLRSLT
 ;
CHK4DFN(PSCLRGNO) ; See if this Clozapine registration is assigned
 N PSCLRSLT
 S PSCLRSLT=$O(^XTMP("PSJ CLOZ","B",PSCLRGNO,""))
 Q PSCLRSLT
 ;
CHK4EXP(PSCLRGNO,PSCLDFN) ; Check for registration expiration
 ; returns zero if expired, 1 if not
 N PSCLRSLT,PSCLZDAT
 S PSCLRSLT=1
 I $D(^XTMP("PSJ CLOZ","B",PSCLRGNO,PSCLDFN)) D
 . S PSCLZDAT=$G(^XTMP("PSJ CLOZ","B",PSCLRGNO,PSCLDFN)) Q:'(DT>PSCLZDAT)  ; not expired
 . S PSCLRSLT=0 S:PSCLZDAT>0 $P(^XTMP("PSJ CLOZ",PSCLDFN),U,3)="D"
 ;
 Q PSCLRSLT
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
EXPDT(PSORXARY,CLOZPT) ; PSORXARY,CLOZPAT passed by ref., determine expiration date (for Clozapine only)
 ; PSORXARY can be a new Rx (PSONEW) or an edited Rx (PSORXED and PSODIR)
 Q:'($G(PSORXARY("IRXN"))>0)  ; must have IEN
 ; Check for updates to DAYS SUPPLY, ISSUE DATE and QUANTITY
 N D,DYS2EXPR,PSRXFMDT,PSCLUPDT,NUMREFS
 S PSCLUPDT("change")=0
 S:$G(PSORXARY("DAYS SUPPLY")) PSCLUPDT("change")=1
 S:$G(PSORXARY("FLD",1)) PSCLUPDT("change")=1
 S:$G(PSORXARY("QTY")) PSCLUPDT("change")=1
 I $D(PSORXARY("N# REF")) D
 . S NUMREFS=+$G(PSORXARY("N# REF"))
 E  D
 . S NUMREFS=+$P($G(PSORXARY("RX0")),U,9)
 Q:'PSCLUPDT("change")  ; no changes, exit
 S DYS2EXPR=0  ; days to expire
 S PSRXFMDT(1)=0  ; field #1
 D  ; determine ISSUE DATE
 . S PSRXFMDT(1)=$G(PSORXARY("FLD",1))  ; field may have been edited
 . Q:PSRXFMDT(1)?7N  ; date found
 . S PSRXFMDT(1)=$$GET1^DIQ(52,PSORXARY("IRXN")_",",1,"I")  ; (#1) ISSUE DATE [13D]
 . Q:PSRXFMDT(1)
 . S PSRXFMDT(1)=DT  ; last resort
 ;
 D  ; determine days to expire
 . S D=$G(PSORXARY("DAYS SUPPLY")) S:D>0 DYS2EXPR=D*(NUMREFS+1)
 . I D,$G(PSORXARY("DAYS SUPPLY OLD")) S PSCLUPDT(8)=PSORXARY("DAYS SUPPLY")
 . Q:DYS2EXPR
 . S D=$P($G(PSORXARY("RX0")),U,8) I D>0 S DYS2EXPR=D*(NUMREFS+1) Q
 . S DYS2EXPR=$S(CLOZPAT=2:28,CLOZPAT=1:14,1:7)  ; default
 ; value for FM call
 S PSRXFMDT("expires")=$$FMADD^XLFDT(PSRXFMDT(1),DYS2EXPR)
 S PSCLUPDT(26)=PSRXFMDT("expires")  ; (#26) EXPIRATION DATE [6D]
 S PSORXARY("CLOZ EDIT")=PSCLUPDT(26)
 I $G(PSORXARY("DAYS SUPPLY")) D 
 . D QTYCHK(.PSORXARY,PSORXARY("DAYS SUPPLY"))
 . ; only if quantity changed
 . I $G(PSORXARY("QTY")) S PSCLUPDT(7)=PSORXARY("QTY")  ; (#7) QTY [7N]
 ;
 ; update PSORXARY("FLD") nodes to include any edits
 ;  QTY (#7), DAYS SUPPLY (#8), EXPIRATION DATE (#26)
 F D=7,8,26 I $G(PSCLUPDT(D)) S PSORXARY("FLD",D)=PSCLUPDT(D)
 I $G(PSCLUPDT(8)) S $P(PSORXARY("RX0"),U,8)=PSCLUPDT(8) ; (#8) DAYS SUPPLY [8N]
 I $G(PSCLUPDT(26)) S $P(PSORXARY("RX2"),U,6)=PSCLUPDT(26) ;  (#26) EXPIRATION DATE [6D]
 ;
 Q
 ;
QTYCHK(PSORXARY,NUMDAYS) ; check/adjust quantity, PSORXARY passed by ref., NUMDAYS is # of days
 Q:'($G(NUMDAYS)>0)  ; required
 D QTYCHK^PSOCLUTL(.PSORXARY,NUMDAYS)
 Q
