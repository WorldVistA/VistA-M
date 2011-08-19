RAUTL19C ;HISC/GJC-Utility Routine ;10/29/97  12:42
 ;;5.0;Radiology/Nuclear Medicine;**10**;Mar 16, 1998
 ;
EN1 ; Check data consistency
 N I,J,RAERR,RAFLG,RAIEN,RANO,RANODE,RAO,RAPIECE,RAYES,RAWATERR,RACHKERR
 S RAERR=0,RANO="Nn",RAYES="Yy",RACHKERR=0,RAWATERR=0 D HEAD^RAUTL11
 S RAO="" F  S RAO=$O(^RA(72,"AA",RAIMG,RAO)) Q:RAO']""  D  Q:RAOUT
 . S RAIEN=0
 . F  S RAIEN=+$O(^RA(72,"AA",RAIMG,RAO,RAIEN)) Q:'RAIEN  D  Q:RAOUT
 .. S RANODE(0)=$G(^RA(72,RAIEN,0)),RANODE(.1)=$G(^(.1)),RANODE(.2)=$G(^(.2)),RANODE(.5)=$G(^(.5)),RANODE(.6)=$G(^(.6))
 .. ; let rapiece(.25)=$p(ranode(.2),"^",5), etc
 .. K RAPIECE
 .. F I=.11,.111,.116,.12,.14,.15,.16,.21,.22,.24,.25,.26,.27,.28,.51,.53,.54,.55,.57,.58,.59,.61,.63,.64,.65,.67,.68,.69,.611,.113,.114,.213,.214 S RAPIECE(I)=$P(RANODE($E(I,1,2)),"^",$E(I,3,$L(I)))
 .. I $P(RANODE(0),U,3)=1 D CKWAIT Q:RAOUT
 .. ; if REQUIRED fld=Y, its corresp ASK fld must be Y at same/lower status
 .. ; field .11<->field .21, .12<->.22, .14<->.24, .15<->.25, .16<->.26
 .. ; .51<->.61, .53<->.63, .54<->.64
 .. ; .55<->.65, .58<->.68, .59<->.69
 .. F I=.11,.12,.14,.15,.16,.51,.53,.54,.55,.58,.59,.113,.114 S J=I+.1 D CKPAIR Q:RAOUT
 .. Q:RAOUT
 .. ; ASK PHARM ADM DT/TIME/PERSON must be Y before ASK PHARM & DOSAGE=Y
 .. S I=.28,J=.27 D CKPAIR
 .. Q:RAOUT
 .. ; if IMPRESSION is required, then REPORT should also be required
 .. I $$UP^XLFSTR(RAPIECE(.116))="Y",$$UP^XLFSTR(RAPIECE(.111))'="Y" D
 ... W !!?5,"<WARNING> -- Within "_RAIMG_", exam status '"_$P(RANODE(0),"^")_"'"
 ... W !?5,"Impression is required, but a report is not, so an exam"
 ... W !?5,"will be able to reach this status without a report.",!?5
 ... W "But if a report is entered, an impression will be required.",!
 ... Q
 .. ; other Radiopharm flds must be Y before ASK RADIOPHARM & DOSAGES=Y
 .. S J=.61 F I=.53,.54,.57,.58,.59,.63,.64,.65,.67,.68,.69 D CKPAIR Q:RAOUT
 .. Q:RAOUT
 .. ; if print dosage ticket is Y, then all required flds on ticket s/b Y
 .. S I=.611 F J=.51,.53,.54,.58 D CKPAIR Q:RAOUT
 .. I RAPIECE(.611)="Y" D CKPRNTR^RAUTL19 Q:RAOUT
 .. I $P(^RA(79.2,$P(RANODE(0),U,7),0),U,5)'["Y" D NOTNEED^RAUTL19
 .. Q
 . Q
 Q:RAOUT
 D CKCOMP^RAUTL19B(RAIMG) Q:RAOUT
 D CKREQD^RAUTL19B(RAIMG) Q:RAOUT
 D CKOTHER^RAUTL19A(RAIMG) Q:RAOUT
 ; 'XAMORD^RAMAIN1' hit twice: once for the screen, once for hardcopy
 D XAMORD^RAMAIN1 Q:RAOUT
 I 'RAERR,'RAORDXST D  Q:RAOUT
 . I $Y>(IOSL-6) S RAOUT=$$EOS^RAUTL5() Q:RAOUT  D HEAD^RAUTL11
 . W !!?(IOM-$L(RANOERR)\2),RANOERR
 . Q
 S:$D(ZTQUEUED) ZTREQ="@" D ^%ZISC
 Q
