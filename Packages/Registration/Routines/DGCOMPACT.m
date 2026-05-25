DGCOMPACT ;ALB/BPA,CMC - Routine for COMPACT Act processing the DG;12/18/2023@9:26am
 ;;5.3;Registration;**1104,1117**;Aug 13, 1993;Build 32
 ; *1104* APIs for COMPACT Act processing
 ; Reference to VISIT^PXCOMPACT in ICR #7327
 ;
SETPTFFLG(DGENC,DGVAL) ;
 ; API to set TRT FOR ACUTE SUICIDAL CRISIS flag in PTF 101
 ; DGENC - Encounter ID (PTF IEN)
 ; DGVAL - Value to set into flag
 ;   For YES: D SETPTFFLG^DGCOMPACT(DGENC,1)
 ;   For NO: D SETPTFFLG^DGCOMPACT(DGENC,0)
 ;   For NULL: D SETPTFFLG^DGCOMPACT(DGENC,"")
 ; Create a 70 level in the PTF file if it is not set
 I $G(^DGPT(DGENC,70))="" S ^DGPT(DGENC,70)=""
 S $P(^DGPT(DGENC,70),"^",33)=DGVAL
 Q
 ;
SETPTFMVMT(DGENC,DGVAL,DGSEQ) ;
 ; API to set TREATMENT FOR SUICIDAL CRISIS flag in PTF 501
 ; DGENC - Encounter ID (PTF IEN)
 ; DGVAL - Value to set into flag
 ; DGSEQ - Movement sequence *not required
 ;   For YES: D SETPTFMVMT^DGCOMPACT(DGENC,"Y",DGSEQ)
 ;   For NO: D SETPTFMVMT^DGCOMPACT(DGENC,"N",DGSEQ)
 ;   For NULL: D SETPTFMVMT^DGCOMPACT(DGENC,"",DGSEQ)
 ; When setting a sequence other than the first one, pass the sequence number
 I $G(DGSEQ)'="" S $P(^DGPT(DGENC,"M",DGSEQ,0),"^",33)=DGVAL
 ; Whenever a new movement is created for a PTF, it becomes the 1 node of the subfile.
 E  S $P(^DGPT(DGENC,"M",1,0),"^",33)=DGVAL
 Q
 ;
EDITADMIT(PTF) ;
 N ADMTYP,CDATA,CMPMSG,DFN,DGSTDT,PXIENS
 S DFN=$P(^UTILITY($J,"PXCOMPACT"),"^",1),DGSTDT=$P(^UTILITY($J,"PXCOMPACT"),"^",2),ADMTYP=$P(^UTILITY($J,"PXCOMPACT"),"^",3)
 D ADMIT^PXCOMPACT(DFN,DGSTDT,ADMTYP,PTF)
 S (CMPMSG,CDATA(818.41))=""
 ;Set the movement multiple
 S PXEOCNUM=$$GETEOC^PXCOMPACT(DFN)
 S PXEOCSEQ=$$GETEOCSEQ^PXCOMPACT(DFN)
 S PTFPOINT=$$GETPOINTRSEQ^PXCOMPACT(DFN,PTF,"I")
 S PXIENS="?+1,"_PTFPOINT_","_PXEOCSEQ_","_PXEOCNUM_","
 I $G(DGPMDA)'="" D
 . S CDATA(818.41,PXIENS,.01)=DGPMDA
 . D UPDATE^DIE("","CDATA","","CMPMSG")
 K ^UTILITY($J,"PXCOMPACT"),DGSTDT,ADMTYP
 Q
 ;
