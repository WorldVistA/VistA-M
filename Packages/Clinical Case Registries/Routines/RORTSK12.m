RORTSK12 ;HCIOFO/SG - REPORT STATS UTILITIES ; 7/15/05 12:00pm
 ;;1.5;CLINICAL CASE REGISTRIES;;Feb 17, 2006
 ;
 Q
 ;
 ;***** CLEARS THE STATISTICS
 ;
 ; REGIEN        Registry IEN
 ;
 ; [RPTCODE]     Report Code. By default ($G(RPTCODE)'>0),
 ;               all statistic data is deleted.
 ;
CLEAR(REGIEN,RPTCODE) ;
 N DA,DIK,IENS,NODE,RPIEN
 S DA(1)=+REGIEN,IENS=","_DA(1)_","
 S DIK=$$ROOT^DILFD(798.12,IENS)
 S NODE=$$CREF^DILF(DIK)
 ;
 ;--- Clear the report stats
 I $G(RPTCODE)>0  D  Q
 . S RPIEN=$$RPIEN^RORUTL08(RPTCODE)  Q:RPIEN'>0
 . L +@NODE@(RPTCODE):5
 . S DA=$$FIND1^DIC(798.12,IENS,"QX",RPIEN,"B",,"RORMSG")
 . D:DA>0 ^DIK
 . L -@NODE@(RPTCODE)
 ;
 ;--- Clear all stats
 L +@NODE:5
 S DA=0  F  S DA=$O(@NODE@(DA))  Q:DA'>0  D ^DIK
 L -@NODE
 Q
 ;
 ;***** INCREMENT THE NUMBER OF REPORT RUNS
 ;
 ; REGIEN        Registry IEN
 ;
 ; RPTCODE       Report Code
 ;
 ; [VAL]         Increment value. By default ($G(VAL)'>0),
 ;               the counter is incremented by 1.
 ;
INC(REGIEN,RPTCODE,VAL) ;
 N IEN,IENS,NODE,RORBUF,RORFDA,RORMSG,RPIEN,TMP
 S:$G(VAL)'>0 VAL=1
 ;
 ;--- Get IEN of the report parameters
 S RPIEN=$$RPIEN^RORUTL08(RPTCODE)  Q:RPIEN'>0
 ;
 ;--- Lock the report stats
 S IENS=","_(+REGIEN)_","
 S NODE=$$ROOT^DILFD(798.12,IENS,1)
 L +@NODE@(RPTCODE):5
 D
 . ;--- Find and load the report stats
 . S TMP="@;.02"
 . D FIND^DIC(798.12,IENS,TMP,"QX",RPIEN,2,"B",,,"RORBUF","RORMSG")
 . D:$G(DIERR) DBS^RORERR("RORMSG",-9,,,798.12,IENS)
 . Q:$G(RORBUF("DILIST",0))>1
 . S IEN=+$G(RORBUF("DILIST",2,1))
 . ;--- Increment the counter
 . S IENS=$S(IEN>0:IEN,1:"?+1")_","_(+REGIEN)_","
 . S RORFDA(798.12,IENS,.01)=RPIEN
 . S RORFDA(798.12,IENS,.02)=$G(RORBUF("DILIST","ID",1,.02))+VAL
 . D UPDATE^DIE(,"RORFDA",,"RORMSG")
 . D:$G(DIERR) DBS^RORERR("RORMSG",-9,,,798.12,IENS)
 ;
 ;--- Unlock the report stats
 L -@NODE@(RPTCODE)
 Q
 ;
 ;***** RETURNS THE REPORT RUN STATISTICS
 ;
 ; REGIEN        Registry IEN
 ;
 ; .STATS        Reference to a local array where the statistics
 ;               (collected since the last successful data
 ;               transmission) will be returned to.
 ;
 ;  STATS(       Report Statistics Summary
 ;                 ^01: Total number of report runs
 ;    RptCode)   Report run statistics
 ;                 ^01: Number of report runs
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;
STATS(REGIEN,STATS) ;
 N IR,RORBUF,RORMSG,RPTCODE,TMP
 K STATS  S STATS="0"
 ;--- Load the statistics
 S TMP=","_(+REGIEN)_","
 D LIST^DIC(798.12,TMP,".01I;.02","Q",,,,"B",,,"RORBUF","RORMSG")
 Q:$G(DIERR) $$DBS^RORERR("RORMSG",-9,,,798.12,TMP)
 ;--- Process the statistics
 S IR=0
 F  S IR=$O(RORBUF("DILIST","ID",IR))  Q:IR'>0  D
 . ;--- Get the IEN of the report parameters
 . S TMP=+$G(RORBUF("DILIST","ID",IR,.01))  Q:TMP'>0
 . ;--- Get the report code
 . S RPTCODE=$$RPCODE^RORUTL08(TMP)  Q:RPTCODE'>0
 . ;--- Get the report statistics
 . S TMP=+$G(RORBUF("DILIST","ID",IR,.02))
 . S $P(STATS(RPTCODE),U)=TMP
 . S $P(STATS,U)=$P(STATS,U)+TMP
 ;---
 Q 0
