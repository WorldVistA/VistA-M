GMV2PST ;HIOFO/FT-Create Indexes for HDR ;10/7/04  17:06
 ;;5.0;GEN. MED. REC. - VITALS;**2**;Oct 31, 2002
 ;
 ; This routine uses the following IAs:
 ; #10141 - ^XPDUTL calls      (supported)
 ;
EN ; Driver subroutine
 D AHDRN,AHDRE
 Q
 ;
AHDRN ; Create AHDRNEW Index on GMRV Vital Measurement file (#120.5) for use
 ; by Health Data Repository (HDR)
 ; Calls HDR API whenever a new entry is made in FILE 120.5
 N MSG,RESULT,XREF
 D BMES^XPDUTL("Creating AHDRNEW Index on GMRV VITAL MEASUREMENT (#120.5) file.")
 S XREF("ACTIVITY")=""
 S XREF("FILE")=120.5
 S XREF("ROOT FILE")=120.5
 S XREF("TYPE")="MU"
 S XREF("SHORT DESCR")="INDEX for HDR"
 S XREF("DESCR",1)="This cross-reference calls a Health Data Repository (HDR) API whenever a"
 S XREF("DESCR",2)="new entry is created."
 S XREF("DESCR",3)=" "
 S XREF("DESCR",4)="No actual cross-reference nodes are set or killed."
 S XREF("DESCR",5)=" "
 S XREF("DESCR",6)="Calls to the VDEFQM routine are covered by Integration Agreement 4253."
 S XREF("USE")="ACTION"
 S XREF("EXECUTION")="F"
 S XREF("WHOLE KILL")="Q"
 S XREF("VAL",1)=.01
 S XREF("NAME")="AHDRNEW"
 S XREF("SET")="Q:$D(DIU(0))  N ERR,GMVFLAG I $T(QUEUE^VDEFQM)]"""" S GMVFLAG=$$QUEUE^VDEFQM(""ORU^R01"",""SUBTYPE=VTLS^IEN=""_DA,.ERR)"
 S XREF("KILL")="Q"
 S XREF("SET CONDITION")="S:X1(1)="""" X=1"
 D CREIXN^DDMOD(.XREF,"k",.RESULT,"","MSG")
 I RESULT="" D
 .D BMES^XPDUTL("The AHDRNEW Index was not added to FILE 120.5. Please enter a NOIS.")
 .Q 
 Q
 ;
AHDRE ; Create AHDRERR Index on GMRV Vital Measurement file (#120.5) for use
 ; by Health Data Repository (HDR)
 ; Calls HDR API whenever a FILE 120.5 entry is marked as an error
 N MSG,RESULT,XREF
 D BMES^XPDUTL("Creating AHDRERR Index on GMRV VITAL MEASUREMENT (#120.5) file.")
 S XREF("ACTIVITY")=""
 S XREF("FILE")=120.5
 S XREF("ROOT FILE")=120.5
 S XREF("TYPE")="MU"
 S XREF("SHORT DESCR")="INDEX for HDR"
 S XREF("DESCR",1)="This cross-reference calls a Health Data Repository (HDR) API whenever a"
 S XREF("DESCR",2)="FILE 120.5 entry is marked as entered-in-error."
 S XREF("DESCR",3)=" "
 S XREF("DESCR",4)="No actual cross-reference nodes are set or killed."
 S XREF("DESCR",5)=" "
 S XREF("DESCR",6)="Calls to the VDEFQM routine are covered by Integration Agreement 4253."
 S XREF("USE")="ACTION"
 S XREF("EXECUTION")="F"
 S XREF("WHOLE KILL")="Q"
 S XREF("VAL",1)=2
 S XREF("NAME")="AHDRERR"
 S XREF("SET")="Q:$D(DIU(0))  N ERR,GMVFLAG I $T(QUEUE^VDEFQM)]"""" S GMVFLAG=$$QUEUE^VDEFQM(""ORU^R01"",""SUBTYPE=VTLS^IEN=""_DA,.ERR)"
 S XREF("KILL")="Q"
 S XREF("SET CONDITION")="I X1(1)="""",X2(1)]"""" S X=1"
 D CREIXN^DDMOD(.XREF,"k",.RESULT,"","MSG")
 I RESULT="" D
 .D BMES^XPDUTL("The AHDRERR Index was not added to FILE 120.5. Please enter a NOIS.")
 .Q 
 Q
