ORWDXR01 ;SLC/JDL - Utilities for Order Actions ;May 04, 2022@13:28:41
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**187,190,195,215,280,345,311,350,405**;Dec 17, 1997;Build 211
CANCHG(ORY,ORIFN,TXTOD) ;
 ;If it's an pending or unsigned unreleased renewed order, can edit=True
 S ORY=0
 Q:'$D(^OR(100,+ORIFN,0))
 I TXTOD D TXTCAN(.ORY) Q
 N OUTGRP,URELSTS,USIGSTS,RNTYPE,PDSTS
 N ODGRP,ODREL,ODSIG,ODTYPE,LSTACT
 S OUTGRP=$O(^ORD(100.98,"B","O RX",0))
 S URELSTS=$O(^ORD(100.01,"B","UNRELEASED",0))
 S PDSTS=$O(^ORD(100.01,"B","PENDING",0))
 S USIGSTS=2 ; unsigned order
 S RNTYPE=2 ; renew action
 ;Data from the order entry
 S LSTACT=$P($G(^OR(100,+ORIFN,3)),U,7)
 S ODGRP=$P($G(^OR(100,+ORIFN,0)),U,11)
 S ODREL=$P($G(^OR(100,+ORIFN,3)),U,3)
 S ODSIG=$P($G(^OR(100,+ORIFN,8,LSTACT,0)),U,4)
 S ODTYPE=$P($G(^OR(100,+ORIFN,3)),U,11)
 I (ODGRP=OUTGRP),(ODREL=URELSTS),(ODSIG=USIGSTS),(ODTYPE=RNTYPE) S ORY=1
 Q
 ;
TXTCAN(ORY) ;
 ;if it's an unsigned unreleased renewed text order, can change=true
 N URELSTS,USIGSTS,RNTYPE
 N ODREL,ODSIG,ODTYPE,LSTACT
 S URELSTS=$O(^ORD(100.01,"B","UNRELEASED",0))
 S USIGSTS=2 ; unsigned order
 S RNTYPE=2 ; renew action
 ;Data from the order entry
 S LSTACT=$P($G(^OR(100,+ORIFN,3)),U,7)
 S ODREL=$P($G(^OR(100,+ORIFN,8,LSTACT,0)),U,15)
 S ODSIG=$P($G(^OR(100,+ORIFN,8,LSTACT,0)),U,4)
 S ODTYPE=$P($G(^OR(100,+ORIFN,3)),U,11)
 I (ODREL=URELSTS),(ODSIG=USIGSTS),(ODTYPE=RNTYPE) S ORY=1
 Q
 ;
