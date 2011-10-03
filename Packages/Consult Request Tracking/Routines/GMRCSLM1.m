GMRCSLM1 ;SLC/DCM - Gather data and format ^TMP global for consult tracking Silent call for use by List Manager and GUI ;10/9/01 23:12
 ;;3.0;CONSULT/REQUEST TRACKING;**1,4,10,12,15,17,22,32,63**;DEC 27, 1997;Build 10
 ;
 ; This routine invokes IA #2638,#2740
 ;
 G AD
SVC(NODE) ;Check for a valid service
 K GMRCDEAV
 I '$D(^GMR(123,NODE,0)) Q 0
 I '+$P(^GMR(123,NODE,0),"^",5) Q 0
 I '$D(^TMP("GMRCS",$J,$P(^GMR(123,NODE,0),"^",5))) Q 0
 Q 1
AD ;Main entry point. Loop through AD x-ref in file 123; Find consults that have been released to requested service
 ;;DFN and GMRCSSNM must be defined when this entry point is called
 ;;DFN=Internal File Number of Patient in ^DPT
 ;;GMRCSSNM=Service Name of a Hospital Service from file ^GMR(123.5
 ;;If GMRCSSNM is not defined or is null, then no records will be found.
 ;;GMRCOER must be passed so that proper formatting for GUI or List Manager can be performed.  GMRCOER is passed as 0 for List Manager, 1 for GUI.
 ;;GMRCDT1 and GMRCDT2 are passed in as start and stop dates for the lookup. If GMRCDT1="" or GMRCDT1="ALL", then all dates are searched.
 ;;GMRCIS=IFC site (if defined); Values: R(equesting) or C(onsulting)
 ;;  ***********************************************************
 K ^TMP("GMRCR",$J,"CS"),GMRCNUL
 I $D(GMRCSSS) S (GMRCDG,GMRCSS)=GMRCSSS,GMRCSSNM=($P($G(^GMR(123.5,+GMRCSS,0)),"^",1)) D SERV1^GMRCASV K GMRCSSS ;reset after forward
 S TAB="",$P(TAB," ",41)="",BLK=0,LNCT=1 S:'$D(GMRCOER) GMRCOER=0
 S GMRCD=0 F  S GMRCD=$O(^GMR(123,"AD",DFN,GMRCD)) Q:'GMRCD  S GMRCDA=0 F  S GMRCDA=$O(^GMR(123,"AD",DFN,GMRCD,GMRCDA)) Q:'GMRCDA  I $$SVC(GMRCDA) D SET
 D END Q
SET ;;Format entries into a word processing 'TMP("GMRCR",$J,"CS",' global that List Manager can display
 ;;GMRCOER is a variable that signals that data is being formatted for the OE/RR GUI; this data is formatted differently than the data for List Manager.
 ;;GMRCOER=0 : Data is List Manager formatted.
 ;;GMRCOER=1 : Data is OE/RR GUI formatted.
 S:'$D(TAB) TAB="",$P(TAB," ",30)=""
 S GMRCIFN=$G(GMRCDA) I '$L(GMRCIFN),$D(XQADATA) S (GMRCDA,GMRCIFN)=+XQADATA
 I $G(XQADATA)["@" S (GMRCDA,GMRCIFN)=+$P($P(XQADATA,"@",2),"|",2)
 S GMRCSEX=$S($P(^DPT(DFN,0),"^",2)="M":"MALE",1:"FEMALE")
 I '$D(^GMR(123,+GMRCIFN,0)) S GMRCQUT=1 Q
 S PROC="",GMRC(0)=^GMR(123,GMRCIFN,0)
 ;IF Consults
 N GMRCCK
 I $D(GMRCIS) D  Q:'GMRCCK
 . S GMRCCK=1
 . S:'$P($G(GMRC(0)),"^",23) GMRCCK=0
 . I GMRCCK=1 D
 . . S GMRC(12)=$G(^GMR(123,GMRCIFN,12))
 . . I GMRCIS="R",$P(GMRC(12),"^",5)'="P" S GMRCCK=0
 . . I GMRCIS="C",$P(GMRC(12),"^",5)'="F" S GMRCCK=0
 I $D(GMRCSTCK),GMRCSTCK'="" N STATUS,TITLE D  Q:'STATUS
 . N I
 . F I=1:1 S STATUS=$P(GMRCSTCK,",",I) Q:STATUS=$P(GMRC(0),"^",12)  Q:'STATUS
 . Q
 I $D(GMRCVP),GMRCVP'=$P(GMRC(0),"^",8) Q
 S (GMRCFMDT,X)=$P(GMRC(0),"^",7) I GMRCDT1'="ALL",$P(X,".",1)<GMRCDT1!($P(X,".",1)>GMRCDT2) Q
 I GMRCOER'=2 D
 . S BLK=BLK+1
 . S ^TMP("GMRCR",$J,"CS","AD",BLK,LNCT,GMRCDA)=""
 D REGDTM^GMRCU S CDT=$P(X," ")
 S PROC=$S($P(GMRC(0),U,17)="P":"Procedure",1:"Consult")
 I PROC'="Consult" S PROC=$$GET1^DIQ(123.3,+$P(GMRC(0),"^",8),.01)
 S:PROC="" PROC="Consult"
 S TO=+$P(GMRC(0),"^",5)
 I +TO S TOD=$S($P($G(^GMR(123.5,+TO,0)),"^",2)=9:1,1:0)
 I '$D(TOD) S TOD=0
 S TO=$S(+TO:$P($G(^GMR(123.5,+TO,0)),"^",1),1:"")
 S TO=$S(TOD:"<",1:"")_TO
 S TO=$S(GMRCOER:TO,1:$E(TO,1,40))_$S(TOD:">",1:"")
 I '$L(TO) S TO="**Unknown Service**"
 S STS=$P(GMRC(0),"^",12) D
 . I '+STS,'$D(^ORD(100.01,+STS,0)) Q
 . I '+GMRCOER S STS=$P(^ORD(100.01,+STS,.1),"^",1) Q
 . I GMRCOER=1 S STS=$P(^ORD(100.01,+STS,0),"^") Q
 . S STS=$P(^ORD(100.01,+STS,.1),"^")
 I $S(STS="":1,'$D(^ORD(100.01,+$P(GMRC(0),"^",12),0)):1,1:0) S STS=99,$P(GMRC(0),"^",12)=STS,STS=$S(GMRCOER=1:$P(^ORD(100.01,5,0),"^",1),1:$P(^ORD(100.01,+STS,.1),"^",1))
 D SERVPROC
 I 'GMRCOER D  Q
 . S ^TMP("GMRCR",$J,"CS",LNCT,0)=BLK_$E(TAB,1,(4-$L(BLK)))_CDT_"  "_$E(STS,1,3)_$S(STS?1A:"  ",STS?2A:" ",1:"")_" "_$J(GMRCDA,7)_" "_$S($P(GMRC(0),"^",19)="Y":"*",1:" ")_TITLE
 . S LNCT=LNCT+1
 I GMRCOER D
 . N DATA
 . S DATA=GMRCDA_U_GMRCFMDT_U_STS_U_TO_U_PROC_U
 . S DATA=DATA_$S($P(GMRC(0),U,19)="Y":"*",1:"")_U
 . S DATA=DATA_TITLE_U_$P(GMRC(0),U,3)
 . D  ;get type of record for proper icon in GUI
 .. ; "C"=reg cons, "P"=reg proc, "M"=clin proc, "I"=IF cons, "R"=IF proc
 .. I +$G(^GMR(123,GMRCDA,1)) S $P(DATA,U,9)="M" Q
 .. S $P(DATA,U,9)=$P(GMRC(0),U,17)
 .. N GMRCGVER
 .. S GMRCGVER=$P($G(ORWCLVER),".",3,4) ;GUI version running
 .. I GMRCGVER'>19.1 Q  ;will crash at less than 19.1
 .. I $P(GMRC(0),U,23) S $P(DATA,U,9)=$S($P(DATA,U,9)="P":"R",1:"I")
 . S ^TMP("GMRCR",$J,"CS",LNCT,0)=DATA
 . S LNCT=LNCT+1
 . K STSOER Q
 Q
END I LNCT<2 S (BLK,LNCT,GMRCNUL)=1,GMRCNPM="< PATIENT DOES NOT HAVE ANY CONSULTS/REQUESTS "_$S($D(GMRCPRNM):"FOR "_GMRCPRNM,1:"")_" ON FILE. >",GMRCNPM=$E(TAB,1,(80-$L(GMRCNPM))\80)_GMRCNPM,^TMP("GMRCR",$J,"CS",LNCT,0)=GMRCNPM D
 .I $D(GMRCDT1)&($D(GMRCDT2)),GMRCDT1'="ALL" S LNCT=LNCT+1,^TMP("GMRCR",$J,"CS",LNCT,0)="Between Dates: "_$$FMTE^XLFDT(GMRCDT1)_" and "_$$FMTE^XLFDT(GMRCDT2)
 .I $D(GMRCSTCK),$L(GMRCSTCK) S LNCT=LNCT+1,^TMP("GMRCR",$J,"CS",LNCT,0)="With Status: " S STS="" F I=1:1 S STS=$P(GMRCSTCK,",",I) Q:STS=""  S ^TMP("GMRCR",$J,"CS",LNCT,0)=^(0)_$P($G(^ORD(100.01,+STS,0)),"^",1)_" "
 .Q
 E  S (BLK,LNCT)=LNCT-1,^TMP("GMRCR",$J,"CS",0)="^^^"_LNCT
 I $D(GMRCALFL) S (BLK,LNCT)=1
 K TO,TOD,END,FLG,GMRC(0),GMRCD,GMRCDG,GMRCIFN,GMRCFMDT,GMRCNPM,GMRCWARD
 K I,PROC,STS,URG
 Q
OER(DFN,GMRCDG,GMRCDT1,GMRCDT2,GMRCSTCK,GMRCOER) ;;GUI interface for CPRS
 ;;DFN=Patient internal file number
 ;;GMRCDG:  Internal file number of consult service from file 123.5
 ;;GMRCDT1:  Beginning date for lookup
 ;;GMRCDT2:  Ending date for lookup
 ;;GMRCSTCK: IEN from OER Status File [^OER(100.01)] to screen results
 ;;     so that only consults with a desired status are displayed
 ;;     Can be sent as a set of statuses: i.e., 6,5,2
 ;;      (GMRCSTCK=GMRC STATUS CHECK)
 ;;GMRCOER=0 if request is from CONSULTS
 ;;       =1 if request is for CPRS List Manager
 ;;       =2 if for CPRS GUI
 I GMRCDT1="" S GMRCDT1="ALL"
 I GMRCDG="" S GMRCDG=$O(^GMR(123.5,"B","ALL SERVICES",0))
 S:'$D(GMRCOER) GMRCOER=1
 D SERV1^GMRCASV,AD
 K ^TMP("GMRCS",$J),^TMP("GMRCSLIST",$J)
 Q
SERVPROC ; Build contents of SERV/PROC field for List Manager
 N TYPE,OTXT
 S TITLE=""
 S TYPE=""
 S OTXT=$P($G(^GMR(123,GMRCDA,1.11)),"^")
 I OTXT="" D BUILD2
 I OTXT'="" D BUILD1
 Q
BUILD1 ;OTXT does contain information
 N FLG,BADFLG,TPROC,TTO,LEN,ABBRS,ABBRP
 S TPROC=$$UP^XLFSTR(PROC),TTO=$$UP^XLFSTR(TO)
 S TITLE=OTXT,OTXT=$$UP^XLFSTR(OTXT)
 S BADFLG=0
 I PROC="Consult" S FLG=1,TYPE="Cons"
 I PROC'="Consult" S FLG=0,TYPE="Proc"
 S LEN=$L(TITLE)
 I TO="" S TO="No Service"
 I LEN<30,FLG=1,OTXT'=TTO S TITLE=TITLE_" "_TO_" "_TYPE Q
 I LEN<30,FLG=1,OTXT=TTO S TITLE=TITLE_" "_TYPE Q
 I TO["<" S BADFLG=1
 S ABBRS=$$SVC^GMRCAU(GMRCDA),ABBRP=$$PROC^GMRCAU(GMRCDA)
 I LEN<30,FLG=0,TPROC'=OTXT,TTO'=TPROC S TITLE=TITLE_" "_PROC_" "_TO_" "_TYPE Q
 I LEN<30,FLG=0,TPROC=OTXT,TTO'=TPROC S TITLE=TITLE_" "_TO_" "_TYPE Q
 I LEN<30,FLG=0,TPROC=OTXT,TTO=TPROC S TITLE=TITLE_" "_TYPE Q
 I LEN>30,FLG=1,TTO'=OTXT S TITLE=TITLE_" "_TO_" "_TYPE Q
 I LEN>30,FLG=1,TTO=OTXT S TITLE=TITLE_" "_TYPE Q
 I LEN>30,FLG=0,TPROC'=OTXT,TTO'=TPROC S TITLE=TITLE_" "_ABBRP_" "_TYPE Q
 I LEN>30,FLG=0,TTO'=OTXT,BADFLG=0 S TITLE=TITLE_" "_ABBRS_" "_TYPE Q
 I LEN>30,FLG=0,TTO'=OTXT,BADFLG=1 S TITLE=TITLE_" "_"<"_ABBRS_">"_TYPE Q
 Q
BUILD2 ;OTXT contains no information
 N FLG,TPROC,TTO,LEN
 S TPROC=$$UP^XLFSTR(PROC),TTO=$$UP^XLFSTR(TO)
 I PROC="Consult" S TITLE=TO,LEN=$L(TITLE),FLG=1,TYPE="Cons"
 I PROC'="Consult" S TITLE=PROC,LEN=$L(TITLE),FLG=0,TYPE="Proc"
 I FLG=1 S TITLE=TITLE_" "_TYPE Q
 I FLG=0,TTO=TPROC S TITLE=TITLE_" "_TYPE Q
 I FLG=0,TTO'=TPROC S TITLE=TITLE_" "_TO_" "_TYPE Q
 Q
