IBDF1B1A ;ALB/CJM - ENCOUNTER FORM PRINT (IBDF1B continued - user options for printing- continuation of IBDF1B1); 3/1/93
 ;;3.0;AUTOMATED INFO COLLECTION SYS;**25**;APR 24, 1997
 ;
ENCL ;for every clinic choosen find patient appointments on DATE
 N DFN,CLNCNAME,IBCLINIC,PNAME,TDIGIT,IBAPPT,IBAPTYP,IBX,Y,IBDIV,FIRST4
 S IBCLINIC="" F  S IBCLINIC=$O(^TMP("IBDF",$J,"C",IBCLINIC)) Q:'IBCLINIC  D
 .;
 .;
 .;get the clinic's division
 .S IBDIV=$$DIVISION^IBDF1B5(IBCLINIC) S:IBDIV="" IBDIV="^ "
 .
 .;setup defined for clinic or division? - otherwise there is nothing to print
 .Q:'($D(^SD(409.95,"B",IBCLINIC))!$D(^SD(409.96,"B",+IBDIV)))
 .S IBDIV=$P(IBDIV,"^",2)
 .;
 .;if restart, sorting is by division/clinic, and clinic is in the starting division, make sure the clinic does not precede the starting clinic
 .I IBDIV=IBSTRTDV,((IBSRT=1)!(IBSRT=3)) S CLNCNAME=$P($G(^SC(IBCLINIC,0)),"^") I CLNCNAME'=IBREPRNT,CLNCNAME']IBREPRNT Q
 .;
 .;find the appts
 .S IBAPPT=IBDT F  S IBAPPT=$O(^SC(IBCLINIC,"S",IBAPPT)) Q:$E(IBAPPT,1,7)'=IBDT  D
 ..S IBX=0 F  S IBX=$O(^SC(IBCLINIC,"S",IBAPPT,1,IBX)) Q:IBX=""  D
 ...Q:$P($G(^SC(IBCLINIC,"S",IBAPPT,1,IBX,0)),"^",9)="C"
 ...S DFN=+$G(^SC(IBCLINIC,"S",IBAPPT,1,IBX,0)) Q:$E($P($G(^DPT(DFN,0)),"^",9),1,5)="00000"&($D(IBDFTSTP))  S PNAME=$P($G(^DPT(DFN,0)),"^") Q:PNAME=""
 ...;check the appt status - may be cancelled
 ...S IBAPTYP=$G(^DPT(DFN,"S",IBAPPT,0)) Q:"NT,I,"'[($P(IBAPTYP,"^",2)_",")
 ...; -- check parameter if inpatient and don't print inpatients then quit
 ...I $P(IBAPTYP,"^",2)="I",$P($G(^IBD(357.09,1,0)),"^",5)=0 Q
 ...;
 ...;if only printing add-ons don't print if already printed
 ...I IBADDONS,IBREPRNT="" Q:$$PRINTED(DFN,IBAPPT)
 ...I IBADDONS,IBREPRNT'="" Q:'$$ADDON(DFN,IBAPPT)
 ...;
 ...;case of sort by clinic,patient
 ...;
 ...;**** when the new SAC standards go into effect, increasing the allowable global subscript length, this line should be substituted for the line following it ****
 ...I IBSRT=1 S CLNCNAME=$P($G(^SC(IBCLINIC,0)),"^") Q:CLNCNAME=""  S ^TMP("IBDF",$J,"P",IBDIV,CLNCNAME,IBCLINIC,$E(PNAME,1,15),DFN,+IBAPPT)=""
 ...; old way ;I IBSRT=1 S CLNCNAME=$P($G(^SC(IBCLINIC,0)),"^") Q:CLNCNAME=""  S ^TMP("IBDF",$J,"P",$E(IBDIV,1,20),$E(CLNCNAME,1,10),IBCLINIC,$E(PNAME,1,10),DFN,+IBAPPT)=""
 ...;
 ...;case of sort by terminal digit
 ...I IBSRT=2 D
 ....S TDIGIT=$$TDG(DFN),FIRST4=$E(TDIGIT,1,$L(TDIGIT)-5)
 ....;
 ....;if this is a restart and clinic is in the starting division, make sure the terminal digits (1st 4) do not precede the restart position
 ....I IBDIV=IBSTRTDV,FIRST4'=IBREPRNT,FIRST4<IBREPRNT Q
 ....;
 ....S ^TMP("IBDF",$J,"P",IBDIV,TDIGIT,DFN,+IBAPPT)=IBCLINIC
 ...;
 ...;case of sort by clinic/terminal digits
 ...;
 ...;**** when the new SAC standards go into effect, increasing the allowable global subscript length, this line should be substituted for the line following it ****
 ...I IBSRT=3 S TDIGIT=$$TDG(DFN),CLNCNAME=$P($G(^SC(IBCLINIC,0)),"^") Q:CLNCNAME=""  S ^TMP("IBDF",$J,"P",IBDIV,CLNCNAME,IBCLINIC,TDIGIT,DFN,+IBAPPT)=""
 ...; this is the old way ;I IBSRT=3 S TDIGIT=$$TDG(DFN),CLNCNAME=$P($G(^SC(IBCLINIC,0)),"^") Q:CLNCNAME=""  S ^TMP("IBDF",$J,"P",$E(IBDIV,1,20),$E(CLNCNAME,1,10),IBCLINIC,TDIGIT,DFN,+IBAPPT)=""
 ;
 ;don't need the list of clinics anymore
 K ^TMP("IBDF",$J,"C")
 Q
 ;
