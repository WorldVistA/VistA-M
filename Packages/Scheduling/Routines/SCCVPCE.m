SCCVPCE ;ALB/TMP - Send data to PCE; [ 01/28/98  10:19 AM ]
 ;;5.3;Scheduling;**211**;Aug 13, 1993
 ;
DATA2PCE(SDOE,SCCONS,SCCVEVT,SCOEP,SCDTM,SCDA,SCEST) ; -- send data to pce
 ;Input:
 ;   SCOE     Internal entry # of encounter
 ;   SCCONS   Array containing constant data for the conversion ...
 ;               needed for reconvert to work properly
 ;            ("PKG")  = Scheduling package pointer
 ;            ("SRCE") = source name for the conversion
 ;   SCCVEVT   1 for estimate, 2 for convert
 ;   SCOEP    Parent encounter [optional]
 ;   SCDTM    Date/time of add/edit entry if no encounter [optional]
 ;   SCDA     'CS' entry ien if add/edit, no encounter [optional]
 ;Output:
 ;   SCEST  Variable of '^' pieces that contain # of entries to be added:
 ;            # providers^# diagnoses^# procedures 
 ;
 N PXKNOEVT,SDOE0,X,SDVST,SDPRV,SDIAG,SDCLS,SDPROC,SCPCE,SDOEC,SCE,SCERRM
 ;
 K ^TMP("PXK-SD",$J),^TMP("PXK",$J)
 S SCEST=0
 ; -- gather needed data
 S SDOE0=$G(^SCE(SDOE,0))
 ;
 I SCCVEVT G DATAQ:SDOE0=""
 ;
 S SDVST=$S('$G(SCOEP):+$P(SDOE0,U,5),1:+$P($G(^SCE(SCOEP,0)),U,5))
 ;
 I SCCVEVT G DATAQ:'SDVST
 ;
 ; -- if child visit and has v-file data quit
 I $S('$G(SCOEP):0,1:$O(^AUPNVCPT("AD",SDVST,0))!($O(^AUPNVPRV("AD",SDVST,0)))!($O(^AUPNVPOV("AD",SDVST,0)))) G DATAQ
 ;
 ; -- Get data from encounter for providers, diagnoses, classifications
 D SET(SDOE,"SDPRV",409.44)
 D SET(SDOE,"SDIAG",409.43)
 D SET(SDOE,"SDCLS",409.42)
 ; -- Get data for procedures
 I '$G(SCOEP) D  ; look for parents only so data not duplicated
 . D PROC(SDOE,+$G(SCDTM),+$G(SCDA),SCCVEVT,"SDPROC")
 ;
 ; -- Build PCE data array
 D BUILD("SDPRV","SDIAG","SDCLS","SDPROC","SCPCE","^TMP(""PXK-SD"","_$J_")",+$P(SDOE0,U,2),SDVST)
 ;
 ; For Estimate, count # of cpt's, dx's, providers to be added
 I 'SCCVEVT D  G DATAQ ;Estimate exits here
 . S SCEST=+$O(^TMP("PXK-SD",$J,"PRV",""),-1)_U_+$O(SCPCE("DX/PL",""),-1)_U_+$O(SCPCE("PROCEDURE",""),-1)
 ;
 ; -- Call PCE APIs to file additional data
 S PXKNOEVT=1 ;Needed to keep sched events from being fired off by PCE
 ;
 I $D(SCPCE),$$DATA2PCE^PXAPI("SCPCE",$G(SCCONS("PKG")),$G(SCCONS("SRCE")),SDVST)<0 D
 . N Z,Z0,Z1,SCTEXT,SCX
 . S (Z,Z1)=0
 . F  S Z=$O(SCPCE("DIERR",Z)) Q:'Z  S Z0=0 F  S Z0=$O(SCPCE("DIERR",Z,"TEXT",Z0)) Q:'Z0  S SCTEXT=$TR(SCPCE("DIERR",Z,"TEXT",Z0)," ") I SCTEXT'="" D
 .. S:Z0=1&(Z>1) Z1=Z1+1,SCERRM(Z1)="  -----"
 .. I SCTEXT["SCPCE.." S SCX=$P(SCTEXT,"=",2) D  Q
 ... I SCTEXT["DX/PL" S Z1=Z1+1,SCERRM(Z1)="  DIAGNOSIS "_+SCX_" ("_$S($D(^ICD9(+SCX,0)):$P(^(0),U),1:"UNDEFINED")_") WAS NOT CONVERTED" D SETERR^SCCVZZ("POV",SCOE,+SCX,$G(SCLOG))
 ... I SCTEXT["PROCEDURE" S Z1=Z1+1,SCERRM(Z1)="  PROCEDURE "_+SCX_" ("_$S($D(^ICPT(+SCX,0)):$P(^(0),U),1:"UNDEFINED")_") WAS NOT CONVERTED" D SETERR^SCCVZZ("CPT",SCOE,+SCX,$G(SCLOG))
 .. S Z1=Z1+1,SCERRM(Z1)=SCPCE("DIERR",Z,"TEXT",Z0)
 . S SCE("DFN")=$P(SDOE0,U,2),SCE("ENC")=SDOE,SCE("VSIT")=SDVST,SCE("DATE")=+SDOE0
 . I $O(SCERRM("")) D
 .. D LOGERR^SCCVLOG1($G(SCLOG),.SCERRM,.SCE,.SCCVERRH)
 .. I '$G(SCLOG) D
 ... N Z,Z0 S Z=0,Z0=$O(SCERRMSG(""),-1) F  S Z=$O(SCERRM(Z)) Q:'Z  S Z0=Z0+1,SCERRMSG(Z0)=SCERRM(Z,0)
 ;
 I $D(^TMP("PXK-SD",$J)) D  ;Convert providers
 . N Z,Z0,Z1,SCTEXT,SCX
 . M ^TMP("PXK",$J)=^TMP("PXK-SD",$J)
 . K ^TMP("PXK-SD",$J)
 . D EN1^PXKMAIN
 . S Z="PXKERROR(""PRV"")",Z1=0
 . F  S Z=$G(@Z) Q:Z'["PXKERROR(""PRV"""  S SCTEXT=$G(@Z) D
 .. S SCX=+$G(^TMP("PXK",$J,"PRV",+$QS(Z,2),0,"AFTER"))
 .. S Z1=Z1+1 S:Z1>1 SCERRM(Z1)="  -----",Z1=Z1+1
 .. S SCERRM(Z1)="  PROVIDER ERROR "_SCX_" ("_$S($D(^VA(200,SCX,0)):$P(^(0),U),1:"UNDEFINED")_") WAS NOT CONVERTED"
 .. S Z1=Z1+1,SCERRM(Z1)="    "_SCTEXT
 .. D SETERR^SCCVZZ("PRV",SCOE,SCX,$G(SCLOG))
 . K ^TMP("PXK",$J),PXKERROR
 ;
DATAQ Q
 ;
BUILD(SDPROV,SDDX,SDCLASS,SDCPT,SDATA,SPDATA,DFN,SDVST) ; -- bld pce data arrays
 N X,SDI,SDIEN,SDCNT,SDSEQ,SCSRCE
 S SCSRCE=$$SOURCE^PXAPI($G(SCCONS("SRCE")))
 S SDI=0 F  S SDI=$O(@SDCLASS@(SDI)) Q:'SDI  D
 . S X=@SDCLASS@(SDI)
 . S @SDATA@("ENCOUNTER",1,$P("AO^IR^SC^EC",U,+X))=$P(X,U,3)
 ;
 ; -- set dx info
 I $O(@SDDX@(0)) D
 . S (SDCNT,SDIEN)=0
 . F  S SDIEN=$O(@SDDX@(SDIEN)) Q:'SDIEN  D
 . . S X=@SDDX@(SDIEN)
 . . S SDCNT=SDCNT+1
 . . S @SDATA@("DX/PL",SDCNT,"DIAGNOSIS")=+X
 ;
 ; -- set cpt info
 I $O(@SDCPT@(0)) D
 . ; -- count times performed
 . N SDX
 . S (SDCNT,SDSEQ)=0
 . F  S SDSEQ=$O(@SDCPT@(SDSEQ)) Q:'SDSEQ  D
 . . S SDIEN=@SDCPT@(SDSEQ)
 . . S SDX(+SDIEN)=$G(SDX(+SDIEN))+1
 . ;
 . ; -- build nodes
 . S (SDCNT,SDIEN)=0
 . F  S SDIEN=$O(SDX(SDIEN)) Q:'SDIEN  D
 . . S X=SDX(SDIEN)
 . . S SDCNT=SDCNT+1
 . . S @SDATA@("PROCEDURE",SDCNT,"PROCEDURE")=SDIEN
 . . S @SDATA@("PROCEDURE",SDCNT,"QTY")=+X
 ;
 ; -- build prov pce data array to be stuffed
 ; Must be separate to call EN1^PXKMAIN to add so no check for prov class
 ;
 I $O(@SDPROV@(0)) D
 . K @SPDATA
 . S (SDCNT,SDIEN)=0
 . S @SPDATA@("VST",1,0,"AFTER")=$G(^AUPNVSIT(SDVST,0))
 . S @SPDATA@("VST",1,0,"BEFORE")=@SPDATA@("VST",1,0,"AFTER")
 . F  S SDIEN=$O(@SDPROV@(SDIEN)) Q:'SDIEN  D
 . . S X=@SDPROV@(SDIEN),SDCNT=SDCNT+1
 . . S @SPDATA@("SOR")=SCSRCE
 . . S @SPDATA@("PRV",SDCNT,0,"BEFORE")=""
 . . S @SPDATA@("PRV",SDCNT,0,"AFTER")=+X_U_DFN_U_SDVST_U_$S(SDCNT=1:"P",1:"S")_U
 . . S @SPDATA@("PRV",SDCNT,812,"BEFORE")=""
 . . S @SPDATA@("PRV",SDCNT,812,"AFTER")=U_$G(SCCONS("PKG"))_U_$$SOURCE^PXAPI($G(SCCONS("SRCE")))
 . . S @SPDATA@("PRV",SDCNT,"IEN")=""
 . . S @SPDATA@("VST",SDCNT,"IEN")=SDVST
 ;
 Q
 ;
BUILDQ Q
 ;
SET(SDOE,ARRAY,FILE) ;Set-up Array for Outpatient Encounter
 ; Input  -- SDOE      Outpatient Encounter IEN
 ; Output -- ARRAY     Provider or dx Array Subscripted by ien
 ;
 N SDIEN,SDDUP,SDCNT
 S SDIEN=0,SDCNT=0
 F  S SDIEN=$O(^SDD(FILE,"OE",SDOE,SDIEN)) Q:'SDIEN  D
 . S X=$G(^SDD(FILE,SDIEN,0)) Q:X=""!$S(FILE'[".42":$D(SDDUP(+X)),1:0)
 . S SDCNT=SDCNT+1,@ARRAY@(SDCNT)=X,SDDUP(+X)=""
 Q
 ;
PROC(SDOE,SCDTM,SCDA,SCCVEVT,SCDXARRY) ;
 ; SDOE = encounter ien
 ; SCDTM = if estimating and no enctr, dt/tm of the new encounter [opt]
 ; SCDA  = if estimating and no enctr, 'CS' node entry [opt]
 ; SCCVEVT = conversion event
 ; SCDXARRY = name of array to return
 N CNT,SDOEC
 S CNT=0,SDOE=+$G(SDOE),SDOEC=""
 I 'SDOE,'SCDTM,'SCDA G PROCQ
 ;
 ; - Use parent encounter for standalone add/edit
 ; - There may be no encounter yet if we're just estimating
 ;   ... it will never get here without an encounter if converting
 I $S('SDOE:1,1:$P($G(^SCE(SDOE,0)),"^",8)=2) D  G PROCQ
 . D GETPROC(.CNT,SDOE,$G(SCDTM),$G(SCDA),SCDXARRY) Q
 ;
 ;- Use child encounter(s) for appointment and disposition
 F  S SDOEC=$O(^SCE("APAR",SDOE,SDOEC)) Q:'SDOEC  I $P($G(^SCE(SDOEC,0)),"^",8)=2 D GETPROC(.CNT,SDOEC,"","",SCDXARRY)
 ;
 ;- Array of procedures
PROCQ S @SCDXARRY@(0)=CNT
 Q
 ;
 ;
GETPROC(CNT,ENC,SDVDT,EXTREF,SCDXARRY) ;Get procedures from Scheduling Visits file
 ;
 ;
 N DATE,DFN,I,NODE,PRNODE,SUB
 ;
 I ENC D  ;Find 'CS' node from encounter data
 . S NODE=$G(^SCE(ENC,0)),DATE=+$P(NODE,"^"),DFN=+$P(NODE,"^",2),EXTREF=$P(NODE,"^",9)
 . S DATE=$P(DATE,"."),SDVDT=$$SDVIEN^SCCVU(DFN,DATE)
 Q:'$G(SDVDT)
 F I=1:1:$L(EXTREF,":") D  ;Should not have > 1 for dates < 10-1-96
 . S SUB=+$P(EXTREF,":",I)
 . I '$D(^SDV(SDVDT,"CS",SUB,0)) Q
 . I ENC,$P(^SDV(SDVDT,"CS",SUB,0),U,8)'=ENC Q
 . S CNT=$G(CNT)+$$PRNODE(SDVDT,SUB,SCDXARRY)
 Q
 ;
PRNODE(SDVDT,SUB,SCDXARRY) ; Extract data for procs from SDV's 'PR' node
 ; SDVDT -- SDV entry ien 
 ; SUB   -- 'CS' node entry ien
 ; SCDXARRY -- the name of the array to return for the entry
 ;             SCDXARRY(0)= the total # of procedure codes
 ;             SCDXARRY(CPT code) = the total # of a particular CPT code
 N PRNODE,PCNT,X
 S PCNT=0
 S PRNODE=$G(^SDV(+SDVDT,"CS",+SUB,"PR"))
 I $L(PRNODE,"^")<1 G PRQ
 F X=1:1:$L(PRNODE,"^") I $P(PRNODE,"^",X)'="" S PCNT=PCNT+1,@SCDXARRY@($O(@SCDXARRY@(""),-1)+1)=$P(PRNODE,"^",X)
PRQ Q $G(PCNT)
 ;
