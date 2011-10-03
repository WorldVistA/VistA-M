MAGXCVL ;WOIFO/SEB,MLH - Image File Conversion Utilities & Misc. options ; 15 Jul 2004  10:54 AM
 ;;3.0;IMAGING;**17,25,31**;Mar 31, 2005
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
 ;
 ; Entry point for the File Setup option (MAG IMAGE INDEX FILE SETUP)
EN N FNAME,COUNT,MAGDATA,MAGFLD,MAGID,CT,DR,DIE,DA,%ZIS
 N IX ; --------- scratch subscript var
 ;
 S COUNT=0
EN1 ; get the name of the conversion file
 K DIR S DIR(0)="FOU^3:60"
 S DIR("A")="Please enter the filename of the conversion file"
 S DIR("?",1)="Enter a filename (including the path) of a text file"
 S DIR("?")="containing mapping data."
 D ^DIR
 I $G(Y)]"",'$D(DUOUT),'$D(DTOUT)
 E  S COUNT=-1 G DONE
 S %ZIS="",%ZIS("HFSNAME")=Y,%ZIS("HFSMODE")="R",IOP="HFS"
 S X="ERR^"_$T(+0),@^%ZOSF("TRAP")
 D ^%ZIS I POP=1 W !,"Invalid filename. Please try again." G EN1
 U IO(0)
CLEAR ; confirm it's OK to clear before proceeding
 K DIR S DIR(0)="YU"
 S DIR("A")="Clear mapping file",DIR("B")="NO"
 D ^DIR
 I $D(DUOUT)!$D(DTOUT) G CLOSE
 I Y K ^XTMP("MAG30P25","MAPPING") W "    File cleared!"
 U IO(0) W !
 F CT=1:1 U IO(0) W:CT#10=0 "." U IO R MAGDATA:DTIME Q:$E(MAGDATA,1,7)="$$EOF$$"  D
 . S MAGDATA=$TR(MAGDATA,$C(9),U),MAGDATA=$TR(MAGDATA,$C(34),"")
 . I $E(MAGDATA,1,2)="ID"!(MAGDATA="") Q
 . I $E(MAGDATA,1,7)="Field #" S MAGFLD=$P($E(MAGDATA,8,$L(MAGDATA)),"-") Q
 . I MAGFLD="" Q
 . ; To prevent mismatching of IEN keys, do not overwrite the values in the
 . ; MAG DESCRIPTIVE CATEGORIES File (#2005.81).  Instead, we will later
 . ; load the values from that (merged-into) file into the mapping file.
 . I MAGFLD=100 Q
 . S MAGID=$P(MAGDATA,U)
 . I MAGFLD=6!(MAGFLD=8)!(MAGFLD=10) S MAGID=$P(MAGDATA,U,2)
 . I MAGID="" Q
 . S ^XTMP("MAG30P25","MAPPING",MAGFLD,MAGID)=$P(MAGDATA,U,2,999)
 . I MAGFLD=16 D DIE(MAGFLD,MAGID,MAGDATA)
 . Q
 U IO(0) W !,"Mapping text file load complete.",!
 ;
 ; Here is where we will load FROM the MAG DESCRIPTIVE CATEGORIES File
 ; (#2005.81) INTO the mapping file.  (We used to do it the other way around.)
 W !,"Loading values from MAG DESCRIPTIVE CATEGORIES..."
 S IX=0
 F  S IX=$O(^MAG(2005.81,IX)) Q:'IX  S MAGDATA=$G(^(IX,2)) I MAGDATA]"" D
 . S ^XTMP("MAG30P25","MAPPING",100,IX)=$P($G(^MAG(2005.81,IX,0)),U)_U_MAGDATA
 . Q
 W "done.",!
 ;
 ; Now, re-apply local edits from the audit subtree.
 W !,"Re-applying local edits..."
 S AUDIX=0
 F  S AUDIX=$O(^XTMP("MAG30P25","MAPEDITAUD",AUDIX)) Q:'AUDIX  S AUDDTA=$G(^(AUDIX,0)) I AUDDTA]"" D
 . S ^XTMP("MAG30P25","MAPPING",$P(AUDDTA,U,3),$P(AUDDTA,U,4))=$P(AUDDTA,U,5,999)
 . Q
 W "done.",!
 G CLOSE
 ;
DIE(MAGFLD,MAGID,MAGDATA) ;
 ; File mapping data for field 16 into file #2005.03 (Parent Data File)
 ; or mapping data for field 100 into file #2005.81 (MAG Descriptive Categories)
 ; Called from CLEAR and from END^MAGXCVE 
 N DR ; --- FileMan field string
 N DIE ; -- FileMan file number
 N DA ; --- FileMan internal entry number
 N I ; ---- scratch index
 ;
 F I=3:1:8 S $P(MAGDATA,U,I)=$S($P(MAGDATA,U,I)="":"@",1:$P($P(MAGDATA,U,I),"-"))
 S DR="40////"_$P(MAGDATA,U,3)_";41////"_$P(MAGDATA,U,4)
 S DR=DR_";42////"_$P(MAGDATA,U,5)_";43////"_$P(MAGDATA,U,6)
 S DR=DR_";44////"_$P(MAGDATA,U,7)_";45////"_$P(MAGDATA,U,8)
 S DIE=$S(MAGFLD=16:2005.03,MAGFLD=100:2005.81),DA=MAGID U IO D ^DIE
 Q
 ;
 ; Reached when an error (including end-of-file) occurs.
ERR ;
 U IO(0) X "W !,$ZE,!"
CLOSE ; normal file close logic
 D ^%ZISC
DONE S COUNT=COUNT+1
 I COUNT=1 W !,"Done importing conversion values."
 Q
