DGHTINAC ;ALB/JRC/JAM - Home Telehealth Patient Inactivation HL7;10 January 2005 ; 11/14/06 9:46am
 ;;5.3;Registration;**644**;Aug 13, 1993;Build 11
 ;;
EN ;Main entry point
 ;Initiate variables
 N STOP,ARR,DGTYPE,DGDUZ,FLG
 N CNT,DGDFN,DGVEN,NODE,NODE1,MSGTYPE,INACTDT,IRECORD,INODE,DGEVNT
 N INAMSGID,ACKCODE,TINACTDT,DGVEN,DGCOOR,DGDATE,VENDOR,CHOICES
 N ARECORD,NUMBER,TMPNODE,ITRANS,INODE,DGMID,RESULT,GETOK,DIR,RECORD
 S ARR=$NA(HLA("HLS")),DGTYPE="I",DGDUZ=DUZ
 S STOP=0
 F  D  Q:STOP
 .K ^TMP("DGHT",$J),CHOICES
 .S (DGVEN,RECORD,CNT,FLG,ITRANS)=0
 .W !!
 .;Select patient
 .S DGDFN=$$GETPAT()
 .I 'DGDFN S STOP=1 Q
 .;Get active patient's home telehealth records
 .F  S DGVEN=$O(^DGHT(391.31,"APATVN",DGDFN,DGVEN)) Q:'DGVEN  D
 ..S ARECORD=$$LOCREC(DGDFN,DGVEN,"A")
 ..Q:'(ARECORD)
 ..;Get 0'th node of activation record and 0'th node of transaction
 ..S NODE=$G(^DGHT(391.31,$P(ARECORD,U,1),0))
 ..S NODE1=$G(^DGHT(391.31,+$P(ARECORD,U,1),"TRAN",+$P(ARECORD,U,2),0))
 ..Q:$P(NODE1,U,7)'="A"
 ..S IRECORD=$$LOCREC(DGDFN,DGVEN,"I")
 ..Q:'+IRECORD
 ..S MSGTYPE=$P($G(NODE1),U,4),INACTDT=$P($G(NODE),U,7)
 ..;Get Inactivation transaction node if exist
 ..S INODE=$G(^DGHT(391.31,+$P(IRECORD,U,1),"TRAN",+$P(IRECORD,U,2),0))
 ..S INAMSGID=$P(INODE,U,2),ACKCODE=$P(INODE,U,7),TINACTDT=$P(INODE,U,1)
 ..I $P($G(INODE),U,7)="A" Q
 ..;Increment counter
 ..S CNT=CNT+1
 ..;Store records in temporary global
 ..;
 ..;  ^TMP NODE  - Record # ^ Transaction # ^ patient ^ vendor ^
 ..;               trans date ^ coordinator ^ trans type ^ inactiva
 ..;               tio date ^ inact msg id ^ inact msg ack code ^
 ..;               trans inactivation date and time ^ inact record
 ..;
 ..S DGVEN=$P(NODE,U,3),DGCOOR=$P(NODE,U,5),DGDATE=$P(NODE,U,6)
 ..S ^TMP("DGHT",$J,CNT,$P(ARECORD,U,1))=ARECORD_U_DGDFN_U_DGVEN_U_DGDATE_U_DGCOOR_U_MSGTYPE_U_INACTDT_U_$G(INAMSGID)_U_$G(ACKCODE)_U_$G(TINACTDT)_U_$TR(IRECORD,U,"~")
 ..;If more than one record prepare CHOICES variable for DIR call
 ..S VENDOR=$$GET1^DIQ(4,$P(NODE,U,3),.01,"E")
 ..S CHOICES=$G(CHOICES)_CNT_":"_$TR($$FMTE^XLFDT(DGDATE,"1HM"),":","")_"   "_VENDOR_";"
 ..;If more than one active HTH record prompt user for selection
 .I CNT>1 D  Q:FLG
 ..;Resolve external value for PATIENT
 ..W !!,"Patient "_$$GET1^DIQ(2,DGDFN,.01,"E")_" has multiple  active records"
 ..K DIR,X,Y,DIRUT,DUOUT
 ..S DIR(0)="S^"_CHOICES
 ..S DIR("A")="Select Sign-up/Activation record to Inactivate"
 ..D ^DIR
 ..I $D(DIRUT)!$D(DUOUT) S FLG=1 Q
 ..S NUMBER=Y
 ..S RECORD=0,RECORD=$O(^TMP("DGHT",$J,NUMBER,RECORD))
 ..S TMPNODE=^TMP("DGHT",$J,NUMBER,RECORD),IRECORD=$P(TMPNODE,U,12)
 .;If there is only one record suppress choices
 .I CNT=1 D
 ..S NUMBER=CNT
 ..S RECORD=0,RECORD=$O(^TMP("DGHT",$J,NUMBER,RECORD))
 ..S TMPNODE=^TMP("DGHT",$J,CNT,RECORD),IRECORD=$P(TMPNODE,U,12)
 .;If no active records
 .I 'CNT D  Q:FLG
 ..W !
 ..W !,"************************************************************"
 ..W !,"*   THIS PATIENT HAS NO ACTIVE HOME TELEHEALTH  RECORDS     *"
 ..W !,"************************************************************"
 ..S FLG=1
 .;Display patient's record information to screen
 .W @IOF
 .W !!,"THE FOLLOWING PATIENT'S HOME TELEHEALTH RECORD WILL BE INACTIVATED"
 .W !!
 .D DSPREC^DGHTENR($P(TMPNODE,U,1,2))
 .;If patient's record was previously inactivated display information
 .I +$P(IRECORD,"~",2)'="" D
 ..W !,"Patient's inactivation was previously transmitted on:"
 ..W !!,?3,"Date & Time: ",?21,$$FMTE^XLFDT($P(TMPNODE,U,11),"2")
 ..W !,?3,"Message ID: ",?21,$P(TMPNODE,U,9)
 ..W !,?3,"Acknowledge Code: ",?21,$S($P(TMPNODE,U,10)="R":"Rejected",$P(TMPNODE,U,10)="A":"Accepted",1:"")
 ..W !!
 .;Prompt user for inactivation date
 .K DIR,X,Y,DIRUT,DUOUT
 .S DIR(0)="D^::ERTXS"
 .S DIR("A")="Enter Inactivation Date & Time"
 .S DIR("B")=$$FMTE^XLFDT($$NOW^XLFDT())
 .D ^DIR
 .I $D(DIRUT)!$D(DUOUT) D EXIT Q
 .S DGEVNT=Y
 .;Get okay for tansmission
 .S GETOK=$$SNDMSG^DGHTENR(DGTYPE)
 .I 'GETOK W "  ...Patient record not transmitted." D EXIT Q
 .;Set variables and validate
 .S DGVEN=$P(TMPNODE,U,4),DGDATE=$P(TMPNODE,U,5)
 .S DGCOOR=$P(TMPNODE,U,6),TINACTDT=$P(TMPNODE,U,10)
 .;build message
 .W !!,"Generating message ..."
 .K @ARR
 .S RESULT=$$BLDHL7I^DGHTHL7(DGDFN,ARR)
 .I RESULT<0 D  Q
 ..W !,"** UNABLE TO BUILD MESSAGE **"
 ..W !,$P(RESULT,"^",2)
 ..K @ARR
 .I RESULT=0 D  Q
 ..W !,"** EMPTY MESSAGE BUILT **"
 ..K @ARR
 .;send message
 .W !,"Sending message ..."
 .S RESULT=$$SNDHL7^DGHTHL7(ARR,DGVEN,"DG HOME TELEHEALTH ADT-A03 SERVER")
 .I RESULT<0 D  Q
 ..W !,"** UNABLE TO SEND MESSAGE **"
 ..W !,$P(RESULT,"^",2)
 ..K @ARR
 .W !,"Sent using message ID ",+RESULT
 .S DGMID=$P(RESULT,U,1)
 .K @ARR
 .D FILE
 D EXIT
 Q
 ;
