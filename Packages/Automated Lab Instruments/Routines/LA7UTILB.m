LA7UTILB ;DALOI/JMC - Reprocess Lab HL7 Incoming Messages ;July 22, 2008
 ;;5.2;AUTOMATED LAB INSTRUMENTS;**74**;Sep 27, 1994;Build 229
 ;
EN ; Select a Lab HL7 message to reprocess.
 N DIC,DIR,DIROUT,DIRUT,DTOUT,FDA,LA7DIE,LA76248,LA7I,LA7LIST,LA7X,PARAM,X,Y
 ;
 S PARAM("SHOIDS")=$$GET^XPAR("USR^SYS","LA7UTILA SHOIDS",1,"Q")
 S PARAM("SHOIDS LAST")=$$GET^XPAR("USR^SYS","LA7UTILA SHOIDS LAST",1,"Q")
 S X=PARAM("SHOIDS")
 I X="L" S X=PARAM("SHOIDS LAST")
 I X="" S X=PARAM("SHOIDS")
 I X="" S X=1
 I X'=+X S X=$S(X="Y":1,X="N":0,1:1)
 K PARAM
 S DIR("B")=$S(X:"YES",1:"NO")
 S DIR(0)="Y",DIR("A")="Display identifiers during message selection"
 D ^DIR
 I $D(DIRUT) Q
 I Y<1 S DIC("W")="D DICW^LA7UTILA"
 ; save PARAM setting
 D EN^XPAR("USR","LA7UTILA SHOIDS LAST",1,$S(+Y>0:1,1:0))
 S DIC="^LAHM(62.49,",DIC("S")="I $$DICS^LA7UTILB(Y)"
 S DIC(0)="EQMZ"
 S X=$$SELECT^LRUTIL(.DIC,.LA7LIST,"Message",10,0,1,1)
 ;
 K DIC,DIR
 I '$O(LA7LIST(0)) D CHECKQ Q
 ; Confirm selection
 S DIR(0)="YO",DIR("A")="Reprocess these messages",DIR("B")="YES"
 D ^DIR
 I Y'=1 Q
 D SETSTAT,TASK
 Q
 ;
 ;
SETSTAT ; Set status of selected messages to queued for processing
 S LA7I=0
 F  S LA7I=$O(LA7LIST(LA7I)) Q:'LA7I  D
 . K FDA,LRDIE
 . S FDA(1,62.49,LA7I_",",2)="Q"
 . D FILE^DIE("","FDA(1)","LA7DIE(1)")
 . S LA76248=$P($G(^LAHM(62.49,LA7I,.5)),"^")
 . I LA76248 S LA76248(LA76248)=""
 ;
 Q
 ;
 ;
TASK ; Task processing routine for each message's respective configuration
 S LA76248=0
 F  S LA76248=$O(LA76248(LA76248)) Q:'LA76248  D
 . S LA7X=$P($G(^LAHM(62.48,LA76248,0)),"^")
 . I $G(^LAHM(62.48,LA76248,1))'="" X ^(1) D EN^DDIOL("Queued processing routine for configuration "_LA7X,"","!") Q
 . D EN^DDIOL($C(7)_"Unable to queue processing routine for configuration "_LA7X_" - No processing routine","","!")
 ;
 Q
 ;
 ;
CHECKQ ; Check "IQ" incoming queued for processing queues in case need to restart.
 N DIR,DIRUT,DTOUT,DUOUT,LA76248,LA7CNT,LA7I,LA7J,LA7K
 S (LA7I,LA7J)=0
 F  S LA7I=$O(^LAHM(62.48,LA7I)) Q:LA7I<1  D
 . I '$P(^LAHM(62.48,LA7I,0),"^",3) Q
 . I '$D(^LAHM(62.49,"Q",LA7I,"IQ")) Q
 . S (LA7CNT,LA7K)=0
 . F  S LA7K=$O(^LAHM(62.49,"Q",LA7I,"IQ",LA7K)) Q:LA7K<1  S LA7CNT=LA7CNT+1
 . S LA7J=LA7J+1,LA7J(LA7J)=LA7I,DIR("A",LA7J)=LA7J_"  "_$P(^LAHM(62.48,LA7I,0),"^")_" (Queue size: "_LA7CNT_")"
 I '$O(LA7J(0)) Q
 W !!
 S DIR(0)="LO^1:"_LA7J
 S DIR("A")="Select the number(s) of the configurations to restart"
 S DIR("A",.1)="The following configurations have messages queued for processing:",DIR("A",.2)=" ",DIR("A",LA7J+1)=" "
 D ^DIR
 I $D(DIRUT) Q
 S LA7I=0
 F LA7I=1:1 S LA7J=$P(Y,",",LA7I) Q:LA7J<1  S LA76248(LA7J(LA7J))=""
 I $D(LA76248) D TASK
 Q
 ;
 ;
DICS(DA) ; Perform FileMan DIC screen on lookup
 ; Call with DA = IEN of entry in file #62.49
 ; Returns LA7Y = 1 if entry should be selected
 ;              = 0 if not selectable
 ; Entry should be type (I)ncoming, have a status of (X)purgable, (E)rror or (Q)ueued for processing and
 ; be related to an message configuration type 1-UI or 10-LEDI.
 ; Messages for other configuration types should not be reprocessed at this time.
 N LA7I,LA7X,LA7Y
 S LA7I(0)=$G(^LAHM(62.49,DA,0)),LA7Y=0
 I $P(LA7I(0),"^",2)="I",$P(LA7I(0),"^",3)?1(1"X",1"E",1"Q") D
 . S LA7X=$P($G(^LAHM(62.49,DA,.5)),"^"),LA7X(0)=$G(^LAHM(62.48,LA7X,0))
 . I $P(LA7X(0),"^",9)>0,$P(LA7X(0),"^",9)<11 S LA7Y=1
 Q LA7Y
