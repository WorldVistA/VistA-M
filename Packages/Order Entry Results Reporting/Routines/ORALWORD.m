ORALWORD ; SLC/JMH - Utilities for Checking if an order can be ordered ; 5/10/07 5:55am
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**243**;Dec 17, 1997;Build 242
 ;
ALLWORD(ORY,DFN,ORX,ORTYPE,PROV) ;
 N OROI,ORYS,QOIEN,QPIEN,ORCLOZ,QOAA
 S OROI=0
 ;
 ;ORTYPE used to determine the type of data coming into the call
 ;ORYTPE="E" existing order, ORX equal the IEN from file 100 (used with
 ;copy,edit functionality)
 ;ORTYPE="Q" Quick Order, ORX equal the IEN from file 101.43
 ;ORTYPE="N" New order, ORX equal the IEN from file 101.41
 ;
 I ORTYPE="E" S OROI=$G(^OR(100,ORX,.1,1,0))
 I ORTYPE="Q" D
 .S QPIEN=$O(^ORD(101.41,"AB","OR GTX ORDERABLE ITEM","")) Q:QPIEN'>0
 .S QOIEN=$O(^ORD(101.41,ORX,6,"D",QPIEN,"")) Q:QOIEN'>0
 .S OROI=$G(^ORD(101.41,ORX,6,QOIEN,1))
 .S QOAA=$P($G(^ORD(101.41,ORX,5)),U,8)
 I ORTYPE="N" S OROI=ORX
 Q:OROI'>0
 S ORY=0
 ;checks if the orderable item (OROI) is a clozapine med
 ;  if not returns ORY=0
 S ORCLOZ=$$ISCLOZ(OROI),ORY=ORY_U_ORCLOZ,ORY(0)=U_ORCLOZ
 Q:'ORCLOZ
 N ORQUIT
 S ORQUIT=0
 I '$G(PROV) S PROV=DUZ
 I $G(PROV) D
 .I '$L($$DEA^XUSER(,PROV)) D
 ..S ORQUIT=1,ORY=1
 ..S ORQUIT=1,ORY=1
 ..S ORY(1)="*** You are not authorized to place Clozapine orders."
 ..S ORY(2)="You must have a DEA#.  Please contact your"
 ..S ORY(3)="CAC or IRM for more information. ***"
 .Q:ORQUIT
 .I '$D(^XUSEC("YSCL AUTHORIZED",PROV)) D
 ..S ORQUIT=1,ORY=1
 ..S ORY(1)="*** You are not authorized to place Clozapine orders."
 ..S ORY(2)="You must hold key YSCL AUTHORIZED.  Please contact your"
 ..S ORY(3)="CAC or IRM for more information on this key. ***"
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
 I +ORYS<0 D  Q
 .S ORY(1)="*** This patient is not registered in the clozapine treatment "
 .S ORY(2)="program or has been discontinued from the program and must "
 .S ORY(3)="have a new registration number assigned.  Contact the NCCC to "
 .S ORY(4)="get this patient registered in the program. ***"
 ;problem with lab tests
 I +ORYS=0 D  Q
 .I $$OVERRIDE^YSCLTST2(DFN) S ORY=0_U_ORCLOZ,ORY(0)=U_ORCLOZ D BEFQUIT  Q  ;override allowed
 .N COUNT S COUNT=0
 .S COUNT=COUNT+1,ORY(COUNT)="*** This clozapine drug may not be dispensed to the patient at this "
 .S COUNT=COUNT+1,ORY(COUNT)="time based on the available lab tests related to the clozapine "
 .S COUNT=COUNT+1,ORY(COUNT)="treatment program. Please contact the NCCC to request an override in"
 .S COUNT=COUNT+1,ORY(COUNT)="order to proceed with dispensing this drug. ***"
 .Q:'$L($P(ORYS,U,3))!('$L($P(ORYS,U,5)))
 .S COUNT=COUNT+1,ORY(COUNT)="Related Lab Test(s)"
 .S COUNT=COUNT+1,ORY(COUNT)="==================="
 .;the lab values returned by Mental Health are given in 4 digit numbers to be standard with 
 .;reporting formats to the NCCC, we are dividing by 1000 to align it with the display of the
 .;labs on the lab tab
 .;S:$L($P(ORYS,U,3)) COUNT=COUNT+1,ORY(COUNT)=$P(ORYS,U,3)_":  "_($P(ORYS,U,2)/1000)_" K/cmm"
 .;S:$L($P(ORYS,U,5)) COUNT=COUNT+1,ORY(COUNT)=$P(ORYS,U,5)_":  "_($P(ORYS,U,4)/1000)_" K/cmm"
 .S:$L($P(ORYS,U,3)) COUNT=COUNT+1,ORY(COUNT)="WBC:  "_($P(ORYS,U,2)/1000)_" K/cmm"
 .S:$L($P(ORYS,U,5)) COUNT=COUNT+1,ORY(COUNT)="ANC:  "_($P(ORYS,U,4)/1000)_" K/cmm"
 .S COUNT=COUNT+1,ORY(COUNT)="Date/Time of last tests: "_$$DATE^ORU($P(ORYS,U,6))
 Q
BEFQUIT ;
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
 N ORPSOI,ORPSDRUG
 S ORPSOI=$P(^ORD(101.43,OROI,0),U,2)
 I $P(ORPSOI,";",2)'="99PSP" Q 0
 K ^TMP($J,"ORCLOZ")
 D ASP^PSS50(+ORPSOI,,,"ORCLOZ")
 S ORPSDRUG=$O(^TMP($J,"ORCLOZ",0))
 I 'ORPSDRUG K ^TMP($J,"ORCLOZ") Q 0
 K ^TMP($J,"ORCLOZ")
 D CLOZ^PSS50(ORPSDRUG,,,,,"ORCLOZ")
 I $G(^TMP($J,"ORCLOZ",ORPSDRUG,"CLOZ",0))>0 K ^TMP($J,"ORCLOZ") Q 1
 K ^TMP($J,"ORCLOZ")
 Q 0
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
