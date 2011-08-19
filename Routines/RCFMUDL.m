RCFMUDL ;WASH-ISC@ALTOONA,PA/RB-UNPROCESSED DOCUMENT LIST ;11/10/94  1:55 PM
V ;;4.5;Accounts Receivable;;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
EN ;Entry point from UDLIST^PRCABJ1
 N DCDT S DCDT=1 I $G(IOP)="" S IOP=RCFMDEV
EN2 ;Entry point from Unprocessed Document List option
 N BY,DHD,DIC,DIS,FLDS,FR,L,TO
 S DIC=347,BY="@.03"_$S($G(DCDT)="":",@.05;""DOCUMENT DATE""",1:"")
 S (FR,TO)=$S($G(DCDT)="":",?",1:""),L=0
 S FLDS="[PRCA FMS UNPROCESSED LIST]"
 S DIS(0)="I $P(^RC(347,D0,0),""^"",3)'=2"
 I $G(DCDT) S DIS(1)="I +$$DAYS^RCFMUDL($P(^RC(347,D0,0),""^"",5))'<3"
 S DHD="FMS UNPROCESSED DOCUMENT LIST" D EN1^DIP,^%ZISC Q
 ;
DAYS(Z) ;Determines no. of days since document has been updated
 N X1,X2,Y I $G(Z)="" S Y="" Q Y
 S X1=DT,X2=Z D ^%DTC S Y=X Q Y