CKPAIR ; when field I is Y, then field J must also be Y at current/lower status
 S RAFLG=0
 ; don't check length of rapiece(j) because we need to treat null as 'no'
 I $L(RAPIECE(I)),(RAYES[RAPIECE(I)),(RANO[RAPIECE(J)) D
 . ; check fields, get field text from Field Title in Data Dictionary
 . S RAFLG=$$ASKPRI^RAUTL19(RAIMG,RAO,J) Q:RAFLG  S RAERR=1 D WRPAIR^RAUTL19
 . I $Y>(IOSL-6) S RAOUT=$$EOS^RAUTL5() Q:RAOUT  D HEAD^RAUTL11
 . W !!?5,"Within "_RAIMG_", exam status '"_$P(RANODE(0),"^")_"'"
 . I $Y>(IOSL-6) S RAOUT=$$EOS^RAUTL5() Q:RAOUT  D HEAD^RAUTL11
 . W !?5,"order ("_RAO_") '"_$P($G(^DD(72,I,.1)),U)_"' is set to 'Yes'"
 . I $Y>(IOSL-6) S RAOUT=$$EOS^RAUTL5() Q:RAOUT  D HEAD^RAUTL11
 . W !?5,"but '"_$P($G(^DD(72,J,.1)),U)_"' is set to 'No'"
 . I $Y>(IOSL-6) S RAOUT=$$EOS^RAUTL5() Q:RAOUT  D HEAD^RAUTL11
 . W !?5,"in this status and all lower active statuses."
 . Q
 Q
CKWAIT ; CKWAIT is only done for WAITING FOR EXAM and assumes order seq = 1
 F I=.111,.112,.116,.211,.23 S RAPIECE(I)=$P(RANODE($E(I,1,2)),"^",$E(I,3,$L(I)))
 I $Y>(IOSL-6) S RAOUT=$$EOS^RAUTL5() Q:RAOUT  D HEAD^RAUTL11
 S I=.2 F  S I=$O(RAPIECE(I)) Q:I>.29  Q:I=""  S J=$$UP^XLFSTR(RAPIECE(I)) I J="Y" D WRWAIT^RAUTL19 W !?5,"'",$P($G(^DD(72,I,.1)),U),"'" S RAERR=1 I $Y>(IOSL-6) S RAOUT=$$EOS^RAUTL5() Q:RAOUT  D HEAD^RAUTL11
 Q:RAOUT
 S I=.6 F  S I=$O(RAPIECE(I)) Q:I>.69  Q:I=""  S J=$$UP^XLFSTR(RAPIECE(I)) I J="Y" D WRWAIT^RAUTL19 W !?5,"'",$P($G(^DD(72,I,.1)),U),"'" S RAERR=1 I $Y>(IOSL-6) S RAOUT=$$EOS^RAUTL5() Q:RAOUT  D HEAD^RAUTL11
 Q:RAOUT
 S I=.1 F  S I=$O(RAPIECE(I)) Q:I>.19  Q:I=""  S J=$$UP^XLFSTR(RAPIECE(I)) I J="Y" D WRWAIT^RAUTL19 W !?5,"'",$P($G(^DD(72,I,.1)),U),"'" S RAERR=1 I $Y>(IOSL-6) S RAOUT=$$EOS^RAUTL5() Q:RAOUT  D HEAD^RAUTL11
 Q:RAOUT
 S I=.5 F  S I=$O(RAPIECE(I)) Q:I>.59  Q:I=""  S J=$$UP^XLFSTR(RAPIECE(I)) I J="Y" D WRWAIT^RAUTL19 W !?5,"'",$P($G(^DD(72,I,.1)),U),"'" S RAERR=1 I $Y>(IOSL-6) S RAOUT=$$EOS^RAUTL5() Q:RAOUT  D HEAD^RAUTL11
 W:RAERR !!?5,"The above fields need not be answered for the ",$P(RANODE(0),U)," status.",!?5,"The system automatically sets newly registered cases to this status",!?5,"even if they don't meet all these requirements."
 I $$UP^XLFSTR(RAPIECE(.611))="Y" D WRWAIT^RAUTL19 W !!?5,"'",$P($G(^DD(72,.611,.1)),U),"' should NOT be  Y",!,?5,"for status of ",$P(RANODE(0),U) S RAERR=1 I $Y>(IOSL-6) S RAOUT=$$EOS^RAUTL5() Q:RAOUT  D HEAD^RAUTL11
 Q
