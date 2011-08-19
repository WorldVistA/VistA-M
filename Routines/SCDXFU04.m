SCDXFU04 ;ALB/JRP - ACRP FILE UTILITIES FOR CLOSE OUT;15-APR-97 ; 1/24/02 3:44pm
 ;;5.3;Scheduling;**121,140,247**;Aug 13, 1993
 ;
XMIT4DBC(XMITPTR) ;Determine if an entry in the TRANSMITTED OUTPATIENT
 ; ENCOUNTER file (#409.73) should be transmitted to the NPCD
 ; for database [not workload] credit and/or workload credit
 ;
 ;Input : XMITPTR - Pointer to entry in Transmitted Outpatient
 ;                  Encounter file
 ;Output:
 ;       0 - Transmit - NPCD will accept for monthly workload credit,
 ;                      no message generated
 ;       1 - Transmit - NPCD will accept for monthly workload credit
 ;           with a rolling message
 ;       2 - Transmit - will accept for yearly workload report
 ;       3 - Transmit - for historical accuracy of database only
 ;       4 - Don't transmit (NPCD will not accept for database credit)
 ;Notes :5 (don't transmit) will be returned on error/bad input
 ;
 ;Check input
 S XMITPTR=+$G(XMITPTR)
 Q:('$D(^SD(409.73,XMITPTR,0))) 5
 ;Declare variables
 N NODE,ENCPTR,DELPTR,ENCDATE
 ;Get pointer to [deleted] encounter
 S NODE=$G(^SD(409.73,XMITPTR,0))
 S ENCPTR=+$P(NODE,"^",2)
 S DELPTR=+$P(NODE,"^",3)
 ;Get date/time of [deleted] encounter
 S:(ENCPTR) NODE=$G(^SCE(ENCPTR,0))
 S:('ENCPTR) NODE=$G(^SD(409.74,DELPTR,1))
 S ENCDATE=+NODE
 Q:('ENCDATE) 5
 ;Get the level of acceptance
 Q $$OKTOXMIT(ENCDATE)
 ;
OKTOXMIT(ENCDATE,COMPDATE) ;Determine if an encounter occurring on a
 ; specified date should be transmitted to the National Patient Care
 ; Database for database and workload credit. It also determines
 ; the acceptance level(message type), later used when generating
 ; late activity messages
 ;
 ;Input (FileMan format):
 ;
 ;  ENCDATE  - Date/time Outpatient Encounter occurred on
 ;  COMPDATE - Date to compare close out dates against;
 ;             defaults to the current date
 ;
 ;Output : MessageType
 ;
 ; MessageType  - Indicates what type of message will be generated
 ;                for Encounter with the submitted ENCDATE.
 ;                In the same time the message type determines if
 ;                Encounter can be transmitted. The message type
 ;                indicates if the specified date/time will be
 ;                accepted for database/workload credit.
 ;                
 ;  A message type is determined in the following order of comparison:
 ;     Type                                  Transmitted
 ;    -------------------------------------------------------------
 ;      4 - Database closeout date                no        DBCLOSE
 ;      3 - Annual Workload closeout date         yes       WLCLA
 ;      2 - Monthly Workload closeout date        yes       WLCLOSE
 ;      1 - Rolling date                          yes       ROLL
 ;
 ;      0 - No message                            yes
 ;     -1 - Error                                 no
 ;
 ;Check input / remove time
 S ENCDATE=+$G(ENCDATE)\1
 Q:(ENCDATE'?7N) "-1"
 S COMPDATE=+$G(COMPDATE)\1
 S:(COMPDATE'?7N) COMPDATE=$$DT^XLFDT()
 ;Declare variables
 N CLOSEOUT,DBCLOSE,WLCLOSE,WLCLA,ROLL
 N DBCRED,WLCRED,COMP
 S (DBCRED,WLCRED)=-1
 ;Get close-out dates for month the encounter occurred in
 S CLOSEOUT=$$CLOSEOUT(ENCDATE)
 S DBCLOSE=$P(CLOSEOUT,U)
 S WLCLOSE=$P(CLOSEOUT,U,2)
 S WLCLA=$P(CLOSEOUT,U,3)
 S ROLL=$P(CLOSEOUT,U,4)
 ;Determine LEVEL to determine if an encounter can be transmitted
 ;and identify a message to be generated
 N LEVEL,X,%H,%T,%Y,YY
 S LEVEL=0
 S X=COMPDATE D H^%DTC S COMP=%H
 F YY=4:-1:1 D  Q:LEVEL
 .S X=$S(YY=4:DBCLOSE,YY=3:WLCLA,YY=2:WLCLOSE,YY=1:ROLL) D
 ..D H^%DTC I COMP>%H S LEVEL=YY
 ;Done
 Q LEVEL
 ;
CLOSEOUT(NPCDMNTH) ;Get National Patient Care Database (NPCD) close-out
 ; dates for a given month
 ;
 ;Input : NPCDMNTH - Encouter Date (FileMan format) to calculate
 ;                   close-out dates
 ;Output: DBCL ^ WLCLM ^ WLCLA ^ ROLL
 ;    or  -1 ^ -1 ^ -1 ^ -1^  -  Error/bad input
 ;        DBCL,WLCLM,WLCLA,ROLL are returned in FileMan format.
 ;
 ;DBCL    - Database closeout date
 ;          Date on which the specified date/time (NPCDMNTH) will no
 ;          longer be accepted by the NPCD
 ;WLCLM   - Monthly Workload closeout date
 ;          Date on which the specified date/time will no longer be
 ;          accepted by the NPCD for montly workload credit but will
 ;          be valid for fiscal year credit
 ;WLCLA   - Annual Workload closeout date
 ;          Date on which the specified date/time will no longer be
 ;          accepted for yearly credit but will be sent to NPCD for
 ;          historical accuracy of the database.
 ;ROLL    - NPCDMNTH+ROLLD
 ;          Date representing the date ROLLD days older than the
 ;          specified date/time.
 ;
 N DBCL,WLCLM,WLCLA,ROLL,SDY,SDM,SDMM,SDYM,DBCLMD,WLCLMD,WLCLAMD,ROLLD
 N X1,X2,X,%H,%T,%Y,TODAY,SDYY
 S DBCLMD="0930",WLCLMD=19,WLCLAMD=1019,ROLLD=19
 ;
 ;Check input / remove time
 S NPCDMNTH=+$G(NPCDMNTH)\1
 Q:(+NPCDMNTH'?7N) "-1^-1^-1^-1"
 ;
 ;Declare variables
 S SDY=$E(NPCDMNTH,1,3)
 S SDM=$E(NPCDMNTH,4,5)
 ;
 ;Build DBCL
 S SDYY=SDY+2 S:SDM>9 SDYY=SDYY+1
 S DBCL=SDYY_DBCLMD
 ;
 ;Build WLCLM
 S SDMM=SDM+1,SDYM=SDY
 I SDMM=13 S SDMM="01",SDYM=SDY+1
 S:$L(SDMM)=1 SDMM="0"_SDMM
 S WLCLM=SDYM_SDMM_WLCLMD
 ;
 ;Build WLCLA
 I SDM>9 S SDY=SDY+1
 S WLCLA=SDY_WLCLAMD
 ;
 ;Build ROLL
 S X1=NPCDMNTH,X2=ROLLD D C^%DTC S ROLL=X
 ;
 Q DBCL_U_WLCLM_U_WLCLA_U_ROLL
 ;
AECLOSE(NPCDMNTH,DBCLOSE,WLCLOSE) ;Add/edit NPCD close-out dates for
 ; entries in the NPCD ENCOUNTER MONTH multiple (field #710) of the
 ; SCHEDULING PARAMETERS file (#404.91)
 ;
 ;  This field (#710) is not used starting with SD*5.3*247.
 ;
 ;Input  : NPCDMNTH - Month to add/edit National Patient Care Database
 ;                    close-out dates (FileMan format)
 ;         DBCLOSE - Date on which the specified date/time will no
 ;                   longer be accepted by the NPCD (FileMan format)
 ;         WLCLOSE - Date on which the specified date/time will no
 ;                   longer be accepted by the NPCD for workload
 ;                   credit (FileMan format)
 ;Output : IEN ^ Added = Success
 ;           IEN = Pointer to entry in NPCD ENCOUNTER MONTH multiple
 ;           Added = Flag indicating if new entry was added
 ;                     1 = Yes     0 = No
 ;         -1 = Error/bad input
 ;Notes  : NPCDMNTH will be converted to an NPCD Encounter Month
 ;       : It is assumed that NPCDMNTH is a valid date
 ;
 ;Check input / remove time
 S NPCDMNTH=$P((+$G(NPCDMNTH)),".",1)
 Q:(NPCDMNTH'?7N) -1
 S DBCLOSE=$P((+$G(DBCLOSE)),".",1)
 Q:(DBCLOSE'?7N) -1
 S WLCLOSE=$P((+$G(WLCLOSE)),".",1)
 Q:(WLCLOSE'?7N) -1
 ;Declare variables
 N SCDXFDA,SCDXIEN,SCDXMSG,MNTHPTR,MNTHADD
 ;Convert FileMan month to NPCD Encounter Month
 S NPCDMNTH=$$FM2NPCD(NPCDMNTH)
 Q:(NPCDMNTH=-1) -1
 ;Set up call to FileMan Updater (call will find/create entry)
 S SCDXFDA(404.9171,"?+1,1,",.01)=NPCDMNTH
 S SCDXFDA(404.9171,"?+1,1,",.02)=DBCLOSE
 S SCDXFDA(404.9171,"?+1,1,",.03)=WLCLOSE
 ;Call FileMan Updater
 D UPDATE^DIE("ES","SCDXFDA","SCDXIEN","SCDXMSG")
 ;Error
 Q:($D(SCDXMSG("DIERR"))) -1
 ;Get entry number
 S MNTHPTR=+$G(SCDXIEN(1))
 ;Determine if new entry was added
 S MNTHADD=0
 S:($G(SCDXIEN(1,0))="+") MNTHADD=1
 ;Done
 Q MNTHPTR_"^"_MNTHADD
 ;
FM2NPCD(DATE) ;Convert FileMan date/time to NPCD ENCOUNTER MONTH format
 ;
 ;Input  : DATE - Date/time to convert (FileMan format)
 ;Output : MM-YYYY - Imprecise month format
 ;                   MM = Month (numeric with leading zero)
 ;                   YYYYY = Year
 ;         -1 - Error (bad input)
 ;Notes  : It is assumed that DATE is a valid date
 ;
 ;Check input
 S DATE=+$P($G(DATE),".",1)
 Q:(DATE'?7N) -1
 ;Return NPCD Encounter Month
 Q $E(DATE,4,5)_"-"_(1700+$E(DATE,1,3))
 ;
NPCD2FM(NPCDMNTH) ;Convert NPCD ENCOUNTER MONTH format to FileMan date
 ;
 ;Input  : MM-YYYY - Imprecise month format
 ;                   MM = Month (numeric with leading zero)
 ;                   YYYYY = Year
 ;Output : DATE - Date/time to convert (FileMan format)
 ;         -1 - Error (bad input)
 ;Notes  : It is assumed that NPCDMNTH is a valid imprecise date
 ;
 ;Check input
 S NPCDMNTH=$G(NPCDMNTH)
 Q:(NPCDMNTH'?2N1"-"4N) -1
 ;Return FileMan date
 ;Q ($P(NPCDMNTH,"-",2)-1700)_$P(NPCDMNTH,"-",1)_"00"
 ; Y2K Renovation.  %DT will return yyymm00 for imprecise date.
 N X,Y S X=NPCDMNTH D ^%DT
 Q Y
