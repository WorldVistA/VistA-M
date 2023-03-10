PSOVEXRX ;BIRM/KML - PHARMACY TELEPHONE REFILLS ; 06/07/18 08:47am
 ;;7.0;OUTPATIENT PHARMACY;**653**;Dec 1997;Build 14
 ;
 N QUIT
 S QUIT=0
 D PSOBLD^PSOVEXR1 Q:QUIT 
 D START Q:QUIT
 D SUMM Q:QUIT
 D SETVEN^PSOVEXR1
 I 'PSOCNT,PRINT W !,"No telephone refills were processed."
 Q
 ;
START ;
 N PSOANS,PSOANS2,PSODFN,PSONO,PSONRF,PSONRFLG,PSOPAR,PSOPROVP,PSOPTRAD,PSOREFLG,PSORENEW,PSORXEN,PSORXIEN,PSOREN,PSORFY,PSOVX,PSOXFLAG
 N PSORXN,PSOSITE,PSOISITE,PSOVEXI,PSOCNT,PSOCNT1,PSORSULT,PRINT,LN,PSOTILDE,PSOVEXFL,PSO648,DIR,PSOBBC,PSOBBC1,PSORX,PSOTTREN,PSOTOTF
 K ^TMP($J,"ORAREN E"),^TMP($J,"ORAREN OC"),^TMP("PSOFILLED",$J)
 S (PSOCNT1,PSONRF,PSONRFLG,PSORFY,PSOTTREN,PSOTOTF)=0
 S PSOVX=0 F  S PSOVX=$O(^PS(59,PSOVX)) Q:'PSOVX  I $P($G(^PS(59,PSOVX,"I")),"^"),DT>$P($G(^("I")),"^") S PSOVEXI(PSOVX)=""
 I $O(PSOVEXI(0)) W !,"Looking for refill requests for inactive Outpatient divisions..."
 S PSOVX=0 F  S PSOVX=$O(PSOVEXI(PSOVX)) Q:'PSOVX  D
 . S PSORXN=0 F  S PSORXN=$O(^PS(52.444,"C",PSOVX,PSORXN)) Q:'PSORXN  D
 . . Q:($P(^PS(52.444,PSORXN,0),U,4))  ;Quit if already date processed exists
 . . S PSORXIEN=$P(^PS(52.444,PSORXN,0),"^")
 . . S PSOISITE=$P($G(^PSRX(+PSORXIEN,2)),"^",9) Q:$G(PSOVEXI(+$G(PSOISITE)))
 . . I PSOISITE,$D(PSOVEXI(PSOISITE)),$P(^PS(52.444,PSORXN,0),"^",4)="" S PSOVEXI(PSOVX)=1,PSOVEXFL=1
 I '$G(PSOVEXFL),$O(PSOVEXI(0)) W ".none found.",!
 I $G(PSOVEXFL) W !!,"The following Inactive Outpatient sites have refill requests:",! F PSOVX=0:0 S PSOVX=$O(PSOVEXI(PSOVX)) Q:'PSOVX  I $G(PSOVEXI(PSOVX)) W !?5,$P($G(^PS(59,+$G(PSOVX),0)),"^")
 I $G(PSOVEXFL) W ! S DIR(0)="E",DIR("A")="Press Return to Continue, '^' to exit",DIR("T")=DTIME D ^DIR W ! I Y'=1 S QUIT=1 Q
 D:'$D(PSOPAR) ^PSOLSET I $G(PSOQUIT)!'$D(PSOPAR) S QUIT=1 Q
 W !!!?20,"Division: "_$P(^PS(59,PSOSITE,0),"^"),!!
 S PSOBBC1("FROM")="REFILL",PSOBBC("QFLG")=0,PSOBBC("DFLG")=0
 I '$D(^PS(52.444,"C",PSOSITE)) S PSOANS="N" W !!,"There are no telephone refills to process for the selected division." S QUIT=1 Q
 D ASK^PSOBBC W:PSOBBC("QFLG")=1 !,"No telephone refills were processed." I PSOBBC("QFLG")=1 S QUIT=1 Q
