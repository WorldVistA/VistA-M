SCMCFTEE ;ALB/ART - PCMM Web CRUD for FTEE History ;02/23/2015
 ;;5.3;Scheduling;**603**;Aug 13, 1993;Build 79
 ;
 QUIT
 ;
 ;Public, Supported ICRs
 ; #2051 - Database Server API: Lookup Utilities (DIC) 
 ; #2053 - Data Base Server API: Editing Utilities (DIE)
 ; #2056 - Data Base Server API: Data Retriever Utilities (DIQ)
 ; #10013 - Classic FileMan API: Entry Deletion & File Reindexing (DIK)
 ; #10060 - NEW PERSON FILE
 ; #10103 - Kernel Date functions (XLFDT)
 ;Subscription
 ;
EN ;
 ;
 QUIT
 ;
CREATE(SCRET,SCPHIEN,SCHSTDT,SCVALUE,SCDUZ) ; Create/Add a Position Assignment History FTEE History Record
 ;Inputs: SCRET - return data - passed by reference
 ;        SCPHIEN - Position Assignment History Record IEN
 ;        SCHSTDT - History Date
 ;        SCVALUE - FTEE Value
 ;        SCDUZ - User DUZ
 ;Output: populated SCRET - 
 ;
 IF $GET(SCPHIEN)="" DO  QUIT
 . SET SCRET="0^Missing record IEN"
 ;
 IF $GET(SCHSTDT)="" DO
 . SET SCHSTDT=$$NOW^XLFDT()
 ;
 NEW SCNAME
 SET SCNAME="SCMC,APPLICATION PROXY"
 IF $GET(SCDUZ)="" DO
 . SET SCDUZ=$$FIND1^DIC(200,"","BX",SCNAME,"","","")
 ;
 NEW SCIENS,SCFDA,SCFDAI,SCERR,DIERR
 ;add sub rec
 SET SCIENS="+1,"_SCPHIEN_","
 SET SCFDA(404.521,SCIENS,.01)=$GET(SCHSTDT) ;History Date
 SET SCFDA(404.521,SCIENS,.02)=$GET(SCVALUE) ;FTEE Value
 SET SCFDA(404.521,SCIENS,.03)=$GET(SCDUZ) ;User DUZ
 DO UPDATE^DIE("","SCFDA","SCFDAI","SCERR")
 IF '$DATA(DIERR) DO
 . SET SCRET=SCFDAI(1)
 ELSE  DO
 . SET SCRET="0^Error creating FTEE history record"
 ;
 QUIT
 ;
READ(SCRET,SCPHIEN,SCFTIEN) ; Read a Position Assignment History FTEE History Record
 ;Inputs: SCRET - return data - passed by reference
 ;        SCPHIEN - Position Assignment History Record IEN
 ;        SCFTIEN - FTEE History Sub-Record IEN
 ;Output: populated SCRET - ien^history date^ftee value^user ien(duz)
 ;
 IF $GET(SCPHIEN)="" DO  QUIT
 . SET SCRET="0^Missing record IEN"
 IF $GET(SCFTIEN)="" DO  QUIT
 . SET SCRET="0^Missing FTEE record IEN"
 ;
 NEW SCIENS,SCHSTDT,SCVALUE,SCDUZ
 SET SCIENS=SCFTIEN_","_SCPHIEN_","
 SET SCHSTDT=$$GET1^DIQ(404.521,SCIENS,.01,"I") ;History Date
 SET SCVALUE=$$GET1^DIQ(404.521,SCIENS,.02,"I") ;FTEE Value
 SET SCDUZ=$$GET1^DIQ(404.521,SCIENS,.03,"I") ;User DUZ
 SET SCRET=SCFTIEN_U_SCHSTDT_U_SCVALUE_U_SCDUZ
 ;
 QUIT
 ;
READALL(SCRET,SCPHIEN) ; Read Position Assignment History FTEE History Records
 ;Inputs: SCRET - return data - passed by reference
 ;        SCPHIEN - Position Assignment History Record IEN
 ;Output: populated SCRET - array of: ien^history date^ftee value^user ien(duz)
 ;
 IF $GET(SCPHIEN)="" DO  QUIT
 . SET SCRET(0)="0^Missing record IEN"
 ;
 NEW SCIENS,SCFTIEN,SCHSTDT,SCVALUE,SCDUZ,SCI
 ;
 SET SCI=1
 SET SCFTIEN=0
 FOR  SET SCFTIEN=$ORDER(^SCTM(404.52,SCPHIEN,1,SCFTIEN)) QUIT:+SCFTIEN=0  DO
 . SET SCIENS=SCFTIEN_","_SCPHIEN_","
 . SET SCHSTDT=$$GET1^DIQ(404.521,SCIENS,.01,"I") ;History Date
 . SET SCVALUE=$$GET1^DIQ(404.521,SCIENS,.02,"I") ;FTEE Value
 . SET SCDUZ=$$GET1^DIQ(404.521,SCIENS,.03,"I") ;User DUZ
 . SET SCRET(SCI)=SCFTIEN_U_SCHSTDT_U_SCVALUE_U_SCDUZ
 . SET SCI=SCI+1
 SET SCRET(0)=SCI-1
 ;
 QUIT
 ;
UPDATE(SCRET,SCPHIEN,SCFTIEN,SCHSTDT,SCVALUE,SCDUZ) ; Update a Position Assignment History FTEE History Record
 ;Inputs: SCRET - return data - passed by reference
 ;        SCPHIEN - Position Assignment History Record IEN
 ;        SCFTIEN - FTEE History Sub-Record IEN
 ;        SCHSTDT - History Date
 ;        SCVALUE - FTEE Value
 ;        SCDUZ - User DUZ
 ;Output: populated SCRET - 
 ;
 IF $GET(SCPHIEN)="" DO  QUIT
 . SET SCRET="0^Missing record IEN"
 IF $GET(SCFTIEN)="" DO  QUIT
 . SET SCRET="0^Missing FTEE record IEN"
 ;
 NEW SCIENS,SCFDA,SCERR,SCGO
 SET SCGO=0
 ;
 SET SCIENS=SCFTIEN_","_SCPHIEN_","
 SET SCFDA(404.521,SCIENS,.01)=$GET(SCHSTDT) ;History Date
 SET SCFDA(404.521,SCIENS,.02)=$GET(SCVALUE) ;FTEE Value
 SET SCFDA(404.521,SCIENS,.03)=$GET(SCDUZ) ;User DUZ
 DO FILE^DIE("K","SCFDA","SCERR")
 IF '$DATA(DIERR) DO
 . SET SCRET=1
 ELSE  DO
 . SET SCRET="0^Error updating FTEE history record"
 ;
 QUIT
 ;
DELETE(SCRET,SCPHIEN,SCFTIEN) ; Delete a Position Assignment History FTEE History Record
 ;Inputs: SCRET - return code - passed by reference
 ;        SCPHIEN - Position Assignment History Record IEN
 ;        SCFTIEN - FTEE History Sub-Record IEN
 ;Output: populated SCRET - defaults to 1 (there is no return code from ^DIK)
 ;
 IF $GET(SCPHIEN)="" DO  QUIT
 . SET SCRET="0^Missing record IEN"
 IF $GET(SCFTIEN)="" DO  QUIT
 . SET SCRET="0^Missing FTEE record IEN"
 ;
 NEW DIK,DA
 SET DIK="^SCTM(404.52,"_SCPHIEN_",1,"
 SET DA=SCFTIEN
 SET DA(1)=SCPHIEN
 DO ^DIK
 SET SCRET=1
 QUIT
 ;
