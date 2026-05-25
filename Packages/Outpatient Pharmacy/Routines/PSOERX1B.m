PSOERX1B ;ALB/BWF - Accept eRx function ; 8/3/2016 5:14pm
 ;;7.0;OUTPATIENT PHARMACY;**467,506,520,527,508,551,591,606,581,617,700,770**;DEC 1997;Build 145
 ;
 Q
ACVAL(PSOIEN,TYPE,VAMMODE) ; NEW MTYPE, GET IT OFF FIELD .08, IF NOT DEFINED, 
 ;Input: PSOIEN  - eRx IEN (Pointer to #52.49)
 ;       TYPE    - Validation Type (P: Patient, PR: Provider, D: Drug)
 ;       VAMMODE - Validate All Matches Mode (optional)
 N MBMSITE,F,VBFLD,VBDTTMF,DIR,TAG,VALPAR,VAL,CURVAL,MVFLD,VBFLD,VBDTTMF,PSOIENS,RXSTAT,QFLG,VDTTM,ERXMMFLG,MTYPE,Y
 N RESTYPE,GMRA,GMRAL,ERXPTIEN,DFN
 S MBMSITE=$S($$GET1^DIQ(59.7,1,102,"I")="MBM":1,1:0)
 S F=52.49,PSOIENS=PSOIEN_","
 D FULL^VALM1
 S VALMBCK="R"
 ; first check to see if the entry exists. cannot validate something that has no value
 S MTYPE=$$GET1^DIQ(52.49,PSOIEN,.08,"I") ;mtype
 S RXSTAT=$$GET1^DIQ(52.49,PSOIEN,1,"E") I RXSTAT="RJ"!(RXSTAT="RM")!($E(RXSTAT,1,3)="REM")!(RXSTAT="PR")!(RXSTAT="CRP")!(RXSTAT="CXP")!(RXSTAT="RRP") D  Q
 . W !!,"Cannot accept validation for a prescription with a status of 'Rejected',",!,"'Removed',or 'Processed",!
 . S DIR(0)="E" D ^DIR
 Q:TYPE']""
 S TAG=$S(TYPE="P":"patient",TYPE="PR":"provider",TYPE="D":"drug",1:"")
 S VALPAR=$S(TYPE="P":.05,TYPE="PR":2.3,TYPE="D":3.2,1:"") Q:VALPAR=""
 S VAL=$$GET1^DIQ(F,PSOIEN,VALPAR,"I") I 'VAL D  Q
 . W !,"Vista "_TAG_" has not been matched. Cannot manually validate."
 . S DIR(0)="E" D ^DIR
 S MVFLD=$S(TYPE="P":1.7,TYPE="PR":1.3,TYPE="D":1.5,1:"")
 S VBFLD=$S(TYPE="P":1.13,TYPE="PR":1.8,TYPE="D":1.11,1:"")
 S VBDTTMF=$S(TYPE="P":1.14,TYPE="PR":1.9,TYPE="D":1.12,1:"")
 ; check if Patient has a valid adress - CS prescriptions only
 I TYPE="P",$$GET1^DIQ(52.49,PSOIEN,95.1,"I"),'$$VALPTADD^PSOERXUT(+$G(VAL)) D  Q
 . W !!,"Unable to validate - VistA Patient does not have a current mailing"
 . W !,"or residential address on file.",$C(7),!
 . S DIR(0)="E" D ^DIR
 ; check to see if this is already validated
 I MVFLD S CURVAL=$$GET1^DIQ(F,PSOIEN,MVFLD,"I")
 I CURVAL D  Q
 . W !!,"This "_TAG_" has already been "_$S(TYPE="PR"&$$GET1^DIQ(52.49,PSOIEN,2.7,"I"):"automatically",1:"manually")_" validated."
 . W !,"Validated By: "_$$GET1^DIQ(F,PSOIEN,VBFLD,"E")
 . W !,"Validated Date/Time: "_$$GET1^DIQ(F,PSOIEN,VBDTTMF,"E"),!
 . S DIR(0)="E" D ^DIR
 S QFLG=0
 I TYPE="D" D
 . W !
 . I '$O(^PS(52.49,PSOIEN,21,0)) W !,"Dosing information missing.",$C(7) S QFLG=1
 . I $$GET1^DIQ(52.49,PSOIEN,20.1,"E")="" W !,"Quantity missing.",$C(7) S QFLG=1
 . I $$GET1^DIQ(52.49,PSOIEN,20.2,"E")="" W !,"Days supply missing.",$C(7) S QFLG=1
 I $G(QFLG) W ! S DIR(0)="E" D ^DIR K DIR Q
 I TYPE="D" D
 . N ERXMSG,I
 . D PRDRVAL^PSOERXUT(.ERXMSG,"VD",PSOIEN) I $P(ERXMSG,"^",2)="B" S QFLG=1
 . I $O(ERXMSG(0)) D
 . . W !!,"*********************************",$S($P(ERXMSG,"^",2)="W":" WARNING(S) ",1:"INVALID DRUG"),"***********************************"
 . . S I=0 F  S I=$O(ERXMSG(I)) Q:'I  W !,$P(ERXMSG(I),"^")
 . . W !,"********************************************************************************",$C(7)
 I $G(QFLG) W ! S DIR(0)="E" D ^DIR K DIR Q
 ;
 I TYPE="P" D  I '$G(ERXMMFLG) S DIR(0)="E" D ^DIR K DIR
 . S ERXMMFLG=$$PATWARN^PSOERX1E("VP",PSOIEN)
 ;
 S DFN=$$GET1^DIQ(52.49,PSOIEN,.05,"I")
 ; VistA Patient ChampVA Eligibility Check (MbM Only)
 I $G(MBMSITE),TYPE="P",'$$CHVAELIG^PSOERXU9(DFN) D  Q
 . I ",N,I,W,RXI,RXN,RXW,RXR,CXI,CXN,CXW,"[(","_$G(RXSTAT)_",") D
 . . D UPDSTAT^PSOERXU1(PSOIEN,"HEL","Hold due to Eligibility Issue")
 . . W !!,"This eRx has been put on Hold (HEL) because the VistA Patient ("_$$GET1^DIQ(2,DFN,.01)_") is not Eligible for ChampVA Rx Benefit."
 . . K DIR D PAUSE^VALM1
 . D AUTOHOLD^PSOERX1E("E",PSOIEN,DFN)
 ;
 ; VistA Patient Allergy Check (MbM Only)
 I $G(MBMSITE),TYPE="P" D  I $G(GMRAL)="" Q
 . S GMRA="0^0^111" D EN1^GMRADPT I $G(GMRAL)'="" Q
 . I ",N,I,W,RXI,RXN,RXW,RXR,CXI,CXN,CXW,"[(","_$G(RXSTAT)_",") D
 . . D UPDSTAT^PSOERXU1(PSOIEN,"HAL","Hold for Allergy Assessment")
 . . W !!,"This eRx has been put on Hold (HAL) because the VistA Patient ("_$$GET1^DIQ(2,DFN,.01)_") does not have an Allergy Assessment.."
 . . K DIR D PAUSE^VALM1
 . D AUTOHOLD^PSOERX1E("A",PSOIEN,DFN)
 ;
 I TYPE="P",'$G(ERXMMFLG) Q
 ;
 I TYPE="PR" S ERXMMFLG=$$PRVWARN^PSOERX1A("VP",PSOIEN) I 'ERXMMFLG S DIR(0)="E" D ^DIR K DIR Q
 I '$G(VAMMODE) W !,"Would you like to mark this "_TAG_" as VALIDATED?" S DIR(0)="Y",DIR("B")=$S($G(ERXMMFLG):"NO",1:"YES") D ^DIR Q:Y'=1
 K FDA,DIR
 S VDTTM=$$NOW^XLFDT I MVFLD S FDA(F,PSOIENS,MVFLD)=1
 I VBFLD S FDA(F,PSOIENS,VBFLD)=$G(DUZ)
 I VBDTTMF S FDA(F,PSOIENS,VBDTTMF)=VDTTM
 I $D(FDA) D FILE^DIE(,"FDA") K FDA
 W !,$S(TYPE="P":"Patient",TYPE="PR":"Provider",1:"Drug/SIG")_" Match Validated!!"
 ; check validations and update status to 'wait' if all validations have occured.
 I MTYPE="N",$E(RXSTAT)'="H" D
 . I $$GET1^DIQ(52.49,PSOIEN,1.3,"I"),$$GET1^DIQ(52.49,PSOIEN,1.5,"I"),$$GET1^DIQ(52.49,PSOIEN,1.7,"I") D UPDSTAT^PSOERXU1(PSOIEN,"W") Q
 . D UPDSTAT^PSOERXU1(PSOIEN,"I")
 I MTYPE="RE",$E(RXSTAT)'="H" D
 . S RESTYPE=$$GET1^DIQ(52.49,PSOIEN,52.1,"I")
 . I RESTYPE'="R" D UPDSTAT^PSOERXU1(PSOIEN,"RXW") Q
 . I $$GET1^DIQ(52.49,PSOIEN,1.3,"I"),$$GET1^DIQ(52.49,PSOIEN,1.5,"I"),$$GET1^DIQ(52.49,PSOIEN,1.7,"I") D UPDSTAT^PSOERXU1(PSOIEN,"RXW") Q
 . D UPDSTAT^PSOERXU1(PSOIEN,"RXI")
 I MTYPE="CX",$E(RXSTAT)'="H" D
 . I $$GET1^DIQ(52.49,PSOIEN,1.3,"I"),$$GET1^DIQ(52.49,PSOIEN,1.5,"I"),$$GET1^DIQ(52.49,PSOIEN,1.7,"I") D UPDSTAT^PSOERXU1(PSOIEN,"CXW") Q
 . D UPDSTAT^PSOERXU1(PSOIEN,"CXI")
 I TYPE="P" D BPROC^PSOERXU8(PSOIEN,"PA",MVFLD,VBFLD,VBDTTMF,VDTTM) I '$G(VAMMODE),'$G(MBMSITE) K @VALMAR
 I TYPE="PR" D BPROC^PSOERXU8(PSOIEN,"PR",MVFLD,VBFLD,VBDTTMF,VDTTM) I '$G(VAMMODE),'$G(MBMSITE) K @VALMAR
 I TYPE="D" D
 . ; Setting Clinic (if not already set)
 . I '$$GET1^DIQ(52.49,+PSOIEN,20.6,"I") d
 . . S $P(^PS(52.49,+PSOIEN,20),"^",6)=$S($G(PSOCLNC):PSOCLNC,1:$$GET1^DIQ(59,+$G(PSOSITE),10,"I"))
 . I '$G(VAMMODE),'$G(MBMSITE) K @VALMAR
 I '$G(MBMSITE) S VALMBCK="Q"
 Q
 ; remove eRx from holding queue
REM ;
 D REM^PSOERXU4
 Q
 ; unremove eRx from holding queue
UNREM ;
 D UNREM^PSOERXU4
 Q
 ; reject eRx
REJ ;
 D REJ^PSOERXU4
