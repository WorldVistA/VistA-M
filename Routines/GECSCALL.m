GECSCALL ;WISC/RFJ-calls to various options                         ;27 Apr 89
 ;;2.0;GCS;;MAR 14, 1995
 Q
 ;
 ;
TYPE ;  set selectable batch type
 S GECSSYS="MAS"
 Q
 ;
CREATE ;  create a code sheet
 D ^GECSEDIT
 Q
 ;
BATCH ;  batch a code sheet
 D ^GECSBATC
 Q
 ;
KEY ;  keypunch a code sheet
 D KEY^GECSEDIT
 Q
 ;
REBAT ;  remark a code sheet for rebatching
 D REMARK^GECSMUT1
 Q
 ;
EDITBAT ;  edit a batch number
 D EDITBAT^GECSMUT1
 Q
 ;
EDITCOD ;  edit a code sheet
 D EDIT^GECSEDIT
 Q
 ;
REVCODE ;  review a code sheet
 D REVIEW^GECSMUT1
 Q
 ;
DELCODE ;  delete a code sheet
 D DELETE^GECSMUT1
 Q
 ;
TRANS ;  transmit a batch
 D ^GECSTRAN
 Q
 ;
RETRAN ;  remark a batch for transmission
 D RETRAN^GECSMUT2
 Q
 ;
PURGE ;  purge code sheets
 D ^GECSPURG
 Q
 ;
RCODEBA ;  report: code sheets ready for batching
 D READYBAT^GECSREP0
 Q
 ;
RBATWA ;  report: batches waiting to be transmitted
 D WAITBAT^GECSREP0
 Q
 ;
RSTATUS ;  report: status of all batches
 D BATCHES^GECSREP0
 Q
 ;
COMMENT ;  enter user comments on stack status report (for batch financial management)
 D ^GECSSCOM
 Q
 ;
STACRETR ;  retransmit stack file document (for batch financial management)
 D ^GECSSTT1
 Q
 ;
STACSTAT ;  stack status report (for batch financial management)
 D ^GECSRSTA
 Q
