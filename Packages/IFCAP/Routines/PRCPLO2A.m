PRCPLO2A ;WOIFO/DAP-stock status report (cont) ; 1/26/06 12:00pm
V ;;5.1;IFCAP;**83,98,112**;Oct 20, 2000;Build 2
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;External reference to $$GET1^DIQ(4, is supported by ICR# 10090
 ; *112 changes by: VMP, Holloway,T.
 ;
ENT ;*83 Building ^TMP with total result data, totaling logic pulled from PRCPRSS0
 N PRCPIN,PRCPIN1,PRCPIN2,PRCPIN3,TOTVAL,TOTCLOS,TOTCLO1,TOTCLO2,SSRIEN
 S U="^",STA=PRC("SITE"),INV=PRCP("I")
 ;
SSR1 ;*98 First Stock Status Report data field set
 ;
 S $P(^TMP($J,"PRCPSSR1",STA,INV),U,1)=STA ;Station #
 S DATRN=$$FMTE^XLFDT(DATESTRT)
 S DATRN1=$P(DATRN," ",1)_","_$P(DATRN," ",2)
 S $P(^TMP($J,"PRCPSSR1",STA,INV),U,2)=DATRN1 ;Date Range
 S $P(^TMP($J,"PRCPSSR1",STA,INV),U,3)=INARNG ;Inactivity Range
 S $P(^TMP($J,"PRCPSSR1",STA,INV),U,4)=INV ;Inventory Point #
 ;*83 Retrieve external inventory point name and primary/secondary/
 ;warehouse indicator
 S PRCPIN=$G(^PRCP(445,INV,0))
 I PRCPIN'="" S PRCPIN1=$P(PRCPIN,"^",1),PRCPIN2=$P(PRCPIN1,"-",2,99)
 I PRCPIN'="" S PRCPIN3=$P(PRCPIN,"^",3)
 I PRCPIN="" S PRCPIN2="",PRCPIN3=""
 S PRCPIN2=$TR(PRCPIN2,"*","|")  ; Needed due to "*" delimiter
 S $P(^TMP($J,"PRCPSSR1",STA,INV),U,5)=PRCPIN2 ;Inventory Point Name
 S $P(^TMP($J,"PRCPSSR1",STA,INV),U,6)=PRCPIN3 ;P/S/W Indicator
 ;
 S PRCPDX=$TR(^TMP($J,"PRCPSSR1",STA,INV),"^","*"),DR="3///"_PRCPDX
 D FILE
 ;
SSR2 ;*98 Second Stock Status Report data field set
 ;
 S TOTOPEN=0 F ACCT=1,2,3,6,8 S %=$P($G(^TMP($J,1,"OPEN",ACCT)),U,2),TOTOPEN=TOTOPEN+%
 S $P(^TMP($J,"PRCPSSR2",STA,INV),U,1)=TOTOPEN ;Std. Open Balance Total $
 S TOTOPEN=0 F ACCT=1,2,3,6,8 S %=$P($G(^TMP($J,2,"OPEN",ACCT)),U,2),TOTOPEN=TOTOPEN+%
 S $P(^TMP($J,"PRCPSSR2",STA,INV),U,2)=TOTOPEN ;ODI Open Balance Total $
 S TOTOPEN=0 F ACCT=1,2,3,6,8 S %=$P($G(^TMP($J,3,"OPEN",ACCT)),U,2),TOTOPEN=TOTOPEN+%
 S $P(^TMP($J,"PRCPSSR2",STA,INV),U,3)=TOTOPEN ;All Open Balance Total $
 ;
 S $P(^TMP($J,"PRCPSSR2",STA,INV),U,4)=+$G(^TMP($J,1,"REC","TOTAL"))
 ;Std. Receipts Total $
 S $P(^TMP($J,"PRCPSSR2",STA,INV),U,5)=+$G(^TMP($J,2,"REC","TOTAL"))
 ;ODI Receipts Total $
 S $P(^TMP($J,"PRCPSSR2",STA,INV),U,6)=+$G(^TMP($J,3,"REC","TOTAL"))
 ;All Receipts Total $
 S $P(^TMP($J,"PRCPSSR2",STA,INV),U,7)=+$G(^TMP($J,1,"ISS","TOTAL"))
 ;Std. Usages Total $
 S $P(^TMP($J,"PRCPSSR2",STA,INV),U,8)=+$G(^TMP($J,2,"ISS","TOTAL"))
 ;ODI Usages Total $
 S $P(^TMP($J,"PRCPSSR2",STA,INV),U,9)=+$G(^TMP($J,3,"ISS","TOTAL"))
 ;All Usages Total $
 S $P(^TMP($J,"PRCPSSR2",STA,INV),U,10)=+$G(^TMP($J,1,"ADJ","TOTAL"))
 ;Std. Adjustments Total $
 S $P(^TMP($J,"PRCPSSR2",STA,INV),U,11)=+$G(^TMP($J,2,"ADJ","TOTAL"))
 ;ODI Adjustments Total $
 S $P(^TMP($J,"PRCPSSR2",STA,INV),U,12)=+$G(^TMP($J,3,"ADJ","TOTAL"))
 ;All Adjustments Total $
 ;
 S PRCPDX=$TR(^TMP($J,"PRCPSSR2",STA,INV),"^","*"),DR="4///"_PRCPDX
 D FILE
 ;
SSR3 ;*98 Third Stock Status Report data field set
 ;
 S TOTCLOS=0
 S TOTCLOS=$P($G(^TMP($J,"PRCPSSR2",STA,INV)),U,1)+$G(^TMP($J,1,"REC","TOTAL"))
 S TOTCLOS=TOTCLOS+$G(^TMP($J,1,"ISS","TOTAL"))+$G(^TMP($J,1,"ADJ","TOTAL"))
 S $P(^TMP($J,"PRCPSSR3",STA,INV),U,1)=TOTCLOS ;Std. Closing Bal Total $
 S TOTCLO1=0
 S TOTCLO1=$P($G(^TMP($J,"PRCPSSR2",STA,INV)),U,2)+$G(^TMP($J,2,"REC","TOTAL"))
 S TOTCLO1=TOTCLO1+$G(^TMP($J,2,"ISS","TOTAL"))+$G(^TMP($J,2,"ADJ","TOTAL"))
 S $P(^TMP($J,"PRCPSSR3",STA,INV),U,2)=TOTCLO1 ;ODI Closing Bal Total $
 S TOTCLO2=0
 S TOTCLO2=$P($G(^TMP($J,"PRCPSSR2",STA,INV)),U,3)+$G(^TMP($J,3,"REC","TOTAL"))
 S TOTCLO2=TOTCLO2+$G(^TMP($J,3,"ISS","TOTAL"))+$G(^TMP($J,3,"ADJ","TOTAL"))
 S $P(^TMP($J,"PRCPSSR3",STA,INV),U,3)=TOTCLO2 ;All Closing Bal Total $
 ;
 S $P(^TMP($J,"PRCPSSR3",STA,INV),U,4)=+$G(^TMP($J,1,"RECN","TOTAL"))
 ;# Std. Receipts
 S $P(^TMP($J,"PRCPSSR3",STA,INV),U,5)=+$G(^TMP($J,2,"RECN","TOTAL"))
 ;# ODI Receipts
 S $P(^TMP($J,"PRCPSSR3",STA,INV),U,6)=+$G(^TMP($J,3,"RECN","TOTAL"))
 ;# All Receipts
 S $P(^TMP($J,"PRCPSSR3",STA,INV),U,7)=+$G(^TMP($J,1,"ISSN","TOTAL"))
 ;# Std. Issues
 S $P(^TMP($J,"PRCPSSR3",STA,INV),U,8)=+$G(^TMP($J,2,"ISSN","TOTAL"))
 ;# ODI Issues
 S $P(^TMP($J,"PRCPSSR3",STA,INV),U,9)=+$G(^TMP($J,3,"ISSN","TOTAL"))
 ;# All Issues
 S $P(^TMP($J,"PRCPSSR3",STA,INV),U,10)=+$G(^TMP($J,1,"ADJN","TOTAL"))
 ;# Std. Adjustments
 S $P(^TMP($J,"PRCPSSR3",STA,INV),U,11)=+$G(^TMP($J,2,"ADJN","TOTAL"))
 ;# ODI Adjustments
 S $P(^TMP($J,"PRCPSSR3",STA,INV),U,12)=+$G(^TMP($J,3,"ADJN","TOTAL"))
 ;# All Adjustments
 ;
 S PRCPDX=$TR(^TMP($J,"PRCPSSR3",STA,INV),"^","*"),DR="5///"_PRCPDX
 D FILE
 ;
SSR4 ;*98 Fourth Stock Status Report data field set
 ;
 ;*83 Turnover computation logic also pulled from PRCPRSS0
 S DAYS=$P("31^28^31^30^31^30^31^31^30^31^30^31",U,+$E(DATESTRT,4,5))
 I DAYS=28 S %=(17+$E(DATESTRT))_$E(DATESTRT,2,3),DAYS=$S(%#400=0:29,(%#4=0&(%#100'=0)):29,1:28)
 ;
 S %=($G(^TMP($J,1,"ISS","TOTAL"))*365)/DAYS,%=$S('TOTCLOS:0,1:-%/TOTCLOS)
 S $P(^TMP($J,"PRCPSSR4",STA,INV),U,1)=$J(%,0,2)
 ;Std. Turnover
 S %=($G(^TMP($J,2,"ISS","TOTAL"))*365)/DAYS,%=$S('TOTCLO1:0,1:-%/TOTCLO1)
 S $P(^TMP($J,"PRCPSSR4",STA,INV),U,2)=$J(%,0,2)
 ;ODI Turnover
 S %=($G(^TMP($J,3,"ISS","TOTAL"))*365)/DAYS,%=$S('TOTCLO2:0,1:-%/TOTCLO2)
 S $P(^TMP($J,"PRCPSSR4",STA,INV),U,3)=$J(%,0,2)
 ;All Turnover
 S $P(^TMP($J,"PRCPSSR4",STA,INV),U,4)=+$G(^TMP($J,1,"INACTN","TOTAL"))
 ;# Std. Inactive
 S $P(^TMP($J,"PRCPSSR4",STA,INV),U,5)=+$G(^TMP($J,2,"INACTN","TOTAL"))
 ;# ODI Inactive
 S $P(^TMP($J,"PRCPSSR4",STA,INV),U,6)=+$G(^TMP($J,3,"INACTN","TOTAL"))
 ;# All Inactive
 S $P(^TMP($J,"PRCPSSR4",STA,INV),U,7)=+$G(^TMP($J,1,"INACT","TOTAL"))
 ;Std Inactive Total $
 S $P(^TMP($J,"PRCPSSR4",STA,INV),U,8)=+$G(^TMP($J,2,"INACT","TOTAL"))
 ;ODI Inactive Total $
 S $P(^TMP($J,"PRCPSSR4",STA,INV),U,9)=+$G(^TMP($J,3,"INACT","TOTAL"))
 ;All Inactive Total $
 ;
 S %=$S('$G(^TMP($J,1,"VALUE","TOTAL")):0,1:$G(^TMP($J,1,"INACT","TOTAL"))/$G(^TMP($J,1,"VALUE","TOTAL")))
 I %="" S %=0
 S $P(^TMP($J,"PRCPSSR4",STA,INV),U,10)=$J(%,0,2)
 ;Std. Inactive %
 S %=$S('$G(^TMP($J,2,"VALUE","TOTAL")):0,1:$G(^TMP($J,2,"INACT","TOTAL"))/$G(^TMP($J,2,"VALUE","TOTAL")))
 I %="" S %=0
 S $P(^TMP($J,"PRCPSSR4",STA,INV),U,11)=$J(%,0,2)
 ;ODI Inactive %
 S %=$S('$G(^TMP($J,3,"VALUE","TOTAL")):0,1:$G(^TMP($J,3,"INACT","TOTAL"))/$G(^TMP($J,3,"VALUE","TOTAL")))
 I %="" S %=0
 S $P(^TMP($J,"PRCPSSR4",STA,INV),U,12)=$J(%,0,2)
 ;All Inactive %
 ;
 S PRCPDX=$TR(^TMP($J,"PRCPSSR4",STA,INV),"^","*"),DR="6///"_PRCPDX
 D FILE
 ;
SSR5 ;*98 Fifth Stock Status Report data field set
 ;
 S $P(^TMP($J,"PRCPSSR5",STA,INV),U,1)=+$G(^TMP($J,1,"LONGN","TOTAL"))
 ;# Std. Long Supply
 S $P(^TMP($J,"PRCPSSR5",STA,INV),U,2)=+$G(^TMP($J,2,"LONGN","TOTAL"))
 ;# ODI Long Supply
 S $P(^TMP($J,"PRCPSSR5",STA,INV),U,3)=+$G(^TMP($J,3,"LONGN","TOTAL"))
 ;# All Long Supply
 S $P(^TMP($J,"PRCPSSR5",STA,INV),U,4)=+$G(^TMP($J,1,"LONG","TOTAL"))
 ;Std. Long Supply Total $
 S $P(^TMP($J,"PRCPSSR5",STA,INV),U,5)=+$G(^TMP($J,2,"LONG","TOTAL"))
 ;ODI Long Supply Total $
 S $P(^TMP($J,"PRCPSSR5",STA,INV),U,6)=+$G(^TMP($J,3,"LONG","TOTAL"))
 ;All Long Supply Total $
 ;
 S %=$S('$G(^TMP($J,1,"VALUE","TOTAL")):0,1:$G(^TMP($J,1,"LONG","TOTAL"))/$G(^TMP($J,1,"VALUE","TOTAL")))
 I %="" S %=0
 S $P(^TMP($J,"PRCPSSR5",STA,INV),U,7)=$J(%,0,2)
 ;Std. Long Supply %
 S %=$S('$G(^TMP($J,2,"VALUE","TOTAL")):0,1:$G(^TMP($J,2,"LONG","TOTAL"))/$G(^TMP($J,2,"VALUE","TOTAL")))
 I %="" S %=0
 S $P(^TMP($J,"PRCPSSR5",STA,INV),U,8)=$J(%,0,2)
 ;ODI Long Supply %
 S %=$S('$G(^TMP($J,3,"VALUE","TOTAL")):0,1:$G(^TMP($J,3,"LONG","TOTAL"))/$G(^TMP($J,3,"VALUE","TOTAL")))
 I %="" S %=0
 S $P(^TMP($J,"PRCPSSR5",STA,INV),U,9)=$J(%,0,2)
 ;All Long Supply %
 S $P(^TMP($J,"PRCPSSR5",STA,INV),U,10)=+$G(^TMP($J,1,"CNT","TOTAL"))
 ;# Std. Items
 S $P(^TMP($J,"PRCPSSR5",STA,INV),U,11)=+$G(^TMP($J,2,"CNT","TOTAL"))
 ;# On-Demand Items
 S $P(^TMP($J,"PRCPSSR5",STA,INV),U,12)=+$G(^TMP($J,3,"CNT","TOTAL"))
 ;# All Items
 ;
 S PRCPDX=$TR(^TMP($J,"PRCPSSR5",STA,INV),"^","*"),DR="7///"_PRCPDX
 D FILE
 K Y
 ;
 Q
 ;
 ;*98 Created filing subroutine
FILE ; Subroutine that creates entries in File #446.7 fields as they 
 ; are created
 ;
 N PRCPDR,PRCPSNM,PRCPDA,PRCPDX,X,Y
 S PRCPDR=DR
 S SSRIEN=STA_INV
 S DIC="^PRCP(446.7,",DIC(0)="L",DLAYGO=446.7,X=SSRIEN D ^DIC K DIC,DLAYGO
 S PRCPDA=Y+0
 ;*98 Send enhanced mail message if exception occurs during FileMan set
 I Y=-1 N PRCPMSG D  Q
 . S PRCPMSG(1)="Error saving to File #446.7 for Stock Status Report, related data: "
 . S PRCPSNM=$$GET1^DIQ(4,STA_",",.01)
 . S PRCPMSG(2)="",PRCPMSG(3)="Station: "_STA_" "_PRCPSNM
 . S PRCPMSG(4)="Inventory Point: "_$P(^TMP($J,"PRCPSSR1",STA,INV),U,4)_" "_$P(^TMP($J,"PRCPSSR1",STA,INV),U,5)
 . S PRCPMSG(5)="File #446.7 Field Set Attempted: "_PRCPDR
 . D MAIL^PRCPLO3 Q
 ;
 S DIE="^PRCP(446.7,",DA=PRCPDA D ^DIE K DIE,DR,DA
 ;
 Q
