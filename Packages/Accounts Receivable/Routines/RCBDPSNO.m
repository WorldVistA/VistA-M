RCBDPSNO ;WISC/RFJ-patient statement (remove transaction) ;1 Mar 01
 ;;4.5;Accounts Receivable;**169**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;
COMMENT ;  remove a comment transaction from a patient statement
 N DATA1,DATE,RCDATE,RCDEBTDA,RCEVENDA,RCTRANDA
 ;
 F  D  Q:'RCDEBTDA
 .   W !! S RCDEBTDA=$$SELACCT^RCDPAPLM
 .   I RCDEBTDA<1 S RCDEBTDA=0 Q
 .   ;
 .   ;  build a list of the comments for the account
 .   ;  get the last event (patient statement) entry
 .   S RCEVENDA=$$LASTEVNT^RCBDFST1(RCDEBTDA)
 .   ;
 .   W !!,"The following is a list of comment transactions since last statement date."
 .   S DATE=+$P(RCEVENDA,"^",2) I DATE S DATE=$E(DATE,4,5)_"/"_$E(DATE,6,7)_"/"_$E(DATE,2,3)
 .   W !,"Last Statement Date: ",DATE,!
 .   ;
 .   ;  build list of comment transactions since statement date
 .   K ^TMP("RCBDPSNO",$J)
 .   S RCDATE=+$P(RCEVENDA,"^",2)
 .   F  S RCDATE=$O(^PRCA(433,"ATD",RCDEBTDA,RCDATE)) Q:'RCDATE  D
 .   .   S RCTRANDA=0 F  S RCTRANDA=$O(^PRCA(433,"ATD",RCDEBTDA,RCDATE,RCTRANDA)) Q:'RCTRANDA  D
 .   .   .   ;  if transaction not a comment, quit
 .   .   .   S DATA1=$G(^PRCA(433,RCTRANDA,1))
 .   .   .   I $P(DATA1,"^",2)'=45 Q
 .   .   .   W !?2,"Transaction: ",RCTRANDA
 .   .   .   W ?25," bill: ",$P($P($G(^PRCA(430,+$P(^PRCA(433,RCTRANDA,0),"^",2),0)),"^"),"-",2)
 .   .   .   W ?42," date: ",$E(RCDATE,4,5),"/",$E(RCDATE,6,7),"/",$E(RCDATE,2,3)
 .   .   .   W ?60," ",$S($P($G(^PRCA(433,RCTRANDA,0)),"^",10):"***** OFF STATEMENT *****",1:"")
 .   .   .   W !?5,"1st Line: ",$E($G(^PRCA(433,RCTRANDA,7,1,0)),1,64)
 .   .   .   ;  store for lookup
 .   .   .   S ^TMP("RCBDPSNO",$J,RCTRANDA)=""
 .   ;
 .   I '$O(^TMP("RCBDPSNO",$J,0)) W !,"Account does not have any comment transactions." Q
 .   ;
 .   F  D  Q:RCTRANDA<1
 .   .   ;  select comment transaction
 .   .   S RCTRANDA=$$ASKTRAN I RCTRANDA<1 Q
 .   .   ;
 .   .   ;  ask to remove or add a comment transaction to patient statement
 .   .   S RCTRANDA=$$ADDREM(RCTRANDA)
 Q
 ;
 ;
ASKTRAN() ;  ask to select the comment transaction
 N DIR,DIQ2,DIRUT,DTOUT,DUOUT,X,Y
 S DIR(0)="NAO^"_$O(^TMP("RCBDPSNO",$J,0))_":"_$O(^TMP("RCBDPSNO",$J,9999999999),-1)_":0"
 S DIR("A")="  Select COMMENT Transaction: "
 S DIR("S")="I $D(^TMP(""RCBDPSNO"",$J,Y))"
 W ! D ^DIR
 I $G(DTOUT)!($G(DUOUT)) S Y=-1
 Q Y
 ;
 ;
ADDREM(RCTRANDA) ;  ask to add or remove from patient statement
 N DIR,DIQ2,DIRUT,DTOUT,DUOUT,RESULT,X,Y
 S DIR(0)="YO",DIR("B")="NO"
 S RESULT=$P($G(^PRCA(433,RCTRANDA,0)),"^",10)
 W !,"  The comment transaction is currently ",$S(RESULT:"OFF",1:"ON")," the patient statement."
 S DIR("A")="  Would you like to "_$S(RESULT:"ADD it to",1:"REMOVE it from")_" the patient statement "
 D ^DIR
 I $G(DTOUT)!($G(DUOUT)) Q 0
 ;
 I Y=1 D  Q 1
 .   S Y=$$EDIT433^RCBEUTRA(RCTRANDA,"10///"_$S(RESULT=1:"@",1:1)_";")
 .   S RESULT=$P($G(^PRCA(433,RCTRANDA,0)),"^",10)
 .   W !,"  Comment Transaction is now ",$S(RESULT:"OFF",1:"ON")," the patient statement."
 ;
 W !,"  No change, comment transaction remains ",$S(RESULT:"OFF",1:"ON")," the patient statement."
 Q 1
