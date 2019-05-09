MPIFNAMC ;OAKLAND OIFO/MKO-NAME COMPONENTS UPDATE FLAG ;21 Nov 2018  12:28 PM
 ;;1.0;MASTER PATIENT INDEX VISTA;**69**;;Build 1
 ;**69,Story 841921 (mko): New routine for the Name Components Update Flag
 Q
 ;
UPDFLAG(RETURN,FLAG,VALUE) ;Remote Procedure MPIF UPDATE NAME COMP FLAG
 ;Update the flag for entry THREE in File #984.8
 ; FLAG : "G" - "GET" mode, the flag should be returned, not updated
 ;        Otherwise, flag is updated with the value passed
 ; VALUE : If FLAG'["G", VALUE is what the flag should be set to, 0 or 1.
 N DIERR,DIHELP,DIMSG,FDA,VAL,IEN,MSG,X,Y
 K RETURN
 ;
 I $G(FLAG)["G" S RETURN="1^"_$$GETFLAG Q
 ;
 S VAL=+$G(VALUE)'=0
 S FDA(984.8,"?+1,",.01)="THREE"
 S FDA(984.8,"?+1,",3)=VAL
 S IEN(1)=3
 D UPDATE^DIE("E","FDA","IEN","MSG")
 I $G(DIERR) S RETURN="-1^"_$$BLDERR("MSG") Q
 S RETURN="1^Successfully "_$S($G(IEN(1,0))="+":"added entry THREE and ",1:"")_"updated flag to "_VAL_" in File #984.8"
 Q
 ;
GETFLAG() ;Get the value of the flag
 Q $P($G(^MPIF(984.8,3,0)),"^",4)
 ;
DELTHREE(RETURN) ;Delete entry THREE in File #984.8
 N DA,DIK,X,Y
 I $D(^MPIF(984.8,3,0))[0 S RETURN="-1^Entry 3 doesn't exist." Q
 S DIK="^MPIF(984.8,",DA=3 D ^DIK
 S RETURN="1^Entry 3 deleted."
 Q
 ;
BLDERR(MSGROOT) ;Build an error from the error message array
 N ERRARR,ERRMSG,I
 D MSG^DIALOG("AE",.ERRARR,"","",MSGROOT)
 S ERRMSG="",I=0 F  S I=$O(ERRARR(I)) Q:'I  S ERRMSG=ERRMSG_$S(ERRMSG]"":" ",1:"")_$G(ERRARR(I))
 Q ERRMSG
