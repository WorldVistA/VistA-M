RORUTL11 ;HCIOFO/SG - ACCESS AND SECURITY UTILITIES ; 03 Dec 2015  1:56 PM
 ;;1.5;CLINICAL CASE REGISTRIES;**13,14,15,17,18,20,19,21,22,24,27,25,26,28,29,30,31,32**;Feb 17, 2006;Build 20
 ;
 ;******************************************************************************
 ;******************************************************************************
 ;                 --- ROUTINE MODIFICATION LOG ---
 ;        
 ;PKG/PATCH    DATE        DEVELOPER    MODIFICATION
 ;-----------  ----------  -----------  ----------------------------------------
 ;ROR*1.5*13   DEC  2010   A SAUNDERS   Added tag VERSRV to return an associated
 ;                                      version to the GUI during RPC call ROR
 ;                                      GET M VERSION
 ;ROR*1.5*14   APR  2011   A SAUNDERS   Updated version in tag VERSRV
 ;ROR*1.5*15   JUN 2011    C RAY        Updated version
 ;ROR*1.5*17   DEC 2011    C RAY        Updated version 
 ;ROR*1.5*18   MAY 2012    C RAY        Updated version 
 ;ROR*1.5*20   DEC 2012    C RAY        Updated version
 ;ROR*1.5*19   APR 2012    K GUPTA      Updated version                            
 ;ROR*1.5*21   AUG 2013    T KOPP       Updated version
 ;ROR*1.5*22   FEB 2014    T KOPP       Updated version 
 ;ROR*1.5*24   DEC 2014    T KOPP       Updated version
 ;ROR*1.5*27   FEB 2015    T KOPP       Updated version
 ;ROR*1.5*25   MAR 2015    T KOPP       Updated version                  
 ;ROR*1.5*26   MAY 2015    T KOPP       Updated version
 ;ROR*1.5*28   APR 2016    T KOPP       Updated version
 ;ROR*1.5*29   AUG 2016    T KOPP       Updated version
 ;ROR*1.5*30   MAR 2017    M FERRARESE  Updated version
 ;ROR*1.5*31   JUL 2017    S ALSAHHAR   Updated version
 ;ROR*1.5*32   JUL 2017    S ALSAHHAR   Updated version
 ;******************************************************************************
 ; This routine uses the following IAs:
 ;
 ; #2055   $$ROOT^DILFD (supported)
 ; #10013  ENALL^DIK (supported)
 ;         
 ;******************************************************************************
 Q
 ;
 ;***** REBUILDS THE "ACL" CROSS-REFERENCE (USER ACCESS)
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;
RNDXACL() ;
 N DA,DIK,REGIEN,ROOT
 S ROOT=$$ROOT^DILFD(798.1,,1)  K @ROOT@("ACL")
 S REGIEN=0
 F  S REGIEN=$O(@ROOT@(REGIEN))  Q:'REGIEN  D
 . S DIK=$$ROOT^DILFD(798.118,","_REGIEN_","),DIK(1)=".01^ACL"
 . S DA(1)=REGIEN  D ENALL^DIK
 Q 0
 ;
 ;***** CHECKS IF THE RPC CAN BE CALLED BY THE CURRENT USER
 ;
 ; RPCNAME       Name of the RPC
 ;
 ; [REGIEN]      Registry IEN
 ;
 ; [FLAGS]       Flags that control the execution (can be combined):
 ;                 A  Administrator Only
 ;                 I  IRM Only
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;       >0  Access denied
 ;
RPCHECK(RPCNAME,REGIEN,FLAGS) ;
 N ACCESS,KEY,RC
 Q:$G(DUZ)'>0 $$ERROR^RORERR(-40,,,,"DUZ")
 S FLAGS=$G(FLAGS),REGIEN=+$G(REGIEN)
 ;---
 S (ACCESS,RC)=0
 D  Q:ACCESS 0
 . I REGIEN  Q:$D(^ROR(798.1,"ACL",DUZ,REGIEN))<10
 . E  Q:$D(^ROR(798.1,"ACL",DUZ))<10
 . I FLAGS["I"  Q:'$D(^XUSEC("ROR VA IRM",DUZ))
 . I FLAGS["A"  S RC=1,KEY=""  D  Q:RC
 . . F  S KEY=$O(^ROR(798.1,"ACL",DUZ,REGIEN,KEY))  Q:KEY=""  D  Q:'RC
 . . . I KEY?1"ROR"1.E  S:KEY["ADMIN" RC=0
 . S ACCESS=1
 ;---
 D ACVIOLTN^RORLOG(-91,$G(REGIEN),RPCNAME)
 Q 1
 ;
 ;***** RETURNS SERVER VERSION
 ;REMOTE PROCEDURE: ROR GET M VERSION
 ;
 ;The purpose of this RPC is to catch when the GUI executable has been
 ;upgraded AND REQUIRES an associated M patch, but the M patch has not
 ;been installed yet.
 ;
 ; VAL n.n.n represents the CCR package version and the m patch number that
 ; contains the associated M changes that the GUI is expecting.
 ;
 ;NOTE TO CCR MAINTENANCE TEAM: For M changes made by the maintenance team,
 ;the server version below should not be modified.  The only time the server
 ;version should be modified is if the GUI was changed AND there were
 ;associated M changes needed for it.
 ;
VERSRV(VAL) ;
 S VAL="1.5.32"
 Q
