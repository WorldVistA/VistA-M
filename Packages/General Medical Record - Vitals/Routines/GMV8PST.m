GMV8PST ;HIOFO/FT-POST-INSTALLATION FOR GMRV*5*8 ;5/3/05  11:48
 ;;5.0;GEN. MED. REC. - VITALS;**8**;Oct 31, 2002
 ;
 ; This routine uses the following IAs:
 ; #1157 - ^XPDMENU calls      (supported)
 ; #4639 - ^HDISVCMR calls     (supported)
 ; #4651 - ^HDISVF09 calls     (supported)
 ;
 ;
EN ; Driver subroutine
 D AHDRN,AHDRE
 D MENU,DEL,FIELD9,XREF1,XREF2,XREF3,ACCESS,KILL,HDIS
 Q
 ;
MENU ; Place vitals options out-of-order so they can no longer be used.
 N GMVOPT,GMVTXT
 S GMVOPT="GMRV VMSITE"
 S GMVTXT="Use the 'New Term Rapid Turnaround' process"
 D OUT^XPDMENU(GMVOPT,GMVTXT)
 Q
DEL ; Delete File 120.52, Field 999
 ; Get rid of data first
 N DA,DIE,DR
 S DA=0,DIE="^GMRD(120.52,",DR="999///@"
 F  S DA=$O(^GMRD(120.52,DA)) Q:'DA  D
 .D ^DIE
 .K ^GMRD(120.52,DA,"CONV")
 .Q
 ;get rid of field definition
 N DA,DIK
 S DIK="^DD(120.52,",DA=999,DA(1)=DA
 D ^DIK
 Q
FIELD9 ; Delete File 120.51, Field 9 (VITAL/MEASUREMENT) if it exists.
 ; Get rid of data first.
 N DA
 I $D(^DD(120.51,9,0)) D
 .S DA=0
 .F  S DA=$O(^GMRD(120.51,DA)) Q:'DA  D
 ..S $P(^GMRD(120.51,DA,0),U,8)=""
 ..Q
 .Q
 ;get rid of field definition
 N DA,DIK
 S DA=9 D
 .Q:'$D(^DD(120.51,DA,0))
 .S DIK="^DD(120.51,",DA(1)=DA
 .D ^DIK
 .Q
 Q
XREF1 ; Adds the AMASTERVUID index to file 120.51
 N GMVXR,GMVRES,GMVOUT
 S GMVXR("FILE")=120.51
 S GMVXR("NAME")="AMASTERVUID"
 S GMVXR("TYPE")="R"
 S GMVXR("USE")="S"
 S GMVXR("EXECUTION")="R"
 S GMVXR("ACTIVITY")="IR"
 S GMVXR("SHORT DESCR")="This cross-reference identifies the Master entry for a VUID."
 S GMVXR("DESCR",1)="If multiple entries have the same VUID in the file, this cross-refernce "
 S GMVXR("DESCR",2)="can be used to identify the Master entry for a VUID associated with a "
 S GMVXR("DESCR",3)="Term/Concept."
 S GMVXR("VAL",1)=99.99
 S GMVXR("VAL",1,"SUBSCRIPT")=1
 S GMVXR("VAL",1,"LENGTH")=30
 S GMVXR("VAL",1,"COLLATION")="F"
 S GMVXR("VAL",2)=99.98
 S GMVXR("VAL",2,"SUBSCRIPT")=2
 S GMVXR("VAL",2,"COLLATION")="F"
 D CREIXN^DDMOD(.GMVXR,"SW",.GMVRES,"GMVOUT")
 Q
XREF2 ; Adds the AMASTERVUID index to file 120.52
 N GMVXR,GMVRES,GMVOUT
 S GMVXR("FILE")=120.52
 S GMVXR("NAME")="AMASTERVUID"
 S GMVXR("TYPE")="R"
 S GMVXR("USE")="S"
 S GMVXR("EXECUTION")="R"
 S GMVXR("ACTIVITY")="IR"
 S GMVXR("SHORT DESCR")="This cross-reference identifies the Master entry for a VUID."
 S GMVXR("DESCR",1)="If multiple entries have the same VUID in the file, this cross-refernce "
 S GMVXR("DESCR",2)="can be used to identify the Master entry for a VUID associated with a "
 S GMVXR("DESCR",3)="Term/Concept."
 S GMVXR("VAL",1)=99.99
 S GMVXR("VAL",1,"SUBSCRIPT")=1
 S GMVXR("VAL",1,"LENGTH")=30
 S GMVXR("VAL",1,"COLLATION")="F"
 S GMVXR("VAL",2)=99.98
 S GMVXR("VAL",2,"SUBSCRIPT")=2
 S GMVXR("VAL",2,"COLLATION")="F"
 D CREIXN^DDMOD(.GMVXR,"SW",.GMVRES,"GMVOUT")
 Q
