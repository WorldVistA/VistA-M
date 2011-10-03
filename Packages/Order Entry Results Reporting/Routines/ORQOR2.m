ORQOR2 ; slc/CLA - Extrinsic functions which return order information ;6/14/96  10:15 [ 04/02/97  1:35 PM ]
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**6,32,92,122,144,190,251**;Dec 17, 1997
STATUS(ORN) ;extrinsic function returns the current status of an order in
 ;the format: status ien^external text 
 ;DBIA #3458 supported api for outpt pharmacy
 Q:'$L($G(ORN)) ""
 Q:'$L($G(^OR(100,ORN,3))) ""
 N ORSTATUS
 S ORSTATUS=$P(^OR(100,ORN,3),U,3)
 S ORSTATUS=ORSTATUS_U_$G(^ORD(100.01,+ORSTATUS,0))
 Q ORSTATUS
RECENT(PT,OI,ST) ;extrinsic funct returns pt's most recent order for an orderable item and status in format:
 ; order number^order text (truncated to 60 chars)^start d/t^status
 N INDT,ORN,CDT,ORSTATUS,ORTEXT,RESULT S RESULT="",ORN="",INDT=""
 F  S INDT=$O(^OR(100,"AOI",OI,PT_";DPT(",INDT)) Q:INDT=""!(RESULT'="")  D
 .F  S ORN=$O(^OR(100,"AOI",OI,PT_";DPT(",INDT,ORN)) Q:ORN=""  D
 ..S ORSTATUS=$P(^OR(100,ORN,3),U,3)
 ..I '$L($G(ST))!($G(ORSTATUS)=ST) D
 ...S ORSTATUS=$G(^ORD(100.01,ORSTATUS,0)),CDT=9999999-INDT
 ...S ORTEXT=$P($$TEXT^ORKOR(ORN,60),U,2)
 ...S RESULT=ORN_U_ORTEXT_U_CDT_U_ORSTATUS
 Q RESULT
DUPRANGE(OI,DG,ODT,ORPT) ;extrinsic funct returns duplicate order range beginning date in the format:
 ;fileman d/t^inverse fileman d/t
 ;OI   = orderable item ien
 ;DG   = display group abbrev. (e.g. 'LR')
 ;ODT  = order effective/start date/time in FM format
 ;ORPT = patient dfn
 N DHRS,BDT,INBDT,ORSRV,ORLOC
 S BDT="",INBDT=""
 ;
 ;get patient's location flag (INPATIENT ONLY - outpt locations cannot be
 ;reliably determined, and many simultaneous outpt locations can occur):
 I +$G(ORPT)>0 D
 .N DFN S DFN=ORPT,VA200="" D OERR^VADPT
 .I +$G(VAIN(4))>0 S ORLOC=+$G(^DIC(42,+$G(VAIN(4)),44))
 .K VA200,VAIN
 ;
 S ORSRV=$G(^VA(200,DUZ,5)) I +ORSRV>0 S ORSRV=$P(ORSRV,U)
 S DHRS=$$GET^XPAR("LOC.`"_$G(ORLOC)_"^SRV.`"_$G(ORSRV)_"^DIV^SYS","ORK DUP ORDER RANGE OI",OI,"I")
 Q:$G(DHRS)=0 "0^0" ;quit if number of hours for this OI is zero
 I +$G(DHRS)<1 D
 .I DG="LR" S DHRS=$$GET^XPAR("LOC.`"_$G(ORLOC)_"^SRV.`"_$G(ORSRV)_"^DIV^SYS^PKG","ORK DUP ORDER RANGE LAB",1,"I")
 .I DG="RA" S DHRS=$$GET^XPAR("LOC.`"_$G(ORLOC)_"^SRV.`"_$G(ORSRV)_"^DIV^SYS^PKG","ORK DUP ORDER RANGE RADIOLOGY",1,"I")
 I +$G(DHRS)<1 S DHRS=48  ;non-lab and non-radiology default is 48 hrs
 S BDT=$$FMADD^XLFDT(ODT,"","-"_DHRS,"",""),INBDT=9999999-BDT
 Q BDT_U_INBDT
ORDERER(ORNUM) ;ext. funct. gets ordering provider DUZ from ORDER File (#100)
 Q:'$L($G(ORNUM)) ""
 S ORNUM=+$G(ORNUM)
 N ORQDUZ,ORQI S ORQDUZ=""
 I $L($G(^OR(100,ORNUM,8,0))) D
 .S ORQI=0,ORQI=$O(^OR(100,ORNUM,8,"C","NW",ORQI))  ;8 node for New order
 Q:+$G(ORQI)<1 ""
 S ORQDUZ=$P(^OR(100,ORNUM,8,ORQI,0),U,3)
 Q ORQDUZ
UNSIGNOR(ORNUM) ;ext. funct. gets ordering provider DUZ from ORDER File (#100)
 ; based on order action number (8 node)
 ; if no action number return orderer for New order
 ;ORNUM in format: <order ien>;<action number>
 Q:'$L(+$G(ORNUM)) ""
 N ORQDUZ,ORQI S ORQDUZ=""
 S ORQI=$P(ORNUM,";",2)
 S ORNUM=$P(ORNUM,";")
 Q:+$G(ORNUM)<1 ""
 I +$G(ORQI)<1 S ORQI=$P($G(^OR(100,ORNUM,8,0)),U,3)
 I $L(ORQI),$L($G(^OR(100,ORNUM,8,ORQI,0))) D
 .S ORQDUZ=$P(^OR(100,ORNUM,8,ORQI,0),U,3)
 Q ORQDUZ
OI(ORNUM) ;ext. funct. gets Orderable Item ien from ORDER File (#100)
 Q:+$G(ORNUM)<1 ""
 N OI S OI=""
 S OI=+$G(^OR(100,+$G(ORNUM),.1,1,0))
 Q OI
DG(ORNUM) ;ext. funct. gets Display Group ien from ORDER File (#100)
 Q:'$L($G(ORNUM)) ""
 N DG S DG=""
 S DG=$G(^OR(100,ORNUM,0))
 I $L(DG) S DG=$P(DG,U,11)
 Q DG
DGRX(ORNUM)        ;ext. funct. determines if order is pharmacy order
 Q:+$G(ORNUM)<1 ""
 N DG,DGNAME,RXDG
 S DG=$$DG(ORNUM)
 S DGNAME=$P($G(^ORD(100.98,+DG,0)),U) Q:'$L(DGNAME) ""
 F RXDG="PHARMACY","INPATIENT MEDICATIONS","OUTPATIENT MEDICATIONS","UNIT DOSE MEDICATIONS","IV MEDICATIONS","NON-VA MEDICATIONS","CLINIC ORDERS","" Q:(DGNAME=RXDG)
 Q RXDG
PT(ORNUM) ;ext. funct. gets Patient dfn from ORDER File (#100)
 Q:'$L($G(ORNUM)) ""
 N PT S PT=""
 S PT=$G(^OR(100,ORNUM,0))
 I $L(PT) S PT=$P(PT,U,2),PT=$P(PT,";DPT")
 Q PT
RSLTFLG(ORNUM) ;ext. funct. returns duz of user to receive alert if order was
 ; flagged to alert when resulted
 Q:'$L($G(ORNUM)) ""
 N FLG S FLG=""
 S FLG=$G(^OR(100,+ORNUM,3))
 I $L(FLG) S FLG=$P(FLG,U,10)
 Q FLG
