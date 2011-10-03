RART2 ;HISC/GJC-Reporting Menu (Part 3) ;4/3/97  08:33
 ;;5.0;Radiology/Nuclear Medicine;**26**;Mar 16, 1998
4 ;;Print Report By Patient
 K ^TMP($J,"RAEX")
 S RAF1="" ; allow the user to select a range of case #'s
 S DIC(0)="AEMQ" D ^RADPA
 I Y<0 D Q4 Q
 S RADFN=+Y,RAHEAD="**** Patient's Exams ****",RAREPORT=1
 D ^RAPTLU
 I X="^" D Q4 Q
 S RAGJC=0 F  S RAGJC=$O(^TMP($J,"RAEX",RAGJC)) Q:RAGJC'>0  D
 . I '$D(RADUP(RAGJC)) K ^TMP($J,"RAEX",RAGJC) Q
 . D CHK(RAGJC) ; check all existing entries!
 . Q
 I '$D(^TMP($J,"RAEX")) D  D Q4 Q  ; quit if nothing to print
 . W !?4,"There are no reports left to print!",$C(7)
 . Q
 K %ZIS,IOP W ! S %ZIS="QM",%ZIS("A")="Select a device: "
 D ^%ZIS I POP D Q4 Q
 I $D(IO("Q")) D  D Q4 Q
 . S ZTRTN="START^RART2",ZTSAVE("^TMP($J,""RAEX"",")=""
 . S ZTDESC="Rad/Nuc Med Print Selected Reports By Patient"
 . S:'$D(RADFT) ZTSAVE("RASTFL")="",RASTFL=""
 . S:$D(RAOPT) ZTSAVE("RAOPT")=""
 . D ^%ZTLOAD
 . I +$G(ZTSK("D"))>0 W !?5,"Request Queued, Task #: ",$G(ZTSK)
 . D HOME^%ZIS K IO("Q") ;restore home device parameters P26
 . Q
START ; start printing the data
 U IO S RAGJC=0 ; RAOOUT is defined in RARTR if abnormal exit (eos)
 F  S RAGJC=$O(^TMP($J,"RAEX",RAGJC)) Q:RAGJC'>0  D  Q:$D(RAOOUT)
 . S RAXAM=$G(^TMP($J,"RAEX",RAGJC))
 . S RARPT=+$P(RAXAM,"^",10) D:RARPT PRT^RARTR
 . Q
 D CLOSE
 Q
CLOSE ; Close the device
 W ! D ^%ZISC
Q4 ; Kill & Quit
 S:$D(ZTQUEUED) ZTREQ="@"
 K %I,%W,%X,%XX,%Y,%YY,%ZHFN,%ZISZ,C,DFN,DIC,DIROUT,DIRUT,DIW,DIWF,DIWL
 K DIWR,DIWT,DLAYGO,DTOUT,DUOUT,ER,RACATP,RACN,RACNI,RADATE,RADFN,RADFT
 K RADOC,RADTE,RADTI,RADUP,RAF1,RAGJC,RAHEAD,RAI,RAMES,RANM,RANME,RANOW
 K RANUM,RAOATP,RAOOUT,RAPAR,RAPOP,RAPRC,RAPTLOC,RAREDT,RAREPORT,RARPT
 K RAS,RASEL,RASSN,RAST,RASTFL,RAXAM,X,X1,X2,XMAP0R,XMDISP1,XMGAPI1
 K XMLOC,XMN,XMREC,XQXFLG,XMXUSER,Y,ZTDESC,ZTRTN,ZTSAVE,ZTSK
 K ^TMP($J,"RAEX")
 K DIPGM,I,POP,RAIMGTYI,RAVERFDT,RAWHOVER,RAPRTSET,DISYS
 Q
CHK(X) ; check if a valid report
 ; 'X' is the subscript on ^TMP($J,"RAEX")
 N RACASE,RAXAM,Y S RAXAM=$G(^TMP($J,"RAEX",X))
 S RACASE=$P(RAXAM,"^",8),Y=$P(RAXAM,"^",10)
 I '$L(Y)!('$D(^RARPT(+Y,0))) D  Q
 . W !?3,*7,"No report filed for case number ",RACASE,"."
 . K ^TMP($J,"RAEX",X)
 . Q
 I $D(RADFT),$P(^RARPT(+Y,0),"^",5)'["D" D  Q
 . W !?3,"Report for case number ",RACASE," is not in a 'draft' status."
 . W $C(7) K ^TMP($J,"RAEX",X)
 . Q
 I '$D(RADFT),$P(^RARPT(+Y,0),"^",5)["D" D  Q
 . W !?3,"Report filed for case number ",RACASE," but not available"
 . W " for printing.",$C(7)
 . K ^TMP($J,"RAEX",X)
 . Q
 Q
