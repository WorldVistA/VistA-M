DDFIX ;SFCIOFO/S0/MKO VARIOUS DD AND DIC FIXES ;9:17 AM  15 Mar 1999
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
FIXPT ; ==> Fix Bad "PT" Nodes <==
 ;
 N EP,ESC
 I '$D(XPDNM) S EP="PT" D DEVICE
 I $D(ESC) G EXIT
DEQPT N DICFILE,DDFILE,DDFIELD,PGLEN,PG,RPTDT,X
 U IO
 D RPTDT
 S PGLEN=IOSL-5,PG=0
 I '$D(XPDNM) D PTHDR
 ; Loop thru DIC(<file #>,
 S DICFILE=1.99999
 F  S DICFILE=$O(^DIC(DICFILE)) Q:DICFILE'>1.99999!$D(ESC)  D
 . ; Loop thru DD(DICFILE,0,"PT",<file #>
 . S DDFILE=1.99999
 . F  S DDFILE=$O(^DD(DICFILE,0,"PT",DDFILE)) Q:DDFILE'>1.99999!$D(ESC)  D
 .. I $D(^DD(DDFILE,0))#2 D  Q  ; File Exists
 ... ; Check Fields Exists
 ... S DDFIELD=0
 ... F  S DDFIELD=$O(^DD(DICFILE,0,"PT",DDFILE,DDFIELD)) Q:'DDFIELD!$D(ESC)  D
 .... I $D(^DD(DDFILE,DDFIELD,0))#2 D  Q  ; Field is still in DD
 ..... I ($P(^(0),U,2)'["P")&($P(^(0),U,2)'["V") D  Q  ; Field Still A Pointer?
 ...... S X="*File: "_DDFILE_" Field: "_DDFIELD_" is Not a Pointer Type." D RPTOUT
 ...... S X="   Deleting ""PT"" node: "_$NA(^DD(DICFILE,0,"PT",DDFILE,DDFIELD)) D RPTOUT,K1 Q
 ..... I $P(^(0),U,2)["P",+$P($P(^(0),U,2),"P",2)'=DICFILE D  Q  ; Field Still Point To Same File?
 ...... S X="*File: "_DDFILE_" Field: "_DDFIELD_" Does Not Point To File: "_DICFILE_"." D RPTOUT
 ...... S X="  Deleting ""PT"" Node: "_$NA(^DD(DICFILE,0,"PT",DDFILE,DDFIELD)) D RPTOUT,K1 Q
 .... ; **Field No Longer Exists
 .... S X="*Field: "_DDFIELD_" in File: "_DDFILE_" does Not Exist." D RPTOUT
 .... S X="  Deleting ""PT"" node: "_$NA(^DD(DICFILE,0,"PT",DDFILE,DDFIELD)) D RPTOUT,K1 Q
 .. ; **File No Longer Exists
 .. S X="*File: "_DDFILE_" Does Not Exist." D RPTOUT
 .. S X="  Deleting ""PT"" node: "_$NA(^DD(DICFILE,0,"PT",DDFILE)) D RPTOUT
 .. K ^DD(DICFILE,0,"PT",DDFILE)
 G EXIT ; GoTo Common Exit
K1 ; Kill at Field Level
 K ^DD(DICFILE,0,"PT",DDFILE,DDFIELD)
 Q
PTHDR ; Fix "PT" nodes Report Header
 I $E(IOST,1,2)="C-" D  Q:$D(ESC)
 . I PG D PAUSE Q:$D(ESC)
 . W @IOF
 I PG W @IOF
 S PG=PG+1
 W "Fix ""PT"" Nodes Report     "_RPTDT,?(IOM-10),"Page: "_PG,!
 N X
 S X="",$P(X,"-",(IOM-1))="" W X,!
 Q
 ;
FIXNM ; ==> Fix Duplicate 'NM' Nodes <==
 ; From patch DI*21*50, routine DIPR50
 ;
 N EP,ESC
 I '$D(XPDNM) S EP="NM" D DEVICE
 I $D(ESC) G EXIT
DEQNM N DDFILE,DDNAME,DDNEW,PGLEN,PG,RPTDT,X
 U IO
 D RPTDT
 S PGLEN=IOSL-5,PG=0
 I '$D(XPDNM) D NMHDR
 S DDFILE=1.99999
 F  S DDFILE=$O(^DD(DDFILE)) Q:'DDFILE!$D(ESC)  D
 . ; Check and repair duplicate "NM" nodes
 . S DDNAME=$O(^DD(DDFILE,0,"NM","")) Q:DDNAME=""
 . I $O(^DD(DDFILE,0,"NM",DDNAME))="" Q
 . S X="*File/Subfile: "_DDFILE_" has duplicate 'NM' nodes."
 . D RPTOUT
 . S DDNEW=$S($D(^DIC(DDFILE,0))#2:$P(^(0),U),1:$P(^DD(DDFILE,0)," SUB-FIELD"))
 . Q:DDNEW=""
 . K ^DD(DDFILE,0,"NM")
 . S ^DD(DDFILE,0,"NM",DDNEW)=""
 . S X="  ""NM"" node will be set to: "_DDNEW
 . D RPTOUT
 G EXIT ; GoTo Common Exit Point
NMHDR ; Fix "NM" nodes Report Header
 I $E(IOST,1,2)="C-" D  Q:$D(ESC)
 . I PG D PAUSE Q:$D(ESC)
 . W @IOF
 I PG W @IOF
 S PG=PG+1
 W "Fix Duplicate ""NM"" Nodes Report     "_RPTDT,?(IOM-10),"Page: "_PG,!
 N X
 S X="",$P(X,"-",(IOM-1))="" W X,!
 Q
 ;
FIXAG ; ==> Application Group Multiple Bad Xrefs <==
 ; From patch DI*21*58, routine DIPR58
 ;
 N EP,ESC
 I '$D(XPDNM) S EP="AG" D DEVICE
 I $D(ESC) G EXIT
DEQAG N DDAGPKG,DDFILE,IEN,PGLEN,PG,RPTDT,X
 U IO
 D RPTDT
 S PGLEN=IOSL-5,PG=0
 I '$D(XPDNM) D AGHDR
 S DDFILE=1.99999
 F  S DDFILE=$O(^DIC(DDFILE)) Q:DDFILE<1.99999  D
 . I '$D(^DIC(DDFILE,"%")) Q  ; No App. Group Multiple
 . S DDAGPKG=""
 . F  S DDAGPKG=$O(^DIC(DDFILE,"%","B",DDAGPKG)) Q:DDAGPKG=""  D
 .. S IEN=0
 .. F  S IEN=$O(^DIC(DDFILE,"%","B",DDAGPKG,IEN)) Q:'IEN  D
 ... I $P($G(^DIC(DDFILE,"%",IEN,0)),U)=DDAGPKG Q
 ... S X="Deleting App. Group "_DDAGPKG_" ""B"" xref: "_$NA(^DIC(DDFILE,"%","B",DDAGPKG,IEN))
 ... D RPTOUT
 ... K ^DIC(DDFILE,"%","B",DDAGPKG,IEN)
AC ; Loop Thru "AC" xref and Remove Any Entries That Point to
 ; Files That Do Not Exist
 S DDAGPKG=""
 F  S DDAGPKG=$O(^DIC("AC",DDAGPKG)) Q:DDAGPKG=""  D
 . S DDFILE=1.99999
 . F  S DDFILE=$O(^DIC("AC",DDAGPKG,DDFILE)) Q:DDFILE<1.99999  D
 .. I $D(^DIC(DDFILE,0))[0 D  Q
 ... S X="Deleting ""AC"" xref: "_$NA(^DIC("AC",DDAGPKG,DDFILE))
 ... D RPTOUT
 ... K ^DIC("AC",DDAGPKG,DDFILE)
 .. S IEN=0
 .. F  S IEN=$O(^DIC("AC",DDAGPKG,DDFILE,IEN)) Q:'IEN  D
 ... I $P($G(^DIC(DDFILE,"%",IEN,0)),U)'=DDAGPKG D
 .... S X="Deleting ""AC"" xref: "_$NA(^DIC("AC",DDAGPKG,DDFILE,IEN))
 .... D RPTOUT
 .... K ^DIC("AC",DDAGPKG,DDFILE,IEN)
 G EXIT ; GoTo Common Exit Point
AGHDR ; Fix Application Group Xrefs Report Header
 I $E(IOST,1,2)="C-" D  Q:$D(ESC)
 . I PG D PAUSE Q:$D(ESC)
 . W @IOF
 I PG W @IOF
 S PG=PG+1
 W "Fix Application Group Xrefs Report     "_RPTDT,?(IOM-10),"Page: "_PG,!
 N X
 S X="",$P(X,"-",(IOM-1))="" W X,!
 Q
 ;
 ; Common For All Entry Points
 ;
DEVICE ; Output Device Selection
 S %ZIS="MQ"
 D ^%ZIS
 I POP S ESC=1 Q  ;User Escaped Device Selection
 I $D(IO("Q")) D
 . S ZTDESC=$S(EP="PT":"FIX PT NODES",EP="NM":"FIX DUPLICATE 'NM' NODES",EP="AG":"FIX APPLICATION GROUP XREFS",1:"")
 . S ZTRTN=$S(EP="PT":"DEQPT",EP="NM":"DEQNM",EP="AG":"DEQAG",1:"")_"^DDFIX"
 . S ZTSAVE("EP")=""
 . D ^%ZTLOAD
 . I $D(ZTSK)#2 W !,"Report queued!",!,"Task number: "_$G(ZTSK),!
 . S ESC=1
 . K ZTSK,ZTDESC,ZTRTN,ZTSAVE
 . D HOME^%ZIS
 Q
RPTDT ; Get Report Date/Time
 N %,%H,X,Y
 S %H=$H
 D YX^%DTC
 S RPTDT=$P(Y,"@")_"@"_$E($P(Y,"@",2),1,5)
 Q
RPTOUT ; Print Messages
 I $D(XPDNM) D MES^XPDUTL(X) Q  ;  KIDS install being used
 W X,! ; KIDS install not being used
 I $Y'>PGLEN Q
 I EP="PT" D PTHDR Q
 I EP="NM" D NMHDR Q
 I EP="AG" D AGHDR Q
 Q
PAUSE ; End of Page Pause
 N DIR,Y
 S DIR(0)="E"
 D ^DIR
 I $D(DTOUT)!$D(DUOUT)!$D(DIRUT)!$D(DIROUT) K DTOUT,DUOUT,DIRUT,DIROUT S ESC=1 Q
 Q
EXIT ; Common Exit Point
 I $E(IOST,1,2)="P-" D ^%ZISC
 I $D(ZTQUEUED) S ZTREQ="@"
 K EP
 Q
