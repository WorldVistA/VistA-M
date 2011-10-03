XLFNAME4 ;CIOFO-SF/MKO-PRINT INFORMATION IN ^XTMP ;11:35 AM  23 Mar 2000
 ;;8.0;KERNEL;**134**;Jul 10, 1995
 ;
PRINT N XUCD,XUCDX,XUFD,XUFDTXT,XUFL,XUHLIN,XUPG,XUREC
 N DIROUT,DIRUT,DTOUT,DUOUT,POP,X,Y
 D INTRO
 ;
 ;Get file number
 ;S XUFL=$$READ("Select a file or subfile number","ALL","HLPFIL") Q:XUFL=""
 S XUFL=200
 ;
 ;Get field number
 ;I XUFL="ALL" S XUFD="ALL"
 ;E  S XUFD=$$READ("Select a field number","ALL","HLPFLD") Q:XUFD=""
 S XUFD=.01
 ;
 ;Get list of codes
 S XUCD=$$READ("Enter a list of codes to print","ALL","HLPCOD","Enter a list of codes separated by commas, 'ALL', or '??' for more help.")
 Q:U[XUCD
 S:XUCD="ALL" XUCD=""
 I XUCD]"" S XUCD=$$UP^XLFSTR($TR(XUCD," "))
 ;
 ;Get list of codes to exclude
 S XUCDX=$$READ("Enter a list of codes to exclude","","HLPCODX","Enter a list of codes separated by commas, or '??' for more help.")
 Q:XUCDX=U
 I XUCDX]"" S XUCDX=$$UP^XLFSTR($TR(XUCDX," "))
 ;
 ;Prompt for device
 S %ZIS="Q" W ! D ^%ZIS Q:$G(POP)
 I $D(IO("Q")),$D(^%ZTSK) D QUEUE G END
 U IO
 ;
MAIN ;TaskMan entry point
 D INIT,HDR,CODTAB
 ;
 I XUFL="ALL" D
 . S XUFL=0
 . F  S XUFL=$O(^XTMP("XLFNAME",XUFL)) Q:'XUFL  D PFIL(XUFL,XUCD,XUCDX) Q:$D(DIRUT)
 E  I XUFD="ALL" D
 . D PFIL(XUFL,XUCD,XUCDX)
 E  D PFLD(XUFL,XUFD,XUCD,XUCDX)
 ;
 D END
 Q
 ;
PFIL(XUFL,XUCD,XUCDX) ;Print information for a specific file
 S XUFD=0
 F  S XUFD=$O(^XTMP("XLFNAME",XUFL,XUFD)) Q:'XUFD  D PFLD(XUFL,XUFD,XUCD,XUCDX) Q:$D(DIRUT)
 Q
 ;
PFLD(XUFL,XUFD,XUCD,XUCDX) ;Print info for a specific field
 D HINFO(XUFL,XUFD),EOP Q:$D(DIRUT)  D HDR,SUBHDR
 S XUREC="" F  S XUREC=$O(^XTMP("XLFNAME",XUFL,XUFD,XUREC)) Q:XUREC=""  D PREC(XUFL,XUFD,XUREC,XUCD,XUCDX) Q:$D(DIRUT)
 Q
 ;
PREC(XUFL,XUFD,XUREC,XUCD,XUCDX) ;Print info for a specific record
 N C,I,XUOLD,XUNEW,XUCOD,XULN,XUMAT,XUMATX,XUNC
 ;
 ;Get old and new name, and Name Components ien
 S XULN=^XTMP("XLFNAME",XUFL,XUFD,XUREC)
 S XUOLD=$P(XULN,U),XUNEW=$P(XULN,U,2)
 ;
 ;Get note codes
 S XUCOD="" S XUMAT=$G(XUCD)="",(XUMATX,XUNC)=0
 S I=0 F  S I=$O(^XTMP("XLFNAME",XUFL,XUFD,XUREC,I)) Q:I=""  D  Q:XUMATX
 . I I="MIDDLE"!(I="SUFFIX") S XUNC=1
 . S C=$E(I,1,"NPS"[$E(I)+1)
 . I 'XUMAT,","_XUCD_","[(","_C_",") S XUMAT=1
 . I $G(XUCDX)]"",'XUMATX,","_XUCDX_","[(","_C_",") S XUMATX=1
 . S XUCOD=XUCOD_C_","
 Q:'XUMAT!XUMATX
 S:XUCOD?.E1"," XUCOD=$E(XUCOD,1,$L(XUCOD)-1)
 ;
 D W(XUREC) Q:$D(DIRUT)  W ?15,"Old: "_XUOLD,?60,XUCOD
 D W("New: "_XUNEW,15) Q:$D(DIRUT)
 I XUNC D
 . D W(" Given: "_$P(XULN,U,3),22)
 . D W("Middle: "_$P(XULN,U,4),22)
 . D W("Family: "_$P(XULN,U,5),22)
 . D W("Suffix: "_$P(XULN,U,6),22)
 D W() Q:$D(DIRUT)
 Q
 ;
