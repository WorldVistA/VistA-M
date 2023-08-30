PXVXR ;BIR/ADM - CROSS REFERENCE AND OTHER LOGIC ;Dec 20, 2022@13:24:02
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**210,216,211,217,233**;Aug 12, 1996;Build 3
 ;
 Q
EXP ; check for expiration date in the past
 N PXVX,PXVDT,Y
 S PXVDT=X I PXVDT<DT D  Q
 .D EN^DDIOL(">>> The date entered is a past date. <<<","","!!?4") S PXVX=$C(7) D EN^DDIOL(PXVX,"","!")
 .K DIR S DIR("A")=" Are you sure you have entered the correct date",DIR(0)="Y",DIR("B")="NO" D ^DIR K DIR
 .I $D(DTOUT)!$D(DUOUT)!'Y K X Q
 .S X=PXVDT
 Q
INUSE ; input check on LOT NUMBER field (#.01)
 N PXV,PXVIM,PXVLN,PXVMAN,PXVX
 I $D(^AUPNVIMM("LN",DA)) D  Q:'$D(X)
 .D EN^DDIOL("Lot Number already assigned and cannot be edited.","","!!?4")
 .S PXVX=$C(7) D EN^DDIOL(PXVX,"","!") K X
COMB ; check on LOT NUMBER field (#.01) for uniqueness of Immunization Name, Lot Number and Manufacturer combination
 S PXVLN=X
 S PXV=$G(^AUTTIML(DA,0)),PXVMAN=$P(PXV,"^",2),PXVIM=$P(PXV,"^",4) I PXVMAN=""!(PXVIM="") Q
AUCHK N PXVINST,PXVSTN
 S PXVSTN=$P($G(^AUTTIML(DA,0)),"^",10)
 I PXVSTN="",$G(PXVFIEN) S PXVSTN=PXVFIEN
 I PXVSTN'="" S PXVSTN="_#"_PXVSTN,PXVLN=PXVLN_PXVSTN
 I $D(^AUTTIML("AC",PXVIM,PXVMAN,PXVLN)) D  Q
 .D EN^DDIOL("Immunization Name, Lot Number and Manufacturer combination must be unique.","","!!?4")
 .S PXVX=$C(7) D EN^DDIOL(PXVX,"","!") K X
 Q
COMB1 ; input check on MANUFACTURER field (#.02)
 N PXV,PXVIM,PXVLN,PXVMAN,PXVX
 S PXVMAN=X
 S PXV=$G(^AUTTIML(DA,0)),PXVLN=$P(PXV,"^"),PXVIM=$P(PXV,"^",4) I PXVLN=""!(PXVIM="") Q
 D AUCHK
 Q
COMB2 ; input check on VACCINE field (#.04)
 N PXV,PXVIM,PXVLN,PXVMAN,PXVX
 S PXVIM=X
 S PXV=$G(^AUTTIML(DA,0)),PXVLN=$P(PXV,"^"),PXVMAN=$P(PXV,"^",2) I PXVLN=""!(PXVMAN="") Q
 D AUCHK
 Q
 ;
ACT(PXLOT) ; screen immunization with active immunization lot number
 ;
 ; ZEXCEPT: DA,PXCEFIEN,PXCEVIEN,PXD,PXVISIEN
 N PXDT,PXRSLT,PXVIEN,PXIMMIEN,PXVISIT,PXINST
 ;
 S PXRSLT=0
 ;
 ; Get Immunization IEN
 S PXVIEN=$S($D(DA):DA,$G(PXCEFIEN):PXCEFIEN,1:"")
 S PXIMMIEN=$S(PXVIEN:$P(^AUPNVIMM(PXVIEN,0),U),$G(PXD)'="":$P(PXD,"^"),1:"")
 I 'PXIMMIEN Q 0
 ;
 ; Only allow Lots for this Immunization
 I '$D(^AUTTIML("C",PXIMMIEN,PXLOT)) Q 0
 ;
 ; Get Division of Visit
 S PXVISIT=$S(PXVIEN:$P(^AUPNVIMM(PXVIEN,0),"^",3),$G(PXCEVIEN):PXCEVIEN,$G(PXVISIEN):PXVISIEN,1:"")
 S PXINST=$$DIV1(PXVISIT)
 ;
 ; Only allow Lots that belong to this Division
 I PXINST,'$$IMMSEL(PXLOT,PXINST) Q 0
 ;
 ; Check if Lot is active and not expired at the time of the Visit
 S PXDT=""
 I PXVIEN S PXDT=$P($G(^AUPNVIMM(PXVIEN,12)),U,1)
 I 'PXDT,PXVISIT S PXDT=$P($G(^AUPNVSIT(PXVISIT,0)),U,1)
 S PXRSLT=$$LOTSTAT(PXLOT,PXDT)
 ;
 Q PXRSLT
 ;
LOTSTAT(PXLOT,PXDT) ; Check if lot is active and not expired
 ;
 N PXEXPDT,PXNODE,PXSTAT,PXSTATDT,PXSTATIEN
 ;
 I '$G(PXDT) S PXDT=$$NOW^XLFDT()
 ;
 S PXNODE=$G(^AUTTIML(+$G(PXLOT),0))
 I PXNODE="" Q 0
 ;
 ; Check if lot is expired
 S PXEXPDT=$P(PXNODE,U,9)
 I $P(PXDT,".",1)>$P(PXEXPDT,".",1) Q 0
 ;
 ; if lot is active now, let them select it regardless if it was inactive in the past
 I $P(PXNODE,U,3)'>0 Q 1
 ;
 ; If it's inactive now, see if it was active on PXDT
 S PXSTATIEN=""
 I $D(^AUTTIML(PXLOT,1,"B",PXDT)) S PXSTATIEN=$O(^AUTTIML(PXLOT,1,"B",PXDT,0))
 I 'PXSTATIEN D
 . S PXSTATDT=$O(^AUTTIML(PXLOT,1,"B",PXDT),-1)
 . I PXSTATDT S PXSTATIEN=$O(^AUTTIML(PXLOT,1,"B",PXSTATDT,0))
 I PXSTATIEN S PXSTAT=$P($G(^AUTTIML(PXLOT,1,PXSTATIEN,0)),U,3)
 I 'PXSTATIEN D
 . I $D(^AUTTIML(PXLOT,1,"B")) S PXSTAT=0 Q
 . S PXSTAT=$P(PXNODE,U,3)
 I PXSTAT>0 Q 0
 ;
 Q 1
 ;
IMMSEL(PXVLOT,PXVIN) ; is this lot # selectable for this facility
 N PXVST
 S PXVST=0
 I $D(^AUTTIML("AF",PXVIN,PXVLOT))!($P(^AUTTIML(PXVLOT,0),"^",10)="") S PXVST=1
 Q PXVST
 ;
LOT() ;
 N PXVIMM,PXVLN
 S PXVIMM=0 D  Q PXVIMM
 .S PXVLN=0 F  S PXVLN=$O(^AUTTIML("C",Y,PXVLN)) Q:'PXVLN  I $P(^AUTTIML(PXVLN,0),"^",12)>0 S PXVIMM=1 Q
 Q
 ;
DIV1(PXVISIT) ; return division associated with the encounter
 N PXVL
 S (PXVIN,PXVL)=""
 I PXVISIT D
 .S PXVL=$P(^AUPNVSIT(PXVISIT,0),"^",22)
 .I PXVL S PXVIN=$P(^SC(PXVL,0),"^",4)
 .; if hospital location institution is null, set institution to LOC. OF ENCOUNTER in VISIT file
 .; else set institution to Kernel default institution
 .I 'PXVIN S PXVIN=$S($P(^AUPNVSIT(PXVISIT,0),"^",6):$P(^AUPNVSIT(PXVISIT,0),"^",6),$G(DUZ(2)):$G(DUZ(2)),1:$$KSP^XUPARAM("INST"))
 Q PXVIN
 ;
HIST() ; check if historical encounter
 N PXVIEN,PXVHIST,PXVSIT,PXVSRCE
 S PXVHIST=0
 S PXVIEN=$S($G(DA):DA,$G(PXKPIEN):PXKPIEN,$G(PXVNEWIM):PXVNEWIM,1:"") I 'PXVIEN Q PXVHIST
 S PXVSRCE=$P($G(^AUPNVIMM(PXVIEN,13)),"^")
 I PXVSRCE="",$G(PXKAFT("13")) S PXVSRCE=$P(PXKAFT("13"),"^")
 I PXVSRCE S PXVHIST=$S(PXVSRCE=$O(^PXV(920.1,"H","00",0)):0,1:1) Q PXVHIST
 S PXVSIT=$P(^AUPNVIMM(PXVIEN,0),"^",3)
 I $P($G(^AUPNVSIT(PXVSIT,0)),"^",7)="E" S PXVHIST=1
 Q PXVHIST
 ;
DECR ; set logic for AF x-ref in V IMMUNIZATION file
 ; decrement doses unused in IMMUNIZATION LOT file
 ; check if "low stock" message needs to be sent
 ;
 N PXV,PXCURSTOCK,PXIMM,PXINST,PXLOT,PXOLDSTOCK,PXTHRESHOLD,PXVISIT,PXVIMM
 ;
 S PXVIMM=+$G(DA)
 S PXLOT=+$G(X)
 ;
 D
 . N DA,X
 . ;
 . I $$HIST Q
 . ;
 . S PXIMM=$P($G(^AUPNVIMM(PXVIMM,0)),U,1)
 . I 'PXIMM Q
 . S PXVISIT=$P($G(^AUPNVIMM(PXVIMM,0)),U,3)
 . S PXINST=+$$DIV1(PXVISIT)
 . ;
 . L +^AUTTIML("C",PXIMM):$G(DILOCKTM,3)
 . S PXOLDSTOCK=$$STOCKQTY(PXINST,PXIMM)
 . S PXV=$P($G(^AUTTIML(PXLOT,0)),"^",12)
 . I 'PXV D  Q
 . . L -^AUTTIML("C",PXIMM)
 . S PXV=PXV-1
 . S $P(^AUTTIML(PXLOT,0),"^",12)=PXV
 . L -^AUTTIML("C",PXIMM)
 . ;
 . ; check if need to send low stock message
 . I '$$GET^XPAR("DIV.`"_PXINST_"^SYS^PKG","PXV IMM INVENTORY ALERTS",1,"I") Q
 . S PXTHRESHOLD=+$P(PXOLDSTOCK,U,2)
 . S PXOLDSTOCK=$P(PXOLDSTOCK,U,1)
 . S PXCURSTOCK=PXOLDSTOCK-1
 . I PXOLDSTOCK>PXTHRESHOLD,PXCURSTOCK'>PXTHRESHOLD D SENDMSG(PXINST,PXIMM,PXCURSTOCK)
 ;
 Q
 ;
INCR ; kill logic for AF x-ref in V IMMUNIZATION file
 ; increment doses unused in IMMUNIZATION LOT file
 I $$HIST Q
 N PXV
 S PXV=$P($G(^AUTTIML(X,0)),"^",12) I PXV="" Q
 S PXV=PXV+1,$P(^AUTTIML(X,0),"^",12)=PXV
 Q
 ;
STOCKQTY(PXINST,PXIMM) ;
 ; Return the total active stock for this imm/div.
 ; Also, return the largest Low Supply Alert value (this will be used as
 ; the threshold to see if an alert should be sent).
 ;
 N PXLOTNUM,PXNODE0,PXSTOCK,PXTHRESHOLD,PXX
 S PXTHRESHOLD=0
 S PXSTOCK=0
 S PXLOTNUM=0
 F  S PXLOTNUM=$O(^AUTTIML("C",PXIMM,PXLOTNUM)) Q:'PXLOTNUM  D
 . S PXNODE0=$G(^AUTTIML(PXLOTNUM,0))
 . I '$$LOTSTAT(PXLOTNUM) Q  ;Quit if Inactive or expired
 . I '$$IMMSEL(PXLOTNUM,PXINST) Q  ;not linked to this div
 . S PXSTOCK=PXSTOCK+$P(PXNODE0,U,12)
 . S PXX=$P(PXNODE0,U,15)
 . I PXX>PXTHRESHOLD S PXTHRESHOLD=PXX
 Q PXSTOCK_U_PXTHRESHOLD
 ;
SENDMSG(PXINST,PXIMM,PXSTOCK) ; Send MailMan message that stock is low
 N DIWF,DIWL,DIWR,PXBODY,PXIMMNAME,PXINSTNM,PXINSTR,PXMSG,PXTO,X
 S PXIMMNAME=$P($G(^AUTTIMM(PXIMM,0)),"^",1)
 S PXINSTNM=$P($$NS^XUAF4(PXINST),U,1)
 S PXMSG="Low stock of "_$E(PXIMMNAME,1,25)_" for "_$E(PXINSTNM,1,20)
 D EN^DDIOL(">> "_PXMSG_"! <<",,"!!,?2")
 M PXTO=^XUSEC("PXV IMM INVENTORY MGR")
 S PXTO("G.PXV IMM INVENTORY ALERTS")=""
 S X="Low stock of "_PXIMMNAME_" for "_PXINSTNM_". There are "_PXSTOCK_" doses remaining."
 K ^UTILITY($J,"W")
 S DIWL=1
 S DIWR=80
 S DIWF="|"
 D ^DIWP
 M PXBODY=^UTILITY($J,"W",1)
 K ^UTILITY($J,"W")
 S PXINSTR("FROM")="PXV IMM INVENTORY MGR"
 S PXINSTR("LATER")=$$NOW^XLFDT
 D SENDMSG^XMXAPI(DUZ,PXMSG,"PXBODY",.PXTO,.PXINSTR)
 Q
 ;
 ;
 ; Update Immunization Lot Effective Date/Time multiple
 ; Called from AH x-ref IMMUNIZATION LOT file
UPDSTAT(PXIEN,PXOLDSTATUS,PXNEWSTATUS,PXDT,PXUSER) ;
 ;
 N PXIENSUB,PXX
 ;
 I '$G(PXIEN) Q
 I '$D(^AUTTIML(PXIEN,0)) Q
 S PXOLDSTATUS=$G(PXOLDSTATUS)
 S PXNEWSTATUS=$G(PXNEWSTATUS)
 I '$G(PXDT) S PXDT=$$NOW^XLFDT()
 I '$G(PXUSER) S PXUSER=DUZ
 ;
 I PXOLDSTATUS=PXNEWSTATUS,$O(^AUTTIML(PXIEN,1,0)) Q
 ;
 F  Q:'$D(^AUTTIML(PXIEN,1,"B",PXDT))  D
 . S PXDT=$$FMADD^XLFDT(PXDT,,,,1)
 ;
 S PXIENSUB=$O(^AUTTIML(PXIEN,1,"A"),-1)+1
 F  Q:'$D(^AUTTIML(PXIEN,1,PXIENSUB))  D
 . S PXIENSUB=PXIENSUB+1
 ;
 ; this this is called from a x-ref, trying to avoid making
 ; a new FileMan call, and instead using direct sets.
 S ^AUTTIML(PXIEN,1,PXIENSUB,0)=PXDT_U_PXUSER_U_PXNEWSTATUS
 S ^AUTTIML(PXIEN,1,"B",PXDT,PXIENSUB)=""
 I $G(^AUTTIML(PXIEN,1,0))="" S ^AUTTIML(PXIEN,1,0)="^9999999.411DA^0^0"
 S PXX=$P(^AUTTIML(PXIEN,1,0),4)+1
 S $P(^AUTTIML(PXIEN,1,0),U,3,4)=PXIENSUB_U_PXX
 ;
 Q
