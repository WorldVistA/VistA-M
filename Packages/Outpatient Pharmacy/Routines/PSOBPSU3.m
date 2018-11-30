PSOBPSU3 ;ALB/CFS - BPS (ECME) Utilities 3 ;08/27/15
 ;;7.0;OUTPATIENT PHARMACY;**448**;DEC 1997;Build 25
 ; Reference to ^BPSVRX supported by IA #5723
 ; Reference to ^BPSPSOU1 supported by IA #6248
 ;
RES(RXIEN,DFN) ; Resubmit a claim action from PSO HIDDEN ACTIONS
 N ACTION,DIRUT,PSOCOB,PSOFILL,PSOFL,PSOFLZ,PSOELIG,REVREAS,VALID
 S PSOFILL=$$FILL(RXIEN,DFN,.PSOFL)
 I $D(DIRUT) G END
 I PSOFILL="" W !!,"No claim was ever submitted for this prescription. Cannot resubmit." D PAUSE^VALM1 G END
 S PSOELIG=$$ELIGDISP^PSOREJP1(RXIEN,PSOFILL)
 ; Validate the claim.
 S VALID=$$VAL^BPSPSOU1(RXIEN,PSOFILL,PSOELIG,"RES",.PSOCOB,.REVREAS) ;DBIA #6248
 I 'VALID G END
 I $$RXDEL(RXIEN,PSOFILL) D  D PAUSE^VALM1 G END
 . W !!,"The claim cannot be Resubmitted since it has been deleted in Pharmacy."
 ; Resubmit the claim to ECME
 D ECMESND^PSOBPSU1(RXIEN,PSOFILL,,"ED",,,"RESUBMIT FROM RX EDIT SCREEN","","","","","","","",$G(PSOCOB))
 D PAUSE^VALM1
 S VALMBCK="R"
 Q
 ;
FILL(RXIEN,DFN,PSOFL) ;
 N CNT,DIR,FILL,FLDT,PSOELIG,PSOET,PSOSTR,REFILL,RELDT,RF,RXNUM,X,Y
 D FULL^VALM1
 I '$G(RXIEN)!'$G(DFN) Q ""
 ;
 S RXNUM=$P($G(^PSRX(RXIEN,0)),U)
 K PSOFL,PSOFLZ
 ; Get refill dates and release dates
 S REFILL=0 F  S REFILL=$O(^PSRX(RXIEN,1,REFILL)) Q:'REFILL  D
 . S FLDT=$P($G(^PSRX(RXIEN,1,REFILL,0)),U)\1
 . S RELDT=$P($G(^PSRX(RXIEN,1,REFILL,0)),U,18)\1
 . S PSOFLZ(REFILL)=FLDT_U_RELDT
 ; Get orignal RX fill date and release date
 S FLDT=$P($G(^PSRX(RXIEN,2)),U)\1
 S RELDT=$P($G(^PSRX(RXIEN,2)),U,13)\1
 S PSOFLZ(0)=FLDT_U_RELDT
 ; Check for any deleted fills that have ECME activity
 D RFL^BPSVRX(RXIEN,.PSOFL)  ; DBIA #5723
 I '$D(PSOFL) Q "" ; Not in BPS transaction file.
 S RF="" F  S RF=$O(PSOFL(RF)) Q:RF=""  I '$D(PSOFLZ(RF)) S PSOFLZ(RF)=0_U_0
 ;
 S DIR(0)="S"
 S DIR("L",1)="Rx# "_RXNUM_" has the following fills:"
 S DIR("L",2)=""
 S DIR("L",3)="    Fill#   Fill Date     Release Date"
 S DIR("L",4)="    -----   ----------    ------------"
 S CNT=0,PSOSTR=""
 S RF="" F  S RF=$O(PSOFLZ(RF)) Q:RF=""  D
 . S CNT=CNT+1
 . S FLDT=$$FMTE^XLFDT($P(PSOFLZ(RF),U,1),"5Z") I 'FLDT S FLDT="    -     "
 . S RELDT=$$FMTE^XLFDT($P(PSOFLZ(RF),U,2),"5Z") I 'RELDT S RELDT="    -     "
 . I 'FLDT,'RELDT S (FLDT,RELDT)=" Deleted  "
 . S $P(PSOSTR,";",CNT)=RF_":"_FLDT_"    "_RELDT
 . S DIR("L",CNT+4)=$J(RF,7)_"     "_FLDT_"    "_RELDT
 . Q
 S DIR("L")=" "
 S $P(DIR(0),U,2)=PSOSTR
 S DIR("A")="Select Fill Number"
 S DIR("B")=$O(PSOFLZ(""),-1)
 I CNT=1 D
 . S $P(DIR("L",1)," ",$L(DIR("L",1)," "))="fill:"    ; singular
 . Q
 W ! D ^DIR K DIR
 S FILL=Y
 Q FILL
 ;
VER(RXIEN,DFN) ; -- VER hidden action under protocol PSO HIDDEN ACTIONS
 D FULL^VALM1
 K ^TMP("PSOHDR_ARCHIVE",$J)
 M ^TMP("PSOHDR_ARCHIVE",$J)=^TMP("PSOHDR",$J)
 S BPSVRX("RXIEN")=RXIEN
 D ^BPSVRX  ;DBIA #5723
 M ^TMP("PSOHDR",$J)=^TMP("PSOHDR_ARCHIVE",$J)
 K ^TMP("PSOHDR_ARCHIVE",$J)
 S VALMBCK="R"
 Q
 ;
REV(RXIEN,DFN) ; Reverse a claim action from PSO HIDDEN ACTIONS
 N DIRUT,PSOCOB,PSOFILL,PSOFL,PSOFLZ,PSOELIG,REVREAS,VALID
 S PSOFILL=$$FILL(RXIEN,DFN,.PSOFL)
 I $D(DIRUT) G END
 I PSOFILL="" W !!,"No claim was ever submitted for this prescription. Cannot reverse." D PAUSE^VALM1 G END
 S PSOELIG=$$ELIGDISP^PSOREJP1(RXIEN,PSOFILL)
 ; Validate the claim.
 S VALID=$$VAL^BPSPSOU1(RXIEN,PSOFILL,PSOELIG,"REV",.PSOCOB,.REVREAS) ;DBIA #6248
 I 'VALID G END
 I $$RXDEL(RXIEN,PSOFILL) D  D PAUSE^VALM1 G END
 . W !!,"The claim cannot be Reversed since it has been deleted in Pharmacy."
 ; Submit the reversal to ECME
 D ECMESND^PSOBPSU1(RXIEN,PSOFILL,"","OREV","","",REVREAS,"","","","","","","",$G(PSOCOB))
 D PAUSE^VALM1
 S VALMBCK="R"
 Q
 ;
RXDEL(RXIEN,PSOFILL) ; EP - $$ is RX deleted?
 ; For refills:  if the refill multiple is gone, it's been "deleted"
 I $G(PSOFILL),'$P($G(^PSRX(RXIEN,1,PSOFILL,0)),U) Q 1
 ; For first fill: look at the STATUS flag
 I $P($G(^PSRX(RXIEN,0)),U,1)="" Q 1 ; shouldn't be missing but is
 N X S X=$P($G(^PSRX(RXIEN,"STA")),U,1)
 Q X=13 ; if status is DELETED
 ;
END ;
 S VALMBCK="R"
 Q
