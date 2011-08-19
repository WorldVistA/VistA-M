GMRCSTL1 ;SLC/DCM,dee;MA - List Manager Format Routine - Get Active Consults by service - pending,active,scheduled,incomplete,etc. ;11/13/02 08:30
 ;;3.0;CONSULT/REQUEST TRACKING;**7,21,22,29,63**;DEC 27, 1997;Build 10
 ; Patch #21 changed array GMRCTOT to ^TMP("GMRCTOT,$J)
 ; This routine invokes IA #875, #2638
 Q
STATNAME(STATUS) ;Return the name for the status number
 I STATUS<9 Q $S(STATUS=1:"Discont.",STATUS=2:"Completed",STATUS=3:"On Hold",STATUS=4:"Flagged",STATUS=5:"Pending",STATUS=6:"Active",STATUS=7:"Expired",STATUS=8:"Scheduled",1:"No Status")
 E  Q $S(STATUS=9:"Incomplete",STATUS=10:"Delayed",STATUS=11:"Unreleased",STATUS=12:"Discont/Ed",STATUS=13:"Cancelled",STATUS=14:"Lapsed",STATUS=15:"Renewed",1:"No Status")
 Q
 ;
STATABBR(STATUS) ;Return the name for the status number
 Q ^ORD(100.01,STATUS,.1)
 ;
LISTTOT(COUNT,GEN,INDEX,NAME,GROUPNAM,CONTROL,ARRN) ;
 N LOOP,STATUS,STS,CTRLTEMP,GMRCTOTS,SP
 S SP=""
 S CTRLTEMP=$S(CONTROL#2:"^",1:"")
 I GEN=2 D
 . S COUNT=COUNT+1
 . S ^TMP("GMRCR",$J,ARRN,COUNT,0)=CTRLTEMP
 . S COUNT=COUNT+1
 . S ^TMP("GMRCR",$J,ARRN,COUNT,0)=CTRLTEMP_"          GROUPER: "_NAME_" Totals:"
 S GMRCTOTS=0
 I $L(GMRCSTAT,",")=16 S GMRCTOTS=1 ;only incl. totals if all status
 F LOOP=1:1:$L(GMRCSTAT,",") S STATUS=$P(GMRCSTAT,",",LOOP) I ^TMP("GMRCTOT",$J,GEN,INDEX,STATUS)>0 D
 .S COUNT=COUNT+1
 .S STS=$$STATNAME(STATUS)
 .S ^TMP("GMRCR",$J,ARRN,COUNT,0)=CTRLTEMP_"Total Requests "_STS_": "_$J(^TMP("GMRCTOT",$J,GEN,INDEX,STATUS),42-$L(STS),0)
 ;If any printed are pending then print the total that are pending for all pending status.
 I ^TMP("GMRCTOT",$J,GEN,INDEX,"P")>0 D
 .S COUNT=COUNT+1
 .S ^TMP("GMRCR",$J,ARRN,COUNT,0)=CTRLTEMP_"Total Requests Pending Resolution: "_$J(^TMP("GMRCTOT",$J,GEN,INDEX,"P"),24,0)
 ; IF Consults
 I ARRN="IFC" D
 .N IRFN,VALSVC,VALTOT S IRFN=""
 .F  S IRFN=$O(^TMP("GMRCTOT",$J,GEN,INDEX,"F",IRFN)) Q:IRFN=""  D
 ..I GMRCTOTS D
 ...S COUNT=COUNT+1
 ...I GEN=1 S ^TMP("GMRCR",$J,ARRN,COUNT,0)=CTRLTEMP_"Total Requests To Service @ "_$E(IRFN,1,16)_": "_$J(SP,16-$L($E(IRFN,1,16)))_$J(^TMP("GMRCTOT",$J,1,INDEX,"F",IRFN),13,0)
 ...E  S ^TMP("GMRCR",$J,ARRN,COUNT,0)=CTRLTEMP_"Total Requests to Grouper @ "_$E(IRFN,1,20)_": "_$J(SP,20-$L($E(IRFN,1,20)))_$J(^TMP("GMRCTOT",$J,2,INDEX,"F",IRFN),9,0)
 ..I $P($G(GMRCST(GEN,INDEX,IRFN)),"^",2)>0 D
 ...S COUNT=COUNT+1
 ...S VALSVC=$P(GMRCST(GEN,INDEX,IRFN),"^")\$P(GMRCST(GEN,INDEX,IRFN),"^",2)
 ...S ^TMP("GMRCR",$J,ARRN,COUNT,0)=CTRLTEMP_"Mean Days Completed To "_$S(GEN=1:"Service ",1:"Grouper ")_"@ "_$E(IRFN,1,16)_": "_$J(SP,16-$L($E(IRFN,1,16)))_$J(VALSVC,8,0)
 .I $P($G(GMRCST(GEN,INDEX)),"^",2)>0 D
 ..S COUNT=COUNT+1
 ..S VALTOT=$P(GMRCST(GEN,INDEX),"^")\$P(GMRCST(GEN,INDEX),"^",2)
 ..S ^TMP("GMRCR",$J,ARRN,COUNT,0)=CTRLTEMP_"Mean Days Completed To "_$S(GEN=1:"Service",1:"Grouper")_": "_$J(VALTOT,27,0)
 I GMRCTOTS D
 .S COUNT=COUNT+1
 .I GEN=1 S ^TMP("GMRCR",$J,ARRN,COUNT,0)=CTRLTEMP_"Total Requests To Service: "_$J(^TMP("GMRCTOT",$J,1,INDEX,"T"),32,0)
 .E  S ^TMP("GMRCR",$J,ARRN,COUNT,0)=CTRLTEMP_"Total Requests To Grouper: "_$J(^TMP("GMRCTOT",$J,2,INDEX,"T"),32,0)
 Q
 ;
