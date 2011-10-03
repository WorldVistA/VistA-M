SCUTIE1 ;ALB/SCK - INCOMPLETE ENCOUNTER MGMT API CALLS ; 6/17/97
 ;;5.3;Scheduling;**66**;AUG 13, 1993
 ;
 Q
 ;
OPENC(SDXMT,SDARRAY) ; API to return whether Transmitted Outpatient Encounter File entry
 ; points to a deleted encounter.
 ;
 ;   Input:
 ;       SDXMT   - IEN of the Transmitted Outpatient Encounter file entry
 ;       SDARRAY - [optional] - if passed in (as "xxxx"), will return encounter information
 ;                              DFN, Clinic IEN, and Encounter date
 ;
 ;   Return:
 ;        1  - if encounter is deleted
 ;        0  - if encounter is not deleted.
 ;       -1  - if error condition
 ;
 ;        If SDARRAY is passed in, returns:
 ;           SDARRAY["DFN"]       = DFN
 ;           SDARRAY["CLINIC"]    = Clinic IEN
 ;           SDARRAY["ENCOUNTER"] = Encounter date
 ;           SDARRAY["ERROR"]     = Error Condition
 ;           SDARRAY["DELIEN"]   = Ien of Deleted Encounter
 ;           SDARRAY["SDOIEN"]    = Ien of OP Encounter
 ;           SDARRAY["AE"]        = 0 if Originating process is an appointment,
 ;                                  1 if not.
 ;
 N SDOK,NODE0,NODE1
 ;
 K @SDARRAY
 I +$G(SDXMT)=0 D  G DELQ
 . S SDOK=-1
 . I $G(SDARRAY)]"" S @SDARRAY@("ERROR")="NULL XMT POINTER"
 ;
 I +$P($G(^SD(409.73,SDXMT,0)),U,2)>0,$D(^SCE(+$P(^SD(409.73,SDXMT,0),U,2))) D  G DELQ
 . S SDOK=0
 . I $G(SDARRAY)]"" D
 .. K @SDARRAY
 .. S NODE0=$G(^SCE($P(^SD(409.73,SDXMT,0),U,2),0))
 .. S @SDARRAY@("DFN")=$P(NODE0,U,2)
 .. S @SDARRAY@("CLINIC")=$P(NODE0,U,4)
 .. S @SDARRAY@("ENCOUNTER")=$P(NODE0,U)
 .. S @SDARRAY@("SDOIEN")=$P(^SD(409.73,SDXMT,0),U,2)
 .. S @SDARRAY@("AE")=$S($P(NODE0,U,8)=1:0,1:1)
 ;
 I +$P($G(^SD(409.73,SDXMT,0)),U,3)>0,$D(^SD(409.74,+$P(^SD(409.73,SDXMT,0),U,3))) D  G DELQ
 . S SDOK=1
 . I $G(SDARRAY)]"" D
 .. K @SDARRAY
 .. S NODE0=$G(^SD(409.74,$P(^SD(409.73,SDXMT,0),U,3),0))
 .. S NODE1=$G(^SD(409.74,$P(^SD(409.73,SDXMT,0),U,3),1))
 .. S @SDARRAY@("DFN")=$P(NODE0,U,2)
 .. S @SDARRAY@("CLINIC")=$P(NODE1,U,4)
 .. S @SDARRAY@("ENCOUNTER")=$P(NODE1,U)
 .. S @SDARRAY@("DELIEN")=$P(^SD(409.73,SDXMT,0),U,3)
 .. S @SDARRAY@("AE")=$S($P(NODE1,U,8)=1:0,1:1)
 ;
 S SDOK=-1
 I $G(SDARRAY)]"" S @SDARRAY@("ERROR")="No (Deleted) Outpatient Encounter entry found."
DELQ Q SDOK
