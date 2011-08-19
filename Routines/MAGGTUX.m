MAGGTUX ;WIOFO/GEK/SG - Imaging utility to validate INDEX values. ; 2/5/09 1:58pm
 ;;3.0;IMAGING;**59,93**;Dec 02, 2009;Build 163
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; | Use of unreleased versions of this software requires the user |
 ;; | to execute a written test agreement with the VistA Imaging    |
 ;; | Development Office of the Department of Veterans Affairs,     |
 ;; | telephone (301) 734-0100.                                     |
 ;; |                                                               |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a medical device.  As such, it may not be changed in any way. |
 ;; | Modifications to this software may result in an adulterated   |
 ;; | medical device under 21CFR820, the use of which is considered |
 ;; | to be a violation of US Federal Statutes.                     |
 ;; +---------------------------------------------------------------+
 ;;
 Q
CHECK ; Check the entries, NO DATABASE changes.
 D 1(0,"MAGGTUXC")
 Q
FIX ; Fix/Check INDEX values in Image File entries. 
 D 1(1,"MAGGTUX")
 Q
1(COMMIT,MAGN) ; Start here.
 I '$D(DUZ) W !,"DUZ is undefined.   Quitting." Q
 N DESC,ANS,ZTDTH,ZTIO,ZTRTN,ZTDESC,ZTSAVE,ZTSK ; -- TaskMan variables
 I 'COMMIT W !,"   **** Just Checking entries, no DataBase changes will occur. ****",!
 W !,"Validate Image Index Terms:"
 W !,"  The Image File is searched for invalid or missing index values."
 W !,"  The Image Index Generate and Commit functions are used"
 W !,"  to fix the incorrect Index values."
 W !
 W !,"For a summary of the index values that will be changed."
 W !,"  use the menu option:   CHK  -  Check Image File for missing Index values"
 W !," "
 W !,"To Fix the invalid index values in the Image File (#2005)."
 W !,"  use the menu option:   FIX  -  Fix missing Index values in Image File"
 W !
 I 'COMMIT W !,"   **** Just Checking entries, No DataBase changes will occur. ****",!
 E  W !,"   **** Fixing invalid entries,  DataBase changes Will occur. ****",!
 D TASKMAN^MAGXCVP(.ANS)
 I "^"=ANS W !,"Canceled. " Q
 S ZTSK=0 I ANS="" D START(COMMIT,MAGN,0) Q
 S ZTRTN="TASK^MAGGTUX"
 S DESC=$S(COMMIT:"FIX INVALID INDEX VALUES",1:"CHECK FOR INVALID INDEX VALUES")
 S ZTDESC=DESC
 S ZTDTH=ANS,ZTIO=""
 S ZTSAVE("COMMIT")=COMMIT,ZTSAVE("MAGN")=MAGN,ZTSAVE("QUEUED")=1
 D ^%ZTLOAD
 W !,DESC_" Has been Queued as task# : "_ZTSK
 Q
TASK ;
 D START(COMMIT,MAGN,QUEUED)
 Q
