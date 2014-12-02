LRJSAU60 ;ALB/PO/DK/TMK Lab File 60 Audit Manager ;08/16/2010 15:54:29
 ;;5.2;LAB SERVICE;**425**;Sep 27, 1994;Build 30
 ;
 ;Reference to direct lookup via fileman to DD global supported by ICR #4281
 ;Reference to direct lookup of subfile name in DD global supported by ICR #4768
 ;Reference to sort and print templates in file 1.1 (AUDIT) supported by ICR #4806
 ;
AUDSET ; -- enable audit fields for file 60
 ; Called from:
 ;    LRJ SYS SET AUDITED FLAG FOR FIELDS protocol
 ;
 N LRI,LRAFLDS,FILENUM,FIELDNUM,FIELDNAM,XINDEX,XISAUD,XAUDSET,Q
 N DIR,DIC,DIK,DA,DUOUT,DTOUT,DIROUT,X,Y
 D FULL^VALM1
 I '$D(^TMP($J,"LRAUDREQ")) D
 .F LRI=1:1 S LRALINE=$P($TEXT(AFLDS+LRI^LRJSAU),";;",2) Q:LRALINE="$$END$$"  D
 ..I +LRALINE'=60 Q
 ..S LRSUBFLD=$P($P(LRALINE,"^"),";",2)
 ..F Q=1:1:$L($P(LRALINE,"^",2),";") D
 ...I 'LRSUBFLD S ^TMP($J,"LRAUDREQ","60,"_$P($P(LRALINE,"^",2),";",Q))=1 Q
 ...S ^TMP($J,"LRAUDREQ","60,"_LRSUBFLD_","_$P($P(LRALINE,"^",2),";",Q))=1
 S FIELDNUM="",DIC="^DD(60," ;ICR 4281
 S DIC(0)="AEQZ",DIC("A")="Field: "
 F  D ^DIC D  Q:Y'=""
 .I Y>0,$G(^TMP($J,"LRAUDREQ","60,"_+Y)) D
 ..W !,"'SF' cannot be used to turn auditing off for any required audit field."
 ..S Y=""
 .I Y>0 S FIELDNUM=$P(Y,"^"),FIELDNAM=$P(Y,"^",2)
 Q:FIELDNUM=""
 ;check if field is multiple
 S FILENUM=+$$GFLDSB(60,FIELDNUM),FILENUM=$S(FILENUM>0:FILENUM,1:60)
 I FILENUM'=60 D
 . S DIC="^DD("_FILENUM_"," ; ICR 4281
 . S DIC(0)="AEQMZ",DIC("A")="Sub-File "_FIELDNAM_" Field: "
 . F  D ^DIC D  Q:Y'=""
 .. I Y>0,$G(^TMP($J,"LRAUDREQ","60,"_FIELDNUM_","_+Y)) D
 ... W !,"'SF' cannot be used to turn auditing off for any required audit field."
 ... S Y=""
 .S FIELDNUM=$S(Y>0:$P(Y,"^"),1:"")
 Q:FIELDNUM=""
 S XISAUD=$$ISAUDON(FILENUM,FIELDNUM)
 W !,"  File "_FILENUM_" - Field "_FIELDNUM_" is "_$S(XISAUD:"already ",1:"not currently ")_"audited."
 N DIR
 S DIR(0)="Y"
 S DIR("A")="Do you wish to turn auditing "_$S(XISAUD:"OFF ",1:"ON ")_"for this field?"
 S DIR("B")="No"
 D ^DIR K DIR
 I $D(DTOUT)!$D(DUOUT)!$D(DIROUT) Q
 S XAUDSET=+Y
 N DIR
 I 'XAUDSET D  Q
 .W !!,"   NO ACTION TAKEN"
 .D PAUSE^VALM1
 .D REFRESH^LRJSAU
 ;if not audited, turn auditing on
 I 'XISAUD D  Q
 .S XINDEX=$O(^LABAUD(64.9178,"B",60,""))
 .S XSUB=$S(FILENUM=60:FIELDNUM,1:FILENUM_","_FIELDNUM)
 .S DIC(0)="L",DA(1)=XINDEX,DLAYGO=64.9178
 .S DIC="^LABAUD(64.9178,"_XINDEX_",1,",X=XSUB
 .D FILE^DICN K DLAYGO
 .D TURNON^DIAUTL(FILENUM,FIELDNUM)
 .W !!,"    CHANGE MADE: File "_FILENUM_" - Field "_FIELDNUM_" is now audited"
 .D PAUSE^VALM1
 .D REFRESH^LRJSAU
 ;if audited, turn auditing off
 I XISAUD D
 .S XINDEX=$O(^LABAUD(64.9178,"B",60,""))
 .S XSUB=$S(FILENUM=60:FIELDNUM,1:FILENUM_","_FIELDNUM)
 .I $D(^LABAUD(64.9178,XINDEX,1,"B",XSUB)) D
 .. S DA(1)=XINDEX
 .. S DA=$O(^LABAUD(64.9178,XINDEX,1,"B",XSUB,""))
 .. S DIK="^LABAUD(64.9178,"_XINDEX_",1,"
 .. D ^DIK
 .D TURNON^DIAUTL(FILENUM,FIELDNUM,"n")
 .W !!,"    CHANGE MADE: File "_FILENUM_" - Field "_FIELDNUM_" is now NOT audited"
 .D PAUSE^VALM1
 .D REFRESH^LRJSAU
 Q
 ;
