LA7VIN2A ;DALOI/JMC - Process Incoming UI Msgs, continued ;11/17/11  15:52
 ;;5.2;AUTOMATED LAB INSTRUMENTS;**74**;Sep 27, 1994;Build 229
 ;
 ;This routine is a continuation of LA7VIN2 and is only called from there.
 Q
 ;
NTE ; Process NTE segment
 ; NTE segments contain comments from instruments or other facilities.
 ; NTE segments following OBR's contain comments which refer to the entire test battery.
 ; NTE segments following OBX's contain comments which are test specific.
 ;
 ; For comments in ORU messages:
 ;  Test specific comments can be prefaced with a site defined prefix -
 ;  see field REMARK PREFIX (#19) in CHEM TEST multiple of AUTOMATED INSTRUMENT (#62.4 file.
 ;  There can be more than one NTE, each will be stored as a comment in ^LAH.
 ;
 N LA7,LA7CMTYP,LA7I,LA7NTE,LA7SOC,X,Y
 ;
 S LA7SOC=$$P^LA7VHLU(.LA7SEG,3,LA7FS)
 S LA7NTE=$$P^LA7VHLU(.LA7SEG,4,LA7FS)
 S LA7CMTYP=$$P^LA7VHLU(.LA7SEG,5,LA7FS)
 D FLD2ARR^LA7VHLU7(.LA7CMTYP,LA7FS_LA7ECH)
 ;
 ; Trim trailing spaces.
 I LA7NTE'="" S LA7NTE=$$TRIM^XLFSTR(LA7NTE,"R"," ")
 I LA7NTE="" S LA7NTE=" "
 ;
 I LA7MTYP="ORM" D OCOM Q
 ;
 ; Check for repeating comments in NTE segment and process
 ; If "^" in remark then translate to "~" to store.
 F LA7I=1:1:$L(LA7NTE,$E(LA7ECH,2)) D
 . S LA7RMK=$P(LA7NTE,$E(LA7ECH,2),LA7I)
 . I LA7RMK="" Q
 . S LA7RMK=$$UNESC^LA7VHLU3(LA7RMK,LA7FS_LA7ECH)
 . I LA7RMK["^" S LA7RMK=$TR(LA7RMK,"^","~")
 . I LA7MTYP="ORU" D RCOM Q
 . I LA7MTYP="ORR",$G(LA7OTYPE)="UA" D RCOM Q
 ;
 ; Clean up LA7RMK except for LA7RMK(0)
 K X M X=LA7RMK(0) K LA7RMK M LA7RMK(0)=X
 ;
 Q
 ;
 ;
RCOM ; Store result comments in ORU messages
 ;
 ; Check there's pointers to LAH
 I $G(LA7LWL)=""!($G(LA7ISQN)="") Q
 ;
 ; Don't store remark if same as specimen comment (without "~").
 I $G(LA7AA),$G(LA7AD),$G(LA7AN),LA7RMK=$TR($P($G(^LRO(68,LA7AA,1,LA7AD,1,LA7AN,3)),"^",6),"~") Q
 ; Or patient info (#.091 in file 63) - info previously downloaded
 I $G(LA7AA),$G(LA7AD),$G(LA7AN),LA7RMK=$G(^LR(+$G(^LRO(68,LA7AA,1,LA7AD,1,LA7AN,0)),.091)) Q
 ;
 ; If test specific, store comment prefix with comments (see LA7VIN5)
 I $G(LA7SS)="CH",$O(LA7RMK(0,0)) D  Q
 . N LA7I
 . S LA7I=0
 . F  S LA7I=$O(LA7RMK(0,LA7I)) Q:'LA7I  D
 . . I '$P(LA7RMK(0,LA7I),"^") Q
 . . ; Don't store if status not "FINAL"
 . . I $P(LA7RMK(0,LA7I),"^")=2,"CFUX"'[$G(LA7ORS) Q
 . . D RMKSET^LASET(LA7LWL,LA7ISQN,LA7RMK,$P(LA7RMK(0,LA7I),"^",2))
 ;
 ; Store comment in 1 node of ^LAH global
 I $G(LA7SS)="CH",$P(LA7624(0),"^",17) D RMKSET^LASET(LA7LWL,LA7ISQN,LA7RMK,"") Q
 ;
 ; Store "MI" subscript comments/remarks in specific places.
 ;  - Don't store comments from ORR messages - handled by mail bulletin
 I $G(LA7SS)="MI",LA7MTYP'="ORR" D  Q
 . N LA7ISQN2,LA7ISQN3,LA7ISQN4,LA7ND,LACONCPT,LAPREFIX
 . S (LA7ISQN2,LA7ISQN3,LA7ISQN4,LA7ND)=""
 . I $G(LA7CMTYP(3))="HL70364",$E($G(LA7CMTYP(1)),1,7)="VA-LRMI" D MISPC
 . S LACONCPT=$P($G(LA7RMK(0,0)),"^"),LAPREFIX=$P($G(LA7RMK(0,0)),"^",3)
 . D MICMT,UPD0
 ;
 ; Store AP subscripts comments/remarks in specific places.
 ; - Don't store comments from ORR messages - handled by mail bulletin
 I $G(LA7SS)'="","SPCYEM"[LA7SS,LA7MTYP'="ORR" D  Q
 . N LA7ISQN2,LAPREFIX
 . S LA7ND=99,LAPREFIX=$P($G(LA7RMK(0,0)),"^",3),(LA7ISQN2,LA7ISQN3,LA7ISQN4)=""
 . S LA7ISQN2=$O(^LAH(LA7LWL,1,LA7ISQN,LA7SS,99,"A"),-1)+1
 . S ^LAH(LWL,1,LA7ISQN,LA7SS,99,LA7ISQN2,0)=LAPREFIX_LA7RMK
 . D UPD0
 ;
 Q
 ;
 ;
OCOM ; Store order comments from ORM messages in file #69.6
 ; Check for repeating comments in NTE segment and process
 ; If "^" in remark then translate to "~" to store.
 ;
 ; If source of comment (LA7SOC) is "RQ" then comment is from CHCS which
 ; uses a composite data type for NTE-3. VistA only extracts component #9
 ; which contains the external value of the comment.
 ;
 N LA7DIE,LA7RMK,LA7WP,X
 I $G(LA7696)<1 Q
 F LA7I=1:1:$L(LA7NTE,$E(LA7ECH,2)) D
 . S LA7RMK=$P(LA7NTE,$E(LA7ECH,2),LA7I)
 . I LA7SOC="RQ" D
 . . S X=$P(LA7RMK,$E(LA7ECH),9)
 . . I X'="" S LA7RMK=X
 . I LA7RMK="" Q
 . S LA7RMK=$$UNESC^LA7VHLU3(LA7RMK,LA7FS_LA7ECH)
 . I LA7RMK["^" S LA7RMK=$TR(LA7RMK,"^","~")
 . S LA7WP(LA7I,0)=LA7RMK
 D WP^DIE(69.6,LA7696_",",99,"A","LA7WP","LA7DIE(99)")
 Q
 ;
 ;
MISPC ; Process special VistA Lab MI preliminary reports/test/remarks comment types
 ;
 N LA7I
 S LA7I=+$E(LA7CMTYP(1),8,99)
 ;
 ; Comment on Specimen: VA-LRMI001 node = 99
 ; Bacterial preliminary/report/tests remark: VA-LRMI010:VA-LRMI013 nodes = 4,19,26,25
 ; Parasite preliminary/report/tests remark: VA-LRMI020:VA-LRMI023 nodes = 7,21,27,24
 ; Fungal preliminary/report/tests remark: VA-LRMI030:VA-LRMI033 nodes = 10,22,28,15
 ; Mycobacteria preliminary/report/tests remark: VA-LRMI040:VA-LRMI042 nodes = 13,23,29
 ; Viral preliminary/report/tests remark: VA-LRMI050:VA-LRMI052 nodes = 18,20,30
 ; Sterility Results: VA-LRMI060 node = 31
 ;
 S LA7ND=$P("99^^^^^^^^^4^19^26^25^^^^^^^7^21^27^24^^^^^^^10^22^28^15^^^^^^^13^23^29^^^^^^^^18^20^30^^^^^^^^31","^",LA7I)
 ;
 Q
 ;
 ;
MICMT ; Store MI comments/remarks
 ; From above
 I LACONCPT=13 D  Q
 . S LA7ND=6,LA7ISQN2=$P($P(LA7RMK(0,0),"^",2),","),LA7ISQN3=$P($P(LA7RMK(0,0),"^",2),",",2)
 . S LA7ISQN4=$O(^LAH(LWL,1,LA7ISQN,"MI",6,LA7ISQN2,1,LA7ISQN3,1,"A"),-1)+1
 . S ^LAH(LWL,1,LA7ISQN,"MI",6,LA7ISQN2,1,LA7ISQN3,1,LA7ISQN4,0)=LAPREFIX_LA7RMK
 ;
 I LACONCPT=3!(LACONCPT=7)!(LACONCPT=10)!(LACONCPT=4) D  Q
 . S LA7ND=$S(LACONCPT=4:12,1:3)
 . S LA7ISQN2=$P($P(LA7RMK(0,0),"^",2),","),LA7ISQN3=$O(^LAH(LWL,1,LA7ISQN,"MI",LA7ND,LA7ISQN2,1,"A"),-1)+1
 . S ^LAH(LWL,1,LA7ISQN,"MI",LA7ND,LA7ISQN2,1,LA7ISQN3,0)=LAPREFIX_LA7RMK
 ;
 ; Store all other concepts here.
 I LA7ND="" S LA7ND=$S(LACONCPT<2:4,LACONCPT=12:7,LACONCPT=15:10,LACONCPT=22:13,LACONCPT=79:13,LACONCPT=85:13,LACONCPT=30:18,1:4)
 S LA7ISQN2=$O(^LAH(LWL,1,LA7ISQN,"MI",LA7ND,"A"),-1)+1
 S ^LAH(LWL,1,LA7ISQN,"MI",LA7ND,LA7ISQN2,0)=LAPREFIX_LA7RMK
 ;
 Q
 ;
 ;
UPD0 ; Update the remarks/comments zeroth node with status
 ;
 N LA7STAT,LA7PL,LA7X
 ;
 ; Attempt to identify performing lab from OBX-15 (NTE following OBX) or OBR-32 (NTE following OBR)
 S LA7PL=$G(LA7PRODID)
 I LA7PL="",$G(LA7OBR32(7))'="" S LA7PL=$$RESFID^LA7VHLU2(LA7OBR32(7),LA7SFAC,LA7CS)
 ;
 S LA7STAT=$S($G(LA7ORS)'="":LA7ORS,1:$G(LA7OBR25))
 ;
 I LA7ISQN4 D  Q
 . I LA7PL'="" S $P(^LAH(LWL,1,LA7ISQN,LA7SS,LA7ND,LA7ISQN2,1,LA7ISQN3,1,0),"^")=LA7PL
 . I $P($G(^LAH(LWL,1,LA7ISQN,LA7SS,LA7ND,LA7ISQN2,1,LA7ISQN3,0)),"^",4)'="" Q
 . I LA7STAT'="" S $P(^LAH(LWL,1,LA7ISQN,LA7SS,LA7ND,LA7ISQN2,1,LA7ISQN3,1,0),"^",4)=LA7STAT
 ;
 I LA7ISQN3 D  Q
 . I LA7PL'="" S $P(^LAH(LWL,1,LA7ISQN,LA7SS,LA7ND,LA7ISQN2,1,0),"^")=LA7PL
 . I $P($G(^LAH(LWL,1,LA7ISQN,LA7SS,LA7ND,LA7ISQN2,0)),"^",4)'="" Q
 . S $P(^LAH(LWL,1,LA7ISQN,LA7SS,LA7ND,LA7ISQN2,1,0),"^",4)=LA7STAT
 ;
 I LA7ISQN2 D  Q
 . I LA7PL'="" S $P(^LAH(LWL,1,LA7ISQN,LA7SS,LA7ND,0),"^")=LA7PL
 . I $P($G(^LAH(LWL,1,LA7ISQN,LA7SS,LA7ND,0)),"^",4)'="" Q
 . S $P(^LAH(LWL,1,LA7ISQN,LA7SS,LA7ND,0),"^",4)=LA7STAT
 Q
