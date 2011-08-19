PSORMRX ;BIRM/JAM - REMOTE DATA INTEROPERABILITY UTILITY ; 10/29/08
 ;;7.0;OUTPATIENT PHARMACY;**320**;DEC 1997;Build 2
 ;;
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;References to ORRDI1 supported by DBIA 4659
 ;
EN(PSODFN) ;- ListManager entry point
 ;
 S PSORFLG=1
 D EN^VALM("PSO RDI VISITS")
 D FULL^VALM1
 G EXIT
 ;
HDR ; Patient Header for remote site
 N LINE,SSN
 K VALMHDR
 S LINE="Patient: "_$E($$GET1^DIQ(2,PSODFN,.01),1,25)
 S SSN=$$GET1^DIQ(2,PSODFN,.09,"E")
 S SSN=$E(SSN,1,3)_"-"_$E(SSN,4,5)_"-"_$E(SSN,6,9)
 S $E(LINE,36)="("_SSN_")",$E(LINE,55)="DOB: "
 S $E(LINE,60)=$$FMTE^XLFDT($$GET1^DIQ(2,PSODFN,.03),"5ZM")
 S VALMHDR(1)="",VALMHDR(2)=LINE
 S VALM("TITLE")="Remote Facilities Visited"
 Q
 ;
INIT ; - Populates the body of ListMan
 S VALMCNT=0
 D BLDRDI,BLDSIT
 S VALMSG="Enter ?? for more actions"
 Q
 ;
BLDSIT ; - Build prescription details for remote site sites
 N LC,CNT
 K ^TMP("PSORSITE",$J)
 S LC="",CNT=0
 F  S LC=$O(^TMP("PSORDIS",$J,LC)) Q:LC=""  D
 .S CNT=CNT+1,^TMP("PSORSITE",$J,CNT,0)="  "_LC
 ; if no remote sites, set display reasons
 I '$D(^TMP("PSORSITE",$J)),$D(^TMP($J,"PSORDI",1)) S LC="" D
 .F  S LC=$O(^TMP($J,"PSORDI",LC)) Q:LC=""  D
 ..S CNT=CNT+1,^TMP("PSORSITE",$J,CNT,0)="  "_$G(^TMP($J,"PSORDI",LC,0))
 S VALMCNT=CNT
 Q
 ;
BLDRDI ;Builds Medication Profile (remote) for display
 N SEQ,PSORDI,LC,SEQ,LINE,DATA,DATA1,QTY,ISDT,LFDT,FSIG,SIG,SITE,SITEO
 N STA,EXPDT
 K ^TMP("PSORDI",$J),^TMP("PSORDIS",$J)
 S PSORDI=$$RDI(PSODFN),SITEO=""
 S (LC,SEQ)=0
 F  S LC=$O(^TMP($J,"PSORDI",PSODFN,LC)) Q:'LC  D
 .S DATA=$G(^TMP($J,"PSORDI",PSODFN,LC,0))
 .S EXPDT=$P(DATA,"^",7),STA=$P(DATA,"^",5)
 .S STA=$$STACHK(STA,EXPDT) I '+STA Q
 .S STA=$P(STA,"^",2)
 .S SITE=$P(DATA,"^") I SITE'=SITEO D
 ..I SITEO'="" S LINE="" D SETTMP
 ..S LINE=SITE D SETTMP
 .S LINE=$E($P(DATA,"^",4),1,13),$E(LINE,15)=$E($P(DATA,"^",2),1,34)
 .S $E(LINE,50)=$S(STA="DISCONTINUED":"DC",1:$E(STA))
 .S QTY=$P($P(DATA,"^",6),";"),$E(LINE,53)=$J(QTY,4)
 .S ISDT=$P(DATA,"^",8),LFDT=$P(DATA,"^",9)
 .S $E(LINE,60)=$$FMTE^XLFDT(ISDT,"5ZM")
 .S $E(LINE,70)=$$FMTE^XLFDT(LFDT,"5ZM")
 .D SETTMP
 .I SITE'="" S ^TMP("PSORDIS",$J,SITE)=""
 .S SITEO=SITE
 .I $D(^TMP($J,"PSORDI",PSODFN,LC,"SIG")) D
 ..K FSIG D GETSIG
 ..S LINE="",$E(LINE,15)="SIG: ",SIG=0
 ..F  S SIG=$O(FSIG(SIG)) Q:'SIG  D
 ...S $E(LINE,20)=FSIG(SIG)
 ...D SETTMP S LINE=""
 .S LINE="",$E(LINE,15)="PROVIDER: "_$P(DATA,"^",11) D SETTMP
 S ^TMP("PSORDI",$J,"REMOTE COUNT")=SEQ
 K X,Y
 Q
