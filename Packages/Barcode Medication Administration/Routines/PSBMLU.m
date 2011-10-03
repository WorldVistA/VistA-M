PSBMLU ;BIRMINGHAM/EFC - BCMA MEDICATION LOG FUNCTIONS ;6/25/10 6:44am
 ;;3.0;BAR CODE MED ADMIN;**6,11,13,28,42**;Mar 2004;Build 23
 ;Per VHA Directive 2004-038 (or future revisions regarding same), this routine should not be modified.
 ;
 ; Reference/IA
 ; DEM^VADPT/10061
EN ;
 Q
 ;
AUDIT(IEN,TXT,PSBTRN) ; Append and Audit
 D NOW^%DTC
 S RDAT=%
 D:PSBTRN="ADD COMMENT"
 . N XA
 . S XA=$O(^PSB(53.79,IEN,.3,"A"),-1)
 . S RDAT=$P(^PSB(53.79,IEN,.3,XA,0),U,3)
 D:PSBTRN="PRN EFFECTIVENESS" 
 . S RDAT=$P(^PSB(53.79,IEN,.2),U,4)
 D:PSBTRN="UPDATE STATUS"
 . S RDAT=$P(^PSB(53.79,IEN,0),U,6)
 D:PSBTRN="MEDPASS"
 . S RDAT=$P(^PSB(53.79,IEN,0),U,6)
 S:'$D(^PSB(53.79,IEN,.9,0)) ^(0)="^53.799D^^"
 S PSBAD1=""
 S PSBAD1=$O(^PSB(53.79,IEN,.9,"A"),-1)+1
 S ^PSB(53.79,IEN,.9,PSBAD1,0)=RDAT_U_DUZ_U_TXT
 Q
 ;
ERROR(PSB1,PSB2,DFN,PSB3,PSB4,PSB5,PSB6,PSB7) ;
 ; PSB1 = order #
 ; PSB2 = orderable item
 ; PSB3 = message to be sent
 ; PSB4 = schedule
 ; PSB5 = action date/time
 ; PSB6 = med log ien #
 ; PSB7 = user identification
 ; Send Error Msg about problems
 K PSBMG S PSBMG=$$GET^XPAR("DIV",$S($G(PSBADMER):"PSB MG ADMIN ERROR",1:"PSB MG DUE LIST ERROR"),,"E")
 Q:PSBMG=""
 S PSBMSG(1)="  The following "_$S($G(PSBADMER):"administration",1:"order")_" was NOT displayed"
 S PSBMSG(2)="  on the Virtual Due List"
 S PSBMSG(3)=" "
 S PSBMSG(4)="  Order Number....: "_PSB1
 S PSBMSG(5)="  Orderable Item..: "_PSB2
 N VA,VADM D DEM^VADPT
 S PSBMSG(6)="  Patient.........: "_VADM(1)_" ("_$TR(VA("PID"),"-")_")"
 S PSBMSG(7)="  Ward/Bed........: "_$$GET1^DIQ(2,DFN_",",.1)_"/"_$$GET1^DIQ(2,DFN_",",.101)
 S PSBMSG(8)="  Reason..........: "_PSB3
 S PSBMSG(9)="  Schedule........: "_PSB4
 I $D(PSB5) S PSBMSG(10)="  Action Dt/Tm....: "_PSB5
 I $D(PSB6) S PSBMSG(11)="  BCMA Med Log IEN: "_PSB6
 I $D(PSB7) S PSBMSG(12)="  User............: "_PSB7
 S XMY("G."_PSBMG)="",XMTEXT="PSBMSG(",XMSUB="BCMA - "_$S($G(PSBADMER):"Admin "_$G(PSB6),1:"Order")_" Problem"
 K PSBADMER
 D ^XMD
 K PSB1,PSB2,PSB3,PSB4,PSBMSG,PSBMG,XMY,XMSUB,XMTEXT
 Q
 ;
