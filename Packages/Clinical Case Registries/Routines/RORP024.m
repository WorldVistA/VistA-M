RORP024 ;ALB/TK  ENV CK, PRE and POST INSTALL - PATCH 24 ;20 Jun 2014  8:21 AM
 ;;1.5;CLINICAL CASE REGISTRIES;**24**;Feb 17, 2006;Build 15
 ;
 ;*****************************************************************************
 ;*****************************************************************************
 ;                       --- ROUTINE MODIFICATION LOG ---
 ;        
 ;PKG/PATCH    DATE       DEVELOPER    MODIFICATION
 ;-----------  ---------  -----------  ----------------------------------------
 ;ROR*1.5*24   JUN 2014   T KOPP       Added routine for env check, pre/post
 ;                                     install
 ;                                               
 ;******************************************************************************
 ;******************************************************************************
 ; 
 ; SUPPORTED CALLS:
 ;  RTN^%ZTLOAD   #10063
 ;  STAT^%ZTLOAD  #10063
 ;  BMES^XPDUTL   #10141
 ;  MES^XPDUTL    #10141
 ;  BLD^DIALOG    #2050
 ;  UPDATE^DIE    #2053
 ;  FILE^DIE      #2053
 ;  FIND1^DIC     #2051
 ;  CODEABA^CODEX #5747
 ;  OBA^ICDEX     #5747
 ;  FMADD^XLFDT   #10103
 ;  NOW^XLFDT     #10103
 ;
ENV ;  Environment check
 S XPDNOQUE=1 ; disable queuing
 Q
 ;
PRE ; Patch pre-install
 N RC,ZTSK,RORBUF,RORMES
 ; Check for ROR INITIALIZE task running
 D BMES^XPDUTL("   *** Checking to be sure ROR INITIALIZE task is not already running")
 S RC=0
 D RTN^%ZTLOAD("RORSET02","RORBUF")
 S ZTSK="" F  S ZTSK=$O(RORBUF(ZTSK)) Q:ZTSK=""  D  I $G(ZTSK(1))=2 S RC=-1 Q
 . D STAT^%ZTLOAD
 ;--- Display error message if option is running
 I RC<0  D  S XPDABORT=2 Q
 . K RORMES
 . D BMES^XPDUTL($$MSG^RORERR20(RC,,XPDNM))
 . D BMES^XPDUTL("")
 . S RORMES(1)="   >> ROR INITIALIZE task is already running.  Task # is "_ZTSK
 . S RORMES(2)="      This task must complete or be terminated before the install can continue"
 . S RORMES(3)="      Restart this patch install when this task is not running"
 . D MES^XPDUTL(.RORMES)
 . ;
 D BMES^XPDUTL("   *** Verifying VA HEPC registry exists on your system")
 S RORIEN=$$FIND1^DIC(798.1,,"X","VA HEPC",,,"RORZMSG")
 I 'RORIEN D  S XPDABORT=2 Q
 . K RORMES
 . S RORMES(1)="   >> Your VA HEPC registry entry cannot be found"
 . S RORMES(2)="      Please correct the entry in the ROR REGISTRY PARAMETERS file and restart this install"
 . S RORMES(3)="      Install was NOT successful!!!!"
 . D MES^XPDUTL(.RORMES)
 Q
 ;
POST ; Patch post-install
 N CT,RORI,RORREG,REGIEN,Z
 D BMES^XPDUTL("POST INSTALL START")
 ;
 D BMES^XPDUTL(">> Adding new report to the VA HEPC registry parameters")
 D AVRPT
 D BMES^XPDUTL("   >> Step complete")
 ;
 D BMES^XPDUTL(">> Adding new LOINC codes to the VA HEPC and VA HIV registry parameters")
 D LOINC
 D BMES^XPDUTL("   >> Step complete")
 ;
 D BMES^XPDUTL(">> Adding new registry entries to ROR ICD SEARCH with appropriate diagnosis codes")
 D ADDICD
 D BMES^XPDUTL("   >> Step complete")
 ;
 D BMES^XPDUTL(">> Initiating background job to set up registries added with this patch")
 N RORKIDS
 S RORKIDS=1
 F RORI=1:1 S RORREG=$P($P($T(@("REGCODES+"_RORI_"^RORP024")),";;",2),U) Q:RORREG=""  D
 . S REGIEN=$$REGIEN^RORUTL02(RORREG)
 . I REGIEN>0 D
 .. K RORFDA,RORMSG,RORERR,DIERR
 .. S RORFDA(798.1,REGIEN_",",1)=2850101
 .. S RORFDA(798.1,REGIEN_",",21.05)=""
 .. S RORFDA(798.1,REGIEN_",",19.1)=""
 .. D UPDATE^DIE(,"RORFDA",,"RORMSG")
 .. I $G(DIERR) D
 ... D DBS^RORERR("RORMSG",-112,,,798.1,REGIEN)
 ... K RORERR
 ... S RORERR(1)="     New registry "_RORREG_"(ien #"_REGIEN_") encountered the following error"
 ... S RORERR(2)="     and may not initialize correctly.  Please report this error to your CCR contact:"
 ... S RORERR(3)=""
 ... S Z=0,CT=3 F  S Z=$O(RORMSG("DIERR",1,"TEXT",Z)) Q:'Z  S CT=CT+1,RORERR(CT)=$J("",10)_$G(RORMSG("DIERR",1,"TEXT",1))
 ... D MES^XPDUTL(.RORERR)
 D ^RORSET02
 D BMES^XPDUTL("   >> Step complete")
 ;
 D BMES^XPDUTL("POST INSTALL COMPLETE")
 Q
 ;
