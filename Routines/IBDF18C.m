IBDF18C ;ALB/CJM/AAS - ENCOUNTER FORM - form ID utilities ;04-OCT-94
 ;;3.0;AUTOMATED INFO COLLECTION SYS;**5,9**;APR 24, 1997
 ;
FID(DFN,APPT,SOURCE,FORMTYPE,CLIN) ; -- Form ID Tracking
 ; -- create record in the ENCOUNTER FORM TRACKING file
 ;    and returned a unique FORM ID
 ; -- Input    DFN    = patient internal entry number
 ;             APPT   = appointment date time (fm format)
 ;             SOURCE = the source of the form, ie
 ;                          IB = 1
 ;                      Pandas = 2
 ;                      Telefr = 3
 ;             FORMTYPE   = the package form definition ID - may have been exterally assigned
 ;             CLIN   = pointer to 44 (optional)
 ;
 ; -- Output Returns  = internal form id^external form id
 ;
 N I,J,X,Y,ID,EXID,CLN,INTERNAL,NODE,FORMID,DIC,DIE,DA,DR,DINUM,DLAYGO
 S ID=-1,EXID=""
 ;
 I '$G(DFN)!('$G(APPT))!('$G(SOURCE)) G FIDQ
 ;
 ; -- FORMTYPE may="", but should always be >0 for scannable forms 
 S FORMTYPE=+$G(FORMTYPE)
 S FORMID("APPT")=APPT,FORMID("SOURCE")=1
 ;
 ; -- determine if the FORMTYPE was exterally assigned
 S INTERNAL=$D(^IBD(357.95,"C",SOURCE,FORMTYPE))
 ;
 ;
 S ID=$$FINDID(DFN,APPT,FORMTYPE) I ID S EXID=ID_"^"_$P($G(^IBD(357.96,ID,0)),"^",9) G FIDQ
 K DIC,DO,D0,DD,DA,DINUM
 S DIC="^IBD(357.96,",X=ID,DIC(0)="L",DLAYGO=357.96,DINUM=ID
 ;
 L +^IBD(357.97,1,.02):3
 S ID=+$P($G(^IBD(357.97,1,0)),"^",2)
 F ID=ID+1:1 L:$D(^IBD(357.96,(ID-1))) -^IBD(357.96,(ID-1)) I ID>0,'$D(^IBD(357.96,ID)) L +^IBD(357.96,ID):1 I $T,'$D(^IBD(357.96,ID)) S (X,DINUM)=ID D FILE^DICN I +Y>0 L -^IBD(357.96,ID) Q
 S $P(^IBD(357.97,1,0),"^",2)=ID
 L -^IBD(357.97,1,.02)
 ;
 S ID=$S(+Y<1:"",1:+Y) I ID="" D LOGERR^IBDF18E2(3579600,.FORMID) G FIDQ
 D:ID
 .S EXID=$$EXID(ID)
 .S DIE="^IBD(357.96,",DA=ID
 .S DR="[IBD CREATE FORM TRACKING]"
 .L +^IBD(357.96,ID):5 D ^DIE L -^IBD(357.96,ID)
 .K DIC,DIE,DA,DR,DINUM,DLAYGO,%,%H,%I
 .;
 .;D NOW^%DTC N IBPRDT S IBPRDT=% ;Not needed with template, delete
 .;S DR=".02////^S X=DFN;.03////^S X=APPT;.04////^S X=$S(INTERNAL:FORMTYPE,1:"""");.05////^S X=IBPRDT;.07////^S X=SOURCE;.08////^S X=$S('INTERNAL:FORMTYPE,1:"""");.09////^S X=EXID;.1////^S X=$G(CLIN);.11////1"
 .;I $G(^DPT(DFN,"S",APPT,0))="" S DR=DR_";.14////1"
FIDQ Q ID_"^"_EXID
 ;
EXID(ID) ; -- converts external id format to internal id format
 ; -- we need to decide on external id format
 Q $G(ID)
 ;
INID(ID) ; -- find internal id number from external format
 ; -- Input ID  = form id in external format
 ;    Output    = form id in internal format or NULL if nonexistant
 ;
 N EXID
 S EXID=$O(^IBD(357.96,"AEXT",ID,0))
INIDQ Q $G(EXID)
 ;
FSCND(ID,STAT,ERR) ; -- update form tracking file that 
 ; -- Input  ID = entry to flag as scanned (internal format)
 ;         STAT = NEW status, 1=printed, 2=scanned,3=sent to pce okay, 
 ;                4=pce returned err
 ;                11=pending pages, 12=input data error
 ;          ERR = pce error message (required only if stat=4)
 ;
 ; -- Output    = 1 if successful, 0 if not
 ;
 N IBI,SUCCESS,I,J,X,Y,DA,DR,DIC,DIE
 S SUCCESS=0
 I '$G(ID) G FSCNDQ
 I $G(STAT)=4,$G(ERR)="" G FSCNDQ
 ;
 ; -- three lines below use template, new for t6, uncommend and delete
 ;    remaining lines
 S DIE="^IBD(357.96,",DA=ID,DR="[IBD EDIT FORM TRACKING STATUS]"
 D ^DIE
 S SUCCESS=1
 ;
 ;S IBI=$G(^IBD(357.96,+ID,0)) I IBI="" G FSCND
 ;I $P(IBI,"^",6)="" S DIE="^IBD(357.96,",DA=ID,DR=".06///NOW;.11////^S X=$S($G(STAT):STAT,1:2);.12////^S X=$G(ERR)" D ^DIE S SUCCESS=1 G FSCNDQ
 ;S DIE="^IBD(357.96,",DA=+ID,DR=".11////^S X=$G(STAT);.12////^S X=$G(ERR)" D ^DIE S SUCCESS=1
 ;
FSCNDQ Q SUCCESS
 ;
FIDST(ID) ; -- form id status
 ; -- Input   ID = form id (internal entry number)
 ;
 ; -- Output  STATUS = -1 if id does not exist
 ;                   =  1 if id exists but not scanned (printed)
 ;                   =  2 if already scanned in
 ;                   =  3 if sent to pce okay
 ;                   =  4 if sent to pce with error....
 ;
 N STATUS,I,J,X,Y
 S STATUS=-1
 I '$G(ID) G FIDSTQ
 S X=$G(^IBD(357.96,ID,0)) I X="" G FIDSTQ
 S STATUS=$S($P(X,"^",6)="":1,1:2)
 S:$P(X,"^",11)>2 STATUS=$P(X,"^",11)
FIDSTQ Q STATUS
 ;
FINDID(DFN,APPT,FORM,DUP) ; -- Find a form id for a patient and appointment
 ; -- input  DFN =  patient
 ;          APPT =  appointment date time
 ;          FORM =  (Optional) type of form, pointer to 357.95 or field 10 
 ;           DUP =  (Optional) if true, No duplicates of same form (357)
 ;                  returns last printing of same form with different
 ;                  form definitions, will also exclude nonscannable form
 ;
 ; -- output     = form id1^form id2^form id3^form idn...
 ;               = where form ids are successive form ids (in internal
 ;                 format) for same appointment
 ;
 N ID,I,J,X,ORIGIN,OLDDATE,NEWDATE
 S ID=""
 I '$G(DFN)!('$G(APPT)) G FINDIDQ
 K ^TMP($J,"IBD-FINDID")
 S CLN=+$G(^DPT(DFN,"S",APPT,0)) ;get clinic if appointment
 ;
 I '$G(DUP) S X=0 F  S X=$O(^IBD(357.96,"APTAP",DFN,APPT,X)) Q:'X  D
 .I CLN,CLN'=$P($G(^IBD(357.96,X,0)),"^",10) Q  ;form for canceled appt.
 .I '$G(FORM) S ID=ID_X_"^" Q
 .I $G(FORM) S I=$G(^IBD(357.96,X,0)) I $P(I,"^",4)=FORM!($P(I,"^",8)=FORM) S ID=X Q
 ;
 I $G(DUP) S X=0 F  S X=$O(^IBD(357.96,"APTAP",DFN,APPT,X)) Q:'X  D
 .I +$P($G(^IBE(357,+$P($G(^IBD(357.95,+$P($G(^IBD(357.96,X,0)),"^",4),0)),"^",21),0)),"^",12)<1 Q
 .I CLN,CLN'=$P($G(^IBD(357.96,X,0)),"^",10) Q  ;form for canceled appt.
 .S ORIGIN=$P($G(^IBD(357.95,+$P($G(^IBD(357.96,X,0)),"^",4),0)),"^",21) Q:'ORIGIN
 .I '$G(FORM) D
 ..I '$D(^TMP($J,"IBD-FINDID",ORIGIN)) S ^TMP($J,"IBD-FINDID",ORIGIN)=X Q
 ..S OLDDATE=$P($G(^IBD(357.96,+$G(^TMP("IBD-FINDID",ORIGIN)),0)),"^",5)
 ..S NEWDATE=$P($G(^IBD(357.96,X,0)),"^",5)
 ..I NEWDATE'<OLDDATE S ^TMP($J,"IBD-FINDID",ORIGIN)=X
 .I $G(FORM) S I=$G(^IBD(357.96,X,0)) I $P(I,"^",4)=FORM!($P(I,"^",8)=FORM) S ID=X Q
 I $G(DUP),'$G(FORM) S ORIGIN=0 F  S ORIGIN=$O(^TMP($J,"IBD-FINDID",ORIGIN)) Q:'ORIGIN  S ID=ID_^TMP($J,"IBD-FINDID",ORIGIN)_"^"
 ;
