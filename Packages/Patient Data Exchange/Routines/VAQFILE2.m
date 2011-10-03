VAQFILE2 ;ALB/MFK - MESSAGE FILING;19-OCT-95
 ;;1.5;PATIENT DATA EXCHANGE;**16,20**;NOV 17, 1993
FILESEG(FILE,DA,FIELD,VALUE1,VALUE2,VALUE3) ;FILE INFORMATION
 ;INPUT  : FILE - File number
 ;         DA - IFN of entry to edit
 ;         FIELD - Field of multiple
 ;         VALUE1 - Name of segment to be filed
 ;         VALUE2 - Time limit of segment being filed
 ;         VALUE3 - Occurrence limit of segment being filed
 ;OUTPUT : 0 - Success
 ;        -1^Error_text - Error
 ;NOTES  : It is the responsibility of
 ;         the calling routine to verify that VALUE can be added as
 ;         an entry in the multiple.  It is also the responsibility
 ;         of the calling routine to verify that VALUE is an entry in
 ;         the subfile when deleting/editing.
 ;
 ;CHECK INPUT
 Q:('$G(FILE)) "-1^Did not pass file number"
 Q:('$D(^DD(FILE))) "-1^Did not pass valid file number"
 Q:('$G(DA)) "-1^Did not pass entry number"
 Q:('$D(FIELD)) "-1^Field not passed"
 S VALUE1=$G(VALUE1)
 Q:(VALUE1="") "-1^No .01 sent"
 S VALUE2=$G(VALUE2)
 S VALUE3=$G(VALUE3)
 ;DECLARE VARIABLES
 N DIE,DR,X,DIC,Y,DLAYGO
 K DD,DO
 ; SET UP FILE^DICN CALL
 S DIC=$G(^DIC(FILE,0,"GL"))
 S DIC(0)="XL"
 S DLAYGO=FILE
 Q:(DIC="") "-1^Could not determine global root of file"
 Q:('$D(@(DIC_DA_")"))) "-1^Did not pass valid entry number"
 S MULT=$P($P($G(^DD(FILE,FIELD,0)),"^",4),";",1)
 S DIC=DIC_DA_",MULT,"
 S DIC("P")=+$P($G(^DD(FILE,FIELD,0)),"^",2)
 I ('DIC("P")) Q "-1^Main field is not a multiple"
 S DA(1)=DA
 S DIC("DR")=".01////"_VALUE1_";.02////"_VALUE2_";.03////"_VALUE3
 S X=VALUE1
 D FILE^DICN
 Q:($D(Y)="-1") "-1^Could not file new value"
 Q 0
