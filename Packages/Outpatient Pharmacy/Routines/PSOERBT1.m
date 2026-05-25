PSOERBT1 ;ALB/RM - PSO ERX UTILITIES ;Jan 16, 2025@12:43:34
 ;;7.0;OUTPATIENT PHARMACY;**770**;DEC 16, 1997;Build 145
 ;
ERXBATCH(CHRQTYPE,FROMDRUG,NEWDRUG) ;entry point for PSO ERX BATCH CHANGE REQUEST SUBMISSION protocol action
 ;Input: CHRQTYPE - Type of eRx Change Request
 ;                  1 - Change Request for Same Drug/SIG Rx's
 ;                  2 - Drug Replacement for Similar VistA Drug
 ;                  3 - Change Request w/out Drug Suggestion(s)
 ;      FROMDRUG  - Pointer to the DRUG file (#50)
 ;    (o)NEWDRUG  - Pointer to the DRUG file (#50)
 ;
 I '+$G(FROMDRUG) Q
 N CNT,ERXIEN,SEL,VRXIEN,NPIINST,INSTNAME,ERXBTCHFLG,PSOBTDAT,STATION,INSTNPI,DRUGNAME,DRUGCODE,DRUGCODQ,QTY,ERXBTCHFLG
 N ERXHUBID,REASONTXT,DIR,DIRUT,DIROUT,TEXT,CNTR,SELCNT,ENTRYNUM,EXTRCODE,EXTSCODE,GBL,PNCOMM,CRMEDS,DAYSUP,NUMREFS,VISTASIG,VASIG
 S ERXBTCHFLG=1 D FULL^VALM1 S VALMBCK="R"
 I $G(CHRQTYPE)=2,'$G(NEWDRUG) W !,"New VistA Drug is missing, please enter a new VistA Drug." D DIRE^PSOERXX1 Q
 ;
 ;prompt the user to select which RX they want to send CH requests and create a PN.
 D ENTRYSEL^PSOERBT I '$O(^TMP("PSOERSEL",$J,0)) Q
 S (RX,SELCNT)=0 F  S RX=$O(^TMP("PSOERSEL",$J,RX)) Q:'RX  S SELCNT=SELCNT+1
 ;
 S NPIINST=$$GET1^DIQ(59,PSOSITE,101,"I"),INSTNAME=$$NAME^XUAF4(NPIINST),STATION=$$WHAT^XUAF4(NPIINST,99)
 S INSTNPI=$$NPI^XUSNPI("Organization_ID",NPIINST) I $P(INSTNPI,U)<1 D
 . S INSTNPI=$$WHAT^XUAF4(NPIINST,41.99)
 I '$G(INSTNPI) W !!,"Institution NPI Number could not be found. Cannot create Change Request." D DIRE^PSOERXX1 Q
 ;
 ;build the erx change request data just once
 D EN^PSOERCR0        ;This is to build the entire CH RQ data and all Vista RX listed in the LM will inherit all of the CH RQ data. This is built only once.
 I '$D(PSOBTDAT) Q    ;User aborted building the ERX batch change request data.
 ;
 W ! K DIR S DIR(0)="SA^Y:YES;N:NO",DIR("B")="YES"
 S DIR("B")="NO",DIR("A")="Are you sure you want to send "_$S(SELCNT=1:"this ",1:"these ")_$G(IOINHI)_$G(SELCNT)_$G(IOINORM)_" Rx's Change Requests? "
 D ^DIR I ($D(DIRUT)!$D(DIROUT)!(Y="N")) Q
 S EXTRCODE=$G(PSOBTDAT("EXTRCODE"))
 S EXTSCODE=$G(PSOBTDAT("EXTSCODE"))
 S PNCOMM=$G(PSOBTDAT("PNCOMM"))
 M REATXT=PSOBTDAT("REATXT")
 I $G(CHRQTYPE)=1 K CRMEDS M CRMEDS=PSOBTDAT("CRMEDS")
 ;
 S CNTR=0,ERXBTCHFLG=1
 S VRXIEN="" F  S VRXIEN=$O(^TMP("PSOERSEL",$J,VRXIEN)) Q:'VRXIEN  D
 . S ERXIEN=$$ERXIEN^PSOERXUT(VRXIEN) I 'ERXIEN Q
 . ;Building CRMEDS array for option #2
 . I $G(CHRQTYPE)=2 D
 . . K DRUGNAME,DRUGCODE,DRUGCODQ,QTY,DAYSUP,NUMREFS,VISTASIG,VASIG
 . . S DRUGNAME=$$GET1^DIQ(50,+NEWDRUG,.01),DRUGCODE=$$GETNDC^PSSNDCUT(+NEWDRUG,$G(PSOSITE)),DRUGCODQ="ND"
 . . S QTY=+$$GET1^DIQ(52,VRXIEN,7)
 . . S DAYSUP=+$$GET1^DIQ(52,VRXIEN,8,"I")
 . . S NUMREFS=+$$GET1^DIQ(52,VRXIEN,9,"I")
 . . K CRMEDS
 . . S CRMEDS(1)="V^"_DRUGNAME_"^"_DRUGCODE_"^"_DRUGCODQ_"^0^"_QTY_"^QS^C38046^"_DAYSUP_"^"_NUMREFS
 . . S CRMEDS(1,"NOTE")=$G(PSOBTDAT("NOTE2PRV"))
 . . S VISTASIG=$$RXSIG(VRXIEN)
 . . K VASIG D WRAP^PSOERUT(VISTASIG,80,.VASIG)
 . . S CRMEDS(1,"SIG",0)="^^1^1^"_DT_"^"
 . . M CRMEDS(1,"SIG")=VASIG
 . ;Note: For CHRQTYPE=3, we are only sending EXTRCODE, EXTSCODE, PNCOMM, and REATXT, which are already set above.
 . ;                      No medication change request (CRMEDS) is needed, so there is no need to do anything for criteria #3.
 . ;
 . S ENTRYNUM=+$G(^TMP("PSOERSEL",$J,VRXIEN)),CNTR=CNTR+1
 . S TEXT=$E($P(@VALMAR@(ENTRYNUM,0),"&",2),1,45),$E(TEXT,1)=""
 . W !!,IOINHI_CNTR_".   "_TEXT_IOINORM
 . W !,"     Sending Request to Provider..."
 . S CNT=0
 . D SENDCHRQ^PSOERCR0(ERXIEN,.CRMEDS,1)
 . I $D(TDDAT) K TDDAT
 W ! D PAUSE^PSOERXUT
 K ^TMP("PSOERSEL",$J)
 D REF^PSOERBT
 Q
 ;
RXSIG(RXIEN) ; Return the Rx SIG w/out PI
 ; Input: RXIEN - Pointer to the Rx being worked on (Pointer to #52)
 ;Return: RXSIG - VistA Rx SIG
 ;
 I '$G(RXIEN) Q ""
 N DOSE,SIG,RXSIG
 I '$$GET1^DIQ(52,RXIEN,6,"I") Q ""
 K DOSE D VARXDOSE^PSOERUT4(RXIEN,.DOSE)
 K SIG D EN^PSOFSIG(.DOSE)
 S RXSIG="" F I=1:1 Q:'$D(SIG(I))  S RXSIG=$G(SIG(I))_" "
 S $E(RXSIG,$L(RXSIG))=""
 Q RXSIG
