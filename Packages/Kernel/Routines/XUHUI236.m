XUHUI236 ;SFISC/SO- Post Install for Patch 236, Install Xrefs ;1:40 PM  7 Jun 2002
 ;;8.0;KERNEL;**236**;Jul 10, 1995
 ;START - IA #3591
 D HUI200
 D HUIKEY
 Q
 ;
HUI200 ;INSTALL 'AXUHUI' CROSS-REFERENCE
 N HUIFDA,HUIERR,HUIWP
 S X="Adding 'AXUHUI' new style cross-reference..." D MES^XPDUTL(X)
 S HUIFDA(.11,"+1,",.01)=200 ;FILE NUMBER
 S HUIFDA(.11,"+1,",.02)="AXUHUI" ;X-REF NAME
 S HUIFDA(.11,"+1,",.11)="Hui Project Top File Xref" ;SHORT DESC.
 S HUIFDA(.11,"+1,",.2)="MU" ;TYPE
 S HUIFDA(.11,"+1,",.4)="R" ;EXECUTION
 S HUIFDA(.11,"+1,",.5)="I" ;ROOT TYPE
 S HUIFDA(.11,"+1,",.51)=200 ;ROOT FILE
 S HUIFDA(.11,"+1,",.42)="A" ;USE
 S HUIFDA(.11,"+1,",1.1)="D HUI^XUHUI("""",""XUHUI FIELD CHANGE EVENT"","""",""AXUHUI"") Q" ;SET LOGIC
 S HUIFDA(.11,"+1,",2.1)="Q" ;KILL LOGIC
 S HUIFDA(.11,"+1,",2.5)="Q" ;WHOLE FILE KILL
 ;
 ; CROSS REFERENCE VALUES
 ;===========================================
 S HUIFDA(.114,"+2,+1,",.01)=1 ;ORDER NUMBER
 S HUIFDA(.114,"+2,+1,",1)="F" ;TYPE OF VALUE
 S HUIFDA(.114,"+2,+1,",2)=200 ;FILE NUMBER
 S HUIFDA(.114,"+2,+1,",3)=.01 ;FIELD NUMBER
 S HUIFDA(.114,"+2,+1,",7)="F" ;COLLATION
 ;===========================================
 S HUIFDA(.114,"+3,+1,",.01)=2 ;ORDER NUMBER
 S HUIFDA(.114,"+3,+1,",1)="F" ;TYPE OF VALUE
 S HUIFDA(.114,"+3,+1,",2)=200 ;FILE NUMBER
 S HUIFDA(.114,"+3,+1,",3)=9.2 ;FIELD NUMBER
 S HUIFDA(.114,"+3,+1,",7)="F" ;COLLATION
 ;===========================================
 S HUIFDA(.114,"+4,+1,",.01)=3 ;ORDER NUMBER
 S HUIFDA(.114,"+4,+1,",1)="F" ;TYPE OF VALUE
 S HUIFDA(.114,"+4,+1,",2)=200 ;FILE NUMBER
 S HUIFDA(.114,"+4,+1,",3)=5 ;FIELD NUMBER
 S HUIFDA(.114,"+4,+1,",7)="F" ;COLLATION
 ;==========================================
 S HUIFDA(.114,"+5,+1,",.01)=4 ;ORDER NUMBER
 S HUIFDA(.114,"+5,+1,",1)="F" ;TYPE OF VALUE
 S HUIFDA(.114,"+5,+1,",2)=200 ;FILE NUMBER
 S HUIFDA(.114,"+5,+1,",3)=9 ;FIELD NUMBER
 S HUIFDA(.114,"+5,+1,",7)="F" ;COLLATION
 D UPDATE^DIE("","HUIFDA","","HUIERR")
 I $D(DIERR) D ERR Q
 ;SET DESCRIPTION ARRAY
 N VAL,HUIIEN
 S VAL(1)=200,VAL(2)="AXUHUI"
 S HUIIEN=$$FIND1^DIC(.11,"","X",.VAL,"BB","","HUIERR")
 I $D(DIERR) D ERR Q
 S HUIWP(1)="This new style cross-reference is on non-multiple fields that the Hui"
 S HUIWP(2)="project want to monitor for a change in value (Patch XU*8*236). The"
 S HUIWP(3)="following fields are being monitored in order:"
 S HUIWP(4)=" "
 S HUIWP(5)=" .01 (NAME)"
 S HUIWP(6)=" 9.2 (TERMINATION DATE)"
 S HUIWP(7)=" 5 (DOB)"
 S HUIWP(8)=" 9 (SSN)"
 D WP^DIE(.11,HUIIEN_",",.1,"","HUIWP") ;LONG DESCRIPTION
 S X="Finished adding 'AXUHUI' cross-reverence." D MES^XPDUTL(X)
 S X="Updating any Triggers for cross-reference 'AXUHUI'..." D MES^XPDUTL(X)
 N XR
 S XR(200,.01)="" ;Name
 S XR(200,9.2)="" ;Termination Date
 S XR(200,5)="" ;Date Of Birth
 S XR(200,9)="" ;SSN
 D TRIG^DICR(.XR) ;IA# 3405
 S X="Finished Updating any Trigers for cross-reference 'AXUHUI'." D MES^XPDUTL(X)
 Q
 ;
