EDPFMON ;SLC/MKB - ED Monitor at facility ;2/28/12 08:33am
 ;;2.0;EMERGENCY DEPARTMENT;;May 2, 2012;Build 103
 ;
EN(MSG) ; -- main entry point for EDP MONITOR where MSG contains HL7 msg
 N EDMSG,PKG,MSH,PID,PV1,ORC,DFN,LOG
 S EDMSG=$S($L($G(MSG)):MSG,1:"MSG"),MSH=0       ;MSG="NAME" or MSG(#)
 F  S MSH=$O(@EDMSG@(MSH)) Q:MSH'>0  Q:$E(@EDMSG@(MSH),1,3)="MSH"
 Q:'MSH                                          ;no message/header
 S PKG=$$PKG($P(@EDMSG@(MSH),"|",3)) Q:'$L(PKG)  ;unknown or not tracked
 S DFN=$$PID Q:DFN<1                             ;missing patient
 S LOG=+$O(^EDP(230,"APA",DFN,0)) Q:LOG<1        ;not in ED now
 S ORC=0 F  S ORC=$O(@EDMSG@(+ORC)) Q:ORC'>0  I $E(@EDMSG@(ORC),1,3)="ORC" D
 . N ORDCNTRL,ORIFN,STS,RTN
 . S ORC=ORC_U_@EDMSG@(ORC),ORDCNTRL=$TR($P(ORC,"|",2),"@","P")
 . Q:'$L(ORDCNTRL)
 . S ORIFN=$P($P(ORC,"|",3),U),STS=$P(ORC,"|",6)
 . S RTN=$S("NW^OK^XR"[ORDCNTRL:"NEW",1:"UPD")
 . D @RTN
 Q
 ;
ENOR(MSG) ; -- main entry point for EDP OR MONITOR where MSG contains HL7 msg
 N EDMSG,PKG,MSH,PID,PV1,ORC,DFN,LOG
 S EDMSG=$S($L($G(MSG)):MSG,1:"MSG"),MSH=0       ;MSG="NAME" or MSG(#)
 F  S MSH=$O(@EDMSG@(MSH)) Q:MSH'>0  Q:$E(@EDMSG@(MSH),1,3)="MSH"
 Q:'MSH                                          ;no message/header
 S PKG=$$PKG($P(@EDMSG@(MSH),"|",5)) Q:'$L(PKG)  ;unknown or not tracked
 S DFN=$$PID Q:DFN<1                             ;missing patient
 S LOG=+$O(^EDP(230,"APA",DFN,0)) Q:LOG<1        ;not in ED now
 S ORC=0 F  S ORC=$O(@EDMSG@(+ORC)) Q:ORC'>0  I $E(@EDMSG@(ORC),1,3)="ORC" D
 . N ORDCNTRL,ORIFN
 . S ORC=ORC_U_@EDMSG@(ORC),ORDCNTRL=$TR($P(ORC,"|",2),"@","P")
 . Q:ORDCNTRL'="NA"                              ;new backdoor ack
 . S ORIFN=$P($P(ORC,"|",3),U)
 . D NEW
 Q
 ;
PKG(NAME) ; -- Returns package code
 I NAME="RADIOLOGY"!(NAME="IMAGING") Q "R"
 I NAME="LABORATORY" Q "L"
 I NAME="PHARMACY" Q "M"
 I NAME="CONSULTS" Q "C"
 I NAME="PROCEDURES" Q "C"
 I NAME="DIETETICS" Q "A"
 I NAME="ORDER ENTRY" Q "A"
 Q ""
 ;
PID() ; -- Returns patient DFN from PID segment in current msg
 N I,Y,SEG S I=MSH,Y=""
 F  S I=$O(@EDMSG@(I)) Q:I'>0  S SEG=$E(@EDMSG@(I),1,3) Q:SEG="ORC"  I SEG="PID" S Y=+$P(@EDMSG@(I),"|",4) Q
 Q Y
 ;
PV1() ; -- Returns patient location from PV1 segment in current msg
 N I,Y,SEG S I=MSH,Y=""
 F  S I=$O(@EDMSG@(I)) Q:I'>0  S SEG=$E(@EDMSG@(I),1,3) Q:SEG="ORC"  I SEG="PV1" S Y=+$P(@EDMSG@(I),"|",4) Q
 Q Y
 ;
NEW ; -- add new order to patient log
 Q:'$G(ORIFN)  Q:$$START(ORIFN)>DT  ;no future orders
 N MSG,URG,ORL
 S ORL=+$$GET1^DIQ(100,+ORIFN_",",6,"I")
 I ORL,'$$ED(ORL) Q  ;not ED location
 S URG=$$VALUE^ORCSAVE2(+ORIFN,"URGENCY") S:'URG URG=9 ;routine
 S MSG(1)="command=newOrder"
 S MSG(2)="id="_LOG
 S MSG(3)="orifn="_+ORIFN
 S MSG(4)="pkg="_PKG
 S MSG(5)="sts="_"N"
 S MSG(6)="stat="_(URG<3) ;1=STAT or 2=ASAP
 S MSG(7)="release="_$$NOW^XLFDT
 D SEND(.MSG)
 Q
 ;
ED(LOC) ; -- Return 1 or 0 if LOCation is part of ED
 N EDLOC,I,Y
 D GETLST^XPAR(.EDLOC,"ALL","EDPF LOCATION")
 S (I,Y)=0 F  S I=$O(EDLOC(I)) Q:I<1  I $P(EDLOC(I),U,2)=LOC S Y=1 Q
 Q Y
 ;
START(IFN) ; -- return start date (day only) of order
 N X,Y,%DT
 S Y=+$$GET1^DIQ(100,+$G(IFN)_",",21,"I") I Y<1 D
 . S X=$$VALUE^ORCSAVE2(+IFN,"START")
 . I '$L(X) S Y=DT Q  ;assume NOW
 . S %DT="T" D ^%DT S:Y<1 Y=""
 S Y=$P(Y,".")
 Q Y
 ;
UPD ; -- update state of order in log
 I ORDCNTRL="RE" D STS("C") Q
 I "CA^DC^OC^OD^CR^DR"[ORDCNTRL D DEL Q  ;??
 I PKG="L",ORDCNTRL="SC" D STS("A") Q
 I PKG="R",ORDCNTRL="SC" D STS("A") Q
 I PKG="C","SC^XX"[ORDCNTRL D STS("A") Q
 I PKG="M" D  Q
 . I "RO^XX^ZV"[ORDCNTRL D STS("A") Q
 . Q:ORDCNTRL'="SC"  Q:'$L(STS)
 . I "DC^ZE^RP"[STS D STS("C") Q
 . D STS("A")
 I PKG="A","SC^XX"[ORDCNTRL D  Q
 . I "DC^ZE"[STS D STS("C") Q
 . D STS("A")
 Q
 ;
STS(X) ; -- update status
 N MSG
 S MSG(1)="command=updateOrder"
 S MSG(2)="id="_LOG
 S MSG(3)="orifn="_+ORIFN
 S MSG(4)="sts="_X
 D SEND(.MSG)
 Q
 ;
DEL ; -- remove order
 N MSG
 S MSG(1)="command=deleteOrder"
 S MSG(2)="id="_LOG
 S MSG(3)="orifn="_+ORIFN
 D SEND(.MSG)
 Q
 ;
VER(ORIFN) ; -- update status when ORIFN verified
 N LOG,MSG S ORIFN=+$G(ORIFN)
 S LOG=+$O(^EDP(230,"AO",ORIFN,0)) Q:LOG<1  ;not in ED
 S MSG(1)="command=verifyOrder"
 S MSG(2)="id="_LOG
 S MSG(3)="orifn="_ORIFN
 D SEND(.MSG)
 Q
 ;
COMP(ORIFN) ; -- update status when ORIFN completed
 N LOG,MSG S ORIFN=+$G(ORIFN)
 S LOG=+$O(^EDP(230,"AO",ORIFN,0)) Q:LOG<1  ;not in ED
 S MSG(1)="command=completeOrder"
 S MSG(2)="id="_LOG
 S MSG(3)="orifn="_ORIFN
 D SEND(.MSG)
 Q
 ;
 ; -- Monitor SDAM APPOINTMENT EVENTS for patients checking-in to ED
 ; 
SDAM ; -- send bulletin on check-in
 N EDPEVENT
 S EDPEVENT=$$GET^XPAR("ALL","EDPF SCHEDULING TRIGGER",1,"Q")
 S:'EDPEVENT EDPEVENT=4
 Q:$G(SDAMEVT)'=EDPEVENT
 ;
 N EDPLST,X,FOUND
 D GETLST^XPAR(.EDPLST,"ALL","EDPF LOCATION","I")
 S X="",FOUND=0
 F  S X=$O(EDPLST(X)) Q:X=""  I $P(SDATA,U,4)=EDPLST(X) S FOUND=1 Q
 Q:'FOUND
 ;
 N DFN,DATE,HLOC
 S DFN=+$P(SDATA,U,2),DATE=+$P(SDATA,U,3),HLOC=+$P(SDATA,U,4)
 ; your code goes here :)
 N MSG
 S MSG(1)="command=patientCheckIn"
 S MSG(2)="dfn="_DFN
 S MSG(3)="ptNm="_$P(^DPT(DFN,0),U)
 S MSG(4)="ssn="_$P(^DPT(DFN,0),U,9)
 S MSG(5)="hloc="_HLOC
 S MSG(6)="site="_DUZ(2)
 S MSG(7)="time="_DATE  ; appt date to match PCE
 D SEND(.MSG)
 Q
 ;
SEND(MSG) ; Transfer control to message handler
 D MSG^EDPMAIL(.MSG)
 Q
