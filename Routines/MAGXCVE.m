MAGXCVE ;WOIFO/SEB,MLH - Image File Conversion Utilities & Misc. options ; 13 Aug 2003  1:24 PM
 ;;3.0;IMAGING;**25**;Sep 4, 2003
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
 ; Entry point for the Mapping File Edit option (MAG IMAGE INDEX MAP EDIT)
EDIT ;
 I '$D(^XTMP("MAG30P25","MAPPING")) D  I $D(DTOUT)!$D(DUOUT) Q
 . K DIR S DIR(0)="YU"
 . S DIR("A",1)="No mapping entries found."
 . S DIR("A")="Do you want to import a mapping file",DIR("B")="NO"
 . D ^DIR
 . I Y D EN^MAGXCVL
 . Q
 D MENU
 Q
 ;
 ; List of files available in the Mapping File Edit option.
MENU ;
 K DIR S DIR(0)="SUO^1:Short Description Keyword;2:Procedure;"
 S DIR(0)=DIR(0)_"3:Parent Data File;4:Document Category;5:Object Type;"
 S DIR(0)=DIR(0)_"6:Service/Section"
 S DIR("A")="Please choose a file to edit, or <enter> to exit"
 D ^DIR
 I $D(DTOUT)!$D(DUOUT) Q
 I Y="" Q
 D LOOKUP(Y)
 G MENU
 ;
 ; Look up values in the mappable files.
LOOKUP(INPUT) N FILENUM,FLDNUM,FILELIST,DIC,Y,ITEMNUM,ITEMTXT,ANS,CT
 S FILENUM=$P("-1^-1^2005.03^2005.81^2005.02^49",U,INPUT)
 S FLDNUM=$P("10^6^16^100^3^8",U,INPUT)
 S FILELIST="Short Description^Procedure^Parent Data File^Document Category"
 S FILELIST=FILELIST_"^Object Type^Service/Section"
 S DIC("A")="Select "_$P(FILELIST,U,INPUT)_": "
 I INPUT>2 D
 . F  D  I Y=-1 Q
 . . W ! S DIC=FILENUM,DIC(0)="AENQ" D ^DIC I Y=-1 Q
 . . S ITEMNUM=$P(Y,U),ITEMTXT=$P(Y,U,2) D FILE(FLDNUM,ITEMNUM,ITEMTXT)
 . . Q
 . Q
 E  D
 . F  D PRLOOKUP(.ITEMTXT,FLDNUM) I ITEMTXT="" Q
 . Q
 Q
 ;
 ; Custom lookup for the procedures, which is a free text field.
PRLOOKUP(ITEMTXT,FLDNUM) N CT,ANS,LASTSUB
PR1 ;
 ; Can't use ^DIR here because of the way we have to process input of '?'.
 W !!,"Select ",$S(FLDNUM=10:"Short Description",1:"Procedure Name"),": " R ITEMTXT:DTIME I ITEMTXT="" Q
 S ITEMTXT=$$UCASE^MAGXCVP(ITEMTXT)
 I $E(ITEMTXT)="?" S (ANS,ITEMTXT)="" D  G PR1
 . F CT=1:1 S ITEMTXT=$O(^XTMP("MAG30P25","MAPPING",FLDNUM,ITEMTXT)) Q:ITEMTXT=""!(ANS="^")  D
 . . W !?3,ITEMTXT
 . . I CT#IOSL=0 R !?3,"'^' TO STOP: ",ANS:DTIME I ANS="^" Q
 . . Q
 . Q
 I $E(ITEMTXT)="^" S ITEMTXT="" Q
 S LASTSUB=$S(FLDNUM=10:"LASTDESC",1:"LASTPROC")
 I ITEMTXT=" " S ITEMTXT=$G(^XTMP("MAG30P25",LASTSUB)) W "  ",$S(ITEMTXT="":"??",1:ITEMTXT) I ITEMTXT="" G PR1
 S ^XTMP("MAG30P25",LASTSUB)=ITEMTXT
 I '$D(^XTMP("MAG30P25","MAPPING",FLDNUM,ITEMTXT)) D  I ANS="N" Q
 . W !!,"Do you want to add '",ITEMTXT,"' to the mapping file? N // " R ANS:DTIME
 . I "Nn"[$E(ANS) S ANS="N" W !!,"OK, entry not added."
 . Q
 D FILE(FLDNUM,ITEMTXT,ITEMTXT)
 Q
 ;
 ; Get values for an item described by ITEMNUM and ITEMTXT from file FLDNUM.
FILE(FLDNUM,ITEMIX,ITEMTXT) N MAPDATA,FLDNFO,CODES,CODE,PC,PKG,DIC,X,Y,VALUE,PKGFND,CH2
 N AUDREC ; ---- audit record for later reapplication if needed
 N NEWDATA ; --- new data to be applied to the mapping file (and audit)
 N CODES ; ----- array for sets of codes 
 N PAIR ; ------ code-value pair
 ;
 S MAPDATA=$P($G(^XTMP("MAG30P25","MAPPING",FLDNUM,ITEMIX)),U,2,7)
 ;
 ; Get a value for Package.
PKG S VALUE=$P(MAPDATA,U) I VALUE="" S VALUE="(none)"
 W !,"Package: ",VALUE," // " R PKG:DTIME S PKG=$$UCASE^MAGXCVP(PKG)
 I $E(PKG)="^" S CH2=$E(PKG,2) G PKG:CH2="P",CLS:CH2="C",TYP:CH2="T",PRC:CH2="E",SPC:CH2="S",ORG:CH2="O" I CH2="" S Y="" G END
 I PKG=" " S PKG=$G(^XTMP("MAG30P25","LASTPKG")) W "  ",$S(PKG="":"??",1:PKG) I PKG="" G PKG
 I PKG="@",VALUE="(none)" W !,"No value to delete." G PKG
 I PKG="@" S:$$DELETE^MAGXCVH $P(MAPDATA,U)="" G END:$D(DTOUT)!$D(DUOUT),PKG
 D FIELD^DID(2005,40,"","POINTER","FLDNFO") K CODES
 F PC=1:1 S CODE=$P($P(FLDNFO("POINTER"),";",PC),":") Q:CODE=""  S CODES(CODE)=""
 I $E(PKG)="?" D  W ! G PKG
 . D HELP^MAGXCVH(1) W !,"Valid packages are:"
 . S CODE="" F  S CODE=$O(CODES(CODE)) Q:CODE=""  W !,CODE
 . Q
 I PKG'="" S PKG=$$PKGPARSE(PKG)
 S ^XTMP("MAG30P25","LASTPKG")=$S(PKG="":$P(MAPDATA,U),1:PKG)
 I PKG="" G CLS
 I PKG]"",'$D(CODES(PKG)) W !,"Unknown package code. Please try again." G PKG
 I PKG]"" W "  ",PKG S $P(MAPDATA,U)=PKG
 ;
 ; Get a value for Class.
