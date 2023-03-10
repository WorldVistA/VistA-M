PXVTRAN ;ISP/LMT - Transfer Vaccine Inventory Between Facilities ;Dec 03, 2018@15:13:49
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**217**;Aug 12, 1996;Build 134
 ;
 ;
EN(PXINST,PXTITLE) ;
 ;
 N PXADD,PXCONF,PXEXIT,PXVAC,PXQTY,PXTO
 ;
 I '$O(^AUTTIML("AF",PXINST,0)) D  Q
 . W $C(7),!!,"There are no vaccine lots in the transferring facility.",!!
 . H 1
 ;
 F  D  Q:$G(PXEXIT)
 . W @IOF,?10,"Transfer Vaccine Inventory From "_PXTITLE,!
 . S PXVAC=$$VAC(PXINST)
 . I PXVAC<1 S PXEXIT=1 Q
 . S PXQTY=$$QTY(PXVAC)
 . I PXQTY=0 W ! Q
 . I PXQTY<0 S PXEXIT=1 Q
 . S PXTO=$$TO(PXINST)
 . I PXTO=0 W ! Q
 . I PXTO<0 S PXEXIT=1 Q
 . S PXADD=$$ADDCHK(PXVAC,PXTO)
 . I PXADD=0 W ! Q
 . I PXADD<0 S PXEXIT=1 Q
 . S PXCONF=$$CONF(PXVAC,PXQTY,PXINST,PXTO)
 . I PXCONF=0 W ! Q
 . I PXCONF<0 S PXEXIT=1 Q
 . D TRAN(PXVAC,PXQTY,PXTO,PXADD)
 ;
 Q
 ;
VAC(PXINST) ;
 ;
 N DIC,DIDIC,DINUM,DLAYGO,X,Y,PXVAC,DTOUT,DUOUT
 ;
 S PXVAC=""
 ;
 W !
 S DIC("S")="I $P(^(0),""^"",10)="_PXINST_"&($P(^(0),""^"",9)'<DT)&('$P(^(0),""^"",3))"
 S DIC(0)="AEMQ"
 S DIC="^AUTTIML("
 D ^DIC
 I $D(DTOUT)!($D(DUOUT)) Q -1
 I Y<1 Q 0
 ;
 S PXVAC=+Y
 Q PXVAC
 ;
QTY(PXVAC) ;
 ;
 N DIR,X,Y,PXBAL,PXQTY,DTOUT,DUOUT
 ;
 S PXBAL=$P($G(^AUTTIML(PXVAC,0)),U,12)
 ;
 I PXBAL'>0 D  Q 0
 . W $C(7),!!,"This vaccine lot has a "_$S(PXBAL=0:"zero",1:"negative")_" balance."
 . W !,"Select another vaccine lot to transfer.",!
 . H 2
 ;
 W !!,?5,"Current Balance: "_PXBAL,!
 S DIR(0)="NO^1:"_PXBAL_":0"
 S DIR("A")="Enter Quantity to Transfer"
 S DIR("?",1)="Enter a whole number between 1 and "_PXBAL_"."
 S DIR("?")="This is the number of doses to transfer."
 D ^DIR
 I $D(DTOUT)!($D(DUOUT)) Q -1
 I Y<1 Q 0
 S PXQTY=+Y
 Q PXQTY
 ;
TO(PXINST) ;
 ;
 N DIR,X,Y,PXTO,DTOUT,DUOUT
 ;
 ;S DIR(0)="9999999.41,.1"
 S DIR(0)="P^4:AEQM"
 S DIR("A")="Enter the facility name or station number"
 S DIR("S")="I Y'="_PXINST
 S DIR("?")="Enter the facility that will be receiving the vaccines."
 D ^DIR
 ;
 I $D(DTOUT)!($D(DUOUT)) Q -1
 I Y<1 Q 0
 ;
 S PXTO=+Y
 Q PXTO
 ;
