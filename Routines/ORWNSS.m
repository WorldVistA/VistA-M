ORWNSS ;JDL/SLC Non-Standard Schedule ;11/24/06
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**195,243**;Dec 17, 1997;Build 242
NSSOK(ORY,ORX) ;Check availability for Non-standard schedule
 N VAL
 S VAL=$$PATCH^XPDUTL("PSJ*5.0*113")
 S ORY=VAL
 Q
NSSMSG(ORY) ;Retrieve site message for None-Standard Schedule
 N ORSRV
 S ORY=""
 S ORSRV=$G(^VA(200,DUZ,5)) I +ORSRV>0 S ORSRV=$P(ORSRV,U)
 S ORY=$$GET^XPAR("SRV.`"_+$G(ORSRV)_"^DIV^SYS","ORWIM NSS MESSAGE",1,"I")
 Q
VALSCH(ORY,ORID) ;Validate a schedule for IM order; 1: valid, 0: invalid
 ;
 S ORY=0
 Q:'$D(^OR(100,+ORID,0))
 N IPGRP,ORGRP
 S IPGRP=$O(^ORD(100.98,"B","UD RX",0))
 S ORGRP=$P($G(^OR(100,+ORID,0)),U,11)
 I ORGRP'=IPGRP S ORY=1 Q
 N SCH,IDX,SCHVAL S (SCH,SCHVAL)=""
 I $D(^OR(100,+ORID,4.5,"ID","SCHEDULE")) S SCH=$O(^OR(100,+ORID,4.5,"ID","SCHEDULE",0))
 I SCH="" S ORY=1 Q
 S IDX=0 F  S IDX=$O(^OR(100,+ORID,4.5,SCH,IDX)) Q:'IDX  D
 . S SCHVAL=$G(^OR(100,+ORID,4.5,SCH,IDX))
 . Q:'$L(SCHVAL)
 . D VALSCH^ORWDPS33(.ORY,SCHVAL,"I")
 . I ORY=0 Q
 Q
QOSCH(ORY,QOID) ;Validate IM QO schedule
 ;QOID: Inpt Pharmacy QO
 S ORY=""
 N QOSCH,SCHID,SCHVAL,RST
 S SCHID=$O(^ORD(101.41,"B","OR GTX SCHEDULE",0))
 S (QOSCH,SCHVAL)="",RST=1
 I '$D(^ORD(101.41,+QOID,6,"D",SCHID)) S ORY="schedule is not defined." Q
 S QOSCH=$O(^ORD(101.41,+QOID,6,"D",SCHID,0))
 I 'QOSCH S ORY="schedule is not defined." Q
 N IDX S IDX=0
 F  S IDX=$O(^ORD(101.41,+QOID,6,QOSCH,IDX)) Q:'IDX!('RST)  D
 . S SCHVAL=^ORD(101.41,+QOID,6,QOSCH,IDX)
 . I $$UP^XLFSTR(SCHVAL)="OTHER" S ORY="OTHER" Q
 . D VALSCH^ORWDPS33(.RST,SCHVAL,"I")
 . I RST=0 S ORY="This quick order contains a non-standard administration schedule." Q
 Q
CHKSCH(ORY,SCH) ;Validate schedule
 Q:SCH=""
 D VALSCH^ORWDPS33(.ORY,SCH,"I")
 Q
