BPSEBP ;AITC/PD - ePharmacy Billing Parameters;08/07/2025
 ;;1.0;E CLAIMS MGMT ENGINE;**42**;JUN 2004;Build 11
 ;;Per VA Directive 6402, this routine should not be modified.
 ;;
 ;
 Q
 ;
ELIG(DFN) ;
 ;
 ;Description:
 ;  This function is used to determine if an ePharmacy claim should be
 ;  created for a patient.  Parameters exist in the BPS SETUP file
 ;  (#9002313.99) which will be used by this function in making the
 ;  determination.
 ;
 ;  The function will check if a patient is Priority 8e, Priority 8g,
 ;  or an Ineligible Patient.  To determine Priority 8e or 8g, the most
 ;  current Patient Enrollment record (#27.11) will be used.  An
 ;  Ineligible Patient is identified as a patient that has a value in
 ;  the INELIGIBLE DATE field (#.152), of the Patient file (#2), less than
 ;  or equal to the current date.
 ;
 ;  Patients with dual eligibility will not be evaluated.  For those
 ;  patients, this function will not prevent an ePharmacy claim from
 ;  being created.
 ;
 ;Input:
 ;  DFN - Patient IEN
 ;
 ;Output:
 ;  A returned value of 0 will not stop an ePharmacy claim from being created.
 ;  A returned value of 1 indicates an ePharmacy claim should not be created.
 ;
 ;  Function Value - 0 - Dual eligible patients will result in 0.
 ;                       Veterans that are not Priority 8e or 8g will result in 0.
 ;                       Patients that do not have a current Patient Enrollment record
 ;                         will result in 0, unless the INELIGIBLE DATE field is set.
 ;                   1^scenario
 ;                       scenario = Priority 8e Veteran
 ;                                  Priority 8g Veteran
 ;                                  Ineligible Patient
 ;                  
 N %,DGIEN,ELIG,ENPRI,ENSUBG,IBI,PARAM8E,PARAM8G,PARAMIN,VAEL
 ;
 ; Quit if primary eligibility is TRICARE/SHARING AGREEMENT/CHAMPVA
 ; or patient has dual eligibility.
 ;
 D ELIG^VADPT
 ;
 S ELIG="^"_$P(VAEL(1),"^",2)_"^"
 S IBI=0
 F  S IBI=$O(VAEL(1,IBI)) Q:'IBI  S ELIG=ELIG_$P(VAEL(1,IBI),"^",2)_"^"
 I (ELIG["^TRICARE^")!(ELIG["^SHARING AGREEMENT^")!(ELIG["^CHAMPVA^") Q 0
 ;
 ; Get the parameter values from BPS SETUP file.
 ; Parameter value of 0 means do not create ePharmacy claim.
 ; Paramater value of 1 means create ePharmacy claim.
 ; 
 S PARAM8E=$$GET1^DIQ(9002313.99,1,1.01,"I")
 S PARAM8G=$$GET1^DIQ(9002313.99,1,1.02,"I")
 S PARAMIN=$$GET1^DIQ(9002313.99,1,1.03,"I")
 ;
 ; If the Ineligible Patient paramater is set to prevent claims, and a
 ; value exists in the INELIGIBLE DATE field (#.152), of the Patient
 ; File (#2), that is less than or equal to the current date, do not
 ; create an ePharmacy claim.
 D NOW^%DTC
 I 'PARAMIN,(($$GET1^DIQ(2,DFN,.152)'="")&($$GET1^DIQ(2,DFN,.152,"I")<%)) Q "1^ePharmacy Claim: Ineligible Patient, Billing Parameter set to ""Not Bill"""
 ;
 ; Initialize Priority and Subgroup variables.
 ;
 S ENPRI=""
 S ENSUBG=""
 ;
 ; Get current Patient Enrollment record
 ;
 S DGIEN=$$FINDCUR^DGENA(DFN)
 ;
 ; If DGIEN="", there is not a current enrollment record on file for
 ; the patient and, therefore, no enrollment priority or subgroup.
 ;
 I DGIEN="" Q 0
 ;
 ; Using the patient's current Patient Enrollment record, get Priority
 ; and Subgroup.
 ;
 S ENPRI=$$GET1^DIQ(27.11,DGIEN,.07)
 S ENSUBG=$$GET1^DIQ(27.11,DGIEN,.12)
 ;
 ; If the parameter for 8e or 8g is set to prevent claims, and the
 ; patient is Priority Group 8 and Subgroup e or g, do not create an
 ; ePharmacy Claim.
 ;
 I 'PARAM8E,ENPRI="GROUP 8",ENSUBG="e" Q "1^ePharmacy Claim: Priority 8e Veteran, Billing Parameter set to ""Not Bill"""
 I 'PARAM8G,ENPRI="GROUP 8",ENSUBG="g" Q "1^ePharmacy Claim: Priority 8g Veteran, Billing Parameter set to ""Not Bill"""
 ;
 Q 0
 ;
EBP ; ePharmacy Billing Parameters option
 ;
 N BPSEBP,BPSI,BPSIEN,BPSQ,CNT,EBP01,EBP1,EBP1E,EBP2,EBP3,EBP4,EBP5
 N EBPDATA,FLDNO,LOOPX
 K BPSEBP
 ;
 ; The EBP option displays a historical audit of the ePharmacy Billing
 ; Parameters which includes the category, the date it was edited, the
 ; new and old values, the user who made the change and a comment
 ; explaining why the change was made.
 ;
 ; The option also allows the user to update the prompt for each
 ; category.  If the user changes a value, a comment will be required.
 ;
 W !!,"This option will enable or disable third-party billing for specific patient"
 W !,"categories.  Selecting 'Yes' will allow ePharmacy claims to transmit to the"
 W !,"patients' third-party payer, while selecting 'No' will disable the ePharmacy"
 W !,"claims for the selected category."
 ;
 W !!,"Parameter History:"
 ;
 D HDR
 S CNT=10
 ;
 ; Gather the parameter history information into an array sorted by
 ; category and date.
 ;
 S BPSIEN=0
 F  S BPSIEN=$O(^BPS(9002313.99,1,"EBP",BPSIEN)) Q:'BPSIEN  D
 . S EBP01=$$GET1^DIQ(9002313.9901,BPSIEN_",1,",.01,"I")
 . S EBP1=$$GET1^DIQ(9002313.9901,BPSIEN_",1,",1,"I")
 . S EBP1E=$$GET1^DIQ(9002313.9901,BPSIEN_",1,",1)
 . S EBP2=$$GET1^DIQ(9002313.9901,BPSIEN_",1,",2)
 . S EBP3=$$GET1^DIQ(9002313.9901,BPSIEN_",1,",3)
 . S EBP4=$$GET1^DIQ(9002313.9901,BPSIEN_",1,",4)
 . S EBP5=$$GET1^DIQ(9002313.9901,BPSIEN_",1,",5)
 . S BPSEBP(EBP1,EBP01)=EBP1E_"^"_EBP3_"^"_EBP4_"^"_EBP2_"^"_EBP5
 ;
 ; Write the parameter history information to the screen.
 ;
 S EBP1=""
 S LOOPX=0
 ;
 F  S EBP1=$O(BPSEBP(EBP1)) Q:EBP1=""  D
 . S EBP01=""
 . I (EBP1="8G"!(EBP1="IN")),CNT'=3 W ! S CNT=CNT+1
 . F  S EBP01=$O(BPSEBP(EBP1,EBP01)) Q:EBP01=""  D
 . . I LOOPX=1 Q
 . . S EBPDATA=BPSEBP(EBP1,EBP01)
 . . W !,$P(EBPDATA,"^")
 . . W ?15,$$DATE(EBP01)
 . . W ?30,$P(EBPDATA,"^",2)
 . . W ?40,$P(EBPDATA,"^",3)
 . . W ?50,$P(EBPDATA,"^",4)
 . . W !,"  Comment: "_$P(EBPDATA,"^",5)
 . . S CNT=CNT+2
 . . I CNT>20 D
 . . . D PAUSE^VALM1
 . . . I 'Y S LOOPX=1 G LOOPX
 . . . E  D CLEAR^VALM1,HDR S CNT=3
 W !
 ;
 ; Display prompts, to update the parameters, passing in the parameter
 ; field numbers.
 ;
 S BPSQ=0
 F BPSI=1.01,1.02,1.03 D PARAM(BPSI) Q:BPSQ
 ;
LOOPX ;
 ;
 Q
 ;
HDR ;
 ;
 W !,?30,"Old",?40,"New"
 W !,"Category",?15,"Date",?30,"Value",?40,"Value",?50,"User"
 W !,"--------",?15,"----",?30,"-----",?40,"-----",?50,"----"
 ;
 Q
 ;
PARAM(FLDNO) ; 
 ;
 N BPSI,BPSNEW,BPSOLD,BPSOLDI,BPSQT,CAT,CAT1,COMMENT
 N DA,DIE,DIR,DIRUT,DR,Y
 ;
 S BPSOLD=$$GET1^DIQ(9002313.99,1,FLDNO)
 S BPSOLDI=$$GET1^DIQ(9002313.99,1,FLDNO,"I")
 ;
 I FLDNO=1.01 S CAT="Priority Group 8e",CAT1="8E"
 I FLDNO=1.02 S CAT="Priority Group 8g",CAT1="8G"
 I FLDNO=1.03 S CAT="Ineligible Patients",CAT1="IN"
 ;
 S DIR(0)="Y"
 S DIR("A")="Bill ePharmacy Claims for "_CAT
 S DIR("B")=BPSOLD
 S DIR("?",1)="Select 'Yes' to allow ePharmacy claims to transmit for "_CAT_"."
 S DIR("?")="Select 'No' to disable ePharmacy claims for this category."
 D ^DIR
 K DIR
 ;
 ; If ^, quit
 I $D(DIRUT) S BPSQ=1 Q
 ;
 S BPSNEW=Y
 I BPSNEW'=BPSOLDI D
 . S DIR(0)="F^3:69"
 . S DIR("A")="Comment"
 . S DIR("B")=""
 . S DIR("?")="Enter a comment (3-69 characters) detailing why the "_CAT_" parameter is being changed."
 . S BPSQT=0
 . F  D  Q:+BPSQT'=0
 . . D ^DIR
 . . I $D(DIRUT) S BPSQT=1
 . . F BPSI=1:1:$L(Y) I $E(Y,BPSI)'=" " S BPSQT=1
 . . I BPSQT=1 Q
 . . W !!,"Enter a comment (3-69 characters) detailing why the "_CAT,!,"parameter is being changed.",!
 . W !
 ;
 ; If ^, quit
 I $D(DIRUT) S BPSQ=1 Q
 ;
 ; If user did not change the parameter value, quit
 I BPSNEW=BPSOLDI Q
 ;
 S COMMENT=Y
 ;
 I BPSNEW=1 S BPSNEW="YES"
 I BPSNEW=0 S BPSNEW="NO"
 S DIE=9002313.99
 S DR=FLDNO_"///"_BPSNEW_";3000///NOW"
 S DA=1
 S DR(2,9002313.9901)="1///"_CAT1
 S DR(2,9002313.9901)=DR(2,9002313.9901)_";"_2_"////"_DUZ
 S DR(2,9002313.9901)=DR(2,9002313.9901)_";"_3_"///"_BPSOLD
 S DR(2,9002313.9901)=DR(2,9002313.9901)_";"_4_"///"_BPSNEW
 S DR(2,9002313.9901)=DR(2,9002313.9901)_";"_5_"///"_COMMENT
 D ^DIE
 ;
 Q
 ;
DATE(X) ; Convert FM date to displayable (MM/DD/YYYY) format
 ;
 N DATE,YR
 I $G(X) S YR=($E(X,1,3)+1700)
 I $G(X) S DATE=$S(X:$E(X,4,5)_"/"_$E(X,6,7)_"/"_$G(YR),1:"")
 Q $G(DATE)