STACHK(ST,EXPDT) ;Status Check
 ;Input:  ST    - Status of prescription
 ;        EXPDT - Expiration date or prescription
 ;
 I ST="" Q 0
 I (ST="DELETED")!(ST="NON-VERIFIED") Q 0
 I "EXPIRED"[ST D  I $$FMDIFF^XLFDT(DT,Y)>90 Q 0
 .N %DT S %DT="X",X=EXPDT D ^%DT
 S ST=$S(ST["DISCONTINUED":"DC",ST["HOLD":"HOLD",1:ST)
 Q 1_"^"_ST
 ;
SETTMP ;Sets the ^TMP("PSORDI",$J global
 S SEQ=SEQ+1,^TMP("PSORDI",$J,SEQ,0)=LINE
 Q
GETSIG ;Get SIG for remote sites from ^TMP($J,"PSORDI",
 N RSIG,I
 F I=0:1 Q:'$D(^TMP($J,"PSORDI",PSODFN,LC,"SIG",I))  S RSIG(I+1)=^(I)
 ;
FMTSIG ;Format SIG from remote site and return in the FSIG array
 N FFF,NNN,CNT,FVAR,FVAR1,FLIM,II
 S (FVAR,FVAR1)="",II=1
 K FSIG
 F FFF=0:0 S FFF=$O(RSIG(FFF)) Q:'FFF  S CNT=0 F NNN=1:1:$L(RSIG(FFF)," ") S CNT=CNT+1 D  I $L(FVAR)>52 S FSIG(II)=FLIM_" ",II=II+1,FVAR=FVAR1
 .S FVAR1=$P(RSIG(FFF)," ",CNT),FLIM=FVAR
 .S FVAR=$S(FVAR="":FVAR1,1:FVAR_" "_FVAR1)
 I $G(FVAR)'="" S FSIG(II)=FVAR
 I $G(FSIG(1))=""!($G(FSIG(1))=" ") S FSIG(1)=$G(FSIG(2)) K FSIG(2)
 Q
 ;
RDI(DFN) ; This call gets patient prescription data from other hospitals and
 ;  stores them in ^TMP($J,"PSORDI"
 ;
 ;  Input:    DFN - The patient DFN from the patient file.
 ;  Output:   ^TMP($J,"PSORDI", - patient medication data.
 ;
 N PSORET,PSOMED,PSOSIG,PSOSTAT,PSOSTR,LN,FAC,DRG,CNT
 K ^TMP($J,"PSORDI"),^TMP("PSOREMOTE",$J)
 I '$G(DFN) D  Q 0
 .S ^TMP($J,"PSORDI",1,0)="Invalid Patient IEN."
 I '$$HAVEHDR^ORRDI1 D  Q 0
 .S ^TMP($J,"PSORDI",1,0)="Remote Data from HDR not available."
 I $D(^XTMP("ORRDI","OUTAGE INFO","DOWN")) D  Q 0
 .S ^TMP($J,"PSORDI",1,0)="WARNING: Connection to Remote Data Currently Down."
 S PSORET=$$GETRDI(DFN)
 I PSORET=-1 D  Q 0
 .S ^TMP($J,"PSORDI",1,0)="Connection to Remote Data Not Available."
 I '$D(^XTMP("ORRDI","PSOO",DFN)) D  Q 0
 .S ^TMP($J,"PSORDI",1,0)="No Remote Data available for this patient."
 ;
PARSE S (LN,PSOMED)=0
 F  S PSOMED=$O(^XTMP("ORRDI","PSOO",DFN,PSOMED)) Q:'+PSOMED  D
 .S PSOSTAT=$G(^XTMP("ORRDI","PSOO",DFN,PSOMED,5,0))
 .S PSOSTR=$G(^XTMP("ORRDI","PSOO",DFN,PSOMED,1,0))_"^"_$G(^XTMP("ORRDI","PSOO",DFN,PSOMED,2,0))_"^"_$G(^XTMP("ORRDI","PSOO",DFN,PSOMED,3,0))_"^"_$G(^XTMP("ORRDI","PSOO",DFN,PSOMED,4,0))_"^"
 .S PSOSTR=PSOSTR_$G(^XTMP("ORRDI","PSOO",DFN,PSOMED,5,0))_"^"_$G(^XTMP("ORRDI","PSOO",DFN,PSOMED,6,0))_"^"_$G(^XTMP("ORRDI","PSOO",DFN,PSOMED,7,0))_"^"_$G(^XTMP("ORRDI","PSOO",DFN,PSOMED,8,0))_"^"
 .S PSOSTR=PSOSTR_$G(^XTMP("ORRDI","PSOO",DFN,PSOMED,9,0))_"^"_$G(^XTMP("ORRDI","PSOO",DFN,PSOMED,10,0))_"^"_$G(^XTMP("ORRDI","PSOO",DFN,PSOMED,11,0))_"^"_$G(^XTMP("ORRDI","PSOO",DFN,PSOMED,12,0))
 .S FAC=$G(^XTMP("ORRDI","PSOO",DFN,PSOMED,1,0))
 .S DRG=$G(^XTMP("ORRDI","PSOO",DFN,PSOMED,2,0))
 .S FAC=$S(FAC="":"**UNKNOWN**",1:$E(FAC,1,30))
 .S DRG=$S(DRG="":"**UNKNOWN**",1:$E(DRG,1,30))
 .S LN=LN+1,^TMP("PSOREMOTE",$J,DFN,FAC,DRG,LN,0)=PSOSTR,PSOSIG=""
 .F  S PSOSIG=$O(^XTMP("ORRDI","PSOO",DFN,PSOMED,14,PSOSIG)) Q:PSOSIG=""  S ^TMP("PSOREMOTE",$J,DFN,FAC,DRG,LN,"SIG",PSOSIG)=^(PSOSIG)
 I '$D(^TMP("PSOREMOTE",$J,DFN)) D  Q 0
 .S ^TMP($J,"PSORDI",1,0)="No Active Remote Medications for this patient."
 S FAC="",CNT=0
 F  S FAC=$O(^TMP("PSOREMOTE",$J,DFN,FAC)) Q:FAC=""  S DRG="" D
 .F  S DRG=$O(^TMP("PSOREMOTE",$J,DFN,FAC,DRG)) Q:DRG=""  S LN=0 D
 ..F  S LN=$O(^TMP("PSOREMOTE",$J,DFN,FAC,DRG,LN)) Q:'LN  D
 ...S CNT=CNT+1,^TMP($J,"PSORDI",DFN,CNT,0)=^TMP("PSOREMOTE",$J,DFN,FAC,DRG,LN,0)
 ...M ^TMP($J,"PSORDI",DFN,CNT,"SIG")=^TMP("PSOREMOTE",$J,DFN,FAC,DRG,LN,"SIG")
 K ^TMP("PSOREMOTE",$J)
RDIOUT Q 1
 ;
GETRDI(DFN) ; call to get remote data
 N RDI
 S RDI=$$GET^ORRDI1(DFN,"PSOO")
 Q $G(RDI)
 ;
RDICHK(PSODFN) ;Check for remote prescriptions
 ;Input - PSODFN Patient internal entry number
 ;
 N DIR,X,Y
 I '$$RDI(PSODFN) Q
 W !!,"REMOTE PRESCRIPTIONS AVAILABLE!"
 S DIR(0)="Y",DIR("A")="Display Remote Data",DIR("B")="N"
 D ^DIR W ! I 'Y Q
 D EN(PSODFN)
 Q
 ;
REMOTE ; Listman display of remote prescriptions
 I '$D(^TMP("PSORDI",$J)) D BLDRDI
 D EN^PSORMRXD("DO")
 Q
 ;
BOTH ; Listman display of remote and local prescriptions
 D EN^PSORMRXD("DB")
 Q
 ;
HELP ;
 Q
 ;
EXIT ;
 K ^TMP("PSORDI",$J),^TMP($J,"PSORDI"),^TMP("PSORSITE",$J)
 K ^TMP("PSORDIS",$J),PSORFLG
 Q
