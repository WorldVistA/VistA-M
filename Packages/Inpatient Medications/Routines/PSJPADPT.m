PSJPADPT ;BIR/JCH - PADE Activity Utility ;09/22/11 5:00pm
 ;;5.0;INPATIENT MEDICATIONS;**317**;16 DEC 97;Build 130
 ;
 ; References to ^PSSDSAPM is supported by DBIA 5570.
 ; Reference to FULL^VALM1 is supported by DBIA 10116.
 ; Reference to $$FMTE^XLFDT is supported by DBIA 10103.
 ; Reference to ^PSDRUG is supported by DBIA 2192.
 ;
PADECK ;
 N PSJTCNT,PSJTSCR
 K VALMBCK
 S PSJPADPT=1,PSJTSCR=15
 D FULL^VALM1
 I '$$ACTIVITY(DFN,PSJTSCR) D
 .W !!,"No PADE activity on file",!
 .K DIR S DIR(0)="EAO",DIR("A")="Press Return to Continue..." D ^DIR K DIR W @IOF
 .W @IOF
PADEND S VALMBCK="R"
 K PSJPADPT
 Q
 ;
ACTIVITY(DFN,PSJTSCR) ; Get PADE activity for patient DFN, display to screen length PSJTSCR
 N PSPDT,PSPDRG,PSTRANS,PSJPOP,PSJCONT,PSJPAGE,PSJPGTMP
 K DIR W @IOF
 S (PSJTCNT,PSJPOP,PSJPAGE)=0
 S PSPDT=99999999 F  S PSPDT=$O(^PS(58.6,"P",+$G(DFN),PSPDT),-1) Q:'PSPDT!PSJPOP  D
 .S PSPDRG="" F  S PSPDRG=$O(^PS(58.6,"P",+$G(DFN),PSPDT,PSPDRG)) Q:(PSPDRG="")!PSJPOP  D
 ..S PSTRANS=0 F  S PSTRANS=$O(^PS(58.6,"P",+$G(DFN),PSPDT,PSPDRG,PSTRANS)) Q:'PSTRANS!PSJPOP  D
 ...S PSJCONT=$G(PSJCONT)+1
 ...I 'PSJTCNT D PGHEAD
 ...N PSEXDT,PSEXTM,PSEXDRG,PSJCAB,PSJQTY,PSJSTS,PSJORD,ND0,ND1,ND2,PSEXDRG2,PSJOVOK,PSJQAR
 ...S ND0=$G(^PS(58.6,PSTRANS,0)),ND1=$G(^PS(58.6,PSTRANS,1))
 ...S PSEXDT=$$PSEXDT(PSPDT)
 ...S PSEXDRG=$S($G(PSPDRG):$P($G(^PSDRUG(+PSPDRG,0)),"^"),1:$P(PSPDRG,"zz",2))
 ...I PSPDRG="zz~UNKNOWN" S PSEXDRG2=$P(ND1,"^",6) I PSEXDRG2]"" S PSEXDRG=PSEXDRG2
 ...S:$L(PSEXDRG)>36 PSEXDRG=$E(PSEXDRG,1,36)_"_"
 ...S PSJORD=$P(ND1,"^")
 ...S PSJQTY=$P(ND0,"^",4) I PSJQTY["." N PSJDEC S PSJDEC="."_$E($P(PSJQTY,".",2),1,2) D
 ....I 'PSJDEC!(PSJDEC=".") S PSJQTY=$P(PSJQTY,".") Q  ; insignificant trailing zeroes
 ....S PSJQTY=$P(PSJQTY,".")_+PSJDEC
 ...S PSJCAB=$P(ND0,"^",2)
 ...S PSJSTS=$P(ND0,"^",5)
 ...S PSJQAR(5)=PSJSTS,PSJQAR(6)=PSJQTY N PSJSIGN S PSJSIGN=$$TSIGN^PSJPADIT(.PSJQAR) S:PSJQTY["-" PSJQTY=$P(PSJQTY,"-",2) S PSJQTY=PSJSIGN_PSJQTY
 ...S PSJOVOK=$S(PSJSTS="V":1,PSJSTS="R":1,PSJSTS="W":1,1:0)
 ...S PSJSTS=$S(PSJSTS="V":"DISP",PSJSTS="R":"RTN",PSJSTS="W":"WASTE",PSJSTS="D":"DESTK",PSJSTS="L":"LOAD",PSJSTS="U":"UNLD",PSJSTS="F":"FILL",PSJSTS="N":"CANCL",PSJSTS="C":"COUNT",PSJSTS="E":"EXP",PSJSTS="A":"DISCR",1:PSJSTS)
 ...S:$E(PSJSTS)="W" PSJQTY="NA"
 ...W !,PSEXDT S PSJTCNT=$G(PSJTCNT)+1
 ...W ?15,$S(PSJORD:"N",'PSJOVOK:"",1:"Y"),?18,$E(PSEXDRG,1,39),?56,$E(PSJSTS,1,6),?62,$J(PSJQTY,3),?69,PSJCAB
 ...S ND2=$P($G(^PS(58.6,PSTRANS,2)),"^") I ND2]"" W !,"   Comment: ",$E(ND2,1,66) S PSJTCNT=$G(PSJTCNT)+1
 ...I (PSJTCNT\PSJTSCR)>PSJPAGE D CONTINUE(.PSJPAGE)
 ...S PSJPGTMP=PSJPAGE
 I $G(PSJCONT) D CONTINUE(.PSJPAGE)
 K DIR W @IOF
 Q PSJTCNT
 ;
PGHEAD ; Print Page Header
 W !,"Pharmacy Automated Dispensing Equipment (PADE) Activity Log"
 D COHEAD
 Q
 ;
COHEAD ; Print Column Header
 W @IOF
 W !!,"Date/Time",?14,"O-R",?18,"Item",?55,"Status",?63,"Qty",?69,"PADE ID"
 W !,"================================================================================"
 Q
 ;
CONTINUE(PSJPAGE)  ; Press return to continue
 N X,DIR
 S DIR("A",1)=" "
 S DIR(0)="EAO",DIR("A")="Press Return to Continue..." D ^DIR S:$G(X)="^" PSJPOP=1
 K DIR
 D COHEAD
 S PSJPAGE=$G(PSJPAGE)+1
 K PSJCONT
 Q
 ;
PSEXDT(DT) ; Format Date for display
 N XDT,XTM,I
 S XDT=$P($TR($$FMTE^XLFDT(DT,2),"@"," "),":",1,2)
 S XTM=$P(XDT," ",2)
 F I=1:1:3 S $P(XDT,"/",I)=$TR($J(+$P(XDT,"/",I),2)," ",0)
 S XDT=XDT_" "_XTM
 Q XDT
 ;
ASKRESET(PADE)  ; Prompt to reset PADE device balances
 N DIR,X,Y
 S DIR(0)="Y",DIR("A")="RESET/INITIALIZE PADE DEVICE"
 S DIR("?")="^D RESHLP^PSJPADPT"
 S DIR("B")="N" D ^DIR
 I 'Y D MANUN^PSJPAD70(PADE) Q
 Q:'$$SURES()
 D CONTRES(PADE)
 Q
 ;
SURES()  ; Ask user if they're really sure about deleting all meds from device
 N DIR,X,Y
 S DIR(0)="Y"
 S DIR("A",1)=" "
 S DIR("A",2)="     CAUTION: THIS WILL DELETE THE LIST OF MEDICATIONS"
 S DIR("A",3)="      LINKED TO THIS PADE CABINET (in VistA only)."
 S DIR("A",4)=" "
 S DIR("A")="Are you sure you want to do this",DIR("B")="N"
 S DIR("?")="^D RESHLP^PSJPADPT"
 D ^DIR
 Q Y
 ;
CONTRES(PADE) ;  Finish device reset
 N FDA,PSPADER
 I '$$RESPADE(PADE) W " ...Unable to reset "_$G(PADE) Q
 S FDA(58.639,"?+1,"_+PADE_",",.01)=$$NOW^XLFDT()
 D UPDATE^DIE("","FDA","PSPADER")
 I $G(PSPADER(1,0))="+" W "  ...PADE initialization complete."
 Q
 ;
RESPADE(PADE) ; Reset balances in PADE cabinet to zero
 N DRUG,DRAWER,POCKET,SUBPCK,PSJPSYS,DIK,DA,PADIEN,PADENAM,PSPADER,PSJY
 D GETS^DIQ(58.63,PADE_",",1,"I","PSJPSYS")
 S PSJPSYS=$G(PSJPSYS("58.63",+PADE_",",1,"I"))
 Q:'$G(PSJPSYS)!'$D(^PS(58.601,+$G(PSJPSYS),0)) 0
 S PADENAM=$P($G(^PS(58.63,+PADE,0)),"^")
 S PADIEN=$$FIND1^DIC(58.6011,","_PSJPSYS_",","MX",PADENAM,,,"PSPADER")
 Q:'$G(PADIEN)!'$G(^PS(58.601,+PSJPSYS,"DEVICE",+PADIEN,0)) 0
 S DIK="^PS(58.601,"_+PSJPSYS_",""DEVICE"","_+PADIEN_",""DRAWER"","
 S DA(2)=+PSJPSYS,DA(1)=+PADIEN
 S DRAWER=0 F  S DRAWER=$O(^PS(58.601,+PSJPSYS,"DEVICE",+PADIEN,"DRAWER",DRAWER)) Q:'DRAWER  D
 .S DA=DRAWER D ^DIK
 S DIK="^PS(58.601,"_+PSJPSYS_",""DEVICE"","_+PADIEN_",""DRUG"","
 S DA(2)=+PSJPSYS,DA(1)=+PADIEN
 S DRUG=0 F  S DRUG=$O(^PS(58.601,+PSJPSYS,"DEVICE",+PADIEN,"DRUG",DRUG)) Q:'DRUG  D
 .S DA=DRUG D ^DIK
 Q 1
 ;
EMPTY(PADE)  ; Return 1 if PADE cabinet contains no drugs
 ; INPUT : PADE - Pointer to PADE DISPENSING DEVICE (#58.63) FILE
 N EMPTY
 S EMPTY=0
 I '$D(^PS(58.601,"DEV",+PADE)) S EMPTY=1
 Q EMPTY
 ;
RESHLP  ; Display help text explaining PADE reset
 N HELPAR
 S HELPAR(1)="This action deletes all medications from this PADE cabinet in VistA,"
 S HELPAR(2)="making the cabinet appear empty to VistA users. This does not affect"
 S HELPAR(3)="the vendor system. Resetting a cabinet makes the device unavailable"
 S HELPAR(4)="to the PADE INVENTORY REPORT as it will no longer have inventory."
 S HELPAR(5)="After a PADE cabinet is reset, medications will be added babck to the"
 S HELPAR(6)="cabinet as new HL7 messages are received from the vendor, and the"
 S HELPAR(7)="cabinet will be available again for reports and order entry lookups."
 D EN^DDIOL(.HELPAR)
 Q
 ;
PARTIAL(PSJY,INARRAY,OUTARRAY,DISPDATA,MSG,ARRAYX,FOUND,NOXREF,PSALLPC) ; Lookup PSJY in INARRAY
 ; INPUT  - PSJY=Lookup text
 ;        - INARRAY(text)=number - Array of selectable data
 ; OUTPUT - OUTARRAY(text)=number - Entry selected from INARRAY
 ;
 N PSJPART,ITMNAME,II,ITM,ITMX,Y,PSJTMP,PSJDUP
 K FOUND
 S II=1,ITMID="" F  S ITMID=$O(INARRAY(ITMID)) Q:ITMID=""  D
 .Q:ITMID="IEN"!(ITMID="NAME")
 .S ITM(ITMID)=$P(INARRAY(ITMID),"^"),ITMX(INARRAY(ITMID),ITMID)=$P(INARRAY(ITMID),"^",2)
 ;
 Q:$D(ITM)<10
 F ITM="" F  S ITM=$O(ITM(ITM)) Q:ITM=""  D
 .S PSJDUP=0
 .I $E(ITM,1,$L(PSJY))=PSJY D  Q:'$G(PSJDUP)
 ..N PP,QQ S PP="" F  S PP=$O(PSJPART(PP)) Q:PP=""  S QQ="" F  S QQ=$O(PSJPART(PP,QQ)) Q:QQ=""  I PSJPART(PP,QQ)=ITM(ITM) S PSJDUP=1
 ..Q:$G(PSJDUP)
 ..S PSJPART(II,ITM)=INARRAY(ITM)
 ..S PSJPART(II,ITM)=PSJPART(II,ITM)_"^"_$P($G(ARRAYX(ITM(ITM))),"^",2)
 ..S II=II+1
 .I '$G(NOXREF) I $E(ITM(ITM),1,$L(PSJY))=PSJY D  Q:'$G(PSJDUP)
 ..N PP,QQ S PP="" F  S PP=$O(PSJPART(PP)) Q:PP=""  S QQ="" F  S QQ=$O(PSJPART(PP,QQ)) Q:QQ=""  I PSJPART(PP,QQ)=ITM(ITM) S PSJDUP=1
 ..Q:$G(PSJDUP)
 ..S PSJPART(II,ITM)=ITM(ITM)
 ..S PSJPART(II,ITM)=PSJPART(II,ITM)_"^"_$P($G(ARRAYX(ITM(ITM))),"^",2)
 ..S II=II+1
 .I $$UPPER^HLFNC($E(ITM,1,$L(PSJY)))=$$UPPER^HLFNC(PSJY) D  Q:'$G(PSJDUP)
 ..N PP,QQ S PP="" F  S PP=$O(PSJPART(PP)) Q:PP=""  S QQ="" F  S QQ=$O(PSJPART(PP,QQ)) Q:QQ=""  I PSJPART(PP,QQ)=ITM(ITM) S PSJDUP=1
 ..Q:$G(PSJDUP)
 ..S PSJPART(II,ITM)=INARRAY(ITM)_"^"_$P($G(ARRAYX(ITM(ITM))),"^",2)
 ..S II=II+1
 .I '$G(NOXREF) I $$UPPER^HLFNC($E(ITM(ITM),1,$L(PSJY)))=$$UPPER^HLFNC(PSJY) D  Q:'$G(PSJDUP)
 ..N PP,QQ S PP="" F  S PP=$O(PSJPART(PP)) Q:PP=""  S QQ="" F  S QQ=$O(PSJPART(PP,QQ)) Q:QQ=""  I PSJPART(PP,QQ)=ITM(ITM) S PSJDUP=1
 ..Q:$G(PSJDUP)
 ..S PSJPART(II,ITM)=ITM(ITM)_"^"_$P($G(ARRAYX(ITM(ITM))),"^",2)
 ..S II=II+1
 I $D(PSJPART(1)) D
 .N DIR,STRING,CNT
 .I '$O(PSJPART(1)) S PSJTMP=$O(PSJPART(1,"")) D  Q
 ..S OUTARRAY(PSJTMP)=$S('$G(PSALLPC):$P(PSJPART(1,PSJTMP),"^"),1:PSJPART(1,PSJTMP)),FOUND=1
 ..W !," "_$O(PSJPART(1,"")),?15,$P(PSJPART(1,PSJTMP),"^")
 .I $L($G(MSG)) W !,MSG,!
 .S CNT=0 F  S CNT=$O(PSJPART(CNT)) Q:'CNT  D
 ..N ITMID S ITMID=$O(PSJPART(CNT,""))
 ..S STRING=$G(STRING)_CNT_":"_ITMID_";"
 ..S DIR("A",CNT)="   "_CNT_"      "_ITMID_$S($G(DISPDATA):"  "_$P($G(PSJPART(CNT,ITMID)),"^"),1:"")
 .S DIR("A")="Choose 1-"_+$O(PSJPART(9999999),-1)_": "
 .S DIR(0)="SAO^"_STRING D ^DIR
 .I Y>0 D  Q
 ..N PSPTSEL S PSPTSEL=$O(PSJPART(+Y,""))
 ..S OUTARRAY(PSPTSEL)=$S('$G(PSALLPC):$P(PSJPART(+Y,PSPTSEL),"^"),1:$G(PSJPART(+Y,PSPTSEL))),FOUND=1
 ..N ID2 S ID2=$G(OUTARRAY(PSPTSEL)) I ID2]"" W "  ",$P(ID2,"^")
 .S PSJY=""
 Q
