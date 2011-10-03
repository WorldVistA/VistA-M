VBECDCR ;hoifo/gjc-data conversion & pre-implementation reporting mechanism;Nov 21, 2002
 ;;5.2;LAB SERVICE;**335**;Sep 27, 1994;Build 5
 ;
 ;Medical Device #:
 ;Note: The food and Drug Administration classifies this software as a
 ;medical device.  As such, it may not be changed in any way.
 ;Modifications to this software may result in an adulterated medical
 ;device under 21CFR820, the use of which is considered to be a
 ;violation of US Federal Statutes.  Acquiring and implementing this
 ;software through the Freedom of Information Act requires the
 ;implementer to assume total responsibility for the software, and
 ;become a registered manufacturer of a medical device, subject to FDA
 ;regulations.
 ;
 ;Call to $$NEWERR^%ZTER is supported by IA: 1621
 ;Call to $$S^%ZTLOAD is supported by IA: 10063
 ;Call to FILE^DID is supported by IA: 2052
 ;Call to $$EXTERNAL^DILFD is supported by IA: 2055
 ;Call to ^DIR is supported by IA: 10026
 ;Call to ^DIWP is supported by IA: 10011
 ;Call to $$DT^XLFDT is supported by IA: 10103
 ;Call to $$FMTE^XLFDT is supported by IA: 10103
 ;Call to $$CJ^XLFSTR is supported by IA: 10104
 ;Call to EN^XUTMDEVQ is supported by IA: 1519
 ;global read on ^DPT(DFN,0) for patient name supported by IA: 10035
 ;Execution of ^%ZOSF("TEST") is supported by IA: 10096
 ;
