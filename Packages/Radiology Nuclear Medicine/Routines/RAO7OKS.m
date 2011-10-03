RAO7OKS ;HISC/GJC-Accept/reject OE/RR request ;9/5/97  09:33
 ;;5.0;Radiology/Nuclear Medicine;**18,57**;Mar 16, 1998
 ;Last modified for P18 Oct 24 by SS
ACC(Y1,Y2,Y3,Y4,Y5) ; Rad accepts OE/RR request
 ; Y1-> order control                 Y2-> universal service ID
 ; Y3-> results rpt./stat. change DT  Y4-> result status 
 ; Y5-> scheduled date/time
 ;
 ; PFSS 1B Project Account Referance Number
 ; If the order status is "NEW", call to set up a new account number.
 I RAORD="NW" D FB^RABWIBB(+RAORC3)  ; Requirement 1, 5
 ; If the order status is "DISCONTINUE", call to set up a discontinue event
 I RAORD="DC" D DC^RABWIBB(+RAORC3) ; Requirement 8
 ;
 N MSG S MSG(1)=$$MSH^RAO7UTL("ORR")
 S MSG(2)=$$MSA^RAO7UTL(+RAORC2,"AA") ;P18 add MSA segment with accept AA
 S MSG(3)="PID"_$$STR^RAO7UTL(3)_$G(RAPID3)_$$STR^RAO7UTL(2)_$G(RAPID5) ;P18
 ; Add PV1 Segment for PFSS Project
 ; PFSS 1B project define new field: PV1-50 Alternate Visit ID
 S MSG(4)=$$PV1^RAO7UTL($G(^RAO(75.1,+RAORC3,0)))
 S MSG(5)="ORC"_RAHLFS_Y1_RAHLFS_$G(RAORC2)_RAHLFS_$G(RAORC3) ;P18
 I Y2]""!(Y3]"")!(Y4]"")!(Y5]"") D  ; include if order is scheduled
 . S MSG(6)="OBR"_$$STR^RAO7UTL(4)_Y2_$$STR^RAO7UTL(18)_Y3
 . S MSG(6)=MSG(6)_$$STR^RAO7UTL(2)_Y4_$$STR^RAO7UTL(12)_Y5
 . Q
 ;
 D SHIP ; send HL7 message on its way to CPRS
 Q
 ;
REJ(Y1,Y2) ; Rad rejects OE/RR request
 ; Y1-> order control                 Y2-> order control reason
 N MSG S MSG(1)=$$MSH^RAO7UTL("ORR")
 S MSG(2)=$$MSA^RAO7UTL(+RAORC2,"AR") ;P18 add MSA segment with reject AR
 S MSG(3)="PID"_$$STR^RAO7UTL(3)_$G(RAPID3)_$$STR^RAO7UTL(2)_$G(RAPID5) ;P18
 S MSG(4)="ORC"_RAHLFS_Y1_RAHLFS_$G(RAORC2)_RAHLFS_$G(RAORC3) ;P18
 S:Y2]"" MSG(4)=MSG(4)_$$STR^RAO7UTL(13)_RAECH(1)_Y2_RAECH(1)
SHIP ; ship message to MSG^RAO7UTL which fires of the HL7 message to CPRS
 D MSG^RAO7UTL("RA EVSEND OR",.MSG)
 Q