AVRPT ;  Update available reports in VA HEPC registry
 N RORFDA,RORIEN,RORZMSG,X,Y
 K RORZMSG
 S RORIEN=$$FIND1^DIC(798.1,,"X","VA HEPC",,,"RORZMSG")
 S RORIEN=+RORIEN_","
 S RORFDA(798.1,RORIEN,27)="1,2,3,4,5,6,7,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23"
 K RORZMSG
 I RORIEN>0 D FILE^DIE(,"RORFDA","RORZMSG")
 Q
 ;
LOINC ;Add new LOINC codes to the VA HEPC and VA HIV lab search criterion in
 ;ROR LAB SEARCH file #798.9.  Don't add them if they already exist.  Don't
 ;add the 'dash' or the number following it (checksum)
 ;**********************************************************************
 N I,HEPCIEN,HIVIEN,RORDATA,RORLOINC,RORTAG,ROR K RORMSG1,RORMSG2
 S HIVIEN=$O(^ROR(798.9,"B","VA HIV",0)) ;HIV top level IEN
 S HEPCIEN=$O(^ROR(798.9,"B","VA HEPC",0)) ;HEPC top level IEN
 ;--- add LOINC codes to the VA HIV search criteria
 F I=1:1  S RORTAG="HIV+"_I,ROR=$P($T(@RORTAG),";;",2) Q:ROR=""  D
 . S RORLOINC=$P(ROR,"-",1)
 . ;don't add if it's already in the global
 . Q:($D(^ROR(798.9,HIVIEN,1,"B",RORLOINC)))
 . S RORDATA(1,798.92,"+2,"_HIVIEN_",",.01)=$G(RORLOINC)
 . S RORDATA(1,798.92,"+2,"_HIVIEN_",",1)=6
 . D UPDATE^DIE("","RORDATA(1)",,"RORMSG1")
 K RORDATA(1)
 ;--- add LOINC codes to the VA HEPC search criteria
 F I=1:1:5  S RORTAG="HEP+"_I,ROR=$P($T(@RORTAG),";;",2) Q:ROR=""  D
 . S RORLOINC=$P(ROR,"-",1)
 . ;don't add if it's already in the global
 . Q:($D(^ROR(798.9,HEPCIEN,1,"B",RORLOINC)))
 . S RORDATA(1,798.92,"+2,"_HEPCIEN_",",.01)=$G(RORLOINC)
 . S RORDATA(1,798.92,"+2,"_HEPCIEN_",",1)=6
 . D UPDATE^DIE("","RORDATA(1)",,"RORMSG2")
 K RORDATA,RORMSG1,RORMSG2
 ;
 Q
 ;
 ;**********************************************************************
 ;New LOINC codes
 ;**********************************************************************
HIV ;
 ;;35438-1
 ;;41143-9
 ;;43599-0
 ;;48345-3
 ;;48346-1
 ;;49483-1
 ;;5220-9
 ;;57975-5
 ;;68961-2
 ;;69668-2
 ;;73905-2
 ;;73906-0
 ;;16976-3
 ;;18396-2
 ;;24012-7
 ;;33660-2
 ;;42339-2
 ;;44531-2
 ;;44872-0
 ;;5222-5
 ;;53601-1
 ;;9665-1
 ;;9821-0
 ;;
 ;
HEPC ;
 ;;39008-8
 ;;51657-5
 ;;72376-7
 ;;
 ;
 ; Data set up for REGCODES is 
 ;   ^ piece 1: name of registry
 ;   ^ piece 2: ICD code if ICD-9 or ICD code followed by ~30 if ICD-10.  Multiple codes are separated by comma.
REGCODES ; New registry add ICD9 and ICD10 diagnosis codes with wild card denoted by % to be added to ROR ICD SEARCH file
 ;;VA OSTEOPOROSIS^733.00,733.01,733.02,733.03,733.09,M80.%~30,M81.%~30
 ;;VA ALS^335.20,G12.21~30
 ;;VA HCC^155.0,C22.0~30
 ;;VA LUNG CANCER^162.2,162.3,162.4,162.5,162.8,162.9,231.2,V10.11,C34.%~30
 ;;VA MELANOMA^172.0,172.1,172.2,172.3,172.4,172.5,172.6,172.7,172.8,172.9,C43.%~30
 ;;VA COLORECTAL CANCER^153.0,153.1,153.2,153.3,153.4,153.5,153.6,153.7,153.8,153.9,154.0,154.1,230.3,230.4,V10.05,V10.06,C18.%~30,C19.~30,C20.~30
 ;;VA PANCREATIC CANCER^157.0,157.1,157.2,157.3,157.4,157.8,157.9,C25.%~30
 ;;VA PROSTATE CANCER^185.,233.4,V10.46,C61.~30
 ;;
 ;
