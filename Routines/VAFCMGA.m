VAFCMGA ;ALB/JRP,LTL-DEMOGRAPHIC MERGE SCREEN ACTIONS ;31-OCT-96
 ;;5.3;Registration;**149,477,479**;Aug 13, 1993
 ;
 ;NOTE: The VAFCMGA* routines contain line tags used to implement
 ;      the actions of a List Manager user interface.  All line
 ;      tags assume that the following variables and arrays are
 ;      defined.
 ;
 ;Input  : VAFCDFN - Pointer to entry in PATIENT file (#2) to merge
 ;                   data into
 ;         VAFCARR - Array contain data to merge (full global reference)
 ;                   VAFCARR() should be set as follows:
 ;                     VAFCARR(File,Field) = Value
 ;                       Where File = File number Value is from
 ;                             Field = Field number Value is from
 ;                             Value = Info to merge
 ;                       Notes: Dates must be in FileMan format
 ;                            : Special considerations for Value
 ;                                "@"  - Displays <DELETE> and deletes
 ;                                       local value if merged
 ;                                "^text"  - Displays text and ignores
 ;                                           field if merged
 ;                                NULL  - Displays <UNSPECIFIED> and
 ;                                        ignores field if merged
 ;                                Doesn't exist  - Displays <UNSPECIFIED>
 ;                                                 and ignores field
 ;                                                 if merged
 ;         VAFCFROM - Text denoting where merge data cam from (1-35)
 ;         VAFCEVDT - Date/time merge data was instantiated (FileMan)
 ;         All variables set by List Manager Interface
 ;         Display area and variables required List Manager interface
 ;         Display
 ;           VALMAR(Line,0) = Line of text in display
 ;         Indexes
 ;           VALMAR("IDX",Line,Entry) = ""
 ;           VALMAR("E2F",Entry,N) = File^Field
 ;             N => Allows for multiple fields per entry (starts with 1)
 ;           VALMAR("E2G",Entry) = Group entry is contained in
 ;           VALMAR("GRP",Group) = First line of group in display
 ;             Note: The E2F and E2G indexes are only set if the data
 ;                   to merge does not match the local data
 ;
MRGALL ;Merge all differences
 ;
 ;Input  : See above note on input variables
 ;Output : VALMAR() array will be rebuilt accordingly
 ;
 ;Declare variables
 N VAFCDOTS,ENTRY,REBUILD,FILE,FIELD,VALUE,REPEAT
 N TMP,IENS,FDAROOT,MSGROOT,QUOTE
 S FDAROOT="^TMP(""VAFC-MERGE-UPLOAD"","_$J_",""FDA"")"
 S MSGROOT="^TMP(""VAFC-MERGE-UPLOAD"","_$J_",""MSG"")"
 S QUOTE=$C(34)
 S IENS=VAFCDFN_","
 K @FDAROOT,@MSGROOT
 ;Build array of differences to merge
 N DGNOFDEL S DGNOFDEL=1 ;**477 stop NOK Name x-ref from firing.
 NEW EASZIPLK S EASZIPLK=1 ;**477 zipcode lookup for GMT
 S ENTRY=""
 F  S ENTRY=$O(@VALMAR@("E2F",ENTRY)) Q:(ENTRY="")  D
 .;Remember which group(s) to rebuild
 .S TMP=$G(@VALMAR@("E2G",ENTRY))
 .S:(TMP'="") REBUILD(TMP)=""
 .;Loop through list of fields contained in the entry
 .S REPEAT=""
 .F  S REPEAT=$O(@VALMAR@("E2F",ENTRY,REPEAT)) Q:(REPEAT="")  D
 ..S TMP=$G(@VALMAR@("E2F",ENTRY,REPEAT))
 ..S FILE=+$P(TMP,"^",1)
 ..S FIELD=+$P(TMP,"^",2)
 ..;Get remote value
 ..S VALUE=$G(@VAFCARR@(FILE,FIELD))
 ..;Screen for ignore conditions
 ..I $P(VALUE,U,3) S VALMSG=$S($G(VALMSG)]"":VALMSG_","_ENTRY,1:"Can't merge unresolved item(s) "_ENTRY) Q
 ..S VALUE=$P(VALUE,U)
 ..Q:(VALUE="")
 ..;Convert "@" to @
 ..S:(VALUE=(QUOTE_"@"_QUOTE)) VALUE="@"
 ..;Move data into upload array
 ..;I $S(ENTRY=6:0,ENTRY=7:0,ENTRY=9:0,1:1) S @FDAROOT@(FILE,IENS,FIELD)=VALUE ;let zipcode populate city, state and county for merge all ;**477 for GMT ;**479 address removed
 .. S @FDAROOT@(FILE,IENS,FIELD)=VALUE ;**479 address removed - allow merge
 ..;Prepare for undo
 ..S ^TMP("VAFC-UNDO",$J,"FDA",FILE,IENS,FIELD)=$$GET1^DIQ(FILE,IENS,FIELD)
 ;Merge differences
 I (+$O(@FDAROOT@(0))) D FILE^DIE("E",FDAROOT,MSGROOT)
 ;Rebuild required portion of display
 S VAFCDOTS=1
 S ENTRY=""
 F  S ENTRY=$O(REBUILD(ENTRY)) Q:(ENTRY="")  D RBLDGRP^VAFCMGB(ENTRY)
 ;No more differences
 S:('$D(@VALMAR@("E2F"))) VALMSG="** No differences found **"
 ;Done - refresh List Manager display
 S VALMBCK="R"
 Q
MRGSLCT ;Merge user selected differences
 ;
 ;Input  : See above note on input variables
 ;Output : Modified areas of VALMAR() array will be rebuilt accordingly
 ;
 ;Declare variables
 N VAFCDOTS,ENTRY,REBUILD,VALMY,FILE,FIELD,REPEAT
 N TMP,IENS,FDAROOT,MSGROOT,QUOTE,UNDO
 S QUOTE=$C(34)
 S FDAROOT="^TMP(""VAFC-MERGE-UPLOAD"","_$J_",""FDA"")"
 S MSGROOT="^TMP(""VAFC-MERGE-UPLOAD"","_$J_",""MSG"")"
 S IENS=VAFCDFN_","
 K @FDAROOT,@MSGROOT
 ;Prompt user for entries to merge
 D EN^VALM2($G(XQORNOD(0)),"O")
 ;Build array of data selected for merging
 N DGNOFDEL S DGNOFDEL=1 ;**477 stop NOK Name x-ref from firing.
 NEW EASZIPLK S EASZIPLK=1 ;**477 zipcode lookup for GMT
 ;I $D(VALMY(8)) F ENTRY=6,7,9 I '$D(VALMY(ENTRY)) S VALMY(ENTRY)="",UNDO(ENTRY)="" ;prepare to undo city, state and county if zip selected ;**477 for GMT ;**479 address removed
 S ENTRY=""
 F  S ENTRY=$O(VALMY(ENTRY)) Q:(ENTRY="")  D
 .;Remember which group(s) to rebuild
 .S TMP=$G(@VALMAR@("E2G",ENTRY))
 .S:(TMP'="") REBUILD(TMP)=""
 .;Loop through list of fields contained in the entry
 .S REPEAT=""
 .F  S REPEAT=$O(@VALMAR@("E2F",ENTRY,REPEAT)) Q:(REPEAT="")  D
 ..S TMP=$G(@VALMAR@("E2F",ENTRY,REPEAT))
 ..S FILE=+$P(TMP,"^",1)
 ..S FIELD=+$P(TMP,"^",2)
 ..;Get remote value
 ..S VALUE=$G(@VAFCARR@(FILE,FIELD))
 ..;Screen for ignore conditions
 ..I $P(VALUE,U,3) S VALMSG=$S($G(VALMSG)]"":VALMSG_","_ENTRY,1:"Can't merge unresolved item(s) "_ENTRY) Q
 ..S VALUE=$P(VALUE,U)
 ..Q:(VALUE="")
 ..;Convert "@" to @
 ..S:(VALUE=(QUOTE_"@"_QUOTE)) VALUE="@"
 ..;Move data into upload array
 ..I '$D(UNDO(ENTRY)) S @FDAROOT@(FILE,IENS,FIELD)=VALUE ;**477 for GMT
 ..;Prepare for undo
 ..S ^TMP("VAFC-UNDO",$J,"FDA",FILE,IENS,FIELD)=$$GET1^DIQ(FILE,IENS,FIELD)
 ;Merge selected data BUT don't transmit until merge completed or rejected
 I (+$O(@FDAROOT@(0))) S VAFCA08=1 D FILE^DIE("E",FDAROOT,MSGROOT) K VAFCA08
 ;Rebuild required portion of display
 S VAFCDOTS=1
 S ENTRY=""
 F  S ENTRY=$O(REBUILD(ENTRY)) Q:(ENTRY="")  D RBLDGRP^VAFCMGB(ENTRY)
 ;No more differences
 S:('$D(@VALMAR@("E2F"))) VALMSG="** No differences found **"
 ;Done - refresh List Manager display
 K @FDAROOT,@MSGROOT
 S VALMBCK="R"
 Q
 ;
COMPLETE ;Merge process completed ;**477 always prompt for merge, add verbage
 ;
 ;Input  : See above note on input variables
 ;Output : VAFCDONE will be set to '1'
 ;
 ;Declare variables
 N DIR,X,Y
 S VAFCDONE=1
 D FULL^VALM1 ;switch to full screen
 I ($D(@VALMAR@("E2F"))) D  ;check for differences
 .S DIR("A",7)="      ** Differences still exist between local and remote data **" ;check for differences
 .S DIR("A",8)=" "
 ;Make sure user is really done with merge process
 S DIR(0)="YA"
 S DIR("A",1)=" "
 S DIR("A",2)="NOTE: Since your site is the CMOR, you are considered to be the"
 S DIR("A",3)="      authoritative source.  By completing the merge, you confirm that"
 S DIR("A",4)="      your facility's NAME, SEX, DOB, SSN and MOTHER'S MAIDEN NAME are"
 S DIR("A",5)="      accurate for broadcast to all facilities sharing this patient."
 S DIR("A",6)=" "
 S DIR("A")="Are you ready to complete the merge process? (Yes/No) : "
 S DIR("B")="YES"
 D ^DIR
 S VAFCDONE=+Y
 ;User not done
 I ('VAFCDONE) S VALMBCK="R" Q
 ;  Create an entry in the ADT/HL7 PIVOT file (#391.71) and
 ;  mark it as requiring transmission of an HL7 ADT-A08 message
 D AVAFC^VAFCDD01(VAFCDFN)
 ;Done - quit List Manager interface
 S VALMBCK="Q"
 Q
 ;
REJECT ;Reject/ignore differences ;**477 add verbage
 ;
 ;Input  : See above note on input variables
 ;Output : VAFCRJCT will be set to '1'
 ;
 ;Declare variables
 N DIR,X,Y
 S VAFCRJCT=1
 ;Switch to full screen
 D FULL^VALM1
 ;Make sure user really wants to reject differences
 S DIR(0)="YA"
 S DIR("A",1)=" "
 S DIR("A",2)="NOTE: Since your site is the CMOR, you are considered to be the"
 S DIR("A",3)="      authoritative source.  By rejecting the remote data, you confirm"
 S DIR("A",4)="      that your facility's NAME, SEX, DOB, SSN and MOTHER'S MAIDEN NAME"
 S DIR("A",5)="      are accurate for broadcast to all facilities sharing this patient."
 S DIR("A",6)=" "
 S DIR("A")="Are you sure you want to reject the remote data? (Yes/No) : "
 S DIR("B")="YES"
 D ^DIR
 S VAFCRJCT=+Y
 ;Don't reject
 I ('VAFCRJCT) S VALMBCK="R" Q
 ;  Create an entry in the ADT/HL7 PIVOT file (#391.71) and
 ;  mark it as requiring transmission of an HL7 ADT-A08 message
 D AVAFC^VAFCDD01(VAFCDFN)
 ;Done - quit List Manager interface
 S VALMBCK="Q"
 Q
HI ;Hinq Inquiry
 S DFN=VAFCDFN
 D HINQ^DG10 S VALMBCK=""
 ;D EN^DVBHQZ4 S VALMBCK=""
 ;S VALMSG="Hinq request has "_$S($D(^DVB(395.5,DFN,0))&("PNEA"[$P($G(^DVB(395.5,DFN,0)),U,4)):"",1:"NOT ")_"been made for this patient."
HIQ Q
PA ;Patient Audit
 Q  ;**477 - no longer in use replaced by remote audit protcols
 I '$O(^DIA(2,"B",VAFCDFN,0)) S VALMSG="This patient has no audit data available.",VALMBCK="" G PAQ
 N IEN S DFN=VAFCDFN,QFLG=1 D FULL^VALM1 D:$T(ASK2^RGMTAUD)]"" ASK2^RGMTAUD S VALMBCK="R"
PAQ Q
