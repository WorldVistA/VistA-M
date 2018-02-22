%ZOSV2 ;ISF/RWF,FIS/KSB,VEN/SMH - More GT.M support routines ;2017-01-09  3:32 PM
 ;;8.0;KERNEL;**275,425,10001**;Jul 10, 1995;Build 18
 ; Submitted to OSEHRA in 2017 by Sam Habiel for OSEHRA
 ; Original Routine authored by Department of Veterans Affairs
 ; All EPs authored by Sam Habiel 2016 except RSUM and RSUM2
 ; except: TEST is authored by KS Bhaskar
 Q
 ;SAVE: DIE open array reference.
 ;      XCN is the starting value to $O from.
SAVE(RN) ;Save a routine
 N %,%F,%I,%N,SP,$ETRAP
 S $ETRAP="S $ECODE="""" Q"
 S %I=$I,SP=" ",%F=$$RTNDIR^%ZOSV()_$TR(RN,"%","_")_".m"
 O %F:(NEWVERSION:NOWRAP:STREAM) U %F
 F  S XCN=$O(@(DIE_XCN_")")) Q:XCN'>0  S %=@(DIE_XCN_",0)") Q:$E(%,1)="$"  I $E(%)'=";" W %,!
 C %F
 I $G(^%ZOSF("COMPILEWARNING")) ZLINK RN
 E  ZLINK RN:"-nowarning"
 U %I
 Q
DEL(RN) ; Delete Routine, VEN/SMH
 ; Input: Routine Name by Value
 ; Output: None
 N CNT S CNT=0
DELLOOP ; Loop entry point
 I CNT>5 S $EC=",U-DELETION-FAILED,"
 N %ZR ; Output from GT.M %RSEL
 N %S,%O ; Source directory, object directory 
 ; 
 ; NB: For future works, %RSEL support * syntax to get a bunch of routines
 D SILENT^%RSEL(RN,"SRC") S %S=$G(%ZR(RN)) ; Source Directory
 D SILENT^%RSEL(RN,"OBJ") S %O=$G(%ZR(RN)) ; Object Directory
 ;
 I '$L(%S)&('$L(%O)) QUIT
 ;
 S RN=$TR(RN,"%","_") ; change % to _ in routine name
 ;
 N $ET,$ES S $ET="Q:$ES  S $EC="""" Q" ; In case somebody else deletes this; we don't crash
 ;
 I $L(%S) D  ; If source routine present?
 . O %S_RN_".m":(newversion):0  ; Write out a new routine that's completely empty.
 . E  Q
 . ZLINK RN  ; Tell this process that that's the new routine. Other proceses that have the object linked be notified using the RELINK_CTL file.
 . C %S_RN_".m":(delete)  ; now delete
 . I CNT>3 N % S %=$$RETURN^%ZOSV("rm -r "_%S_RN_".m")
 ;
 I $L(%O) D  ; If object code present?
 . O %O_RN_".o":(readonly):0
 . E  Q
 . C %O_RN_".o":(delete)
 . I CNT>3 N % S %=$$RETURN^%ZOSV("rm -r "_%O_RN_".o")
 S CNT=CNT+1
 ;
 G DELLOOP
 ;
 ;
 ;LOAD: DIF open array to receive the routine lines.
LOAD(RN) ;Load a routine using $TEXT
 N %
 S XCNP=0 F  S %=$T(+$I(XCNP)^@RN) Q:$L(%)=0  S @(DIF_XCNP_",0)")=%
 Q
 ;
LOAD2(RN) ;Load a routine from the Filesystem
 N %,%1,%F,%N,$ETRAP
 S %I=$I,%F=$$RTNDIR^%ZOSV()_$TR(RN,"%","_")_".m"
 O %F:(READONLY):1 Q:'$T  U %F
 N CNT S CNT=0
 F  R %1 Q:$ZEOF  S CNT=$I(CNT),@(DIF_CNT_",0)")=%1
 U:$L(%I) %I C %F
 Q
 ;
RSUM(RN) ;Calculate a RSUM value
 N %,DIF,XCNP,%N,Y,$ETRAP K ^TMP("RSUM",$J)
 S $ETRAP="S $ECODE="""" Q"
 S Y=0,DIF="^TMP(""RSUM"",$J,",XCNP=0 D LOAD2(RN)
 F %=1,3:1 S %1=$G(^TMP("RSUM",$J,%,0)),%3=$F(%1," ") Q:'%3  S %3=$S($E(%1,%3)'=";":$L(%1),$E(%1,%3+1)=";":$L(%1),1:%3-2) F %2=1:1:%3 S Y=$A(%1,%2)*%2+Y
 K ^TMP("RSUM",$J)
 Q Y
 ;
RSUM2(RN) ;Calculate a RSUM2 value
 N %,DIF,XCNP,%N,Y,$ETRAP K ^TMP("RSUM",$J)
 S $ETRAP="S $ECODE="""" Q"
 S Y=0,DIF="^TMP(""RSUM"",$J,",XCNP=0 D LOAD2(RN)
 F %=1,3:1 S %1=$G(^TMP("RSUM",$J,%,0)),%3=$F(%1," ") Q:'%3  S %3=$S($E(%1,%3)'=";":$L(%1),$E(%1,%3+1)=";":$L(%1),1:%3-2) F %2=1:1:%3 S Y=$A(%1,%2)*(%2+%)+Y
 K ^TMP("RSUM",$J)
 Q Y
 ;
TEST(RN) ;Special GT.M Test to see if routine is here.
 N %ZR
 D SILENT^%RSEL(RN) Q $S(%ZR:%ZR(RN)_$TR($E(RN,1),"%","_")_$E(RN,2,$L(RN))_".m",1:"")