GETPAT()        ;Prompt user for patient
 ;Input : None
 ;Output: Pointer to PATIENT File, #2 (i.e. DFN)
 ;        0 on user quit
 N DIC,X,Y,DTOUT,DUOUT
 S DIC="^DPT(",DIC("A")="Patient: "
 S DIC(0)="AEQM"
 S DIC("S")="I $D(^DGHT(391.31,""APATVN"",+Y))"
 D ^DIC
 Q $S(+Y<0:0,1:+Y)
 ;
FILE ;Update Home Telehealth File Inactivation
 N DGHFDA,DGHERR,FLDS,DA
 ;Remove old inactivation entry in transaction subfile
 I +$P(IRECORD,"~",2) D
 .N DIK S DA(1)=+$P(IRECORD,"~",1),DA=+$P(IRECORD,"~",2)
 .S DIK="^DGHT(391.31,"_DA(1)_",""TRAN"","
 .D ^DIK
 ;Update subfile 391.317 Transaction
 K DGHFDA,DGHERR
 S DGHFDA(391.317,"+2,"_RECORD_",",.01)=DGEVNT
 S DGHFDA(391.317,"+2,"_RECORD_",",.02)=DGMID
 S DGHFDA(391.317,"+2,"_RECORD_",",.03)=DGDUZ
 S DGHFDA(391.317,"+2,"_RECORD_",",.04)=DGTYPE
 D UPDATE^DIE("","DGHFDA","","DGHERR")
 I $D(DGHERR) D
 .W !!!,"Problem encountered during record update "
 .W !!,"Contact IRM"_"  Error: "_$G(DGHERR("DIERR",1,"TEXT",1))
 Q
 ;
