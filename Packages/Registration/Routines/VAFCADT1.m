VAFCADT1 ;ALB/RJS - HL7 PATIENT MOVEMENT EVENTS  - APRIL 13,1995
 ;;5.3;Registration;**91,179**;Jun 06, 1996
 ;HL7v1.6
 ;This Routine is executed as an item protocol on the DGPM Patient
 ;Movement Event Driver. It's purpose is to determine what event
 ;has occurred. Has an Admission been created ? Has a Transfer with
 ;an associated Specialty Transfer been deleted ? This routine 
 ;contains the logic to determine this.
 ;
 ;In certain instances, one HL7 message will be sent. In other
 ;instances portions (or the entire) history of an admission may
 ;be sent.
 ;
 ;A Portion of the history will be sent, if that portion
 ;is affected by the insertion or deletion of an event.
 ;
 ;You can run this software in the foreground and turn on a trace of 
 ;this software, by defining the node ^TMP("VAFCADT1",$J)
 ;
 Q:'$P($$SEND^VAFHUTL(),"^",2)
 ;S ^TMP("VAFCADT1",$J)=1
 N VATRACE,VAFH
 MERGE VAFH=^UTILITY("DGPM",$J)
 I '($G(DGQUIET)) D
 . W !,"Executing HL7 ADT Messaging"
 . I $D(^TMP("VAFCADT1",$J)) S VATRACE=1
 I $D(VATRACE) D  G EXIT
 . D INITIZE
 N ZTDESC,ZTRTN,ZTSAVE,ZTIO,ZTDTH
 S ZTDESC="HL7 ADT MESSAGE",ZTRTN="INITIZE^VAFCADT1",ZTSAVE("DGPMP")="",ZTSAVE("DGPMA")="",ZTIO="",ZTSAVE("DGPMDA")="",ZTSAVE("DFN")="",ZTDTH=$H,ZTSAVE("VAFH(")=""
 D ^%ZTLOAD
EXIT ;
 I $D(ZTQUEUED) S ZTREQ="@"
 D KILL^HLTRANS
 K ^TMP("HLS",$J)
 Q
 ;
INITIZE ;;;can't do v1.6 it here, need event for init
 ;S HLNDAP="PIMS HL7" D INIT^HLTRANS
 ;S HLNDAP="PIMS HL7" D INIT^HLFNC2("VAFH "_EVENT,.HL)
 ;I $D(HLERR) Q
 ;I $D(HL)<2 Q
 D EVENT,EXIT
 Q
