VAQXRF2 ;ALB/JRP - X-REF CODES FOR PDX;01-DEC-92
 ;;1.5;PATIENT DATA EXCHANGE;**30**;NOV 17, 1993
AD(IFN1,IFN,SET,FNUM,OLDX)        ;AD* X-REF FOR OUTGOING GROUP FILE (#394.83)
 ;INPUT  : IFN1 - Internal file number of master record
 ;         IFN - Internal file number of record
 ;         SET - If 1, set cross reference
 ;               If 0, kill cross reference (DEFAULT)
 ;         FNUM - Only valid for KILLS
 ;                The field number that was changed
 ;         OLDX - Only valid for KILLS
 ;                The previous value
 ;OUTPUT : 0 - Cross reference was set/killed
 ;        -1 - Cross reference not set/killed
 ;        -2 - Bad input
 ;
 ;CHECK INPUT & RECORD EXISTANCE
 Q:($G(IFN1)="") -2
 Q:($G(IFN)="") -2
 S SET=+$G(SET)
 Q:('$D(^VAT(394.83,IFN1,"FAC",IFN))) -2
 Q:(('SET)&('$D(FNUM))&('$D(OLDX))) -2
 ;DECLARE VARIABLES
 N FACILITY,DOMAIN,ZERO
 ;GET INFO FOR X-REF & QUIT IF ANY PART IS NULL
 S ZERO=$G(^VAT(394.83,IFN1,"FAC",IFN,0))
 Q:(ZERO="") -1
 S FACILITY=$P(ZERO,"^",1)
 I ('SET) S:(FNUM=.01) FACILITY=OLDX
 Q:(FACILITY="") -1
 S DOMAIN=$P(ZERO,"^",2)
 I ('SET) S:(FNUM=.02) DOMAIN=OLDX
 Q:(DOMAIN="") -1
 ;SET X-REF
 S:(SET) ^VAT(394.83,IFN1,"FAC","A-OUTGRP",FACILITY,DOMAIN,IFN)=""
 ;KILL X-REF
 K:('SET) ^VAT(394.83,IFN1,"FAC","A-OUTGRP",FACILITY,DOMAIN,IFN)
 Q 0
OKDOM1(X) ; Screen for "Remote Facility" field #.01 in "Remote Facility"
 ; multiple 394.831 (field #10) in file 394.83
 N VIEN
 S VIEN=+$G(^DIC(4,X,6))
 Q:$P($G(^DIC(4.2,VIEN,0)),U,2)'["C" 1
 ;D EN^DDIOL("Domain for this Facility is closed.")
 Q 0
OKDOM2(X) ; Screen for "Remote Domain" field #.02 in "Remote Facility"
 ; multiple 394.831 (field #10) in file 394.83
 Q:$P($G(^(0)),U,2)'["C" 1
 ;D EN^DDIOL("Domain is closed.")
 Q 0
 ;
AE(IFN,SET,FNUM,OLDX)        ;AE* X-REF FOR SEGMENT GROUP FILE (#394.84)
 ;INPUT  : IFN - Internal file number of record
 ;         SET - If 1, set cross reference
 ;               If 0, kill cross reference (DEFAULT)
 ;         FNUM - Only valid for KILLS
 ;                The field number that was changed
 ;         OLDX - Only valid for KILLS
 ;                The previous value
 ;OUTPUT : 0 - Cross reference was set/killed
 ;        -1 - Cross reference not set/killed
 ;        -2 - Bad input
 ;
 ;CHECK INPUT & RECORD EXISTANCE
 Q:($G(IFN)="") -2
 S SET=+$G(SET)
 Q:('$D(^VAT(394.84,IFN))) -2
 Q:(('SET)&('$D(FNUM))&('$D(OLDX))) -2
 ;DECLARE VARIABLES
 N TYPE,PERSON,ZERO
 ;GET INFO FOR X-REF & QUIT IF ANY PART IS NULL
 S ZERO=$G(^VAT(394.84,IFN,0))
 Q:(ZERO="") -1
 S TYPE=$P(ZERO,"^",2)
 I ('SET) S:(FNUM=.02) TYPE=OLDX
 Q:(TYPE="") -1
 S PERSON=$P(ZERO,"^",3)
 I ('SET) S:(FNUM=.03) PERSON=OLDX
 Q:(PERSON="") -1
 ;SET X-REF
 S:(SET) ^VAT(394.84,"A-SEGGRP",TYPE,PERSON,IFN)=""
 ;KILL X-REF
 K:('SET) ^VAT(394.84,"A-SEGGRP",TYPE,PERSON,IFN)
 Q 0
 ;
BS5(IFN,SET,FNUM,OLDX)        ;BS5* X-REF FOR TRANSACTION FILE (#394.61)
 ;INPUT  : IFN - Internal file number of record
 ;         SET - If 1, set cross reference
 ;               If 0, kill cross reference (DEFAULT)
 ;         FNUM - Only valid for KILLS
 ;                The field number that was changed
 ;         OLDX - Only valid for KILLS
 ;                The previous value
 ;OUTPUT : 0 - Cross reference was set/killed
 ;        -1 - Cross reference not set/killed
 ;        -2 - Bad input
 ;
 ;CHECK INPUT & RECORD EXISTANCE
 Q:($G(IFN)="") -2
 S SET=+$G(SET)
 Q:('$D(^VAT(394.61,IFN))) -2
 Q:(('SET)&('$D(FNUM))&('$D(OLDX))) -2
 ;DECLARE VARIABLES
 N NAME,SSN,QRY
 ;GET INFO FOR X-REF & QUIT IF ANY PART IS NULL
 S QRY=$G(^VAT(394.61,IFN,"QRY"))
 Q:(QRY="") -1
 S NAME=$P(QRY,"^",1)
 I ('SET) S:(FNUM=10) NAME=OLDX
 Q:(NAME="") -1
 S SSN=$P(QRY,"^",2)
 I ('SET) S:(FNUM=11) SSN=OLDX
 Q:(SSN="") -1
 ;SET X-REF
 S:(SET) ^VAT(394.61,"BS5",($E(NAME,1)_$E(SSN,6,10)),IFN)=""
 ;KILL X-REF
 K:('SET) ^VAT(394.61,"BS5",($E(NAME,1)_$E(SSN,6,10)),IFN)
 Q 0
AUTO(VNODE)       ;Auto-Numbering Logic
 ;INPUT  : VNODE - Shows which field is being incremented
 ;            1 - Field .01 of file 394.61
 ;            2 - Field .01 of file 394.62
 ;            3 - Field .01 of file 394.73
 ;OUTPUT : N - Next available number
 ;        -1 - Could not find auto-number record
 ;        -2 - Bad input
 N VFILE,VIEN,VNEXT
 S VIEN=+$O(^VAT(394.86,"B",1,0)) ;Check for record existence
 Q:'VIEN -1
 S VFILE=$S($G(VNODE)=1:394.61,$G(VNODE)=2:394.62,$G(VNODE)=3:394.73,1:0)
 Q:'VFILE -2
 L +^VAT(394.86,VIEN,VNODE) ;Lock node to prevent simultaneous use
 ;Get next value for .01 of 394.61 or 394.62 or 394.73
 F VNEXT=$G(^VAT(394.86,VIEN,VNODE))+1:1 S:(VNEXT>9999999999) VNEXT=100 Q:'$D(^VAT(VFILE,"B",VNEXT))
 S ^VAT(394.86,VIEN,VNODE)=VNEXT ;Store new value
 L -^VAT(394.86,VIEN,VNODE) ;Unlock node
 ; Note that we enclose the number in quotes so that ^DIC does not
 ; perform a lookup.  Rather, it simply adds the new record to the file.
 Q """"_VNEXT_""""  ;Return next available number
