DGENCLN1 ;ALB/CJM - National Enrollment Seeding, Patient File Cleanup; 2/22/1999
 ;;5.3;Registration;**222**;08/13/93
 ;
CLEANUP ;This entry point will do the cleanup.
 ;
 N DGENSKIP
 S DGENSKIP=0
 W !,"*** This is a one-time cleanup for the National Enrollment Seeding ***"
 W !,"Patient records whose seeding update may not have completed will be"
 W !,"reported, and a query for each patient will be sent to HEC in order"
 W !,"to complete the cleanup.  Also, records in the Patient file with no"
 W !,"zero node that were created by the seeding will be deleted."
 I $$DEVICE() D ENTER
 Q
 ;
REPORT ;This entry point was provided for testing, so that before
 ;patient records are deleted the site can have a list of
 ;the DFN's that would be deleted.
 ; 
 ;Use this entry point to report on what the cleanup would do.
 ;No changes will be made to the database.
 ;
 N DGENSKIP
 S DGENSKIP=1
 W !,"*** This is a one-time report for the National Enrollment Seeding ***"
 W !,"Patient records whose seeding update may not have completed will be"
 W !,"reported. Also, records in the Patient file with no zero node that"
 W !,"were created by the seeding will be listed by DFN"
 I $$DEVICE() D ENTER
 Q
 ;