ADDICD ; Add registry and specific/wild card-specified ICD codes to the ROR ICD SEARCH file
 N RORX,RORZ
 F RORZ=1:1 S RORX=$P($T(REGCODES+RORZ),";;",2) Q:RORX=""  D
 . N DA,DIC,DIERR,RORREG,RORREG1,RORIEN,RORINFO,RORREGNM,RORLIST,RORCDX,RORICD,RORX1,RORYY,RORWCARD,RORFILE,X,Y
 . S RORREGNM=$P(RORX,U),RORLIST=$P(RORX,U,2)
 . S RORREG1=$$FIND1^DIC(798.1,"","X",RORREGNM)
 . Q:'RORREG1
 . K RORDATA,RORIEN
 . S RORDATA(1,798.5,"?+1,",.01)=RORREG1
 . S RORIEN(1)=RORREG1 ; Make ien the same as file 798.1
 . D UPDATE^DIE("","RORDATA(1)","RORIEN")
 . Q:$G(DIERR)  ; Lookup or addition unsuccessful
 . S RORREG=RORREG1
 . F RORYY=1:1 S RORINFO=$P(RORLIST,",",RORYY),RORCDX=$P($P(RORINFO,"~"),"%"),RORFILE=+$P(RORINFO,"~",2) Q:RORCDX=""  D
 .. S RORX1=RORCDX,RORWCARD=$S(RORINFO["%":1,1:0) S:'RORFILE RORFILE=1
 .. S RORICD=+$$CODEABA^ICDEX(RORX1,"",RORFILE) ; Code lookup in file 80
 .. I RORICD'>0 Q:'RORWCARD  ; Code not found and not a wildcard
 .. I RORICD>0 D FILEICD(RORREG,RORICD) ; Single code or 'base' code of wildcard sequence
 .. Q:'RORWCARD
 .. ; Use wild card to find matching code entries
 .. F  S RORX1=$$OBA^ICDEX(80,RORX1) Q:$S(RORX1="":1,1:$E(RORX1,1,$L(RORCDX))'=RORCDX)  D
 ... S RORICD=+$$CODEABA^ICDEX(RORX1,"",RORFILE)
 ... Q:RORICD'>0
 ... D FILEICD(RORREG,RORICD)
 Q
 ;
 ; RORREG = ien of registry
 ; RORICD = ien of diagnosis code to add to registry
FILEICD(RORREG,RORICD) ; Add ICD code to ROR ICD SEARCH file
 N RORICD1,RORDATA
 ; Don't add if it already exists for the registry
 S RORICD1=$$FIND1^DIC(798.51,","_RORREG_",","Q",RORICD,"B")
 Q:RORICD1'=0  ;quit if code is already assigned to rule 
 K RORDATA
 S RORDATA(1,798.51,"+2,"_RORREG_",",.01)=RORICD
 D UPDATE^DIE("","RORDATA(1)")
 Q
 ;
 ; Sets the DIR array from the post-install question #3 (suspension start time)
POSQ3(DIR) ;
 K:$G(XPDQUES("POSQ2"))'=1 DIR
 Q:'$D(DIR)
 D BLD^DIALOG(7980000.011,,,"DIR(""?"")","S")
 Q
 ;
 ; Sets the DIR array from the post-install question #4  (suspension end time)
POSQ4(DIR) ;
 K:$G(XPDQUES("POSQ2"))'=1 DIR
 Q:'$D(DIR)
 S DIR("A")="Suspension end time"
 ;  Make sure end time entered is later than end time start
 S DIR(0)="D^::R^K:(Y#1)'>(XPDQUES(""POSQ3"")#1) X"
 D BLD^DIALOG(7980000.012,,,"DIR(""?"")","S")
 Q
 ;
 ; Updates the DIR array from the post-install question #5  (schedule time for ROR INITIALIZE task)
POSQ5(DIR) ;
 Q:'$D(DIR)
 N ROREDT
 ; Set earliest date to schedule to 15 minutes from 'NOW'
 S ROREDT=$$FMADD^XLFDT($$NOW^XLFDT(),,,15)
 ; Strip seconds
 S ROREDT=$P(ROREDT,".",1)_"."_$E($P(ROREDT,".",2),1,4)
 ;  Make sure future date/time is entered
 S $P(DIR(0),U,3)=("K:Y<"_ROREDT_" X")
 S DIR("B")=$$FMTE^XLFDT(ROREDT,2)
 Q
 ;