CLS S VALUE=$P($P(MAPDATA,U,2),"-",2) I VALUE="" S VALUE="(none)"
 W !,"Class: ",VALUE," // " R X:DTIME
 I $E(X)="^" S CH2=$E(X,2) G PKG:CH2="P",CLS:CH2="C",TYP:CH2="T",PRC:CH2="E",SPC:CH2="S",ORG:CH2="O",END:CH2=""
 I X="" G TYP
 I X="@",VALUE="(none)" W !,"No value to delete." G CLS
 I X="@" S:$$DELETE^MAGXCVH $P(MAPDATA,U,2)="" G END:$D(DTOUT)!$D(DUOUT),CLS
 I $E(X)="?" D HELP^MAGXCVH(2)
 S DIC=2005.82,DIC(0)="ENQ" D ^DIC I Y=-1 W ! G CLS
 I Y'=-1 S $P(MAPDATA,U,2)=$TR(Y,U,"-")
 ;
 ; Get a value for Type.
TYP S VALUE=$P($P(MAPDATA,U,3),"-",2) I VALUE="" S VALUE="(none)"
 W !,"Type: "_VALUE_" // " R X:DTIME
 I $E(X)="^" S CH2=$E(X,2) G PKG:CH2="P",CLS:CH2="C",TYP:CH2="T",PRC:CH2="E",SPC:CH2="S",ORG:CH2="O",END:CH2=""
 I X="" G PRC
 I X="@",VALUE="(none)" W !,"No value to delete." G TYP
 I X="@" S:$$DELETE^MAGXCVH $P(MAPDATA,U,3)="" G END:$D(DTOUT)!$D(DUOUT),TYP
 I $E(X)="?" D HELP^MAGXCVH(3)
 S DIC=2005.83,DIC(0)="ENQ" D ^DIC I Y=-1 W ! G TYP
 I Y'=-1 S $P(MAPDATA,U,3)=$TR(Y,U,"-")
 ;
 ; Get a value for Procedure.
PRC S VALUE=$P($P(MAPDATA,U,4),"-",2) I VALUE="" S VALUE="(none)"
 W !,"Procedure/Event: "_VALUE_" // " R X:DTIME
 I $E(X)="^" S CH2=$E(X,2) G PKG:CH2="P",CLS:CH2="C",TYP:CH2="T",PRC:CH2="E",SPC:CH2="S",ORG:CH2="O",END:CH2=""
 I X="" G SPC
 I X="@",VALUE="(none)" W !,"No value to delete." G PRC
 I X="@" S:$$DELETE^MAGXCVH $P(MAPDATA,U,4)="" G END:$D(DTOUT)!$D(DUOUT),PRC
 I $E(X)="?" D HELP^MAGXCVH(4)
 S DIC=2005.85,DIC(0)="ENQ" D ^DIC I Y=-1 W ! G PRC
 I Y'=-1 S $P(MAPDATA,U,4)=$TR(Y,U,"-")
 ;
 ; Get a value for Specialty.
