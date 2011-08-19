ORAREN ;;SLC/JLC - Process Renewal Request from Non-CPRS System ; 11/2/10 11:39am
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**336**;Dec 17, 1997;Build 24
 ;
 ;The purpose of this API is to process a request to renew an
 ;Outpatient Prescription
 ;
 Q
RENEW(ORRESULT,DFN,RX,PROVP,RENEWF) ;
 ;Input - DFN of the patient
 ;        RX to be renewed
 ;
 ; One assumption is made for now and that is that the TMP globals and the message counters are
 ; initialized by the calling routine. Not a perfect scenario, but in order to batch the mail
 ; messages that is what was done.
 N X,OK,ORY,ORPKG,ORITM,ORIFN,PSOSTAT,A,PDET,ORFLDS,DRUG,DISPLAY,FAIL,LIST,OCHKS,OCO,OCLIST,ORCPLX,ORINFO,ORPVSTS
 N ORL,ORPROV,PCP,PCPN,RNWFLDS,SPACES,Y,ORUSR,NEWIFN,PNM,RXE
 K ^TMP("SC",$J) S SPACES=$J(" ",25),RENEWF=$G(RENEWF)
 I $G(PROVP)="" S PROVP="A"
 S PNM=$P($G(^DPT(DFN,0)),"^"),ORUSR=$$GET^XPAR("SYS","OR AUTORENEWAL USER") I ORUSR="" D AE("No auto-renewal user defined") S ORRESULT=0 G END
 D EN^PSOORDER(DFN,RX)
 S DRUG=$P($G(^TMP("PSOR",$J,RX,"DRUG",0)),"^",2)
 S PSOSTAT=$P($P($G(^TMP("PSOR",$J,RX,0)),"^",4),";") I PSOSTAT'="A",PSOSTAT'="E" D AE("RX Status Not Active or Expired") S ORRESULT=0 G END
 D LOCK^ORWDX(.OK,DFN) I 'OK D AE("Chart Lock Failed") S ORRESULT=0 G END
 S ORIFN=$P($G(^TMP("PSOR",$J,RX,1)),"^",8) I ORIFN="" D AE("No CPRS Order Number") S ORRESULT=0 G UNLOCK
 D LOCKORD^ORWDX(.OK,ORIFN) I 'OK D AE("Order Lock Failed") S ORRESULT=0 G UNLOCK
 S A=$G(^OR(100,ORIFN,0)) I A="" D AE("Order missing from ORDERS file") S ORRESULT=0 G UNO
 I RENEWF="N" D AE("Drug not renewable"),EN^ORB3(73,DFN,ORIFN,"","Rx Renewal Request for "_DRUG) S ORRESULT=0 G UNLOCK
 S ORPROV=+$P(A,"^",4),ORL=+$P(A,"^",10)
 S PCPN=$$GETALL^SCAPMCA(DFN),PCP=+$G(^TMP("SC",$J,DFN,"PCPR",1))
 I PROVP="P",ORPROV'=PCP D AE("Ordering Provider not Primary Care") S ORRESULT=3 G UNO
 D ALLWORD^ORALWORD(.ORY,DFN,ORIFN,"E",ORPROV) I $G(ORY)>0 D AE("Clozapine Failed - details below",.ORY) S ORRESULT=0 G UNO
 S ORPVSTS=$$ACTIVE^XUSER(ORPROV) I '$G(ORPVSTS) D AE("Provider "_$S(ORPVSTS="":"NOT FOUND",1:"flagged as "_$P(ORPVSTS,"^",2))) S ORRESULT=0 G UNO
 D VALID^ORWDXA(.ORY,ORIFN,"RN",ORPROV) I $G(ORY)]"" D AE("Invalid Action - details below",.ORY) S ORRESULT=0 G UNO
 D GETPKG^ORWDXR(.ORPKG,ORIFN) I '$D(ORPKG) D AE("Invalid Order Number") S ORRESULT=0 G UNO
 I ORPKG'="PSO" D AE("Problem with package in ORDERS file") S ORRESULT=0 G UNO
 D GTORITM^ORWDXR(.ORITM,ORIFN)
 D FAILDEA^ORWDPS1(.FAIL,ORITM,ORPROV,"O") I FAIL D AE("Failed DEA Check") S ORRESULT=0 G UNO
 D RNWFLDS^ORWDXR(.RNWFLDS,ORIFN) S ORFLDS(1)=RNWFLDS(0)
 D CHKGRP^ORWDPS2(.DISPLAY,ORIFN) I DISPLAY'=2 D AE("Package Problem on Order") S ORRESULT=0 G UNO
 D ON^ORWDXC(.OCO)
 D DISPLAY^ORWDXC(.OCLIST,DFN,ORPKG) I $D(OCLIST) D INFO
 D OXDATA^ORWDXR01(.ORINFO,ORIFN)
 D ACCEPT^ORWDXC(.OCHKS,DFN,"PSO","",ORL,ORINFO,ORIFN)
 D ISCPLX^ORWDXR(.ORCPLX,ORIFN) S ORCPLX=+$G(ORCPLX)
 D RENEW^ORWDXR(.LIST,ORIFN,DFN,ORPROV,ORL,.ORFLDS,ORCPLX,0) S ORRESULT=1
 S NEWIFN=$P(^OR(100,ORIFN,3),"^",6)
 S $P(^OR(100,NEWIFN,8,1,0),"^",13)=ORUSR
 D UNSIGNED(NEWIFN)
 D KILUNSNO^ORWORB(.Y,DFN)
 D KILEXMED^ORWORB(.Y,DFN)
