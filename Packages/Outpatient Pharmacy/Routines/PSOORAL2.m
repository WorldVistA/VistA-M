PSOORAL2 ;BHAM-ISC/SAB - build listman activity logs con't ;Feb 10, 2022@10:12:50
 ;;7.0;OUTPATIENT PHARMACY;**258,260,386,427,454,482,441**;DEC 1997;Build 208
 ;
RF ;refill log
 S IEN=IEN+1,^TMP("PSOAL",$J,IEN,0)=" ",IEN=IEN+1,^TMP("PSOAL",$J,IEN,0)="Refill Log:"
 S IEN=IEN+1,^TMP("PSOAL",$J,IEN,0)="#  Log Date   Refill Date  Qty               Routing  Lot #       Pharmacist",IEN=IEN+1,$P(^TMP("PSOAL",$J,IEN,0),"=",79)="="
 S (RF,PL)=0 F RF=0:0 S RF=$O(^PSRX(DA,1,RF)) Q:'RF  S PL=PL+1
 I 'PL S IEN=IEN+1,^TMP("PSOAL",$J,IEN,0)="There are NO Refills For this Prescription" Q
 F N=0:0 S N=$O(^PSRX(DA,1,N)) Q:'N  S P1=^(N,0) D
 .S DTT=$P(P1,"^",8)\1 D DAT S IEN=IEN+1,^TMP("PSOAL",$J,IEN,0)=N_"   "_DAT_"   "
 .S DTT=$P(P1,"^"),$P(RN," ",10)=" " D DAT
 .S ^TMP("PSOAL",$J,IEN,0)=^TMP("PSOAL",$J,IEN,0)_DAT_"     "_$P(P1,"^",4)_$E("               ",$L($P(P1,"^",4))+1,15)_"  "_$S($P(P1,"^",2)="M":"Mail",$P(P1,"^",2)="P":"Park",1:"Window")_" "_$P(P1,"^",6)_$E(RN,$L($P(P1,"^",6))+1,12)
 .; grab remote fill information as part of OneVA project
 .; and display if available
 .N REMOTEF,REMOTEPH,REMOTES
 .S REMOTEF=$G(^PSRX(DA,1,N,"RF")),REMOTEPH=$P(REMOTEF,U,2),REMOTES=$P(REMOTEF,U)
 .I REMOTES D
 .. S REMOTES=$$FIND1^DIC(4,,"X",REMOTES,"D","I $P(^(0),U,11)=""N"",'$P($G(^(99)),U,4)")
 .. I 'REMOTES S REMOTES="" Q
 .. S REMOTES=$$GET1^DIQ(4,REMOTES_",",99)
 .S ^TMP("PSOAL",$J,IEN,0)=^TMP("PSOAL",$J,IEN,0)_$E($S(REMOTEPH]"":REMOTEPH,$D(^VA(200,+$P(P1,"^",5),0)):$P(^(0),"^"),1:""),1,16)
 .S PSDIV=$S(REMOTES]"":REMOTES,$D(^PS(59,+$P(P1,"^",9),0)):$P(^(0),"^",6),1:"Unknown"),IEN=IEN+1,^TMP("PSOAL",$J,IEN,0)="Division: "_PSDIV_$E("        ",$L(PSDIV)+1,8)_"  "
 .S ^TMP("PSOAL",$J,IEN,0)=^TMP("PSOAL",$J,IEN,0)_"Dispensed: "_$S($P(P1,"^",19):$E($P(P1,"^",19),4,5)_"/"_$E($P(P1,"^",19),6,7)_"/"_$E($P(P1,"^",19),2,3),1:"")_"  "
 .S RTS=$S($P(P1,"^",16):" Returned to Stock: "_$E($P(P1,"^",16),4,5)_"/"_$E($P(P1,"^",16),6,7)_"/"_$E($P(P1,"^",16),2,3),1:" Released: "_$S($$RXRLDT^PSOBPSUT(DA,N):$$FMTE^XLFDT($$RXRLDT^PSOBPSUT(DA,N)\1,2),1:""))
 .; Always display the NDC# - PSO*7*427
 .S RTS=RTS_"  NDC: "_$$GETNDC^PSONDCUT(DA,N)
 .S ^TMP("PSOAL",$J,IEN,0)=^TMP("PSOAL",$J,IEN,0)_RTS S:$P(P1,"^",3)]"" IEN=IEN+1,^TMP("PSOAL",$J,IEN,0)="   Remarks: "_$P(P1,"^",3)
 K RTS Q
