PXVP217 ;ISP/LMT - PX*1*217 KIDS Routine ;Aug 16, 2022@13:48:51
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**217**;Aug 12, 1996;Build 134
 ;
 Q
 ;
CHFSCAT ;Correct Service Categories that are HF.
 ; ZEXCEPT: ZTQUEUED,ZTSTOP
 N CNT,FDA,IEN,IENS,MSG,NUMC
 ;
 S ^XTMP("PXVP217-CHFSCAT",0)=$$FMADD^XLFDT(DT,1000)_U_DT_U_"Correct Service Categories that are HF"
 S NUMC=0
 S CNT=0
 ;
 S IEN=0
 F  S IEN=+$O(^AUPNVSIT(IEN)) Q:IEN=0  D  Q:$G(ZTSTOP)
 . S CNT=CNT+1
 . ; take a "rest" - allow OS to swap out process
 . I '(CNT#10000) D  I $D(ZTQUEUED),$$S^%ZTLOAD("Processing Visit #"_IEN) S ZTSTOP=1 Q
 . . S ^XTMP("PXVP217-CHFSCAT","LAST")=IEN
 . . H 1
 . ;
 . I $P(^AUPNVSIT(IEN,0),U,7)'="HF" Q
 . ;
 . S ^XTMP("PXVP217-CHFSCAT",IEN)=""
 . S IENS=IEN_","
 . S FDA(9000010,IENS,.07)="H"
 . K MSG
 . D FILE^DIE("","FDA","MSG")
 . I $D(MSG) D  Q
 . . S ^XTMP("PXVP217-CHFSCAT",IEN,"ERROR")="The FILE^DIE call returned an error"
 . . M ^XTMP("PXVP217-CHFSCAT",IEN,"ERROR","MSG")=MSG
 . ;
 . S NUMC=NUMC+1
 ;
 S ^XTMP("PXVP217-CHFSCAT","NUMCORRECTED")=$G(^XTMP("PXVP217-CHFSCAT","NUMCORRECTED"))+NUMC
 Q
 ;