SPC S VALUE=$P($P(MAPDATA,U,5),"-",2) I VALUE="" S VALUE="(none)"
 W !,"Specialty: "_VALUE_" // " R X:DTIME
 I $E(X)="^" S CH2=$E(X,2) G PKG:CH2="P",CLS:CH2="C",TYP:CH2="T",PRC:CH2="E",SPC:CH2="S",ORG:CH2="O",END:CH2=""
 I X="" G ORG
 I X="@",VALUE="(none)" W !,"No value to delete." G SPC
 I X="@" S:$$DELETE^MAGXCVH $P(MAPDATA,U,5)="" G END:$D(DTOUT)!$D(DUOUT),SPC
 I $E(X)="?" D HELP^MAGXCVH(5)
 S DIC=2005.84,DIC(0)="ENQ" D ^DIC I Y=-1 W ! G SPC
 I Y'=-1 S $P(MAPDATA,U,5)=$TR(Y,U,"-")
 ;
 ; Get a value for Origin.
ORG D FIELD^DID(2005,45,"","POINTER","FLDNFO") K CODES
 F PC=1:1:$L(FLDNFO("POINTER"),";") D
 . S PAIR=$P(FLDNFO("POINTER"),";",PC)
 . S CODE=$P(PAIR,":") I CODE]"" S CODES(CODE)=$P(PAIR,":",2)
 . Q
 S VALUE=$P(MAPDATA,U,6) I VALUE]"" S VALUE=$G(CODES(VALUE))
 W !,"Origin: "_VALUE_" // " R X:DTIME E  Q
 I $E(X)="^" S CH2=$E(X,2) G PKG:CH2="P",CLS:CH2="C",TYP:CH2="T",PRC:CH2="E",SPC:CH2="S",ORG:CH2="O",END:CH2=""
 S ORG=X I ORG="" G END
 I ORG="@",VALUE="(none)" W !,"No value to delete." G ORG
 I ORG="@" S:$$DELETE^MAGXCVH $P(MAPDATA,U,6)="" G END:$D(DTOUT)!$D(DUOUT),ORG
 I $E(ORG)="?" D  W ! G ORG
 . D HELP^MAGXCVH(1) W !,"Valid origins are as follows:"
 . S CODE="" F  S CODE=$O(CODES(CODE)) Q:CODE=""  W !,?3,CODE,?8,CODES(CODE)
 . Q
 I '$D(CODES(ORG)) D HELP^MAGXCVH(6) G ORG
 S $P(MAPDATA,U,6)=ORG
 ;
END ; File changes into mapping global, mapping global audit, and (if applicable)
 ; PARENT DATA FILE File (#2005.03) or MAG DESCRIPTIVE CATEGORIES File
 ; (#2005.81).
 S NEWDATA=ITEMTXT_U_MAPDATA
 I $G(^XTMP("MAG30P25","MAPPING",FLDNUM,ITEMIX))'=NEWDATA D
 . S ^XTMP("MAG30P25","MAPPING",FLDNUM,ITEMIX)=NEWDATA
 . S IXAUD=$O(^XTMP("MAG30P25","MAPEDITAUD"," "),-1)+1
 . S AUDREC=($$NOW^XLFDT)_U_DUZ_U_FLDNUM_U_ITEMIX_U_NEWDATA
 . S ^XTMP("MAG30P25","MAPEDITAUD",IXAUD,0)=AUDREC
 . I FLDNUM=16!(FLDNUM=100) D DIE^MAGXCVL(FLDNUM,ITEMIX,"^^"_MAPDATA)
 Q
 ;
 ; Parse Package entered and perform partial lookup.
PKGPARSE(PKG) N PKGFND,CODE,CT,SEL
 K PKGFND S PKGFND=0,PKG=$$UCASE^MAGXCVP(PKG)
 I $D(CODES(PKG)) D
 . S PKGFND=1,PKGFND(1)=PKG
 . Q
 E  S CODE=PKG F  S CODE=$O(CODES(CODE)) Q:CODE=""!($E(CODE,1,$L(PKG))'=PKG)  D
 . S PKGFND=$G(PKGFND)+1,PKGFND(PKGFND)=CODE
 . Q
 I PKGFND=0 Q ""
 I PKGFND=1 Q PKGFND(1)
 F CT=1:1:PKGFND W !?5,CT,?9,PKGFND(CT)
 W !,"Choose 1-",PKGFND,": " R SEL:DTIME I SEL="" Q ""
 I '$D(PKGFND(SEL)) W $C(7),"??" Q "?"
 Q PKGFND(SEL)
