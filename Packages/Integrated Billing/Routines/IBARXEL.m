IBARXEL ;ALB/CPM - RX COPAY EXEMPTION INCOME TEST REMINDERS ;22-MAR-95
 ;;2.0;INTEGRATED BILLING;**34,139,206,217**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
EN ; Entry point for the generation of income test reminder letters.
 ; Invoked by the nightly IB Background job (routine IBAMTC).
 ;
 ; - check the job parameters
 S IBLET=$O(^IBE(354.6,"B","IB INCOME TEST REMINDER",0)) I 'IBLET G ENQ
 S IBLET0=$G(^IBE(354.6,IBLET,0))
 S IBDEV=$P(IBLET0,"^",5) I IBDEV="" G ENQ
 S IBREPR=$P(IBLET0,"^",7)
 ;
 ; - should the job run tonight?
 D NOW^%DTC S IBDAT=%
 S IBDAY=$$DOW^XLFDT(IBDAT\1,1)
 I $E(IBDAT,8,17)>.17 S IBDAY=$S(IBDAY=6:0,1:IBDAY+1)
 I $P(IBLET0,"^",6)'[IBDAY G ENQ
 ;
 ; - who needs a letter?
 S IBSTART=$$FMADD^XLFDT(IBDAT\1,-366)
 S IBEND=$$FMADD^XLFDT(IBDAT\1,-305)
 ;
 K ^TMP("IBEX",$J)
 S IBD=IBSTART F  S IBD=$O(^IBA(354.1,"B",IBD)) Q:'IBD!(IBD>IBEND)  D
 .S IBEX=0 F  S IBEX=$O(^IBA(354.1,"B",IBD,IBEX)) Q:'IBEX  D
 ..S IBEXD=$G(^IBA(354.1,IBEX,0)) Q:'IBEXD
 ..;
 ..; - don't reprint letter unless requested
 ..S IBLASTPR=$P(IBEXD,"^",16)
 ..I IBREPR,IBLASTPR,IBLASTPR'=IBREPR Q
 ..I 'IBREPR,IBLASTPR Q
 ..;
 ..Q:$P(IBEXD,"^",3)'=1  ;           not a copay exemption
 ..Q:'$P(IBEXD,"^",10)  ;            exemption is not active
 ..;
 ..S IBEXREA=$$ACODE^IBARXEU0(IBEXD)
 ..I IBEXREA'=110,IBEXREA'=120 Q  ;  exemption is not based on income
 ..;
 ..S DFN=+$P(IBEXD,"^",2)
 ..Q:$$BIL^DGMTUB(DFN,IBD)  ; vet is cat c or pend. adj. & agreed to pay deductible
 ..I $P(IBLET0,"^",8),$$DOM(DFN) Q  ;  vet is in a dom
 ..Q:$G(^DPT(DFN,.35))  ;              vet is deceased
 ..I +IBEXD'=$P($G(^IBA(354,DFN,0)),"^",3) Q  ;  exemption not current
 ..Q:$D(^TMP("IBEX",$J,"V",DFN))  ;    vet already getting letter
 ..;
 ..; - sort letters by zip code
 ..K VA,VAERR,VAPA D ADD^VADPT
 ..S IBZIP=$P(VAPA($S($$CONFADD():18,1:11)),"^",2) S:IBZIP="" IBZIP="99999-9999"
 ..S:'$P(IBZIP,"-",2) IBZIP=$E(IBZIP,1,5)_"-0000"
 ..S ^TMP("IBEX",$J,"V",DFN)=""
 ..S ^TMP("IBEX",$J,"L",IBZIP,IBEX)=+IBEXD_"^"_+$P(IBEXD,"^",4)_"^"_DFN
 ;
 ; - open a print device if necessary
 I '$D(^TMP("IBEX",$J,"L")) G ENQ
 S IOP=IBDEV D ^%ZIS I POP G ENQ
 U IO
 ;
 ; - print the letters
 S IBSCR="" F  S IBSCR=$O(^TMP("IBEX",$J,"L",IBSCR)) Q:IBSCR=""  D
 .S IBEX=0 F  S IBEX=$O(^TMP("IBEX",$J,"L",IBSCR,IBEX)) Q:'IBEX  D PRINT
 ;
ENQ I $G(IBREPR),IBLET S DA=IBLET,DIE="^IBE(354.6,",DR=".07////@" D ^DIE K DA,DR,DIE
 ;
 D ^%ZISC
 K ^TMP("IBEX",$J),DFN,VAPA,VA,VAERR,X
 K IBD,IBEX,IBEXD,IBEXREA,IBDAT,IBDAY,IBDEV,IBZIP,IBLET0,IBREPR,IBQUIT
 K IBEND,IBLET,IBSTART,IBSCR,IBEXPD,IBDATA,IBNAM,IBALIN,IBLASTPR
 Q
 ;
 ;
PRINT ; Print a reminder letter.
 ;  Required variable input:
 ;      IBEX  --  Pointer to exemption in file #354.1
 ;     IBLET  --  Pointer to the reminder letter in file #354.6
 ;
 ; - set letter variables
 S IBEXD=$G(^IBA(354.1,+IBEX,0))
 S IBEXPD=$$DATE($$PLUS^IBARXEU0(+IBEXD))
 ;S IBEXPD=$$DATE($$FMADD^XLFDT(+IBEXD,365))
 S DFN=+$P(IBEXD,"^",2),IBQUIT=0
 S IBDATA=$$PT^IBEFUNC(DFN),IBNAM=$P(IBDATA,"^")
 S IBALIN=$P($G(^IBE(354.6,IBLET,0)),"^",4)
 I IBALIN<10!(IBALIN>25) S IBALIN=15
 ;
 ; - print letter
 D ONE^IBARXEPL
 ;
 ; - update the exemption
 S DA=IBEX,DIE="^IBA(354.1,",DR=".16////"_DT D ^DIE K DA,DR,DIE
 K IBEXD,TAB,IBCNTL,IB,IBCNT,IBX,VAPA,VA,VAERR
 Q
 ;
 ;
DATE(X) ; Format the exemption expiration date.
 N A S A="January^February^March^April^May^June^July^August^September^October^November^December"
 Q $P(A,"^",+$E(X,4,5))_" "_+$E(X,6,7)_", "_(1700+$E(X,1,3))
 ;
DOM(DFN) ; Is the veteran in a domiciliary?
 ;  Input:  DFN  -  Pointer to the patient in file #2
 ; Output:    0  -  Vet is not in a domiciliary
 ;            1  -  Vet is in a domiciliary
 ;
 N VAIN,VA,VAERR
 D INP^VADPT
 Q $P($G(^DIC(42,+$G(VAIN(4)),0)),"^",3)="D"
 ;
CONFADD() ; Determine, does the patient have a Confidential Address.
 ; Input: VAPA() local array (by ADD^VADPT)
 I '$G(VAPA(12)) Q 0  ; The Conf Address is not active
 I $P($G(VAPA(22,3)),U,3)'="Y" Q 0  ; The Conf Address is not valid for billing-related correspondence
 Q 1