UNO D UNLKORD^ORWDX(.OK,ORIFN)
UNLOCK D UNLOCK^ORWDX(.OK,DFN)
END I EMCNT>5 D
 . I '$G(ORRESULT) S ORRESULT=0
 . S ^TMP($J,"ORAREN E",1,0)="Renewal Requests Not Sent to Provider"
 . S ^TMP($J,"ORAREN E",2,0)=" "
 . S ^TMP($J,"ORAREN E",3,0)="PATIENT                    PRESCRIPTION  PROBLEM"
 . S ^TMP($J,"ORAREN E",4,0)="=============================================================================="
 . S ^TMP($J,"ORAREN E",5,0)=" "
 I INCNT>5 D
 . S ^TMP($J,"ORAREN OC",1,0)="Renewal Requests with Order Checks"
 . S ^TMP($J,"ORAREN OC",2,0)=" "
 . S ^TMP($J,"ORAREN OC",3,0)="PATIENT                    PRESCRIPTION"
 . S ^TMP($J,"ORAREN OC",4,0)="=============================================================================="
 . S ^TMP($J,"ORAREN OC",5,0)=" "
 Q
AE(TEXT,PDET) ;
 N S1
 S EMCNT=EMCNT+1,RXE=$P($G(^TMP("PSOR",$J,RX,0)),"^",5),^TMP($J,"ORAREN E",EMCNT,0)=$E(PNM,1,25)_$E(SPACES,1,27-$L(PNM))_RXE_$E(SPACES,1,14-$L(RXE))_TEXT
 I '(EMCNT#20) S EMCNT=EMCNT+1,^TMP($J,"ORAREN E",EMCNT,0)=" "
 I $D(PDET),$O(PDET(0))="" S EMCNT=EMCNT+1,^TMP($J,"ORAREN E",EMCNT,0)="     "_PDET Q
 I $D(PDET) S S1=0 F  S S1=$O(PDET(S1)) Q:'S1  S EMCNT=EMCNT+1,^TMP($J,"ORAREN E",EMCNT,0)="     "_PDET(S1)
 Q
INFO ;file informational items in mail message
 N I
 S INCNT=INCNT+1,^TMP($J,"ORAREN OC",INCNT,0)=$E(PNM,1,25)_$E(SPACES,1,27-$L(PNM))_$P($G(^TMP("PSOR",$J,RX,0)),"^",5)
 F I=1:1 Q:'$D(OCLIST(I))  S INCNT=INCNT+1,^TMP($J,"ORAREN OC",INCNT,0)="     "_OCLIST(I)
 Q
UNSIGNED(UIFN) ;queue unsigned order alert
 N ORVP,ORIFN,ORNP,A
 Q:$G(UIFN)=""  S A=$G(^OR(100,UIFN,0)),ORVP=$P(A,"^",2),ORNP=$P(A,"^",4),ORIFN=UIFN_";1"
 D NOTIF^ORCSIGN
 Q
