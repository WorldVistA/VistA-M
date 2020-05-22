RORP035A ;HIOFO/FT - CCR PRE/POST-INSTALL PATCH 35 (cont.) ;9/16/2019
 ;;1.5;CLINICAL CASE REGISTRIES;**35**;Feb 17, 2006;Build 7
 ;
 ;*****************************************************************************
 ;*****************************************************************************
 ;                       --- ROUTINE MODIFICATION LOG ---
 ;  
 ;PKG/PATCH    DATE       DEVELOPER    MODIFICATION
 ;-----------  ---------  -----------  ----------------------------------------
 ;ROR*1.5*35   Nov 2019   F TRAXLER    Part of post-install process to change
 ;                                     "Pending" status to "Confirmed. Called
 ;                                     from RORP035.
 ;******************************************************************************
 ;******************************************************************************
 ;
 ; SUPPORTED CALLS:
 ;  FMADD^XLFDT   #10103
 ;  BMES^XPDUTL   #10141
 ;  MES^XPDUTL    #10141
 ;        
 Q
 ;
FINDPEND ;Find 'Pending' patients in 'VA HEPC' and 'VA HIV' registries
 N RORIEN,RORHEPCIEN,RORHIVIEN,RORREGISTRY,RORSTATUS
 S RORHEPCIEN=$O(^ROR(798.1,"B","VA HEPC",0))
 S RORHIVIEN=$O(^ROR(798.1,"B","VA HIV",0))
 I 'RORHEPCIEN D BMES^XPDUTL("Cannot find HEP C registry.") Q
 I 'RORHIVIEN D BMES^XPDUTL("Cannot find HIV registry.") Q
 S ^XTMP("ROR PENDING RECORDS",0)=$$FMADD^XLFDT(DT,60)_U_DT_U_"ROR*1.5*35: File 798 records before resetting Pending to Confirmed"
 F RORREGISTRY=RORHEPCIEN,RORHIVIEN D
 .D ACONFIRM(RORREGISTRY,1) ;set auto-confirm to 'Yes'
 .S RORIEN=0
 .F  S RORIEN=$O(^RORDATA(798,"AC",RORREGISTRY,RORIEN)) Q:'RORIEN  D
 ..Q:$P($G(^RORDATA(798,RORIEN,0)),U,5)'=4  ;we want PENDING only
 ..S ^XTMP("ROR PENDING RECORDS",RORIEN)=$G(^RORDATA(798,RORIEN,0))
 ..S ^XTMP("ROR PENDING RECORDS",RORIEN,"COMMENT")=$G(^RORDATA(798,RORIEN,3))
 ..S RORSTATUS=$$P2C(RORIEN)
 ..I +RORSTATUS<0 D BMES^XPDUTL(RORSTATUS)
 Q
P2C(RORDA) ;change patient status (file 798, field 3) 
 ;from 'Pending' (4) to 'Confirmed' (0)
 ;Also, remove any 'Pending' comment (file 798, field 12) value
 ;  Input: RORDA = FILE 798 ien
 ; Output: flag^message
 ;  where:   -n^error message text
 ;            1^success
 N RORFDA,RORFLAG,RORMSG
 S RORDA=+$G(RORDA),RORFLAG="1^Success"
 I '$D(^RORDATA(798,RORDA,0)) S RORFLAG="-1^RORDATA(798,"_RORDA_",0) not defined" Q RORFLAG
 S RORFDA(798,RORDA_",",3)=0 ;status=confirmed
 S RORFDA(798,RORDA_",",12)="@" ;remove pending comment
 D FILE^DIE(,"RORFDA","RORMSG")
 I $D(RORMSG) S RORFLAG="-"_RORDA_U_RORMSG("DIERR",1,"TEXT",1)
 Q RORFLAG
 ;
C2P ;restore status from 'confirmed' to 'pending' and reset pending patient comment field.
 N RORDA,RORFDA,RORMSG
 S RORDA=0
 F  S RORDA=$O(^XTMP("ROR PENDING RECORDS",RORDA)) Q:'RORDA  D
 .S RORFDA(798,RORDA_",",2)="@" ;date confirmed
 .S RORFDA(798,RORDA_",",2.1)="@" ;confirmed by
 .S RORFDA(798,RORDA_",",3)=4 ;status=Pending
 .S RORFDA(798,RORDA_",",12)=$G(^XTMP("ROR PENDING RECORDS",RORDA,"COMMENT")) ;pending patient comment
 .D FILE^DIE(,"RORFDA","RORMSG")
 .I $D(RORMSG) W !,RORDA_U_RORMSG("DIERR",1,"TEXT",1)
 Q
ACONFIRM(RORDA,RORVALUE) ;set FILE 798.1, field #31 (AUTO-CONFIRM)
 N RORFDA,RORMSG
 S RORFDA(798.1,RORDA_",",31)=RORVALUE ;0=No, 1=Yes, @=delete existing value (i.e., null)
 D FILE^DIE(,"RORFDA","RORMSG")
 Q