PAR ;partial log
 S IEN=IEN+1,^TMP("PSOAL",$J,IEN,0)=" ",IEN=IEN+1,^TMP("PSOAL",$J,IEN,0)="Partial Fills:"
 S IEN=IEN+1,^TMP("PSOAL",$J,IEN,0)="#   Log Date   Date     Qty              Routing    Lot #        Pharmacist",IEN=IEN+1,$P(^TMP("PSOAL",$J,IEN,0),"=",79)="="
 I '$O(^PSRX(DA,"P",0)) S IEN=IEN+1,^TMP("PSOAL",$J,IEN,0)="There are NO Partials for this Prescription" Q
 S N=0 F  S N=$O(^PSRX(DA,"P",N)) Q:'N  S P1=^(N,0),DTT=$P(P1,"^",8)\1 D DAT D
 .S IEN=IEN+1,^TMP("PSOAL",$J,IEN,0)=N_"   "_DAT_"  ",QTY=$P(P1,"^",4)_$E("               ",$L($P(P1,"^",4))+1,15)
 .S DTT=$P(P1,"^") D DAT S ^TMP("PSOAL",$J,IEN,0)=^TMP("PSOAL",$J,IEN,0)_DAT_"  "_QTY_"  "
 .; grab remote fill information as part of OneVA project
 .; and display if available
 .N REMOTEF,REMOTEPH,REMOTES
 .S REMOTEF=$G(^PSRX(DA,"P",N,"PF")),REMOTEPH=$P(REMOTEF,U,2),REMOTES=$P(REMOTEF,U)
 .I REMOTES D
 .. S REMOTES=$$FIND1^DIC(4,,"X",REMOTES,"D","I $P(^(0),U,11)=""N"",'$P($G(^(99)),U,4)")
 .. I 'REMOTES S REMOTES="" Q
 .. S REMOTES=$$GET1^DIQ(4,REMOTES_",",99)
 .S PSDIV=$S(REMOTES]"":REMOTES,$D(^PS(59,+$P(P1,"^",9),0)):$P(^(0),"^",6),1:"UNKNOWN"),PSDIV=PSDIV_$E("        ",$L(PSDIV)+1,8)
 .S MW=$S($P(P1,"^",2)="M":"Mail",1:"Window"),MW=MW_$E("          ",$L(MW)+1,10)
 .S ^TMP("PSOAL",$J,IEN,0)=^TMP("PSOAL",$J,IEN,0)_MW_"  "_$P(P1,"^",6)_$E("            ",$L($P(P1,"^",6))+1,10)_$E($S(REMOTEPH]"":REMOTEPH,$D(^VA(200,+$P(P1,"^",5),0)):$P(^(0),"^"),1:""),1,16)
 .S RTS=$S($P(P1,"^",16):" RETURNED TO STOCK: "_$E($P(P1,"^",16),4,5)_"/"_$E($P(P1,"^",16),6,7)_"/"_$E($P(P1,"^",16),2,3),1:" RELEASED: "_$S($P(P1,"^",19):$E($P(P1,"^",19),4,5)_"/"_$E($P(P1,"^",19),6,7)_"/"_$E($P(P1,"^",19),2,3),1:""))
 .S IEN=IEN+1,^TMP("PSOAL",$J,IEN,0)="Division: "_PSDIV_" "_RTS ;_"      Entry By: "_$P(^VA(200,$P(P1,"^",7),0),"^")
 .S:$P(P1,"^",3)]"" IEN=IEN+1,^TMP("PSOAL",$J,IEN,0)="  REMARKS: "_$P(P1,"^",3) K RTS
 Q
HLD ;hold info
 S DTT=$P(^PSRX(DA,"H"),"^",3) D DAT S HLDR=$$GET1^DIQ(52,DA,99)
 S $P(RN," ",60)=" ",IEN=IEN+1,^TMP("PSOAL",$J,IEN,0)="Hold Reason: "_HLDR_$E(RN,$L("Hold Reason: "_HLDR)+1,60)_"Hold Date: "_DAT
 I $P($G(^PSRX(DA,"H")),"^",2)]"" D
 . N HLDCOMM S HLDCOMM=$P(^PSRX(DA,"H"),"^",2)
 . S IEN=IEN+1,^TMP("PSOAL",$J,IEN,0)="Hold Comments: "_$E(HLDCOMM,1,65),HLDCOMM=$E(HLDCOMM,66,999)
 . F  Q:HLDCOMM=""  D
 . . S IEN=IEN+1,^TMP("PSOAL",$J,IEN,0)="               "_$E(HLDCOMM,1,65),HLDCOMM=$E(HLDCOMM,66,999)
 K RN,DAT,DTT,HLDR
 Q
DAT S DAT="",DTT=DTT\1 Q:DTT'?7N  S DAT=$E(DTT,4,5)_"/"_$E(DTT,6,7)_"/"_$E(DTT,2,3)
 Q
