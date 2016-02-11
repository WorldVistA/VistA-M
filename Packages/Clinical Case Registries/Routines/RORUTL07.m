RORUTL07 ;HCIOFO/SG - TEST ENTRY POINTS ; 26 May 2015  3:44 PM
 ;;1.5;CLINICAL CASE REGISTRIES;**21,26**;Feb 17, 2006;Build 53
 ;
 Q
 ;******************************************************************************
 ;******************************************************************************
 ;                       --- ROUTINE MODIFICATION LOG ---
 ;        
 ;PKG/PATCH    DATE        DEVELOPER    MODIFICATION
 ;-----------  ----------  -----------  ----------------------------------------
 ;ROR*1.5*26   APR  2015   T KOPP       UPDATE updated to ask for start date
 ;                                      and set IO variable 
 ;
 ;******************************************************************************
 ;******************************************************************************
 ;
 ;***** DISPLAYS THE ERRORS
ERROR ;
 D DSPSTK^RORERR()
 Q
 ;
 ;***** DATA EXTRACTION TEST ENTRY POINT
EXTRACT ;
 N RORERRDL      ; Default error location
 N RORERROR      ; Error processing data
 N RORPARM       ; Application parameters
 ;
 N RC,REGLST,REGNAME,SDT
 W !,"DATA EXTRACTION & TRANSMISSION IN DEBUG MODE",!
 D KILL^XUSCLEAN
 S RORPARM("DEBUG")=2
 S RORPARM("ERR")=1
 D CLEAR^RORERR("EXTRACT^RORUTL07")
 ;--- Select registries
 Q:$$SELREG(.REGLST)'>0
 ;--- Request a start date
 S SDT=$$GETSDT()                            G:SDT<0 ERROR
 ;--- Extract the registry data
 S RC=$$EXTRACT^ROREXT(.REGLST,SDT,,"S")  G:RC<0 ERROR
 Q
 ;
 ;***** REQESTS A START DATE FROM A USER
 ;
 ; Return Values:
 ;       <0  Error Code
 ;       ""  No start date (default)
 ;       >0  Start date
 ;
GETSDT() ;
 ;;If you enter an empty string then the individual start date
 ;;(from the registry record) will be used for each patient.
 ;
 N DA,DIR,DIROUT,DIRUT,DTOUT,DUOUT,RC,X,Y
 S DIR(0)="DO^:DT:EX"
 S DIR("A")="Start date for data extraction"
 F X=1:1  S Y=$P($T(GETSDT+X),";;",2)  Q:Y=""  S DIR("?",X)=Y
 S DIR("?")="This response must be a date."
 D ^DIR
 S RC=$S($D(DTOUT):-72,$D(DUOUT):-71,1:0)
 Q $S(RC<0:RC,1:$G(Y))
 ;
 ;***** SELECTS REGISTRIES FROM THE FILE #798.1
 ;
 ; .REGLST       Reference to a local variable for the list of
 ;               registry names (subscripts) and IENs (values)
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Nothing selected
 ;       >0  Number of selected registries
 ;       ""  Timeout or "^"
 ;
SELREG(REGLST) ;
 N CNT,DA,DIC,DLAYGO,DTOUT,DUOUT,X,Y
 K REGLST  S CNT=0
 ;--- Select a registry
 S DIC=798.1,DIC(0)="AENQ"
 S DIC("A")="Select a Registry: "
 F  D  Q:Y'>0  S REGLST($P(Y,U,2))=+Y,CNT=CNT+1
 . D ^DIC
 W !
 Q $S($D(DTOUT)!$D(DUOUT):"",1:CNT)
 ;
 ;***** REGISTRY UPDATE TEST ENTRY POINT
UPDATE ;
 N RORERRDL      ; Default error location
 N RORERROR      ; Error processing data
 N RORPARM       ; Application parameters
 ;
 N RC,REGLST,REGNAME,DSBEG
 D HOME^%ZIS
 W !,"REGISTRY UPDATE IN DEBUG MODE",!
 D KILL^XUSCLEAN
 S RORPARM("DEBUG")=2
 S RORPARM("ERR")=1
 D CLEAR^RORERR("UPDATE^RORUTL07")
 ;--- Select registries
 Q:$$SELREG(.REGLST)'>0
 ;--- Request a start date
 S DSBEG=$$GETSDT()
 Q:DSBEG<0
 ;--- Update the registry
 S RC=$$UPDATE^RORUPD(.REGLST)  G:RC<0 ERROR
 Q
  ;DEFINE ENTRY POINT TO CLEAR AND RESTART REGISTRY UPDATE
DEL(REGLST) ;
 ;Select new registry to delete
 ;delete any records in 798 for that registry
 ;delete enable protocols,hdt,registry updated until
 N REGNAME,REGIEN,IEN,DA,DIK,RORFDA,IENS,RORMSG,DIERR
 N FILE,ROOT,IX,RORPARM,FLD
 S (REGNAME,IEN)=""
 S RORPARM("DEVELOPER")=1
 F  S REGNAME=$O(REGLST(REGNAME)) Q:REGNAME=""  D
 . S REGIEN=$$REGIEN^RORUTL02(REGNAME) Q:REGIEN=""
 . ; Only local registries
 . Q:$P($G(^ROR(798.1,REGIEN,0)),U,11)
 . S IENS=REGIEN_","
 . F FLD=6.1,6.2,7,10,13,13.1,19.1,19.2,19.3,21.01,21.04,21.05 D
 . . S RORFDA(798.1,IENS,FLD)="@"
 . S RORFDA(798.1,IENS,1)=2850101
 . D FILE^DIE(,"RORFDA","RORMSG")
 . I $G(DIERR) W !!,"<<ERROR - restoring "_REGNAME_" registry parameters>>" Q
 . F  S IEN=$O(^RORDATA(798,"AC",REGIEN,IEN)) Q:IEN=""  D
 . . N DA,DIK
 . . S DIK=$$ROOT^DILFD(798),DA=IEN  D ^DIK
 . . W !,"<< "_IEN_" >> Deleted"
 Q
 ;