W(XUSTR,XUCOL,XUFLG) ;Write line feed and string XUSTR in column XUCOL
 I $Y+3'<IOSL D EOP Q:$D(DIRUT)  D HDR D:'$G(XUFLG) SUBHDR
 W !?+$G(XUCOL),$G(XUSTR)
 Q
 ;
EOP ;EOP
 I $E(IOST,1,2)="C-",'$D(ZTQUEUED) D
 . N DIR,X,Y
 . S DIR(0)="E" W ! D ^DIR
 E  I $D(ZTQUEUED),$$S^%ZTLOAD S (ZTSTOP,DIRUT)=1
 W @IOF
 Q
 ;
HDR ;Print header
 S XUPG=$G(XUPG)+1,$X=0
 W "^XTMP(""XLFNAME"") LISTING",?(IOM-$L(XUHLIN)-$L(XUPG)-1),XUHLIN_XUPG
 W !,$TR($J("",IOM-1)," ","-")
 Q
 ;
SUBHDR ;Print subheader
 W !,"File: #"_XUFL,", Field: "_XUFDTXT
 W:XUCD]"" !,"Entries that contain any of the following codes: ",XUCD
 W:XUCDX]"" !,"Excluding entries that contain any of the following codes: ",XUCDX
 W !!,"Record",?15,"Name",?60,"Codes"
 W !,"------",?15,$TR($J("",40)," ","-"),?60,"-----"
 Q
 ;
HINFO(XUFL,XUFD) ;Get XUFDTXT for subheader
 N XULAB
 D FIELD^DID(XUFL,XUFD,"","LABEL","XULAB")
 S XUFDTXT=XULAB("LABEL")_" (#"_XUFD_")"
 Q
 ;
READ(PROMPT,DEF,XHELP,HELP) ;Read X, default is ALL
 N DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT
 S DIR(0)="FO^1:30"
 S:$G(PROMPT)]"" DIR("A")=PROMPT
 S DIR("?")=$S($G(HELP)]"":HELP,1:"Enter a number or the word 'ALL'. Enter '??' for more help.")
 S:$G(XHELP)]"" DIR("??")="^D "_XHELP_"^XLFNAME4"
 S:$G(DEF)]"" DIR("B")=DEF
 D ^DIR Q:$D(DUOUT)!$D(DTOUT) U
 Q Y
 ;
HLPFIL ;Execute help for file prompt
 N I
 W !,"Enter 'ALL' to select all files, or select one of the following:",!
 S I=0 F  S I=$O(^XTMP("XLFNAME",I)) Q:'I  W:$X>70 ! W I_"  "_$J("",10-$L(I))
 Q
 ;
HLPFLD ;Execute help for field prompt
 N I
 W !,"Enter 'ALL' to select all fields, or select one of the following:",!
 S I=0 F  S I=$O(^XTMP("XLFNAME",XUFL,I)) Q:'I  W:$X>70 ! W I_"  "_$J("",10-$L(I))
 Q
 ;
HLPCOD ;Executable help for codes prompt
 N I,T
 F I=1:1 S T=$P($T(CODTAB+I),";;",2,999) Q:T="$$END"  W !,T
 W !!,"To include entries with specific codes, enter those codes separated by commas,"
 W !,"or enter 'ALL' to select entries with any code,"
 Q
 ;
