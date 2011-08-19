LRBARCFA ;DALOI/JMC - Lab Label Zebra Configuration Utility ;8/29/94  12:36
 ;;5.2;LAB SERVICE;**218**;Sep 27, 1994
 ;
EN ;
 N DA,DIR,DIRUT,DTOUT,DUOUT,LRY,X,Y
 D ZIS
 I POP D END Q
 D USE^%ZISUTL("LRHOME")
 S DIR(0)="SO^1:Configuration Update;2:Print Configuration Label;3:Adjust Tear Off Position;4:Label Top Position;5:Set Darkness;6:Mode Protection (Stripe printers only)"
 S DIR("A")="Select Function",DIR("B")=1
 D ^DIR
 I $D(DIRUT) D END Q
 S LRY=+Y
 I LRY=1 D CU
 I LRY=2 D CFL
 I LRY=3 D TA
 I LRY=4 D LT
 I LRY=5 D SD
 I LRY=6 D MP
 D END
 Q
 ;
CU ; Zebra Configuration Update.
 N LRY,DIR,DIRUT,DTOUT,DUOUT,X,Y
 S DIR(0)="SO^F:Reload Factory Defaults;R:Recall Last Saved Values;S:Save Current Settings"
 D USE^%ZISUTL("LRHOME")
 D ^DIR Q:$D(DIRUT)
 S LRY=Y
 D USE^%ZISUTL("LRLABEL")
 W "^XA^JU"_LRY_"^XZ" ; Set configuration update.
 D CFL
 Q
 ;
CFL ; Print Zebra Configuration Label.
 D USE^%ZISUTL("LRLABEL")
 W "~WC" ; Print configuration label.
 D USE^%ZISUTL("LRHOME")
 Q
 ;
TA ; Zebra Tear Off Adjust Position.
 N LRY,DIR,DIRUT,DTOUT,DUOUT,X,Y
 S DIR(0)="NAO^-64:64:0",DIR("A")="Number of dots to adjust (Range -64 to +64): "
 F  D  Q:$D(DIRUT)
 . D USE^%ZISUTL("LRHOME")
 . D ^DIR Q:$D(DIRUT)
 . S LRY=+Y
 . I LRY<0 S LRY="-"_$$RJ^XLFSTR($P(LRY,"-",2),2,"0")
 . E  S LRY="+"_$$RJ^XLFSTR(LRY,2,"0")
 . D USE^%ZISUTL("LRLABEL")
 . W "^XA~TA"_LRY_"^XZ^XA^JUS^XZ" ; Set tear off and save configuration
 . D CFL
 Q
 ;
LT ; Zebra Label Top Position adjustment
 N LRY,DIR,DIRUT,DTOUT,DUOUT,X,Y
 S DIR(0)="NAO^-64:64:0",DIR("A")="Number of dots to adjust (Range -64 to +64): "
 F  D  Q:$D(DIRUT)
 . D USE^%ZISUTL("LRHOME")
 . D ^DIR Q:$D(DIRUT)
 . S LRY=+Y
 . I LRY<0 S LRY="-"_$$RJ^XLFSTR($P(LRY,"-",2),2,"0")
 . E  S LRY="+"_$$RJ^XLFSTR(LRY,2,"0")
 . D USE^%ZISUTL("LRLABEL")
 . W "^XA^LT"_LRY_"^XZ^XA^JUS^XZ" ; Set label top and save configuration
 . D CFL
 Q
 ;
SD ; Zebra Set Darkness adjustment
 N LRY,DIR,DIRUT,DTOUT,DUOUT,X,Y
 S DIR(0)="NAO^0:30:0",DIR("A")="Number of dots to adjust (Range 0 to 30): "
 F  D  Q:$D(DIRUT)
 . D USE^%ZISUTL("LRHOME")
 . D ^DIR Q:$D(DIRUT)
 . S LRY=+Y
 . S LRY=$$RJ^XLFSTR(LRY,2,"0")
 . D USE^%ZISUTL("LRLABEL")
 . W "^XA~SD"_LRY_"^XZ^XA^JUS^XZ" ; Set darkness and save configuration
 . D CFL
 Q
 ;
MP ; Zebra Mode Protection (only applies to Stripe printers).
 N LRY,DIR,DIRUT,DTOUT,DUOUT,X,Y
 S DIR(0)="SO^E:Enable All Modes;D:Disable Darkness;P:Disable Position;C:Disable Calibration;S:Disable Save Permanent;W:Disable Pause Key;F:Disable Feed Key;X:Disable Cancel Key;M:Disable Menu Changes"
 S DIR("A")="Select Mode to Change"
 D USE^%ZISUTL("LRHOME")
 D ^DIR Q:$D(DIRUT)
 S LRY=Y
 D USE^%ZISUTL("LRLABEL")
 W "^XA^MP"_LRY_"^XZ" ; Set mode protection.
 D CFL
 Q
 ;
ZIS ; Device selection
 D OPEN^%ZISUTL("LRHOME","HOME") ; Setup handle for user's "HOME" device.
 S %ZIS="0",%ZIS("A")="Select ZEBRA Printer: ",%ZIS("B")=""
 S %ZIS("S")="N LRY S LRY=$O(^LAB(69.9,1,3.6,""B"",Y,0)) I LRY,$P($G(^LAB(69.9,1,3.6,LRY,0)),U,2)=2"
 D OPEN^%ZISUTL("LRLABEL",,.%ZIS) ; Setup handle for user's LABEL device.
 Q
 ;
END ; Clean up.
 I $D(ZTQUEUED) S ZTREQ="@"
 E  D
 . D CLOSE^%ZISUTL("LRLABEL")
 . D CLOSE^%ZISUTL("LRHOME")
 Q
