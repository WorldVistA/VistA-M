SCRPO5 ;BP-CIOFO/KEITH - Historical Patient Assignment Detail ; 01 Jul 99  9:30 PM
 ;;5.3;Scheduling;**177,505**;AUG 13, 1993;Build 20
 ;
PTDET N DIC,SC,DFN,SCPT0,X,Y,SCDT,DTOUT,DUOUT
 D TITL^SCRPW50("Historical Patient Assignment Detail")
 S DIC="^DPT(",DIC(0)="AEMQZ" D ^DIC I $D(DTOUT)!$D(DUOUT) G EXIT
 G:Y<1 EXIT S DFN=+Y,SCPT0=Y(0),SC="SC",SCDT("B")="TODAY"
 G:'$$DTR^SCRPO(.SC,.SCDT,.SCDT) EXIT
 N ZTSAVE F X="DFN","SCPT0","SC(" S ZTSAVE(X)=""
 W ! D EN^XUTMDEVQ("RUN^SCRPO5","Historical Patient Assignment Detail",.ZTSAVE)
EXIT D DISP0^SCRPW23,END^SCRPW50 Q
 ;
RUN ;Print report
 N SCI,SCPNOW,SCLINE,SCPAGE,SCSUB,SCFF,SCFOUND,SCLN,SCAGE,SCDATA
 N SCDOB,SCGEND,SCIFN,SCOUT,SCPNAME,SCREC,SCSH,SCSSN,SCTITL,SCDT
 N SCEU,SCEUNM,SCLEBNM,SCLEDT,SCSTAT,SCSTNM,SCX,SCY
 K ^TMP("SCRPT",$J) M SCDT=SC("DTR") S SCDT="SCDT"
 S SCI=$$GETALL^SCAPMCA(DFN,.SCDT),SCSUB="",(SCFF,SCLN,SCFOUND,SCOUT)=0
 F  S SCSUB=$O(^TMP("SC",$J,DFN,SCSUB)) Q:SCSUB=""!(SCSUB]"PCTM")  D
 .S SCX=$P($T(@SCSUB),";;",2) F SCI=1:1:9 S SCX(SCI)=$P(SCX,U,SCI)
 .S ^TMP("SCRPT",$J,SCX(1))=SCX(2),SCX(3)=U_SCX(3)
 .S SCI=0 F  S SCI=$O(^TMP("SC",$J,DFN,SCSUB,SCI)) Q:'SCI  D
 ..S SCDATA=^TMP("SC",$J,DFN,SCSUB,SCI)
 ..S SCNAME=$P(SCDATA,U,SCX(8))  ;provider/position/team name
 ..S SCIFN=$P(SCDATA,U,SCX(4))  ;history record ifn
 ..S SCACT=$P(SCDATA,U,SCX(5))  ;active date
 ..Q:'SCACT
 ..S SCINAC=$P(SCDATA,U,SCX(6))  ;inactive date
 ..S SCREC=$G(@SCX(3)@(SCIFN,0))  ;history record
 ..Q:'$L(SCREC)
 ..S SCUSER=$P(SCREC,U,SCX(7))  ;user duz
 ..S SCDENT=$P(SCREC,U,SCX(9))  ;date entered
 ..S SCEU=$P(SCREC,U,6),SCEUNM=$$GET1^DIQ(200,SCEU_",",.01)  ;editing user
 ..S SCSTAT=$P(SCREC,U,12),SCSTNM=$$GET1^DIQ(404.43,SCIFN_",",.12)  ;status
 ..S SCLEDT=$P(SCREC,U,8),SCLEBNM=$$GET1^DIQ(200,SCLEDT_",",.01)  ;last edited by
 ..D SLINE(SCX(1),SCNAME,SCACT,SCINAC,SCUSER,SCDENT,SCEUNM,SCSTNM,SCLEBNM,.SCLN)
 ..Q
 .Q
 S SCTITL(1)="<*>  HISTORICAL PATIENT ASSIGNMENT DETAIL  <*>"
 S SCTITL(2)="For assignments effective "_SC("DTR","PBDT")_" to "_SC("DTR","PEDT")
 S SCLINE="",$P(SCLINE,"-",81)="",SCPAGE=1
 S Y=$$NOW^XLFDT() X ^DD("DD") S SCPNOW=$P(Y,":",1,2)
 S SCPNAME=$P(SCPT0,U),SCSSN=$P(SCPT0,U,9)
 S SCGEND=$S($P(SCPT0,U,2)="M":"MALE",1:"FEMALE")
 S (Y,SCAGE)=$P(SCPT0,U,3) X ^DD("DD") S SCDOB=Y
 S SCAGE=$E(DT,1,3)-$E(SCAGE,1,3)-($E(DT,4,7)<$E(SCAGE,4,7))
 D:$E(IOST)="C" DISP0^SCRPW23 D HDR^SCRPO(.SCTITL,80),SHDR
 W:'SCFOUND !!?21,"No assignments found for this patient."
 I SCFOUND S SCSUB=0 F  S SCSUB=$O(^TMP("SCRPT",$J,SCSUB)) Q:'SCSUB!SCOUT  D
 .D:$Y>(IOSL-5) HDR^SCRPO(.SCTITL,80),SHDR Q:SCOUT
 .S SCSH=^TMP("SCRPT",$J,SCSUB)
 .W:SCSUB>1 ! D SSHDR(SCSH) S SCACT=""
 .I '$O(^TMP("SCRPT",$J,SCSUB,"")) W "  (none found)" Q
 .F  S SCACT=$O(^TMP("SCRPT",$J,SCSUB,SCACT)) Q:SCACT=""!SCOUT  D
 ..S SCI=0 F  S SCI=$O(^TMP("SCRPT",$J,SCSUB,SCACT,SCI)) Q:'SCI!SCOUT  D
 ...D:$Y>(IOSL-3) HDR^SCRPO(.SCTITL,80),SHDR,SSHDR(SCSH,1) Q:SCOUT
 ...S SCX=^TMP("SCRPT",$J,SCSUB,SCACT,SCI)
 ...W !,$P(SCX,U),?28,$P(SCX,U,2),?40,$P(SCX,U,3),?52,$P(SCX,U,4)
 ...I SCSUB=3 D
 ....W !,"User Entering: ",$P(SCX,U,6)
 ....W !,"Last Edited By: ",$P(SCX,U,7)
 ....W !,"Status: ",$P(SCX,U,5)
 ...Q
 ..Q
 .Q
 I 'SCOUT,$E(IOST)="C" N DIR S DIR(0)="E" W ! D ^DIR
 K ^TMP("SCRPT",$J) Q
 ;
