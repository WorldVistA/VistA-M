PXKMAIN ;ISL/JVS,PKR,ISA/Zoltan - Main Routine for Data Capture ;03/12/2020
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**22,59,73,88,69,117,130,124,174,164,210,215,216,211**;Aug 12, 1996;Build 454
 ;+This routine is responsible for:
 ;+
 ;+LOCAL VARIABLE LIST:
 ;+ PXFG     = Stop flag with duplicate of delete
 ;+ PXKAFT   = After node
 ;+ PXKBEF   = Before node
 ;+ PXKAV    = Pieces from the after node
 ;+ PXKBV    = Pieces from the before node
 ;+ PXKERROR = Set when there is an error
 ;+ PXKFGAD  = ADD flag
 ;+ PXKFGED  = EDIT flag
 ;+ PXKFGDE  = DELETE flag
 ;+ PXKSEQ   = Sequence number in PXK TMP global
 ;+ PXKCAT   = Category of entry (CPT,MSR,VST...)
 ;+ PXKREF   = Root of temp global
 ;+ PXKPIEN  = IEN of v file or the visit file
 ;+ PXKREF   = The original reference we are ordering off of
 ;+ PXKRT    = name of the node in the v file
 ;+ PXKRTN   = routine name for the file routine
 ;+ PXKSOR   = the data source for this entry
 ;+ PXKSUB   = the subscript the data is located on the v file
 ;+ PXKVST   = the visit IEN
 ;+ PXKDUZ   = the DUZ of the user
 ;+ *PXKHLR* = A variable set by calling routine so that duplicate
 ;+            PXKERROR messages aren't produced.
 ;
 W !,"This is not an entry point" Q
