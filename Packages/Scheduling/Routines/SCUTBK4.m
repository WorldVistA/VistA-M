SCUTBK4 ;ALB/JLU;BROKER UTILITIES
 ;;5.3;Scheduling;**148,157**;AUG 13, 1993
ACTPOS(RESULTS,SCARY) ;
 ;
 ;This broker entry point returns an array of active positions for a
 ;patient on a specific team.
 ;
 ;INPUTS         SCARY - Contains the following subscripted elements
 ;               DFN - DFN of the patient.
 ;               BEGIN - The beginning date range.
 ;               END - The ending date range.
 ;               TEAM - The team associated with the patient.
 ;
 ;OUTPUTS        RESULTS - The array of active positions.  The following
 ;               is a description of the piece structure.
 ;               PIECE - Description
 ;                 1     IEN of TEAM POSITION FILE(#404.57)
 ;                 2     NAME of Position
 ;                 3     Current effective date
 ;                 4     Pointer to role (403.46)
 ;                 5     Name of Standard role
 ;                 6     Pointer to User Class
 ;                 7     Name of User Class
 ;                 8     IEN of 404.43
 ;
 N SCOK,SCDT,SCDFN,SCTEAM,SCPOS,LP,CNT,SCERR
 ;
 D CHK^SCUTBK
 D TMP^SCUTBK
 ;
 D PARSE(.SCARY) ;parse array for inputs
 K ^TMP($J,"ACTLST")
 ;gets a list o positions for this patient
 S SCOK=$$TPPT^SCAPMC(SCDFN,.SCDT,"","","","","","SCPOS","SCBKERR")
 I 'SCOK G EXIT
 S CNT=1
 ;
 ;loop through positions only getting the ones associated with the team
 ;and that are active.
 ;
 F LP=0:0 S LP=$O(SCPOS(LP)) Q:'LP  DO
 .I $P(SCPOS(LP),U,3)'=SCTEAM Q
 .I $P(SCPOS(LP),U,6)]"" Q
 .S ^TMP($J,"ACTLST",CNT)=$P(SCPOS(LP),U,1)_U_$P(SCPOS(LP),U,2)_U_$P(SCPOS(LP),U,5)_U_$P(SCPOS(LP),U,7)_U_$P(SCPOS(LP),U,8)_U_$P(SCPOS(LP),U,9)_U_$P(SCPOS(LP),U,10)_U_$P(SCPOS(LP),U,4)
 .S CNT=CNT+1
 .Q
 ;
EXIT S RESULTS=$NA(^TMP($J,"ACTLST"))
 Q
 ;
PARSE(ARY) ;parses the input parameters from the broker.
 ;
 S SCDFN=$G(ARY("DFN"))
 S SCDT("BEGIN")=$G(ARY("BEGIN"))
 S SCDT("END")=$G(ARY("END"))
 S SCTEAM=$G(ARY("TEAM"))
 Q
 ;
PARIEN(RESULT) ;returns the ien for 404.91
 ;used by SCMC GET PARAMETER IEN (rpc)
 ;
 N RES
 S RES=$O(^SD(404.91,0))
 S RESULT=$S(RES="":0,1:+RES)
 Q