SHDR ;Subheader
 Q:SCOUT
 W !,"Patient: ",$E(SCPNAME,1,18),?29,"SSN: ",SCSSN,?46,"DOB: ",SCDOB
 W ?64,"AGE: ",SCAGE,?74,$J(SCGEND,6),!,SCLINE
 Q:'SCFOUND
 W !,"Assignment",?28,"Active",?40,"Inactive",?52,"Assigned by/date"
 W !,"--------------------------  ----------  ----------  ----------------------------"
 Q
 ;
SSHDR(X,CONT) ;Subheader
 ;Input: X=category
 ;Input: CONT='1' for continuation (optional)
 W !,X,$S($G(CONT):" (cont.)",1:""),":"
 Q
 ;
SLINE(SCORD,SCNAME,SCACT,SCINAC,SCUSER,SCDENT,SUNM,SCTNM,SCBNM,SCLN) ;Set report global
 ;Input: SCORD=output order
 ;Input: SCNAME=provider/position/team name
 ;Input: SCACT=active date
 ;Input: SCINAC=inactive date
 ;Input: SCUSER=user duz
 ;Input: SCDENT=date entered
 ;Input: SUNM=entered by
 ;Input: SCTNM=status
 ;Input: SCBNM=last edited by
 ;
 ;N SCX,SCY
 S SCFOUND=1,SCLN=SCLN+1
 S SCX=$E(SCNAME,1,25)_U_$$SDT(SCACT)_U_$$SDT(SCINAC),SCY=$$SDT(SCDENT)
 S:$L(SCY) SCY=" ("_SCY_")"
 S SCX=SCX_U_$E($P($G(^VA(200,+SCUSER,0)),U),1,(28-$L(SCY)))_SCY_U_SCTNM_U_SUNM_U_SCBNM
 S ^TMP("SCRPT",$J,SCORD,-SCACT,SCLN)=SCX
 Q
 ;
CODE ;Data handling instructions
 ;  The following $TEXT lines contain data handling instructions
 ;  in the format:  $PIECE 1 = output order
 ;                         2 = subtitle
 ;                         3 = global reference of history record
 ;                         4 = $piece of history record ifn
 ;                         5 = $piece of active date
 ;                         6 = $piece of inactive date
 ;                         7 = $piece of user (in history record)
 ;                         8 = $piece of provider/position/team name
 ;                         9 = $piece of date entered
 ;
NPCPOS ;;7^Non-PC Position^SCPT(404.43)^4^5^6^6^2^7
NPCPPOS ;;9^Non-PC Preceptor Position^SCTM(404.53)^16^14^15^7^2^8
NPCPPR ;;8^Non-PC Preceptor Provider^SCTM(404.52)^11^9^10^7^2^8
NPCPR ;;6^Non-PC Provider^SCTM(404.52)^11^9^10^7^2^8
NPCTM ;;10^Non-PC Team^SCPT(404.42)^3^4^5^11^2^12
PCAP ;;2^PC Associate Provider^SCTM(404.52)^11^9^10^7^2^8
PCPOS ;;3^PC Position^SCPT(404.43)^4^5^6^6^2^7
PCPPOS ;;4^PC Preceptor Position^SCTM(404.53)^16^14^15^7^2^8
PCPR ;;1^PC Provider^SCTM(404.52)^11^9^10^7^2^8
PCTM ;;5^PC Team^SCPT(404.42)^3^4^5^11^2^12
 ;
SDT(X) ;Slashed date
 S X=$E(X,1,7) Q:X'?7N ""
 Q $E(X,4,5)_"/"_$E(X,6,7)_"/"_(17+$E(X))_$E(X,2,3)