EN ; entry point for anomaly report
 ;
 I $S($D(DUZ)[0:1,$D(DUZ(0))[0:1,'DUZ:1,DUZ=.5:1,1:0) W !!?3,$C(7),"DUZ & DUZ(0) must be defined to an active user (not POSTMASTER) in order to",!?3,"proceed." Q
 ;
 ; initialize the error trap
 I $$NEWERR^%ZTER N $ETRAP,$ESTACK S $ETRAP="D ERR^VBECDCU1"
 E  S X="D ERR^VBECDCU1",@^%ZOSF("TRAP")
 ;
 ; check to see if anomaly data exists for the most recent record in the
 ; VBECS DATA INTEGRITY/CONVERSION STATISTICS (#6001) file.
 S VBECIEN=$O(^VBEC(6001,$C(32)),-1)
 I '$O(^VBEC(6001,VBECIEN,"ERR",0)) D  Q
 .K VBECIEN
 .W !!?3,"There are no occurrences of VistA Blood Bank data anomalies on file to be",!?3,"displayed.",$C(7)
 .Q
 ;
 S VBECR="START^VBECDCR",VBECS("DUZ")="",VBECS("VBECIEN")=""
 S VBECZ="MQ",VBECD="VBECS data anomaly reporting process"
 D EN^XUTMDEVQ(VBECR,VBECD,.VBECS,,1)
 I +$G(ZTSK)>0 W !!,"Task Number: "_ZTSK,!
 K VBECIEN,VBECD,VBECR,VBECS,VBECZ,ZTSK
 Q
 ;
START ; display the data
 ;
 ; VBEC(1)=process start timestamp (internal)
 ; VBEC(2)=process (internal)
 ; VBEC(3)=process finish timestamp (internal)
 ; VBEC(4)=user responsible for process (internal)
 ; VBECX(1)=process start timestamp (external)
 ; VBECX(2)=process (external)
 ; VBECX(3)=process finish timestamp (external)
 ; VBECX(4)=user responsible for process (external)
 ; VBEC1A(1)=file navigated (pointer)
 ; VBEC1A(2)=ien of record in file navigated
 ; VBEC1A(3)=file navigate to (pointer)
 ; VBEC1A(4)=ien of record in file navigated to
 ; VBEC1A(5)=lrdfn1 dup blood component/blood component id (same patient)
 ; VBEC1A(6)=lrdfn2 dup blood component/blood component id (diff patients)
 ; VBEC1A(7)=blood component (pointer)
 ; VBEC1A(8)=blood component id
 ; VBEC1A(9)=user readable data integrity issue
 ;
 S:$D(ZTQUEUED) ZTREQ="@" S PAGE=1,(VBEC1,VBECXIT,VBECSTOP)=0,U="^"
 S $P(LINE,"*",81)="",TODAY=$$FMTE^XLFDT($$DT^XLFDT(),1)
 S VBEC(0)=$G(^VBEC(6001,VBECIEN,0))
 F I=1:1:4 S VBEC(I)=$P(VBEC(0),U,I) ;internal
 F I=1:1:4 S VBECX(I)=$$EXTERNAL^DILFD(6001,".0"_I,"L",VBEC(I)) ;external
 D HDR ; header output
 F  S VBEC1=$O(^VBEC(6001,VBECIEN,"ERR",VBEC1)) Q:'VBEC1  D  Q:VBECXIT!(VBECSTOP)
 .I $$S^%ZTLOAD() S (ZTSTOP,VBECSTOP)=1 Q
 .S VBECERR(0)=$G(^VBEC(6001,VBECIEN,"ERR",VBEC1,0))
 .F I=1:1:9 S VBEC1A(I)=$P(VBECERR(0),U,I)
 .S ERRTOT(VBEC1A(1))=+$G(ERRTOT(VBEC1A(1)))+1
 .D FILE^DID(VBEC1A(1),"","NAME","VBECFR")
 .D:VBEC1A(3) FILE^DID(VBEC1A(3),"","NAME","VBECTO")
 .S VBECOMP=$$EXTERNAL^DILFD(6001.01,.07,"L",VBEC1A(7)) ; value or null
 .S X=VBEC1A(9),DIWL=1,DIWR=55,DIWF="" D ^DIWP ; format text...
 .W !,"File Navigated: "_VBECFR("NAME")_"("_VBEC1A(1)_")"
 .I $Y>(IOSL-4) D EOS Q:VBECXIT
 .W:VBEC1A(2) !,$$NAME(VBEC1A(1),VBEC1A(2))
 .W:VBEC1A(3) !,"File Navigated To: "_VBECTO("NAME")_"("_VBEC1A(3)_")"
 .I $Y>(IOSL-4) D EOS Q:VBECXIT
 .W:VBEC1A(4) !,$$NAME(VBEC1A(3),VBEC1A(4))
 .W:VBEC1A(5) !,"Similar Blood Component/Blood Component ID for Lab Data patient"
 .W $S((VBEC1A(5)&VBEC1A(6)):"s:",(VBEC1A(5)&'VBEC1A(6)):":",1:"")
 .I $Y>(IOSL-4) D EOS Q:VBECXIT
 .W:VBEC1A(5) !?3,"LRDFN (IEN in Lab Data file): "_VBEC1A(5)
 .W:VBEC1A(6) !?3,"LRDFN (conflicting patient IEN): "_VBEC1A(6)
 .I $Y>(IOSL-4) D EOS Q:VBECXIT
 .W:VBEC1A(7) !,"Blood Component: "_VBECOMP
 .W:VBEC1A(8)'="" !,"Blood Component ID: "_VBEC1A(8)
 .I $Y>(IOSL-4) D EOS Q:VBECXIT
 .W !,"Data Integrity Issue: " S A=0
 .I $Y>(IOSL-4) D EOS Q:VBECXIT  W !
 .F  S A=$O(^UTILITY($J,"W",DIWL,A)) Q:'A!(VBECXIT)  D
 ..I $Y>(IOSL-4) D EOS Q:VBECXIT  W !
 ..W ?22,$G(^UTILITY($J,"W",DIWL,A,0)),!
 ..Q
 .K A,DIW,DIWF,DIWI,DIWL,DIWR,DIWT,DIWTC,DIWX,DN,VBEC1A,VBECFR,VBECOMP,VBECTO,X,Z,^UTILITY($J,"W")
 .Q
 ;
ERRTOT ; print error total for each file
 I $Y>(IOSL-6) D EOS Q:VBECXIT  W !
 S I=0 F  S I=$O(ERRTOT(I)) Q:'I  W !,"Total number of anomalies for file "_I_": "_$G(ERRTOT(I))
 ;
XIT ; cleanup after yourself before you go...
 K A,DIRUT,DIW,DIWF,DIWI,DIWL,DIWR,DIWT,DIWTC,DIWX,DN,DTOUT,DUOUT,ERRTOT,I,LINE,PAGE,TODAY,VBEC,VBEC1,VBEC1A,VBECERR,VBECFR,VBECOMP,VBECTO,VBECX,VBECXIT,X,Z,^UTILITY($J,"W"),VBECSTOP
 Q
 ;
EOS ; end of screen check & refresh screen action
 I $E(IOST)="C" K DIR S DIR(0)="E" D ^DIR S VBECXIT=$S(Y'>0:1,1:0) K DIR,X,Y
 Q:VBECXIT
HDR ; draw header
 W:($E(IOST)="C")!(PAGE>1) @IOF
 W !,$$CJ^XLFSTR("VistA Blood Bank Data Anomalies Report",80)
 W !,"Date: ",TODAY,?69,"Page: ",PAGE S PAGE=PAGE+1
 W !,"Process initiated by: "_$E(VBECX(4),1,25),?49,"Process: "_VBECX(2)
 W !,"Start time: "_VBECX(1),?49,"Finish time: "_VBECX(3),!,LINE
 Q
 ;
NAME(FILE,IEN) ; Using file number and ien, determine the value of the .01
 ; field and pass it back (along with the data descriptor).
 ; input: FILE-file number, either 2, 63, 65, or 66
 ;        IEN-internal entry number of the record in question
 ; output: (examples) Patient Name: Doe,John, Lab Data ID: 12345,
 ;         Unit ID: ABC123, Blood Component: CPDA-1 RED BLOOD CELLS
 ;
 Q:FILE=2 "Patient Name: "_$P($G(^DPT(IEN,0)),U)_$S($P($G(^DPT(IEN,0)),U)]"":" ("_$E($P($G(^DPT(IEN,0)),U,9),1,3)_"-"_$E($P($G(^DPT(IEN,0)),U,9),4,5)_"-"_$E($P($G(^DPT(IEN,0)),U,9),6,9)_")",1:"")
 Q:FILE=63 "Lab Data ID: "_$P($G(^LR(IEN,0)),U)
 Q:FILE=65 "Unit ID: "_$P($G(^LRD(65,IEN,0)),U)
 Q:FILE=66 "Blood Component: "_$P($G(^LAB(66,IEN,0)),U)
 ;
