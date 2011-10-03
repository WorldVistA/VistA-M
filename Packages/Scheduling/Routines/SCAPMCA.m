SCAPMCA ;BP-CIOFO/KEITH - API to return all patient assignment information ;7/8/99  18:16
 ;;5.3;Scheduling;**177**;AUG 13, 1993
 ;
GETALL(DFN,SCDT,SCARR) ;Get all assignment information
 ;Input: DFN=patient ifn
 ;Input: SCDT=date range and "include" values (optional) where
 ;       SCDT("BEGIN")=begin date
 ;       SCDT("END")=end date
 ;       SCDT("INCL")='1' for assignments active during entire date
 ;                    range, '0' for assignments active at any time
 ;                    during date range.  
 ;                 ***If undefined, "BEGIN" and "END" = DT, "INCL" = 0
 ;       SCARR=name of array to return data (default ^TMP("SC",$J,...)
 ;
 ;Output: '0' for error, '1' otherwise
 ;Output: array returned in SCARR in hierarchical format (returned only
 ;        if assignments exist)
 ;
 ; @SCARR@(DFN,"TM",a,b)=team data
 ; @SCARR@(DFN,"TM",a,b,"POS",c)=position data
 ; @SCARR@(DFN,"TM",a,b,"POS",c,"PROV",d)=provider data
 ; @SCARR@(DFN,"TM",a,b,"POS",c,"PPOS",e)=preceptor position data
 ; @SCARR@(DFN,"TM",a,b,"POS",c,"PPOS",e,"PPROV",f)=preceptor 
 ;                                                       provider data
 ;
 ; where:  a = TEAM file (#404.51) ifn
 ;         b = PATIENT TEAM ASSIGNMENT file (#404.42) ifn
 ;         c = PATIENT TEAM POSITION ASSIGNMENT file (#404.43) ifn
 ;         d = POSITION ASSIGNMENT HISTORY file (#404.52) ifn
 ;         e = TEAM POSITION file (#404.57) ifn
 ;         f = POSITION ASSIGNMENT HISTORY file (#404.52) ifn
 ;
 ;Output: array returned in SCARR in "flat" format (the zeroeth nodes
 ;        of this array are always returned -- equal to zero if no
 ;        assignments exist.
 ;
 ; @SCARR@(DFN,"NPCPOS",0)=non-PC position count
 ; @SCARR@(DFN,"NPCPOS",n)=non-PC position data
 ; @SCARR@(DFN,"NPCPPOS",0)=non-PC preceptor position count
 ; @SCARR@(DFN,"NPCPPOS",n)=non-PC preceptor position data
 ; @SCARR@(DFN,"NPCPPR",0)=non-PC preceptor provider count
 ; @SCARR@(DFN,"NPCPPR",n)=non-PC preceptor provider data
 ; @SCARR@(DFN,"NPCPR",0)=non-PC provider count
 ; @SCARR@(DFN,"NPCPR",n)=non-PC provider data
 ; @SCARR@(DFN,"NPCTM",0)=non-PC team count
 ; @SCARR@(DFN,"NPCTM",n)=non-PC team data
 ; @SCARR@(DFN,"PCAP",0)=PC associate provider count
 ; @SCARR@(DFN,"PCAP",n)=PC associate provider data
 ; @SCARR@(DFN,"PCPOS",0)=PC position count
 ; @SCARR@(DFN,"PCPOS",n)=PC position data
 ; @SCARR@(DFN,"PCPPOS",0)=PC preceptor position count
 ; @SCARR@(DFN,"PCPPOS",n)=PC preceptor position data
 ; @SCARR@(DFN,"PCPR",0)=PC provider count
 ; @SCARR@(DFN,"PCPR",n)=PC provider data
 ; @SCARR@(DFN,"PCTM",0)=PC team count
 ; @SCARR@(DFN,"PCTM",n)=PC team data
 ;
 ; where:  n = incrementing number 1 to 'n'.
 ;
 ;                 --output array data strings--
 ;
 ; Team information data:
 ;
 ;               Piece     Description
 ;                 1       IEN of TEAM file entry
 ;                 2       Name of team
 ;                 3       IEN of file #404.42 (Pt Tm Assignment)
 ;                 4       current effective date
 ;                 5       current inactivate date (if any)
 ;                 6       pointer to 403.47 (purpose)
 ;                 7       Name of Purpose
 ;                 8       Is this the pt's PC Team?
 ;
 ; Position information data:
 ;
 ;               Piece     Description
 ;                 1       IEN of TEAM POSITION File (#404.57)
 ;                 2       Name of Position
 ;                 3       IEN of Team #404.51
 ;                 4       IEN of file #404.43 (Pt Tm Pos Assign)
 ;                 5       current effective date
 ;                 6       current inactivate date (if any)
 ;                 7       pointer to 403.46 (role)
 ;                 8       Name of Standard Role
 ;                 9       pointer to User Class (#8930)
 ;                10       Name of User Class
 ;                11       Pointer to patient team assignment (404.42) 
 ;
 ; Provider information data:
 ;
 ;               Piece     Description
 ;                 1       IEN of NEW PERSON file entry (#200)
 ;                 2       Name of person
 ;                 3       IEN of TEAM POSITION file (#404.57)
 ;                 4       Name of Position
 ;                 5       IEN OF USR CLASS(#8930) of POSITION(#404.57)
 ;                 6       USR Class Name
 ;                 7       IEN of STANDARD POSITION (#403.46)
 ;                 8       Standard Role (Position) Name
 ;                 9       Activation Date for 404.52 (not 404.59!)
 ;                10       Inactivation Date for 404.52
 ;                11       IEN of Position Ass History (404.52)
 ;                12       IEN of Preceptor Position
 ;                13       Name of Preceptor Position
 ;
 ;  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 ;
SETUP N SCI,SCX,SCRATCH1,SCADT,SCIDT,SCII,SCIII,SCPAH,SCPCPOSF,SCPCTF
 N SCPOS,SCPOSD,SCPOSPRC,SCPPOS,SCPPOS0,SCPPOSD,SCPPROVD,SCPRD
 N SCPROVD,SCPTA,SCPTPA,SCRATCH2,SCSUB,SCTM,SCTMD,SCPOSPDT,SCPTPA0
 Q:'$D(^DPT(DFN,0)) 0
 I '$D(SCDT("BEGIN")),$D(SCDT("END")) S SCDT("BEGIN")=SCDT("END")
 I '$D(SCDT("END")),$D(SCDT("BEGIN")) S SCDT("END")=SCDT("BEGIN")
 I '$D(SCDT("BEGIN"))&'$D(SCDT("END")) S (SCDT("BEGIN"),SCDT("END"))=DT
 S SCX=SCDT("BEGIN") I SCX>SCDT("END") S SCDT("BEGIN")=SCDT("END"),SCDT("END")=SCX
 S SCDT="SCDT"
 I $L($G(SCDT("INCL")))'=1!("01"'[$G(SCDT("INCL"))) S SCDT("INCL")=0
 I '$L($G(SCARR)) S SCARR="^TMP(""SC"",$J)" K @SCARR@(DFN)
 S SCX="NPCPOS^NPCPPOS^NPCPPR^NPCPR^NPCTM^PCAP^PCPOS^PCPPOS^PCPR^PCTM"
 F SCI=1:1:10 S @SCARR@(DFN,$P(SCX,U,SCI),0)=0  ;initialize flat array
 S SCRATCH1="^TMP(""SCRATCH1"",$J)" K @SCRATCH1
 S SCRATCH2="^TMP(""SCRATCH2"",$J)" K @SCRATCH2
 D GETDAT^SCAPMCA1
 K ^TMP("SCRATCH1",$J),^TMP("SCRATCH2",$J)
 Q 1