ENTER ;
 ;Description:  This routine looks at patients included in the
 ;seeding.  It reports each patient where the update may not have
 ;completed for the fields RECEIVING VA DISABILITY, or ELIGIBLE
 ;FOR MEDICAID?, or POW STATUS INDICATED?  It re-queries HEC for
 ;those patients.
 ;
 N DFN,AUDIT,ANODE,NAME,SSN,COUNT,XREFDFN,NAMESSN,LINE,SEEDDATE,DGENON
 K ^TMP($J)
 S (AUDIT,XREFDFN,COUNT)=0
 ;
 I '$G(DGENSKIP) D
 .S DGENON=$$ON^DGENQRY
 .I 'DGENON D TURNON^DGENQRY
 F  S XREFDFN=$O(^DGENA(27.14,"C",XREFDFN)) Q:'XREFDFN  S AUDIT=$O(^DGENA(27.14,"C",XREFDFN,9999999999),-1) Q:'AUDIT  D
 .N COND
 .S ANODE=$G(^DGENA(27.14,AUDIT,0))
 .S SEEDDATE=($P(ANODE,"^",2)\1)
 .S DFN=$P(ANODE,"^",3)
 .Q:'DFN
 .Q:(XREFDFN'=DFN)
 .I $$PARSE(AUDIT,DFN,SEEDDATE,.COND) D
 ..S COUNT=COUNT+1
 ..I '$G(DGENSKIP) I $$SEND^DGENQRY1(DFN)
 ..S NAME=$$NAME^DGENPTA(DFN) Q:(NAME="")
 ..S SSN=$$SSN^DGENPTA(DFN) Q:(SSN="")
 ..S NAMESSN=$$LJ(NAME,32)_"  "_SSN
 ..S ^TMP($J,NAMESSN,DFN)=SEEDDATE
 ..S LINE=0 F  S LINE=$O(COND(LINE)) Q:'LINE  S ^TMP($J,NAMESSN,DFN,LINE)=COND(LINE)
 D PRINT(COUNT)
 K ^TMP($J)
 I '$G(DGENSKIP) D
 .I 'DGENON D TURNOFF^DGENQRY
 ;
 ;don't need the printer anymore, unless the bad patient records are
 ;just being reported rather than deleted
 D:('DGENSKIP) ^%ZISC
 ;
 ;process the patient records with no 0 node
 D DELETE(DGENSKIP)
 D:(DGENSKIP) ^%ZISC
 I $D(ZTQUEUED) S ZTREQ="@"
 Q
PRINT(COUNT) ;
 N NAME,DFN,LINE,NODE,PAGE,QUIT,CRT
 S QUIT=0
 S CRT=$S($E(IOST,1,2)="C-":1,1:0)
 U IO
 W @IOF
 S PAGE=1
 D HEADER(1)
 S NAME=""
 F  S NAME=$O(^TMP($J,NAME)) Q:(NAME="")  Q:QUIT  D
 .S DFN=0
 .F  S DFN=$O(^TMP($J,NAME,DFN)) Q:'DFN  D
 ..S LINE=$G(^TMP($J,NAME,DFN))
 ..S QUIT=$$PLINE(.PAGE,NAME_"       "_$$DATE(LINE)) Q:QUIT
 ..S LINE=0
 ..F  S LINE=$O(^TMP($J,NAME,DFN,LINE)) Q:'LINE  S QUIT=$$PLINE(.PAGE,"    "_$G(^TMP($J,NAME,DFN,LINE))) Q:QUIT
 ..S QUIT=$$PLINE(.PAGE,"  ") Q:QUIT
 W !!," ***   Total #Patients Found: "_COUNT_"  ***"
 Q
 ;
PARSE(AUDIT,DFN,SEEDDATE,COND) ;
 ;Description:  looks for particular changes in the Enrollment Upload
 ;Audit file (#27.14) for the record=AUDIT.  Returns 1 if found, 0 otherwise.
 ;
 N NODE,FOUND,LINE,COUNT,NEWVALUE,PAT,DATABASE
 S (LINE,FOUND,COUNT)=0
 F  S LINE=$O(^DGENA(27.14,AUDIT,1,LINE)) Q:'LINE  D  Q:'LINE
 .S NODE=$G(^DGENA(27.14,AUDIT,1,LINE,0))
 .;
 .I NODE["POW:" D
 ..I '$D(PAT) D GETPAT(DFN,.PAT)
 ..S NEWVALUE=$$STRIP($E(NODE,41,100))
 ..S DATABASE=$$EXT^DGENELA3("POW",PAT("POW"))
 ..I NEWVALUE'=DATABASE S FOUND=1,COUNT=COUNT+1,COND(COUNT)=$$LJ("POW STATUS INDICATED?",30)_" seeding: "_$$LJ(NEWVALUE,8)_" database: "_DATABASE
 .;
 .I NODE["MEDICAID:" D
 ..I '$D(PAT) D GETPAT(DFN,.PAT)
 ..S NEWVALUE=$$STRIP($E(NODE,41,100))
 ..S DATABASE=$$EXT^DGENELA3("MEDICAID",PAT("MEDICAID"))
 ..I NEWVALUE'=DATABASE,(SEEDDATE>PAT("LAST ASKED")) S FOUND=1,COUNT=COUNT+1,COND(COUNT)=$$LJ("ELIGIBLE FOR MEDICAID? ",30)_" seeding: "_$$LJ(NEWVALUE,8)_" database: "_DATABASE
 .;
 .I NODE["VADISAB:" D
 ..I '$D(PAT) D GETPAT(DFN,.PAT)
 ..S DATABASE=$$EXT^DGENELA3("VADISAB",PAT("VADISAB"))
 ..S NEWVALUE=$$STRIP($E(NODE,41,100))
 ..I NEWVALUE'=DATABASE S FOUND=1,COUNT=COUNT+1,COND(COUNT)=$$LJ("RECEIVING VA DISABILITY?",30)_" seeding: "_$$LJ(NEWVALUE,8)_" database: "_DATABASE
 Q FOUND
 ;
GETPAT(DFN,PAT) ;
 ;Gets several fields from the patient file and returns them in the PAT
 ;array
 ;
 N NODE
 S PAT("VADISAB")=$P($G(^DPT(DFN,.3)),"^",11)
 S PAT("POW")=$P($G(^DPT(DFN,.52)),"^",5)
 S NODE=$G(^DPT(DFN,.38))
 S PAT("MEDICAID")=$P(NODE,"^")
 S PAT("LAST ASKED")=$P(NODE,"^",2)
 Q
DEVICE() ;
 ;Description: allows the user to select a device.
 ;
 ;Output:
 ;  Function Value - Returns 0 if the user decides not to print or to
 ;       queue the report, 1 otherwise.
 ;
 N OK
 S OK=1
 S %ZIS="MQ"
 D ^%ZIS
 S:POP OK=0
 D:OK&$D(IO("Q"))
 .S ZTRTN="ENTER^DGENCLN1",ZTDESC=$S(DGENSKIP:"Report",1:"Cleanup")_" of Incomplete Patient Updates, Enrollment Seeding"
 .S ZTSAVE("DGENSKIP")=""
 .D ^%ZTLOAD
 .W !,$S($D(ZTSK):"REQUEST QUEUED TASK="_ZTSK,1:"REQUEST CANCELLED")
 .D HOME^%ZIS
 .S OK=0
 Q OK
 ;
PLINE(PAGE,LINE) ;
 ;Description: prints a line. First prints header if at end of page.
 ;Returns 1 on success, 0 if the user enters '^'
 ;
 N QUIT S QUIT=0
 I CRT,($Y>(IOSL-5)) D
 .S QUIT=$$PAUSE
 .Q:QUIT
 .W @IOF
 .S PAGE=PAGE+1
 .D HEADER(PAGE)
 .W LINE
 ;
 E  I ('CRT),($Y>(IOSL-5)) D
 .W @IOF
 .S PAGE=PAGE+1
 .D HEADER(PAGE)
 .W LINE
 ;
 E  W !,LINE
 Q QUIT
 ;
HEADER(PAGE) ;
 W !,?((IOM-77)/2),"Incomplete Patient Updates from National Enrollment Seeding",?(IOM-10),"PAGE: ",PAGE
 W !,?((IOM-24)\2),$$FMTE^XLFDT(DT,"D")
 W !!,"     Patient                        SSN           Date Of Seeding"
 W !,"____________________________________________________________________________",!
 Q
 ;
PAUSE() ;
 ;Description: Screen pause.  Sets QUIT=1 if user decides to quit.
 ;
 N DIR,X,Y,QUIT
 S QUIT=0
 F  Q:$Y>(IOSL-4)  W !
 S DIR(0)="E" D ^DIR
 I '(+Y) S QUIT=1
 Q QUIT
 ;
DATE(FMDATE) ;
 N DATE S DATE=""
 S FMDATE=FMDATE\1
 I FMDATE S DATE=$$FMTE^XLFDT(FMDATE,"1")
 Q DATE
 ;
 ;
LJ(STR,LEN) ;
 Q $$LJ^XLFSTR($E(STR,1,LEN),LEN)
 ;
STRIP(STR) ;
 N I
 F I=1:1:$L(STR) I $E(STR,I,I)'=" " Q
 S STR=$E(STR,I,$L(STR))
 S STR=$REVERSE(STR)
 F I=1:1:$L(STR) I $E(STR,I,I)'=" " Q
 S STR=$E(STR,I,$L(STR))
 S STR=$REVERSE(STR)
 Q STR
 ;
DELETE(DGENSKIP) ;
 ;This will delete bogus patient records created during the seeding
 ;A patient record will be deleted if the only nodes are the .3,
 ;.38, or .52
 ;
 ;Input: DGENSKIP - if =1, the the records will not be deleted, but just reported
 ;
 N DFN,SUB,GOOD,COUNT
 W:DGENSKIP !!!,"Begining to search for bad patient records...."
 S (COUNT,DFN)=0
 F  S DFN=$O(^DPT(DFN)) Q:'DFN  D
 .S SUB=""
 .S GOOD=0
 .F  S SUB=$O(^DPT(DFN,SUB)) Q:(SUB="")  D
 ..I (SUB'=.3),(SUB'=.38),(SUB'=.52) S GOOD=1 Q
 .I 'GOOD D
 ..S COUNT=COUNT+1
 ..I DGENSKIP W !,"BAD PATIENT RECORD FOUND, DFN= ",DFN
 ..I 'DGENSKIP D
 ...N DIK,DA
 ...S DIK="^DPT(",DA=DFN D ^DIK
 W:DGENSKIP !!,"*** COUNT OF BAD PATIENT RECORDS (MISSING THE 0 NODE)"_$S(DGENSKIP:"",1:" DELETED")_": ",COUNT,"  ***"
 Q