QUERY ;
 ;query the COMPACT ACT TRANSACTION LOG file and display contents
 N COUNT,DATA,ICN,RECORD,REQ,REQUEST,RESP,RESPCODE,RESPDATE,ROUTINE,RSEQ,SEQ,SITE
 I '$D(^DGCOMP(33.3,"B")) W !,"Data Not Available" Q
 S ICN=""
 F  S ICN=$O(^DGCOMP(33.3,"B",ICN)) Q:ICN=""  D
 . S SEQ=""
 . F  S SEQ=$O(^DGCOMP(33.3,"B",ICN,SEQ)) Q:SEQ=""  D
 . . S RECORD=^DGCOMP(33.3,SEQ,0)
 . . S ROUTINE=$P(RECORD,"^",2),REQUEST=$P(RECORD,"^",3),RESPCODE=$P(RECORD,"^",4),RESPDATE=$P(RECORD,"^",5)
 . . S ROUTINE=$S($P(RECORD,"^",2)="":"NO ROUTINE",1:$P(RECORD,"^",2))
 . . I $D(ROUTINE(ROUTINE,"ICN",ICN)) D  Q
 . . . S ROUTINE(ROUTINE,"ICN",ICN,$O(ROUTINE(ROUTINE,"ICN",ICN,""))+1)=REQUEST_"^"_RESPDATE_"^"_RESPCODE
 . . . S ROUTINE(ROUTINE,"COUNT")=$G(ROUTINE(ROUTINE,"COUNT"))+1
 . . S ROUTINE(ROUTINE,"ICN",ICN,1)=REQUEST_"^"_RESPDATE_"^"_RESPCODE,ROUTINE(ROUTINE,"COUNT")=$G(ROUTINE(ROUTINE,"COUNT"))+1
 . . Q
 . Q
 ;now display data in desired format
 S SITE=$P($$SITE^VASITE,"^",1)
 W !,"Site # ",SITE
 S ROUTINE=""
 F  S ROUTINE=$O(ROUTINE(ROUTINE)) Q:ROUTINE=""  D
 . S COUNT=ROUTINE(ROUTINE,"COUNT")
 . W !!,"Calling Routine: ",ROUTINE,"          Request Count: ",COUNT
 . S ICN=""
 . F  S ICN=$O(ROUTINE(ROUTINE,"ICN",ICN)) Q:ICN=""  D
 . . W !,ICN
 . . S RSEQ=""
 . . F  S RSEQ=$O(ROUTINE(ROUTINE,"ICN",ICN,RSEQ)) Q:RSEQ=""  D
 . . . S DATA=ROUTINE(ROUTINE,"ICN",ICN,RSEQ)
 . . . S REQ=$$FMTE^XLFDT($P(DATA,"^",1)),RESP=$$FMTE^XLFDT($P(DATA,"^",2)),RESPCODE=$P(DATA,"^",3)
 . . . W !,"                Request: ",$S($L(REQ)=18:REQ_":00",1:REQ)
 . . . W !,"                Response: ",$S($L(RESP)=18:RESP_":00",1:RESP),"       ",$TR(RESPCODE,"~","^"),!
 Q
