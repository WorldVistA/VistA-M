AFJXWCPM ;FO-OAKLAND/GMB-REQUEST PATIENT INFO MENU ;11/8/95
 ;;5.1;Network Health Exchange;**6,22,31,33,34**;Jan 23, 1996
 ; Totally rewritten 11/2001.  (Previously FJ/CWS.)
 ; Entry point:
 ; EN - Invoked by option AFJXNHEX REQUEST
EN ;
 I '$G(DUZ) W !!,"You must have a DUZ defined ........" H 3 W !! Q
 Q:'$$NHEACTIV
 D HOME^%ZIS ; Not sure this is needed, but I left it in, anyway.
 N AXABORT
 S AXABORT=0
 F  D  Q:AXABORT
 . N DIR,X,Y,DIRUT
 . D HDR
 . S DIR("A")="     Enter choice"
 . S DIR(0)="SO^1:Brief (12 months) Medical Record Information"
 . S DIR(0)=DIR(0)_";2:Total Medical Record Information"
 . S DIR(0)=DIR(0)_";3:Brief (12 months) Pharmacy Information"
 . S DIR(0)=DIR(0)_";4:Total Pharmacy Information"
 . S DIR(0)=DIR(0)_";5:Print (Completed Requests Only)"
 . S DIR(0)=DIR(0)_";6:Print By Type of Information (Completed Requests)"
 . D ^DIR I $D(DIRUT) S AXABORT=1 Q
 . D @Y
 W @IOF
 Q
1 ; Brief (12 months) Medical Record Information
 D REQUEST^AFJXWCP1("PB")
 Q
2 ; Total Medical Record Information
 D REQUEST^AFJXWCP1("P")
 Q
3 ; Brief (12 months) Pharmacy Information
 D REQUEST^AFJXWCP1("RB")
 Q
4 ; Total Pharmacy Information
 D REQUEST^AFJXWCP1("R")
 Q
5 ; Print (Completed Requests Only)
 D ENTER^AFJXMBOX
 Q
6 ; Print By Type of Information (Completed Requests)
 D ENTER^AFJXMABX
 Q
HDR ; Print page header
 N AX1,AX2
 W @IOF
 S AX1="VistA Network Health Exchange Menu"
 S AX2=$$NAME^XMXUTIL(DUZ)
 W AX1,$J(AX2,74-$L(AX1)),!,$$REPEAT^XLFSTR("=",74)
 Q
NHEACTIV() ; Is NHE user active?
 N AXNHEDUZ,AXTXT,AXI
 S AXI=0
 S AXNHEDUZ=$$FIND1^DIC(200,"","X","NETWORK,HEALTH EXCHANGE")
 I 'AXNHEDUZ D
 . S AXI=AXI+1,AXTXT(AXI)="The NETWORK,HEALTH EXCHANGE user is not in the NEW PERSON file."
 E  I $P($G(^VA(200,AXNHEDUZ,0)),U,3)="" D
 . S AXI=AXI+1,AXTXT(AXI)="The NETWORK,HEALTH EXCHANGE user does not have an access code."
 I '$D(^XMB(3.7,+AXNHEDUZ,2)) D
 . S AXI=AXI+1,AXTXT(AXI)="The NETWORK,HEALTH EXCHANGE user does not have a MAILBOX."
 Q:'AXI 1
 W $C(7),!
 S AXI=0 F  S AXI=$O(AXTXT(AXI)) Q:'AXI  W !,AXTXT(AXI)
 W !!,"Please inform IRM."
 W !,"Until this is corrected, you will not be able to use this option."
 Q 0
