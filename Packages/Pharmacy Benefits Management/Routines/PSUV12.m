PSUV12 ;BIR/DAM - IV AMIS Summary Message II ;04 MAR 2004
 ;;4.0;PHARMACY BENEFITS MANAGEMENT;**4**;MARCH, 2005
 ;
 ;No DBIA's required
 ;
EN ;Entry point for MailMan message
 ;Called from PSUV11
 ;
 ;Construct IV AMIS summary message
 ;
 S Y=PSUSDT X ^DD("DD") S PSUDTS=Y
 S Y=PSUEDT X ^DD("DD") S PSUDTE=Y
 S PSUDIV=PSUSNDR D GETDIV^PSUV3
 S AMIS(1)="IV AMIS Summary for "_PSUDTS_" through "_PSUDTE_" for "_PSUDIVNM
 ;
 S AMIS(2)=""     ;Blank line
 ;
 I PSUAIS=1 S AMIS(3)="NO IV AMIS Summary data to report" Q
 ;
 S AMIS(3)="                                                NET                 Cost/"
 ;
 S AMIS(4)="                    LVPs    LVPs   LVPs   LVPs  LVPs       Total    NET LVPs"
 ;
 S AMIS(5)="Division            DISP    RET    DES    CAN   DISP       Cost     DISP"
 ;
 S $P(AMIS(6),"-",78)=""      ;Separator bar
 ;
 S PSULN=7
 ;
 ;Construct LVP DATA lines with spacing
 S PSUDIV=0
 F  S PSUDIV=$O(LVP(PSUDIV)) Q:PSUDIV=""  D
 .D GETDIV^PSUV3
 .S PSULINE=""
 .S $E(PSULINE,1,17)=PSUDIVNM
 .S $E(PSULINE,18,24)=$J($P(LVP(PSUDIV),U,1),7)
 .S $E(PSULINE,25,31)=$J($P(LVP(PSUDIV),U,2),7)
 .S $E(PSULINE,32,38)=$J($P(LVP(PSUDIV),U,3),7)
 .S $E(PSULINE,39,45)=$J($P(LVP(PSUDIV),U,4),7)
 .S $E(PSULINE,46,52)=$J($P(LVP(PSUDIV),U,5),7)
 .S $E(PSULINE,54,55)="$"
 .S $E(PSULINE,56,64)=$J($P(LVP(PSUDIV),U,6),9)
 .S $E(PSULINE,66,67)="$"
 .S $E(PSULINE,68,75)=$J($P(LVP(PSUDIV),U,7),8)
 .;End line
 .S AMIS(PSULN)=PSULINE S PSULN=PSULN+1
 ;
 S $P(AMIS(PSULN),"-",78)="" S PSULN=PSULN+1      ;Separator bar
 ;
 M LVP("TOT")=^XTMP(PSUIVSUB,"LVPTOT")        ;LVP Totals array
 ;Construct LVP Totals line
 S PSULINE=""
 S $E(PSULINE,1,17)="Total"
 S $E(PSULINE,18,24)=$J($P(LVP("TOT"),U,1),7)
 S $E(PSULINE,25,31)=$J($P(LVP("TOT"),U,2),7)
 S $E(PSULINE,32,38)=$J($P(LVP("TOT"),U,3),7)
 S $E(PSULINE,39,45)=$J($P(LVP("TOT"),U,4),7)
 S $E(PSULINE,46,52)=$J($P(LVP("TOT"),U,5),7)
 S $E(PSULINE,54,55)="$"
 S $E(PSULINE,56,64)=$J($P(LVP("TOT"),U,6),9)
 S $E(PSULINE,66,67)="$"
 S $E(PSULINE,68,75)=$J($P(LVP("TOT"),U,7),8)
 ;End line
 S AMIS(PSULN)=PSULINE S PSULN=PSULN+1
 ;
 F PSULN=PSULN:1:(PSULN+4) S AMIS(PSULN)=""     ;Blank lines
 S PSULN=PSULN+1
 ;
 ;
 S AMIS(PSULN)="                                                NET               Cost/"
 S PSULN=PSULN+1
 ;
 S AMIS(PSULN)="                    IVPBs   IVPBs  IVPBs  IVPBs IVPBs    Total    NET IVPBs"
 ;
 S PSULN=PSULN+1
 S AMIS(PSULN)="Division            DISP    RET    DES    CAN   DISP     Cost     DISP"
 ;
 S PSULN=PSULN+1
 ;
 S $P(AMIS(PSULN),"-",78)="" S PSULN=PSULN+1      ;Separator bar
 ;
 ;Construct IVPB DATA lines with spacing
 S PSUDIV=0
 F  S PSUDIV=$O(PB(PSUDIV)) Q:PSUDIV=""  D
 .D GETDIV^PSUV3
 .S PSULINE=""
 .S $E(PSULINE,1,17)=PSUDIVNM
 .S $E(PSULINE,18,24)=$J($P(PB(PSUDIV),U,1),7)
 .S $E(PSULINE,25,31)=$J($P(PB(PSUDIV),U,2),7)
 .S $E(PSULINE,32,38)=$J($P(PB(PSUDIV),U,3),7)
 .S $E(PSULINE,39,45)=$J($P(PB(PSUDIV),U,4),7)
 .S $E(PSULINE,46,52)=$J($P(PB(PSUDIV),U,5),7)
 .S $E(PSULINE,54,55)="$"
 .S $E(PSULINE,56,64)=$J($P(PB(PSUDIV),U,6),9)
 .S $E(PSULINE,66,67)="$"
 .S $E(PSULINE,68,75)=$J($P(PB(PSUDIV),U,7),8)
 .;End line
 .S AMIS(PSULN)=PSULINE S PSULN=PSULN+1
 ;
 S $P(AMIS(PSULN),"-",78)="" S PSULN=PSULN+1      ;Separator bar
 ;
 M PB("TOT")=^XTMP(PSUIVSUB,"PBTOT")        ;IVPB Totals array
 ;Construct PB Totals line
 S PSULINE=""
 S $E(PSULINE,1,17)="Total"
 S $E(PSULINE,18,24)=$J($P(PB("TOT"),U,1),7)
 S $E(PSULINE,25,31)=$J($P(PB("TOT"),U,2),7)
 S $E(PSULINE,32,38)=$J($P(PB("TOT"),U,3),7)
 S $E(PSULINE,39,45)=$J($P(PB("TOT"),U,4),7)
 S $E(PSULINE,46,52)=$J($P(PB("TOT"),U,5),7)
 S $E(PSULINE,54,55)="$"
 S $E(PSULINE,56,64)=$J($P(PB("TOT"),U,6),9)
 S $E(PSULINE,66,67)="$"
 S $E(PSULINE,68,75)=$J($P(PB("TOT"),U,7),8)
 ;End line
 S AMIS(PSULN)=PSULINE S PSULN=PSULN+1
 ;
 F PSULN=PSULN:1:(PSULN+4) S AMIS(PSULN)=""     ;Blank lines
 S PSULN=PSULN+1
 ;
 S AMIS(PSULN)="                                                NET               Cost/"
 S PSULN=PSULN+1
 ;
 S AMIS(PSULN)="                   TPNs    TPNs    TPNs   TPNs  TPNs     Total    NET TPNs"
 ;
 S PSULN=PSULN+1
 S AMIS(PSULN)="Division           DISP    RET     DES    CAN   DISP     Cost     DISP"
 ;
 S PSULN=PSULN+1
 ;
 S $P(AMIS(PSULN),"-",78)="" S PSULN=PSULN+1      ;Separator bar
 ;
 ;Construct TPN DATA lines with spacing
 S PSUDIV=0
 F  S PSUDIV=$O(TPN(PSUDIV)) Q:PSUDIV=""  D
 .D GETDIV^PSUV3
 .S PSULINE=""
 .S $E(PSULINE,1,17)=PSUDIVNM
 .S $E(PSULINE,18,24)=$J($P(TPN(PSUDIV),U,1),7)
 .S $E(PSULINE,25,31)=$J($P(TPN(PSUDIV),U,2),7)
 .S $E(PSULINE,32,38)=$J($P(TPN(PSUDIV),U,3),7)
 .S $E(PSULINE,39,45)=$J($P(TPN(PSUDIV),U,4),7)
 .S $E(PSULINE,46,52)=$J($P(TPN(PSUDIV),U,5),7)
 .S $E(PSULINE,54,55)="$"
 .S $E(PSULINE,56,64)=$J($P(TPN(PSUDIV),U,6),9)
 .S $E(PSULINE,66,67)="$"
 .S $E(PSULINE,68,75)=$J($P(TPN(PSUDIV),U,7),8)
 .;End line
 .S AMIS(PSULN)=PSULINE S PSULN=PSULN+1
 ;
 S $P(AMIS(PSULN),"-",78)="" S PSULN=PSULN+1      ;Separator bar
 ;
 M TPN("TOT")=^XTMP(PSUIVSUB,"TPNTOT")        ;TPN Totals array
 ;Construct TPN Totals line
 S PSULINE=""
 S $E(PSULINE,1,17)="Total"
 S $E(PSULINE,18,24)=$J($P(TPN("TOT"),U,1),7)
 S $E(PSULINE,25,31)=$J($P(TPN("TOT"),U,2),7)
 S $E(PSULINE,32,38)=$J($P(TPN("TOT"),U,3),7)
 S $E(PSULINE,39,45)=$J($P(TPN("TOT"),U,4),7)
 S $E(PSULINE,46,52)=$J($P(TPN("TOT"),U,5),7)
 S $E(PSULINE,54,55)="$"
 S $E(PSULINE,56,64)=$J($P(TPN("TOT"),U,6),9)
 S $E(PSULINE,66,67)="$"
 S $E(PSULINE,68,75)=$J($P(TPN("TOT"),U,7),8)
 ;End line
 S AMIS(PSULN)=PSULINE S PSULN=PSULN+1
 ;
 F PSULN=PSULN:1:(PSULN+4) S AMIS(PSULN)=""     ;Blank lines
 S PSULN=PSULN+1
 ;
 S AMIS(PSULN)="                                                NET               Cost/"
 S PSULN=PSULN+1
 ;
 S AMIS(PSULN)="                    CHEMO   CHEMO  CHEMO  CHEMO CHEMO     Total   NET CHEMOs"
 ;
 S PSULN=PSULN+1
 S AMIS(PSULN)="Division            DISP    RET    DES    CAN   DISP      Cost    DISP"
 ;
 S PSULN=PSULN+1
 ;
 S $P(AMIS(PSULN),"-",78)="" S PSULN=PSULN+1      ;Separator bar
 ;
 ;Construct CHEMO DATA lines with spacing
 S PSUDIV=0
 F  S PSUDIV=$O(CH(PSUDIV)) Q:PSUDIV=""  D
 .D GETDIV^PSUV3
 .S PSULINE=""
 .S $E(PSULINE,1,17)=PSUDIVNM
 .S $E(PSULINE,18,24)=$J($P(CH(PSUDIV),U,1),7)
 .S $E(PSULINE,25,31)=$J($P(CH(PSUDIV),U,2),7)
 .S $E(PSULINE,32,38)=$J($P(CH(PSUDIV),U,3),7)
 .S $E(PSULINE,39,45)=$J($P(CH(PSUDIV),U,4),7)
 .S $E(PSULINE,46,52)=$J($P(CH(PSUDIV),U,5),7)
 .S $E(PSULINE,54,55)="$"
 .S $E(PSULINE,56,64)=$J($P(CH(PSUDIV),U,6),9)
 .S $E(PSULINE,66,67)="$"
 .S $E(PSULINE,68,75)=$J($P(CH(PSUDIV),U,7),8)
 .;End line
 .S AMIS(PSULN)=PSULINE S PSULN=PSULN+1
 ;
 S $P(AMIS(PSULN),"-",78)="" S PSULN=PSULN+1      ;Separator bar
 ;
 M CH("TOT")=^XTMP(PSUIVSUB,"CHTOT")        ;CHEMO Totals array
 ;Construct CHEMO Totals line
 S PSULINE=""
 S $E(PSULINE,1,17)="Total"
 S $E(PSULINE,18,24)=$J($P(CH("TOT"),U,1),7)
 S $E(PSULINE,25,31)=$J($P(CH("TOT"),U,2),7)
 S $E(PSULINE,32,38)=$J($P(CH("TOT"),U,3),7)
 S $E(PSULINE,39,45)=$J($P(CH("TOT"),U,4),7)
 S $E(PSULINE,46,52)=$J($P(CH("TOT"),U,5),7)
 S $E(PSULINE,54,55)="$"
 S $E(PSULINE,56,64)=$J($P(CH("TOT"),U,6),9)
 S $E(PSULINE,66,67)="$"
 S $E(PSULINE,68,75)=$J($P(CH("TOT"),U,7),8)
 ;End line
 S AMIS(PSULN)=PSULINE S PSULN=PSULN+1
 ;
 F PSULN=PSULN:1:(PSULN+4) S AMIS(PSULN)=""     ;Blank lines
 S PSULN=PSULN+1
 ;
 ;
 S AMIS(PSULN)="                                                NET               Cost/"
 S PSULN=PSULN+1
 ;
 S AMIS(PSULN)="                   SYRs    SYRs   SYRs   SYRs   SYRs     Total    NET SYRs"
 ;
 S PSULN=PSULN+1
 S AMIS(PSULN)="Division           DISP    RET    DES    CAN    DISP     Cost     DISP"
 ;
 S PSULN=PSULN+1
 ;
 S $P(AMIS(PSULN),"-",78)="" S PSULN=PSULN+1      ;Separator bar
 ;
 ;Construct SYRINGE DATA lines with spacing
 S PSUDIV=0
 F  S PSUDIV=$O(SYR(PSUDIV)) Q:PSUDIV=""  D
 .D GETDIV^PSUV3
 .S PSULINE=""
 .S $E(PSULINE,1,17)=PSUDIVNM
 .S $E(PSULINE,18,24)=$J($P(SYR(PSUDIV),U,1),7)
 .S $E(PSULINE,25,31)=$J($P(SYR(PSUDIV),U,2),7)
 .S $E(PSULINE,32,38)=$J($P(SYR(PSUDIV),U,3),7)
 .S $E(PSULINE,39,45)=$J($P(SYR(PSUDIV),U,4),7)
 .S $E(PSULINE,46,52)=$J($P(SYR(PSUDIV),U,5),7)
 .S $E(PSULINE,54,55)="$"
 .S $E(PSULINE,56,64)=$J($P(SYR(PSUDIV),U,6),9)
 .S $E(PSULINE,66,67)="$"
 .S $E(PSULINE,68,75)=$J($P(SYR(PSUDIV),U,7),8)
 .;End line
 .S AMIS(PSULN)=PSULINE S PSULN=PSULN+1
 ;
 S $P(AMIS(PSULN),"-",78)="" S PSULN=PSULN+1      ;Separator bar
 ;
 M SYR("TOT")=^XTMP(PSUIVSUB,"SYRTOT")        ;SYRINGE Totals array
 ;Construct SYRINGE Totals line
 S PSULINE=""
 S $E(PSULINE,1,17)="Total"
 S $E(PSULINE,18,24)=$J($P(SYR("TOT"),U,1),7)
 S $E(PSULINE,25,31)=$J($P(SYR("TOT"),U,2),7)
 S $E(PSULINE,32,38)=$J($P(SYR("TOT"),U,3),7)
 S $E(PSULINE,39,45)=$J($P(SYR("TOT"),U,4),7)
 S $E(PSULINE,46,52)=$J($P(SYR("TOT"),U,5),7)
 S $E(PSULINE,54,55)="$"
 S $E(PSULINE,56,64)=$J($P(SYR("TOT"),U,6),9)
 S $E(PSULINE,66,67)="$"
 S $E(PSULINE,68,75)=$J($P(SYR("TOT"),U,7),8)
 ;End line
 S AMIS(PSULN)=PSULINE S PSULN=PSULN+1
 ;
 F PSULN=PSULN:1:(PSULN+4) S AMIS(PSULN)=""     ;Blank lines
 S PSULN=PSULN+1
 Q
