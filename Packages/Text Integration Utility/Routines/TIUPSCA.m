TIUPSCA ;BPOIFO/EL/CR - TIU DOCUMENT POST SIGNATURE ALERTS ;12/18/17 3:59pm
 ;;1.0;TEXT INTEGRATION UTILITIES;**305**;JUN 20, 1997;Build 27
 ;
 ; External Reference DBIA#:
 ; -------------------------
 ; #1252  - Reference to OUTPTPR^SDUTL3 (Supported)
 ; #2056  - Reference to GET1^DIQ (supported)
 ; #2263  - Reference to GET^XPAR (Supported)
 ; #6811  - Reference to file #100.21 (Private)
 ; #10035 - Reference to file #2  (Supported)
 ; #10061 - Reference to KVA^VADPT (Supported)
 ; #10103 - Reference to FMTE^XLFDT (Supported)
 ; #10103 - Reference to NOW^XLFDT (Supported)
 ; #10081 - Reference to SETUP1^XQALERT (Supported)
 ;
 ; This routine expects the following variables to be defined in the 
 ; local symbol table:
 ; TIUTTL  - IEN of the just-signed TIU DOCUMENT DEFINITION 
 ;           as found in file #8925.1
 ; DA      - IEN of the just-signed TIU DOCUMENT as found in file #8925
 ; DFN     - IEN of the PATIENT associated with the just-signed
 ;           TIU DOCUMENT as found in file #2
 ; TIUXQA  - TIUXQA in TIUPSCS  (mail group recipient)
 ; TIUSPEC - TIUSPEC in TIUPSCS (API for alert)
 ; TIUDEV  - TIUDEV in TIUPSCS (DEVICE to send alert to) 
 ;
 ;
AUTOPRT ; generate note to location based chart copy printer
 N TIUTIU,TIUTOFP
 S (TIUTIU,TIUTOFP)=""
 S TIUTIU=$S($G(TIU12)]"":TIU12,$G(TIUD12)]"":TIUD12,1:"")
 Q:'+TIUTIU
 ; get external name of printer below
 S TIUTOFP=$$GET^XPAR($P(TIUTIU,U,5)_";SC(","ORPF CHART COPY PRINT DEVICE",,"E")
 ;I +TIUTOFP S TIUTOFP=$P(^%ZIS(1,TIUTOFP,0),U)
 Q:TIUTOFP']""
 D RPC^TIUPD(.TIU,DA,TIUTOFP,2)
 Q
 ;
CLEAN ;
 K XQA
 Q
 ;
DEVP ;
 W !,TIUMSG
 Q
 ;