ADMIT(DFN,PTF) ;
GO N X,Y,%,CDATA,DA,DEF,ERROR,FIRSTMOVE,MOVEDT,PTFPOINT,PXIENS,PXNWSTDT,SEQCHK,STARTDT,STDT
 W !!,"ADMITTED FOR ACUTE SUICIDAL CRISIS" S %=$S($$ASC^PXCOMPACT(DFN)="Y":1,1:2) D YN^DICN I %=-1 G GO
 S PXEOCNUM=$$GETEOC^PXCOMPACT(DFN),PXEOCSEQ=$$GETEOCSEQ^PXCOMPACT(DFN),PTFPOINT="",ERROR="",CDATA=""
 I PTF'="" S PTFPOINT=$$GETPOINTRSEQ^PXCOMPACT(DFN,PTF,"I")
 I (%=2),$$ASC^PXCOMPACT(DFN)="Y" D  Q
 . ;if this is the last movement in the multiple, need the 'are you sure' prompt
 . I PTFPOINT="" Q
 . I $$CHKMVMT(DFN,PTF)=1,$D(^PXCOMP(818,PXEOCNUM,10,PXEOCSEQ,40,PTFPOINT,1,"B",DGPMDA)) D
 . . I $$GETBENTYP^PXCOMPACT(DFN)="I" W !,"This action will end the episode. Are you sure" S %=2 D YN^DICN I %'=1 G GO
 . . ;Remove movement from multiple in EOC file
 . . S PTFPOINT=$$GETPOINTRSEQ^PXCOMPACT(DFN,PTF,"I")
 . . S DA(3)=PXEOCNUM,DA(2)=PXEOCSEQ,DA(1)=PTFPOINT,DA=$$GETMVMT^DGCOMPACT(DFN,PTF,DGPMDA)
 . . S DIK="^PXCOMP(818,"_DA(3)_",10,"_DA(2)_",40,"_DA(1)_",1,"
 . . D ^DIK
 . . K DA,DIK
 . . ;set PTF 101 to a No
 . . D SETPTFFLG(PTF,0)
 . . ;set PTF 501 to a No
 . . D SETPTFMVMT(PTF,"N",1)
 . . I $$GETBENTYP^PXCOMPACT(DFN)="I" D REVERT(DFN,PTF) Q
 . . ;Otherwise remove 40 node associating the episode with the PTF and movement (edit admission to No after patient is discharged)
 . . N DA,DIK
 . . S DA(2)=PXEOCNUM,DA(1)=PXEOCSEQ,DA=PTFPOINT,DIK="^PXCOMP(818,"_DA(2)_",10,"_DA(1)_",40,"
 . . D ^DIK
 . . K DA,DIK
 . I $$CHKMVMT(DFN,PTF)>1 D
 . . ;Remove movement from multiple in EOC file
 . . S PTFPOINT=$$GETPOINTRSEQ^PXCOMPACT(DFN,PTF,"I")
 . . S DA(3)=PXEOCNUM,DA(2)=PXEOCSEQ,DA(1)=PTFPOINT,DA=$$GETMVMT^DGCOMPACT(DFN,PTF,DGPMDA)
 . . S DIK="^PXCOMP(818,"_DA(3)_",10,"_DA(2)_",40,"_DA(1)_",1,"
 . . D ^DIK
 . . K DA,DIK
 . . ;set PTF 501 to a No
 . . D SETPTFMVMT(PTF,"N",1)
 . . ;reset start date (potentially) to earliest movement date
 . . S FIRSTMOVE=$O(^PXCOMP(818,PXEOCNUM,10,PXEOCSEQ,40,PTFPOINT,1,"B","")) I FIRSTMOVE="" Q
 . . S MOVEDT=$P($P($G(^DGPM(FIRSTMOVE,0)),"^"),"."),STARTDT=$$GETSTDT^PXCOMPACT(DFN)
 . . I MOVEDT'=STARTDT D
 . . . ;check if there is a prior OP episode whose end date matches this episode's start date
 . . . S SEQCHK="B"
 . . . F  S SEQCHK=$O(^PXCOMP(818,PXEOCNUM,10,SEQCHK),-1) Q:SEQCHK=0  D
 . . . . I (SEQCHK=PXEOCSEQ)!($P(^PXCOMP(818,PXEOCNUM,10,SEQCHK,0),"^",6)="E") Q
 . . . . I $P(^PXCOMP(818,PXEOCNUM,10,SEQCHK,0),"^",2)=STARTDT D
 . . . . . S $P(^PXCOMP(818,PXEOCNUM,10,SEQCHK,0),"^",2)=MOVEDT,$P(^PXCOMP(818,PXEOCNUM,10,SEQCHK,0),"^",5)=MOVEDT
 . . . I $$GETBENTYP^PXCOMPACT(DFN)="O" D  Q
 . . . . ;update start date ONLY
 . . . . S PXIENS=PXEOCSEQ_","_PXEOCNUM_","
 . . . . I $G(MOVEDT)'="" S CDATA(818.01,PXIENS,.01)=MOVEDT
 . . . . D FILE^DIE("","CDATA")
 . . . D SETSTDT^PXCOMPACT(DFN,MOVEDT)
 ;if admission is edited to a Yes after discharge, add movement to episode multiple and update 101
 I (%=1),$G(PTF)'="",($$ASC^PXCOMPACT(DFN)="Y"),($$GETBENTYP^PXCOMPACT(DFN)="O"),($P(^PXCOMP(818,PXEOCNUM,10,PXEOCSEQ,0),"^",4)'="") D  I ERROR="" Q
 . ;if latest sequence is error, quit
 . I $P(^PXCOMP(818,PXEOCNUM,10,PXEOCSEQ,0),"^",6)="E" S ERROR=1 Q
 . D VISIT^PXCOMPACT(PTF,"I",PXEOCNUM,DFN)
 . S PTFPOINT=$$GETPOINTRSEQ^PXCOMPACT(DFN,PTF,"I")
 . ;Set the movement multiple
 . S PXIENS="?+1,"_PTFPOINT_","_PXEOCSEQ_","_PXEOCNUM_","
 . I $G(DGPMDA)'="" D
 . . S CDATA(818.41,PXIENS,.01)=DGPMDA
 . . D UPDATE^DIE("","CDATA","","CMPMSG")
 . D SETPTFMVMT(PTF,"Y",1)
 ;if admission is edited to a Yes AFTER a transfer is a Yes, add movement to episode multiple and update start date to admission date
 I (%=1),($$ASC^PXCOMPACT(DFN)="Y"),($$GETBENTYP^PXCOMPACT(DFN)="I") D  Q
 . ;in the event there's no PTF associated (if PTF was removed while patient was discharged and then discharge was deleted)
 . I PTFPOINT="" D VISIT^PXCOMPACT(PTF,"I",PXEOCNUM,DFN)
 . S PTFPOINT=$$GETPOINTRSEQ^PXCOMPACT(DFN,PTF,"I")
 . ;Set the movement multiple
 . S PXIENS="?+1,"_PTFPOINT_","_PXEOCSEQ_","_PXEOCNUM_","
 . I $G(DGPMDA)'="" D
 . . S CDATA(818.41,PXIENS,.01)=DGPMDA
 . . D UPDATE^DIE("","CDATA","","CMPMSG")
 . ;now update start date
 . D SETSTDT^PXCOMPACT(DFN,$P(^DGPM(DGPMDA,0),"."))
 . ;set PTF 501 to Yes
 . D SETPTFMVMT(PTF,"Y",1)
 ;otherwise, start the Inpatient episode
 I %=1 D
 . W !,"         THIS ADMISSION WILL BEGIN THE COMPACT ACT BENEFIT. ARE YOU SURE" S %=2 D YN^DICN I %'=1 G GO
 I ($$ASC^PXCOMPACT(DFN)="Y"),($$GETIPDT^PXCOMPACT(DFN)'=""),($$GETBENTYP^PXCOMPACT(DFN)="O"),$$CHKMVMT(DFN,PTF)="" D
 . S PXNWSTDT=$$GETSTDT^PXCOMPACT(DFN)
DT ;
 I %=1 D
 . I ($$ASC^PXCOMPACT(DFN)="Y"),($$GETBENTYP^PXCOMPACT(DFN)="I") Q
 . W !,"      ACUTE SUICIDAL CRISIS START DATE?: NOW//" R STDT:30
 . I $G(STDT)="" S STDT="NOW"
 . D DT^DILF("",STDT,.PXNWSTDT) I PXNWSTDT=-1 W $C(7),"??",!," Invalid Date!" S %=1 G DT
 . S ^UTILITY($J,"PXCOMPACT")=DFN_"^"_PXNWSTDT_"^F"
 Q
 ;
CHKMVMT(DFN,PTF) ;
 N COUNT,PTFPOINT,PXEOCNUM,PXEOCSEQ
 I PTF="" Q ""
 S PXEOCNUM=$$GETEOC^PXCOMPACT(DFN) I PXEOCNUM="" Q ""
 S PXEOCSEQ=$$GETEOCSEQ^PXCOMPACT(DFN) I PXEOCSEQ="" Q ""
 S PTFPOINT=$$GETPOINTRSEQ^PXCOMPACT(DFN,PTF,"I") I PTFPOINT="" Q ""
 S COUNT=$P($G(^PXCOMP(818,PXEOCNUM,10,PXEOCSEQ,40,PTFPOINT,1,0)),"^",4)
 Q COUNT
 ;
GETMVMT(DFN,PTF,DGPMDA) ;
 N MOVE,PTFPOINT,PXEOCNUM,PXEOCSEQ
 S PXEOCNUM=$$GETEOC^PXCOMPACT(DFN)
 S PXEOCSEQ=$$GETEOCSEQ^PXCOMPACT(DFN)
 S PTFPOINT=$$GETPOINTRSEQ^PXCOMPACT(DFN,PTF,"I")
 S MOVE=$O(^PXCOMP(818,PXEOCNUM,10,PXEOCSEQ,40,PTFPOINT,1,"B",DGPMDA,""))
 Q MOVE
 ;
REVERT(DFN,PTF,DGPMT) ;
 ; get EOC number
 N X,Y,DA,DIK,ELIG,FLAG,FOUND,PTFPOINT,PXEOCNUM,PXEOCSEQ,PXSTARTDT,SEQCHK,STARTDT,VISIT
 S PXEOCNUM=$$GETEOC^PXCOMPACT(DFN),FLAG=""
 ; get EOC sequence number
 S PXEOCSEQ=$$GETEOCSEQ^PXCOMPACT(DFN)
 ;before marking an episode as Entered in Error, determine if it's associated to the PTF
 S PTFPOINT=$$GETPOINTRSEQ^PXCOMPACT(DFN,PTF,"I")
 I PTFPOINT="" Q
 ;check if episode is currently Outpatient. if so, just remove 40 node associating episode with PTF and movement
 ;don't want to change dates
 I $$GETBENTYP^PXCOMPACT(DFN)="O" D  Q
 . D DELPTF
 ;check if there are any VISITs. if so, check the date to see if it's the same as the episode start date
 I $D(^PXCOMP(818,PXEOCNUM,10,PXEOCSEQ,41)) D  I FLAG Q
 . S PXSTARTDT=$$GETSTDT^PXCOMPACT(DFN)
 . S VISIT=""
 . F  S VISIT=$O(^PXCOMP(818,PXEOCNUM,10,PXEOCSEQ,41,"B",VISIT)) Q:(VISIT="")!(FLAG)  D
 . . I $P($P($G(^AUPNVSIT(VISIT,0)),"^",1),".")=PXSTARTDT S FLAG=1
 . I FLAG="" Q
 . S $P(^PXCOMP(818,PXEOCNUM,0),"^",2)=1 ;Reset the episode of care open/close flag
 . S $P(^PXCOMP(818,PXEOCNUM,0),"^",3)="O" ;Reset the Benefit Type
 . S $P(^PXCOMP(818,PXEOCNUM,10,PXEOCSEQ,0),"^",5)=$$FMADD^XLFDT(PXSTARTDT,90) ; Reset outpatient benefit end date
 . S $P(^PXCOMP(818,PXEOCNUM,10,PXEOCSEQ,0),"^",4)="" ;Set inpatient benefit end date to null
 . ;Remove 40 node associating the episode with the PTF and movement
 . D DELPTF
 ;Same day scenario - check if there is a prior episode. if so, check if it was an Outpatient and was closed due to this admission
 S PXSTARTDT=$$GETSTDT^PXCOMPACT(DFN)
 S SEQCHK="B",FOUND=""
 F  S SEQCHK=$O(^PXCOMP(818,PXEOCNUM,10,SEQCHK),-1) Q:(SEQCHK=0)!(FOUND)  D
 . I $P(^PXCOMP(818,PXEOCNUM,10,SEQCHK,0),"^",6)="E" Q
 . I $P(^PXCOMP(818,PXEOCNUM,10,SEQCHK,0),"^",2)'=PXSTARTDT Q
 . ;update fields for prior episode
 . S $P(^PXCOMP(818,PXEOCNUM,10,SEQCHK,0),"^",2)="" ;Remove the end date
 . S $P(^PXCOMP(818,PXEOCNUM,10,SEQCHK,0),"^",3)="" ;Remove the end source
 . S STARTDT=$P(^PXCOMP(818,PXEOCNUM,10,SEQCHK,0),"^",1) ;Get start date for processing
 . S $P(^PXCOMP(818,PXEOCNUM,10,SEQCHK,0),"^",5)=$$FMADD^XLFDT(STARTDT,90) ; Reset outpatient benefit end date
 . I $D(^PXCOMP(818,PXEOCNUM,10,SEQCHK,1)) K ^PXCOMP(818,PXEOCNUM,10,SEQCHK,1)
 . S ELIG=$$ELIG^DGCOMPACTELIG(DFN,"PXCOMPACT")
 . S $P(^PXCOMP(818,PXEOCNUM,10,SEQCHK,0),"^",8)=$S(ELIG="ELIGIBLE":"E",ELIG="NOT ELIGIBLE":"N",1:"U") ;Reset the patient eligibility
 . D SETENDDT^PXCOMPACT(DFN,DT,"")
 . ;mark episode as Entered in Error
 . ; Set the EPISODE FINAL STATUS to Entered in Error (E) and EPISODE SOURCE to NULL
 . S $P(^PXCOMP(818,PXEOCNUM,10,PXEOCSEQ,0),"^",6)="E",$P(^PXCOMP(818,PXEOCNUM,10,PXEOCSEQ,0),"^",7)=""
 . S FOUND=1
 . ;Remove 40 node associating the episode with the PTF and movement
 . D DELPTF
 . S $P(^PXCOMP(818,PXEOCNUM,0),"^",2)=1,$P(^PXCOMP(818,PXEOCNUM,0),"^",3)="O" ;Reset the Benefit Type
 I FOUND Q
 ;Remove 40 node associating the episode with the PTF and movement
 D DELPTF
 ; otherwise, it's a stand alone episode that needs to be marked as Entered in Error
 ; Set the EPISODE FINAL STATUS to Entered in Error (E) and EPISODE SOURCE to NULL
 D SETENDDT^PXCOMPACT(DFN,DT,"")
 S $P(^PXCOMP(818,PXEOCNUM,10,PXEOCSEQ,0),"^",6)="E",$P(^PXCOMP(818,PXEOCNUM,10,PXEOCSEQ,0),"^",7)=""
 Q
DELPTF ;
 ;repeatable function to remove 40 node associating episode with the PTF and movement
 N DA,DIK
 S DA(2)=PXEOCNUM,DA(1)=PXEOCSEQ,DA=PTFPOINT,DIK="^PXCOMP(818,"_DA(2)_",10,"_DA(1)_",40,"
 D ^DIK
 K DA,DIK
 Q
