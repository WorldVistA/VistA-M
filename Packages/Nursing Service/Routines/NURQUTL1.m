NURQUTL1 ;HIRMFO/RM-QI SUMMARY UTILITIES ;1/22/97  15:26
 ;;4.0;NURSING SERVICE;;Apr 25, 1997
NLDEM() ; This function returns the IEN of the Demographic Reference (748.2)
 ; file for the NURS Location (file) entry, or "" if it is not in
 ; the file.
 ;   Function Value = IEN in 748.2 file, or "".
 ;
 N FXN K ^TMP("DILIST",$J)
 D FIND^DIC(748.2,"","","X","NURS LOCATION",1,"B")
 S FXN=$G(^TMP("DILIST",$J,2,1)) K ^TMP("DILIST",$J)
 Q FXN
SURLOC(NURQSURV) ; This function will determine if this survey tracks
 ; response data by NURS Location.
 ;   Input Parameter:  NURQSURV=ptr to 748 (survey) file
 ;   Function Value = IEN in demographic multiple for NURS Location
 ;                       demographic, if responses tracked by NURS Loc.
 ;                    0 Responses not tracked by NURS Location
 ;
 N NURQDEM,NURQFXN,NURQX
 S NURQDEM=$$NLDEM,NURQFXN=0
 K ^TMP($J,"NURQDEM")
 D GETS^DIQ(748,NURQSURV_",","3*","","^TMP($J,""NURQDEM"")")
 S NURQX="" F  S NURQX=$O(^TMP($J,"NURQDEM",748.03,NURQX)) Q:NURQX=""  I $P($G(^TMP($J,"NURQDEM",748.03,NURQX,2)),U)="NURS LOCATION" S NURQFXN=1
 K ^TMP($J,"NURQDEM")
 Q NURQFXN
RESLOC(NURQRESP,NURQDEM) ; This function returns the NURS Location
 ; demographic for a particular set of Response Data.
 ;   Input Parameter: NURQRESP=Ptr to 748.3 (Response Data) file
 ;                    NURQDEM=Ien in Demographic Data Item sub-file
 ;                            of Survey (748) file for the NURS Location
 ;                            demographic.
 ;   Function Value = Ptr to Hospital Location (44) or 0 if this
 ;                    entry was not filled in.
 ;
 N NURQFXN K ^TMP("DILIST",$J)
 D FIND^DIC(748.36,","_NURQRESP_",",1,"X",NURQDEM,1)
 S NURQFXN=$G(^TMP("DILIST",$J,"ID",1,1)) K ^TMP("DILIST",$J)
 Q NURQFXN
 ;
SURGENVR(VRCHK,OPT) ; THIS EXTRINSIC FUNCTION WILL DETERMINE IF THE VERSION
 ; OF THE SURVEY GENERATOR DETERMINED BY VRCHK IS INSTALLED.  IF THE
 ; IT IS NOT INSTALLED, THE FUNCTION RETURNS FALSE (0) AND PRINTS
 ; AN ERROR MESSAGE.  IF IT IS, IT RETURNS TRUE (1).  OPT IS AN OPTIONAL
 ; INPUT THAT WILL HAVE THE ERROR MESSAGE CALL ^DIR TO STOP SCREEN FROM
 ; SCROLLING MESSAGE OFF.
 N FXN,VER S FXN=1,VER=+$$VERSION^XPDUTL("SURVEY GENERATOR")
 I VRCHK=1,VER'=1 S FXN=0
 I VRCHK=2,VER<2 S FXN=0
 I 'FXN W !!,"SURVEY GENERATOR V. "_VRCHK_".0 "_$S(VRCHK=2:"OR GREATER ",1:"")_"IS REQUIRED - CANNOT CONTINUE:" I $G(OPT) S DIR(0)="E" D ^DIR K DIR
 Q FXN
