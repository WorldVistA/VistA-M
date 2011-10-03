RAIPST4 ;HIRMFO/GJC - Post-init number four ;12/18/97  09:08
VERSION ;;5.0;Radiology/Nuclear Medicine;;Mar 16, 1998
 ;
EN1 ; Add Exam Statuses with an Imaging Type of 'Mammography'.
 ; Exam Statuses created: Cancelled; Waiting For Exam; Called
 ; For Exam; Examined; Transcribed and Complete.
 N RAERR,RAFDA,RAITY,RATXT S RATXT(1)=" "
 S RAITY=+$O(^RA(79.2,"B","MAMMOGRAPHY",0))
 I RAITY=0 D  Q  ; mammography missing as an i-type
 . S RATXT(1)=" ",RATXT(2)="Error, 'MAMMOGRAPHY' missing from the Imaging Type (79.2) file.",RATXT(3)="IRM and the Radiology/Nuclear Medicine ADPAC should investigate."
 . D MES^XPDUTL(.RATXT)
 . Q
 S RATXT(1)=" "
 S RATXT(2)="Add Exam Statuses with an Imaging Type of 'Mammography'."
 S RATXT(3)="Exam Statuses created: Cancelled; Waiting For Exam; Called"
 S RATXT(4)="For Exam; Examined; Transcribed and Complete."
 D MES^XPDUTL(.RATXT) K RATXT
 ;-------------------- Exam Status: Cancelled --------------------------
 I '($D(^RA(72,"AA","MAMMOGRAPHY",0))\10) D  ; Cancelled not filed.
 . S RAFDA(72,"+1,",.01)="CANCELLED",RAFDA(72,"+1,",3)=0
 . S RAFDA(72,"+1,",6)="y",RAFDA(72,"+1,",7)=RAITY
 . D UPDATE^DIE("","RAFDA","","RAERR")
 . I $D(RAERR("DIERR")) D ERMSG72("CANCELLED")
 . Q
 ;------------------ Exam Status: Waiting For Exam ---------------------
 I '($D(^RA(72,"AA","MAMMOGRAPHY",1))\10) D  ; Waiting For Xam not filed.
 . K RAERR,RAFDA
 . S RAFDA(72,"+1,",.01)="WAITING FOR EXAM",RAFDA(72,"+1,",3)=1
 . S RAFDA(72,"+1,",5)="Y",RAFDA(72,"+1,",6)="y"
 . S RAFDA(72,"+1,",7)=RAITY
 . F RAI=.31,.32,.33,.34,.35,.36,.37,.38,.39,.311,.312,.313,.314,.315 S RAFDA(72,"+1,",RAI)="y"
 . D UPDATE^DIE("","RAFDA","","RAERR")
 . I $D(RAERR("DIERR")) D ERMSG72("WAITING FOR EXAM")
 . Q
 ;------------------ Exam Status: Called For Exam ----------------------
 I '$$XIST("CALLED FOR EXAM",RAITY) D  ; Called For Exam not filed.
 . K RAERR,RAFDA
 . S RAFDA(72,"+1,",.01)="CALLED FOR EXAM",RAFDA(72,"+1,",6)="y"
 . S RAFDA(72,"+1,",7)=RAITY
 . F RAI=.11,.21 S RAFDA(72,"+1,",RAI)="Y"
 . F RAI=.31,.32,.33,.34,.35,.36,.37,.38,.39,.311,.312,.313,.314,.315 S RAFDA(72,"+1,",RAI)="y"
 . D UPDATE^DIE("","RAFDA","","RAERR")
 . I $D(RAERR("DIERR")) D ERMSG72("CALLED FOR EXAM")
 . Q
 ;------------------ Exam Status: Examined -----------------------------
 I '$$XIST("EXAMINED",RAITY) D  ; Examined not filed.
 . K RAERR,RAFDA
 . S RAFDA(72,"+1,",.01)="EXAMINED",RAFDA(72,"+1,",7)=RAITY
 . F RAI=.11,.13,.14 S RAFDA(72,"+1,",RAI)="Y"
 . F RAI=.21,.23,.24,.26 S RAFDA(72,"+1,",RAI)="Y"
 . F RAI=.31,.32,.33,.34,.35,.36,.37,.38,.39,.311,.312,.313,.314,.315 S RAFDA(72,"+1,",RAI)="y"
 . D UPDATE^DIE("","RAFDA","","RAERR")
 . I $D(RAERR("DIERR")) D ERMSG72("EXAMINED")
 . Q
 ;------------------ Exam Status: Transcribed --------------------------
 I '$$XIST("TRANSCRIBED",RAITY) D  ; Transcribed not filed.
 . K RAERR,RAFDA
 . S RAFDA(72,"+1,",.01)="TRANSCRIBED",RAFDA(72,"+1,",7)=RAITY
 . F RAI=.11,.12,.13,.14,.15,.16,.111 S RAFDA(72,"+1,",RAI)="Y"
 . F RAI=.22,.25 S RAFDA(72,"+1,",RAI)="Y"
 . F RAI=.31,.32,.33,.34,.35,.36,.37,.38,.39,.311,.312,.313,.314,.315 S RAFDA(72,"+1,",RAI)="y"
 . D UPDATE^DIE("","RAFDA","","RAERR")
 . I $D(RAERR("DIERR")) D ERMSG72("TRANSCRIBED")
 . Q
 ;------------------ Exam Status: Complete -----------------------------
 I '($D(^RA(72,"AA","MAMMOGRAPHY",9))\10) D  ; Complete not filed.
 . K RAERR,RAFDA
 . S RAFDA(72,"+1,",.01)="COMPLETE"
 . S RAFDA(72,"+1,",3)=9,RAFDA(72,"+1,",7)=RAITY
 . F RAI=.11,.12,.13,.14,.15,.16 S RAFDA(72,"+1,",RAI)="Y"
 . F RAI=.111,.112,.116 S RAFDA(72,"+1,",RAI)="Y"
 . F RAI=.31,.32,.33,.34,.35,.36,.37,.38,.39,.311,.312,.313,.314 S RAFDA(72,"+1,",RAI)="y"
 . D UPDATE^DIE("","RAFDA","","RAERR")
 . I $D(RAERR("DIERR")) D ERMSG72("COMPLETE")
 . Q
 Q
 ;
