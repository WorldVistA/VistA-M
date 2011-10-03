PRCFDPVU ;WISC/LEM-PAYMENT ERROR PROCESSING CON'T ;9/7/94  15:20
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 QUIT
 ; No top level entry
NUM S PONUM=$G(GECSDATA(2100.1,GECSDATA,.01,"E"))
 ;S PONUM=$P(PONUM,"-",2),PATNUM=$E(PONUM,4,9),SITE=$E(PONUM,1,3)
 ;S PARTIAL=$E(PONUM,10,11),PARTIAL=$$STRIP(PARTIAL)
 ;I PARTIAL?1N.N S PARTIAL=+PARTIAL
 ;S PONUM=SITE_"-"_PATNUM
 S PONUM=$$STRIP(PONUM)
 Q
GET(DIC,X) ; Get Certified Invoice information for review
 ;
 ;S X=$P($G(GECSDATA(2100.1,GECSDATA,.01,"E")),"-",2) Q:X=""
 S X=$P($G(X),"-",2) Q:X=""
 ;
 ;STOP HERE AND CHECK
 K Y S DIC(0)="Z",D="F" D IX^DIC K DIC
 Q
STRIP(X) ; Strip trailing spaces
 F LOOP=$L(X):-1:1 Q:$E(X,LOOP)'=" "
 S VAR=$E(X,1,LOOP)
 Q VAR
PAUSE ; Pause screen when data is displayed
 W !!,"Press 'RETURN' to continue: " R X:DTIME
 I $D(IOF) W @IOF
 Q
PAUSE1 ; Pause screen when data is displayed
 W !!,"Press 'RETURN' to start the display" R X:DTIME
 I $D(IOF) W @IOF
 Q
REVIEW() ; Prompt user to review source document
 S DIR(0)="Y",DIR("B")="YES"
 S DIR("A")="Do you wish to display the source document"
 S DIR("?")="Enter 'NO' or 'N' or '^' if the display is not necessary."
 S DIR("?",1)="Enter 'YES' or 'Y' or 'RETURN' to display the source document."
 D ^DIR K DIR S RESP=Y
 I $D(Y(0)) S $P(RESP,U,2)=Y(0)
 I $D(DIRUT) S $P(RESP,U,3)=DIRUT
 Q RESP
RETRANS() ; Prompt user to rebuild FMS doc from source doc and retransmit
 S DIR(0)="Y",DIR("B")="YES"
 S DIR("A")="Do you wish to rebuild and retransmit this FMS document"
 S DIR("?")="Enter 'NO' or 'N' or '^' to exit."
 S DIR("?",1)="Enter 'YES' or 'Y' or 'RETURN' to rebuild/retransmit this document."
 D ^DIR K DIR S RETRAN=Y
 I $D(Y(0)) S $P(RETRAN,U,2)=Y(0)
 I $D(DIRUT) S $P(RETRAN,U,3)=DIRUT
 Q RETRAN
