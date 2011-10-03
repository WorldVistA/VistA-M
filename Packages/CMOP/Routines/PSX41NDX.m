PSX41NDX ;BIR/PDW-Execute new indexes in PSX patch 41 ;08/12/2002
 ;;2.0;CMOP;**41**;11 Apr 97
 Q
EN ; populates new indexes brought in with PSX*2*41
SYS550 ;index
 I ^XMB("NETNAME")?1"CMOP-".E Q
 ;       new status index "ST"
 K ^PSX(550,"ST")
 K DIK S DIK="^PSX(550,",DIK(1)="1^ST" D ENALL^DIK
 ;new transmit index "TR"
 K ^PSX(550,"TR")
 K DIK S DIK="^PSX(550,",DIK(1)="2^TR" D ENALL^DIK
 ;new Task index "AG"
 K ^PSX(550,"AG")
 K DIK S DIK="^PSX(550,",DIK(1)="9^AG" D ENALL^DIK
 Q