AUDLIST ; -- list file 60 audited fields
 ; Called from:
 ;    LRJ SYS LIST AUDITED FIELDS  protocol
 ;
 N X
 D FULL^VALM1
 S VALMCNT=0
 D KILL^LRJSAU
 D KILL^VALM10()
 S X=$$AUDCHK(1)
 Q
 ;
AUDISP ; -- Display file 60 changes
 ; Called from:
 ;    LRJ SYS DISPLAY FILE 60 CHANGES  protocol
 ;  
 ;  VALMCNT - [global/Input/Output] last entry in List Manager 
 ;   VALMAR - [global/Output] reference to List Manager buffer
 ;                   like   "^TMP("LRJ SYS ORDERS MANAGER",$JOB)"
 ; 
 ;TSKCALL set if called from TaskMan
 N FR,TO,FLDS,DIC,IOP,LRD0,LRD00,X,LRDATA,XSUB,XENT,XSTR,XLRIEN,XLRIEN1,XD1,XSQ,XD2,XSP,XLOINC
 N LRDT,LRDONE,LRFAC,LRFLDNM,LRGBL,LRIEN,LRNEW,LRARRY,LROLD,LROUT,LRSET,LRUSER,SPACE,LRDEV,XNEW,BY
 I '$G(TSKCALL) N LRTODT,LRFRDT,LRTO,LRFROM D FULL^VALM1
 S VALMCNT=0,XSUB=" "
 D KILL^LRJSAU
 I '$G(TSKCALL) D KILL^VALM10()
 S SPACE=$J("",47)
 S LROUT=0
 ; set up parameters to run the print template to a null device and store the results in LRDATA array
 ; in case there is no null defined, print template with IOP of ";;99999" still will store the results in LRDATA 
 ; 
 ;kill to variable DIA needed because otherwise carryover
 ;occurs if user invokes various audits in same session - [krused]
 K DIA
 S DIC="^DIA(60," ;ICR #4806
 S BY="[LRJ SYS DISPLAY FILE 60 CHANGE]"
 S FLDS="[LRJ SYS DISPLAY FILE 60 CHANGE]"
 ;
 F LRDEV="NULL DEVICE","NULL" S IOP=$$GIOP(LRDEV) QUIT:IOP'=""
 I IOP="" S IOP=";;99999" ; if no IOP then set the number of lines per page to maximum
 ;
 I '$G(TSKCALL) D FILENUM(.LROUT) Q:LROUT
 I '$G(TSKCALL) I $G(LRFRDT)=""!($G(LRTODT)="") G AUDISP
 I '$G(TSKCALL) I LRFRDT<0!(LRTODT<0) G AUDISP
 I $G(TSKCALL) S LRFRDT=LRFROM,LRTODT=LRTO
 ; wait message in case many audits to search through
 I '$G(TSKCALL) D WAIT^DICD
 K ^TMP("LRDATA",$J)
 S FR=LRFRDT,TO=LRTODT
 D EN1^DIP
 ;
 ; put the results from ^TMP("LRDATA",$J... into List Manager
 S ^TMP("LRJ SYS F60 AUD MANAGER",$J,1)=LRFRDT_"^"_LRTODT
 I '$G(TSKCALL) D
 .S X="File 60 Audit - From "_$$FMTE^XLFDT(LRFRDT)_" to "_$$FMTE^XLFDT(LRTODT)
 .D ADD^LRJSAU(.VALMCNT,X)
 S LRD0=0
 F  S LRD0=$O(^TMP("LRDATA",$J,LRD0)) Q:'LRD0  D
 .; sort by new entry added ... all changes made within 2 hours are 'NEW', not 'MODIFIED'
 .K LRARRY
 .S LRIEN=+$G(^TMP("LRDATA",$J,LRD0,"LRIEN"))
 .S LRNEW=+$O(^TMP("LRDATA",$J,"NEW",LRIEN,0))
 .I LRNEW,'$D(^TMP("LRDATA",$J,"NEW",LRIEN,LRD0)) S LRNEW=0 ; new entry changed outside 2 hr window
 .I LRNEW Q:'$G(^TMP("LRDATA",$J,"NEW",LRIEN,LRD0))  ; change to new entry made inside 2 hr window
 .S LRDT=$G(^TMP("LRDATA",$J,LRD0,"LRDT"))
 .I LRNEW D  ; flag all changed records associated with 'NEW' file 60 entry
 .. N Z
 .. S Z=0 F  S Z=$O(^TMP("LRDATA",$J,"NEW",LRIEN,Z)) Q:'Z  S LRARRY(Z)=1
 . I 'LRNEW S LRARRY(LRD0)=""
 . ; LRD00 = ien of the audit file
 . S LRD00=0
 . F  S LRD00=$O(LRARRY(LRD00)) Q:'LRD00  D
 .. K LRDATA,LRSET M LRDATA=^TMP("LRDATA",$J,LRD00)
 .. S LRDT=LRDATA("LRDT")
 .. S X=" "_$E($$FMTE^XLFDT(LRDT)_SPACE,1,25)_$E(LRDATA("LRUSER")_SPACE,1,40)_LRDATA("LRIEN")
 .. S XSUB=$S(LRARRY(LRD00):"NEW",1:"OLD")
 .. S ^TMP("LRJ SYS F60 AUD MANAGER",$J,XSUB,LRD00,"LRDT")=X
 .. S X=$P($G(^LAB(60,+$G(LRDATA("LRIEN")),0)),"^")
 .. I X="" S X="NONE (DELETED BEFORE BEING COMPLETELY DEFINED)"
 .. S X="       TEST NAME: "_X
 .. S LRSET("LRIEN")=X
 .. S X="      FIELD NAME: "_LRDATA("LRFLDNM")
 .. S LRSET("LRFLDNM")=X
 .. S X="       OLD VALUE: "_LRDATA("LROLD")
 .. S LRSET("LROLD")=X
 .. S X="       NEW VALUE: "_LRDATA("LRNEW")
 .. S LRSET("LRNEW")=X
 .. M ^TMP("LRJ SYS F60 AUD MANAGER",$J,XSUB,LRD00)=LRSET
 .. ;extract file if user requests
 .. S XLRIEN=$P(LRDATA("LRIEN"),","),XLRIEN1=$TR($P(LRDATA("LRIEN"),",",2,999),",","~")
 .. S ^TMP("LRJ SYS F60 AUD MANAGER",$J,"EXTRACT_INIT",XSUB,XLRIEN,LRDATA("LRFNUM")_";"_LRDATA("LRFLDNM")_$S(XLRIEN="":"",1:"-"_XLRIEN1),LRDATA("LRDT"),LRD00)=""
 ;create extract file entry
 S (XSUB,XLRIEN,XD1)="",LRFAC=$$NAME^XUAF4($$KSP^XUPARAM("INST"))
 F  S XSUB=$O(^TMP("LRJ SYS F60 AUD MANAGER",$J,"EXTRACT_INIT",XSUB)) Q:XSUB=""  D
 .S LRGBL=$NA(^TMP("LRJ SYS F60 AUD MANAGER",$J,"EXTRACT",XSUB))
 .S XSTR="File 60 Audit "_$S(XSUB="NEW":"New_",1:"Modified ")_" Entries - From "_$$FMTE^XLFDT(LRFRDT)_" to "_$$FMTE^XLFDT(LRTODT)
 .S @LRGBL@(1)=$TR(XSTR,",","")
 .S @LRGBL@(2)="Facility,Test Name,Subscript,IEN~subfile IEN,NLT Code,Place holder,Site/Specimen~LOINC,Synonym(s)"
 .S @LRGBL@(2)=@LRGBL@(2)_",Fld #,Fld name,Date/Time of change,Previous value,New value"
 .S XSQ=2
 .F  S XLRIEN=$O(^TMP("LRJ SYS F60 AUD MANAGER",$J,"EXTRACT_INIT",XSUB,XLRIEN)) Q:XLRIEN=""  D
 ..N LRREC,Z
 ..K XLRAR M XLRAR=^LAB(60,XLRIEN)
 ..S LRREC=$NA(^TMP("LRJ SYS F60 AUD MANAGER",$J,"EXTRACT_INIT",XSUB,XLRIEN))
 ..F  S LRREC=$Q(@LRREC) Q:$QS(LRREC,5)'=XLRIEN  D
 ...S XSQ=XSQ+1,LRD00=$QS(LRREC,8)
 ...K LRDATA
 ...M LRDATA=^TMP("LRDATA",$J,LRD00)
 ...;facility name 
 ...S XSTR=$TR(LRFAC,","," ")
 ...;test name
 ...S XLRAR(0)=$TR($G(XLRAR(0)),","," ")
 ...I XLRAR(0)="" S XLRAR(0)="NONE (DELETED BEFORE BEING COMPLETELY DEFINED)"
 ...S XSTR=XSTR_","_$P($G(XLRAR(0)),"^")
 ...;test subscript
 ...S XSTR=XSTR_","_$P($G(XLRAR(0)),"^",4)
 ...;IEN~subfile iens
 ...S Z=$P($QS(LRREC,6),"-",2)
 ...S XSTR=XSTR_","_XLRIEN_$S(Z="":"",1:"~"_Z)
 ...;NLT code
 ...S XD1=$P($G(XLRAR(64)),"^")
 ...I XD1]"" S XD1=$P($G(^LAM(XD1,0)),"^",2)_"~"
 ...S XSTR=XSTR_","_XD1
 ...;Place holder
 ...S XSTR=XSTR_",~"
 ...;site/specimen(s) which linked to LOINC codes at subscript 95.3
 ...S XD1=0,(XD2,XSP,XLOINC)="" F  S XD1=$O(XLRAR(1,XD1)) Q:XD1=""  Q:XD1'?1N.N  D
 ....S XSP=$P($G(XLRAR(1,XD1,0)),"^"),XSP=$S(XSP]"":$P($G(^LAB(61,XSP,0)),"^"),1:"")
 ....S XLOINC=$G(XLRAR(1,XD1,95.3))
 ....I XLOINC]"" S XLOINC=$$GET1^DIQ(60.01,XD1_","_XLRIEN,95.3,,"LRMSG")
 ....S XD2=$S(XD2]"":XD2_";",1:"")_XSP_"~"_XLOINC
 ...S XSTR=XSTR_","_$TR(XD2,","," ")
 ...;synonym(s) -- string together
 ...S XD1=0,XD2="" F  S XD1=$O(XLRAR(5,XD1)) Q:XD1=""  Q:XD1'?1N.N  S XD2=$S(XD2]"":XD2_";",1:"")_$P(XLRAR(5,XD1,0),"^")
 ...S XSTR=XSTR_","_$TR(XD2,","," ")
 ...; field number
 ...S:LRDATA("LRFNUM")["," LRDATA("LRFNUM")=""""_LRDATA("LRFNUM")_""""
 ...S XSTR=XSTR_","_LRDATA("LRFNUM")
 ...; field name
 ...S:LRDATA("LRFLDNM")["," LRDATA("LRFLDNM")=""""_LRDATA("LRFLDNM")_""""
 ...S XSTR=XSTR_","_LRDATA("LRFLDNM")
 ...; date/time changed
 ...S XSTR=XSTR_","_LRDATA("LRDT")
 ...; old value
 ...S:LRDATA("LROLD")["," LRDATA("LROLD")=""""_LRDATA("LROLD")_""""
 ...S XSTR=XSTR_","_LRDATA("LROLD")
 ...; new value
 ...S:LRDATA("LRNEW")["," LRDATA("LRNEW")=""""_LRDATA("LRNEW")_""""
 ...S XSTR=XSTR_","_LRDATA("LRNEW")
 ...S @LRGBL@(XSQ)=XSTR
 .Q:$G(TSKCALL)
 .S VALMHDR(1)=$J("",21)_"Laboratory Test File (#60) Changes"
 .S VALMHDR(2)=$J("",9)_"Date Range: "_$$FMTE^XLFDT(LRFRDT)_" to "_$$FMTE^XLFDT(LRTODT)
 .D CHGCAP^VALM("HEADER","DT RECORDED"_$J("",14)_"USER"_$J("",36)_"IEN(s)     ")
 I '$G(TSKCALL) F XSUB="NEW","OLD" D
 .I '$D(^TMP("LRJ SYS F60 AUD MANAGER",$J,XSUB)) D  Q
 ..D ADD^LRJSAU(.VALMCNT,"")
 ..S X="No "_$S(XSUB="NEW":"New",1:"Modified")_" Entries"
 ..D ADD^LRJSAU(.VALMCNT,X)
 ..D ADD^LRJSAU(.VALMCNT,"")
 .D ADD^LRJSAU(.VALMCNT,"")
 .S X=$S(XSUB="NEW":"New",1:"Modified")_" Entries"
 .D ADD^LRJSAU(.VALMCNT,X)
 .D ADD^LRJSAU(.VALMCNT,"")
 .S (LRD0,XENT)=""
 .F  S LRD0=$O(^TMP("LRJ SYS F60 AUD MANAGER",$J,XSUB,LRD0)) Q:LRD0=""  D
 ..F  S XENT=$O(^TMP("LRJ SYS F60 AUD MANAGER",$J,XSUB,LRD0,XENT)) Q:XENT=""  D
 ...S X=^TMP("LRJ SYS F60 AUD MANAGER",$J,XSUB,LRD0,XENT)
 ...D ADD^LRJSAU(.VALMCNT,X)
 Q
 ;
AUDCHK(DISPLAY) ; -- check files/fields to see if they are audited for file 60
 ; 
 ; DISPLAY  - [Input/Optional] 
 ;          - if  0 or does not exist, return 1 if all fields in the list are audited,  0 otherwise
 ;                  if 1 or -1  populate the VALMCNT array too as described below.
 ;          - if  1 populate VALMCNT for all the fields in the list  and change the VALM header
 ;          - if -1 populate VALMCNT for all the fields that their audit field is turned off, but do not change the VALM header
 ;  
 ;  VALMCNT - [global/Input/Output] last entry in List Manager 
 ;   VALMAR - [global/Output] reference to List Manager list of fields that their audit is on or off,
 ;                   like   "^TMP("LRJ SYS ORDERS MANAGER",$JOB)"
 ;
 ;  Returns  1 if all audited fields are on,  otherwise 0.
 ; 
 N LRI,LRJ,LRALINE,LRAFLDS,LRSUBFLD,LRAUDIT,X,FLDAUDIT,SPACE,HDRDISP,FLDTITL,XAUD,XFILENUM,XNEW
 S SPACE=$J("",47)
 S DISPLAY=+$G(DISPLAY),XNEW=0
 S HDRDISP=0 ; intialize as header not displayed
 S LRAUDIT=1 ; assume audit  is ON for all fields
 F LRI=1:1 S LRALINE=$P($TEXT(AFLDS+LRI^LRJSAU),";;",2) Q:LRALINE="$$END$$"  D
 .I +LRALINE'=60 Q
 .S LRSUBFLD=$P($P(LRALINE,"^"),";",2)
 .F LRJ=1:1 S LRAFLDS=$P($P(LRALINE,"^",2),";",LRJ) Q:LRAFLDS=""  D
 .. D AUDCHK2(+LRALINE,LRSUBFLD,LRAFLDS)
 N MONLIST S FILENUM=60 D GMONLIST(FILENUM,.MONLIST)
 S XFILENUM="",XNEW=1
 F  S XFILENUM=$O(MONLIST(XFILENUM)) Q:XFILENUM=""  D
 .S LRALINE=MONLIST(XFILENUM)
 .F LRJ=1:1 S LRAFLDS=$P(LRALINE,";",LRJ) Q:LRAFLDS=""  D
 .. I XFILENUM=FILENUM,LRJ=1 Q
 .. D AUDCHK2(XFILENUM,"",LRAFLDS)
 Q LRAUDIT
 ;
AUDCHK2(XFILENUM,XFLDSUB,LRAFLDS) ;
 ; XFILENUM (input) - file or subfile # if known
 ; XFLDSUB (input/opt) - If a subfield and subfile not in XFILENUM, this is the field # for the subfile
 N X
 S FLDAUDIT=1 ; assume audit is ON for ONLY this field.
 I XFLDSUB D  ; If present, field is within a subfile XFLDSUB of XFILENUM
 .N OUT
 .S OUT=+$$GFLDSB(XFILENUM,XFLDSUB)
 .I OUT S XFILENUM=OUT
 I '$$ISAUDON(XFILENUM,LRAFLDS) S LRAUDIT=0,FLDAUDIT=0
 I (DISPLAY=1)!((DISPLAY=-1)&(FLDAUDIT=0)) D
 .I 'HDRDISP  D  ; if the header is not already displayed, display it.
 ..S FLDTITL="Field"_$J("",15)_"File Name"_$J("",11)_"Field Name"_$J("",15)_"Audit"_$J("",14)
 ..I DISPLAY=1 D 
 ...S VALMHDR(1)=$J("",26)_"List of Audited Fields"
 ...S VALMHDR(2)="  Asterisk (*) beside field name denotes required field for audit"
 ...D CHGCAP^VALM("HEADER",FLDTITL)
 ..I DISPLAY=-1 D
 ...D ADD^LRJSAU(.VALMCNT," "_FLDTITL)
 ...S X=" ",$P(X,"-",73)=""
 ...D ADD^LRJSAU(.VALMCNT,X)
 ..S HDRDISP=1 ; flag the header as displayed
 ..Q
 .S X=" "_60_"."_$S(XFILENUM=60&($E(LRAFLDS)="."):$P(LRAFLDS,".",2),XFILENUM=60:LRAFLDS,1:XFILENUM)
 .I XFILENUM'=60 S X=X_$S($E(LRAFLDS)'=".":".",1:"")_LRAFLDS
 .S X=$E(X_SPACE,1,17)
 .S X=X_$E($$GFILENM(XFILENUM)_SPACE,1,19)_" "
 .S X=X_$E($$GFLDNM(XFILENUM,LRAFLDS)_$S('$G(XNEW):"*",1:" ")_SPACE,1,27)
 .S XAUD=$$GET1^DID(XFILENUM,LRAFLDS,"","AUDIT")
 .S X=X_" "_$S(XAUD]"":XAUD,1:"** NOT AUDITED **")
 .D ADD^LRJSAU(.VALMCNT,X)
 Q
 ;
ISAUDON(FILENUM,FLDNUM) ; -- is audit on for the given file/field number
 Q ($$GET1^DID(FILENUM,FLDNUM,"","AUDIT")["YES, ALWAYS")
 ;
GFLDSB(FILENUM,FLDNUM) ;if field is multiple, return subfile #
 N LRX
 D FIELD^DID(FILENUM,FLDNUM,"","SPECIFIER","LRX")
 Q +$G(LRX("SPECIFIER"))
 ;
GFILENM(FILENUM) ;  -- get the file/subfile name for given file ien
 N LRX,LRE
 I $D(^DIC(FILENUM,0)) D  ; Not a subfile
 .S LRX=$$GET1^DID(FILENUM,"","","NAME","LRX","LRE")
 E  D  ; subfile
 .S LRX=$O(^DD(FILENUM,0,"NM",""))
 Q $G(LRX)
 ;
GFLDNM(FILENUM,FLDNUM) ;  -- get the field name for given file/sub-file ien and field number
 N OUT
 D FIELD^DID(FILENUM,FLDNUM,"","LABEL","OUT")
 Q $G(OUT("LABEL"))
 ;
GMONLIST(FILENUM,MONLIST) ; return the list of fields to be monitored from configuration file.
 N ARR,IEN,FLDNUM,FLDLIST,NODE,VAR,XFILENUM
 S IEN=$O(^LABAUD(64.9178,"B",FILENUM,0))
 D GETS^DIQ(64.9178,IEN_",","**","","ARR")
 S VAR="ARR"
 S MONLIST=""
 S NODE=$NAME(@VAR@(64.9178))
 F  S NODE=$Q(@NODE)  Q:NODE=""  Q:$QS(NODE,3)'=.01  D
 .S FLDNUM=$P(@NODE,"^",1)
 .S XFILENUM=$S(FLDNUM'[",":60,1:$P(FLDNUM,","))
 .S MONLIST(XFILENUM)=$S($D(MONLIST(XFILENUM)):MONLIST(XFILENUM)_";",1:"")_$S(FLDNUM'[",":FLDNUM,1:$P(FLDNUM,",",2))
 Q
 ;
 ; if '^' out of prompts, allow exit/added parameter
FILENUM(LROUT) ;
 K DIR
 S LROUT=0
 S FILENUM=60
 D GIENLIST(FILENUM,.IENLIST)
 I $D(DTOUT)!$D(DUOUT) S LROUT=1 Q
 I '$D(IENLIST) W !,"  ALL TESTS"
 ;Select FROM DATE
 S LRFRDT=$$DATEENT("Select Start date: ",,"-NOW")
 I LRFRDT<1 S:$D(DTOUT)!$D(DUOUT) LROUT=1 Q
 S LRTODT=$$DATEENT("  Select End date: ",LRFRDT,"-NOW")
 I $D(DTOUT)!$D(DUOUT) S LROUT=1 Q
 I +LRTODT<1 S:$D(DTOUT)!$D(DUOUT) LROUT=1 Q
 D MSG2
 Q
 ;
GIENLIST(FILENUM,IENLIST) ; get list of entries (ien) For a given file into IENLIST array.
 N DIC,X,Y,U
 K IENLIST
 S DIC("0")="AEQM"
 S DIC=FILENUM
 S Y=-1
 F  D  Q:+Y=-1
 .D ^DIC
 .S:+Y'=-1 IENLIST(+Y)=""
 Q
 ;
DATEENT(LRPRMPT,LRBD,LRED) ;Prompt for extract date
 ;INPUT
 ; LRPRMPT - Prompt displayed to user
 ; LRBD    - Begin date of range
 ; LRED    - End date of range
 ;
 ;RETURN
 ; LRDT
 ;  SUCCESS: FILEMAN INTERNALLY FORMATED DATE
 ;  FAILURE: -1
 ;
 N LRDT,LRGOOD,X,Y
 S LRGOOD=0
 S:+$G(LRED)>0 %DT(0)=LRED
 S:$G(LRED)["NOW" %DT(0)=LRED
 S %DT("A")=LRPRMPT
 S %DT("B")="TODAY" ;Default for [Start] date entry
 S %DT="AEPST"
 D:LRPRMPT["Start" ^%DT ;Prompt for Start date
 ;
 ;Prompt for End date with conditions
 I LRPRMPT["End" D
 .F  Q:LRGOOD  D
 ..S %DT("B")="NOW" ;Change default for End Date entry
 ..D ^%DT
 ..W:((Y<LRBD)&(X'="^")&('$D(DTOUT))) " ??",!,"   End date must follow Begin date!",!
 ..S:((Y>LRBD)!(Y=LRBD)!($D(DTOUT))!(X="^")) LRGOOD=1
 S LRDT=Y
 K Y,%DT
 Q LRDT
 ;
MSG2 ; -- set default message
 N LREND,LRBEGIN,LRAUTMSG
 S LRBEGIN=$$GET^XPAR("SYS","LRJ LSRP AUF60 LAST START DATE",1,"Q")
 S LREND=$$GET^XPAR("SYS","LRJ LSRP AUF60 LAST END DATE",1,"Q")
 I (LRBEGIN'="")!(LREND'="") D 
 .S LRAUTMSG="Last Task Rpt "_$S(LRBEGIN'="":$$FMTE^XLFDT(LRBEGIN),1:"undeed")_" - "_$S(LREND'="":$$FMTE^XLFDT(LREND),1:"undefined")
 I LRBEGIN="",LREND="" D 
 .S LRAUTMSG="Tasked Report has not run!"
 S VALMSG=LRAUTMSG
 Q
 ;
GIOP(DEVICE) ; --  return the device if exist and it is not FORCED to queue, otherwise return ""  
 N POP
 S IOP=DEVICE
 S %ZIS="N" ; so the ^%ZIS call does not open the device. 
 D ^%ZIS ; return the characteristics of the device.
 I POP=1  DO  ; does the device exist? 
 .S DEVICE=""
 E  D
 .; is the queuing forced forced for this device?
 .I $P(^%ZIS(1,IOS,0),"^",12)=1 S DEVICE=""
 ;
 D ^%ZISC ; restore the device variables 
 Q DEVICE
 ;
SETTMP(D0,LRIEN,LRDT,LRUSER,LRFLDNM,LRFNUM,LROLD,LRNEW) ;
 ; ^TMP("LRDATA",$J,OLD/NEW determination,test ien,data element)=data element value
 I $D(IENLIST),'$D(IENLIST(+LRIEN)) Q  ; test is not one of those selected
 N Q
 F Q="LRIEN","LRDT","LRUSER","LRFLDNM","LRFNUM","LROLD","LRNEW" S ^TMP("LRDATA",$J,D0,Q)=@Q
 ;determine if new test was entered
 I LRFLDNM="NAME",LROLD["<no previous",LRIEN=+LRIEN S ^TMP("LRDATA",$J,"NEW",LRIEN,D0)=LRDT Q
 I $D(^TMP("LRDATA",$J,"NEW",+LRIEN)) D
 .;Check for within 2 hr window
 .N DIFF,X1,X2
 .S X1=+$O(^TMP("LRDATA",$J,"NEW",+LRIEN,0)),X1=$G(^TMP("LRDATA",$J,"NEW",+LRIEN,X1))
 .S X2=LRDT
 .S DIFF=$$FMDIFF^XLFDT(X2,X1,2) ; find difference in seconds (2 hrs = 7200 secs)
 .I DIFF'>7200 S ^TMP("LRDATA",$J,"NEW",+LRIEN,D0)=""
 Q
 ;