FINDIDQ K ^TMP($J,"IBD-FINDID")
 Q ID
 ;
FINDPT(FORMID) ;
 ; -- find patient from form id
 ; -- Output  :Patient Name ^ PID ^ clinic Name ^ appt date/time (external)
 ;             ^form ID ^ form status ^ DFN ^ clinic ien ^ appt date/time (fm format)
 ;
 N I,J,X,Y,DFN,IBNODE,IBXX,VA,VADM,VAERR,STATNM,FORM,FORMNM
 S IBXX="Unable to identify Form^^^"
 I +$G(FORMID)<1 G FINDPTQ
 S IBNODE=$G(^IBD(357.96,+FORMID,0))
 I IBNODE="" G FINDPTQ
 S DFN=+$P(IBNODE,"^",2)
 D DEM^VADPT
 S Y=$P(IBNODE,"^",11),C=$P(^DD(357.96,.11,0),"^",2) D Y^DIQ S STATNM=Y
 S FORM=$P($G(^IBD(357.95,+$P(IBNODE,"^",4),0)),"^",21)
 S FORMNM=$P($G(^IBE(357,+FORM,0)),"^")
 ;
 S IBXX=$G(VADM(1))_"^"_$G(VA("PID"))_"^"_$P($G(^SC(+$P(IBNODE,"^",10),0),"Clinic Not Specified"),"^")_"^"_$$FMTE^XLFDT($P(IBNODE,"^",3))_"^"_$P(IBNODE,"^",4)_"^"_$P(IBNODE,"^",11)_"^"_DFN
 S IBXX=IBXX_"^"_$P(IBNODE,"^",10)_"^"_$P(IBNODE,"^",3)_"^"_STATNM_"^"_FORMNM_"^"_FORM
 ;
 I +$P(FORMID,"^",2)>0,$P(IBNODE,"^",4)'=+$P(FORMID,"^",2) S IBXX="Form Type and Form ID Don't match^^^"
 ;
FINDPTQ Q IBXX
