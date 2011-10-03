PXKENC ;ISL/dee,ESW - Builds the array of all encounter data for the event point ; 12/5/02 11:53am  ; 1/5/07 4:54pm
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**15,22,73,108,143,183**;Aug 12, 1996;Build 3
 Q
 ;
GETENC(DFN,ENCDT,HLOC) ;Get all of the encounter data
 ;Parameters:
 ;  DFN    Pointer to the patient (#9000001)
 ;  ENCDT  Date/Time of the encounter in Fileman format
 ;  HLOC   Pointer to Hospital Location (#44)
 ;
 ;Returns:
 ;  -2  if called incorrectly
 ;  -1  if could not find encounter
 ;  >0  Visit ien(s) separated by ^
 ;
 ;  The encounter is returned in the array
 ;    ^TMP("PXKENC",$J,pointer to visit)
 ;  may contain more than one visit
 ;
 N VISITIEN,REVDT,RETURN
 K ^TMP("PXKENC",$J)
 S RETURN=-1
 Q:DFN'>0!(ENCDT<1800000)!(HLOC'>0) -2
 S REVDT=(9999999-$P(+ENCDT,".",1))_$S($P(+ENCDT,".",2)'="":"."_$P(+ENCDT,".",2),1:"")
 S VISITIEN=0
 F  S VISITIEN=$O(^AUPNVSIT("AA",+DFN,REVDT,VISITIEN)) Q:'VISITIEN  D
 . I $P($G(^AUPNVSIT(VISITIEN,0)),"^",22)=HLOC,"C~S"'[$P($G(^AUPNVSIT(VISITIEN,150)),"^",3) D
 .. D ENCEVENT(VISITIEN,1)
 .. I RETURN<1 S RETURN=VISITIEN
 .. E  S RETURN=RETURN_"^"_VISITIEN
 Q RETURN
 ;
ENCEVENT(VISITIEN,DONTKILL) ;Create the ^TMP("PXKENC",$J, array of all the
 ;  information about one encounter.
 ;Parameters:
 ;  VISITIEN  Pointer to the Visit (#9000010)
 ;  DONOTKILL is 1 if the output array is not to be killed before used
 ;            and 0 or null if the array is to be killed (cleaned out)
 ;
 ;  The encounter is returned in the array
 ;    ^TMP("PXKENC",$J,pointer to visit)
 ;
 I $G(VISITIEN)'>0 Q  ;PX/183
 I '$D(^AUPNVSIT(VISITIEN)) Q
 K:'$G(DONTKILL) ^TMP("PXKENC",$J)
 N PXKCNT,PXKROOT
 S PXKROOT=$NA(@("^TMP(""PXKENC"",$J,"_VISITIEN_")"))
 ;
 N IEN,FILE,VFILE,FILESTR,PXKNODE
 F FILE="SIT","CSTP","PRV","POV","CPT","TRT","IMM","PED","SK","HF","XAM" D
 . S FILESTR=$S(FILE="SIT":"VST",1:FILE)
 . S VFILE=$P($T(GLOBAL^@("PXKF"_$S(FILE="SIT":"VST",FILE="CSTP":"VST",1:FILE))),";;",2)
 . I FILE="SIT" D
 .. S IEN=VISITIEN
 .. S PXKNODE=""
 .. F  S PXKNODE=$O(@VFILE@(IEN,PXKNODE)) Q:PXKNODE=""  D
 ... S @PXKROOT@(FILESTR,IEN,PXKNODE)=@VFILE@(IEN,PXKNODE)
 . E  D
 .. I FILE="PRV" D EVALD(VISITIEN,PXKROOT,VFILE,FILESTR)
 .. I FILE'="PRV" S IEN="" F  S IEN=$O(@VFILE@("AD",VISITIEN,IEN)) Q:'IEN  D
 ... I FILE="CSTP","SC"'[$P($G(@VFILE@(IEN,150)),"^",3) Q
 ... S PXKNODE=""
 ... F  S PXKNODE=$O(@VFILE@(IEN,PXKNODE)) Q:PXKNODE=""  D:PXKNODE'=801
 .... ;for cpt modifiers
 .... I FILE="CPT",PXKNODE=1 D  Q
 ..... S @PXKROOT@(FILESTR,IEN,PXKNODE,0)=$G(@VFILE@(IEN,PXKNODE,0))
 ..... N SUBIEN
 ..... S SUBIEN=0
 ..... F  S SUBIEN=$O(@VFILE@(IEN,PXKNODE,SUBIEN)) Q:SUBIEN=""  D
 ...... S @PXKROOT@(FILESTR,IEN,PXKNODE,SUBIEN,0)=$G(@VFILE@(IEN,PXKNODE,SUBIEN,0))
 .... ;
 .... S @PXKROOT@(FILESTR,IEN,PXKNODE)=$G(@VFILE@(IEN,PXKNODE))
 Q
EVALD(VISITIEN,PXKROOT,VFILE,FILESTR) ;evaluation for duplicate providers
 N CNT,PR,PRS,PS,PP,PRV,STR
 S IEN="",CNT=0
 F  S IEN=$O(@VFILE@("AD",VISITIEN,IEN)) Q:'IEN  D
 .S STR=@VFILE@(IEN,0),PR=+STR,PS=$P(STR,U,4)
 .I PS="P",'CNT S PRV=PR,CNT=1 D PXKNODE(VFILE,FILESTR,IEN,PXKROOT)
 .I PS="S" S PRS(PR,IEN)="" D PXKNODE(VFILE,FILESTR,IEN,PXKROOT)
 .Q
 S PR="" F  S PR=$O(PRS(PR)) Q:PR=""  S IEN="" D
 .F PP=1:1 S IEN=$O(PRS(PR,IEN)) Q:IEN=""  D
 ..I PR=$G(PRV) K @PXKROOT@(FILESTR,IEN) Q
 ..I PP>1 K @PXKROOT@(FILESTR,IEN)
 Q
PXKNODE(VFILE,FILESTR,IEN,PXKROOT) ;
 N STRR S PXKNODE=""
 F  S PXKNODE=$O(@VFILE@(IEN,PXKNODE)) Q:PXKNODE=""  D:PXKNODE'=801
 . I $E($P($P(PXKROOT,","),"(",2),2,7)="PXKENC" D
 ..; ENCEVENT called
 .. S @PXKROOT@(FILESTR,IEN,PXKNODE)=$G(@VFILE@(IEN,PXKNODE))
 . I $P(PXKROOT,"""",2)="PXKCO",'$D(@PXKROOT@(FILESTR,IEN)) D
 ..; COEVENT called
 .. F STRR="BEFORE","AFTER" D
 ... S @PXKROOT@(FILESTR,IEN,PXKNODE,STRR)=$G(@VFILE@(IEN,PXKNODE))
 Q
 ;
COEVENT(VISITIEN) ;Add to the ^TMP("PXKCO",$J, array all of the
 ;   information that is not already there.
 I '$D(^AUPNVSIT(VISITIEN)) Q
 N PXKCNT,PXKROOT
 S PXKROOT=$NA(@("^TMP(""PXKCO"",$J,"_VISITIEN_")"))
 ;
 N IEN,FILE,VFILE,PXKNODE
 F FILE="CSTP","PRV","POV","CPT","TRT","IMM","PED","SK","HF","XAM" D
 . S VFILE=$P($T(GLOBAL^@("PXKF"_$S(FILE="CSTP":"VST",1:FILE))),";;",2)
 . I FILE="PRV" D EVALD(VISITIEN,PXKROOT,VFILE,FILE)
 . I FILE'="PRV" S IEN="" F  S IEN=$O(@VFILE@("AD",VISITIEN,IEN)) Q:'IEN  D
 .. I FILE="CSTP","SC"'[$P($G(@VFILE@(IEN,150)),"^",3) Q
 .. S PXKNODE=""
 .. I '$D(@PXKROOT@(FILE,IEN)) D
 ... F  S PXKNODE=$O(@VFILE@(IEN,PXKNODE)) Q:PXKNODE=""  D:PXKNODE'=801
 .... I FILE="CPT",PXKNODE=1 D  Q
 ..... N SUBIEN,MOD
 ..... S SUBIEN=0
 ..... F  S SUBIEN=$O(@VFILE@(IEN,PXKNODE,SUBIEN)) Q:'SUBIEN  D
 ...... S MOD=@VFILE@(IEN,PXKNODE,SUBIEN,0)
 ...... S @PXKROOT@(FILE,IEN,PXKNODE,"BEFORE",MOD)=""
 ...... S @PXKROOT@(FILE,IEN,PXKNODE,"AFTER",MOD)=""
 .... S @PXKROOT@(FILE,IEN,PXKNODE,"BEFORE")=$G(@VFILE@(IEN,PXKNODE))
 .... S @PXKROOT@(FILE,IEN,PXKNODE,"AFTER")=$G(@VFILE@(IEN,PXKNODE))
 Q
 ;
