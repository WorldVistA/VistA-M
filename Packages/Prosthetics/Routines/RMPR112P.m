RMPR112P ;VMP/RB - POST INIT FOR PACKAGE FILE (#9.4) UPDATES BY PROSTHETIC BUILDS ;06/17/05
 ;;3.0;Prosthetics;**112**;06/20/05
 ;;
 ;** Cameron Schlehuber created IA 4691 for a single use, private IA with Kernel (
 ;   the custodian of the Package file)
 ;Post install to remove erroneous Prosthetics merge nodes set
 ;into the Package file (#9.4) for merging capabilities.  These
 ;nodes were set in by accident as Prosthetics builds being sent to sites
 ;did not have a null response under Install Questions, Edit PACKAGE File
 ;response Select Affects Record Merge.  These bogus Prosthetics entries
 ;to the Package file will be located and deleted at the 20 node level.
 ;The package merge errors occur since the Prosthetics node ^DIC(9.4,D0,20,D1,0)
 ;has no routine in piece 3 for the merge to execute.
SRCH N PIEN,MIEN
 S PIEN=0
 F  S PIEN=$O(^DIC(9.4,PIEN)) Q:PIEN=""!(PIEN>9999999)  D
 . ;Check for Prosthetics merge entry
 . S PACKR=$G(^DIC(9.4,PIEN,0)) Q:PACKR=""!(PACKR>99999)
 . I PACKR["PROS"!(PACKR["Pros") D
 .. ;KILL PROS ENTRY 20 NODES IF PIECE 3 EMPTY
 .. S MIEN=0
 .. F  S MIEN=$O(^DIC(9.4,PIEN,20,MIEN)) Q:MIEN=""  D
 ... S MERGREC=$G(^DIC(9.4,PIEN,20,MIEN,0)) Q:MERGREC=""
 ... I $P(MERGREC,U,3)="" D
 .... ;DELETE INVALID MERGE REC WITH NO ROUTINE NAME
 .... S DA(1)=PIEN,DIK="^DIC(9.4,"_PIEN_",20,",DA=MIEN D ^DIK K DA,DIK
 K MERGREC,PACKR
 Q
