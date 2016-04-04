DMSQP5 ;SFISC/EZ-DD LISTING USING SQLI ;10/30/97  17:46
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
EN ; for a single file or number range, display DD information
 I '$O(^DMSQ("S",0)) W !?5,"Sorry, SQLI files are empty.",! Q
 I $$WAIT^DMSQT1 D  Q
 . W !?5,"Try later.  SQLI is being re-built right now."
 D DT^DICRW S DMQ="" D ASK G EXIT:DMQ D ASK1 G EXIT:DMQ
 S %ZIS="Q" D ^%ZIS G EXIT:POP
 I $D(IO("Q")) D  G EXIT
 . S ZTRTN="DQ^DMSQP5",ZTSAVE("DMFN")="",ZTSAVE("DMFN1")=""
 . D ^%ZTLOAD
 D DQ
EXIT D ^%ZISC
 K DMFN,DMFN1,DM1,DM2,DMQ
 Q
ASK ; select file numbers
 W !,"WARNING:  REPORT JUST WRITES TO THE SCREEN WITHOUT PAGE BREAKS"
 W !,"          (INTENDED FOR SCREEN CAPTURES) SO PICK ONE TABLE"
 W !,"          OR A SMALL RANGE WHEN TESTING",!
 S DM1=$O(^DMSQ("T","C",0)),DM2=$O(^DMSQ("T","C",99999999999),-1)
 S DIR(0)="NO^"_DM1_":"_DM2_":999999999",DIR("A")="Starting File Number"
 S DIR("?")="Enter the number of the file, e.g. 200 or 1.5215"
 S DIR("B")=1.521 D ^DIR S:$D(DIRUT) DMQ=1 K DIR Q:DMQ  S DMFN=Y
 I '$D(^DMSQ("T","C",DMFN)) W !,"SQLI table not found." G ASK
 Q
ASK1 S DIR("B")=DMFN ; default to one file (not a range)
 S DIR(0)="NO^"_DM1_":"_DM2_":999999999",DIR("A")="  Ending File Number"
 S DIR("?")="Optionally enter a larger number for a range, e.g. 1.5217"
 D ^DIR S:$D(DTOUT)!$D(DUOUT) DMQ=1 K DIR Q:DMQ  S DMFN1=Y
 I '$D(^DMSQ("T","C",DMFN1)) D  G ASK1
 . W !!?5,"There isn't a table for the file number you've entered."
 . W !?5,"(The highest possible number is "_DM2_".)",!
 I DMFN1'=DMFN,DMFN1'>DMFN D  G ASK1
 . W !!?5,"Enter a LARGER number to get a range."
 . W !?5,"The highest possible number here is "_DM2_".",!
 Q
DQ ; print DD information in file number order
 ; find file number links (from subfiles or pointers)
 U IO
 N DMQ,FI,TI,EI,CI,PEI,PI,FEI,FKI
 N GBL,PARLNK,LINK,PTRLNK,FLD,FLDGBL,ID,PIECE,EXTRACT,FN,DMSQTMP,TN,EN
 S DMQ="",FI=$O(^DMSQ("T","C",DMFN),-1)
 F  S FI=$O(^DMSQ("T","C",FI)) Q:(DMQ)!(FI>DMFN1)!(FI'>0)  D
 . S TI=0 F  S TI=$O(^DMSQ("T","C",FI,TI)) Q:(DMQ)!(TI'>0)  D
 .. S TN=$P(^DMSQ("T",TI,0),U,1)
 .. S (EI,GBL,PARLNK)=""
 .. F  S EI=$O(^DMSQ("E","F",TI,"C",EI)) Q:(DMQ)!(EI'>0)  D
 ... D PAGE I $D(DIRUT) S DMQ=1 Q
 ... D RPT
 Q
PAGE ; do page breaks if using a terminal (C-) device
 I ($Y+6>IOSL)&(IOST["C-") S DIR(0)="E" D ^DIR K DIR W @IOF
 Q
RPT ;
 I $P(^DMSQ("E",EI,0),U,2)=14 Q   ;exclude wp fields here
 ;include the subfiles created from wp fields later on
 S EN=$P(^DMSQ("E",EI,0),U,1)
 S (LINK,PTRLNK,FLD,FLDGBL,ID)=""
 S CI=$O(^DMSQ("C","B",EI,""))
 S PEI=$O(^DMSQ("E","F",TI,"P",""))
 S PI="" F  S PI=$O(^DMSQ("P","B",PEI,PI)) Q:PI'>0  D
 . I CI=$P(^DMSQ("P",PI,0),U,2) D
 .. S GBL=GBL_^DMSQ("C",CI,1)_"{K}",ID=1
 S FEI=0 F  S FEI=$O(^DMSQ("E","F",TI,"F",FEI)) Q:FEI'>0  D
 . S FKI=$O(^DMSQ("F","B",FEI,""))
 . I FKI,CI=$P(^DMSQ("F",FKI,0),U,3) D
 .. S LINK=$P(^DMSQ("T",$P(^DMSQ("DM",$P(^DMSQ("E",FEI,0),U,2),0),U,4),0),U,7)
 .. S:ID PARLNK=LINK S:'ID PTRLNK=LINK
 Q:ID  D   ;just process non-ID columns (regular fields)
 . S FLD=$P(^DMSQ("C",CI,0),U,6) I $D(^DMSQ("C",CI,1)) D
 .. S FLDGBL=GBL_^DMSQ("C",CI,1)
 .. S PIECE=$P(^DMSQ("C",CI,0),U,11)
 .. S EXTRACT=$P(^DMSQ("C",CI,0),U,12)_","_$P(^(0),U,13)
 .. S:PIECE FLDGBL="$P("_FLDGBL_",U,"_PIECE_")"
 .. S:EXTRACT FLDGBL="$E("_FLDGBL_","_EXTRACT_")"
 D FIELD^DID(FI,FLD,"","LABEL;TYPE","DMSQTMP")
 S FN=$S($D(^DIC(FI)):$P(^(FI,0),U),1:$O(^DD(FI,0,"NM","")))
 W !,FI_" "_FN,!?($L(FI)-3),"TBL:"_TN
 W !?10,FLD_" "_$G(DMSQTMP("LABEL")),!?($L(FLD)+7),"COL:"_EN
 W !?20,$G(DMSQTMP("TYPE"))
 W:PTRLNK ?32,"TO: "_PTRLNK
 W:PARLNK ?52,"SUBFILE OF: "_PARLNK
 W !?20,FLDGBL
 Q
