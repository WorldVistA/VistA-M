VAQPST10 ;ALB/JRP - POST INITS;10-JUN-93
 ;;1.5;PATIENT DATA EXCHANGE;;NOV 17, 1993
MAIL() ;ADD MAIL GROUPS USED
 ;INPUT  : NONE
 ;OUTPUT : XYZ - Code telling which groups were/weren't added
 ;               X specifies if VAQ PDX ERRORS was added
 ;               Y specifies if VAQ MANUAL PROCESSING was added
 ;               Z specifies if VAQ UNSOLICITED RECEIVED was added
 ;NOTES  : When an error occurs, the error code returned specifies
 ;         which mail groups were & weren't added.  If the "bit"
 ;         position that specifies the mail group is set to 1, the
 ;         mail group wasn't added.
 ;           EX:  -101 tells that the mail groups VAQ PDX ERRORS and
 ;                VAQ UNSOLICITED RECEIVED were not added, while the
 ;                mail group VAQ MANUAL PROCESSING was added.
 ;
 ;DECLARE VARIABLES
 N GROUP,PRIVATE,ENROLL,RESTCODE,TMPARR,OUTCODE,ERROR
 S OUTCODE="000"
 ;ADD VAQ PDX ERRORS
 S GROUP="VAQ PDX ERRORS"
 S PRIVATE=0
 S ENROLL=0
 S RESTCODE=0
 S TMPARR(1)="Mail group that will receive any recoverable errors that occur"
 S TMPARR(2)="when using PDX.  These errors will generally happen when a PDX"
 S TMPARR(3)="message can not be properly received by the PDX Server or when"
 S TMPARR(4)="a PDX message can not be properly created by the PDX Transmitter."
 S TMPARR(6)="This group will typically consist of the ADPAC(s) and IRM personnel"
 S TMPARR(7)="responsible for PDX."
 S ERROR=+$$MAILGRP^VAQUTL4(GROUP,PRIVATE,ENROLL,RESTCODE,"TMPARR")
 S:(ERROR<0) OUTCODE="1"_$E(OUTCODE,2,$L(OUTCODE))
 ;ADD VAQ MANUAL PROCESSING
 S GROUP="VAQ MANUAL PROCESSING"
 S PRIVATE=0
 S ENROLL=0
 S RESTCODE=0
 K TMPARR
 S TMPARR(1)="Mail group that will receive notification of a PDX Request that"
 S TMPARR(2)="has been received and requires manual processing.  This group"
 S TMPARR(3)="will typically consist of users that authorize the release of"
 S TMPARR(4)="patient data to other facilities."
 S ERROR=+$$MAILGRP^VAQUTL4(GROUP,PRIVATE,ENROLL,RESTCODE,"TMPARR")
 S:(ERROR<0) OUTCODE=$E(OUTCODE,1)_"1"_$E(OUTCODE,3,$L(OUTCODE))
 ;ADD VAQ UNSOLICITED RECEIVED
 S GROUP="VAQ UNSOLICITED RECEIVED"
 S PRIVATE=0
 S ENROLL=0
 S RESTCODE=0
 K TMPARR
 S TMPARR(1)="Mail group that will receive notification when an Unsolicited"
 S TMPARR(2)="PDX has been received.  This group will typically consist of"
 S TMPARR(3)="users that receive patient data from other facilities."
 S ERROR=+$$MAILGRP^VAQUTL4(GROUP,PRIVATE,ENROLL,RESTCODE,"TMPARR")
 S:(ERROR<0) OUTCODE=$E(OUTCODE,1,2)_"1"_$E(OUTCODE,4,$L(OUTCODE))
 Q OUTCODE