EN(TIUXQA,TIUSPEC,TIUDEV) ;
 N TIU,TIUDEVG,TIUDFN,TIUFOUR,TIUGO,TIUGRP,TIULOC,TIUMSG
 N TIUPTNM,TIUTDEV,TIUTEAM,TIUTIEN,TIUTITL,TIUUSER,VAIN
 N TIUPCP,TIUATT,TIUEND,TIULINE,TIULNUM,TIUPLUS
 N X,XQADATA,XQAID,XQAMSG,XQAROU
 N ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE
 S (TIU,TIUDEVG,TIUDFN,TIUEND,TIUFOUR,TIUGO,TIUGRP,TIULOC,TIUMSG)=""
 S (TIUPTNM,TIUTDEV,TIUTEAM,TIUTIEN,TIUTITL,TIUUSER,VAIN)=""
 S (X,XQADATA,XQAID,XQAMSG,XQAROU)=""
 S (ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE)=""
 ;
 S (DFN,TIUDFN)=$$GET1^DIQ(8925,DA,.02,"I") ; don't count on existing DFN
 D RECIP
 ;
 S TIUTITL=$$GET1^DIQ(8925.1,TIUTTL,.01)
 ;
 S TIUPTNM=$$GET1^DIQ(2,TIUDFN,.01)
 S TIUFOUR=" ("_$E(TIUPTNM)_$E($$GET1^DIQ(2,TIUDFN,.09),6,9)_") "
 S TIULOC=$$LOC D KVA^VADPT
 S XQAID="TIUADD"_+DA,XQADATA=DA_U
 S XQAROU="ACT^TIUALRT"
 S TIUGO=1
 I $G(TIUSPEC)]"" I $L($T(@TIUSPEC)) D @TIUSPEC
 ; get the primary care provider for the patient, if assigned
 I $G(TIUSPEC)="PCP" D
 . S TIUPCP=$P($$OUTPTPR^SDUTL3(DFN,DT,1),U,1) ; get PCP's DUZ
 . I TIUPCP S XQA(TIUPCP)=""
 ;
 I '$D(XQA) S XQA(DUZ)="" ; default so that the alert can still be sent
 S XQAMSG=TIUPTNM_TIUFOUR_TIULOC_" ("_$$FMTE^XLFDT($$NOW^XLFDT,"2D")
 S XQAMSG=XQAMSG_"): "_TIUTITL_$S($G(TIUEND)]"":" "_TIUEND_".",1:" signed.")
 I $G(TIUDEV)]"" D
 . S TIU=""
 . D RPC^TIUPD(.TIU,DA,TIUDEV,2)
 S TIUMSG=XQAMSG
 I $G(TIUGO)=1 S X=$$SETUP1^XQALERT ; I 'XQALERR W !,"Alert Error: ",XQALERR
 I $G(TIUDEVG)=1 S ZTSAVE("TIUMSG")="" D ^%ZTLOAD
 D CLEAN
 Q
 ;
GETRTN(TIUARY) ; compile array of SUBROUTINE for TIU Document Definition Code
 N I,X
 S (I,X)="",(I,TIUARY)=0
 F I=1:1 D  Q:$G(I)="STOP"
 . S X=$P($T(RTNLST+I),";;",2)
 . I $G(X)="" S I="STOP" Q
 . S TIUARY=I,TIUARY(I)=$E(X,1,70)
 Q TIUARY
 ;
LOC() ; WARD Location: Int^Ext (nn^LOC)
 D INP^VADPT
 Q $S(VAIN(4)]"":"["_$P(VAIN(4),U,2)_"]",1:"")
 ;
RECIP ; determine alert recipients
 ; the patient IEN is kept by TIUDFN, title ien is TIUTTL
 I TIUXQA=+TIUXQA S XQA(TIUXQA)="" ; individual user
 I TIUXQA["G." S XQA(TIUXQA)="" ; mail group
 ;
 I TIUXQA["T." D  ; TEAM LIST
 . S TIUTEAM=$P(TIUXQA,".",2),TIUTIEN=$O(^OR(100.21,"B",TIUTEAM,0)) Q:'+TIUTIEN
 . ; ** EL **
 . S TIUUSER=0
 . F  S TIUUSER=$O(^OR(100.21,TIUTIEN,1,TIUUSER)) Q:'+TIUUSER  D  ;OE/RR team members
 .. S XQA(TIUUSER)=""
 . ; ** EL **
 . S TIUTDEV=$$GET1^DIQ(100.21,TIUTIEN,1.5,"I") I +TIUTDEV D  ; OE/RR team device
 .. S ZTIO="`"_TIUTDEV,ZTDTH=$$NOW^XLFDT
 .. S ZTDESC="TIU Document Post-Signature Alert",ZTRTN="DEVP^TIUPSCA"
 .. S TIUDEVG=1
 Q
 ;
RTNLST ; SUBROUTINE listing as ";;API-Description (upto 70 chars)"
 ;;N/A-No Conditional Alert is needed
 ;;PCP-Include patient's Primary Care Provider from PCMM as a recipient
 ;;AUTOPRT-Generate message to chart copy printer at encounter location
 ;
 Q
