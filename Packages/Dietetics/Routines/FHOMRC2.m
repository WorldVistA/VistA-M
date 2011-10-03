FHOMRC2 ;Hines OIFO/RTK BACKDOOR CANCEL OUTPATIENT MEALS  ;4/27/05  10:05
 ;;5.5;DIETETICS;**2,5**;Jan 28, 2005;Build 53
 ;
CNRM100 ;Backdoor message to update file #100 with RM cancel order
 S FHORN=$P($G(^FHPT(FHDFN,"OP",FHRNUM,0)),U,12)
 S FHMPNUM=$P($G(^FHPT(FHDFN,"OP",FHRNUM,0)),U,6)
 S FHDT=$P($G(^FHPT(FHDFN,"OP",FHRNUM,0)),U,1)
 S FILL="R;"_FHMPNUM_";"_FHDT_";"_FHDT_";;"
 D CHECK
 I FHACTV=0 D CAN
 I FHACTV=1 D CANOCC
ASSOC I $D(^FHPT(FHDFN,"OP",FHRNUM,1)) D CNAO100,CANAO^FHOMRC1
 I $D(^FHPT(FHDFN,"OP",FHRNUM,2)) D CNEL100,CANEL^FHOMRC1
 I $D(^FHPT(FHDFN,"OP",FHRNUM,3)) D CNTF100,CANTF^FHOMRC1
 Q
CNAO100 ;Backdoor message to update file #100 with AO cancel order
 S FHORN=$P($G(^FHPT(FHDFN,"OP",FHRNUM,1)),U,4),FILL="A;"_FHRNUM D CAN Q
CNEL100 ;Backdoor message to update file #100 with EL cancel order
 S FHORN=$P($G(^FHPT(FHDFN,"OP",FHRNUM,2)),U,5),FILL="E;"_FHRNUM D CAN Q
CNTF100 ;Backdoor message to update file #100 with TF cancel order
 S FHORN=$P($G(^FHPT(FHDFN,"OP",FHRNUM,3)),U,4),FILL="T;"_FHRNUM D CAN Q
CNIP100 ;Backdoor message to update file #100 with IP cancel order
 S FHORN=$P($G(^FHPT(FHDFN,0)),U,6),FILL="I;CANCEL" D CAN Q
CNSM100 ;Backdoor message to update file #100 with SM cancel order
 S FHORN=$P($G(^FHPT(FHDFN,"SM",FHDA,0)),U,12),FILL="S;"_FHDA D CAN
 ;if an SM E/L Tray exists cancel that too:
CNSMEL S FHORN=$P($G(^FHPT(FHDFN,"SM",FHDA,1)),U,4) I FHORN="" Q
 S FILL="G;"_FHDA D CAN Q
CAN ;
 Q:'$$PATCH^XPDUTL("OR*3.0*215")  ;must have CPRSv26 for O.M. backdoor
 Q:'DFN  D MSHCA^FHOMUTL,EVSEND^FHWOR
 Q
CANOCC ; If cancelling occurences of RM (not ALL) then send "XX" message
 ; instead of "OC" which will cancel the entire order in CPRS.
 Q:'$$PATCH^XPDUTL("OR*3.0*215")  ;must have CPRSv26 for O.M. backdoor
 Q:'DFN  K MSG D MSHOM^FHOMUTL  ;Sets MSG(1), MSG(2) & MSG(3) for OM
 S FHOSTDT=$P($G(^FHPT(FHDFN,"OP",FHRNUM,0)),U,1)
 S FHOSTDT=$$FMTHL7^XLFDT(FHOSTDT)
 S MSG(4)="ORC|XX|"_FHORN_"^OR|"_FILL_"^FH||||^^^"_FHOSTDT_"^"_FHOSTDT
 S MSG(5)="ODS|||^^^FH-X^Meal Canceled^99OTH|"
 D EVSEND^FHWOR
 Q
CHECK ; Check if there are other "active" RM's to determine if entire order
 ; should be cancelled
 S FHACTV=0,FHMPNUM=$P($G(^FHPT(FHDFN,"OP",FHRNUM,0)),U,6)
 F FHINDX=0:0 S FHINDX=$O(^FHPT(FHDFN,"OP","C",FHMPNUM,FHINDX)) Q:FHINDX'>0!(FHACTV=1)  D
 .I $P($G(^FHPT(FHDFN,"OP",FHINDX,0)),U,1)<DT Q
 .I $P($G(^FHPT(FHDFN,"OP",FHINDX,0)),U,15)'="C" S FHACTV=1
 .Q
 Q
