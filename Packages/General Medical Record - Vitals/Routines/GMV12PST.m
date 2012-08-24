GMV12PST ;HIOFO/FT-POST-INSTALLATION FOR GMRV*5*12 ;6/16/05  14:16
 ;;5.0;GEN. MED. REC. - VITALS;**12**;Oct 31, 2002
 ;
 ; This routine uses the following IAs:
 ; #10141 - ^XPDUTL calls (supported)
 ;
EN ; Driver subroutine
 D AHDRN,AHDRE
 Q
 ;
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
 S GMVXR("DESCR",7)="Calls to the VADPT routine are covered by Integration Agreement 3744."
 S GMVXR("DESCR",8)="Use of the XDRDVALF variable is covered by Integration Agreement 4690."
 S GMVXR("SET")="Q:$D(DIU(0))!($$TESTPAT^VADPT($P(^GMR(120.5,DA,0),U,2)))!($G(XDRDVALF)=1)  N ERR,GMVFLAG I $T(QUEUE^VDEFQM)]"""" S GMVFLAG=$$QUEUE^VDEFQM(""ORU^R01"",""SUBTYPE=VTLS^IEN=""_DA,.ERR)"
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
 S GMVXR("DESCR",7)="Calls to the VADPT routine are covered by Integration Agreement 3744."
 S GMVXR("DESCR",8)="Use of the XDRDVALF variable is covered by Integration Agreement 4690."
 S GMVXR("SET")="Q:$D(DIU(0))!($$TESTPAT^VADPT($P(^GMR(120.5,DA,0),U,2)))!($G(XDRDVALF)=1)  N ERR,GMVFLAG I $T(QUEUE^VDEFQM)]"""" S GMVFLAG=$$QUEUE^VDEFQM(""ORU^R01"",""SUBTYPE=VTLS^IEN=""_DA,.ERR)"
 S GMVXR("KILL")="Q"
 S GMVXR("WHOLE KILL")="Q"
 S GMVXR("SET CONDITION")="I X1(1)="""",X2(1)]"""" S X=1"
 S GMVXR("VAL",1)=2
 D CREIXN^DDMOD(.GMVXR,"k",.GMVRES,"GMVOUT")
 I GMVRES="" D
 .D BMES^XPDUTL("The AHDRERR Index was not added to FILE 120.5. Please enter a Remedy ticket.")
 .Q
 Q