START(COMMIT,MAGN,QUEUED) ;Start here.
 N $ETRAP,$ESTACK S $ETRAP="D ERR^"_$T(+0)
 L +MAGTMP("VALIDATE INDEX TERMS"):0 E  D  Q
 . I 'QUEUED W !,"Image Index Validate process is currently running.  Try later." Q
 . S XMSUB="Image Index Validate wasn't started"
 . S ^TMP($J,"MAGQ",1)="You attempted to Task the Index Validate process, but the"
 . S ^TMP($J,"MAGQ",2)="Image Validate process is currently running.  Please try later."
 . D MAILSHR^MAGQBUT1
 . Q
 N DOT,N0,N40,OL40,N2,MDFN,IXT,IXP,IXS,IXO,ST,ET,NORG,ISGRP,X,J,RADCT,RADCR,CDT,IEN,INDXD
 N PKG,SD,TIM,TITLE,TIUDA,TTLDA,MRY,LNT,LNI,X1,STTIME,ENDTIME,ELSP,%H,%
 N GRINT,NI,NOPAT,NOZ,INVG,CRCT,INVO,GRINI,NT,CT,CTALL,STOP,LN,GO1,GO0,ORG,OFX,NOMERG,OKMERG,FIX
 S (GRINT,NI,NOPAT,NOZ,INVG,CRCT,INVO,GRINI,NT,CT,CTALL,STOP,LN,GO1,GO0,ORG,OFX,NOMERG,OKMERG,FIX)=0
 ; Write 200 lines to screen.
 S DOT=$P(($P(^MAG(2005,0),"^",4)/200),".",1)
 S IEN="A"
 ; if it was started and stopped, continue.
 ; ^XTMP("MAGGTUX,0)=PurgeDate^CreateDate^LastIENChecked^HighestIENChecked^NumberChecked^Description
 ; 
 I $D(^XTMP(MAGN,0)) D INIT^MAGGTUX2
 S STTIME=$$NOW^XLFDT
 I 'QUEUED D  I STOP G END
 . I 'COMMIT W !!,"Just Checking Index Terms, NO CHANGES to database. (Q to quit)"
 . E  W !!,"Invalid entries will be fixed.  Database will be modified (Q to quit)"
 . W !!,"   Press 'Q' at any time to QUIT.  It can be resumed later.",!
 . W !,"Ready to Start   Y/N    N// " R X:30
 . I "Nn"[X W !!,"Canceled." S STOP=1 Q
 . W !,"Starting at "_$$FMTE^XLFDT(STTIME)
 . Q
 ;  Start.....
 ;  Set XTMP Dates
 I IEN="A" K ^XTMP(MAGN) S $P(^XTMP(MAGN,0),"^",4)=$O(^MAG(2005,IEN),-1) ; Keep the Highest IEN checked.
 S X1=DT,X2=14 D C^%DTC S $P(^XTMP(MAGN,0),"^",1,2)=X_"^"_$$NOW^XLFDT
 S $P(^XTMP(MAGN,0),"^",6)="Fix Invalid Index Nodes"
 ; Set variables to check the CR - CT problem.
 S RADCR=+$O(^MAG(2005.85,"B","COMPUTED RADIOGRAPHY",""))
 S RADCT=+$O(^MAG(2005.85,"B","COMPUTED TOMOGRAPHY",""))
 ;
 D PRHDR
 S ST=$P($H,",",2) ; Start Time
 S TIM=$P(^MAG(2005,0),"^",4) ; Total Images
 F  S IEN=$O(^MAG(2005,IEN),-1) Q:IEN=0  D  I STOP Q  ;G END
 . R X:0 I X="Q" D  Q
 . . S STOP=1
 . . I 'QUEUED W ! D MES^XPDUTL(" Function interrupted. ")
 . . Q
 . S CTALL=CTALL+1
 . Q:$$ISDEL^MAGGI11(IEN)
 . S ISGRP=0
 . S N0=$G(^MAG(2005,IEN,0))
 . S N2=$G(^MAG(2005,IEN,2))
 . S N40=$G(^MAG(2005,IEN,40))
 . S MDFN=+$P(N0,"^",7)
 . S IXT=$P(N40,"^",3),IXS=$P(N40,"^",5),IXP=$P(N40,"^",4),IXO=$P(N40,"^",6)
 . S CT=CT+1
 . I (CT=1)!(CT#DOT=0)!($O(^MAG(2005,IEN),-1)=0) D PRLINE
 . ; Count NO Patient, No Zero Node
 . I 'MDFN S NOPAT=NOPAT+1 Q
 . I N0="" S NOZ=NOZ+1 Q
 . ; Count Groups of 1, No change.
 . I $P(N0,"^",6)=11 S ISGRP=1 I $P($G(^MAG(2005,IEN,1,0)),"^",4)=1 S GO1=GO1+1
 . I ISGRP I $O(^MAG(2005,IEN,1,0))="" S GO0=GO0+1 Q
 . ;
 . ;  Chk ORIGIN (fld #45) had 'VA' not 'V'.
 . I '("VNFD"[$P(N40,"^",6)) D CHK45^MAGGTUX2(.N40,IEN)
 . ;
 . ; Was a CR, CT mismapping, this will fix it.
 . I RADCR=IXP D CHKCR^MAGGTUX2(.N40,IEN)
 . ; 
 . ; Validate the Proc/Event <-> Spec/SubSpec dependency
 . ; Check TYPE is Clinical, All are Active.
 . I IXT D VALIND^MAGGTUX2 Q  ;If image has TYPE, Check then Quit.
 . ;
 . ; Counting problems
 . ; If no index values.
 . I N40="" D
 . . I $P(N0,"^",10) S GRINI=GRINI+1 ; GRoupImageNoIndex
 . . E  S NI=NI+1 ; NoIndex
 . . S LNI=IEN_"-"_$P(N2,"^",1)
 . . Q
 . ;
 . ; If this case follows the Majority of invalid 40 Nodes
 . ; i.e. PKG^^^^^V  PKG^^^^^VA then Kill and ReGenerate later
 . I (N40'="") D
 . . I $P(N0,"^",10) S GRINT=GRINT+1 ; Group Image with No Type
 . . E  S NT=NT+1  ; NoType :  group or single
 . . S ^XTMP(MAGN,"AAN40",N40)=$G(^XTMP(MAGN,"AAN40",N40))+1
 . . S ^XTMP(MAGN,"AAN40",N40,"IEN")=IEN
 . . S LNT=IEN_"-"_$P(N2,"^",1)
 . . ; if 40 node is just default PKG and ORIGIN,  we kill and regenerate.
 . . ; Don't kill N40 if Origin is F,D or N
 . . I N40?.A1"^^^^^".E I "V"[$P(N40,"^",6) S N40=""
 . . Q
 . ;
 . ; Use Patch 31 Utils to Generate Index values
 . I N40="" D  Q
 . . I COMMIT D
 . . . ; GENERATE AND COMMIT INDEX VALUES.
 . . . D GENIEN^MAGXCVI(IEN,.INDXD)
 . . . I $P(INDXD,"^",6)="" S $P(INDXD,"^",6)="V"
 . . . S ^MAG(2005,IEN,40)=INDXD
 . . . S ^MAGIXCVT(2006.96,IEN)=2 ; status = 2 ( generate by Patch 59) 
 . . . S FIX=FIX+1
 . . . D ENTRY^MAGLOG("INDEX-ALL",DUZ,IEN,"TUX59",MDFN,1)
 . . . Q
 . . Q
 . ;  40 node is missing TYPE
 . ;   - has Spec and/or Proc 
 . ;   - or Origin is not V.
 . ; Compare old to new, only set missing pieces, (don't overwrite)
 . ; If the merged 40 node doesn't pass VAL59G,
 . ; Then revert to old Spec and Proc but keep Generated Type.
 . ; 
 . D GENIEN^MAGXCVI(IEN,.INDXD)
 . I $P(INDXD,"^",6)="" S $P(INDXD,"^",6)="V"
 . S OL40=N40
 . ; We're not changing existing values of Spec,Proc or Origin 
 . F J=1:1:6 I '$L($P(N40,"^",J)) S $P(N40,"^",J)=$P(INDXD,"^",J)
 . ;  Validate the merged Spec and Proc dependency, may be invalid.
 . D VALMERG^MAGGTUX2(OL40,.N40) ; 
 . I '$D(^XTMP(MAGN,"AAN40",OL40,"CVT",INDXD)) S ^XTMP(MAGN,"AAN40",OL40,"CVT",INDXD)=N40
 . I COMMIT D
 . . S ^MAG(2005,IEN,40)=N40
 . . S FIX=FIX+1
 . . S ^MAGIXCVT(2006.96,IEN)=2 ; 2 is set of codes - converted by Patch 59 
 . . D ENTRY^MAGLOG("INDEX-42",DUZ,IEN,"TUX59",MDFN,1)
 . . Q
 . Q
 S ENDTIME=$$NOW^XLFDT
 S %H=$P($H,",")_","_($P($H,",",2)-ST) D YMD^%DTC
 S ELSP=$P($$FMTE^XLFDT(X_%),"@",2)
 S ^XTMP(MAGN,0,"END")=$$FMTE^XLFDT(ENDTIME)_"^"_ELSP
 S $P(^XTMP(MAGN,0),"^",3)=IEN ; last IEN Checked.
 S $P(^XTMP(MAGN,0),"^",5)=$P(^XTMP(MAGN,0),"^",5)+CT
 ;
 S ^XTMP(MAGN,"AATCHK")=$G(^XTMP(MAGN,"AATCHK"))+CT
 S ^XTMP(MAGN,"AANT")=NT
 S ^XTMP(MAGN,"AANI")=NI
 S ^XTMP(MAGN,"AAGRINT")=GRINT
 S ^XTMP(MAGN,"AAGRINI")=GRINI
 S ^XTMP(MAGN,"AAGO1")=GO1
 S ^XTMP(MAGN,"AAGO0")=GO0
 S ^XTMP(MAGN,"AAOFX")=OFX
 S ^XTMP(MAGN,"AAINVG")=INVG
 S ^XTMP(MAGN,"AAINVO")=INVO
 S ^XTMP(MAGN,"AANOMERG")=NOMERG
 S ^XTMP(MAGN,"AAOKMERG")=OKMERG
 S ^XTMP(MAGN,"AACRCT")=CRCT
 S ^XTMP(MAGN,"AAN40","no index")=GRINI+NI
 S ^XTMP(MAGN,"AANOPAT")=NOPAT
 S ^XTMP(MAGN,"AANOZ")=NOZ
 S ^XTMP(MAGN,0,"NT")=$G(LNT)
 S ^XTMP(MAGN,0,"NI")=$G(LNI)
 I FIX S ^XTMP(MAGN,"AAFIX")=FIX
 I 'QUEUED D DISPLAY^MAGGTUX1
 D MAIL^MAGGTUX1
 ; KILL LOCKS.
END ;
 L -MAGTMP("VALIDATE INDEX TERMS")
 Q
ERR ; 
 L -MAGTMP("VALIDATE INDEX TERMS")
 D @^%ZOSF("ERRTN")
 Q
EST() ;Estimate time remaining.
 Q:'$G(ST) ""    ; we didn't start yet.
 N ET,EST,PS             ; Elapsed Time, Estimate Time, Number Per Second.
 S ET=$P($H,",",2)-ST I ET<2 Q "" ; Elapsed Time (seconds)
 I (CTALL/ET)<1 Q ""
 S PS=$P(CTALL/ET,".") ; number Per second
 S EST=$P(((TIM-CTALL)/PS),".") ;remaining/ (num/sec) = seconds remaining
 S %H=$P($H,",")_","_EST D YMD^%DTC
 Q $P($$FMTE^XLFDT(X_%),"@",2)
 ;
PRLINE ; Print a line of current counts
 Q:QUEUED
 S CDT=$$FMTE^XLFDT($P($G(^MAG(2005,IEN,2)),"^",1),"2DF") ; Capture DaTe
 W !,IEN,?10,CDT,?22,CT,?36,NT,?48,NI,?64,$$EST_" ..."
 S LN=LN+1 I LN#10=0 D PRHDR
 Q
PRHDR ; Print a header and estimate of time.
 ; For Test DataBase, put code to Hang here for 1 sec. (magslow)
 Q:QUEUED
 I 'COMMIT W !,"Just Checking Index Terms, NO CHANGES to database. (Q to quit)"
 W !,"IEN       Saved       #checked   No Type     No Index values    est: "
 Q
REVIEW G REVIEW^MAGGTUX1
 Q
