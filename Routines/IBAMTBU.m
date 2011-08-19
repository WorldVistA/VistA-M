IBAMTBU ;ALB/CPM - MEANS TEST BILLING BULLETINS ; 09-DEC-91
 ;;2.0;INTEGRATED BILLING;**153**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
PM ; Send bulletin when patient movements for a Means Test copay patient
 ; have been edited, deleted, or retro-actively added.
 ;        Input:  IBJOB = 3 (Edited, deleted movements)
 ;                      = 6 (Retro-actively added movements)
 ;                DFN, DUZ, DGPMA, DGPMP
 ;
 ; - quit if a bulletin is not needed
 Q:'$$APM^IBAMTD2
 ;
 ; - generate the bulletin
 K IBT
 S IBPT=$$PT^IBEFUNC(DFN)
 S XMSUB=$E($P(IBPT,"^"),1,14)_"  "_$P(IBPT,"^",3)_" - MOVEMENT CHANGE"
 S IBMTYP=$S(DGPMP="":$P(DGPMA,"^",2),1:$P(DGPMP,"^",2))
 I IBJOB=3 S IBT(1)="A"_$S(IBMTYP=1:"n admission",IBMTYP=2:" transfer",IBMTYP=3:" discharge",IBMTYP=6:" treating specialty",1:" lodger movement")_" has been "_$S(DGPMA]"":"edited",1:"deleted")
 I IBJOB=6 S IBT(1)="A "_$S($P(DGPMA,"^",2)=6:"treating specialty",1:"transfer")_" has been retro-actively added"
 S IBT(1)=IBT(1)_" for the following patient:" S IBT(2)=" ",IBC=2
 S IBDUZ=DUZ D PAT^IBAERR1
 S Y=$S(DGPMA:+DGPMA,1:+DGPMP) D DD^%DT
 S IBC=IBC+1,IBT(IBC)=$S(IBMTYP=1:" Adm",IBMTYP=2:"Trnf",IBMTYP=3:"Disc",IBMTYP=6:"Spec",1:"Lodg")_" Date: "_Y
 S IBC=IBC+1,IBT(IBC)=" "
 ;
 ; - display before/after critical values and instructions
 D DISP^IBAMTBU1
 ;
 ; - deliver message
 D SEND
 Q
 ;
CTPT ; Send bulletin for the discharge of a Continuous Patient.
 ;  Input: DGPMA, DFN, DUZ, IBASIH, TRAN
 S IBPT=$$PT^IBEFUNC(DFN),Y=+DGPMA D D^DIQ K IBT
 S XMSUB=$E($P(IBPT,"^"),1,14)_"  "_$P(IBPT,"^",3)_" - CONTINUOUS PATIENT"
 S IBT(1)="The following continuous patient was discharged on  "_Y
 S IBT(2)=" ",IBC=2
 S IBDUZ=DUZ D PAT^IBAERR1
 S IBC=IBC+1,IBT(IBC)=" "
 S IBC=IBC+1,IBT(IBC)="Discharge Type: "_$S($P($G(^DG(405.1,+$P(DGPMA,"^",4),0)),"^")]"":$P(^(0),"^"),1:"TYPE UNKNOWN")
 I TRAN S IBC=IBC+1,IBT(IBC)="Transferred To: "_$S($P($G(^DIC(4,+$P(DGPMA,"^",5),0)),"^")]"":$P(^(0),"^"),1:"FACILITY UNKNOWN")
 S IBC=IBC+1,IBT(IBC)=" "
 ; - message for ASIH or non-transfers
 I 'TRAN!(IBASIH) D  G SEND
 . S IBC=IBC+1 I IBASIH S IBT(IBC)="Please note that, since this patient went out on ASIH,"
 . E  S IBT(IBC)="Since the patient was not transferred to another facility,"
 . S IBT(IBC)=IBT(IBC)_" the patient's"
 . S IBC=IBC+1,IBT(IBC)="discharge date was entered into the Continuous Patient file, 'unflagging'"
 . S IBC=IBC+1,IBT(IBC)="the patient as continuous. The patient will now be charged the Means Test"
 . S IBC=IBC+1,IBT(IBC)="copayment (Medicare Deductible) for any future episodes of Hospital or"
 . S IBC=IBC+1,IBT(IBC)="Nursing Home care, if s/he is Means Test copay at that time."
 . Q:IBASIH
 . S IBC=IBC+1,IBT(IBC)=" "
 . S IBC=IBC+1,IBT(IBC)="If the patient was in fact transferred, then the Discharge Date must be"
 . S IBC=IBC+1,IBT(IBC)="deleted from the Continuous Patient file."
 ;
 ; - message for transferred patients
 S IBC=IBC+1,IBT(IBC)="Please note that, since the patient was transferred to another facility,"
 S IBC=IBC+1,IBT(IBC)="the patient's discharge date was not entered into the Continuous Patient"
 S IBC=IBC+1,IBT(IBC)="file.  If the patient does not receive continuous care while outside of"
 S IBC=IBC+1,IBT(IBC)="your facility, you must manually enter the date on which the patient's"
 S IBC=IBC+1,IBT(IBC)="care was discontinued into the Continuous Patient file."
 ;
SEND ; - send message and quit.
 D MAIL^IBAERR1
 K IBVAL,IBT,IBMTYP,IBC,IBI,IBPT,XMSUB,XMY,XMTEXT,XMDUZ
 Q
