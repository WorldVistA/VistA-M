PSIVARH ;AAC/JLS - DISPLAY RECENTLY DC'D IV ORDERS ; 17 Nov 2015  1:53 PM
 ;;5.0;INPATIENT MEDICATIONS;**325**;;Build 37
 ;
EN101(PSIVMSG) ;Entry from protocol PSIVARH PHARMACY
       ;
       N ORIFN,PSJORD,ORVP
       D DECODE^PSIVARH1
       I $G(PSIVPKG(2),"")="" Q
       I PSIVPKG(2)'["PHARMACY" Q
       I ";DC;XO;"'[(";"_$G(PSIVSTS)_";") Q
       ;
       I PSIVSTS="DC" D
       .  S ORIFN=+PSIVIFNF
       .  S PSJORD=$P(PSIVIFNP,U,1)
       .  I PSJORD'["V" Q  ;only IV
       .  S ORVP=DFN
       .  D STORE1(ORIFN,PSJORD,ORVP)
       ;
       I PSIVSTS="XO" D
       .  I PSIVIFNP'="" Q  ;placer # exists so this is not a dc/edit
       .  S ORIFN=$$GET1^DIQ(100,+PSIVIFNF,9,"I")  ;prior orifn
       .  I 'ORIFN Q
       .  S PSIVSTS0=$$GET1^DIQ(100,+ORIFN,5,"I") ;prior status
       .  I PSIVSTS0'=12 Q  ;only dc/edit
       .  S PSJORD=$$GET1^DIQ(100,+ORIFN,33,"I") ;prior pkg ref
       .  I PSJORD'["V" Q   ;ONLY IV
       .  S ORVP=DFN
       .  D STORE1(ORIFN,PSJORD,ORVP)
       K PSIV42,PSIV44,PSIVDUZ,PSIVEDT,PSIVFLD,PSIVIFNF,PSIVIFNP,PSIVLOC,PSIVMSG,PSIVPKG,PSIVRDT
       K PSIVRDUZ,PSIVRM,PSIVSTS,PSIVSTS0
       Q
