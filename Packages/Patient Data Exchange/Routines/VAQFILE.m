VAQFILE ;ALB/JRP/KLD - MESSAGE FILING;12-MAY-93 [ 10/04/96  1:10 PM ]
 ;;1.5;PATIENT DATA EXCHANGE;**22,26,28,32**;NOV 17, 1993
NEWTRAN() ;MAKE STUB ENTRY IN TRANSACTION FILE
 ;INPUT  : NONE
 ;OUTPUT : IFN^Transaction_Number - Success
 ;         -1^Error_text - Error
 ;
 ;DECLARE VARIABLES
 N DD,DIC,X,DINUM,Y,DLAYGO
 S X="+" ;-- auto numbering - see ^DD(394.61,.01,7.5).  It involves $$AUTO^VAQXRF2(1) and file 394.86.
 S DIC="^VAT(394.61,",DIC(0)="L",DLAYGO=394.61
 D ^DIC
 I Y<0 Q "-1^Could not determine new transaction number"
 Q $P(Y,U,1,2)
 ;
DELTRAN(TRANPTR) ;DELETE TRANSACTION
 ;INPUT  : TRANPTR - Pointer to VAQ - TRANSACTION file
 ;OUTPUT : 0 - Success
 ;        -1^Error_text - Error
 ;NOTES  : This will also delete all entries in the VAQ - DATA file
 ;         that are associated with the transaction.
 ;
 ;CHECK INPUT
 Q:('(+$G(TRANPTR))) "-1^Did not pass pointer to transaction"
 ;DECLARE VARIABLES
 N DIK,SEGMENT,DA,DATAPTR,TMP
 ;DELETE ENTRIES IN DATA FILE
 S (DATAPTR,SEGMENT)=""
 F  S SEGMENT=$O(^VAT(394.62,"A-SEGMENT",TRANPTR,SEGMENT)) Q:'SEGMENT  D
 . F  S DATAPTR=+$O(^VAT(394.62,"A-SEGMENT",TRANPTR,SEGMENT,DATAPTR)) Q:'DATAPTR  D
 . . I ('$D(^VAT(394.62,DATAPTR,0))&($D(^VAT(394.62,"A-SEGMENT",TRANPTR,SEGMENT,DATAPTR))=1)) D
 . . . K ^VAT(394.62,"A-SEGMENT",TRANPTR,SEGMENT,DATAPTR)
 . . Q:'DATAPTR
 . . S TMP=$$DELDATA^VAQFILE1(DATAPTR)
 . . Q:(TMP)
 ;IF TRANSACTION DOES NOT EXIST RETURN SUCCESS
 Q:('$D(^VAT(394.61,TRANPTR))) 0
 ;DELETE ENTRY IN TRANSACTION FILE
 S DIK="^VAT(394.61,"
 S DA=TRANPTR
 D ^DIK
 Q:($D(^VAT(394.61,TRANPTR))) "-1^Unable to delete transaction"
 Q 0
 ;
FILEINFO(FILE,DA,FIELD,VALUE,SUBFIELD,SUBVALUE) ;FILE INFORMATION
 ;INPUT  : FILE - File number
 ;         DA - IFN of entry to edit
 ;         FIELD - Field number
 ;         VALUE - Information to be filed (defaults to '@')
 ;         SUBFIELD - Field number in multiple
 ;         SUBVALUE - Information to be filed in SUBFIELD of multiple
 ;                    (defaults to '@')
 ;OUTPUT : 0 - Success
 ;        -1^Error_text - Error
 ;NOTES  : If SUBFIELD is not passed, editing of a multiple will be
 ;         ignored.  If SUBFIELD is passed, the multiple under VALUE
 ;         will be edited.
 ;       : If working with a multiple, it is the responsibility of
 ;         the calling routine to verify that VALUE can be added as
 ;         an entry in the multiple.  It is also the responsibility
 ;         of the calling routine to verify that VALUE is an entry in
 ;         the subfile when deleting/editing.
 ;
 ;CHECK INPUT
 N IFN,NAME,SSN,PID,SITE,DOMAIN
 Q:('$G(FILE)) "-1^Did not pass file number"
 Q:('$D(^DD(FILE))) "-1^Did not pass valid file number"
 Q:('$G(DA)) "-1^Did not pass entry number"
 Q:('$G(FIELD)) "-1^Did not pass field number"
 Q:('$D(^DD(FILE,FIELD))) "-1^Did not pass valid field number"
 S VALUE=$G(VALUE)
 ;REMOVE ';' FROM VALUE (CONFUSES CALL TO DIE)
 S VALUE=$TR(VALUE,";","")
 S:(VALUE="") VALUE="@"
 S SUBFIELD=+$G(SUBFIELD)
 S SUBVALUE=$G(SUBVALUE)
 S:(SUBVALUE="") SUBVALUE="@"
 ;DECLARE VARIABLES
 N DIE,DR,Y,X,SUBFILE,ERR
 S DIE=$G(^DIC(FILE,0,"GL"))
 Q:(DIE="") "-1^Could not determine global root of file"
 Q:('$D(@(DIE_DA_")"))) "-1^Did not pass valid entry number"
 S DR=FIELD_"///"_VALUE
 ;SET UP FOR MULTIPLE
 S ERR=0
 I (SUBFIELD) D  Q:(ERR) ERR
 .S SUBFILE=+$P($G(^DD(FILE,FIELD,0)),"^",2)
 .I ('SUBFILE) S ERR="-1^Main field is not a multiple" Q
 .I ('$D(^DD(SUBFILE,SUBFIELD))) S ERR="-1^Did not pass valid field in multiple" Q
 .S DR(2,SUBFILE)=SUBFIELD_"///"_SUBVALUE
 ;MAKE SURE OTHER USER ISN'T EDITING ENTRY
 L +(@(DIE_DA_")")):60 Q:('$T) "-1^Could not edit entry (locked by other user)"
 D ^DIE
 L -(@(DIE_DA_")"))
 Q:($D(Y)#2) "-1^Could not file new value"
 Q 0