HLPCODX ;Executable help for codes prompt
 N I,T
 F I=1:1 S T=$P($T(CODTAB+I),";;",2,999) Q:T="$$END"  W !,T
 W !!,"To exclude entries with specific codes, enter those codes separated by commas,"
 W !,"or press <RET> to exclude no entries."
 W !!,"This list overrides the list of codes to include."
 Q
 ;
QUEUE ;Queue the report
 N I,ZTSK
 ;
 S ZTRTN="MAIN^XLFNAME4"
 S ZTDESC="Report of ^XTMP(""XLFNAME"")"
 F I="XUFL","XUFD","XUCD","XUCDX" S ZTSAVE(I)=""
 D ^%ZTLOAD
 ;
 I $D(ZTSK)#2 W !,"Report queued!",!,"Task number: "_$G(ZTSK),!
 E  W !,"Report canceled!",!
 ;
 D HOME^%ZIS
 Q
 ;
INIT ;Set XUHLIN to Date/time/page for header
 N %,%H,X,Y
 S %H=$H D YX^%DTC
 S XUHLIN=$P(Y,"@")_"  "_$P($P(Y,"@",2),":",1,2)_"    PAGE "
 W:$E(IOST,1,2)="C-" @IOF
 Q
 ;
END ;Finish up
 I $D(ZTQUEUED) S ZTREQ="@"
 E  D ^%ZISC
 Q
 ;
INTRO ;Introductory text
 ;;This entry point prints a report of the information stored in
 ;;^XTMP("XLFNAME").
 ;;
 ;;The New Person Name Standardization conversion is run automatically during
 ;;the installation of patch XU*8.0*134, as part of the POST-INSTALL ROUTINE
 ;;(POST^XLFNAME). The conversion records in ^XTMP("XLFNAME") information
 ;;about each Name that had to be changed to convert it to standard form, or
 ;;for which assumptions had to be made in breaking the Name into its
 ;;component parts for storage in the new NAME COMPONENTS file (#20).
 ;;
 ;;You can use this report to determine whether any names were standardized
 ;;or parsed incorrectly. To correct a name or its component parts, go to the
 ;;"Systems Manager Menu" [EVE], select "User Management" [XUSER], and then
 ;;"Edit an Existing User" [XUSEREDIT]. From there you can edit the NAME
 ;;field (#.01) of the NEW PERSON file (#200), as well as the component parts
 ;;of the Name as they are stored in the NAME COMPONENTS file (#20).
 ;;
 ;;$$END
 N I,T
 F I=1:1 S T=$P($T(INTRO+I),";;",2,999) Q:T="$$END"  W !,T
 Q
 ;
CODTAB ;Code Table
 ;;Explanation of Codes:
 ;;--------------------
 ;;  D  : The standard name is different from the original name.
 ;;  F  : The Family Name starts with ST<period>. The period and
 ;;         following space, if any, were removed.
 ;;  G  : There is no Given Name.
 ;;  M  : Assumption: There is more than one Given and only one Middle Name.
 ;;  NM : NMI or NMN was used as the Middle Name.
 ;;  NU : A name part contains a number.
 ;;  PE : Periods were removed.
 ;;  PU : Punctuation was removed.
 ;;  SP : Spaces were removed from the Family Name.
 ;;  ST : Text in parentheses was stripped from the name.
 ;;  SU : One or more of the following situations was encountered relating
 ;;       to suffixes:
 ;;       - Suffixes were found immediate to left of the first comma.
 ;;       - I, V, or X was interpreted as a Middle Name.
 ;;       - A name part was interpreted as a Suffix, not a Middle Name.
 ;;       - M.D. or M D was NOT interpreted as a Suffix.
 ;;       - A name part with no vowels was interpreted as a Suffix.
 ;;       - A Suffix was found between commas immediately after the Family Name.
 ;;  T  : The standard name was truncated.
 ;;$$END
 N I,T
 F I=1:1 S T=$P($T(CODTAB+I),";;",2,999) Q:T="$$END"  D W(T,0,1)
 Q
