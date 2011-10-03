RMPR129P ;VMP/RB - POST INIT FOR PACKAGE FILE (#9.4) UPDATES BY PROSTHETIC BUILDS ;08/22/06
 ;;3.0;Prosthetics;**129**;06/20/05;Build 2
 ;;
 ;Post install to remove erroneous Prosthetics merge nodes set
 ;into the Package file (#9.4) for merging capabilities.  These
 ;nodes were set in by accident as Prosthetics builds being sent to sites
 ;did not have a null response under Install Questions, Edit PACKAGE File
 ;response Select Affects Record Merge.  These bogus Prosthetics entries
 ;to the Package file will be located and deleted at the 20 node level.
 ;The package merge errors occur since the Prosthetics node ^DIC(9.4,D0,20,D1,0)
 ;has routine RMPRPFC in piece 3 for the merge to execute.
SRCH1 N PIEN,MIEN
 S PIEN=0
 F  S PIEN=$O(^DIC(9.4,PIEN)) Q:PIEN=""!(PIEN]"@")  D
 . ;Check for Prosthetics merge entry
 . S PACKR=$G(^DIC(9.4,PIEN,0)) Q:PACKR=""!(PACKR]"@")
 . I PACKR["PROS"!(PACKR["Pros") D
 .. ;KILL PROS ENTRY 20 NODES IF PIECE 3 = 'RMPRPFC'
 .. S MIEN=0
 .. F  S MIEN=$O(^DIC(9.4,PIEN,20,MIEN)) Q:MIEN=""  D
 ... S MERGREC=$G(^DIC(9.4,PIEN,20,MIEN,0)) Q:MERGREC=""
 ... I $P(MERGREC,U,3)="RMPRPFC" D
 .... ;DELETE INVALID MERGE REC WITH ROUTINE NAME 'RMPRPFC'
 .... S DA(1)=PIEN,DIK="^DIC(9.4,"_PIEN_",20,",DA=MIEN D ^DIK K DA,DIK
 K MERGREC,PACKR
SRCH2 ;clean VA(15.2)-XDR MERGE PROCESS FILE for same invalid process
 N PIEN,MIEN
 S PIEN=0
 F  S PIEN=$O(^VA(15.2,PIEN)) Q:PIEN=""!(PIEN]"@")  D
 . ;Check for Prosthetics invalid merge process entry
 . ;KILL PROS INVALID PROS ENTRY IF PIECE 9 = 'RMPRPFC'
 . S MIEN=0
 . F  S MIEN=$O(^VA(15.2,PIEN,3,MIEN)) Q:MIEN=""!(MIEN]"@")  D
 .. S PROCREC=$G(^VA(15.2,PIEN,3,MIEN,0)) Q:PROCREC=""
 .. I $P(PROCREC,U,9)="RMPRPFC" D
 ... ;DELETE INVALID MERGE REC WITH ROUTINE NAME 'RMPRPFC'
 ... S DA(1)=PIEN,DIK="^VA(15.2,"_PIEN_",3,",DA=MIEN D ^DIK K DA,DIK
 K MERGREC,PACKR,PROCREC
 Q