SAVCHG(ORY,ORID,PARM1,PARM2,TXTOD,DAYSUP,QTY) ;
 ;save new changes on the unreleased unsigned renewed order
 Q:'$D(^OR(100,+ORID,0))
 ;Update new start and stop date the text order
 I TXTOD D TXTSAV(.ORY,ORID,PARM1,PARM2) Q
 ;Update new refills and pickup for the med order
 N REFID,PICKID,SUPPLYID,QTYID,ACT,IX,TXT,REFPOS,NDQUIT
 S (REFID,PICKID,ACT,REFPOS,NDQUIT)=0,ORY=""
 S ACT=+$P(ORID,";",2) S:ACT'>0 ACT=1
 S REFID=$O(^OR(100,+ORID,4.5,"ID","REFILLS",0))
 S PICKID=$O(^OR(100,+ORID,4.5,"ID","PICKUP",0))
 S SUPPLYID=$O(^OR(100,+ORID,4.5,"ID","SUPPLY",0))
 S QTYID=$O(^OR(100,+ORID,4.5,"ID","QTY",0))
 S:$D(^OR(100,+ORID,4.5,REFID,1)) ^(1)=PARM1
 S:$D(^OR(100,+ORID,4.5,PICKID,1)) ^(1)=PARM2
 S:$D(^OR(100,+ORID,4.5,+SUPPLYID,1)) ^(1)=$G(DAYSUP)
 S:$D(^OR(100,+ORID,4.5,+QTYID,1)) ^(1)=$G(QTY)
 S IX=0 F  S IX=$O(^OR(100,+ORID,8,ACT,.1,IX)) Q:('IX)!(NDQUIT)  D
 . S TXT=$G(^OR(100,+ORID,8,ACT,.1,IX,0))
 . I ($$UP^XLFSTR(TXT)["QUANTITY:"),($$UP^XLFSTR(TXT)["REFILLS:") D
 . . ;S REFPOS=$F($$UP^XLFSTR(TXT),"REFILLS")-$L("REFILLS")-1
 . . ;S TXT=$E(TXT,1,REFPOS)_"Refills: "_PARM1
 . . S TXT=" Quantity: "_$G(QTY)_" Refills: "_$G(PARM1)
 . . S ^OR(100,+ORID,8,ACT,.1,IX,0)=TXT,NDQUIT=1 Q
 D GETBYIFN^ORWORR(.ORY,+ORID)
 Q
 ;
TXTSAV(ORY,ORID,PARM1,PARM2) ;
 ; Update new start and stop date for the unsigned unreleased
 ; renewed text order
 N STRTID,STOPID
 S STRTID=$O(^OR(100,+ORID,4.5,"ID","START",0))
 S STOPID=$O(^OR(100,+ORID,4.5,"ID","STOP",0))
 S:$D(^OR(100,+ORID,4.5,STRTID,1)) ^(1)=PARM1
 S:$D(^OR(100,+ORID,4.5,STOPID,1)) ^(1)=PARM2
 D GETBYIFN^ORWORR(.ORY,+ORID)
 Q
 ;
ISSPLY(ORY,DLGID,QODLG) ;
 ; ORY=1: is "PSO SUPPLY" dialog
 N A,IFN
 S ORY=""
 S DLGID=$G(DLGID)
 I DLGID?1"X".E S IFN=$E(DLGID,2,99),A=$P($G(^OR(100,+IFN,0)),"^",5) D
 . I $P(A,";",2)[101.41 S DLGID=+A Q
 . S DLGID=0
 Q:+DLGID=0
 Q:'$D(^ORD(101.41,DLGID,0))
 I 'QODLG,($P(^ORD(101.41,DLGID,0),U)="PSO SUPPLY") S ORY=1
 I QODLG D
 . N SPLYDG S SPLYDG=$O(^ORD(100.98,"B","SPLY",0))
 . I $P(^ORD(101.41,DLGID,0),U,5)=SPLYDG S ORY=1
 Q
 ;
OXDATA(ORY,ORIEN) ; Return orderable item data for order check usage
 Q:'$D(^OR(100,+ORIEN,0))
 D MAYBEIV(.ORY,ORIEN,1) I $L($G(ORY))>1 Q
 N DISPSUP,DRUGID,OIID,IDX,IDY,DISPIN,DISPOUT,DISPID
 S (DRUGID,OIID,IDX,IDY,DISPIN,DISPOUT,DISPSUP)=0
 S DISPID=""
 S DISPIN=$O(^ORD(100.98,"B","UD RX",0))
 S DISPOUT=$O(^ORD(100.98,"B","O RX",0))
 N DISPCM S DISPCM=$O(^ORD(100.98,"B","CLINIC MEDICATIONS",0))
 N DISPCMIV S DISPCMIV=$O(^ORD(100.98,"B","CLINIC INFUSIONS",0))
 S DISPSUP=$O(^ORD(100.98,"B","SUPPLIES/DEVICES",0))
 S DRUGID=$O(^OR(100,+ORIEN,4.5,"ID","DRUG",0))
 S OIID=$O(^OR(100,+ORIEN,4.5,"ID","ORDERABLE",0))
 S DISPID=$P(^OR(100,+ORIEN,0),U,11)
 I DISPID=DISPIN S DISPID="PSI"
 I DISPID=DISPOUT S DISPID="PSO"
 I DISPID=DISPCM S DISPID="PSI"
 I DISPID=DISPCMIV S DISPID="PSI"
 I DISPID=DISPSUP S DISPID="PSO"
 I (DISPID'="PSI"),(DISPID'="PSO") Q
 I 'DRUGID,DISPID="PSI" D
 .N ORCHI S ORCHI=0 F  S ORCHI=$O(^OR(100,+ORIEN,2,ORCHI)) Q:'ORCHI  D
 ..N ORCHDRID,ORCHOIID,ORCHIDX,ORCHIDY
 ..S ORCHDRID=$O(^OR(100,+ORCHI,4.5,"ID","DRUG",0))
 ..S ORCHOIID=$O(^OR(100,+ORCHI,4.5,"ID","ORDERABLE",0))
 ..Q:'ORCHDRID
 ..Q:'ORCHOIID
 ..S ORCHIDX=$O(^OR(100,+ORCHI,4.5,ORCHDRID,0))
 ..S ORCHIDY=$O(^OR(100,+ORCHI,4.5,ORCHOIID,0))
 ..I ORCHIDX,ORCHIDY S ORY=$G(^OR(100,+ORCHI,4.5,ORCHOIID,ORCHIDY))_U_DISPID_U_$G(^OR(100,+ORCHI,4.5,ORCHDRID,ORCHIDX))_"|"_$G(ORY)
 Q:'DRUGID
 Q:'OIID
 S IDX=$O(^OR(100,+ORIEN,4.5,DRUGID,0))
 S IDY=$O(^OR(100,+ORIEN,4.5,OIID,0))
 I IDX,IDY,'+DISPID S ORY=$G(^OR(100,+ORIEN,4.5,OIID,IDY))_U_DISPID_U_$G(^OR(100,+ORIEN,4.5,DRUGID,IDX))
 Q
 ;
MAYBEIV(ORY,ORIEN,FORMAT) ; Return orderable item data for iv order check usage
 ;PARAMETERS: ORY   => REFERENCE TO ARRAY THAT STORES ORDERABLE ITEM DATA
 ;            ORIEN => ORDER NUMBER FROM ORDER FILE (#100)
 ;            FORMAT => FLAG DENOTING WHICH FORMAT TO RETURN THE DATA IN:
 ;                      NULL OR ZERO - NEW FORMAT (USING PIPE DELMITER)
 ;                      1 - OLD FORMAT (USING CAROT DELIMITER)
 N X0,ORDIALOG,DELIMIT
 S DELIMIT=$S($G(FORMAT):"|",1:U)
 S X0=^OR(100,+ORIEN,0)
 S ORDIALOG=+$P(X0,U,5)
 D GETDLG^ORCD(ORDIALOG)
 D GETORDER^ORCD(+ORIEN)
 I $D(ORDIALOG("B","SOLUTION")) D
 .N ORI,ORSUB
 .S ORSUB=$P(ORDIALOG("B","SOLUTION"),U,2)
 .S ORI=0 F  S ORI=$O(ORDIALOG(ORSUB,ORI)) Q:'ORI  D
 ..S:DELIMIT="|" ORY=$G(ORY)_"|"_$G(ORDIALOG(ORSUB,ORI))_U_"PSIV"_U_"B;"
 ..S:DELIMIT=U ORY=$G(ORY)_U_$G(ORDIALOG(ORSUB,ORI))_"|"_"PSIV"_"|"_ORSUB_"||"_ORIEN_"||"_"B"
 I $D(ORDIALOG("B","ADDITIVE")) D
 .N ORI,ORSUB
 .S ORSUB=$P(ORDIALOG("B","ADDITIVE"),U,2)
 .S ORI=0 F  S ORI=$O(ORDIALOG(ORSUB,ORI)) Q:'ORI  D
 ..S:DELIMIT="|" ORY=$G(ORY)_"|"_$G(ORDIALOG(ORSUB,ORI))_U_"PSIV"_U_"A"
 ..S:DELIMIT=U ORY=$G(ORY)_U_$G(ORDIALOG(ORSUB,ORI))_"|"_"PSIV"_"|"_ORSUB_"||"_ORIEN_"||"_"A"
 I $L($G(ORY),DELIMIT)>1 S ORY=$P(ORY,DELIMIT,2,$L(ORY,DELIMIT))
 Q
 ;
WARN(ORVAL,ORIFN,ORACTION) ; Should a warning be displayed for order action
 ;
 S ORVAL=0
 ;
 ; Copy
 I ORACTION="RW" D  Q:ORVAL
 . ; Return warning if copying outpatient med order marked for titration
 . I $$ISTITR^ORUTL3(+ORIFN) D
 . . S ORVAL="1^This prescription has been marked as a titration order. "
 . . S ORVAL=ORVAL_"Creating a COPY of the order will repeat the titration instructions. "
 . . S ORVAL=ORVAL_"If you only want to copy the maintenance portion, please use the RENEW action. "
 . . S ORVAL=ORVAL_"Do you wish to proceed? "
 ;
 ; Change
 I ORACTION="XX" D  Q:ORVAL
 . ; Return warning if changing outpatient med order marked for titration
 . I $$ISTITR^ORUTL3(+ORIFN) D
 . . S ORVAL="1^This prescription has been marked as a titration order. "
 . . S ORVAL=ORVAL_"Do you wish to proceed? "
 ;
 ; Renew
 I ORACTION="RN" D  Q:ORVAL
 . ; Return warning if renewing outpatient med order marked for titration
 . I $$ISTITR^ORUTL3(+ORIFN) D
 . . S ORVAL="1^This prescription has been marked as a titration order. "
 . . S ORVAL=ORVAL_"Only the maintenance portion of the RX will be renewed. "
 . . S ORVAL=ORVAL_"If you want to re-titrate, please use the COPY action. "
 . . S ORVAL=ORVAL_"Do you wish to proceed? "
 ;
 Q
