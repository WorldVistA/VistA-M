ACKQCLED ;SMT - ACKQ CLINICIAN EDIT MENU ;11/14/07 10:24am ; 9/22/09 8:48am
 ;;3.0;QUASAR;**17**;Nov 10, 2007;Build 28
 Q
 ; ACKQ*3*17 Removed the pointer from the .01 field of file 509850.3
 ; to the .01 field of file 200. Because of this, Adding a new A&SP
 ; staff member can be done with ^A at the lookup prompt.
 ; 
 ;
EN ;Menu Entry Point.
 N X,Y,DIC,DR,DTOUT,DUOUT,DIE,ACKIEN,ADDFLG
 K RSLT
 ;
SRCH ;Search New Person file for a name
 S DIC="^ACK(509850.3,",DIC(0)="QAME",DIC("A")="Select A&SP STAFF NAME (^A to add new entry):"
 W !
 D ^DIC
 I X["^A" G ADDSTF
 I $D(DTOUT)!$D(DUOUT)!(Y<0) G EX
 S ACKIEN=$O(^ACK(509850.3,"B",$P(Y,"^",2),0)),RSLT=Y,ADDFLG=0
 G EDTSTF
 Q
 ;   
ADDSTF ;Add A&SP Staff Member
 N ANS,PCK,UCK
 K DIC S DIC="^VA(200,",DIC(0)="AQME"
 D ^DIC
 I $D(DTOUT)!$D(DUOUT)!(Y<0) G SRCH
 I $O(^ACK(509850.3,"B",$P(Y,"^",2),0)) W !,$P(Y,"^",2)_" is already an A&SP Staff Member" G ADDSTF
 S ACKLAYGO="",%=2,RSLT=Y
 W !,"Are you adding "_$P(RSLT,"^",2)_" as a new A&SP Staff" D YN^DICN S ANS=% G:ANS=2 ADDSTF
 S PCK=$$PCCHK(+RSLT),UCK=$$USRCHK($P(RSLT,"^",2))
 I (PCK<1) W !,$P(RSLT,"^",2)_$S(PCK=-1:" has no PERSON CLASS, status will be set to STUDENT.",1:" needs a valid PERSON CLASS.") S:PCK=0 ANS=2
 I (UCK=0) W !,$P(RSLT,"^",2)_" needs a valid USR CLASS." S ANS=2
 I ANS=2 G ADDSTF
 I ANS=1 D
 . S ADDFLG=1,DIC="^ACK(509850.3,",X=$P(RSLT,"^",2)
 . S DIC("DR")=".07////^S X=+RSLT" S:(PCK=-1) DIC("DR")=DIC("DR")_";.02//S;.06//0"
 . D FILE^DICN
 . I Y=-1 W "ERROR" Q
 G:Y=-1 EX
 S ACKIEN=$P(Y,"^") G EDTSTF
 Q
 ;
EDTSTF ;Edit an A&SP Staff Member.
 ;     Force User with No PERSON CLASS to remain student.
 ;
 N PCK,UCK
 D NOW^%DTC S TODAY=$P(%,".")
 S DIE="^ACK(509850.3,",DA=ACKIEN
 D DO^DIC1 S ID=$S(+$P(^ACK(509850.3,DA,0),"^",5):$P(^ACK(509850.3,DA,0),"^",5),1:$G(^ACK(509850.3,"ALID"))+1)
 S PCK=$$PCCHK($$GET1^DIQ(509850.3,DA,.07,"I")),UCK=$$USRCHK($$GET1^DIQ(509850.3,DA,.01,"E"))
 S DR=$S(PCK<1:".02///S;",1:".02;")_".03;"_$S('UCK:".04///^S X=TODAY-1",1:".04")_";.05//^S X=$E(""0000"",1,4-$L(ID))_ID;"_$S(PCK<1:".06///0",1:".06")
 ;If this is a newly added user, we don't need double alerts.
 I 'ADDFLG D
 . W:PCK<1 !,"No Valid/Active PERSON CLASS, STATUS forced to STUDENT"
 . W:'UCK !," No Valid USR CLASS, User forced INACTIVE."
 . Q
 D ^DIE
 G SRCH
 Q
 ; 
NMVD ;Validate that the NEW PERSON names match the A&SP Staff names,
 ;If the NEW PERSON name was changed, The A&SP Name will be changed to match
 N NPIEN,NPNM,I,DIK
 S I=0,DIK="^ACK(509850.3,",DIK(1)=".01^B" F  S I=$O(^ACK(509850.3,I)) Q:'I  D
 . S NPIEN=$P(^ACK(509850.3,I,1),"^"),NPNM=$$GET1^DIQ(200,NPIEN,.01,"")
 . I $P(^ACK(509850.3,I,0),"^")=NPNM Q
 . K ^ACK(509850.3,"B",$P(^ACK(509850.3,I,0),"^"),I)
 . S $P(^ACK(509850.3,I,0),"^")=NPNM,DA=I
 . D EN1^DIK
 Q
 ;
PCCHK(NPIEN) ;Check if User has a PERSON CLASS valid to QUASAR.
 ;  Input:
 ;    NPIEN = New Person File IEN
 ;  Output:
 ;    1 - if Audiology/Valid Quasra person class exists and is active
 ;    0 - No valid Quasar person class exists or is active(can be student)
 ;   -1 - No Person classes assigned to this user(can be student)
 ;
 N I,EFDT,EXPDT,X,RETRN,TODAY,PCLS
 S RETRN=0,PCLS=""
 D NOW^%DTC S TODAY=$P(%,".")
 F I=1:1 K ACKQARY D GETS^DIQ(200.05,I_","_NPIEN,".01;2:3","I","ACKQARY") Q:'$D(ACKQARY)  D
 . ;Unimplemented checks (Possible future use?)
 . ;S PCLS=$$GET1^DIQ(8932.1,$G(ACKQARY(200.05,I_","_NPIEN_",",.01,"I")),5,"") Q:(I=1)&(PCLS="")
 . ;I '((PCLS["V140200")!(PCLS["V140701")!(PCLS["V140600")!(PCLS["V140500")) Q
 . S EFDT=$G(ACKQARY(200.05,I_","_NPIEN_",",2,"I")),EXPDT=$G(ACKQARY(200.05,I_","_NPIEN_",",3,"I"))
 . I (EFDT<=TODAY),(+EXPDT=0)!(EXPDT>TODAY) S RETRN=1
 K ACKQARY
 I I=1,PCLS="" Q -1
 Q RETRN
 ;
USRCHK(NPNM) ;Check if User has valid USR Class
 ; Input:
 ;   NPNM = FILE 200 NAME
 ; Output:
 ;   Returns 1 if Valid, 0 if invalid.
 ;
 N USRARY,I,RETRN,TODAY,USRIEN
 D NOW^%DTC S RETRN=0,TODAY=$P(%,".")
 K USRARY D FIND^DIC(8930.3,"",".01","",NPNM,"","B","","","USRARY")
 S I=0 F  S I=$O(USRARY("DILIST",2,I)) Q:'I!RETRN  D
 . S RETRN=1,USRIEN=USRARY("DILIST",2,I)
 . I +$$GET1^DIQ(8930.3,USRIEN,".03","I")>TODAY S RETRN=0
 . I +$$GET1^DIQ(8930.3,USRIEN,".04","I")<=TODAY,+$$GET1^DIQ(8930.3,USRIEN,".04","I")>0 S RETRN=0
 Q RETRN
 ; 
EX K DIC,DIK,DIE,DR,X,Y,RSLT,ACKIEN,USRARY,ACKQARY,TODAY,RETRN,ID
 Q