LOCREC(DFN,VENDOR,TYPE) ;Locate the appropriate record pointer(s) for processing
 ;Input : DFN    - Patient DFN
 ;        VENDOR - Vendor IEN
 ;        TYPE   - A for Activation/Sign-up  or I for Inactivation
 ;Output: Record IEN^transaction IEN (if available)
 ;   flag 1 = Patient record was located
 ;        0 = No record was located.
 ;
 ;If TYPE="A"  and record has inactivation date then nothing will be 
 ;             returned, record is consider closed.
 ;   TYPE="I"  and transaction level record was accepted,then nothing
 ;             will be returned, record is consider closed.
 ;
 I ($G(DFN)="")!($G(VENDOR)="")!($G(TYPE)="") Q 0
 N IEN,IEN1,DGDAT,DGDAT1,FND,FND1
 S (IEN,FND,FND1)=0
 F  S IEN=$O(^DGHT(391.31,"APATVN",DFN,VENDOR,IEN)) Q:'IEN  D  I FND Q
 .S DGDAT=$G(^DGHT(391.31,IEN,0)) I DGDAT="" Q
 .Q:$P(DGDAT,"^",7)'=""
 .;I TYPE="A" Q:$P(DGDAT,"^",7)'=""
 .;I TYPE="I",$P(DGDAT,"^",7)="" S FND=IEN Q
 .S IEN1=0 F  S IEN1=$O(^DGHT(391.31,IEN,"TRAN",IEN1)) Q:'IEN1  D  Q:+FND1
 ..S DGDAT1=$G(^DGHT(391.31,IEN,"TRAN",IEN1,0)) Q:DGDAT1=""
 ..I $P(DGDAT1,"^",4)'=$E(TYPE) Q
 ..I TYPE="I",$P(DGDAT1,"^",7)="A" Q
 ..S FND1=IEN1
 .S FND=IEN_$S(IEN1:"^"_IEN1,1:"")
 Q FND
 ;
EXIT ;Kill array
 K ^TMP("DGHT",$J)
 Q
