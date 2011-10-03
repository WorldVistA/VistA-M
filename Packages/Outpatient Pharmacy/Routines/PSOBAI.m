PSOBAI ;BIR/EJW - BAD ADDRESS PROCESSING ;02/02/2006
 ;;7.0;OUTPATIENT PHARMACY;**233,258,268,264**;DEC 1997;Build 19
 ;
 ;External reference EN^DGREGAED supported by DBIA 4198
 ;External reference UPDATE^DGADDUTL supported by DBIA 4886
 ;External reference ^DPT( supported by DBIA 5031
 ;
CHKADDR(PSODFN,WARN,UPDATE) ; CHECK ADDRESS BY PATIENT
 ;Input: PSODFN - PATIENT file (#2) IEN
 ;       WARN - Display warning (optional)
 ;       UPDATE - If bad address flagged, prompt to update patient address (optional)
 ;If calling from patient selection, if bad, even if there is an active temporary address, prompt to update the address
 N PSOBADR,PSOTEMP
 I PSODFN="" Q
 S PSOBADR=$$BADADR^DGUTL3(PSODFN)
 I PSOBADR D
 .S PSOTEMP=$$CHKTEMP(PSODFN)
 .I $G(WARN) D
 ..D WARN1
 ..I $G(UPDATE) D UPDATE Q
 ..D PAUSE
 Q
 ;
CHKRX(PSORX) ;CHECK ADDRESS BY RX
 ;Input: PSORX - PRESCRIPTION file (#52) IEN
 ;Output: PSOBADR - Bad Address Indicator_"^"_temporary address or not
 N PSOBADR,PSODFN,PSOTEMP
 S PSOBADR=""
 I PSORX="" Q 0
 S PSODFN=$P($G(^PSRX(PSORX,0)),"^",2) I PSODFN="" Q 0
 S PSOBADR=$$BADADR^DGUTL3(PSODFN)
 I PSOBADR S PSOTEMP=$$CHKTEMP(PSODFN)
 S PSOBADR=PSOBADR_"^"_$G(PSOTEMP)
 Q PSOBADR
 ;
WARN1 ;
 W !!,?8,"WARNING: The patient address is indicated as a bad"
 W !,?17,"address (",$S(PSOBADR=1:"UNDELIVERABLE",PSOBADR=2:"HOMELESS",1:"OTHER"),")."
 I $G(PSOTEMP) W !,?17,"* Temporary address is active *" Q
 W !,?17,"Medication will not be mailed to"
 W !,?17,"the patient until the address has been"
 W !,?17,"corrected.",!
 Q
CHKTEMP(PSODFN) ; see if active temporary address
 ;Input: PSODFN - PATIENT file (#2) IEN
 N DFN,VAPA
 S DFN=PSODFN,PSOTEMP=0
 D 6^VADPT I +VAPA(9) S PSOTEMP=1
 Q PSOTEMP
 ;
UPDATE ;
 N PSOSEL,DA
 I '$D(PSOPAR) D ^PSOLSET
 I '$P($G(PSOPAR),"^",22),'$D(^XUSEC("PSO ADDRESS UPDATE",+$G(DUZ))) D PAUSE Q
 K DIR S DIR(0)="Y",DIR("B")="N",DIR("A")="Do you want to update the address/phone"
 D ^DIR K DIR
 I Y'=1 Q
 L +^DPT(PSODFN):$S(+$G(^DD("DILOCKTM"))>0:+^DD("DILOCKTM"),1:3) I '$T D MSG,PAUSE Q
 K DIR S DIR(0)="SAO^P:PERMANENT;T:TEMPORARY;B:BOTH"
 S DIR("A")=" Update (P)ermanent address, (T)emporary, or (B)oth: "
 S DIR("B")="BOTH" D ^DIR
 I $D(DIRUT) G ULK
 S PSOSEL=Y
 I PSOSEL="P"!(PSOSEL="B") D
 .;D UPDATE^DGADDUTL(PSODFN,"PERM") - THIS CALL CLEARS BAI FLAG INAPPROPRIATELY SO USE FOLLOWING TO UPDATE PERMANENT ADDRESS/PHONE INSTEAD 5/29/06
 .N PSOFLG
 .S PSOFLG(1)=1 D EN^DGREGAED(PSODFN,.PSOFLG) W !
 S DA=PSODFN,DIE="^DPT(",DR=".134" D ^DIE W !
 I PSOSEL="P" D ULK Q
 I PSOSEL="B"!(PSOSEL="T") D UPDATE^DGADDUTL(PSODFN,"TEMP"),ULK,PAUSE
 Q
ULK ;
 L -^DPT(PSODFN)
 Q
 ;
PAUSE ;
 W ! K DIR S DIR(0)="E",DIR("A")="Press Return to continue" D ^DIR K DIR
 Q
 ;
MSG ;
 S VALMSG="Patient Data is being edited by another user!"
 Q
 ;
