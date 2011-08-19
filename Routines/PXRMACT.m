PXRMACT ; SLC/PJH - Activity File Update ;06/03/1999
 ;;2.0;CLINICAL REMINDERS;;Feb 04, 2005
 ;
 ; This is a bit ruff 'cos we don't have a file to update yet
 ;
 ;Initialize fields
START N PXRMITEM,DFN,ADATE,ATYPE,RDATE,EDATE,STATUS,NDATE,ROLL,EPROC,AEDATE
 N PSEX,AAGE,DOD,AFAC,HLOC,SPEC,CSTOP,CSEX,MINAGE,MAXAGE
 ;
 ;Get patient cache items
 D CACHE
 ;Get finding items
 D FIND
 ;Update Activity file
 D UPD
 ;
END Q
 ;
 ;Get Cache items
 ;---------------
CACHE Q
 ;
 ;Get Finding Items
FIND Q
 ;
 ;Create activity record - file #801 ??
 ;-------------------------------------
UPD N ARRAY,DATA,DESC,IEN,STRING,SUB,TAG,FDA,FDAIEN
 ;Get each reminder in turn
 S STRING="Building activity record"
 D BMES^XPDUTL(STRING)
 ;Build FDA array
 K FDAIEN,FDA
 S FDA(801,"+1,",.01)=PXRMITEM
 S FDA(801,"+1,",.02)=DFN
 S FDA(801,"+1,",.03)=ADATE
 S FDA(801,"+1,",.04)=ATYPE
 S FDA(801,"+1,",.05)=RDATE
 S FDA(801,"+1,",.06)=EDATE
 S FDA(801,"+1,",.07)=STATUS
 S FDA(801,"+1,",.08)=NDATE
 S FDA(801,"+1,",.09)=ROLL
 S FDA(801,"+1,",.1)=EPROC
 S FDA(801,"+1,",.11)=AEDATE
 S FDA(801,"+1,",2.01)=PSEX
 S FDA(801,"+1,",2.02)=AAGE
 S FDA(801,"+1,",2.03)=DOD
 S FDA(801,"+1,",4.01)=AFAC
 S FDA(801,"+1,",4.02)=HLOC
 S FDA(801,"+1,",4.03)=SPEC
 S FDA(801,"+1,",4.04)=CSTOP
 S FDA(801,"+1,",7.01)=CSEX
 S FDA(801,"+1,",7.02)=MINAGE
 S FDA(801,"+1,",7.03)=MAXAGE
 ;
 ;Store findings multiple(s)
 N CNT S CNT=0
 D MFDA(801.002,"?","?")
 D MFDA(801.002,"?","?")
 D MFDA(801.002,"?","?")
 D MFDA(801.002,"?","?")
 D MFDA(801.002,"?","?")
 ;
 S FDA(801,"+1,",200.1)="?"
 D UPDATE^DIE("","FDA","FDAIEN","MSG")
 I $D(MSG) D ERR
 Q
 ;
MFDA(FILE,FIELD,DATA) ;
 I FIELD=".01" S CNT=CNT+1
 S FDA(FILE,"+"_CNT_",?1,",FIELD)=DATA
 Q
 ;
 ;Error Handler
 ;-------------
ERR N ERROR,IC,REF
 S ERROR(1)="Error in UPDATE^DIE, needs further investigation"
 ;Move MSG into ERROR
 S REF="MSG"
 F IC=2:1 S REF=$Q(@REF) Q:REF=""  S ERROR(IC)=REF_"="_@REF
 ;Screen message
 D BMES^XPDUTL(.ERROR)
 ;Mail Message - this should become a standard facility
 ;D ERR^PXRMPV1E(.ERROR)
 Q
