MDRPCOO ; HOIFO/DP - Object RPCs (TMDOutput) ; [03-24-2003 15:44]
 ;;1.0;CLINICAL PROCEDURES;;Apr 01, 2004
 ; Integration Agreements:
 ; IA# 2263 [Supported] Kernel Parameter APIs.
 ; IA# 2541 [Supported] API to get some Kernel System Parameter fields.
 ; IA# 2320 [Supported] %ZISH entry points.
 ;
ANALYZE ; [Procedure] Analyze an insturment interface
 ; Checks the CP instrument file for completeness of an entry.
 ; Special Note, variable RTN actually contains the IEN of the
 ; entry.
 ;
 ; Variables:
 ;  MDTMP: [Private] Scratch
 ;
 ; New private variables
 NEW MDTMP
 D INST^MDHL7U2(RTN,.MDTMP)
 S @RESULTS@(0)=MDTMP_U_MDTMP(0)
 F X=0:0 S X=$O(MDTMP(X)) Q:X=""  D
 .S @RESULTS@(X)=MDTMP(X)
 Q
 ;
DIQ(DD,IENS) ; [Procedure] Gather data about an entry
 ; Input parameters
 ;  1. DD [Literal/Required] DDNumber
 ;  2. IENS [Literal/Required] IENS of entry to retrieve
 ;
 K ^TMP($J)
 D GETS^DIQ(DD,IENS,"*","",$NA(^TMP($J)))
 Q
 ;
EXECUTE ; [Procedure] Execute the output
 D INIT
 D HFSOPEN("TMDOUTPUT")
 I POP S @RESULTS@(0)="-1^Unable to open HFS Device" Q
 U IO D @RTN
 D HFSCLOSE("TMDOUTPUT")
 D EXIT
 Q
 ;
EXIT ; [Procedure] Cleanup
 K ^TMP("DILIST",$J),^TMP($J)
 Q
 ;
HFSCLOSE(HANDLE) ; [Procedure] 
 ; Input parameters
 ;  1. HANDLE [Literal/Required] File Handle
 ;
 ; Variables:
 ;  MDDEL: [Private] Deletion array for Kernel
 ;  MDDIR: [Private] Holds VistA scratch directory
 ;  MDFILE: [Private] Unique filename
 ;
 ; New private variables
 NEW MDDEL,MDDIR,MDFILE
 D CLOSE^%ZISH(HANDLE)
 K @RESULTS
 S MDDIR=$$GET^XPAR("DIV","MD HFS SCRATCH")
 S MDFILE="MD"_DUZ_".DAT",MDDEL(MDFILE)=""
 S X=$$FTG^%ZISH(MDDIR,MDFILE,$NAME(@RESULTS@(1)),3)
 S Y=$O(@RESULTS@(""),-1)+1,@RESULTS@(Y)="[End of Report]"
 S X=$$DEL^%ZISH(MDDIR,$NA(MDDEL))
 Q
 ;
HFSOPEN(HANDLE) ; [Procedure] Open Host File for output
 ; Input parameters
 ;  1. HANDLE [Literal/Required] File Handle
 ;
 ; Variables:
 ;  MDDIR: [Private] VistA scratch directory
 ;  MDFILE: [Private] Unique file name
 ;
 ; New private variables
 NEW MDDIR,MDFILE
 S MDDIR=$$GET^XPAR("DIV","MD HFS SCRATCH")
 S MDFILE="MD"_DUZ_".DAT"
 D OPEN^%ZISH(HANDLE,MDDIR,MDFILE,"W") Q:POP
 Q
 ;
INIT ; [Procedure] Cleanup environment before starting
 K ^TMP("DILIST",$J),^TMP($J)
 Q
 ;
INST(IEN) ; [Procedure] Display Instrument
 ; Input parameters
 ;  1. IEN [Literal/Required] Instrument IEN or * for all
 ;
 ; Variables:
 ;  MDDX: [Private] Scratch counter
 ;
 ; New private variables
 NEW MDDX
 I $G(IEN,"*")="*" D  Q
 .W "NAME",?20,"PRINT NAME",?40,"SERIAL #",?50,"M RTN",?60,"PKG",?72,"ACTIVE"
 .D LIST^DIC(702.09,"","@;.01;.06;.08;.11;.12;.09","P")
 .F X=0:0 S X=$O(^TMP("DILIST",$J,X)) Q:'X  S MDDX=$G(^(X,0)) D
 ..W !,$$EXT($P(MDDX,U,2),18),?20,$E($P(MDDX,U,3),1,18),?40,$P(MDDX,U,4),?50,$P(MDDX,U,5),?60,$P(MDDX,U,6),?72,$P(MDDX,U,7)
 D DIQ(702.09,IEN_",")
 W $$LINE(702.09,IEN_",",.01,0,1),!!
 S X=.01 F  S X=$O(^TMP($J,702.09,IEN_",",X)) Q:'X  D
 .W !,$$LINE(702.09,IEN_",",X,30,1)
 Q
 ;
LINE(DD,IENS,FIELD,COL,TITLE) ; [Procedure] Display a default line of a field loaded from DIQ above
 ; Input parameters
 ;  1. DD [Literal/Required] DD Number
 ;  2. IENS [Literal/Required] Record IENS
 ;  3. FIELD [Literal/Required] Field number
 ;  4. COL [Literal/Required] Column for data
 ;  5. TITLE [Literal/Required] Use FileMan TITLE:1 or LABEL:0
 ;
 Q:'$$VFIELD^DILFD(DD,FIELD) ""
 W:$X>1 !
 W $S($G(TITLE):$$GET1^DID(DD,FIELD,"","TITLE"),1:$$GET1^DID(DD,FIELD,"","LABEL"))
 W ": ",?($G(COL,0)),$S(^TMP($J,DD,IENS,FIELD)]"":^(FIELD),1:"<Blank>")
 Q ""
 ;
