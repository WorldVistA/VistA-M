RABAR1 ;HISC/GJC-Procedure & CPT Code barcode output (part 2 of 2)
 ;;5.0;Radiology/Nuclear Medicine;;Mar 16, 1998
 ;
PRINT ; Print the barcode(s) & CPT Code(s)
 N RA71,RA792,D0,RASPACE S RASPACE="  "
 S D0=RA2 ; D0 selected for FM compatibility
 S RA71(0)=$G(^RAMIS(71,D0,0)),RA71(6)=$P(RA71(0),"^",6)
 S RA71(9)=+$P(RA71(0),"^",9),RA71(12)=+$P(RA71(0),"^",12)
 S RA71(6)=$$XTERNAL^RAUTL5(RA71(6),$P($G(^DD(71,6,0)),"^",2))
 I RA71(9)>0 D
 . S RA71(9)=$$XTERNAL^RAUTL5(RA71(9),$P($G(^DD(71,9,0)),"^",2))
 . Q
 E  S RA71(9)="No CPT"
 S RA792(3)=$P($G(^RA(79.2,+RA71(12),0)),"^",3)
 I $E(RAPRNT,1)="B" D
 . I $Y>(IOSL-RAEOS) D  Q:RAXIT
 .. S RAXIT=$$EOS^RAUTL5() Q:RAXIT
 .. D HDR^RABAR
 .. Q
 . W !,$P(RA71(0),"^"),RASPACE,RA792(3),RASPACE,RA71(6),RASPACE,RA71(9)
 . W ! X ^DD(71,15,9.1) D:$D(RAVHI) DOLLARY^RABAR
 . I $Y>(IOSL-RAEOS) D  Q:RAXIT
 .. S RAXIT=$$EOS^RAUTL5() Q:RAXIT
 .. D HDR^RABAR
 .. Q
 . W !?10 X ^DD(71,16,9.1) W !
 . D:$D(RAVHI) DOLLARY^RABAR
 . Q
 E  D
 . I $Y>(IOSL-RAEOS) D  Q:RAXIT
 .. S RAXIT=$$EOS^RAUTL5() Q:RAXIT
 .. D HDR^RABAR
 .. Q
 . I $E(RAPRNT,1)="C" D
 .. W !,$P(RA71(0),"^"),RASPACE,RA792(3),RASPACE,RA71(6),RASPACE,RA71(9)
 .. W !?10 X ^DD(71,16,9.1) W !
 .. Q
 . I $E(RAPRNT,1)="P" D
 .. W !,$P(RA71(0),"^"),RASPACE,RA792(3),RASPACE,RA71(6),RASPACE,RA71(9)
 .. W ! X ^DD(71,15,9.1) W !
 .. Q
 . D:$D(RAVHI) DOLLARY^RABAR
 . Q
 Q
PRINT1 ; Print the test barcode
 N X S X="TEST BARCODE PRINT"
 D LINE^RABAR
 D PSET^%ZISP
 I IOBARON]"",(IOBAROFF]"") D
 . W !,X
 . W @IOBARON,X,@IOBAROFF
 . Q
 D PKILL^%ZISP
 D LINE^RABAR
 Q
PROC() ; Select the Procedure(s)
 N RADIC,RAINPUT,RAQUIT,RAUTIL
 S RADIC="^RAMIS(71,",RADIC(0)="QEAMZ",RADIC("A")="Select Procedure: "
 S RADIC("S1")="N RAI S RAI=+$P($G(^RAMIS(71,+Y,0)),""^"",12)"
 S RADIC("S2")=",RAI(""DT"")=$$INA^RABAR(+Y) "
 S RADIC("S3")="I RAI,(RAI(""DT"")),($D(^TMP($J,""RA I-TYPE"",$P($G(^RA(79.2,RAI,0)),""^""))))"
 S RADIC("S")=RADIC("S1")_RADIC("S2")_RADIC("S3")
 S RAUTIL="RA PROC",RAINPUT=1
 D:$E($G(RASORT),1)'="C" EN1^RASELCT(.RADIC,RAUTIL,"",RAINPUT)
 D:$E($G(RASORT),1)="C" EN1^RASELCT(.RADIC,RAUTIL,"",RAINPUT,9)
 Q RAQUIT
TEST() ; Does the user wish to print a test barcode.
 ; Returns '1' if test print is requested, '0' if no test print
 W !,"To print barcoded procedure list, you will need to know the height (in",!,"vertical lines) of the barcode output on the printer to be used."
 W ! D KILLDIR^RABAR S DIR(0)="YA",DIR("A",1)="Do you wish to print a sample barcode for the purpose of determining the"
 S DIR("?")="Enter 'Y'es to print a sample, 'N'o to continue without a sample."
 S DIR("A")="height (in vertical lines) of the barcode? "
 S DIR("B")="No" D ^DIR S Y=$S($D(DIRUT):-1,1:+Y)
 D KILLDIR^RABAR
 Q Y
ZOSF(DX,DY) ; Called to execute ^%ZOSF("XY")
 X ^%ZOSF("XY")
 Q
ZTSAVE ; Save off variable for ZTLOAD
 N I
 F I="RADT","RAPRNT","RAXIT","^TMP($J,""RA PROC""," D
 . S ZTSAVE(I)=""
 . Q
 S:$D(RASORT) ZTSAVE("RASORT")=""
 S:$D(RATEST) ZTSAVE("RATEST")=""
 S:$D(RAVHI) ZTSAVE("RAVHI")=""
 Q