MSFMSG(PSB1,PSB2,PSB3,PSB4,PSB5,PSB6,PSB7,PSB8,XFLG) ;
 ; PSB1 = Patient IEN
 ; PSB2 = Ward Location/Room
 ; PSB3 = Reason
 ; PSB4 = Type of Scan Issue
 ; PSB5 = Event date/time
 ; PSB6 = User's Comment
 ; PSB7 = User identification
 ; PSB8 = Order Number
 ; XFLG = -1 IF UNSUCCESSFU
 ;
 S PSBMG=$$GET^XPAR("DIV","PSB MG SCANNING FAILURES",,"E"),PSBX1=9
 I PSBMG="" S XFLG(0)=-1 Q
 I PSB2["$" S PSB2=$TR(PSB2,"$","/")
 K PSBDROP
 ;
 ; Dynamic - Add the 'user' to Group if not a member!
 I '$$MEMBER^XMXAPIG(DUZ,PSBMG) S XMY(DUZ)="",X=$$MG^XMBGRP(PSBMG,"","","",.XMY,"","") S:X>0 PSBDROP(0)=DUZ K XMY
 ;
 S PSBMSG(1)="  The following BCMA Unable to Scan event has occurred:"
 S PSBMSG(2)=" "
 S PSBMSG(3)="  User.....................:  "_PSB7
 S PSBMSG(4)="  Date/Time of Event.......:  "_PSB5
 N PSBDPT S PSBDPT="" I +$G(PSB1)>0 S DFN=PSB1 D DEM^VADPT S PSBDPT=VADM(1)_" ("_VA("BID")_")"
 S PSBMSG(5)="  Patient..................:  "_PSBDPT
 S PSBMSG(6)="  Order Number.............:  "_$S(PSB8]"":PSB8,1:"N/A")
 S PSBMSG(7)="  Ward Location/Room.......:  "_PSB2
 S PSBMSG(8)="  Type of Barcode Issue....:  "_PSB4
 I PSB4="Medication" D
 .I PSB8]"" D CLEAN^PSBVT,PSJ1^PSBVT(DFN,PSB8)
 .I $D(PSBSFUID),$G(PSBSFUID)]"" D  Q
 ..D  ;Set the Unique ID value
 ...I PSB6["Verify 5 Rights Override" S PSBSFUID="WARD STOCK" Q
 ...I PSBSFUID="WS" S PSBSFUID="WARD STOCK" Q
 ...I PSBSFUID["WS" S PSBSFUID="WARD STOCK ("_PSBSFUID_")"
 ..S PSBMSG(PSBX1)="  Unique ID................:  "_PSBSFUID,PSBX1=PSBX1+1
 ..S PSBMSG(PSBX1)="  Orderable Item...........:  "_PSBOITX,PSBX1=PSBX1+1
 .I '$D(PSBSFUID),$G(PSBMEDNM)]"" D  Q
 ..I $D(PSBMEDNM) S PSBMSG(PSBX1)="  Dispense Drug............:  "_PSBMEDNM_$S($G(PSBMEDOI)]"":" ("_PSBMEDOI_")",1:""),PSBX1=PSBX1+1
 ..I $G(PSBDOSE)]"" S PSBMSG(PSBX1)="  Dosage Ordered...........:  "_PSBDOSE,PSBX1=PSBX1+1 Q
 .I '$D(PSBSFUID),$G(PSBMEDNM)="" D  Q
 ..S PSBMSG(PSBX1)="  Unique ID................:  WARD STOCK",PSBX1=PSBX1+1
 ..S PSBMSG(PSBX1)="  Orderable Item...........:  "_PSBOITX,PSBX1=PSBX1+1
 S PSBMSG(PSBX1)="  Reason Unable to Scan....:  "_PSB3,PSBX1=PSBX1+1
 S PSB6=$S($E(PSB6,1,2)="!~":$TR(PSB6,"!~",""),1:$TR(PSB6,"!~"," ")) I $E(PSB6,1)=" " S PSB6=$E(PSB6,2,999)
 S PSBX2="  User's Comment...........:  "_PSB6
 D  ;Wrap user comment if neccesary
 .N FL S FL=PSBX1
 .I $L(PSBX2)'>75 S PSBMSG(PSBX1)=PSBX2 Q
 .F PSBX3=1:1:$L(PSBX2," ") D
 ..I $L($P(PSBX2," ",1,PSBX3))>75 S PSBMSG(PSBX1)=$S(PSBX1=FL:"",1:"  ")_$P(PSBX2," ",1,PSBX3-1),PSBX2=$P(PSBX2," ",PSBX3,999),PSBX1=PSBX1+1,PSBX3=1
 .I $L(PSBX2)>0 S PSBMSG(PSBX1+1)="  "_PSBX2
 S XMY("G."_PSBMG)="",XMTEXT="PSBMSG(",XMSUB="BCMA - Unable to Scan "_PSB4_":   "_PSB2
 D ^XMD ; Send Message
 ;
 ; Clean-up
 K PSBMSG,XMY,XMSUB,XMTEXT,PSBX1,PSBX2,PSBX3
 ;
 ; Dynamic - Remove the user from Group if not a member originally!
 I $D(PSBDROP(0)) S XMY(PSBDROP(0))="",X=$$DM^XMBGRP(PSBMG,.XMY)
 F XX=1:1 Q:'$D(PSBDROP(XX))  S XMY(PSBDROP(XX))="",X=$$DM^XMBGRP(PSBMG,.XMY)
CLEANMSF K PSBDROP,PSBMG,XMY
 Q
 ;