HUIKEY ;INSTALL 'AXUHUIKEY' CROSS-REFERENCE
 N HUIFDA,HUIERR,HUIWP
 S X="Adding 'AXUHUIKEY' new style cross-reference..." D MES^XPDUTL(X)
 S HUIFDA(.11,"+1,",.01)=200 ;FILE NUMBER
 S HUIFDA(.11,"+1,",.02)="AXUHUIKEY" ;X-REF NAME
 S HUIFDA(.11,"+1,",.11)="HUI key xref" ;SHORT DESC.
 S HUIFDA(.11,"+1,",.2)="MU" ;TYPE
 S HUIFDA(.11,"+1,",.4)="R" ;EXECUTION
 S HUIFDA(.11,"+1,",.5)="W" ;ROOT TYPE
 S HUIFDA(.11,"+1,",.51)=200.051 ;ROOT FILE
 S HUIFDA(.11,"+1,",.42)="A" ;USE
 S HUIFDA(.11,"+1,",1.1)="D HUIKEY^XUHUI("""",""XUHUI FIELD CHANGE EVENT"","""",""AXUHUIKEY"") Q" ;SET LOGIC
 S HUIFDA(.11,"+1,",2.1)="D HUIKEY^XUHUI("""",""XUHUI FIELD CHANGE EVENT"",""K"",""AXUHUIKEY"") Q" ;KILL LOGIC
 S HUIFDA(.11,"+1,",2.5)="Q" ;WHOLE FILE KILL
 ;
 ;CROSS REFERENCE VALUES
 ;=================================================
 S HUIFDA(.114,"+2,+1,",.01)=1 ;ORDER NUMBER
 S HUIFDA(.114,"+2,+1,",1)="F" ;TYPE OF VALUE
 S HUIFDA(.114,"+2,+1,",2)=200.051 ;FILE NUMBER
 S HUIFDA(.114,"+2,+1,",3)=.01 ;FIELD NUMBER
 S HUIFDA(.114,"+2,+1,",7)="F" ;COLLATION
 ;
 ;FILE THE 'AXUHUIKEY' XREF
 D UPDATE^DIE("","HUIFDA","","HUIERR")
 I $D(DIERR) D ERR Q
 ;SET DESCRIPTION ARRAY
 N VAL,HUIIEN
 S VAL(1)=200,VAL(2)="AXUHUIKEY"
 S HUIIEN=$$FIND1^DIC(.11,"","X",.VAL,"BB","","HUIERR")
 I $D(DIERR) D ERR Q
 S HUIWP(1)="This new style cross-reference is on the multiple: 'KEYS' so the Hui"
 S HUIWP(2)="project can monitor the allocation/de-allocation of the 'PROVIDER'"
 S HUIWP(3)="key."
 D WP^DIE(.11,HUIIEN_",",.1,"","HUIWP") ;LONG DESCRIPTION
 S X="Finished adding 'AXUHUIKEY' new style cross-reference." D MES^XPDUTL(X)
 S X="Updating any triggers for new style cross-reference 'AXUHUIKEY'." D MES^XPDUTL(X)
 N XR
 S XR(200.051,.01)="" ;Name
 D TRIG^DICR(.XR) ;IA #3405
 S X="Finished updating triggers for 'AXUHUIKEY' cross-reference." D MES^XPDUTL(X)
 S X="Post installed finished." D MES^XPDUTL(X)
 Q
 ;
ERR ;ERROR PROCESSING
 N I S I=""
 F  S I=$O(HUIERR("DIERR",1,"TEXT",I)) Q:I=""  D
 . D MES^XPDUTL(HUIERR("DIERR",1,"TEXT",I))
 D CLEAN^DILF
 Q
