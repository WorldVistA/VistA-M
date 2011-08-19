RMPRPIQ5 ;HCIOFO/ODJ - INVENTORY REPORT - BUILD ^TMP SORT ARRAY ; 12/30/02  11:35
 ;;3.0;PROSTHETICS;**61,127**;Feb 09, 1996
 ;
 ;RVD patch #61  modified to read the new PIP files; 661.11, 661.6
 ;               661.7, 661.9
 Q
 ;
 ; Start of Report build and print. Enter here after report params.
 ; entered by user (see RMPR5HQ4).
 ; Also called by TaskMan if report queued.
 ;
 ; Variables required
 ;
 ; RMPR("STA")
 ; RMPRSDT
 ; RMPREDT
 ; RMPRDET
 ; RMPRSEL
 ; {IO vars}
 ;
REPORT I $E(IOST)["C" W !!,"Processing report......."
 D GEN(RMPRSDT,RMPREDT,RMPRDET,.RMPRSEL,RMPR("STA")) ;generate ^TMP sort array
 D CALC^RMPR5HQ6 ;calculations
 U IO D ^RMPR5HQ2     ;print report
 D ^%ZISC
 ;K ^TMP($J,"RMPR5") ;make live after testing
 N RMPR,RMPRSITE D KILL^XUSCLEAN
 Q
 ;
 ; Entry point for national roll-up
NATION N RMPRSEL,RMPRDET,RMPRSTN,RMPRSDT,RMPREDT,X
 S RMPRSTN="*"
 S RMPRDET="H"
 ;D NOW^%DTC S RMPREDT=X S %H=%H-30 D YMD^%DTC S RMPRSDT=X
 S RMPRSDT=RMPRPIP1,RMPREDT=RMPRPIP2
 S RMPRSEL("*")=""
 D GEN(RMPRSDT,RMPREDT,RMPRDET,.RMPRSEL,RMPRSTN)
 D CALC^RMPR5HQ6 ;put calcs in TMP array
 D MAIL^RMPR5HQ7 ;build ^TMP($J,"RMPR5A" array for mailing
 Q
 ;
 ;
 ; Generate temporary index global ^TMP($J,"RMPR5"
 ; (as of 11/29/00 we use the 660 file, not 661.2)
 ;
GEN(STDT,ENDT,DETAIL,RMPRSEL,RMPRSTN) ;
 N TNAM,FROM,EOF,DAT,HCDAT,HCPCIEN,NPGRP,NPLIN,S,HCPC,HCPCITEM
 N OUPIEN,ITEM,ALLGRP,HCPCREF,SELECTED,STATION,QTY,STR,MULITEM
 N ITMIEN,INVDT,SOURCE,ISCOST,PATIENT,COST
 S TNAM="RMPR5" ;TMP global name
 K ^TMP($J,TNAM)
 D CURVAL(TNAM,RMPRSTN,.RMPRSEL,DETAIL)
 ;S FROM="" S:$G(STDT)'="*" FROM=STDT-1
 S EOF=0,ENDT=ENDT+1
 F RSDT=STDT:0 S RSDT=$O(^RMPR(661.6,"XSTD",RMPRSTN,3,RSDT)) Q:(RSDT>ENDT)!(RSDT="")  D  Q:EOF
 .; I INVDT="" S EOF=1 Q
 .; I ENDT'="*",INVDT>ENDT S EOF=1 Q
 . S OUPIEN=0
 . F  S OUPIEN=$O(^RMPR(661.6,"XSTD",RMPRSTN,3,RSDT,OUPIEN)) Q:OUPIEN'>0  D
 .. S S=$G(^RMPR(661.6,OUPIEN,0))
 .. S PATIENT=$P(S,"^",2) Q:PATIENT=""
 .. S QTY=+$P(S,"^",5) Q:QTY<1
 .. S HCPC=$P(S,"^",1) Q:HCPC=""
 .. S HCPCIEN=$O(^RMPR(661.1,"B",HCPC,0)) Q:HCPCIEN=""
 .. S STATION=RMPRSTN Q:STATION=""
 .. I RMPRSTN'="*",STATION'=RMPRSTN Q
 .. Q:'$D(^TMP($J,TNAM,"Z",HCPCIEN))
 .. Q:$P(^TMP($J,TNAM,"Z",HCPCIEN),"^",3)=1
 .. S HCPCITEM=HCPC_"-"_$P(S,"^",11)
 .. S ITEM=$P(HCPCITEM,"-",2)
 .. S:ITEM="" ITEM="?"
 .. S ISCOST=$P(S,"^",6)
 ..; S COST=$$PRECOST(OUPIEN,HCPCIEN,HCPCITEM,STATION)
 ..; I COST'="" S ISCOST=COST-ISCOST
 ..; S:COST="" ISCOST=QTY*$P(S,"^",5)
 .. S R11=$O(^RMPR(661.11,"C",HCPCITEM,0))
 .. S R11DAT=$G(^RMPR(661.11,R11,0))
 .. S SOURCE=$P(R11DAT,"^",5)
 .. S STR=^TMP($J,TNAM,"Z",HCPCIEN)
 .. S NPGRP=$P(STR,"^",1)
 .. S NPLIN=$P(STR,"^",2)
 .. S HCPCREF=HCPC,$P(HCPCREF,"/",2)=HCPCIEN
 .. I '$D(^TMP($J,TNAM,STATION,NPGRP,NPLIN,HCPCREF,ITEM)) D  Q:'+QTY
 ... S:+QTY ^TMP($J,TNAM,STATION,NPGRP,NPLIN,HCPCREF,ITEM)=""
 ... Q
 .. S ^TMP($J,TNAM,STATION,NPGRP,NPLIN,HCPCREF,ITEM,OUPIEN)=QTY_"^"_ISCOST_"^"_SOURCE
 .. Q
 . Q
 Q
 ;
 ; Get total cost of item just prior to current issue
PRECOST(INVIEN,HCPCIEN,HCPCITEM,STATION) ;
 N IEN,COST,STR,LOC
 S COST=""
 S IEN=INVIEN,RD=RMPRSDT
 S RD=$O(^RMPR(661.9,"ASHID",RMPRSTN,HCPC,IEN,RD),-1)
 Q:'$G(RD)  S RIEN=$O(^RMPR(661.9,"ASHID",RMPRSTN,HCPC,IEN,RD,0))
 S STR=^RMPR(661.9,RIEN,0)
 S COST=$P(STR,"^",9)
 Q COST
 ;
 ; Get QOH for HCPC
CURVAL(RMPRNAM,RMPRSTN,RMPRSEL,DETAIL) ;
 N INVIEN,STR,IEN1,IEN2,LOCN,HCPCIEN,HCDAT,NPLIN,NPGRP,ALLGRP,SELECTED
 N S,SOURCE,STATION,QOH,COST,HCPC,HCPCREF,ITEM
 S ALLGRP=0 S:$O(RMPRSEL(""))="*" ALLGRP=1
 S RH=""
 F  S RH=$O(^RMPR(661.9,"ASHID",RMPRSTN,RH)) Q:RH=""  D
 . S IEN1=0
 . F  S IEN1=$O(^RMPR(661.9,"ASHID",RMPRSTN,RH,IEN1)) Q:'+IEN1  D
 .. S HCPCIEN=$O(^RMPR(661.1,"B",RH,0)) Q:HCPCIEN=""
 .. I '$D(^TMP($J,RMPRNAM,"Z",HCPCIEN)) D
 ... S S=^RMPR(661.1,HCPCIEN,0)
 ... S NPLIN=$P(S,"^",7)
 ... S:NPLIN="" NPLIN="999 X"
 ... S NPGRP=$P(NPLIN," ",1) ;group num. is 1st set of digits of new line
 ... S STR=NPGRP
 ... S $P(STR,"^",2)=NPLIN
 ... S ^TMP($J,RMPRNAM,"Z",HCPCIEN)=STR
 ... Q
 .. E  D  Q:$P(S,"^",3)=1
 ... S S=^TMP($J,RMPRNAM,"Z",HCPCIEN)
 ... S NPGRP=$P(S,"^",1)
 ... S NPLIN=$P(S,"^",2)
 ... Q
 .. ;
 .. ; Test if record matches selection criteria
 .. ; (only needed if not all groups selected)
 .. I 'ALLGRP D  I 'SELECTED S $P(^TMP($J,RMPRNAM,"Z",HCPCIEN),"^",3)=1 Q
 ... S SELECTED=0
 ... I '$D(RMPRSEL(NPGRP)) Q
 ... I DETAIL="G" S SELECTED=1 Q
 ... I $O(RMPRSEL(NPGRP,""))="*" S SELECTED=1 Q
 ... I '$D(RMPRSEL(NPGRP,NPLIN)) Q
 ... I DETAIL="L" S SELECTED=1 Q
 ... I $O(RMPRSEL(NPGRP,NPLIN,""))="*" S SELECTED=1 Q
 ... I '$D(RMPRSEL(NPGRP,NPLIN,HCPCIEN)) Q
 ... S SELECTED=1
 ... Q
 .. S RD=ENDT+1
 .. S RD=$O(^RMPR(661.9,"ASHID",RMPRSTN,RH,IEN1,RD),-1) Q:RD=""  S RIEN=$O(^RMPR(661.9,"ASHID",RMPRSTN,RH,IEN1,RD,""),-1) D
 ... Q:'$D(^RMPR(661.9,RIEN,0))
 ... S HCPC=RH,S=^RMPR(661.9,RIEN,0)
 ... S QOH=+$P(S,"^",8) Q:'QOH
 ... S COST=$P(S,"^",9)
 ... S ITEM=IEN1
 ... S RS=$O(^RMPR(661.11,"C",HCPC_"-"_ITEM,0)) Q:RS=""
 ... S SOURCE=$P($G(^RMPR(661.11,RS,0)),U,5)
 ... S HCPCREF=HCPC,$P(HCPCREF,"/",2)=HCPCIEN
 ... S S=$G(^TMP($J,RMPRNAM,RMPRSTN,NPGRP,NPLIN,HCPCREF,ITEM))
 ... I SOURCE="C" D
 .... S $P(S,"^",9)=QOH+$P(S,"^",9)
 .... S $P(S,"^",11)=COST+$P(S,"^",11)
 .... Q
 ... E  D
 .... S $P(S,"^",8)=QOH+$P(S,"^",8)
 .... S $P(S,"^",10)=COST+$P(S,"^",10)
 .... Q
 ... S ^TMP($J,RMPRNAM,RMPRSTN,NPGRP,NPLIN,HCPCREF,ITEM)=S
 ... Q
 .. Q
 . Q
 Q
 ;
 ; return item text string given HCPC and ITEM IENs to 661.11
 ; if null ITEMIEN passed the just return the HCPC short name text
GETITEM(HCPCIEN,ITEMIEN) ;
 N STR,ITEMTXT
 S ITEMTXT=""
 I ITEMIEN="" D  G GETITEMX
 . S STR=$G(^RMPR(661.1,HCPCIEN,0))
 . S ITEMTXT=$P(STR,"^",2)
 . Q
 S HCPC=$P($G(^RMPR(661.1,HCPCIEN,0)),U,1)
 S STR=$G(^RMPR(661.11,"C",HCPC_"-"_ITEMIEN,0))
 I STR="" D
 . S ITEMTXT=$P(^RMPR(661.1,HCPCIEN,0),"^",2)
 . Q
 E  D
 . S ITEMTXT=$P(STR,"^",1)
 . Q
 S:ITEMTXT="" ITEMTXT="ITEM "_ITEMIEN
GETITEMX Q ITEMTXT
 ;
 ; return NPPD line text from line code (New lines only)
NPLIN(CODE) ;
 N I,S,LINTXT
 S LINTXT=""
 F I=1:1 S S=$P($T(DES+I^RMPRN62),";;",2) Q:$E(S,1,3)="END"  D  Q:LINTXT'=""
 . I $P(S,";",1)=CODE S LINTXT=$P(S,";",2)
 . Q
 Q LINTXT