TDG(DFN) ;reformat patient's SSN into terminal digit order, then turns it into a cannonic number
 ; returns either 0 or ssn in terminal digit order
 N X,Y,I,SSN
 S SSN=$P($G(^DPT(DFN,0)),"^",9)
 S Y="" F I=1:1 S X=$E(SSN,I) Q:X=""  I X?1N S Y=Y_X
 S Y=$S(Y'?9N:0,1:$E(Y,8,9)_$E(Y,6,7)_$E(Y,4,5)_$E(Y,1,3))
 Q +Y
 ;
PRINTED(DFN,IBAPPT) ;returns 1 if the print manager already printed forms for this appt, 0 otherwise
 Q +$P($G(^DPT(DFN,"S",IBAPPT,0)),"^",21)
ADDON(DFN,IBAPPT) ;returns 1 if the print manager already printed forms for this appt as an add-on, 0 otherwise
 Q +$P($G(^DPT(DFN,"S",IBAPPT,0)),"^",22)
 ;
GETLIST(DFN,IBDT,DIVISION) ;creates a list of the patient's appts on IBDT
 Q:'DFN!'IBDT
 N APPT,NODE,TO
 S TO=IBDT+.999999
 S ^TMP("IBDF",$J,"APPT LIST",DIVISION,DFN)=""
 S APPT=IBDT-.0001 F  S APPT=$O(^DPT(DFN,"S",APPT)) Q:'APPT!(APPT>TO)  D
 .S NODE=$G(^DPT(DFN,"S",APPT,0))
 .Q:"NT,I,"'[($P(NODE,"^",2)_",")
 .Q:$P($G(^SC(+NODE,0)),"^",15)'=DIVISION
 .; -- check parameter
 .;I $P(NODE,"^",2)="I",$P($G(^IBD(357.09,1,0)),"^",5)=0 Q
 .S ^TMP("IBDF",$J,"APPT LIST",DIVISION,DFN,APPT)=+NODE
 Q
MULTIPLE(DFN,APPT) ;determines if patient=DFN has multiple appts on the list and APPT is the earliest
 N APT
 D GETLIST(DFN,APPT,DIVISION)
 S APT=$O(^TMP("IBDF",$J,"APPT LIST",DIVISION,DFN,""))
 ;Q:APT'=APPT 0
 I $O(^TMP("IBDF",$J,"APPT LIST",DIVISION,DFN,APT))
 Q $T
 ;
DIVHAS(IBDIV) ;returns >0 if the division has anything to print, 0 otherwise
 Q:'$G(IBDIV) 0
 Q $L($O(^SD(409.96,"A",IBDIV,"")))
 ;
CLNCHAS(CLINIC) ;returns>0 if the clinic has something to print
 N NODE,SETUP,I,FOUND
 S SETUP=$O(^SD(409.95,"B",CLINIC,0)) Q:'SETUP 0
 S NODE=$G(^SD(409.95,SETUP,0))
 S FOUND=0 F I=2,3,4,6,8,9 I $P(NODE,"^",I) S FOUND=1 Q
 Q:FOUND 1
 Q $L($O(^SD(409.95,"A",CLINIC,"")))