ADDCHK(PXVAC,PXTO) ;
 ;
 N DIR,X,Y,PXLN,PXVIM,PXMAN,PXVACTO,DTOUT,DUOUT
 ;
 S PXLN=$P($G(^AUTTIML(PXVAC,0)),U,1)
 S PXVIM=$P($G(^AUTTIML(PXVAC,0)),U,4)
 S PXMAN=$P($G(^AUTTIML(PXVAC,0)),U,2)
 I PXVIM=""!(PXMAN="") Q -1
 S PXVACTO=$O(^AUTTIML("AC",PXVIM,PXMAN,PXLN_"_#"_PXTO,0))
 I PXVACTO Q "0^"_PXVACTO
 ;
 W $C(7),!!,$P($$NS^XUAF4(PXTO),U)_" does not currently stock this lot!",!
 S DIR(0)="Y"
 S DIR("A")="Do you want to continue"
 S DIR("?",1)="Answer 'YES' to add this vaccine lot to the receiving facility."
 S DIR("?")="Answer 'NO' to quit this transfer request."
 D ^DIR
 I $D(DTOUT)!($D(DUOUT)) Q -1
 I Y<1 Q 0
 Q +Y
 ;
CONF(PXVAC,PXQTY,PXINST,PXTO) ;
 ;
 N DIR,X,Y,PXLINE,PXLN,PXVIM,PXMAN,PXX,DTOUT,DUOUT
 ;
 S PXLN=$P($G(^AUTTIML(PXVAC,0)),U,1)
 S PXVIM=$$GET1^DIQ(9999999.41,PXVAC_",",.04)
 S PXMAN=$$GET1^DIQ(9999999.41,PXVAC_",",.02)
 ;
 S $P(PXLINE,"-",80)=""
 W @IOF,!,PXLINE
 W !,PXVIM
 W !,"Manufacturer: "_PXMAN
 W !,"Lot: "_PXLN
 W !,"Exp Date: "_$$FMTE^XLFDT($P($G(^AUTTIML(PXVAC,0)),U,9),"5D")
 W !!,"Transferring: "_PXQTY_" (Doses)"
 S PXX=$$NS^XUAF4(PXINST)
 W !!,"From: "_$P(PXX,U)_" ("_$P(PXX,U,2)_")"
 S PXX=$$NS^XUAF4(PXTO)
 W !,"To  : "_$P(PXX,U)_" ("_$P(PXX,U,2)_")"
 W !,PXLINE,!
 S DIR(0)="Y"
 S DIR("A")="OK to post"
 S DIR("B")="Yes"
 S DIR("?")="Answer 'YES' to post this transfer, 'NO' to quit."
 D ^DIR
 I $D(DTOUT)!($D(DUOUT)) Q -1
 I Y<1 Q 0
 Q +Y
 ;
TRAN(PXVAC,PXQTY,PXTO,PXADD) ;
 ;
 N PXFQTY,PXTQTY,PXVACTO,PXFDA
 ;
 W !!,"Updating vaccine on-hand balances now..."
 ;
 S PXFQTY=$P($G(^AUTTIML(PXVAC,0)),U,12)-PXQTY
 I PXFQTY<0 S PXFQTY=0
 S PXFDA(9999999.41,PXVAC_",",.12)=PXFQTY
 I PXADD D ADD(PXVAC,PXQTY,PXTO)
 I 'PXADD D
 . S PXVACTO=$P(PXADD,U,2)
 . S PXTQTY=$P($G(^AUTTIML(PXVACTO,0)),U,12)+PXQTY
 . S PXFDA(9999999.41,PXVACTO_",",.12)=PXTQTY
 ;
 D FILE^DIE("","PXFDA","PXERR")
 ;
 W !,"Done!",!
 H 1
 ;
 Q
 ;
ADD(PXVAC,PXQTY,PXTO) ;
 ;
 N PXNODE,PXIENS,PXFDA
 ;
 S PXNODE=$G(^AUTTIML(PXVAC,0))
 S PXIENS="+1,"
 S PXFDA(1,9999999.41,PXIENS,.01)=$P(PXNODE,U,1)
 S PXFDA(1,9999999.41,PXIENS,.02)=$P(PXNODE,U,2)
 S PXFDA(1,9999999.41,PXIENS,.03)=$P(PXNODE,U,3)
 S PXFDA(1,9999999.41,PXIENS,.04)=$P(PXNODE,U,4)
 S PXFDA(1,9999999.41,PXIENS,.09)=$P(PXNODE,U,9)
 S PXFDA(1,9999999.41,PXIENS,.1)=PXTO
 S PXFDA(1,9999999.41,PXIENS,.11)=PXQTY
 S PXFDA(1,9999999.41,PXIENS,.12)=PXQTY
 S PXFDA(1,9999999.41,PXIENS,.15)=$P(PXNODE,U,15)
 S PXFDA(1,9999999.41,PXIENS,.18)=$P(PXNODE,U,18)
 ;
 D UPDATE^DIE("U","PXFDA(1)")
 ;
 Q
