ORAREN ;SLC/JLC - PROCESS RENEWAL REQUEST ;10/27/2014  07:14
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**336,349,350**;Dec 17, 1997;Build 77
 ;
 ;The purpose of this API is to process a request to renew an
 ;Outpatient Prescription
 ;
 ;  DBIA 2790 - ACTVSURO^XQALSURO
 ;  DBIA 2343 - ACTIVE^XUSER
 ;  DBIA 2848 - GETALL^SCAPMCA
 ;  DBIA 2263 - GET^XPAR
 ;
 Q
RENEW(ORRESULT,DFN,RX,PROVP,RENEWF) ;
 ;Input - DFN of the patient
 ;        RX to be renewed
 ;
 ; One assumption is made for now and that is that the TMP globals and the message counters are
 ; initialized by the calling routine. Not a perfect scenario, but in order to batch the mail
 ; messages that is what was done.
 ;*349 Added passing to build the message for variable safety. And mail reformat.
 N X,OK,ORY,ORPKG,ORITM,ORIFN,PSOSTAT,A,PDET,ORFLDS,DRUG,DISPLAY,FAIL,LIST,OCHKS,OCO,OCLIST,ORCPLX,ORINFO,ORPVSTS
 N ORL,ORPROV,PCP,PCPN,RNWFLDS,Y,ORUSR,NEWIFN,PNM,RXE,EMSG,INMSG,ORPROVNM ;*349
 K ^TMP("SC",$J) S RENEWF=$G(RENEWF)
 I $G(PROVP)="" S PROVP="A"
 S PNM=$P($G(^DPT(DFN,0)),U),ORUSR=$$GET^XPAR("SYS","OR AUTORENEWAL USER") I ORUSR="" D AE(.EMSG,RX,DFN,"No auto-renewal user defined") S ORRESULT=0 G END
 D EN^PSOORDER(DFN,RX)
 S DRUG=$P($G(^TMP("PSOR",$J,RX,"DRUG",0)),U,2)
 S:DRUG="" DRUG=$P($P($G(^TMP("PSOR",$J,RX,"DRUG",0)),U),";",2)
 S PSOSTAT=$P($P($G(^TMP("PSOR",$J,RX,0)),U,4),";") I PSOSTAT'="A",PSOSTAT'="E" D AE(.EMSG,RX,DFN,"RX Status Not Active or Expired") S ORRESULT=0 G END
 D LOCK^ORWDX(.OK,DFN) I 'OK D AE(.EMSG,RX,DFN,"Chart Lock Failed") S ORRESULT=0 G END
 S ORIFN=$P($G(^TMP("PSOR",$J,RX,1)),U,8) I ORIFN="" D AE(.EMSG,RX,DFN,"No CPRS Order Number") S ORRESULT=0 G UNLOCK
 I RENEWF="N" D  G UNLOCK
 .D AE(.EMSG,RX,DFN,"Drug not renewable")
 .D EN^ORB3(73,DFN,ORIFN,"","Non-Renewable RX Request for "_DRUG,"NEW;"_ORIFN)
 .S ORRESULT=0
 D LOCKORD^ORWDX(.OK,ORIFN) I 'OK D AE(.EMSG,RX,DFN,"Order Lock Failed") S ORRESULT=0 G UNLOCK
 S A=$G(^OR(100,ORIFN,0)) I A="" D AE(.EMSG,RX,DFN,"Order missing from ORDERS file") S ORRESULT=0 G UNO
 S ORPROV=+$P(A,U,4),ORL=+$P(A,U,10)
 ;*349 Add Provider name, check valid surogate
 S ORPROVNM=$$GET1^DIQ(200,ORPROV,.01,"E"),ORPVSTS=$$ACTIVE^XUSER(ORPROV)
 I ORPROVNM]"" S ORPROVNM="("_ORPROVNM_")"
 I '$G(ORPVSTS)&($$ACTVSURO^XQALSURO(ORPROV)<1) D AE(.EMSG,RX,DFN,"Provider "_ORPROVNM_$S(ORPVSTS="":" NOT FOUND",1:" flagged as "_$P(ORPVSTS,U,2))) S ORRESULT=0 G UNO
 S PCPN=$$GETALL^SCAPMCA(DFN),PCP=+$G(^TMP("SC",$J,DFN,"PCPR",1))
 I PROVP="P",ORPROV'=PCP D AE(.EMSG,RX,DFN,"Ordering Provider "_ORPROVNM_" not Primary Care") S ORRESULT=3 G UNO
 D ALLWORD^ORALWORD(.ORY,DFN,ORIFN,"E",ORPROV) I $G(ORY)>0 D AE(.EMSG,RX,DFN,"Clozapine Failed - details below",.ORY) S ORRESULT=0 G UNO
 D VALID^ORWDXA(.ORY,ORIFN,"RN",ORPROV)
 I $G(ORY)]"" D  G UNO
 .D AE(.EMSG,RX,DFN,"Invalid Action - details below",.ORY)
 .D:$$UP^XLFSTR(ORY)["NON-RENEWABLE" EN^ORB3(73,DFN,ORIFN,"","Non-Renewable RX Request for "_DRUG,"NEW;"_ORIFN)
 .S ORRESULT=0
 D GETPKG^ORWDXR(.ORPKG,ORIFN) I '$D(ORPKG) D AE(.EMSG,RX,DFN,"Invalid Order Number") S ORRESULT=0 G UNO
 I ORPKG'="PSO" D AE(.EMSG,RX,DFN,"Problem with package in ORDERS file") S ORRESULT=0 G UNO
 D GTORITM^ORWDXR(.ORITM,ORIFN)
 D FAILDEA^ORWDPS1(.FAIL,ORITM,ORPROV,"O") I FAIL D AE(.EMSG,RX,DFN,"Failed DEA Check") S ORRESULT=0 G UNO
 ;*349 Maintain AUDIO RENEWAL USER on pharmacy side.
 D RNWFLDS^ORWDXR(.RNWFLDS,ORIFN) S ORFLDS(1)=RNWFLDS(0),ORFLDS("ORDUZ")=ORUSR
 D CHKGRP^ORWDPS2(.DISPLAY,ORIFN) I DISPLAY'=2 D AE(.EMSG,RX,DFN,"Package Problem on Order") S ORRESULT=0 G UNO
 D ON^ORWDXC(.OCO)
 D DISPLAY^ORWDXC(.OCLIST,DFN,ORPKG) I $D(OCLIST) D INFO(.INMSG,RX,DFN,.OCLIST)
 D OXDATA^ORWDXR01(.ORINFO,ORIFN)
 S ORINFO(1)=ORINFO
 D ACCEPT^ORWDXC(.OCHKS,DFN,"PSO","",ORL,.ORINFO,ORIFN,1)
 I $D(OCHKS) D INFO(.INMSG,RX,DFN,.OCHKS)
 D ISCPLX^ORWDXR(.ORCPLX,ORIFN) S ORCPLX=+$G(ORCPLX)
 S (CNT,S1)=0 F  S S1=$O(OCHKS(S1)) Q:'S1  S CNT=CNT+1,ORFLDS("ORCHECK",$P(OCHKS(S1),U),$P(OCHKS(S1),U,3),CNT)=$P(OCHKS(S1),U,2,99)
 I CNT>0 S ORFLDS("ORCHECK")=CNT
 D RENEW^ORWDXR(.LIST,ORIFN,DFN,ORPROV,ORL,.ORFLDS,ORCPLX,0) S ORRESULT=1
 S NEWIFN=$P(^OR(100,ORIFN,3),U,6)
 S $P(^OR(100,NEWIFN,8,1,0),U,13)=ORUSR
 D UNSIGNED(NEWIFN)
 D KILUNSNO^ORWORB(.Y,DFN)
 D KILEXMED^ORWORB(.Y,DFN)
UNO D UNLKORD^ORWDX(.OK,ORIFN)
UNLOCK D UNLOCK^ORWDX(.OK,DFN)
 ;
END ;*249 Modify END.
 ;Merge Message Arrays into ^TMP( for VEXRX, add header if needed.
 N I,J,RXELN,DRGLN,DSPNMLN,SPACE
 S SPACE=$J(" ",40)
 S RXELN=$$GET1^DID(52,.01,"","FIELD LENGTH"),DRGLN=$$GET1^DID(52,6,"","FIELD LENGTH"),DSPNMLN=$$GET1^DID(2,.01,"","FIELD LENGTH")
 I $D(EMSG) D
 . S J=$O(^TMP($J,"ORAREN E",""),-1)+1
 . I J<2 D
 . . S ^TMP($J,"ORAREN E",J,0)="Renewal Requests Not Sent to Provider",J=J+1
 . . S ^TMP($J,"ORAREN E",J,0)=" ",J=J+1
 . . S ^TMP($J,"ORAREN E",J,0)=$E("PATIENT"_SPACE,0,DSPNMLN)_" "_$E("RX#"_SPACE,0,RXELN)_" "_$E("DRUG"_SPACE,0,DRGLN),J=J+1
 . . S ^TMP($J,"ORAREN E",J,0)="    PROBLEM",J=J+1
 . . S ^TMP($J,"ORAREN E",J,0)="==============================================================================",J=J+1
 . . S ^TMP($J,"ORAREN E",J,0)=" ",J=J+1
 . F I=0:0 S I=$O(EMSG(I)) Q:'I  S ^TMP($J,"ORAREN E",J,0)=EMSG(I),J=J+1
 I $D(INMSG) D
 . S J=$O(^TMP($J,"ORAREN OC",""),-1)+1
 . I J<2 D
 . . S ^TMP($J,"ORAREN OC",J,0)="Renewal Requests with Order Checks",J=J+1
 . . S ^TMP($J,"ORAREN OC",J,0)=" ",J=J+1
 . . S ^TMP($J,"ORAREN OC",J,0)=$E("PATIENT"_SPACE,0,DSPNMLN)_" "_$E("RX#"_SPACE,0,RXELN)_" "_$E("DRUG"_SPACE,0,DRGLN),J=J+1
 . . S ^TMP($J,"ORAREN OC",J,0)="==============================================================================",J=J+1
 . . S ^TMP($J,"ORAREN OC",J,0)=" ",J=J+1
 . F I=0:0 S I=$O(INMSG(I)) Q:'I  S ^TMP($J,"ORAREN OC",J,0)=INMSG(I),J=J+1
 Q
 ;
AE(MSARY,RX,DFN,TEXT,PDET) ;*349
 ;Input:  MSARY - Output aray
 ;        RX    - Internal RX#
 ;        DFN   - Internal Patient DFN
 ;Output: MSARY will be appended with a line pertaining to the input.
 ;
 N I,S1,SPACE,CNT,RXE,DRG,PNM,SSN,SSID,SPACE S SPACE=$J(" ",40),CNT=1
 N RXELN,DRGLN,DSPNMLN
 S RXE=$$GET1^DIQ(52,RX,.01,"E"),DRG=$$GET1^DIQ(52,RX,6,"E"),PNM=$$GET1^DIQ(2,DFN,.01,"E"),SSN=+$$GET1^DIQ(2,DFN,.09,"E")
 S RXELN=$$GET1^DID(52,.01,"","FIELD LENGTH"),DRGLN=$$GET1^DID(52,6,"","FIELD LENGTH"),DSPNMLN=$$GET1^DID(2,.01,"","FIELD LENGTH")
 S SSID="("_$E(PNM,1)_$E(SSN,$L(SSN)-3,$L(SSN))_")"
 S DSPNM=$E(PNM,1,DSPNMLN-$L(" "_SSID))_" "_SSID  ;Have to truncate Patient name if it is too long.
 F I="DSPNM","RXE","DRG" S MSARY(CNT)=$G(MSARY(CNT))_$E(@I_SPACE,1,@(I_"LN"))_" "
 S CNT=CNT+1
 S MSARY(CNT)=$E(SPACE,0,4)_TEXT,CNT=CNT+1
 I $D(PDET),$O(PDET(0))="" S MSARY(CNT)=$E(SPACE,0,4)_PDET,CNT=CNT+1 Q
 I $D(PDET) S S1=0 F  S S1=$O(PDET(S1)) Q:'S1  S MSARY(CNT)=$E(SPACE,0,4)_PDET(S1),CNT=CNT+1
 Q
 ;
INFO(INARY,RX,DFN,MSG)     ;file informational items in mail message ;*349
 ;Input:  INARY - Output aray
 ;        RX    - Internal RX#
 ;        DFN   - Internal Patient DFN
 ;        MSG   - Message Array
 ;Output: INARY will be appended with a line pertaining to the input.
 ;
 N I,SPACE,CNT,RXE,DRG,PNM,SSN,SSID,DSPNM,SPACE,S1 S SPACE=$J(" ",40),CNT=1
 N RXELN,DRGLN,DSPNMLN
 I $D(INARY) S CNT=$O(INARY(""),-1)
 I '$D(INARY) D
 . S RXE=$$GET1^DIQ(52,RX,.01,"E"),DRG=$$GET1^DIQ(52,RX,6,"E"),PNM=$$GET1^DIQ(2,DFN,.01,"E"),SSN=+$$GET1^DIQ(2,DFN,.09,"E")
 . S RXELN=$$GET1^DID(52,.01,"","FIELD LENGTH"),DRGLN=$$GET1^DID(52,6,"","FIELD LENGTH"),DSPNMLN=$$GET1^DID(2,.01,"","FIELD LENGTH")
 . S SSID="("_$E(PNM,1)_$E(SSN,$L(SSN)-3,$L(SSN))_")"
 . S DSPNM=$E(PNM,1,DSPNMLN-$L(" "_SSID))_" "_SSID  ;Have to truncate Patient name if it is too long.
 . F I="DSPNM","RXE","DRG" S INARY(CNT)=$G(INARY(CNT))_$E(@I_SPACE,0,@(I_"LN"))_" "
 S CNT=CNT+1,INARY(CNT)=" ",CNT=CNT+1,S1=0
 F  S S1=$O(MSG(S1)) Q:'S1  D  S INARY(CNT)=" ",CNT=CNT+1
 . I $L(MSG(S1),U)>2 S INARY(CNT)=$P(MSG(S1),U,4,99),CNT=CNT+1 Q
 . S INARY(CNT)=$E(SPACE,0,5)_MSG(S1),CNT=CNT+1
 Q
UNSIGNED(UIFN) ;queue unsigned order alert
 N ORVP,ORIFN,ORNP,A
 Q:$G(UIFN)=""  S A=$G(^OR(100,UIFN,0)),ORVP=$P(A,U,2),ORNP=$P(A,U,4),ORIFN=UIFN_";1"
 D NOTIF^ORCSIGN
 Q