ERMSG72(X) ; Display error message when an Exam Status is not filed.
 N Y
 S Y(1)=" ",Y(2)="Error filing `"_X_"' in the Examination Status (72) file.",Y(3)="IRM and the Radiology/Nuclear Medicine ADPAC should investigate."
 D MES^XPDUTL(.Y)
 Q
 ;
XIST(X,Y) ; Check if an Exam Status for a particular imaging type exists
 ; in file 72.
 ; Input: X-Exam Status, Y-imaging type (pointer)
 N I,XIT S (I,XIT)=0
 F  S I=$O(^RA(72,"B",X,I)) Q:I'>0  D  Q:XIT
 . S:$P($G(^RA(72,I,0)),"^",7)=Y XIT=1
 . Q
 Q XIT
 ;
EN2 ; For the HL7 Application Parameter (file 771) 'Radiology',
 ; change the 'ORU' HL7 Message processing routine from RAHLO
 ; to the new bridge routine RAHLBKVR.
 N %,D,D0,DA,DI,DIC,DIE,DQ,DR,RA771,RA77106,RATXT,X
 S RA771=+$$FIND1^DIC(771,"","X","RADIOLOGY")
 I 'RA771 D  Q  ; Can't find 'Radiology' in file 771.  Add to 771
 . S RATXT(1)=""
 . S RATXT(2)="Adding 'Radiology' to the HL7 Application Parameter file."
 . S RATXT(3)="Set the 'ORU' HL7 Message Processing Routine field to the"
 . S RATXT(4)="new bridge routine RAHLBKVR.  Set the 'QRY' HL7 Message"
 . S RATXT(5)="Processing Routine field to the new bridge routine"
 . S RATXT(6)="RAHLBKVQ." D MES^XPDUTL(.RATXT)
 . N RA771,RAFDA S RAFDA(771,"+1,",.01)="RADIOLOGY"
 . S RAFDA(771,"+1,",2)="INACTIVE"
 . S RAFDA(771.06,"+2,+1,",.01)="ACK"
 . S RAFDA(771.06,"+3,+1,",.01)="ORF"
 . S RAFDA(771.06,"+4,+1,",.01)="ORU"
 . S RAFDA(771.06,"+4,+1,",1)="RAHLBKVR"
 . S RAFDA(771.06,"+5,+1,",.01)="QRY"
 . S RAFDA(771.06,"+5,+1,",1)="RAHLBKVQ"
 . D UPDATE^DIE("E","RAFDA")
 . S RA771=+$$FIND1^DIC(771,"","X","RADIOLOGY")
 . I RA771 D  Q
 .. S ^HL(771,RA771,"EC")="~|\&" ; hard set the encoding char field
 .. S ^HL(771,RA771,"FS")="^" ; hard set the field seperator field
 .. Q
 . ; Display error message, 'RADIOLOGY' was not filed!
 . K RATXT S RATXT(1)=""
 . S RATXT(2)="'RADIOLOGY' could not be added as a HL7 Application"
 . S RATXT(3)="Parameter.  IRM should investigate." D MES^XPDUTL(.RATXT)
 . Q
 ; The 'RADIOLOGY' entry exists, make sure the right fields are
 ; populated with the right data.
 S:$G(^HL(771,RA771,"EC"))'="~|\&" ^("EC")="~|\&" ; set encoding chars
 S:$G(^HL(771,RA771,"FS"))'="~|\&" ^("FS")="^" ; set field seperator
 S RA77106("ACK")=$$FIND("ACK")
 I 'RA77106("ACK") D ADD("ACK")
 I RA77106("ACK") D
 . N RAFDA
 . S RAFDA(771.06,RA77106("ACK")_","_RA771_",",1)="@" ;no processing rou
 . D FILE^DIE("","RAFDA","")
 . Q
 ;
 S RA77106("ORF")=$$FIND("ORF")
 I 'RA77106("ORF") D ADD("ORF")
 I RA77106("ORF") D
 . N RAFDA
 . S RAFDA(771.06,RA77106("ORF")_","_RA771_",",1)="@" ;no processing rou
 . D FILE^DIE("","RAFDA","")
 . Q
 S RA77106("ORU")=+$$FIND1^DIC(771.06,","_RA771_",","X","ORU")
 I 'RA77106("ORU") D ADD("ORU")
 I RA77106("ORU") D
 . N RAFDA S RAFDA(771.06,RA77106("ORU")_","_RA771_",",1)="RAHLBKVR"
 . D FILE^DIE("","RAFDA","")
 . Q
 S RA77106("QRY")=+$$FIND1^DIC(771.06,","_RA771_",","X","QRY")
 I 'RA77106("QRY") D ADD("QRY")
 I RA77106("QRY") D
 . N RAFDA S RAFDA(771.06,RA77106("QRY")_","_RA771_",",1)="RAHLBKVQ"
 . D FILE^DIE("","RAFDA","")
 . Q
 Q
ADD(X) ; Add the HL7 Message to the 'RADIOLOGY' entry on the HL7 Application
 ; Parameter file.
 ; Input: 'X'-the HL7 Message we are trying to add
 ; Sets: RA77106('X')=the ien of the newly added HL7 Message 
 N RAFDA S RAFDA(771.06,"+1,"_RA771_",",.01)=X
 D UPDATE^DIE("E","RAFDA") S RA77106(X)=$$FIND(X)
 Q
FIND(X) ; Find the ien of the various HL7 Messages used by our HL7 Application
 ; Input: 'X'-the HL7 Message we are trying to find.
 ; Output: ien of the HL7 Message entry (if exists), else 0
 Q +$$FIND1^DIC(771.06,","_RA771_",","X",X)
