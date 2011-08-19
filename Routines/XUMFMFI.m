XUMFMFI ;OIFO-OAK/RAM - HL7 MFI SEGMENT ;8/23/95
 ;;8.0;KERNEL;**217**;Jul 10, 1995
 ;
 ;routine copied from VAFHLMFI by ALB/CM,JLU
 ;
 ;Input Parameters:
 ;ID - Master File Identifier (required)
 ;APP - Master File Application Identifier.  (required)
 ;EVENT - File-Level Event Code.  If not defined, the default will be "REP" to replace current version of this master file with the version contained in the message.
 ;ENDT - Entered date/time.  If not defined, the default is today. This should be in FM date/time format.
 ;EFFDT - Effective date/time.  If not defined, the default is today. This should be in FM date/time format.
 ;RESP - Response Level Code.  If not defined, will be "NE" Never, No application level response needed.
 ;
 ;Output:
 ;MFI - contains the segment if successful
 ;    - contains -1^error message if unsuccessful
 ;
MFI(ID,APP,EVENT,ENDT,EFFDT,RESP) ;
 ;
 I '$D(ID)!('$D(APP)) Q "-1^Missing Required Parameter(s)"
 I '$D(EVENT) S EVENT="REP"
 I '$D(ENDT) D NOW^%DTC S ENDT=$P(%,".") K %
 I '$D(EFFDT) D NOW^%DTC S EFFDT=$P(%,".") K %
 I '$D(RESP) S RESP="NE"
 ;
 N MFI
 S MFI="MFI"_HLFS_ID_HLFS_APP_HLFS_EVENT_HLFS_$$HLDATE^HLFNC(ENDT)_HLFS_$$HLDATE^HLFNC(EFFDT)_HLFS_RESP
 Q MFI
 ;
 ;
EN(ENC,FS,QUOTS,ARY) ;generic call to create MFI segments.
 ;
 ;INPUTS  ENC   - the encoding characters for the segments
 ;        FS    - the field separators to be used
 ;        QUOTS - what to use as double quots
 ;        ARY   - this array contains the data to be place in the
 ;                MFI segment.  The subscripts of the array should
 ;                be the sequence number of the data element in the
 ;                array.
 ;         Ex.  X(1)=master fiel identifier
 ;              X(2)=Master File Application Identifier
 ;              X(3)=File Level Event Code
 ;              etc.
 ;OUTPUT
 ;         0^description if there was an error.
 ;         the formatted segment if successful.
 ;
 N SEG,LP
 I '$D(ENC)!('$D(FS))!('$D(QUOTS))!('$D(ARY)) S SEG="0^Missing parameters." G MFIQ
 I $D(@ARY)<10 S SEG="0^Field array not populated." G MFIQ
 S SEG=""
 F LP=0:0 S LP=$O(@ARY@(LP)) Q:'LP  S $P(SEG,FS,LP+1)=@ARY@(LP)
 S $P(SEG,FS,1)="MFI"
MFIQ Q SEG
