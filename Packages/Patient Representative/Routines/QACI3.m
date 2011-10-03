QACI3 ; OAKOIFO/TKW - DATA MIGRATION - VISTALINK RPC CODE ;7/27/05  16:18
 ;;2.0;Patient Representative;**19**;07/25/1995;Build 55
EN(PATSBY,PATSNO,PATSLIST,PATSFLAG,PATSFRST) ;
 ; Read list of migrated reference table entries in PATSLIST, put into
 ;   ^XTMP. Then return the next PATSNO entries into global PATSBY,
 ;   from the table referrenced by PATSFLAG.
 ; PATSBY = the name of the output global
 ; PATSNO = the number of records to return
 ; PATSLIST = If defined, contains a list of ^ delimited strings
 ;     0 node set to a flag indicating which file these came from.
 ;     The other entries contain two pieces:
 ;     1)ien or primary key of the entry on the M VistA side
 ;     2)primary key of the entry in the Oracle table (usually id).
 ; PATSFLAG="H" (hospital location), "U" (user), "P" (patient),
 ;  "C" (congressional contact), "E" (employee involved),
 ;  "F" (facility service or section)
 ; PATSFRST = 1 on the first call to this routine, 0 on subsequent calls.
 ;
 ; Process incoming list
 N FLAG,TYPE,UNAME,DONENAME
 S PATSNO=+$G(PATSNO),PATSFRST=+$G(PATSFRST)
 ; For the incoming list, find the file type on the first array entry.
 S FLAG=$P($G(PATSLIST(0)),"^"),TYPE=""
 I FLAG]"" S TYPE=$S(FLAG="H":"HL",FLAG="U":"USER",FLAG="P":"PT",FLAG="C":"CC",FLAG="E":"EMPINV",FLAG="F":"FSOS",1:"")
 ; Move list of migrated entries to ^XTMP("QACMIGR",file_type,"D").
 ;  at the same time, delete them from the list of entries still to be
 ;  migrated, ^XTMP("QACMIGR",file_type,"U").
 I TYPE]"" D
 . S UNAME=$NA(^XTMP("QACMIGR",TYPE,"U"))
 . S DONENAME=$NA(^XTMP("QACMIGR",TYPE,"D"))
 . D LISTIN Q
 ; Now get the next set of entries to be migrated, for the table
 ;  referenced by the PATSFLAG input parameter.
 S FLAG=$G(PATSFLAG)
 S TYPE=$S(FLAG="H":"HL",FLAG="U":"USER",FLAG="P":"PT",FLAG="C":"CC",FLAG="E":"EMPINV",FLAG="F":"FSOS",1:"")
 Q:TYPE=""
 S UNAME=$NA(^XTMP("QACMIGR",TYPE,"U"))
 S PATSBY=$NA(^TMP(TYPE,$J))
 ; Build the next list of entries to be migrated.
 D LISTOUT
 Q
 ;
LISTIN ; Move Ids of migrated data entries into ^XTMP
 N I,X,CNT S CNT=0
 F I=0:0 S I=$O(PATSLIST(I)) Q:'I  S X=PATSLIST(I) D
 . S Y=$P(X,"^"),X=$P(X,"^",2)
 . ; If entry not added to Oracle table, quit
 . Q:X=""
 . ; Else, kill 'unmigrated' entry, set 'migrated' entry
 . K @UNAME@(Y)
 . S @DONENAME@(Y)=X
 . S CNT=CNT+1 Q
 ; If no data left in table of entries to be migrated, kill it.
 I '$O(@UNAME@(0)) K @UNAME
 I CNT>0 D
 . ; Increment count of migrated entries
 . S @DONENAME=$G(@DONENAME)+CNT
 . Q:'$O(@UNAME@(0))
 . ; Decrement count of entries to be migrated.
 . S @UNAME=$G(@UNAME)-CNT
 . Q
 Q
 ;
LISTOUT ; Build next set of data to be migrated into ^TMP global
 K @PATSBY
 N CNT,I,X,XOUT
 ; On the first time calling this routine, check.
 S XOUT=0 I PATSFRST=1 D  Q:XOUT
 . ; If no data in staging area, return 0 in 0th node
 . S CNT=0 F I="ROC","HL","USER","PT","CC","EMPINV","FSOS" D
 .. S CNT=CNT+$G(^XTMP("QACMIGR",I,"U")) Q
 . I CNT=0 S @PATSBY@(0)=0,XOUT=1
 . Q
 ; If no data to migrate in the current table, return nothing
 ;  in the output array.
 Q:'$O(@UNAME@(0))
 S CNT=0
 ; For Facility Service or Section, set VISN name into first entry of output array.
 ; For Users or Employees Involved, put station number for server into first entry of output array.
 I "F^U^E"[FLAG,$O(@UNAME@(0)) D
 . S CNT=1,PATSNO=PATSNO+1
 . S @PATSBY@(1)=$G(^XTMP("QACMIGR",TYPE,"U",0))
 . Q
 ; Move data to be migrated into output global.
 F I=0:0 S I=$O(@UNAME@(I)) Q:'I  Q:PATSNO&(CNT=PATSNO)  S X=^(I) D
 . S CNT=CNT+1
 . S @PATSBY@(CNT)=X
 . Q:FLAG'="P"
 . ; Load continuation patient data
 . S CNT=CNT+1
 . S @PATSBY@(CNT)=@UNAME@(I,"cont")
 . Q
 Q
 ;
 ;