EVENT ;
 I $G(DGPMP)=""&($G(DGPMA)="") Q
 N EVENT,TYPE,VAFHDT,ADMSSN,ADMDATE,IEN,PIVOT,PIVCHK,HISTORY
 N OLDDATE,PV1,GARBAGE,MOVETYPE
 ;  
 ;I DGPMP="" and DGPMA'="" it means we're adding a new ADMISSION,
 ;TRANSFER, DISCHARGE, or SPECIALTY TRANSFER to the Patient Movement
 ;File
 ;
 I (DGPMP="")&(DGPMA'="") D  G EXIT
 . ;
 . D SETVARS^VAFCADT4(DGPMA,DGPMDA) ;             TYPE,VAFHDT,ADMSSN,IEN
 . ;
 . ;I TYPE=3 it means we're inserting a DISCHARGE
 . ;
 . I (TYPE=3) S EVENT="A03" D  Q
 . . W:$D(VATRACE) !,1.3
 . . S MOVETYPE=$$MOVETYPE^VAFCADT4(DGPMA)
 . . I MOVETYPE=41 D 41^VAFCADT5(DFN) Q
 . . I MOVETYPE=46 D 46^VAFCADT5(DFN) Q
 . . S PIVCHK=$$PIVCHK^VAFHPIVT(DFN,$$ADMDATE^VAFCADT4(ADMSSN),1,ADMSSN_";DGPM(")
 . . S PIVOT=$$PIVNW^VAFHPIVT(DFN,$$ADMDATE^VAFCADT4(ADMSSN),1,ADMSSN_";DGPM(")
 . . I +PIVCHK>0 D BLDMSG^VAFCADT2(DFN,"A03",VAFHDT,"05",IEN,+PIVOT) Q
 . . K HISTORY
 . . D BLDHIST^VAFCADT3(DFN,ADMSSN,"HISTORY")
 . . D ENTIRE^VAFCADT4(+PIVOT)
 . ;
 . ;I TYPE=1 it means we're inserting an ADMISSION
 . ;
 . I (TYPE=1) D  Q
 . . W:$D(VATRACE) !,1.1
 . . D PIVINIT^VAFCADT4(DFN,$$ADMDATE^VAFCADT4(ADMSSN),ADMSSN)
 . . D BLDMSG^VAFCADT2(DFN,"A01",VAFHDT,"05",IEN,+PIVOT)
 . ;
 . ;I TYPE=2 it means we're inserting a TRANSFER
 . ;
 . I (TYPE=2) D  Q
 . . W:$D(VATRACE) !,1.2
 . . S MOVETYPE=$$MOVETYPE^VAFCADT4(DGPMA)
 . . I MOVETYPE=13 D 13^VAFCADT5(DFN) Q
 . . I MOVETYPE=14 D 14^VAFCADT5(DFN) Q
 . . I MOVETYPE=43 D 43^VAFCADT5(DFN) Q
 . . I MOVETYPE=44 D 44^VAFCADT5(DFN) Q
 . . K HISTORY
 . . D BLDHIST^VAFCADT3(DFN,ADMSSN,"HISTORY")
 . . D PIVINIT^VAFCADT4(DFN,$$ADMDATE^VAFCADT4(ADMSSN),ADMSSN)
 . . D ADDING^VAFCADT4(DFN,"A02",VAFHDT,+PIVOT,+PIVCHK) Q
 . ;
 . ;I TYPE=6 it means we're inserting a standalone SPECIALTY TRANSFER
 . ;
 . I (TYPE=6) D  Q
 . . W:$D(VATRACE) !,1.6
 . . K HISTORY
 . . D BLDHIST^VAFCADT3(DFN,ADMSSN,"HISTORY")
 . . D PIVINIT^VAFCADT4(DFN,$$ADMDATE^VAFCADT4(ADMSSN),ADMSSN)
 . . D ADDING^VAFCADT4(DFN,"A08",VAFHDT,+PIVOT,+PIVCHK) Q
 ;
 ;If DGPMP'="" and DGPMA'="" it means we're editing an existing
 ;ADMISSION, DISCHARGE, TRANSFER, or SPECIALTY TRANSFER
 ;
 I (DGPMP'="")&(DGPMA'="") D  G EXIT
 . ;
 . D SETVARS^VAFCADT4(DGPMA,DGPMDA)
 . S EVENT="A08",OLDDATE=$P(DGPMP,"^",1)
 . K HISTORY
 . D BLDHIST^VAFCADT3(DFN,ADMSSN,"HISTORY")
 . I '$D(HISTORY) Q
 . ;
 . ;I TYPE=1 it means we're editing an existing ADMISSION
 . ;
 . I (TYPE=1) D  Q
 . . W:$D(VATRACE) !,2.1
 . . ;
 . . ;If the DATE/TIME of the admission is one of the fields
 . . ;that's been edited, it demands special treatment
 . . ;
 . . I VAFHDT'=OLDDATE D  Q
 . . . K HL D INIT^HLFNC2("VAFC ADT-A11 SERVER",.HL) ;          doit here before dgbuild
 . . . I $D(HL)#2 Q
 . . . S PV1=$$DGBUILD^VAFHAPV1(DGPMP,",3,7,10,18,44,45")
 . . . S PIVCHK=$$PIVCHK^VAFHPIVT(DFN,OLDDATE,1,ADMSSN_";DGPM(")
 . . . ;
 . . . I +PIVCHK>0 D
 . . . . S PIVOT=$$PIVNW^VAFHPIVT(DFN,OLDDATE,1,ADMSSN_";DGPM(")
 . . . . D BLDMSG^VAFCADT2(DFN,"A11",OLDDATE,"05","",+PIVOT,PV1)
 . . . . S GARBAGE=$$UPDATE^VAFHUTL(+PIVOT,"","",1)
 . . . S PIVOT=$$PIVNW^VAFHPIVT(DFN,VAFHDT,1,ADMSSN_";DGPM(")
 . . . D:+PIVOT>0 ENTIRE^VAFCADT4(+PIVOT)
 . . ;
 . . I VAFHDT=OLDDATE D  Q
 . . . ;
 . . . D PIVINIT^VAFCADT4(DFN,VAFHDT,ADMSSN)
 . . . ;
 . . . I +PIVCHK'>0 D ENTIRE^VAFCADT4(+PIVOT) Q
 . . . ;
 . . . I +PIVCHK>0 D INSERT^VAFCADT4(DFN,"A08",VAFHDT,+PIVOT) Q
 . ;
 . ;I TYPE=2 it means we're editing an existing TRANSFER
 . ;
 . I (TYPE=2) D  Q
 . . W:$D(VATRACE) !,2.2
 . . ;
 . . D PIVINIT^VAFCADT4(DFN,$$ADMDATE^VAFCADT4(ADMSSN),ADMSSN)
 . . ;
 . . I VAFHDT'=OLDDATE D  Q
 . . . ;
 . . . I +PIVCHK'>0 D ENTIRE^VAFCADT4(+PIVOT) Q
 . . . ;
 . . . I +PIVCHK>0 D  Q
 . . . . D DELETE^VAFCADT4(DFN,"A12",OLDDATE,+PIVOT,2.2)
 . . . . D INSERT^VAFCADT4(DFN,"A02",VAFHDT,+PIVOT)
 . . ;
 . . I VAFHDT=OLDDATE D  Q
 . . . ;
 . . . I +PIVCHK'>0 D ENTIRE^VAFCADT4(+PIVOT) Q
 . . . ;
 . . . I +PIVCHK>0 D INSERT^VAFCADT4(DFN,"A08",VAFHDT,+PIVOT) Q
 . ;
 . ;I TYPE=3 it means we're editing an existing DISCHARGE
 . ;
 . I (TYPE=3) D  Q
 . . W:$D(VATRACE) !,2.3
 . . ;
 . . D PIVINIT^VAFCADT4(DFN,$$ADMDATE^VAFCADT4(ADMSSN),ADMSSN)
 . . I VAFHDT'=OLDDATE D  Q
 . . . ;
 . . . I +PIVCHK'>0 D ENTIRE^VAFCADT4(+PIVOT) Q
 . . . I +PIVCHK>0 D  Q
 . . . . D BLDMSG^VAFCADT2(DFN,"A13",OLDDATE,"05",IEN,+PIVOT)
 . . . . D BLDMSG^VAFCADT2(DFN,"A03",VAFHDT,"05",IEN,+PIVOT)
 . . ;
 . . I VAFHDT=OLDDATE D  Q
 . . . I +PIVCHK'>0 D ENTIRE^VAFCADT4(+PIVOT) Q
 . . . I +PIVCHK>0 D BLDMSG^VAFCADT2(DFN,EVENT,VAFHDT,"05",IEN,+PIVOT) Q
 . ;
 . ;I TYPE=6 it means we're editing an existing SPECIALTY TRANSFER
 . ;
 . I (TYPE=6) D  Q
 . . W:$D(VATRACE) !,2.6
 . . ;
 . . D PIVINIT^VAFCADT4(DFN,$$ADMDATE^VAFCADT4(ADMSSN),ADMSSN)
 . . ;
 . . I VAFHDT'=OLDDATE D  Q
 . . . ;
 . . . I +PIVCHK'>0 D ENTIRE^VAFCADT4(+PIVOT) Q
 . . . ;
 . . . I +PIVCHK>0 D  Q
 . . . . D DELETE^VAFCADT4(DFN,"A08",OLDDATE,+PIVOT,2.6)
 . . . . D INSERT^VAFCADT4(DFN,"A08",VAFHDT,+PIVOT)
 . . ;
 . . I VAFHDT=OLDDATE D  Q
 . . . ;
 . . . I +PIVCHK'>0 D ENTIRE^VAFCADT4(+PIVOT) Q
 . . . ;
 . . . I +PIVCHK>0 D INSERT^VAFCADT4(DFN,"A08",VAFHDT,+PIVOT) Q
 ;
 ;If DGPMP'="" and DGPMA="" it means we're deleting an ADMISSION,
 ;TRANSFER, DISCHARGE, or SPECIALTY TRANSFER
 ;
 I (DGPMP'="")&(DGPMA="") D  G EXIT
 . D SETVARS^VAFCADT4(DGPMP,DGPMDA)
 . K HISTORY
 . D BLDHIST^VAFCADT3(DFN,ADMSSN,"HISTORY")
 . ;
 . ;If TYPE=1 it means we're deleting an ADMISSION
 . ;
 . I (TYPE=1) S EVENT="A11" D  Q
 . . W:$D(VATRACE) !,3.1
 . . S PIVCHK=$$PIVCHK^VAFHPIVT(DFN,VAFHDT,1,ADMSSN_";DGPM(")
 . . ;
 . . I +PIVCHK'>0 Q
 . . K HL D INIT^HLFNC2("VAFC ADT-A11 SERVER",.HL) ;             doit here before dgbuild
 . . I $D(HL)#2 Q
 . . S PV1=$$DGBUILD^VAFHAPV1(DGPMP,",3,7,10,18,44,45")
 . . S PIVOT=$$PIVNW^VAFHPIVT(DFN,VAFHDT,1,ADMSSN_";DGPM(")
 . . D BLDMSG^VAFCADT2(DFN,EVENT,VAFHDT,"05","",+PIVOT,PV1)
 . . N GARBAGE
 . . S GARBAGE=$$UPDATE^VAFHUTL(+PIVOT,"","",1)
 . ;
 . ;If TYPE=2 it means we're deleting a TRANSFER
 . ;
 . I (TYPE=2) S EVENT="A12" D  Q
 . . W:$D(VATRACE) !,3.2
 . . ;
 . . D PIVINIT^VAFCADT4(DFN,$$ADMDATE^VAFCADT4(ADMSSN),ADMSSN)
 . . ;
 . . I +PIVCHK'>0 D ENTIRE^VAFCADT4(+PIVOT) Q
 . . ;
 . . I +PIVCHK>0 D DELETE^VAFCADT4(DFN,EVENT,VAFHDT,+PIVOT,3.2) Q
 . ;
 . ;If TYPE=3 it means we're deleting a DISCHARGE
 . ;
 . I (TYPE=3) S EVENT="A13" D  Q
 . . W:$D(VATRACE) !,3.3
 . . ;
 . . D PIVINIT^VAFCADT4(DFN,$$ADMDATE^VAFCADT4(ADMSSN),ADMSSN)
 . . ;
 . . I +PIVCHK'>0 D ENTIRE^VAFCADT4(+PIVOT) Q
 . . ;
 . . I +PIVCHK>0 D BLDMSG^VAFCADT2(DFN,EVENT,VAFHDT,"05","",+PIVOT) Q
 . ;
 . ;If TYPE=6 it means we're deleting a SPECIALTY TRANSFER
 . ;
 . I (TYPE=6) S EVENT="A08" D  Q
 . . W:$D(VATRACE) !,3.6
 . . ;
 . . D PIVINIT^VAFCADT4(DFN,$$ADMDATE^VAFCADT4(ADMSSN),ADMSSN)
 . . ;
 . . I +PIVCHK'>0 D ENTIRE^VAFCADT4(+PIVOT) Q
 . . ;
 . . I +PIVCHK>0 D DELETE^VAFCADT4(DFN,EVENT,VAFHDT,+PIVOT,3.6) Q
