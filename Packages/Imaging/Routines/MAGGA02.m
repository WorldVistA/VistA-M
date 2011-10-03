MAGGA02 ;WOIFO/SG - REMOTE PROCEDURES FOR IMAGE PROPERTIES ; 5/1/09 2:54pm
 ;;3.0;IMAGING;**93**;Dec 02, 2009;Build 163
 ;; Per VHA Directive 2004-038, this routine should not be modified.
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; | Use of unreleased versions of this software requires the user |
 ;; | to execute a written test agreement with the VistA Imaging    |
 ;; | Development Office of the Department of Veterans Affairs,     |
 ;; | telephone (301) 734-0100.                                     |
 ;; |                                                               |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a medical device.  As such, it may not be changed in any way. |
 ;; | Modifications to this software may result in an adulterated   |
 ;; | medical device under 21CFR820, the use of which is considered |
 ;; | to be a violation of US Federal Statutes.                     |
 ;; +---------------------------------------------------------------+
 ;;
 Q
 ;
 ;***** GETS THE IMAGE PROPERTIES (FIELDS IN FILE #2005 OR #2005.1)
 ; RPC: MAGG IMAGE GET PROPERTIES
 ;
 ; .RESULTS      Reference to a local variable where the results
 ;               are returned to.
 ;
 ; IMGIEN        IEN of the image record in the IMAGE file (#2005)
 ;
 ; PROPLST       Property names separated by semicolons or one of
 ;               the following special characters:
 ;
 ;                 *  All supported properties
 ;
 ;                 #  Image indexes (IXCLASS, IXORIGIN, IXPKG,
 ;                    IXPROC, IXSPEC, and ISTYPE)
 ;
 ;               See the IPDEFS^MAGGA02A and IPDEFS1^MAGGA02A for
 ;               the lists of supported properties.
 ;
 ; [FLAGS]       Flags that control the execution (can be combined):
 ;
 ;                 E  Return external values (default)
 ;
 ;                 I  Return internal values
 ;
 ; [ADT]         Date/time (internal FileMan value) for retrieving
 ;               previous values. By default ($G(ADT)'>0), audit
 ;               checks are not performed and current values are
 ;               returned.
 ; 
 ; Return Values
 ; =============
 ;
 ; Zero value of the first '^'-piece of the RESULTS(0) indicates
 ; that an error occurred during the execution of the procedure.
 ; In this case, the RESULTS array is formatted as described in the
 ; comments to the RPCERRS^MAGUERR1 procedure.
 ;  
 ; Otherwise, '1^Ok' is returned in the RESULTS(0) and subsequent
 ; nodes contain property values:
 ;
 ; RESULTS(0)            Result descriptor
 ;                         ^01: 1
 ;                         ^02: Ok
 ;
 ; RESULTS(i)            Property value
 ;                         ^01: Property name
 ;                         ^02: "" (empty)
 ;                         ^03: Internal property value if the 'I'
 ;                              flag is provided. Otherwise - empty.
 ;                         ^04: External property value if the 'E'
 ;                              flag is provided. Otherwise - empty.
 ;
 ; RESULTS(j)            Line of word-processing property value
 ;                         ^01: Property name
 ;                         ^02: Sequential number
 ;                         ^03: Line of text
 ;
GETPROPS(RESULTS,IMGIEN,PROPLST,FLAGS,ADT) ;RPC [MAGG IMAGE GET PROPERTIES]
 N MAGRC,RESCNT
 D CLEAR^MAGUERR(1)
 K RESULTS  S RESULTS(0)="1^Ok",RESCNT=0
 S FLAGS=$G(FLAGS),MAGRC=0
 ;
 D
 . N FIELD,FLDLST,I,IENS,IMGFILE,MAGBUF,MAGMSG,NAME,PROPDEFS,TMP
 . S IMGFILE=2005,PROPDEFS="IPDEFS^MAGGA02A"
 . ;=== Check the record IEN
 . I '$$ISVALID^MAGGI11(IMGIEN,.MAGRC)  D STORE^MAGUERR(MAGRC)  Q
 . S IENS=IMGIEN_","
 . ;~~~ Delete this comment and the following lines of code when
 . ;~~~ the IMAGE AUDIT file (#2005.1) is completely eliminated.
 . I $$ISDEL^MAGGI11(IMGIEN,.MAGRC)  D
 . . S IMGFILE=2005.1,PROPDEFS="IPDEFS1^MAGGA02A"
 . . Q
 . ;
 . ;=== Load definitions of the properties
 . S MAGRC=$$LDMPDEFS^MAGUTL01(.PROPDEFS,PROPDEFS,"R")
 . Q:MAGRC<0
 . ;
 . ;=== Compile the list of fields
 . S FLDLST=""
 . I PROPLST="*"  D
 . . S NAME=""
 . . F  S NAME=$O(PROPDEFS("N",NAME))  Q:NAME=""  D
 . . . S TMP=$G(PROPDEFS("N",NAME)),FIELD=$P(TMP,U,2)
 . . . Q:($P(TMP,U)'=IMGFILE)!(FIELD'>0)
 . . . S FLDLST=FLDLST_";"_FIELD,FLDLST(FIELD)=NAME
 . . . Q
 . . Q
 . E  D
 . . S:PROPLST="#" PROPLST="IXCLASS;IXORIGIN;IXPKG;IXPROC;IXSPEC;IXTYPE"
 . . F I=1:1  S NAME=$P(PROPLST,";",I)  Q:NAME=""  D
 . . . S TMP=$G(PROPDEFS("N",NAME)),FIELD=$P(TMP,U,2)
 . . . Q:($P(TMP,U)'=IMGFILE)!(FIELD'>0)
 . . . S FLDLST=FLDLST_";"_FIELD,FLDLST(FIELD)=NAME
 . . . Q
 . . Q
 . S FLDLST=$P(FLDLST,";",2,999999)  Q:FLDLST=""
 . ;
 . ;=== Load the field values
 . S TMP=$$TRFLAGS^MAGUTL05(FLAGS,"EI")
 . S:TMP="" TMP="E",FLAGS=FLAGS_"E"
 . D GETS^MAGUTL04(IMGFILE,IENS,FLDLST,TMP,"MAGBUF","MAGMSG",$G(ADT))
 . I $G(DIERR)  S MAGRC=$$DBS^MAGUERR("MAGMSG",IMGFILE,IENS)  Q
 . ;
 . ;=== Store property values to the result array
 . S FIELD=0
 . F  S FIELD=$O(MAGBUF(IMGFILE,IENS,FIELD))  Q:FIELD'>0  D
 . . S NAME=$P(FLDLST(FIELD),U)
 . . ;--- Word-processing field
 . . I $P(PROPDEFS("N",NAME),U,3)["W"  D  Q
 . . . S I=0
 . . . F  S I=$O(MAGBUF(IMGFILE,IENS,FIELD,I))  Q:I'>0  D
 . . . . S RESCNT=RESCNT+1
 . . . . S RESULTS(RESCNT)=NAME_U_I_U_MAGBUF(IMGFILE,IENS,FIELD,I)
 . . . . Q
 . . . Q
 . . ;--- Other types
 . . S TMP=NAME
 . . S:FLAGS["I" $P(TMP,U,3)=MAGBUF(IMGFILE,IENS,FIELD,"I")
 . . S:FLAGS["E" $P(TMP,U,4)=MAGBUF(IMGFILE,IENS,FIELD,"E")
 . . S RESCNT=RESCNT+1,RESULTS(RESCNT)=TMP
 . . Q
 . ;
 . ;=== Compute the value of the Image Class property
 . I (PROPLST="*")!((";"_PROPLST_";")[";IXCLASS;")  D  Q:MAGRC<0
 . . S TMP=$G(MAGBUF(IMGFILE,IENS,42,"I"))
 . . S TMP=$$IXCLASS^MAGGA02A(IMGFILE,IENS,TMP,FLAGS)
 . . I TMP<0  S MAGRC=TMP  Q
 . . S:TMP'=0 RESCNT=RESCNT+1,RESULTS(RESCNT)=TMP
 . . Q
 . Q
 ;
 ;=== Error handling and cleanup
 D:MAGRC<0 RPCERRS^MAGUERR1(.RESULTS,MAGRC)
 Q
 ;
 ;***** SETS THE IMAGE PROPERTIES (FIELDS IN THE FILE #2005)
 ; RPC: MAGG IMAGE SET PROPERTIES
 ;
 ; .RESULTS      Reference to a local variable where the results
 ;               are returned to.
 ;
 ; IMGIEN        IEN of the image record in the IMAGE file (#2005)
 ;
 ; [FLAGS]       Reserved for future use
 ;
 ; .PROPVALS     Reference to a local array that stores new values
 ;               for image properties. See description of the MAGG
 ;               IMAGE SET PROPERTIES remote procedure for details.
 ;
 ;               See the IPDEFS^MAGGA02A for the list of supported
 ;               properties.
 ;
 ; Return Values
 ; =============
 ;
 ; Zero value of the first '^'-piece of the RESULTS(0) indicates
 ; that an error occurred during the execution of the procedure.
 ; In this case, the RESULTS array is formatted as described in the
 ; comments to the RPCERRS^MAGUERR1 procedure.
 ;  
 ; Otherwise, the RESULTS(0) contains '1^OK'.
 ;
 ; Notes
 ; =====
 ;
 ; Properties of images marked as deleted cannot be modified. This
 ; entry point returns an error (-41) if the IMGIEN parameter
 ; references a deleted image entry.
 ;
 ; If one of the following fields is updated in the parent or the
 ; child of a group that has only one image, then the changes are
 ; replicated to the child or parent respectively:
 ;
 ; SHORT DESCRIPTION (10), TYPE INDEX (42), PROC/EVENT INDEX (43),
 ; SPEC/SUBSPEC INDEX (44), ORIGIN INDEX (45), CREATION DATE (110),
 ; CONTROLLED IMAGE (112), STATUS (113), and STATUS REASON (113.3).
 ;
SETPROPS(RESULTS,IMGIEN,FLAGS,PROPVALS) ;RPC [MAGG IMAGE SET PROPERTIES]
 N MAGNODE,MAGRC
 D CLEAR^MAGUERR(1)
 K RESULTS  S RESULTS(0)="1^Ok"
 S MAGRC=0
 ;
 D
 . N FLD,IENS,IMGIEN1,NAME,MAGFDA,MAGMSG,MISC,PROPDEFS
 . ;=== Set up the error handler
 . N $ESTACK,$ETRAP  D SETDEFEH^MAGUERR("MAGRC")
 . ;
 . ;=== Check the record IEN
 . I '$$ISVALID^MAGGI11(IMGIEN,.MAGRC)  D STORE^MAGUERR(MAGRC)  Q
 . ;
 . ;=== Load definitions of parameters and properties
 . S MAGRC=$$LDMPDEFS^MAGUTL01(.PROPDEFS,"IPDEFS^MAGGA02A","W")
 . Q:MAGRC<0
 . ;
 . ;=== Validate the new property values
 . S MAGRC=$$RPCMISC^MAGUTL02(.PROPVALS,.MISC,.PROPDEFS,"UV")
 . Q:MAGRC<0
 . ;
 . ;=== Prepare the new data
 . S IENS=IMGIEN_","
 . S NAME=""
 . F  S NAME=$O(MISC(NAME))  Q:NAME=""  D
 . . ;--- Check the file and field numbers and skip parameters
 . . ;--- that should not be stored in the IMAGE file (#2005)
 . . Q:$P($G(PROPDEFS("N",NAME)),U)'=2005
 . . S FLD=$P(PROPDEFS("N",NAME),U,2)  Q:FLD'>0
 . . ;--- Store the value into the Fileman DBS buffer
 . . S MAGFDA(2005,IENS,FLD)=MISC(NAME,"I")
 . . Q
 . Q:$D(MAGFDA)<10
 . ;
 . ;=== Check for the group of one and replicate the changes
 . S IMGIEN1=$$REPLIC^MAGGA02A(IMGIEN,.MAGFDA)
 . I IMGIEN1<0  S MAGRC=IMGIEN1  Q
 . ;
 . ;=== Lock the image record(s)
 . S MAGNODE=$NA(^MAG(2005,IMGIEN))
 . S:IMGIEN1>0 MAGNODE="("_MAGNODE_","_$NA(^MAG(2005,IMGIEN1))_")"
 . D LOCK^DILF(MAGNODE)  E  D  K MAGNODE  Q
 . . S MAGRC=$$ERROR^MAGUERR(-21,,"image (IEN="_IMGIEN_")")
 . . Q
 . ;
 . ;=== Check if the image record exists
 . I $$ISDEL^MAGGI11(IMGIEN,.MAGRC)  D  Q
 . . S MAGRC=$$ERROR^MAGUERR(-41,,IMGIEN)
 . . Q
 . I MAGRC<0  D STORE^MAGUERR(MAGRC)  Q
 . ;
 . ;=== Update the image record
 . D FILE^DIE(,"MAGFDA","MAGMSG")
 . I $G(DIERR)  S MAGRC=$$DBS^MAGUERR("MAGMSG",2005,IENS)  Q
 ;
 ;=== Error handling and cleanup
 X:$G(MAGNODE)'="" "L -"_MAGNODE
 D:MAGRC<0 RPCERRS^MAGUERR1(.RESULTS,MAGRC)
 Q
