VAQFILE1 ;ALB/JRP/KLD - MESSAGE FILING;12-MAY-93 [ 09/16/96  9:44 AM ]
 ;;1.5;PATIENT DATA EXCHANGE;**22,34**;NOV 17, 1993
NEWDATA() ;MAKE NEW ENTRY IN DATA FILE
 ;INPUT  : NONE
 ;OUTPUT : IFN - Success
 ;         -1^Error_text - Error
 ;
 ;DECLARE VARIABLES
 N DD,DIC,X,DINUM,Y,DLAYGO
 S DIC="^VAT(394.62,",DLAYGO=394.62
 S DIC(0)="L"
 S X="+" ;-- auto numbering - see ^DD(394.62,.01,7.5).  It involves $$AUTO^VAQXRF2(2) and file 394.86.
 D ^DIC
 I Y<0 Q "-1^Could not create entry in data file"
 Q $P(Y,"^",1)
 ;
DELDATA(DA) ;DELETE ENTRY IN DATA FILE
 ;INPUT  : DA - Pointer to VAQ - DATA file
 ;OUTPUT : 0 - Success
 ;        -1^Error_text - Error
 ;
 ;CHECK INPUT
 Q:('(+$G(DA))) "-1^Did not pass pointer to data"
 ;IF DATA DOES NOT EXIST RETURN SUCCESS
 ;Q:('$D(^VAT(394.62,DA))) 0
 Q:('$D(^VAT(394.62,DA))) "-1^No Data Exist Record not Deleted"
 ;DECLARE VARIABLES
 N DIK
 ;DELETE ENTRY
 S DIK="^VAT(394.62,"
 D ^DIK
 Q:('$D(^VAT(394.62,DA))) 0
 Q "-1^Unable to delete data"
 ;
DELSEG(SEG,TRAN) ;DELETE SEGMENT IN DATA FILE FOR A TRANSACTION
 ;INPUT  : SEG - Segment abbreviation
 ;         TRAN - Pointer to VAQ - TRANSACTION file
 ;OUTPUT : 0 - Success
 ;         -1^Error_Text - Error
 ;
 ;CHECK INPUT
 Q:($G(SEG)="") "-1^Did not pass segment abbreviation"
 S TRAN=+$G(TRAN)
 Q:(('TRAN)!('$D(^VAT(394.61,TRAN)))) "-1^Did not pass valid transaction"
 ;DECLARE VARIABLES
 N DATAPTR,TMP,SEGPTR
 ;GET SEGMENT POINTER
 S SEGPTR=+$O(^VAT(394.71,"C",SEG,""))
 Q:('SEGPTR) "-1^Did not pass valid segment abbreviation"
 ;DELETE ENTRIES IN DATA FILE
 S DATAPTR=""
 F  S DATAPTR=+$O(^VAT(394.62,"A-SEGMENT",TRAN,SEGPTR,"")) Q:('DATAPTR)  S TMP=$$DELDATA(DATAPTR)
 Q 0
 ;
STUBDATA(SEG,TRAN) ;CREATE STUB ENTRY IN DATA FILE
 ;INPUT  : SEG - Segment abbreviation
 ;         TRAN - Pointer to VAQ - TRANSACTION file
 ;OUTPUT : IFN - Success
 ;         -1^Error_text - Error
 ;NOTES  : The following fields (in addition to .01) will be filled in
 ;           .02 - Segment
 ;           .05 - Display Ready
 ;           40 - Transaction Number
 ;
 ;CHECK INPUT
 Q:($G(SEG)="") "-1^Did not pass segment abbreviation"
 S TRAN=+$G(TRAN)
 Q:(('TRAN)!('$D(^VAT(394.61,TRAN)))) "-1^Did not pass valid transaction"
 ;DECLARE VARIABLES
 N IFN,SEGNAME,TMP,TRANNUM,DIE,DR,Y,DA,DISPLAY
 ;GET SEGMENT NAME
 S TMP=+$O(^VAT(394.71,"C",SEG,""))
 Q:('TMP) "-1^Did not pass valid segment abbreviation"
 S TMP=$G(^VAT(394.71,TMP,0))
 S SEGNAME=$P(TMP,"^",1)
 Q:(SEGNAME="") "-1^Could not determine segment name"
 ;DETERMINE IF SEGMENT IS DISPLAY READY
 S DISPLAY=+$P(TMP,"^",3)
 S DISPLAY=$S(DISPLAY:"YES",1:"NO")
 ;GET TRANSACTION NUMBER
 S TRANNUM=+$G(^VAT(394.61,TRAN,0))
 Q:('TRANNUM) "-1^Could not determine transaction number"
 ;MAKE ENTRY IN DATA FILE
 S IFN=+$$NEWDATA
 Q:(IFN<0) "-1^Could not create entry in data file"
 ;PLACE INFO IN NEW ENTRY
 L +^VAT(394.62,IFN):60 I ('$T) S TMP=$$DELDATA(IFN) Q "-1^Could not edit entry (locked by other user)"
 ;PLACE SEGMENT NAME INTO DATA
 S DIE="^VAT(394.62,"
 S DA=IFN
 S DR=".02///"_SEGNAME
 D ^DIE
 I ($D(Y)#2) L -^VAT(394.62,IFN) S TMP=$$DELDATA(IFN) Q "-1^Could not file segment name"
 ;PLACE DISPLAY READY FLAG INTO DATA
 S DIE="^VAT(394.62,"
 S DA=IFN
 S DR=".05///"_DISPLAY
 D ^DIE
 I ($D(Y)#2) L -^VAT(394.62,IFN) S TMP=$$DELDATA(IFN) Q "-1^Could not file display ready flag"
 ;PLACE TRANSACTION NUBMER INTO DATA
 S DIE="^VAT(394.62,"
 S DA=IFN
 S DR="40///"_TRANNUM
 D ^DIE
 I ($D(Y)#2) L -^VAT(394.62,IFN) S TMP=$$DELDATA(IFN) Q "-1^Could not file transaction number"
 L -^VAT(394.62,IFN)
 Q IFN
