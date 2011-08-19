RORRP038 ;HCIOFO/SG - RPC: USER AND PACKAGE PARAMETERS ; 11/21/05 9:28am
 ;;1.5;CLINICAL CASE REGISTRIES;;Feb 17, 2006
 ;
 ; This routine uses the following IA's:
 ;
 ; #2263         GETWP^XPAR and PUT^XPAR (supported)
 ;
 Q
 ;
 ;***** RETRIEVES THE VALUE OF THE GUI PARAMETER
 ; RPC: [ROR GUI PARAMETER GET]
 ;
 ; .RESULTS      Reference to a local variable where the results
 ;               are returned to.
 ;
 ; INSTANCE      Instance name of the GUI parameter.
 ;               Optional second "^"-piece of this parameter can
 ;               contain name of the parameter. By default, the
 ;               "ROR GUI PARAMETER" is used.
 ;
 ; [ENTITY]      Entity where the parameter value is searched for.
 ;               By default ($G(ENTITY)=""), the "ALL" value is used
 ;               (see the DBIA #2263 for more details).
 ;
 ; Return Values:
 ;
 ; A negative value of the first "^"-piece of the RESULTS(0) indicates
 ; an error (see the RPCSTK^RORERR procedure for more details).
 ;
 ; Otherwise, the RESULTS(0) will contain 0 and the subsequent nodes
 ; of the RESULTS array will contain the lines of parameter value.
 ;
GETPARM(RESULTS,INSTANCE,ENTITY) ;
 N CNT,I,RC,RORBUF,RORERRDL,RORMSG  K RESULTS
 D CLEAR^RORERR("GETPARM^RORRP038",1)
 ;--- Check the parameters
 I $G(INSTANCE)=""  D  D RPCSTK^RORERR(.RESULTS,RC)  Q
 . S RC=$$ERROR^RORERR(-88,,,,"INSTANCE",$G(INSTANCE))
 S:$G(ENTITY)="" ENTITY="ALL"
 S NAME=$P(INSTANCE,U,2)
 S:$G(NAME)="" NAME="ROR GUI PARAMETER"
 ;--- Get the value
 D GETWP^XPAR(.RORBUF,ENTITY,NAME,$P(INSTANCE,U),.RORMSG)
 I $G(RORMSG)  D  D RPCSTK^RORERR(.RESULTS,RC)  Q
 . S RC=$$ERROR^RORERR(-56,,$P(RORMSG,U,2),,+RORMSG,"GETWP^XPAR")
 S RESULTS(0)=0
 ;--- Ignore and delete old parameters without description.
 ;    These parameters were created by the CCR v1.0.
 ;--- Unfortunately, the ENVAL^XPAR procedure ignores them.
 I $G(RORBUF)=""  D DEL^XPAR(ENTITY,NAME,$P(INSTANCE,U))  Q
 ;--- Copy the value to the output array
 S I="",CNT=0
 F  S I=$O(RORBUF(I))  Q:I=""  D
 . S CNT=CNT+1,RESULTS(CNT)=RORBUF(I,0)  K RORBUF(I)
 Q
 ;
 ;***** RETRIEVES THE LIST OF ALL INSTANCES OF THE PARAMETER
 ; RPC: [ROR LIST PARAMETER INSTANCES]
 ;
 ; .RESULTS      Reference to a local variable where the results
 ;               are returned to.
 ;
 ; [NAME]        Name of the parameter (by default, the
 ;               "ROR GUI PARAMETER" is used)
 ;
 ; [ENTITY]      Entity where the parameters are searched for.
 ;               By default ($G(ENTITY)=""), the "ALL" value is used
 ;               (see the DBIA #2263 for more details).
 ;
 ; [PREFIX]      Instance name prefix (by default, all instances
 ;               are selected). Bear in mind that the prefix is
 ;               removed from the instance names.
 ;
GETPLIST(RESULTS,NAME,ENTITY,PREFIX) ;
 N CNT,I,LP,RC,RORBUF,RORERRDL,RORMSG  K RESULTS
 D CLEAR^RORERR("GETRPLST^RORRP038",1)
 S:$G(NAME)="" NAME="ROR GUI PARAMETER"
 S:$G(ENTITY)="" ENTITY="ALL"
 S:$G(PREFIX)="" PREFIX=""
 D GETLST^XPAR(.RESULTS,ENTITY,NAME,"Q")
 I $G(RORMSG)  D  D RPCSTK^RORERR(.RESULTS,RC)  Q
 . S RC=$$ERROR^RORERR(-56,,$P(RORMSG,U,2),,+RORMSG,"GETLST^XPAR")
 ;--- Screen unwanted instances and strip the prefixes
 S LP=$L(PREFIX)
 I LP>0  S (CNT,I)=0  D
 . F  S I=$O(RESULTS(I))  Q:I=""  D
 . . I $E(RESULTS(I),1,LP)'=PREFIX  K RESULTS(I)  Q
 . . S RESULTS(I)=$E(RESULTS(I),LP+1,999),CNT=CNT+1
 E  S CNT=+$G(RESULTS)
 ;--- Store the total number of instances
 S RESULTS(0)=CNT,RESULTS=""
 Q
 ;
 ;***** RENAMES THE INSTANCE OF THE GUI PARAMETER
 ; RPC: [ROR GUI PARAMETER RENAME]
 ;
 ; .RESULTS      Reference to a local variable where the results
 ;               are returned to.
 ;
 ; ENTITY        Entity that the parameter is associated with.
 ;
 ; NAME          Name of the parameter
 ;
 ; OLDINST       Current instance name of the GUI parameter
 ;
 ; NEWINST       New instance name for the GUI parameter
 ;
 ; Return Values:
 ;
 ; A negative value of the first "^"-piece of the RESULTS(0) indicates
 ; an error (see the RPCSTK^RORERR procedure for more details).
 ;
 ; Otherwise, the RESULTS(0) will contain 0.
 ;
RENPARM(RESULTS,ENTITY,NAME,OLDINST,NEWINST) ;
 N RC,RORERRDL,RORMSG,TMP  K RESULTS
 D CLEAR^RORERR("RENPARM^RORRP038",1)
 ;--- Check the parameters
 I $G(ENTITY)=""  D  D RPCSTK^RORERR(.RESULTS,RC)  Q
 . S RC=$$ERROR^RORERR(-88,,,,"ENTITY",$G(ENTITY))
 I $G(NAME)=""  D  D RPCSTK^RORERR(.RESULTS,RC)  Q
 . S RC=$$ERROR^RORERR(-88,,,,"NAME",$G(NAME))
 I $G(OLDINST)=""  D  D RPCSTK^RORERR(.RESULTS,RC)  Q
 . S RC=$$ERROR^RORERR(-88,,,,"OLDINST",$G(OLDINST))
 I $G(NEWINST)=""  D  D RPCSTK^RORERR(.RESULTS,RC)  Q
 . S RC=$$ERROR^RORERR(-88,,,,"NEWINST",$G(NEWINST))
 ;--- Delete the instance with the new name if it exists
 ;--- (otherwise, the REP^XPAR will return an error)
 D:$$UP^XLFSTR(OLDINST)'=$$UP^XLFSTR(NEWINST)
 . D DEL^XPAR(ENTITY,NAME,NEWINST,.RORMSG)  K RORMSG
 ;--- Rename the instance
 D REP^XPAR(ENTITY,NAME,OLDINST,NEWINST,.RORMSG)
 I $G(RORMSG)  D  D RPCSTK^RORERR(.RESULTS,RC)  Q
 . S RC=$$ERROR^RORERR(-56,,$P(RORMSG,U,2),,+RORMSG,"REP^XPAR")
 S RESULTS(0)=0
 Q
 ;
 ;***** STORES THE VALUE OF THE GUI PARAMETER
 ; RPC: [ROR GUI PARAMETER SET]
 ;
 ; .RESULTS      Reference to a local variable where the results
 ;               are returned to.
 ;
 ; INSTANCE      Instance name of the GUI parameter.
 ;               Optional second "^"-piece of this parameter can
 ;               contain name of the parameter. By default, the
 ;               "ROR GUI PARAMETER" is used.
 ;
 ; [ENTITY]      Entity that the parameter is associated with.
 ;               By default ($G(ENTITY)=""), the "USR" value is used
 ;               (see the DBIA #2263 for more details).
 ;
 ; [.]VALUE      Value of the parameter. It should be either a string
 ;               or a reference to a local array that contains a text
 ;               (prepared for a word-processing field).
 ;
 ;               The local array should not contain the 0 subscript
 ;               (it will not be stored).
 ;
 ;               You can use the "@" value to delete the parameter.
 ;
 ; Return Values:
 ;
 ; A negative value of the first "^"-piece of the RESULTS(0) indicates
 ; an error (see the RPCSTK^RORERR procedure for more details).
 ;
 ; Otherwise, the RESULTS(0) will contain 0.
 ;
SETPARM(RESULTS,INSTANCE,ENTITY,VALUE) ;
 N RC,RORBUF,RORERRDL,RORMSG,TMP  K RESULTS
 D CLEAR^RORERR("SETPARM^RORRP038",1)
 ;--- Check the parameters
 I $G(INSTANCE)=""  D  D RPCSTK^RORERR(.RESULTS,RC)  Q
 . S RC=$$ERROR^RORERR(-88,,,,"INSTANCE",$G(INSTANCE))
 I '$D(VALUE)  D  D RPCSTK^RORERR(.RESULTS,RC)  Q
 . S RC=$$ERROR^RORERR(-88,,,,"VALUE","<UNDEFINED>")
 S:$G(ENTITY)="" ENTITY="USR"
 S NAME=$P(INSTANCE,U,2)
 S:$G(NAME)="" NAME="ROR GUI PARAMETER"
 ;--- Prepare the value (make sure the description is not empty)
 I $D(VALUE),$G(VALUE)'="@"  D
 . I $D(VALUE)=1  S RORBUF(1,0)=VALUE
 . E  M RORBUF=VALUE
 . S:$G(RORBUF)="" RORBUF="CCR GUI Parameter"
 E  S RORBUF="@"
 ;--- Store the value
 D PUT^XPAR(ENTITY,NAME,$P(INSTANCE,U),.RORBUF,.RORMSG)
 I $G(RORMSG),+RORMSG'=1  D  D RPCSTK^RORERR(.RESULTS,RC)  Q
 . S RC=$$ERROR^RORERR(-56,,$P(RORMSG,U,2),,+RORMSG,"PUT^XPAR")
 S RESULTS=0
 Q
