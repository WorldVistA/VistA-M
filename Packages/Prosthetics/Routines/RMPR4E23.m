RMPR4E23 ;HINES CIOFO/TH - PROMPT FOR SHIPMENT DATE ;08/05/03
 ;;3.0;PROSTHETICS;**78,114,118**;Feb 09, 1996
 ;
 ;TH 08/05/03 Patch #78 - Add shipment date.
 ;                      - DBIA #3427
 ;
 ; RMIFCAP = IFCAP Order
 ; RMPRTRDT = Transaction Date from file #440.6
 ; RMPRSHIP = Shipment Date
 ;
 S (RMIFCAP,RMPRTRDT,RMPRSHIP)=""
 ; Set default to today's date
 S RMPRTRDT=DT
 I $D(^RMPR(664,RMPRA)) D
 . Q:'$D(^RMPR(664,RMPRA,4))
 . S RMIFCAP=$P(^RMPR(664,RMPRA,4),U,6) Q:RMIFCAP=""
 . I $D(^PRCH(440.6,"PO",RMIFCAP)) D
 . . S D1="",D1=$O(^PRCH(440.6,"PO",RMIFCAP,D1),-1) Q:D1=""
 . . Q:'$D(^PRCH(440.6,D1,0))
 . . S RMPRTRDT=$$GET1^DIQ(440.6,D1,6,"I")
 S RMPRTRDT=$$FMTE^XLFDT(RMPRTRDT,"2D")
 D GETDT,BILL,EXIT
 Q
 ;
GETDT ; DIR call to obtain the shipment date
 Q:$G(DA)=""
 I $G(SKPSHDT)=1 D  G GETDT1  ;SKPSHDT set in RMPR4E21 to auto set ship date to trans date
 . S RMPRSHIP=DT
 . I RMPRTRDT'="" S X=RMPRTRDT K %DT D ^%DT S RMPRSHIP=Y
 K DIR,DIRUT
 S DIR(0)="D",DIR("A")="Shipment Date",DIR("B")=$G(RMPRTRDT)
 S DIR("?")="The date that the item shipped to the patient. The default"
 S DIR("?")=DIR("?")_" date would be the transaction date from IFCAP."
 D ^DIR
 S RMPRSHIP=Y
GETDT1 G:'$D(^RMPR(660,DA)) EXIT
 G:RMPRSHIP="" EXIT
 ; Shipment Date/Date of Service filed in file #660.
 I DA'="" S $P(^RMPR(660,DA,1),U,8)=RMPRSHIP
 Q
 ;
BILL ; File to #660.5 - ready to bill
 Q  ; taken out for phase II Billing Aware (WLC 02/26/04)
 N DIC,X,DLAYGO,DIR
 S DIC="^RMPR(660.5,"
 S DIC(0)="L",X="""N"""
 S DLAYGO=660.5 D ^DIC K DLAYGO Q:Y<1
 S RMPRO=+Y,DIE=DIC
 ;
 L +^RMPR(660.5,RMPRO)
 ; .01-Transaction Date; 2-Send Required; .02-Shipment Date
 ; 3-ProsFile(pointer to file #660)
 S DR=".01////^S X=DT;2////1;.02////^S X=RMPRSHIP;3////^S X=DA"
 D ^DIE
 L -^RMPR(660.5,RMPRO)
 Q
 ;
EXIT ; Exit
 K DA,DIC,DIE,DR,RMIFCAP,RMPRTRDT,RMPRSHIP
 Q
