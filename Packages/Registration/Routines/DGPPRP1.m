DGPPRP1 ;LIB/MKN - PRESUMPTIVE PSYCHOSIS STATUS REPORT;08/01/2019
 ;;5.3;Registration;**977**August 01, 2019;;Build 177
 ;
 ;IA's
 ;   402 Ctrl ^SCE("ADFN"
 ;   664 Sup DIVISION^VAUTOMA
 ;  2171 Sup ^XUAF4;  $$STA
 ; 10003 Sup ^%DT
 ; 10004 Sup ^DIQ:    $$GET1, GETS
 ; 10026 Sup ^DIR
 ; 10063 Sup ^%ZTLOAD
 ; 10086 Sup ^%ZIS:   HOME
 ; 10089 Sup ^%ZISC
 ; 10103 Sup ^XLFDT:  $$FMTE, $$FMADD, $$NOW
 ; 10112 Sup ^VASITE: $$SITE
 ; 10141 Sup ^XPDUTL  $$INSTALDT
 ;
 Q
 ;
EN ;entry point from Menu Option: PRESUMPTIVE PSYCHOSIS STATUS REPORT
 N DFN,DGCAT,DGDIV,DGDIVSEL,DGDT,DGDTDEF,DGDTF,DGDTP,DGDTT,DGRTYP,DGRES,DGSET,DGSRTFAC,DGTEMP,DGX,DGYN,PAGE,POP,VAUTD,Y,ZTDESC,ZTRTN,ZTSAVE,ZTSK,%ZIS
 S DGDTDEF=$$GETDEFD() I DGDTDEF="" W !!,"There is no record of patch DG*5.3*977 being installed!",!! Q
 ;DG*5.3*977 PP
 W @IOF
 W !,"PRESUMPTIVE PSYCHOSIS STATUS REPORT"
 ;PRESUMPTIVE PSYCHOSIS STATUS REPORT help text
 D HELP^DGPPRP3(1)
ASKDIV ;Select Division
 S DGX=$$SELDIV(.DGDIVSEL) Q:'DGX
 S DGSRTFAC=0 I DGDIVSEL S DIR(0)="Y",DIR("A")="Do you want to sort by division",DIR("B")="Y" D ^DIR Q:Y=U  I 'Y S DGSRTFAC=+$$SITE^VASITE()
 ;
SELCAT ;
 S DGSET="S^ALL:ALL;"_$P($G(^DD(2,.5601,0)),U,3)
 I $P(DGSET,U,2)="" W !,"Presumptive Psychosis Category not found in Patient file" Q
 S DGRTYP=$$SELECT("Select One of the Following:",DGSET)
 I Y="^" Q   ;quit if no selection
 ;
SELDATES ;
 N DGDTFC,DGDTTC
 S DGDT=$$DTFRMTO("Select dates")
 Q:+DGDT=0  S DGDTF=$P(DGDT,U,2),DGDTT=$P(DGDT,U,3)_".2399"
 S DGDTFC=$$FMTE^XLFDT(DGDTF,"5PZ"),DGDTTC=$$FMTE^XLFDT(DGDTT,"5PZ")
 S DGTEMP=$NA(^TMP("DGPPRP1",$J)) K @DGTEMP
 ; Allow queueing
 K IOP,IO("Q") S %ZIS="MQ",%ZIS("B")="",POP=0 D ^%ZIS Q:POP
 I $D(IO("Q")) D  Q   ;Queued report settings
 .S ZTDESC="Presumptive Psychosis Report",ZTRTN="DQ^DGPPRP1"
 .S ZTSAVE("DGRTYP")="",ZTSAVE("DGDTFRMT")="",ZTSAVE("DGDTFRM")="",ZTSAVE("ZTREQ")="@",ZTSAVE("DGDTTO")=""
 .D ^%ZTLOAD,HOME^%ZIS
 .I $G(ZTSK) W !!,"Report compilation has started with task# ",ZTSK,".",! S DIR(0)="E" D ^DIR K DIR
 ;
DQ ;
 N DFN,DFNA,DGN,IENDFN,EXIT
 S EXIT=0
 S DGDTP="Date Printed: "_$$FMTE^XLFDT($$NOW^XLFDT()\1,"5PZ")
 S DGDT=$$FMADD^XLFDT(DGDTF,-1)_".2399" F  S DGDT=$O(^DGPP(33.1,"AC",DGDT)) Q:'DGDT!(DGDT>DGDTT)  D
 . S DGCAT="" F  S DGCAT=$O(^DGPP(33.1,"AC",DGDT,DGCAT)) Q:DGCAT=""  D
 .. S DGYN=0 I DGRTYP="ALL" S DGYN=1  ;If all categories selected
 .. I 'DGYN,DGCAT=DGRTYP S DGYN=1 ;If selected category match
 .. Q:'DGYN 
 .. S IENDFN=0 F  S IENDFN=$O(^DGPP(33.1,"AC",DGDT,DGCAT,IENDFN)) Q:'IENDFN  D
 ... S DFN=$P($G(^DGPP(33.1,IENDFN,0)),U) Q:'DFN
 ... S DGN=$O(^DGPP(33.1,"AC",DGDT,DGCAT,IENDFN,"")) Q:'DGN
 ... D:'$D(DFNA(DFN)) SET(IENDFN,DGDT,DGDTF,DGDTT,.DGDIVSEL)
 ... S DFNA(DFN)=""
 D PRINT,OUT
 I $E(IOST,1,2)="C-",'EXIT R !!?8,"End of the Report...Press Enter to Continue",X:DTIME W @IOF
 Q
 ;
PRINT ;Print results by Division/PP Category/Treatment Date/Patient Name
 N DASH,DFN,DGCAT,DGCATL,DGDT,DGHDRDT,DGHDRYN,DGI,DGPATNA,DGX,DGY,LASTPNA
 W @IOF I '$D(@DGTEMP) W !!?10," << None found >> ",!! G OUT
 S DGX=$P(^DD(2,.5601,0),U,3),PAGE=0 K DGCATL F DGI=1:1:$L(DGX,";")-1 S DGY=$P(DGX,";",DGI),DGCATL($P(DGY,":"))=$P(DGY,":",2)
 S DGHDRDT="Date Range: "_$$FMTE^XLFDT(DGDTF,"5PZ")_" to "_$$FMTE^XLFDT((DGDTT\1),"5PZ")
 S DASH="",$P(DASH,"-",81)="",(DGHDRYN,EXIT)=0
 S DGDIV="" F  S DGDIV=$O(@DGTEMP@(DGDIV)) Q:DGDIV=""!(EXIT)  S DGHDRYN=1 D
 . S LASTPNA=""
 . S DGPATNA="" F  S DGPATNA=$O(@DGTEMP@(DGDIV,DGPATNA)) Q:DGPATNA=""!(EXIT)  D
 .. S DFN="" F  S DFN=$O(@DGTEMP@(DGDIV,DGPATNA,DFN)) Q:DFN=""!(EXIT)  D
 ... S DGDT="" F  S DGDT=$O(@DGTEMP@(DGDIV,DGPATNA,DFN,DGDT),-1) Q:DGDT=""!(EXIT)  D PRINT2 Q:EXIT
 W !
 Q
 ;
PRINT2 ;
 N DGCAT,DGDT1,DGSTA
 S DGDT1=0 F  S DGDT1=$O(@DGTEMP@(DGDIV,DGPATNA,DFN,DGDT,DGDT1)) Q:'DGDT1!EXIT  D
 .S DGCAT="" F  S DGCAT=$O(@DGTEMP@(DGDIV,DGPATNA,DFN,DGDT,DGDT1,DGCAT)) Q:DGCAT=""!EXIT  D
 ..S DGX=@DGTEMP@(DGDIV,DGPATNA,DFN,DGDT,DGDT1,DGCAT),DGSTA=$P(DGX,U,2)
 ..I $Y+2>IOSL!DGHDRYN,PAGE>0 I ($E(IOST,1,2)="C-")&(IO=IO(0)) W ! S DIR(0)="E" D ^DIR K DIR D  Q:EXIT
 ...I $D(DTOUT)!($D(DUOUT)) S EXIT=1 Q
 ...W @IOF D HDR S DGHDRYN=0
 ...Q
 ..D:DGHDRYN HDR W ! W:(LASTPNA="")!(LASTPNA]""&(LASTPNA'=DGPATNA)) $E(DGPATNA,1,20),?22,$P(DGX,U) W ?28,DGCATL(DGCAT),?57,$$FMTE^XLFDT(DGDT\1)
 ..S LASTPNA=DGPATNA
 ..Q
 .Q
 Q
 ;
HDR ; Print page header
 N DGX
 S PAGE=PAGE+1,DGX="Presumptive Psychosis Status Report"
 W $J(" ",80-$L(DGX)/2),DGX
 W !,$J(" ",80-$L(DGHDRDT)/2),DGHDRDT
 S DGX=$S(DGSRTFAC=0:"Division",1:"Facility")_": "_$$GET1^DIQ(40.8,DGDIV_",",.01)_" ("_DGSTA_")"
 W !,$J(" ",80-$L(DGX)/2),DGX
 W !,$J(" ",80-$L(DGDTP)/2-1),DGDTP
 W !!?68,"Page: ",PAGE,!,DASH
 W !,"PATIENT NAME",?22,"PID",?28,"PRESUMPTIVE PSYCHOSIS CAT.",?57,"STATUS DATE"
 W !,DASH
 S DGHDRYN=0
 Q
 ;
SET(IENDFN,DGDT,FD,TD,VAUTD) ;
 N DGCAT,DGDIV,DGDT1,DFN,DFNS,DGI,DGIENS,DGOUT,DGPAT,DGRET,DGSTD,DGSUB1,DGX,DGY,IENDFNS
 S DFN=$P(^DGPP(33.1,IENDFN,0),U),DFNS=DFN_","
 D CHKTREAT(.DGRET,DFN,FD,TD,.DGDIVSEL) Q:'$D(DGRET)
 S IENDFNS=IENDFN_"," D GETS^DIQ(2,DFNS,".01;.0905","E","DGPAT")
 S DGDIV="" F  S DGDIV=$O(DGRET(DGDIV)) Q:DGDIV=""  D
 . S DGDT1=0 F  S DGDT1=$O(DGRET(DGDIV,DGDT1)) Q:'DGDT1  D
 .. K DGOUT D GETS^DIQ(33.1,IENDFN_",","**","IE","DGOUT")
 .. F DGI=1:1 S DGIENS=DGI_","_IENDFN_"," Q:'$D(DGOUT(33.12,DGIENS))  D
 ... S DGCAT=DGOUT(33.12,DGIENS,.02,"I") Q:($G(DGRTYP)'=""&($G(DGRTYP)'="ALL")&(DGRTYP'=DGCAT))!(DGCAT="")
 ... S DGSUB1=$S(DGSRTFAC:DGSRTFAC,1:DGDIV)
 ... S @DGTEMP@(DGSUB1,DGPAT(2,DFNS,.01,"E"),DFN,$G(DGOUT(33.12,DGIENS,.01,"I")),DGDT,DGCAT)=$G(DGPAT(2,DFNS,.0905,"E"))_U_$P(DGRET(DGDIV,DGDT1),U,2)
 Q
 ;
SELDIV(DGDIVSEL) ;prompt for DIVISION
 N DIV,FAC,VAUTD,Y
 W !
 I '$D(^DG(40.8,+$O(^DG(40.8,0)),0)) D  Q 0
 . W !!,*7,"***WARNING...MEDICAL CENTER DIVISION FILE IS NOT SET UP",!
 ;get division
 D DIVISION^VAUTOMA
 Q:$G(Y)<0 0
 M DGDIVSEL=VAUTD
 Q 1
 ;
 ;Check if patient should be included in report, using OUTPATIENT ENCOUNTER file, and return division
CHKTREAT(RET,DFN,DGDTF,DGDTT,ARRDIV) ;
 ;
 ;Find all divisions within the user-selected date range, and check input array ARRDIV
 ;
 ;Input:
 ; DFN=IEN in file #2
 ; DGDTF='From' date entered by user
 ; DGDTT='To' date entered by user
 ; ARRDIV is in the format output by utility VAUTOMA
 ;Output:
 ; RET(DIVISION#,DATE OF ENCOUNTER)=Name of division^Station #
 ; Example:
 ; RET(1,3190425)="NORTHAMPTON^666"
 ; RET(7,3190413)="PITTSFIELD^777"
 ; RET(7,3190425)="PITTSFIELD^888"
 ;
 N DGCO,DGDIV,DGDT,DGIEN,DGOUT
 S DGDT="" F  S DGDT=$O(^SCE("ADFN",DFN,DGDT),-1) Q:'DGDT!(DGDT<DGDTF)  D:(DGDT\1'<DGDTF)&((DGDT\1)'>DGDTT)
 . S DGIEN=0 F  S DGIEN=$O(^SCE("ADFN",DFN,DGDT,DGIEN)) Q:'DGIEN  D
 .. K DGOUT D GETS^DIQ(409.68,DGIEN_",",".11;.12","IE","DGOUT") Q:$G(DGOUT(409.68,DGIEN_",",.12,"E"))'="CHECKED OUT"
 .. S DGDIV=$G(DGOUT(409.68,DGIEN_",",.11,"I")) Q:DGDIV=""
 .. S DGSTA=$$STA^XUAF4($$GET1^DIQ(40.8,DGDIV_",",.07,"I"))
 .. I $G(ARRDIV)=1 D CHKTRSET Q
 .. D:$D(ARRDIV(DGDIV)) CHKTRSET
 Q 
 ;
CHKTRSET ;
 S RET(DGDIV,DGDT\1)=DGOUT(409.68,DGIEN_",",.11,"E")_U_DGSTA
 Q
 ;
DTFRMTO(PROMPT) ;Get from and to dates 
 N %DT,Y,X,DGDTFRM,DGDTTO,DTOUT,OUT,DIRUT,DUOUT,STATUS,STDT,STATUS
 ;INPUT : PROMPT - Message to display prior to prompting for dates
 ;OUTPUT: 1^BEGDT^ENDDT - Data found
 ; 0 - User up arrowed or timed out
 ;If they want to show first available date for that set of Status, use this sub
FRMDT ;
 S OUT=0
 S DIR(0)="DO^"_DT_":"_DT_":EX",%DT("B")=$$FMTE^XLFDT(DGDTDEF,"5PZ")
 S %DT="AEX",%DT("A")="From date: " ;Enter Beginning Date: "
 W ! D ^%DT K %DT
 Q:Y<0 0
 I Y<DGDTDEF W !!,"'From' date may not be earlier than "_$$FMTE^XLFDT(DGDTDEF,"5PZ") G FRMDT
 I Y>DT W !,"Future dates are not allowed, please re-enter",! K Y,%DT G FRMDT  ;Future dates not allowed
 S DGDTFRM=+Y
TODT ;
 S %DT="AEX",%DT("A")="To date: ",%DT("B")=$$FMTE^XLFDT($$NOW^XLFDT\1,"5PZ") ; Get end date, default is "TODAY"
 D ^%DT K %DT
 Q:Y<0 0
 I Y<DGDTFRM W !!,"'To' date may not be earlier than 'From' date" K %DT G TODT
 I Y>DT W !,"Future dates are not allowed, please re-enter",! K Y,%DT G TODT
 S DGDTTO=+Y,OUT=1_U_DGDTFRM_U_DGDTTO
 Q OUT
 ;
SELECT(PROMPT,SET) ; prompts for a report type
 S DIR(0)=SET,DIR("A")="Please select report type",DIR("B")="ALL" D ^DIR K DIR
 Q:Y<0 EXIT
 Q Y
 ;
GETDEFD() ;
 N DGOUT,X
 S X=$$INSTALDT^XPDUTL("DG*5.3*977",.DGOUT)
 Q $O(DGOUT(""))\1
 ;
OUT ; KILL RETURN ARRAY QUIT
 D ^%ZISC
 K @DGTEMP
 Q
 ;
