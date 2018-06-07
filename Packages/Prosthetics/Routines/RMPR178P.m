RMPR178P ;CEP-JAH/OIFO - PATCH 178 POST INSTALLATION ;02/26/16
 ;;3.0;Prosthetics;**178**;13/27/08;Build 14
 ;;
 Q
EN ;
    D MSG("Starting Post Install")  ;TODO: IS THIS NEEDED?
    D MSG("Checking for existance of PRGIP Site Parameter")
    I '$$FIND1^DIC(8989.51,"","","PRGIP","","","RMPRERR") D  Q
    .  D MSG("PRGIP Site Parameter does not exist - Good To Go!")
    D MSG("Removing PRGIP Site Parameter")
    D XPARDEL("PRGIP",0)
    Q
    ;
MSG(TEXT) ; [Procedure] Display message to user
    ; Input parameters
    ;  1. TEXT [Literal/Required] Text to display to the user
    ;
    D BMES^XPDUTL(" "_TEXT_"...")
    Q ""
    ;
XPARDEL(RMPRPAR,VALUES) ; [Procedure] Remove a parameter for XPAR
    ; VALUES determines the mode of deletion.
    ; 0: Will delete *BOTH* the values and the parameter definition (DEFAULT)
    ; 1: Will only delete the values of the parameter
    ;
    ; Input parameters
    ;  1. RMPRPAR [Literal/Required] Name of the parameter definition
    ;  2. VALUES [Literal/] Values Only 0/1
    ;
    ; Variables:
    ;  DA: [Private] Fileman variable
    ;  DIK: [Private] Fileman variable
    ;  RMPRENT: [Private] Parameter entity
    NEW DA,DIK,RMPRENT,RMPRERR
    S VALUES=$G(VALUES,0)
    K ^TMP("RMPRPOST",$J)
    D ENVAL^XPAR($NA(^TMP("RMPRPOST",$J)),RMPRPAR,"","",1)
    S RMPRENT=""  F  S RMPRENT=$O(^TMP("RMPRPOST",$J,RMPRENT)) Q:RMPRENT=""  D
    .  D NDEL^XPAR(RMPRENT,RMPRPAR,.RMPRERR)
    .  I +$G(RMPRERR) D
    ..   D MSG(RMPRPAR_":  "_RMPRERR)
    .  E  D
    ..   D MSG(RMPRPAR_" Site Parameter Value was deleted")
    Q:VALUES
    S DA=$$FIND1^DIC(8989.51,"","",RMPRPAR,"B")
    I DA'>0 D MSG(RMPRPAR_" Site Parameter Definition was not found") Q
    S DIK="^XTV(8989.51," D ^DIK
    D MSG(RMPRPAR_" Site Parameter Definition was deleted")
    Q
    ;
    ;ALL BELOW FOR TESTING PURPOSES ONLY
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
PRGIPDEF ;ADDS PRGIP PARAMETER DEFINITION
    ;FOR TESTING PURPOSES ONLY
    ;SOME SITES ADDED PRGIP SITE PARAMETER THAT NOW NEEDS TO BE DELETED
    ;THIS FUNCTION CREATES THE SITE PARAMETER TO FACILITATE TESTING ITS DELETION
    ;;;;;;;;;;
    I $$FIND1^DIC(8989.51,"","","PRGIP","","","RMPRERR") D  Q
    .  D MSG("PARAMETER VALUE ALREADY EXISTED")
    N RMPR,RMPRIEN,RMPRMSG
    S RMPR(8989.51,"+1,",.01)="PRGIP"
    S RMPR(8989.51,"+1,",.02)="Prosthetics GIP IN USE SITE PARAMETER"
    S RMPR(8989.51,"+1,",.03)=0
    S RMPR(8989.51,"+1,",.06)=0
    S RMPR(8989.51,"+1,",1.1)="Y"
    D UPDATE^DIE("","RMPR","RMPRIEN","RMPRMSG")
    D MSG($G(RMPRMSG))
    Q
SETPAR(PAR,INS,VAL,ERR) ; [Procedure] Set value into XPAR parameter
    ; Input parameters
    ; NOT PART OF P178 BUT INCLUDED FOR TESTING PURPOSES FOR ADDING "PRGIP" SITE PARAM
    ;  1. PAR [Literal/Required] Parameter
    ;  2. INS [Literal/Required] Instance
    ;  3. VAL [Literal/Required] New value
    ;  4. ERR (CALL BY REF) ERROR ARRAY
    ;
    D EN^XPAR("SYS",PAR,INS,VAL,.ERR)
    Q
    ;
