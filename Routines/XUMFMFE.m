XUMFMFE ;OIFO-OAK/RAM - HL7 MFE SEGMENT ;8/23/95
 ;;8.0;KERNEL;**217**;Jul 10, 1995
 ;
 ;routine copied from VAFHLMFE, written by ALB/CM,JLU
 ;
MFE(EVENT,MFN,EDT,CODE) ;
 ;
 ;Input Parameters:
 ;EVENT - Record-level Event Code.  If not defined, the default is MAD (always add record to master file
 ;MFN - MFN Control ID.  If not defined, the default is null
 ;EDT - Effective date/time.  If not defined, the default is today. This should be in FM date/time format.
 ;CODE - REQUIRED!  Primary Key Value.  If not defined, segment will not be built and record will not be sent.
 ;
 ;Output:
 ;MFE - contains the segment if successful
 ;    - contains -1^error message if unsuccessful
 ;
 I '$D(EVENT) S EVENT="MAD"
 I '$D(MFN) S MFN=""
 I '$D(EDT) D NOW^%DTC S EDT=$P(%,".") K %
 I '$D(CODE) S MFE="-1^No Primary Key Value" G EXIT
 N MFE
 S MFE="MFE"_HLFS_EVENT_HLFS_MFN_HLFS_$$HLDATE^HLFNC(EDT)_HLFS_CODE
EXIT ;
 Q MFE
 ;
EN(ENC,FS,QUOTS,ARY) ;formats the MFE segment
 ;INPUTS  ENC   - the encoding characters for the segments
 ;        FS    - the field separators to be used
 ;        QUOTS - what to use as double quots
 ;        ARY   - this array contains the data to be place in the
 ;                MFE segment.  The subscripts of the array should
 ;                be the sequence number of the data element in the
 ;                array.
 ;         Ex.  X(1)=Record Level Event Code
 ;              X(2)=MFN Control ID
 ;              X(3)=Effective Date/time
 ;              etc.
 ;OUTPUT
 ;         0^description if there was an error.
 ;         the formatted segment if successful.
 N SEG,LP
 I '$D(ENC)!('$D(FS))!('$D(QUOTS))!('$D(ARY)) S SEG="0^Missing parameters." G MFIQ
 I $D(@ARY)<10 S SEG="0^Field array not populated." G MFIQ
 S SEG=""
 F LP=0:0 S LP=$O(@ARY@(LP)) Q:'LP  S $P(SEG,FS,LP+1)=@ARY@(LP)
 S $P(SEG,FS,1)="MFE"
MFIQ Q SEG