EN1 ;+Main entry point to read ^TMP("PXK", Global
 ;+ Partial ^TMP Global Structure when called:
 ;+ ^TMP("PXK",$J,"SOR") = Source ien
 ;+
 ;+ ^TMP("PXK",$J,"VST",1,0,"BEFORE") = the 0-node of the visit file
 ;+ ^TMP("PXK",$J,"VST",1,0,"AFTER") = 0-node after changes.
 ;+ ^TMP("PXK",$J,"VST",provider counter,"IEN") = ""
 ;+
 ;+ ^TMP("PXK",$J,"PRV",provider counter,0,"BEFORE") = ""
 ;+ ^TMP("PXK",$J,"PRV",provider counter,0,"AFTER") = Provider id^DFN^Visitien^'P' or 'S' for primary/secondary
 ;+ ^TMP("PXK",$J,"PRV",provider counter,"IEN") = ""
 ;+ ^TMP("PXK",$J,"PRV",provider counter,"BEFORE") = ""
 ;+ ^TMP("PXK",$J,"PRV",provider counter,"AFTER") = ^Package ien^Source ien
 ;+
 N LOCK,PXKDUZ,VISITIEN
 K PXKERROR
 I '$G(PXKDUZ) S PXKDUZ=$S($G(DUZ):DUZ,1:.5)
 D VST(.VISITIEN,PXKDUZ,.LOCK)
 I LOCK=0 S PXAERRF=4 Q
 I VISITIEN>0 D UNLOCK^PXLOCK(VISITIEN,PXKDUZ)
 Q
 ;
 ;VST ;--Check for visit node and get one created or quit.
VST(VISITIEN,PXKDUZ,LOCK) ;--Check for visit node and get one created or quit.
 S LOCK=0,VISITIEN=""
 I '$G(^TMP("PXK",$J,"VST",1,"IEN")) D VSIT^PXKVST
 I +$G(^TMP("PXK",$J,"VST",1,"IEN"))=-1 S PXKERROR("VISIT")="Visit Tracking could not get a visit." Q
 I +$G(^TMP("PXK",$J,"VST",1,"IEN"))=-2 S PXKERROR("VISIT")="PCE is not activated in Visit Tracking Parameters and thus cannot create visits." Q
 I +$G(^TMP("PXK",$J,"VST",1,"IEN"))<1 S PXKERROR("VISIT")="Did not get a visit^"_$G(^TMP("PXK",$J,"VST",1,"IEN")) Q
 S VISITIEN=^TMP("PXK",$J,"VST",1,"IEN")
 S LOCK=$$LOCK^PXLOCK(VISITIEN,PXKDUZ,2,.PXKERROR)
 I LOCK=0 Q
 ;
NEW ;--New variables and set main variables
 N PXKDFN,PXKSOR,PXKVST,PXKSEQ,PXFG,PXKAFT,PXKBEF,PXKAUDIT
 N PXKCAT,PXKCO,PXKER,PXKFGAD,PXKFGED,PXKFGDE,PXKNOD,PXKPCE
 N PXKPIEN,PXKREF,PXKRTN,PXKSORR,PXKSUB,PXKVCAT
 N PXKPTR,PXDFG,PX,PXJJ,PXJJJ,PXKAFT8,PXKAFTR,PXKGN,PXKN,PXKNOW,PXKP
 N PXKRRT,PXKVRTN,PXKRT,PXKFVDLM,TMPPX
PRVTYPE ;---DO PROVIDER TYPE--PXKMAIN2
 D PRVTYPE^PXKMAIN2
 ;
SET ;--SET VARIABLES NECESSARY
 ;'DA' should not be defined at this point
 N DA ;PX*1.0*117
 ;
 S PXFG=0,TMPPX="^",PXKLAYGO="",PXDFG=0
SOURCE S PXKSOR=$G(^TMP("PXK",$J,"SOR")) D  Q:$D(PXKERROR("SOURCE"))
 .S PXKCO("SOR")=PXKSOR
 .I $D(PXKSOR)']"" S PXKERROR("SOURCE")="" Q
VISIT S (PXKVST,VSIT("IEN"))=$G(^TMP("PXK",$J,"VST",1,"IEN"))
ORDER ;--$ORDER Through the ^TMP("PXK", global setting variables
 S PXKREF="^TMP(""PXK"",$J)"
CATEG S PXKCAT="" F  S (PXKCAT,PXKVCAT)=$O(@PXKREF@(PXKCAT)) Q:PXKCAT=""  D
 .I PXKCAT="VST" S PXKVCAT="SIT"
 .S PXKRTN="PXKF"_PXKCAT
 .S X=PXKRTN X ^%ZOSF("TEST") Q:'$T
SEQUE .S PXKSEQ=0 F  S PXKSEQ=$O(@PXKREF@(PXKCAT,PXKSEQ)) K PXKAV,PXKBV S PXFG=0 Q:'PXKSEQ  D
 ..S PXKPIEN=$G(@PXKREF@(PXKCAT,PXKSEQ,"IEN")),(PXKFGAD,PXKFGDE,PXKFGED,PXDFG)=0
SUBSCR ..S PXKSUB="" F  S PXKSUB=$O(@PXKREF@(PXKCAT,PXKSEQ,PXKSUB)) Q:PXKSUB["IEN"  Q:PXFG=1  Q:PXDFG=1  D
AFTER ...S PXKAFT(PXKSUB)=$G(@PXKREF@(PXKCAT,PXKSEQ,PXKSUB,"AFTER"))
BEFORE ...S PXKBEF(PXKSUB)=$G(@PXKREF@(PXKCAT,PXKSEQ,PXKSUB,"BEFORE"))
 ...I PXKCAT="CPT",PXKSUB=1 D SUBSCR^PXKMOD
 ...I PXKCAT="IMM",PXKSUB?1(1"2",1"3",1"11") D MULT
 ...D LOOP^PXKMAIN1 I PXKSUB=0 D ERROR^PXKMAIN1
 ...S PXDFG=0 I $G(PXKAV(0,1))["@"!('$D(PXKAV(0,1))) S PXKAFT(PXKSUB)="" K PXKAV(0) S PXDFG=1
 ..Q:PXFG=1
 ..I $D(PXKAV),'$D(PXKBV) S PXKSORR=PXKSOR_"-A "_PXKDUZ,PXKFGAD=1 I PXKCAT["VST" S PXKFGAD=0
 ..I '$D(PXKAV),$D(PXKBV) S PXKFGDE=1,PXKFVDLM="" D
 ...S PXKRT=$P($T(GLOBAL^@PXKRTN),";;",2)_"("_PXKPIEN_")" I $D(@PXKRT) D CHKAUD,DELETE^PXKMAIN1,EN1^PXKMASC S PXFG=1 K PXKRT Q
 ..I 'PXKFGAD,'PXKFGDE D
 ...I PXKCAT="VST" D CQDEL
 ...D CLEAN^PXKMAIN1
 ...I $D(PXKAV) S PXKSORR=PXKSOR_"-E "_PXKDUZ,PXKFGED=1 I PXKCAT="VST",'$D(PXKBV),$D(PXKVST) S PXKFGED=0
 ..I 'PXKFGAD,'PXKFGDE,'PXKFGED,PXKCAT["VST" D EN1^PXKMASC
 ..I PXKFGAD=1 D  Q:PXFG
 ...D ERROR^PXKMAIN1
 ...I $D(PXKERROR(PXKCAT,PXKSEQ)) S PXFG=1
 ...D:'PXFG DUP^PXKMAIN1
 ...I PXFG=1 D  Q
 ....Q:PXKCAT'="CPT"
 ....I $G(@PXKREF@(PXKCAT,PXKSEQ,"IEN"))]"" D REMOVE^PXCEVFIL(@PXKREF@(PXKCAT,PXKSEQ,"IEN"))
 ...;FILE^PXKMAIN1 MAKES THE ENTRY
 ...D:'PXKPIEN FILE^PXKMAIN1
 ...S:'$G(DA) DA=PXKPIEN
 ...D AUD2^PXKMAIN1,DRDIE^PXKMAIN1,EN1^PXKMASC
 ..I PXKFGED=1,PXKCAT'="VST" S PXKRT=$P($T(GLOBAL^@PXKRTN),";;",2)_"("_PXKPIEN_")" Q:'$D(@PXKRT)  S DA=PXKPIEN D DUP^PXKMAIN1 Q:PXFG=1  D AUD12^PXKMAIN1,CHKAUD,DRDIE^PXKMAIN1,EN1^PXKMASC
 ..I PXKFGED=1,PXKCAT="VST" S PXKRT=$P($T(GLOBAL^@PXKRTN),";;",2)_"("_PXKPIEN_")" Q:'$D(@PXKRT)  S DA=PXKPIEN D DUP^PXKMAIN1 Q:PXFG=1  D DRDIE^PXKMAIN1,EN1^PXKMASC
 ..D SPEC2^PXKMAIN2
 ..D EN^PXKMCODE
 ..K PXKAFT,PXKBEF
 I $D(^TMP("PXKSAVE",$J)) D RECALL^PXKMAIN2
 D EXIT
 Q
 ;
MULT ; Add multiples to PXKAFT, PXKBEF, PXKAV, PXKBV arrays
 ;
 N PXKSUBIEN,PXKI
 ;
 S PXKSUBIEN=0
 F  S PXKSUBIEN=$O(@PXKREF@(PXKCAT,PXKSEQ,PXKSUB,PXKSUBIEN)) Q:'PXKSUBIEN  D
 . ;
 . I $D(@PXKREF@(PXKCAT,PXKSEQ,PXKSUB,PXKSUBIEN,"AFTER")) D
 . . S PXKAFT(PXKSUB,PXKSUBIEN)=$G(@PXKREF@(PXKCAT,PXKSEQ,PXKSUB,PXKSUBIEN,"AFTER"))
 . . F PXKI=1:1:$L(PXKAFT(PXKSUB,PXKSUBIEN),"^") D
 . . . I $P(PXKAFT(PXKSUB,PXKSUBIEN),"^",PXKI)'="" S PXKAV(PXKSUB,PXKSUBIEN,PXKI)=$P(PXKAFT(PXKSUB,PXKSUBIEN),"^",PXKI)
 . ;
 . I $D(@PXKREF@(PXKCAT,PXKSEQ,PXKSUB,PXKSUBIEN,"BEFORE")) D
 . . S PXKBEF(PXKSUB,PXKSUBIEN)=$G(@PXKREF@(PXKCAT,PXKSEQ,PXKSUB,PXKSUBIEN,"BEFORE"))
 . . F PXKI=1:1:$L(PXKBEF(PXKSUB,PXKSUBIEN),"^") D
 . . . I $P(PXKBEF(PXKSUB,PXKSUBIEN),"^",PXKI)'="" S PXKBV(PXKSUB,PXKSUBIEN,PXKI)=$P(PXKBEF(PXKSUB,PXKSUBIEN),"^",PXKI)
 ;
 I $G(@PXKREF@(PXKCAT,PXKSEQ,PXKSUB,0,"AFTER"))="@" D
 . S PXKAFT(PXKSUB,0)="@"
 . S PXKAV(PXKSUB,0)="@"
 ;
 Q
 ;
CHKAUD ; Check and turn on Auditing
 I PXKCAT="IMM" D TURNON^DIAUTL(9000010.11,"*","y")
 Q
 ;
EXIT ;--EXIT
 I $D(PXKFVDLM) D MODIFIED^VSIT(PXKVST)
 K PXKPXD,TMPPX
 K DA,DR,PXKI,PXKJ,PXKLAYGO,PXKDUZ,PXKAFT8,PXKAFTR,VSIT("IEN")
 Q
 ;
EVENT ;--ENTRY POINT TO POST EXECUTE PCE'S EVENT
 ;Setting the variable PXKNOEVT=1 will stop the event from being
 ;fired off whenever any data is sent into PCE
 ;
 ;PX*1*124  AUTO-POPULATE THE ENCOUNTER SC/EI BASED ON THE ENCOUNTER DX'S
 ;PX*1.0*164 Relocate the PXCECCLS call
 I $D(^TMP("PXKCO",$J)) D
 . S PXKVVST=+$O(^TMP("PXKCO",$J,0))
 . I $G(PXKVVST),$D(^AUPNVSIT(PXKVVST)) D VST^PXCECCLS(PXKVVST) ;PX*1.0*174
 ;
 I $G(PXKNOEVT) K ^TMP("PXKCO",$J) Q
 D EVENT^PXKMASC
 Q
 ;
CQDEL ;Classification question deletion check
 I PXKCAT'="VST" Q
 S PXJ="" F  S PXJ=$O(PXKBV(800,PXJ)) Q:'PXJ  I PXKBV(800,PXJ)'="" I '$D(PXKAV(800,PXJ)) S PXKAV(800,PXJ)="@"
 K PXJ Q
 ;
