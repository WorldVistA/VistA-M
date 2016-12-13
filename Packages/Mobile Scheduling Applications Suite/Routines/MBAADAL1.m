MBAADAL1 ;OIT-PD/CBR - CONSULT DAL ;02/10/2016
 ;;1.0;Scheduling Calendar View;**1**;Aug 27, 2014;Build 85
 ;Associated ICRs
 ;  ICR#
 ;  6052 GMR(123
 ;
 ;code below is not being used in the initial release of MBAA. It will be released at a later date in a future release of MBAA
 ;GETCONSR(RETURN,DFN,FLDS) ; Get consult requests
 ; N FILE,FIELDS,RET,SCR,LST,SFLS,DL,IN
 ; S FILE=123,FIELDS=".01IE;.02IE;.04IE;.1;8IE;1IE"
 ; S SCR="I $P(^(0),U,2)=$G(DFN)"
 ; D LIST^DIC(FILE,"",FIELDS,"",,,,"F",.SCR,"","LST","ERR")
 ; S IN="",DL="DILIST"
 ; S SFLS("40")="",SFLS("40","N")="COMM",SFLS("40","F")="123.02"
 ; F  S IN=$O(LST(DL,2,IN)) Q:IN=""  D
 ; . N CR
 ; . D GETREC^MBAAMDAL(.CR,LST(DL,2,IN),123,.FLDS,.SFLS,1,1)
 ; . M RETURN(LST(DL,2,IN))=CR
 ; Q
 ;
 ;GETRQSV(RETURN,STPCOD,SRV) ; Get request service
 ; N SCR,ERR
 ; S SCR="I $D(^GMR(123.5,""AB1"","_STPCOD_","_SRV_"))"
 ; D LIST^DIC(123.5,"","","",,,,"AB1",.SCR,"","RETURN","ERR")
 ; Q
 ; ;
 ;GETRQSV1(RETURN,SRV,FLDS,FLAG) ; Get request service by IFN
 ; N DA,DIQ,DIC,DR,GMR
 ; S DIQ="GMR(",DIC="^GMR(123.5,",DIQ(0)=$G(FLAG)
 ; S DA=SRV,DR=FLDS
 ; D EN^DIQ1
 ; M RETURN=GMR(123.5,SRV)
 ; Q
 ;
GETCONS(RETURN,CONS,FLAG) ; Get consult Called by RPC MBAA APPOINTMENT MAKE, MBAA RPC: MBAA CANCEL APPOINTMENT
 N DA,DIQ,DIC,DR,GMR
 S DIQ="GMR(",DIC="^GMR(123,",DIQ(0)=$G(FLAG)  ;ICR#: 6052 GMR(123
 S DA=CONS,DR=".001:70"
 D EN^DIQ1
 M RETURN=GMR(123,CONS)
 Q
 ;code below is not being used in the initial release of MBAA. It will be released at a later date in a future release of MBAA
 ;CONSLNKD(CONS) ; Return 1 if consult is already linked
 ; Q:'$D(CONS) 0
 ; Q $D(^SC("AWAS1",CONS))
 ; ;