STORE1(ORIFN,PSJORD,ORVP) ;Get common info
       ;;ORVP
       N QNOW,LOCIEN,LOCNAME,WRDIEN,WG,PSIVF,PHORD,X,Y,%
       S QNOW=$$NOW^XLFDT
       S LOCIEN=$P($G(^OR(100,+ORIFN,0)),U,10) ; p44
       S LOCNAME=$P($G(^SC(+LOCIEN,0)),"^",1)  ;name
       I LOCNAME="" S LOCNAME="NO WARD"
       Q:'LOCIEN
       S WRDIEN=$P($G(^SC(+LOCIEN,42)),U)
       S WG=0
       S:+WRDIEN WG=$O(^PS(57.5,"AB",WRDIEN,WG))
       S PHORD=$$OI(+ORIFN)                    ;;ORDER NUMBER
       I PSJORD["P" S PSIVF=$NA(^PS(53.1,+PSJORD))
       E  S PSIVF=$NA(^PS(55,+ORVP,$S(PSJORD["V":"IV",1:5),+PSJORD))
       ;STORE IF AN IV ORDER AND THE PARAMETER NOT SET TO 0 (FEATURE TURNED OFF)
       I $$IVROFF(ORVP,PSJORD)'=0 D STOREIV
       Q
IVROFF(ORVP,PSJORD) ;
       ;FUNCTION RETURNS IVROOM'S DC'D ORDERS SETTING
       N IVR,IVHRS
       S IVR=$$IVROOM(ORVP,+PSJORD)
       S IVHRS=$P($$GETHRS^PSIVARH1($P(IVR,U,1)),U,3)
       Q IVHRS
       ;
OI(Q)  ;Get pharmacy orderable item
       N QQ,PHORD,PSIVOI,PSIVOID
       S QQ=0,PHORD=0
       F  S QQ=$O(^OR(100,Q,.1,QQ)) Q:'QQ  D
       .  S PSIVOI=$P(^OR(100,Q,.1,QQ,0),U)
       .  S PSIVOID=$P(^ORD(101.43,PSIVOI,0),U,2)
       .  I PSIVOID'["PSP" Q
       .  S PHORD=$P(PSIVOID,";")
       Q PHORD
STOREIV ;Store IV info
       N PSIVMR,PSIVSCH,PSIVDO,DIC,DD,DO,X,Y,%
       S PSIVMR=$P($G(@PSIVF@(.2)),U,3)
       S PSIVMR=$$GET1^DIQ(51.2,PSIVMR,1)  ;abbrev
       I PSIVMR="" S PSIVMR=$$GET1^DIQ(51.2,PSIVMR,.01)  ;long name
       S PSIVMR=$E(PSIVMR,1,5)
       S PSIVSCH=$P($G(@PSIVF@(0)),U,8)
       I +LOCIEN D
       .K DIC S DIC="^PS(52.75,",DIC(0)="LQ",X=QNOW
       .S DIC("DR")="2////"_+ORVP_";3////"_PHORD_";4////"_$G(^DPT(+ORVP,.101),9999)_";5////"_LOCNAME_";7////"_+LOCIEN_";8////"_PSJORD_";9////"_WG_";10////"_$G(PSIVSTS)
       .S DIC("DR")=DIC("DR")_";.662////"_"Give: "_PSIVMR_" "_$TR(PSIVSCH,";",",")
       .D FILE^DICN
       .K DD,DO
       Q
       ;
       ;==========================================================
       ;
START  ;Called from PSGVBW to display orders; Input: PSGSS,WD,WG
       Q:'$D(PSGSS)!("^G^W^"'[(U_$G(PSGSS)_U))
       N PSIVDA,PSIVRI,PSIVWG,PSIVWDI,PSIVWN,WRDIEN,WDSETUP,GRSETUP
       N PSIVXREF,DIC,DR,DIR,WARD,X,HRSFILT,TDNODE,TPNODE
       ;
       ;
       ; global to determine if the user elected to queue the print
       ; if so we don't touch ^TMP( that holds the data that will print
       ;
       ; global to note the IV room the user is signed into.
       ; this is used to screen out orders from the report that
       ; are associated with other IV rooms
       ;
       N SIGNONIV
       S SIGNONIV=+$G(^TMP("PSJUSER",$J,"PSIV","PSIVSN"))
       S SIGNONIV=SIGNONIV_U_$P($G(^PS(59.5,SIGNONIV,0)),U)
       ;
       ;
       N ZTSK,RPTITLE,RPTITLE1,RPTITLE2
       S RPTITLE="IV ORDER D/Cs and EDITS Thru CPRS"
       ;
       ; get the iv room parameter for how far back
       ; to look at IV orders (# of hours--integer)
       ;
       S HRSFILT=$$GETHRS^PSIVARH1(PSIVSN)
       ;
       ; don't display the report if HOURS FILTER parameter
       ; is set to zero.
       ;
       Q:$P(HRSFILT,U,3)=0
       ;
       S RPTITLE1=RPTITLE_" Since "_$$FMTE^XLFDT($P(HRSFILT,U,1),"5M")_" (past "_$P(HRSFILT,U,3)_" hrs)"
       ;
       ;
       ; display DC'd or Edited orders within HRSFILT
       ;
       S (GRSETUP,WDSETUP)=0
       ;
       ;if group or ward selected initialize selection specific vars and check for data
       ; quit if there is no data
       ;
       S:PSGSS="G" GRSETUP=$$GRSETUP(WG)
       Q:GRSETUP<0
       ;
       S:PSGSS="W" WDSETUP=$$WDSETUP(WD)
       Q:WDSETUP<0
       ;
       ; continue display and action loop until user wants to quit
       D ORDLOOP
       D EXIT
       Q
ORDLOOP ;  Loop through orders for each ward or each ward in a group
       ;
       ; PAUSE is set to true if the user up arrowed during the display
       ; so they can be prompted to take action on records that they have
       ; viewed so far
       ;
       N ACTION,PAUSE,PSIVQT,NORECS
       S (NORECS,PAUSE)=0,PSIVQT=""
       F  D  Q:($G(PSIVQT)=1)!(PAUSE)!(NORECS)
       . 
       .; global counts records that displayed (DISP subroutine)
       .; from the signon IV room. If none then give user a message.
       .;
       .N RECCNT S RECCNT=0
       .;
       .; Node setup for ^TMP arrays to hold data to be printed or deleted
       .; Print array needs to be unique ($H) for case where user queues print
       .; and same user then could review or delete entries included in queued print job.
       .;
       .  I $D(TDNODE) D TMPCLEAN^PSIVARH1(TDNODE)
       .  S TDNODE="PSI52.75 DELETE"
       .  I $D(TPNODE) D TMPCLEAN^PSIVARH1(TPNODE)
       .  S TPNODE="PSI52.75 PRINT"_" "_$P($H,",")_$P($H,",",2)
       .;
       .  N PSIVLN
       .  D HEADER(.PSIVLN)
       .  D:PSGSS="G" GLOOP
       .  D:PSGSS="W" WLOOP(WRDIEN)
       .  I RECCNT=0 D  Q
       ..    D NODCD^PSIVARH1("IV room "_$P(SIGNONIV,U,2),$P(HRSFILT,U,3))
       ..    N X S X=$$ASK(1)
       ..    S NORECS=1
       .  Q:PAUSE
       .  S ACTION=$$ACTION^PSIVARH1()
       .;
       .  Q:"R"[ACTION
       .  I "P"[ACTION D PRINT Q
       .  I "D"[ACTION I $$YOURSURE^PSIVARH1() D DELETE(TDNODE) Q
       .  I "I^"[ACTION S PSIVQT=1 Q
       ;
       Q
GRSETUP(WG) ; setup vars for group and return -1 if no data
       ;
       N RETURN,WGRPNM
       S RETURN=0
       S WGRPNM=$P($G(^PS(57.5,$G(WG),0)),U)
       ;
       ;quit if the data check reveals that there are no records within the last HRSFILT
       ;
       I '$$ISDATAG^PSIVARH1(WG) D  Q RETURN
       .  D NODCD^PSIVARH1("ward group "_WGRPNM,$P(HRSFILT,U,3)) S HOLD=$$ASK(1)
       .  S RETURN=-1
       ;
       S PSIVWG=WG
       S RPTITLE2="IV ROOM:  "_$P(SIGNONIV,U,2)_"     GROUP:  "_$P(^PS(57.5,PSIVWG,0),U)
       Q RETURN
WDSETUP(WD) ;
       N RETURN
       S RETURN=0
       S WARD=$P($G(^DIC(42,WD,0)),U)
       ;
       ; find ward ien its a pointer from file 42
       S WRDIEN=+$G(^DIC(42,WD,44))
       ;
       I '$$ISDATAW^PSIVARH1(WRDIEN) D  Q RETURN
       .  D NODCD^PSIVARH1("ward "_WARD,$P(HRSFILT,U,3))
       .  S HOLD=$$ASK(1)
       .  S RETURN=-1
       S RPTITLE2="IV ROOM:  "_$P(SIGNONIV,U,2)_"     WARD:  "_WARD
       Q RETURN
       ;
GLOOP  ;Loop through each ward in the group to display records.
       ;
       N WARD,VWDI
       ;
       S VWDI=0
       F  S VWDI=$O(^PS(57.5,WG,1,"B",VWDI)) Q:'VWDI!PSIVQT  D
       .  S WRDIEN=+$G(^DIC(42,VWDI,44))
       .  I $G(WRDIEN)>0 D
       ..   S WARD=$P($G(^SC(+WRDIEN,0)),U)
       ..   D WLOOP(WRDIEN)
       Q
WLOOP(WRDIEN) ;
       ;ADDED AW NEW COMPOUND INDEX EG
       ;    ^PS(52.75,"AW","C MEDICINE",3160510.11443,5)=""
       ;                      WARD      ROOM    DT         IEN
       N PSIVDA,THISHR
       S THISHR=$P(HRSFILT,U,1)
       F  S THISHR=$O(^PS(52.75,"AW",WRDIEN,THISHR)) Q:'THISHR!PSIVQT  D
       .S PSIVDA=""
       .F  S PSIVDA=$O(^PS(52.75,"AW",WRDIEN,THISHR,PSIVDA)) Q:'PSIVDA!PSIVQT  D
       ..;  quit if the data is not there
       ..  Q:'$D(^PS(52.75,PSIVDA,0))
       ..  D DISP(.PSIVLN)
       ..  D PAUSE(.PSIVLN)
       Q
DISP(PSIVLN)   ;Display data
       N PSIVND,PSIVDT,PSIVPN,PSIVPID,PSIVDRN,PSIVRB,PSIVWN,PSIVSIG
       N PSIVSS,INTDCDT,ORDERNUM
       S PSIVND=^PS(52.75,PSIVDA,0)
       S INTDCDT=$P(PSIVND,U) ; fileman internal discontinue/edit date/time
       S PSIVDT=$$FMTE^XLFDT($P(PSIVND,U),"5MZP")
       N PSIDT,PSITM
       ;
       S PSIDT=$P(PSIVDT," ",1)
       S PSITM=$P(PSIVDT," ",2,3)
       S PSIVPN=$P(PSIVND,U,2)
       S PSIVPID=$E($P($G(^DPT(PSIVPN,0)),U,9),6,9)
       S PSIPNAME=$P($G(^DPT(PSIVPN,0)),U)
       S PSIVDRN=$P(PSIVND,U,3)
       S PSIVSS=$P(PSIVND,U,10)
       S PSIVRB=$P(PSIVND,U,4)
       S PSIVSIG=$G(^PS(52.75,PSIVDA,.662))
       ;
       ; look for IV Room for this order and exclude if not current IV Room
       ;
       N IVROOM,ROOMIEN
       S ORDERNUM=+$P(PSIVND,U,8)
       S IVROOM=$$IVROOM(PSIVPN,ORDERNUM)
       S ROOMIEN=+IVROOM
       Q:(+SIGNONIV'=ROOMIEN)
       ;
       ; count the records that match current IV room. In case there are
       ; none RECORD=0, then don't display action prompt and give user
       ; message that there aren't any records for the signed on IV Room
       ;
       S RECCNT=RECCNT+1
       ;
       ;count display lines for pagination
       ;
       S PSIVLN=PSIVLN+2
       ;
       ; display the data and save a ^TMP version of entries to Print and entries to delete.
       ;
       D DISPLINE(WARD,PSIVRB,PSIVDRN,PSIPNAME,PSIVPID,PSIDT,PSIVSIG,PSITM,PSIVSS)
       D SAVELINE(WRDIEN,WARD,PSIVRB,PSIVDRN,PSIPNAME,PSIVPID,PSIDT,PSIVSIG,PSITM,THISHR,PSIVDA,PSIVSS)
       ;
       Q
       ;
IVROOM(PHPTIEN,ORDERNUM) ;
       ; return IV Room for this dc or edit order
       ;  returns 2 piece--IEN of IV Room ^ display name of IV room
       ;
       N IVROOMEX,IVRMIEN
       S (IVROOMEX,IVRMIEN)=""
       I $G(PHPTIEN)>0&($G(ORDERNUM)>0) S IVRMIEN=$P($G(^PS(55,PHPTIEN,"IV",ORDERNUM,2)),U,2)
       I IVRMIEN>0 S IVROOMEX=$P($G(^PS(59.5,IVRMIEN,0)),U)
       Q IVRMIEN_U_IVROOMEX
       ;
DISPLINE(WARD,PSIVRB,PSIVDRN,PSIPNAME,PSIVPID,PSIDT,PSIVSIG,PSITM,PSIVSS) ;
    ;Display a single line of the data
    ;
       W !?1,$E(WARD,1,9) ;  ward name
       W ?12,$E(PSIVRB,1,8) ;  room-bed
       I $G(PSIVDRN)>0 W ?21,$E($P(^PS(50.7,PSIVDRN,0),U),1,18)
       W ?42,$E(PSIPNAME,1,15) ;  patient name
       W ?59,PSIVPID ;   patient L4
       W ?64,PSIDT ;  date/time .01
       S PSIVSS=$S(PSIVSS="XO":"Edited",PSIVSS="DC":"Discontinued",1:"")
       W !?3,$G(PSIVSS),?22,$E(PSIVSIG,1,42),?65,"@",PSITM
       Q
       ;
       ;
SAVELINE(WRDIEN,WARD,PSIVRB,PSIVDRN,PSIPNAME,PSIVPID,PSIDT,PSIVSIG,PSITM,THISHR,PSIVDA,PSIVSTS) ;
       ;save last displayed record in case we need to protect remaining records from deletion
       ;
       S ^TMP(TDNODE,$J,WRDIEN,THISHR,PSIVDA)=""
       ;
       S ^TMP(TPNODE,$J,WRDIEN,THISHR,PSIVDA)=WARD_U_PSIVRB_U_PSIVDRN_U_PSIPNAME_U_PSIVPID_U_PSIDT_U_PSIVSIG_U_PSITM_U_PSIVSTS
       Q
       ;
PRINT ;
       ;
       N PFLAGDEL ; flag based on users response to whether they want to delete or retain after printing
       S PFLAGDEL=$$PFLAGDEL() Q:PFLAGDEL<0
       ;
       N HOLD W !!,"Only data that you have viewed will be printed." S HOLD=$$ASK(1)
       N %ZIS,POP,IOP
       S %ZIS="MQ"
       D ^%ZIS
       Q:POP
       I $D(IO("Q")) D
       .  K IO("Q")
       .  N ZTDESC,ZTRTN,ZTSAVE
       .  S ZTDESC=RPTITLE1_"-"_RPTITLE2
       .  S ZTRTN="PRINT1^PSIVARH"
       .  S ZTSAVE("^TMP(TPNODE,$J,")=""
       .  S ZTSAVE("TPNODE")=""
       .  S ZTSAVE("RPTITLE1")=""
       .  S ZTSAVE("RPTITLE2")=""
       .  D ^%ZTLOAD
       .  I $D(ZTSK) D
       ..     S ZTREQ="@"
       ..     W !,"Your task number is ",ZTSK," and it has been queued."
       .  E  D
       ..    W !,"Your task was NOT queued."
       E  D
       .  U IO
       .  D PRINT1
       D ^%ZISC K %ZIS,IOP
       S HOLD=$$ASK(1)
       I PFLAGDEL D DELETE(TDNODE)
       Q
       ;
PRINT1 ;
       ;
       ;print records that were viewed and stored in the TMP global
       ;
       ;  S ^TMP("PSI DEL ENTRIES 52.75",1756,77,3160512.143021,9)=
       ; =>       "C MEDICINE^9999^2032^AAADTSXY,QLYJH U^M^2470203^E^2^^PASTOR
       ; =>       ^25^101074507^RCD RCVD FM ROSEBURG OR, 072790-JWR^WOLVINGTON
       ; =>       ^27^^3^331^2900712^^^^1^4507^05/12/2016^Give: IV 4 ml/hr^2:30 pm"
       ;
       N WDIEN,ODATA,WARD,PSIVRB,PSIVDRN,PSIPNAME,PSIVPID,PSIDT,PSIVSIG,PSITM,LCNT,PSIVSS
       S LCNT=0
       D HEADER(.LCNT)
       ;
       S (PSIVQT,WDIEN)=0
       F  S WDIEN=$O(^TMP(TPNODE,$J,WDIEN)) Q:(WDIEN'>0)!PSIVQT  D
       .  S ODT=0
       .  F  S ODT=$O(^TMP(TPNODE,$J,WDIEN,ODT)) Q:(ODT'>0)!PSIVQT  D
       ..    S OIEN=0
       ..    F  S OIEN=$O(^TMP(TPNODE,$J,WDIEN,ODT,OIEN)) Q:(OIEN'>0)!PSIVQT  D
       ...      I OIEN>0 D
       ....        S ODATA=$G(^TMP(TPNODE,$J,WDIEN,ODT,OIEN))
       ....        S WARD=$P(ODATA,U)
       ....        S PSIVRB=$P(ODATA,U,2)
       ....        S PSIVDRN=$P(ODATA,U,3)
       ....        S PSIPNAME=$P(ODATA,U,4)
       ....        S PSIVPID=$P(ODATA,U,5)
       ....        S PSIDT=$P(ODATA,U,6)
       ....        S PSIVSIG=$P(ODATA,U,7)
       ....        S PSITM=$P(ODATA,U,8)
       ....        S PSIVSS=$P(ODATA,U,9)
       ....        D DISPLINE(WARD,PSIVRB,PSIVDRN,PSIPNAME,PSIVPID,PSIDT,PSIVSIG,PSITM,PSIVSS)
       ....        S LCNT=LCNT+2
       ....        D PAUSE(.LCNT)
       W !,"END OF REPORT.",!
       ;
       ;clean up print node if the print job was queued
       ;
       D:$D(ZTSK) TMPCLEAN^PSIVARH1(TPNODE)
       Q
       ;
PFLAGDEL() ; ask user whether to delete after printing.
       N DIR,DUOUT,DTOUT,DIROUT,DIRUT,X,Y
       S DIR("B")="N"
       S DIR(0)="Y",DIR("A")="Do you also want to delete the records that you are printing"
       S DIR("?")="Answer yes to remove the discontinued orders tracking entries after printing."
       S DIR("?",1)="The records you have viewed are from a temporary tracking file"
       S DIR("?",2)="and they can be deleted without any impact to the orders file."
       D ^DIR
       I $D(DIRUT) Q -1
       Q Y
       ;
DELETE(NODE) ;
       ;
       N DIK,WDIEN,ODT,OIEN,DA,HOLD
       S DIK="^PS(52.75,"
       S WDIEN=0
       F  S WDIEN=$O(^TMP(NODE,$J,WDIEN)) Q:(WDIEN'>0)!PSIVQT  D
       .  S ODT=0
       .  F  S ODT=$O(^TMP(NODE,$J,WDIEN,ODT)) Q:(ODT'>0)!PSIVQT  D
       ..    S OIEN=0
       ..    F  S OIEN=$O(^TMP(NODE,$J,WDIEN,ODT,OIEN)) Q:OIEN'>0  D
       ...       S DA=OIEN D ^DIK
       ...       I $E(IOST,1,2)="C-" W "."
       I $E(IOST,1,2)="C-" D
       .  W !,"  Records which you have viewed or printed from"
       .  W !,"  the temporary file--IV MEDICATION ORDERS DC'D (#52.75)"
       .  W !,"  have been removed."
       .  S HOLD=$$ASK(1)
       Q
HEADER(PSIVLN) ;Header
       N PSIVI
       S $P(PSIVI,"-",80)=""
       S PSIVLN=4
       W @IOF,!,?(IOM-$L(RPTITLE1))\2,RPTITLE1
       W !,?(IOM-$L(RPTITLE2))\2,RPTITLE2
       W !?1,"WARD  -  ROOM/BED",?22,"DRUG",?42,"PATIENT",?59,"PID",?65,"DT/TM",!,PSIVI,!
       Q
       ;
ASK(HOLD) ;ask user 2 continue function
       ;return true (1) if user want's 2 stop, false (0) 2 continue.
       ;If HOLD defined, use prompt 2 hold display until user hits return.
       ;If not terminal then, do nothing, return FALSE.
       ;
       N STOP S STOP=0
       I $E(IOST,1,2)="C-" D
       .;
       .  N RESP,DIR S RESP=0
       .  I $G(HOLD) S DIR(0)="EA",DIR("A")="Enter return to continue. "
       .  E  S DIR(0)="E"
       .  D ^DIR I Y="" S STOP=0
       .  I $D(DIRUT) S STOP=1
       Q STOP
       ;
PAUSE(PSIVLN)  ;Btw screens
       ;not to bottom of page yet so don't do anything
       Q:'(($G(PSIVLN)+4)>$G(IOSL))
       ;
       I $E(IOST,1,2)="C-" D
       .  S PSIVQT=$$ASK()
       Q:PSIVQT
       D HEADER(.PSIVLN)
       Q
       ;
TURNOFF(VALUE) ;entry point called from IV room Input transform field 21
       ;
       Q:$G(VALUE)>0 0
       N SURE,Y,X
       S SURE=$$SURE^PSIVARH1()
       I SURE D CLEAN^PSIVARH1
       Q 'SURE
       ;
EXIT   D ^%ZISC
       K PSIVRM,PSIVWD,WARD
       ;
       ; user can print, delete, or print and delete.  if the print is queued,
       ; then the print logic cleans up TMP, otherwise we need to clean it up
       ; now.
       ;
       D TMPCLEAN^PSIVARH1(TDNODE)
       D TMPCLEAN^PSIVARH1(TPNODE)
       Q
       ;
