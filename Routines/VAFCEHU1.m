VAFCEHU1 ;ALB/JLU,PTD-FILE UTILITIES FOR 391.98 ;11/21/02  12:24
 ;;5.3;Registration;**149,255,307,477,685**;Aug 13, 1993
 ;
ADD(VAFCA,VAFCB) ;Main entry point to add an entry to 391.98
 ;INPUTS    VAFCA - This parameter contains a piece string of 4 elements
 ;Date Received^Event date^From whom^patient IEN
 ;  Date Received - This is the date/time that the exception was received
 ;at the facility.  Must be in FM format
 ;  Event date - This is the date/time when the event occurred that caused
 ;this information to be sent.  Must be in FM format
 ;  From whom - This is who sent the information.  This should be in a
 ;free text format.  There is a potential that exception could be coming
 ;from sources other than what is listed in the institution file.
 ;FORMAT of WHOM
 ;  prior to RG*1*8: institution name(sender name)
 ;     after RG*1*8: sending facility: station # -or- station #~domain
 ;
 ;  Patient IEN - The patient file internal entry number.
 ;
 ;         VAFCB - is an array storage structure. It can be either global
 ;or local.  The array should be in the following format.
 ;Ex.   A(file #,field #)=value
 ;      A(file #, field #)=value
 ;
 ;In the case of multiples us the following structure:
 ;Ex.   A(file #,field #,Subfile #, subfield #)=value
 ;***NOTE*** THE SOFTWARE LOGIC TO HANDLE THIS MULTIPLE CASE HAS NOT
 ;BEEN WRITTEN YET.
 ;
 ;**NOTE**
 ;When setting info in the passage array please follow this format for
 ;these exceptions.
 ;-Unspecified or blank data should have no array element or an array
 ;element set to the mumps null.
 ;-If data from a sender can not be resolved then set
 ; $P(array element,U,2)=1
 ;-If you wish to delete what is in the receiving facilities field set
 ;the array element to "@". EX. s X(1)="""@"""
 ;
 ;OUTPUTS
 ; 0^error message - in the case of a failure
 ; 1 - in the case that the entry is added
 ;
 N REC,EVT,WHO,PAT,RESLT,STATUS,LATEST
 K ERR
 S LATEST=""
 I '$D(VAFCA) S ERR="0^Missing date/from parameter" G ADDQ
 I '$D(VAFCB) S ERR="0^Missing array structure" G ADDQ
 S REC=$P(VAFCA,U,1)
 I REC']"" S ERR="0^Missing date of receipt" G ADDQ
 S EVT=$P(VAFCA,U,2)
 I EVT']"" S ERR="0^Missing date of event" G ADDQ
 S WHO=$$WHO^VAFCEHU4($P(VAFCA,"^",3))
 I WHO']"" S ERR="0^Missing who sent the information" G ADDQ
 S PAT=$P(VAFCA,U,4)
 I PAT']"" S ERR="0^Missing patient pointer" G ADDQ
 I '$D(^DPT(PAT,0)) S ERR="0^Patient not defined" G ADDQ
 I '$O(@VAFCB@("")) S ERR="0^Missing array storage structure" G ADDQ
 ;There can be more than one patient update for a given day
 ;resulting from different fields being edited.
 ;I $D(^DGCN(391.98,"AKY",PAT,WHO,EVT)) S ERR="0^Entry already exists." G ADDQ
 ;
 ;update select edited fields and check for any differences
 D EN^VAFCEHU3 I '$G(VAFCQ) S ERR="0^No exception needed" K VAFCQ G ADDQ
 K VAFCQ
 ;check for other entries for this date
 S LATEST=$$CHKDATE(EVT,WHO,PAT)
 ;if other entries than retire them based upon the event date
 S STATUS=$S(LATEST:"ACTION REQUIRED",1:"RETIRED DATA")
 ;
 S (RESLT,RESLT(1))=$$EXCPTN(REC,EVT,WHO,PAT,STATUS)
 I RESLT=-1 S ERR="0^Adding entry failed" G ADDQ
 S RESLT=$$DATA(+RESLT,VAFCB)
 I 'RESLT S ERR="0^Adding element failed"
 ;
ADDQ ;
 I LATEST,'$D(ERR) D RETIRE(EVT,WHO,PAT)
 Q $S($D(ERR):ERR,1:1)
 ;
CHKDATE(EVT,WHO,PAT) ;
 N AFTER
 S AFTER=$O(^DGCN(391.98,"AKY",PAT,WHO,EVT)) ;there is another date after
 Q $S(AFTER:0,1:1)
 ;
RETIRE(EVT,WHO,PAT) ; Retire all previous entries from same site
 N LP,ACTION,EDIT S LP=0
 ;ien of action required
 S ACTION=$O(^DGCN(391.984,"B","ACTION REQUIRED",0))
 Q:'ACTION
 ;looping to get all action required for "from" site
 F  S LP=$O(^DGCN(391.98,"AKY",PAT,WHO,LP)) Q:'LP  D
 .N ENTRY,DATA,XX,ELIEN,NODE
 .S ENTRY=0
 .F  S ENTRY=$O(^DGCN(391.98,"AKY",PAT,WHO,LP,ENTRY)) Q:'ENTRY!(ENTRY=+RESLT(1))  D
 ..S DATA=$G(^DGCN(391.98,ENTRY,0))
 ..;sets the status to retired
 ..I DATA,$P(DATA,U,4)=ACTION D  S XX=$$EDIT(ENTRY,"RETIRED DATA")
 ...;build array of EDITED elements from all entries being retired
 ...S ELIEN=0
 ...F  S ELIEN=$O(^DGCN(391.99,"B",ENTRY,ELIEN)) Q:'ELIEN  S NODE=$G(^DGCN(391.99,ELIEN,0)) I NODE,$P(NODE,U,5)=1 S EDIT($P(NODE,U,2),$P(NODE,U,3))=""
 ..Q
 ;mark EDITED fields in remaining entry
 Q:'$O(EDIT(0))
 N ELIEN,NODE,P2,P3 S ELIEN=0,DIE="^DGCN(391.99,",DR=".05///1"
 F  S ELIEN=$O(^DGCN(391.99,"B",(+RESLT(1)),ELIEN)) Q:'ELIEN  D
 .S NODE=$G(^DGCN(391.99,ELIEN,0)),(P2,P3)="" I NODE S P2=$P(NODE,U,2),P3=$P(NODE,U,3) I $D(EDIT(P2,P3)) D
 ..L +^DGCN(391.99,ELIEN):60 ;**255
 ..S DA=ELIEN D ^DIE
 ..L -^DGCN(391.99,ELIEN) ;**255
 K DA,DIE,DR,EDIT
 Q
 ;
EXCPTN(REC,EVT,WHO,PAT,VAFCA) ;
 N Y
 K DIC,DA,DD,DO
 S DGSENFLG="" ;**255
 S DLAYGO=391.98
 S DIC="^DGCN(391.98,"
 S DIC(0)="LI"
 S X=PAT
 S DIC("DR")=".02///"_REC_";.03///"_EVT_";.04///"_VAFCA_";50///"_WHO
 D FILE^DICN
 K DIC,DLAYGO,X,DGSENFLG ;**255
 Q Y
 ;
DATA(VAFCA,VAFCB) ;
 N ADDED,LP,LP1,VAR
 F LP=0:0 S LP=$O(@VAFCB@(LP)) Q:'LP  DO
 .F LP1=0:0 S LP1=$O(@VAFCB@(LP,LP1)) Q:'LP1  DO
 ..K DIC,DA,DD,DO,VAFCE
 ..S DLAYGO=391.99
 ..S DIC="^DGCN(391.99,"
 ..S DIC(0)="LI" ;**477 added 'I' to suppress incoming filer from generating bulletins
 ..S X=VAFCA
 ..S VAR=@VAFCB@(LP,LP1)
 ..I (@VAFCB@(2,"FLD")[LP1_";"),(VAR]"") S VAFCE=1
 ..S DIC("DR")=".02///"_LP_";.03///"_LP1_";.05///"_$G(VAFCE)_";.06///"_$P(VAR,U,2)_";50////^S X=$P(VAR,U)"
 ..D FILE^DICN
 ..I Y>0 S ADDED=1
 ..Q
 .Q
 Q $S($D(ADDED):1,1:0)
 ;
CHK(A) ;
 ;INPUT - A This parameter contains a piece string of 3 elements
 ;      patient dfn^event date/time^from whom
 ;These are the key element to finding the entry in the patient data 
 ;exception file.
 ;
 ;Patient DFN is the internal entry number of the patient in the patient
 ;file.
 ;
 ;event date/time is the date/time the event took place at the facility
 ;that sent the data.  This date must be in FM format.
 ;
 ;from whom is who sent this information to this medical center.
 ;
 ;OUTPUT
 ; ZERO(0) if nothing found
 ; ZERO(0)^error description if an error found
 ; IEN of the entry in the patient data exception file if found
 ;
 N FOUND,PAT,EVT,WHO
 S FOUND=0
 I '$D(A) S FOUND="0^Input parameter missing." G CHKQ
 S PAT=$P(A,U,1)
 I PAT']"" S FOUND="0^No patient DFN defined." G CHKQ
 I '$D(^DPT(PAT,0)) S FOUND="0^No patient with this DFN." G CHKQ
 S EVT=$P(A,U,2)
 I EVT']"" S FOUND="0^Date of event not defined." G CHKQ
 S WHO=$$WHO^VAFCEHU4($P(A,U,3))
 I WHO']"" S FOUND="0^Who sent the information is not defined." G CHKQ
 ;
 I $D(^DGCN(391.98,"AKY",PAT,WHO,EVT)) DO
 .S FOUND=$O(^(EVT,"")) ;naked on the ^dgcn aky cross ref.
 .I '$D(^DGCN(391.98,FOUND,0)) S FOUND=0
 .Q
 ;
CHKQ Q FOUND
 ;
DELEXCPT(IEN) ;
 ;This entry point deletes the entire exception from the file 391.98 
 ;and 391.99
 ;INPUTS
 ;IEN is the IEN of the entry in 391.98 it can be obtained from the call
 ; to the CHK line tag.
 ;
 ;OUTPUT
 ;ZERO(0) - if a problem or no deletion
 ;ONE(1) - if deletion occurred
 ;
 I '$D(IEN) S ERR="0^Input parameter missing." G DELQ
 I IEN']"" S ERR="0^Input parameter undefined." G DELQ
 I '$D(^DGCN(391.98,IEN,0)) S ERR="0^Exception data missing." G DELQ
 D DELDATA(IEN,.ERR)
 ;
 S DIK="^DGCN(391.98,"
 S DA=IEN
 D ^DIK
 K DIK,DA
 S ERR=1
 ;
DELQ Q ERR
 ;
DELDATA(IEN,ERR) ;
 N LP
 F LP=0:0 S LP=$O(^DGCN(391.99,"B",IEN,LP)) Q:'LP  DO
 .I '$D(^DGCN(391.99,LP,0)) Q
 .S DIK="^DGCN(391.99,"
 .S DA=LP
 .D ^DIK
 .K DA,DIK
 .S ERR=1
 .Q
 Q
 ;
EDIT(IEN,STAT) ;
 ;This entry point allows the editing of the status of an exception.
 ;INPUT
 ;IEN - the ien for an entry from 391.98
 ;STAT - the new status.
 ;
 ;OUTPUTS
 ;ZERO(0)^ description if an error
 ;1 if changed
 N ERR
 ;
 I '$D(IEN) S ERR="0^IEN not defined." G EDITQ
 I IEN']"" S ERR="0^IEN is null." G EDITQ
 I '$D(STAT) S ERR="0^Status is not defined." G EDITQ
 I STAT']"" S ERR="0^Status is null." G EDITQ
 I '$D(^DGCN(391.98,IEN,0)) S ERR="0^No entry for the IEN." G EDITQ
 ;
 N DIE,DA,DR
 S DIE="^DGCN(391.98,"
 S DA=IEN
 S DR=".04///"_STAT
 D ^DIE
 S ERR=1
 ;
EDITQ Q ERR
 ;
LOCK(IEN) ;this function call will check the status of the exception and
 ;set it to being reviewed if it is able.  Exceptions that are being 
 ;reviewed, data rejected, merge complete or retired data can not be
 ;set to being reviewed and thus accessed.
 ;
 ;INPUT - IEN the ien of the exception
 ;
 ;OUTPUT - 1 if the exception was able to be locked/ status turned to
 ;           being reviewed.
 ;         0^description if the exception was not able to be "locked"
 ;
 N ERR,STAT,DATA
 I '$D(IEN) S ERR="0^No input." G LCKQ
 I IEN']"" S ERR="0^Null input." G LCKQ
 L +^DGCN(391.98,IEN):0 I '$T S ERR="0^Exception is currently locked." G LCKQ ;**255
 S DATA=$G(^DGCN(391.98,IEN,0))
 I DATA="" S ERR="0^Exception not found." G LCKQ
 S STAT=$P(DATA,U,4)
 I STAT']"" S ERR="0^Status not defined." G LCKQ
 S STAT=$G(^DGCN(391.984,STAT,0))
 I STAT="" S ERR="0^Status not found." G LCKQ
 I $P(STAT,U,2)'="AR",($P(STAT,U,2)'="DE") S ERR="0^"_$P(STAT,U,1) G LCKQ
 I $$EDIT(IEN,"BR") S ERR="1^OK"
 E  S ERR="0^Could not change status."
 ;
LCKQ Q ERR