PSOX W ! S DIR("A")="Process telephone refill requests at this time",DIR("B")="YES",DIR(0)="Y",DIR("T")=DTIME D ^DIR K DIR S PSOANS="N" I $G(DIRUT)!(Y=0) S QUIT=1 W !?7,$C(7),"No telephone refills were processed." Q
 S PSORXIEN="" I Y=1 S PSOANS="Y"
 S PSOPTRAD=$$GET1^DIQ(59,PSOSITE,4.2) ;parameter from 59 for all divisions default prompt answer
 S PSOANS2="S" ; initialize the answer to the processing all divisions prompt
 I PSOANS["Y",$$GET1^DIQ(59.7,1,"INTERDIVISIONAL PROCESSING","I") D  I $G(DIRUT) S PSOANS="N" S QUIT=1 W !?7,$C(7),"No telephone refills were processed." Q
 . S DIR("A")="Process telephone refills for all divisions",DIR("B")=PSOPTRAD,DIR(0)="Y",DIR("T")=DTIME
 . W !
 . S DIR("?",1)="Enter 'YES' to process all division refill requests."
 . S DIR("?",2)="Enter 'NO' to only process refill request for the division you selected when you logged on."
 . S DIR("?")=" "
 . D ^DIR K DIR S:Y=1 PSOANS2="M"
 I PSOANS2["S" S PSONO=$D(^PS(52.444,"C",PSOSITE)) I '$G(PSONO) W !,"There are no requests for your selected division." Q
 S PSOCNT1=10  ; use to indicate first time through for mail msg build
 S $P(LN,"-",80)="",PSOCNT=0
PSO6 I PSOANS["Y",$G(PSORXIEN) S PSORXEN=0,PSORXEN=$O(^PS(52.444,"B",PSORXIEN,PSORXEN)) D PSO5 ;MARK PROCESSED NODES
 I PSOANS="N" S PSORX=PSORXIEN D ULK G END
 D PSO3 I $G(PSOANS)="N" S PSORX=PSORXIEN D ULK G END
 I 'PSOSITE W !?7,$C(7),$C(7),$C(7),"Not from this institution.",! S PSORX=PSORXIEN D ULK G PSO6
 I $L(PSORENEW) S PSORENEW="" G PSO6
 S (PSOBBC("IRXN"),PSOBBC("OIRXN"))=PSORXIEN
 I $D(^PSRX(PSOBBC("IRXN"),0))']"" W !,$C(7),"Rx data is not on file!",!  S PSORX=PSORXIEN D ULK G PSO6
 I $P($G(^PSRX(PSOBBC("IRXN"),"STA")),"^")=13 W !,$C(7),"Rx has already been deleted." S PSORX=PSORXIEN D ULK G PSO6
 I $G(PSOBBC("DONE"))[PSOBBC("IRXN")_"," W !,$C(7),"Rx has already been entered." S PSORX=PSORXIEN D ULK G PSO6
 K X,Y D:PSOBBC("QFLG") PROCESSX^PSOBBC
 S PSOSELSE=0 I $G(PSODFN)'=$P(^PSRX(PSOBBC("IRXN"),0),"^",2) S PSOSELSE=1 W !,LN D PT^PSOBBC I $G(PSOBBC("DFLG")) K PSOSELSE S PSORX=PSORXIEN D ULK G PSO6
 I '$G(PSOSELSE) W !,LN D PTC^PSOBBC I $G(PSOBBC("DFLG")) K PSOSELSE S PSORX=PSORXIEN D ULK G PSO6
 K PSOSELSE D PROFILE^PSORX1
 S PSOBBC("DONE")=PSOBBC("IRXN")_"," D REFILL^PSOBBC
 I $$TITRX^PSOUTL(PSOBBC("IRXN"))="t" S PSOBBC("DFLG")=1
 S PSORX=PSORXIEN D ULK G PSO6
 ;
PSO3 ; avoid skipping renewal requests.
 N PSOPP
 K PSOBBC("IRXN"),PSOXFLAG,PSOPP S:'$G(PSORXIEN) PSORXIEN=0 F  S PSORXIEN=$O(^PS(52.444,"B",PSORXIEN)) D  Q:PSOANS="N"!($G(PSOXFLAG))
 . I PSORXIEN="" S PSOANS="N" Q
 . I PSOANS2["S",$D(^PSRX(PSORXIEN,0)),PSOSITE'=$P(^PSRX(PSORXIEN,2),"^",9) Q
 . S PSORXEN=0 F  S PSORXEN=$O(^PS(52.444,"B",PSORXIEN,PSORXEN)) Q:'PSORXEN  D
 . . I $P(^PS(52.444,PSORXEN,0),U,4) S ^TMP("PSOFILLED",$J,PSORXIEN)=""
 . . Q:($P(^PS(52.444,PSORXEN,0),U,4))  ;Quit if date processed exists
 . . S PSOCNT=PSOCNT+1
 . . S PSO648=0,PSOREN=$P(^PS(52.444,PSORXEN,0),U,4,9) I PSOREN]"" D BFDRNCHK
 . . ;CANNOT PROCESS RENEWAL ENTRIES CONTAINING TILDE CHARACTER (~) IN THE FREE TEXT DOSAGE FIELD
 . . I ($P($G(PSOREN),U,3)]"") S PSOTILDE=$$TILDECHK^PSOVEXR1(PSORXIEN,PSORXEN) I +PSOTILDE D PSO7(PSORXIEN,PSOTILDE) K PSOTILDE Q:'$G(DUOUT)  I $G(DUOUT) S PSOANS="N" Q
 . . I '$D(^PSRX(PSORXIEN,0)),PSO648=1 D PSO5 Q  ;SKIPS ERRONEOUS ENTRIES
 . . I PSOANS["Y" Q:PSO648=1  ;SKIPS ENTRIES ALREADY PROCESSED AND FORMATS VARIABLE X (BFD/648 LINE)
 . . D RENEWCHK I PSORENEW]"" S PSOXFLAG=1 Q
 . . I PSORXIEN S PSORX=PSORXIEN D PSOL^PSSLOCK(PSORX) I '$G(PSOMSG) K PSORX,PSOMSG Q
 . . K PSOMSG S PSOXFLAG=1
 I 'PSOCNT W !!,"There are NO telephone refills to process."
 Q
 ; -----------------------------------------------------------------------------------
PSO5 ; Mark the node as processed.
 K FDA,IENS
 S PSORXIEN=$P(^PS(52.444,PSORXEN,0),U)
 I PSOREFLG=0 S IENS=PSORXEN_",",FDA(52.444,IENS,3)=DT D FILE^DIE(,"FDA","PSOERR") D  ;marks node as processed
 . I $G(PSOBBC("DFLG")) D PSO12 ;FLAGS UNSUCCESSFUL ATTEMPTS TO REFILL.
 I PSONRFLG=0,(PSOREFLG=0) S PSORFY=PSORFY+1
 S PSONRFLG=0
 I '$G(PSOBBC("DFLG")),PSORSULT=1  W !,LN,!,"Prescription: RX # "_$P(^PSRX(PSORXIEN,0),U)_" Processed",!
 Q
 ;
PSO7(PSORXIEN,PSOTILDE) ; Add skipped prescriptions due to tilde error to the report
 ; input = PSORXIEN - ien of RX in PRESCRIPTION file (#52)
 ; input = PSOTILDE - string representing the results of Tilde check
 ;                    first piece = 1 or 0; where 1 means it's an RX with a Tilde in the dosage form
 ;                    second piece = 1 or 0; where 1 means it's a controlled substance RX
 ;                    
 N LAST,PSORET,TXT,XX
 ; Tilde RX is a controlled substance 
 I $P(PSOTILDE,"^",2)  D  G PSO7X
 . S LAST=0 I $D(^TMP($J,"ORAREN E")) S LAST=$O(^TMP($J,"ORAREN E",9999),-1)
 . I LAST>0 S LAST=LAST+1,^TMP($J,"ORAREN E",LAST,0)=" "
 . S (TXT(1),^TMP($J,"ORAREN E",LAST+1,0))="RX # "_$P(^PSRX(PSORXIEN,0),U)
 . S (TXT(2),^TMP($J,"ORAREN E",LAST+2,0))="This controlled substance prescription cannot generate a notification to"
 . S (TXT(3),^TMP($J,"ORAREN E",LAST+3,0))="the provider because there is a tilde (~) character in the dosage field. "
 . S (TXT(4),^TMP($J,"ORAREN E",LAST+4,0))="Using CPRS, flag the requested order and ask the provider to correct"
 . S (TXT(5),^TMP($J,"ORAREN E",LAST+5,0))="the order by removing the tilde (~) from the free text dosage using"
 . S (TXT(6),^TMP($J,"ORAREN E",LAST+6,0))="Change or Copy to New Order.  When the corrected order is digitally"
 . S (TXT(7),^TMP($J,"ORAREN E",LAST+7,0))="signed, a Pending order is created for the pharmacy to finish."
 . S (TXT(8),^TMP($J,"ORAREN E",LAST+8,0))=""
 . W !,LN
 . S XX=0 F  S XX=$O(TXT(XX)) Q:XX=""  W !,TXT(XX)
 . W !
 ; Tilde RX not a controlled substance
 S LAST=0 I $D(^TMP($J,"ORAREN E")) S LAST=$O(^TMP($J,"ORAREN E",9999),-1)
 I LAST>0 S LAST=LAST+1,^TMP($J,"ORAREN E",LAST,0)=" "
 S (TXT(1),^TMP($J,"ORAREN E",LAST+1,0))="RX # "_$P(^PSRX(PSORXIEN,0),U)
 S (TXT(2),^TMP($J,"ORAREN E",LAST+2,0))="This prescription cannot be renewed because there is a tilde (~)"
 S (TXT(3),^TMP($J,"ORAREN E",LAST+3,0))="character in the dosage field.  Using CPRS, flag the requested"
 S (TXT(4),^TMP($J,"ORAREN E",LAST+4,0))="order and ask the provider to remove the tilde (~) from the free"
 S (TXT(5),^TMP($J,"ORAREN E",LAST+5,0))="text dosage when Renewing.  After the corrected order is digitally"
 S (TXT(6),^TMP($J,"ORAREN E",LAST+6,0))="signed, a Pending order is created for the pharmacy to finish."
 S (TXT(7),^TMP($J,"ORAREN E",LAST+7,0))=" "
 W !,LN
 S XX=0 F  S XX=$O(TXT(XX)) Q:XX=""  W !,TXT(XX)
PSO7X ;
 S PSOTOTF=$G(PSOTOTF)+1
 W ! S DIR("A")="Enter <RETURN> to continue.",DIR(0)="FO",DIR("T")=DTIME
 S DIR("?")=" ",DIR("?",1)="Answering ""^"" will abort processing and the remaining refills will not"
 S DIR("?",2)="be processed."
 D ^DIR K DIR
 Q
 ;
PSO12 ; refill not processed.
 K FDA,IENS
 S PSONRF=PSONRF+1,PSONRFLG=1
 S IENS=PSORXEN_"," ;NOTE THE IENS MUST HAVE A FINAL COMMA ADDED TO THE ENTRY NUMBER.
 S FDA(52.444,IENS,4)="NOT FILLED" D FILE^DIE(,"FDA","PSOERR")
 W !,"Prescription REFILL, RX # "_$P(^PSRX(PSORXIEN,0),U)_", was not processed. ",!," PLEASE TAKE APPROPRIATE ACTION."
 S DIR("?",1)="Answering YES will continue to process the remaining Telephone Refill"
 S DIR("?",2)="Requests. "
 S DIR("?",3)=""
 S DIR("?",4)="Answering NO will abort processing and the remaining refills will not be"
 S DIR("?")="processed. The option will need to be run again to continue processing."
 W ! S DIR("A")="Do you wish to continue processing the remaining refill requests",DIR("B")="YES",DIR(0)="Y",DIR("T")=DTIME D ^DIR
 W ! K DIR I Y'=1 S PSOANS="N"
 Q
END D PROCESSX^PSOBBC
 K XMY N XMDUZ,XMSUB,XMTEXT,XMT
 S XMDUZ="AUTO,RENEWAL",XMY(DUZ)="",XMY("G.AUTORENEWAL")="",XMSUB=$S($G(PSOANS2)["S":$$GET1^DIQ(59,PSOSITE,.01)_" ",1:"")_"REFILL TOTALS",XMTEXT="XMT("
 S XMT(1,0)="Refills Processed: "_PSORFY,XMT(2,0)="Refills 'Not Processed': "_PSONRF
 S XMT(3,0)=" ",XMT(4,0)="Renewals sent to provider: "_PSOTTREN
 S XMT(5,0)="Renewals not sent to provider: "_PSOTOTF
 D ^XMD
 I $D(^TMP($J)) K XMY N XMDUZ,XMSUB,XMTEXT D
 . S XMY(DUZ)=""
 . I $D(^TMP($J,"ORAREN E")) S XMDUZ="AUTO,RENEWAL",XMY("G.AUTORENEWAL")="",XMSUB=$S($G(PSOANS2)["S":$$GET1^DIQ(59,PSOSITE,.01)_" ",1:"")_"RENEWAL REQUESTS NOT SENT TO PROVIDERS",XMTEXT="^TMP("_$J_",""ORAREN E""," D ^XMD
 . I $D(^TMP($J,"ORAREN OC")) S XMDUZ="AUTO,RENEWAL",XMY("G.AUTORENEWAL")="",XMSUB=$S($G(PSOANS2)["S":$$GET1^DIQ(59,PSOSITE,.01)_" ",1:"")_"RENEWAL REQUESTS WITH ORDER CHECKS",XMTEXT="^TMP("_$J_",""ORAREN OC""," D ^XMD
 I $P($G(^PS(59,+$G(PSOSITE),"I")),"^"),DT>$P($G(^("I")),"^") D FINAL^PSOLSET W !!,"Your Outpatient Site parameters have been deleted because you selected an",!,"inactive Outpatient Site!",!
 K DIR,DIRUT,DUOUT,PSOBBC,PSOBBC1
 Q
ULK ; unlock a record.
 N SAVE
 I '$G(PSORX) Q
 D PSOUL^PSSLOCK(PSORX)
 M SAVE=PSORX
 K PSORX
 S PSORX("FILL DATE")=$G(SAVE("FILL DATE")),PSORX("MAIL/WINDOW")=$G(SAVE("MAIL/WINDOW")),PSORX("METHOD OF PICK-UP")=$G(SAVE("METHOD OF PICK-UP"))
 Q
 ; -----------------------------------------------------------------------------------
RENEWCHK ; Checks ^PS(52.444 node for renewal information
 K FDA,IENS
 S (PSOREFLG,PSORSULT)=0
 S PSORENEW=$P(PSOREN,"^",3),PSOPROVP=$P(PSOREN,"^",6)
 I PSORENEW="U"!(PSORENEW="I")!(PSORENEW="N") D
 . S PSORXIEN=+$P(^PS(52.444,PSORXEN,0),U),PSODFN=+$P(^PS(52.444,PSORXEN,0),U,3)
 . D RENEW^ORAREN(.PSORSULT,PSODFN,PSORXIEN,PSOPROVP,PSORENEW) ;ICR 5498
 . S PSOREFLG=1
 . S IENS=PSORXEN_",",FDA(52.444,IENS,3)=DT D FILE^DIE(,"FDA","PSOERR") ;marks node as processed
 . S IENS=PSORXEN_",",FDA(52.444,IENS,6)=PSORSULT D FILE^DIE(,"FDA","PSOERR")  ;marks the result from RENEW^ORAREN processing 
 . I PSORSULT=0 S PSOCNT1=PSOCNT1+1
 . I PSORSULT'=1 S PSOTOTF=PSOTOTF+1 W !,LN,!,$C(7),"Prescription Renewal Request, RX # "_$P(^PSRX(PSORXIEN,0),U)_", was not sent to the provider. ",!," PLEASE TAKE APPROPRIATE ACTION."
 . I PSORSULT=1 S PSOTTREN=PSOTTREN+1
 . Q
 Q
BFDRNCHK ; There is data in global - is it date or renewal request
 ;"if there is something in the Date piece S PSO648=1 to stop processing"
 I $P(PSOREN,"^",1)]"" S PSO648=1
 ;if there are more than just piece 1 but the 
 I $P(PSOREN,"^",1)']"" S PSO648=0
 ;"if PSO648 is 0 then no date but renewal"
 Q
 ;
SUMM ;  display summary of refills processed
 S DIR("A")="Display the full summary of individual orders processed"
 s DIR("B")="NO",DIR(0)="Y"
 S DIR("?",1)="Enter 'YES' to display the summary of orders processed in this session."
 S DIR("?",2)="Enter 'NO' to not display the summary."
 S DIR("?")=" "
 D ^DIR K DIR
 I $G(DIRUT) S QUIT=1 Q
 S PRINT=$S(+Y=1:1,1:0)
 I PRINT W !!!,"TELEPHONE REFILL/RENEW SUMMARY",!!
 Q