XREF3 ; Adds the AMASTERVUID index to file 120.53
 N GMVXR,GMVRES,GMVOUT
 S GMVXR("FILE")=120.53
 S GMVXR("NAME")="AMASTERVUID"
 S GMVXR("TYPE")="R"
 S GMVXR("USE")="S"
 S GMVXR("EXECUTION")="R"
 S GMVXR("ACTIVITY")="IR"
 S GMVXR("SHORT DESCR")="This cross-reference identifies the Master entry for a VUID."
 S GMVXR("DESCR",1)="If multiple entries have the same VUID in the file, this cross-refernce "
 S GMVXR("DESCR",2)="can be used to identify the Master entry for a VUID associated with a "
 S GMVXR("DESCR",3)="Term/Concept."
 S GMVXR("VAL",1)=99.99
 S GMVXR("VAL",1,"SUBSCRIPT")=1
 S GMVXR("VAL",1,"LENGTH")=30
 S GMVXR("VAL",1,"COLLATION")="F"
 S GMVXR("VAL",2)=99.98
 S GMVXR("VAL",2,"SUBSCRIPT")=2
 S GMVXR("VAL",2,"COLLATION")="F"
 D CREIXN^DDMOD(.GMVXR,"SW",.GMVRES,"GMVOUT")
 Q
ACCESS ; Set file access
 N GMVFILE,GMVNODE
 F GMVFILE=120.51,120.52,120.53 D
 .F GMVNODE="AUDIT","DD","DEL","LAYGO","WR" D
 ..S ^DIC(GMVFILE,0,GMVNODE)="@"
 ..Q
 .Q
 Q
KILL ; Kill left over x-ref node
 K ^DD(120.52,"IX",999)
 Q
HDIS ; Call HDIS to begin the 'seeding' process
 N DOMPTR,TMP
 S TMP=$$GETIEN^HDISVF09("VITALS",.DOMPTR)
 D EN^HDISVCMR(DOMPTR,"")
 Q
AHDRN ; Create AHDRNEW Index on GMRV Vital Measurement file (#120.5) for use
 ; by Health Data Repository (HDR)
 ; Calls HDR API whenever a new entry is made in FILE 120.5
 N GMVXR,GMVRES,GMVOUT
 S GMVXR("ACTIVITY")=""
 S GMVXR("FILE")=120.5
 S GMVXR("NAME")="AHDRNEW"
 S GMVXR("TYPE")="MU"
 S GMVXR("USE")="A"
 S GMVXR("EXECUTION")="F"
 S GMVXR("SHORT DESCR")="INDEX for HDR"
 S GMVXR("DESCR",1)="This cross-reference calls a Health Data Repository (HDR) API whenever a"
 S GMVXR("DESCR",2)="new entry is created."
 S GMVXR("DESCR",3)=" "
 S GMVXR("DESCR",4)="No actual cross-reference nodes are set or killed."
 S GMVXR("DESCR",5)=" "
 S GMVXR("DESCR",6)="Calls to the VDEFQM routine are covered by Integration Agreement 4253."
 S GMVXR("SET")="Q:$D(DIU(0))!($$TESTPAT^VADPT($P(^GMR(120.5,DA,0),U,2)))  N ERR,GMVFLAG I $T(QUEUE^VDEFQM)]"""" S GMVFLAG=$$QUEUE^VDEFQM(""ORU^R01"",""SUBTYPE=VTLS^IEN=""_DA,.ERR)"
 S GMVXR("KILL")="Q"
 S GMVXR("WHOLE KILL")="Q"
 S GMVXR("SET CONDITION")="I X1(1)="""",X2(1)'="""" S X=1"
 S GMVXR("VAL",1)=.02
 D CREIXN^DDMOD(.GMVXR,"k",.GMVRES,"GMVOUT")
 I GMVRES="" D
 .D BMES^XPDUTL("The AHDRNEW Index was not added to FILE 120.5. Please enter a Remedy ticket.")
 .Q
 Q
 ;
AHDRE ; Create AHDRERR Index on GMRV Vital Measurement file (#120.5) for use
 ; by Health Data Repository (HDR)
 ; Calls HDR API whenever a FILE 120.5 entry is marked as an error
 N GMVXR,GMVRES,GMVOUT
 S GMVXR("ACTIVITY")=""
 S GMVXR("FILE")=120.5
 S GMVXR("NAME")="AHDRERR"
 S GMVXR("TYPE")="MU"
 S GMVXR("USE")="A"
 S GMVXR("EXECUTION")="F"
 S GMVXR("SHORT DESCR")="INDEX for HDR"
 S GMVXR("DESCR",1)="This cross-reference calls a Health Data Repository (HDR) API whenever a"
 S GMVXR("DESCR",2)="FILE 120.5 entry is marked as entered-in-error."
 S GMVXR("DESCR",3)=" "
 S GMVXR("DESCR",4)="No actual cross-reference nodes are set or killed."
 S GMVXR("DESCR",5)=" "
 S GMVXR("DESCR",6)="Calls to the VDEFQM routine are covered by Integration Agreement 4253."
 S GMVXR("SET")="Q:$D(DIU(0))!($$TESTPAT^VADPT($P(^GMR(120.5,DA,0),U,2)))  N ERR,GMVFLAG I $T(QUEUE^VDEFQM)]"""" S GMVFLAG=$$QUEUE^VDEFQM(""ORU^R01"",""SUBTYPE=VTLS^IEN=""_DA,.ERR)"
 S GMVXR("KILL")="Q"
 S GMVXR("WHOLE KILL")="Q"
 S GMVXR("SET CONDITION")="I X1(1)="""",X2(1)]"""" S X=1"
 S GMVXR("VAL",1)=2
 D CREIXN^DDMOD(.GMVXR,"k",.GMVRES,"GMVOUT")
 I GMVRES="" D
 .D BMES^XPDUTL("The AHDRERR Index was not added to FILE 120.5. Please enter a Remedy ticket.")
 .Q
 Q