TSKHFSC ; Task out job to correct Service Categories that are HF
 N ZTDTH,ZTSAVE,ZTIO,ZTSK,ZTRTN,ZTDESC,ZTUCI,ZTCPU,ZTSYNC,ZTKIL
 ;
 S ZTRTN="CHFSCAT^PXVP217"
 S ZTDESC="Correct Service Categories that are HF"
 S ZTIO=""
 S ZTDTH=$H
 D ^%ZTLOAD
 I $G(ZTSK) D BMES("""Correct Service Categories that are HF"" has been queued, task number "_ZTSK)
 I '$G(ZTSK) D BMES("ERROR: ""Correct Service Categories that are HF"" failed to queue. Please email the Implementation Team.")
 ;
 Q
 ;
PRE ;KIDS Pre install for PX*1*217
 D RMOLDDDS
 Q
 ;
POST ; KIDS Post install for PX*1*217
 D BMES("*** Post install started ***")
 ;
 D SKACHXR ; Update ACR cross-reference on V SKIN TEST file
 D SKAHXR ; Update AH cross-reference on V SKIN TEST file
 D SKCPT ; Set PXV SKIN TEST READING CPT parameter
 D IMMMAILG  ;Create PXV IMM INVENTORY ALERTS mail group
 D SETPAR  ; Set param value for PXV IMM INVENTORY ALERTS
 D IMMDEF ; Update the IMM DEFAULT RESPONSES (920.05) file - Immunizations
 D CONDEF ; Update the IMM DEFAULT RESPONSES (920.05) file - Contra/Refusals
 D TSKHFSC ; Correct Service Categories that are HF
 ;
 D BMES("*** Post install completed ***")
 ;
 Q
 ;
RMOLDDDS ;Remove old data dictionaries.
 N DIU,TEXT
 D BMES^XPDUTL("Removing old data dictionaries.")
 S DIU(0)=""
 F DIU=9000010.13,9000010.16,9000010.23,9999999.09,9999999.15,9999999.64 D
 . S TEXT=" Deleting data dictionary for file # "_DIU
 . D MES^XPDUTL(TEXT)
 . D EN^DIU2
 Q
 ;
SKACHXR ; Update ACR cross-reference on V SKIN TEST file
 ;
 D BMES("*** Updating ACR cross-reference on V SKIN TEST file ***")
 ;
 N PXXR,PXRES,PXOUT
 S PXXR("FILE")=9000010.12
 S PXXR("NAME")="ACR"
 S PXXR("TYPE")="MU"
 S PXXR("USE")="A"
 S PXXR("EXECUTION")="R"
 S PXXR("ACTIVITY")="IR"
 S PXXR("SHORT DESCR")="Clinical Reminders index."
 S PXXR("DESCR",1)="This cross-reference builds two indexes, one for finding all patients"
 S PXXR("DESCR",2)="with a particular skin test and one for finding all the skin tests a"
 S PXXR("DESCR",3)="patient has."
 S PXXR("DESCR",4)="The indexes are stored in the Clinical Reminders index global as:"
 S PXXR("DESCR",5)=" ^PXRMINDX(9000010.12,""IP"",SKIN TEST,DFN,DATE,DAS) and"
 S PXXR("DESCR",6)=" ^PXRMINDX(9000010.12,""PI"",DFN,SKIN TEST,DATE,DAS)"
 S PXXR("DESCR",7)="respectively."
 S PXXR("DESCR",8)=" "
 S PXXR("DESCR",9)="Where"
 S PXXR("DESCR",10)=" SKIN TEST is a pointer to file #9999999.28."
 S PXXR("DESCR",11)=" DFN is a pointer to file #2."
 S PXXR("DESCR",12)=" DATE is EVENT DATE AND TIME, if it exists. If it does not, then it is"
 S PXXR("DESCR",13)="VISIT/ADMIT DATE&TIME."
 S PXXR("DESCR",14)=" DAS is the internal entry number of the entry in file #9000010.12."
 S PXXR("DESCR",15)=" "
 S PXXR("DESCR",16)="For all the details, see the Clinical Reminders Index Technical"
 S PXXR("DESCR",17)="Guide/Programmer's Manual."
 S PXXR("DESCR",18)=" "
 S PXXR("SET")="D SVFILE^PXPXRM(9000010.12,.X,.DA)"
 S PXXR("KILL")="D KVFILE^PXPXRM(9000010.12,.X,.DA)"
 S PXXR("WHOLE KILL")="K ^PXRMINDX(9000010.12)"
 S PXXR("VAL",1)=.01
 S PXXR("VAL",1,"SUBSCRIPT")=1
 S PXXR("VAL",1,"COLLATION")="F"
 S PXXR("VAL",2)=.02
 S PXXR("VAL",2,"SUBSCRIPT")=2
 S PXXR("VAL",2,"COLLATION")="F"
 S PXXR("VAL",3)=.03
 S PXXR("VAL",3,"SUBSCRIPT")=3
 S PXXR("VAL",3,"COLLATION")="F"
 S PXXR("VAL",4)=1201
 S PXXR("VAL",4,"COLLATION")="F"
 S PXXR("VAL",5)=.06
 S PXXR("VAL",5,"COLLATION")="F"
 D CREIXN^DDMOD(.PXXR,"k",.PXRES,"PXOUT")
 I $G(PXRES) D
 . D MES("Cross-reference "_$P(PXRES,U,2)_" (#"_$P(PXRES,U,1)_") was updated successfully.")
 I $G(PXRES)="" D
 . D MES("*** ERROR: Failed to update cross-reference. ***")
 Q
 ;
SKAHXR ; Update AH cross-reference on V SKIN TEST file
 ;
 D BMES("*** Updating AH cross-reference on V SKIN TEST file ***")
 ;
 N PXXR,PXRES,PXOUT
 S PXXR("FILE")=9000010.12
 S PXXR("NAME")="AH"
 S PXXR("TYPE")="MU"
 S PXXR("USE")="A"
 S PXXR("EXECUTION")="R"
 S PXXR("ACTIVITY")="IR"
 S PXXR("SHORT DESCR")="Hours between placement and reading"
 S PXXR("DESCR",1)="This cross reference calculates the number of hours between the EVENT "
 S PXXR("DESCR",2)="DATE AND TIME field (#1201) and the DATE READ field (#.06) and stores "
 S PXXR("DESCR",3)="that value in the HOURS READ POST-PLACEMENT field (#1214)."
 S PXXR("SET")="D HR^PXVUTL Q"
 S PXXR("KILL")="D HR^PXVUTL Q"
 S PXXR("WHOLE KILL")="Q"
 S PXXR("VAL",1)=.06
 S PXXR("VAL",1,"COLLATION")="F"
 S PXXR("VAL",2)=1201
 S PXXR("VAL",2,"COLLATION")="F"
 S PXXR("VAL",3)=1214
 S PXXR("VAL",3,"COLLATION")="F"
 D CREIXN^DDMOD(.PXXR,"k",.PXRES,"PXOUT")
 I $G(PXRES) D
 . D MES("Cross-reference "_$P(PXRES,U,2)_" (#"_$P(PXRES,U,1)_") was updated successfully.")
 I $G(PXRES)="" D
 . D MES("*** ERROR: Failed to update cross-reference. ***")
 Q
 ;
 ;
SKCPT ; Set PXV SKIN TEST READING CPT parameter
 ;
 N PXDATE,PXX
 ;
 D BMES("*** Setting PXV SKIN TEST READING CPT parameter ***")
 ;
 ; See if this is the first install after we started pushing out this parameter.
 ; We don't want to overwrite the user's settings.
 S PXDATE=3180807
 S PXX=$$INSTALDT^XPDUTL("PX*1.0*217",.PXX)
 I $O(PXX(PXDATE)) D  Q
 . D MES(" No need to set the parameter, as it was set previously.")
 ;
 D MES(" Setting the parameter to 99211 at the SYS level.")
 D PUT^XPAR("SYS","PXV SKIN TEST READING CPT",1,"99211")
 ;
 Q
 ;
 ;
IMMMAILG  ;Create PXV IMM INVENTORY ALERTS mail group
 N PXDESC,PXUSERS,PXMG
 ;
 D BMES("*** Creating the PXV IMM INVENTORY ALERTS Mail Group ***")
 S PXDESC(1)="This mail group will receive messages when an immunization is running low on"
 S PXDESC(2)="stock."
 S PXUSERS(DUZ)=""
 S PXMG=$$MG^XMBGRP("PXV IMM INVENTORY ALERTS",1,DUZ,1,.PXUSERS,.PXDESC,1)
 I PXMG D MES(" Created the mail group (#"_PXMG_").")
 I 'PXMG D MES(" Mail Group was not created.")
 Q
 ;
 ;
SETPAR ; Set param value for PXV IMM INVENTORY ALERTS
 N PXVAL,PXERR
 D BMES("Setting PKG value for parameter PXV IMM INVENTORY ALERTS...")
 ;
 S PXVAL="YES"
 D EN^XPAR("PKG","PXV IMM INVENTORY ALERTS",1,.PXVAL,.PXERR)
 I +$G(PXERR)>0 D MES("  ERROR #"_$P(PXERR,U)_": "_$P(PXERR,U,2)) Q
 D MES("  DONE")
 Q
 ;
IMMDEF ; Populate the IMM DEFAULT RESPONSES (920.05) file, Immunizations
 ;
 N PXDOSE,PXFDA,PXI,PXIENS,PXIMM,PXINST,PXLINE,PXNUNITS,PXROUTE,PXSITE,PXUCUM,PXUNITS,PXIEN
 ;
 D BMES("*** Populate the IMM DEFAULT RESPONSES (920.05) file - Immunizations ***")
 ;
 I $O(^PXV(920.05,0)),'$D(^XTMP("PXVP217")) D
 . S ^XTMP("PXVP217",0)=$$FMADD^XLFDT(DT,60)_"^"_DT
 . M ^XTMP("PXVP217",920.05)=^PXV(920.05)
 ;
 S PXINST=$$KSP^XUPARAM("INST")
 I 'PXINST D  Q
 . D MES("ERROR: No default Institution. Can't populate file.")
 ;
 F PXI=2:1 S PXLINE=$P($T(IMMDATA+PXI),";;",2) Q:PXLINE=""  D
 . K PXFDA,PXIEN
 . S PXIMM=$P(PXLINE,U,1)
 . S PXROUTE=$P(PXLINE,U,2)
 . S PXSITE=$P(PXLINE,U,3)
 . S PXDOSE=$P(PXLINE,U,4)
 . S PXUNITS=$P(PXLINE,U,5)
 . S PXNUNITS=$P(PXLINE,U,6)
 . ;
 . I PXIMM="" D  Q
 . . D MES("ERROR: Immunization null. Can't populate this entry.")
 . S PXIMM=$O(^AUTTIMM("AVUID",PXIMM,0))
 . I 'PXIMM D  Q
 . . D MES("ERROR: Immunization not found. Can't populate this entry.")
 . ;
 . ;I $D(^PXV(920.05,"AC",PXINST,PXIMM)) D  Q
 . ;. D MES("Default already defined for: "_PXIMM_". Skiping this entry.")
 . ;
 . I PXROUTE'="" D
 . . S PXROUTE=$O(^PXV(920.2,"AVUID",PXROUTE,0))
 . . I 'PXROUTE D
 . . . D MES("ERROR: Route not found. Can't populate it for immunization #"_PXIMM_".")
 . . . S PXROUTE=""
 . ;
 . I PXSITE'="" D
 . . S PXSITE=$O(^PXV(920.3,"AVUID",PXSITE,0))
 . . I 'PXSITE D
 . . . D MES("ERROR: Site not found. Can't populate it for immunization #"_PXIMM_".")
 . . . S PXSITE=""
 . ;
 . K PXUCUM
 . I PXUNITS'="" D
 . . D UCUMDATA^LEXMUCUM(PXUNITS,.PXUCUM)
 . . S PXUNITS=$O(PXUCUM(0))
 . . I 'PXUNITS D
 . . . S PXUNITS=""
 . . . D MES("ERROR: Units not found. Can't populate it for immunization #"_PXIMM_".")
 . ;
 . I 'PXROUTE,'PXSITE,PXDOSE="",PXUNITS="",PXNUNITS="" Q
 . ;
 . S PXIENS="?+1,"
 . S PXFDA(920.05,PXIENS,.01)=PXINST
 . S PXIENS="?+2,?+1,"
 . S PXFDA(920.051,PXIENS,.01)=PXIMM
 . I PXROUTE'="" S PXFDA(920.051,PXIENS,1302)=PXROUTE
 . I PXSITE'="" S PXFDA(920.051,PXIENS,1303)=PXSITE
 . S PXFDA(920.051,PXIENS,1312)=PXDOSE
 . I PXUNITS'="" S PXFDA(920.051,PXIENS,1313)=PXUNITS
 . I PXNUNITS'="" S PXFDA(920.051,PXIENS,1314)=PXNUNITS
 . K ^TMP("DIERR",$J)
 . S PXIEN(2)=PXIMM
 . D UPDATE^DIE("","PXFDA","PXIEN")
 . I $D(^TMP("DIERR",$J)) D MES("ERROR: Error filing default for Immunization #"_PXIMM_".")
 Q
 ;
CONDEF ; Populate the IMM DEFAULT RESPONSES (920.05) file, Contra/Refusals
 ;
 N PXDAYS,PXFDA,PXFILE,PXI,PXIEN,PXIENS,PXINST,PXLINE,PXVUID
 ;
 D BMES("*** Populate the IMM DEFAULT RESPONSES (920.05) file - Contraindications/Refusals ***")
 ;
 S PXINST=$$KSP^XUPARAM("INST")
 I 'PXINST D  Q
 . D MES("ERROR: No default Institution. Can't populate file.")
 ;
 F PXI=2:1 S PXLINE=$P($T(CONDATA+PXI),";;",2) Q:PXLINE=""  D
 . K PXFDA,PXIEN
 . S PXFILE=$P(PXLINE,U,1)
 . S PXVUID=$P(PXLINE,U,3)
 . S PXDAYS=$P(PXLINE,U,4)
 . ;
 . I PXFILE=""!(PXVUID="")!(PXDAYS="") D  Q
 . . D MES("ERROR: File #, VUID, and/or Days is null. Can't populate this entry.")
 . S PXIEN=$O(^PXV(PXFILE,"AVUID",PXVUID,0))
 . I 'PXIEN D  Q
 . . D MES("ERROR: Contra/Refusal not found. Can't populate this entry.")
 . ;
 . I PXDAYS<0!(PXDAYS>10000) D  Q
 . . D MES("ERROR: Days '"_PXDAYS_"' is not appropriate value. Skipping.")
 . ;
 . S PXIENS="?+1,"
 . S PXFDA(920.05,PXIENS,.01)=PXINST
 . S PXIENS="?+2,?+1,"
 . S PXFDA(920.052,PXIENS,.01)=PXIEN_";PXV("_PXFILE_","
 . S PXFDA(920.052,PXIENS,.02)=PXDAYS
 . K ^TMP("DIERR",$J)
 . D UPDATE^DIE("","PXFDA")
 . I $D(^TMP("DIERR",$J)) D MES("ERROR: Error filing default for Contra/Refusal #"_PXIEN_";PXV("_PXFILE_",")
 Q
 ;
BMES(STR) ;
 ; Write string
 D BMES^XPDUTL($$TRIM^XLFSTR($$CJ^XLFSTR(STR,$G(IOM,80)),"R"," "))
 Q
MES(STR) ;
 ; Write string
 D MES^XPDUTL($$TRIM^XLFSTR($$CJ^XLFSTR(STR,$G(IOM,80)),"R"," "))
 Q
 ;
 ;
IMMDATA ;Data to populate the IMM DEFAULT RESPONSES (920.05) file
 ;;VUID^ROUTE^SITE^DOSE^UNITS^NON-STANDARD UNITS
 ;;5197809^4500642^^2^^Tablets
 ;;5197633^4706241^^.5^mL^
 ;;5197833^4706241^^^mL^
 ;;5197623^5197549^^^mL^
 ;;5245875^4500642^^90^mL^
 ;;5333977^4706241^^.5^mL^
 ;;5333973^4706241^^.5^mL^
 ;;5333969^4706241^^^mL^
 ;;5333975^4706241^^.5^mL^
 ;;5333971^4706241^^.3^mL^
 ;;5330716^4706258^^.5^mL^
 ;;5197639^4706241^^.5^mL^
 ;;5197625^4706241^^.5^mL^
 ;;5197739^4706241^^.5^mL^
 ;;5327721^4706241^^.5^mL^
 ;;5197747^4706241^^.5^mL^
 ;;5197765^4706241^^.5^mL^
 ;;5197783^4706241^^.5^mL^
 ;;5335437^4706241^^1^mL^
 ;;5197679^4706241^^1^mL^
 ;;5197709^4706241^^.5^mL^
 ;;5197735^4706241^^1^mL^
 ;;5197607^4706241^^.5^mL^
 ;;5197661^4706241^^^mL^
 ;;5197663^4706241^^1^mL^
 ;;5258667^4706241^^.5^mL^
 ;;5197673^4706241^^.5^mL^
 ;;5197671^4706241^^.5^mL^
 ;;5197687^4706241^^.5^mL^
 ;;5215778^4706241^^.5^mL^
 ;;5197831^4706241^^.5^mL^
 ;;5333949^4706241^^.5^mL^
 ;;5197793^4706241^^.5^mL^
 ;;5331733^4706241^^.7^mL^
 ;;5245869^4706241^^.5^mL^
 ;;5258486^4706241^^.5^mL^
 ;;5197829^4706241^^.5^mL^
 ;;5197819^4706241^^.5^mL^
 ;;5215772^4706241^^.5^mL^
 ;;5215780^4706239^^.1^mL^
 ;;5197817^4706252^^.2^mL^
 ;;5197827^4706241^^.5^mL^
 ;;5254431^4706241^^.5^mL^
 ;;5197805^4706241^^.5^mL^
 ;;5197803^4706241^^.5^mL^
 ;;5197811^4706239^^.1^mL^
 ;;5245607^4706241^^.5^mL^
 ;;5197611^^^.5^mL^
 ;;5197791^4706241^^.5^mL^
 ;;5215782^4706241^^.5^mL^
 ;;5215774^4706241^^.5^mL^
 ;;5197795^4706241^^.5^mL^
 ;;5197755^4706241^^.5^mL^
 ;;5333947^4706241^^.5^mL^
 ;;5197597^4706258^^.5^mL^
 ;;5197725^4706258^^.5^mL^
 ;;5197789^4706241^^.5^mL^
 ;;5197645^4706241^^.5^mL^
 ;;5248397^4706241^^1^mL^
 ;;5248399^4706241^^1^mL^
 ;;5197763^4500642^^1^mL^
 ;;5197759^4500642^^2^mL^
 ;;5333951^^^^mL^
 ;;5197609^4706241^^.5^mL^
 ;;5197753^4706241^^.5^mL^
 ;;5197757^4706241^^.5^mL^
 ;;5197635^4500642^^1^^Capsules
 ;;5197729^4706241^^.5^mL^
 ;;5197695^5197549^^2.5^uL^
 ;;5197627^4706258^^.5^mL^
 ;;5197649^4706258^^.5^mL^
 ;;5251135^^^.5^mL^
 ;;5197767^4706258^^.65^mL^
 ;;5258663^4706241^^.5^mL^
 ;;5339688^4706241^^.5^mL^
 ;;5339690^4706241^^.5^mL^
 ;;5339697^4706241^^.3^mL^
 ;;5339699^4706241^^.2^mL^
 ;;5339701^4706241^^.2^mL^
 ;;5340643^4706241^^.5^mL^
 ;;5339892^4706241^^1^mL^
 ;;5342690^^^.5^mL^
 ;;5342688^^^^mL^
 ;;5342684^4706241^^.25^mL^
 ;;5342686^4706241^^.5^mL^
 ;;
CONDATA ;Data to populate the IMM DEFAULT RESPONSES (920.05) file
 ;;FILE^NAME^VUID^WARN UNTIL DAYS
 ;;920.4^CURRENT IMMUNODEFICIENCY^5198139^90
 ;;920.4^CURRENT PREGNANCY^5198141^280
 ;;920.4^ENCEPHALOPATHY PREVIOUS DOSE^5198127^0
 ;;920.4^HX ARTHUS REACTION^5198135^0
 ;;920.4^HX INTUSSUSCEPTION^5198125^0
 ;;920.4^LATEX ALLERGY^5198121^0
 ;;920.4^SEVERE ALLERGY EGGS^5198107^0
 ;;920.4^SEVERE GELATIN ALLERGY^5251118^0
 ;;920.4^SEVERE NEOMYCIN ALLERGY^5198111^0
 ;;920.4^SEVERE POLYMYXIN B ALLERGY^5198123^0
 ;;920.4^SEVERE REACTION PREVIOUS DOSE^5198117^0
 ;;920.4^SEVERE STREPTOMYCIN ALLERGY^5198113^0
 ;;920.4^SEVERE YEAST ALLERGY^5237393^0
 ;;920.4^CONCURRENT TB SKIN TEST^5198101^7
 ;;920.4^CURRENT ACUTE ILLNESS^5198131^7
 ;;920.4^CURRENT FEVER^5198129^7
 ;;920.4^THROMBOCYTOPENIA^5198143^30
 ;;920.4^UNSTABLE/EVOLVING NEURO DZ^5198137^30
 ;;920.5^OTHER^5198154^30
 ;;920.5^PARENTAL DECISION^5198150^365
 ;;920.5^PATIENT DECISION^5198156^30
 ;;920.5^RELIGIOUS EXEMPTION^5198152^365
 ;;
