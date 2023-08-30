ORALWORD ; SLC/JMH - Utilities for Checking if an order can be ordered ;Apr 21, 2021@10:02:50
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**243,427,405,499**;Dec 17, 1997;Build 165
 ;External reference $$CL^YSCLTST2 controlled by DBIA 4556
 ;External reference $$OVERRIDE^YSCLTST2 controlled by DBIA 4556
 ;Reference to ^DIQ supported by DBIA #2056
 ;Reference to ^PSS50 supported by DBIA #4533
 ;Reference to $$DEA^XUSER supported by DBIA #2343
 ;
ALLWORD(ORY,DFN,ORX,ORTYPE,PROV) ;
 N OROI,ORYS,QOIEN,QPIEN,ORCLOZ,QOAA,DPKG
 S OROI=0
 ;
 ;ORTYPE used to determine the type of data coming into the call
 ;ORYTPE="E" existing order, ORX equal the IEN from file 100 (used with
 ;copy,edit functionality)
 ;ORTYPE="Q" Quick Order, ORX equal the IEN from file 101.41
 ;ORTYPE="N" New order, ORX equal the IEN from file 101.41
 ;
 I ORTYPE="E" S OROI=$G(^OR(100,ORX,.1,1,0)) N ORTXT D TEXT^ORQ12(.ORTXT,ORX) ; ajb added N and TEXT call
 I ORTYPE="Q" D
 .S QPIEN=$O(^ORD(101.41,"AB","OR GTX ORDERABLE ITEM","")) Q:QPIEN'>0
 .S QOIEN=$O(^ORD(101.41,ORX,6,"D",QPIEN,"")) Q:QOIEN'>0
 .S OROI=$G(^ORD(101.41,ORX,6,QOIEN,1))
 .S QOAA=$P($G(^ORD(101.41,ORX,5)),U,8)
 I ORTYPE="N" S OROI=ORX
 Q:OROI'>0
 ; patch 499
 N ORZIPOK S ORZIPOK=1 D  I 'ORZIPOK Q
 . I $G(DLGIEN) S DPKG=$P($G(^ORD(101.41,+DLGIEN,0)),U) I $L(DPKG),(DPKG'["PSO") Q
 . D ZIP^ORWDPS11(.ORZIPOK,OROI,"PSO",DFN) I 'ORZIPOK D
 . . N COUNT,ORY0 S COUNT=+$O(ORY(""),-1)+1,ORY(COUNT)=$P(ORZIPOK,"^",2)
 . . S ORY0="Order Not Placed - Missing Patient Address"
 . . S ORY(0)=$S($L($G(ORY(0))):$G(ORY(0))_" | "_ORY0,1:ORY0)
 ;
 S ORY=0
 ;checks if the orderable item (OROI) is a clozapine med
 ;  if not returns ORY=0
 S ORCLOZ=$$ISCLOZ(OROI),ORY=ORY_U_ORCLOZ,ORY(0)=U_ORCLOZ
 Q:'ORCLOZ
 N ORQUIT
 S ORQUIT=0
 I '$G(PROV) S PROV=DUZ
 I $G(PROV) D  ; ajb v32 *405
 . N ORDEA,ORKEY S (ORDEA,ORKEY)=0
 . I '$L($$DEA^XUSER(,PROV)) S ORDEA=1
 . I '$D(^XUSEC("YSCL AUTHORIZED",PROV)) S ORKEY=1
 . I +ORDEA!+ORKEY D
 . . S ORQUIT=1,ORY=1
 . . S ORY(1)="Warning:  This CLOZAPINE order will NOT be "_$S(ORTYPE="E":"transferred.",1:"placed.")
 . . S ORY(2)=""
 . . I +$D(ORTXT) S ORY(3)="" D
 . . . N X S X=0 F  S X=$O(ORTXT(X)) Q:'+X  S ORY(3)=ORY(3)_ORTXT(X)
 . . S:$G(ORY(3))'="" ORY(4)=""
 . . S ORY(5)="You are NOT authorized to place CLOZAPINE orders."
 . . S ORY(6)=""
 . . S ORY(7)="Reason:  "_$S(+ORDEA&+ORKEY:"You do not have a DEA# and missing key YSCL AUTHORIZED.",+ORDEA:"You do not have a DEA#.",1:"You are missing key YSCL AUTHORIZED.")
 . . S ORY(8)=""
 . . S ORY(9)="Contact your Pharmacy for more information about the authorization requirements for ordering CLOZAPINE."
 . . N ORMSG D GETWP^XPAR(.ORMSG,"SYS","OR CPRS CLOZAPINE CUSTOM MSG")
 . . I +$D(ORMSG) S ORMSG=0 F  S ORMSG=$O(ORMSG(ORMSG)) Q:'+ORMSG  S ORY(8+ORMSG)=ORMSG(ORMSG,0) ; replace ORY(9) with custom message line(s)
 . . ;S ORY(1)="*** You are not authorized to place Clozapine orders."
 . . ;S ORY(2)="You must have a DEA#.  Please contact your"
 . . ;S ORY(3)="CAC or IRM for more information. ***"
 . . ;S ORY(1)="*** You are not authorized to place Clozapine orders."
 . . ;S ORY(2)="You must hold key YSCL AUTHORIZED.  Please contact your"
 . . ;S ORY(3)="CAC or IRM for more information on this key. ***"
 Q:ORQUIT
 ;  if is a cloz med , check if patient (DFN) can have a clozapine med
 S ORYS=$$CL^YSCLTST2(DFN)
 ;    if yes returns ORY=0
 I +ORYS>0 D BEFQUIT  Q
 ;    if no
 ;      returns
 ;    ORY=1
 ;    ORY(0)=CAPTION FOR DIALOG BOX
 ;    ORY(1-N)=MESSAGE TO DISPLAY
 S ORY=1_U_ORCLOZ,ORY(0)="Problem Ordering Clozapine Related Medication"_U_ORCLOZ
 ;patient not in clozapine patient program
 ;; START NCC REMEDIATION >> 427*RJS
 I +ORYS<0 D  Q
 .S ORY(1)="*** This patient is not registered in the clozapine treatment "
 .S ORY(2)="program or has been discontinued from the program. A new"
 .S ORY(3)="registration number must be assigned. If this is not an emergency,"
 .S ORY(4)="contact the NCCC. For emergency registration during non-NCCC duty"
 .S ORY(5)="hours, a written order to the pharmacist can be used to process a"
 .S ORY(6)="registration override. ***"
 ;problem with lab tests
 I +ORYS=0 D  Q
 .I $$OVERRIDE^YSCLTST2(DFN) S ORY=0_U_ORCLOZ,ORY(0)=U_ORCLOZ D BEFQUIT  Q  ;override allowed
 .I +$P(ORYS,"^",2),$P(ORYS,"^",4)<1000 D
 ..N COUNT S COUNT=0
 ..S COUNT=COUNT+1,ORY(COUNT)="*** This clozapine drug may not be dispensed to the patient at this "
 ..S COUNT=COUNT+1,ORY(COUNT)="time based on the available lab tests related to the clozapine "
 ..S COUNT=COUNT+1,ORY(COUNT)="treatment program. Please contact the NCCC to request an override in"
 ..S COUNT=COUNT+1,ORY(COUNT)="order to proceed with dispensing this drug. ***"
 ..D DISPRSLT
 .I '$P(ORYS,U,2),$P(ORYS,U,4) D
 ..N COUNT S COUNT=0
 ..S COUNT=COUNT+1,ORY(COUNT)="*** Permission to dispense clozapine has been denied based on the available"
 ..S COUNT=COUNT+1,ORY(COUNT)="lab tests related to the clozapine treatment program.***"
 ..S COUNT=COUNT+1,ORY(COUNT)=""
 ..S COUNT=COUNT+1,ORY(COUNT)="The latest lab test results drawn in the past 7 days have ANC results but no"
 ..S COUNT=COUNT+1,ORY(COUNT)="matching WBC. Redo the lab tests or contact the NCCC for a National Override"
 ..S COUNT=COUNT+1,ORY(COUNT)="to dispense clozapine with no matching WBC results."
 ..D DISPRSLT
 .I '+$P(ORYS,"^",4) D MSG
 Q
MSG      ;
 N COUNT S COUNT=0
 S COUNT=COUNT+1,ORY(COUNT)="*** Permission to dispense clozapine has been denied based on the"
 S COUNT=COUNT+1,ORY(COUNT)="available lab tests related to the clozapine treatment program. ***"
 S COUNT=COUNT+1,ORY(COUNT)=""
 I $P($G(X0),U)["PSJ" D DISPRSLT S COUNT=COUNT+1,ORY(COUNT)=""
 S COUNT=COUNT+1,ORY(COUNT)="For a National Override to dispense at the patient's normal"
 S COUNT=COUNT+1,ORY(COUNT)="frequency, contact the NCCC."
 S COUNT=COUNT+1,ORY(COUNT)=""
 D:$D(X0)  ;; NCC REMEDIATION << 427 RTW Special Conditions selections for outpatient and inpatient RTW
 .I $P(X0,U,1)["PSO" D
 ..S COUNT=COUNT+1,ORY(COUNT)="A local emergency override for an Outpatient can be approved for:"
 ..S COUNT=COUNT+1,ORY(COUNT)="(1) weather-related conditions, (2) mail order delays of clozapine,"
 ..S COUNT=COUNT+1,ORY(COUNT)="or (3) inpatient going on leave."
 ..S COUNT=COUNT+1,ORY(COUNT)=""
 ..S COUNT=COUNT+1,ORY(COUNT)="For an Outpatient Special Conditions Local Override, a written prescription from"
 ..S COUNT=COUNT+1,ORY(COUNT)="the provider with documentation to the pharmacist is required to dispense"
 ..S COUNT=COUNT+1,ORY(COUNT)="a one-time emergency 4-day supply."
 .I $P(X0,U,1)["PSJ" D
 ..S COUNT=COUNT+1,ORY(COUNT)="A local emergency override for an Inpatient can be approved for:"
 ..S COUNT=COUNT+1,ORY(COUNT)="IP Order Override with Outside Lab Results"
 ..S COUNT=COUNT+1,ORY(COUNT)=""
 ..S COUNT=COUNT+1,ORY(COUNT)="For a Special Conditions Local Override, a written order from"
 ..S COUNT=COUNT+1,ORY(COUNT)="the provider with documentation to the pharmacist is required to"
 ..S COUNT=COUNT+1,ORY(COUNT)="dispense a one-time 4-day supply."
 ..S COUNT=COUNT+1,ORY(COUNT)=""
 ..S COUNT=COUNT+1,ORY(COUNT)="The provider must record the ANC from another facility including date/time in both the Provider Progress Note and Comment field in CPRS."
 Q
DISPRSLT ; Display Lab Tests
 S COUNT=COUNT+1,ORY(COUNT)="Related Lab Test(s)"
 S COUNT=COUNT+1,ORY(COUNT)="==================="
 I $L($P(ORYS,U,3)) S COUNT=COUNT+1,ORY(COUNT)="WBC:  "_($P(ORYS,U,2)/1000)_" K/cmm"
 E  S COUNT=COUNT+1,ORY(COUNT)="WBC:  NO TEST RESULTS FOUND"
 I $L($P(ORYS,U,5)) S COUNT=COUNT+1,ORY(COUNT)="ANC:  "_($P(ORYS,U,4)/1000)_" K/cmm"
 E  S COUNT=COUNT+1,ORY(COUNT)="ANC:  NO TEST RESULTS FOUND"
 S COUNT=COUNT+1,ORY(COUNT)="Date/Time of last tests: "_$$DATE^ORU($P(ORYS,U,6))
 Q
 ;; END NCC REMEDIATION << 427*RTW
BEFQUIT  ;
 Q:'$G(QOAA)
 N QODS,QORF,ORMAX,ORCLPAT
 S QODS=$O(^ORD(101.41,"AB","OR GTX DAYS SUPPLY","")) Q:QODS'>0
 S QODS=$O(^ORD(101.41,ORX,6,"D",QODS,"")) Q:QOIEN'>0
 S QODS=$G(^ORD(101.41,ORX,6,QODS,1))
 S QORF=$O(^ORD(101.41,"AB","OR GTX REFILLS","")) Q:QORF'>0
 S QORF=$O(^ORD(101.41,ORX,6,"D",QORF,"")) Q:QOIEN'>0
 S QORF=$G(^ORD(101.41,ORX,6,QORF,1))
 S QORF=QORF+1
 S ORCLPAT=$P(ORYS,U,7)
 S ORMAX=$S(ORYS="M":28,ORYS="B":14,ORYS="W":7,1:90)
 I QORF*QODS>ORMAX D
 .K ORY
 .S ORY=1_U_ORCLOZ,ORY(0)="Problem Ordering Clozapine Related Medication"_U_ORCLOZ
 .S ORY(1)="*** This patient is only allowed an order with a maximum Days Supply of "_ORMAX_"."
 .S ORY(2)="This includes the amounts added by any refills entered in with the order also."
 Q
ISCLOZ(OROI) ;
 N ORPSOI,ORPSDRUG,ISCLOZ
 S ORPSOI=$$GET1^DIQ(101.43,OROI,2)
 I $P(ORPSOI,";",2)'="99PSP" Q 0
 K ^TMP($J,"ORCLOZ")
 D ASP^PSS50(+ORPSOI,,,"ORCLOZ")
 S (ORPSDRUG,ISCLOZ)=0
 F  S ORPSDRUG=$O(^TMP($J,"ORCLOZ",ORPSDRUG)) Q:'ORPSDRUG  D  Q:ISCLOZ
 .K ^TMP($J,"ORCLOZ2")
 .D CLOZ^PSS50(ORPSDRUG,,,,,"ORCLOZ2")
 .I $G(^TMP($J,"ORCLOZ2",ORPSDRUG,"CLOZ",0))>0 S ISCLOZ=1
 K ^TMP($J,"ORCLOZ"),^TMP($J,"ORCLOZ2")
 Q ISCLOZ
ALLWRN(ORY,ORN,REFILLS) ;allow order to be renewed
 ;ORN is the order number
 ;REFILLS is the number of refills to be included with the renewed order
 N ORDS,ORQT,ORUPD,ORSCH,ORDUR,ORDFN,ORDRG,OROI,ORMAXDS,ORMAXQT,ORCLOZ,ORREF,ORMAXREF
 ;default return 1 (ORY=1 means allow renew)
 S ORY=1
 ;get DFN (ORDFN)
 S ORDFN=+$P(^OR(100,ORN,0),U,2)
 Q:'ORDFN
 ;get if order is a clozapine order (ORCLOZ)
 S OROI=$G(^OR(100,ORN,.1,1,0)) Q:'OROI
 S ORCLOZ=$$ISCLOZ(OROI)
 ;quit if order is not clozapine
 I 'ORCLOZ Q
 ;get schedule from order (ORSCH)
 S ORSCH=$G(^OR(100,ORN,4.5,$O(^OR(100,ORN,4.5,"ID","SCHEDULE",0)),1))
 ;get units per dose from order (ORUPD)
 S ORSCH=$G(^OR(100,ORN,4.5,$O(^OR(100,ORN,4.5,"ID","DOSE",0)),1))
 S ORSCH=$P(ORSCH,"&",3)
 ;get duration from order (ORDUR)
 I '$O(^OR(100,ORN,4.5,"ID","DURATION",0)) S ORDUR="~^"
 E  S ORSCH=$G(^OR(100,ORN,4.5,$O(^OR(100,ORN,4.5,"ID","DURATION",0)),1))
 ;get days supply from order (ORDS)
 S ORSCH=$G(^OR(100,ORN,4.5,$O(^OR(100,ORN,4.5,"ID","SUPPLY",0)),1))
 ;get drug (ptr50) from order (ORDRG)
 S ORSCH=$G(^OR(100,ORN,4.5,$O(^OR(100,ORN,4.5,"ID","DRUG",0)),1))
 ;get refills from order (ORREF)
 S ORSCH=$G(^OR(100,ORN,4.5,$O(^OR(100,ORN,4.5,"ID","REFILLS",0)),1))
 ;get quantity from order (ORQT)
 S ORSCH=$G(^OR(100,ORN,4.5,$O(^OR(100,ORN,4.5,"ID","QTY",0)),1))
 ;get max days supply for order (ORMAXDS)
 S ORMAXDS=$$DEFSPLY^ORWDPS1(ORDFN)
 ;if ds from order is > max ds return 0 (ORY=0)
 I ORDS>ORMAXDS D  Q
 .S ORY=0
 .S ORY(0)="Problem Renewing Clozapine Related Medication"_U_ORCLOZ
 .S ORY(1)="The Days Supply set for this order is greater than the Max Days Supply"
 .S ORY(2)="    allowed for this patient."
 ;get max quantity for order (ORMAXQT)
 D DAY2QTY^ORWDPS2(.ORMAXQT,ORDS,ORUPD,ORSCH,ORDUR,ORDFN,ORDRG)
 ;if qt from order is > max qt return 0 (ORY=0)
 I ORQT>ORMAXQT D  Q
 .S ORY=0
 .S ORY(0)="Problem Renewing Clozapine Related Medication"_U_ORCLOZ
 .S ORY(1)="The Quantity set for this order is greater than the Max Quantity"
 .S ORY(2)="    allowed for this patient."
 ;get max refills for order (ORMAXREF)
 D MAXREF^ORWDPS2(.ORMAXREF,ORDFN,ORDRG,ORDS,OROI,1)
 ;if refill from order is > max refills return 0 (ORY=0)
 I ORREF>ORMAXREF D  Q
 .S ORY=0
 .S ORY(0)="Problem Renewing Clozapine Related Medication"_U_ORCLOZ
 .S ORY(1)="The Refills field set for this order is greater than the Refills"
 .S ORY(2)="    allowed for this patient with the order having a Days Supply "
 .S ORY(3)="    of "_ORDS_"."
 Q