PAR ; [Procedure] Display System Parameters
 ; Variables:
 ;  MD: [Private] Scratch
 ;  MDLST: [Private] Scratch
 ;  MDMULT: [Private] Scratch
 ;  MDPAR: [Private] Scratch
 ;  MDWP: [Private] Scratch
 ;
 ; New private variables
 NEW MD,MDLST,MDMULT,MDPAR,MDWP
 W "System Parameters For: ",$$KSP^XUPARAM("WHERE")
 D RPC^MDRPCOV(.X,"PARLST","SYS")
 F MD=0:0 S MD=$O(^TMP($J,MD)) Q:'MD  D
 .S MDPAR=$P(^TMP($J,MD),U,2)
 .S MDMULT=($P(^TMP($J,MD),U,5)="Yes")
 .S MDWP=($P(^TMP($J,MD),U,4)="word processing")
 .W !!,"Parameter:   ",MDPAR
 .W ?55,"Type:     ",$P(^TMP($J,MD),U,4)
 .W !,"Description: ",$P(^TMP($J,MD),U,3)
 .W ?55,"Multiple: ",$P(^TMP($J,MD),U,5)
 .D:'MDMULT  ; Not Multiple
 ..I 'MDWP W !,"      Value: ",$$GET^XPAR("SYS",MDPAR,,"E") Q
 ..K MDWP D GETWP^XPAR(.MDWP,"SYS",MDPAR,1) D
 ...W !,"WP-Text:"
 ...F X=0:0 S X=$O(MDWP(X)) Q:'X  W !?2,MDWP(X,0)
 .D:MDMULT  ; Multiple Instances
 ..D:'MDWP
 ...W !,?2,"Values:"
 ...D GETLST^XPAR(.MDLST,"SYS",MDPAR,"E")
 ...F X=0:0 S X=$O(MDLST(X)) Q:'X  D
 ....W !?2,$P(MDLST(X),"^",1)
 ....W ?30,"= ",$P(MDLST(X),U,2)
 ....;W !!," Instance: ",$P(MDLST(X),"^",1)
 ....;W !,"    Value: ",$P(MDLST(X),U,2)
 K ^TMP($J)
 Q
 ;
PROC(IEN) ; [Procedure] Display a procedure
 ; Input parameters
 ;  1. IEN [Literal/Required] Procedure IEN or * for all
 ;
 I $G(IEN,"*")="*" D  Q
 .W "NAME",?32,"TREATING SPECIALTY",?54,"TIU NOTE",?76,"LOCATION",?98,"ACTIVE",?108,"EXT DATA"
 .D LIST^DIC(702.01,"","@;.01;.02;.04;.05;.09;.03","P")
 .F X=0:0 S X=$O(^TMP("DILIST",$J,X)) Q:'X  D
 ..; Naked refs below are from ^TMP("DILIST",$J,X)
 ..W !,$$EXT($P(^(X,0),U,2),30)
 ..W ?32,$$EXT($P(^(0),U,3),20)
 ..W ?54,$$EXT($P(^(0),U,4),20)
 ..W ?76,$$EXT($P(^(0),U,5),20)
 ..W ?98,$P(^(0),U,6)
 ..W ?108,$P(^(0),U,7)
 D DIQ(702.01,IEN_",")
 W $$LINE(702.01,IEN_",",.01,0,1),!
 S X=.01 F  S X=$O(^TMP($J,702.01,IEN_",",X)) Q:'X  D
 .W !,$$LINE(702.01,IEN_",",X,32,1)
 K ^TMP("DILIST",$J),^TMP($J)
 W !!,"Associated Instruments",!,$TR($J("",30)," ","-"),!
 D LIST^DIC(702.011,","_IEN_",",.01,"P")
 I '$O(^TMP("DILIST",$J,0)) W ?5,"<None>"
 E  F X=0:0 S X=$O(^TMP("DILIST",$J,X)) Q:'X  W $P(^(X,0),U,2),!
 K ^TMP("DILIST",$J)
 Q
 ;
RPC(RESULTS,OPTION,RTN) ; [Procedure] Main RPC for TMD_Output Object
 ; RPC: [MD TMDOUTPUT]
 ;
 ; Input parameters
 ;  1. RESULTS [Literal/Required] RPC Return Array
 ;  2. OPTION [Literal/Required] Option to execute
 ;  3. RTN [Literal/Required] Routine to execute
 ;
 S RESULTS=$NA(^TMP("MD",$J)) K @RESULTS
 I $T(@OPTION)]"" D @OPTION
 D:'$D(@RESULTS) BADRPC^MDRPCU("MD TMDOUTPUT","MDRPCOO",OPTION)
 D CLEAN^DILF
 Q
 ;
EXT(VALUE,LENGTH) ; [Function] $Extract with ... trailer
 ; Input parameters
 ;  1. VALUE [Literal/Required] Value to truncate
 ;  2. LENGTH [Literal/Required] Result length
 ;
 I $L(VALUE)>LENGTH S VALUE=$E(VALUE,1,LENGTH-3)_"..."
 Q VALUE
 ;
