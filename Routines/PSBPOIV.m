PSBPOIV ;BIRMINGHAM/EFC-IV PARAMETER VALIDATION ;Mar 2004
 ;;3.0;BAR CODE MED ADMIN;**2**;Mar 2004;Build 22
 ;;Per VHA Directive 2004-038 (or future revisions regarding same), this routine should not be modified.
 ;
 ; Reference/IA
 ; ^DIC(42/2440
 ; EN^PSJBCMA2/2830
 ; VADPT/10061
 ;
 ;
EN(PSBDFN,PSBORD) ;
 ;
 S DFN=PSBDFN,(PSBMI,PSBMW,PSBMWC,PSBMAUD)=0,(PSBMIDT,PSBMIM)="",PSBONXS=PSBORD_"^"
 K ^TMP("PSBAR",$J) S ^TMP("PSBAR",$J,"W",0)=0
 D CLEAN^PSBVT,PSJ1^PSBVT(DFN,PSBORD)
 ; get IV parameters for the current ward
 S PSBCSTR="^ADDITIVE^STRENGTH^BOTTLE^SOLUTION^VOLUME^INFUSION RATE^MED ROUTE^SCHEDULE^ADMIN TIME^REMARKS^OTHER PRINT INFO^PROVIDER^START DATE/TIME^STOP DATE/TIME^PROVIDER COMMENTS"
 D INP^VADPT S PSBWARD=$P(VAIN(4),"^"),PSBWDIV=PSBWARD D KVAR^VADPT
 I $G(PSBWARD)'="",$D(^PSB(53.66,"B",PSBWARD)) D  ; if IV paramaters defined for ward use them
 .S PSBWARD=$O(^PSB(53.66,"B",PSBWARD,""))
 .S:$D(^PSB(53.66,PSBWARD,1,"B",PSBIVT)) PSBIVPAR=^PSB(53.66,PSBWARD,1,$O(^PSB(53.66,PSBWARD,1,"B",PSBIVT,""),-1),0)
 I '$D(PSBIVPAR) S PSBIVPAR=PSBIVT D  ; if IV parameters not defined for ward get defaults for division
 .D:$D(PSBWDIV)  ; Get the appropriate DIV for ward and DIVISIONAL IV PARAMETERS
 ..S PSBWDIV=$$GET1^DIQ(42,PSBWDIV_",",.015,"I")
 ..I $G(PSBWDIV)']"" S PSBWDIV="DIV"
 ..E  S PSBWDIV=$P($$SITE^VASITE(DT,PSBWDIV),U,1),PSBWDIV="DIV.`"_PSBWDIV
 ..F X=2:1 Q:$P(PSBCSTR,U,X)=""  S PSBIVPAR=PSBIVPAR_U_$P($P($$GET^XPAR(PSBWDIV,"PSBIV "_$P(PSBCSTR,U,X),PSBIVT,"B"),U,2),"-",1)
 ..K PSBWDIV ; Kill temp variable.
 F PSBC1=1:1 Q:$P(PSBONXS,U,PSBC1)=""  D  ; process all orders
 .D CLEAN^PSBVT,PSJ1^PSBVT(DFN,$P(PSBONXS,U,PSBC1))
 .K PSBPONX2 I $G(PSBPONX)]"",$G(PSBPONX)["P" S PSBPONX2=PSBPONX D  ; Must compare "active" orders for changes made - look beyond "pendings"
 ..F  D CLEAN^PSBVT,PSJ1^PSBVT(DFN,PSBPONX2) S PSBPONX2=PSBPONX Q:(PSBPONX2="")!(PSBPONX2'["P")  ;
 ..D CLEAN^PSBVT,PSJ1^PSBVT(DFN,$P(PSBONXS,U,PSBC1))  ; Refresh data
 ..S:$D(PSBPONX2) PSBPONX=PSBPONX2 K PSBPONX2
 .Q:($L(U_PSBONXS,U_PSBPONX_U)-1)>0
 .I $G(PSBPONX)]"" S PSBONXS=PSBONXS_PSBPONX_U
 .K ^TMP("PSJ2",$J) S PSBMAUD=0 D EN^PSJBCMA2(PSBDFN,PSBONX,1)  ; check IV parameters against activity log for this order when no "I"nvalid message
 .I PSBMI=0 F X=1:1 Q:'$D(^TMP("PSJ2",$J,X))  S PSBCHKV=U_$P(^TMP("PSJ2",$J,X,1),U,3)_U I PSBCSTR[PSBCHKV D MSG(PSBCHKV,$P(^TMP("PSJ2",$J,X,1),U,1)) S PSBMAUD=1
 .K ^TMP("PSJ2",$J)
 .I PSBMI=0,$G(PSBPONX)]"" D SAVEPAR,CHKORD  ; check IV parameters against previous order when no "I"nvalid message
 .D CLEAN^PSBVT,PSJ1^PSBVT(DFN,$P(PSBONXS,U,PSBC1))  ; restore variable for this order
 .; okay - we have invalids and warnings through this order so process bags for this order
 .I '$D(PSBUIDA) Q  ; got errors and warning but no bags printed for this order - go to the next
 .S PSBUID="" F  S PSBUID=$O(PSBUIDA(PSBUID),-1) Q:PSBUID=""  D
 ..F PSBC2=1:1 S PSBMONX=$P(PSBONXS,U,PSBC2) Q:PSBMONX=""  D  ; check if bag is in 53.79
 ...I $D(^PSB(53.79,"AUID",PSBDFN,PSBMONX,PSBUID)) D
 ....S PSBIEN=$O(^PSB(53.79,"AUID",PSBDFN,PSBMONX,PSBUID,""))
 ....S PSBPDT=$P(PSBLBLA(PSBUID),U,1),PSBLSTS=$P(PSBLBLA(PSBUID),3)
 ....S $P(X,U,2)=$P(^PSB(53.79,PSBIEN,0),U,9)  ; add action status
 ....S $P(X,U,3)=$P(^PSB(53.79,PSBIEN,0),U,6)  ; add action date/time
 ....S $P(X,U,4)=$P(^PSB(53.79,PSBIEN,.1),U,1)  ; add order ID was administered for
 ..S $P(X,U,5)=PSBONX  ; add order ID was printed for
 ..S $P(X,U,6)=PSBOSTS  ; add order status
 ..S $P(X,U,7)=$P(PSBLBLA(PSBUID),U,1)  ; add date/time ID was printed
 ..S $P(X,U,8)=$P(PSBLBLA(PSBUID),U,3)  ; add lable status from pharmacy
 ..S $P(X,U,9)=""  ; 9 open for later development
 ..S $P(X,U,10)=PSBUIDA(PSBUID)  ; add return from PSJ1
 ..D BWAR
 ..I PSBMW=1 S PSBMWS="W;" F I=1:1:^TMP("PSBAR",$J,"W",0) D  S $P(X,U,1)=$P(PSBMWS,";",1,$L(PSBMWS,";")-1)
 ...I $P(PSBLBLA(PSBUID),U,1)'>$P(^TMP("PSBAR",$J,"W",I),U,2) D
 ....S:(PSBONX=$P(PSBONXS,U,1))&(PSBMAUD=1) PSBMWS=PSBMWS_I_";"
 ....S:PSBONX'=$P(PSBONXS,U,1) PSBMWS=PSBMWS_I_";"
 ..I PSBMIDT'="",$P(PSBLBLA(PSBUID),U,1)<PSBMIDT D
 ...S:(PSBONX=$P(PSBONXS,U,1))&(PSBMAUD=1) $P(X,U,1)="I"
 ...S:(PSBONX'=$P(PSBONXS,U,1)) $P(X,U,1)="I"
 ..S ^TMP("PSBAR",$J,PSBUID)=X K X
 D CLEAN^PSBVT
 K PSBC1,PSBC2,PSBSCHV,PSBCSTR,PSBIVPAR,PSBMI,PSBMIDT,PSBMIM,PSBMONX,PSBMW,PSBSPAR,PSBUID,PSBWARD
 K PSBADA,PSBSOLA,PSBOTMP
 I ^TMP("PSBAR",$J,"W",0)=0 K ^TMP("PSBAR",$J,"W",0)
 D PSJ1^PSBVT(DFN,PSBORD)  ; restore variables for calling order
 Q
 ;
SAVEPAR ; save parameters from current order
 K PSBOTMP
 I $D(PSBADA) M PSBOTMP("ADD")=PSBADA E  S PSBOTMP("ADD")=""  ; additive, strength, bottle
 I $D(PSBSOLA) M PSBOTMP("SOL")=PSBSOLA E  S PSBOTMP("SOL")=""  ; solution, volume,
 K PSBADA,PSBSOLA
 S PSBOTMP("INFUSION RATE")=$G(PSBIFR),PSBOTMP("MED ROUTE")=$G(PSBMR)
 S PSBOTMP("SCHEDULE")=$G(PSBSCH),PSBOTMP("ADMIN TIME")=$G(PSBADST)
 S PSBOTMP("REMARKS")=$G(PSBRMRK),PSBOTMP("OTHER PRINT INFO")=$G(PSBOTXT)
 S PSBOTMP("PROVIDER")=PSBMD,PSBOTMP("START DATE/TIME")=PSBOST
 S PSBOTMP("STOP DATE/TIME")=PSBOSP
 D CLEAN^PSBVT,PSJ1^PSBVT(DFN,$P(PSBONXS,U,PSBC1+1))  ; setup previous order variables
 Q
 ;
CHKORD ; check previous order against current order
 I $D(PSBADA)!($D(PSBOTMP("ADD"))) D CHKADD Q:PSBMI=1
 I $D(PSBSOLA)!($D(PSBOTMP("SOL"))) D CHKSOL Q:PSBMI=1
 I PSBIFR'=PSBOTMP("INFUSION RATE") D MSG("INFUSION RATE",PSBOSP) Q:PSBMI=1
 I PSBMR'=PSBOTMP("MED ROUTE") D MSG("MED ROUTE",PSBOSP) Q:PSBMI=1
 I PSBSCH'=PSBOTMP("SCHEDULE") D MSG("SCHEDULE",PSBOSP) Q:PSBMI=1
 I PSBADST'=PSBOTMP("ADMIN TIME") D MSG("ADMIN TIME",PSBOSP) Q:PSBMI=1
 I PSBRMRK'=PSBOTMP("REMARKS") D MSG("REMARKS",PSBOSP) Q:PSBMI=1
 I PSBOTXT'=PSBOTMP("OTHER PRINT INFO") D MSG("OTHER PRINT INFO",PSBOSP) Q:PSBMI=1
 I PSBMD'=PSBOTMP("PROVIDER") D MSG("PROVIDER",PSBOSP) Q:PSBMI=1
 I $E(PSBOST,1,10)'=$E(PSBOTMP("START DATE/TIME"),1,10) D MSG("START DATE/TIME",PSBOSP) Q:PSBMI=1
 I $E(PSBOSP,1,10)'=$E(PSBOTMP("STOP DATE/TIME"),1,10) D MSG("STOP DATE/TIME",PSBOSP)
 Q
CHKADD ;
 N X,Y
 I '$D(PSBADA),'$D(PSBOTMP("ADD")) Q  ; no additives
 I $O(PSBADA(""),-1)>$O(PSBOTMP("ADD",""),-1) D MSG("ADDITIVE",PSBOSP) Q  ;previous order has addtives not in current order
 I $O(PSBADA(""),-1)<$O(PSBOTMP("ADD",""),-1) D MSG("ADDITIVE",PSBOSP) Q  ;previous order missing additives in current order
 S X="" F  S X=$O(PSBADA(X)) Q:X=""  D  Q  ; check that additives, strength, and bottle are the same
 .I PSBADA(X)=PSBOTMP("ADD",X) Q  ; everything the same
 .I $P(PSBADA(X),U,2)'=$P(PSBOTMP("ADD",X),U,2) D MSG("ADDITIVE",PSBOSP) Q
 .I $P(PSBADA(X),U,4)'=$P(PSBOTMP("ADD",X),U,4) D MSG("STRENGTH",PSBOSP) Q
 Q
 ;
CHKSOL ;
 N X,Y
 I '$D(PSBSOLA),'$D(PSBOTMP("SOL")) Q  ; no solutions
 I $O(PSBSOLA(""),-1)>$O(PSBOTMP("SOL",""),-1) D MSG("SOLUTION",PSBOSP) Q  ;previous order has solutions not in current order
 I $O(PSBSOLA(""),-1)<$O(PSBOTMP("SOL",""),-1) D MSG("SOLUTION",PSBOSP) Q  ;previous order missing solutions in current order
 S X="" F  S X=$O(PSBSOLA(X)) Q:X=""  D  Q  ; check that solutions volume are the same
 .I PSBSOLA(X)=PSBOTMP("SOL",X) Q  ; everything the same
 .I $P(PSBSOLA(X),U,2)'=$P(PSBOTMP("SOL",X),U,2) D MSG("SOLUTION",PSBOSP) Q
 .I $P(PSBSOLA(X),U,4)'=$P(PSBOTMP("SOL",X),U,4) D MSG("VOLUME",PSBOSP) Q
 Q
 ;
BWAR ;
 N X,Y,Z,PSBONX
 S X=^TMP("PSBAR",$J,"W",0)+1
 S Z="" F Z=1:1 S PSBONX=$P(PSBONXS,U,Z) Q:$G(PSBONX)=""  D  ; Display "Warning"s for changes 
 .I '$D(PSBMWAR(PSBONX)) Q
 .S Y="" F  S Y=$O(PSBMWAR(PSBONX,Y)) Q:Y'?.N1".".N  D
 ..S Z="",PSBYS="" F  S Z=$O(PSBMWAR(PSBONX,Y,Z)) Q:Z=""  S PSBYS=PSBYS_Z_";"
 ..S PSBYS=$P(PSBYS,";",1,$L(PSBYS,";")-1)
 ..S ^TMP("PSBAR",$J,"W",X)=PSBONX_U_Y_U_"2^The "_PSBYS_" was changed on",^TMP("PSBAR",$J,"W",0)=X,X=X+1
 .K PSBMWAR(PSBONX)
 Q
 ;
MSG(PSBMVAR,PSBDATE) ;
 I PSBMI=1 Q  ;already have an invalid don't need anymore
 F Y=1:1 S PSBSPAR=$P(PSBCSTR,U,Y) I PSBSPAR=$TR(PSBMVAR,"^") D  Q
 .I $P(PSBIVPAR,U,Y)="W" D
 ..S PSBMVAR=$TR(PSBMVAR,"^")
 ..I PSBMW=0 S PSBMW=1
 ..S PSBMWC=PSBMWC+1,PSBMWM="2^The "_PSBSPAR_" has been changed."
 ..I $D(PSBMWAR(PSBONX,PSBMVAR)) S PSBOLDT=$O(PSBMWAR(PSBONX,PSBMVAR,"")) I PSBOLDT<$E(PSBDATE,1,12) K PSBMWAR(PSBONX,PSBMVAR,PSBOLDT)
 ..S PSBMWAR(PSBONX,PSBMVAR,$E(PSBDATE,1,12))=""
 ..S PSBMWAR(PSBONX,$E(PSBDATE,1,12),PSBMVAR)=""
 .I $P(PSBIVPAR,U,Y)="I" S PSBMI=1,PSBMIDT=PSBDATE,PSBMIM="-1^IV invalid "_PSBSPAR_".",^TMP("PSBAR",$J,"I")=PSBONX_U_PSBMIDT_U_PSBMIM
 Q
