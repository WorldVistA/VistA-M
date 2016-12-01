PSOSPML6 ;BIRM/MFR - Unmark Rx Fill as 'Administered in Clinic' ;09/30/13
 ;;7.0;OUTPATIENT PHARMACY;**408,451**;DEC 1997;Build 114
 ;
 N DIR,DIRUT,X,PSOQUIT,RXIEN,RXFILL,BATIEN,STATEIEN
RX ; - Prescription prompt
 K DIR S DIR(0)="FAO^1:30",DIR("A")=" PRESCRIPTION: ",(DIR("?"),DIR("??"))="^D HLP^PSORXVW1"
 W ! D ^DIR I X=""!$D(DIRUT) G EXIT
 S X=$$UP^XLFSTR(X),PSOQUIT=0
 I $E(X,1,2)'="E." S RXIEN=+$$RXLKP(X) I RXIEN<0 G RX
 I $E(X,1,2)="E." D  I PSOQUIT G RX
 . I $L(X)'=9 W !?5,"The ECME# must be 7 digits long!",$C(7) S PSOQUIT=1 Q
 . S RXIEN=+$$RXNUM^PSOBPSU2($E(X,3,9)) I RXIEN<0 W " ??" S PSOQUIT=1
 ;
 S RXFILL=$$RXFILL^PSOSPMU2(RXIEN) I RXFILL="^" G EXIT
 ;
 I '$$ADMCLN^PSOSPMUT(RXIEN,RXFILL) D  G RX
 . W !!," Prescription Fill not marked as 'Administered in Clinic'.",$C(7)
 ;
 W ! K DIR,DTOUT,DUOUT
 S DIR("A")="Unmark prescription fill as 'Administered in Clinic'",DIR("A",2)=""
 S DIR(0)="Y",DIR("B")="N" D ^DIR I $G(DTOUT)!$G(DUOUT)!'Y Q
 ;
 N DIE,DR,DA W !!,"Updating Rx..."
 I 'RXFILL D
 . S DIE="^PSRX(",DA=RXIEN,DR="14///@"
 E  D
 . S DIE="^PSRX("_RXIEN_",1,",DA(1)=RXIEN,DA=RXFILL,DR="23///@"
 D ^DIE H 2 W "done.",$C(7)
 ;
 I '$$RXRLDT^PSOBPSUT(RXIEN,RXFILL) G RX
 ;
 W ! K DIR
 S DIR("A")="Transmit Prescription Fill to the State",DIR(0)="Y",DIR("B")="N"
 D ^DIR I $G(DTOUT)!$G(DUOUT)!'Y G RX
 ;
 S STATEIEN=$$RXSTATE^PSOBPSUT(RXIEN,0)
 K ^TMP("PSOSPMRX",$J) S ^TMP("PSOSPMRX",$J,STATEIEN,RXIEN,RXFILL)="N"
 S BATIEN=$$BLDBAT^PSOSPMU1("RX")
 D EXPORT^PSOSPMUT(BATIEN,"EXPORT")
 ;
 G RX
 ;
EXIT Q
 ;
RXLKP(RXNUM) ; - Peforms Lookup on the PRESCRIPTION file
 N DIC,X,Y,D
 S DIC="^PSRX(",DIC(0)="QE",D="B",X=RXNUM
 D IX^DIC
 Q Y
